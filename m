Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7D9CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0K-0005FS-WA; Tue, 26 May 2026 04:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0J-0005ER-2P
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0H-0007Ym-6I
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rizq2K3PQZy6O3Z2ND0nuJ82zts+TTfxvu42v2xOi/c=;
 b=HJCLGxYHuA6suiz/mV7ZQGEOOo2ReZrEdx7l+sD+FpyU6VhQRsisJd0YE269rfjsoJBG1M
 /GeZMa6XaS06xx7VYvpdsRBQ0qietk1TxOIo86U8kBaH2POH32e57ariF45X4XDNJHg151
 wRwT/owP6gR6xFZUT1WX05XXh2CkJmw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-Cyg0zb8CMA-yl_hTpfvCTg-1; Tue,
 26 May 2026 04:19:06 -0400
X-MC-Unique: Cyg0zb8CMA-yl_hTpfvCTg-1
X-Mimecast-MFC-AGG-ID: Cyg0zb8CMA-yl_hTpfvCTg_1779783545
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F48A18002CB; Tue, 26 May 2026 08:19:05 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ADD6D180056E; Tue, 26 May 2026 08:19:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/37] hw/arm/aspeed: Convert SRAM MemoryRegion to array type
Date: Tue, 26 May 2026 10:18:17 +0200
Message-ID: <20260526081848.651835-7-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Several kinds of RAM are supported across Aspeed SoCs, including
SRAM, SDRAM, HyperRAM, secure SRAM, and generic SRAM. In addition,
different SoCs may expose multiple SRAM regions at different MMIO
addresses.

The current implementation models SRAM with a single MemoryRegion
instance, which makes future expansion cumbersome when additional
SRAM types or regions are introduced.

Prepare for future SoC designs by converting the SRAM MemoryRegion
from a single object into an array-based structure. This change
introduces ASPEED_SRAM_NUM and converts existing SRAM users to
reference sram[0].

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260525053036.3305181-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 3 ++-
 hw/arm/aspeed_ast10x0.c     | 5 +++--
 hw/arm/aspeed_ast2400.c     | 6 +++---
 hw/arm/aspeed_ast2600.c     | 6 +++---
 hw/arm/aspeed_ast27x0.c     | 4 ++--
 5 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index d7b3647ca16c..e6942b2936ae 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -60,6 +60,7 @@
 #define ASPEED_PCIE_NUM  3
 #define ASPEED_INTC_NUM  2
 #define ASPEED_IOEXP_NUM 2
+#define ASPEED_SRAM_NUM 1
 
 struct AspeedSoCState {
     DeviceState parent;
@@ -67,7 +68,7 @@ struct AspeedSoCState {
     MemoryRegion *memory;
     MemoryRegion *dram_mr;
     MemoryRegion dram_container;
-    MemoryRegion sram;
+    MemoryRegion sram[ASPEED_SRAM_NUM];
     MemoryRegion spi_boot_container;
     MemoryRegion spi_boot;
     MemoryRegion vbootrom;
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 41a4e82c1f87..3e478f752058 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -240,14 +240,15 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCState *a, Error **errp)
     /* Internal SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d",
                                 CPU(a->armv7m.cpu)->cpu_index);
-    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
+    memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name, sc->sram_size,
+                           &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return false;
     }
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SRAM],
-                                &s->sram);
+                                &s->sram[0]);
     memory_region_init_ram(&s->secsram, OBJECT(s), "sec.sram",
                            sc->secsram_size, &err);
     if (err != NULL) {
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index b1b826b7e0b1..d79aa832f3fa 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -281,12 +281,12 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
-                                errp)) {
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,
+                                sc->sram_size, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index efb1d8c0637c..a69103de89ea 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -437,12 +437,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
-                                errp)) {
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), sram_name,
+                                sc->sram_size, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);
 
     /* DPMCU */
     aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->dpmcu),
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 87dcb82e1b01..0fb5e4b24c9d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -778,12 +778,12 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), name, sc->sram_size,
+    if (!memory_region_init_ram(&s->sram[0], OBJECT(s), name, sc->sram_size,
                                 errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM], &s->sram);
+                                sc->memmap[ASPEED_DEV_SRAM], &s->sram[0]);
 
     /* VBOOTROM */
     if (!memory_region_init_ram(&s->vbootrom, OBJECT(s), "aspeed.vbootrom",
-- 
2.54.0


