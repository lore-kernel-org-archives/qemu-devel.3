Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B06C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 07:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlNat-0004hS-F7; Fri, 21 Feb 2025 02:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.chichkov@yadro.com>)
 id 1tlNaq-0004gY-3E
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 02:37:04 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.chichkov@yadro.com>)
 id 1tlNam-000230-4B
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 02:37:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 55933E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1740123413; bh=+hAaey3c0vfYnrIEX+xaF6kSjeIEmCU+qHqKYmepm2M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=IuvApOzEscktr3WY7cXbJZksIR0atlxWGfYX9sIGFSwHYj/tYX5CmusrTiXhYAJPG
 68K6CtEA9L0pqRP4GtqJdeSqzGCXNb/m2sffxlh4tdaaVJNhfzcZ6fGK+5Qcuyin71
 iN6zu9CwkmktqNEH+TqZ5FpCXqaaUH4T2jv4aPTOIaA5zG2t6T+J9ncEjYjHh/qxtg
 d3Iuzb75HsS57mDF58OJzvAuTBulIEQLza+6o8TU3CugzNh/+D4/0783scfwa0B41g
 mbuaIHrRnbstJ6KTFNG4xWiU99UcudYHa/v/0MAht+py4ki4KInh/hsCF6OzYVCCty
 QxvwLddOhcpeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1740123413; bh=+hAaey3c0vfYnrIEX+xaF6kSjeIEmCU+qHqKYmepm2M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=qOD2jdMf8BdcuVH/69CJacTxvFO8Ae+A3L2ggKezOQESdr8qmxG3Wh+OvPmjoQGy4
 u2sAIk38NdbullU4gtnhCM3LhvAxhi/CcYpyFo+mK6kZX1dyyse+MzVriRDW+cdbSu
 ggQ/n4jYtd9RPkSmxICsEKNqpvh62Z+szxY86qHA+ubCK715eQggFC4svq6beyqCWO
 CzKlUqMz3H7rvKNTdF/u/MrlmQEBsMROUHc7J1RNVb+WcurIM/I6mTS/vBjgpC0Yer
 UHQnRMhL2+mI2JrsWfqCoEisdm20lMgNSsOQnX5mjMbmjgnjR1oxtQuY6GvYzN5ci2
 Xb4QEFnDWZOIg==
From: Ilya Chichkov <i.chichkov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, Ilya Chichkov <i.chichkov@yadro.com>
Subject: [PATCH] hw/rtc: Add RTC PCF8563 module
Date: Fri, 21 Feb 2025 10:34:44 +0300
Message-ID: <20250221073444.15257-1-i.chichkov@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: pass client-ip=89.207.88.253; envelope-from=i.chichkov@yadro.com;
 helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add PCF8563 a real-time clock with calendar and I2C interface.
This commit adds support for interfacing with it and implements
functionality of setting timer, alarm, reading and writing time.

Datasheet: https://www.micros.com.pl/mediaserver/UZPCF8563ts5_0001.pdf

Signed-off-by: Ilya Chichkov <i.chichkov@yadro.com>
---
 hw/rtc/Kconfig       |   5 +
 hw/rtc/meson.build   |   1 +
 hw/rtc/pcf8563_rtc.c | 638 +++++++++++++++++++++++++++++++++++++++++++
 hw/rtc/trace-events  |  11 +
 4 files changed, 655 insertions(+)
 create mode 100644 hw/rtc/pcf8563_rtc.c

diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index d0d8dda084..fd7bd393bd 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -30,3 +30,8 @@ config GOLDFISH_RTC
 
 config LS7A_RTC
     bool
+
+config PCF8563_RTC
+    bool
+    depends on I2C
+    default y if I2C_DEVICES
diff --git a/hw/rtc/meson.build b/hw/rtc/meson.build
index 3ea2affe0b..959541a96d 100644
--- a/hw/rtc/meson.build
+++ b/hw/rtc/meson.build
@@ -14,3 +14,4 @@ system_ss.add(when: 'CONFIG_GOLDFISH_RTC', if_true: files('goldfish_rtc.c'))
 system_ss.add(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-rtc.c'))
 system_ss.add(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc.c'))
+system_ss.add(when: 'CONFIG_PCF8563_RTC', if_true: files('pcf8563_rtc.c'))
diff --git a/hw/rtc/pcf8563_rtc.c b/hw/rtc/pcf8563_rtc.c
new file mode 100644
index 0000000000..63d5f95c42
--- /dev/null
+++ b/hw/rtc/pcf8563_rtc.c
@@ -0,0 +1,638 @@
+/*
+ * Real-time clock/caread_indexdar PCF8563 with I2C interface.
+ *
+ * Copyright (c) 2024 Ilya Chichkov <i.chichkov@yadro.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/register.h"
+#include "hw/registerfields.h"
+#include "hw/irq.h"
+#include "qemu/bitops.h"
+#include "hw/qdev-properties.h"
+#include "qemu/timer.h"
+#include "qapi/error.h"
+#include "hw/i2c/i2c.h"
+#include "qemu/bcd.h"
+#include "qemu/module.h"
+#include "qom/object.h"
+#include "sysemu/rtc.h"
+#include "migration/vmstate.h"
+#include "qapi/visitor.h"
+#include "qemu/log.h"
+
+#include "trace.h"
+
+#define TYPE_PCF8563 "pcf8563"
+
+#define PCF8563(obj) \
+    OBJECT_CHECK(Pcf8563State, (obj), TYPE_PCF8563)
+
+#define  PCF8563_CS1            0x00
+#define  PCF8563_CS2            0x01
+#define  PCF8563_VLS            0x02
+#define  PCF8563_MINUTES        0x03
+#define  PCF8563_HOURS          0x04
+#define  PCF8563_DAYS           0x05
+#define  PCF8563_WEEKDAYS       0x06
+#define  PCF8563_CENTURY_MONTHS 0x07
+#define  PCF8563_YEARS          0x08
+#define  PCF8563_MINUTE_A       0x09
+#define  PCF8563_HOUR_A         0x0A
+#define  PCF8563_DAY_A          0x0B
+#define  PCF8563_WEEKDAY_A      0x0C
+#define  PCF8563_CLKOUT_CTL     0x0D
+#define  PCF8563_TIMER_CTL      0x0E
+#define  PCF8563_TIMER          0x0F
+
+REG8(PCF8563_CS1, 0x00)
+    FIELD(PCF8563_CS1, RSVD0,  0,  3)
+    FIELD(PCF8563_CS1, TESTC,  3,  1)
+    FIELD(PCF8563_CS1, RSVD1,  4,  1)
+    FIELD(PCF8563_CS1, STOP,   5,  1)
+    FIELD(PCF8563_CS1, RSVD2,  6,  1)
+    FIELD(PCF8563_CS1, TEST1,  7,  1)
+
+REG8(PCF8563_CS2, 0x01)
+    FIELD(PCF8563_CS2, TIE,   0,  1)
+    FIELD(PCF8563_CS2, AIE,   1,  1)
+    FIELD(PCF8563_CS2, TF,    2,  1)
+    FIELD(PCF8563_CS2, AF,    3,  1)
+    FIELD(PCF8563_CS2, TI_TP, 4,  1)
+    FIELD(PCF8563_CS2, RSVD,  5,  3)
+
+REG8(PCF8563_VLS, 0x02)
+    FIELD(PCF8563_VLS, SECONDS,  0,  7)
+    FIELD(PCF8563_VLS, VL,       7,  1)
+
+REG8(PCF8563_MINUTES, 0x03)
+    FIELD(PCF8563_MINUTES, MINUTES, 0,  7)
+    FIELD(PCF8563_MINUTES, RSVD,    7,  1)
+
+REG8(PCF8563_HOURS, 0x04)
+    FIELD(PCF8563_HOURS, HOURS, 0,  6)
+    FIELD(PCF8563_HOURS, RSVD,  6,  2)
+
+REG8(PCF8563_DAYS, 0x05)
+    FIELD(PCF8563_DAYS, DAYS, 0,  6)
+    FIELD(PCF8563_DAYS, RSVD, 6,  2)
+
+REG8(PCF8563_WEEKDAYS, 0x06)
+    FIELD(PCF8563_WEEKDAYS, WEEKDAYS, 0,  3)
+    FIELD(PCF8563_WEEKDAYS, RSVD,     3,  5)
+
+REG8(PCF8563_CENTURY_MONTHS, 0x07)
+    FIELD(PCF8563_CENTURY_MONTHS, MONTHS,  0,  5)
+    FIELD(PCF8563_CENTURY_MONTHS, RSVD,    5,  2)
+    FIELD(PCF8563_CENTURY_MONTHS, CENTURY, 7,  1)
+
+REG8(PCF8563_YEARS, 0x08)
+    FIELD(PCF8563_YEARS, YEARS, 0,  8)
+
+REG8(PCF8563_MINUTE_A, 0x09)
+    FIELD(PCF8563_MINUTE_A, MINUTE_A, 0,  7)
+    FIELD(PCF8563_MINUTE_A, AE_M,     7,  1)
+
+REG8(PCF8563_HOUR_A, 0x0A)
+    FIELD(PCF8563_HOUR_A, HOUR_A, 0,  7)
+    FIELD(PCF8563_HOUR_A, AE_H,   7,  1)
+
+REG8(PCF8563_DAY_A, 0x0B)
+    FIELD(PCF8563_DAY_A, DAY_A,  0,  7)
+    FIELD(PCF8563_DAY_A, AE_D,   7,  1)
+
+REG8(PCF8563_WEEKDAY_A, 0x0C)
+    FIELD(PCF8563_WEEKDAY_A, WEEKDAY_A, 0,  3)
+    FIELD(PCF8563_WEEKDAY_A, RSVD,      3,  4)
+    FIELD(PCF8563_WEEKDAY_A, AE_W,      7,  1)
+
+REG8(PCF8563_CLKOUT_CTL, 0x0D)
+    FIELD(PCF8563_CLKOUT_CTL, FD,   0,  2)
+    FIELD(PCF8563_CLKOUT_CTL, RSVD, 2,  5)
+    FIELD(PCF8563_CLKOUT_CTL, FE,   7,  1)
+
+REG8(PCF8563_TIMER_CTL, 0x0E)
+    FIELD(PCF8563_TIMER_CTL, TD,   0,  2)
+    FIELD(PCF8563_TIMER_CTL, RSVD, 2,  5)
+    FIELD(PCF8563_TIMER_CTL, TE,   7,  1)
+
+REG8(PCF8563_TIMER, 0x0F)
+    FIELD(PCF8563_TIMER, TIMER, 0,  8)
+
+typedef struct Pcf8563State {
+    /*< private >*/
+    I2CSlave i2c;
+
+    qemu_irq irq;
+
+    uint8_t read_index;
+    uint8_t write_index;
+    uint8_t reg_addr;
+
+    /* Control and status */
+    uint8_t cs1;
+    uint8_t cs2;
+    /* Counters */
+    uint8_t vls;
+    uint8_t minutes;
+    uint8_t hours;
+    uint8_t days;
+    uint8_t weekdays;
+    uint8_t centure_months;
+    uint8_t years;
+    /* Alarm registers */
+    uint8_t minute_a;
+    uint8_t hour_a;
+    uint8_t day_a;
+    uint8_t weekday_a;
+    /* Timer control */
+    uint8_t clkout_ctl;
+    uint8_t timer_ctl;
+    uint8_t timer_cnt;
+
+    QEMUTimer *alarm_timer;
+    struct tm tm_alarm;
+    bool alarm_irq;
+    QEMUTimer *timer;
+    time_t time_offset;
+    time_t stop_time;
+    QEMUTimer *irq_gen_timer;
+} Pcf8563State;
+
+static uint16_t get_src_freq(Pcf8563State *s, bool *multiply)
+{
+    *multiply = false;
+    /* Select source clock frequency (Hz) */
+    switch (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD)) {
+    case 0:
+        return 4096;
+    case 1:
+        return 64;
+    case 2:
+        return 1;
+    case 3:
+        *multiply = true;
+        return 60;
+    default:
+        return 0;
+    }
+}
+
+static uint16_t get_irq_pulse_freq(Pcf8563State *s)
+{
+    if (s->timer_cnt > 1) {
+        switch (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD)) {
+        case 0:
+            return 8192;
+        case 1:
+            return 128;
+        case 2:
+        case 3:
+            return 64;
+        default:
+            return 0;
+        }
+    } else {
+        if (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD) == 0) {
+            return 4096;
+        }
+        return 64;
+    }
+
+}
+
+static void pcf8563_update_irq(Pcf8563State *s)
+{
+    if (!FIELD_EX8(s->cs2, PCF8563_CS2, TF) &&
+        !FIELD_EX8(s->cs2, PCF8563_CS2, AF)) {
+        return;
+    }
+
+    /* Timer interrupt */
+    if (FIELD_EX8(s->cs2, PCF8563_CS2, TIE)) {
+        if (FIELD_EX8(s->cs2, PCF8563_CS2, TI_TP)) {
+            qemu_irq_pulse(s->irq);
+
+            /* Start IRQ pulse generator */
+            uint64_t delay = s->timer_cnt *
+                            NANOSECONDS_PER_SECOND *
+                            get_irq_pulse_freq(s);
+            timer_mod(s->irq_gen_timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay);
+        } else {
+            qemu_irq_raise(s->irq);
+        }
+    }
+
+    /* Alarm interrupt */
+    if (FIELD_EX8(s->cs2, PCF8563_CS2, AIE)) {
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static void alarm_timer_cb(void *opaque)
+{
+    Pcf8563State *s = PCF8563(opaque);
+
+    s->cs2 = FIELD_DP8(s->cs2, PCF8563_CS2, AF, 1);
+    pcf8563_update_irq(s);
+}
+
+static void timer_cb(void *opaque)
+{
+    Pcf8563State *s = PCF8563(opaque);
+
+    s->cs2 = FIELD_DP8(s->cs2, PCF8563_CS2, TF, 1);
+    pcf8563_update_irq(s);
+}
+
+static void irq_gen_timer_cb(void *opaque)
+{
+    Pcf8563State *s = PCF8563(opaque);
+
+    pcf8563_update_irq(s);
+}
+
+static void set_alarm(Pcf8563State *s)
+{
+    /* Update alarm */
+    int64_t diff_sec;
+    if (s->alarm_timer != NULL) {
+        timer_del(s->alarm_timer);
+        diff_sec = qemu_timedate_diff(&s->tm_alarm);
+        if (diff_sec > 0) {
+            timer_mod_ns(s->alarm_timer, diff_sec * NANOSECONDS_PER_SECOND);
+        }
+
+        trace_pcf8563_rtc_set_alarm();
+    }
+}
+
+static inline void get_time(Pcf8563State *s, struct tm *tm)
+{
+    qemu_get_timedate(tm, s->time_offset);
+
+    trace_pcf8563_rtc_get_time();
+}
+
+static void set_time(Pcf8563State *s, struct tm *tm)
+{
+    s->time_offset = qemu_timedate_diff(tm);
+    set_alarm(s);
+
+    trace_pcf8563_rtc_set_time();
+}
+
+static void pcf8563_reset(I2CSlave *i2c)
+{
+    Pcf8563State *s = PCF8563(i2c);
+
+    s->read_index = 0;
+    s->write_index = 0;
+    s->reg_addr = 0;
+
+    s->cs1 = 0x8;
+    s->cs2 = 0x0;
+    s->vls = 0x80;
+    s->minutes = 0x0;
+    s->hours = 0x0;
+    s->days = 0x0;
+    s->weekdays = 0x0;
+    s->centure_months = 0x0;
+    s->years = 0x0;
+    s->minute_a = 0x80;
+    s->hour_a = 0x80;
+    s->day_a = 0x80;
+    s->weekday_a = 0x80;
+    s->clkout_ctl = 0x80;
+    s->timer_ctl = 0x3;
+    s->timer_cnt = 0x0;
+
+    s->reg_addr = 0;
+    s->time_offset = 0;
+
+    s->alarm_irq = false;
+
+    qemu_get_timedate(&s->tm_alarm, 0);
+}
+
+static void pcf8563_read(Pcf8563State *s, uint8_t *result)
+{
+    struct tm tm;
+
+    switch (s->reg_addr) {
+    case PCF8563_CS1:
+        *result = s->cs1;
+        break;
+    case PCF8563_CS2:
+        *result = s->cs2;
+        break;
+    case PCF8563_VLS:
+        get_time(s, &tm);
+        *result = (s->vls & 0x80) | to_bcd(tm.tm_sec);
+        break;
+    case PCF8563_MINUTES:
+        get_time(s, &tm);
+        *result = to_bcd(tm.tm_min);
+        break;
+    case PCF8563_HOURS:
+        get_time(s, &tm);
+        *result = to_bcd(tm.tm_hour);
+        break;
+    case PCF8563_DAYS:
+        get_time(s, &tm);
+        *result = to_bcd(tm.tm_mday);
+        break;
+    case PCF8563_WEEKDAYS:
+        get_time(s, &tm);
+        *result = to_bcd(tm.tm_wday);
+        break;
+    case PCF8563_CENTURY_MONTHS:
+        get_time(s, &tm);
+        *result = to_bcd(tm.tm_mon + 1);
+        break;
+    case PCF8563_YEARS:
+        get_time(s, &tm);
+        *result = to_bcd((tm.tm_year + 1900) % 100);
+        break;
+    case PCF8563_MINUTE_A:
+        *result = s->minute_a;
+        break;
+    case PCF8563_HOUR_A:
+        *result = s->hour_a;
+        break;
+    case PCF8563_DAY_A:
+        *result = s->day_a;
+        break;
+    case PCF8563_WEEKDAY_A:
+        *result = s->weekday_a;
+        break;
+    case PCF8563_CLKOUT_CTL:
+        *result = s->clkout_ctl;
+        break;
+    case PCF8563_TIMER_CTL:
+        *result = s->timer_ctl;
+        break;
+    case PCF8563_TIMER:
+        *result = s->timer_cnt;
+        break;
+    }
+}
+
+static void pcf8563_write(Pcf8563State *s, uint8_t val)
+{
+    struct tm tm;
+    int tmp;
+
+    switch (s->reg_addr) {
+    case PCF8563_CS1:
+        s->cs1 = val & 0xa8;
+        break;
+    case PCF8563_CS2:
+        s->cs2 = val & 0x1f;
+        break;
+    case PCF8563_VLS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_VLS, SECONDS));
+        if (tmp >= 0 && tmp <= 59) {
+            get_time(s, &tm);
+            tm.tm_sec = tmp;
+            set_time(s, &tm);
+        }
+
+        bool vl = FIELD_EX8(val, PCF8563_VLS, VL);
+
+        if (vl ^ (s->vls & 0x80)) {
+            if (vl) {
+                s->stop_time = time(NULL);
+            } else {
+                s->time_offset += s->stop_time - time(NULL);
+                s->stop_time = 0;
+            }
+        }
+
+        s->vls = vl << 8;
+        break;
+    case PCF8563_MINUTES:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_MINUTES, MINUTES));
+        if (tmp >= 0 && tmp <= 59) {
+            s->minutes = val;
+            get_time(s, &tm);
+            tm.tm_min = tmp;
+            set_time(s, &tm);
+        }
+        break;
+    case PCF8563_HOURS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_HOURS, HOURS));
+        if (tmp >= 0 && tmp <= 23) {
+            s->hours = val;
+            get_time(s, &tm);
+            tm.tm_hour = tmp;
+            set_time(s, &tm);
+        }
+        break;
+    case PCF8563_DAYS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_DAYS, DAYS));
+        if (tmp >= 1 && tmp <= 31) {
+            s->hours = val;
+            get_time(s, &tm);
+            tm.tm_hour = tmp;
+            set_time(s, &tm);
+        }
+        break;
+    case PCF8563_WEEKDAYS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_WEEKDAYS, WEEKDAYS));
+        if (tmp >= 0 && tmp <= 6) {
+            s->weekdays = val;
+            get_time(s, &tm);
+            tm.tm_wday = tmp;
+            set_time(s, &tm);
+        }
+        break;
+    case PCF8563_CENTURY_MONTHS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_CENTURY_MONTHS, MONTHS));
+        if (tmp >= 0 && tmp <= 6) {
+            s->weekdays = val;
+            get_time(s, &tm);
+            tm.tm_wday = tmp;
+            set_time(s, &tm);
+        }
+        break;
+    case PCF8563_YEARS:
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_YEARS, YEARS));
+        if (tmp >= 0 && tmp <= 99) {
+            s->years = val;
+            get_time(s, &tm);
+            tm.tm_year = tmp;
+            set_time(s, &tm);
+        }
+        break;
+    case PCF8563_MINUTE_A:
+        s->minute_a = val;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_MINUTE_A, MINUTE_A));
+        if (tmp >= 0 && tmp <= 59) {
+            s->tm_alarm.tm_min = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_HOUR_A:
+        s->hour_a = val & 0xbf;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_HOUR_A, HOUR_A));
+        if (tmp >= 0 && tmp <= 23) {
+            s->tm_alarm.tm_hour = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_DAY_A:
+        s->day_a = val & 0xbf;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_DAY_A, DAY_A));
+        if (tmp >= 1 && tmp <= 31) {
+            s->tm_alarm.tm_mday = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_WEEKDAY_A:
+        s->weekday_a = val & 0x87;
+        tmp = from_bcd(FIELD_EX8(val, PCF8563_WEEKDAY_A, WEEKDAY_A));
+        if (tmp >= 0 && tmp <= 6) {
+            s->tm_alarm.tm_wday = tmp;
+            set_alarm(s);
+        }
+        break;
+    case PCF8563_CLKOUT_CTL:
+        s->clkout_ctl = val & 0x83;
+        break;
+    case PCF8563_TIMER_CTL:
+        s->timer_ctl = val & 0x83;
+        break;
+    case PCF8563_TIMER:
+        s->timer_cnt = val;
+        if (FIELD_EX32(s->timer_ctl, PCF8563_TIMER_CTL, TE)) {
+            bool multiply = false;
+            uint16_t src_freq = get_src_freq(s, &multiply);
+            uint64_t delay = 0;
+
+            /* Calculate timer's delay in ns based on value and set it up */
+            if (multiply) {
+                delay = val * NANOSECONDS_PER_SECOND * src_freq;
+            } else {
+                delay = val * NANOSECONDS_PER_SECOND / src_freq;
+            }
+            timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay);
+        }
+        break;
+    }
+}
+
+static uint8_t pcf8563_rx(I2CSlave *i2c)
+{
+    Pcf8563State *s = PCF8563(i2c);
+    uint8_t result = 0xff;
+
+    pcf8563_read(s, &result);
+    /* Auto-increment register address */
+    s->reg_addr++;
+
+    trace_pcf8563_rtc_read(s->read_index, result);
+    return result;
+}
+
+static int pcf8563_tx(I2CSlave *i2c, uint8_t data)
+{
+    Pcf8563State *s = PCF8563(i2c);
+
+    if (s->write_index == 0) {
+        /* Receive register address */
+        s->reg_addr = data;
+        s->write_index++;
+        trace_pcf8563_rtc_write_addr(data);
+    } else {
+        /* Receive data to write */
+        pcf8563_write(s, data);
+        s->write_index++;
+        s->reg_addr++;
+        trace_pcf8563_rtc_write_data(data);
+    }
+    return 0;
+}
+
+static int pcf8563_event(I2CSlave *i2c, enum i2c_event event)
+{
+    trace_pcf8563_rtc_event(event);
+    Pcf8563State *s = PCF8563(i2c);
+
+    switch (event) {
+    case I2C_FINISH:
+        s->read_index = 0;
+        s->write_index = 0;
+    default:
+        break;
+    }
+    return 0;
+}
+
+static const VMStateDescription vmstate_pcf8563 = {
+    .name = "PCF8563",
+    .version_id = 0,
+    .minimum_version_id = 0,
+};
+
+static void pcf8563_realize(DeviceState *dev, Error **errp)
+{
+    I2CSlave *i2c = I2C_SLAVE(dev);
+    Pcf8563State *s = PCF8563(i2c);
+
+    s->alarm_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &alarm_timer_cb, s);
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &timer_cb, s);
+    s->irq_gen_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &irq_gen_timer_cb, s);
+
+    pcf8563_reset(i2c);
+}
+
+static void pcf8563_init(Object *obj)
+{
+    Pcf8563State *s = PCF8563(obj);
+
+    qdev_init_gpio_out(DEVICE(s), &s->irq, 1);
+}
+
+static void pcf8563_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
+
+    k->event = pcf8563_event;
+    k->recv = pcf8563_rx;
+    k->send = pcf8563_tx;
+    dc->realize = pcf8563_realize;
+    dc->vmsd = &vmstate_pcf8563;
+
+    trace_pcf8563_rtc_init();
+}
+
+static const TypeInfo pcf8563_device_info = {
+    .name          = TYPE_PCF8563,
+    .parent        = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(Pcf8563State),
+    .instance_init = pcf8563_init,
+    .class_init    = pcf8563_class_init,
+};
+
+static void pcf8563_register_types(void)
+{
+    type_register_static(&pcf8563_device_info);
+}
+
+type_init(pcf8563_register_types)
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index ebb311a5b0..446017f512 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -31,3 +31,14 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x val
 # goldfish_rtc.c
 goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+
+# pcf8563_rtc.c
+pcf8563_rtc_write_data(uint8_t data) "data: 0x%x"
+pcf8563_rtc_write_addr(uint8_t addr) "register address: 0x%x"
+pcf8563_rtc_read(uint8_t addr, uint8_t data) "addr: 0x%x, data: 0x%x"
+pcf8563_rtc_event(uint8_t event) "Event: 0x%x"
+pcf8563_rtc_init(void)
+pcf8563_rtc_reset(void)
+pcf8563_rtc_set_time(void)
+pcf8563_rtc_get_time(void)
+pcf8563_rtc_set_alarm(void)
-- 
2.34.1


