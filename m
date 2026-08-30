Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEF3C61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 06:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0Yry-0003Et-1Q; Sun, 30 Aug 2026 02:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yrw-0003Cz-Di; Sun, 30 Aug 2026 02:18:16 -0400
Received: from smtp-out-2.univ-lille.fr ([194.254.129.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x0Yru-0005LX-99; Sun, 30 Aug 2026 02:18:16 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-2.univ-lille.fr (Postfix) with ESMTPS id 4hXhjq0TrFz834L;
 Sun, 30 Aug 2026 08:17:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1788070639;
 bh=c9z8dU4O2YK2suuIBTSBJbTwyv+59modIwsJ1H91r84=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ae1YfOacUqQ25hsuFmxMxWodj4hgFN/qFv8M+yuCy9ISPhb6RyEsK/pDLXVVk9yDs
 NgloSAPicFwz1h+MEBK7AorVyu1ZZen7siIHtFnTlb7MpGxj1kLMXY12tx69ICffIA
 FedJ4RZB3yqnTtq8lah4NRe5ozrCeFPJ/l4aEC0vKZs1RLscvGoTFqV/zPu4mp1XfW
 oyzzdmBmUgzh4F2CPH8K2ppUjLO4HKVDmEHv5V/2J83RPvHqMTxYs+J3+RxUqXViF5
 BDQtUtMngfNdb+LEhk9q+/obawCHuN08mlnNOP0gwMzxS7x5hA3y/ZYdE65Tf4W0G4
 cAjaIRb+z1gLQ==
Received: from localhost.localdomain (unknown [10.134.14.34])
 (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hXhjp6BsRz7xSW;
 Sun, 30 Aug 2026 08:17:18 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH RFC v2 26/30] hw/arm: add shallow RP2040 USB controller
Date: Sun, 30 Aug 2026 08:15:57 +0200
Message-ID: <20260830061601.52136-12-gilles.grimaud@univ-lille.fr>
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

Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/arm/rp2040.c               | 125 +++++++++++++++++++++++++++++++++-
 include/hw/arm/rp2040.h       |   8 +++
 tests/qtest/meson.build       |   1 +
 tests/qtest/rp2040-usb-test.c |  80 ++++++++++++++++++++++
 4 files changed, 212 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/rp2040-usb-test.c

diff --git a/hw/arm/rp2040.c b/hw/arm/rp2040.c
index ca27b3c8ef..10a79c7daa 100644
--- a/hw/arm/rp2040.c
+++ b/hw/arm/rp2040.c
@@ -14,6 +14,7 @@
 #include "hw/core/qdev-clock.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
+#include "hw/misc/rp2040_nyi.h"
 #include "hw/misc/unimp.h"
 #include "qemu/datadir.h"
 #include "system/address-spaces.h"
@@ -29,6 +30,21 @@
 #define RP2040_IO_IRQ_BANK0 13
 #define RP2040_SIO_IRQ_PROC0 15
 #define RP2040_SIO_IRQ_PROC1 16
+
+#define USBCTRL_SIE_STATUS      0x50
+#define USBCTRL_BUFF_CPU_HANDLE 0x5c
+#define USBCTRL_EP_ABORT_DONE   0x64
+#define USBCTRL_INTR            0x8c
+#define USBCTRL_INTE            0x90
+#define USBCTRL_INTF            0x94
+#define USBCTRL_INTS            0x98
+
+#define USBCTRL_SIE_STATUS_VBUS_DETECTED BIT(11)
+
+#define ATOMIC_ALIAS_MASK 0x3000
+#define ATOMIC_XOR        0x1000
+#define ATOMIC_SET        0x2000
+#define ATOMIC_CLR        0x3000
 #define RP2040_PROC1          1
 
 /*
@@ -149,8 +165,6 @@ static const struct {
     { "rp2040.adc",      0x4004c000, 0x4000 },
     { "rp2040.pwm",      0x40050000, 0x4000 },
     { "rp2040.rtc",      0x4005c000, 0x4000 },
-    { "rp2040.usbctrl_dpram", 0x50100000, 0x10000 },
-    { "rp2040.usbctrl_regs",  0x50110000, 0x10000 },
     { "rp2040.pio0",     0x50200000, 0x10000 },
     { "rp2040.pio1",     0x50300000, 0x10000 },
 };
@@ -180,6 +194,21 @@ static const MemoryRegionOps rp2040_powered_off_ops = {
     },
 };
 
+static uint32_t rp2040_apply_atomic_alias(uint32_t old, uint32_t value,
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
 static void rp2040_update_mempowerdown(RP2040State *s)
 {
     uint32_t mempowerdown;
@@ -194,9 +223,78 @@ static void rp2040_update_mempowerdown(RP2040State *s)
         memory_region_set_enabled(&s->sram_poweroff[i],
                                   mempowerdown & BIT(i));
     }
+    memory_region_set_enabled(&s->usbctrl_dpram_poweroff,
+                              mempowerdown & BIT(6));
     memory_region_set_enabled(&s->rom_poweroff, mempowerdown & BIT(7));
 }
 
+static uint64_t rp2040_usbctrl_regs_read(void *opaque, hwaddr addr,
+                                         unsigned size)
+{
+    RP2040State *s = opaque;
+    hwaddr offset = addr & 0xfff;
+    uint64_t value;
+
+    switch (offset) {
+    case USBCTRL_SIE_STATUS:
+        value = s->usbctrl_reg[offset / sizeof(uint32_t)] |
+                USBCTRL_SIE_STATUS_VBUS_DETECTED;
+        break;
+    case USBCTRL_BUFF_CPU_HANDLE:
+    case USBCTRL_EP_ABORT_DONE:
+    case USBCTRL_INTR:
+        value = s->usbctrl_reg[offset / sizeof(uint32_t)];
+        break;
+    case USBCTRL_INTS:
+        value = (s->usbctrl_reg[USBCTRL_INTR / sizeof(uint32_t)] |
+                 s->usbctrl_reg[USBCTRL_INTF / sizeof(uint32_t)]) &
+                s->usbctrl_reg[USBCTRL_INTE / sizeof(uint32_t)];
+        break;
+    default:
+        if (offset < sizeof(s->usbctrl_reg)) {
+            value = s->usbctrl_reg[offset / sizeof(uint32_t)];
+        } else {
+            value = 0;
+            rp2040_log_unimplemented_read("usbctrl_regs", size,
+                                          RP2040_USBCTRL_REGS_BASE + addr,
+                                          offset, value);
+        }
+        break;
+    }
+
+    return value;
+}
+
+static void rp2040_usbctrl_regs_write(void *opaque, hwaddr addr,
+                                      uint64_t value64, unsigned size)
+{
+    RP2040State *s = opaque;
+    hwaddr alias = addr & ATOMIC_ALIAS_MASK;
+    hwaddr offset = addr & 0xfff;
+    uint32_t value = value64;
+    uint32_t old;
+
+    if (offset < sizeof(s->usbctrl_reg)) {
+        old = s->usbctrl_reg[offset / sizeof(uint32_t)];
+        s->usbctrl_reg[offset / sizeof(uint32_t)] =
+            rp2040_apply_atomic_alias(old, value, alias);
+    } else {
+        rp2040_log_unimplemented_write("usbctrl_regs", size,
+                                       RP2040_USBCTRL_REGS_BASE + addr,
+                                       offset, value64);
+    }
+}
+
+static const MemoryRegionOps rp2040_usbctrl_regs_ops = {
+    .read = rp2040_usbctrl_regs_read,
+    .write = rp2040_usbctrl_regs_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void rp2040_update_nmi(RP2040State *s)
 {
     uint32_t nmi_mask = rp2040_syscfg_get_proc0_nmi_mask(&s->syscfg);
@@ -475,6 +573,29 @@ static bool rp2040_init_memory(RP2040State *s, Error **errp)
                                         &s->sram_poweroff[5], 1);
     memory_region_set_enabled(&s->sram_poweroff[5], false);
 
+    if (!memory_region_init_ram(&s->usbctrl_dpram, OBJECT(s),
+                                "rp2040.usbctrl_dpram",
+                                RP2040_USBCTRL_DPRAM_SIZE, errp)) {
+        return false;
+    }
+    memory_region_add_subregion(s->board_memory, RP2040_USBCTRL_DPRAM_BASE,
+                                &s->usbctrl_dpram);
+    memory_region_init_io(&s->usbctrl_dpram_poweroff, OBJECT(s),
+                          &rp2040_powered_off_ops, s,
+                          "rp2040.usbctrl_dpram.poweroff",
+                          RP2040_USBCTRL_DPRAM_SIZE);
+    memory_region_add_subregion_overlap(s->board_memory,
+                                        RP2040_USBCTRL_DPRAM_BASE,
+                                        &s->usbctrl_dpram_poweroff, 1);
+    memory_region_set_enabled(&s->usbctrl_dpram_poweroff, false);
+
+    memory_region_init_io(&s->usbctrl_regs, OBJECT(s),
+                          &rp2040_usbctrl_regs_ops, s,
+                          "rp2040.usbctrl_regs",
+                          RP2040_USBCTRL_REGS_SIZE);
+    memory_region_add_subregion(s->board_memory, RP2040_USBCTRL_REGS_BASE,
+                                &s->usbctrl_regs);
+
     s->mempowerdown_ready = true;
 
     return true;
diff --git a/include/hw/arm/rp2040.h b/include/hw/arm/rp2040.h
index eeec45efbe..5c5026d65a 100644
--- a/include/hw/arm/rp2040.h
+++ b/include/hw/arm/rp2040.h
@@ -48,6 +48,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(RP2040State, RP2040)
 #define RP2040_SRAM4_BASE     0x20040000
 #define RP2040_SRAM5_BASE     0x20041000
 #define RP2040_SRAM_HI_SIZE   (4 * KiB)
+#define RP2040_USBCTRL_DPRAM_BASE 0x50100000
+#define RP2040_USBCTRL_DPRAM_SIZE (4 * KiB)
+#define RP2040_USBCTRL_REGS_BASE  0x50110000
+#define RP2040_USBCTRL_REGS_SIZE  0x4000
 
 #define RP2040_NUM_CORES      2
 #define RP2040_NUM_IRQS       32
@@ -85,6 +89,10 @@ struct RP2040State {
     MemoryRegion rom_poweroff;
     MemoryRegion sram[6];
     MemoryRegion sram_poweroff[6];
+    MemoryRegion usbctrl_dpram;
+    MemoryRegion usbctrl_dpram_poweroff;
+    MemoryRegion usbctrl_regs;
+    uint32_t usbctrl_reg[0x100 / sizeof(uint32_t)];
     char *bootrom_file;
 
     qemu_irq *irq;
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c11f35e427..23ca1b6161 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -268,6 +268,7 @@ qtests_arm = \
                                                        'rp2040-sio-test',
                                                        'rp2040-tbman-test',
                                                        'rp2040-timer-test',
+                                                       'rp2040-usb-test',
                                                        'rp2040-uart-test',
                                                        'rp2040-vreg-test',
                                                        'rp2040-watchdog-test',
diff --git a/tests/qtest/rp2040-usb-test.c b/tests/qtest/rp2040-usb-test.c
new file mode 100644
index 0000000000..e56b6f9066
--- /dev/null
+++ b/tests/qtest/rp2040-usb-test.c
@@ -0,0 +1,80 @@
+/*
+ * QTest testcase for the shallow RP2040 USB controller model.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define USBCTRL_DPRAM_BASE       0x50100000
+#define USBCTRL_REGS_BASE        0x50110000
+#define USBCTRL_ALIAS_XOR        0x1000
+#define USBCTRL_ALIAS_SET        0x2000
+#define USBCTRL_ALIAS_CLR        0x3000
+
+#define USBCTRL_SIE_STATUS       0x50
+#define USBCTRL_USB_MUXING       0x74
+#define USBCTRL_INTR             0x8c
+#define USBCTRL_INTE             0x90
+#define USBCTRL_INTF             0x94
+#define USBCTRL_INTS             0x98
+
+#define USBCTRL_VBUS_DETECTED    (1U << 11)
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_usb_dpram(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, USBCTRL_DPRAM_BASE + 0x20, 0x12345678);
+    g_assert_cmphex(qtest_readl(qts, USBCTRL_DPRAM_BASE + 0x20),
+                    ==, 0x12345678);
+
+    qtest_quit(qts);
+}
+
+static void test_usb_registers(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, USBCTRL_REGS_BASE +
+                               USBCTRL_SIE_STATUS) &
+                    USBCTRL_VBUS_DETECTED, ==, USBCTRL_VBUS_DETECTED);
+
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_USB_MUXING, 0x5);
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_ALIAS_SET +
+                 USBCTRL_USB_MUXING, 0x8);
+    g_assert_cmphex(qtest_readl(qts, USBCTRL_REGS_BASE +
+                               USBCTRL_USB_MUXING), ==, 0xd);
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_ALIAS_XOR +
+                 USBCTRL_USB_MUXING, 0x9);
+    g_assert_cmphex(qtest_readl(qts, USBCTRL_REGS_BASE +
+                               USBCTRL_USB_MUXING), ==, 0x4);
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_ALIAS_CLR +
+                 USBCTRL_USB_MUXING, 0x4);
+    g_assert_cmphex(qtest_readl(qts, USBCTRL_REGS_BASE +
+                               USBCTRL_USB_MUXING), ==, 0);
+
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_INTR, 0x3);
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_INTF, 0x4);
+    qtest_writel(qts, USBCTRL_REGS_BASE + USBCTRL_INTE, 0x6);
+    g_assert_cmphex(qtest_readl(qts, USBCTRL_REGS_BASE + USBCTRL_INTS),
+                    ==, 0x6);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-usb/dpram", test_usb_dpram);
+    qtest_add_func("/rp2040-usb/registers", test_usb_registers);
+
+    return g_test_run();
+}
-- 
2.55.0


