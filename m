Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E88CC0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 09:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcLen-0006bJ-OJ; Mon, 27 Jan 2025 04:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLeF-0006HR-QS
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tcLeD-0005Ro-Op
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 04:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737970991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvxXCpgxcR8pnFAbFm1ZXD/+Uaq5sgKqZlPpIPkXai4=;
 b=HgUekkEi6QUljUEYtLJ27Ar+A6dYk56Mzvb/VuC/2JDSQ1Zjw6H5n1joNMQ7EHVn+WTt6A
 cn4ZVE+2przM7FmtP3xdysAODfwW2Nq461cQCzIxpAGqsBTDtCSZN/8sCRohH2xnW11RsD
 wIWx/uxOYqmBZP8q4LvJyZ4/foLs2wQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-wTJvDMfFPWa2KzkVTeBabA-1; Mon,
 27 Jan 2025 04:43:07 -0500
X-MC-Unique: wTJvDMfFPWa2KzkVTeBabA-1
X-Mimecast-MFC-AGG-ID: wTJvDMfFPWa2KzkVTeBabA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D34819560BB; Mon, 27 Jan 2025 09:43:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FBA71800365; Mon, 27 Jan 2025 09:42:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/12] hw/timer/aspeed: Add AST2700 Support
Date: Mon, 27 Jan 2025 10:42:32 +0100
Message-ID: <20250127094239.636526-6-clg@redhat.com>
In-Reply-To: <20250127094239.636526-1-clg@redhat.com>
References: <20250127094239.636526-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

The timer controller include 8 sets of 32-bit decrement counters, based on
either PCLK or 1MHZ clock and the design of timer controller between AST2600
and AST2700 are almost the same.

TIMER0 – TIMER7 has their own individual control and interrupt status register.
In other words, users are able to set timer control in register TMC10 with
different TIMER base address and clear timer control and interrupt status in
register TMC14 with different TIMER base address.

Introduce new "aspeed_2700_timer_read" and "aspeed_2700_timer_write" callback
functions and a new ast2700 class to support AST2700.

The base address of TIMER0 to TIMER7 as following.
Base Address of Timer 0 = 0x12C1_0000
Base Address of Timer 1 = 0x12C1_0040
Base Address of Timer 2 = 0x12C1_0080
Base Address of Timer 3 = 0x12C1_00C0
Base Address of Timer 4 = 0x12C1_0100
Base Address of Timer 5 = 0x12C1_0140
Base Address of Timer 6 = 0x12C1_0180
Base Address of Timer 7 = 0x12C1_01C0

The register address space of each TIMER is "0x40" , and uses the following
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
Acked-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20250113064455.1660564-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/timer/aspeed_timer.h |   1 +
 hw/timer/aspeed_timer.c         | 208 ++++++++++++++++++++++++++++++++
 2 files changed, 209 insertions(+)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 07dc6b6f2cbd..767cae4b05ba 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -32,6 +32,7 @@ OBJECT_DECLARE_TYPE(AspeedTimerCtrlState, AspeedTimerClass, ASPEED_TIMER)
 #define TYPE_ASPEED_2500_TIMER TYPE_ASPEED_TIMER "-ast2500"
 #define TYPE_ASPEED_2600_TIMER TYPE_ASPEED_TIMER "-ast2600"
 #define TYPE_ASPEED_1030_TIMER TYPE_ASPEED_TIMER "-ast1030"
+#define TYPE_ASPEED_2700_TIMER TYPE_ASPEED_TIMER "-ast2700"
 
 #define ASPEED_TIMER_NR_TIMERS 8
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 24ba40cbe9b4..ecda49574e2c 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -618,6 +618,197 @@ static void aspeed_2600_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
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
+    /* Clear interrupt status */
+    if (reg & 0x10000) {
+        s->irq_sts = deposit32(s->irq_sts, index, 1, 0);
+    }
+}
+
+static uint64_t aspeed_2700_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
+{
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
+        value = 0;
+        break;
+    }
+    trace_aspeed_timer_read(offset, value);
+    return value;
+}
+
+static void aspeed_2700_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
+                                    uint64_t value)
+{
+    const uint32_t timer_value = (uint32_t)(value & 0xFFFFFFFF);
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
 static void aspeed_init_one_timer(AspeedTimerCtrlState *s, uint8_t id)
 {
     AspeedTimer *t = &s->timers[id];
@@ -788,6 +979,22 @@ static const TypeInfo aspeed_1030_timer_info = {
     .class_init = aspeed_1030_timer_class_init,
 };
 
+static void aspeed_2700_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
+
+    dc->desc = "ASPEED 2700 Timer";
+    awc->read = aspeed_2700_timer_read;
+    awc->write = aspeed_2700_timer_write;
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
@@ -795,6 +1002,7 @@ static void aspeed_timer_register_types(void)
     type_register_static(&aspeed_2500_timer_info);
     type_register_static(&aspeed_2600_timer_info);
     type_register_static(&aspeed_1030_timer_info);
+    type_register_static(&aspeed_2700_timer_info);
 }
 
 type_init(aspeed_timer_register_types)
-- 
2.48.1


