Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F3A4E77184
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 07:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN5vv-0004WB-2K; Mon, 16 Dec 2024 02:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tN5vr-0004VT-5F; Mon, 16 Dec 2024 02:54:23 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tN5vp-000791-6w; Mon, 16 Dec 2024 02:54:22 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 16 Dec
 2024 15:53:54 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 16 Dec 2024 15:53:54 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 2/3] hw/timer/aspeed: Add AST2700 Support
Date: Mon, 16 Dec 2024 15:53:51 +0800
Message-ID: <20241216075353.1308043-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
References: <20241216075353.1308043-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

The timer controller include 8 sets of 32-bit decrement counters, based on
either PCLK or 1MHZ clock and the design of timer controller between AST2600
and AST2700 are almost the same.

The different is that the register set have a significant change in AST2700.
TIMER0 – TIMER7 has their own individua control and interrupt status register.
In other words, users are able to set timer control in register TMC10 with
different TIMER base address and clear timer control and interrupt status in
register TMC14 with different TIMER base address.

Both "aspeed_timer_read" and "aspeed_timer_write" callback functions are not
compatible AST2700. Introduce new "aspeed_2700_timer_read" and
"aspeed_2700_timer_write" callback functions and "aspeed_2700_timer_ops" memory
region operation for AST2700. Introduce a new ast2700 class to support AST2700.

The base address of TIMER0 to TIMER7 as following.
Base Address of Timer 0 = 0x12C1_0000
Base Address of Timer 1 = 0x12C1_0040
Base Address of Timer 2 = 0x12C1_0080
Base Address of Timer 3 = 0x12C1_00C0
Base Address of Timer 4 = 0x12C1_0100
Base Address of Timer 5 = 0x12C1_0140
Base Address of Timer 6 = 0x12C1_0180
Base Address of Timer 7 = 0x12C1_01C0

The register address space of each TIMER is "0x40" , so uses the following
formula to get the index and register of each TIMER.

timer_index = offset >> 6;
timer_offset = offset & 0x3f;

The TMC010 is a counter control set and interrupt status register. Write "1" to
TMC10[3:0] will set the specific bits to "1". Introduce a new
"aspeed_2700_timer_set_ctrl" function to handle this register behavior.

The TMC014 is a counter control clear and interrupt status register, to clear
the specific bits to "0", it should write "1" to  TMC14[3:0] on the same bit
position. Introduce a new "aspeed_2700_timer_clear_ctrl" function to handle
this register behavior. TMC014 does not support read operation.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/timer/aspeed_timer.c         | 224 ++++++++++++++++++++++++++++++++
 include/hw/timer/aspeed_timer.h |   1 +
 2 files changed, 225 insertions(+)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 970bf1d79d..de4d78a0fb 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -593,6 +593,214 @@ static void aspeed_2600_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
     }
 }
 
+static void aspeed_2700_timer_set_ctrl(AspeedTimerCtrlState *s, int index,
+                                    uint32_t reg)
+{
+    const uint8_t overflow_interrupt_mask = BIT(op_overflow_interrupt);
+    const uint8_t external_clock_mask = BIT(op_external_clock);
+    const uint8_t pulse_enable_mask = BIT(op_pulse_enable);
+    const uint8_t enable_mask = BIT(op_enable);
+    AspeedTimer *t;
+    uint8_t t_old;
+    uint8_t t_new;
+    int shift;
+
+    /*
+     * Only 1 will set the specific bits to 1
+     * Handle a dependency between the 'enable' and remaining three
+     * configuration bits - i.e. if more than one bit in the control set has
+     * set, including the 'enable' bit, perform configuration and then
+     * enable the timer.
+     * Interrupt Status bit should not be set.
+     */
+
+     t = &s->timers[index];
+     shift = index * TIMER_CTRL_BITS;
+
+     t_old = (s->ctrl >> shift) & TIMER_CTRL_MASK;
+     t_new = reg & TIMER_CTRL_MASK;
+
+    if (!(t_old & external_clock_mask) &&
+        (t_new & external_clock_mask)) {
+        aspeed_timer_ctrl_external_clock(t, true);
+        s->ctrl = deposit32(s->ctrl, shift + op_external_clock, 1, 1);
+    }
+
+    if (!(t_old & overflow_interrupt_mask) &&
+        (t_new & overflow_interrupt_mask)) {
+        aspeed_timer_ctrl_overflow_interrupt(t, true);
+        s->ctrl = deposit32(s->ctrl, shift + op_overflow_interrupt, 1, 1);
+    }
+
+
+    if (!(t_old & pulse_enable_mask) &&
+        (t_new & pulse_enable_mask)) {
+        aspeed_timer_ctrl_pulse_enable(t, true);
+        s->ctrl = deposit32(s->ctrl, shift + op_pulse_enable, 1, 1);
+    }
+
+    /* If we are enabling, do so last */
+    if (!(t_old & enable_mask) &&
+        (t_new & enable_mask)) {
+        aspeed_timer_ctrl_enable(t, true);
+        s->ctrl = deposit32(s->ctrl, shift + op_enable, 1, 1);
+    }
+}
+
+static void aspeed_2700_timer_clear_ctrl(AspeedTimerCtrlState *s, int index,
+                                    uint32_t reg)
+{
+    const uint8_t overflow_interrupt_mask = BIT(op_overflow_interrupt);
+    const uint8_t external_clock_mask = BIT(op_external_clock);
+    const uint8_t pulse_enable_mask = BIT(op_pulse_enable);
+    const uint8_t enable_mask = BIT(op_enable);
+    AspeedTimer *t;
+    uint8_t t_old;
+    uint8_t t_new;
+    int shift;
+
+    /*
+     * Only 1 will clear the specific bits to 0
+     * Handle a dependency between the 'enable' and remaining three
+     * configuration bits - i.e. if more than one bit in the control set has
+     * clear, including the 'enable' bit, then disable the timer and perform
+     * configuration
+     */
+
+     t = &s->timers[index];
+     shift = index * TIMER_CTRL_BITS;
+
+     t_old = (s->ctrl >> shift) & TIMER_CTRL_MASK;
+     t_new = reg & TIMER_CTRL_MASK;
+
+    /* If we are disabling, do so first */
+    if ((t_old & enable_mask) &&
+        (t_new & enable_mask)) {
+        aspeed_timer_ctrl_enable(t, false);
+        s->ctrl = deposit32(s->ctrl, shift + op_enable, 1, 0);
+    }
+
+    if ((t_old & external_clock_mask) &&
+        (t_new & external_clock_mask)) {
+        aspeed_timer_ctrl_external_clock(t, false);
+        s->ctrl = deposit32(s->ctrl, shift + op_external_clock, 1, 0);
+    }
+
+    if ((t_old & overflow_interrupt_mask) &&
+        (t_new & overflow_interrupt_mask)) {
+        aspeed_timer_ctrl_overflow_interrupt(t, false);
+        s->ctrl = deposit32(s->ctrl, shift + op_overflow_interrupt, 1, 0);
+    }
+
+    if ((t_old & pulse_enable_mask) &&
+        (t_new & pulse_enable_mask)) {
+        aspeed_timer_ctrl_pulse_enable(t, false);
+        s->ctrl = deposit32(s->ctrl, shift + op_pulse_enable, 1, 0);
+    }
+
+    if ((t_old & pulse_enable_mask) &&
+        (t_new & pulse_enable_mask)) {
+        aspeed_timer_ctrl_pulse_enable(t, false);
+        s->ctrl = deposit32(s->ctrl, shift + op_pulse_enable, 1, 0);
+    }
+
+    /* Clear interrupt status */
+    if (reg & 0x10000) {
+        s->irq_sts = deposit32(s->irq_sts, index, 1, 0);
+    }
+}
+
+static uint64_t aspeed_2700_timer_read(void *opaque, hwaddr offset,
+                                    uint32_t size)
+{
+    AspeedTimerCtrlState *s = ASPEED_TIMER(opaque);
+    uint32_t timer_offset = offset & 0x3f;
+    int timer_index = offset >> 6;
+    uint64_t value = 0;
+
+    if (timer_index >= ASPEED_TIMER_NR_TIMERS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%" PRIx64 " out of bounds\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    switch (timer_offset) {
+    /*
+     * Counter Status
+     * Counter Reload
+     * Counter First Matching
+     * Counter Second Matching
+     */
+    case 0x00 ... 0x0C:
+        value = aspeed_timer_get_value(&s->timers[timer_index],
+                                       timer_offset >> 2);
+        break;
+    /* Counter Control and Interrupt Status */
+    case 0x10:
+        value = deposit64(value, 0, 4,
+                          extract32(s->ctrl, timer_index * 4, 4));
+        value = deposit64(value, 16, 1,
+                          extract32(s->irq_sts, timer_index, 1));
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no getter for offset 0x%"
+                     PRIx64"\n", __func__, offset);
+        return 0;
+    }
+    trace_aspeed_timer_read(offset, size, value);
+    return value;
+}
+
+static void aspeed_2700_timer_write(void *opaque, hwaddr offset,
+                                uint64_t value, uint32_t size)
+{
+    const uint32_t timer_value = (uint32_t)(value & 0xFFFFFFFF);
+    AspeedTimerCtrlState *s = ASPEED_TIMER(opaque);
+    uint32_t timer_offset = offset & 0x3f;
+    int timer_index = offset >> 6;
+
+    if (timer_index >= ASPEED_TIMER_NR_TIMERS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: offset 0x%" PRIx64 " out of bounds\n",
+                      __func__, offset);
+    }
+
+    switch (timer_offset) {
+    /*
+     * Counter Status
+     * Counter Reload
+     * Counter First Matching
+     * Counter Second Matching
+     */
+    case 0x00 ... 0x0C:
+        aspeed_timer_set_value(s, timer_index, timer_offset >> 2,
+                               timer_value);
+        break;
+    /* Counter Control Set and Interrupt Status */
+    case 0x10:
+        aspeed_2700_timer_set_ctrl(s, timer_index, timer_value);
+        break;
+    /* Counter Control Clear and Interrupr Status */
+    case 0x14:
+        aspeed_2700_timer_clear_ctrl(s, timer_index, timer_value);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no setter for offset 0x%"
+                      PRIx64"\n", __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_2700_timer_ops = {
+    .read = aspeed_2700_timer_read,
+    .write = aspeed_2700_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
 static void aspeed_init_one_timer(AspeedTimerCtrlState *s, uint8_t id)
 {
     AspeedTimer *t = &s->timers[id];
@@ -769,6 +977,21 @@ static const TypeInfo aspeed_1030_timer_info = {
     .class_init = aspeed_1030_timer_class_init,
 };
 
+static void aspeed_2700_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 Timer";
+    awc->reg_ops = &aspeed_2700_timer_ops;
+}
+
+static const TypeInfo aspeed_2700_timer_info = {
+    .name = TYPE_ASPEED_2700_TIMER,
+    .parent = TYPE_ASPEED_TIMER,
+    .class_init = aspeed_2700_timer_class_init,
+};
+
 static void aspeed_timer_register_types(void)
 {
     type_register_static(&aspeed_timer_info);
@@ -776,6 +999,7 @@ static void aspeed_timer_register_types(void)
     type_register_static(&aspeed_2500_timer_info);
     type_register_static(&aspeed_2600_timer_info);
     type_register_static(&aspeed_1030_timer_info);
+    type_register_static(&aspeed_2700_timer_info);
 }
 
 type_init(aspeed_timer_register_types)
diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 8d0b15f055..2247dc20ab 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -32,6 +32,7 @@ OBJECT_DECLARE_TYPE(AspeedTimerCtrlState, AspeedTimerClass, ASPEED_TIMER)
 #define TYPE_ASPEED_2500_TIMER TYPE_ASPEED_TIMER "-ast2500"
 #define TYPE_ASPEED_2600_TIMER TYPE_ASPEED_TIMER "-ast2600"
 #define TYPE_ASPEED_1030_TIMER TYPE_ASPEED_TIMER "-ast1030"
+#define TYPE_ASPEED_2700_TIMER TYPE_ASPEED_TIMER "-ast2700"
 
 #define ASPEED_TIMER_NR_TIMERS 8
 
-- 
2.25.1


