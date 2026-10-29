Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC08606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGDvfMwE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMPxD-0000Ha-3n; Thu, 29 Oct 2026 09:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwW-0007uh-7x
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPwU-0006Dp-Cu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q4EKGHzXC6AVPfX5IpbkqCTVZ9Zlq3JGylx3phh9zm8=;
 b=VGDvfMwEIKCG8GjaiQOxEnJMm+TfXSKKFOFgs2RTdizIdKPtec82LYdyJOSfjvy3nLcq7g
 Q1x+E/9qn7P41yUFei8qNNg/KsKP+qVQeUM1vf/+I34R6SFXm8oWYDzJlPFef6Tr/R/X6q
 lRdLiK0Yr5hRSSV33CHsk74/YInTZeA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-H_lJsiYzPbKEltWBA7nJew-1; Thu,
 29 Oct 2026 09:13:09 -0400
X-MC-Unique: H_lJsiYzPbKEltWBA7nJew-1
X-Mimecast-MFC-AGG-ID: H_lJsiYzPbKEltWBA7nJew_1793279588
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F966180065C; Thu, 29 Oct 2026 13:13:08 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0ADDC3000723; Thu, 29 Oct 2026 13:13:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 08/28] hw/usb: mark commonly used USB devices/hosts as
 secure
Date: Thu, 29 Oct 2026 13:12:21 +0000
Message-ID: <20261029131241.2275706-9-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
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
index 977151c4a08..7e0699cb518 100644
--- a/hw/usb/dev-storage-classic.c
+++ b/hw/usb/dev-storage-classic.c
@@ -133,6 +133,7 @@ static const TypeInfo msd_info = {
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
index 5d7a77b8bcf..cf49d5ae759 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3705,6 +3705,7 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .secure        = true,
 };
 
 static void xhci_register_types(void)
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 8f7ced95cfe..b207320d481 100644
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
2.56.0


