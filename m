Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCEEC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 18:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlXsg-0004Ru-VD; Fri, 21 Feb 2025 13:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tlXse-0004Qi-Jb
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:36:08 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1tlXsU-0008Ly-T5
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 13:36:05 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso4481327a12.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740162953; x=1740767753; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=7grIQ353X4fHsaaJPxl7Gf8dvWwDPutg4gnlYOw9kY4=;
 b=ZT54h7xAskrI/QuppE4dOg6VsIlhO215wBlpECSalu0Y+hFEY48wb/f0bRnt9M6fnn
 t7kQU+s2guADa/WIR1WPcuqnvevwAjWAcpcwq1FhWPUaXg6koNdHiZJgAbS1o8kaAo6Q
 mxnjJhVGXKECaBV2qfbTM9vV8NLmF5hSxhZjv3InWIyxSZbHE/chYMEMGTt1yDLmeMhh
 VrK9TjVZ0mZ5eD4dtq7hJlTgQdxyQo5nDAp7VRJqMLVBmWkI+ZUTETld5CrEqJOsaYeC
 lVqVr1Igp8vT7wcgZgsOSIX5QXZruvOyPjKCmOUHinHIF75fEArs295TCbTpbNLFZbUM
 N8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740162953; x=1740767753;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7grIQ353X4fHsaaJPxl7Gf8dvWwDPutg4gnlYOw9kY4=;
 b=QflPuOzmfNvIyA7m1zhDZdyGKQacgcsBOxf8jkAYy8msgIkBV6OxTozJDJ9+0pG6O3
 M8NGK58vKpJmTXcU+dhrmtmHqo4aCNHnQRtWV1BmyYcvqP2oahMFxGapfeYYc4va4RWa
 7lJeM9blqo34WY8ozdpmil1z6kKslA51zMRB/A9GpkYh/FYQKhjVYiz/07sFVTx7aHKj
 5nobu245xZqpUO7qpkrGwAAnqn3nsFOZRe/JJN5JBtx0n78goGPAyTOzSFb0mhFmo8z+
 BGzoMkfQJN7fFC8/uISR7T5T3tu2sbVOpzsdBE0f6oMSUfGxjUuZZsmHcxB13ZswttM3
 7Ucg==
X-Gm-Message-State: AOJu0YwMbtUDiBwjWJpJ0v4uNzjQvag/05deAVxE99y9cOPgOxqzeLP5
 tGoONlFtUkT1179dEnwwHAqnHwselxM1YPBNwbXOcpcipk/4RZyuGunbfw==
X-Gm-Gg: ASbGncuNcn1AZfYORgRuJ9RTQ/luyMQJcZGkUrrsm5rKwKXeyirtVMMbeYClt/OReAZ
 AkQGlmCUjyOozs/HvPKs/IMIMAbE6hgC79jsAXMFtoSpKuZByqOG2g2BPs87nMONaZ7cAcjwbwt
 PUsZUOrseo+0UD4B4TsmJJuSWUJDSKJOqnQaKkzP2EcnAT2G80bwR0oU4SC6b+xUDtMh9TZQMkd
 1R5TvszRFV8L0tEmEieBug+EGUUY6v5ac90/4ZX1oMv/TIdltEnM/jJQpHIeeyY5zDo2fpgercb
 0Fo5xtgafToS93G5YcVmYKfP8t/Floa3BxYs9g974pdGJ5iyWJt3Pi5v2Cuz/cSZyx3loIOupeQ
 =
X-Google-Smtp-Source: AGHT+IH6yCsl0aHJdQTvYqlHVAtdQNFvW6SctGioHb0PNYt/fHRMBHp+tE9Foa2RgN1poJU2RHcsCQ==
X-Received: by 2002:a05:6402:3593:b0:5de:5717:f235 with SMTP id
 4fb4d7f45d1cf-5e0b7246df6mr4427656a12.24.1740162952956; 
 Fri, 21 Feb 2025 10:35:52 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-245-042-240.2.245.pool.telefonica.de.
 [2.245.42.240]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dedd35b0aasm12712770a12.52.2025.02.21.10.35.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 10:35:52 -0800 (PST)
Date: Fri, 21 Feb 2025 18:35:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Ilya Chichkov <i.chichkov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/rtc: Add RTC PCF8563 module
In-Reply-To: <20250221073444.15257-1-i.chichkov@yadro.com>
References: <20250221073444.15257-1-i.chichkov@yadro.com>
Message-ID: <F7B81A07-F33F-4396-ADD7-68FEFFA740FE@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x533.google.com
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



Am 21=2E Februar 2025 07:34:44 UTC schrieb Ilya Chichkov <i=2Echichkov@yad=
ro=2Ecom>:
>Add PCF8563 a real-time clock with calendar and I2C interface=2E

Nice! I'd like to use it myself=2E

>This commit adds support for interfacing with it and implements
>functionality of setting timer, alarm, reading and writing time=2E
>
>Datasheet: https://www=2Emicros=2Ecom=2Epl/mediaserver/UZPCF8563ts5_0001=
=2Epdf

Better link to the datasheet in the top source comment, and perhaps use a =
more authoritative source such as <https://www=2Enxp=2Ecom/docs/en/data-she=
et/PCF8563=2Epdf>=2E

>
>Signed-off-by: Ilya Chichkov <i=2Echichkov@yadro=2Ecom>
>---
> hw/rtc/Kconfig       |   5 +
> hw/rtc/meson=2Ebuild   |   1 +
> hw/rtc/pcf8563_rtc=2Ec | 638 +++++++++++++++++++++++++++++++++++++++++++
> hw/rtc/trace-events  |  11 +
> 4 files changed, 655 insertions(+)
> create mode 100644 hw/rtc/pcf8563_rtc=2Ec
>
>diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
>index d0d8dda084=2E=2Efd7bd393bd 100644
>--- a/hw/rtc/Kconfig
>+++ b/hw/rtc/Kconfig
>@@ -30,3 +30,8 @@ config GOLDFISH_RTC
>=20
> config LS7A_RTC
>     bool
>+
>+config PCF8563_RTC
>+    bool
>+    depends on I2C
>+    default y if I2C_DEVICES
>diff --git a/hw/rtc/meson=2Ebuild b/hw/rtc/meson=2Ebuild
>index 3ea2affe0b=2E=2E959541a96d 100644
>--- a/hw/rtc/meson=2Ebuild
>+++ b/hw/rtc/meson=2Ebuild
>@@ -14,3 +14,4 @@ system_ss=2Eadd(when: 'CONFIG_GOLDFISH_RTC', if_true: f=
iles('goldfish_rtc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_LS7A_RTC', if_true: files('ls7a_rtc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-r=
tc=2Ec'))
> system_ss=2Eadd(when: 'CONFIG_MC146818RTC', if_true: files('mc146818rtc=
=2Ec'))
>+system_ss=2Eadd(when: 'CONFIG_PCF8563_RTC', if_true: files('pcf8563_rtc=
=2Ec'))
>diff --git a/hw/rtc/pcf8563_rtc=2Ec b/hw/rtc/pcf8563_rtc=2Ec
>new file mode 100644
>index 0000000000=2E=2E63d5f95c42
>--- /dev/null
>+++ b/hw/rtc/pcf8563_rtc=2Ec
>@@ -0,0 +1,638 @@
>+/*
>+ * Real-time clock/caread_indexdar PCF8563 with I2C interface=2E

s/caread_indexdar/calendar/ ?

>+ *
>+ * Copyright (c) 2024 Ilya Chichkov <i=2Echichkov@yadro=2Ecom>
>+ *
>+ * This program is free software; you can redistribute it and/or modify =
it
>+ * under the terms and conditions of the GNU General Public License,
>+ * version 2 or later, as published by the Free Software Foundation=2E
>+ *
>+ * This program is distributed in the hope it will be useful, but WITHOU=
T
>+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>+ * FITNESS FOR A PARTICULAR PURPOSE=2E See the GNU General Public Licens=
e for
>+ * more details=2E
>+ *
>+ * You should have received a copy of the GNU General Public License alo=
ng with
>+ * this program=2E If not, see <http://www=2Egnu=2Eorg/licenses/>=2E

AFAIU QEMU tries to move towards SPDX license identifiers=2E But it's up t=
o you if you agree with that=2E

>+ */
>+
>+#include "qemu/osdep=2Eh"

>+#include "hw/sysbus=2Eh"
>+#include "hw/register=2Eh"

Unused=2E

>+#include "hw/registerfields=2Eh"
>+#include "hw/irq=2Eh"

>+#include "qemu/bitops=2Eh"
>+#include "hw/qdev-properties=2Eh"

Unused=2E

Used, but missing: #include "hw/qdev-core=2Eh"

>+#include "qemu/timer=2Eh"

>+#include "qapi/error=2Eh"

Unused=2E

>+#include "hw/i2c/i2c=2Eh"
>+#include "qemu/bcd=2Eh"

>+#include "qemu/module=2Eh"

Unused if you'd use DEFINE_TYPES() macro (see below)=2E

>+#include "qom/object=2Eh"

>+#include "sysemu/rtc=2Eh"

s/sysemu/system/

>+#include "migration/vmstate=2Eh"

>+#include "qapi/visitor=2Eh"
>+#include "qemu/log=2Eh"

Unused=2E

>+
>+#include "trace=2Eh"
>+
>+#define TYPE_PCF8563 "pcf8563"
>+

>+#define PCF8563(obj) \
>+    OBJECT_CHECK(Pcf8563State, (obj), TYPE_PCF8563)

Use `OBJECT_DECLARE_SIMPLE_TYPE(Pcf8563State, PCF8563)` instead=2E

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
>+    /*< private >*/

This comment is discuraged nowadays=2E Just omit it=2E

>+    I2CSlave i2c;

s/i2c/parent_obj/ is more idiomatic because it becomes more obvious that I=
2CSlave is the base class which may be cast from or into=2E

>+
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
>+static void pcf8563_update_irq(Pcf8563State *s)
>+{
>+    if (!FIELD_EX8(s->cs2, PCF8563_CS2, TF) &&
>+        !FIELD_EX8(s->cs2, PCF8563_CS2, AF)) {
>+        return;
>+    }
>+
>+    /* Timer interrupt */
>+    if (FIELD_EX8(s->cs2, PCF8563_CS2, TIE)) {
>+        if (FIELD_EX8(s->cs2, PCF8563_CS2, TI_TP)) {
>+            qemu_irq_pulse(s->irq);
>+
>+            /* Start IRQ pulse generator */
>+            uint64_t delay =3D s->timer_cnt *
>+                            NANOSECONDS_PER_SECOND *
>+                            get_irq_pulse_freq(s);
>+            timer_mod(s->irq_gen_timer,
>+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay);
>+        } else {
>+            qemu_irq_raise(s->irq);
>+        }
>+    }
>+
>+    /* Alarm interrupt */
>+    if (FIELD_EX8(s->cs2, PCF8563_CS2, AIE)) {
>+        qemu_irq_raise(s->irq);
>+    }
>+}
>+
>+static void alarm_timer_cb(void *opaque)
>+{
>+    Pcf8563State *s =3D PCF8563(opaque);
>+
>+    s->cs2 =3D FIELD_DP8(s->cs2, PCF8563_CS2, AF, 1);
>+    pcf8563_update_irq(s);
>+}
>+
>+static void timer_cb(void *opaque)
>+{
>+    Pcf8563State *s =3D PCF8563(opaque);
>+
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
>+static void set_alarm(Pcf8563State *s)
>+{
>+    /* Update alarm */
>+    int64_t diff_sec;
>+    if (s->alarm_timer !=3D NULL) {
>+        timer_del(s->alarm_timer);
>+        diff_sec =3D qemu_timedate_diff(&s->tm_alarm);
>+        if (diff_sec > 0) {
>+            timer_mod_ns(s->alarm_timer, diff_sec * NANOSECONDS_PER_SECO=
ND);
>+        }
>+
>+        trace_pcf8563_rtc_set_alarm();
>+    }
>+}
>+
>+static inline void get_time(Pcf8563State *s, struct tm *tm)
>+{
>+    qemu_get_timedate(tm, s->time_offset);
>+
>+    trace_pcf8563_rtc_get_time();
>+}
>+
>+static void set_time(Pcf8563State *s, struct tm *tm)
>+{
>+    s->time_offset =3D qemu_timedate_diff(tm);
>+    set_alarm(s);
>+
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
>+    s->reg_addr =3D 0;
>+    s->time_offset =3D 0;
>+
>+    s->alarm_irq =3D false;
>+
>+    qemu_get_timedate(&s->tm_alarm, 0);
>+}
>+
>+static void pcf8563_read(Pcf8563State *s, uint8_t *result)
>+{
>+    struct tm tm;
>+
>+    switch (s->reg_addr) {
>+    case PCF8563_CS1:
>+        *result =3D s->cs1;
>+        break;
>+    case PCF8563_CS2:
>+        *result =3D s->cs2;
>+        break;
>+    case PCF8563_VLS:
>+        get_time(s, &tm);

AFAIU get_time() returns a different time upon each invocation which means=
 that timestamps could be inconsistent=2E Looking at other i2c rtc device m=
odels, a timestamp is captured at "convenient occations", just like in the =
real devices, e=2Eg=2E when the device starts to send data=2E How does PCF8=
563 handle it?

>+        *result =3D (s->vls & 0x80) | to_bcd(tm=2Etm_sec);
>+        break;
>+    case PCF8563_MINUTES:
>+        get_time(s, &tm);
>+        *result =3D to_bcd(tm=2Etm_min);
>+        break;
>+    case PCF8563_HOURS:
>+        get_time(s, &tm);
>+        *result =3D to_bcd(tm=2Etm_hour);
>+        break;
>+    case PCF8563_DAYS:
>+        get_time(s, &tm);
>+        *result =3D to_bcd(tm=2Etm_mday);
>+        break;
>+    case PCF8563_WEEKDAYS:
>+        get_time(s, &tm);
>+        *result =3D to_bcd(tm=2Etm_wday);
>+        break;
>+    case PCF8563_CENTURY_MONTHS:
>+        get_time(s, &tm);
>+        *result =3D to_bcd(tm=2Etm_mon + 1);
>+        break;
>+    case PCF8563_YEARS:
>+        get_time(s, &tm);
>+        *result =3D to_bcd((tm=2Etm_year + 1900) % 100);
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
>+        *result =3D s->timer_cnt;
>+        break;
>+    }
>+}
>+
>+static void pcf8563_write(Pcf8563State *s, uint8_t val)
>+{
>+    struct tm tm;
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
>+            get_time(s, &tm);
>+            tm=2Etm_sec =3D tmp;
>+            set_time(s, &tm);
>+        }
>+
>+        bool vl =3D FIELD_EX8(val, PCF8563_VLS, VL);
>+
>+        if (vl ^ (s->vls & 0x80)) {
>+            if (vl) {
>+                s->stop_time =3D time(NULL);
>+            } else {
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
>+            get_time(s, &tm);
>+            tm=2Etm_min =3D tmp;
>+            set_time(s, &tm);
>+        }
>+        break;
>+    case PCF8563_HOURS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_HOURS, HOURS));
>+        if (tmp >=3D 0 && tmp <=3D 23) {
>+            s->hours =3D val;
>+            get_time(s, &tm);
>+            tm=2Etm_hour =3D tmp;
>+            set_time(s, &tm);
>+        }
>+        break;
>+    case PCF8563_DAYS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_DAYS, DAYS));
>+        if (tmp >=3D 1 && tmp <=3D 31) {
>+            s->hours =3D val;
>+            get_time(s, &tm);
>+            tm=2Etm_hour =3D tmp;
>+            set_time(s, &tm);
>+        }
>+        break;
>+    case PCF8563_WEEKDAYS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_WEEKDAYS, WEEKDAYS));
>+        if (tmp >=3D 0 && tmp <=3D 6) {
>+            s->weekdays =3D val;
>+            get_time(s, &tm);
>+            tm=2Etm_wday =3D tmp;
>+            set_time(s, &tm);
>+        }
>+        break;
>+    case PCF8563_CENTURY_MONTHS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_CENTURY_MONTHS, MONTHS))=
;
>+        if (tmp >=3D 0 && tmp <=3D 6) {
>+            s->weekdays =3D val;
>+            get_time(s, &tm);
>+            tm=2Etm_wday =3D tmp;
>+            set_time(s, &tm);
>+        }
>+        break;
>+    case PCF8563_YEARS:
>+        tmp =3D from_bcd(FIELD_EX8(val, PCF8563_YEARS, YEARS));
>+        if (tmp >=3D 0 && tmp <=3D 99) {
>+            s->years =3D val;
>+            get_time(s, &tm);
>+            tm=2Etm_year =3D tmp;
>+            set_time(s, &tm);
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

It might be a good idea to populate this struct faithfully=2E=20

>+};
>+
>+static void pcf8563_realize(DeviceState *dev, Error **errp)
>+{
>+    I2CSlave *i2c =3D I2C_SLAVE(dev);
>+    Pcf8563State *s =3D PCF8563(i2c);
>+
>+    s->alarm_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &alarm_timer_cb,=
 s);
>+    s->timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &timer_cb, s);
>+    s->irq_gen_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &irq_gen_timer=
_cb, s);
>+
>+    pcf8563_reset(i2c);

Together with Phil's comment of registering pcf8563_reset() as a reset han=
dler, it seems possible to eliminate pcf8563_realize() by initializing the =
above three attributes in pcf8563_init()=2E

>+}
>+
>+static void pcf8563_init(Object *obj)
>+{
>+    Pcf8563State *s =3D PCF8563(obj);
>+
>+    qdev_init_gpio_out(DEVICE(s), &s->irq, 1);
>+}
>+
>+static void pcf8563_class_init(ObjectClass *klass, void *data)
>+{
>+    DeviceClass *dc =3D DEVICE_CLASS(klass);
>+    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
>+
>+    k->event =3D pcf8563_event;
>+    k->recv =3D pcf8563_rx;
>+    k->send =3D pcf8563_tx;
>+    dc->realize =3D pcf8563_realize;
>+    dc->vmsd =3D &vmstate_pcf8563;
>+
>+    trace_pcf8563_rtc_init();
>+}
>+
>+static const TypeInfo pcf8563_device_info =3D {
>+    =2Ename          =3D TYPE_PCF8563,
>+    =2Eparent        =3D TYPE_I2C_SLAVE,
>+    =2Einstance_size =3D sizeof(Pcf8563State),
>+    =2Einstance_init =3D pcf8563_init,
>+    =2Eclass_init    =3D pcf8563_class_init,
>+};
>+
>+static void pcf8563_register_types(void)
>+{
>+    type_register_static(&pcf8563_device_info);
>+}
>+
>+type_init(pcf8563_register_types)

You could instead use DEFINE_TYPES() here=2E Even though it asks for an ar=
ray it still requires less code=2E And you can omit the "module=2Eh" includ=
e=2E

Best regards,
Bernhard

>diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
>index ebb311a5b0=2E=2E446017f512 100644
>--- a/hw/rtc/trace-events
>+++ b/hw/rtc/trace-events
>@@ -31,3 +31,14 @@ m48txx_nvram_mem_write(uint32_t addr, uint32_t value) =
"mem write addr:0x%04x val
> # goldfish_rtc=2Ec
> goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " v=
alue 0x%08" PRIx64
> goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " =
value 0x%08" PRIx64
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

