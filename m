Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F08C79F99
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3IoX-0003FZ-2R; Sun, 06 Sep 2026 15:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3IoU-00037P-3l; Sun, 06 Sep 2026 15:46:02 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3IoR-0007Ez-2P; Sun, 06 Sep 2026 15:46:01 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hdLJF0s0fz7ydV;
 Sun,  6 Sep 2026 21:44:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723885;
 bh=BTQwzySm7AQRDQat7SztWms+nUT3RVobRpI1Sz7OcZM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GEd3rcs+KCeBdpLtJGMfqSfi/ocEb+iQ+LA8d1Z360OuptAsmAouTys/1LbqA58UY
 4NWaROgGG+EHNvjoIK4xBd07Mqw1qBlugMD1dpnaPfWRUgC4pVqlPj+T5w84ILcxjC
 f09PY5EwW5Xol3OkTFeZ2sZtPP31xKh2/IyF6UJvo+Rqc5w3OTigO3ccV0wM0CmKc1
 pZGCb2hfFdiJ5hr966GJLYX47xgHHLui+5JtdR+xV5dRjJOyLqcO+fc+DfcnoqMP8s
 tOHIqUOTR5r1hrEOWXttAx/Crv7JJq7de8fNtTvj/hF3UMeRdSUKfdvCF0Bv5Dhu1l
 4lJKVOW733RSQ==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJD5tKYz7tc2;
 Sun,  6 Sep 2026 21:44:44 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 16/36] hw/misc: add RP2040 watchdog
Date: Sun,  6 Sep 2026 21:44:15 +0200
Message-ID: <20260906194438.93046-17-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 watchdog control, load, reason, scratch and tick
registers. Drive the counter from clk_ref with the RP2040-E1 twice-per-tick
behavior and use QEMU's standard watchdog action for timer expiry and
forced resets. Add qtests for reset state, sub-word scratch accesses, timer
expiry and forced triggering.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                    |  11 +-
 hw/misc/meson.build                |   5 +-
 hw/misc/rp2040_watchdog.c          | 349 +++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h            |   2 +
 include/hw/misc/rp2040_watchdog.h  |  36 +++
 tests/qtest/meson.build            |   3 +-
 tests/qtest/rp2040-watchdog-test.c | 170 ++++++++++++++
 7 files changed, 573 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/rp2040_watchdog.c
 create mode 100644 include/hw/misc/rp2040_watchdog.h
 create mode 100644 tests/qtest/rp2040-watchdog-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index fa28859309..140c73ae78 100644
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
@@ -153,6 +152,8 @@ static void rp2040_soc_init(Object *obj)
     object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
     object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
     object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
+    object_initialize_child(obj, "watchdog", &s->watchdog,
+                            TYPE_RP2040_WATCHDOG);
     object_initialize_child(obj, "xosc", &s->xosc, TYPE_RP2040_XOSC);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
@@ -332,6 +333,14 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c04e2ffe22..e03f45d667 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -104,9 +104,12 @@ system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_psm.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_resets.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_rosc.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_syscfg.c'))
-system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_sysinfo.c'))
+system_ss.add(when: 'CONFIG_RP2040',
+              if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_tbman.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_vreg.c'))
+system_ss.add(when: 'CONFIG_RP2040',
+              if_true: files('rp2040_watchdog.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_xosc.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/rp2040_watchdog.c b/hw/misc/rp2040_watchdog.c
new file mode 100644
index 0000000000..b15e30a285
--- /dev/null
+++ b/hw/misc/rp2040_watchdog.c
@@ -0,0 +1,349 @@
+/*
+ * RP2040 watchdog emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_watchdog.h"
+#include "hw/misc/rp2040.h"
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
+    s->preserve_reason_on_reset =
+        get_watchdog_action() == WATCHDOG_ACTION_RESET;
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
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    hwaddr word_offset = offset & ~3ULL;
+    unsigned scratch;
+    uint32_t value = rp2040_watchdog_expand_write(value64, size);
+
+    switch (word_offset) {
+    case WATCHDOG_CTRL: {
+        uint32_t old = rp2040_watchdog_ctrl_read(s);
+        uint32_t newval = rp2040_atomic_update(old, value, alias);
+
+        s->ctrl = newval & WATCHDOG_CTRL_RW_MASK;
+        rp2040_watchdog_update(s);
+        if (newval & WATCHDOG_CTRL_TRIGGER) {
+            rp2040_watchdog_reset_request(s, WATCHDOG_REASON_FORCE, false);
+        }
+        break;
+    }
+    case WATCHDOG_LOAD:
+        s->load = rp2040_atomic_update(s->load, value, alias) &
+                  WATCHDOG_LOAD_MASK;
+        ptimer_transaction_begin(s->timer);
+        ptimer_set_limit(s->timer, s->load, 1);
+        ptimer_transaction_commit(s->timer);
+        rp2040_watchdog_update(s);
+        break;
+    case WATCHDOG_REASON:
+        break;
+    case WATCHDOG_TICK:
+        s->tick = rp2040_atomic_update(s->tick, value, alias) &
+                  WATCHDOG_TICK_RW_MASK;
+        rp2040_watchdog_update(s);
+        break;
+    default:
+        if (rp2040_watchdog_scratch_offset(word_offset, &scratch)) {
+            s->scratch[scratch] =
+                rp2040_atomic_update(s->scratch[scratch], value,
+                                            alias);
+        } else {
+            qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    if (s->preserve_reason_on_reset) {
+        s->preserve_reason_on_reset = false;
+    } else {
+        s->reason = 0;
+    }
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
+        VMSTATE_BOOL(preserve_reason_on_reset, RP2040WatchdogState),
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
index 1c69ce089b..c3c6419613 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -22,6 +22,7 @@
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_tbman.h"
 #include "hw/misc/rp2040_vreg.h"
+#include "hw/misc/rp2040_watchdog.h"
 #include "hw/misc/rp2040_xosc.h"
 #include "qom/object.h"
 
@@ -55,6 +56,7 @@ struct RP2040State {
     RP2040RoscState rosc;
     RP2040TbmanState tbman;
     RP2040VregState vreg;
+    RP2040WatchdogState watchdog;
     RP2040XoscState xosc;
 
     MemoryRegion *board_memory;
diff --git a/include/hw/misc/rp2040_watchdog.h b/include/hw/misc/rp2040_watchdog.h
new file mode 100644
index 0000000000..9c3cb375e6
--- /dev/null
+++ b/include/hw/misc/rp2040_watchdog.h
@@ -0,0 +1,36 @@
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
+    bool preserve_reason_on_reset;
+    uint32_t scratch[8];
+    uint32_t tick;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 23cc9f2503..18120f17bf 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -269,7 +269,8 @@ qtests_arm = \
      'rp2040-resets-test',
      'rp2040-rosc-test',
     'rp2040-tbman-test',
-    'rp2040-vreg-test'] : []) + \
+    'rp2040-vreg-test',
+    'rp2040-watchdog-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-watchdog-test.c b/tests/qtest/rp2040-watchdog-test.c
new file mode 100644
index 0000000000..ef54631897
--- /dev/null
+++ b/tests/qtest/rp2040-watchdog-test.c
@@ -0,0 +1,170 @@
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
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_REASON), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_reason_survives_watchdog_reset(void)
+{
+    QTestState *qts = qtest_init("-machine raspi-pico "
+                                 "-watchdog-action reset");
+
+    qtest_writel(qts, WATCHDOG_BASE + WATCHDOG_CTRL, CTRL_TRIGGER);
+    qtest_qmp_eventwait(qts, "WATCHDOG");
+    qtest_qmp_eventwait(qts, "RESET");
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_REASON), ==,
+                    REASON_FORCE);
+
+    qtest_system_reset(qts);
+    g_assert_cmphex(qtest_readl(qts, WATCHDOG_BASE + WATCHDOG_REASON), ==, 0);
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
+    qtest_add_func("/rp2040-watchdog/reason-survives-watchdog-reset",
+                   test_reason_survives_watchdog_reset);
+
+    return g_test_run();
+}
-- 
2.55.0


