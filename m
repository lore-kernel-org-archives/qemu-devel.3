Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABBCC61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Sij-0008Az-BD; Sat, 29 Aug 2026 19:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Sid-0008AE-9j; Sat, 29 Aug 2026 19:44:15 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiZ-0006FU-BV; Sat, 29 Aug 2026 19:44:15 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXWzd1qKzz8388;
 Sun, 30 Aug 2026 01:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047021;
 bh=GDGPmZqmkdR7qqsy3AZxl8puIuhDK59ALlXB9fHMTjY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dKqHo+TLv/oil7dGO0ORgfPLfVyINCyBB78+lWmMm4KC9Jeq96X1uMu4NqIoqTES9
 OZcV3h2NyaKZ0WKmRlN+GRWnH1EfqE+4ZHSutfkN/r5GwXxjhmY/qHreURHPjKzuLh
 4vLZ9z+RlwelVzK0fjAPf46i0UhEWpyCWyVvwb5n/Y6k3UvDtJdkf+FZQKCfW4Tyub
 DiKnSWwdHXoICfxj622pviPWt1qUJOB85iZpjM1TbC4o53jIb+tqOQW1dGg/pE9Ver
 Kwq+iR0a6zZpRF8Fz7M+r21Gihsi/HyDhGe1MsLCEW+IhgubTpVkBlCnrHflk651f+
 Ub9RzdumTddXA==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzc6YFYz7tLT;
 Sun, 30 Aug 2026 01:43:40 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 08/30] hw/misc: add RP2040 crystal and ring oscillators
Date: Sun, 30 Aug 2026 01:42:42 +0200
Message-ID: <20260829234308.33725-9-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 XOSC and ROSC register blocks and expose their clock outputs. Use virtual time for the ROSC COUNT register and provide either QEMU guest entropy or a machine-selectable deterministic seed for RANDOMBIT. Add qtests for the ROSC register behavior and deterministic stream.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                 |   2 +
 hw/arm/raspi_pico.c            |  56 +++++
 hw/arm/rp2040.c                |  14 +-
 hw/misc/Kconfig                |   6 +
 hw/misc/meson.build            |   2 +
 hw/misc/rp2040_rosc.c          | 430 +++++++++++++++++++++++++++++++++
 hw/misc/rp2040_xosc.c          | 237 ++++++++++++++++++
 include/hw/arm/rp2040.h        |   4 +
 include/hw/misc/rp2040_rosc.h  |  42 ++++
 include/hw/misc/rp2040_xosc.h  |  33 +++
 tests/qtest/meson.build        |   1 +
 tests/qtest/rp2040-rosc-test.c | 146 +++++++++++
 12 files changed, 971 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/rp2040_rosc.c
 create mode 100644 hw/misc/rp2040_xosc.c
 create mode 100644 include/hw/misc/rp2040_rosc.h
 create mode 100644 include/hw/misc/rp2040_xosc.h
 create mode 100644 tests/qtest/rp2040-rosc-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 89c479ab6d..b55a75fd5a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -379,10 +379,12 @@ config RP2040
     select ARM_V7M
     select PL011
     select RP2040_NYI
+    select RP2040_ROSC
     select RP2040_SYSCFG
     select RP2040_SYSINFO
     select RP2040_TBMAN
     select RP2040_VREG
+    select RP2040_XOSC
     select UNIMP
 
 config STM32F100_SOC
diff --git a/hw/arm/raspi_pico.c b/hw/arm/raspi_pico.c
index 2bb7d4e511..2a65176dc6 100644
--- a/hw/arm/raspi_pico.c
+++ b/hw/arm/raspi_pico.c
@@ -14,6 +14,7 @@
 #include "hw/arm/rp2040.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
+#include "qemu/cutils.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "qom/object.h"
@@ -28,8 +29,43 @@ struct RaspiPicoMachineState {
 
     RP2040State soc;
     MemoryRegion flash;
+    char *rosc_random_seed;
+    uint64_t rosc_random_seed_value;
+    bool rosc_random_seed_set;
 };
 
+static char *raspi_pico_get_rosc_random_seed(Object *obj, Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    return g_strdup(s->rosc_random_seed ?: "");
+}
+
+static void raspi_pico_set_rosc_random_seed(Object *obj, const char *value,
+                                            Error **errp)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+    uint64_t seed;
+
+    if (!value || !*value) {
+        g_free(s->rosc_random_seed);
+        s->rosc_random_seed = NULL;
+        s->rosc_random_seed_value = 0;
+        s->rosc_random_seed_set = false;
+        return;
+    }
+
+    if (qemu_strtou64(value, NULL, 0, &seed) < 0) {
+        error_setg(errp, "invalid ROSC random seed '%s'", value);
+        return;
+    }
+
+    g_free(s->rosc_random_seed);
+    s->rosc_random_seed = g_strdup(value);
+    s->rosc_random_seed_value = seed;
+    s->rosc_random_seed_set = true;
+}
+
 static void raspi_pico_init(MachineState *machine)
 {
     RaspiPicoMachineState *s = RASPI_PICO_MACHINE(machine);
@@ -38,6 +74,10 @@ static void raspi_pico_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RP2040);
     qdev_prop_set_chr(DEVICE(&s->soc), "serial0", serial_hd(0));
     qdev_prop_set_chr(DEVICE(&s->soc), "serial1", serial_hd(1));
+    qdev_prop_set_uint64(DEVICE(&s->soc.rosc), "random-seed",
+                         s->rosc_random_seed_value);
+    qdev_prop_set_bit(DEVICE(&s->soc.rosc), "random-seed-set",
+                      s->rosc_random_seed_set);
     if (machine->firmware) {
         qdev_prop_set_string(DEVICE(&s->soc), "bootrom-file",
                              machine->firmware);
@@ -55,6 +95,13 @@ static void raspi_pico_init(MachineState *machine)
                        RP2040_XIP_BASE, PICO_FLASH_SIZE);
 }
 
+static void raspi_pico_machine_finalize(Object *obj)
+{
+    RaspiPicoMachineState *s = RASPI_PICO_MACHINE(obj);
+
+    g_free(s->rosc_random_seed);
+}
+
 static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -68,6 +115,14 @@ static void raspi_pico_machine_class_init(ObjectClass *oc, const void *data)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
+
+    object_class_property_add_str(oc, "rosc-random-seed",
+                                  raspi_pico_get_rosc_random_seed,
+                                  raspi_pico_set_rosc_random_seed);
+    object_class_property_set_description(oc, "rosc-random-seed",
+                                          "Use a deterministic seed for the "
+                                          "ROSC RANDOMBIT stream; if unset, "
+                                          "QEMU guest entropy is used");
 }
 
 static const TypeInfo raspi_pico_machine_info = {
@@ -75,6 +130,7 @@ static const TypeInfo raspi_pico_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(RaspiPicoMachineState),
     .class_init = raspi_pico_machine_class_init,
+    .instance_finalize = raspi_pico_machine_finalize,
     .interfaces = arm_machine_interfaces,
 };
 
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index f2a6613aa3..889decded0 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -57,7 +57,6 @@ static const struct {
     { "rp2040.ioqspi",   0x40018000, 0x4000 },
     { "rp2040.padsbank0", 0x4001c000, 0x4000 },
     { "rp2040.padsqspi", 0x40020000, 0x4000 },
-    { "rp2040.xosc",     0x40024000, 0x4000 },
     { "rp2040.pll_sys",  0x40028000, 0x4000 },
     { "rp2040.pll_usb",  0x4002c000, 0x4000 },
     { "rp2040.busctrl",  0x40030000, 0x4000 },
@@ -72,7 +71,6 @@ static const struct {
     { "rp2040.timer",    0x40054000, 0x4000 },
     { "rp2040.watchdog", 0x40058000, 0x4000 },
     { "rp2040.rtc",      0x4005c000, 0x4000 },
-    { "rp2040.rosc",     0x40060000, 0x4000 },
     { "rp2040.dma",      0x50000000, 0x1000 },
     { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
     { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
@@ -177,8 +175,10 @@ static void rp2040_soc_init(Object *obj)
 
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
+    object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
     object_initialize_child(obj, "tbman", &s->tbman, TYPE_RP2040_TBMAN);
     object_initialize_child(obj, "vreg", &s->vreg, TYPE_RP2040_VREG);
+    object_initialize_child(obj, "xosc", &s->xosc, TYPE_RP2040_XOSC);
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
     s->sysclk = clock_new(obj, "sysclk");
@@ -325,6 +325,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
     rp2040_syscfg_update(s);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rosc), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rosc), 0, RP2040_ROSC_BASE);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->tbman), errp)) {
         return;
     }
@@ -335,6 +340,11 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->vreg), 0, RP2040_VREG_BASE);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->xosc), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xosc), 0, RP2040_XOSC_BASE);
+
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
         qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 597559186f..8f0860139f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -104,6 +104,9 @@ config FSL_IMX8MP_CCM
 config RP2040_NYI
     bool
 
+config RP2040_ROSC
+    bool
+
 config RP2040_SYSCFG
     bool
 
@@ -116,6 +119,9 @@ config RP2040_TBMAN
 config RP2040_VREG
     bool
 
+config RP2040_XOSC
+    bool
+
 config STM32_RCC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9191b16360..7ad307beee 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -99,10 +99,12 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_powermgt.c',
 ))
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
+system_ss.add(when: 'CONFIG_RP2040_ROSC', if_true: files('rp2040_rosc.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
 system_ss.add(when: 'CONFIG_RP2040_TBMAN', if_true: files('rp2040_tbman.c'))
 system_ss.add(when: 'CONFIG_RP2040_VREG', if_true: files('rp2040_vreg.c'))
+system_ss.add(when: 'CONFIG_RP2040_XOSC', if_true: files('rp2040_xosc.c'))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQ_DDRC', if_true: files('xlnx-zynq-ddrc.c'))
diff --git a/hw/misc/rp2040_rosc.c b/hw/misc/rp2040_rosc.c
new file mode 100644
index 0000000000..dcb340ec57
--- /dev/null
+++ b/hw/misc/rp2040_rosc.c
@@ -0,0 +1,430 @@
+/*
+ * RP2040 ring oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_rosc.h"
+#include "migration/vmstate.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+#define ROSC_NOMINAL_HZ        6500000
+
+#define ROSC_CTRL              0x00
+#define ROSC_FREQA             0x04
+#define ROSC_FREQB             0x08
+#define ROSC_DORMANT           0x0c
+#define ROSC_DIV               0x10
+#define ROSC_PHASE             0x14
+#define ROSC_STATUS            0x18
+#define ROSC_RANDOMBIT         0x1c
+#define ROSC_COUNT             0x20
+
+#define ROSC_ENABLE_DISABLE    0xd1e
+#define ROSC_ENABLE_ENABLE     0xfab
+#define ROSC_FREQ_RANGE_LOW    0xfa4
+#define ROSC_FREQ_RANGE_MEDIUM 0xfa5
+#define ROSC_FREQ_RANGE_HIGH   0xfa7
+#define ROSC_FREQ_RANGE_TOOHIGH 0xfa6
+#define ROSC_DORMANT_VALUE     0x636f6d61
+#define ROSC_WAKE_VALUE        0x77616b65
+#define ROSC_FREQ_PASSWD       0x9696
+#define ROSC_DIV_PASS          0xaa0
+#define ROSC_PHASE_PASSWD      0xaa
+
+#define ROSC_STATUS_STABLE     BIT(31)
+#define ROSC_STATUS_BADWRITE   BIT(24)
+#define ROSC_STATUS_DIV_RUNNING BIT(16)
+#define ROSC_STATUS_ENABLED    BIT(12)
+
+#define ATOMIC_ALIAS_MASK      0x3000
+#define ATOMIC_XOR             0x1000
+#define ATOMIC_SET             0x2000
+#define ATOMIC_CLR             0x3000
+
+static uint32_t rp2040_rosc_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
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
+static bool rp2040_rosc_valid_range(uint32_t range)
+{
+    return range == ROSC_FREQ_RANGE_LOW || range == ROSC_FREQ_RANGE_MEDIUM ||
+           range == ROSC_FREQ_RANGE_HIGH || range == ROSC_FREQ_RANGE_TOOHIGH;
+}
+
+static bool rp2040_rosc_enabled(RP2040RoscState *s)
+{
+    return extract32(s->ctrl, 12, 12) != ROSC_ENABLE_DISABLE;
+}
+
+static bool rp2040_rosc_running(RP2040RoscState *s)
+{
+    return rp2040_rosc_enabled(s) && s->dormant == ROSC_WAKE_VALUE;
+}
+
+static uint32_t rp2040_rosc_divisor(RP2040RoscState *s)
+{
+    uint32_t encoded = s->div & 0xfff;
+    uint32_t div;
+
+    if (encoded < ROSC_DIV_PASS) {
+        return 31;
+    }
+
+    div = encoded - ROSC_DIV_PASS;
+    if (div == 0) {
+        return 32;
+    }
+    if (div > 31) {
+        return 31;
+    }
+    return div;
+}
+
+static uint32_t rp2040_rosc_hz(RP2040RoscState *s)
+{
+    if (!rp2040_rosc_running(s)) {
+        return 0;
+    }
+
+    return ROSC_NOMINAL_HZ / rp2040_rosc_divisor(s);
+}
+
+static void rp2040_rosc_update_clock(RP2040RoscState *s)
+{
+    clock_update_hz(s->clk, rp2040_rosc_hz(s));
+}
+
+static uint32_t rp2040_rosc_count_read(RP2040RoscState *s)
+{
+    uint64_t elapsed_ns;
+    uint64_t elapsed_ticks;
+
+    if (!s->count || !rp2040_rosc_running(s)) {
+        return s->count;
+    }
+
+    elapsed_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - s->count_start_ns;
+    elapsed_ticks = elapsed_ns * ROSC_NOMINAL_HZ / NANOSECONDS_PER_SECOND;
+    if (elapsed_ticks >= s->count) {
+        s->count = 0;
+    } else {
+        s->count -= elapsed_ticks;
+        s->count_start_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+
+    return s->count;
+}
+
+static uint32_t rp2040_rosc_status(RP2040RoscState *s)
+{
+    uint32_t value = 0;
+
+    if (rp2040_rosc_enabled(s)) {
+        value |= ROSC_STATUS_ENABLED;
+        if (s->dormant == ROSC_WAKE_VALUE) {
+            value |= ROSC_STATUS_STABLE | ROSC_STATUS_DIV_RUNNING;
+        }
+    }
+    if (s->badwrite) {
+        value |= ROSC_STATUS_BADWRITE;
+    }
+
+    return value;
+}
+
+static uint32_t rp2040_rosc_random_bit(RP2040RoscState *s)
+{
+    uint64_t x;
+    uint32_t bit;
+
+    if (!rp2040_rosc_running(s)) {
+        return 0;
+    }
+
+    if (!s->random_seed_set) {
+        if (!s->random_pool_bits) {
+            qemu_guest_getrandom_nofail(&s->random_pool,
+                                        sizeof(s->random_pool));
+            s->random_pool_bits = 64;
+        }
+
+        bit = s->random_pool & 1;
+        s->random_pool >>= 1;
+        s->random_pool_bits--;
+        return bit;
+    }
+
+    x = s->random_prng_state;
+    x ^= x >> 12;
+    x ^= x << 25;
+    x ^= x >> 27;
+    s->random_prng_state = x;
+    return (x * 0x2545f4914f6cdd1dull) >> 63;
+}
+
+static uint64_t rp2040_rosc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040RoscState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case ROSC_CTRL:
+        value = s->ctrl;
+        break;
+    case ROSC_FREQA:
+        value = s->freqa;
+        break;
+    case ROSC_FREQB:
+        value = s->freqb;
+        break;
+    case ROSC_DORMANT:
+        value = s->dormant;
+        break;
+    case ROSC_DIV:
+        value = s->div;
+        break;
+    case ROSC_PHASE:
+        value = s->phase;
+        break;
+    case ROSC_STATUS:
+        value = rp2040_rosc_status(s);
+        break;
+    case ROSC_RANDOMBIT:
+        value = rp2040_rosc_random_bit(s);
+        break;
+    case ROSC_COUNT:
+        value = rp2040_rosc_count_read(s);
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("rosc", size,
+                                      RP2040_ROSC_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_rosc_write_ctrl(RP2040RoscState *s, uint32_t value)
+{
+    uint32_t enable = extract32(value, 12, 12);
+    uint32_t range = extract32(value, 0, 12);
+
+    if (enable != ROSC_ENABLE_DISABLE && enable != ROSC_ENABLE_ENABLE) {
+        s->badwrite = true;
+        value = deposit32(value, 12, 12, ROSC_ENABLE_ENABLE);
+    }
+    if (!rp2040_rosc_valid_range(range)) {
+        s->badwrite = true;
+        value = deposit32(value, 0, 12, ROSC_FREQ_RANGE_LOW);
+    }
+
+    s->ctrl = value & 0x00ffffff;
+    rp2040_rosc_update_clock(s);
+}
+
+static void rp2040_rosc_write_freq(RP2040RoscState *s, uint32_t *reg,
+                                   uint32_t value)
+{
+    if (extract32(value, 16, 16) != ROSC_FREQ_PASSWD) {
+        s->badwrite = true;
+        *reg = 0;
+        return;
+    }
+
+    *reg = value & 0x96967777;
+}
+
+static void rp2040_rosc_write_div(RP2040RoscState *s, uint32_t value)
+{
+    if ((value & 0xfff) < ROSC_DIV_PASS) {
+        s->badwrite = true;
+        value = ROSC_DIV_PASS + 31;
+    }
+
+    s->div = value & 0xfff;
+    rp2040_rosc_update_clock(s);
+}
+
+static void rp2040_rosc_write_phase(RP2040RoscState *s, uint32_t value)
+{
+    if (extract32(value, 4, 8) != ROSC_PHASE_PASSWD) {
+        s->badwrite = true;
+        value = 0;
+    }
+
+    s->phase = value & 0x00000fff;
+}
+
+static void rp2040_rosc_write(void *opaque, hwaddr addr,
+                              uint64_t value64, unsigned size)
+{
+    RP2040RoscState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case ROSC_CTRL:
+        rp2040_rosc_write_ctrl(s, rp2040_rosc_apply_alias(s->ctrl, value,
+                                                          alias));
+        break;
+    case ROSC_FREQA:
+        rp2040_rosc_write_freq(s, &s->freqa,
+                               rp2040_rosc_apply_alias(s->freqa, value,
+                                                       alias));
+        break;
+    case ROSC_FREQB:
+        rp2040_rosc_write_freq(s, &s->freqb,
+                               rp2040_rosc_apply_alias(s->freqb, value,
+                                                       alias));
+        break;
+    case ROSC_DORMANT:
+        s->dormant = value == ROSC_DORMANT_VALUE ? value : ROSC_WAKE_VALUE;
+        if (value != ROSC_DORMANT_VALUE && value != ROSC_WAKE_VALUE) {
+            s->badwrite = true;
+        }
+        rp2040_rosc_update_clock(s);
+        break;
+    case ROSC_DIV:
+        rp2040_rosc_write_div(s, rp2040_rosc_apply_alias(s->div, value,
+                                                         alias));
+        break;
+    case ROSC_PHASE:
+        rp2040_rosc_write_phase(s, rp2040_rosc_apply_alias(s->phase, value,
+                                                           alias));
+        break;
+    case ROSC_STATUS:
+        if (value & ROSC_STATUS_BADWRITE) {
+            s->badwrite = false;
+        }
+        break;
+    case ROSC_COUNT:
+        s->count = value & 0xff;
+        s->count_start_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        break;
+    default:
+        rp2040_log_unimplemented_write("rosc", size,
+                                       RP2040_ROSC_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_rosc_ops = {
+    .read = rp2040_rosc_read,
+    .write = rp2040_rosc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_rosc_reset(DeviceState *dev)
+{
+    RP2040RoscState *s = RP2040_ROSC(dev);
+
+    s->ctrl = (ROSC_ENABLE_ENABLE << 12) | ROSC_FREQ_RANGE_LOW;
+    s->freqa = 0;
+    s->freqb = 0;
+    s->dormant = ROSC_WAKE_VALUE;
+    s->div = ROSC_DIV_PASS + 16;
+    s->phase = 0x00000aa8;
+    s->count = 0;
+    s->count_start_ns = 0;
+    s->random_pool = 0;
+    s->random_pool_bits = 0;
+    s->random_prng_state = s->random_seed;
+    if (!s->random_prng_state) {
+        s->random_prng_state = 0x9e3779b97f4a7c15ull;
+    }
+    s->badwrite = false;
+
+    rp2040_rosc_update_clock(s);
+}
+
+static void rp2040_rosc_init(Object *obj)
+{
+    RP2040RoscState *s = RP2040_ROSC(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk = qdev_init_clock_out(dev, "clk");
+    memory_region_init_io(&s->iomem, obj, &rp2040_rosc_ops, s,
+                          "rp2040.rosc", RP2040_ROSC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_rosc_vmstate = {
+    .name = TYPE_RP2040_ROSC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, RP2040RoscState),
+        VMSTATE_UINT32(freqa, RP2040RoscState),
+        VMSTATE_UINT32(freqb, RP2040RoscState),
+        VMSTATE_UINT32(dormant, RP2040RoscState),
+        VMSTATE_UINT32(div, RP2040RoscState),
+        VMSTATE_UINT32(phase, RP2040RoscState),
+        VMSTATE_UINT32(count, RP2040RoscState),
+        VMSTATE_INT64(count_start_ns, RP2040RoscState),
+        VMSTATE_UINT64(random_pool, RP2040RoscState),
+        VMSTATE_UINT64(random_prng_state, RP2040RoscState),
+        VMSTATE_UINT64(random_seed, RP2040RoscState),
+        VMSTATE_UINT8(random_pool_bits, RP2040RoscState),
+        VMSTATE_BOOL(random_seed_set, RP2040RoscState),
+        VMSTATE_BOOL(badwrite, RP2040RoscState),
+        VMSTATE_CLOCK(clk, RP2040RoscState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_rosc_properties[] = {
+    DEFINE_PROP_UINT64("random-seed", RP2040RoscState, random_seed, 0),
+    DEFINE_PROP_BOOL("random-seed-set", RP2040RoscState, random_seed_set,
+                     false),
+};
+
+static void rp2040_rosc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_rosc_reset);
+    dc->vmsd = &rp2040_rosc_vmstate;
+    device_class_set_props(dc, rp2040_rosc_properties);
+}
+
+static const TypeInfo rp2040_rosc_info = {
+    .name          = TYPE_RP2040_ROSC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040RoscState),
+    .instance_init = rp2040_rosc_init,
+    .class_init    = rp2040_rosc_class_init,
+};
+
+static void rp2040_rosc_register_types(void)
+{
+    type_register_static(&rp2040_rosc_info);
+}
+type_init(rp2040_rosc_register_types)
diff --git a/hw/misc/rp2040_xosc.c b/hw/misc/rp2040_xosc.c
new file mode 100644
index 0000000000..a8340ca0c9
--- /dev/null
+++ b/hw/misc/rp2040_xosc.c
@@ -0,0 +1,237 @@
+/*
+ * RP2040 crystal oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_xosc.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define XOSC_HZ             12000000
+
+#define XOSC_CTRL           0x00
+#define XOSC_STATUS         0x04
+#define XOSC_DORMANT        0x08
+#define XOSC_STARTUP        0x0c
+#define XOSC_COUNT          0x1c
+
+#define XOSC_ENABLE_DISABLE 0xd1e
+#define XOSC_ENABLE_ENABLE  0xfab
+#define XOSC_FREQ_1_15MHZ   0xaa0
+#define XOSC_DORMANT_VALUE  0x636f6d61
+#define XOSC_WAKE_VALUE     0x77616b65
+
+#define XOSC_STATUS_STABLE  BIT(31)
+#define XOSC_STATUS_BADWRITE BIT(24)
+#define XOSC_STATUS_ENABLED BIT(12)
+
+#define ATOMIC_ALIAS_MASK    0x3000
+#define ATOMIC_XOR           0x1000
+#define ATOMIC_SET           0x2000
+#define ATOMIC_CLR           0x3000
+
+static bool rp2040_xosc_enabled(RP2040XoscState *s)
+{
+    return extract32(s->ctrl, 12, 12) != XOSC_ENABLE_DISABLE;
+}
+
+static void rp2040_xosc_update_clock(RP2040XoscState *s)
+{
+    clock_update_hz(s->clk, rp2040_xosc_enabled(s) ? XOSC_HZ : 0);
+}
+
+static uint32_t rp2040_xosc_status(RP2040XoscState *s)
+{
+    uint32_t value = 0;
+
+    if (rp2040_xosc_enabled(s)) {
+        value |= XOSC_STATUS_ENABLED;
+        if (s->dormant == XOSC_WAKE_VALUE) {
+            value |= XOSC_STATUS_STABLE;
+        }
+    }
+    if (s->badwrite) {
+        value |= XOSC_STATUS_BADWRITE;
+    }
+
+    return value;
+}
+
+static uint64_t rp2040_xosc_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040XoscState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case XOSC_CTRL:
+        value = s->ctrl;
+        break;
+    case XOSC_STATUS:
+        value = rp2040_xosc_status(s);
+        break;
+    case XOSC_DORMANT:
+        value = s->dormant;
+        break;
+    case XOSC_STARTUP:
+        value = s->startup;
+        break;
+    case XOSC_COUNT:
+        value = 0;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read("xosc", size,
+                                      RP2040_XOSC_BASE + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static uint32_t rp2040_xosc_apply_alias(uint32_t old, uint32_t value,
+                                        hwaddr alias)
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
+static void rp2040_xosc_write_ctrl(RP2040XoscState *s, uint32_t value)
+{
+    uint32_t enable = extract32(value, 12, 12);
+    uint32_t freq_range = extract32(value, 0, 12);
+
+    if (freq_range != XOSC_FREQ_1_15MHZ ||
+        (enable != XOSC_ENABLE_DISABLE && enable != XOSC_ENABLE_ENABLE)) {
+        s->badwrite = true;
+    }
+
+    if (enable != XOSC_ENABLE_DISABLE && enable != XOSC_ENABLE_ENABLE) {
+        value = deposit32(value, 12, 12, XOSC_ENABLE_ENABLE);
+    }
+    value = deposit32(value, 0, 12, XOSC_FREQ_1_15MHZ);
+
+    s->ctrl = value;
+    rp2040_xosc_update_clock(s);
+}
+
+static void rp2040_xosc_write(void *opaque, hwaddr addr,
+                              uint64_t value64, unsigned size)
+{
+    RP2040XoscState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case XOSC_CTRL:
+        rp2040_xosc_write_ctrl(s, rp2040_xosc_apply_alias(s->ctrl, value,
+                                                          alias));
+        break;
+    case XOSC_STATUS:
+        if (value & XOSC_STATUS_BADWRITE) {
+            s->badwrite = false;
+        }
+        break;
+    case XOSC_DORMANT:
+        s->dormant = value == XOSC_DORMANT_VALUE ? value : XOSC_WAKE_VALUE;
+        rp2040_xosc_update_clock(s);
+        break;
+    case XOSC_STARTUP:
+        s->startup = value & 0x00103fff;
+        break;
+    case XOSC_COUNT:
+        s->count = 0;
+        break;
+    default:
+        rp2040_log_unimplemented_write("xosc", size,
+                                       RP2040_XOSC_BASE + addr, offset,
+                                       value64);
+        break;
+    }
+}
+
+static const MemoryRegionOps rp2040_xosc_ops = {
+    .read = rp2040_xosc_read,
+    .write = rp2040_xosc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_xosc_reset(DeviceState *dev)
+{
+    RP2040XoscState *s = RP2040_XOSC(dev);
+
+    s->ctrl = (XOSC_ENABLE_DISABLE << 12) | XOSC_FREQ_1_15MHZ;
+    s->dormant = XOSC_WAKE_VALUE;
+    s->startup = 0x000000c4;
+    s->count = 0;
+    s->badwrite = false;
+
+    rp2040_xosc_update_clock(s);
+}
+
+static void rp2040_xosc_init(Object *obj)
+{
+    RP2040XoscState *s = RP2040_XOSC(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk = qdev_init_clock_out(dev, "clk");
+    memory_region_init_io(&s->iomem, obj, &rp2040_xosc_ops, s,
+                          "rp2040.xosc", RP2040_XOSC_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_xosc_vmstate = {
+    .name = TYPE_RP2040_XOSC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, RP2040XoscState),
+        VMSTATE_UINT32(dormant, RP2040XoscState),
+        VMSTATE_UINT32(startup, RP2040XoscState),
+        VMSTATE_UINT32(count, RP2040XoscState),
+        VMSTATE_BOOL(badwrite, RP2040XoscState),
+        VMSTATE_CLOCK(clk, RP2040XoscState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_xosc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_xosc_reset);
+    dc->vmsd = &rp2040_xosc_vmstate;
+}
+
+static const TypeInfo rp2040_xosc_info = {
+    .name          = TYPE_RP2040_XOSC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040XoscState),
+    .instance_init = rp2040_xosc_init,
+    .class_init    = rp2040_xosc_class_init,
+};
+
+static void rp2040_xosc_register_types(void)
+{
+    type_register_static(&rp2040_xosc_info);
+}
+type_init(rp2040_xosc_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 86037dd0d7..47a8cb2236 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -13,10 +13,12 @@
 #include "hw/char/pl011.h"
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/rp2040_rosc.h"
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_tbman.h"
 #include "hw/misc/rp2040_vreg.h"
+#include "hw/misc/rp2040_xosc.h"
 #include "qom/object.h"
 
 #define TYPE_RP2040 "rp2040"
@@ -40,8 +42,10 @@ struct RP2040State {
     PL011State uart[2];
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
+    RP2040RoscState rosc;
     RP2040TbmanState tbman;
     RP2040VregState vreg;
+    RP2040XoscState xosc;
 
     MemoryRegion *board_memory;
     MemoryRegion rom;
diff --git a/include/hw/misc/rp2040_rosc.h b/include/hw/misc/rp2040_rosc.h
new file mode 100644
index 0000000000..6377704e22
--- /dev/null
+++ b/include/hw/misc/rp2040_rosc.h
@@ -0,0 +1,42 @@
+/*
+ * RP2040 ring oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_ROSC_H
+#define HW_MISC_RP2040_ROSC_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_ROSC "rp2040-rosc"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040RoscState, RP2040_ROSC)
+
+#define RP2040_ROSC_BASE 0x40060000
+#define RP2040_ROSC_SIZE 0x4000
+
+struct RP2040RoscState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk;
+
+    uint32_t ctrl;
+    uint32_t freqa;
+    uint32_t freqb;
+    uint32_t dormant;
+    uint32_t div;
+    uint32_t phase;
+    uint32_t count;
+    int64_t count_start_ns;
+    uint64_t random_pool;
+    uint64_t random_prng_state;
+    uint64_t random_seed;
+    uint8_t random_pool_bits;
+    bool random_seed_set;
+    bool badwrite;
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_xosc.h b/include/hw/misc/rp2040_xosc.h
new file mode 100644
index 0000000000..7b9ef62d22
--- /dev/null
+++ b/include/hw/misc/rp2040_xosc.h
@@ -0,0 +1,33 @@
+/*
+ * RP2040 crystal oscillator emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_XOSC_H
+#define HW_MISC_RP2040_XOSC_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_XOSC "rp2040-xosc"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040XoscState, RP2040_XOSC)
+
+#define RP2040_XOSC_BASE 0x40024000
+#define RP2040_XOSC_SIZE 0x4000
+
+struct RP2040XoscState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk;
+
+    uint32_t ctrl;
+    uint32_t dormant;
+    uint32_t startup;
+    uint32_t count;
+    bool badwrite;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 8916f68bad..441f6f294a 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -256,6 +256,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
+                                                       'rp2040-rosc-test',
                                                        'rp2040-tbman-test',
                                                        'rp2040-vreg-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
diff --git a/tests/qtest/rp2040-rosc-test.c b/tests/qtest/rp2040-rosc-test.c
new file mode 100644
index 0000000000..2f1fb96022
--- /dev/null
+++ b/tests/qtest/rp2040-rosc-test.c
@@ -0,0 +1,146 @@
+/*
+ * QTest testcase for the RP2040 ring oscillator block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define ROSC_BASE              0x40060000
+#define ROSC_CTRL              0x00
+#define ROSC_FREQA             0x04
+#define ROSC_DORMANT           0x0c
+#define ROSC_DIV               0x10
+#define ROSC_PHASE             0x14
+#define ROSC_STATUS            0x18
+#define ROSC_RANDOMBIT         0x1c
+#define ROSC_COUNT             0x20
+
+#define ROSC_ENABLE_ENABLE     0xfab
+#define ROSC_ENABLE_DISABLE    0xd1e
+#define ROSC_FREQ_RANGE_LOW    0xfa4
+#define ROSC_WAKE_VALUE        0x77616b65
+#define ROSC_STATUS_STABLE     BIT(31)
+#define ROSC_STATUS_BADWRITE   BIT(24)
+#define ROSC_STATUS_DIV_RUNNING BIT(16)
+#define ROSC_STATUS_ENABLED    BIT(12)
+#define ROSC_STATUS_RUNNING \
+    (ROSC_STATUS_STABLE | ROSC_STATUS_DIV_RUNNING | ROSC_STATUS_ENABLED)
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static uint32_t read_random_bits(QTestState *qts, unsigned count)
+{
+    uint32_t value = 0;
+    unsigned i;
+
+    for (i = 0; i < count; i++) {
+        value |= (qtest_readl(qts, ROSC_BASE + ROSC_RANDOMBIT) & BIT(0)) << i;
+    }
+
+    return value;
+}
+
+static void test_rosc_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_CTRL), ==,
+                    (ROSC_ENABLE_ENABLE << 12) | ROSC_FREQ_RANGE_LOW);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_DORMANT), ==,
+                    ROSC_WAKE_VALUE);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_DIV), ==, 0x00000ab0);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS), ==,
+                    ROSC_STATUS_RUNNING);
+
+    qtest_quit(qts);
+}
+
+static void test_rosc_badwrite_and_clear(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, ROSC_BASE + ROSC_FREQA, 0x00007777);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_FREQA), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS) &
+                    ROSC_STATUS_BADWRITE, ==, ROSC_STATUS_BADWRITE);
+
+    qtest_writel(qts, ROSC_BASE + ROSC_STATUS, ROSC_STATUS_BADWRITE);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS) &
+                    ROSC_STATUS_BADWRITE, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_rosc_count_reaches_zero(void)
+{
+    QTestState *qts = rp2040_start();
+    int i;
+
+    qtest_writel(qts, ROSC_BASE + ROSC_COUNT, 1);
+    for (i = 0; i < 16 && qtest_readl(qts, ROSC_BASE + ROSC_COUNT); i++) {
+        qtest_clock_step(qts, 1000);
+    }
+
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_COUNT), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_rosc_misc_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_RANDOMBIT) & ~BIT(0),
+                    ==, 0);
+    qtest_writel(qts, ROSC_BASE + ROSC_DIV, 0xaa1);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_DIV), ==, 0xaa1);
+    qtest_writel(qts, ROSC_BASE + ROSC_PHASE, 0xaa8);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_PHASE), ==, 0xaa8);
+
+    qtest_writel(qts, ROSC_BASE + ROSC_CTRL,
+                 (ROSC_ENABLE_DISABLE << 12) | ROSC_FREQ_RANGE_LOW);
+    g_assert_cmphex(qtest_readl(qts, ROSC_BASE + ROSC_STATUS) &
+                    ROSC_STATUS_ENABLED, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_rosc_seeded_randombit(void)
+{
+    QTestState *qts_a;
+    QTestState *qts_b;
+    uint32_t bits_a;
+    uint32_t bits_b;
+
+    qts_a = qtest_init("-machine raspi-pico,rosc-random-seed=0x1234");
+    bits_a = read_random_bits(qts_a, 32);
+    qtest_quit(qts_a);
+
+    qts_b = qtest_init("-machine raspi-pico,rosc-random-seed=0x1234");
+    bits_b = read_random_bits(qts_b, 32);
+    qtest_quit(qts_b);
+
+    g_assert_cmphex(bits_a, ==, bits_b);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-rosc/reset-values", test_rosc_reset_values);
+    qtest_add_func("/rp2040-rosc/badwrite-and-clear",
+                   test_rosc_badwrite_and_clear);
+    qtest_add_func("/rp2040-rosc/count-reaches-zero",
+                   test_rosc_count_reaches_zero);
+    qtest_add_func("/rp2040-rosc/misc-values", test_rosc_misc_values);
+    qtest_add_func("/rp2040-rosc/seeded-randombit",
+                   test_rosc_seeded_randombit);
+
+    return g_test_run();
+}
-- 
2.55.0


