Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C9C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 20:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvMOG-0000sz-Hr; Thu, 20 Mar 2025 16:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tvMOD-0000sa-Pu
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:21:18 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tvMOA-0006iT-DG
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 16:21:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so1939269a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742502071; x=1743106871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0HtNq6Er9OBg+aCTJqYT3cnco2Ah8ZEAsHEr6xP5S38=;
 b=OmH396G5xbuFJSUZS1m5B2brkVK70WzvjGV1VGDp+/0SJ7YAo839Fa5iPhLp5Zqjlx
 kgiS0ulf5GpVvSBDjLeFgd02sJFjbX+d+RDL+VypAYxohy7kFVXMA9jcxXQlqzxcKuzs
 IVgUmzSrA1XL9oy0S7RTnJSkrehzLhKb4KGpVtgVP22DqK+JPN6rGD1upepCNDBTNmuw
 S9cLj+goEIOvIy+7Vh+cADDmhi3ImXPEFv/GWltNeejKLPf5rfRXQOiCm01bxScDo2Ub
 UtnDXQboLGFgP61nNs9ai+PEXHK7Zt/BopPtLa7yYa3/rTCMztokwyoTfjua/Kp148az
 /n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742502071; x=1743106871;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HtNq6Er9OBg+aCTJqYT3cnco2Ah8ZEAsHEr6xP5S38=;
 b=D9q+jJ3QYLqPSRdMfjqewX4N33cxjB49InT/VFcbSR3YwgFeWk2S0TBghJi/HgYjcX
 7wxd8BgjqaQztywuyeg600jcZGDABPb7Kv/OaASTbYSyk1CrcXbhy0QEUjTYHHln0Pkk
 jJwEkQ8ElJ6sTJUz7tbeEShyWoh74CrYxFcPosjZ3lIo3OXOUw0vlgVghMpgm7w5DVWs
 Ph9UGuG0CwLKRq4r4xqpzA9x3DcDtpiQGMoeoUNic9qouGUgYclaPl5K69/Bw6U7uewo
 kk1haRiUvzr7ARnDnwOVQqYdqHh++ZGDLoMYPGT1FVg652oQSEEEPheZqniR5HBztQqj
 DDBA==
X-Gm-Message-State: AOJu0YzzFY4kV2gk9yNpqQXAE45m37FtZUaAbmr2BmOT5f+gliYqMQGP
 XZX/pi9yt4p9BaShge3QJirEh3SKwp+XG8Mu9qbz1iYhlA1yrRfBMUqO3Q==
X-Gm-Gg: ASbGnctfQvWKW3sd1X4ALWIHuU9ZSoaNY83fVtdJ0pab5GOLQkjW0adzAalK1Jj8rCj
 3lVlyMkEF6nOgmSnFTwPwqud4wzZ1/4+LjJHScXrYbb28xX75Uh7cJad57D7Weuu0tl8G3ySK8u
 BlQZ2BJCE/OFztBTK8h2UtRAhAPBxUMQLomypdAtSmvGBXLXCRqbbrzj4kQvmYfKRU7ZH4YUGKr
 YG2MUlI1ENbrUuxJ8E3iOO3K1VA/CrjYIM0yDAKvyaLMG37kQosP06Vp74JStjqtbH8NnKf5mGt
 HmS2FuL2cjiHAWjaUQZ+HTh4nUpxYkG7/+nzNdL8tR9ujMJk5R3O4vThk+xPZq6NZAwycbuo6kT
 nF2cDASYSSBvst88t+o/qJ6m7EWL4E67NwT5n6TheizIOyRus1i9f
X-Google-Smtp-Source: AGHT+IGp6saZClzggLsMjgImc9D7yvy7mGe6CVsDK+7kuQItrltyoWXmbi2k5MiOSVlaNAl9miW2dw==
X-Received: by 2002:a05:6402:3508:b0:5e5:c0e7:f428 with SMTP id
 4fb4d7f45d1cf-5ebcd24cebfmr634882a12.0.1742502070982; 
 Thu, 20 Mar 2025 13:21:10 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-1a2e-5200-69d2-56f6-a5af-50a8.310.pool.telefonica.de.
 [2a02:3100:1a2e:5200:69d2:56f6:a5af:50a8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebcd0df501sm236894a12.69.2025.03.20.13.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 13:21:10 -0700 (PDT)
Date: Thu, 20 Mar 2025 19:22:35 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ilya Chichkov <i.chichkov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
CC: nikita.shubin@maquefel.me
Subject: Re: [PATCH v2] hw/rtc: Add RTC PCF8563 module
In-Reply-To: <20250310113635.349822-1-i.chichkov@yadro.com>
References: <20250310113635.349822-1-i.chichkov@yadro.com>
Message-ID: <0F90EED3-5010-4C2F-90F3-9C0C40A5C0ED@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 10=2E M=C3=A4rz 2025 11:36:34 UTC schrieb Ilya Chichkov <i=2Echichkov@y=
adro=2Ecom>:
>Add PCF8563 a real-time clock with calendar and I2C interface=2E
>This commit adds support for interfacing with it and implements
>functionality of setting timer, alarm, reading and writing time=2E
>
>Signed-off-by: Ilya Chichkov <i=2Echichkov@yadro=2Ecom>
>---
>v1->v2
>Phil:
>- Add hot reset
>- Fix trace message
>- Add testing coverage with qtest
>
>Bernhard:
>- Move datasheet link to source code top comment section
>- Fix typos
>- Update licence identifier to SPDX
>- Remove unused import libraries
>- Change OBJECT_CHECK to OBJECT_DECLARE_SIMPLE_TYPE
>- Remove outdated comment
>- Rename i2c to parent_obj
>- Moved get_time inside capture_time function that is
>  called only when I2C request starts
>- Add fields inside VMStateDescription
>- Removed pcf8563_realize
>- Change type_init to DEFINE_TYPES
>---
> hw/rtc/Kconfig       |   5 +
> hw/rtc/meson=2Ebuild   |   1 +
> hw/rtc/pcf8563_rtc=2Ec | 740 +++++++++++++++++++++++++++++++++++++++++++
> hw/rtc/trace-events  |  12 +
> 4 files changed, 758 insertions(+)
> create mode 100644 hw/rtc/pcf8563_rtc=2Ec
>
>diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
>index b90c2e510a=2E=2E4e7a1f75ef 100644
>--- a/hw/rtc/Kconfig
>+++ b/hw/rtc/Kconfig
>@@ -27,5 +27,10 @@ config GOLDFISH_RTC
> config LS7A_RTC
>     bool
>=20
>+config PCF8563_RTC
>+    bool
>+    depends on I2C
>+    default y if I2C_DEVICES
>+
> config STM32_RTC
>     bool
>\ No newline at end of file
>diff --git a/hw/rtc/meson=2Ebuild b/hw/rtc/meson=2Ebuild
>index b6bb7436c7=2E=2E6180ffc6d9 100644
>--- a/hw/rtc/meson=2Ebuild
>+++ b/hw/rtc/meson=2Ebuild
>@@ -13,4 +13,5 @@ system_ss=2Eadd(when: 'CONFIG_GOLDFISH_RTC', if_true: f=
iles('goldfish_rtc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-r=
tc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc=
=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_PCF8563_RTC', if_true: files('pcf8563_rtc=
=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_STM32_RTC', if_true: files('stm32-rtc=2Ec'=
))
>diff --git a/hw/rtc/pcf8563_rtc=2Ec b/hw/rtc/pcf8563_rtc=2Ec
>new file mode 100644
>index 0000000000=2E=2E195b697598
>--- /dev/null
>+++ b/hw/rtc/pcf8563_rtc=2Ec
>@@ -0,0 +1,740 @@
>+// SPDX-License-Identifier: GPL-2=2E0-or-later
>+/*
>+ * Real-time clock/calendar PCF8563 with I2C interface=2E
>+ *
>+ * Datasheet: https://www=2Enxp=2Ecom/docs/en/data-sheet/PCF8563=2Epdf
>+ *
>+ * Author (c) 2024 Ilya Chichkov <i=2Echichkov@yadro=2Ecom>
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "hw/sysbus=2Eh"
>+#include "hw/register=2Eh"
>+#include "hw/registerfields=2Eh"
>+#include "hw/irq=2Eh"
>+#include "qemu/bitops=2Eh"
>+#include "hw/qdev-properties=2Eh"
>+#include "qemu/timer=2Eh"
>+#include "hw/i2c/i2c=2Eh"
>+#include "qemu/bcd=2Eh"
>+#include "qom/object=2Eh"
>+#include "sysemu/sysemu=2Eh"
>+#include "sysemu/rtc=2Eh"
>+#include "migration/vmstate=2Eh"
>+#include "qapi/visitor=2Eh"
>+
>+#include "trace=2Eh"
>+
>+#define TYPE_PCF8563 "pcf8563"
>+OBJECT_DECLARE_SIMPLE_TYPE(Pcf8563State, PCF8563)
>+
>+#define  PCF8563_CS1            0x00
>+#define  PCF8563_CS2            0x01
>+#define  PCF8563_VLS            0x02
>+#define  PCF8563_MINUTES        0x03
>+#define  PCF8563_HOURS          0x04
>+#define  PCF8563_DAYS           0x05
>+#define  PCF8563_WEEKDAYS       0x06
>+#define  PCF8563_CENTURY_MONTHS 0x07
>+#define  PCF8563_YEARS          0x08
>+#define  PCF8563_MINUTE_A       0x09
>+#define  PCF8563_HOUR_A         0x0A
>+#define  PCF8563_DAY_A          0x0B
>+#define  PCF8563_WEEKDAY_A      0x0C
>+#define  PCF8563_CLKOUT_CTL     0x0D
>+#define  PCF8563_TIMER_CTL      0x0E
>+#define  PCF8563_TIMER          0x0F
>+
>+#define MINUTES_IN_HOUR 60
>+#define HOURS_IN_DAY 24
>+#define DAYS_IN_MONTH 31
>+#define DAYS_IN_WEEK 7
>+
>+REG8(PCF8563_CS1, 0x00)
>+    FIELD(PCF8563_CS1, RSVD0,  0,  3)
>+    FIELD(PCF8563_CS1, TESTC,  3,  1)
>+    FIELD(PCF8563_CS1, RSVD1,  4,  1)
>+    FIELD(PCF8563_CS1, STOP,   5,  1)
>+    FIELD(PCF8563_CS1, RSVD2,  6,  1)
>+    FIELD(PCF8563_CS1, TEST1,  7,  1)
>+
>+REG8(PCF8563_CS2, 0x01)
>+    FIELD(PCF8563_CS2, TIE,   0,  1)
>+    FIELD(PCF8563_CS2, AIE,   1,  1)
>+    FIELD(PCF8563_CS2, TF,    2,  1)
>+    FIELD(PCF8563_CS2, AF,    3,  1)
>+    FIELD(PCF8563_CS2, TI_TP, 4,  1)
>+    FIELD(PCF8563_CS2, RSVD,  5,  3)
>+
>+REG8(PCF8563_VLS, 0x02)
>+    FIELD(PCF8563_VLS, SECONDS,  0,  7)
>+    FIELD(PCF8563_VLS, VL,       7,  1)
>+
>+REG8(PCF8563_MINUTES, 0x03)
>+    FIELD(PCF8563_MINUTES, MINUTES, 0,  7)
>+    FIELD(PCF8563_MINUTES, RSVD,    7,  1)
>+
>+REG8(PCF8563_HOURS, 0x04)
>+    FIELD(PCF8563_HOURS, HOURS, 0,  6)
>+    FIELD(PCF8563_HOURS, RSVD,  6,  2)
>+
>+REG8(PCF8563_DAYS, 0x05)
>+    FIELD(PCF8563_DAYS, DAYS, 0,  6)
>+    FIELD(PCF8563_DAYS, RSVD, 6,  2)
>+
>+REG8(PCF8563_WEEKDAYS, 0x06)
>+    FIELD(PCF8563_WEEKDAYS, WEEKDAYS, 0,  3)
>+    FIELD(PCF8563_WEEKDAYS, RSVD,     3,  5)
>+
>+REG8(PCF8563_CENTURY_MONTHS, 0x07)
>+    FIELD(PCF8563_CENTURY_MONTHS, MONTHS,  0,  5)
>+    FIELD(PCF8563_CENTURY_MONTHS, RSVD,    5,  2)
>+    FIELD(PCF8563_CENTURY_MONTHS, CENTURY, 7,  1)
>+
>+REG8(PCF8563_YEARS, 0x08)
>+    FIELD(PCF8563_YEARS, YEARS, 0,  8)
>+
>+REG8(PCF8563_MINUTE_A, 0x09)
>+    FIELD(PCF8563_MINUTE_A, MINUTE_A, 0,  7)
>+    FIELD(PCF8563_MINUTE_A, AE_M,     7,  1)
>+
>+REG8(PCF8563_HOUR_A, 0x0A)
>+    FIELD(PCF8563_HOUR_A, HOUR_A, 0,  7)
>+    FIELD(PCF8563_HOUR_A, AE_H,   7,  1)
>+
>+REG8(PCF8563_DAY_A, 0x0B)
>+    FIELD(PCF8563_DAY_A, DAY_A,  0,  7)
>+    FIELD(PCF8563_DAY_A, AE_D,   7,  1)
>+
>+REG8(PCF8563_WEEKDAY_A, 0x0C)
>+    FIELD(PCF8563_WEEKDAY_A, WEEKDAY_A, 0,  3)
>+    FIELD(PCF8563_WEEKDAY_A, RSVD,      3,  4)
>+    FIELD(PCF8563_WEEKDAY_A, AE_W,      7,  1)
>+
>+REG8(PCF8563_CLKOUT_CTL, 0x0D)
>+    FIELD(PCF8563_CLKOUT_CTL, FD,   0,  2)
>+    FIELD(PCF8563_CLKOUT_CTL, RSVD, 2,  5)
>+    FIELD(PCF8563_CLKOUT_CTL, FE,   7,  1)
>+
>+REG8(PCF8563_TIMER_CTL, 0x0E)
>+    FIELD(PCF8563_TIMER_CTL, TD,   0,  2)
>+    FIELD(PCF8563_TIMER_CTL, RSVD, 2,  5)
>+    FIELD(PCF8563_TIMER_CTL, TE,   7,  1)
>+
>+REG8(PCF8563_TIMER, 0x0F)
>+    FIELD(PCF8563_TIMER, TIMER, 0,  8)
>+
>+typedef struct Pcf8563State {
>+    I2CSlave parent_obj;
>+
>+    struct tm current_time;
>+    qemu_irq irq;
>+
>+    uint8_t read_index;
>+    uint8_t write_index;
>+    uint8_t reg_addr;
>+
>+    /* Control and status */
>+    uint8_t cs1;
>+    uint8_t cs2;
>+    /* Counters */
>+    uint8_t vls;
>+    uint8_t minutes;
>+    uint8_t hours;
>+    uint8_t days;
>+    uint8_t weekdays;
>+    uint8_t centure_months;
>+    uint8_t years;
>+    /* Alarm registers */
>+    uint8_t minute_a;
>+    uint8_t hour_a;
>+    uint8_t day_a;
>+    uint8_t weekday_a;
>+    /* Timer control */
>+    uint8_t clkout_ctl;
>+    uint8_t timer_ctl;
>+    uint8_t timer_cnt;
>+
>+    QEMUTimer *alarm_timer;
>+    struct tm tm_alarm;
>+    bool alarm_irq;
>+    QEMUTimer *timer;
>+    time_t time_offset;
>+    time_t stop_time;
>+    QEMUTimer *irq_gen_timer;
>+} Pcf8563State;
>+
>+static uint16_t get_src_freq(Pcf8563State *s, bool *multiply)
>+{
>+    *multiply =3D false;
>+    /* Select source clock frequency (Hz) */
>+    switch (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD)) {
>+    case 0:
>+        return 4096;
>+    case 1:
>+        return 64;
>+    case 2:
>+        return 1;
>+    case 3:
>+        *multiply =3D true;
>+        return 60;
>+    default:
>+        return 0;
>+    }
>+}
>+
>+static uint16_t get_irq_pulse_freq(Pcf8563State *s)
>+{
>+    if (s->timer_cnt > 1) {
>+        switch (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD)) {
>+        case 0:
>+            return 8192;
>+        case 1:
>+            return 128;
>+        case 2:
>+        case 3:
>+            return 64;
>+        default:
>+            return 0;
>+        }
>+    } else {
>+        if (FIELD_EX8(s->timer_ctl, PCF8563_TIMER_CTL, TD) =3D=3D 0) {
>+            return 4096;
>+        }
>+        return 64;
>+    }
>+
>+}
>+
>+static void timer_irq(Pcf8563State *s)
>+{
>+    if (!FIELD_EX8(s->cs2, PCF8563_CS2, TIE)) {
>+        return;
>+    }
>+
>+    if (FIELD_EX8(s->cs2, PCF8563_CS2, TI_TP)) {
>+        qemu_irq_pulse(s->irq);
>+
>+        /* Start IRQ pulse generator */
>+        uint64_t delay =3D s->timer_cnt *
>+                        NANOSECONDS_PER_SECOND *
>+                        get_irq_pulse_freq(s);
>+        timer_mod(s->irq_gen_timer,
>+                    qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay);
>+    } else {
>+        qemu_irq_raise(s->irq);
>+    }
>+}
>+
>+static void alarm_irq(Pcf8563State *s)
>+{
>+    if (FIELD_EX8(s->cs2, PCF8563_CS2, AIE)) {
>+        qemu_irq_raise(s->irq);
>+    }
>+}
>+
>+static void set_alarm(Pcf8563State *s)
>+{
>+    uint64_t diff_sec =3D 0;
>+    uint64_t diff_min =3D 0;
>+    uint64_t diff_hour =3D 0;
>+    uint64_t diff_day =3D 0;
>+    uint64_t diff_wday =3D 0;
>+    uint64_t delay =3D 0;
>+    uint64_t now_cl =3D 0;
>+    struct tm now;
>+
>+    bool is_min_en =3D !FIELD_EX8(s->minute_a, PCF8563_MINUTE_A, AE_M);
>+    bool is_hour_en =3D !FIELD_EX8(s->hour_a, PCF8563_HOUR_A, AE_H);
>+    bool is_day_en =3D !FIELD_EX8(s->day_a, PCF8563_DAY_A, AE_D);
>+    bool is_wday_en =3D !FIELD_EX8(s->weekday_a, PCF8563_WEEKDAY_A, AE_W=
);
>+    if (!is_day_en && !is_wday_en && !is_hour_en && !is_min_en) {
>+        if (s->alarm_timer) {
>+            timer_del(s->alarm_timer);
>+        }
>+        return;
>+    }
>+
>+    qemu_get_timedate(&now, s->time_offset);
>+
>+    if (is_min_en) {
>+        if (s->tm_alarm=2Etm_min > s->current_time=2Etm_min) {
>+            diff_min =3D s->tm_alarm=2Etm_min - s->current_time=2Etm_min=
;
>+        } else {
>+            diff_min =3D (MINUTES_IN_HOUR -
>+                        s->current_time=2Etm_min + s->tm_alarm=2Etm_min)=
;
>+        }
>+    }
>+
>+    if (is_hour_en) {
>+        if (s->tm_alarm=2Etm_hour > s->current_time=2Etm_hour) {
>+            diff_hour =3D s->tm_alarm=2Etm_hour - s->current_time=2Etm_h=
our;
>+        } else {
>+            diff_hour =3D (HOURS_IN_DAY -
>+                         s->current_time=2Etm_hour + s->tm_alarm=2Etm_ho=
ur);
>+        }
>+    }
>+
>+    if (is_day_en) {
>+        if (s->tm_alarm=2Etm_mday > s->current_time=2Etm_mday) {
>+            diff_day =3D s->tm_alarm=2Etm_mday - s->current_time=2Etm_md=
ay;
>+        } else {
>+            diff_day =3D (DAYS_IN_MONTH -
>+                        s->current_time=2Etm_mday + s->tm_alarm=2Etm_mda=
y);
>+        }
>+    }
>+
>+    if (is_wday_en) {
>+        if (s->tm_alarm=2Etm_wday > s->current_time=2Etm_wday) {
>+            diff_wday =3D s->tm_alarm=2Etm_wday - s->current_time=2Etm_w=
day;
>+        } else {
>+            diff_wday =3D (DAYS_IN_WEEK -
>+                         s->current_time=2Etm_wday + s->tm_alarm=2Etm_wd=
ay);
>+        }
>+    }
>+
>+    diff_sec =3D (diff_min * 60) +
>+               (diff_hour * 60 * 60) +
>+               (diff_day * 24 * 60 * 60) +
>+               (diff_wday * 24 * 60 * 60);
>+    now_cl =3D muldiv64(qemu_clock_get_ns(rtc_clock), 1, NANOSECONDS_PER=
_SECOND);
>+    delay =3D muldiv64((now_cl + diff_sec), NANOSECONDS_PER_SECOND, 1);
>+
>+    if (s->alarm_timer) {
>+        timer_del(s->alarm_timer);
>+    }
>+    timer_mod(s->alarm_timer, delay);
>+}
>+
>+static void pcf8563_update_irq(Pcf8563State *s)
>+{
>+    if (FIELD_EX8(s->cs2, PCF8563_CS2, TF)) {
>+        timer_irq(s);
>+    }
>+
>+    if (FIELD_EX8(s->cs2, PCF8563_CS2, AF)) {
>+        alarm_irq(s);
>+    }
>+}
>+
>+static void alarm_timer_cb(void *opaque)
>+{
>+    Pcf8563State *s =3D PCF8563(opaque);

No need for casting from void*, `Pcf8563State *s =3D opaque;` works as wel=
l and is shorter=2E There are similar cases below=2E

>+
>+    set_alarm(s);
>+    s->cs2 =3D FIELD_DP8(s->cs2, PCF8563_CS2, AF, 1);
>+    pcf8563_update_irq(s);
>+}
>+
>+static void timer_cb(void *opaque)
>+{
>+    Pcf8563State *s =3D PCF8563(opaque);
>+
>+    s->timer_cnt =3D 0;
>+    s->cs2 =3D FIELD_DP8(s->cs2, PCF8563_CS2, TF, 1);
>+    pcf8563_update_irq(s);
>+}
>+
>+static void irq_gen_timer_cb(void *opaque)
>+{
>+    Pcf8563State *s =3D PCF8563(opaque);
>+
>+    pcf8563_update_irq(s);
>+}
>+
>+static inline void capture_time(Pcf8563State *s)
>+{
>+    qemu_get_timedate(&s->current_time, s->time_offset);
>+    trace_pcf8563_rtc_capture_time();
>+}
>+
>+static void set_time(Pcf8563State *s, struct tm *tm)
>+{
>+    s->time_offset =3D qemu_timedate_diff(tm);
>+    set_alarm(s);
>+    trace_pcf8563_rtc_set_time();
>+}
>+
>+static void pcf8563_reset(I2CSlave *i2c)
>+{
>+    Pcf8563State *s =3D PCF8563(i2c);
>+
>+    s->read_index =3D 0;
>+    s->write_index =3D 0;
>+    s->reg_addr =3D 0;
>+
>+    s->cs1 =3D 0x8;
>+    s->cs2 =3D 0x0;
>+    s->vls =3D 0x80;
>+    s->minutes =3D 0x0;
>+    s->hours =3D 0x0;
>+    s->days =3D 0x0;
>+    s->weekdays =3D 0x0;
>+    s->centure_months =3D 0x0;
>+    s->years =3D 0x0;
>+    s->minute_a =3D 0x80;
>+    s->hour_a =3D 0x80;
>+    s->day_a =3D 0x80;
>+    s->weekday_a =3D 0x80;
>+    s->clkout_ctl =3D 0x80;
>+    s->timer_ctl =3D 0x3;
>+    s->timer_cnt =3D 0x0;
>+
>+    s->stop_time =3D 0;
>+    s->reg_addr =3D 0;
>+
>+    s->alarm_irq =3D false;
>+    s->time_offset =3D 0;
>+
>+    qemu_irq_lower(s->irq);
>+    qemu_get_timedate(&s->tm_alarm, 0);
>+
>+    timer_del(s->alarm_timer);
>+    timer_del(s->timer);

Not everything gets reset according to table 27 in the datasheet=2E I'd on=
ly reset the bits that are not marked with 'x' there=2E With this, you may =
not need to handle the timers, IRQ, etc=2E

>+}
>+
>+static void pcf8563_read(Pcf8563State *s, uint8_t *result)
>+{
>+    struct tm *tm =3D &s->current_time;
>+
>+    bool multiply =3D false;
>+    uint16_t src_freq =3D get_src_freq(s, &multiply);
>+
>+    switch (s->reg_addr) {
>+    case PCF8563_CS1:
>+        *result =3D s->cs1;
>+        break;
>+    case PCF8563_CS2:
>+        *result =3D s->cs2;
>+        break;
>+    case PCF8563_VLS:
>+        *result =3D (s->vls & 0x80) | to_bcd(tm->tm_sec);
>+        break;
>+    case PCF8563_MINUTES:
>+        *result =3D to_bcd(tm->tm_min);
>+        break;
>+    case PCF8563_HOURS:
>+        *result =3D to_bcd(tm->tm_hour);
>+        break;
>+    case PCF8563_DAYS:
>+        *result =3D to_bcd(tm->tm_mday);
>+        break;
>+    case PCF8563_WEEKDAYS:
>+        *result =3D to_bcd(tm->tm_wday);
>+        break;
>+    case PCF8563_CENTURY_MONTHS:
>+        *result =3D to_bcd(tm->tm_mon + 1);
>+        break;
>+    case PCF8563_YEARS:
>+        *result =3D to_bcd((tm->tm_year + 1900) % 100);
>+        break;
>+    case PCF8563_MINUTE_A:
>+        *result =3D s->minute_a;
>+        break;
>+    case PCF8563_HOUR_A:
>+        *result =3D s->hour_a;
>+        break;
>+    case PCF8563_DAY_A:
>+        *result =3D s->day_a;
>+        break;
>+    case PCF8563_WEEKDAY_A:
>+        *result =3D s->weekday_a;
>+        break;
>+    case PCF8563_CLKOUT_CTL:
>+        *result =3D s->clkout_ctl;
>+        break;
>+    case PCF8563_TIMER_CTL:
>+        *result =3D s->timer_ctl;
>+        break;
>+    case PCF8563_TIMER:
>+        if (timer_pending(s->timer)) {
>+            uint64_t expire_time_s =3D muldiv64(timer_expire_time_ns(s->=
timer),
>+                                              1,
>+                                              NANOSECONDS_PER_SECOND);
>+            if (multiply) {
>+                s->timer_cnt =3D muldiv64(expire_time_s, 1, src_freq);
>+            } else {
>+                s->timer_cnt =3D muldiv64(expire_time_s, src_freq, 1);
>+            }
>+        }
>+        *result =3D s->timer_cnt;
>+        break;
>+    }
>+}
>+
>+static void pcf8563_write(Pcf8563State *s, uint8_t val)
>+{
>+    struct tm *tm =3D &s->current_time;
>+    int tmp;
>+
>+    switch (s->reg_addr) {
>+    case PCF8563_CS1:
>+        s->cs1 =3D val & 0xa8;
>+        break;
>+    case PCF8563_CS2:
>+        s->cs2 =3D val & 0x1f;
>+        break;
>+    case PCF8563_VLS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_VLS, SECONDS));
>+        if (tmp >=3D 0 && tmp <=3D 59) {
>+            tm->tm_sec =3D tmp;
>+            set_time(s, tm);
>+        }
>+
>+        bool vl =3D FIELD_EX8(val, PCF8563_VLS, VL);
>+
>+        if (vl ^ (s->vls & 0x80)) {
>+            if (vl) {
>+                /* Clock integrity is not guaranteed */
>+                s->stop_time =3D time(NULL);
>+            } else if (s->stop_time !=3D 0) {
>+                s->time_offset +=3D s->stop_time - time(NULL);
>+                s->stop_time =3D 0;
>+            }
>+        }
>+
>+        s->vls =3D vl << 8;
>+        break;
>+    case PCF8563_MINUTES:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_MINUTES, MINUTES));
>+        if (tmp >=3D 0 && tmp <=3D 59) {
>+            s->minutes =3D val;
>+            tm->tm_min =3D tmp;
>+            set_time(s, tm);
>+        }
>+        break;
>+    case PCF8563_HOURS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_HOURS, HOURS));
>+        if (tmp >=3D 0 && tmp <=3D 23) {
>+            s->hours =3D val;
>+            tm->tm_hour =3D tmp;
>+            set_time(s, tm);
>+        }
>+        break;
>+    case PCF8563_DAYS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_DAYS, DAYS));
>+        if (tmp >=3D 1 && tmp <=3D 31) {
>+            s->days =3D val;
>+            tm->tm_mday =3D tmp;
>+            set_time(s, tm);
>+        }
>+        break;
>+    case PCF8563_WEEKDAYS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_WEEKDAYS, WEEKDAYS));
>+        if (tmp >=3D 0 && tmp <=3D 6) {
>+            s->weekdays =3D val;
>+            tm->tm_wday =3D tmp;
>+            set_time(s, tm);
>+        }
>+        break;
>+    case PCF8563_CENTURY_MONTHS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_CENTURY_MONTHS, MONTHS))=
;
>+        if (tmp >=3D 0 && tmp <=3D 12) {
>+            s->centure_months =3D val;
>+            tm->tm_mon =3D tmp;
>+            set_time(s, tm);
>+        }
>+        break;
>+    case PCF8563_YEARS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_YEARS, YEARS));
>+        if (tmp >=3D 0 && tmp <=3D 99) {
>+            s->years =3D val;
>+            tm->tm_year =3D tmp + 100;
>+            set_time(s, tm);
>+        }
>+        break;
>+    case PCF8563_MINUTE_A:
>+        s->minute_a =3D val;
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_MINUTE_A, MINUTE_A));
>+        if (tmp >=3D 0 && tmp <=3D 59) {
>+            s->tm_alarm=2Etm_min =3D tmp;
>+            set_alarm(s);
>+        }
>+        break;
>+    case PCF8563_HOUR_A:
>+        s->hour_a =3D val & 0xbf;
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_HOUR_A, HOUR_A));
>+        if (tmp >=3D 0 && tmp <=3D 23) {
>+            s->tm_alarm=2Etm_hour =3D tmp;
>+            set_alarm(s);
>+        }
>+        break;
>+    case PCF8563_DAY_A:
>+        s->day_a =3D val & 0xbf;
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_DAY_A, DAY_A));
>+        if (tmp >=3D 1 && tmp <=3D 31) {
>+            s->tm_alarm=2Etm_mday =3D tmp;
>+            set_alarm(s);
>+        }
>+        break;
>+    case PCF8563_WEEKDAY_A:
>+        s->weekday_a =3D val & 0x87;
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_WEEKDAY_A, WEEKDAY_A));
>+        if (tmp >=3D 0 && tmp <=3D 6) {
>+            s->tm_alarm=2Etm_wday =3D tmp;
>+            set_alarm(s);
>+        }
>+        break;
>+    case PCF8563_CLKOUT_CTL:
>+        s->clkout_ctl =3D val & 0x83;
>+        break;
>+    case PCF8563_TIMER_CTL:
>+        s->timer_ctl =3D val & 0x83;
>+
>+        if (!FIELD_EX32(s->timer_ctl, PCF8563_TIMER_CTL, TE)) {
>+            if (timer_pending(s->timer)) {
>+                timer_del(s->timer);
>+            }
>+        }
>+        break;
>+    case PCF8563_TIMER:
>+        s->timer_cnt =3D val;
>+        if (FIELD_EX32(s->timer_ctl, PCF8563_TIMER_CTL, TE)) {
>+            bool multiply =3D false;
>+            uint16_t src_freq =3D get_src_freq(s, &multiply);
>+            uint64_t delay =3D 0;
>+
>+            /* Calculate timer's delay in ns based on value and set it u=
p */
>+            if (multiply) {
>+                delay =3D val * NANOSECONDS_PER_SECOND * src_freq;
>+            } else {
>+                delay =3D val * NANOSECONDS_PER_SECOND / src_freq;
>+            }
>+            timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + =
delay);
>+        }
>+        break;
>+    }
>+}
>+
>+static uint8_t pcf8563_rx(I2CSlave *i2c)
>+{
>+    Pcf8563State *s =3D PCF8563(i2c);
>+    uint8_t result =3D 0xff;
>+
>+    pcf8563_read(s, &result);
>+    /* Auto-increment register address */
>+    s->reg_addr++;
>+
>+    trace_pcf8563_rtc_read(s->read_index, result);
>+    return result;
>+}
>+
>+static int pcf8563_tx(I2CSlave *i2c, uint8_t data)
>+{
>+    Pcf8563State *s =3D PCF8563(i2c);
>+
>+    if (s->write_index =3D=3D 0) {
>+        /* Receive register address */
>+        s->reg_addr =3D data;
>+        s->write_index++;
>+        trace_pcf8563_rtc_write_addr(data);
>+    } else {
>+        /* Receive data to write */
>+        pcf8563_write(s, data);
>+        s->write_index++;
>+        s->reg_addr++;
>+        trace_pcf8563_rtc_write_data(data);
>+    }
>+    return 0;
>+}
>+
>+static int pcf8563_event(I2CSlave *i2c, enum i2c_event event)
>+{
>+    trace_pcf8563_rtc_event(event);
>+    Pcf8563State *s =3D PCF8563(i2c);
>+
>+    switch (event) {
>+    case I2C_START_RECV:
>+        capture_time(s);
>+        break;
>+    case I2C_FINISH:
>+        s->read_index =3D 0;
>+        s->write_index =3D 0;
>+    default:
>+        break;
>+    }
>+    return 0;
>+}
>+
>+static const VMStateDescription vmstate_pcf8563 =3D {
>+    =2Ename =3D "PCF8563",
>+    =2Eversion_id =3D 0,
>+    =2Eminimum_version_id =3D 0,
>+    =2Efields =3D (const VMStateField[]) {
>+        VMSTATE_I2C_SLAVE(parent_obj, Pcf8563State),
>+        VMSTATE_UINT8(read_index, Pcf8563State),
>+        VMSTATE_UINT8(write_index, Pcf8563State),
>+        VMSTATE_UINT8(reg_addr, Pcf8563State),
>+        VMSTATE_UINT8(cs1, Pcf8563State),
>+        VMSTATE_UINT8(cs2, Pcf8563State),
>+        VMSTATE_UINT8(vls, Pcf8563State),
>+        VMSTATE_UINT8(minutes, Pcf8563State),
>+        VMSTATE_UINT8(hours, Pcf8563State),
>+        VMSTATE_UINT8(days, Pcf8563State),
>+        VMSTATE_UINT8(weekdays, Pcf8563State),
>+        VMSTATE_UINT8(centure_months, Pcf8563State),
>+        VMSTATE_UINT8(years, Pcf8563State),
>+        VMSTATE_UINT8(minute_a, Pcf8563State),
>+        VMSTATE_UINT8(hour_a, Pcf8563State),
>+        VMSTATE_UINT8(day_a, Pcf8563State),
>+        VMSTATE_UINT8(weekday_a, Pcf8563State),
>+        VMSTATE_UINT8(clkout_ctl, Pcf8563State),
>+        VMSTATE_UINT8(timer_ctl, Pcf8563State),
>+        VMSTATE_UINT8(timer_cnt, Pcf8563State),
>+        VMSTATE_TIMER_PTR(timer, Pcf8563State),
>+        VMSTATE_TIMER_PTR(irq_gen_timer, Pcf8563State),
>+        VMSTATE_TIMER_PTR(alarm_timer, Pcf8563State),
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+static void pcf8563_init(Object *obj)
>+{
>+    I2CSlave *i2c =3D I2C_SLAVE(obj);
>+    Pcf8563State *s =3D PCF8563(obj);
>+
>+    s->alarm_timer =3D timer_new_ns(rtc_clock, &alarm_timer_cb, s);
>+    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &timer_cb, s);
>+    s->irq_gen_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &irq_gen_timer=
_cb, s);
>+
>+    qdev_init_gpio_out(DEVICE(s), &s->irq, 1);
>+
>+    pcf8563_reset(i2c);

Not needed=2E Reset is done automatically when QEMU starts=2E

>+
>+    trace_pcf8563_rtc_init();
>+
>+    s->reg_addr =3D 0x09;
>+    pcf8563_write(s, 0x81);
>+    set_alarm(s);
>+}
>+
>+static void pcf8563_reset_hold(Object *obj, ResetType type)
>+{
>+    I2CSlave *i2c =3D I2C_SLAVE(obj);
>+    pcf8563_reset(i2c);

Eliminating the above invocation of pcf8563_reset() leaves just this one c=
allside, so pcf8563_reset() can be inlined here=2E

Other than that the code LGTM=2E

Best regards,
Bernhard

>+}
>+
>+static void pcf8563_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
>+
>+    k->event =3D pcf8563_event;
>+    k->recv =3D pcf8563_rx;
>+    k->send =3D pcf8563_tx;
>+    dc->vmsd =3D &vmstate_pcf8563;
>+    rc->phases=2Ehold =3D pcf8563_reset_hold;
>+}
>+
>+static const TypeInfo pcf8563_register_types[] =3D {
>+    {
>+        =2Ename          =3D TYPE_PCF8563,
>+        =2Eparent        =3D TYPE_I2C_SLAVE,
>+        =2Einstance_size =3D sizeof(Pcf8563State),
>+        =2Einstance_init =3D pcf8563_init,
>+        =2Eclass_init    =3D pcf8563_class_init,
>+    },
>+};
>+
>+DEFINE_TYPES(pcf8563_register_types)
>diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
>index 743ff775d4=2E=2E17c524d61d 100644
>--- a/hw/rtc/trace-events
>+++ b/hw/rtc/trace-events
>@@ -43,3 +43,15 @@ stm32_rtc_arm_ointr(uint64_t tocks, uint64_t nsecs) "o=
verflow interrupt in %" PR
> stm32_rtc_arm_aintr(uint64_t tocks, uint64_t nsecs) "alarm interrupt in =
%" PRIu64 " ticks, %" PRIu64" nsecs"
> stm32_rtc_read(uint64_t addr, uint64_t value, uint32_t size) "addr 0x%02=
" PRIx64 " value 0x%08" PRIx64" size %u"
> stm32_rtc_write(uint64_t addr, uint64_t value, uint32_t size) "addr 0x%0=
2" PRIx64 " value 0x%08" PRIx64" size %u"
>+
>+# pcf8563_rtc=2Ec
>+pcf8563_rtc_write_data(uint8_t data) "data: 0x%x"
>+pcf8563_rtc_write_addr(uint8_t addr) "register address: 0x%x"
>+pcf8563_rtc_read(uint8_t addr, uint8_t data) "addr: 0x%x, data: 0x%x"
>+pcf8563_rtc_event(uint8_t event) "Event: 0x%x"
>+pcf8563_rtc_init(void)
>+pcf8563_rtc_reset(void)
>+pcf8563_rtc_set_time(void)
>+pcf8563_rtc_get_time(void)
>+pcf8563_rtc_set_alarm(void)
>+pcf8563_rtc_capture_time(void)

