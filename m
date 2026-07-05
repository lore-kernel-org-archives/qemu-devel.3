Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E49BC43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgVJy-0006nJ-3V; Sun, 05 Jul 2026 18:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUw7-0002EO-Ry; Sun, 05 Jul 2026 18:03:39 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgUw2-0001h2-VP; Sun, 05 Jul 2026 18:03:39 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4gthMG6YMCzBt0f;
 Mon,  6 Jul 2026 00:03:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783289002;
 bh=Nb/7wEHJmJ7o7Wa887+QjUm87puhwT6uWKi1riPD/2Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZaetCRI56RQnOsbEsc+7eKSGwa4VtrglNb3qlirgNuIvrEVumRgV0gHjZh7x04Rxw
 EJ+Jfdyo5oTL7dLRWqY17H9yPxN0OmysjTRXuTCuljURCa+u6UbL+roqpfBIFkrTZn
 3Xyh3Zm0VNUHoLNLhp6Mk3IFTQ5rEoINlUAZWaZVxBKk84Q3dCi9b+B9loNkqi0Pe3
 aTWVAr5G+18TuMC8GRA9jmDu3RGCtO9A9xG/cwem1ReLeAmtsk2ox3blCBoCubm+a7
 e6Y+w6aN+L7+8K8QoBEYX1+FfI6Lymf68lQ7qLc79qPwqqMKDXhC2ev5vgccc6LYw5
 GkTWS5QpsxzFA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4gthMG5Mdbz6tBv;
 Mon,  6 Jul 2026 00:03:22 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [PATCH RFC v1 7/9] tests/qtest: add RP2040 peripheral tests
Date: Mon,  6 Jul 2026 00:03:18 +0200
Message-ID: <20260705220320.90395-8-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
References: <20260705220320.90395-1-gilles.grimaud@univ-lille.fr>
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
X-Mailman-Approved-At: Sun, 05 Jul 2026 18:28:16 -0400
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

Add qtests for RP2040 SIO, DMA, XIP/SSI, clocks, resets, watchdog, ROSC, SYSINFO/SYSCFG, VREG, IO_QSPI, TBMAN and BUSCTRL behaviour.

The tests cover the functional contracts used by the Pico machine and the Pico SDK examples rather than cycle-level timing.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 tests/qtest/meson.build                  |  12 +
 tests/qtest/rp2040-busctrl-test.c        |  92 ++++++
 tests/qtest/rp2040-clocks-test.c         | 107 +++++++
 tests/qtest/rp2040-dma-test.c            | 374 +++++++++++++++++++++++
 tests/qtest/rp2040-ioqspi-test.c         |  81 +++++
 tests/qtest/rp2040-resets-test.c         |  84 +++++
 tests/qtest/rp2040-rosc-test.c           | 146 +++++++++
 tests/qtest/rp2040-sio-test.c            | 234 ++++++++++++++
 tests/qtest/rp2040-sysinfo-syscfg-test.c | 177 +++++++++++
 tests/qtest/rp2040-tbman-test.c          |  32 ++
 tests/qtest/rp2040-vreg-test.c           |  79 +++++
 tests/qtest/rp2040-watchdog-test.c       | 148 +++++++++
 tests/qtest/rp2040-xip-test.c            | 212 +++++++++++++
 13 files changed, 1778 insertions(+)
 create mode 100644 tests/qtest/rp2040-busctrl-test.c
 create mode 100644 tests/qtest/rp2040-clocks-test.c
 create mode 100644 tests/qtest/rp2040-dma-test.c
 create mode 100644 tests/qtest/rp2040-ioqspi-test.c
 create mode 100644 tests/qtest/rp2040-resets-test.c
 create mode 100644 tests/qtest/rp2040-rosc-test.c
 create mode 100644 tests/qtest/rp2040-sio-test.c
 create mode 100644 tests/qtest/rp2040-sysinfo-syscfg-test.c
 create mode 100644 tests/qtest/rp2040-tbman-test.c
 create mode 100644 tests/qtest/rp2040-vreg-test.c
 create mode 100644 tests/qtest/rp2040-watchdog-test.c
 create mode 100644 tests/qtest/rp2040-xip-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5e18b947c7..12cc8a500d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -250,6 +250,18 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_RASPI_PICO') ? ['rp2040-sysinfo-syscfg-test',
+                                                       'rp2040-busctrl-test',
+                                                       'rp2040-clocks-test',
+                                                       'rp2040-dma-test',
+                                                       'rp2040-ioqspi-test',
+                                                       'rp2040-resets-test',
+                                                       'rp2040-rosc-test',
+                                                       'rp2040-sio-test',
+                                                       'rp2040-tbman-test',
+                                                       'rp2040-vreg-test',
+                                                       'rp2040-watchdog-test',
+                                                       'rp2040-xip-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
diff --git a/tests/qtest/rp2040-busctrl-test.c b/tests/qtest/rp2040-busctrl-test.c
new file mode 100644
index 0000000000..a86fd8a20e
--- /dev/null
+++ b/tests/qtest/rp2040-busctrl-test.c
@@ -0,0 +1,92 @@
+/*
+ * QTest testcase for the RP2040 bus fabric control block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define BUSCTRL_BASE           0x40030000
+#define BUSCTRL_PRIORITY       0x00
+#define BUSCTRL_PRIORITY_ACK   0x04
+#define BUSCTRL_PERFCTR0       0x08
+#define BUSCTRL_PERFSEL0       0x0c
+#define BUSCTRL_PERFCTR1       0x10
+#define BUSCTRL_PERFSEL1       0x14
+#define BUSCTRL_PRIORITY_MASK  0x00001111
+#define BUSCTRL_PERFCTR_MASK   0x00ffffff
+#define BUSCTRL_PERFSEL_RESET  0x1f
+#define BUSCTRL_PERFSEL_SRAM5  0x05
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_busctrl_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY_ACK),
+                    ==, 1);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL0),
+                    ==, BUSCTRL_PERFSEL_RESET);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL1),
+                    ==, BUSCTRL_PERFSEL_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_busctrl_priority(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY),
+                    ==, BUSCTRL_PRIORITY_MASK);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PRIORITY_ACK),
+                    ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_busctrl_perf_counter(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t first;
+    uint32_t second;
+
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0),
+                    ==, 0);
+    qtest_writel(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL0,
+                 BUSCTRL_PERFSEL_SRAM5);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFSEL0),
+                    ==, BUSCTRL_PERFSEL_SRAM5);
+
+    first = qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0);
+    second = qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0);
+    g_assert_cmphex(first, ==, 1);
+    g_assert_cmphex(second, ==, 2);
+
+    qtest_writel(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0,
+                 BUSCTRL_PERFCTR_MASK);
+    g_assert_cmphex(qtest_readl(qts, BUSCTRL_BASE + BUSCTRL_PERFCTR0),
+                    ==, BUSCTRL_PERFCTR_MASK);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-busctrl/reset-values",
+                   test_busctrl_reset_values);
+    qtest_add_func("/rp2040-busctrl/priority", test_busctrl_priority);
+    qtest_add_func("/rp2040-busctrl/perf-counter",
+                   test_busctrl_perf_counter);
+
+    return g_test_run();
+}
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
diff --git a/tests/qtest/rp2040-dma-test.c b/tests/qtest/rp2040-dma-test.c
new file mode 100644
index 0000000000..61ad2fac40
--- /dev/null
+++ b/tests/qtest/rp2040-dma-test.c
@@ -0,0 +1,374 @@
+/*
+ * QTest testcase for the RP2040 DMA block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define DMA_BASE                0x50000000
+#define DMA_CH_READ_ADDR        0x00
+#define DMA_CH_WRITE_ADDR       0x04
+#define DMA_CH_TRANS_COUNT      0x08
+#define DMA_CH_CTRL_TRIG        0x0c
+#define DMA_CH_AL1_CTRL         0x10
+#define DMA_CH_AL3_TRANS_COUNT  0x38
+#define DMA_CH_AL3_READ_ADDR    0x3c
+#define DMA_CH_SIZE             0x40
+#define DMA_INTR                0x400
+#define DMA_INTE0               0x404
+#define DMA_INTS0               0x40c
+#define DMA_TIMER0              0x420
+#define DMA_SNIFF_CTRL          0x434
+#define DMA_SNIFF_DATA          0x438
+#define DMA_CHAN_ABORT          0x444
+
+#define DMA_CTRL_AHB_ERROR      BIT(31)
+#define DMA_CTRL_READ_ERROR     BIT(30)
+#define DMA_CTRL_WRITE_ERROR    BIT(29)
+#define DMA_CTRL_BUSY           BIT(24)
+#define DMA_CTRL_SNIFF_EN       BIT(23)
+#define DMA_CTRL_IRQ_QUIET      BIT(21)
+#define DMA_CTRL_TREQ_SEL_SHIFT 15
+#define DMA_CTRL_CHAIN_TO_SHIFT 11
+#define DMA_CTRL_RING_SEL       BIT(10)
+#define DMA_CTRL_RING_SIZE_SHIFT 6
+#define DMA_CTRL_INCR_WRITE     BIT(5)
+#define DMA_CTRL_INCR_READ      BIT(4)
+#define DMA_CTRL_DATA_SIZE_8    (0 << 2)
+#define DMA_CTRL_DATA_SIZE_32   (2 << 2)
+#define DMA_CTRL_EN             BIT(0)
+
+#define DMA_SNIFF_CTRL_OUT_INV  BIT(11)
+#define DMA_SNIFF_CTRL_OUT_REV  BIT(10)
+#define DMA_SNIFF_CTRL_CALC_SUM (0xf << 5)
+#define DMA_SNIFF_CTRL_EN       BIT(0)
+
+#define DREQ_DMA_TIMER0         59
+#define DREQ_XIP_SSIRX          39
+#define DREQ_FORCE              63
+
+#define XIP_SSI_BASE            0x18000000
+#define XIP_SSI_DR0             0x60
+
+#define SRAM_BASE               0x20000000
+#define BAD_DMA_ADDR            0x60000000
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_dma_xip_ssi_rx_dreq(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_WRITE | DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_XIP_SSIRX << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_writel(qts, SRAM_BASE, 0xffffffff);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, XIP_SSI_BASE + XIP_SSI_DR0);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 4);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, DMA_CTRL_BUSY);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 4);
+
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x03);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SRAM_BASE), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_write_ring_wrap(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 0x10, 0x11, 0x12, 0x13, 0x14, 0x15 };
+    const uint8_t initial[] = { 0xaa, 0xaa, 0xaa, 0xaa };
+    uint8_t dest[sizeof(initial)];
+    uint32_t read_addr = SRAM_BASE + 0x80;
+    uint32_t write_addr = SRAM_BASE + 0x100;
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ | DMA_CTRL_INCR_WRITE |
+                    DMA_CTRL_RING_SEL | DMA_CTRL_DATA_SIZE_8 |
+                    (2 << DMA_CTRL_RING_SIZE_SHIFT) |
+                    (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+    qtest_memwrite(qts, write_addr, initial, sizeof(initial));
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, read_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    qtest_memread(qts, write_addr, dest, sizeof(dest));
+    g_assert_cmphex(dest[0], ==, 0x14);
+    g_assert_cmphex(dest[1], ==, 0x15);
+    g_assert_cmphex(dest[2], ==, 0x12);
+    g_assert_cmphex(dest[3], ==, 0x13);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_READ_ADDR), ==,
+                    read_addr + sizeof(source));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_WRITE_ADDR), ==,
+                    write_addr + 2);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_channel_abort(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_WRITE | DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_XIP_SSIRX << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_writel(qts, SRAM_BASE, 0xffffffff);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, XIP_SSI_BASE + XIP_SSI_DR0);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 4);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, DMA_CTRL_BUSY);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 4);
+
+    qtest_writel(qts, DMA_BASE + DMA_CHAN_ABORT, BIT(0));
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CHAN_ABORT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x03);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+    qtest_writel(qts, XIP_SSI_BASE + XIP_SSI_DR0, 0x00);
+
+    g_assert_cmphex(qtest_readl(qts, SRAM_BASE), ==, 0xffffffff);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_sniff_sum(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 1, 2, 3, 4 };
+    uint32_t read_addr = SRAM_BASE + 0x180;
+    uint32_t write_addr = SRAM_BASE + 0x190;
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ | DMA_CTRL_INCR_WRITE |
+                    DMA_CTRL_SNIFF_EN | DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_DATA, 0x100);
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_CTRL,
+                 DMA_SNIFF_CTRL_EN | DMA_SNIFF_CTRL_CALC_SUM);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, read_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_SNIFF_DATA), ==, 0x10a);
+
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_CTRL,
+                 DMA_SNIFF_CTRL_EN | DMA_SNIFF_CTRL_CALC_SUM |
+                 DMA_SNIFF_CTRL_OUT_REV);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_SNIFF_DATA), ==,
+                    0x50800000);
+
+    qtest_writel(qts, DMA_BASE + DMA_SNIFF_CTRL,
+                 DMA_SNIFF_CTRL_EN | DMA_SNIFF_CTRL_CALC_SUM |
+                 DMA_SNIFF_CTRL_OUT_INV);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_SNIFF_DATA), ==,
+                    0xfffffef5);
+
+    qtest_quit(qts);
+}
+
+static void test_dma_error_status(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_DATA_SIZE_32 |
+                    (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_writel(qts, SRAM_BASE, 0x12345678);
+    qtest_writel(qts, DMA_BASE + DMA_INTR, BIT(0));
+    qtest_writel(qts, DMA_BASE + DMA_INTE0, BIT(0));
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, BAD_DMA_ADDR);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE + 4);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 1);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    (DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR |
+                     DMA_CTRL_WRITE_ERROR | DMA_CTRL_BUSY), ==,
+                    DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTS0), ==, BIT(0));
+
+    qtest_writel(qts, DMA_BASE + DMA_INTS0, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTS0), ==, 0);
+
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG,
+                 DMA_CTRL_READ_ERROR | DMA_CTRL_WRITE_ERROR);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    (DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR |
+                     DMA_CTRL_WRITE_ERROR), ==, 0);
+
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, BAD_DMA_ADDR);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 1);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    (DMA_CTRL_AHB_ERROR | DMA_CTRL_READ_ERROR |
+                     DMA_CTRL_WRITE_ERROR | DMA_CTRL_BUSY), ==,
+                    DMA_CTRL_AHB_ERROR | DMA_CTRL_WRITE_ERROR);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 1);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTS0), ==, BIT(0));
+
+    qtest_quit(qts);
+}
+
+static void test_dma_timer_dreq(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 0xa1, 0xb2, 0xc3 };
+    uint8_t dest[sizeof(source)];
+    uint32_t read_addr = SRAM_BASE + 0x280;
+    uint32_t write_addr = SRAM_BASE + 0x290;
+    uint32_t ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ | DMA_CTRL_INCR_WRITE |
+                    DMA_CTRL_DATA_SIZE_8 |
+                    (DREQ_DMA_TIMER0 << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+    memset(dest, 0, sizeof(dest));
+    qtest_memwrite(qts, write_addr, dest, sizeof(dest));
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, read_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, sizeof(source));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, DMA_CTRL_BUSY);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==,
+                    sizeof(source));
+
+    /*
+     * X/Y = 1/1000 on a nominal 125 MHz sys_clk gives one DREQ every
+     * 8000 ns of QEMU virtual time.
+     */
+    qtest_writel(qts, DMA_BASE + DMA_TIMER0, (1u << 16) | 1000u);
+    qtest_clock_step(qts, 7999);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==,
+                    sizeof(source));
+
+    qtest_clock_step(qts, 1);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 2);
+    g_assert_cmphex(qtest_readb(qts, write_addr), ==, source[0]);
+
+    qtest_clock_step(qts, 8000);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 1);
+    g_assert_cmphex(qtest_readb(qts, write_addr + 1), ==, source[1]);
+
+    qtest_clock_step(qts, 8000);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    qtest_memread(qts, write_addr, dest, sizeof(dest));
+    g_assert_cmpmem(dest, sizeof(dest), source, sizeof(source));
+
+    qtest_quit(qts);
+}
+
+static void test_dma_control_blocks(void)
+{
+    QTestState *qts = rp2040_start();
+    const uint8_t source[] = { 0x44, 0x4d, 0x41 };
+    uint8_t dest[sizeof(source)];
+    uint32_t blocks[] = {
+        sizeof(source), SRAM_BASE + 0x380,
+        0, 0,
+    };
+    uint32_t block_addr = SRAM_BASE + 0x300;
+    uint32_t read_addr = SRAM_BASE + 0x380;
+    uint32_t write_addr = SRAM_BASE + 0x390;
+    uint32_t chan1 = DMA_BASE + DMA_CH_SIZE;
+    uint32_t ctrl_chan_ctrl;
+    uint32_t data_chan_ctrl;
+
+    qtest_memwrite(qts, block_addr, blocks, sizeof(blocks));
+    qtest_memwrite(qts, read_addr, source, sizeof(source));
+
+    /*
+     * Channel 0 writes two 32-bit words into channel 1's alias 3
+     * TRANS_COUNT/READ_ADDR registers.  The second write triggers channel 1.
+     */
+    ctrl_chan_ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ |
+                     DMA_CTRL_INCR_WRITE | DMA_CTRL_RING_SEL |
+                     DMA_CTRL_DATA_SIZE_32 |
+                     (3 << DMA_CTRL_RING_SIZE_SHIFT) |
+                     (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT);
+
+    /*
+     * Channel 1 copies the configured block and chains back to channel 0.
+     * The final zero-length control block sets channel 1's interrupt via
+     * IRQ_QUIET, matching the SDK control_blocks example's termination.
+     */
+    data_chan_ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_READ |
+                     DMA_CTRL_INCR_WRITE | DMA_CTRL_IRQ_QUIET |
+                     (DREQ_FORCE << DMA_CTRL_TREQ_SEL_SHIFT) |
+                     (0 << DMA_CTRL_CHAIN_TO_SHIFT);
+
+    qtest_writel(qts, chan1 + DMA_CH_WRITE_ADDR, write_addr);
+    qtest_writel(qts, chan1 + DMA_CH_AL1_CTRL, data_chan_ctrl);
+
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, block_addr);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR,
+                 chan1 + DMA_CH_AL3_TRANS_COUNT);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, 2);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl_chan_ctrl);
+
+    qtest_memread(qts, write_addr, dest, sizeof(dest));
+    g_assert_cmpmem(dest, sizeof(dest), source, sizeof(source));
+    g_assert_cmphex(qtest_readl(qts, chan1 + DMA_CH_TRANS_COUNT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, chan1 + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_INTR) & BIT(1), ==,
+                    BIT(1));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-dma/xip-ssi-rx-dreq",
+                   test_dma_xip_ssi_rx_dreq);
+    qtest_add_func("/rp2040-dma/write-ring-wrap",
+                   test_dma_write_ring_wrap);
+    qtest_add_func("/rp2040-dma/channel-abort",
+                   test_dma_channel_abort);
+    qtest_add_func("/rp2040-dma/sniff-sum",
+                   test_dma_sniff_sum);
+    qtest_add_func("/rp2040-dma/error-status",
+                   test_dma_error_status);
+    qtest_add_func("/rp2040-dma/timer-dreq",
+                   test_dma_timer_dreq);
+    qtest_add_func("/rp2040-dma/control-blocks",
+                   test_dma_control_blocks);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/rp2040-ioqspi-test.c b/tests/qtest/rp2040-ioqspi-test.c
new file mode 100644
index 0000000000..4f94b5f3a2
--- /dev/null
+++ b/tests/qtest/rp2040-ioqspi-test.c
@@ -0,0 +1,81 @@
+/*
+ * QTest testcase for the RP2040 QSPI IO bank block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define IOQSPI_BASE             0x40018000
+#define IOQSPI_SCLK_STATUS      0x00
+#define IOQSPI_SCLK_CTRL        0x04
+#define IOQSPI_SD1_CTRL         0x1c
+#define IOQSPI_PROC0_INTE       0x34
+#define IOQSPI_PROC0_INTF       0x38
+#define IOQSPI_PROC0_INTS       0x3c
+
+#define IOQSPI_CTRL_RESET       0x1f
+#define IOQSPI_SD1_CTRL_SET     0x201c
+#define IOQSPI_SD1_CTRL_CLR     0x301c
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_ioqspi_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SCLK_STATUS), ==,
+                    0);
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SCLK_CTRL), ==,
+                    IOQSPI_CTRL_RESET);
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL), ==,
+                    IOQSPI_CTRL_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_ioqspi_atomic_ctrl_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL, 0);
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL_SET, BIT(17));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL_CLR, BIT(17));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL_SET, BIT(9));
+
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_SD1_CTRL), ==,
+                    BIT(9));
+
+    qtest_quit(qts);
+}
+
+static void test_ioqspi_interrupt_force_status(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTE, BIT(1));
+    qtest_writel(qts, IOQSPI_BASE + IOQSPI_PROC0_INTF, BIT(2));
+
+    g_assert_cmphex(qtest_readl(qts, IOQSPI_BASE + IOQSPI_PROC0_INTS), ==,
+                    BIT(2));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-ioqspi/reset-values", test_ioqspi_reset_values);
+    qtest_add_func("/rp2040-ioqspi/atomic-ctrl-aliases",
+                   test_ioqspi_atomic_ctrl_aliases);
+    qtest_add_func("/rp2040-ioqspi/interrupt-force-status",
+                   test_ioqspi_interrupt_force_status);
+
+    return g_test_run();
+}
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
diff --git a/tests/qtest/rp2040-sio-test.c b/tests/qtest/rp2040-sio-test.c
new file mode 100644
index 0000000000..8212497e28
--- /dev/null
+++ b/tests/qtest/rp2040-sio-test.c
@@ -0,0 +1,234 @@
+/*
+ * QTest testcase for the RP2040 SIO block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define SIO_BASE                0xd0000000
+#define SIO_CPUID               0x000
+#define SIO_GPIO_IN             0x004
+#define SIO_GPIO_HI_IN          0x008
+#define SIO_GPIO_OUT            0x010
+#define SIO_GPIO_OUT_SET        0x014
+#define SIO_GPIO_OUT_CLR        0x018
+#define SIO_GPIO_OUT_XOR        0x01c
+#define SIO_GPIO_HI_OUT         0x030
+#define SIO_GPIO_HI_OUT_SET     0x034
+#define SIO_GPIO_HI_OUT_CLR     0x038
+#define SIO_GPIO_HI_OUT_XOR     0x03c
+#define SIO_FIFO_ST             0x050
+#define SIO_FIFO_RD             0x058
+#define SIO_SPINLOCK_ST         0x05c
+#define SIO_SPINLOCK0           0x100
+#define SIO_INTERP0_ACCUM0      0x080
+#define SIO_INTERP0_ACCUM1      0x084
+#define SIO_INTERP0_BASE0       0x088
+#define SIO_INTERP0_BASE1       0x08c
+#define SIO_INTERP0_POP_LANE1   0x098
+#define SIO_INTERP0_PEEK_LANE0  0x0a0
+#define SIO_INTERP0_PEEK_LANE1  0x0a4
+#define SIO_INTERP0_CTRL_LANE0  0x0ac
+#define SIO_INTERP0_CTRL_LANE1  0x0b0
+#define SIO_INTERP0_ACCUM0_ADD  0x0b4
+#define SIO_INTERP0_BASE_1AND0  0x0bc
+#define SIO_INTERP1_ACCUM0      0x0c0
+#define SIO_INTERP1_BASE0       0x0c8
+#define SIO_INTERP1_BASE1       0x0cc
+#define SIO_INTERP1_PEEK_LANE0  0x0e0
+#define SIO_INTERP1_CTRL_LANE0  0x0ec
+
+#define INTERP_CTRL_SHIFT(n)    (n)
+#define INTERP_CTRL_MASK(lsb, msb) (((lsb) << 5) | ((msb) << 10))
+#define INTERP_CTRL_SIGNED      BIT(15)
+#define INTERP_CTRL_CROSS_RESULT BIT(17)
+#define INTERP0_CTRL_BLEND      BIT(21)
+#define INTERP1_CTRL_CLAMP      BIT(22)
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_sio_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_CPUID), ==, 0);
+    g_assert_cmphex(qtest_readb(qts, SIO_BASE + SIO_CPUID), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_IN), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_HI_IN), ==, BIT(1));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_OUT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_HI_OUT), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_FIFO_ST), ==, BIT(1));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK_ST), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_gpio_alias_registers(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT, BIT(3));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT_SET, BIT(5));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT_CLR, BIT(3));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_OUT_XOR, BIT(7));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_OUT), ==,
+                    BIT(5) | BIT(7));
+
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT, BIT(0));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT_SET, BIT(2));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT_CLR, BIT(0));
+    qtest_writel(qts, SIO_BASE + SIO_GPIO_HI_OUT_XOR, BIT(5));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_GPIO_HI_OUT), ==,
+                    BIT(2) | BIT(5));
+
+    qtest_quit(qts);
+}
+
+static void test_sio_fifo_empty_read_sets_roe(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_readl(qts, SIO_BASE + SIO_FIFO_RD);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_FIFO_ST), ==,
+                    BIT(3) | BIT(1));
+
+    qtest_writel(qts, SIO_BASE + SIO_FIFO_ST, BIT(3));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_FIFO_ST), ==, BIT(1));
+
+    qtest_quit(qts);
+}
+
+static void test_sio_spinlock_claim_release(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK0), ==, BIT(0));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK0), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK_ST), ==, BIT(0));
+
+    qtest_writel(qts, SIO_BASE + SIO_SPINLOCK0, 0);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_SPINLOCK_ST), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_mask_and_sign(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM0, 0x1234abcd);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 INTERP_CTRL_MASK(4, 7));
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_ACCUM0_ADD),
+                    ==, 0x000000c0);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 INTERP_CTRL_MASK(4, 7) | INTERP_CTRL_SIGNED);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_ACCUM0_ADD),
+                    ==, 0xffffffc0);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_pop_cross_result(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t full_mask = INTERP_CTRL_MASK(0, 31);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM0, 123);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM1, 456);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE0, 1);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE1, 0);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 full_mask | INTERP_CTRL_CROSS_RESULT);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE1,
+                 full_mask | INTERP_CTRL_CROSS_RESULT);
+
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE0),
+                    ==, 124);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_POP_LANE1),
+                    ==, 456);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE0),
+                    ==, 457);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_blend(void)
+{
+    QTestState *qts = rp2040_start();
+    uint32_t full_mask = INTERP_CTRL_MASK(0, 31);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE0,
+                 full_mask | INTERP0_CTRL_BLEND);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE1, full_mask);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_ACCUM1, 128);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE_1AND0, 0x30005000);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE1),
+                    ==, 0x00004000);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE_1AND0, 0xe000f000);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE1),
+                    ==, 0x0000e800);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_CTRL_LANE1,
+                 full_mask | INTERP_CTRL_SIGNED);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP0_BASE_1AND0, 0xe000f000);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP0_PEEK_LANE1),
+                    ==, 0xffffe800);
+
+    qtest_quit(qts);
+}
+
+static void test_sio_interp_clamp(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_CTRL_LANE0,
+                 INTERP1_CTRL_CLAMP | INTERP_CTRL_SIGNED |
+                 INTERP_CTRL_SHIFT(2) | INTERP_CTRL_MASK(0, 29));
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_BASE0, 0);
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_BASE1, 255);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_ACCUM0, -1024);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP1_PEEK_LANE0),
+                    ==, 0);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_ACCUM0, 512);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP1_PEEK_LANE0),
+                    ==, 128);
+
+    qtest_writel(qts, SIO_BASE + SIO_INTERP1_ACCUM0, 1024);
+    g_assert_cmphex(qtest_readl(qts, SIO_BASE + SIO_INTERP1_PEEK_LANE0),
+                    ==, 255);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-sio/reset-values", test_sio_reset_values);
+    qtest_add_func("/rp2040-sio/gpio-alias-registers",
+                   test_sio_gpio_alias_registers);
+    qtest_add_func("/rp2040-sio/fifo-empty-read-sets-roe",
+                   test_sio_fifo_empty_read_sets_roe);
+    qtest_add_func("/rp2040-sio/spinlock-claim-release",
+                   test_sio_spinlock_claim_release);
+    qtest_add_func("/rp2040-sio/interp-mask-and-sign",
+                   test_sio_interp_mask_and_sign);
+    qtest_add_func("/rp2040-sio/interp-pop-cross-result",
+                   test_sio_interp_pop_cross_result);
+    qtest_add_func("/rp2040-sio/interp-blend", test_sio_interp_blend);
+    qtest_add_func("/rp2040-sio/interp-clamp", test_sio_interp_clamp);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/rp2040-sysinfo-syscfg-test.c b/tests/qtest/rp2040-sysinfo-syscfg-test.c
new file mode 100644
index 0000000000..7440c3570b
--- /dev/null
+++ b/tests/qtest/rp2040-sysinfo-syscfg-test.c
@@ -0,0 +1,177 @@
+/*
+ * QTest testcase for the RP2040 sysinfo and syscfg blocks.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define SYSINFO_BASE                  0x40000000
+#define SYSINFO_CHIP_ID               0x00
+#define SYSINFO_PLATFORM              0x04
+#define SYSINFO_GITREF_RP2040         0x40
+
+#define SYSINFO_PLATFORM_ASIC         BIT(1)
+
+#define SYSCFG_BASE                   0x40004000
+#define SYSCFG_PROC0_NMI_MASK         0x00
+#define SYSCFG_PROC1_NMI_MASK         0x04
+#define SYSCFG_PROC_CONFIG            0x08
+#define SYSCFG_PROC_IN_SYNC_BYPASS    0x0c
+#define SYSCFG_PROC_IN_SYNC_BYPASS_HI 0x10
+#define SYSCFG_DBGFORCE               0x14
+#define SYSCFG_MEMPOWERDOWN           0x18
+
+#define SRAM0_BASE                    0x20000000
+#define UART0_BASE                    0x40034000
+#define UARTDR                        0x00
+#define UARTCR                        0x30
+#define UARTIMSC                      0x38
+#define UARTICR                       0x44
+#define UART_INT_TX                   BIT(5)
+#define UART0_IRQ                     20
+#define NVIC_ISPR                     0xe000e200
+#define NVIC_ICPR                     0xe000e280
+#define NVIC_ICSR                     0xe000ed04
+#define NVIC_ICSR_NMIPENDSET          BIT(31)
+
+#define PROC_CONFIG_RESET             0x10000000
+#define DBGFORCE_RESET                0x00000066
+
+#define ATOMIC_SET_ALIAS              0x2000
+#define ATOMIC_CLR_ALIAS              0x3000
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_sysinfo_read_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_CHIP_ID), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_PLATFORM), ==,
+                    SYSINFO_PLATFORM_ASIC);
+    g_assert_cmphex(qtest_readl(qts, SYSINFO_BASE + SYSINFO_GITREF_RP2040),
+                    ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK),
+                    ==, 0);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC_CONFIG), ==,
+                    PROC_CONFIG_RESET);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_DBGFORCE), ==,
+                    DBGFORCE_RESET);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_rw_masks(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0xa5a5a5a5);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK, 0x5a5a5a5a);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0xa5a5a5a5);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC1_NMI_MASK),
+                    ==, 0x5a5a5a5a);
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS, 0xffffffff);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI,
+                 0xffffffff);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                                SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS),
+                    ==, 0x3fffffff);
+    g_assert_cmphex(qtest_readl(qts,
+                                SYSCFG_BASE + SYSCFG_PROC_IN_SYNC_BYPASS_HI),
+                    ==, 0x0000003f);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN), ==,
+                    0x000000ff);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_atomic_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, 0);
+    qtest_writel(qts, SYSCFG_BASE + ATOMIC_SET_ALIAS + SYSCFG_PROC0_NMI_MASK,
+                 0x0000000f);
+    qtest_writel(qts, SYSCFG_BASE + ATOMIC_CLR_ALIAS + SYSCFG_PROC0_NMI_MASK,
+                 0x00000003);
+    g_assert_cmphex(qtest_readl(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK),
+                    ==, 0x0000000c);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_mempowerdown_blocks_sram(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, SRAM0_BASE, 0x11223344);
+    g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), ==, 0x11223344);
+
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, BIT(0));
+    qtest_writel(qts, SRAM0_BASE, 0xaabbccdd);
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_MEMPOWERDOWN, 0);
+
+    g_assert_cmphex(qtest_readl(qts, SRAM0_BASE), ==, 0x11223344);
+
+    qtest_quit(qts);
+}
+
+static void test_syscfg_nmi_mask_routes_uart0_irq(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, UART0_BASE + UARTCR, BIT(0) | BIT(8));
+    qtest_writel(qts, UART0_BASE + UARTIMSC, UART_INT_TX);
+
+    qtest_writel(qts, UART0_BASE + UARTICR, UART_INT_TX);
+    qtest_writel(qts, NVIC_ICPR, BIT(UART0_IRQ));
+    qtest_writel(qts, UART0_BASE + UARTDR, 'a');
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & BIT(UART0_IRQ), ==,
+                    BIT(UART0_IRQ));
+
+    qtest_writel(qts, UART0_BASE + UARTICR, UART_INT_TX);
+    qtest_writel(qts, NVIC_ICPR, BIT(UART0_IRQ));
+    qtest_writel(qts, SYSCFG_BASE + SYSCFG_PROC0_NMI_MASK, BIT(UART0_IRQ));
+    qtest_writel(qts, UART0_BASE + UARTDR, 'b');
+    g_assert_cmphex(qtest_readl(qts, NVIC_ISPR) & BIT(UART0_IRQ), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, NVIC_ICSR) & NVIC_ICSR_NMIPENDSET, ==,
+                    NVIC_ICSR_NMIPENDSET);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-sysinfo/read-values", test_sysinfo_read_values);
+    qtest_add_func("/rp2040-syscfg/reset-values", test_syscfg_reset_values);
+    qtest_add_func("/rp2040-syscfg/rw-masks", test_syscfg_rw_masks);
+    qtest_add_func("/rp2040-syscfg/atomic-aliases",
+                   test_syscfg_atomic_aliases);
+    qtest_add_func("/rp2040-syscfg/mempowerdown-blocks-sram",
+                   test_syscfg_mempowerdown_blocks_sram);
+    qtest_add_func("/rp2040-syscfg/nmi-mask-routes-uart0-irq",
+                   test_syscfg_nmi_mask_routes_uart0_irq);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/rp2040-tbman-test.c b/tests/qtest/rp2040-tbman-test.c
new file mode 100644
index 0000000000..a05eb3c3e2
--- /dev/null
+++ b/tests/qtest/rp2040-tbman-test.c
@@ -0,0 +1,32 @@
+/*
+ * QTest testcase for the RP2040 testbench manager block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define TBMAN_BASE          0x4006c000
+#define TBMAN_PLATFORM      0x00
+#define TBMAN_PLATFORM_ASIC BIT(0)
+
+static void test_tbman_platform(void)
+{
+    QTestState *qts = qtest_init("-machine raspi-pico");
+
+    g_assert_cmphex(qtest_readl(qts, TBMAN_BASE + TBMAN_PLATFORM), ==,
+                    TBMAN_PLATFORM_ASIC);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-tbman/platform", test_tbman_platform);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/rp2040-vreg-test.c b/tests/qtest/rp2040-vreg-test.c
new file mode 100644
index 0000000000..b08bb16765
--- /dev/null
+++ b/tests/qtest/rp2040-vreg-test.c
@@ -0,0 +1,79 @@
+/*
+ * QTest testcase for the RP2040 vreg_and_chip_reset block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define VREG_BASE           0x40064000
+#define VREG_VREG           0x00
+#define VREG_BOD            0x04
+#define VREG_CHIP_RESET     0x08
+
+#define VREG_ROK            BIT(12)
+#define VREG_RESET          0x000000b1
+#define BOD_RESET           0x00000091
+#define CHIP_RESET_RESCUE   BIT(24)
+
+#define ATOMIC_SET_ALIAS    0x2000
+#define ATOMIC_CLR_ALIAS    0x3000
+
+static QTestState *rp2040_start(void)
+{
+    return qtest_init("-machine raspi-pico");
+}
+
+static void test_vreg_reset_values(void)
+{
+    QTestState *qts = rp2040_start();
+
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_VREG), ==,
+                    VREG_RESET | VREG_ROK);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_BOD), ==, BOD_RESET);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_CHIP_RESET), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_vreg_rw_masks(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, VREG_BASE + VREG_VREG, 0xffffffff);
+    qtest_writel(qts, VREG_BASE + VREG_BOD, 0xffffffff);
+    qtest_writel(qts, VREG_BASE + VREG_CHIP_RESET, 0xffffffff);
+
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_VREG), ==, 0x000000f3);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_BOD), ==, 0x000000f1);
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_CHIP_RESET), ==,
+                    CHIP_RESET_RESCUE);
+
+    qtest_quit(qts);
+}
+
+static void test_vreg_atomic_aliases(void)
+{
+    QTestState *qts = rp2040_start();
+
+    qtest_writel(qts, VREG_BASE + VREG_BOD, 0);
+    qtest_writel(qts, VREG_BASE + ATOMIC_SET_ALIAS + VREG_BOD, 0x00000011);
+    qtest_writel(qts, VREG_BASE + ATOMIC_CLR_ALIAS + VREG_BOD, 0x00000010);
+
+    g_assert_cmphex(qtest_readl(qts, VREG_BASE + VREG_BOD), ==, 0x00000001);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-vreg/reset-values", test_vreg_reset_values);
+    qtest_add_func("/rp2040-vreg/rw-masks", test_vreg_rw_masks);
+    qtest_add_func("/rp2040-vreg/atomic-aliases", test_vreg_atomic_aliases);
+
+    return g_test_run();
+}
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
diff --git a/tests/qtest/rp2040-xip-test.c b/tests/qtest/rp2040-xip-test.c
new file mode 100644
index 0000000000..9de4d645b8
--- /dev/null
+++ b/tests/qtest/rp2040-xip-test.c
@@ -0,0 +1,212 @@
+/*
+ * QTest testcase for the RP2040 XIP/SSI block.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define XIP_BASE     0x10000000
+#define XIP_NOCACHE_NOALLOC_BASE 0x13000000
+#define XIP_CTRL_BASE 0x14000000
+#define XIP_AUX_BASE 0x50400000
+#define XIP_STAT     0x08
+#define XIP_STREAM_ADDR 0x14
+#define XIP_STREAM_CTR  0x18
+#define XIP_STREAM_FIFO 0x1c
+#define XIP_SSI_BASE 0x18000000
+#define SSI_CTRLR1   0x04
+#define SSI_SSIENR   0x08
+#define SSI_DR0      0x60
+#define SSI_SER      0x10
+#define SSI_DMACR    0x4c
+
+#define XIP_STAT_FIFO_FULL  BIT(2)
+#define XIP_STAT_FIFO_EMPTY BIT(1)
+#define XIP_STAT_FLUSH_READY BIT(0)
+
+#define DMA_BASE                0x50000000
+#define DMA_CH_READ_ADDR        0x00
+#define DMA_CH_WRITE_ADDR       0x04
+#define DMA_CH_TRANS_COUNT      0x08
+#define DMA_CH_CTRL_TRIG        0x0c
+#define DMA_CTRL_BUSY           BIT(24)
+#define DMA_CTRL_BSWAP          BIT(22)
+#define DMA_CTRL_TREQ_SEL_SHIFT 15
+#define DMA_CTRL_INCR_WRITE     BIT(5)
+#define DMA_CTRL_DATA_SIZE_32   (2 << 2)
+#define DMA_CTRL_EN             BIT(0)
+#define DREQ_XIP_STREAM         37
+#define DREQ_XIP_SSIRX          39
+#define SRAM_BASE               0x20000000
+
+static QTestState *rp2040_start(const char *machine_args)
+{
+    if (machine_args) {
+        return qtest_initf("-machine raspi-pico,%s", machine_args);
+    }
+    return qtest_init("-machine raspi-pico");
+}
+
+static void read_flash_uid(QTestState *qts, uint8_t *uid)
+{
+    int i;
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x4b);
+    qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+    for (i = 0; i < 4; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0);
+        qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+    }
+    for (i = 0; i < 8; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0);
+        uid[i] = qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+    }
+}
+
+static void program_flash_bytes(QTestState *qts, uint32_t off,
+                                const uint8_t *buf, size_t len)
+{
+    size_t i;
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x06);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x02);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 16, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 8, 8));
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, extract32(off, 0, 8));
+    for (i = 0; i < len; i++) {
+        qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, buf[i]);
+    }
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SER, 0);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0x05);
+    qtest_readl(qts, XIP_SSI_BASE + SSI_DR0);
+}
+
+static void test_flash_uid_default(void)
+{
+    static const uint8_t expected[] = {
+        0x3e, 0xb8, 0xa7, 0x49, 0x3f, 0xcc, 0x06, 0x08,
+    };
+    QTestState *qts = rp2040_start(NULL);
+    uint8_t uid[8];
+
+    read_flash_uid(qts, uid);
+    g_assert_cmpmem(uid, sizeof(uid), expected, sizeof(expected));
+
+    qtest_quit(qts);
+}
+
+static void test_flash_uid_machine_option(void)
+{
+    static const uint8_t expected[] = {
+        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
+    };
+    QTestState *qts = rp2040_start("flash-uid=0011223344556677");
+    uint8_t uid[8];
+
+    read_flash_uid(qts, uid);
+    g_assert_cmpmem(uid, sizeof(uid), expected, sizeof(expected));
+
+    qtest_quit(qts);
+}
+
+static void test_stream_fifo_and_dma(void)
+{
+    static const uint32_t expected[] = {
+        0x03020100, 0x07060504, 0x0b0a0908, 0x0f0e0d0c,
+        0x13121110, 0x17161514,
+    };
+    QTestState *qts = rp2040_start(NULL);
+    uint32_t ctrl;
+    uint32_t buf[ARRAY_SIZE(expected)];
+
+    program_flash_bytes(qts, 0, (const uint8_t *)expected, sizeof(expected));
+
+    qtest_writel(qts, XIP_CTRL_BASE + XIP_STREAM_ADDR, XIP_BASE);
+    qtest_writel(qts, XIP_CTRL_BASE + XIP_STREAM_CTR, ARRAY_SIZE(expected));
+
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STAT) &
+                    (XIP_STAT_FLUSH_READY | XIP_STAT_FIFO_FULL), ==,
+                    XIP_STAT_FLUSH_READY | XIP_STAT_FIFO_FULL);
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STREAM_FIFO), ==,
+                    expected[0]);
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STREAM_FIFO), ==,
+                    expected[1]);
+
+    ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_WRITE | DMA_CTRL_DATA_SIZE_32 |
+           (DREQ_XIP_STREAM << DMA_CTRL_TREQ_SEL_SHIFT);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, XIP_AUX_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, ARRAY_SIZE(expected) - 2);
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    qtest_memread(qts, SRAM_BASE, buf,
+                  sizeof(buf[0]) * (ARRAY_SIZE(expected) - 2));
+    g_assert_cmpmem(buf, sizeof(buf[0]) * (ARRAY_SIZE(expected) - 2),
+                    expected + 2,
+                    sizeof(expected[0]) * (ARRAY_SIZE(expected) - 2));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STREAM_CTR), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, XIP_CTRL_BASE + XIP_STAT) &
+                    XIP_STAT_FIFO_EMPTY, ==, XIP_STAT_FIFO_EMPTY);
+
+    qtest_quit(qts);
+}
+
+static void test_ssi_rx_dma_bulk_read(void)
+{
+    static const uint32_t expected[] = {
+        0x03020100, 0x07060504, 0x0b0a0908, 0x0f0e0d0c,
+        0x13121110, 0x17161514,
+    };
+    QTestState *qts = rp2040_start(NULL);
+    uint32_t ctrl;
+    uint32_t buf[ARRAY_SIZE(expected)];
+
+    program_flash_bytes(qts, 0, (const uint8_t *)expected, sizeof(expected));
+    g_assert_cmphex(qtest_readl(qts, XIP_NOCACHE_NOALLOC_BASE), ==,
+                    expected[0]);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SSIENR, 0);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_CTRLR1, ARRAY_SIZE(expected) - 1);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DMACR, 3);
+    qtest_writel(qts, XIP_SSI_BASE + SSI_SSIENR, 1);
+
+    ctrl = DMA_CTRL_EN | DMA_CTRL_INCR_WRITE | DMA_CTRL_DATA_SIZE_32 |
+           DMA_CTRL_BSWAP | (DREQ_XIP_SSIRX << DMA_CTRL_TREQ_SEL_SHIFT);
+    qtest_writel(qts, DMA_BASE + DMA_CH_READ_ADDR, XIP_SSI_BASE + SSI_DR0);
+    qtest_writel(qts, DMA_BASE + DMA_CH_WRITE_ADDR, SRAM_BASE);
+    qtest_writel(qts, DMA_BASE + DMA_CH_TRANS_COUNT, ARRAY_SIZE(expected));
+    qtest_writel(qts, DMA_BASE + DMA_CH_CTRL_TRIG, ctrl);
+
+    qtest_writel(qts, XIP_SSI_BASE + SSI_DR0, 0xa0);
+
+    qtest_memread(qts, SRAM_BASE, buf, sizeof(buf));
+    g_assert_cmpmem(buf, sizeof(buf), expected, sizeof(expected));
+    g_assert_cmphex(qtest_readl(qts, DMA_BASE + DMA_CH_CTRL_TRIG) &
+                    DMA_CTRL_BUSY, ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/rp2040-xip/flash-uid-default",
+                   test_flash_uid_default);
+    qtest_add_func("/rp2040-xip/flash-uid-machine-option",
+                   test_flash_uid_machine_option);
+    qtest_add_func("/rp2040-xip/stream-fifo-and-dma",
+                   test_stream_fifo_and_dma);
+    qtest_add_func("/rp2040-xip/ssi-rx-dma-bulk-read",
+                   test_ssi_rx_dma_bulk_read);
+
+    return g_test_run();
+}
-- 
2.53.0


