Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1E3C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFYY-0000Wc-DQ; Wed, 16 Jul 2025 23:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVX-0003oh-9D; Wed, 16 Jul 2025 23:42:11 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVV-0000g2-Kk; Wed, 16 Jul 2025 23:42:07 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:41:00 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:41:00 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 16/21] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Date: Thu, 17 Jul 2025 11:40:44 +0800
Message-ID: <20250717034054.1903991-17-jamin_lin@aspeedtech.com>
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

This commit adds SCU register support for TSP SDRAM remap control and runtime
activation. Unlike SSP, the TSP does not support configurable target address remapping
through SCU registers. It only supports setting the PSP DRAM base and size, which
are then aliased into the TSP-visible SDRAM window.

One MemoryRegion alias is attached to the SCU via QOM property link:
    - tsp-sdram-remap: maps PSP DRAM at 0x42E000000 (size: 32MB) to TSP SDRAM
      offset 0x0

The SCU registers AST2700_SCU_TSP_CTRL_1 and
AST2700_SCU_TSP_REMAP_SIZE_2 allow runtime reconfiguration of the DRAM base (alias offset)
and mapping size.

|------------------------------------------|         |----------------------------|
|               PSP DRAM                   |         |        TSP SDRAM           |
|------------------------------------------|         |----------------------------|
| 0x42E0_0000_0 (SCU_168 << 4)             |         | 0x0000_0000                |
|   remap base                             |------>  |  - fixed target addr       |
|   size: 32MB    (SCU_194)                |         |                            |
|------------------------------------------|         |----------------------------|

SCU VMState version remains at 3, as it was already bumped in a previous commit.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/misc/aspeed_scu.h |  1 +
 hw/arm/aspeed_ast27x0.c      |  3 +++
 hw/misc/aspeed_scu.c         | 24 +++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 408f821379..5e7c80feb1 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -42,6 +42,7 @@ struct AspeedSCUState {
 
     MemoryRegion *ssp_sdram_remap1;
     MemoryRegion *ssp_sdram_remap2;
+    MemoryRegion *tsp_sdram_remap;
 };
 
 #define AST2400_A0_SILICON_REV   0x02000303U
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 587c042c30..23096bda34 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -839,6 +839,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         object_property_set_link(OBJECT(&s->scu), "ssp-sdram-remap2",
                                  OBJECT(&a->ssp.sdram_remap2_alias),
                                  &error_abort);
+        object_property_set_link(OBJECT(&s->scu), "tsp-sdram-remap",
+                                 OBJECT(&a->tsp.sdram_remap_alias),
+                                 &error_abort);
     }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index df379cafbe..21a0d1ad5c 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -143,13 +143,15 @@
 #define AST2700_HW_STRAP1_SEC2    TO_REG(0x28)
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)
 
-/* SSP */
+/* SSP TSP */
 #define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)
 #define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)
 #define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)
 #define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14c)
 #define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)
 #define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)
 
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
@@ -630,6 +632,8 @@ static const Property aspeed_scu_properties[] = {
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_LINK("ssp-sdram-remap2", AspeedSCUState, ssp_sdram_remap2,
                      TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_LINK("tsp-sdram-remap", AspeedSCUState, tsp_sdram_remap,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
 };
 
 static void aspeed_scu_class_init(ObjectClass *klass, const void *data)
@@ -956,6 +960,22 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
         data &= 0x3fffffff;
         memory_region_set_size(mr, data);
         break;
+    case AST2700_SCU_TSP_CTRL_1:
+        if (s->tsp_sdram_remap == NULL) {
+            return;
+        }
+        data &= 0x7fffffff;
+        /* remapped to SOC DRAM by adding data << 4 */
+        memory_region_set_alias_offset(s->tsp_sdram_remap,
+                                       (uint64_t) data << 4);
+        break;
+    case AST2700_SCU_TSP_REMAP_SIZE_2:
+        if (s->tsp_sdram_remap == NULL) {
+            return;
+        }
+        data &= 0x3fffffff;
+        memory_region_set_size(s->tsp_sdram_remap, data);
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
@@ -989,6 +1009,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCU_SSP_REMAP_SIZE_1]  = 0x02000000,
     [AST2700_SCU_SSP_REMAP_ADDR_2]  = 0x00000000,
     [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x02000000,
+    [AST2700_SCU_TSP_CTRL_1]        = 0x42E00000,
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
     [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
     [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
-- 
2.43.0


