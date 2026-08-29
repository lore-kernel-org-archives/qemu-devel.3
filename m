Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC48C61DDE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Sis-0008ED-7G; Sat, 29 Aug 2026 19:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Sip-0008Db-Kl; Sat, 29 Aug 2026 19:44:27 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Sil-0006H2-Ua; Sat, 29 Aug 2026 19:44:27 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXWzf3Gm7z838H;
 Sun, 30 Aug 2026 01:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047022;
 bh=jaGznRlhYw7viXdXk7BC2gWQcp908uo1V4fO1DssXg8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BoqApYQ0kdvdU9NUEr4dALvT2CPU7UxFMOP8g2Il0Tz08oBcEY29ymduPZn11WdJ2
 57v7K9iOYCwmHjzSy02qCHLgXRwHfUXuYvRjQAxgkYbU1w+GMkBt5uTNBk+wMb8UhN
 oGz3pwZmFRdZFLnpXkqRMvvndcC2/6aHuIcl3UEQRtk++MCWFy7NxFHFHyaI/TjWUk
 n+aIuG3eYasXPmMZrOEqAzs2oD4NfsjEN7hEnPWHVCLx8KVmRie3GLk5IJ9Lo9/IwJ
 utNJpzy5K4WmXssk5ObFTZsxNh8Ii+5c8oVpGkO+dQnUSri51VdoB5g1ZU5N0+/Icl
 /t1Q9EIs5YU5g==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzf10dVz7vrV;
 Sun, 30 Aug 2026 01:43:42 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 11/30] hw/misc: add RP2040 watchdog
Date: Sun, 30 Aug 2026 01:42:45 +0200
Message-ID: <20260829234308.33725-12-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.106;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-2.univ-lille.fr
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Model the RP2040 watchdog control, load, reason, scratch and tick registers. Drive the counter from clk_ref with the RP2040-E1 twice-per-tick behavior and use QEMU's standard watchdog action for timer expiry and forced resets. Add qtests for reset state, sub-word scratch accesses, timer expiry and forced triggering.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                     |   1 +
 hw/arm/rp2040.c                    |  11 +-
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/rp2040_watchdog.c          | 361 +++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h            |   2 +
 include/hw/misc/rp2040_watchdog.h  |  35 +++
 tests/qtest/meson.build            |   3 +-
 tests/qtest/rp2040-watchdog-test.c | 148 ++++++++++++
 9 files changed, 563 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/rp2040_watchdog.c
 create mode 100644 include/hw/misc/rp2040_watchdog.h
 create mode 100644 tests/qtest/rp2040-watchdog-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2ea9ec31df..384ea0520f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -388,6 +388,7 @@ config RP2040
     select RP2040_SYSINFO
     select RP2040_TBMAN
     select RP2040_VREG
+    select RP2040_WATCHDOG
     select RP2040_XOSC
     select UNIMP
 
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 28b4079ff9..7b3bb0e7b1 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -62,7 +62,6 @@ static const struct {
     { "rp2040.adc",      0x4004c000, 0x4000 },
     { "rp2040.pwm",      0x40050000, 0x4000 },
     { "rp2040.timer",    0x40054000, 0x4000 },
-    { "rp2040.watchdog", 0x40058000, 0x4000 },
     { "rp2040.rtc",      0x4005c000, 0x4000 },
     { "rp2040.dma",      0x50000000, 0x1000 },
     { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
@@ -187,6 +186,8 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
     object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
     object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
+    object_initialize_child(obj, "watchdog", &s->watchdog,
+                            TYPE_RP2040_WATCHDOG);
     object_initialize_child(obj, "xosc", &s->xosc, TYPE_RP2040_XOSC);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
@@ -379,6 +380,14 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->vreg), 0, RP2040_VREG_BASE);
 
+    qdev_connect_clock_in(DEVICE(&s->watchdog), "clk-ref",
+                          qdev_get_clock_out(DEVICE(&s->clocks), "clk-ref"));
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->watchdog), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->watchdog), 0,
+                    RP2040_WATCHDOG_BASE);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->xosc), errp)) {
         return;
     }
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 9c15b56f74..c6a815f9bc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -131,6 +131,9 @@ config RP2040_TBMAN
 config RP2040_VREG
     bool
 
+config RP2040_WATCHDOG
+    bool
+
 config RP2040_XOSC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 2589bec8a6..cdbfa7de31 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -108,6 +108,7 @@ system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_RP2040_TBMAN', if_true: files('rp2040_tbman.c'))
 system_ss.add(when: 'CONFIG_RP2040_VREG', if_true: files('rp2040_vreg.c'))
+system_ss.add(when: 'CONFIG_RP2040_WATCHDOG', if_true: files('rp2040_watchdog.c'))
 system_ss.add(when: 'CONFIG_RP2040_XOSC', if_true: files('rp2040_xosc.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/rp2040_watchdog.c b/hw/misc/rp2040_watchdog.c
new file mode 100644
index 0000000000..eb767304b2
--- /dev/null
+++ b/hw/misc/rp2040_watchdog.c
@@ -0,0 +1,361 @@
+/*
+ * RP2040 watchdog emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_watchdog.h"
+#include "migration/vmstate.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "system/watchdog.h"
+
+#define WATCHDOG_CTRL       0x00
+#define WATCHDOG_LOAD       0x04
+#define WATCHDOG_REASON     0x08
+#define WATCHDOG_SCRATCH0   0x0c
+#define WATCHDOG_SCRATCH7   0x28
+#define WATCHDOG_TICK       0x2c
+
+#define WATCHDOG_CTRL_TRIGGER   BIT(31)
+#define WATCHDOG_CTRL_ENABLE    BIT(30)
+#define WATCHDOG_CTRL_PAUSE_DBG1 BIT(26)
+#define WATCHDOG_CTRL_PAUSE_DBG0 BIT(25)
+#define WATCHDOG_CTRL_PAUSE_JTAG BIT(24)
+#define WATCHDOG_CTRL_PAUSE_MASK \
+    (WATCHDOG_CTRL_PAUSE_DBG1 | WATCHDOG_CTRL_PAUSE_DBG0 | \
+     WATCHDOG_CTRL_PAUSE_JTAG)
+#define WATCHDOG_CTRL_TIME_MASK 0x00ffffff
+#define WATCHDOG_CTRL_RW_MASK \
+    (WATCHDOG_CTRL_ENABLE | WATCHDOG_CTRL_PAUSE_MASK)
+
+#define WATCHDOG_LOAD_MASK  0x00ffffff
+#define WATCHDOG_REASON_FORCE   BIT(1)
+#define WATCHDOG_REASON_TIMER   BIT(0)
+
+#define WATCHDOG_TICK_ENABLE    BIT(9)
+#define WATCHDOG_TICK_RUNNING   BIT(10)
+#define WATCHDOG_TICK_CYCLES_MASK 0x000001ff
+#define WATCHDOG_TICK_RW_MASK \
+    (WATCHDOG_TICK_ENABLE | WATCHDOG_TICK_CYCLES_MASK)
+#define WATCHDOG_TICK_COUNT_SHIFT 11
+
+#define ATOMIC_ALIAS_MASK   0x3000
+#define ATOMIC_XOR          0x1000
+#define ATOMIC_SET          0x2000
+#define ATOMIC_CLR          0x3000
+
+static uint32_t rp2040_watchdog_apply_alias(uint32_t old, uint32_t value,
+                                            hwaddr alias)
+{
+    switch (alias) {
+    case ATOMIC_XOR:
+        return old ^ value;
+    case ATOMIC_SET:
+        return old | value;
+    case ATOMIC_CLR:
+        return old & ~value;
+    default:
+        return value;
+    }
+}
+
+static uint32_t rp2040_watchdog_expand_write(uint32_t value, unsigned size)
+{
+    switch (size) {
+    case 1:
+        return value * 0x01010101u;
+    case 2:
+        return (value & 0xffffu) * 0x00010001u;
+    default:
+        return value;
+    }
+}
+
+static bool rp2040_watchdog_scratch_offset(hwaddr offset, unsigned *index)
+{
+    if (offset < WATCHDOG_SCRATCH0 || offset > WATCHDOG_SCRATCH7) {
+        return false;
+    }
+
+    *index = (offset - WATCHDOG_SCRATCH0) / sizeof(uint32_t);
+    return true;
+}
+
+static bool rp2040_watchdog_tick_running(RP2040WatchdogState *s)
+{
+    return (s->tick & WATCHDOG_TICK_ENABLE) &&
+           (s->tick & WATCHDOG_TICK_CYCLES_MASK) &&
+           clock_get_hz(s->clk_ref);
+}
+
+static uint32_t rp2040_watchdog_tick_freq_hz(RP2040WatchdogState *s)
+{
+    uint64_t clk_ref_hz = clock_get_hz(s->clk_ref);
+    uint32_t cycles = s->tick & WATCHDOG_TICK_CYCLES_MASK;
+
+    if (!cycles || !clk_ref_hz || !(s->tick & WATCHDOG_TICK_ENABLE)) {
+        return 0;
+    }
+
+    return MIN(UINT32_MAX, (uint32_t)(clk_ref_hz / cycles));
+}
+
+static uint32_t rp2040_watchdog_tick_read(RP2040WatchdogState *s)
+{
+    uint32_t value = s->tick & WATCHDOG_TICK_RW_MASK;
+
+    if (rp2040_watchdog_tick_running(s)) {
+        /*
+         * The precise divider phase is not observable by current firmware
+         * tests. Report a stable running state and a valid non-zero count.
+         */
+        value |= WATCHDOG_TICK_RUNNING;
+        value |= (s->tick & WATCHDOG_TICK_CYCLES_MASK) <<
+                 WATCHDOG_TICK_COUNT_SHIFT;
+    }
+
+    return value;
+}
+
+static void rp2040_watchdog_update(RP2040WatchdogState *s)
+{
+    uint32_t tick_hz = rp2040_watchdog_tick_freq_hz(s);
+    uint64_t watchdog_hz = (uint64_t)tick_hz * 2;
+
+    ptimer_transaction_begin(s->timer);
+    if (!tick_hz) {
+        ptimer_stop(s->timer);
+    } else {
+        /*
+         * RP2040-E1: the watchdog counter decrements twice per watchdog
+         * tick, so a LOAD of N expires after N / 2 generated ticks.
+         */
+        ptimer_set_freq(s->timer, MIN(watchdog_hz, (uint64_t)UINT32_MAX));
+        if (s->ctrl & WATCHDOG_CTRL_ENABLE) {
+            ptimer_run(s->timer, 1);
+        } else {
+            ptimer_stop(s->timer);
+        }
+    }
+    ptimer_transaction_commit(s->timer);
+}
+
+static uint32_t rp2040_watchdog_ctrl_read(RP2040WatchdogState *s)
+{
+    uint32_t time = MIN(ptimer_get_count(s->timer), WATCHDOG_CTRL_TIME_MASK);
+
+    return (s->ctrl & WATCHDOG_CTRL_RW_MASK) | time;
+}
+
+static void rp2040_watchdog_reset_request(RP2040WatchdogState *s,
+                                          uint32_t reason,
+                                          bool in_ptimer_transaction)
+{
+    s->reason = reason;
+    if (!in_ptimer_transaction) {
+        ptimer_transaction_begin(s->timer);
+    }
+    ptimer_stop(s->timer);
+    if (!in_ptimer_transaction) {
+        ptimer_transaction_commit(s->timer);
+    }
+    watchdog_perform_action();
+}
+
+static uint64_t rp2040_watchdog_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040WatchdogState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    hwaddr word_offset = offset & ~3ULL;
+    unsigned scratch;
+    uint64_t value;
+
+    switch (word_offset) {
+    case WATCHDOG_CTRL:
+        value = rp2040_watchdog_ctrl_read(s);
+        break;
+    case WATCHDOG_LOAD:
+        value = 0;
+        break;
+    case WATCHDOG_REASON:
+        value = s->reason;
+        break;
+    case WATCHDOG_TICK:
+        value = rp2040_watchdog_tick_read(s);
+        break;
+    default:
+        if (rp2040_watchdog_scratch_offset(word_offset, &scratch)) {
+            value = s->scratch[scratch];
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("watchdog", size,
+                                          RP2040_WATCHDOG_BASE + addr,
+                                          offset, value);
+        }
+        break;
+    }
+
+    return extract64(value, (offset & 3) * 8, size * 8);
+}
+
+static void rp2040_watchdog_write(void *opaque, hwaddr addr,
+                                  uint64_t value64, unsigned size)
+{
+    RP2040WatchdogState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    hwaddr word_offset = offset & ~3ULL;
+    unsigned scratch;
+    uint32_t value = rp2040_watchdog_expand_write(value64, size);
+
+    switch (word_offset) {
+    case WATCHDOG_CTRL: {
+        uint32_t old = rp2040_watchdog_ctrl_read(s);
+        uint32_t newval = rp2040_watchdog_apply_alias(old, value, alias);
+
+        s->ctrl = newval & WATCHDOG_CTRL_RW_MASK;
+        rp2040_watchdog_update(s);
+        if (newval & WATCHDOG_CTRL_TRIGGER) {
+            rp2040_watchdog_reset_request(s, WATCHDOG_REASON_FORCE, false);
+        }
+        break;
+    }
+    case WATCHDOG_LOAD:
+        s->load = rp2040_watchdog_apply_alias(s->load, value, alias) &
+                  WATCHDOG_LOAD_MASK;
+        ptimer_transaction_begin(s->timer);
+        ptimer_set_limit(s->timer, s->load, 1);
+        ptimer_transaction_commit(s->timer);
+        rp2040_watchdog_update(s);
+        break;
+    case WATCHDOG_REASON:
+        break;
+    case WATCHDOG_TICK:
+        s->tick = rp2040_watchdog_apply_alias(s->tick, value, alias) &
+                  WATCHDOG_TICK_RW_MASK;
+        rp2040_watchdog_update(s);
+        break;
+    default:
+        if (rp2040_watchdog_scratch_offset(word_offset, &scratch)) {
+            s->scratch[scratch] =
+                rp2040_watchdog_apply_alias(s->scratch[scratch], value,
+                                            alias);
+        } else {
+            rp2040_log_unimplemented_write("watchdog", size,
+                                           RP2040_WATCHDOG_BASE + addr,
+                                           offset, value64);
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_watchdog_ops = {
+    .read = rp2040_watchdog_read,
+    .write = rp2040_watchdog_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void rp2040_watchdog_reset(DeviceState *dev)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(dev);
+
+    s->ctrl = WATCHDOG_CTRL_PAUSE_MASK;
+    s->load = 0;
+    s->tick = WATCHDOG_TICK_ENABLE;
+
+    ptimer_transaction_begin(s->timer);
+    ptimer_stop(s->timer);
+    ptimer_set_limit(s->timer, 0, 1);
+    ptimer_transaction_commit(s->timer);
+}
+
+static void rp2040_watchdog_clk_ref_update(void *opaque, ClockEvent event)
+{
+    rp2040_watchdog_update(opaque);
+}
+
+static void rp2040_watchdog_tick(void *opaque)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(opaque);
+
+    rp2040_watchdog_reset_request(s, WATCHDOG_REASON_TIMER, true);
+}
+
+static void rp2040_watchdog_init(Object *obj)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk_ref = qdev_init_clock_in(dev, "clk-ref",
+                                    rp2040_watchdog_clk_ref_update, s,
+                                    ClockUpdate);
+    memory_region_init_io(&s->iomem, obj, &rp2040_watchdog_ops, s,
+                          "rp2040.watchdog", RP2040_WATCHDOG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static void rp2040_watchdog_realize(DeviceState *dev, Error **errp)
+{
+    RP2040WatchdogState *s = RP2040_WATCHDOG(dev);
+
+    if (!clock_has_source(s->clk_ref)) {
+        error_setg(errp, "RP2040 watchdog: clk-ref clock must be connected");
+        return;
+    }
+
+    s->timer = ptimer_init(rp2040_watchdog_tick, s,
+                           PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
+                           PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+}
+
+static const VMStateDescription rp2040_watchdog_vmstate = {
+    .name = TYPE_RP2040_WATCHDOG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_CLOCK(clk_ref, RP2040WatchdogState),
+        VMSTATE_PTIMER(timer, RP2040WatchdogState),
+        VMSTATE_UINT32(ctrl, RP2040WatchdogState),
+        VMSTATE_UINT32(load, RP2040WatchdogState),
+        VMSTATE_UINT32(reason, RP2040WatchdogState),
+        VMSTATE_UINT32_ARRAY(scratch, RP2040WatchdogState, 8),
+        VMSTATE_UINT32(tick, RP2040WatchdogState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_watchdog_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = rp2040_watchdog_realize;
+    device_class_set_legacy_reset(dc, rp2040_watchdog_reset);
+    dc->vmsd = &rp2040_watchdog_vmstate;
+}
+
+static const TypeInfo rp2040_watchdog_info = {
+    .name          = TYPE_RP2040_WATCHDOG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040WatchdogState),
+    .instance_init = rp2040_watchdog_init,
+    .class_init    = rp2040_watchdog_class_init,
+};
+
+static void rp2040_watchdog_register_types(void)
+{
+    type_register_static(&rp2040_watchdog_info);
+}
+type_init(rp2040_watchdog_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 431648af63..6c6eb3d927 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -22,6 +22,7 @@
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_tbman.h"
 #include "hw/misc/rp2040_vreg.h"
+#include "hw/misc/rp2040_watchdog.h"
 #include "hw/misc/rp2040_xosc.h"
 #include "qom/object.h"
 
@@ -54,6 +55,7 @@ struct RP2040State {
     RP2040RoscState rosc;
     RP2040TbmanState tbman;
     RP2040VregState vreg;
+    RP2040WatchdogState watchdog;
     RP2040XoscState xosc;
 
     MemoryRegion *board_memory;
diff --git a/include/hw/misc/rp2040_watchdog.h b/include/hw/misc/rp2040_watchdog.h
new file mode 100644
index 0000000000..2da12c9441
--- /dev/null
+++ b/include/hw/misc/rp2040_watchdog.h
@@ -0,0 +1,35 @@
+/*
+ * RP2040 watchdog emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_WATCHDOG_H
+#define HW_MISC_RP2040_WATCHDOG_H
+
+#include "hw/core/clock.h"
+#include "hw/core/ptimer.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_WATCHDOG "rp2040-watchdog"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040WatchdogState, RP2040_WATCHDOG)
+
+#define RP2040_WATCHDOG_BASE 0x40058000
+#define RP2040_WATCHDOG_SIZE 0x4000
+
+struct RP2040WatchdogState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk_ref;
+    ptimer_state *timer;
+
+    uint32_t ctrl;
+    uint32_t load;
+    uint32_t reason;
+    uint32_t scratch[8];
+    uint32_t tick;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 03bd78b551..e5ddd4ce3b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -260,7 +260,8 @@ qtests_arm = \
                                                        'rp2040-resets-test',
                                                        'rp2040-rosc-test',
                                                        'rp2040-tbman-test',
-                                                       'rp2040-vreg-test'] : []) + \
+                                                       'rp2040-vreg-test',
+                                                       'rp2040-watchdog-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-watchdog-test.c b/tests/qtest/rp2040-watchdog-test.c
new file mode 100644
index 0000000000..14b6f12f1a
--- /dev/null
+++ b/tests/qtest/rp2040-watchdog-test.c
@@ -0,0 +1,148 @@
+/*
+ * QTest testcase for the RP2040 watchdog.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "qobject/qdict.h"
+
+#define WATCHDOG_BASE       0x40058000
+#define WATCHDOG_CTRL       0x00
+#define WATCHDOG_LOAD       0x04
+#define WATCHDOG_REASON     0x08
+#define WATCHDOG_SCRATCH0   0x0c
+#define WATCHDOG_TICK       0x2c
+
+#define CTRL_TRIGGER        BIT(31)
+#define CTRL_ENABLE         BIT(30)
+#define CTRL_PAUSE_DBG1     BIT(26)
+#define CTRL_PAUSE_DBG0     BIT(25)
+#define CTRL_PAUSE_JTAG     BIT(24)
+#define CTRL_TIME_MASK      0x00ffffff
+
+#define REASON_FORCE        BIT(1)
+#define REASON_TIMER        BIT(0)
+
+#define TICK_RUNNING        BIT(10)
+#define TICK_ENABLE         BIT(9)
+
+#define NS_PER_US           1000
+
+static QTestState *rp2040_watchdog_start(void)
+{
+    return qtest_init("-machine raspi-pico -watchdog-action none");
+}
+
+static void check_watchdog_event(QTestState *qts)
+{
+    QDict *event = qtest_qmp_eventwait_ref(qts, "WATCHDOG");
+    QDict *data = qdict_get_qdict(event, "data");
+
+    g_assert_cmpstr(qdict_get_str(data, "action"), ==, "none");
+    qobject_unref(event);
+}
+
+static void test_reset_values(void)
+{
+    QTestState *qts = rp2040_watchdog_start();
+
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_CTRL), ==,
+                    CTRL_PAUSE_DBG1 | CTRL_PAUSE_DBG0 | CTRL_PAUSE_JTAG);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_LOAD), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_REASON), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_TICK), ==,
+                    TICK_ENABLE);
+
+    qtest_quit(qts);
+}
+
+static void test_scratch_registers(void)
+{
+    QTestState *qts = rp2040_watchdog_start();
+
+    qtest_writel(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0), ==,
+                    0x12345678);
+
+    g_assert_cmphex(qtest_readb(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0), ==,
+                    0x78);
+    g_assert_cmphex(qtest_readb(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0 + 1),
+                    ==, 0x56);
+    g_assert_cmphex(qtest_readb(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0 + 2),
+                    ==, 0x34);
+    g_assert_cmphex(qtest_readb(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0 + 3),
+                    ==, 0x12);
+
+    qtest_writeb(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0, 0xa5);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0), ==,
+                    0xa5a5a5a5);
+
+    qtest_writeb(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0 + 1, 0x3c);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0), ==,
+                    0x3c3c3c3c);
+
+    qtest_writew(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0, 0xf00d);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_SCRATCH0), ==,
+                    0xf00df00d);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_expiry(void)
+{
+    QTestState *qts = rp2040_watchdog_start();
+    uint32_t ctrl;
+
+    /*
+     * The default clk_ref is 6 MHz. CYCLES=6 generates a 1 MHz watchdog
+     * tick; RP2040-E1 makes the counter decrement twice per tick.
+     */
+    qtest_writel(qts, WATCHDOG_BASE + WATCHDOG_TICK, TICK_ENABLE | 6);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_TICK) &
+                    (TICK_RUNNING | TICK_ENABLE), ==,
+                    TICK_RUNNING | TICK_ENABLE);
+
+    qtest_writel(qts, WATCHDOG_BASE + WATCHDOG_LOAD, 20);
+    qtest_writel(qts, WATCHDOG_BASE + WATCHDOG_CTRL, CTRL_ENABLE);
+
+    qtest_clock_step(qts, 5 * NS_PER_US);
+    ctrl = qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_CTRL);
+    g_assert_cmpuint(ctrl & CTRL_TIME_MASK, <, 20);
+    g_assert_cmpuint(ctrl & CTRL_TIME_MASK, >, 0);
+
+    qtest_clock_step(qts, 10 * NS_PER_US);
+    check_watchdog_event(qts);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_REASON), ==,
+                    REASON_TIMER);
+
+    qtest_quit(qts);
+}
+
+static void test_force_trigger(void)
+{
+    QTestState *qts = rp2040_watchdog_start();
+
+    qtest_writel(qts, WATCHDOG_BASE + WATCHDOG_CTRL, CTRL_TRIGGER);
+    check_watchdog_event(qts);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_REASON), ==,
+                    REASON_FORCE);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-watchdog/reset-values", test_reset_values);
+    qtest_add_func("/rp2040-watchdog/scratch-registers",
+                   test_scratch_registers);
+    qtest_add_func("/rp2040-watchdog/timer-expiry", test_timer_expiry);
+    qtest_add_func("/rp2040-watchdog/force-trigger", test_force_trigger);
+
+    return g_test_run();
+}
-- 
2.55.0


