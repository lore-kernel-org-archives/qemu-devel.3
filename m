Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EA0C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFXz-0007V6-Ff; Wed, 16 Jul 2025 23:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVF-0003gw-DC; Wed, 16 Jul 2025 23:42:04 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVD-0000YT-0l; Wed, 16 Jul 2025 23:41:48 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:58 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:58 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/21] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
 and update realization order
Date: Thu, 17 Jul 2025 11:40:39 +0800
Message-ID: <20250717034054.1903991-12-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
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

This commit adds two MemoryRegion aliases to support PSP access to
SSP SDRAM through shared memory remapping, as defined by the default SCU
configuration.

The SSP coprocessor exposes two DRAM aliases:
  - remap1 maps PSP DRAM at 0x400000000 (32MB) to SSP SDRAM offset 0x2000000
  - remap2 maps PSP DRAM at 0x42c000000 (32MB) to SSP SDRAM offset 0x0

These regions correspond to the default SCU register values, which control
the mapping between PSP and coprocessor memory windows.

To ensure correctness, the aliases are initialized early in
aspeed_soc_ast2700_realize(), before SCU and coprocessor realization.
This allows SSP to reference the alias regions during its SDRAM setup.

Additionally, the realization order comment has been updated to reflect
the new DRAM dependency: coprocessors must now be realized after DRAM,
SRAM, and SCU are all initialized.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h |  2 ++
 hw/arm/aspeed_ast27x0-ssp.c |  5 ++++
 hw/arm/aspeed_ast27x0.c     | 49 ++++++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 4152fbf495..d628a189c1 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -136,6 +136,8 @@ struct Aspeed27x0SSPSoCState {
     MemoryRegion memory;
     MemoryRegion sram_mr_alias;
     MemoryRegion scu_mr_alias;
+    MemoryRegion sdram_remap1_alias;
+    MemoryRegion sdram_remap2_alias;
 
     ARMv7MState armv7m;
 };
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index 0a58b8ea4b..fff95eac6a 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -187,6 +187,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                 AST2700_SSP_SDRAM_SIZE, errp)) {
         return;
     }
+    /* SDRAM remap alias used by PSP to access SSP SDRAM */
+    memory_region_add_subregion(&s->dram_container, 0, &a->sdram_remap2_alias);
+    memory_region_add_subregion(&s->dram_container,
+                                memory_region_size(&a->sdram_remap2_alias),
+                                &a->sdram_remap1_alias);
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SDRAM],
                                 &s->dram_container);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 9d67c5f631..be130db5e2 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -803,6 +803,28 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
 
     /* SCU */
+    /*
+     * The SSP coprocessor uses two memory aliases (remap1 and remap2)
+     * to access shared memory regions in the PSP DRAM:
+     *
+     *   - remap1 maps PSP DRAM at 0x400000000 (size: 32MB) to SSP SDRAM
+     *     offset 0x2000000
+     *   - remap2 maps PSP DRAM at 0x42c000000 (size: 32MB) to SSP SDRAM
+     *     offset 0x0
+     *
+     * These mappings correspond to the default values of the SCU registers:
+     *
+     * This configuration enables shared memory communication between the PSP
+     * and coprocessors, with address translation controlled by the SCU.
+     */
+    if (mc->default_cpus > sc->num_cpus) {
+        memory_region_init_alias(&a->ssp.sdram_remap1_alias, OBJECT(a),
+                                 "ssp.sdram.remap1", s->memory,
+                                 0x400000000ULL, 32 * MiB);
+        memory_region_init_alias(&a->ssp.sdram_remap2_alias, OBJECT(a),
+                                 "ssp.sdram.remap2", s->memory,
+                                 0x42c000000ULL, 32 * MiB);
+    }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
@@ -816,22 +838,27 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
                     sc->memmap[ASPEED_DEV_SCUIO]);
 
     /*
-     * Coprocessors must be realized after the SRAM and SCU regions.
+     * Coprocessors must be realized after the DRAM, SRAM, and SCU regions.
      *
-     * The SRAM is used as shared memory between the main CPU (PSP) and the
-     * coprocessors. Coprocessors access this shared SRAM region through a
-     * MemoryRegion alias mapped to a different physical address.
+     * - DRAM: Coprocessors access shared memory through MemoryRegion aliases
+     *   that point into PSP's DRAM space. These aliases are mapped into the
+     *   coprocessors' SDRAM windows at specific offsets (e.g., 0x0 and
+     *   0x2000000), and configured according to SCU register defaults.
+     *   Therefore, DRAM must be fully initialized before coprocessors can
+     *   attach aliases to it.
      *
-     * Similarly, the SCU is a single hardware block shared across all
-     * processors. Coprocessors access it via a MemoryRegion alias that maps
-     * to a different address than the one used by the main CPU.
+     * - SRAM: Used as shared memory between the PSP and coprocessors.
+     *   Coprocessors access this memory via alias regions mapped to
+     *   different physical addresses.
      *
-     * Therefore, both the SRAM and SCU must be fully initialized before the
-     * coprocessors can create aliases pointing to them.
+     * - SCU: A single hardware block shared across all processors.
+     *   Coprocessors access SCU registers through alias mappings.
+     *   SCU must be initialized first to allow for consistent register
+     *   state and memory remap configuration.
      *
      * To ensure correctness, the device realization order is explicitly
-     * managed:
-     * coprocessors are initialized only after SRAM and SCU are ready.
+     * managed: coprocessors are initialized only after DRAM, SRAM, and SCU
+     * are ready.
      */
     if (mc->default_cpus > sc->num_cpus) {
         if (!aspeed_soc_ast2700_ssp_realize(dev, errp)) {
-- 
2.43.0


