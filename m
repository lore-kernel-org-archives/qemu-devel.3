Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1662DC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:06:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8K9-0006yO-D1; Tue, 21 Jan 2025 02:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8K6-0006sp-8N; Tue, 21 Jan 2025 02:05:19 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8K4-0001eA-8i; Tue, 21 Jan 2025 02:05:18 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:27 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:27 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 09/18] hw/intc/aspeed: Add ID to trace events for better
 debugging
Date: Tue, 21 Jan 2025 15:04:15 +0800
Message-ID: <20250121070424.2465942-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
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

Currently, it is difficult to recognize whether these trace events are from
INTC0 or INTC1. To make these trace events more readable, add an ID to the
INTC trace events.
Updated trace events to include the "id" field for better identification.
Updated the "AspeedINTCClass" structure to include an "id" field.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c         | 45 ++++++++++++++++++++---------------
 hw/intc/trace-events          | 26 ++++++++++----------
 include/hw/intc/aspeed_intc.h |  1 +
 3 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 2f704d6cd2..c3b51cec6d 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -90,13 +90,15 @@ static void aspeed_intc_update(AspeedINTCState *s, int inpin_idx,
         return;
     }
 
-    trace_aspeed_intc_update_irq(inpin_idx, outpin_idx, level);
+    trace_aspeed_intc_update_irq(aic->id, inpin_idx, outpin_idx, level);
     qemu_set_irq(s->output_pins[outpin_idx], level);
 }
 
 static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
                             const AspeedINTCIRQ *irq, uint32_t select)
 {
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+
     if (s->mask[irq->inpin_idx] || s->regs[irq->status_addr]) {
         /*
          * a. mask is not 0 means in ISR mode
@@ -107,7 +109,7 @@ static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
          * save source interrupt to pending variable.
          */
         s->pending[irq->inpin_idx] |= select;
-        trace_aspeed_intc_pending_irq(irq->inpin_idx,
+        trace_aspeed_intc_pending_irq(aic->id, irq->inpin_idx,
                                       s->pending[irq->inpin_idx]);
     } else {
         /*
@@ -115,7 +117,8 @@ static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
          * by setting status register
          */
         s->regs[irq->status_addr] = select;
-        trace_aspeed_intc_trigger_irq(irq->inpin_idx, irq->outpin_idx,
+        trace_aspeed_intc_trigger_irq(aic->id, irq->inpin_idx,
+                                      irq->outpin_idx,
                                       s->regs[irq->status_addr]);
         aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx, 1);
     }
@@ -124,6 +127,7 @@ static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
 static void aspeed_intc_set_irq_handler_multi_outpins(AspeedINTCState *s,
                                      const AspeedINTCIRQ *irq, uint32_t select)
 {
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     int i;
 
     for (i = 0; i < irq->num_outpins; i++) {
@@ -139,7 +143,7 @@ static void aspeed_intc_set_irq_handler_multi_outpins(AspeedINTCState *s,
                  * save source interrupt to pending bit.
                  */
                  s->pending[irq->inpin_idx] |= BIT(i);
-                 trace_aspeed_intc_pending_irq(irq->inpin_idx,
+                 trace_aspeed_intc_pending_irq(aic->id, irq->inpin_idx,
                                                s->pending[irq->inpin_idx]);
             } else {
                 /*
@@ -147,7 +151,7 @@ static void aspeed_intc_set_irq_handler_multi_outpins(AspeedINTCState *s,
                  * by setting status bit
                  */
                 s->regs[irq->status_addr] |= BIT(i);
-                trace_aspeed_intc_trigger_irq(irq->inpin_idx,
+                trace_aspeed_intc_trigger_irq(aic->id, irq->inpin_idx,
                                               irq->outpin_idx + i,
                                               s->regs[irq->status_addr]);
                 aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx + i, 1);
@@ -180,7 +184,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq_idx, int level)
 
     irq = &aic->irq_table[irq_idx];
 
-    trace_aspeed_intc_set_irq(irq->inpin_idx, level);
+    trace_aspeed_intc_set_irq(aic->id, irq->inpin_idx, level);
     enable = s->enable[irq->inpin_idx];
 
     if (!level) {
@@ -199,7 +203,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq_idx, int level)
         return;
     }
 
-    trace_aspeed_intc_select(select);
+    trace_aspeed_intc_select(aic->id, select);
 
     if (irq->num_outpins > 1) {
         aspeed_intc_set_irq_handler_multi_outpins(s, irq, select);
@@ -242,7 +246,7 @@ static void aspeed_2700_intc_enable_handler(AspeedINTCState *s, uint32_t addr,
 
     /* enable new source interrupt */
     if (old_enable != s->enable[irq->inpin_idx]) {
-        trace_aspeed_intc_enable(s->enable[irq->inpin_idx]);
+        trace_aspeed_intc_enable(aic->id, s->enable[irq->inpin_idx]);
         s->regs[addr] = data;
         return;
     }
@@ -251,10 +255,10 @@ static void aspeed_2700_intc_enable_handler(AspeedINTCState *s, uint32_t addr,
     change = s->regs[addr] ^ data;
     if (change & data) {
         s->mask[irq->inpin_idx] &= ~change;
-        trace_aspeed_intc_unmask(change, s->mask[irq->inpin_idx]);
+        trace_aspeed_intc_unmask(aic->id, change, s->mask[irq->inpin_idx]);
     } else {
         s->mask[irq->inpin_idx] |= change;
-        trace_aspeed_intc_mask(change, s->mask[irq->inpin_idx]);
+        trace_aspeed_intc_mask(aic->id, change, s->mask[irq->inpin_idx]);
     }
     s->regs[addr] = data;
 }
@@ -294,7 +298,7 @@ static void aspeed_2700_intc_status_handler(AspeedINTCState *s, uint32_t addr,
 
     /* All source ISR execution are done */
     if (!s->regs[addr]) {
-        trace_aspeed_intc_all_isr_done(irq->inpin_idx);
+        trace_aspeed_intc_all_isr_done(aic->id, irq->inpin_idx);
         if (s->pending[irq->inpin_idx]) {
             /*
              * handle pending source interrupt
@@ -303,12 +307,13 @@ static void aspeed_2700_intc_status_handler(AspeedINTCState *s, uint32_t addr,
              */
             s->regs[addr] = s->pending[irq->inpin_idx];
             s->pending[irq->inpin_idx] = 0;
-            trace_aspeed_intc_trigger_irq(irq->inpin_idx, irq->outpin_idx,
-                                          s->regs[addr]);
+            trace_aspeed_intc_trigger_irq(aic->id, irq->inpin_idx,
+                                          irq->outpin_idx, s->regs[addr]);
             aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx, 1);
         } else {
             /* clear irq */
-            trace_aspeed_intc_clear_irq(irq->inpin_idx, irq->outpin_idx, 0);
+            trace_aspeed_intc_clear_irq(aic->id, irq->inpin_idx,
+                                        irq->outpin_idx, 0);
             aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx, 0);
         }
     }
@@ -351,7 +356,7 @@ static void aspeed_2700_intc_status_handler_multi_outpins(AspeedINTCState *s,
     for (i = 0; i < irq->num_outpins; i++) {
         /* All source ISR executions are done from a specific bit */
         if (data & BIT(i)) {
-            trace_aspeed_intc_all_isr_done_bit(irq->inpin_idx, i);
+            trace_aspeed_intc_all_isr_done_bit(aic->id, irq->inpin_idx, i);
             if (s->pending[irq->inpin_idx] & BIT(i)) {
                 /*
                  * Handle pending source interrupt.
@@ -360,14 +365,15 @@ static void aspeed_2700_intc_status_handler_multi_outpins(AspeedINTCState *s,
                  */
                 s->regs[addr] |= BIT(i);
                 s->pending[irq->inpin_idx] &= ~BIT(i);
-                trace_aspeed_intc_trigger_irq(irq->inpin_idx,
+                trace_aspeed_intc_trigger_irq(aic->id,
+                                              irq->inpin_idx,
                                               irq->outpin_idx + i,
                                               s->regs[addr]);
                 aspeed_intc_update(s, irq->inpin_idx,
                                    irq->outpin_idx + i, 1);
             } else {
                 /* clear irq for the specific bit */
-                trace_aspeed_intc_clear_irq(irq->inpin_idx,
+                trace_aspeed_intc_clear_irq(aic->id, irq->inpin_idx,
                                             irq->outpin_idx + i, 0);
                 aspeed_intc_update(s, irq->inpin_idx, irq->outpin_idx + i, 0);
             }
@@ -391,7 +397,7 @@ static uint64_t aspeed_2700_intc0_read(void *opaque, hwaddr offset,
     }
 
     value = s->regs[addr];
-    trace_aspeed_intc_read(offset, size, value);
+    trace_aspeed_intc_read(aic->id, offset, size, value);
 
     return value;
 }
@@ -410,7 +416,7 @@ static void aspeed_2700_intc0_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     }
 
-    trace_aspeed_intc_write(offset, size, data);
+    trace_aspeed_intc_write(aic->id, offset, size, data);
 
     switch (addr) {
     case R_INTC0_GICINT128_EN:
@@ -557,6 +563,7 @@ static void aspeed_2700_intc0_class_init(ObjectClass *klass, void *data)
     aic->reg_size = 0x2000;
     aic->irq_table = aspeed_2700_intc0_irqs;
     aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc0_irqs);
+    aic->id = 0;
 }
 
 static const TypeInfo aspeed_2700_intc0_info = {
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index bcea3bf1d3..a320b542d3 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -80,19 +80,19 @@ aspeed_vic_update_irq(int flags) "Raising IRQ: %d"
 aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 # aspeed_intc.c
-aspeed_intc_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
-aspeed_intc_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
-aspeed_intc_set_irq(int inpin_idx, int level) "Set IRQ %d: %d"
-aspeed_intc_clear_irq(int inpin_idx, int outpin_idx, int level) "Clear IRQ %d-%d: %d"
-aspeed_intc_update_irq(int inpin_idx, int outpin_idx, int level) "Update IRQ: %d-%d: %d"
-aspeed_intc_pending_irq(int inpin_idx, uint32_t value) "Pending IRQ: %d: 0x%x"
-aspeed_intc_trigger_irq(int inpin_idx, int outpin_idx, uint32_t value) "Trigger IRQ: %d-%d: 0x%x"
-aspeed_intc_all_isr_done(int inpin_idx) "All source ISR execution are done: %d"
-aspeed_intc_enable(uint32_t value) "Enable: 0x%x"
-aspeed_intc_select(uint32_t value) "Select: 0x%x"
-aspeed_intc_mask(uint32_t change, uint32_t value) "Mask: 0x%x: 0x%x"
-aspeed_intc_unmask(uint32_t change, uint32_t value) "UnMask: 0x%x: 0x%x"
-aspeed_intc_all_isr_done_bit(int inpin_idx, int bit) "All source ISR execution are done from specific bit: %d-%d"
+aspeed_intc_read(int id, uint64_t offset, unsigned size, uint32_t value) "%d: From 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_intc_write(int id, uint64_t offset, unsigned size, uint32_t data) "%d: To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_intc_set_irq(int id, int inpin_idx, int level) "%d: Set IRQ %d: %d"
+aspeed_intc_clear_irq(int id, int inpin_idx, int outpin_idx, int level) "%d: Clear IRQ %d-%d: %d"
+aspeed_intc_update_irq(int id, int inpin_idx, int outpin_idx, int level) "%d: Update IRQ: %d-%d: %d"
+aspeed_intc_pending_irq(int id, int inpin_idx, uint32_t value) "%d: Pending IRQ: %d: 0x%x"
+aspeed_intc_trigger_irq(int id, int inpin_idx, int outpin_idx, uint32_t value) "%d: Trigger IRQ: %d-%d: 0x%x"
+aspeed_intc_all_isr_done(int id, int inpin_idx) "%d: All source ISR execution are done: %d"
+aspeed_intc_enable(int id, uint32_t value) "%d: Enable: 0x%x"
+aspeed_intc_select(int id, uint32_t value) "%d: Select: 0x%x"
+aspeed_intc_mask(int id, uint32_t change, uint32_t value) "%d: Mask: 0x%x: 0x%x"
+aspeed_intc_unmask(int id, uint32_t change, uint32_t value) "%d: UnMask: 0x%x: 0x%x"
+aspeed_intc_all_isr_done_bit(int id, int inpin_idx, int bit) "%d: All source ISR execution are done from specific bit: %d-%d"
 
 # arm_gic.c
 gic_enable_irq(int irq) "irq %d enabled"
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 9280dc49d0..c2e3906d99 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -56,6 +56,7 @@ struct AspeedINTCClass {
     uint64_t reg_size;
     const AspeedINTCIRQ *irq_table;
     int irq_table_count;
+    int id;
 };
 
 #endif /* ASPEED_INTC_H */
-- 
2.34.1


