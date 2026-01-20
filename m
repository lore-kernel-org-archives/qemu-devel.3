Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B576D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi83t-0003nL-DZ; Tue, 20 Jan 2026 04:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vi83r-0003hA-G4; Tue, 20 Jan 2026 04:30:07 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vi83o-0005eG-Vq; Tue, 20 Jan 2026 04:30:06 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Jan
 2026 17:29:41 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Jan 2026 17:29:41 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 07/11] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Date: Tue, 20 Jan 2026 17:29:32 +0800
Message-ID: <20260120092939.2708302-8-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
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

This patch implements TSP reset and power control logic in the SCU module
for AST2700. It introduces support for the following behavior:

1. TSP Reset Trigger (via SCU 0x220):

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
 hw/misc/aspeed_scu.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 506a4fa73f..6aebdd630f 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -147,6 +147,7 @@
 
 /* SSP TSP */
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)
 #define AST2700_SSP_TSP_ENABLE          BIT(0)
 #define AST2700_SSP_TSP_RST             BIT(1)
 #define AST2700_SSP_TSP_RST_RB          BIT(8)
@@ -155,6 +156,9 @@
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)
 
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)
@@ -1007,7 +1011,10 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
 
     switch (reg) {
     case AST2700_SCU_SSP_CTRL_0:
-        cpuid = s->ssp_cpuid;
+    case AST2700_SCU_TSP_CTRL_0:
+        cpuid = (reg == AST2700_SCU_SSP_CTRL_0) ?
+                s->ssp_cpuid : s->tsp_cpuid;
+
         if (cpuid < 0) {
             return;
         }
@@ -1063,6 +1070,28 @@ static void aspeed_ast2700_scu_write(void *opaque, hwaddr offset,
         }
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &= ~active;
         return;
+    case AST2700_SCU_SYS_RST_CTRL_2:
+        if (s->tsp_cpuid < 0) {
+            return;
+        }
+        data &= 0x00001fff;
+        if (data & AST2700_SCU_SYS_RST_TSP) {
+            handle_2700_ssp_tsp_off(s, s->tsp_cpuid, AST2700_SCU_TSP_CTRL_0);
+        }
+        s->regs[reg] |= data;
+        return;
+    case AST2700_SCU_SYS_RST_CLR_2:
+        if (s->tsp_cpuid < 0) {
+            return;
+        }
+        data &= 0x00001fff;
+        oldval = s->regs[AST2700_SCU_SYS_RST_CTRL_2];
+        active = data & oldval;
+        if (active & AST2700_SCU_SYS_RST_TSP) {
+            handle_2700_ssp_tsp_on(s, s->tsp_cpuid, AST2700_SCU_TSP_CTRL_0);
+        }
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &= ~active;
+        return;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n",
@@ -1091,7 +1120,9 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_HW_STRAP1_SEC2]        = 0x00000000,
     [AST2700_HW_STRAP1_SEC3]        = 0x1000408F,
     [AST2700_SCU_SSP_CTRL_0]        = 0x000007FE,
+    [AST2700_SCU_TSP_CTRL_0]        = 0x000007FE,
     [AST2700_SCU_SYS_RST_CTRL_1]    = 0xFFC37FDC,
+    [AST2700_SCU_SYS_RST_CTRL_2]    = 0x00001FFF,
     [AST2700_SCU_HPLL_PARAM]        = 0x0000009f,
     [AST2700_SCU_HPLL_EXT_PARAM]    = 0x8000004f,
     [AST2700_SCU_DPLL_PARAM]        = 0x0080009f,
@@ -1121,6 +1152,10 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
     if (s->ssp_cpuid > 0) {
         arm_set_cpu_off(s->ssp_cpuid);
     }
+
+    if (s->tsp_cpuid > 0) {
+        arm_set_cpu_off(s->tsp_cpuid);
+    }
 }
 
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
-- 
2.43.0


