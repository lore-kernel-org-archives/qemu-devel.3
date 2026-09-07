Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F226C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Rqf-0004vx-KT; Mon, 07 Sep 2026 01:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqd-0004ul-13; Mon, 07 Sep 2026 01:24:51 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Rqa-0007tg-2c; Mon, 07 Sep 2026 01:24:50 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdb994BxyzBqZD;
 Mon,  7 Sep 2026 07:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788758669;
 bh=3ohzsHjLftCiDhHFslpENJheeurUSBF4/KDtQxgFZ7s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m0KJWNoj3et1t4XBE4xwqC69qWMHnDuoUAPn3A8c17OgsHGvKNxwJazQ6+3JFHW5H
 7s+raAU/Yq8O17AL1fwz1ZMflgelVL1a5o8CgI8QB/R6WTI8Ai753611efeabTWnde
 Cf2w2Eaw3pTun4MY5DuLbI+WZg0lq9zjzoBh8ptas1JjfhtHUsVoRKKueztYpk88gu
 BKxWMxDmU/IGwYamsLyTOMocy56lu+hCVacafYCo2zvsULo/weTPdu6D7dWzvWOYlx
 NllklM03rjcNf+hCbfqlBgOZEEOqVRb5ipFoU+BSGn/YpcZryjnCi/JKBPF4MllCCC
 k3sMKwxNp9EcQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdb9927w8z7xqd;
 Mon,  7 Sep 2026 07:24:29 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 23/36] hw/timer: add RP2040 timer and alarms
Date: Mon,  7 Sep 2026 07:24:11 +0200
Message-ID: <20260907052426.24849-7-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260907052426.24849-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                 |  10 +-
 hw/misc/meson.build             |   1 +
 hw/misc/rp2040_timer.c          | 352 ++++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h         |   2 +
 include/hw/misc/rp2040_timer.h  |  39 ++++
 tests/qtest/meson.build         |   1 +
 tests/qtest/rp2040-timer-test.c | 149 ++++++++++++++
 7 files changed, 553 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/rp2040_timer.c
 create mode 100644 include/hw/misc/rp2040_timer.h
 create mode 100644 tests/qtest/rp2040-timer-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index d0107f98a6..86bf259439 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -74,7 +74,6 @@ static const struct {
     { "rp2040.i2c1",     0x40048000, 0x4000 },
     { "rp2040.adc",      0x4004c000, 0x4000 },
     { "rp2040.pwm",      0x40050000, 0x4000 },
-    { "rp2040.timer",    0x40054000, 0x4000 },
     { "rp2040.rtc",      0x4005c000, 0x4000 },
     { "rp2040.dma",      0x50000000, 0x1000 },
     { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
@@ -281,6 +280,7 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
     object_initialize_child(obj, "sio", &s->sio, TYPE_RP2040_SIO);
     object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
+    object_initialize_child(obj, "timer", &s->timer, TYPE_RP2040_TIMER);
     object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
     object_initialize_child(obj, "watchdog", &s->watchdog,
                             TYPE_RP2040_WATCHDOG);
@@ -496,6 +496,14 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->tbman), 0, RP2040_TBMAN_BASE);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->timer), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, RP2040_TIMER_BASE);
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), i, s->irq[i]);
+    }
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->vreg), errp)) {
         return;
     }
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index db0776227d..47e53fc49e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -111,6 +111,7 @@ system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040',
               if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_tbman.c'))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_timer.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_vreg.c'))
 system_ss.add(when: 'CONFIG_RP2040',
               if_true: files('rp2040_watchdog.c'))
diff --git a/hw/misc/rp2040_timer.c b/hw/misc/rp2040_timer.c
new file mode 100644
index 0000000000..024a3e091b
--- /dev/null
+++ b/hw/misc/rp2040_timer.c
@@ -0,0 +1,352 @@
+/*
+ * RP2040 timer emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/irq.h"
+#include "hw/misc/rp2040_timer.h"
+#include "hw/misc/rp2040.h"
+#include "migration/vmstate.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+#define TIMER_TIMEHW       0x00
+#define TIMER_TIMELW       0x04
+#define TIMER_TIMEHR       0x08
+#define TIMER_TIMELR       0x0c
+#define TIMER_ALARM0       0x10
+#define TIMER_ALARM3       0x1c
+#define TIMER_ARMED        0x20
+#define TIMER_TIMERAWH     0x24
+#define TIMER_TIMERAWL     0x28
+#define TIMER_DBGPAUSE     0x2c
+#define TIMER_PAUSE        0x30
+#define TIMER_INTR         0x34
+#define TIMER_INTE         0x38
+#define TIMER_INTF         0x3c
+#define TIMER_INTS         0x40
+
+#define TIMER_ALARM_MASK   0x0f
+#define TIMER_DBGPAUSE_MASK (BIT(2) | BIT(1))
+#define TIMER_PAUSE_MASK   BIT(0)
+
+static uint64_t rp2040_timer_now_us(RP2040TimerState *s)
+{
+    if (s->pause & TIMER_PAUSE_MASK) {
+        return s->paused_time_us;
+    }
+
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000 + s->time_offset_us;
+}
+
+static uint32_t rp2040_timer_ints(RP2040TimerState *s)
+{
+    uint32_t ints = (s->intr & s->inte) | s->intf;
+
+    return ints & TIMER_ALARM_MASK;
+}
+
+static void rp2040_timer_update_irq(RP2040TimerState *s)
+{
+    uint32_t ints = rp2040_timer_ints(s);
+    int i;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        qemu_set_irq(s->irq[i], !!(ints & BIT(i)));
+    }
+}
+
+static void rp2040_timer_update_alarm(RP2040TimerState *s, unsigned alarm)
+{
+    uint64_t now_us;
+    uint32_t delta;
+
+    if (!(s->armed & BIT(alarm)) || (s->pause & TIMER_PAUSE_MASK)) {
+        timer_del(s->alarm_timer[alarm]);
+        return;
+    }
+
+    now_us = rp2040_timer_now_us(s);
+    delta = s->alarm[alarm] - (uint32_t)now_us;
+    if (delta == 0 || delta > INT32_MAX) {
+        timer_del(s->alarm_timer[alarm]);
+        s->armed &= ~BIT(alarm);
+        s->intr |= BIT(alarm);
+        rp2040_timer_update_irq(s);
+    } else {
+        timer_mod(s->alarm_timer[alarm],
+                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
+                  (int64_t)delta * 1000);
+    }
+}
+
+static void rp2040_timer_update_alarms(RP2040TimerState *s)
+{
+    int i;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        rp2040_timer_update_alarm(s, i);
+    }
+}
+
+static bool rp2040_timer_alarm_offset(hwaddr offset, unsigned *alarm)
+{
+    if (offset < TIMER_ALARM0 || offset > TIMER_ALARM3 || (offset & 0x3)) {
+        return false;
+    }
+
+    *alarm = (offset - TIMER_ALARM0) / sizeof(uint32_t);
+    return true;
+}
+
+static uint64_t rp2040_timer_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040TimerState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t now_us = rp2040_timer_now_us(s);
+    unsigned alarm;
+    uint64_t value;
+
+    switch (offset) {
+    case TIMER_TIMEHR:
+    case TIMER_TIMERAWH:
+        value = now_us >> 32;
+        break;
+    case TIMER_TIMELR:
+    case TIMER_TIMERAWL:
+        value = (uint32_t)now_us;
+        break;
+    case TIMER_ARMED:
+        value = s->armed;
+        break;
+    case TIMER_DBGPAUSE:
+        value = s->dbgpause;
+        break;
+    case TIMER_PAUSE:
+        value = s->pause;
+        break;
+    case TIMER_INTR:
+        value = s->intr;
+        break;
+    case TIMER_INTE:
+        value = s->inte;
+        break;
+    case TIMER_INTF:
+        value = s->intf;
+        break;
+    case TIMER_INTS:
+        value = rp2040_timer_ints(s);
+        break;
+    default:
+        if (rp2040_timer_alarm_offset(offset, &alarm)) {
+            value = s->alarm[alarm];
+        } else {
+            value = 0;
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+        }
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_timer_set_time(RP2040TimerState *s, uint64_t value)
+{
+    if (s->pause & TIMER_PAUSE_MASK) {
+        s->paused_time_us = value;
+    } else {
+        s->time_offset_us = value -
+                            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000;
+    }
+    rp2040_timer_update_alarms(s);
+}
+
+static void rp2040_timer_write(void *opaque, hwaddr addr,
+                               uint64_t value64, unsigned size)
+{
+    RP2040TimerState *s = opaque;
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+    uint32_t old;
+    uint64_t now_us;
+    unsigned alarm;
+
+    switch (offset) {
+    case TIMER_TIMEHW:
+        now_us = rp2040_timer_now_us(s);
+        rp2040_timer_set_time(s, ((uint64_t)value << 32) |
+                              (uint32_t)now_us);
+        break;
+    case TIMER_TIMELW:
+        now_us = rp2040_timer_now_us(s);
+        rp2040_timer_set_time(s, (now_us & UINT64_C(0xffffffff00000000)) |
+                              value);
+        break;
+    case TIMER_ARMED:
+        s->armed &= ~(value & TIMER_ALARM_MASK);
+        rp2040_timer_update_alarms(s);
+        break;
+    case TIMER_DBGPAUSE:
+        s->dbgpause = rp2040_atomic_update(s->dbgpause, value, alias) &
+                      TIMER_DBGPAUSE_MASK;
+        break;
+    case TIMER_PAUSE:
+        old = s->pause;
+        now_us = rp2040_timer_now_us(s);
+        s->pause = rp2040_atomic_update(s->pause, value, alias) &
+                   TIMER_PAUSE_MASK;
+        if (!(old & TIMER_PAUSE_MASK) && (s->pause & TIMER_PAUSE_MASK)) {
+            s->paused_time_us = now_us;
+        } else if ((old & TIMER_PAUSE_MASK) &&
+                   !(s->pause & TIMER_PAUSE_MASK)) {
+            s->time_offset_us = s->paused_time_us -
+                                qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000;
+            rp2040_timer_update_alarms(s);
+        }
+        break;
+    case TIMER_INTR:
+        s->intr &= ~(value & TIMER_ALARM_MASK);
+        rp2040_timer_update_irq(s);
+        break;
+    case TIMER_INTE:
+        s->inte = rp2040_atomic_update(s->inte, value, alias) &
+                  TIMER_ALARM_MASK;
+        rp2040_timer_update_irq(s);
+        break;
+    case TIMER_INTF:
+        s->intf = rp2040_atomic_update(s->intf, value, alias) &
+                  TIMER_ALARM_MASK;
+        rp2040_timer_update_irq(s);
+        break;
+    default:
+        if (rp2040_timer_alarm_offset(offset, &alarm)) {
+            s->alarm[alarm] = value;
+            s->armed |= BIT(alarm);
+            rp2040_timer_update_alarm(s, alarm);
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_timer_ops = {
+    .read = rp2040_timer_read,
+    .write = rp2040_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_timer_alarm_tick(void *opaque)
+{
+    uintptr_t packed = (uintptr_t)opaque;
+    RP2040TimerState *s = (RP2040TimerState *)(packed & ~(uintptr_t)0x3);
+    unsigned alarm = packed & 0x3;
+
+    s->armed &= ~BIT(alarm);
+    s->intr |= BIT(alarm);
+    rp2040_timer_update_irq(s);
+}
+
+static void rp2040_timer_reset(DeviceState *dev)
+{
+    RP2040TimerState *s = RP2040_TIMER(dev);
+    int i;
+
+    s->time_offset_us = -qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 1000;
+    s->paused_time_us = 0;
+    memset(s->alarm, 0, sizeof(s->alarm));
+    s->armed = 0;
+    s->dbgpause = TIMER_DBGPAUSE_MASK;
+    s->pause = 0;
+    s->intr = 0;
+    s->inte = 0;
+    s->intf = 0;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        timer_del(s->alarm_timer[i]);
+        qemu_set_irq(s->irq[i], 0);
+    }
+}
+
+static void rp2040_timer_init(Object *obj)
+{
+    RP2040TimerState *s = RP2040_TIMER(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_timer_ops, s,
+                          "rp2040.timer", RP2040_TIMER_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[0]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[1]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[2]);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[3]);
+}
+
+static void rp2040_timer_realize(DeviceState *dev, Error **errp)
+{
+    RP2040TimerState *s = RP2040_TIMER(dev);
+    int i;
+
+    for (i = 0; i < RP2040_TIMER_NUM_ALARMS; i++) {
+        s->alarm_timer[i] =
+            timer_new_ns(QEMU_CLOCK_VIRTUAL, rp2040_timer_alarm_tick,
+                         (void *)((uintptr_t)s | i));
+    }
+}
+
+static const VMStateDescription rp2040_timer_vmstate = {
+    .name = TYPE_RP2040_TIMER,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_TIMER_PTR_ARRAY(alarm_timer, RP2040TimerState,
+                                RP2040_TIMER_NUM_ALARMS),
+        VMSTATE_INT64(time_offset_us, RP2040TimerState),
+        VMSTATE_UINT64(paused_time_us, RP2040TimerState),
+        VMSTATE_UINT32_ARRAY(alarm, RP2040TimerState,
+                             RP2040_TIMER_NUM_ALARMS),
+        VMSTATE_UINT32(armed, RP2040TimerState),
+        VMSTATE_UINT32(dbgpause, RP2040TimerState),
+        VMSTATE_UINT32(pause, RP2040TimerState),
+        VMSTATE_UINT32(intr, RP2040TimerState),
+        VMSTATE_UINT32(inte, RP2040TimerState),
+        VMSTATE_UINT32(intf, RP2040TimerState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void rp2040_timer_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_timer_realize;
+    device_class_set_legacy_reset(dc, rp2040_timer_reset);
+    dc->vmsd = &rp2040_timer_vmstate;
+}
+
+static const TypeInfo rp2040_timer_info = {
+    .name          = TYPE_RP2040_TIMER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040TimerState),
+    .instance_init = rp2040_timer_init,
+    .class_init    = rp2040_timer_class_init,
+};
+
+static void rp2040_timer_register_types(void)
+{
+    type_register_static(&rp2040_timer_info);
+}
+
+type_init(rp2040_timer_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 9fcc50eb3e..788b821d0e 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -25,6 +25,7 @@
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_tbman.h"
+#include "hw/misc/rp2040_timer.h"
 #include "hw/misc/rp2040_vreg.h"
 #include "hw/misc/rp2040_watchdog.h"
 #include "hw/misc/rp2040_xosc.h"
@@ -64,6 +65,7 @@ struct RP2040State {
     RP2040RoscState rosc;
     RP2040SioState sio;
     RP2040TbmanState tbman;
+    RP2040TimerState timer;
     RP2040VregState vreg;
     RP2040WatchdogState watchdog;
     RP2040XoscState xosc;
diff --git a/include/hw/misc/rp2040_timer.h b/include/hw/misc/rp2040_timer.h
new file mode 100644
index 0000000000..b14bf75d53
--- /dev/null
+++ b/include/hw/misc/rp2040_timer.h
@@ -0,0 +1,39 @@
+/*
+ * RP2040 timer emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_TIMER_H
+#define HW_MISC_RP2040_TIMER_H
+
+#include "hw/core/sysbus.h"
+#include "qemu/timer.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_TIMER "rp2040-timer"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040TimerState, RP2040_TIMER)
+
+#define RP2040_TIMER_BASE 0x40054000
+#define RP2040_TIMER_SIZE 0x4000
+#define RP2040_TIMER_NUM_ALARMS 4
+
+struct RP2040TimerState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq irq[RP2040_TIMER_NUM_ALARMS];
+    QEMUTimer *alarm_timer[RP2040_TIMER_NUM_ALARMS];
+
+    int64_t time_offset_us;
+    uint64_t paused_time_us;
+    uint32_t alarm[RP2040_TIMER_NUM_ALARMS];
+    uint32_t armed;
+    uint32_t dbgpause;
+    uint32_t pause;
+    uint32_t intr;
+    uint32_t inte;
+    uint32_t intf;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fca71c8bef..e2ffb99b1f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -274,6 +274,7 @@ qtests_arm = \
     'rp2040-rosc-test',
     'rp2040-sio-test',
     'rp2040-tbman-test',
+    'rp2040-timer-test',
     'rp2040-uart-test',
     'rp2040-vreg-test',
     'rp2040-watchdog-test'] : []) + \
diff --git a/tests/qtest/rp2040-timer-test.c b/tests/qtest/rp2040-timer-test.c
new file mode 100644
index 0000000000..35185415b5
--- /dev/null
+++ b/tests/qtest/rp2040-timer-test.c
@@ -0,0 +1,149 @@
+/*
+ * QTest testcase for the RP2040 timer.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define TIMER_BASE          0x40054000
+#define TIMER_TIMEHW        0x00
+#define TIMER_TIMELW        0x04
+#define TIMER_TIMEHR        0x08
+#define TIMER_TIMELR        0x0c
+#define TIMER_ALARM0        0x10
+#define TIMER_ARMED         0x20
+#define TIMER_TIMERAWH      0x24
+#define TIMER_TIMERAWL      0x28
+#define TIMER_DBGPAUSE      0x2c
+#define TIMER_PAUSE         0x30
+#define TIMER_INTR          0x34
+#define TIMER_INTE          0x38
+#define TIMER_INTF          0x3c
+#define TIMER_INTS          0x40
+
+#define TIMER_SET_ALIAS     0x2000
+#define TIMER_CLR_ALIAS     0x3000
+#define TIMER_ALARM_MASK    0x0f
+#define TIMER_DBGPAUSE_MASK (BIT(2) | BIT(1))
+#define TIMER_PAUSE_MASK    BIT(0)
+#define NS_PER_US           1000
+
+static QTestState *rp2040_timer_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = rp2040_timer_start();
+
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_ARMED), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_DBGPAUSE), ==,
+                    TIMER_DBGPAUSE_MASK);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_PAUSE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTF), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_TIMEHR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWH), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_counter_and_pause(void)
+{
+    QTestState *qts = rp2040_timer_start();
+    uint32_t before = qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWL);
+    uint32_t paused;
+
+    qtest_clock_step(qts, 123 * NS_PER_US);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWL) - before,
+                    ==, 123);
+
+    qtest_writel(qts, TIMER_BASE + TIMER_PAUSE, TIMER_PAUSE_MASK);
+    paused = qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWL);
+    qtest_clock_step(qts, 100 * NS_PER_US);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWL), ==,
+                    paused);
+
+    qtest_writel(qts, TIMER_BASE + TIMER_TIMEHW, 0);
+    qtest_writel(qts, TIMER_BASE + TIMER_TIMELW, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWL), ==,
+                    0x12345678);
+
+    qtest_writel(qts, TIMER_BASE + TIMER_CLR_ALIAS + TIMER_PAUSE,
+                 TIMER_PAUSE_MASK);
+    qtest_clock_step(qts, 10 * NS_PER_US);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_TIMELR), ==,
+                    0x12345682);
+
+    qtest_quit(qts);
+}
+
+static void test_alarm(void)
+{
+    QTestState *qts = rp2040_timer_start();
+    uint32_t now = qtest_readl(qts, TIMER_BASE + TIMER_TIMERAWL);
+
+    qtest_writel(qts, TIMER_BASE + TIMER_INTE, BIT(0));
+    qtest_writel(qts, TIMER_BASE + TIMER_ALARM0, now + 100);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_ARMED), ==, BIT(0));
+
+    qtest_clock_step(qts, 99 * NS_PER_US);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTR), ==, 0);
+    qtest_clock_step(qts, NS_PER_US);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_ARMED), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTR), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTS), ==, BIT(0));
+
+    qtest_writel(qts, TIMER_BASE + TIMER_INTR, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTS), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_interrupt_force_and_masks(void)
+{
+    QTestState *qts = rp2040_timer_start();
+
+    qtest_writel(qts, TIMER_BASE + TIMER_SET_ALIAS + TIMER_INTE,
+                 BIT(2) | BIT(8));
+    qtest_writel(qts, TIMER_BASE + TIMER_SET_ALIAS + TIMER_INTF,
+                 BIT(2) | BIT(9));
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTE), ==, BIT(2));
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTF), ==, BIT(2));
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTS), ==, BIT(2));
+
+    qtest_writel(qts, TIMER_BASE + TIMER_CLR_ALIAS + TIMER_INTF, BIT(2));
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTF), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_INTS), ==, 0);
+
+    qtest_writel(qts, TIMER_BASE + TIMER_ARMED, TIMER_ALARM_MASK);
+    qtest_writel(qts, TIMER_BASE + TIMER_DBGPAUSE, UINT32_MAX);
+    qtest_writel(qts, TIMER_BASE + TIMER_PAUSE, UINT32_MAX);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_DBGPAUSE), ==,
+                    TIMER_DBGPAUSE_MASK);
+    g_assert_cmphex(qtest_readl(qts, TIMER_BASE + TIMER_PAUSE), ==,
+                    TIMER_PAUSE_MASK);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-timer/reset-values", test_reset_values);
+    qtest_add_func("/rp2040-timer/counter-and-pause",
+                   test_counter_and_pause);
+    qtest_add_func("/rp2040-timer/alarm", test_alarm);
+    qtest_add_func("/rp2040-timer/interrupt-force-and-masks",
+                   test_interrupt_force_and_masks);
+
+    return g_test_run();
+}
-- 
2.55.0


