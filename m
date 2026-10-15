Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F08CCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtC-0003ld-Fy; Thu, 15 Oct 2026 14:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt5-0003kj-UG
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPt3-0000zx-Gt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so678890f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087744; x=1792692544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lFZ5bkHT08V3lLkvwIkeipQatXkMut8mgXu9G2GSXIo=;
 b=lf5eZbG8dv+NMPIiJJHKTeemnU6iGcav62Zn8esIm8Vcyjtw3Gf4Ne4q53utXmeOzJ
 f3YTvgSREhiuL0Yan7FHrahjlWfhjiwwD0Bth459zw/rAE0ujII2Nu78s/baZUWGymKq
 PdGjXzAsq308nY+pfJIJX3D+LdmRSomNOOGTrw9acqZkXwHQHOmp0hrojHSbx3v9iU8I
 an1IrItsqmfj/zWkZbc/RywifjFIxcHhh8jH4Y6lg42+UDhB+dWRkwWvjsgctIitcvuX
 SU3HOAOTdxjSruNoDoB27639eZAqdLGp/NS9xkjrQMu5jIhOUaVlPPjUzLXzU34xH+tQ
 Un0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087744; x=1792692544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lFZ5bkHT08V3lLkvwIkeipQatXkMut8mgXu9G2GSXIo=;
 b=Tlkp5wQWvOGq4Mu2nH76LaUWQlicuAOAr91LSGAqFIkfMyBmt60hwqOrYA6IwC9fUW
 +068XX4nW5PGI5ZKHQ6FkWbihMBFLEYhtx+fWp2OidPv2MoC5OibdxN1a2a9LQ1voaeV
 fK6vUumm6GpuE8wdAafcb8CMy9iPGX8Cdjvdrw7k9+5gp0lAPQvgJRw8Rya2i9LvO/d1
 4EW2fwP+lQ2OGOAue5VZ7L3zM6D24tkmo+IQNCoxJFhAaRK+RodLviYW5QQwn9mwo/JM
 f2WTlbOpoXUasaVPt5ycshmZBjcVI0h88PDj6y7SWXTV0CYIrEIMQvPhmA8MF5DpDthr
 gbWA==
X-Gm-Message-State: AFq9FYKMKk4eGSHLbH8tSLhif2c0rIGnbnKqSNDUCUP+3LJCUgNAtSVu
 0Z1eTXapfbFgBPpsZq094hlB2cyXJJnDsZXqZTypRPvlwppO3v5XTlsEk0yhhGtwiK7tysNZAQ6
 DSM4PNqk=
X-Gm-Gg: AYBFou1VKsJAAn1CWN3xZxqwnep5qvs5dC0pSA0MQ1pQW2XVDrvQbVB5bGG1eNl5xOR
 qPq4k6z4PSQyBd7jHMA3sFrwFRfus5wM2nY60Jz4PKAs2/37RrtYlnoLk5I83SSxRxIwV4RkLWS
 yL+34TBN23B5I98bg0wA+yFSUSU0yLe0XPSeuJwxncvhSFfIkZ1TRdhTbWnvqVSdYPW5Xx4OAA8
 61pKWBuGoFCSkL6q1R8FgmmuywAQvb6YwUdbRvRs9X6PMo8NEp8vER8sjtxlEPX9wsP1vMHd9Qf
 3OPWqtjJ7QPHvbSwBMq03OG/WNCih2cvNK0WQr4fgiSqOVT8uSTl6RpeOfskS8EEV33TSmqUXnl
 BTrti4AFX7DczxXSL2BV60JUlMKD8dYRNEGQig1hJBxvmE9zYckkq6LX0PLZ4jY3sVOgUSNzpb1
 utIYY8BOLtz7zDcL6eIWRrh2/3NEFrAGkBdjoH4UorAhnhM8JO+mvSfAB11sI5Yro5cl/8EsCk7
 LX0fUFXGgmvAvDGf7A1TOIUmhpClWDMdpYH2xoeWoxShm5C1PcDooJO7dOUlpATgqV9GiR4gOwx
 31A=
X-Received: by 2002:a05:6000:298e:10b0:48c:7f53:9603 with SMTP id
 ffacd0b85a97d-48dba77d033mr30756403f8f.7.1792087743158; 
 Thu, 15 Oct 2026 11:09:03 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/16] hw/timer/stm32f2xx_timer: fix periodic mode and CEN
 handling
Date: Thu, 15 Oct 2026 19:08:45 +0100
Message-ID: <20261015180858.1863407-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Manuele Conti <manuele.conti@archimede-energia.com>

RM0090 timers count from 0 to ARR inclusive, with a period of ARR + 1,
including ARR == 0. Wrap CNT while running, arm an absolute expiry, and
delete the QEMU timer when CEN is cleared.

Freeze CNT in stopped_cnt while CEN is clear so TIM_CNT writes while
stopped are preserved and resume on enable. Return a stopped CNT verbatim
even when it is greater than ARR. Reset also deletes any pending event.

Migration compatibility is not required for these machine types, so use
version 2 as both the current and minimum VMState version and serialize
stopped_cnt directly.

Add qtests covering the timer period, prescaler, stopped CNT, ARR == 0,
update generation, and system reset.

Signed-off-by: Manuele Conti <manuele.conti@archimede-energia.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                        |   1 +
 include/hw/timer/stm32f2xx_timer.h |   2 +-
 hw/timer/stm32f2xx_timer.c         |  73 ++++++++++++----
 tests/qtest/stm32f405-timer-test.c | 136 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   2 +
 5 files changed, 195 insertions(+), 19 deletions(-)
 create mode 100644 tests/qtest/stm32f405-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ee661cc23a..8741ec001d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1216,6 +1216,7 @@ F: hw/misc/stm32f4xx_syscfg.c
 F: hw/misc/stm32f4xx_exti.c
 F: hw/misc/stm32_rcc.c
 F: include/hw/misc/stm32_rcc.h
+F: tests/qtest/stm32f405*
 
 Netduino 2
 M: Alistair Francis <alistair@alistair23.me>
diff --git a/include/hw/timer/stm32f2xx_timer.h b/include/hw/timer/stm32f2xx_timer.h
index 040e64d4992..6a9aeea998a 100644
--- a/include/hw/timer/stm32f2xx_timer.h
+++ b/include/hw/timer/stm32f2xx_timer.h
@@ -76,7 +76,6 @@ struct STM32F2XXTimerState {
     qemu_irq irq;
 
     int64_t tick_offset;
-    uint64_t hit_time;
     uint64_t freq_hz;
 
     uint32_t tim_cr1;
@@ -97,6 +96,7 @@ struct STM32F2XXTimerState {
     uint32_t tim_dcr;
     uint32_t tim_dmar;
     uint32_t tim_or;
+    uint32_t stopped_cnt;
 };
 
 #endif /* HW_STM32F2XX_TIMER_H */
diff --git a/hw/timer/stm32f2xx_timer.c b/hw/timer/stm32f2xx_timer.c
index 0442ac64adc..09c30f7af16 100644
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
@@ -71,27 +72,43 @@ static inline int64_t stm32f2xx_ns_to_ticks(STM32F2XXTimerState *s, int64_t t)
     return muldiv64(t, s->freq_hz, 1000000000ULL) / (s->tim_psc + 1);
 }
 
+static uint32_t stm32f2xx_timer_get_cnt(STM32F2XXTimerState *s, int64_t now)
+{
+    uint64_t period_ticks = (uint64_t)s->tim_arr + 1;
+
+    if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+        return s->stopped_cnt;
+    }
+
+    return (stm32f2xx_ns_to_ticks(s, now) - s->tick_offset) % period_ticks;
+}
+
 static void stm32f2xx_timer_set_alarm(STM32F2XXTimerState *s, int64_t now)
 {
-    uint64_t ticks;
-    int64_t now_ticks;
+    uint64_t period_ticks;
+    uint64_t remaining_ticks;
+    uint64_t delta_ns;
+    int64_t hit_time;
 
-    if (s->tim_arr == 0) {
+    if (!(s->tim_cr1 & TIM_CR1_CEN)) {
+        timer_del(s->timer);
         return;
     }
 
     DB_PRINT("Alarm set at: 0x%x\n", s->tim_cr1);
 
-    now_ticks = stm32f2xx_ns_to_ticks(s, now);
-    ticks = s->tim_arr - (now_ticks - s->tick_offset);
+    /* STM32 timers count from 0 to ARR inclusive. */
+    period_ticks = (uint64_t)s->tim_arr + 1;
+    remaining_ticks = period_ticks - stm32f2xx_timer_get_cnt(s, now);
 
-    DB_PRINT("Alarm set in %d ticks\n", (int) ticks);
+    DB_PRINT("Alarm set in %" PRIu64 " ticks\n", remaining_ticks);
 
-    s->hit_time = muldiv64((ticks + (uint64_t) now_ticks) * (s->tim_psc + 1),
-                               1000000000ULL, s->freq_hz);
+    delta_ns = muldiv64(remaining_ticks * (s->tim_psc + 1),
+                        1000000000ULL, s->freq_hz);
+    hit_time = now + delta_ns;
+    timer_mod(s->timer, hit_time);
 
-    timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->hit_time);
-    DB_PRINT("Wait Time: %" PRId64 " ticks\n", s->hit_time);
+    DB_PRINT("Wait Time: %" PRId64 " ticks\n", hit_time);
 }
 
 static void stm32f2xx_timer_reset(DeviceState *dev)
@@ -117,8 +134,10 @@ static void stm32f2xx_timer_reset(DeviceState *dev)
     s->tim_dcr = 0;
     s->tim_dmar = 0;
     s->tim_or = 0;
+    s->stopped_cnt = 0;
 
     s->tick_offset = stm32f2xx_ns_to_ticks(s, now);
+    timer_del(s->timer);
 }
 
 static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
@@ -148,8 +167,8 @@ static uint64_t stm32f2xx_timer_read(void *opaque, hwaddr offset,
     case TIM_CCER:
         return s->tim_ccer;
     case TIM_CNT:
-        return stm32f2xx_ns_to_ticks(s, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)) -
-               s->tick_offset;
+        return stm32f2xx_timer_get_cnt(s,
+                                       qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
     case TIM_PSC:
         return s->tim_psc;
     case TIM_ARR:
@@ -187,9 +206,23 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
     DB_PRINT("Write 0x%x, 0x%"HWADDR_PRIx"\n", value, offset);
 
     switch (offset) {
-    case TIM_CR1:
+    case TIM_CR1: {
+        bool was_enabled = s->tim_cr1 & TIM_CR1_CEN;
+        bool enable = value & TIM_CR1_CEN;
+
+        if (was_enabled && !enable) {
+            s->stopped_cnt = stm32f2xx_timer_get_cnt(s, now);
+        }
         s->tim_cr1 = value;
+
+        if (!was_enabled && enable) {
+            s->tick_offset = stm32f2xx_ns_to_ticks(s, now) - s->stopped_cnt;
+            stm32f2xx_timer_set_alarm(s, now);
+        } else if (was_enabled && !enable) {
+            timer_del(s->timer);
+        }
         return;
+    }
     case TIM_CR2:
         s->tim_cr2 = value;
         return;
@@ -220,7 +253,7 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
         s->tim_ccer = value;
         return;
     case TIM_PSC:
-        timer_val = stm32f2xx_ns_to_ticks(s, now) - s->tick_offset;
+        timer_val = stm32f2xx_timer_get_cnt(s, now);
         s->tim_psc = value & 0xFFFF;
         break;
     case TIM_CNT:
@@ -228,7 +261,9 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
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
@@ -261,6 +296,7 @@ static void stm32f2xx_timer_write(void *opaque, hwaddr offset,
      * requires a refresh of both tick_offset and the alarm.
      */
     s->tick_offset = stm32f2xx_ns_to_ticks(s, now) - timer_val;
+    s->stopped_cnt = timer_val;
     stm32f2xx_timer_set_alarm(s, now);
 }
 
@@ -272,8 +308,8 @@ static const MemoryRegionOps stm32f2xx_timer_ops = {
 
 static const VMStateDescription vmstate_stm32f2xx_timer = {
     .name = TYPE_STM32F2XX_TIMER,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_INT64(tick_offset, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_cr1, STM32F2XXTimerState),
@@ -294,6 +330,7 @@ static const VMStateDescription vmstate_stm32f2xx_timer = {
         VMSTATE_UINT32(tim_dcr, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_dmar, STM32F2XXTimerState),
         VMSTATE_UINT32(tim_or, STM32F2XXTimerState),
+        VMSTATE_UINT32(stopped_cnt, STM32F2XXTimerState),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/tests/qtest/stm32f405-timer-test.c b/tests/qtest/stm32f405-timer-test.c
new file mode 100644
index 00000000000..f150da12357
--- /dev/null
+++ b/tests/qtest/stm32f405-timer-test.c
@@ -0,0 +1,136 @@
+/*
+ * STM32F405 timer tests
+ *
+ * Copyright (c) 2026 Manuele Conti <manuele.conti@archimede-energia.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define TIM2_BASE       0x40000000
+#define TIM_CR1         (TIM2_BASE + 0x00)
+#define TIM_DIER        (TIM2_BASE + 0x0c)
+#define TIM_SR          (TIM2_BASE + 0x10)
+#define TIM_EGR         (TIM2_BASE + 0x14)
+#define TIM_CNT         (TIM2_BASE + 0x24)
+#define TIM_PSC         (TIM2_BASE + 0x28)
+#define TIM_ARR         (TIM2_BASE + 0x2c)
+
+#define TIM_CR1_CEN     (1U << 0)
+#define TIM_DIER_UIE    (1U << 0)
+#define TIM_SR_UIF      (1U << 0)
+#define TIM_EGR_UG      (1U << 0)
+
+static void timer_reset(void)
+{
+    qtest_system_reset(global_qtest);
+}
+
+static void test_period_and_update(void)
+{
+    timer_reset();
+    writel(TIM_PSC, 0);
+    writel(TIM_ARR, 4);
+    writel(TIM_CNT, 0);
+    writel(TIM_DIER, TIM_DIER_UIE);
+    writel(TIM_CR1, TIM_CR1_CEN);
+
+    clock_step(4);
+    g_assert_cmphex(readl(TIM_CNT), ==, 4);
+    g_assert_cmphex(readl(TIM_SR), ==, 0);
+
+    clock_step(1);
+    g_assert_cmphex(readl(TIM_CNT), ==, 0);
+    g_assert_cmphex(readl(TIM_SR), ==, TIM_SR_UIF);
+
+    writel(TIM_SR, 0);
+    g_assert_cmphex(readl(TIM_SR), ==, 0);
+}
+
+static void test_prescaler(void)
+{
+    timer_reset();
+    writel(TIM_PSC, 9);
+    writel(TIM_ARR, 4);
+    writel(TIM_CNT, 0);
+    writel(TIM_CR1, TIM_CR1_CEN);
+
+    clock_step(40);
+    g_assert_cmphex(readl(TIM_CNT), ==, 4);
+    clock_step(10);
+    g_assert_cmphex(readl(TIM_CNT), ==, 0);
+}
+
+static void test_stopped_counter(void)
+{
+    timer_reset();
+    writel(TIM_ARR, 100);
+    writel(TIM_CNT, 200);
+    g_assert_cmphex(readl(TIM_CNT), ==, 200);
+
+    writel(TIM_CNT, 37);
+    writel(TIM_CR1, TIM_CR1_CEN);
+    clock_step(10);
+    g_assert_cmphex(readl(TIM_CNT), ==, 47);
+
+    writel(TIM_CR1, 0);
+    clock_step(100);
+    g_assert_cmphex(readl(TIM_CNT), ==, 47);
+
+    writel(TIM_CR1, TIM_CR1_CEN);
+    clock_step(1);
+    g_assert_cmphex(readl(TIM_CNT), ==, 48);
+}
+
+static void test_arr_zero(void)
+{
+    timer_reset();
+    writel(TIM_ARR, 0);
+    writel(TIM_CNT, 0);
+    writel(TIM_DIER, TIM_DIER_UIE);
+    writel(TIM_CR1, TIM_CR1_CEN);
+
+    clock_step(1);
+    g_assert_cmphex(readl(TIM_CNT), ==, 0);
+    g_assert_cmphex(readl(TIM_SR), ==, TIM_SR_UIF);
+}
+
+static void test_update_and_reset(void)
+{
+    timer_reset();
+    writel(TIM_ARR, 20);
+    writel(TIM_CNT, 12);
+    writel(TIM_EGR, TIM_EGR_UG);
+    g_assert_cmphex(readl(TIM_CNT), ==, 0);
+
+    writel(TIM_DIER, TIM_DIER_UIE);
+    writel(TIM_CR1, TIM_CR1_CEN);
+    qtest_system_reset(global_qtest);
+    clock_step(100);
+    g_assert_cmphex(readl(TIM_CR1), ==, 0);
+    g_assert_cmphex(readl(TIM_SR), ==, 0);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/stm32f405/timer/period-and-update",
+                   test_period_and_update);
+    qtest_add_func("/stm32f405/timer/prescaler", test_prescaler);
+    qtest_add_func("/stm32f405/timer/stopped-counter",
+                   test_stopped_counter);
+    qtest_add_func("/stm32f405/timer/arr-zero", test_arr_zero);
+    qtest_add_func("/stm32f405/timer/update-and-reset",
+                   test_update_and_reset);
+
+    qtest_start("-machine olimex-stm32-h405");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 200abf6f36d..69bebe5a396 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -253,6 +253,8 @@ qtests_exynos4210 = \
   ['exynos4210_uart_fifo-test']
 
 qtests_arm = \
+  (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
+   ['stm32f405-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
-- 
2.43.0


