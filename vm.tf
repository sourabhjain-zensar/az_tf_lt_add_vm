resource "azurerm_virtual_machine" "weblt02" {
    name = "weblt02"
    location = "West US"
    resource_group_name = "${azurerm_resource_group.lt.name}"
    network_interface_ids = ["${azurerm_network_interface.ltwebpudinter.id}"]
    vm_size = "Standard_A0"


    storage_image_reference {
        publisher = "MicrosoftWindowsServer"
        offer = "WindowsServer"
        sku = "2008-R2-SP1"
        version = "latest"
    }

    storage_os_disk {
        name = "myosdisk1"
        vhd_uri = "${azurerm_storage_account.swebacnt.primary_blob_endpoint}${azurerm_storage_container.swebcont.name}/myosdisk1.vhd"
        caching = "ReadWrite"
        create_option = "FromImage"
    }

    os_profile {
        computer_name = "weblt02"
        admin_username = "zenadmin"
        admin_password = "Redhat#12345"
    }

    os_profile_windows_config {
        enable_automatic_upgrades = false
    }

    tags {
        environment = "lt"
    }
}
