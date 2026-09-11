Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D20C88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Sd-0006xk-6J; Fri, 11 Sep 2026 10:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NH-0002aE-VJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NA-0007yJ-5D
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RHIZmJ27HpBLHk1UKD1lxc6VROjUi/8BfHOVvo5jR8=;
 b=RWs5BoLD6euVBAHiLXVil0K3RSiPuS+NLXBHUGvU+e9ay9Up7ENR+q4qFbKED6vokawow6
 x6a0S734cNajpSsSnKX2JCFfuiq6Xm2e0vFEoExCJdc3VZQtdhISh3tdkJnlbGAARv+KUY
 xom7sEtM7WscJwH/1kPeCEmAfe4ckq8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-27VQIONhO4KFnGqpGIUqNw-1; Fri,
 11 Sep 2026 10:36:54 -0400
X-MC-Unique: 27VQIONhO4KFnGqpGIUqNw-1
X-Mimecast-MFC-AGG-ID: 27VQIONhO4KFnGqpGIUqNw_1789137413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D0951955D88; Fri, 11 Sep 2026 14:36:53 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 286133000229; Fri, 11 Sep 2026 14:36:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/28] hw/usb: mark commonly used USB devices/hosts as secure
Date: Fri, 11 Sep 2026 15:36:09 +0100
Message-ID: <20260911143627.2743803-11-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Most of the standardized  USB1/2/3 host controllers are relevant
for virtualization use cases, so should be declared secure. The
"NEC" XHCI variant is slightly non-standard, but since it is a
trivial sub-class of the generic XHCI, there's no reason to
exclude it.

The set of devices that are expected to be used is HID (mouse,
tablet, keyboard), host passthrough, CCID (smartcard), hub,
storage and the redirect tunnelling.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/usb/ccid-card-emulated.c   | 1 +
 hw/usb/ccid-card-passthru.c   | 1 +
 hw/usb/dev-hid.c              | 4 ++++
 hw/usb/dev-hub.c              | 1 +
 hw/usb/dev-smartcard-reader.c | 3 +++
 hw/usb/dev-storage-bot.c      | 1 +
 hw/usb/dev-storage-classic.c  | 1 +
 hw/usb/dev-storage.c          | 1 +
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
 19 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 985f21997a..f10295c675 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -610,6 +610,7 @@ static const TypeInfo emulated_card_info = {
     .parent        = TYPE_CCID_CARD,
     .instance_size = sizeof(EmulatedState),
     .class_init    = emulated_class_initfn,
+    .secure        = true,
 };
 module_obj(TYPE_EMULATED_CCID);
 module_kconfig(USB);
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index 5ab7855272..b91f32ebd6 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -412,6 +412,7 @@ static const TypeInfo passthru_card_info = {
     .parent        = TYPE_CCID_CARD,
     .instance_size = sizeof(PassthruState),
     .class_init    = passthru_class_initfn,
+    .secure        = true,
 };
 module_obj(TYPE_CCID_PASSTHRU);
 module_kconfig(USB);
diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
index ae19d60203..7fa9a4b010 100644
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
index b45d571fa8..7017b4fbc7 100644
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
index 964c142d10..d661c7687f 100644
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
index a7f8d80c17..b156f1c5c9 100644
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
index 977151c4a0..7e0699cb51 100644
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
index 040cf15051..f964d0c9dc 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -608,6 +608,7 @@ static const TypeInfo usb_storage_dev_type_info = {
     .instance_size = sizeof(MSDState),
     .abstract = true,
     .class_init = usb_msd_class_initfn_common,
+    .secure = true,
 };
 
 static void usb_msd_register_types(void)
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index fd35d25340..d735d75956 100644
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
index 7f7c7f8a2f..0946d5a004 100644
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
index 70c9e9ac4f..cf0746aa00 100644
--- a/hw/usb/hcd-ohci-pci.c
+++ b/hw/usb/hcd-ohci-pci.c
@@ -148,6 +148,7 @@ static const TypeInfo ohci_pci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(OHCIPCIState),
     .class_init    = ohci_pci_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/usb/hcd-ohci-sysbus.c b/hw/usb/hcd-ohci-sysbus.c
index 4f51eebccb..fd04e918e8 100644
--- a/hw/usb/hcd-ohci-sysbus.c
+++ b/hw/usb/hcd-ohci-sysbus.c
@@ -80,6 +80,7 @@ static const TypeInfo ohci_sysbus_types[] = {
         .parent        = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(OHCISysBusState),
         .class_init    = ohci_sysbus_class_init,
+        .secure        = true,
     },
 };
 
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index a7b9fe1317..cd34680f46 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1283,6 +1283,7 @@ static const TypeInfo uhci_pci_type_info = {
     .instance_size = sizeof(UHCIState),
     .class_size    = sizeof(UHCIPCIDeviceClass),
     .abstract = true,
+    .secure = true,
     .class_init = uhci_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -1380,6 +1381,7 @@ static void uhci_register_types(void)
     TypeInfo uhci_type_info = {
         .parent        = TYPE_UHCI,
         .class_init    = uhci_data_class_init,
+        .secure        = true,
     };
     int i;
 
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
index 46839911f3..070732be9a 100644
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
index b124251ae3..5d0fd851ca 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -266,6 +266,7 @@ static const TypeInfo xhci_pci_info = {
     .class_init    = xhci_class_init,
     .instance_init = xhci_instance_init,
     .abstract      = true,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -298,6 +299,7 @@ static const TypeInfo qemu_xhci_info = {
     .parent        = TYPE_XHCI_PCI,
     .class_init    = qemu_xhci_class_init,
     .instance_init = qemu_xhci_instance_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/hcd-xhci-sysbus.c b/hw/usb/hcd-xhci-sysbus.c
index bbdd5fd64a..8dd50fbbf1 100644
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
index d342aa2739..aa6c8a0fdd 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3676,6 +3676,7 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 564fe9a547..c845778a54 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1810,6 +1810,7 @@ static const TypeInfo usb_host_dev_info = {
     .instance_size = sizeof(USBHostDevice),
     .class_init    = usb_host_class_initfn,
     .instance_init = usb_host_instance_init,
+    .secure        = true,
 };
 module_obj(TYPE_USB_HOST_DEVICE);
 module_kconfig(USB);
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index dfd9e8bb50..2d56ba329a 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2654,6 +2654,7 @@ static const TypeInfo usbredir_dev_info = {
     .instance_size = sizeof(USBRedirDevice),
     .class_init    = usbredir_class_initfn,
     .instance_init = usbredir_instance_init,
+    .secure        = true,
 };
 module_obj(TYPE_USB_REDIR);
 module_kconfig(USB);
-- 
2.55.0


