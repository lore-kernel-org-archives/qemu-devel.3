Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC75DC88E41
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfPc-0004zH-Gr; Tue, 27 Jan 2026 04:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfPR-0004Eb-3k; Tue, 27 Jan 2026 04:30:53 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfPP-0005A1-9b; Tue, 27 Jan 2026 04:30:52 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 27 Jan
 2026 17:29:46 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 27 Jan 2026 17:29:46 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 08/11] hw/misc/aspeed_scu: Add SCU support for SSP SDRAM
 remap
Date: Tue, 27 Jan 2026 17:29:37 +0800
Message-ID: <20260127092943.3731635-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
References: <20260127092943.3731635-1-jamin_lin@aspeedtech.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds SCU register support for SSP SDRAM remap control and runtime
activation. It introduces logic for the PSP to dynamically configure the mapping
of its own DRAM windows into SSP-visible SDRAM space, enabling shared memory
communication via memory region aliases.

- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x400000000 (size: 32MB) to SSP SDRAM
    offset 0x2000000
- coprocessor_sdram_remap[0]: maps PSP DRAM offset 0x42c000000 (size: 32MB) to SSP SDRAM
    offset 0x0

The SCU registers AST2700_SCU_SSP_CTRL_1/2 and
AST2700_SCU_SSP_REMAP_ADDR_{1,2} / REMAP_SIZE_{1,2} allow runtime reconfiguration
of alias offset, base, and size.

|------------------------------------------|         |----------------------------|
|               PSP DRAM                   |         |        SSP SDRAM           |
|------------------------------------------|         |----------------------------|
| 0x4_0000_0000 (SCU_124 << 4)             |     --> | 0x0000_0000                |
|   remap1 base                            |---| |   |  - SCU_150: target addr    |
|   size: 32MB    (SCU_14C)                |   | |   |    remap2                  |
|------------------------------------------|   | |   |----------------------------|
|                                          |   | |   |                            |
| 0x4_2C00_0000 (SCU_128 << 4)             |-----|   | 0x0200_0000                |
|   remap2 base                            |   |     |  - SCU_148: target addr    |
|   size: 32MB    (SCU_154)                |   |---> |    remap1                  |
|------------------------------------------|         |----------------------------|

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_scu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index fe93afed35..333fa964d3 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -147,6 +147,12 @@
 
 /* SSP TSP */
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)
+#define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)
+#define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)
+#define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)
+#define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14C)
+#define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)
+#define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)
 #define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)
 #define AST2700_SSP_TSP_ENABLE          BIT(0)
 #define AST2700_SSP_TSP_RST             BIT(1)
@@ -993,6 +999,7 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
                                      uint64_t data64, unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
+    MemoryRegion *mr = NULL;
     int reg = TO_REG(offset);
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
@@ -1050,6 +1057,37 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
         data &= ~AST2700_SSP_TSP_ENABLE;
         s->regs[reg] = (s->regs[reg] & ~0xff) | (data & 0xff);
         return;
+    case AST2700_SCU_SSP_CTRL_1:
+    case AST2700_SCU_SSP_CTRL_2:
+        mr = (reg == AST2700_SCU_SSP_CTRL_1) ?
+            &s->dram_remap_alias[0] : &s->dram_remap_alias[1];
+        if (s->ssp_cpuid < 0 || mr == NULL) {
+            return;
+        }
+        data &= 0x7fffffff;
+        memory_region_set_alias_offset(mr,
+                                       ((uint64_t) data << 4) & 0x3ffffffff);
+        break;
+    case AST2700_SCU_SSP_REMAP_ADDR_1:
+    case AST2700_SCU_SSP_REMAP_ADDR_2:
+        mr = (reg == AST2700_SCU_SSP_REMAP_ADDR_1) ?
+            &s->dram_remap_alias[0] : &s->dram_remap_alias[1];
+        if (s->ssp_cpuid < 0 || mr == NULL) {
+            return;
+        }
+        data &= 0x3fffffff;
+        memory_region_set_address(mr, data);
+        break;
+    case AST2700_SCU_SSP_REMAP_SIZE_1:
+    case AST2700_SCU_SSP_REMAP_SIZE_2:
+        mr = (reg == AST2700_SCU_SSP_REMAP_SIZE_1) ?
+            &s->dram_remap_alias[0] : &s->dram_remap_alias[1];
+        if (s->ssp_cpuid < 0 || mr == NULL) {
+            return;
+        }
+        data &= 0x3fffffff;
+        memory_region_set_size(mr, data);
+        break;
     case AST2700_SCU_SYS_RST_CTRL_1:
         if (s->ssp_cpuid < 0) {
             return;
@@ -1120,6 +1158,12 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
     [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
     [AST2700_SCU_SSP_CTRL_0]        = 0x000007FE,
+    [AST2700_SCU_SSP_CTRL_1]        = 0x40000000,
+    [AST2700_SCU_SSP_CTRL_2]        = 0x42C00000,
+    [AST2700_SCU_SSP_REMAP_ADDR_1]  = 0x02000000,
+    [AST2700_SCU_SSP_REMAP_SIZE_1]  = 0x02000000,
+    [AST2700_SCU_SSP_REMAP_ADDR_2]  = 0x00000000,
+    [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_TSP_CTRL_0]        = 0x000007FE,
     [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
     [AST2700_SCU_SYS_RST_CTRL_2]    = 0x00001FFF,
@@ -1151,6 +1195,12 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
 
     if (s->ssp_cpuid > 0) {
         arm_set_cpu_off(s->ssp_cpuid);
+        memory_region_set_address(&s->dram_remap_alias[0], 32 * MiB);
+        memory_region_set_alias_offset(&s->dram_remap_alias[0], 0);
+        memory_region_set_size(&s->dram_remap_alias[0], 32 * MiB);
+        memory_region_set_address(&s->dram_remap_alias[1], 0);
+        memory_region_set_alias_offset(&s->dram_remap_alias[1], 0x2c000000);
+        memory_region_set_size(&s->dram_remap_alias[1], 32 * MiB);
     }
 
     if (s->tsp_cpuid > 0) {
-- 
2.43.0


