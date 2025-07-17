Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A778FC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFYC-0008Ny-V7; Wed, 16 Jul 2025 23:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVi-0003yV-Qd; Wed, 16 Jul 2025 23:42:20 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVg-0000g2-T0; Wed, 16 Jul 2025 23:42:18 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:41:01 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:41:01 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 18/21] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Date: Thu, 17 Jul 2025 11:40:46 +0800
Message-ID: <20250717034054.1903991-19-jamin_lin@aspeedtech.com>
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

This patch implements TSP reset and power control logic in the SCU module
for AST2700. It introduces support for the following behavior:

1. TSP Reset Trigger (via SCU 0x224):

   - TSP reset is triggered by writing 1 to bit 9 (RW1S) of SYS_RESET_CTRL_2.

2. TSP Reset State and Source Hold (via SCU 0x160):

   - Upon reset, bit 8 (RST_RB) is set to indicate the TSP is in reset.
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an external source.
   - Bit 1 (RST) is a software-controlled bit used to request holding TSP in reset.
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HOLD_RB)
     will also be asserted to indicate the TSP is being held in reset.
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.

3. Hold Release and Power-on:

   - If RST_HOLD_RB is clear (0), TSP is powered on immediately after reset is deasserted.
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to TSP_CTRL_0 to release
     the hold and power on TSP explicitly.
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear after execution.

4. Reset Status Clear (via SCU 0x224):

   - The reset status can be cleared by writing 1 to bit 9 (RW1C) of SYS_RST_CLR_2,
     which will deassert RST_SRC_RB and potentially trigger power-on if no hold is active.

5. TSP Power Control Logic:

   - handle_ssp_tsp_on() clears RST_SRC_RB and RST_RB (if not held), and invokes
     arm_set_cpu_on_and_reset(cpuid) to power on the TSP core (CPUID 5).
   - handle_ssp_tsp_off() sets RST_RB and RST_SRC_RB; if RST is active, also asserts
     RST_HOLD_RB and invokes arm_set_cpu_off(cpuid).

The default values are based on EVB (evaluation board) register dump observations.
TSP reset control shares the same helper functions and register bit layout as SSP,
with logic selected by cpuid and distinct external reset sources.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_scu.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 50f3f6ff17..ee31a9aabd 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -152,6 +152,7 @@
 #define AST2700_SCU_SSP_REMAP_SIZE_1    TO_REG(0x14c)
 #define AST2700_SCU_SSP_REMAP_ADDR_2    TO_REG(0x150)
 #define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)
 #define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)
 #define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)
 #define AST2700_SSP_TSP_ENABLE          BIT(0)
@@ -162,6 +163,9 @@
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)
 
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
@@ -923,7 +927,7 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
 
 static void handle_ssp_tsp_on(struct AspeedSCUState *s, int cpuid)
 {
-    int reg = AST2700_SCU_SSP_CTRL_0;
+    int reg = (cpuid == 4) ? AST2700_SCU_SSP_CTRL_0 : AST2700_SCU_TSP_CTRL_0;
     uint32_t val = s->regs[reg];
 
     val &= ~AST2700_SSP_TSP_RST_SRC_RB;
@@ -937,7 +941,7 @@ static void handle_ssp_tsp_on(struct AspeedSCUState *s, int cpuid)
 
 static void handle_ssp_tsp_off(struct AspeedSCUState *s, int cpuid)
 {
-    int reg = AST2700_SCU_SSP_CTRL_0;
+    int reg = (cpuid == 4) ? AST2700_SCU_SSP_CTRL_0 : AST2700_SCU_TSP_CTRL_0;
     uint32_t val = s->regs[reg];
 
     val |= AST2700_SSP_TSP_RST_RB;
@@ -973,7 +977,8 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
 
     switch (reg) {
     case AST2700_SCU_SSP_CTRL_0:
-        cpuid = 4;
+    case AST2700_SCU_TSP_CTRL_0:
+        cpuid = (reg == AST2700_SCU_SSP_CTRL_0) ? 4 : 5;
         oldval = s->regs[reg];
         data &= 0xff;
         active = oldval ^ data;
@@ -1068,6 +1073,24 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
         }
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &= ~active;
         return;
+    case AST2700_SCU_SYS_RST_CTRL_2:
+        data &= 0x00001fff;
+        oldval = s->regs[reg];
+        active = data & ~oldval;
+        if (data & AST2700_SCU_SYS_RST_TSP) {
+            handle_ssp_tsp_off(s, 5);
+        }
+        s->regs[reg] |= data;
+        return;
+    case AST2700_SCU_SYS_RST_CLR_2:
+        data &= 0x00001fff;
+        oldval = s->regs[AST2700_SCU_SYS_RST_CTRL_2];
+        active = data & oldval;
+        if (active & AST2700_SCU_SYS_RST_TSP) {
+            handle_ssp_tsp_on(s, 5);
+        }
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &= ~active;
+        return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
@@ -1102,9 +1125,11 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCU_SSP_REMAP_SIZE_1]  = 0x02000000,
     [AST2700_SCU_SSP_REMAP_ADDR_2]  = 0x00000000,
     [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x02000000,
+    [AST2700_SCU_TSP_CTRL_0]        = 0x000007FE,
     [AST2700_SCU_TSP_CTRL_1]        = 0x42E00000,
     [AST2700_SCU_TSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
+    [AST2700_SCU_SYS_RST_CTRL_2]    = 0x00001FFF,
     [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
     [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
     [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
-- 
2.43.0


