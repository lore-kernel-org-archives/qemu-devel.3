Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5102BC282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2XW-0000vx-6E; Mon, 03 Mar 2025 04:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2Wk-00083d-B9; Mon, 03 Mar 2025 04:56:00 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2Wi-0001vN-9C; Mon, 03 Mar 2025 04:55:58 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 3 Mar
 2025 17:55:03 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 3 Mar 2025 17:55:03 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v4 14/23] hw/intc/aspeed: Add Support for Multi-Output IRQ
 Handling
Date: Mon, 3 Mar 2025 17:54:42 +0800
Message-ID: <20250303095457.2337631-15-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This update introduces support for handling multi-output IRQs in the AST2700
interrupt controller (INTC), specifically for GICINT192_201. GICINT192_201 maps
1:10 to input IRQ 0 and output IRQs 0 to 9. Each status bit corresponds to a
specific IRQ.

Implemented "aspeed_intc_set_irq_handler_multi_outpins" to handle IRQs with
multiple output pins. Introduced "aspeed_intc_status_handler_multi_outpins"
for managing status registers associated with multi-output IRQs.

Added new IRQ definitions for GICINT192_201 in INTC.
Adjusted the IRQ array to accommodate 10 input pins and 19 output pins,
aligning with the new GICINT192_201 mappings.

                   |------------------------------|
                   |            INTC              |
                   |inpin[0:0]--------->outpin[0] |
                   |inpin[0:1]--------->outpin[1] |
                   |inpin[0:2]--------->outpin[2] |
                   |inpin[0:3]--------->outpin[3] |
orgates[0]-------> |inpin[0:4]--------->outpin[4] |
                   |inpin[0:5]--------->outpin[5] |
                   |inpin[0:6]--------->outpin[6] |
                   |inpin[0:7]--------->outpin[7] |
                   |inpin[0:8]--------->outpin[8] |
                   |inpin[0:9]--------->outpin[9] |
                   |                              |
 orgates[1]------> |inpin[1]----------->outpin[10]|
 orgates[2]------> |inpin[2]----------->outpin[11]|
 orgates[3]------> |inpin[3]----------->outpin[12]|
 orgates[4]------> |inpin[4]----------->outpin[13]|
 orgates[5]------> |inpin[5]----------->outpin[14]|
 orgates[6]------> |inpin[6]----------->outpin[15]|
 orgates[7]------> |inpin[7]----------->outpin[16]|
 orgates[8]------> |inpin[8]----------->outpin[17]|
 orgates[9]------> |inpin[9]----------->outpin[18]|
                   |------------------------------|

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/intc/aspeed_intc.h |   6 +-
 hw/intc/aspeed_intc.c         | 144 ++++++++++++++++++++++++++++++----
 hw/intc/trace-events          |   1 +
 3 files changed, 133 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 112a01f402..21d9398933 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -16,9 +16,9 @@
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
-#define ASPEED_INTC_NR_REGS (0x808 >> 2)
-#define ASPEED_INTC_MAX_INPINS 9
-#define ASPEED_INTC_MAX_OUTPINS 9
+#define ASPEED_INTC_NR_REGS (0xB08 >> 2)
+#define ASPEED_INTC_MAX_INPINS 10
+#define ASPEED_INTC_MAX_OUTPINS 19
 
 typedef struct AspeedINTCIRQ {
     int inpin_idx;
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 99077ec72d..18521d3eb0 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -39,6 +39,8 @@ REG32(GICINT135_EN,         0x700)
 REG32(GICINT135_STATUS,     0x704)
 REG32(GICINT136_EN,         0x800)
 REG32(GICINT136_STATUS,     0x804)
+REG32(GICINT192_201_EN,         0xB00)
+REG32(GICINT192_201_STATUS,     0xB04)
 
 static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
                                                 uint32_t addr)
@@ -117,9 +119,48 @@ static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
     }
 }
 
+static void aspeed_intc_set_irq_handler_multi_outpins(AspeedINTCState *s,
+                                 const AspeedINTCIRQ *intc_irq, uint32_t select)
+{
+    const char *name = object_get_typename(OBJECT(s));
+    int i;
+
+    for (i = 0; i < intc_irq->num_outpins; i++) {
+        if (select & BIT(i)) {
+            if (s->mask[intc_irq->inpin_idx] & BIT(i) ||
+                s->regs[intc_irq->status_addr] & BIT(i)) {
+                /*
+                 * a. mask bit is not 0 means in ISR mode sources interrupt
+                 * routine are executing.
+                 * b. status bit is not 0 means previous source interrupt
+                 * does not be executed, yet.
+                 *
+                 * save source interrupt to pending bit.
+                 */
+                 s->pending[intc_irq->inpin_idx] |= BIT(i);
+                 trace_aspeed_intc_pending_irq(name, intc_irq->inpin_idx,
+                                               s->pending[intc_irq->inpin_idx]);
+            } else {
+                /*
+                 * notify firmware which source interrupt are coming
+                 * by setting status bit
+                 */
+                s->regs[intc_irq->status_addr] |= BIT(i);
+                trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
+                                              intc_irq->outpin_idx + i,
+                                              s->regs[intc_irq->status_addr]);
+                aspeed_intc_update(s, intc_irq->inpin_idx,
+                                   intc_irq->outpin_idx + i, 1);
+            }
+        }
+    }
+}
+
 /*
- * GICINT128 to GICINT136 map 1:1 to input and output IRQs 0 to 8.
- * The value of input IRQ should be between 0 and the number of inputs.
+ * GICINT192_201 maps 1:10 to input IRQ 0 and output IRQs 0 to 9.
+ * GICINT128 to GICINT136 map 1:1 to input IRQs 1 to 9 and output
+ * IRQs 10 to 18. The value of input IRQ should be between 0 and
+ * the number of input pins.
  */
 static void aspeed_intc_set_irq(void *opaque, int irq, int level)
 {
@@ -158,7 +199,11 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     }
 
     trace_aspeed_intc_select(name, select);
-    aspeed_intc_set_irq_handler(s, intc_irq, select);
+    if (intc_irq->num_outpins > 1) {
+        aspeed_intc_set_irq_handler_multi_outpins(s, intc_irq, select);
+    } else {
+        aspeed_intc_set_irq_handler(s, intc_irq, select);
+    }
 }
 
 static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
@@ -274,6 +319,70 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
     }
 }
 
+static void aspeed_intc_status_handler_multi_outpins(AspeedINTCState *s,
+                                                hwaddr offset, uint64_t data)
+{
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    const char *name = object_get_typename(OBJECT(s));
+    const AspeedINTCIRQ *intc_irq;
+    uint32_t addr = offset >> 2;
+    int i;
+
+    if (!data) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid data 0\n", __func__);
+        return;
+    }
+
+    intc_irq = aspeed_intc_get_irq(aic, addr);
+
+    if (intc_irq->inpin_idx >= aic->num_inpins) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Invalid input pin index: %d\n",
+                      __func__,  intc_irq->inpin_idx);
+        return;
+    }
+
+    /* clear status */
+    s->regs[addr] &= ~data;
+
+    /*
+     * The status registers are used for notify sources ISR are executed.
+     * If one source ISR is executed, it will clear one bit.
+     * If it clear all bits, it means to initialize this register status
+     * rather than sources ISR are executed.
+     */
+    if (data == 0xffffffff) {
+        return;
+    }
+
+    for (i = 0; i < intc_irq->num_outpins; i++) {
+        /* All source ISR executions are done from a specific bit */
+        if (data & BIT(i)) {
+            trace_aspeed_intc_all_isr_done_bit(name, intc_irq->inpin_idx, i);
+            if (s->pending[intc_irq->inpin_idx] & BIT(i)) {
+                /*
+                 * Handle pending source interrupt.
+                 * Notify firmware which source interrupt is pending
+                 * by setting the status bit.
+                 */
+                s->regs[addr] |= BIT(i);
+                s->pending[intc_irq->inpin_idx] &= ~BIT(i);
+                trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
+                                              intc_irq->outpin_idx + i,
+                                              s->regs[addr]);
+                aspeed_intc_update(s, intc_irq->inpin_idx,
+                                   intc_irq->outpin_idx + i, 1);
+            } else {
+                /* clear irq for the specific bit */
+                trace_aspeed_intc_clear_irq(name, intc_irq->inpin_idx,
+                                            intc_irq->outpin_idx + i, 0);
+                aspeed_intc_update(s, intc_irq->inpin_idx,
+                                   intc_irq->outpin_idx + i, 0);
+            }
+        }
+    }
+}
+
 static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
@@ -322,6 +431,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     case R_GICINT134_EN:
     case R_GICINT135_EN:
     case R_GICINT136_EN:
+    case R_GICINT192_201_EN:
         aspeed_intc_enable_handler(s, offset, data);
         break;
     case R_GICINT128_STATUS:
@@ -335,6 +445,9 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     case R_GICINT136_STATUS:
         aspeed_intc_status_handler(s, offset, data);
         break;
+    case R_GICINT192_201_STATUS:
+        aspeed_intc_status_handler_multi_outpins(s, offset, data);
+        break;
     default:
         s->regs[addr] = data;
         break;
@@ -433,15 +546,16 @@ static const TypeInfo aspeed_intc_info = {
 };
 
 static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
-    {0, 0, 1, R_GICINT128_EN, R_GICINT128_STATUS},
-    {1, 1, 1, R_GICINT129_EN, R_GICINT129_STATUS},
-    {2, 2, 1, R_GICINT130_EN, R_GICINT130_STATUS},
-    {3, 3, 1, R_GICINT131_EN, R_GICINT131_STATUS},
-    {4, 4, 1, R_GICINT132_EN, R_GICINT132_STATUS},
-    {5, 5, 1, R_GICINT133_EN, R_GICINT133_STATUS},
-    {6, 6, 1, R_GICINT134_EN, R_GICINT134_STATUS},
-    {7, 7, 1, R_GICINT135_EN, R_GICINT135_STATUS},
-    {8, 8, 1, R_GICINT136_EN, R_GICINT136_STATUS},
+    {0, 0, 10, R_GICINT192_201_EN, R_GICINT192_201_STATUS},
+    {1, 10, 1, R_GICINT128_EN, R_GICINT128_STATUS},
+    {2, 11, 1, R_GICINT129_EN, R_GICINT129_STATUS},
+    {3, 12, 1, R_GICINT130_EN, R_GICINT130_STATUS},
+    {4, 13, 1, R_GICINT131_EN, R_GICINT131_STATUS},
+    {5, 14, 1, R_GICINT132_EN, R_GICINT132_STATUS},
+    {6, 15, 1, R_GICINT133_EN, R_GICINT133_STATUS},
+    {7, 16, 1, R_GICINT134_EN, R_GICINT134_STATUS},
+    {8, 17, 1, R_GICINT135_EN, R_GICINT135_STATUS},
+    {9, 18, 1, R_GICINT136_EN, R_GICINT136_STATUS},
 };
 
 static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
@@ -451,10 +565,10 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
 
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
-    aic->num_inpins = 9;
-    aic->num_outpins = 9;
+    aic->num_inpins = 10;
+    aic->num_outpins = 19;
     aic->mem_size = 0x4000;
-    aic->reg_size = 0x808;
+    aic->reg_size = 0xB08;
     aic->reg_offset = 0x1000;
     aic->irq_table = aspeed_2700_intc_irqs;
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc_irqs);
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index e97eea820b..913197a181 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -92,6 +92,7 @@ aspeed_intc_enable(const char *s, uint32_t value) "%s: Enable: 0x%x"
 aspeed_intc_select(const char *s, uint32_t value) "%s: Select: 0x%x"
 aspeed_intc_mask(const char *s, uint32_t change, uint32_t value) "%s: Mask: 0x%x: 0x%x"
 aspeed_intc_unmask(const char *s, uint32_t change, uint32_t value) "%s: UnMask: 0x%x: 0x%x"
+aspeed_intc_all_isr_done_bit(const char *s, int inpin_idx, int bit) "%s: All source ISR execution are done from specific bit: %d-%d"
 
 # arm_gic.c
 gic_enable_irq(int irq) "irq %d enabled"
-- 
2.34.1


