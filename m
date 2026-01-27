Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2FCD13C1B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfPV-0004cB-VS; Tue, 27 Jan 2026 04:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfPT-0004SJ-KH; Tue, 27 Jan 2026 04:30:56 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vkfPS-0005A1-3J; Tue, 27 Jan 2026 04:30:55 -0500
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
Subject: [PATCH v2 09/11] hw/misc/aspeed_scu: Add SCU support for TSP SDRAM
 remap
Date: Tue, 27 Jan 2026 17:29:38 +0800
Message-ID: <20260127092943.3731635-10-jamin_lin@aspeedtech.com>
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

This commit adds SCU register support for TSP SDRAM remap control and runtime
activation. Unlike SSP, the TSP does not support configurable target address remapping
through SCU registers. It only supports setting the PSP DRAM base and size, which
are then aliased into the TSP-visible SDRAM window.

coprocessor_sdram_remap[2]: maps PSP DRAM offset 0x42E000000 (size: 32MB) to TSP SDRAM
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

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_scu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 333fa964d3..a551063c03 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -159,6 +159,8 @@
 #define AST2700_SSP_TSP_RST_RB          BIT(8)
 #define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)
 #define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)
+#define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)
+#define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)
@@ -1088,6 +1090,23 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
         data &= 0x3fffffff;
         memory_region_set_size(mr, data);
         break;
+    case AST2700_SCU_TSP_CTRL_1:
+        mr = &s->dram_remap_alias[2];
+        if (s->tsp_cpuid < 0 || mr == NULL) {
+            return;
+        }
+        data &= 0x7fffffff;
+        memory_region_set_alias_offset(mr,
+                                       ((uint64_t) data << 4) & 0x3ffffffff);
+        break;
+    case AST2700_SCU_TSP_REMAP_SIZE_2:
+        mr = &s->dram_remap_alias[2];
+        if (s->tsp_cpuid < 0 || mr == NULL) {
+            return;
+        }
+        data &= 0x3fffffff;
+        memory_region_set_size(mr, data);
+        break;
     case AST2700_SCU_SYS_RST_CTRL_1:
         if (s->ssp_cpuid < 0) {
             return;
@@ -1165,6 +1184,8 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCU_SSP_REMAP_ADDR_2]  = 0x00000000,
     [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_TSP_CTRL_0]        = 0x000007FE,
+    [AST2700_SCU_TSP_CTRL_1]        = 0x42E00000,
+    [AST2700_SCU_TSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
     [AST2700_SCU_SYS_RST_CTRL_2]    = 0x00001FFF,
     [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
@@ -1205,6 +1226,8 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
 
     if (s->tsp_cpuid > 0) {
         arm_set_cpu_off(s->tsp_cpuid);
+        memory_region_set_alias_offset(&s->dram_remap_alias[2], 0x2e000000);
+        memory_region_set_size(&s->dram_remap_alias[2], 32 * MiB);
     }
 }
 
-- 
2.43.0


