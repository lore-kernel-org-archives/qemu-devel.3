Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7485AC61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0SiY-00088I-PJ; Sat, 29 Aug 2026 19:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiW-00087s-GO; Sat, 29 Aug 2026 19:44:08 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0SiS-0006Ee-Qn; Sat, 29 Aug 2026 19:44:08 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzd4kzszBqY3;
 Sun, 30 Aug 2026 01:43:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047021;
 bh=6/mfah0HA2ojyE6VhI3Frv9jdjbm4ZP2NAVGZrfbtLk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u37fXoWUR45uHdemp3T5hz9CKomFhmNbVTxAxxCEW3O5hXX/QMP/+IfzLc6ggSnco
 RpVJz1yNkXX7WDewHm5l5O9Hdfe9PZO8YjQ58KpIBgikjLfW6YOvhbh38kg8WGRcLm
 dFbuRGCJs99QlP4mVI/W+02IQ7EWNuUHdIVhTjXDZo5p+mD7DsjJ7hB9ljqwPGcWyl
 w4yVayq4LH6/hA0GhAgP1Bf88m24JBTHN2TjTEEZv7f9V6G4NVNh2jhZu5yuY3F4br
 UOAtGui8mxLnvaBZprL20JymeoxrRUQsWKKBMO6l/L082C1rZHH86SE2MAUMGDS2Gt
 EoOc23zl15cAQ==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzd2Svvz7vrV;
 Sun, 30 Aug 2026 01:43:41 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 09/30] hw/misc: add RP2040 PLL and clock controller
Date: Sun, 30 Aug 2026 01:42:43 +0200
Message-ID: <20260829234308.33725-10-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 system and USB PLL register blocks and their clock outputs. Add the clock mux, divider, selected-source and frequency-counter registers, then route clk-sys to the Cortex-M0+ and clk-peri to both UARTs. Include focused qtests for PLL configuration, clock switching and frequency measurement.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                   |   2 +
 hw/arm/rp2040.c                  |  45 ++-
 hw/misc/Kconfig                  |   6 +
 hw/misc/meson.build              |   2 +
 hw/misc/rp2040_clocks.c          | 480 +++++++++++++++++++++++++++++++
 hw/misc/rp2040_pll.c             | 234 +++++++++++++++
 include/hw/arm/rp2040.h          |   5 +
 include/hw/misc/rp2040_clocks.h  |  36 +++
 include/hw/misc/rp2040_pll.h     |  37 +++
 tests/qtest/meson.build          |   1 +
 tests/qtest/rp2040-clocks-test.c | 107 +++++++
 11 files changed, 948 insertions(+), 7 deletions(-)
 create mode 100644 hw/misc/rp2040_clocks.c
 create mode 100644 hw/misc/rp2040_pll.c
 create mode 100644 include/hw/misc/rp2040_clocks.h
 create mode 100644 include/hw/misc/rp2040_pll.h
 create mode 100644 tests/qtest/rp2040-clocks-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b55a75fd5a..3d1b424fe5 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -378,7 +378,9 @@ config RP2040
     bool
     select ARM_V7M
     select PL011
+    select RP2040_CLOCKS
     select RP2040_NYI
+    select RP2040_PLL
     select RP2040_ROSC
     select RP2040_SYSCFG
     select RP2040_SYSINFO
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 889decded0..b80155ba0b 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -18,8 +18,6 @@
 #include "qemu/datadir.h"
 #include "target/arm/cpu-qom.h"
 
-#define RP2040_SYSCLK_FRQ 125000000
-
 #define RP2040_UART0_BASE 0x40034000
 #define RP2040_UART0_IRQ  20
 #define RP2040_UART1_BASE 0x40038000
@@ -50,15 +48,12 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.clocks",   0x40008000, 0x4000 },
     { "rp2040.resets",   0x4000c000, 0x4000 },
     { "rp2040.psm",      0x40010000, 0x4000 },
     { "rp2040.iobank0",  0x40014000, 0x4000 },
     { "rp2040.ioqspi",   0x40018000, 0x4000 },
     { "rp2040.padsbank0", 0x4001c000, 0x4000 },
     { "rp2040.padsqspi", 0x40020000, 0x4000 },
-    { "rp2040.pll_sys",  0x40028000, 0x4000 },
-    { "rp2040.pll_usb",  0x4002c000, 0x4000 },
     { "rp2040.busctrl",  0x40030000, 0x4000 },
     { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
     { "rp2040.uart1_aliases", 0x40039000, 0x3000 },
@@ -173,6 +168,20 @@ static void rp2040_soc_init(Object *obj)
                                   "chardev");
     }
 
+    object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
+
+    object_initialize_child(obj, "pll-sys", &s->pll_sys, TYPE_RP2040_PLL);
+    qdev_prop_set_string(DEVICE(&s->pll_sys), "trace-name",
+                         "rp2040.pll_sys");
+    qdev_prop_set_uint32(DEVICE(&s->pll_sys), "base", RP2040_PLL_SYS_BASE);
+    qdev_prop_set_uint32(DEVICE(&s->pll_sys), "fallback-hz", 125000000);
+
+    object_initialize_child(obj, "pll-usb", &s->pll_usb, TYPE_RP2040_PLL);
+    qdev_prop_set_string(DEVICE(&s->pll_usb), "trace-name",
+                         "rp2040.pll_usb");
+    qdev_prop_set_uint32(DEVICE(&s->pll_usb), "base", RP2040_PLL_USB_BASE);
+    qdev_prop_set_uint32(DEVICE(&s->pll_usb), "fallback-hz", 48000000);
+
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_RP2040_SYSCFG);
     object_initialize_child(obj, "sysinfo", &s->sysinfo, TYPE_RP2040_SYSINFO);
     object_initialize_child(obj, "rosc", &s->rosc, TYPE_RP2040_ROSC);
@@ -182,7 +191,6 @@ static void rp2040_soc_init(Object *obj)
 
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
     s->sysclk = clock_new(obj, "sysclk");
-    clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
 }
 
 static bool rp2040_init_memory(RP2040State *s, Error **errp)
@@ -298,6 +306,27 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
                                     rp2040_unimplemented[i].size);
     }
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pll_sys), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pll_sys), 0, RP2040_PLL_SYS_BASE);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pll_usb), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pll_usb), 0, RP2040_PLL_USB_BASE);
+
+    qdev_connect_clock_in(DEVICE(&s->clocks), "pll-sys",
+                          qdev_get_clock_out(DEVICE(&s->pll_sys), "clk"));
+    qdev_connect_clock_in(DEVICE(&s->clocks), "pll-usb",
+                          qdev_get_clock_out(DEVICE(&s->pll_usb), "clk"));
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->clocks), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clocks), 0, RP2040_CLOCKS_BASE);
+    clock_set_source(s->sysclk, qdev_get_clock_out(DEVICE(&s->clocks),
+                                                   "clk-sys"));
+
     qdev_connect_clock_in(DEVICE(&s->armv7m), "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(s->board_memory), &err);
@@ -346,7 +375,9 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xosc), 0, RP2040_XOSC_BASE);
 
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
-        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
+        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk",
+                              qdev_get_clock_out(DEVICE(&s->clocks),
+                                                 "clk-peri"));
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f0860139f..8ed229cf27 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -101,9 +101,15 @@ config FSL_IMX8MP_ANALOG
 config FSL_IMX8MP_CCM
     bool
 
+config RP2040_CLOCKS
+    bool
+
 config RP2040_NYI
     bool
 
+config RP2040_PLL
+    bool
+
 config RP2040_ROSC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 7ad307beee..af48fa6dba 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,7 +98,9 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040_CLOCKS', if_true: files('rp2040_clocks.c'))
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
+system_ss.add(when: 'CONFIG_RP2040_PLL', if_true: files('rp2040_pll.c'))
 system_ss.add(when: 'CONFIG_RP2040_ROSC', if_true: files('rp2040_rosc.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSCFG', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040_SYSINFO', if_true: files('rp2040_sysinfo.c'))
diff --git a/hw/misc/rp2040_clocks.c b/hw/misc/rp2040_clocks.c
new file mode 100644
index 0000000000..8a59009c40
--- /dev/null
+++ b/hw/misc/rp2040_clocks.c
@@ -0,0 +1,480 @@
+/*
+ * RP2040 clocks emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define ROSC_HZ     6000000
+#define XOSC_HZ     12000000
+
+#define CLK_GPOUT0_CTRL      0x00
+#define CLK_REF_CTRL         0x30
+#define CLK_REF_DIV          0x34
+#define CLK_REF_SELECTED     0x38
+#define CLK_SYS_CTRL         0x3c
+#define CLK_SYS_DIV          0x40
+#define CLK_SYS_SELECTED     0x44
+#define CLK_PERI_CTRL        0x48
+#define CLK_PERI_DIV         0x4c
+#define CLK_PERI_SELECTED    0x50
+#define CLK_USB_CTRL         0x54
+#define CLK_USB_DIV          0x58
+#define CLK_USB_SELECTED     0x5c
+#define CLK_ADC_CTRL         0x60
+#define CLK_ADC_DIV          0x64
+#define CLK_ADC_SELECTED     0x68
+#define CLK_RTC_CTRL         0x6c
+#define CLK_RTC_DIV          0x70
+#define CLK_RTC_SELECTED     0x74
+#define FC0_REF_KHZ          0x80
+#define FC0_MIN_KHZ          0x84
+#define FC0_MAX_KHZ          0x88
+#define FC0_DELAY            0x8c
+#define FC0_INTERVAL         0x90
+#define FC0_SRC              0x94
+#define FC0_STATUS           0x98
+#define FC0_RESULT           0x9c
+#define WAKE_EN0             0xa0
+#define WAKE_EN1             0xa4
+#define SLEEP_EN0            0xa8
+#define SLEEP_EN1            0xac
+#define ENABLED0             0xb0
+#define ENABLED1             0xb4
+#define INTR                 0xb8
+
+#define CTRL_ENABLE          BIT(11)
+
+#define ATOMIC_ALIAS_MASK    0x3000
+#define ATOMIC_XOR           0x1000
+#define ATOMIC_SET           0x2000
+#define ATOMIC_CLR           0x3000
+
+static void rp2040_clocks_update(RP2040ClocksState *s);
+
+static uint32_t rp2040_clocks_div(uint32_t reg)
+{
+    uint32_t div = reg >> 8;
+
+    return div == 0 ? 1u << 16 : div;
+}
+
+static unsigned rp2040_clocks_hz(Clock *clk)
+{
+    return MIN(clock_get_hz(clk), UINT_MAX);
+}
+
+static unsigned rp2040_clocks_sys_aux_freq(RP2040ClocksState *s,
+                                           uint32_t auxsrc)
+{
+    switch (auxsrc & 0x7) {
+    case 0x0:
+        return rp2040_clocks_hz(s->pll_sys);
+    case 0x1:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x2:
+        return ROSC_HZ;
+    case 0x3:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_ref_aux_freq(RP2040ClocksState *s,
+                                           uint32_t auxsrc)
+{
+    switch (auxsrc & 0x3) {
+    case 0x0:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x1:
+        return ROSC_HZ;
+    case 0x2:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_peri_aux_freq(RP2040ClocksState *s,
+                                            uint32_t auxsrc)
+{
+    switch (auxsrc & 0x7) {
+    case 0x0:
+        return rp2040_clocks_hz(s->clk_sys);
+    case 0x1:
+        return rp2040_clocks_hz(s->pll_sys);
+    case 0x2:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x3:
+        return ROSC_HZ;
+    case 0x4:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_usb_adc_rtc_aux_freq(RP2040ClocksState *s,
+                                                   uint32_t auxsrc)
+{
+    switch (auxsrc & 0x7) {
+    case 0x0:
+        return rp2040_clocks_hz(s->pll_usb);
+    case 0x1:
+        return rp2040_clocks_hz(s->pll_sys);
+    case 0x2:
+        return ROSC_HZ;
+    case 0x3:
+        return XOSC_HZ;
+    default:
+        return 0;
+    }
+}
+
+static unsigned rp2040_clocks_ctrl_auxsrc(uint32_t ctrl)
+{
+    return extract32(ctrl, 5, 4);
+}
+
+static unsigned rp2040_clocks_ref_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[CLK_REF_CTRL / 4];
+    uint32_t src = extract32(ctrl, 0, 2);
+    unsigned freq;
+
+    switch (src) {
+    case 0:
+        freq = ROSC_HZ;
+        break;
+    case 1:
+        freq = rp2040_clocks_ref_aux_freq(s,
+                                          rp2040_clocks_ctrl_auxsrc(ctrl));
+        break;
+    case 2:
+        freq = XOSC_HZ;
+        break;
+    default:
+        freq = 0;
+        break;
+    }
+
+    return freq / rp2040_clocks_div(s->regs[CLK_REF_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_sys_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[CLK_SYS_CTRL / 4];
+    uint32_t src = extract32(ctrl, 0, 1);
+    unsigned freq;
+
+    if (src) {
+        freq = rp2040_clocks_sys_aux_freq(s,
+                                          rp2040_clocks_ctrl_auxsrc(ctrl));
+    } else {
+        freq = rp2040_clocks_ref_freq(s);
+    }
+
+    return freq / rp2040_clocks_div(s->regs[CLK_SYS_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_peri_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[CLK_PERI_CTRL / 4];
+
+    if (!(ctrl & CTRL_ENABLE)) {
+        return 0;
+    }
+
+    return rp2040_clocks_peri_aux_freq(s, rp2040_clocks_ctrl_auxsrc(ctrl)) /
+           rp2040_clocks_div(s->regs[CLK_PERI_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_usb_adc_rtc_freq(RP2040ClocksState *s,
+                                               uint32_t ctrl_off,
+                                               uint32_t div_off)
+{
+    uint32_t ctrl = s->regs[ctrl_off / 4];
+
+    if (!(ctrl & CTRL_ENABLE)) {
+        return 0;
+    }
+
+    return rp2040_clocks_usb_adc_rtc_aux_freq(s,
+                                              rp2040_clocks_ctrl_auxsrc(ctrl)) /
+           rp2040_clocks_div(s->regs[div_off / 4]);
+}
+
+static void rp2040_clocks_update(RP2040ClocksState *s)
+{
+    unsigned ref_hz = rp2040_clocks_ref_freq(s);
+    unsigned sys_hz = rp2040_clocks_sys_freq(s);
+
+    clock_update_hz(s->clk_ref, ref_hz);
+    clock_update_hz(s->clk_sys, sys_hz);
+    clock_update_hz(s->clk_peri, rp2040_clocks_peri_freq(s));
+    clock_update_hz(s->clk_usb,
+                    rp2040_clocks_usb_adc_rtc_freq(s, CLK_USB_CTRL,
+                                                   CLK_USB_DIV));
+    clock_update_hz(s->clk_adc,
+                    rp2040_clocks_usb_adc_rtc_freq(s, CLK_ADC_CTRL,
+                                                   CLK_ADC_DIV));
+    clock_update_hz(s->clk_rtc,
+                    rp2040_clocks_usb_adc_rtc_freq(s, CLK_RTC_CTRL,
+                                                   CLK_RTC_DIV));
+}
+
+static uint32_t rp2040_clocks_selected(RP2040ClocksState *s, hwaddr offset)
+{
+    switch (offset) {
+    case CLK_REF_SELECTED:
+        return 1u << extract32(s->regs[CLK_REF_CTRL / 4], 0, 2);
+    case CLK_SYS_SELECTED:
+        return 1u << extract32(s->regs[CLK_SYS_CTRL / 4], 0, 1);
+    case CLK_PERI_SELECTED:
+    case CLK_USB_SELECTED:
+    case CLK_ADC_SELECTED:
+    case CLK_RTC_SELECTED:
+        return 1;
+    default:
+        return 0;
+    }
+}
+
+static uint32_t rp2040_clocks_fc0_result(RP2040ClocksState *s)
+{
+    unsigned khz;
+
+    switch (s->regs[FC0_SRC / 4] & 0xff) {
+    case 0x01:
+        khz = rp2040_clocks_hz(s->pll_sys) / 1000;
+        break;
+    case 0x02:
+        khz = rp2040_clocks_hz(s->pll_usb) / 1000;
+        break;
+    case 0x03:
+    case 0x04:
+        khz = ROSC_HZ / 1000;
+        break;
+    case 0x05:
+        khz = XOSC_HZ / 1000;
+        break;
+    case 0x08:
+        khz = rp2040_clocks_ref_freq(s) / 1000;
+        break;
+    case 0x09:
+        khz = rp2040_clocks_sys_freq(s) / 1000;
+        break;
+    case 0x0a:
+        khz = clock_get_hz(s->clk_peri) / 1000;
+        break;
+    case 0x0b:
+        khz = clock_get_hz(s->clk_usb) / 1000;
+        break;
+    case 0x0c:
+        khz = clock_get_hz(s->clk_adc) / 1000;
+        break;
+    case 0x0d:
+        khz = clock_get_hz(s->clk_rtc) / 1000;
+        break;
+    default:
+        khz = 0;
+        break;
+    }
+
+    return khz << 5;
+}
+
+static bool rp2040_clocks_is_selected(hwaddr offset)
+{
+    return offset == CLK_REF_SELECTED ||
+           offset == CLK_SYS_SELECTED ||
+           offset == CLK_PERI_SELECTED ||
+           offset == CLK_USB_SELECTED ||
+           offset == CLK_ADC_SELECTED ||
+           offset == CLK_RTC_SELECTED;
+}
+
+static uint64_t rp2040_clocks_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040ClocksState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    if (offset >= sizeof(s->regs)) {
+        value = 0;
+        rp2040_log_unimplemented_read("clocks", size,
+                                      RP2040_CLOCKS_BASE + addr, offset,
+                                      value);
+    } else if (rp2040_clocks_is_selected(offset)) {
+        value = rp2040_clocks_selected(s, offset);
+    } else {
+        switch (offset) {
+        case FC0_STATUS:
+            value = BIT(4);
+            break;
+        case FC0_RESULT:
+            value = rp2040_clocks_fc0_result(s);
+            break;
+        case ENABLED0:
+        case ENABLED1:
+            value = s->regs[(offset - 0x10) / 4];
+            break;
+        default:
+            value = s->regs[offset / 4];
+            break;
+        }
+    }
+
+    return value;
+}
+
+static void rp2040_clocks_write(void *opaque, hwaddr addr,
+                                uint64_t value, unsigned size)
+{
+    RP2040ClocksState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t old;
+    uint32_t newval = value;
+
+    if (offset < sizeof(s->regs) && !rp2040_clocks_is_selected(offset)) {
+        old = s->regs[offset / 4];
+        switch (alias) {
+        case ATOMIC_XOR:
+            newval = old ^ value;
+            break;
+        case ATOMIC_SET:
+            newval = old | value;
+            break;
+        case ATOMIC_CLR:
+            newval = old & ~value;
+            break;
+        default:
+            break;
+        }
+
+        switch (offset) {
+        case ENABLED0:
+        case ENABLED1:
+        case FC0_STATUS:
+        case FC0_RESULT:
+        case INTR:
+            break;
+        default:
+            s->regs[offset / 4] = newval;
+            rp2040_clocks_update(s);
+            break;
+        }
+    } else if (offset >= sizeof(s->regs)) {
+        rp2040_log_unimplemented_write("clocks", size,
+                                       RP2040_CLOCKS_BASE + addr, offset,
+                                       value);
+    }
+}
+
+static void rp2040_clocks_input_update(void *opaque, ClockEvent event)
+{
+    rp2040_clocks_update(opaque);
+}
+
+static const MemoryRegionOps rp2040_clocks_ops = {
+    .read = rp2040_clocks_read,
+    .write = rp2040_clocks_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_clocks_reset(DeviceState *dev)
+{
+    RP2040ClocksState *s = RP2040_CLOCKS(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    s->regs[CLK_REF_DIV / 4] = 0x00000100;
+    s->regs[CLK_SYS_DIV / 4] = 0x00000100;
+    s->regs[CLK_PERI_CTRL / 4] = CTRL_ENABLE;
+    s->regs[CLK_PERI_DIV / 4] = 0x00000100;
+    s->regs[CLK_USB_CTRL / 4] = CTRL_ENABLE | (0x3 << 5);
+    s->regs[CLK_USB_DIV / 4] = 0x00000100;
+    s->regs[CLK_ADC_CTRL / 4] = CTRL_ENABLE | (0x3 << 5);
+    s->regs[CLK_ADC_DIV / 4] = 0x00000100;
+    s->regs[CLK_RTC_CTRL / 4] = CTRL_ENABLE | (0xa << 5);
+    s->regs[CLK_RTC_DIV / 4] = 0x00000100;
+    s->regs[FC0_REF_KHZ / 4] = XOSC_HZ / 1000;
+    s->regs[WAKE_EN0 / 4] = 0xffffffff;
+    s->regs[WAKE_EN1 / 4] = 0xffffffff;
+    s->regs[SLEEP_EN0 / 4] = 0xffffffff;
+    s->regs[SLEEP_EN1 / 4] = 0xffffffff;
+
+    rp2040_clocks_update(s);
+}
+
+static void rp2040_clocks_init(Object *obj)
+{
+    RP2040ClocksState *s = RP2040_CLOCKS(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk_ref = qdev_init_clock_out(dev, "clk-ref");
+    s->clk_sys = qdev_init_clock_out(dev, "clk-sys");
+    s->clk_peri = qdev_init_clock_out(dev, "clk-peri");
+    s->clk_usb = qdev_init_clock_out(dev, "clk-usb");
+    s->clk_adc = qdev_init_clock_out(dev, "clk-adc");
+    s->clk_rtc = qdev_init_clock_out(dev, "clk-rtc");
+    s->pll_sys = qdev_init_clock_in(dev, "pll-sys",
+                                    rp2040_clocks_input_update, s, 0);
+    s->pll_usb = qdev_init_clock_in(dev, "pll-usb",
+                                    rp2040_clocks_input_update, s, 0);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_clocks_ops, s,
+                          "rp2040.clocks", RP2040_CLOCKS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_clocks_vmstate = {
+    .name = TYPE_RP2040_CLOCKS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, RP2040ClocksState, 0x100 / 4),
+        VMSTATE_CLOCK(clk_ref, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_sys, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_peri, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_usb, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_adc, RP2040ClocksState),
+        VMSTATE_CLOCK(clk_rtc, RP2040ClocksState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_clocks_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_clocks_reset);
+    dc->vmsd = &rp2040_clocks_vmstate;
+}
+
+static const TypeInfo rp2040_clocks_info = {
+    .name          = TYPE_RP2040_CLOCKS,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040ClocksState),
+    .instance_init = rp2040_clocks_init,
+    .class_init    = rp2040_clocks_class_init,
+};
+
+static void rp2040_clocks_register_types(void)
+{
+    type_register_static(&rp2040_clocks_info);
+}
+type_init(rp2040_clocks_register_types)
diff --git a/hw/misc/rp2040_pll.c b/hw/misc/rp2040_pll.c
new file mode 100644
index 0000000000..6fe2be6608
--- /dev/null
+++ b/hw/misc/rp2040_pll.c
@@ -0,0 +1,234 @@
+/*
+ * RP2040 PLL emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/misc/rp2040_pll.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define XOSC_HZ             12000000
+
+#define PLL_CS              0x00
+#define PLL_PWR             0x04
+#define PLL_FBDIV_INT       0x08
+#define PLL_PRIM            0x0c
+
+#define PLL_CS_LOCK         BIT(31)
+#define PLL_CS_BYPASS       BIT(8)
+#define PLL_CS_REFDIV_MASK  0x3f
+
+#define PLL_PWR_VCOPD       BIT(5)
+#define PLL_PWR_POSTDIVPD   BIT(3)
+#define PLL_PWR_DSMPD       BIT(2)
+#define PLL_PWR_PD          BIT(0)
+#define PLL_PWR_MASK        (PLL_PWR_VCOPD | PLL_PWR_POSTDIVPD | \
+                             PLL_PWR_DSMPD | PLL_PWR_PD)
+
+#define PLL_FBDIV_MASK      0x00000fff
+#define PLL_PRIM_MASK       0x00077000
+
+#define ATOMIC_ALIAS_MASK   0x3000
+#define ATOMIC_XOR          0x1000
+#define ATOMIC_SET          0x2000
+#define ATOMIC_CLR          0x3000
+
+static uint32_t rp2040_pll_apply_alias(uint32_t old, uint32_t value,
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
+static bool rp2040_pll_locked(RP2040PllState *s)
+{
+    return !(s->pwr & (PLL_PWR_PD | PLL_PWR_VCOPD));
+}
+
+static unsigned rp2040_pll_output_hz(RP2040PllState *s)
+{
+    uint32_t refdiv = s->cs & PLL_CS_REFDIV_MASK;
+    uint32_t fbdiv = s->fbdiv_int & PLL_FBDIV_MASK;
+    uint32_t postdiv1 = extract32(s->prim, 16, 3);
+    uint32_t postdiv2 = extract32(s->prim, 12, 3);
+    uint64_t hz;
+
+    if (!rp2040_pll_locked(s) || (s->pwr & PLL_PWR_POSTDIVPD)) {
+        return 0;
+    }
+
+    refdiv = refdiv ? refdiv : 1;
+    if (s->cs & PLL_CS_BYPASS) {
+        return XOSC_HZ / refdiv;
+    }
+
+    if (!fbdiv || !postdiv1 || !postdiv2) {
+        return s->fallback_hz;
+    }
+
+    hz = XOSC_HZ;
+    hz = hz * fbdiv / refdiv / postdiv1 / postdiv2;
+    return hz;
+}
+
+static void rp2040_pll_update_clock(RP2040PllState *s)
+{
+    clock_update_hz(s->clk, rp2040_pll_output_hz(s));
+}
+
+static uint64_t rp2040_pll_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040PllState *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    const char *name = s->trace_name ? s->trace_name : "rp2040.pll";
+    uint64_t value;
+
+    switch (offset) {
+    case PLL_CS:
+        value = s->cs & ~PLL_CS_LOCK;
+        if (rp2040_pll_locked(s)) {
+            value |= PLL_CS_LOCK;
+        }
+        break;
+    case PLL_PWR:
+        value = s->pwr;
+        break;
+    case PLL_FBDIV_INT:
+        value = s->fbdiv_int;
+        break;
+    case PLL_PRIM:
+        value = s->prim;
+        break;
+    default:
+        value = 0;
+        rp2040_log_unimplemented_read(name, size, s->base + addr, offset,
+                                      value);
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_pll_write(void *opaque, hwaddr addr,
+                             uint64_t value64, unsigned size)
+{
+    RP2040PllState *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    const char *name = s->trace_name ? s->trace_name : "rp2040.pll";
+    uint32_t value = value64;
+
+    switch (offset) {
+    case PLL_CS:
+        s->cs = rp2040_pll_apply_alias(s->cs, value, alias) &
+                (PLL_CS_BYPASS | PLL_CS_REFDIV_MASK);
+        break;
+    case PLL_PWR:
+        s->pwr = rp2040_pll_apply_alias(s->pwr, value, alias) & PLL_PWR_MASK;
+        break;
+    case PLL_FBDIV_INT:
+        s->fbdiv_int = rp2040_pll_apply_alias(s->fbdiv_int, value, alias) &
+                       PLL_FBDIV_MASK;
+        break;
+    case PLL_PRIM:
+        s->prim = rp2040_pll_apply_alias(s->prim, value, alias) &
+                  PLL_PRIM_MASK;
+        break;
+    default:
+        rp2040_log_unimplemented_write(name, size, s->base + addr, offset,
+                                       value64);
+        break;
+    }
+
+    rp2040_pll_update_clock(s);
+}
+
+static const MemoryRegionOps rp2040_pll_ops = {
+    .read = rp2040_pll_read,
+    .write = rp2040_pll_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_pll_reset(DeviceState *dev)
+{
+    RP2040PllState *s = RP2040_PLL(dev);
+
+    s->cs = 1;
+    s->pwr = PLL_PWR_MASK;
+    s->fbdiv_int = 0;
+    s->prim = (7 << 16) | (7 << 12);
+
+    rp2040_pll_update_clock(s);
+}
+
+static void rp2040_pll_init(Object *obj)
+{
+    RP2040PllState *s = RP2040_PLL(obj);
+    DeviceState *dev = DEVICE(obj);
+
+    s->clk = qdev_init_clock_out(dev, "clk");
+    memory_region_init_io(&s->iomem, obj, &rp2040_pll_ops, s,
+                          "rp2040.pll", RP2040_PLL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+}
+
+static const VMStateDescription rp2040_pll_vmstate = {
+    .name = TYPE_RP2040_PLL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(cs, RP2040PllState),
+        VMSTATE_UINT32(pwr, RP2040PllState),
+        VMSTATE_UINT32(fbdiv_int, RP2040PllState),
+        VMSTATE_UINT32(prim, RP2040PllState),
+        VMSTATE_CLOCK(clk, RP2040PllState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property rp2040_pll_properties[] = {
+    DEFINE_PROP_STRING("trace-name", RP2040PllState, trace_name),
+    DEFINE_PROP_UINT32("base", RP2040PllState, base, 0),
+    DEFINE_PROP_UINT32("fallback-hz", RP2040PllState, fallback_hz, 0),
+};
+
+static void rp2040_pll_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_pll_reset);
+    device_class_set_props(dc, rp2040_pll_properties);
+    dc->vmsd = &rp2040_pll_vmstate;
+}
+
+static const TypeInfo rp2040_pll_info = {
+    .name          = TYPE_RP2040_PLL,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040PllState),
+    .instance_init = rp2040_pll_init,
+    .class_init    = rp2040_pll_class_init,
+};
+
+static void rp2040_pll_register_types(void)
+{
+    type_register_static(&rp2040_pll_info);
+}
+type_init(rp2040_pll_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 47a8cb2236..abdd2f006c 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -13,6 +13,8 @@
 #include "hw/char/pl011.h"
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_pll.h"
 #include "hw/misc/rp2040_rosc.h"
 #include "hw/misc/rp2040_syscfg.h"
 #include "hw/misc/rp2040_sysinfo.h"
@@ -40,6 +42,9 @@ struct RP2040State {
 
     ARMv7MState armv7m;
     PL011State uart[2];
+    RP2040ClocksState clocks;
+    RP2040PllState pll_sys;
+    RP2040PllState pll_usb;
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
     RP2040RoscState rosc;
diff --git a/include/hw/misc/rp2040_clocks.h b/include/hw/misc/rp2040_clocks.h
new file mode 100644
index 0000000000..ebbb14e3fa
--- /dev/null
+++ b/include/hw/misc/rp2040_clocks.h
@@ -0,0 +1,36 @@
+/*
+ * RP2040 clocks emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_CLOCKS_H
+#define HW_MISC_RP2040_CLOCKS_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_CLOCKS "rp2040-clocks"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040ClocksState, RP2040_CLOCKS)
+
+#define RP2040_CLOCKS_BASE 0x40008000
+#define RP2040_CLOCKS_SIZE 0x4000
+
+struct RP2040ClocksState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk_ref;
+    Clock *clk_sys;
+    Clock *clk_peri;
+    Clock *clk_usb;
+    Clock *clk_adc;
+    Clock *clk_rtc;
+    Clock *pll_sys;
+    Clock *pll_usb;
+
+    uint32_t regs[0x100 / 4];
+};
+
+#endif
diff --git a/include/hw/misc/rp2040_pll.h b/include/hw/misc/rp2040_pll.h
new file mode 100644
index 0000000000..ad188aa46e
--- /dev/null
+++ b/include/hw/misc/rp2040_pll.h
@@ -0,0 +1,37 @@
+/*
+ * RP2040 PLL emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_PLL_H
+#define HW_MISC_RP2040_PLL_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_PLL "rp2040-pll"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040PllState, RP2040_PLL)
+
+#define RP2040_PLL_SYS_BASE 0x40028000
+#define RP2040_PLL_USB_BASE 0x4002c000
+#define RP2040_PLL_SIZE     0x4000
+
+struct RP2040PllState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    Clock *clk;
+
+    char *trace_name;
+    uint32_t base;
+    uint32_t fallback_hz;
+
+    uint32_t cs;
+    uint32_t pwr;
+    uint32_t fbdiv_int;
+    uint32_t prim;
+};
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 441f6f294a..416d90ae94 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -256,6 +256,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
+                                                       'rp2040-clocks-test',
                                                        'rp2040-rosc-test',
                                                        'rp2040-tbman-test',
                                                        'rp2040-vreg-test'] : []) + \
diff --git a/tests/qtest/rp2040-clocks-test.c b/tests/qtest/rp2040-clocks-test.c
new file mode 100644
index 0000000000..39e49eb57f
--- /dev/null
+++ b/tests/qtest/rp2040-clocks-test.c
@@ -0,0 +1,107 @@
+/*
+ * QTest testcase for the RP2040 clocks block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define CLOCKS_BASE             0x40008000
+#define CLK_SYS_CTRL            0x3c
+#define CLK_SYS_DIV             0x40
+#define CLK_PERI_CTRL           0x48
+#define CLK_PERI_DIV            0x4c
+#define CLK_USB_CTRL            0x54
+#define CLK_USB_DIV             0x58
+#define CLK_ADC_CTRL            0x60
+#define CLK_ADC_DIV             0x64
+#define CLK_RTC_CTRL            0x6c
+#define CLK_RTC_DIV             0x70
+#define FC0_SRC                 0x94
+#define FC0_STATUS              0x98
+#define FC0_RESULT              0x9c
+
+#define PLL_SYS_BASE            0x40028000
+#define PLL_USB_BASE            0x4002c000
+#define PLL_CS                  0x00
+#define PLL_PWR                 0x04
+#define PLL_FBDIV_INT           0x08
+#define PLL_PRIM                0x0c
+
+#define PLL_PWR_BITS            (BIT(5) | BIT(3) | BIT(2) | BIT(0))
+#define CLK_CTRL_ENABLE         BIT(11)
+#define FC0_STATUS_DONE         BIT(4)
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void pll_configure(QTestState *qts, uint32_t base,
+                          uint32_t fbdiv, uint32_t postdiv1,
+                          uint32_t postdiv2)
+{
+    qtest_writel(qts, base + PLL_CS, 1);
+    qtest_writel(qts, base + PLL_FBDIV_INT, fbdiv);
+    qtest_writel(qts, base + PLL_PWR, 0);
+    qtest_writel(qts, base + PLL_PRIM, (postdiv1 << 16) | (postdiv2 << 12));
+}
+
+static uint32_t frequency_count_khz(QTestState *qts, uint32_t src)
+{
+    qtest_writel(qts, CLOCKS_BASE + FC0_SRC, src);
+    g_assert_cmphex(qtest_readl(qts, CLOCKS_BASE + FC0_STATUS) &
+                    FC0_STATUS_DONE, ==, FC0_STATUS_DONE);
+    return qtest_readl(qts, CLOCKS_BASE + FC0_RESULT) >> 5;
+}
+
+static void test_clock_mux_and_frequency_counter(void)
+{
+    QTestState *qts = rp2040_start();
+
+    pll_configure(qts, PLL_SYS_BASE, 125, 6, 2);
+    pll_configure(qts, PLL_USB_BASE, 100, 5, 5);
+
+    qtest_writel(qts, CLOCKS_BASE + CLK_SYS_DIV, 0x100);
+    qtest_writel(qts, CLOCKS_BASE + CLK_PERI_DIV, 0x100);
+    qtest_writel(qts, CLOCKS_BASE + CLK_USB_DIV, 0x100);
+    qtest_writel(qts, CLOCKS_BASE + CLK_ADC_DIV, 0x100);
+    qtest_writel(qts, CLOCKS_BASE + CLK_RTC_DIV, 0x400);
+
+    qtest_writel(qts, CLOCKS_BASE + CLK_SYS_CTRL, BIT(0));
+    qtest_writel(qts, CLOCKS_BASE + CLK_PERI_CTRL, CLK_CTRL_ENABLE);
+    qtest_writel(qts, CLOCKS_BASE + CLK_USB_CTRL, CLK_CTRL_ENABLE);
+    qtest_writel(qts, CLOCKS_BASE + CLK_ADC_CTRL, CLK_CTRL_ENABLE);
+    qtest_writel(qts, CLOCKS_BASE + CLK_RTC_CTRL,
+                 CLK_CTRL_ENABLE | (0x3 << 5));
+
+    g_assert_cmpuint(frequency_count_khz(qts, 0x01), ==, 125000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x02), ==, 48000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x03), ==, 6000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x09), ==, 125000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x0a), ==, 125000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x0b), ==, 48000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x0c), ==, 48000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x0d), ==, 3000);
+
+    qtest_writel(qts, CLOCKS_BASE + CLK_SYS_CTRL, BIT(0) | (0x1 << 5));
+    qtest_writel(qts, PLL_SYS_BASE + PLL_PWR, PLL_PWR_BITS);
+
+    g_assert_cmpuint(frequency_count_khz(qts, 0x01), ==, 0);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x09), ==, 48000);
+    g_assert_cmpuint(frequency_count_khz(qts, 0x0a), ==, 48000);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-clocks/mux-and-frequency-counter",
+                   test_clock_mux_and_frequency_counter);
+
+    return g_test_run();
+}
-- 
2.55.0


