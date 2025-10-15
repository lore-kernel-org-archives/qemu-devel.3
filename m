Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F30CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 06:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uuL-0000uV-CL; Wed, 15 Oct 2025 02:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuI-0000s4-Js; Wed, 15 Oct 2025 02:22:42 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuE-0002xW-Bx; Wed, 15 Oct 2025 02:22:41 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 14:22:11 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 14:22:11 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 01/12] hw/arm/aspeed_ast27x0-ssp: Add SDRAM region and fix
 naming and size to 512MB
Date: Wed, 15 Oct 2025 14:21:56 +0800
Message-ID: <20251015062210.3128710-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Previously, the SSP memory was incorrectly modeled as "SRAM" with
a 32 MB size. This change introduces a new sdram field in
AspeedCoprocessorState and updates the realization logic accordingly.
Rename from SRAM to SDRAM and correct size from 32MB to 512MB to match
hardware.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h |  1 +
 hw/arm/aspeed_ast27x0-ssp.c         | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index d77655d659..0c7168a89c 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -16,6 +16,7 @@ struct AspeedCoprocessorState {
     DeviceState parent;
 
     MemoryRegion *memory;
+    MemoryRegion sdram;
     MemoryRegion sram;
     Clock *sysclk;
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 936c7c72e8..9f3a1933a0 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -16,10 +16,10 @@
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/aspeed_coprocessor.h"
 
-#define AST2700_SSP_RAM_SIZE (32 * MiB)
+#define AST2700_SSP_SDRAM_SIZE (512 * MiB)
 
 static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
-    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_SDRAM]     =  0x00000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -165,7 +165,7 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
-    g_autofree char *sram_name = NULL;
+    g_autofree char *sdram_name = NULL;
     int uart;
     int i;
 
@@ -184,16 +184,16 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                              OBJECT(s->memory), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
 
-    sram_name = g_strdup_printf("aspeed.dram.%d",
-                                CPU(a->armv7m.cpu)->cpu_index);
-
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name,
-                                AST2700_SSP_RAM_SIZE, errp)) {
+    /* SDRAM */
+    sdram_name = g_strdup_printf("aspeed.sdram.%d",
+                                 CPU(a->armv7m.cpu)->cpu_index);
+    if (!memory_region_init_ram(&s->sdram, OBJECT(s), sdram_name,
+                                AST2700_SSP_SDRAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM],
-                                &s->sram);
+                                sc->memmap[ASPEED_DEV_SDRAM],
+                                &s->sdram);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-- 
2.43.0


