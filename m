Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B004CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v294L-0000R3-3F; Fri, 26 Sep 2025 10:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v294I-00005M-Rm
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v2944-0004zC-E2
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvhVVuj+5rYph1gX9Yow5UTEaohDQnvCpXPfzyRrpsM=;
 b=hUzPHX39BqzEG8CoAkSyOSKIkJB0sHoqctjxadY7hvVx+nzGTUBBONuCXnvGR2PVw7ooUl
 QzL/p/APwwcV5R1e3ZwzORYf5LhSVFwV2XCEKn38d5piqq1YNw3+0eM8z7XPFKGT8Tfi2W
 7FTrd7Qf0dv3N6I39Cnh3isLgyYobdk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-quB5zPXBOuy6kG41xDrBOg-1; Fri,
 26 Sep 2025 10:04:37 -0400
X-MC-Unique: quB5zPXBOuy6kG41xDrBOg-1
X-Mimecast-MFC-AGG-ID: quB5zPXBOuy6kG41xDrBOg_1758895477
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C911B195605E; Fri, 26 Sep 2025 14:04:36 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85D49195419F; Fri, 26 Sep 2025 14:04:33 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 32/32] hw/display: mark most display adapters as insecure
Date: Fri, 26 Sep 2025 15:01:43 +0100
Message-ID: <20250926140144.1998694-33-berrange@redhat.com>
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
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Most of thte display adapters are emulating old hardware which is not
relevant to virtualization use cases.

The exceptions that should be considered secure are Cirrus (PCI, not
ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.

The Cirrus PCI decision is borderline. It has been heavily used with
virtualization in the past, but these days VGA / RAMFB are strongly
recommended instead. Due to its historical usage though, we can
consider the code fairly mature, even if no longer hugely relevant
to virtualization use cases.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/display/artist.c           | 1 +
 hw/display/ati.c              | 1 +
 hw/display/bcm2835_fb.c       | 1 +
 hw/display/bochs-display.c    | 1 +
 hw/display/cg3.c              | 1 +
 hw/display/cirrus_vga.c       | 1 +
 hw/display/cirrus_vga_isa.c   | 1 +
 hw/display/dm163.c            | 1 +
 hw/display/dpcd.c             | 1 +
 hw/display/exynos4210_fimd.c  | 1 +
 hw/display/g364fb.c           | 1 +
 hw/display/i2c-ddc.c          | 3 ++-
 hw/display/jazz_led.c         | 1 +
 hw/display/macfb.c            | 2 ++
 hw/display/next-fb.c          | 1 +
 hw/display/pl110.c            | 3 +++
 hw/display/qxl.c              | 4 ++++
 hw/display/ramfb-standalone.c | 1 +
 hw/display/sii9022.c          | 1 +
 hw/display/sm501.c            | 1 +
 hw/display/ssd0303.c          | 1 +
 hw/display/ssd0323.c          | 1 +
 hw/display/tcx.c              | 1 +
 hw/display/vga-isa.c          | 1 +
 hw/display/vga-mmio.c         | 1 +
 hw/display/vga-pci.c          | 3 +++
 hw/display/vmware_vga.c       | 1 +
 hw/display/xlnx_dp.c          | 1 +
 28 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 3c884c9243..caab4d1d4c 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1504,6 +1504,7 @@ static const TypeInfo artist_info = {
     .instance_size = sizeof(ARTISTState),
     .instance_init = artist_initfn,
     .class_init    = artist_class_init,
+    .secure        = false,
 };
 
 static void artist_register_types(void)
diff --git a/hw/display/ati.c b/hw/display/ati.c
index f7c0006a87..6e332e02d2 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1080,6 +1080,7 @@ static const TypeInfo ati_vga_info = {
     .instance_size = sizeof(ATIVGAState),
     .class_init = ati_vga_class_init,
     .instance_init = ati_vga_init,
+    .secure = false,
     .interfaces = (const InterfaceInfo[]) {
           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
           { },
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 1bb2ee45a0..bb6c986fb8 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -459,6 +459,7 @@ static const TypeInfo bcm2835_fb_info = {
     .instance_size = sizeof(BCM2835FBState),
     .class_init    = bcm2835_fb_class_init,
     .instance_init = bcm2835_fb_init,
+    .secure        = false,
 };
 
 static void bcm2835_fb_register_types(void)
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index ad2821c974..0495d900f6 100644
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
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index daeef15217..f437921a7e 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -384,6 +384,7 @@ static const TypeInfo cg3_info = {
     .instance_size = sizeof(CG3State),
     .instance_init = cg3_initfn,
     .class_init    = cg3_class_init,
+    .secure        = false,
 };
 
 static void cg3_register_types(void)
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index ef08694626..d9403ccb57 100644
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
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 4b55c48eff..7b38e6c33a 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -91,6 +91,7 @@ static const TypeInfo isa_cirrus_vga_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(ISACirrusVGAState),
     .class_init = isa_cirrus_vga_class_init,
+    .secure        = false,
 };
 
 static void cirrus_vga_isa_register_types(void)
diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index f8340d8275..f043786775 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -343,6 +343,7 @@ static const TypeInfo dm163_types[] = {
         .parent = TYPE_DEVICE,
         .instance_size = sizeof(DM163State),
         .class_init = dm163_class_init
+        .secure = false,
     }
 };
 
diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index a157dc64e7..733f643375 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -155,6 +155,7 @@ static const TypeInfo dpcd_info = {
     .instance_size = sizeof(DPCDState),
     .class_init    = dpcd_class_init,
     .instance_init = dpcd_init,
+    .secure        = false,
 };
 
 static void dpcd_register_types(void)
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index c61e0280a7..85e32e8700 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1974,6 +1974,7 @@ static const TypeInfo exynos4210_fimd_info = {
     .instance_size = sizeof(Exynos4210fimdState),
     .instance_init = exynos4210_fimd_init,
     .class_init = exynos4210_fimd_class_init,
+    .secure = false,
 };
 
 static void exynos4210_fimd_register_types(void)
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index a6ddc21d3e..c23d584684 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -543,6 +543,7 @@ static const TypeInfo g364fb_sysbus_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(G364SysBusState),
     .class_init    = g364fb_sysbus_class_init,
+    .secure        = false,
 };
 
 static void g364fb_register_types(void)
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 2adfc1a147..525479aa49 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -117,7 +117,8 @@ static const TypeInfo i2c_ddc_info = {
     .parent = TYPE_I2C_SLAVE,
     .instance_size = sizeof(I2CDDCState),
     .instance_init = i2c_ddc_init,
-    .class_init = i2c_ddc_class_init
+    .class_init = i2c_ddc_class_init,
+    .secure = false,
 };
 
 static void ddc_register_devices(void)
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index 90e82b58be..946f78306e 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -310,6 +310,7 @@ static const TypeInfo jazz_led_info = {
     .instance_size = sizeof(LedState),
     .instance_init = jazz_led_init,
     .class_init    = jazz_led_class_init,
+    .secure        = false,
 };
 
 static void jazz_led_register(void)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 574d667173..b80ce26d9b 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -825,6 +825,7 @@ static const TypeInfo macfb_sysbus_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(MacfbSysBusState),
     .class_init    = macfb_sysbus_class_init,
+    .secure        = false,
 };
 
 static const TypeInfo macfb_nubus_info = {
@@ -833,6 +834,7 @@ static const TypeInfo macfb_nubus_info = {
     .instance_size = sizeof(MacfbNubusState),
     .class_init    = macfb_nubus_class_init,
     .class_size    = sizeof(MacfbNubusDeviceClass),
+    .secure        = false,
 };
 
 static void macfb_register_types(void)
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
index ec81b766a7..9ddbd13ba3 100644
--- a/hw/display/next-fb.c
+++ b/hw/display/next-fb.c
@@ -134,6 +134,7 @@ static const TypeInfo nextfb_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(NeXTFbState),
     .class_init    = nextfb_class_init,
+    .secure        = false,
 };
 
 static void nextfb_register_types(void)
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 09c3c59e0e..ce33d4c68c 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -596,18 +596,21 @@ static const TypeInfo pl110_info = {
     .instance_size = sizeof(PL110State),
     .instance_init = pl110_init,
     .class_init    = pl110_class_init,
+    .secure        = false,
 };
 
 static const TypeInfo pl110_versatile_info = {
     .name          = "pl110_versatile",
     .parent        = TYPE_PL110,
     .instance_init = pl110_versatile_init,
+    .secure        = false,
 };
 
 static const TypeInfo pl111_info = {
     .name          = "pl111",
     .parent        = TYPE_PL110,
     .instance_init = pl111_init,
+    .secure        = false,
 };
 
 static void pl110_register_types(void)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 18f482ca7f..8f876c872a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2516,7 +2516,9 @@ static const TypeInfo qxl_pci_type_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIQXLDevice),
     .abstract = true,
+    .secure = true,
     .class_init = qxl_pci_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
@@ -2539,6 +2541,7 @@ static const TypeInfo qxl_primary_info = {
     .name          = "qxl-vga",
     .parent        = TYPE_PCI_QXL,
     .class_init    = qxl_primary_class_init,
+    .secure        = true,
 };
 module_obj("qxl-vga");
 module_kconfig(QXL);
@@ -2557,6 +2560,7 @@ static const TypeInfo qxl_secondary_info = {
     .name          = "qxl",
     .parent        = TYPE_PCI_QXL,
     .class_init    = qxl_secondary_class_init,
+    .secure        = true,
 };
 module_obj("qxl");
 
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 72b2071aed..6fbb90d74c 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -83,6 +83,7 @@ static const TypeInfo ramfb_info = {
     .parent        = TYPE_DYNAMIC_SYS_BUS_DEVICE,
     .instance_size = sizeof(RAMFBStandaloneState),
     .class_init    = ramfb_class_initfn,
+    .secure        = true,
 };
 
 static void ramfb_register_types(void)
diff --git a/hw/display/sii9022.c b/hw/display/sii9022.c
index d00d3e9fc5..06d7863a9e 100644
--- a/hw/display/sii9022.c
+++ b/hw/display/sii9022.c
@@ -185,6 +185,7 @@ static const TypeInfo sii9022_info = {
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(sii9022_state),
     .class_init    = sii9022_class_init,
+    .secure        = false,
 };
 
 static void sii9022_register_types(void)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index bc091b3c9f..abbb78ea3e 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2114,6 +2114,7 @@ static const TypeInfo sm501_sysbus_info = {
     .instance_size = sizeof(SM501SysBusState),
     .class_init    = sm501_sysbus_class_init,
     .instance_init = sm501_sysbus_init,
+    .secure        = false,
 };
 
 #define TYPE_PCI_SM501 "sm501"
diff --git a/hw/display/ssd0303.c b/hw/display/ssd0303.c
index 87781438cd..4be9d3bcc5 100644
--- a/hw/display/ssd0303.c
+++ b/hw/display/ssd0303.c
@@ -328,6 +328,7 @@ static const TypeInfo ssd0303_info = {
     .parent        = TYPE_I2C_SLAVE,
     .instance_size = sizeof(ssd0303_state),
     .class_init    = ssd0303_class_init,
+    .secure        = false,
 };
 
 static void ssd0303_register_types(void)
diff --git a/hw/display/ssd0323.c b/hw/display/ssd0323.c
index af5ff4fecd..8deddf2f47 100644
--- a/hw/display/ssd0323.c
+++ b/hw/display/ssd0323.c
@@ -378,6 +378,7 @@ static const TypeInfo ssd0323_info = {
     .parent        = TYPE_SSI_PERIPHERAL,
     .instance_size = sizeof(ssd0323_state),
     .class_init    = ssd0323_class_init,
+    .secure        = false,
 };
 
 static void ssd03232_register_types(void)
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 4853c5e142..1bbbc670dd 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -901,6 +901,7 @@ static const TypeInfo tcx_info = {
     .instance_size = sizeof(TCXState),
     .instance_init = tcx_initfn,
     .class_init    = tcx_class_init,
+    .secure        = false,
 };
 
 static void tcx_register_types(void)
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 3618913b3b..d01d73ddb0 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -108,6 +108,7 @@ static const TypeInfo vga_isa_info = {
     .parent        = TYPE_ISA_DEVICE,
     .instance_size = sizeof(ISAVGAState),
     .class_init    = vga_isa_class_initfn,
+    .secure        = false,
 };
 
 static void vga_isa_register_types(void)
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index 33263856b7..1c53422b59 100644
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
index b81f7fd2d0..acd59865d3 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -368,6 +368,7 @@ static const TypeInfo vga_pci_type_info = {
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PCIVGAState),
     .abstract = true,
+    .secure = true,
     .class_init = vga_pci_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
@@ -408,6 +409,7 @@ static const TypeInfo vga_info = {
     .name          = "VGA",
     .parent        = TYPE_PCI_VGA,
     .class_init    = vga_class_init,
+    .secure        = true,
 };
 
 static const TypeInfo secondary_info = {
@@ -415,6 +417,7 @@ static const TypeInfo secondary_info = {
     .parent        = TYPE_PCI_VGA,
     .instance_init = pci_secondary_vga_init,
     .class_init    = secondary_class_init,
+    .secure        = true,
 };
 
 static void vga_register_types(void)
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bc1a8ed466..8734da1175 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1363,6 +1363,7 @@ static const TypeInfo vmsvga_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(struct pci_vmsvga_state_s),
     .class_init    = vmsvga_class_init,
+    .secure        = true,
     .interfaces = (const InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { },
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index ef73e1815f..dc239537a9 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1412,6 +1412,7 @@ static const TypeInfo xlnx_dp_info = {
     .instance_init = xlnx_dp_init,
     .instance_finalize = xlnx_dp_finalize,
     .class_init    = xlnx_dp_class_init,
+    .secure        = false,
 };
 
 static void xlnx_dp_register_types(void)
-- 
2.50.1


