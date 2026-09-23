Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4987C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Uxw-0004Mm-LB; Wed, 23 Sep 2026 17:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <manueleconti@Manueles-MacBook-Pro.local>)
 id 1x9Um2-0001aC-AV; Wed, 23 Sep 2026 17:45:06 -0400
Received: from [82.84.137.98] (helo=Manueles-MacBook-Pro.local)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <manueleconti@Manueles-MacBook-Pro.local>)
 id 1x9Uly-0003bA-Mi; Wed, 23 Sep 2026 17:45:05 -0400
Received: by Manueles-MacBook-Pro.local (Postfix, from userid 501)
 id 13418998379E; Wed, 23 Sep 2026 22:27:40 +0200 (CEST)
From: Manuele Conti <manuele.conti@archimede-energia.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manuele Conti <manuele.conti@archimede-energia.com>
Subject: [PATCH 1/2] hw/timer/stm32f2xx_timer: fix periodic mode,
 CNT wrap and CEN handling
Date: Wed, 23 Sep 2026 22:27:32 +0200
Message-ID: <20260923202733.24933-2-manuele.conti@archimede-energia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260923202733.24933-1-manuele.conti@archimede-energia.com>
References: <20260923202733.24933-1-manuele.conti@archimede-energia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 82.84.137.98 (failed)
Received-SPF: none client-ip=82.84.137.98;
 envelope-from=manueleconti@Manueles-MacBook-Pro.local;
 helo=Manueles-MacBook-Pro.local
X-Spam_score_int: 25
X-Spam_score: 2.5
X-Spam_bar: ++
X-Spam_report: (2.5 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NO_DNS_FOR_FROM=0.001, RCVD_IN_PBL=3.335,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Sep 2026 17:56:34 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RM0090 counters count from 0 to ARR inclusive, with period ARR + 1
for all ARR values including ARR == 0. Fix set_alarm to wrap CNT,
arm an absolute expiry and delete the QEMU timer when CEN is cleared.

Freeze CNT while CEN == 0 in stopped_cnt so a TIM_CNT write
programmed while stopped is preserved and resumed on enable, and
reset deletes any pending timer event.

VMState goes to version 2 to serialize stopped_cnt. Loading a v1
stream leaves stopped_cnt at 0, so a timer stopped with CNT != 0
loads CNT as 0; no post_load workaround. The pre-existing QEMUTimer
expiry limit is unchanged.

Add qtests covering PSC/ARR/CEN/UIF, CNT <= ARR, CNT preset before
CEN, ARR == 0, stop freeze on CEN=0, restart, and no spurious IRQ
after reset.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
---
 MAINTAINERS                        |   1 +
 hw/timer/stm32f2xx_timer.c         | 101 ++++++++++++++++----
 include/hw/timer/stm32f2xx_timer.h |   7 ++
 tests/qtest/meson.build            |   4 +
 tests/qtest/stm32f405-timer-test.c | 142 +++++++++++++++++++++++++++++
 5 files changed, 236 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/stm32f405-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5bf895732c..f1b3d75cc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1213,6 +1213,7 @@ F: hw/misc/stm32f4xx_syscfg.c
 F: hw/misc/stm32f4xx_exti.c
 F: hw/misc/stm32_rcc.c
 F: include/hw/misc/stm32_rcc.h
+F: tests/qtest/stm32f405*
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 0442ac64ad..1639037130 100644
--- a/hw/timer/stm32f2xx_timer.c
+++ b/hw/timer/stm32f2xx_timer.c
@@ -53,7 +53,8 @@ static void stm32f2xx_timer_interrupt(void *opaque)
     if (s->tim_dier & TIM_DIER_UIE && s->tim_cr1 & TIM_CR1_CEN) {
         s->tim_sr |= 1;
         qemu_irq_pulse(s->irq);
-        stm32f2xx_timer_set_alarm(s, s->hit_time);
+        stm32f2xx_timer_set_alarm(s,
+                                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
     }
 
     if (s->tim_ccmr1 & (TIM_CCMR1_OC2M2 | TIM_CCMR1_OC2M1) &&
@@ -71,26 +72,46 @@ static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, int64_t t)
     return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + 1);
 }
 
+static uint64_t stm32f2xx_timer_get_cnt(STM32F2XXTimerState *s, int64_t now)
+{
+    uint64_t period_ticks = (uint64_t)s->tim_arr + 1;
+    uint64_t elapsed_ticks =
+        (uint64_t)(stm32f2xx_ns_to_ticks(s, now) - s->tick_offset);
+
+    return elapsed_ticks % period_ticks;
+}
+
 static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t now)
 {
-    uint64_t ticks;
-    int64_t now_ticks;
+    uint64_t period_ticks;
+    uint64_t cnt;
+    uint64_t remaining_ticks;
+    uint64_t delta_ns;
 
-    if (s->tim_arr == 0) {
+    if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+        timer_del(s->timer);
         return;
     }
 
     DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
 
-    now_ticks = stm32f2xx_ns_to_ticks(s, now);
-    ticks = s->tim_arr - (now_ticks - s->tick_offset);
-
-    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
+    /*
+     * RM0090: counter counts from 0 to ARR inclusive, then wraps.
+     * Period is ARR + 1 for all ARR values including ARR == 0.
+     */
+    period_ticks = (uint64_t)s->tim_arr + 1;
+    cnt = stm32f2xx_timer_get_cnt(s, now);
+    remaining_ticks = period_ticks - cnt;
 
-    s->hit_time = muldiv64((ticks + (uint64_t) now_ticks) * (s->tim_psc + 1),
-                               1000000000ULL, s->freq_hz);
+    DB_PRINT("Alarm set in %" PRIu64 " ticks\n", remaining_ticks);
 
-    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->hit_time);
+    delta_ns = muldiv64(remaining_ticks * (uint64_t)(s->tim_psc + 1),
+                        1000000000ULL, s->freq_hz);
+    /*
+     * QEMU timers expect an absolute expiry time.
+     */
+    s->hit_time = (uint64_t)now + delta_ns;
+    timer_mod(s->timer, s->hit_time);
     DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
 }
 
@@ -119,6 +140,9 @@ static void stm32f2xx_timer_reset(DeviceState *dev)
     s->tim_or = 0;
 
     s->tick_offset = stm32f2xx_ns_to_ticks(s, now);
+    s->stopped_cnt = 0;
+    s->hit_time = 0;
+    timer_del(s->timer);
 }
 
 static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
@@ -148,8 +172,11 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
     case TIM_CCER:
         return s->tim_ccer;
     case TIM_CNT:
-        return stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) -
-               s->tick_offset;
+        if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+            return s->stopped_cnt % ((uint64_t)s->tim_arr + 1);
+        }
+        return stm32f2xx_timer_get_cnt(s,
+                   qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
     case TIM_PSC:
         return s->tim_psc;
     case TIM_ARR:
@@ -187,9 +214,24 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
     DB_PRINT("Write 0x%x, 0x%"HWADDR_PRIx"\n", value, offset);
 
     switch (offset) {
-    case TIM_CR1:
+    case TIM_CR1: {
+        uint32_t old_cr1 = s->tim_cr1;
+
         s->tim_cr1 = value;
+        if (!(old_cr1 & TIM_CR1_CEN) && (s->tim_cr1 & TIM_CR1_CEN)) {
+            /*
+             * Resume from the frozen CNT value so that a TIM_CNT write
+             * programmed while stopped is preserved (RM0090: CNT is
+             * retained while CEN == 0).
+             */
+            s->tick_offset = stm32f2xx_ns_to_ticks(s, now) - s->stopped_cnt;
+            stm32f2xx_timer_set_alarm(s, now);
+        } else if ((old_cr1 & TIM_CR1_CEN) && !(s->tim_cr1 & TIM_CR1_CEN)) {
+            s->stopped_cnt = stm32f2xx_timer_get_cnt(s, now);
+            timer_del(s->timer);
+        }
         return;
+    }
     case TIM_CR2:
         s->tim_cr2 = value;
         return;
@@ -206,8 +248,12 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
     case TIM_EGR:
         s->tim_egr = value;
         if (s->tim_egr & TIM_EGR_UG) {
-            timer_val = 0;
-            break;
+            if (s->tim_cr1 & TIM_CR1_CEN) {
+                timer_val = 0;
+                break;
+            }
+            s->stopped_cnt = 0;
+            return;
         }
         return;
     case TIM_CCMR1:
@@ -220,15 +266,25 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
         s->tim_ccer = value;
         return;
     case TIM_PSC:
-        timer_val = stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
+        if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+            s->tim_psc = value & 0xFFFF;
+            return;
+        }
+        timer_val = stm32f2xx_timer_get_cnt(s, now);
         s->tim_psc = value & 0xFFFF;
         break;
     case TIM_CNT:
+        if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+            s->stopped_cnt = value;
+            return;
+        }
         timer_val = value;
         break;
     case TIM_ARR:
         s->tim_arr = value;
-        stm32f2xx_timer_set_alarm(s, now);
+        if (s->tim_cr1 & TIM_CR1_CEN) {
+            stm32f2xx_timer_set_alarm(s, now);
+        }
         return;
     case TIM_CCR1:
         s->tim_ccr1 = value;
@@ -272,7 +328,7 @@ static const MemoryRegionOps stm32f2xx_timer_ops = {
 
 static const VMStateDescription vmstate_stm32f2xx_timer = {
     .name = TYPE_STM32F2XX_TIMER,
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
@@ -294,6 +350,13 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
         VMSTATE_UINT32(tim_dcr, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_dmar, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_or, STM32F2XXTimerState),
+        /*
+         * New in version 2: frozen CNT while CEN == 0. Pre-existing
+         * limitation left unchanged: QEMUTimer expiry (hit_time) is
+         * not migrated and is re-armed by the next register write;
+         * see stm32f2xx_timer_set_alarm.
+         */
+        VMSTATE_UINT32_V(stopped_cnt, STM32F2XXTimerState, 2),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f2xx_timer.h
index 040e64d499..d8ce2efd57 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -79,6 +79,13 @@ struct STM32F2XXTimerState {
     uint64_t hit_time;
     uint64_t freq_hz;
 
+    /*
+     * Frozen counter value while CEN == 0. RM0090: disabling CEN stops
+     * the counter and CNT retains its value; writes to TIM_CNT while
+     * stopped update it, and enabling CEN resumes from it.
+     */
+    uint32_t stopped_cnt;
+
     uint32_t tim_cr1;
     uint32_t tim_cr2;
     uint32_t tim_smcr;
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..51dbe63411 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -249,6 +249,9 @@ qtests_stm32l4x5 = \
    'stm32l4x5_gpio-test',
    'stm32l4x5_usart-test']
 
+qtests_stm32f405 = \
+  ['stm32f405-timer-test']
+
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
@@ -263,6 +266,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
+  (config_all_devices.has_key('CONFIG_STM32F405_SOC') ? qtests_stm32f405 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
diff --git a/tests/qtest/stm32f405-timer-test.c b/tests/qtest/stm32f405-timer-test.c
new file mode 100644
index 0000000000..5f2f5f1042
--- /dev/null
+++ b/tests/qtest/stm32f405-timer-test.c
@@ -0,0 +1,142 @@
+/*
+ * QTest for STM32F2XX timer periodic mode (STM32F405 SoC).
+ *
+ * Covers RM0090 counter 0..ARR inclusive, CEN start/stop, CNT preset,
+ * ARR == 0 period and reset cancelling a pending timer.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define TIM2_BASE 0x40000000ULL
+#define TIM_CR1   0x00
+#define TIM_DIER  0x0c
+#define TIM_SR    0x10
+#define TIM_CNT   0x24
+#define TIM_PSC   0x28
+#define TIM_ARR   0x2c
+
+#define TIM_CR1_CEN  (1U << 0)
+#define TIM_DIER_UIE (1U << 0)
+#define TIM_SR_UIF   (1U << 0)
+
+static void test_periodic(void)
+{
+    QTestState *qts = qtest_init("-M netduinoplus2");
+
+    /*
+     * Default clock-frequency is 1 GHz. PSC=999 gives 1 MHz tick (1 us).
+     * ARR=999 gives 1000-tick period = 1 ms.
+     */
+    qtest_writel(qts, TIM2_BASE + TIM_PSC, 999);
+    qtest_writel(qts, TIM2_BASE + TIM_ARR, 999);
+    qtest_writel(qts, TIM2_BASE + TIM_DIER, TIM_DIER_UIE);
+    qtest_writel(qts, TIM2_BASE + TIM_CNT, 0);
+    qtest_writel(qts, TIM2_BASE + TIM_CR1, TIM_CR1_CEN);
+
+    /* Advance well past one period, UIF must be set. */
+    qtest_clock_step(qts, 2000000);
+    g_assert_true(qtest_readl(qts, TIM2_BASE + TIM_SR) & TIM_SR_UIF);
+    g_assert_cmpuint(qtest_readl(qts, TIM2_BASE + TIM_CNT), <=, 999);
+
+    /* Clear UIF, verify periodicity with a second period. */
+    qtest_writel(qts, TIM2_BASE + TIM_SR, 0);
+    qtest_clock_step(qts, 1000000);
+    g_assert_true(qtest_readl(qts, TIM2_BASE + TIM_SR) & TIM_SR_UIF);
+
+    /*
+     * Stop: CEN=0 must cancel the timer, CNT freezes and no new UIF.
+     * Use 1.5 periods so a free-running counter would visibly differ.
+     */
+    qtest_writel(qts, TIM2_BASE + TIM_SR, 0);
+    qtest_writel(qts, TIM2_BASE + TIM_CR1, 0);
+    {
+        uint32_t cnt = qtest_readl(qts, TIM2_BASE + TIM_CNT);
+        qtest_clock_step(qts, 1500000);
+        g_assert_false(qtest_readl(qts, TIM2_BASE + TIM_SR) & TIM_SR_UIF);
+        g_assert_cmpuint(qtest_readl(qts, TIM2_BASE + TIM_CNT), ==, cnt);
+    }
+
+    /* Restart: counter resumes and UIF fires again. */
+    qtest_writel(qts, TIM2_BASE + TIM_CR1, TIM_CR1_CEN);
+    qtest_clock_step(qts, 2000000);
+    g_assert_true(qtest_readl(qts, TIM2_BASE + TIM_SR) & TIM_SR_UIF);
+
+    qtest_quit(qts);
+}
+
+static void test_cnt_preset(void)
+{
+    QTestState *qts = qtest_init("-M netduinoplus2");
+    uint32_t cnt;
+
+    qtest_writel(qts, TIM2_BASE + TIM_PSC, 999);
+    qtest_writel(qts, TIM2_BASE + TIM_ARR, 9999);
+    qtest_writel(qts, TIM2_BASE + TIM_DIER, TIM_DIER_UIE);
+
+    /* Program CNT while stopped, then enable: counter resumes from N. */
+    qtest_writel(qts, TIM2_BASE + TIM_CNT, 5000);
+    qtest_writel(qts, TIM2_BASE + TIM_CR1, TIM_CR1_CEN);
+
+    cnt = qtest_readl(qts, TIM2_BASE + TIM_CNT);
+    g_assert_cmpuint(cnt, >=, 5000);
+    g_assert_cmpuint(cnt, <=, 5010);
+
+    qtest_clock_step(qts, 100000);
+    cnt = qtest_readl(qts, TIM2_BASE + TIM_CNT);
+    g_assert_cmpuint(cnt, >=, 5100);
+    g_assert_cmpuint(cnt, <=, 9999);
+
+    qtest_quit(qts);
+}
+
+static void test_arr_zero(void)
+{
+    QTestState *qts = qtest_init("-M netduinoplus2");
+
+    /* ARR == 0 means period 1: CNT is always 0 and UIF fires each tick. */
+    qtest_writel(qts, TIM2_BASE + TIM_PSC, 999);
+    qtest_writel(qts, TIM2_BASE + TIM_ARR, 0);
+    qtest_writel(qts, TIM2_BASE + TIM_DIER, TIM_DIER_UIE);
+    qtest_writel(qts, TIM2_BASE + TIM_CNT, 0);
+    qtest_writel(qts, TIM2_BASE + TIM_CR1, TIM_CR1_CEN);
+
+    g_assert_cmpuint(qtest_readl(qts, TIM2_BASE + TIM_CNT), ==, 0);
+    qtest_clock_step(qts, 10000);
+    g_assert_true(qtest_readl(qts, TIM2_BASE + TIM_SR) & TIM_SR_UIF);
+    g_assert_cmpuint(qtest_readl(qts, TIM2_BASE + TIM_CNT), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_reset_cancels(void)
+{
+    QTestState *qts = qtest_init("-M netduinoplus2");
+
+    qtest_writel(qts, TIM2_BASE + TIM_PSC, 999);
+    qtest_writel(qts, TIM2_BASE + TIM_ARR, 999);
+    qtest_writel(qts, TIM2_BASE + TIM_DIER, TIM_DIER_UIE);
+    qtest_writel(qts, TIM2_BASE + TIM_CNT, 0);
+    qtest_writel(qts, TIM2_BASE + TIM_CR1, TIM_CR1_CEN);
+
+    /* Reset with a timer event pending: no spurious IRQ afterwards. */
+    qtest_clock_step(qts, 500000);
+    qtest_system_reset(qts);
+    qtest_clock_step(qts, 2000000);
+    g_assert_false(qtest_readl(qts, TIM2_BASE + TIM_SR) & TIM_SR_UIF);
+    g_assert_cmpuint(qtest_readl(qts, TIM2_BASE + TIM_CNT), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("stm32f405/timer/periodic", test_periodic);
+    qtest_add_func("stm32f405/timer/cnt-preset", test_cnt_preset);
+    qtest_add_func("stm32f405/timer/arr-zero", test_arr_zero);
+    qtest_add_func("stm32f405/timer/reset-cancels", test_reset_cancels);
+    return g_test_run();
+}
-- 
2.41.0


