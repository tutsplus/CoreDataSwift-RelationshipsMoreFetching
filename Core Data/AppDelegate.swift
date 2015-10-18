//
//  AppDelegate.swift
//  Core Data
//
//  Created by Bart Jacobs on 17/10/15.
//  Copyright © 2015 Envato Tuts+. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /*
        // Create Person
        let entityPerson = NSEntityDescription.entityForName("Person", inManagedObjectContext: self.managedObjectContext)
        let newPerson = NSManagedObject(entity: entityPerson!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Populate Person
        newPerson.setValue("Bart", forKey: "first")
        newPerson.setValue("Jacobs", forKey: "last")
        newPerson.setValue(44, forKey: "age")
        
        // Create Address
        let entityAddress = NSEntityDescription.entityForName("Address", inManagedObjectContext: self.managedObjectContext)
        let newAddress = NSManagedObject(entity: entityAddress!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Populate Address
        newAddress.setValue("Main Street", forKey: "street")
        newAddress.setValue("Boston", forKey: "city")
        
        // Add Address to Person
        newPerson.setValue(NSSet(object: newAddress), forKey: "addresses")
        
        do {
            try newPerson.managedObjectContext?.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
        // Create Address
        let otherAddress = NSManagedObject(entity: entityAddress!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set First and Last Name
        otherAddress.setValue("5th Avenue", forKey:"street")
        otherAddress.setValue("New York", forKey:"city")
        
        // Add Address to Person
        let addresses = newPerson.mutableSetValueForKey("addresses")
        addresses.addObject(otherAddress)
        
        // Delete Relationship
        newPerson.setValue(nil, forKey:"addresses")
        
        // Create Another Person
        let anotherPerson = NSManagedObject(entity: entityPerson!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set First and Last Name
        anotherPerson.setValue("Jane", forKey: "first")
        anotherPerson.setValue("Doe", forKey: "last")
        anotherPerson.setValue(42, forKey: "age")
        
        // Create Relationship
        newPerson.setValue(anotherPerson, forKey: "spouse")
        
        // Create a Child Person
        let newChildPerson = NSManagedObject(entity: entityPerson!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set First and Last Name
        newChildPerson.setValue("Jim", forKey: "first")
        newChildPerson.setValue("Doe", forKey: "last")
        newChildPerson.setValue(21, forKey: "age")
        
        // Create Relationship
        let children = newPerson.mutableSetValueForKey("children")
        children.addObject(newChildPerson)
        
        // Create Another Child Person
        let anotherChildPerson = NSManagedObject(entity: entityPerson!, insertIntoManagedObjectContext: self.managedObjectContext)
        
        // Set First and Last Name
        anotherChildPerson.setValue("Lucy", forKey: "first")
        anotherChildPerson.setValue("Doe", forKey: "last")
        anotherChildPerson.setValue(19, forKey: "age")
        
        // Create Relationship
        anotherChildPerson.setValue(newPerson, forKey: "father")

        do {
            try self.managedObjectContext.save()
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        */
        
        /*
        // Create Fetch Request
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        // Add Sort Descriptor
        let sortDescriptor1 = NSSortDescriptor(key: "last", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        // Execute Fetch Request
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                if let first = managedObject.valueForKey("first"), last = managedObject.valueForKey("last"), age = managedObject.valueForKey("age") {
                    print("\(first) \(last) (\(age))")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        */
        
        // Fetching
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        // Create Predicate
        // let predicate = NSPredicate(format: "%K == %@", "last", "Doe")
        // let predicate = NSPredicate(format: "%K >= %i", "age", 30)
        // let predicate = NSPredicate(format: "%K CONTAINS[c] %@", "first", "j")
        // let predicate = NSPredicate(format: "%K CONTAINS[c] %@ AND %K < %i", "first", "j", "age", 30)
        let predicate = NSPredicate(format: "%K == %@", "father.first", "Bart")
        fetchRequest.predicate = predicate
        
        // Add Sort Descriptor
        let sortDescriptor1 = NSSortDescriptor(key: "last", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        
        // Execute Fetch Request
        do {
            let result = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            
            for managedObject in result {
                if let first = managedObject.valueForKey("first"), last = managedObject.valueForKey("last"), age = managedObject.valueForKey("age") {
                    print("\(first) \(last) (\(age))")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {}

    func applicationDidEnterBackground(application: UIApplication) {}

    func applicationWillEnterForeground(application: UIApplication) {}

    func applicationDidBecomeActive(application: UIApplication) {}

    func applicationWillTerminate(application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.tutsplus.Core_Data" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("Core_Data", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

}

