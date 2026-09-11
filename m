Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CBEC88E45
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Tl-00024f-V6; Fri, 11 Sep 2026 10:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nk-0002s6-Pu
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52NN-00087K-Vg
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v/QFXhbR7+trrsi9yjvMVLU5gLecR5pn7XwbzwTQyqg=;
 b=VJnxGc+s/X+w2CjwZG2vKsUy58QKmoFHyd/1U5tyH8TSpQf+IYI/3VXN6IQjt83Gl86afk
 yrSxyOpUpV0UQKyqmli6B371K6BnbCvxHrFvkTUM0hujJTIytu+vAeNcmBq+aWWy7VqVe4
 W3aMW2cS3UToWG8WCDrI37OsgE+FMjY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-tMRy4ymCPxWhrf_UlInavg-1; Fri,
 11 Sep 2026 10:37:10 -0400
X-MC-Unique: tMRy4ymCPxWhrf_UlInavg-1
X-Mimecast-MFC-AGG-ID: tMRy4ymCPxWhrf_UlInavg_1789137428
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B572E1953964; Fri, 11 Sep 2026 14:37:08 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EABCD300022B; Fri, 11 Sep 2026 14:37:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/28] hw/display: mark bochs, cirrus, qxl, VGA,
 ramfb as secure
Date: Fri, 11 Sep 2026 15:36:16 +0100
Message-ID: <20260911143627.2743803-18-berrange@redhat.com>
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

Most of the display adapters are emulating old hardware which is not
relevant to virtualization use cases.

The exceptions that should be considered secure are Cirrus (PCI, not
ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.

The Cirrus PCI decision is borderline. It has been heavily used with
virtualization in the past, but these days VGA / RAMFB are strongly
recommended instead. Due to its historical usage though, we should
likely retain it in the set we aim to class as secure.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/bochs-display.c    | 1 +
 hw/display/cirrus_vga.c       | 1 +
 hw/display/qxl.c              | 3 +++
 hw/display/ramfb-standalone.c | 1 +
 hw/display/vga-mmio.c         | 1 +
 hw/display/vga-pci.c          | 3 +++
 6 files changed, 10 insertions(+)

diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 64e669429c..5f3ba80f99 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -374,6 +374,7 @@ static const TypeInfo bochs_display_type_info = {
     .instance_size  = sizeof(BochsDisplayState),
     .instance_init  = bochs_display_init,
     .class_init     = bochs_display_class_init,
+    .secure         = true,
     .interfaces     = (const InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 0a8c74e137..8232c5c468 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3013,6 +3013,7 @@ static const TypeInfo cirrus_vga_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCICirrusVGAState),
     .class_init    = cirrus_vga_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 384b8767b8..d673663b3a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2566,6 +2566,7 @@ static const TypeInfo qxl_pci_type_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIQXLDevice),
     .abstract = true,
+    .secure = true,
     .class_init = qxl_pci_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -2589,6 +2590,7 @@ static const TypeInfo qxl_primary_info = {
     .name          = "qxl-vga",
     .parent        = TYPE_PCI_QXL,
     .class_init    = qxl_primary_class_init,
+    .secure        = true,
 };
 module_obj("qxl-vga");
 module_kconfig(QXL);
@@ -2607,6 +2609,7 @@ static const TypeInfo qxl_secondary_info = {
     .name          = "qxl",
     .parent        = TYPE_PCI_QXL,
     .class_init    = qxl_secondary_class_init,
+    .secure        = true,
 };
 module_obj("qxl");
 
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 8e8ba37514..9427009acc 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -85,6 +85,7 @@ static const TypeInfo ramfb_info = {
     .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(RAMFBStandaloneState),
     .class_init    = ramfb_class_initfn,
+    .secure        = true,
 };
 
 static void ramfb_register_types(void)
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index 3cd64951c0..65dbbed12d 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -132,6 +132,7 @@ static const TypeInfo vga_mmio_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(VGAMmioState),
     .class_init    = vga_mmio_class_initfn,
+    .secure        = true,
 };
 
 static void vga_mmio_register_types(void)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index d089847bda..bb13eee8a2 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -367,6 +367,7 @@ static const TypeInfo vga_pci_type_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIVGAState),
     .abstract = true,
+    .secure = true,
     .class_init = vga_pci_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -407,6 +408,7 @@ static const TypeInfo vga_info = {
     .name          = "VGA",
     .parent        = TYPE_PCI_VGA,
     .class_init    = vga_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo secondary_info = {
@@ -414,6 +416,7 @@ static const TypeInfo secondary_info = {
     .parent        = TYPE_PCI_VGA,
     .instance_init = pci_secondary_vga_init,
     .class_init    = secondary_class_init,
+    .secure        = true,
 };
 
 static void vga_register_types(void)
-- 
2.55.0


