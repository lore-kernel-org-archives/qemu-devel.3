Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E90C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 03:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFY5-00080j-4r; Wed, 16 Jul 2025 23:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVf-0003tb-De; Wed, 16 Jul 2025 23:42:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFVZ-0000g2-4H; Wed, 16 Jul 2025 23:42:15 -0400
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
Subject: [PATCH v1 17/21] hw/misc/aspeed_scu: Implement SSP reset and power-on
 control via SCU registers
Date: Thu, 17 Jul 2025 11:40:45 +0800
Message-ID: <20250717034054.1903991-18-jamin_lin@aspeedtech.com>
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

This patch implements SSP reset and power control logic in the SCU for AST2700.
It introduces support for the following behavior:

1. SSP Reset Trigger (via SCU 0x220):
   - SSP reset is triggered by writing 1 to bit 30 (RW1S) of SYS_RESET_CTRL_1.

2. SSP Reset State and Source Hold (via SCU 0x120):
   - Upon reset, bit 8 (RST_RB) is set to indicate the SSP is in reset.
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an external source.
   - Bit 1 (RST) is a software-controlled bit used to request holding SSP in reset.
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HOLD_RB)
     will also be asserted to indicate the SSP is being held in reset.
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.

3. Hold Release and Power-on:
   - If RST_HOLD_RB is clear (0), SSP is powered on immediately after reset is deasserted.
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to SSP_CTRL_0 to release
     the hold and power on SSP explicitly.
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear after execution.

4. Reset Status Clear (via SCU 0x204):
   - The reset status can be cleared by writing 1 to bit 30 (RW1C) of SYS_RST_CLR_1,
     which will deassert RST_SRC_RB and potentially trigger power-on if no hold is active.

5. SSP Power Control Logic:
   - `handle_ssp_tsp_on()` clears RST_SRC_RB and RST_RB (if not held), and invokes
     `arm_set_cpu_on_and_reset(cpuid)` to power on the SSP core (CPUID 4).
   - `handle_ssp_tsp_off()` sets RST_RB and RST_SRC_RB; if RST is active, also asserts
     RST_HOLD_RB and invokes `arm_set_cpu_off(cpuid)`.

6. Register Initialization and Definitions:
   - Adds SCU register definitions for SSP_CTRL_0 (0x120), SYS_RST_CTRL_1 (0x220),
     and SYS_RST_CLR_1 (0x204).
   - Updates the reset values for these registers during SCU initialization.

The default values are based on EVB (evaluation board) register dump observations.
This patch enables proper modeling of SSP lifecycle management across reset,
hold, and power-on states for the AST2700 SoC.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_scu.c | 94 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 21a0d1ad5c..50f3f6ff17 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -20,6 +20,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "target/arm/arm-powerctl.h"
 
 #define TO_REG(offset) ((offset) >> 2)
 
@@ -144,6 +145,7 @@
 #define AST2700_HW_STRAP1_SEC3    TO_REG(0x2C)
 
 /* SSP TSP */
+#define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)
 #define AST2700_SCU_SSP_CTRL_1          TO_REG(0x124)
 #define AST2700_SCU_SSP_CTRL_2          TO_REG(0x128)
 #define AST2700_SCU_SSP_REMAP_ADDR_1    TO_REG(0x148)
@@ -152,6 +154,14 @@
 #define AST2700_SCU_SSP_REMAP_SIZE_2    TO_REG(0x154)
 #define AST2700_SCU_TSP_CTRL_1          TO_REG(0x168)
 #define AST2700_SCU_TSP_REMAP_SIZE_2    TO_REG(0x194)
+#define AST2700_SSP_TSP_ENABLE          BIT(0)
+#define AST2700_SSP_TSP_RST             BIT(1)
+#define AST2700_SSP_TSP_RST_RB          BIT(8)
+#define AST2700_SSP_TSP_RST_HOLD_RB     BIT(9)
+#define AST2700_SSP_TSP_RST_SRC_RB      BIT(10)
+#define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)
+#define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)
+#define AST2700_SCU_SYS_RST_SSP         BIT(30)
 
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
@@ -911,6 +921,35 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, hwaddr offset,
     return s->regs[reg];
 }
 
+static void handle_ssp_tsp_on(struct AspeedSCUState *s, int cpuid)
+{
+    int reg = AST2700_SCU_SSP_CTRL_0;
+    uint32_t val = s->regs[reg];
+
+    val &= ~AST2700_SSP_TSP_RST_SRC_RB;
+    if (!(val & AST2700_SSP_TSP_RST_HOLD_RB)) {
+        val &= ~AST2700_SSP_TSP_RST_RB;
+        arm_set_cpu_on_and_reset(cpuid);
+    }
+
+    s->regs[reg] = val;
+}
+
+static void handle_ssp_tsp_off(struct AspeedSCUState *s, int cpuid)
+{
+    int reg = AST2700_SCU_SSP_CTRL_0;
+    uint32_t val = s->regs[reg];
+
+    val |= AST2700_SSP_TSP_RST_RB;
+    val |= AST2700_SSP_TSP_RST_SRC_RB;
+    if (val & AST2700_SSP_TSP_RST) {
+        val |= AST2700_SSP_TSP_RST_HOLD_RB;
+    }
+    arm_set_cpu_off(cpuid);
+
+    s->regs[reg] = val;
+}
+
 static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
                                      uint64_t data64, unsigned size)
 {
@@ -919,6 +958,9 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
     /* Truncate here so bitwise operations below behave as expected */
     uint32_t data = data64;
     MemoryRegion *mr;
+    uint32_t active;
+    uint32_t oldval;
+    int cpuid;
 
     if (reg >= ASPEED_AST2700_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -930,6 +972,40 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
     trace_aspeed_ast2700_scu_write(offset, size, data);
 
     switch (reg) {
+    case AST2700_SCU_SSP_CTRL_0:
+        cpuid = 4;
+        oldval = s->regs[reg];
+        data &= 0xff;
+        active = oldval ^ data;
+
+        /*
+         * If reset bit is being released (1 -> 0) and no other reset source
+         * is active, clear HOLD_RB and power on the corresponding CPU.
+         */
+        if ((active & AST2700_SSP_TSP_RST) && !(data & AST2700_SSP_TSP_RST)) {
+            s->regs[reg] &= ~AST2700_SSP_TSP_RST_HOLD_RB;
+            if ((oldval & AST2700_SSP_TSP_RST_RB) &&
+                !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {
+                handle_ssp_tsp_on(s, cpuid);
+            }
+        }
+
+        /*
+         * If ENABLE bit is newly set and reset state is ready,
+         * clear HOLD_RB and power on the corresponding CPU.
+         */
+        if ((active & AST2700_SSP_TSP_ENABLE) &&
+            (oldval & AST2700_SSP_TSP_RST_RB) &&
+            (oldval & AST2700_SSP_TSP_RST_HOLD_RB) &&
+            !(oldval & AST2700_SSP_TSP_RST_SRC_RB)) {
+                s->regs[reg] &= ~AST2700_SSP_TSP_RST_HOLD_RB;
+                handle_ssp_tsp_on(s, cpuid);
+        }
+
+        /* Auto-clear the ENABLE bit (one-shot behavior) */
+        data &= ~AST2700_SSP_TSP_ENABLE;
+        s->regs[reg] = (s->regs[reg] & ~0xff) | (data & 0xff);
+        return;
     case AST2700_SCU_SSP_CTRL_1:
     case AST2700_SCU_SSP_CTRL_2:
         mr = (reg == AST2700_SCU_SSP_CTRL_1) ?
@@ -976,6 +1052,22 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
         data &= 0x3fffffff;
         memory_region_set_size(s->tsp_sdram_remap, data);
         break;
+    case AST2700_SCU_SYS_RST_CTRL_1:
+        oldval = s->regs[reg];
+        active = data & ~oldval;
+        if (active & AST2700_SCU_SYS_RST_SSP) {
+            handle_ssp_tsp_off(s, 4);
+        }
+        s->regs[reg] |= active;
+        return;
+    case AST2700_SCU_SYS_RST_CLR_1:
+        oldval = s->regs[AST2700_SCU_SYS_RST_CTRL_1];
+        active = data & oldval;
+        if (active & AST2700_SCU_SYS_RST_SSP) {
+            handle_ssp_tsp_on(s, 4);
+        }
+        s->regs[AST2700_SCU_SYS_RST_CTRL_1] &= ~active;
+        return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
@@ -1003,6 +1095,7 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_HW_STRAP1_SEC1]        = 0x000000FF,
     [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
     [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
+    [AST2700_SCU_SSP_CTRL_0]        = 0x000007FE,
     [AST2700_SCU_SSP_CTRL_1]        = 0x40000000,
     [AST2700_SCU_SSP_CTRL_2]        = 0x42C00000,
     [AST2700_SCU_SSP_REMAP_ADDR_1]  = 0x02000000,
@@ -1011,6 +1104,7 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCU_SSP_REMAP_SIZE_2]  = 0x02000000,
     [AST2700_SCU_TSP_CTRL_1]        = 0x42E00000,
     [AST2700_SCU_TSP_REMAP_SIZE_2]  = 0x02000000,
+    [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
     [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
     [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
     [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
-- 
2.43.0


