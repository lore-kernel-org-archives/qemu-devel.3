Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115E9CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKTc-00063h-L0; Thu, 15 Oct 2026 08:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTX-0005mQ-Qe
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xHKTU-0005bu-DT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792066939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22TDwxXlHOPFJDlkPvlOsjmq8m1lAHrkYC3232mXZus=;
 b=ZQW0y9odDnnqN7bbQIOFT2eE5OexKUBV2mtcWCw9Uax+lmhmKySKBTdalpGb3eJE2DTVCk
 PcG/C5L93CgolmAQlk+rd0JfiH8OpAyFClx1c5aM3IM9JlottbIG1et+lFrZVrpN453Qcn
 sY43i3yQKfcdBh99phq9nr6Rb1BGxpE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-vng_rm0KMsqezXVutMGlfw-1; Thu,
 15 Oct 2026 12:22:18 +0000
X-MC-Unique: vng_rm0KMsqezXVutMGlfw-1
X-Mimecast-MFC-AGG-ID: vng_rm0KMsqezXVutMGlfw_1792066937
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39FC918011D5; Thu, 15 Oct 2026 12:22:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 938B37D5; Thu, 15 Oct 2026 12:22:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/21] hw/arm/aspeed_ast2600: Use a table for unimplemented
 devices
Date: Thu, 15 Oct 2026 14:21:41 +0200
Message-ID: <20261015122151.889017-12-clg@redhat.com>
In-Reply-To: <20261015122151.889017-1-clg@redhat.com>
References: <20261015122151.889017-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Before this change, each unimplemented device needed its own field in
AspeedSoCState. This made the variable names confusing. For example,
AspeedSoCState has "udc" as an unimplemented device, but
Aspeed2600SoCState also has "udc" as the real UDC model.

Use the unimp_devs table in AspeedSoCClass to describe the
unimplemented devices, and use create_unimplemented_devices() to create
and map them. This makes the code easier to maintain and read. Convert
AST2600 to use them.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261012064445.2571633-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 44 +++++++++++------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1a10d0fe1ecc..ebaf07d3128a 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -19,9 +19,6 @@
 #include "system/system.h"
 #include "target/arm/cpu-qom.h"
 
-#define ASPEED_SOC_IOMEM_SIZE       0x00200000
-#define ASPEED_SOC_DPMCU_SIZE       0x00040000
-
 static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
     [ASPEED_DEV_SRAM0]     = 0x10000000,
@@ -149,6 +146,15 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_DEV_ACRY]      = 160,
 };
 
+static const UnimplementedDeviceConfig aspeed_soc_ast2600_unimp_devs[] = {
+    { "iomem", "aspeed.io", 0x1E600000, 0x00200000, -1000 },
+    { "video", "aspeed.video", 0x1E700000, 0x1000, -1000 },
+    { "dpmcu", "aspeed.dpmcu", 0x18000000, 0x00040000, -1000 },
+    { "emmc-boot-controller", "aspeed.emmc-boot-controller",
+      0x1E6F5000, 0x1000, -1000 },
+    { }
+};
+
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed2600SoCState *a = ASPEED2600_SOC(s);
@@ -282,13 +288,6 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);
 
-    object_initialize_child(obj, "iomem", &s->iomem, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "video", &s->video, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "dpmcu", &s->dpmcu, TYPE_UNIMPLEMENTED_DEVICE);
-    object_initialize_child(obj, "emmc-boot-controller",
-                            &s->emmc_boot_controller,
-                            TYPE_UNIMPLEMENTED_DEVICE);
-
     for (i = 0; i < ASPEED_FSI_NUM; i++) {
         object_initialize_child(obj, "fsi[*]", &s->fsi[i], TYPE_ASPEED_APB2OPB);
     }
@@ -382,22 +381,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SPI_BOOT],
                                 &s->spi_boot_container);
 
-    /* IO space */
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->iomem),
-                                  "aspeed.io",
-                                  sc->memmap[ASPEED_DEV_IOMEM],
-                                  ASPEED_SOC_IOMEM_SIZE);
-
-    /* Video engine stub */
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->video),
-                                  "aspeed.video",
-                                  sc->memmap[ASPEED_DEV_VIDEO], 0x1000);
-
-    /* eMMC Boot Controller stub */
-    aspeed_mmio_map_unimplemented(s->memory,
-                                  SYS_BUS_DEVICE(&s->emmc_boot_controller),
-                                  "aspeed.emmc-boot-controller",
-                                  sc->memmap[ASPEED_DEV_EMMC_BC], 0x1000);
+    /* Unimplemented devices */
+    create_unimplemented_devices(OBJECT(s), s->memory, sc->unimp_devs);
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
@@ -469,12 +454,6 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],
                                 &s->sram_container[1]);
 
-    /* DPMCU */
-    aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
-                                  "aspeed.dpmcu",
-                                  sc->memmap[ASPEED_DEV_DPMCU],
-                                  ASPEED_SOC_DPMCU_SIZE);
-
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
@@ -838,6 +817,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, const void *data)
     sc->uarts_base   = ASPEED_DEV_UART1;
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
     sc->memmap       = aspeed_soc_ast2600_memmap;
+    sc->unimp_devs   = aspeed_soc_ast2600_unimp_devs;
     sc->num_cpus     = 2;
     sc->boot_from_emmc = aspeed_soc_ast2600_boot_from_emmc;
 }
-- 
2.56.0


