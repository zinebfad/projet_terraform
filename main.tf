terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
 subscription_id = "9fab5c3f-c6a7-4d58-b334-40e41fc2a6e6"
  features {}

  
}
/*
resource "azurerm_resource_group" "zineb" {
  name     = "zineb-resources"
  location = "spaincentral"
}

resource "azurerm_virtual_network" "zineb" {
  name                = "zineb-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.zineb.location
  resource_group_name = azurerm_resource_group.zineb.name
}

resource "azurerm_subnet" "zineb" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.zineb.name
  virtual_network_name = azurerm_virtual_network.zineb.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "zineb" {
  name                = "zineb-nic"
  location            = azurerm_resource_group.zineb.location
  resource_group_name = azurerm_resource_group.zineb.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.zineb.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "zineb" {
  name                = "zineb-machine"
  resource_group_name = azurerm_resource_group.zineb.name
  location            = azurerm_resource_group.zineb.location
  size                = "Standard_D2s_v3"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.zineb.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/PC/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

*/


/*
	
 resource "azurerm_resource_group" "contoso_rg" {
   name     = "contoso_rg"
   location = "spaincentral"
    
   tags = {
     cost_center = "contoso research"
   } 
 }
*/


   /* 
 locals {
   prefix = "contoso"
   region = "spaincentral"
   tags = {
     cost_center = "contoso research"
   }
 }
    
 resource "azurerm_resource_group" "contoso_rg" {
   name     = "${local.prefix}_rg"
   location = local.region
   tags     = local.tags
 }
    
 resource "azurerm_resource_group" "contoso_dev_rg" {
   name     = "${local.prefix}_dev_rg"
   location = local.region
   tags     = local.tags
 }

 */



variable "prefix" {}

variable "region" {
  type        = string
  default     = "North Europe"
  description = "The Azure region to deploy resources"
  validation {
    condition     = contains(["UK South", "UK West", "North Europe", "West Europe", "East US", "West US"], var.region)
    error_message = "Invalid region"
  }
}

variable "tags" {
  type        = map(any)
  description = "A map of tags"
}


resource "azurerm_resource_group" "contoso_rg" {
  name     = "${var.prefix}_rg"
  location = var.region
  tags     = var.tags
}

resource "azurerm_resource_group" "contoso_dev_rg" {
  name     = "${var.prefix}_dev_rg"
  location = var.region
  tags     = var.tags
}
# terraform.tfvars

