Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA45D42BAF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAuCB-0003AZ-6v; Tue, 12 Nov 2024 11:56:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuC6-00038D-Hy; Tue, 12 Nov 2024 11:56:46 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1tAuC4-0000hN-Na; Tue, 12 Nov 2024 11:56:46 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720b2d8bb8dso4306517b3a.1; 
 Tue, 12 Nov 2024 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731430602; x=1732035402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ov5WN5Qnk9W75jTisVRah+9h5c0nBp5r2UmUapO7Zv8=;
 b=bSaurqmJVi/lyf6iZMeOZfgJfh2A92qnxFClt0MspN9rFSNpVxxAXUxv3m+o2oazqF
 hUQ679P4+/vCCORC2MNbV7MNGZM9IMHS/GBUJZQQTqWKWUPRQAZ/KBv+gfT+SwUo8R/4
 RO8R+vLMZ73cJfmuJWP8N0cANImA+DrFPBpaZAtRHAheNw0GTrj0tPcLgRWWOXKXxaUV
 MeE+EZ2k7AbNk/8ruqemKEbrINV1UeA2SecbGniuRgHRn6bhQLEM5LyADQJcnXCw2TGL
 C4e4pMs+sXWydI7Ek1FF57ljz3Q+28UEXrfatLIs2QrIWw4lgeD3y5uNoR8MZBnJXKgA
 2T9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731430602; x=1732035402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ov5WN5Qnk9W75jTisVRah+9h5c0nBp5r2UmUapO7Zv8=;
 b=wL6+YfzS3Pvna85muZXQMapGqwHAgtHgdiNT1Rd2Jlrlqz7lS24Tq7/FwPO17Lkxoe
 WnotixRpDVNTegwQtRsfL8cJpbN0ZFJ10kM2uTeOjQnm5M3T894S54xAgSA08yRR6z++
 2Re/ADVjIQDxr1jaP8EtC3GHreZ4PE8/vANCdVIrP+qMEk5k8/3fAM4wHWN4jszsrfXt
 WyJDzxXXNwQO+i9GBopbBz2XjPEigu2sfyoyI530EKR4ddE3L3r5Jd74SDIFZmr/Qbkt
 c6QVRSEFrrN5suKqnbVXPlcjoAaeMUeQ7vPlCjVsXKTfDLw4slH9+4uHM2Rx4bmkgYZ4
 AizQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV990JjoQw1lehTU86MSER1BOvd223aRmKnA5eOE7IUc2m2IFRx+Si1hiDX5I1Sar3p/3Y67UIoEQ==@nongnu.org
X-Gm-Message-State: AOJu0YwOcRU8lBeyLdmVaUJUfEqMZ1uZ4jkJRujXwy7RvFR9NH/rKlrv
 IjVtrZ2Gk7S3cqFAFyyabJ+WjEDzkWJ8Anq6vbyny22pt5x831T09Nbp2w==
X-Google-Smtp-Source: AGHT+IFdLcaB45Dii+T7JjHYJOHW31bMUYL9ZdUqjGGwC8okA+nV31e7KjVPqxG58+VQnKQ70KcWmA==
X-Received: by 2002:a05:6a00:2e22:b0:71e:795f:92e4 with SMTP id
 d2e1a72fcca58-7241327d92bmr24309952b3a.2.1731430602136; 
 Tue, 12 Nov 2024 08:56:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72407a17ebcsm11382484b3a.138.2024.11.12.08.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:56:41 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 09/10] usb-hub: Add support for v2.0 hubs
Date: Tue, 12 Nov 2024 08:56:18 -0800
Message-ID: <20241112165618.217454-10-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165618.217454-1-linux@roeck-us.net>
References: <20241112165618.217454-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When adding a high speed USB device to the USB hub supported by qemu,
it is added in full speed mode. Here is an example for a storage device.

/:  Bus 001.Port 001: Dev 001, Class=root_hub, Driver=platform-uhci/2p, 12M
    |__ Port 002: Dev 002, If 0, Class=Hub, Driver=hub/8p, 12M
        |__ Port 001: Dev 003, If 0, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 002: Dev 004, If 0, Class=Human Interface Device, Driver=usbhid, 12M
        |__ Port 003: Dev 005, If 0, Class=Mass Storage, Driver=usb-storage, 12M

This also triggers messages such as

usb 1-2.3: new full-speed USB device number 5 using platform-uhci
usb 1-2.3: not running at top speed; connect to a high speed hub

when such devices are instantiated in the host (example from Linux).

Add basic support for USB v2.0 hubs to solve the problem. The usb_version
device parameter configures the USB version; version 1 is default for
compatibility reasons. Example:

-device usb-hub,bus=usb-bus.1,port=1,usb_version=2

This command line parameter can be used to attach devices to the hub in
high speed mode, as seen in the following example.

/:  Bus 002.Port 001: Dev 001, Class=root_hub, Driver=ehci-platform/6p, 480M
    |__ Port 001: Dev 002, If 0, Class=Hub, Driver=hub/8p, 480M
        |__ Port 002: Dev 004, If 0, Class=Mass Storage, Driver=usb-storage, 480M

and

usb 2-1.2: new high-speed USB device number 4 using ehci-platform
usb 2-1.2: New USB device found, idVendor=46f4, idProduct=0001, bcdDevice= 0.00

To distinguish v1 from v2 instantiated hubs, the device version is set to
2.01 (from 1.01) if the hub ist instantiated as USB v2 hub. The product
name is set to "QEMU USB v2.0 Hub".

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since RFC:
- New patch

 hw/usb/dev-hub.c | 84 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 8 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 06e9537d03..4da91d151c 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -46,6 +46,7 @@ struct USBHubState {
     USBDevice dev;
     USBEndpoint *intr;
     uint32_t num_ports;
+    uint32_t usb_version;
     bool port_power;
     QEMUTimer *port_timer;
     USBHubPort ports[MAX_PORTS];
@@ -100,12 +101,14 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBHubState, USB_HUB)
 enum {
     STR_MANUFACTURER = 1,
     STR_PRODUCT,
+    STR_PRODUCT_V2,
     STR_SERIALNUMBER,
 };
 
 static const USBDescStrings desc_strings = {
     [STR_MANUFACTURER] = "QEMU",
     [STR_PRODUCT]      = "QEMU USB Hub",
+    [STR_PRODUCT_V2]   = "QEMU USB v2.0 Hub",
     [STR_SERIALNUMBER] = "314159",
 };
 
@@ -123,6 +126,20 @@ static const USBDescIface desc_iface_hub = {
     }
 };
 
+static const USBDescIface desc_iface_hub_v2 = {
+    .bInterfaceNumber              = 0,
+    .bNumEndpoints                 = 1,
+    .bInterfaceClass               = USB_CLASS_HUB,
+    .eps = (USBDescEndpoint[]) {
+        {
+            .bEndpointAddress      = USB_DIR_IN | 0x01,
+            .bmAttributes          = USB_ENDPOINT_XFER_INT,
+            .wMaxPacketSize        = 512,
+            .bInterval             = 10,
+        },
+    }
+};
+
 static const USBDescDevice desc_device_hub = {
     .bcdUSB                        = 0x0110,
     .bDeviceClass                  = USB_CLASS_HUB,
@@ -140,6 +157,23 @@ static const USBDescDevice desc_device_hub = {
     },
 };
 
+static const USBDescDevice desc_device_hub_v2 = {
+    .bcdUSB                        = 0x0200,
+    .bDeviceClass                  = USB_CLASS_HUB,
+    .bMaxPacketSize0               = 64,
+    .bNumConfigurations            = 1,
+    .confs = (USBDescConfig[]) {
+        {
+            .bNumInterfaces        = 1,
+            .bConfigurationValue   = 1,
+            .bmAttributes          = USB_CFG_ATT_ONE | USB_CFG_ATT_SELFPOWER |
+                                     USB_CFG_ATT_WAKEUP,
+            .nif = 1,
+            .ifs = &desc_iface_hub_v2,
+        },
+    },
+};
+
 static const USBDesc desc_hub = {
     .id = {
         .idVendor          = 0x0409,
@@ -153,6 +187,20 @@ static const USBDesc desc_hub = {
     .str  = desc_strings,
 };
 
+static const USBDesc desc_hub_v2 = {
+    .id = {
+        .idVendor          = 0x0409,
+        .idProduct         = 0x55aa,
+        .bcdDevice         = 0x0201,
+        .iManufacturer     = STR_MANUFACTURER,
+        .iProduct          = STR_PRODUCT_V2,
+        .iSerialNumber     = STR_SERIALNUMBER,
+    },
+    .full = &desc_device_hub,
+    .high = &desc_device_hub_v2,
+    .str  = desc_strings,
+};
+
 static const uint8_t qemu_hub_hub_descriptor[] =
 {
         0x00,                   /*  u8  bLength; patched in later */
@@ -195,15 +243,20 @@ static bool usb_hub_port_clear(USBHubPort *port, uint16_t status)
     return usb_hub_port_change(port, status);
 }
 
-static bool usb_hub_port_update(USBHubPort *port)
+static bool usb_hub_port_update(USBHubState *s, USBHubPort *port)
 {
     bool notify = false;
 
     if (port->port.dev && port->port.dev->attached) {
         notify = usb_hub_port_set(port, PORT_STAT_CONNECTION);
-        if (port->port.dev->speed == USB_SPEED_LOW) {
+        if (s->usb_version == 2 && port->port.dev->speed == USB_SPEED_HIGH) {
+            usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
+            usb_hub_port_set(port, PORT_STAT_HIGH_SPEED);
+        } else if (port->port.dev->speed == USB_SPEED_LOW) {
+            usb_hub_port_clear(port, PORT_STAT_HIGH_SPEED);
             usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
         } else {
+            usb_hub_port_clear(port, PORT_STAT_HIGH_SPEED);
             usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
         }
     }
@@ -217,7 +270,7 @@ static void usb_hub_port_update_timer(void *opaque)
     int i;
 
     for (i = 0; i < s->num_ports; i++) {
-        notify |= usb_hub_port_update(&s->ports[i]);
+        notify |= usb_hub_port_update(s, &s->ports[i]);
     }
     if (notify) {
         usb_wakeup(s->intr, 0);
@@ -230,7 +283,7 @@ static void usb_hub_attach(USBPort *port1)
     USBHubPort *port = &s->ports[port1->index];
 
     trace_usb_hub_attach(s->dev.addr, port1->index + 1);
-    usb_hub_port_update(port);
+    usb_hub_port_update(s, port);
     usb_wakeup(s->intr, 0);
 }
 
@@ -318,7 +371,7 @@ static void usb_hub_handle_reset(USBDevice *dev)
         port->wPortStatus = 0;
         port->wPortChange = 0;
         usb_hub_port_set(port, PORT_STAT_POWER);
-        usb_hub_port_update(port);
+        usb_hub_port_update(s, port);
     }
 }
 
@@ -593,6 +646,19 @@ static void usb_hub_realize(USBDevice *dev, Error **errp)
     USBHubPort *port;
     int i;
 
+    switch (s->usb_version) {
+    case 1:
+        dev->usb_desc = &desc_hub;
+        break;
+    case 2:
+        dev->usb_desc = &desc_hub_v2;
+        break;
+    default:
+        error_setg(errp, "Unsupported usb version %d for usb hub",
+                   s->usb_version);
+        return;
+    }
+
     if (s->num_ports < 1 || s->num_ports > MAX_PORTS) {
         error_setg(errp, "num_ports (%d) out of range (1..%d)",
                    s->num_ports, MAX_PORTS);
@@ -613,7 +679,8 @@ static void usb_hub_realize(USBDevice *dev, Error **errp)
         port = &s->ports[i];
         usb_register_port(usb_bus_from_device(dev),
                           &port->port, s, i, &usb_hub_port_ops,
-                          USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
+                          USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |
+                          ((s->usb_version == 2) ? USB_SPEED_MASK_HIGH : 0));
         usb_port_location(&port->port, dev->port, i+1);
     }
     usb_hub_handle_reset(dev);
@@ -650,7 +717,7 @@ static const VMStateDescription vmstate_usb_hub_port_timer = {
 
 static const VMStateDescription vmstate_usb_hub = {
     .name = "usb-hub",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, USBHubState),
@@ -667,6 +734,7 @@ static const VMStateDescription vmstate_usb_hub = {
 static Property usb_hub_properties[] = {
     DEFINE_PROP_UINT32("ports", USBHubState, num_ports, 8),
     DEFINE_PROP_BOOL("port-power", USBHubState, port_power, false),
+    DEFINE_PROP_UINT32("usb_version", USBHubState, usb_version, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -677,12 +745,12 @@ static void usb_hub_class_initfn(ObjectClass *klass, void *data)
 
     uc->realize        = usb_hub_realize;
     uc->product_desc   = "QEMU USB Hub";
-    uc->usb_desc       = &desc_hub;
     uc->find_device    = usb_hub_find_device;
     uc->handle_reset   = usb_hub_handle_reset;
     uc->handle_control = usb_hub_handle_control;
     uc->handle_data    = usb_hub_handle_data;
     uc->unrealize      = usb_hub_unrealize;
+    uc->handle_attach  = usb_desc_attach;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "hub";
     dc->vmsd = &vmstate_usb_hub;
-- 
2.45.2


