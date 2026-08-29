Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDB2C61DDE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Sih-0008Ah-R8; Sat, 29 Aug 2026 19:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Sic-00089w-46; Sat, 29 Aug 2026 19:44:14 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiY-0006FR-VB; Sat, 29 Aug 2026 19:44:13 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzf0RdjzBqY4;
 Sun, 30 Aug 2026 01:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047022;
 bh=Hi1sHMtAcIkGqN+6fEfecIGe3R/X86Z+Of2u3jYHCAQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PYHiXqhDNCpPmE4ZLBm4Dp5zNnAz03+LEu4DXT0LPoELXuVx3u7KWOG71t+6bLxTE
 g2SiiYRGKF9Y2r2+gWoHEAU0O13Zcs510OrcBzMASjzwISPUqfNTvuFoS+GOmY8IVy
 SRw38r0Z8YhtJg4wGB8OhPD+xAxfGT1GWnVjwsHmYvMU3/tr12QQDXp1kT+ihvOt7I
 1QfXfDMcktsTfNdUmkQMbq1hnOI4rilZQbYLo/XJTCEx7YwP6U0lA/Xl75k3rwjzrk
 BRrQ1Zpi5wWquUHiSITAGo+mq/as8J+d2EEJ7XjpJZdhwxHizEzMQuAUIAWrB5fW/i
 LZtIGoxPXOaeg==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzd5NRdz7tLT;
 Sun, 30 Aug 2026 01:43:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 10/30] hw/misc: add RP2040 reset and power state
 controllers
Date: Sun, 30 Aug 2026 01:42:44 +0200
Message-ID: <20260829234308.33725-11-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
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

From: gilles grimaud <gilles.grimaud@univ-lille.fr>

Model the RP2040 RESETS and PSM register blocks, including atomic aliases, watchdog selection and completion state. Expose the PSM update callback used by the later multicore integration and add focused qtests for reset-controller behavior.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                   |   2 +
 hw/arm/rp2040.c                  |  14 ++-
 hw/misc/Kconfig                  |   6 +
 hw/misc/meson.build              |   2 +
 hw/misc/rp2040_psm.c             | 198 +++++++++++++++++++++++++++++++
 hw/misc/rp2040_resets.c          | 152 ++++++++++++++++++++++++
 include/hw/arm/rp2040.h          |   4 +
 include/hw/misc/rp2040_psm.h     |  40 +++++++
 include/hw/misc/rp2040_resets.h  |  28 +++++
 tests/qtest/meson.build          |   1 +
 tests/qtest/rp2040-resets-test.c |  84 +++++++++++++
 11 files changed, 529 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/rp2040_psm.c
 create mode 100644 hw/misc/rp2040_resets.c
 create mode 100644 include/hw/misc/rp2040_psm.h
 create mode 100644 include/hw/misc/rp2040_resets.h
 create mode 100644 tests/qtest/rp2040-resets-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3d1b424fe5..2ea9ec31df 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -381,6 +381,8 @@ config RP2040
     select RP2040_CLOCKS
     select RP2040_NYI
     select RP2040_PLL
+    select RP2040_PSM
+    select RP2040_RESETS
     select RP2040_ROSC
     select RP2040_SYSCFG
     select RP2040_SYSINFO
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index b80155ba0b..28b4079ff9 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -48,8 +48,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.resets",   0x4000c000, 0x4000 },
-    { "rp2040.psm",      0x40010000, 0x4000 },
     { "rp2040.iobank0",  0x40014000, 0x4000 },
     { "rp2040.ioqspi",   0x40018000, 0x4000 },
     { "rp2040.padsbank0", 0x4001c000, 0x4000 },
@@ -182,6 +180,8 @@ static void rp2040_soc_init(Object *obj)
     qdev_prop_set_uint32(DEVICE(&s->pll_usb), "base", RP2040_PLL_USB_BASE);
     qdev_prop_set_uint32(DEVICE(&s->pll_usb), "fallback-hz", 48000000);
 
+    object_initialize_child(obj, "psm", &s->psm, TYPE_RP2040_PSM);
+    object_initialize_child(obj, "resets", &s->resets, TYPE_RP2040_RESETS);
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
     object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
@@ -327,6 +327,16 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     clock_set_source(s->sysclk, qdev_get_clock_out(DEVICE(&s->clocks),
                                                    "clk-sys"));
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->psm), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->psm), 0, RP2040_PSM_BASE);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->resets), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->resets), 0, RP2040_RESETS_BASE);
+
     qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(s->board_memory), &err);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8ed229cf27..9c15b56f74 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -110,6 +110,12 @@ config RP2040_NYI
 config RP2040_PLL
     bool
 
+config RP2040_PSM
+    bool
+
+config RP2040_RESETS
+    bool
+
 config RP2040_ROSC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index af48fa6dba..2589bec8a6 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -101,6 +101,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
 system_ss.add(when: 'CONFIG_RP2040_CLOCKS', if_true: files('rp2040_clocks.c'))
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
 system_ss.add(when: 'CONFIG_RP2040_PLL', if_true: files('rp2040_pll.c'))
+system_ss.add(when: 'CONFIG_RP2040_PSM', if_true: files('rp2040_psm.c'))
+system_ss.add(when: 'CONFIG_RP2040_RESETS', if_true: files('rp2040_resets.c'))
 system_ss.add(when: 'CONFIG_RP2040_ROSC', if_true: files('rp2040_rosc.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
diff --git a/hw/misc/rp2040_psm.c b/hw/misc/rp2040_psm.c
new file mode 100644
index 0000000000..90b0264d81
--- /dev/null
+++ b/hw/misc/rp2040_psm.c
@@ -0,0 +1,198 @@
+/*
+ * RP2040 power-on state machine emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_psm.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define PSM_FRCE_ON   0x00
+#define PSM_FRCE_OFF  0x04
+#define PSM_WDSEL     0x08
+#define PSM_DONE      0x0c
+
+#define ATOMIC_ALIAS_MASK 0x3000
+#define ATOMIC_XOR        0x1000
+#define ATOMIC_SET        0x2000
+#define ATOMIC_CLR        0x3000
+
+static uint32_t rp2040_psm_apply_alias(uint32_t old, uint32_t value,
+                                       hwaddr alias)
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
+static void rp2040_psm_update(RP2040PsmState *s)
+{
+    if (s->update) {
+        s->update(s->update_opaque);
+    }
+}
+
+void rp2040_psm_set_update_callback(RP2040PsmState *s,
+                                    RP2040PsmUpdateFn update,
+                                    void *opaque)
+{
+    s->update = update;
+    s->update_opaque = opaque;
+}
+
+uint32_t rp2040_psm_get_frce_off(RP2040PsmState *s)
+{
+    return s->frce_off;
+}
+
+static uint32_t rp2040_psm_done(RP2040PsmState *s)
+{
+    return RP2040_PSM_VALID_MASK & ~s->frce_off;
+}
+
+static uint64_t rp2040_psm_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040PsmState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case PSM_FRCE_ON:
+        value = s->frce_on;
+        break;
+    case PSM_FRCE_OFF:
+        value = s->frce_off;
+        break;
+    case PSM_WDSEL:
+        value = s->wdsel;
+        break;
+    case PSM_DONE:
+        value = rp2040_psm_done(s);
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("psm", size,
+                                      RP2040_PSM_BASE + addr, offset, value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_psm_write(void *opaque, hwaddr addr,
+                             uint64_t value64, unsigned size)
+{
+    RP2040PsmState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+    uint32_t old_frce_off = s->frce_off;
+
+    switch (offset) {
+    case PSM_FRCE_ON:
+        s->frce_on = rp2040_psm_apply_alias(s->frce_on, value, alias) &
+                     RP2040_PSM_VALID_MASK;
+        break;
+    case PSM_FRCE_OFF:
+        s->frce_off = rp2040_psm_apply_alias(s->frce_off, value, alias) &
+                      RP2040_PSM_VALID_MASK;
+        if (s->frce_off != old_frce_off) {
+            rp2040_psm_update(s);
+        }
+        break;
+    case PSM_WDSEL:
+        s->wdsel = rp2040_psm_apply_alias(s->wdsel, value, alias) &
+                   RP2040_PSM_VALID_MASK;
+        break;
+    case PSM_DONE:
+        break;
+    default:
+        rp2040_log_unimplemented_write("psm", size,
+                                       RP2040_PSM_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_psm_ops = {
+    .read = rp2040_psm_read,
+    .write = rp2040_psm_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_psm_reset(DeviceState *dev)
+{
+    RP2040PsmState *s = RP2040_PSM(dev);
+
+    s->frce_on = 0;
+    s->frce_off = 0;
+    s->wdsel = 0;
+    rp2040_psm_update(s);
+}
+
+static int rp2040_psm_post_load(void *opaque, int version_id)
+{
+    RP2040PsmState *s = opaque;
+
+    rp2040_psm_update(s);
+    return 0;
+}
+
+static void rp2040_psm_init(Object *obj)
+{
+    RP2040PsmState *s = RP2040_PSM(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_psm_ops, s,
+                          "rp2040.psm", RP2040_PSM_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_psm_vmstate = {
+    .name = TYPE_RP2040_PSM,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = rp2040_psm_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(frce_on, RP2040PsmState),
+        VMSTATE_UINT32(frce_off, RP2040PsmState),
+        VMSTATE_UINT32(wdsel, RP2040PsmState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_psm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_psm_reset);
+    dc->vmsd = &rp2040_psm_vmstate;
+}
+
+static const TypeInfo rp2040_psm_info = {
+    .name          = TYPE_RP2040_PSM,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040PsmState),
+    .instance_init = rp2040_psm_init,
+    .class_init    = rp2040_psm_class_init,
+};
+
+static void rp2040_psm_register_types(void)
+{
+    type_register_static(&rp2040_psm_info);
+}
+type_init(rp2040_psm_register_types)
diff --git a/hw/misc/rp2040_resets.c b/hw/misc/rp2040_resets.c
new file mode 100644
index 0000000000..227ecf64fd
--- /dev/null
+++ b/hw/misc/rp2040_resets.c
@@ -0,0 +1,152 @@
+/*
+ * RP2040 reset controller emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_resets.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define RESETS_RESET       0x00
+#define RESETS_WDSEL       0x04
+#define RESETS_RESET_DONE  0x08
+
+#define RESETS_VALID_MASK  0x01ffffff
+
+#define ATOMIC_ALIAS_MASK  0x3000
+#define ATOMIC_XOR         0x1000
+#define ATOMIC_SET         0x2000
+#define ATOMIC_CLR         0x3000
+
+static uint32_t rp2040_resets_apply_alias(uint32_t old, uint32_t value,
+                                          hwaddr alias)
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
+static uint64_t rp2040_resets_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040ResetsState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case RESETS_RESET:
+        value = s->reset;
+        break;
+    case RESETS_WDSEL:
+        value = s->wdsel;
+        break;
+    case RESETS_RESET_DONE:
+        value = (~s->reset) & RESETS_VALID_MASK;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("resets", size,
+                                      RP2040_RESETS_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_resets_write(void *opaque, hwaddr addr,
+                                uint64_t value64, unsigned size)
+{
+    RP2040ResetsState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case RESETS_RESET:
+        s->reset = rp2040_resets_apply_alias(s->reset, value, alias) &
+                   RESETS_VALID_MASK;
+        break;
+    case RESETS_WDSEL:
+        s->wdsel = rp2040_resets_apply_alias(s->wdsel, value, alias) &
+                   RESETS_VALID_MASK;
+        break;
+    case RESETS_RESET_DONE:
+        break;
+    default:
+        rp2040_log_unimplemented_write("resets", size,
+                                       RP2040_RESETS_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_resets_ops = {
+    .read = rp2040_resets_read,
+    .write = rp2040_resets_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_resets_reset(DeviceState *dev)
+{
+    RP2040ResetsState *s = RP2040_RESETS(dev);
+
+    s->reset = RESETS_VALID_MASK;
+    s->wdsel = 0;
+}
+
+static void rp2040_resets_init(Object *obj)
+{
+    RP2040ResetsState *s = RP2040_RESETS(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_resets_ops, s,
+                          "rp2040.resets", RP2040_RESETS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_resets_vmstate = {
+    .name = TYPE_RP2040_RESETS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(reset, RP2040ResetsState),
+        VMSTATE_UINT32(wdsel, RP2040ResetsState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_resets_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_resets_reset);
+    dc->vmsd = &rp2040_resets_vmstate;
+}
+
+static const TypeInfo rp2040_resets_info = {
+    .name          = TYPE_RP2040_RESETS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040ResetsState),
+    .instance_init = rp2040_resets_init,
+    .class_init    = rp2040_resets_class_init,
+};
+
+static void rp2040_resets_register_types(void)
+{
+    type_register_static(&rp2040_resets_info);
+}
+type_init(rp2040_resets_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index abdd2f006c..431648af63 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -15,6 +15,8 @@
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_clocks.h"
 #include "hw/misc/rp2040_pll.h"
+#include "hw/misc/rp2040_psm.h"
+#include "hw/misc/rp2040_resets.h"
 #include "hw/misc/rp2040_rosc.h"
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_sysinfo.h"
@@ -45,6 +47,8 @@ struct RP2040State {
     RP2040ClocksState clocks;
     RP2040PllState pll_sys;
     RP2040PllState pll_usb;
+    RP2040PsmState psm;
+    RP2040ResetsState resets;
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
     RP2040RoscState rosc;
diff --git a/include/hw/misc/rp2040_psm.h b/include/hw/misc/rp2040_psm.h
new file mode 100644
index 0000000000..8b68fb2ed8
--- /dev/null
+++ b/include/hw/misc/rp2040_psm.h
@@ -0,0 +1,40 @@
+/*
+ * RP2040 power-on state machine emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_PSM_H
+#define HW_MISC_RP2040_PSM_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_PSM "rp2040-psm"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040PsmState, RP2040_PSM)
+
+#define RP2040_PSM_BASE       0x40010000
+#define RP2040_PSM_SIZE       0x4000
+#define RP2040_PSM_VALID_MASK 0x0001ffff
+#define RP2040_PSM_PROC1      (1u << 16)
+
+typedef void (*RP2040PsmUpdateFn)(void *opaque);
+
+struct RP2040PsmState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    uint32_t frce_on;
+    uint32_t frce_off;
+    uint32_t wdsel;
+
+    RP2040PsmUpdateFn update;
+    void *update_opaque;
+};
+
+void rp2040_psm_set_update_callback(RP2040PsmState *s,
+                                    RP2040PsmUpdateFn update,
+                                    void *opaque);
+uint32_t rp2040_psm_get_frce_off(RP2040PsmState *s);
+
+#endif
diff --git a/include/hw/misc/rp2040_resets.h b/include/hw/misc/rp2040_resets.h
new file mode 100644
index 0000000000..ba87d8d7c1
--- /dev/null
+++ b/include/hw/misc/rp2040_resets.h
@@ -0,0 +1,28 @@
+/*
+ * RP2040 reset controller emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_RESETS_H
+#define HW_MISC_RP2040_RESETS_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_RESETS "rp2040-resets"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040ResetsState, RP2040_RESETS)
+
+#define RP2040_RESETS_BASE 0x4000c000
+#define RP2040_RESETS_SIZE 0x4000
+
+struct RP2040ResetsState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint32_t reset;
+    uint32_t wdsel;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 416d90ae94..03bd78b551 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -257,6 +257,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
                                                        'rp2040-clocks-test',
+                                                       'rp2040-resets-test',
                                                        'rp2040-rosc-test',
                                                        'rp2040-tbman-test',
                                                        'rp2040-vreg-test'] : []) + \
diff --git a/tests/qtest/rp2040-resets-test.c b/tests/qtest/rp2040-resets-test.c
new file mode 100644
index 0000000000..f874a25571
--- /dev/null
+++ b/tests/qtest/rp2040-resets-test.c
@@ -0,0 +1,84 @@
+/*
+ * QTest testcase for the RP2040 reset controller block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define RESETS_BASE        0x4000c000
+#define RESETS_RESET       0x00
+#define RESETS_WDSEL       0x04
+#define RESETS_RESET_DONE  0x08
+
+#define RESETS_VALID_MASK  0x01ffffff
+#define RESET_ADC          (1u << 0)
+#define RESET_PWM          (1u << 14)
+
+#define ATOMIC_SET         0x2000
+#define ATOMIC_CLR         0x3000
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_resets_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET), ==,
+                    RESETS_VALID_MASK);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET_DONE), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_WDSEL), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_resets_set_clear_done(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t mask = RESET_PWM | RESET_ADC;
+
+    qtest_writel(qts, RESETS_BASE + RESETS_RESET + ATOMIC_CLR, mask);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET) & mask,
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET_DONE) & mask,
+                    ==, mask);
+
+    qtest_writel(qts, RESETS_BASE + RESETS_RESET + ATOMIC_SET, RESET_PWM);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET) & RESET_PWM,
+                    ==, RESET_PWM);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET_DONE) &
+                    RESET_PWM, ==, 0);
+
+    qtest_writel(qts, RESETS_BASE + RESETS_RESET + ATOMIC_CLR, RESET_PWM);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_RESET_DONE) & mask,
+                    ==, mask);
+
+    qtest_quit(qts);
+}
+
+static void test_resets_wdsel(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, RESETS_BASE + RESETS_WDSEL, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, RESETS_BASE + RESETS_WDSEL), ==,
+                    RESETS_VALID_MASK);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-resets/reset-values", test_resets_reset_values);
+    qtest_add_func("/rp2040-resets/set-clear-done",
+                   test_resets_set_clear_done);
+    qtest_add_func("/rp2040-resets/wdsel", test_resets_wdsel);
+
+    return g_test_run();
+}
-- 
2.55.0


