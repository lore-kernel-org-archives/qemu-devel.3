Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF32C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2XS-0000YH-QI; Mon, 03 Mar 2025 04:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2Wb-00081A-Md; Mon, 03 Mar 2025 04:55:51 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2WW-0001s3-Hd; Mon, 03 Mar 2025 04:55:49 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 3 Mar
 2025 17:55:02 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 3 Mar 2025 17:55:02 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v4 12/23] hw/intc/aspeed: Introduce AspeedINTCIRQ structure to
 save the irq index and register address
Date: Mon, 3 Mar 2025 17:54:40 +0800
Message-ID: <20250303095457.2337631-13-jamin_lin@aspeedtech.com>
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

The INTC controller supports GICINT128 to GICINT136, mapping 1:1 to input and
output IRQs 0 to 8. Previously, the formula "address & 0x0f00" was used to
derive the IRQ index numbers.

However, the INTC controller also supports GICINT192_201, mapping 1 input IRQ
pin to 10 output IRQ pins. The pin numbers for input and output are different.
It is difficult to use a formula to determine the index number of INTC model
supported input and output IRQs.

To simplify and improve readability, introduces the AspeedINTCIRQ structure to
save the input/output IRQ index and its enable/status register address.

Introduce the "aspeed_2700_intc_irqs" table to store IRQ information for INTC.
Introduce the "aspeed_intc_get_irq" function to retrieve the input/output IRQ
pin index from the provided status/enable register address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/intc/aspeed_intc.h |  10 +++
 hw/intc/aspeed_intc.c         | 120 ++++++++++++++++++++--------------
 2 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index f9a0273f78..112a01f402 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -20,6 +20,14 @@ OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 #define ASPEED_INTC_MAX_INPINS 9
 #define ASPEED_INTC_MAX_OUTPINS 9
 
+typedef struct AspeedINTCIRQ {
+    int inpin_idx;
+    int outpin_idx;
+    int num_outpins;
+    uint32_t enable_addr;
+    uint32_t status_addr;
+} AspeedINTCIRQ;
+
 struct AspeedINTCState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -47,6 +55,8 @@ struct AspeedINTCClass {
     uint64_t reg_size;
     uint64_t reg_offset;
     const MemoryRegionOps *reg_ops;
+    const AspeedINTCIRQ *irq_table;
+    int irq_table_count;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 9bc3e089d8..5730a7604d 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -40,7 +40,23 @@ REG32(GICINT135_STATUS,     0x704)
 REG32(GICINT136_EN,         0x800)
 REG32(GICINT136_STATUS,     0x804)
 
-#define GICINT_STATUS_BASE     R_GICINT128_STATUS
+static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
+                                                uint32_t addr)
+{
+    int i;
+
+    for (i = 0; i < aic->irq_table_count; i++) {
+        if (aic->irq_table[i].enable_addr == addr ||
+            aic->irq_table[i].status_addr == addr) {
+            return &aic->irq_table[i];
+        }
+    }
+
+    /*
+     * Invalid addr.
+     */
+    g_assert_not_reached();
+}
 
 /*
  * Update the state of an interrupt controller pin by setting
@@ -81,15 +97,10 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     AspeedINTCState *s = (AspeedINTCState *)opaque;
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
-    uint32_t status_addr = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
+    const AspeedINTCIRQ *intc_irq;
     uint32_t select = 0;
     uint32_t enable;
     int i;
-    int inpin_idx;
-    int outpin_idx;
-
-    inpin_idx = irq;
-    outpin_idx = irq;
 
     if (irq >= aic->num_inpins) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
@@ -97,15 +108,16 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    trace_aspeed_intc_set_irq(name, inpin_idx, level);
-    enable = s->enable[inpin_idx];
+    intc_irq = &aic->irq_table[irq];
+    trace_aspeed_intc_set_irq(name, intc_irq->inpin_idx, level);
+    enable = s->enable[intc_irq->inpin_idx];
 
     if (!level) {
         return;
     }
 
     for (i = 0; i < aic->num_lines; i++) {
-        if (s->orgates[inpin_idx].levels[i]) {
+        if (s->orgates[intc_irq->inpin_idx].levels[i]) {
             if (enable & BIT(i)) {
                 select |= BIT(i);
             }
@@ -118,7 +130,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
 
     trace_aspeed_intc_select(name, select);
 
-    if (s->mask[inpin_idx] || s->regs[status_addr]) {
+    if (s->mask[intc_irq->inpin_idx] || s->regs[intc_irq->status_addr]) {
         /*
          * a. mask is not 0 means in ISR mode
          * sources interrupt routine are executing.
@@ -127,17 +139,19 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
          *
          * save source interrupt to pending variable.
          */
-        s->pending[inpin_idx] |= select;
-        trace_aspeed_intc_pending_irq(name, inpin_idx, s->pending[inpin_idx]);
+        s->pending[intc_irq->inpin_idx] |= select;
+        trace_aspeed_intc_pending_irq(name, intc_irq->inpin_idx,
+                                      s->pending[intc_irq->inpin_idx]);
     } else {
         /*
          * notify firmware which source interrupt are coming
          * by setting status register
          */
-        s->regs[status_addr] = select;
-        trace_aspeed_intc_trigger_irq(name, inpin_idx, outpin_idx,
-                                      s->regs[status_addr]);
-        aspeed_intc_update(s, inpin_idx, outpin_idx, 1);
+        s->regs[intc_irq->status_addr] = select;
+        trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
+                                      intc_irq->outpin_idx,
+                                      s->regs[intc_irq->status_addr]);
+        aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 1);
     }
 }
 
@@ -146,19 +160,17 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
+    const AspeedINTCIRQ *intc_irq;
     uint32_t addr = offset >> 2;
     uint32_t old_enable;
     uint32_t change;
-    uint32_t irq;
-    int inpin_idx;
 
-    irq = (offset & 0x0f00) >> 8;
-    inpin_idx = irq;
+    intc_irq = aspeed_intc_get_irq(aic, addr);
 
-    if (inpin_idx >= aic->num_inpins) {
+    if (intc_irq->inpin_idx >= aic->num_inpins) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Invalid input pin index: %d\n",
-                      __func__, inpin_idx);
+                      __func__, intc_irq->inpin_idx);
         return;
     }
 
@@ -169,17 +181,17 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
      */
 
     /* disable all source interrupt */
-    if (!data && !s->enable[inpin_idx]) {
+    if (!data && !s->enable[intc_irq->inpin_idx]) {
         s->regs[addr] = data;
         return;
     }
 
-    old_enable = s->enable[inpin_idx];
-    s->enable[inpin_idx] |= data;
+    old_enable = s->enable[intc_irq->inpin_idx];
+    s->enable[intc_irq->inpin_idx] |= data;
 
     /* enable new source interrupt */
-    if (old_enable != s->enable[inpin_idx]) {
-        trace_aspeed_intc_enable(name, s->enable[inpin_idx]);
+    if (old_enable != s->enable[intc_irq->inpin_idx]) {
+        trace_aspeed_intc_enable(name, s->enable[intc_irq->inpin_idx]);
         s->regs[addr] = data;
         return;
     }
@@ -187,11 +199,11 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
     /* mask and unmask source interrupt */
     change = s->regs[addr] ^ data;
     if (change & data) {
-        s->mask[inpin_idx] &= ~change;
-        trace_aspeed_intc_unmask(name, change, s->mask[inpin_idx]);
+        s->mask[intc_irq->inpin_idx] &= ~change;
+        trace_aspeed_intc_unmask(name, change, s->mask[intc_irq->inpin_idx]);
     } else {
-        s->mask[inpin_idx] |= change;
-        trace_aspeed_intc_mask(name, change, s->mask[inpin_idx]);
+        s->mask[intc_irq->inpin_idx] |= change;
+        trace_aspeed_intc_mask(name, change, s->mask[intc_irq->inpin_idx]);
     }
 
     s->regs[addr] = data;
@@ -202,24 +214,20 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
+    const AspeedINTCIRQ *intc_irq;
     uint32_t addr = offset >> 2;
-    uint32_t irq;
-    int inpin_idx;
-    int outpin_idx;
 
     if (!data) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid data 0\n", __func__);
         return;
     }
 
-    irq = (offset & 0x0f00) >> 8;
-    inpin_idx = irq;
-    outpin_idx = irq;
+    intc_irq = aspeed_intc_get_irq(aic, addr);
 
-    if (inpin_idx >= aic->num_inpins) {
+    if (intc_irq->inpin_idx >= aic->num_inpins) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Invalid input pin index: %d\n",
-                      __func__, inpin_idx);
+                      __func__, intc_irq->inpin_idx);
         return;
     }
 
@@ -238,22 +246,24 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 
     /* All source ISR execution are done */
     if (!s->regs[addr]) {
-        trace_aspeed_intc_all_isr_done(name, inpin_idx);
-        if (s->pending[inpin_idx]) {
+        trace_aspeed_intc_all_isr_done(name, intc_irq->inpin_idx);
+        if (s->pending[intc_irq->inpin_idx]) {
             /*
              * handle pending source interrupt
              * notify firmware which source interrupt are pending
              * by setting status register
              */
-            s->regs[addr] = s->pending[inpin_idx];
-            s->pending[inpin_idx] = 0;
-            trace_aspeed_intc_trigger_irq(name, inpin_idx, outpin_idx,
+            s->regs[addr] = s->pending[intc_irq->inpin_idx];
+            s->pending[intc_irq->inpin_idx] = 0;
+            trace_aspeed_intc_trigger_irq(name, intc_irq->inpin_idx,
+                                          intc_irq->outpin_idx,
                                           s->regs[addr]);
-            aspeed_intc_update(s, inpin_idx, outpin_idx, 1);
+            aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 1);
         } else {
             /* clear irq */
-            trace_aspeed_intc_clear_irq(name, inpin_idx, outpin_idx, 0);
-            aspeed_intc_update(s, inpin_idx, outpin_idx, 0);
+            trace_aspeed_intc_clear_irq(name, intc_irq->inpin_idx,
+                                        intc_irq->outpin_idx, 0);
+            aspeed_intc_update(s, intc_irq->inpin_idx, intc_irq->outpin_idx, 0);
         }
     }
 }
@@ -416,6 +426,18 @@ static const TypeInfo aspeed_intc_info = {
     .abstract = true,
 };
 
+static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 0, 1, R_GICINT128_EN, R_GICINT128_STATUS},
+    {1, 1, 1, R_GICINT129_EN, R_GICINT129_STATUS},
+    {2, 2, 1, R_GICINT130_EN, R_GICINT130_STATUS},
+    {3, 3, 1, R_GICINT131_EN, R_GICINT131_STATUS},
+    {4, 4, 1, R_GICINT132_EN, R_GICINT132_STATUS},
+    {5, 5, 1, R_GICINT133_EN, R_GICINT133_STATUS},
+    {6, 6, 1, R_GICINT134_EN, R_GICINT134_STATUS},
+    {7, 7, 1, R_GICINT135_EN, R_GICINT135_STATUS},
+    {8, 8, 1, R_GICINT136_EN, R_GICINT136_STATUS},
+};
+
 static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -428,6 +450,8 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     aic->mem_size = 0x4000;
     aic->reg_size = 0x808;
     aic->reg_offset = 0x1000;
+    aic->irq_table = aspeed_2700_intc_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc_irqs);
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.34.1


