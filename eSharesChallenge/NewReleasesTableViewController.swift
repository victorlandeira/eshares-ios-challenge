//
//  NewReleasesTableViewController.swift
//  eSharesChallenge
//
//  Created by Chang Choi on 12/21/16.
//  Copyright © 2016 solechang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewReleasesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("spotifyNotificationIdentifier")
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(NewReleasesTableViewController.getSpotifyCode), name: notificationName, object: nil)
        

        let url = "https://accounts.spotify.com/authorize/?client_id=2749e2f97b65434a86f0054d51f2303b&response_type=code&redirect_uri=eshareschallenge://returnAfterLogin&scope=user-read-private%20user-read-email&state=34fFs29kd09";
   
        if let url = URL(string: url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
    }
    
    func getSpotifyCode(notification: NSNotification) {
    let dict = notification.object as! NSDictionary

    let receivedCode = dict["code"]
        
        
        
        let params =  ["grant_type":"authorization_code",
                       "code" : receivedCode!,
                       "redirect_uri" : "eshareschallenge://returnAfterLogin",
                       "client_secret":"fc19c3d4fc814c4a9f0948087920b8b5" ,
                       "client_id": "2749e2f97b65434a86f0054d51f2303b",
                       ]
        
        
        print("13.0) ", params)
        
        Alamofire.request("https://accounts.spotify.com/api/token", method: .post, parameters:params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
//                if let data = response.result.value{
                    print("11.0) " ,response.result.value)
//                }
                break
                
            case .failure(_):
                print("11.1) " ,response.result.error)
                break
                
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}