Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E45CDD560
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 23:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr4Iu-0001uJ-S6; Wed, 18 Sep 2024 19:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1sr4Ip-0001aP-4z
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:41:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1sr4Ik-0000zE-O2
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 19:41:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71781f42f75so205094b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 16:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726702894; x=1727307694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=JpKjTAhPM8rLOC/+P2i0GYSeYkgfAzRTI5m7xiZZSAI=;
 b=OvfSmga8W/mqktFsYBCz/iGF6h+nxletPnjKcU9X2Sw/Wh7VMtxWK3ntEHNJOjuTqe
 AEtFsD4cK4feG4rkMXMe97GQpVJ4kGuMrevRP6cAe+eGGnLF30O5E1sL3r4CZL65oq67
 Y8PW3dFjIyP5T8y5bAgZqQ9RzjwnBMwhaqCFyl9n6esr4VlObGKPkBctcAr0RO5UXNZz
 +5KNd3KYe8vmH5sKZO5Uhfuei4fj00zJ1Oftvv82i9iA/9RuKMXzWErUk9qXKrzQtYNy
 YQQNG2UUlUNASQQurI5BrE9+BdN4X8r1da470dQmM71YGnJ0Mp+5hGypQ6AzfuBfI5lG
 7d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726702894; x=1727307694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JpKjTAhPM8rLOC/+P2i0GYSeYkgfAzRTI5m7xiZZSAI=;
 b=T83PonG0VOa14n1Mdo3INtgnqf/B2eg1K2jjKc0NeIELIuf1XS0ZHa4E1cLZjf+uwO
 QIUyglFGyW8/Sv1CMsptATDyW+eSAHFHKF8hUVwhUSEMlGIb+JrZpGHh2kCd90GUEi94
 Ene3W3L59qbW8q6+Ed+sPcT7dOkUJoqx14uGudI16fBC6puAelG8CU75bf5ryZ2ce0Z/
 ObThQgkoufbT3jceHtSNb+g1dCtcmtIABvn0yFKgJZXqO0/EmFlA/Ddq06pdtjANYn8k
 cFdRtYSfm+7kRi5umL549BPZTkZFvnELtEMIij67YmXDZWxJMQiMcOf8oL1xohiN7B66
 pNhQ==
X-Gm-Message-State: AOJu0YzckC6jDG4351fiVgaovJc0QHZaSQ5UNwDwFcYdozTV+hbYA3ws
 IZiKvGZgFHjhe59rgFfj+KUoK1vjwhYuuhXvCSr2Pi9XxN2g6tgnwsyxVw==
X-Google-Smtp-Source: AGHT+IHZySXinGSI+EWjiNT4An8oNGh5bX9z1oYHaD4zl46XxKj51kWPZ+HWvHFy2pzaxJyUV8PwAQ==
X-Received: by 2002:a05:6a00:a01:b0:70b:176e:b3bc with SMTP id
 d2e1a72fcca58-71926213bb8mr36480853b3a.28.1726702894139; 
 Wed, 18 Sep 2024 16:41:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944bc9ec1sm7218214b3a.212.2024.09.18.16.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 16:41:32 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] usb-hub: Add support for v2.0 hubs
Date: Wed, 18 Sep 2024 16:41:30 -0700
Message-ID: <20240918234130.3666833-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
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
 hw/usb/dev-hub.c | 85 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index 06e9537d03..0ecc6828cb 100644
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
 
@@ -431,7 +484,6 @@ static void usb_hub_handle_control(USBDevice *dev, USBPacket *p,
                     usb_hub_port_set(port, PORT_STAT_POWER);
                     timer_mod(s->port_timer, now + 5000000); /* 5 ms */
                 }
-                break;
             default:
                 goto fail;
             }
@@ -593,6 +645,19 @@ static void usb_hub_realize(USBDevice *dev, Error **errp)
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
@@ -613,7 +678,8 @@ static void usb_hub_realize(USBDevice *dev, Error **errp)
         port = &s->ports[i];
         usb_register_port(usb_bus_from_device(dev),
                           &port->port, s, i, &usb_hub_port_ops,
-                          USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL);
+                          USB_SPEED_MASK_LOW | USB_SPEED_MASK_FULL |
+                          (s->usb_version == 2) ? USB_SPEED_MASK_HIGH : 0);
         usb_port_location(&port->port, dev->port, i+1);
     }
     usb_hub_handle_reset(dev);
@@ -650,7 +716,7 @@ static const VMStateDescription vmstate_usb_hub_port_timer = {
 
 static const VMStateDescription vmstate_usb_hub = {
     .name = "usb-hub",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_USB_DEVICE(dev, USBHubState),
@@ -667,6 +733,7 @@ static const VMStateDescription vmstate_usb_hub = {
 static Property usb_hub_properties[] = {
     DEFINE_PROP_UINT32("ports", USBHubState, num_ports, 8),
     DEFINE_PROP_BOOL("port-power", USBHubState, port_power, false),
+    DEFINE_PROP_UINT32("usb_version", USBHubState, usb_version, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -677,12 +744,12 @@ static void usb_hub_class_initfn(ObjectClass *klass, void *data)
 
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


