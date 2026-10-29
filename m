Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235ED606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=R//3TqWS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ0x-00067A-Au; Thu, 29 Oct 2026 09:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPxJ-0000Tv-11
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMPxH-0006Y4-64
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793279646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dR2eFwA6BcT8vW16lTId9tfFaddfYJbds4sEJfK9C1s=;
 b=R//3TqWS+qw165tpwG6ONlCf5q6SkedxGkN3FG3DnhVSi0nNzMV+0h4tDCXKG/ENi62hDO
 8oiiL+KWoep6QX2KpS23bic3CjpRMsGsjFBqHM0+ug1lrEONprti+fU66ncM7IeOdqitx/
 fiI/qjG7QcxQQTkzdTdJX6rzQzBQvxI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-m81A4W8_OtKay1YwuGUEnw-1; Thu,
 29 Oct 2026 09:14:04 -0400
X-MC-Unique: m81A4W8_OtKay1YwuGUEnw-1
X-Mimecast-MFC-AGG-ID: m81A4W8_OtKay1YwuGUEnw_1793279643
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69D441955DE8; Thu, 29 Oct 2026 13:14:03 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E0273000723; Thu, 29 Oct 2026 13:14:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 28/28] hw/usb: mark UHCI, OCHI & ECHI USB hosts as secure
Date: Thu, 29 Oct 2026 13:12:41 +0000
Message-ID: <20261029131241.2275706-29-berrange@redhat.com>
In-Reply-To: <20261029131241.2275706-1-berrange@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
XHCI controller which supports all of USB 1, 2 and 3. The UHCI
OCHI and ECHI hosts, however, have all been widely used in
virtualization scenarios historically, especially on x86. Indeed
the -usb flag will enable UCHI by default.

So while these are undesirable hosts in general, this marks them
as secure for virtualization use cases.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/usb/hcd-ehci-pci.c    | 1 +
 hw/usb/hcd-ehci-sysbus.c | 7 +++++++
 hw/usb/hcd-ohci-pci.c    | 1 +
 hw/usb/hcd-ohci-sysbus.c | 1 +
 hw/usb/hcd-uhci.c        | 1 +
 5 files changed, 11 insertions(+)

diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index fd35d253407..2080ea2913a 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -219,6 +219,7 @@ static void ehci_pci_register_types(void)
     TypeInfo ehci_type_info = {
         .parent        = TYPE_PCI_EHCI,
         .class_init    = ehci_data_class_init,
+        .secure        = true,
     };
     int i;
 
diff --git a/hw/usb/hcd-ehci-sysbus.c b/hw/usb/hcd-ehci-sysbus.c
index 7f7c7f8a2f1..0af658d2b68 100644
--- a/hw/usb/hcd-ehci-sysbus.c
+++ b/hw/usb/hcd-ehci-sysbus.c
@@ -247,32 +247,38 @@ static const TypeInfo ehci_sysbus_types[] = {
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
@@ -280,6 +286,7 @@ static const TypeInfo ehci_sysbus_types[] = {
         .instance_size = sizeof(FUSBH200EHCIState),
         .instance_init = fusbh200_ehci_init,
         .class_init    = fusbh200_ehci_class_init,
+        .secure        = true,
     },
 };
 
diff --git a/hw/usb/hcd-ohci-pci.c b/hw/usb/hcd-ohci-pci.c
index 70c9e9ac4f5..cf0746aa00b 100644
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
index 4f51eebccb2..fd04e918e8a 100644
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
index a7b9fe13175..c6d163aa9f6 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1380,6 +1380,7 @@ static void uhci_register_types(void)
     TypeInfo uhci_type_info = {
         .parent        = TYPE_UHCI,
         .class_init    = uhci_data_class_init,
+        .secure        = true,
     };
     int i;
 
-- 
2.56.0


