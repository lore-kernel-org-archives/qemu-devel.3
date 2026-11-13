Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E61606B336
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KR80QZyt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRwFl-0007iQ-BD; Fri, 13 Nov 2026 13:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF4-0007CN-DF
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRwF1-0005OK-Tv
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794595394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mt2C5S/xaWfcGwv43IGGx1+gILajUMV1IGE7kkf4pA0=;
 b=KR80QZytuLx0h98KT3IZv1RKC7hCPUiBOb0tkPdFCFugOSaZx0NNsU8KX8Axtb0kER4G8W
 RAzuOKTKtbUkLzODfLuU2pm6qwhkOEMAB3hic/OpbjQbnU6LULDWmoTwx3CJfWjMmiTDWQ
 2reFJsGbEd7FW7zTBQstsYubc+pQJgc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-P_DWhwUtO1uK9eViKQFXqQ-1; Fri,
 13 Nov 2026 13:43:12 -0500
X-MC-Unique: P_DWhwUtO1uK9eViKQFXqQ-1
X-Mimecast-MFC-AGG-ID: P_DWhwUtO1uK9eViKQFXqQ_1794595392
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C0B9180044D
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 18:43:12 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3F6F1955DB9; Fri, 13 Nov 2026 18:43:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 08/26] hw/usb: mark commonly used USB devices/hosts as
 secure
Date: Fri, 13 Nov 2026 18:42:36 +0000
Message-ID: <20261113184254.2524253-9-berrange@redhat.com>
In-Reply-To: <20261113184254.2524253-1-berrange@redhat.com>
References: <20261113184254.2524253-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Modern virtualized guests are expected to be deployed with the
XHCI controller which supports all of USB 1, 2 and 3, so should
be declared secure.

The "NEC" XHCI variant is slightly non-standard, but since it is
a trivial sub-class of the generic XHCI, there's no reason to
exclude it.

The set of devices that are expected to be used is HID (mouse,
tablet, keyboard), host passthrough, CCID (smartcard), hub,
storage and the redirect tunnelling.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/usb/ccid-card-emulated.c   | 1 +
 hw/usb/ccid-card-passthru.c   | 1 +
 hw/usb/dev-hid.c              | 3 +++
 hw/usb/dev-hub.c              | 1 +
 hw/usb/dev-smartcard-reader.c | 2 ++
 hw/usb/dev-storage-bot.c      | 1 +
 hw/usb/dev-storage-classic.c  | 1 +
 hw/usb/hcd-xhci-nec.c         | 1 +
 hw/usb/hcd-xhci-pci.c         | 1 +
 hw/usb/hcd-xhci-sysbus.c      | 3 ++-
 hw/usb/hcd-xhci.c             | 1 +
 hw/usb/host-libusb.c          | 1 +
 hw/usb/redirect.c             | 1 +
 13 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 6c8eec39faa..4083cf8f4be 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -612,6 +612,7 @@ static const TypeInfo emulated_card_info = {
     .parent        = TYPE_CCID_CARD,
     .instance_size = sizeof(EmulatedState),
     .class_init    = emulated_class_initfn,
+    .secure        = true,
 };
 module_obj(TYPE_EMULATED_CCID);
 module_kconfig(USB);
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 3f4052ec82e..b951a544ef7 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -413,6 +413,7 @@ static const TypeInfo passthru_card_info = {
     .parent        = TYPE_CCID_CARD,
     .instance_size = sizeof(PassthruState),
     .class_init    = passthru_class_initfn,
+    .secure        = true,
 };
 module_obj(TYPE_CCID_PASSTHRU);
 module_kconfig(USB);
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index ae19d60203f..f363449f53e 100644
--- a/hw/usb/dev-hid.c
+++ b/hw/usb/dev-hid.c
@@ -815,6 +815,7 @@ static const TypeInfo usb_tablet_info = {
     .name          = "usb-tablet",
     .parent        = TYPE_USB_HID,
     .class_init    = usb_tablet_class_initfn,
+    .secure        = true,
 };
 
 static const Property usb_mouse_properties[] = {
@@ -837,6 +838,7 @@ static const TypeInfo usb_mouse_info = {
     .name          = "usb-mouse",
     .parent        = TYPE_USB_HID,
     .class_init    = usb_mouse_class_initfn,
+    .secure        = true,
 };
 
 static const Property usb_keyboard_properties[] = {
@@ -860,6 +862,7 @@ static const TypeInfo usb_keyboard_info = {
     .name          = "usb-kbd",
     .parent        = TYPE_USB_HID,
     .class_init    = usb_keyboard_class_initfn,
+    .secure        = true,
 };
 
 static void usb_hid_register_types(void)
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index b45d571fa83..7017b4fbc75 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -694,6 +694,7 @@ static const TypeInfo hub_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBHubState),
     .class_init    = usb_hub_class_initfn,
+    .secure        = true,
 };
 
 static void usb_hub_register_types(void)
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 752571043ee..d6d684c27c4 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1405,6 +1405,7 @@ static const TypeInfo ccid_bus_info = {
     .name = TYPE_CCID_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(CCIDBus),
+    .secure = true,
 };
 
 void ccid_card_send_apdu_to_guest(CCIDCardState *card,
@@ -1779,6 +1780,7 @@ static const TypeInfo ccid_info = {
     .parent        = TYPE_USB_DEVICE,
     .instance_size = sizeof(USBCCIDState),
     .class_init    = ccid_class_initfn,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
diff --git a/hw/usb/dev-storage-bot.c b/hw/usb/dev-storage-bot.c
index a7f8d80c17a..b156f1c5c9a 100644
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
index 353f81dcc05..a244b5c8071 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -134,6 +134,7 @@ static const TypeInfo msd_info = {
     .parent        = TYPE_USB_STORAGE,
     .class_init    = usb_msd_class_storage_initfn,
     .instance_init = usb_msd_instance_init,
+    .secure        = true,
 };
 
 static void register_types(void)
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 46839911f3f..070732be9a6 100644
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
index b124251ae33..a3615b29fbd 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -298,6 +298,7 @@ static const TypeInfo qemu_xhci_info = {
     .parent        = TYPE_XHCI_PCI,
     .class_init    = qemu_xhci_class_init,
     .instance_init = qemu_xhci_instance_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index bbdd5fd64ab..8dd50fbbf13 100644
--- a/hw/usb/hcd-xhci-sysbus.c
+++ b/hw/usb/hcd-xhci-sysbus.c
@@ -112,7 +112,8 @@ static const TypeInfo xhci_sysbus_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(XHCISysbusState),
     .class_init    = xhci_sysbus_class_init,
-    .instance_init = xhci_sysbus_instance_init
+    .instance_init = xhci_sysbus_instance_init,
+    .secure        = true,
 };
 
 static void xhci_sysbus_register_types(void)
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index b5cc1ad2ff5..aac7f6788e0 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3718,6 +3718,7 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 5a369e2ebf5..9c4980995a4 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1839,6 +1839,7 @@ static const TypeInfo usb_host_dev_info = {
     .instance_size = sizeof(USBHostDevice),
     .class_init    = usb_host_class_initfn,
     .instance_init = usb_host_instance_init,
+    .secure        = true,
 };
 module_obj(TYPE_USB_HOST_DEVICE);
 module_kconfig(USB);
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index a666b1e8d7d..401c6f5767b 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2655,6 +2655,7 @@ static const TypeInfo usbredir_dev_info = {
     .instance_size = sizeof(USBRedirDevice),
     .class_init    = usbredir_class_initfn,
     .instance_init = usbredir_instance_init,
+    .secure        = true,
 };
 module_obj(TYPE_USB_REDIR);
 module_kconfig(USB);
-- 
2.56.1


