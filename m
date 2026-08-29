Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625FC61DDE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 23:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Sip-0008Di-Tc; Sat, 29 Aug 2026 19:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Sin-0008Cl-2A; Sat, 29 Aug 2026 19:44:25 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Sij-0006Gr-1q; Sat, 29 Aug 2026 19:44:24 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hXWzg1SvczBqYL;
 Sun, 30 Aug 2026 01:43:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788047023;
 bh=UA53Dbe2MvOAJunleR0nfdNUztIkzhmGrz1Uzr5I+Ik=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q96cib9e+Vc9becDCtbDZuTn71RewHeKocdfQMxxLXu4HMY8WgvSwcAhXtKpoAKm8
 CWAh3kAWQpO0qDpr0RojMClqw/ch9SdfFLuQYMQGewy8bab3e5grPeKSN/bSB2rEFH
 jy9mFrkYMwfnppSadrB/k/NMjJqIRN2MLhcYYlqsTevBo3vUx7kp5Bx/3yf8BQ3+va
 CB3ToOshGZ5kBxAWIPWBUpzKGvON30zwKAeSrd6x+FDHRSMOJSRpHvTUspAXDNblRg
 9iGAoffNW7+NmbL6rbge3N3674Hr4Vpp/QQ5ruGM6ibyIkGG3C5da0Iz71P9SiBl8K
 fWBgZhuhbjf9g==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXWzf6Qz0z7vrV;
 Sun, 30 Aug 2026 01:43:42 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, qemu-arm@nongnu.org,
 gilles grimaud <gilles.grimaud@univ-lille.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH RFC v2 13/30] hw/misc: add RP2040 IO_BANK0
Date: Sun, 30 Aug 2026 01:42:47 +0200
Message-ID: <20260829234308.33725-14-gilles.grimaud@univ-lille.fr>
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

Model GPIO control registers and the PROC0, PROC1 and dormant-wake interrupt banks, including atomic aliases and last-bank masks. Connect the PROC0 interrupt output to the Cortex-M0+ NVIC and add focused qtests for register behavior and interrupt propagation.

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/Kconfig                    |   1 +
 hw/arm/rp2040.c                   |  11 +-
 hw/misc/Kconfig                   |   3 +
 hw/misc/meson.build               |   1 +
 hw/misc/rp2040_iobank0.c          | 353 ++++++++++++++++++++++++++++++
 include/hw/arm/rp2040.h           |   2 +
 include/hw/misc/rp2040_iobank0.h  |  45 ++++
 tests/qtest/meson.build           |   1 +
 tests/qtest/rp2040-iobank0-test.c | 122 +++++++++++
 9 files changed, 538 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/rp2040_iobank0.c
 create mode 100644 include/hw/misc/rp2040_iobank0.h
 create mode 100644 tests/qtest/rp2040-iobank0-test.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0c455fe5ce..7e3d23e81c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -379,6 +379,7 @@ config RP2040
     select ARM_V7M
     select PL011
     select RP2040_CLOCKS
+    select RP2040_IOBANK0
     select RP2040_NYI
     select RP2040_PADS
     select RP2040_PLL
diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index 894f5ec3c2..4cceec863e 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -22,6 +22,7 @@
 #define RP2040_UART0_IRQ  20
 #define RP2040_UART1_BASE 0x40038000
 #define RP2040_UART1_IRQ  21
+#define RP2040_IO_IRQ_BANK0 13
 
 /*
  * Temporary boot ROM used until the synthetic ROM is introduced. It loads
@@ -48,7 +49,6 @@ static const struct {
     hwaddr base;
     hwaddr size;
 } rp2040_unimplemented[] = {
-    { "rp2040.iobank0",  0x40014000, 0x4000 },
     { "rp2040.ioqspi",   0x40018000, 0x4000 },
     { "rp2040.busctrl",  0x40030000, 0x4000 },
     { "rp2040.uart0_aliases", 0x40035000, 0x3000 },
@@ -164,6 +164,8 @@ static void rp2040_soc_init(Object *obj)
     }
 
     object_initialize_child(obj, "clocks", &s->clocks, TYPE_RP2040_CLOCKS);
+    object_initialize_child(obj, "iobank0", &s->iobank0,
+                            TYPE_RP2040_IOBANK0);
     object_initialize_child(obj, "pads-bank0", &s->pads_bank0,
                             TYPE_RP2040_PADS_BANK0);
     object_initialize_child(obj, "pads-qspi", &s->pads_qspi,
@@ -367,6 +369,13 @@ static void rp2040_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, RP2040_SYSINFO_BASE);
     rp2040_syscfg_update(s);
 
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->iobank0), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->iobank0), 0, RP2040_IOBANK0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->iobank0), 0,
+                       s->irq[RP2040_IO_IRQ_BANK0]);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->rosc), errp)) {
         return;
     }
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fc1d5bd58b..daf513766c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -104,6 +104,9 @@ config FSL_IMX8MP_CCM
 config RP2040_CLOCKS
     bool
 
+config RP2040_IOBANK0
+    bool
+
 config RP2040_NYI
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a60226c073..e84cbd735f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -99,6 +99,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_powermgt.c',
 ))
 system_ss.add(when: 'CONFIG_RP2040_CLOCKS', if_true: files('rp2040_clocks.c'))
+system_ss.add(when: 'CONFIG_RP2040_IOBANK0', if_true: files('rp2040_iobank0.c'))
 system_ss.add(when: 'CONFIG_RP2040_NYI', if_true: files('rp2040_nyi.c'))
 system_ss.add(when: 'CONFIG_RP2040_PADS', if_true: files('rp2040_pads.c'))
 system_ss.add(when: 'CONFIG_RP2040_PLL', if_true: files('rp2040_pll.c'))
diff --git a/hw/misc/rp2040_iobank0.c b/hw/misc/rp2040_iobank0.c
new file mode 100644
index 0000000000..60462298da
--- /dev/null
+++ b/hw/misc/rp2040_iobank0.c
@@ -0,0 +1,353 @@
+/*
+ * RP2040 GPIO IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/misc/rp2040_iobank0.h"
+#include "hw/misc/rp2040_nyi.h"
+#include "hw/core/irq.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+#define IOBANK0_GPIO_STRIDE         0x8
+#define IOBANK0_GPIO_STATUS         0x0
+#define IOBANK0_GPIO_CTRL           0x4
+
+#define IOBANK0_INTR                0x0f0
+#define IOBANK0_PROC0_INTE          0x100
+#define IOBANK0_PROC0_INTF          0x110
+#define IOBANK0_PROC0_INTS          0x120
+#define IOBANK0_PROC1_INTE          0x130
+#define IOBANK0_PROC1_INTF          0x140
+#define IOBANK0_PROC1_INTS          0x150
+#define IOBANK0_DORMANT_INTE        0x160
+#define IOBANK0_DORMANT_INTF        0x170
+#define IOBANK0_DORMANT_INTS        0x180
+
+#define IOBANK0_CTRL_RESET          0x1f
+#define IOBANK0_CTRL_RW_MASK        0x33333f
+#define IOBANK0_CTRL_FUNCSEL_MASK   0x1f
+#define IOBANK0_FUNCSEL_UART        2
+#define IOBANK0_INTR_EDGE_MASK      0xcccccccc
+#define IOBANK0_INTR_LAST_EDGE_MASK 0x00cccccc
+#define IOBANK0_IRQ_MASK            0xffffffff
+#define IOBANK0_IRQ_LAST_MASK       0x00ffffff
+
+#define ATOMIC_ALIAS_MASK           0x3000
+#define ATOMIC_XOR                  0x1000
+#define ATOMIC_SET                  0x2000
+#define ATOMIC_CLR                  0x3000
+
+static uint32_t rp2040_iobank0_apply_alias(uint32_t old, uint32_t value,
+                                           hwaddr alias)
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
+static bool rp2040_iobank0_gpio_offset(hwaddr offset, unsigned *gpio,
+                                       unsigned *reg)
+{
+    if (offset >= RP2040_IOBANK0_NUM_GPIOS * IOBANK0_GPIO_STRIDE) {
+        return false;
+    }
+
+    *gpio = offset / IOBANK0_GPIO_STRIDE;
+    *reg = offset & (IOBANK0_GPIO_STRIDE - 1);
+    return *reg == IOBANK0_GPIO_STATUS || *reg == IOBANK0_GPIO_CTRL;
+}
+
+static bool rp2040_iobank0_bank_offset(hwaddr offset, hwaddr base,
+                                       unsigned *bank)
+{
+    if (offset < base || offset >= base + RP2040_IOBANK0_IRQ_BANKS * 4 ||
+        (offset & 0x3)) {
+        return false;
+    }
+
+    *bank = (offset - base) / 4;
+    return true;
+}
+
+static uint32_t rp2040_iobank0_irq_mask(unsigned bank)
+{
+    return bank == 3 ? IOBANK0_IRQ_LAST_MASK : IOBANK0_IRQ_MASK;
+}
+
+static uint32_t rp2040_iobank0_intr_edge_mask(unsigned bank)
+{
+    return bank == 3 ? IOBANK0_INTR_LAST_EDGE_MASK : IOBANK0_INTR_EDGE_MASK;
+}
+
+static uint32_t rp2040_iobank0_ints(uint32_t intr, uint32_t inte,
+                                    uint32_t intf)
+{
+    return (intr & inte) | intf;
+}
+
+static bool rp2040_iobank0_gpio_is_uart(RP2040IoBank0State *s, unsigned gpio)
+{
+    return (s->ctrl[gpio] & IOBANK0_CTRL_FUNCSEL_MASK) == IOBANK0_FUNCSEL_UART;
+}
+
+bool rp2040_iobank0_uart0_tx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 0);
+}
+
+bool rp2040_iobank0_uart0_rx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 1);
+}
+
+bool rp2040_iobank0_uart1_tx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 4);
+}
+
+bool rp2040_iobank0_uart1_rx_enabled(RP2040IoBank0State *s)
+{
+    return rp2040_iobank0_gpio_is_uart(s, 5);
+}
+
+static void rp2040_iobank0_update_uart_pins(RP2040IoBank0State *s)
+{
+    qemu_set_irq(s->uart0_pin[0], rp2040_iobank0_uart0_tx_enabled(s));
+    qemu_set_irq(s->uart0_pin[1], rp2040_iobank0_uart0_rx_enabled(s));
+    qemu_set_irq(s->uart1_pin[0], rp2040_iobank0_uart1_tx_enabled(s));
+    qemu_set_irq(s->uart1_pin[1], rp2040_iobank0_uart1_rx_enabled(s));
+}
+
+static void rp2040_iobank0_update_irq(RP2040IoBank0State *s)
+{
+    bool proc0_level = false;
+    bool proc1_level = false;
+    int i;
+
+    for (i = 0; i < RP2040_IOBANK0_IRQ_BANKS; i++) {
+        proc0_level |= rp2040_iobank0_ints(s->intr[i], s->proc0_inte[i],
+                                           s->proc0_intf[i]) != 0;
+        proc1_level |= rp2040_iobank0_ints(s->intr[i], s->proc1_inte[i],
+                                           s->proc1_intf[i]) != 0;
+    }
+
+    qemu_set_irq(s->proc0_irq, proc0_level);
+    qemu_set_irq(s->proc1_irq, proc1_level);
+}
+
+static uint64_t rp2040_iobank0_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RP2040IoBank0State *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    unsigned gpio;
+    unsigned reg;
+    unsigned bank;
+    uint64_t value;
+
+    if (rp2040_iobank0_gpio_offset(offset, &gpio, &reg)) {
+        value = reg == IOBANK0_GPIO_STATUS ? 0 : s->ctrl[gpio];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_INTR, &bank)) {
+        value = s->intr[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTE, &bank)) {
+        value = s->proc0_inte[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTF, &bank)) {
+        value = s->proc0_intf[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTS, &bank)) {
+        value = rp2040_iobank0_ints(s->intr[bank], s->proc0_inte[bank],
+                                    s->proc0_intf[bank]);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTE, &bank)) {
+        value = s->proc1_inte[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTF, &bank)) {
+        value = s->proc1_intf[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTS, &bank)) {
+        value = rp2040_iobank0_ints(s->intr[bank], s->proc1_inte[bank],
+                                    s->proc1_intf[bank]);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTE,
+                                          &bank)) {
+        value = s->dormant_wake_inte[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTF,
+                                          &bank)) {
+        value = s->dormant_wake_intf[bank];
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTS,
+                                          &bank)) {
+        value = rp2040_iobank0_ints(s->intr[bank],
+                                    s->dormant_wake_inte[bank],
+                                    s->dormant_wake_intf[bank]);
+    } else {
+        value = 0;
+        rp2040_log_unimplemented_read("iobank0", size,
+                                      RP2040_IOBANK0_BASE + addr, offset,
+                                      value);
+    }
+
+    return value;
+}
+
+static void rp2040_iobank0_write_irq_reg(uint32_t *reg, uint64_t value64,
+                                         hwaddr alias, unsigned bank)
+{
+    *reg = rp2040_iobank0_apply_alias(*reg, value64, alias) &
+           rp2040_iobank0_irq_mask(bank);
+}
+
+static void rp2040_iobank0_write(void *opaque, hwaddr addr, uint64_t value64,
+                                 unsigned size)
+{
+    RP2040IoBank0State *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    unsigned gpio;
+    unsigned reg;
+    unsigned bank;
+    uint32_t value = value64;
+
+    if (rp2040_iobank0_gpio_offset(offset, &gpio, &reg)) {
+        if (reg == IOBANK0_GPIO_CTRL) {
+            s->ctrl[gpio] =
+                rp2040_iobank0_apply_alias(s->ctrl[gpio], value, alias) &
+                IOBANK0_CTRL_RW_MASK;
+            if (gpio <= 1 || gpio == 4 || gpio == 5) {
+                rp2040_iobank0_update_uart_pins(s);
+            }
+        }
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_INTR, &bank)) {
+        s->intr[bank] &= ~(value & rp2040_iobank0_intr_edge_mask(bank));
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTE, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc0_inte[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTF, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc0_intf[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTE, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc1_inte[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTF, &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->proc1_intf[bank], value, alias,
+                                     bank);
+        rp2040_iobank0_update_irq(s);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTE,
+                                          &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->dormant_wake_inte[bank], value,
+                                     alias, bank);
+    } else if (rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTF,
+                                          &bank)) {
+        rp2040_iobank0_write_irq_reg(&s->dormant_wake_intf[bank], value,
+                                     alias, bank);
+    } else if (!rp2040_iobank0_bank_offset(offset, IOBANK0_PROC0_INTS,
+                                           &bank) &&
+               !rp2040_iobank0_bank_offset(offset, IOBANK0_PROC1_INTS,
+                                           &bank) &&
+               !rp2040_iobank0_bank_offset(offset, IOBANK0_DORMANT_INTS,
+                                           &bank)) {
+        rp2040_log_unimplemented_write("iobank0", size,
+                                       RP2040_IOBANK0_BASE + addr, offset,
+                                       value64);
+    }
+}
+
+static const MemoryRegionOps rp2040_iobank0_ops = {
+    .read = rp2040_iobank0_read,
+    .write = rp2040_iobank0_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+static void rp2040_iobank0_reset(DeviceState *dev)
+{
+    RP2040IoBank0State *s = RP2040_IOBANK0(dev);
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->ctrl); i++) {
+        s->ctrl[i] = IOBANK0_CTRL_RESET;
+    }
+
+    memset(s->intr, 0, sizeof(s->intr));
+    memset(s->proc0_inte, 0, sizeof(s->proc0_inte));
+    memset(s->proc0_intf, 0, sizeof(s->proc0_intf));
+    memset(s->proc1_inte, 0, sizeof(s->proc1_inte));
+    memset(s->proc1_intf, 0, sizeof(s->proc1_intf));
+    memset(s->dormant_wake_inte, 0, sizeof(s->dormant_wake_inte));
+    memset(s->dormant_wake_intf, 0, sizeof(s->dormant_wake_intf));
+    rp2040_iobank0_update_irq(s);
+    rp2040_iobank0_update_uart_pins(s);
+}
+
+static void rp2040_iobank0_init(Object *obj)
+{
+    RP2040IoBank0State *s = RP2040_IOBANK0(obj);
+
+    memory_region_init_io(&s->iomem, obj, &rp2040_iobank0_ops, s,
+                          "rp2040.iobank0", RP2040_IOBANK0_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->proc0_irq);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->proc1_irq);
+    qdev_init_gpio_out_named(DEVICE(obj), s->uart0_pin, "uart0-pin",
+                             ARRAY_SIZE(s->uart0_pin));
+    qdev_init_gpio_out_named(DEVICE(obj), s->uart1_pin, "uart1-pin",
+                             ARRAY_SIZE(s->uart1_pin));
+}
+
+static const VMStateDescription rp2040_iobank0_vmstate = {
+    .name = TYPE_RP2040_IOBANK0,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(ctrl, RP2040IoBank0State,
+                             RP2040_IOBANK0_NUM_GPIOS),
+        VMSTATE_UINT32_ARRAY(intr, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc0_inte, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc0_intf, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc1_inte, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(proc1_intf, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(dormant_wake_inte, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_UINT32_ARRAY(dormant_wake_intf, RP2040IoBank0State,
+                             RP2040_IOBANK0_IRQ_BANKS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp2040_iobank0_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, rp2040_iobank0_reset);
+    dc->vmsd = &rp2040_iobank0_vmstate;
+}
+
+static const TypeInfo rp2040_iobank0_info = {
+    .name          = TYPE_RP2040_IOBANK0,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RP2040IoBank0State),
+    .instance_init = rp2040_iobank0_init,
+    .class_init    = rp2040_iobank0_class_init,
+};
+
+static void rp2040_iobank0_register_types(void)
+{
+    type_register_static(&rp2040_iobank0_info);
+}
+type_init(rp2040_iobank0_register_types)
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index 033fc17ffc..1ed6fa1449 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -14,6 +14,7 @@
 #include "hw/core/clock.h"
 #include "hw/core/sysbus.h"
 #include "hw/misc/rp2040_clocks.h"
+#include "hw/misc/rp2040_iobank0.h"
 #include "hw/misc/rp2040_pads.h"
 #include "hw/misc/rp2040_pll.h"
 #include "hw/misc/rp2040_psm.h"
@@ -47,6 +48,7 @@ struct RP2040State {
     ARMv7MState armv7m;
     PL011State uart[2];
     RP2040ClocksState clocks;
+    RP2040IoBank0State iobank0;
     RP2040PadsBank0State pads_bank0;
     RP2040PadsQspiState pads_qspi;
     RP2040PllState pll_sys;
diff --git a/include/hw/misc/rp2040_iobank0.h b/include/hw/misc/rp2040_iobank0.h
new file mode 100644
index 0000000000..93f5b4b2f4
--- /dev/null
+++ b/include/hw/misc/rp2040_iobank0.h
@@ -0,0 +1,45 @@
+/*
+ * RP2040 GPIO IO bank emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_RP2040_IOBANK0_H
+#define HW_MISC_RP2040_IOBANK0_H
+
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RP2040_IOBANK0 "rp2040-iobank0"
+OBJECT_DECLARE_SIMPLE_TYPE(RP2040IoBank0State, RP2040_IOBANK0)
+
+#define RP2040_IOBANK0_BASE 0x40014000
+#define RP2040_IOBANK0_SIZE 0x4000
+#define RP2040_IOBANK0_NUM_GPIOS 30
+#define RP2040_IOBANK0_IRQ_BANKS 4
+
+struct RP2040IoBank0State {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+    qemu_irq proc0_irq;
+    qemu_irq proc1_irq;
+    qemu_irq uart0_pin[2];
+    qemu_irq uart1_pin[2];
+
+    uint32_t ctrl[RP2040_IOBANK0_NUM_GPIOS];
+    uint32_t intr[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc0_inte[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc0_intf[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc1_inte[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t proc1_intf[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t dormant_wake_inte[RP2040_IOBANK0_IRQ_BANKS];
+    uint32_t dormant_wake_intf[RP2040_IOBANK0_IRQ_BANKS];
+};
+
+bool rp2040_iobank0_uart0_tx_enabled(RP2040IoBank0State *s);
+bool rp2040_iobank0_uart0_rx_enabled(RP2040IoBank0State *s);
+bool rp2040_iobank0_uart1_tx_enabled(RP2040IoBank0State *s);
+bool rp2040_iobank0_uart1_rx_enabled(RP2040IoBank0State *s);
+
+#endif
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 07a9e97610..372d412b9b 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -257,6 +257,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
                                                        'rp2040-clocks-test',
+                                                       'rp2040-iobank0-test',
                                                        'rp2040-pads-test',
                                                        'rp2040-resets-test',
                                                        'rp2040-rosc-test',
diff --git a/tests/qtest/rp2040-iobank0-test.c b/tests/qtest/rp2040-iobank0-test.c
new file mode 100644
index 0000000000..21bb27cdc4
--- /dev/null
+++ b/tests/qtest/rp2040-iobank0-test.c
@@ -0,0 +1,122 @@
+/*
+ * QTest testcase for the RP2040 IO_BANK0.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define IOBANK0_BASE         0x40014000
+#define GPIO0_STATUS         0x000
+#define GPIO0_CTRL           0x004
+#define GPIO29_CTRL          0x0ec
+#define INTR0                0x0f0
+#define PROC0_INTE0          0x100
+#define PROC0_INTF0          0x110
+#define PROC0_INTS0          0x120
+#define PROC1_INTE3          0x13c
+#define PROC1_INTF3          0x14c
+#define PROC1_INTS3          0x15c
+#define DORMANT_INTE3        0x16c
+#define DORMANT_INTF3        0x17c
+#define DORMANT_INTS3        0x18c
+
+#define CTRL_RESET           0x1f
+#define CTRL_RW_MASK         0x33333f
+#define IRQ_LAST_MASK        0x00ffffff
+#define IO_IRQ_BANK0         13
+
+#define ATOMIC_XOR           0x1000
+#define ATOMIC_SET           0x2000
+#define ATOMIC_CLR           0x3000
+
+#define NVIC_ISPR            0xe000e200
+#define NVIC_ICPR            0xe000e280
+
+static QTestState *rp2040_iobank0_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_gpio_control(void)
+{
+    QTestState *qts = rp2040_iobank0_start();
+
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + GPIO0_STATUS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + GPIO0_CTRL), ==,
+                    CTRL_RESET);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + GPIO29_CTRL), ==,
+                    CTRL_RESET);
+
+    qtest_writel(qts, IOBANK0_BASE + GPIO0_CTRL, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + GPIO0_CTRL), ==,
+                    CTRL_RW_MASK);
+    qtest_writel(qts, IOBANK0_BASE + ATOMIC_CLR + GPIO0_CTRL, 0x30);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + GPIO0_CTRL), ==,
+                    CTRL_RW_MASK & ~0x30);
+    qtest_writel(qts, IOBANK0_BASE + ATOMIC_XOR + GPIO0_CTRL, 0x03);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + GPIO0_CTRL), ==,
+                    (CTRL_RW_MASK & ~0x30) ^ 0x03);
+
+    qtest_quit(qts);
+}
+
+static void test_proc0_irq(void)
+{
+    QTestState *qts = rp2040_iobank0_start();
+    uint32_t irq = BIT(IO_IRQ_BANK0);
+
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + INTR0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + PROC0_INTS0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & irq, ==, 0);
+
+    qtest_writel(qts, IOBANK0_BASE + PROC0_INTF0, BIT(7));
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + PROC0_INTS0), ==,
+                    BIT(7));
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & irq, ==, irq);
+
+    qtest_writel(qts, IOBANK0_BASE + ATOMIC_CLR + PROC0_INTF0, BIT(7));
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + PROC0_INTS0), ==, 0);
+    qtest_writel(qts, NVIC_ICPR, irq);
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & irq, ==, 0);
+
+    qtest_writel(qts, IOBANK0_BASE + ATOMIC_SET + PROC0_INTE0, BIT(3));
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + PROC0_INTE0), ==,
+                    BIT(3));
+
+    qtest_quit(qts);
+}
+
+static void test_last_bank_masks(void)
+{
+    QTestState *qts = rp2040_iobank0_start();
+
+    qtest_writel(qts, IOBANK0_BASE + PROC1_INTE3, 0xffffffff);
+    qtest_writel(qts, IOBANK0_BASE + PROC1_INTF3, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + PROC1_INTE3), ==,
+                    IRQ_LAST_MASK);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + PROC1_INTS3), ==,
+                    IRQ_LAST_MASK);
+
+    qtest_writel(qts, IOBANK0_BASE + DORMANT_INTE3, 0xffffffff);
+    qtest_writel(qts, IOBANK0_BASE + DORMANT_INTF3, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + DORMANT_INTE3), ==,
+                    IRQ_LAST_MASK);
+    g_assert_cmphex(qtest_readl(qts, IOBANK0_BASE + DORMANT_INTS3), ==,
+                    IRQ_LAST_MASK);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-iobank0/gpio-control", test_gpio_control);
+    qtest_add_func("/rp2040-iobank0/proc0-irq", test_proc0_irq);
+    qtest_add_func("/rp2040-iobank0/last-bank-masks", test_last_bank_masks);
+
+    return g_test_run();
+}
-- 
2.55.0


