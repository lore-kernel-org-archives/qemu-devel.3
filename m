Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD117C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFXv-0007Fb-SG; Wed, 16 Jul 2025 23:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUv-0003aI-6F; Wed, 16 Jul 2025 23:41:31 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUt-0000ZH-D5; Wed, 16 Jul 2025 23:41:28 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:59 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:59 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 12/21] hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
 and update realization order
Date: Thu, 17 Jul 2025 11:40:40 +0800
Message-ID: <20250717034054.1903991-13-jamin_lin@aspeedtech.com>
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

This commit adds a MemoryRegion alias to support PSP access to
TSP SDRAM through shared memory remapping, as defined by the default SCU
configuration.

The TSP coprocessor exposes one DRAM alias:
  - remap maps PSP DRAM at 0x42e000000 (32MB) to TSP SDRAM offset 0x0

This region corresponds to the default SCU register value, which controls
the mapping between PSP and coprocessor memory windows.

To ensure correctness, the alias is initialized early in
aspeed_soc_ast2700_realize(), before SCU and coprocessor realization.
This allows TSP to reference the alias region during its SDRAM setup.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast27x0-tsp.c | 2 ++
 hw/arm/aspeed_ast27x0.c     | 9 +++++++++
 3 files changed, 12 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index d628a189c1..83e07582d2 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -153,6 +153,7 @@ struct Aspeed27x0TSPSoCState {
     MemoryRegion memory;
     MemoryRegion sram_mr_alias;
     MemoryRegion scu_mr_alias;
+    MemoryRegion sdram_remap_alias;
 
     ARMv7MState armv7m;
 };
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 6b035e2612..4c3b18695e 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -187,6 +187,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 AST2700_TSP_SDRAM_SIZE, errp)) {
         return;
     }
+    /* SDRAM remap alias used by PSP to access TSP SDRAM */
+    memory_region_add_subregion(&s->dram_container, 0, &a->sdram_remap_alias);
     memory_region_add_subregion(s->memory,
                                 sc->memmap[ASPEED_DEV_SDRAM],
                                 &s->dram_container);
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index be130db5e2..0f988eaa4d 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -812,6 +812,12 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
      *   - remap2 maps PSP DRAM at 0x42c000000 (size: 32MB) to SSP SDRAM
      *     offset 0x0
      *
+     * The TSP coprocessor uses one memory alias (remap) to access a shared
+     * region in the PSP DRAM:
+     *
+     *   - remap maps PSP DRAM at 0x42e000000 (size: 32MB) to TSP SDRAM
+     *     offset 0x0
+     *
      * These mappings correspond to the default values of the SCU registers:
      *
      * This configuration enables shared memory communication between the PSP
@@ -824,6 +830,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         memory_region_init_alias(&a->ssp.sdram_remap2_alias, OBJECT(a),
                                  "ssp.sdram.remap2", s->memory,
                                  0x42c000000ULL, 32 * MiB);
+        memory_region_init_alias(&a->tsp.sdram_remap_alias, OBJECT(a),
+                                 "tsp.sdram.remap", s->memory,
+                                 0x42e000000, 32 * MiB);
     }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
-- 
2.43.0


