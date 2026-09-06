Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC857C79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 19:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Inq-0002Zu-Ku; Sun, 06 Sep 2026 15:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Ino-0002Z9-Rw; Sun, 06 Sep 2026 15:45:20 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x3Ink-0007BU-Ss; Sun, 06 Sep 2026 15:45:20 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hdLJD2wMFzBqZ1;
 Sun,  6 Sep 2026 21:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788723884;
 bh=29F3BJe+BUrkrGDoJ2UMuDZnEQYUs2f/Ah0yCulhM7s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dEBrAzEqDHpB3fpxljbw8LkpfnY6X7Kl3LhA5nXT5r+MAFFPIWc8GSOLjzesP9KUj
 /lK+DXMjvIhb8Xx8VPXkhqc4HSiCpScXuFLweWgX0UWHwLcAaTYkD2cWJhWirphDnc
 8+9qI3eBD9VqeUaGeP/T+PToXFYoZtYUZ0KfMuAyvpuNbgL5ws+K5JsMj9qNW/GFgR
 JyQM2Vz/+4M+VGzMMzE7JEeQJcbh+ruqPocL4Id1Vo9AnXnZ0ugJReWUOA0RPPeAll
 w+2WryrP19XBGPcuyavIaDCVPM80zFt/VT3Tikl3LDRl/kwDkpjO/hBzfAtJ4NXyiH
 QvY/NDaUsqFTA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hdLJD0mYVz7tc2;
 Sun,  6 Sep 2026 21:44:44 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 14/36] hw/misc: add RP2040 PLL and clock controller
Date: Sun,  6 Sep 2026 21:44:13 +0200
Message-ID: <20260906194438.93046-15-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
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

Model the RP2040 system and USB PLL register blocks and their clock
outputs. Add the clock mux, divider, selected-source and frequency-counter
registers, then route clk-sys to the Cortex-M0+ and clk-peri to both UARTs.
Include focused qtests for PLL configuration, clock switching and frequency
measurement.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c                  |  45 +++-
 hw/misc/meson.build              |   2 +
 hw/misc/rp2040_clocks.c          | 422 +++++++++++++++++++++++++++++++
 hw/misc/rp2040_pll.c             | 198 +++++++++++++++
 include/hw/arm/rp2040.h          |   5 +
 include/hw/misc/rp2040_clocks.h  |  79 ++++++
 include/hw/misc/rp2040_pll.h     |  60 +++++
 tests/qtest/meson.build          |   1 +
 tests/qtest/rp2040-clocks-test.c | 105 ++++++++
 9 files changed, 910 insertions(+), 7 deletions(-)
 create mode 100644 hw/misc/rp2040_clocks.c
 create mode 100644 hw/misc/rp2040_pll.c
 create mode 100644 include/hw/misc/rp2040_clocks.h
 create mode 100644 include/hw/misc/rp2040_pll.h
 create mode 100644 tests/qtest/rp2040-clocks-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 7e836dd2b3..d30058c873 100644
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
@@ -139,6 +134,20 @@ static void rp2040_soc_init(Object *obj)
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
@@ -149,7 +158,6 @@ static void rp2040_soc_init(Object *obj)
     s->irq = qemu_allocate_irqs(rp2040_set_irq, s, RP2040_NUM_IRQS);
 
     s->sysclk = clock_new(obj, "sysclk");
-    clock_set_hz(s->sysclk, RP2040_SYSCLK_FRQ);
 }
 
 static bool rp2040_init_memory(RP2040State *s, Error **errp)
@@ -235,6 +243,27 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
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
     for (i = 0; i < RP2040_NUM_CORES; i++) {
         g_autofree char *memory_name =
             g_strdup_printf("rp2040.proc%d-memory", i);
@@ -299,7 +328,9 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->xosc), 0, RP2040_XOSC_BASE);
 
     for (i = 0; i < ARRAY_SIZE(s->uart); i++) {
-        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk", s->sysclk);
+        qdev_connect_clock_in(DEVICE(&s->uart[i]), "clk",
+                              qdev_get_clock_out(DEVICE(&s->clocks),
+                                                 "clk-peri"));
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
             return;
         }
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index aa10271e18..f668574a64 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -98,6 +98,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
 ))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_clocks.c'))
+system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_pll.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_rosc.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_syscfg.c'))
 system_ss.add(when: 'CONFIG_RP2040', if_true: files('rp2040_sysinfo.c'))
diff --git a/hw/misc/rp2040_clocks.c b/hw/misc/rp2040_clocks.c
new file mode 100644
index 0000000000..127e588058
--- /dev/null
+++ b/hw/misc/rp2040_clocks.c
@@ -0,0 +1,422 @@
+/*
+ * RP2040 clocks emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/misc/rp2040.h"
+#include "hw/misc/rp2040_clocks.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define ROSC_HZ     6000000
+#define XOSC_HZ     12000000
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
+    uint32_t ctrl = s->regs[A_CLK_REF_CTRL / 4];
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
+    return freq / rp2040_clocks_div(s->regs[A_CLK_REF_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_sys_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[A_CLK_SYS_CTRL / 4];
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
+    return freq / rp2040_clocks_div(s->regs[A_CLK_SYS_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_peri_freq(RP2040ClocksState *s)
+{
+    uint32_t ctrl = s->regs[A_CLK_PERI_CTRL / 4];
+
+    if (!(ctrl & R_CLK_PERI_CTRL_ENABLE_MASK)) {
+        return 0;
+    }
+
+    return rp2040_clocks_peri_aux_freq(s, rp2040_clocks_ctrl_auxsrc(ctrl)) /
+           rp2040_clocks_div(s->regs[A_CLK_PERI_DIV / 4]);
+}
+
+static unsigned rp2040_clocks_usb_adc_rtc_freq(RP2040ClocksState *s,
+                                               uint32_t ctrl_off,
+                                               uint32_t div_off)
+{
+    uint32_t ctrl = s->regs[ctrl_off / 4];
+
+    if (!(ctrl & R_CLK_PERI_CTRL_ENABLE_MASK)) {
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
+                    rp2040_clocks_usb_adc_rtc_freq(s, A_CLK_USB_CTRL,
+                                                   A_CLK_USB_DIV));
+    clock_update_hz(s->clk_adc,
+                    rp2040_clocks_usb_adc_rtc_freq(s, A_CLK_ADC_CTRL,
+                                                   A_CLK_ADC_DIV));
+    clock_update_hz(s->clk_rtc,
+                    rp2040_clocks_usb_adc_rtc_freq(s, A_CLK_RTC_CTRL,
+                                                   A_CLK_RTC_DIV));
+}
+
+static uint32_t rp2040_clocks_selected(RP2040ClocksState *s, hwaddr offset)
+{
+    switch (offset) {
+    case A_CLK_REF_SELECTED:
+        return 1u << extract32(s->regs[A_CLK_REF_CTRL / 4], 0, 2);
+    case A_CLK_SYS_SELECTED:
+        return 1u << extract32(s->regs[A_CLK_SYS_CTRL / 4], 0, 1);
+    case A_CLK_PERI_SELECTED:
+    case A_CLK_USB_SELECTED:
+    case A_CLK_ADC_SELECTED:
+    case A_CLK_RTC_SELECTED:
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
+    switch (s->regs[A_FC0_SRC / 4] & 0xff) {
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
+    return offset == A_CLK_REF_SELECTED ||
+           offset == A_CLK_SYS_SELECTED ||
+           offset == A_CLK_PERI_SELECTED ||
+           offset == A_CLK_USB_SELECTED ||
+           offset == A_CLK_ADC_SELECTED ||
+           offset == A_CLK_RTC_SELECTED;
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
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
+    } else if (rp2040_clocks_is_selected(offset)) {
+        value = rp2040_clocks_selected(s, offset);
+    } else {
+        switch (offset) {
+        case A_FC0_STATUS:
+            value = BIT(4);
+            break;
+        case A_FC0_RESULT:
+            value = rp2040_clocks_fc0_result(s);
+            break;
+        case A_ENABLED0:
+        case A_ENABLED1:
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
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t old;
+    uint32_t newval = value;
+
+    if (offset < sizeof(s->regs) && !rp2040_clocks_is_selected(offset)) {
+        old = s->regs[offset / 4];
+        newval = rp2040_atomic_update(old, value, alias);
+
+        switch (offset) {
+        case A_ENABLED0:
+        case A_ENABLED1:
+        case A_FC0_STATUS:
+        case A_FC0_RESULT:
+        case A_CLOCKS_INTR:
+            break;
+        default:
+            s->regs[offset / 4] = newval;
+            rp2040_clocks_update(s);
+            break;
+        }
+    } else if (offset >= sizeof(s->regs)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    s->regs[A_CLK_REF_DIV / 4] = RP2040_CLOCKS_DIV_RESET;
+    s->regs[A_CLK_SYS_DIV / 4] = RP2040_CLOCKS_DIV_RESET;
+    s->regs[A_CLK_PERI_DIV / 4] = RP2040_CLOCKS_DIV_RESET;
+    s->regs[A_CLK_USB_DIV / 4] = RP2040_CLOCKS_DIV_RESET;
+    s->regs[A_CLK_ADC_DIV / 4] = RP2040_CLOCKS_DIV_RESET;
+    s->regs[A_CLK_RTC_DIV / 4] = RP2040_CLOCKS_DIV_RESET;
+    s->regs[A_FC0_REF_KHZ / 4] = XOSC_HZ / 1000;
+    s->regs[A_WAKE_EN0 / 4] = 0xffffffff;
+    s->regs[A_WAKE_EN1 / 4] = 0xffffffff;
+    s->regs[A_SLEEP_EN0 / 4] = 0xffffffff;
+    s->regs[A_SLEEP_EN1 / 4] = 0xffffffff;
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
index 0000000000..390a6cb34d
--- /dev/null
+++ b/hw/misc/rp2040_pll.c
@@ -0,0 +1,198 @@
+/*
+ * RP2040 PLL emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/rp2040.h"
+#include "hw/misc/rp2040_pll.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define XOSC_HZ             12000000
+
+static bool rp2040_pll_locked(RP2040PllState *s)
+{
+    return !(s->pwr & (R_PLL_PWR_PD_MASK | R_PLL_PWR_VCOPD_MASK));
+}
+
+static unsigned rp2040_pll_output_hz(RP2040PllState *s)
+{
+    uint32_t refdiv = s->cs & R_PLL_CS_REFDIV_MASK;
+    uint32_t fbdiv = s->fbdiv_int & R_PLL_FBDIV_INT_FBDIV_INT_MASK;
+    uint32_t postdiv1 = extract32(s->prim, R_PLL_PRIM_POSTDIV1_SHIFT,
+                                  R_PLL_PRIM_POSTDIV1_LENGTH);
+    uint32_t postdiv2 = extract32(s->prim, R_PLL_PRIM_POSTDIV2_SHIFT,
+                                  R_PLL_PRIM_POSTDIV1_LENGTH);
+    uint64_t hz;
+
+    if (!rp2040_pll_locked(s) || (s->pwr & R_PLL_PWR_POSTDIVPD_MASK)) {
+        return 0;
+    }
+
+    refdiv = refdiv ? refdiv : 1;
+    if (s->cs & R_PLL_CS_BYPASS_MASK) {
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
+    uint64_t value;
+
+    switch (offset) {
+    case A_PLL_CS:
+        value = s->cs & ~R_PLL_CS_LOCK_MASK;
+        if (rp2040_pll_locked(s)) {
+            value |= R_PLL_CS_LOCK_MASK;
+        }
+        break;
+    case A_PLL_PWR:
+        value = s->pwr;
+        break;
+    case A_PLL_FBDIV_INT:
+        value = s->fbdiv_int;
+        break;
+    case A_PLL_PRIM:
+        value = s->prim;
+        break;
+    default:
+        value = 0;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented read at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    hwaddr alias = addr & RP2040_ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+
+    switch (offset) {
+    case A_PLL_CS:
+        s->cs = rp2040_atomic_update(s->cs, value, alias) &
+                (R_PLL_CS_BYPASS_MASK | R_PLL_CS_REFDIV_MASK);
+        break;
+    case A_PLL_PWR:
+        s->pwr = rp2040_atomic_update(s->pwr, value, alias) &
+                 RP2040_PLL_PWR_MASK;
+        break;
+    case A_PLL_FBDIV_INT:
+        s->fbdiv_int = rp2040_atomic_update(s->fbdiv_int, value, alias) &
+                       R_PLL_FBDIV_INT_FBDIV_INT_MASK;
+        break;
+    case A_PLL_PRIM:
+        s->prim = rp2040_atomic_update(s->prim, value, alias) &
+                  (R_PLL_PRIM_POSTDIV1_MASK | R_PLL_PRIM_POSTDIV2_MASK);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: unimplemented write at offset 0x%"
+                      HWADDR_PRIx "\n", __func__, addr & 0xfff);
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
+    s->pwr = RP2040_PLL_PWR_MASK;
+    s->fbdiv_int = 0;
+    s->prim = RP2040_PLL_PRIM_RESET;
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
index d27f37b1d2..2f569a07b2 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -13,6 +13,8 @@
 #include "hw/char/pl011.h"
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
+#include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_pll.h"
 #include "hw/misc/rp2040_rosc.h"
 #include "hw/misc/rp2040_sysinfo.h"
 #include "hw/misc/rp2040_syscfg.h"
@@ -41,6 +43,9 @@ struct RP2040State {
 
     ARMv7MState armv7m[RP2040_NUM_CORES];
     PL011State uart[2];
+    RP2040ClocksState clocks;
+    RP2040PllState pll_sys;
+    RP2040PllState pll_usb;
     RP2040SysCfgState syscfg;
     RP2040SysInfoState sysinfo;
     RP2040RoscState rosc;
diff --git a/include/hw/misc/rp2040_clocks.h b/include/hw/misc/rp2040_clocks.h
new file mode 100644
index 0000000000..ffb73f2927
--- /dev/null
+++ b/include/hw/misc/rp2040_clocks.h
@@ -0,0 +1,79 @@
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
+#include "hw/core/registerfields.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_CLOCKS "rp2040-clocks"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040ClocksState, RP2040_CLOCKS)
+
+#define RP2040_CLOCKS_BASE 0x40008000
+#define RP2040_CLOCKS_SIZE 0x4000
+
+REG32(CLK_GPOUT0_CTRL, 0x00)
+REG32(CLK_REF_CTRL, 0x30)
+REG32(CLK_REF_DIV, 0x34)
+REG32(CLK_REF_SELECTED, 0x38)
+REG32(CLK_SYS_CTRL, 0x3c)
+REG32(CLK_SYS_DIV, 0x40)
+REG32(CLK_SYS_SELECTED, 0x44)
+REG32(CLK_PERI_CTRL, 0x48)
+    FIELD(CLK_PERI_CTRL, ENABLE, 11, 1)
+REG32(CLK_PERI_DIV, 0x4c)
+REG32(CLK_PERI_SELECTED, 0x50)
+REG32(CLK_USB_CTRL, 0x54)
+    FIELD(CLK_USB_CTRL, ENABLE, 11, 1)
+REG32(CLK_USB_DIV, 0x58)
+REG32(CLK_USB_SELECTED, 0x5c)
+REG32(CLK_ADC_CTRL, 0x60)
+    FIELD(CLK_ADC_CTRL, ENABLE, 11, 1)
+REG32(CLK_ADC_DIV, 0x64)
+REG32(CLK_ADC_SELECTED, 0x68)
+REG32(CLK_RTC_CTRL, 0x6c)
+    FIELD(CLK_RTC_CTRL, ENABLE, 11, 1)
+REG32(CLK_RTC_DIV, 0x70)
+REG32(CLK_RTC_SELECTED, 0x74)
+REG32(FC0_REF_KHZ, 0x80)
+REG32(FC0_MIN_KHZ, 0x84)
+REG32(FC0_MAX_KHZ, 0x88)
+REG32(FC0_DELAY, 0x8c)
+REG32(FC0_INTERVAL, 0x90)
+REG32(FC0_SRC, 0x94)
+REG32(FC0_STATUS, 0x98)
+    FIELD(FC0_STATUS, DONE, 4, 1)
+REG32(FC0_RESULT, 0x9c)
+REG32(WAKE_EN0, 0xa0)
+REG32(WAKE_EN1, 0xa4)
+REG32(SLEEP_EN0, 0xa8)
+REG32(SLEEP_EN1, 0xac)
+REG32(ENABLED0, 0xb0)
+REG32(ENABLED1, 0xb4)
+REG32(CLOCKS_INTR, 0xb8)
+
+#define RP2040_CLOCKS_DIV_RESET 0x00000100
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
index 0000000000..e8e1e33235
--- /dev/null
+++ b/include/hw/misc/rp2040_pll.h
@@ -0,0 +1,60 @@
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
+#include "hw/core/registerfields.h"
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
+REG32(PLL_CS, 0x00)
+    FIELD(PLL_CS, LOCK, 31, 1)
+    FIELD(PLL_CS, BYPASS, 8, 1)
+    FIELD(PLL_CS, REFDIV, 0, 6)
+REG32(PLL_PWR, 0x04)
+    FIELD(PLL_PWR, VCOPD, 5, 1)
+    FIELD(PLL_PWR, POSTDIVPD, 3, 1)
+    FIELD(PLL_PWR, DSMPD, 2, 1)
+    FIELD(PLL_PWR, PD, 0, 1)
+REG32(PLL_FBDIV_INT, 0x08)
+    FIELD(PLL_FBDIV_INT, FBDIV_INT, 0, 12)
+REG32(PLL_PRIM, 0x0c)
+    FIELD(PLL_PRIM, POSTDIV1, 16, 3)
+    FIELD(PLL_PRIM, POSTDIV2, 12, 3)
+
+#define RP2040_PLL_PWR_MASK \
+    (R_PLL_PWR_VCOPD_MASK | R_PLL_PWR_POSTDIVPD_MASK | \
+     R_PLL_PWR_DSMPD_MASK | R_PLL_PWR_PD_MASK)
+#define RP2040_PLL_PRIM_RESET \
+    ((7 << R_PLL_PRIM_POSTDIV1_SHIFT) | \
+     (7 << R_PLL_PRIM_POSTDIV2_SHIFT))
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
index ad206df8c6..d5736a6b56 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -265,6 +265,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_RP2040') ?
    ['rp2040-syscfg-test',
     'rp2040-sysinfo-test',
+     'rp2040-clocks-test',
      'rp2040-rosc-test',
     'rp2040-tbman-test',
     'rp2040-vreg-test'] : []) + \
diff --git a/tests/qtest/rp2040-clocks-test.c b/tests/qtest/rp2040-clocks-test.c
new file mode 100644
index 0000000000..9768259561
--- /dev/null
+++ b/tests/qtest/rp2040-clocks-test.c
@@ -0,0 +1,105 @@
+/*
+ * QTest testcase for the RP2040 clocks block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_pll.h"
+#include "qemu/bitops.h"
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
+    qtest_writel(qts, base + A_PLL_CS, 1);
+    qtest_writel(qts, base + A_PLL_FBDIV_INT, fbdiv);
+    qtest_writel(qts, base + A_PLL_PWR, 0);
+    qtest_writel(qts, base + A_PLL_PRIM,
+                 (postdiv1 << R_PLL_PRIM_POSTDIV1_SHIFT) |
+                 (postdiv2 << R_PLL_PRIM_POSTDIV2_SHIFT));
+}
+
+static uint32_t frequency_count_khz(QTestState *qts, uint32_t src)
+{
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_FC0_SRC, src);
+    g_assert_cmphex(qtest_readl(qts, RP2040_CLOCKS_BASE + A_FC0_STATUS) &
+                    R_FC0_STATUS_DONE_MASK, ==, R_FC0_STATUS_DONE_MASK);
+    return qtest_readl(qts, RP2040_CLOCKS_BASE + A_FC0_RESULT) >> 5;
+}
+
+static void test_clock_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, RP2040_CLOCKS_BASE +
+                                A_CLK_PERI_CTRL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RP2040_CLOCKS_BASE +
+                                A_CLK_USB_CTRL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RP2040_CLOCKS_BASE +
+                                A_CLK_ADC_CTRL), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, RP2040_CLOCKS_BASE +
+                                A_CLK_RTC_CTRL), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_clock_mux_and_frequency_counter(void)
+{
+    QTestState *qts = rp2040_start();
+
+    pll_configure(qts, RP2040_PLL_SYS_BASE, 125, 6, 2);
+    pll_configure(qts, RP2040_PLL_USB_BASE, 100, 5, 5);
+
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_SYS_DIV, 0x100);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_PERI_DIV, 0x100);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_USB_DIV, 0x100);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_ADC_DIV, 0x100);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_RTC_DIV, 0x400);
+
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_SYS_CTRL, BIT(0));
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_PERI_CTRL,
+                 R_CLK_PERI_CTRL_ENABLE_MASK);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_USB_CTRL,
+                 R_CLK_USB_CTRL_ENABLE_MASK);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_ADC_CTRL,
+                 R_CLK_ADC_CTRL_ENABLE_MASK);
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_RTC_CTRL,
+                 R_CLK_RTC_CTRL_ENABLE_MASK | (0x3 << 5));
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
+    qtest_writel(qts, RP2040_CLOCKS_BASE + A_CLK_SYS_CTRL, BIT(0) | (0x1 << 5));
+    qtest_writel(qts, RP2040_PLL_SYS_BASE + A_PLL_PWR, RP2040_PLL_PWR_MASK);
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
+    qtest_add_func("/rp2040-clocks/reset-values", test_clock_reset_values);
+    qtest_add_func("/rp2040-clocks/mux-and-frequency-counter",
+                   test_clock_mux_and_frequency_counter);
+
+    return g_test_run();
+}
-- 
2.55.0


