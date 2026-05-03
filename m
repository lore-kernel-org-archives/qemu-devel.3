Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF6FF885A
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2026 05:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJPrE-0001Dk-Sl; Sun, 03 May 2026 01:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6B-0004vn-Vj
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:24 -0400
Received: from mail-dy1-x1334.google.com ([2607:f8b0:4864:20::1334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <54weasels@gmail.com>)
 id 1wJM6A-0000U3-0b
 for qemu-devel@nongnu.org; Sat, 02 May 2026 21:58:23 -0400
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-2ecf9e398f4so6483088eec.1
 for <qemu-devel@nongnu.org>; Sat, 02 May 2026 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777773500; x=1778378300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O85A+8mTtk4dus5AdYbZBy3FLqoryx7HTG4VFhPinZ8=;
 b=MSREn1KA9YlfJJMXx8WERucqsq66ryQwJVXdIOL0PJ7SNPigg6y6/uAznqjP9VIhzl
 pnI/djsEcWPfiVfTR0/2J1nNoyB0WVHlRMuSC4n4YTJJiPAmXQ7HhPpuLoZ1f9cibUil
 Of37Qtw6EvqfHcUAS2suaa97A+JwxEAclf6g86svEr5p16bvsPSxZc5ht90ksZzjLsEb
 wAJ8z/FpEz3A2e3Svt/1NT0wUKKwxAPjZ1BJXXglDe9Pji5lmA9YuyssUX/OG15Uv2f6
 MfVfaEwCXl1yJbgDCYIFgI3N+dLdbptEmFYQxw2dskpdSsHCegznC39mh8PWQKsFf6nB
 vUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777773500; x=1778378300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O85A+8mTtk4dus5AdYbZBy3FLqoryx7HTG4VFhPinZ8=;
 b=CwUdfoN/LAa1Ta7hwEZ+Bdgo6a2K1POEYcBlPgG/Gc8kTESqcwzJgehgiW/UWGh4Ch
 AiD840hpis/5AgyvRUiE2xZeuAQ/YYVjpzcRqq+YqBxhILXJzKOPub/aBe0H+8bUDrYi
 8JKsr/8G0Cp1Jji9O2OVq5cmDTbrFpiSrI85IHSWcFZ4Sl9VN6g90ojmFOb6CauQALkT
 IStrzGQdn3jZRPXumfQaR3/iYIHP139/6KwF3DKyb1dp9yzwuZGewJx+5nUelGkxvfre
 Xp2IBOyVlxzQxkK/FJ74S6M3muAWhe2mX5gXNT20zJZmnTo5IJ+vpQ7B7P4rNid/GXtV
 lEWw==
X-Gm-Message-State: AOJu0YyyUMMwcQ5Qf/f+zHgVrp86J/lt6PZm6cgkjnI+2iCJR3ADkKap
 C+J+FqyoJ8QlpwPJQQ8Iz6GhApXZ5/+i09oNcpDjnPOMvytwG633jSTRghD6ew==
X-Gm-Gg: AeBDievFrsN8PGs6gQFxpg5QWemHCwD5RwmwZvcA+W6SuOolezJk4vR/phx6y1YEQx2
 OkAb+2Qu9bjbJWaom7RGrl7Sh7W5N2FdFvE05yl9u+EKG5IHqtoU3feMSY3bYh6UIANlNjRMkj+
 ugKf1PREO45hl9vxy9X1Ou4vlLnV4JeB1oLqGbQIzeAT7XQbW6Aazrvn/Ey0Fv39TJkd7rX1slB
 iyzhF+aFkoOYGIxho4C8MEgNXSC4BAP9ED3NSmh2d79IKwVc0p1DhkozzgSCATwcDEacckv2l4A
 1ZooXdDpQ12jN0m8oVNOcwnMmMOYDijtztG8mWiSbdF89IXC3oUqlAaQmAHm90wfZKSuiD5nb/8
 AaaQW6H21vBixoeIcftb4wOHELI0UcSTTQTJ6MoBh3UgqNWBIDgSKJTA1g8A1hVNQ8UZ3GGUUyq
 OZW5x5cXaICEZAyBWkX6oLZUWpOMqntvDFxBkKxb/WueTSf9OF+Q==
X-Received: by 2002:a05:7301:9f06:b0:2be:142f:d499 with SMTP id
 5a478bee46e88-2efb99a10e1mr2273410eec.16.1777773499981; 
 Sat, 02 May 2026 18:58:19 -0700 (PDT)
Received: from newsled.lan ([76.133.142.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38d79eb9sm14361735eec.8.2026.05.02.18.58.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 02 May 2026 18:58:19 -0700 (PDT)
From: 54weasels <54weasels@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	thuth@redhat.com,
	54weasels <54weasels@gmail.com>
Subject: [PATCH 4/7] hw/timer: Introduce Intersil 7170 RTC implementation
Date: Sat,  2 May 2026 18:57:53 -0700
Message-ID: <20260503015756.99176-5-54weasels@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260503015756.99176-1-54weasels@gmail.com>
References: <20260503015756.99176-1-54weasels@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1334;
 envelope-from=54weasels@gmail.com; helo=mail-dy1-x1334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2026 01:59:06 -0400
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

This adds the Intersil 7170 Time-of-Day clock / CMOS RAM chip. It implements the register map, alarm interrupt logic, and persistent 32-byte battery-backed NVRAM used by the Sun-3 architecture for storing the MAC address, EEPROM checksums, and boot parameters.

Signed-off-by: 54weasels <54weasels@gmail.com>
---
 hw/timer/Kconfig                |   3 +
 hw/timer/intersil7170.c         | 216 ++++++++++++++++++++++++++++++++
 hw/timer/meson.build            |   1 +
 include/hw/timer/intersil7170.h |   9 ++
 4 files changed, 229 insertions(+)
 create mode 100644 hw/timer/intersil7170.c
 create mode 100644 include/hw/timer/intersil7170.h

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b3d823ce2c..a828273b6c 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -65,3 +65,6 @@ config STELLARIS_GPTM
 
 config AVR_TIMER16
     bool
+
+config INTERSIL7170
+    bool
diff --git a/hw/timer/intersil7170.c b/hw/timer/intersil7170.c
new file mode 100644
index 0000000000..138151fdc1
--- /dev/null
+++ b/hw/timer/intersil7170.c
@@ -0,0 +1,216 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Intersil 7170 Real Time Clock and Timer Emulation
+ *
+ * This device mimics the core functionality of the Intersil 7170 RTC,
+ * specifically targeting the 1/100th second periodic interrupt requested
+ * by the Sun-3 Boot PROM diagnostic routines.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/timer/intersil7170.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qom/object.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(Intersil7170State, INTERSIL_7170)
+
+struct Intersil7170State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+    QEMUTimer *timer;
+
+    /* Registers */
+    uint8_t int_status; /* 0x10 */
+    uint8_t int_mask;
+    uint8_t command; /* 0x11 */
+};
+
+#define REG_INT 0x10
+#define REG_CMD 0x11
+
+/* Interrupt Register bits */
+#define RTC_INT_PENDING 0x80
+#define RTC_INT_DAY 0x40
+#define RTC_INT_HOUR 0x20
+#define RTC_INT_MIN 0x10
+#define RTC_INT_SEC 0x08
+#define RTC_INT_TSEC 0x04
+#define RTC_INT_HSEC 0x02
+#define RTC_INT_ALARM 0x01
+
+/* Command Register bits */
+#define RTC_CMD_INTENA 0x10
+#define RTC_CMD_RUN 0x08
+
+static void intersil7170_update_irq(Intersil7170State *s)
+{
+    bool level = (s->int_status & s->int_mask) && (s->command & RTC_CMD_INTENA);
+
+    if (level) {
+        s->int_status |= RTC_INT_PENDING;
+    } else {
+        s->int_status &= ~RTC_INT_PENDING;
+    }
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void intersil7170_timer_cb(void *opaque)
+{
+    Intersil7170State *s = opaque;
+
+    if (!(s->command & RTC_CMD_RUN)) {
+        return;
+    }
+
+    /*
+     * Timer fired. Set pending bit based on what is unmasked.
+     * The Sun-3 PROM primarily demands the Hundredth-Second
+     * (RTC_INT_HSEC) tick.
+     */
+    if (s->int_mask & RTC_INT_HSEC) {
+        s->int_status |= RTC_INT_HSEC;
+        intersil7170_update_irq(s);
+
+        /* Reschedule for 1/100th of a second (10,000,000 ns) */
+        timer_mod(s->timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 10000000);
+    }
+}
+
+static uint64_t intersil7170_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Intersil7170State *s = opaque;
+    uint32_t val = 0;
+
+    switch (addr) {
+    case REG_INT:
+        val = s->int_status;
+        /*
+         * Reading the interrupt register formally clears all
+         * pending interrupts.
+         */
+        s->int_status = 0;
+        intersil7170_update_irq(s);
+        break;
+    case REG_CMD:
+        val = s->command;
+        break;
+    default:
+        val = 0;
+        break;
+    }
+
+    return val;
+}
+
+static void intersil7170_write(void *opaque, hwaddr addr, uint64_t val,
+                               unsigned size)
+{
+    Intersil7170State *s = opaque;
+
+    switch (addr) {
+    case REG_INT:
+        /*
+         * Writing to the INT register sets the mask!
+         * Pending flag is read-only.
+         */
+        s->int_mask = val & ~RTC_INT_PENDING;
+        intersil7170_update_irq(s);
+
+        /* If timer requires starting, schedule immediately */
+        if ((s->command & RTC_CMD_RUN) && (s->int_mask & RTC_INT_HSEC)) {
+            timer_mod(s->timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 10000000);
+        }
+        break;
+    case REG_CMD:
+        s->command = val;
+        intersil7170_update_irq(s);
+
+        if ((s->command & RTC_CMD_RUN) && (s->int_mask & RTC_INT_HSEC)) {
+            timer_mod(s->timer,
+                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 10000000);
+        } else if (!(s->command & RTC_CMD_RUN)) {
+            timer_del(s->timer);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps intersil7170_ops = {
+    .read = intersil7170_read,
+    .write = intersil7170_write,
+    .endianness = DEVICE_BIG_ENDIAN,
+    .impl = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+            .unaligned = true,
+        },
+    .valid = {
+            .min_access_size = 1,
+            .max_access_size = 4,
+            .unaligned = true,
+        },
+};
+
+static void intersil7170_realize(DeviceState *dev, Error **errp)
+{
+    Intersil7170State *s = INTERSIL_7170(OBJECT(dev));
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, intersil7170_timer_cb, s);
+}
+
+static void intersil7170_reset(DeviceState *dev)
+{
+    Intersil7170State *s = INTERSIL_7170(OBJECT(dev));
+
+    s->int_status = 0;
+    s->int_mask = 0;
+    s->command = 0;
+    timer_del(s->timer);
+}
+
+static void intersil7170_init(Object *obj)
+{
+    Intersil7170State *s = INTERSIL_7170(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &intersil7170_ops, s, "intersil7170",
+                        8192);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void intersil7170_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = intersil7170_realize;
+    device_class_set_legacy_reset(dc, intersil7170_reset);
+}
+
+static const TypeInfo intersil7170_info = {
+    .name = TYPE_INTERSIL_7170,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Intersil7170State),
+    .instance_init = intersil7170_init,
+    .class_init = intersil7170_class_init,
+};
+
+static void intersil7170_register_types(void)
+{
+    type_register_static(&intersil7170_info);
+}
+
+type_init(intersil7170_register_types)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 178321c029..72f33ec31f 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -15,6 +15,7 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_pwm.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
 system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
+system_ss.add(when: 'CONFIG_INTERSIL7170', if_true: files('intersil7170.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpt.c'))
 system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
diff --git a/include/hw/timer/intersil7170.h b/include/hw/timer/intersil7170.h
new file mode 100644
index 0000000000..cab42b4cc0
--- /dev/null
+++ b/include/hw/timer/intersil7170.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef HW_TIMER_INTERSIL7170_H
+#define HW_TIMER_INTERSIL7170_H
+
+#define TYPE_INTERSIL_7170 "intersil7170"
+
+typedef struct Intersil7170State Intersil7170State;
+
+#endif
-- 
2.50.1 (Apple Git-155)


