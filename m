Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E88CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0O-0005Gt-KO; Tue, 26 May 2026 04:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0N-0005GN-1C
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0K-0007a2-SK
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vCMnshIFVTDoHKDvagDdLswwZqvZhVoRLyqON9R9QLc=;
 b=CeVwlfXNymkH+1qtLuFGJ7jO2ZK8ET8eccU1xMybEQy79kwZH5BSYudWeGmVVbtKPUNUy0
 ffL99TaL6IR7Gu2uh/OHuEW2/jIOpW42i420OzevKSX+AjTmH1thRLRaz80KEXeXsJZEuI
 yll//tnkYmobg6iIRTt1t6RRAJlV0Zk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-HI3IrineP7OpL76pP3SCGg-1; Tue,
 26 May 2026 04:19:10 -0400
X-MC-Unique: HI3IrineP7OpL76pP3SCGg-1
X-Mimecast-MFC-AGG-ID: HI3IrineP7OpL76pP3SCGg_1779783549
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C922180061F; Tue, 26 May 2026 08:19:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE8431800357; Tue, 26 May 2026 08:19:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/37] hw/arm/aspeed: Rename SRAM memmap entry for multi-SRAM
 support
Date: Tue, 26 May 2026 10:18:19 +0200
Message-ID: <20260526081848.651835-9-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some Aspeed SoCs contain multiple SRAM regions with different
MMIO mappings, such as internal SRAM and secure SRAM.

Prepare for future multi-SRAM support by renaming the SRAM
memmap entry from ASPEED_DEV_SRAM to ASPEED_DEV_SRAM0.
This makes the numbering explicit and aligns with the
array-based SRAM representation introduced previously.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 2 +-
 hw/arm/aspeed_ast10x0.c     | 4 ++--
 hw/arm/aspeed_ast2400.c     | 6 +++---
 hw/arm/aspeed_ast2600.c     | 4 ++--
 hw/arm/aspeed_ast27x0-ssp.c | 4 ++--
 hw/arm/aspeed_ast27x0-tsp.c | 4 ++--
 hw/arm/aspeed_ast27x0.c     | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 3a7db959a9ae..dda602e9f20c 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -228,7 +228,7 @@ enum {
     ASPEED_DEV_SECSRAM,
     ASPEED_DEV_EMMC_BC,
     ASPEED_DEV_VIDEO,
-    ASPEED_DEV_SRAM,
+    ASPEED_DEV_SRAM0,
     ASPEED_DEV_SDHCI,
     ASPEED_DEV_GPIO,
     ASPEED_DEV_GPIO_1_8V,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 9e597a75ec53..b55f788342a6 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -20,7 +20,7 @@
 #define ASPEED_SOC_IOMEM_SIZE 0x00200000
 
 static const hwaddr aspeed_soc_ast1030_memmap[] = {
-    [ASPEED_DEV_SRAM]      = 0x00000000,
+    [ASPEED_DEV_SRAM0]     = 0x00000000,
     [ASPEED_DEV_SECSRAM]   = 0x79000000,
     [ASPEED_DEV_IOMEM]     = 0x7E600000,
     [ASPEED_DEV_PWM]       = 0x7E610000,
@@ -247,7 +247,7 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
         return false;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM],
+                                sc->memmap[ASPEED_DEV_SRAM0],
                                 &s->sram[0]);
     memory_region_init_ram(&s->secsram, OBJECT(s), "sec.sram",
                            sc->secsram_size, &err);
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index c4e5388999e6..79a653f65f09 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -38,7 +38,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_DEV_XDMA]   = 0x1E6E7000,
     [ASPEED_DEV_VIDEO]  = 0x1E700000,
     [ASPEED_DEV_ADC]    = 0x1E6E9000,
-    [ASPEED_DEV_SRAM]   = 0x1E720000,
+    [ASPEED_DEV_SRAM0]  = 0x1E720000,
     [ASPEED_DEV_SDHCI]  = 0x1E740000,
     [ASPEED_DEV_GPIO]   = 0x1E780000,
     [ASPEED_DEV_RTC]    = 0x1E781000,
@@ -75,7 +75,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_DEV_XDMA]   = 0x1E6E7000,
     [ASPEED_DEV_ADC]    = 0x1E6E9000,
     [ASPEED_DEV_VIDEO]  = 0x1E700000,
-    [ASPEED_DEV_SRAM]   = 0x1E720000,
+    [ASPEED_DEV_SRAM0]  = 0x1E720000,
     [ASPEED_DEV_SDHCI]  = 0x1E740000,
     [ASPEED_DEV_GPIO]   = 0x1E780000,
     [ASPEED_DEV_RTC]    = 0x1E781000,
@@ -286,7 +286,7 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);
+                                sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0]);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 2f8f49a37689..d1f18e471aa0 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -23,7 +23,7 @@
 
 static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_DEV_SPI_BOOT]  = 0x00000000,
-    [ASPEED_DEV_SRAM]      = 0x10000000,
+    [ASPEED_DEV_SRAM0]     = 0x10000000,
     [ASPEED_DEV_DPMCU]     = 0x18000000,
     /* 0x16000000     0x17FFFFFF : AHB BUS do LPC Bus bridge */
     [ASPEED_DEV_IOMEM]     = 0x1E600000,
@@ -442,7 +442,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);
+                                sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0]);
 
     /* DPMCU */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 8b84300e0f60..b3c4eb1915ed 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -20,7 +20,7 @@
 
 static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x00000000,
-    [ASPEED_DEV_SRAM]      =  0x70000000,
+    [ASPEED_DEV_SRAM0]     =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_TIMER1]    =  0x72C10000,
@@ -182,7 +182,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     /* SRAM */
     memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",
                              s->sram, 0, memory_region_size(s->sram));
-    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],
                                 &s->sram_alias);
 
     /* SCU */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index e7c7b744919b..6098d1aae32d 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -20,7 +20,7 @@
 
 static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x00000000,
-    [ASPEED_DEV_SRAM]      =  0x70000000,
+    [ASPEED_DEV_SRAM0]     =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_TIMER1]    =  0x72C10000,
@@ -182,7 +182,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     /* SRAM */
     memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",
                              s->sram, 0, memory_region_size(s->sram));
-    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM0],
                                 &s->sram_alias);
 
     /* SCU */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 30883ea7ce40..d7ce14e8c563 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -30,7 +30,7 @@
 static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_VBOOTROM]  =  0x00000000,
     [ASPEED_DEV_IOMEM]     =  0x00020000,
-    [ASPEED_DEV_SRAM]      =  0x10000000,
+    [ASPEED_DEV_SRAM0]     =  0x10000000,
     [ASPEED_DEV_DPMCU]     =  0x11000000,
     [ASPEED_DEV_IOMEM0]    =  0x12000000,
     [ASPEED_DEV_EHCI1]     =  0x12061000,
@@ -783,7 +783,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);
+                                sc->memmap[ASPEED_DEV_SRAM0], &s->sram[0]);
 
     /* VBOOTROM */
     if (!memory_region_init_ram(&s->vbootrom, OBJECT(s), "aspeed.vbootrom",
-- 
2.54.0


