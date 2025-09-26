Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE9ECAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v293p-0007Bp-84; Fri, 26 Sep 2025 10:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293k-0006y4-Tn
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v293e-0004v1-1X
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHYuilp4oPhNWzNcKosL8QrjGiebh/fmn4/Oiz8qpng=;
 b=Vi+aZoPoEvE/8hQ3wgSetMcwfveTOj+vhQjZM0QOJ9vSABUuvphdSELfLB0pE46DM6HfxJ
 krs0pf/Ge7T13ZM6/wB80dPhPBIjvMYkK4NdFLia++gPpCgy78yz5oyYR76MA1i/5rwI0F
 iKtF+h8jynGcOn1KA2yzVFj/h0AaT/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-6pXjO7_1NV6Ogmln5OqqIg-1; Fri,
 26 Sep 2025 10:04:09 -0400
X-MC-Unique: 6pXjO7_1NV6Ogmln5OqqIg-1
X-Mimecast-MFC-AGG-ID: 6pXjO7_1NV6Ogmln5OqqIg_1758895448
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E4EC1956056; Fri, 26 Sep 2025 14:04:08 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCEE31956095; Fri, 26 Sep 2025 14:04:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 25/32] hw/usb: mark most USB devices/hosts as secure
Date: Fri, 26 Sep 2025 15:01:36 +0100
Message-ID: <20250926140144.1998694-26-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Most of the USB devices / host controllers are relevant for
virtualization use cases, so should be declared secure. The
exceptions are

 * dwc2/dwc3 - emulating Raspberry Pi hardware.
 * mtp - a complex file sharing device, unclear if
   it has been used/proven sufficiently to consider
   it secure
 * braille - a variant of USB serial, using the
   chardev baum backend, unclear that is written
   with a hostile guest in mind

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/usb/dev-audio.c            | 1 +
 hw/usb/dev-hid.c              | 4 ++++
 hw/usb/dev-hub.c              | 1 +
 hw/usb/dev-mtp.c              | 1 +
 hw/usb/dev-network.c          | 1 +
 hw/usb/dev-serial.c           | 3 +++
 hw/usb/dev-smartcard-reader.c | 3 +++
 hw/usb/dev-storage-bot.c      | 1 +
 hw/usb/dev-storage-classic.c  | 1 +
 hw/usb/dev-storage.c          | 1 +
 hw/usb/dev-uas.c              | 1 +
 hw/usb/dev-wacom.c            | 1 +
 hw/usb/hcd-dwc2.c             | 1 +
 hw/usb/hcd-dwc3.c             | 1 +
 hw/usb/hcd-ehci-pci.c         | 2 ++
 hw/usb/hcd-ehci-sysbus.c      | 8 ++++++++
 hw/usb/hcd-ohci-pci.c         | 1 +
 hw/usb/hcd-ohci-sysbus.c      | 1 +
 hw/usb/hcd-uhci.c             | 2 ++
 hw/usb/hcd-xhci-nec.c         | 1 +
 hw/usb/hcd-xhci-pci.c         | 2 ++
 hw/usb/hcd-xhci-sysbus.c      | 3 ++-
 hw/usb/hcd-xhci.c             | 1 +
 hw/usb/host-libusb.c          | 1 +
 hw/usb/redirect.c             | 1 +
 25 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-audio.c b/hw/usb/dev-audio.c
index 26af709f31..8be35a1cdf 100644
--- a/hw/usb/dev-audio.c
+++ b/hw/usb/dev-audio.c
@@ -1019,6 +1019,7 @@ static const TypeInfo usb_audio_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBAudioState),
     .class_init    = usb_audio_class_init,
+    .secure        = true,
 };
 
 static void usb_audio_register_types(void)
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index 96623aa322..79a3c0387f 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -790,6 +790,7 @@ static const TypeInfo usb_hid_type_info = {
     .parent = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBHIDState),
     .abstract = true,
+    .secure = true,
     .class_init = usb_hid_class_initfn,
 };
 
@@ -815,6 +816,7 @@ static const TypeInfo usb_tablet_info = {
     .name          = "usb-tablet",
     .parent        = TYPE_USB_HID,
     .class_init    = usb_tablet_class_initfn,
+    .secure        = true,
 };
 
 static const Property usb_mouse_properties[] = {
@@ -837,6 +839,7 @@ static const TypeInfo usb_mouse_info = {
     .name          = "usb-mouse",
     .parent        = TYPE_USB_HID,
     .class_init    = usb_mouse_class_initfn,
+    .secure        = true,
 };
 
 static const Property usb_keyboard_properties[] = {
@@ -860,6 +863,7 @@ static const TypeInfo usb_keyboard_info = {
     .name          = "usb-kbd",
     .parent        = TYPE_USB_HID,
     .class_init    = usb_keyboard_class_initfn,
+    .secure        = true,
 };
 
 static void usb_hid_register_types(void)
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index a19350d9c4..66d6b76973 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -694,6 +694,7 @@ static const TypeInfo hub_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBHubState),
     .class_init    = usb_hub_class_initfn,
+    .secure        = true,
 };
 
 static void usb_hub_register_types(void)
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index ce45c9cd06..11b0f284c7 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -2107,6 +2107,7 @@ static const TypeInfo mtp_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(MTPState),
     .class_init    = usb_mtp_class_initfn,
+    .secure        = false,
 };
 
 static void usb_mtp_register_types(void)
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 1df2454181..cb539d8dd3 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1435,6 +1435,7 @@ static const TypeInfo net_info = {
     .instance_size = sizeof(USBNetState),
     .class_init    = usb_net_class_initfn,
     .instance_init = usb_net_instance_init,
+    .secure        = true,
 };
 
 static void usb_net_register_types(void)
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 1c116d8b0f..51d11ba4d0 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -655,6 +655,7 @@ static const TypeInfo usb_serial_dev_type_info = {
     .parent = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBSerialState),
     .abstract = true,
+    .secure = true,
     .class_init = usb_serial_dev_class_init,
 };
 
@@ -672,6 +673,7 @@ static const TypeInfo serial_info = {
     .name          = "usb-serial",
     .parent        = TYPE_USB_SERIAL,
     .class_init    = usb_serial_class_initfn,
+    .secure        = true,
 };
 
 static const Property braille_properties[] = {
@@ -692,6 +694,7 @@ static const TypeInfo braille_info = {
     .name          = "usb-braille",
     .parent        = TYPE_USB_SERIAL,
     .class_init    = usb_braille_class_initfn,
+    .secure        = false,
 };
 
 static void usb_serial_register_types(void)
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 6ce7154fee..ebde3365f8 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1178,6 +1178,7 @@ static const TypeInfo ccid_bus_info = {
     .name = TYPE_CCID_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(CCIDBus),
+    .secure = true,
 };
 
 void ccid_card_send_apdu_to_guest(CCIDCardState *card,
@@ -1458,6 +1459,7 @@ static const TypeInfo ccid_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBCCIDState),
     .class_init    = ccid_class_initfn,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
@@ -1478,6 +1480,7 @@ static const TypeInfo ccid_card_type_info = {
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(CCIDCardState),
     .abstract = true,
+    .secure = true,
     .class_size = sizeof(CCIDCardClass),
     .class_init = ccid_card_class_init,
 };
diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index df6ab7f656..d9b0277856 100644
--- a/hw/usb/dev-storage-bot.c
+++ b/hw/usb/dev-storage-bot.c
@@ -52,6 +52,7 @@ static const TypeInfo bot_info = {
     .name          = "usb-bot",
     .parent        = TYPE_USB_STORAGE,
     .class_init    = usb_msd_class_bot_initfn,
+    .secure        = true,
 };
 
 static void register_types(void)
diff --git a/hw/usb/dev-storage-classic.c b/hw/usb/dev-storage-classic.c
index dabe156359..e3e7d79ecf 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -133,6 +133,7 @@ static const TypeInfo msd_info = {
     .parent        = TYPE_USB_STORAGE,
     .class_init    = usb_msd_class_storage_initfn,
     .instance_init = usb_msd_instance_init,
+    .secure        = true,
 };
 
 static void register_types(void)
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index b13fe345c4..374312e57a 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -607,6 +607,7 @@ static const TypeInfo usb_storage_dev_type_info = {
     .parent = TYPE_USB_DEVICE,
     .instance_size = sizeof(MSDState),
     .abstract = true,
+    .secure = true,
     .class_init = usb_msd_class_initfn_common,
 };
 
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 21cc2835c6..6fde2bdf71 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -982,6 +982,7 @@ static const TypeInfo uas_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(UASDevice),
     .class_init    = usb_uas_class_initfn,
+    .secure        = true,
 };
 
 static void usb_uas_register_types(void)
diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
index f4b71a2147..6c2a37a53e 100644
--- a/hw/usb/dev-wacom.c
+++ b/hw/usb/dev-wacom.c
@@ -442,6 +442,7 @@ static const TypeInfo wacom_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBWacomState),
     .class_init    = usb_wacom_class_init,
+    .secure        = true,
 };
 
 static void usb_wacom_register_types(void)
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
index 83864505bb..10a996cc4a 100644
--- a/hw/usb/hcd-dwc2.c
+++ b/hw/usb/hcd-dwc2.c
@@ -1473,6 +1473,7 @@ static const TypeInfo dwc2_usb_type_info = {
     .instance_init = dwc2_init,
     .class_size    = sizeof(DWC2Class),
     .class_init    = dwc2_class_init,
+    .secure        = false,
 };
 
 static void dwc2_usb_register_types(void)
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 98a342b8b8..54fa3a7922 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -682,6 +682,7 @@ static const TypeInfo usb_dwc3_info = {
     .instance_size = sizeof(USBDWC3),
     .class_init    = usb_dwc3_class_init,
     .instance_init = usb_dwc3_init,
+    .secure        = false,
 };
 
 static void usb_dwc3_register_types(void)
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 38ad3406b3..d80792422d 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -171,6 +171,7 @@ static const TypeInfo ehci_pci_type_info = {
     .instance_init = usb_ehci_pci_init,
     .instance_finalize = usb_ehci_pci_finalize,
     .abstract = true,
+    .secure = true,
     .class_init = ehci_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -219,6 +220,7 @@ static void ehci_pci_register_types(void)
     TypeInfo ehci_type_info = {
         .parent        = TYPE_PCI_EHCI,
         .class_init    = ehci_data_class_init,
+        .secure        = true,
     };
     int i;
 
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 0449f5fa6d..24b8a72af3 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -240,6 +240,7 @@ static const TypeInfo ehci_sysbus_types[] = {
         .instance_init = ehci_sysbus_init,
         .instance_finalize = ehci_sysbus_finalize,
         .abstract      = true,
+        .secure        = true,
         .class_init    = ehci_sysbus_class_init,
         .class_size    = sizeof(SysBusEHCIClass),
     },
@@ -247,32 +248,38 @@ static const TypeInfo ehci_sysbus_types[] = {
         .name          = TYPE_PLATFORM_EHCI,
         .parent        = TYPE_SYS_BUS_EHCI,
         .class_init    = ehci_platform_class_init,
+        .secure        = true,
     },
     {
         .name          = TYPE_EXYNOS4210_EHCI,
         .parent        = TYPE_SYS_BUS_EHCI,
         .class_init    = ehci_exynos4210_class_init,
+        .secure        = true,
     },
     {
         .name          = TYPE_AW_H3_EHCI,
         .parent        = TYPE_SYS_BUS_EHCI,
         .class_init    = ehci_aw_h3_class_init,
+        .secure        = true,
     },
     {
         .name          = TYPE_NPCM7XX_EHCI,
         .parent        = TYPE_SYS_BUS_EHCI,
         .class_init    = ehci_npcm7xx_class_init,
+        .secure        = true,
     },
     {
         .name          = TYPE_TEGRA2_EHCI,
         .parent        = TYPE_SYS_BUS_EHCI,
         .class_init    = ehci_tegra2_class_init,
+        .secure        = true,
     },
     {
         .name          = TYPE_PPC4xx_EHCI,
         .parent        = TYPE_SYS_BUS_EHCI,
         .class_init    = ehci_ppc4xx_class_init,
         .instance_init = ehci_ppc4xx_init,
+        .secure        = true,
     },
     {
         .name          = TYPE_FUSBH200_EHCI,
@@ -280,6 +287,7 @@ static const TypeInfo ehci_sysbus_types[] = {
         .instance_size = sizeof(FUSBH200EHCIState),
         .instance_init = fusbh200_ehci_init,
         .class_init    = fusbh200_ehci_class_init,
+        .secure        = true,
     },
 };
 
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 94d1077eb9..9adfe564db 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -149,6 +149,7 @@ static const TypeInfo ohci_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(OHCIPCIState),
     .class_init    = ohci_pci_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 3fc6cce44b..b57bbd4173 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -81,6 +81,7 @@ static const TypeInfo ohci_sysbus_types[] = {
         .parent        = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(OHCISysBusState),
         .class_init    = ohci_sysbus_class_init,
+        .secure        = true,
     },
 };
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index 4822c704f6..f3ab8dd978 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1277,6 +1277,7 @@ static const TypeInfo uhci_pci_type_info = {
     .instance_size = sizeof(UHCIState),
     .class_size    = sizeof(UHCIPCIDeviceClass),
     .abstract = true,
+    .secure = true,
     .class_init = uhci_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -1374,6 +1375,7 @@ static void uhci_register_types(void)
     TypeInfo uhci_type_info = {
         .parent        = TYPE_UHCI,
         .class_init    = uhci_data_class_init,
+        .secure        = true,
     };
     int i;
 
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 9e0fea26f4..74815af265 100644
--- a/hw/usb/hcd-xhci-nec.c
+++ b/hw/usb/hcd-xhci-nec.c
@@ -67,6 +67,7 @@ static const TypeInfo nec_xhci_info = {
     .instance_size = sizeof(XHCINecState),
     .instance_init = nec_xhci_instance_init,
     .class_init    = nec_xhci_class_init,
+    .secure        = true,
 };
 
 static void nec_xhci_register_types(void)
diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index b93c80b09d..fedc5b7cc2 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -248,6 +248,7 @@ static const TypeInfo xhci_pci_info = {
     .class_init    = xhci_class_init,
     .instance_init = xhci_instance_init,
     .abstract      = true,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -280,6 +281,7 @@ static const TypeInfo qemu_xhci_info = {
     .parent        = TYPE_XHCI_PCI,
     .class_init    = qemu_xhci_class_init,
     .instance_init = qemu_xhci_instance_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index 244698e5f2..f801290284 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -111,7 +111,8 @@ static const TypeInfo xhci_sysbus_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XHCISysbusState),
     .class_init    = xhci_sysbus_class_init,
-    .instance_init = xhci_sysbus_instance_init
+    .instance_init = xhci_sysbus_instance_init,
+    .secure        = true,
 };
 
 static void xhci_sysbus_register_types(void)
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 292c378bfc..2218899d5c 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3655,6 +3655,7 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index b74670ae25..d42f9cdd70 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1807,6 +1807,7 @@ static const TypeInfo usb_host_dev_info = {
     .instance_size = sizeof(USBHostDevice),
     .class_init    = usb_host_class_initfn,
     .instance_init = usb_host_instance_init,
+    .secure        = true,
 };
 module_obj(TYPE_USB_HOST_DEVICE);
 module_kconfig(USB);
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index f516ff42a1..038507ce0b 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2619,6 +2619,7 @@ static const TypeInfo usbredir_dev_info = {
     .instance_size = sizeof(USBRedirDevice),
     .class_init    = usbredir_class_initfn,
     .instance_init = usbredir_instance_init,
+    .secure        = true,
 };
 module_obj(TYPE_USB_REDIR);
 module_kconfig(USB);
-- 
2.50.1


