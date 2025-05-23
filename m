Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F1DC54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 11:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIQi3-00087k-A0; Fri, 23 May 2025 07:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1uIQhz-00083k-0t; Fri, 23 May 2025 07:37:03 -0400
Received: from forward500d.mail.yandex.net ([2a02:6b8:c41:1300:1:45:d181:d500])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikita.shubin@maquefel.me>)
 id 1uIQht-0003g5-Ju; Fri, 23 May 2025 07:37:00 -0400
Received: from mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:4946:0:640:90b4:0])
 by forward500d.mail.yandex.net (Yandex) with ESMTPS id CFB4061319;
 Fri, 23 May 2025 14:36:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id kaOXlq9LjuQ0-DQOMmh0C; 
 Fri, 23 May 2025 14:36:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
 t=1748000211; bh=feFR28ur8iWV2E6dtw3gC5COSsFgqvfRjlNM0tviJLg=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=od7ApWyrtlh9/dy0kUZ8MdcEIU1i3GabeBGPfJHflzFAqyXmUlnDDTo9WqYhw7SqJ
 aDuHMVRSrSWQ6YKoSCV9Y1rVH5446lqOQ6/oIOxGEJny1eVTExrcatFIkml1EfgfyJ
 Ascl1nVG8xZ6JM+QEWYtuIluvs041U+nyVsI8Mpg=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.klg.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Ilya Chichkov <i.chichkov@yadro.com>,
 Nikita Shubin <n.shubin@yadro.com>
Subject: [PATCH v2 3/3] tests/qtest: add qtests for STM32 DMA
Date: Fri, 23 May 2025 14:36:47 +0300
Message-ID: <20250523113647.4388-4-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250523113647.4388-1-nikita.shubin@maquefel.me>
References: <20250523113647.4388-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:d500;
 envelope-from=nikita.shubin@maquefel.me; helo=forward500d.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nikita Shubin <n.shubin@yadro.com>

Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
 tests/qtest/meson.build      |   1 +
 tests/qtest/stm32-dma-test.c | 421 +++++++++++++++++++++++++++++++++++
 2 files changed, 422 insertions(+)
 create mode 100644 tests/qtest/stm32-dma-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 3136d15e0f..5cd14d3cfd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -239,6 +239,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_STM32F100_SOC') ? ['stm32-dma-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
diff --git a/tests/qtest/stm32-dma-test.c b/tests/qtest/stm32-dma-test.c
new file mode 100644
index 0000000000..36c9898756
--- /dev/null
+++ b/tests/qtest/stm32-dma-test.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QTest testcase for STM32 DMA engine.
+ *
+ * This includes STM32F1xxxx, STM32F2xxxx and GD32F30x
+ *
+ * Author: 2025 Nikita Shubin <n.shubin@yadro.com>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "libqtest-single.h"
+#include "libqos/libqos.h"
+
+/* Offsets in stm32vldiscovery platform: */
+#define DMA_BASE    0x40020000
+#define SRAM_BASE   0x20000000
+
+/* Global interrupt flag */
+#define DMA_ISR_GIF   BIT(0)
+/* Full transfer finish */
+#define DMA_ISR_TCIF  BIT(1)
+/* Half transfer finish */
+#define DMA_ISR_HTIF  BIT(2)
+/* Transfer error */
+#define DMA_ISR_TEIF  BIT(3)
+
+/* Used register/fields definitions */
+#define DMA_CCR(idx)     (0x08 + 0x14 * idx)
+#define DMA_CNDTR(idx)   (0x0C + 0x14 * idx)
+#define DMA_CPAR(idx)    (0x10 + 0x14 * idx)
+#define DMA_CMAR(idx)    (0x14 + 0x14 * idx)
+
+#define DMA_MAX_CHAN    7
+
+/* Register offsets for a dma chan0 within a dma block. */
+#define DMA_CHAN(_idx, _irq)  \
+    { \
+        .ccr = DMA_CCR(_idx), \
+        .cndrt = DMA_CNDTR(_idx), \
+        .cpar = DMA_CPAR(_idx), \
+        .cmar = DMA_CMAR(_idx), \
+        .irq_line = _irq,\
+    }
+
+typedef struct DMAChan {
+    uint32_t ccr;
+    uint32_t cndrt;
+    uint32_t cpar;
+    uint32_t cmar;
+    uint8_t irq_line;
+} DMAChan;
+
+const DMAChan dma_chans[] = {
+    DMA_CHAN(0, 11),
+    DMA_CHAN(1, 12),
+    DMA_CHAN(2, 12),
+    DMA_CHAN(3, 13),
+    DMA_CHAN(4, 14),
+    DMA_CHAN(5, 16),
+    DMA_CHAN(6, 17),
+};
+
+/* Register offsets for a dma within a dma block. */
+typedef struct DMA {
+    uint32_t base_addr;
+    uint32_t isr;
+    uint32_t ofcr;
+} DMA;
+
+const DMA dma = {
+    .base_addr = DMA_BASE,
+    .isr = 0x00,
+    .ofcr = 0x04,
+};
+
+typedef struct TestData {
+    QTestState *qts;
+    const DMA *dma;
+    const DMAChan *chans;
+} TestData;
+
+#define NVIC_ISER 0xE000E100
+#define NVIC_ISPR 0xE000E200
+#define NVIC_ICPR 0xE000E280
+
+static void enable_nvic_irq(unsigned int n)
+{
+    writel(NVIC_ISER, 1 << n);
+}
+
+static void unpend_nvic_irq(unsigned int n)
+{
+    writel(NVIC_ICPR, 1 << n);
+}
+
+static bool check_nvic_pending(unsigned int n)
+{
+    return readl(NVIC_ISPR) & (1 << n);
+}
+
+static uint32_t dma_read(const TestData *td, uint32_t offset)
+{
+    return qtest_readl(td->qts, td->dma->base_addr + offset);
+}
+
+static void dma_write(const TestData *td, uint32_t offset, uint32_t value)
+{
+    qtest_writel(td->qts, td->dma->base_addr + offset, value);
+}
+
+static void dma_write_ofcr(const TestData *td, uint32_t value)
+{
+    return dma_write(td, td->dma->ofcr, value);
+}
+
+static uint32_t dma_read_isr(const TestData *td)
+{
+    return dma_read(td, td->dma->isr);
+}
+
+static void dma_write_ccr(const TestData *td, uint8_t idx, uint32_t value)
+{
+    dma_write(td, td->chans[idx].ccr, value);
+}
+
+static uint32_t dma_read_ccr(const TestData *td, uint8_t idx)
+{
+    return dma_read(td, td->chans[idx].ccr);
+}
+
+static void dma_write_cndrt(const TestData *td, uint8_t idx, uint32_t value)
+{
+    dma_write(td, td->chans[idx].cndrt, value);
+}
+
+static void dma_write_cpar(const TestData *td, uint8_t idx, uint32_t value)
+{
+    dma_write(td, td->chans[idx].cpar, value);
+}
+
+static void dma_write_cmar(const TestData *td, uint8_t idx, uint32_t value)
+{
+    dma_write(td, td->chans[idx].cmar, value);
+}
+
+static void test_m2m(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    QTestState *s = td->qts;
+    const uint32_t patt_len = 0xff;
+    g_autofree char *pattern_check = g_malloc(patt_len);
+    g_autofree char *pattern = g_malloc(patt_len);
+    uint8_t idx = 0;
+    uint32_t val;
+
+    enable_nvic_irq(td->chans[idx].irq_line);
+    qtest_irq_intercept_in(global_qtest, "/machine/soc/dma[0]");
+
+    /* write addr */
+    dma_write_cpar(td, idx, SRAM_BASE);
+    dma_write_cmar(td, idx, SRAM_BASE + patt_len);
+
+    /* enable increment and M2M */
+    val = dma_read_ccr(td, idx);
+    val |= BIT(1); /* TCIE */
+    val |= BIT(6); /* PINC */
+    val |= BIT(7); /* MINC */
+    val |= BIT(14); /* M2M */
+    dma_write_ccr(td, idx, val);
+
+    generate_pattern(pattern, patt_len, patt_len);
+    qtest_memwrite(s, SRAM_BASE, pattern, patt_len);
+
+    dma_write_cndrt(td, idx, patt_len);
+
+    val |= BIT(0); /* enable channel */
+    dma_write_ccr(td, idx, val);
+
+    qtest_memread(s, SRAM_BASE + patt_len, pattern_check, patt_len);
+
+    g_assert(memcmp(pattern, pattern_check, patt_len) == 0);
+
+    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
+}
+
+typedef struct width_pattern {
+    uint32_t src;
+    uint8_t swidth;
+    uint32_t dst;
+    uint8_t dwidth;
+} width_pattern;
+
+static void test_width(gconstpointer test_data)
+{
+    const width_pattern patterns[] = {
+        { 0xb0,       1, 0xb0,       1 },
+        { 0xb0,       1, 0x00b0,     2 },
+        { 0xb0,       1, 0x000000b0, 4 },
+        { 0xb1b0,     2, 0xb0,       1 },
+        { 0xb1b0,     2, 0xb1b0,     2 },
+        { 0xb1b0,     2, 0x0000b1b0, 4 },
+        { 0xb3b2b1b0, 4, 0xb0,       1 },
+        { 0xb3b2b1b0, 4, 0xb1b0,     2 },
+        { 0xb3b2b1b0, 4, 0xb3b2b1b0, 4 },
+    };
+
+    const TestData *td = test_data;
+    QTestState *s = td->qts;
+    const uint32_t patt = 0xffffffff;
+    const uint32_t patt_len = 4;
+    uint8_t idx = 0;
+    uint32_t dst;
+    uint32_t val;
+    QDict *resp;
+
+    resp = qmp("{'execute':'system_reset' }");
+    qobject_unref(resp);
+
+    /* write addr */
+    dma_write_cpar(td, idx, SRAM_BASE);
+    dma_write_cmar(td, idx, SRAM_BASE + patt_len);
+
+    /* enable increment and M2M */
+    val = dma_read_ccr(td, idx);
+    val |= BIT(6); /* PINC */
+    val |= BIT(7); /* MINC */
+    val |= BIT(14); /* M2M */
+    dma_write_ccr(td, idx, val);
+
+    for (int i = 0; i < ARRAY_SIZE(patterns); i++) {
+        /* fill destination and source with pattern */
+        qtest_memwrite(s, SRAM_BASE, &patt, patt_len);
+        qtest_memwrite(s, SRAM_BASE + patt_len, &patt, patt_len);
+
+        qtest_memwrite(s, SRAM_BASE, &patterns[i].src, patterns[i].swidth);
+
+        dma_write_cndrt(td, idx, 1);
+        val |= BIT(0); /* enable channel */
+        val = deposit32(val, 8, 2, patterns[i].swidth >> 1);
+        val = deposit32(val, 10, 2, patterns[i].dwidth >> 1);
+        dma_write_ccr(td, idx, val);
+
+        qtest_memread(s, SRAM_BASE + patt_len, &dst, patterns[i].dwidth);
+
+        g_assert(memcmp(&dst, &patterns[i].dst, patterns[i].dwidth) == 0);
+
+        /* disable chan */
+        val &= ~BIT(0);
+        dma_write_ccr(td, idx, val);
+    }
+}
+
+static void dma_set_irq(unsigned int idx, int num, int level)
+{
+    g_autofree char *name = g_strdup_printf("/machine/soc/dma[%u]",
+                                            idx);
+    qtest_set_irq_in(global_qtest, name, NULL, num, level);
+}
+
+static void test_triggers(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    QTestState *s = td->qts;
+    const uint32_t patt = 0xffffffff;
+    const uint32_t patt_len = 4;
+    uint32_t dst;
+    uint32_t val;
+    QDict *resp;
+
+    resp = qmp("{'execute':'system_reset' }");
+    qobject_unref(resp);
+
+    for (int i = 0; i < ARRAY_SIZE(dma_chans); i++) {
+        qtest_memset(s, SRAM_BASE, 0, patt_len * 2);
+        qtest_memwrite(s, SRAM_BASE, &patt, patt_len);
+
+        /* write addr */
+        dma_write_cpar(td, i, SRAM_BASE);
+        dma_write_cmar(td, i, SRAM_BASE + patt_len);
+
+        val = dma_read_ccr(td, i);
+
+        dma_write_cndrt(td, i, 1);
+        val |= BIT(0); /* enable channel */
+        val = deposit32(val, 8, 2, patt_len >> 1);
+        val = deposit32(val, 10, 2, patt_len >> 1);
+        dma_write_ccr(td, i, val);
+
+        dma_set_irq(0, i, 1);
+
+        qtest_memread(s, SRAM_BASE + patt_len, &dst, patt_len);
+
+        g_assert(memcmp(&dst, &patt, patt_len) == 0);
+
+        /* disable chan */
+        val &= ~BIT(0);
+        dma_write_ccr(td, i, val);
+    }
+}
+
+static void test_interrupts(gconstpointer test_data)
+{
+    const TestData *td = test_data;
+    const uint32_t patt_len = 1024;
+    uint8_t idx = 0;
+    uint32_t val;
+    QDict *resp;
+
+    resp = qmp("{'execute':'system_reset' }");
+    qobject_unref(resp);
+
+    enable_nvic_irq(td->chans[idx].irq_line);
+
+    /* write addr */
+    dma_write_cpar(td, idx, SRAM_BASE);
+    dma_write_cmar(td, idx, SRAM_BASE + patt_len);
+
+    /* write counter */
+    dma_write_cndrt(td, idx, 2);
+
+    /* enable increment and M2M */
+    val = dma_read_ccr(td, idx);
+    val |= BIT(0); /* EN */
+    val |= BIT(1); /* TCIE */
+    val |= BIT(2); /* HTIE */
+    val |= BIT(3); /* TEIE */
+    val |= BIT(6); /* PINC */
+    val |= BIT(7); /* MINC */
+    dma_write_ccr(td, idx, val);
+
+    /* Half-transfer */
+    dma_set_irq(0, idx, 1);
+    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
+    val = dma_read_isr(td);
+
+    g_assert_true(val & DMA_ISR_GIF);
+    g_assert_true(val & DMA_ISR_HTIF);
+    unpend_nvic_irq(td->chans[idx].irq_line);
+
+    dma_write_ofcr(td, 0xffffffff);
+    val = dma_read_isr(td);
+    g_assert_false(val & DMA_ISR_GIF);
+    g_assert_false(val & DMA_ISR_HTIF);
+
+    /* Full-transfer */
+    dma_set_irq(0, idx, 1);
+    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
+    val = dma_read_isr(td);
+
+    g_assert_true(val & DMA_ISR_GIF);
+    g_assert_true(val & DMA_ISR_HTIF);
+    g_assert_true(val & DMA_ISR_TCIF);
+    unpend_nvic_irq(td->chans[idx].irq_line);
+
+    dma_write_ofcr(td, 0xffffffff);
+    val = dma_read_isr(td);
+    g_assert_false(val & DMA_ISR_GIF);
+    g_assert_false(val & DMA_ISR_HTIF);
+    g_assert_false(val & DMA_ISR_TCIF);
+
+    /* Error-on-transfer */
+    val = dma_read_ccr(td, idx);
+    val &= ~BIT(0);
+    dma_write_ccr(td, idx, val);
+
+    dma_write_cndrt(td, idx, 1);
+    dma_write_cpar(td, idx, 0xffffffff);
+
+    val |= BIT(0);
+    dma_write_ccr(td, idx, val);
+
+    dma_set_irq(0, idx, 1);
+    g_assert_true(check_nvic_pending(td->chans[idx].irq_line));
+    val = dma_read_isr(td);
+
+    g_assert_true(val & DMA_ISR_GIF);
+    g_assert_true(val & DMA_ISR_TEIF);
+    unpend_nvic_irq(td->chans[idx].irq_line);
+
+    dma_write_ofcr(td, 0xffffffff);
+    val = dma_read_isr(td);
+    g_assert_false(val & DMA_ISR_GIF);
+    g_assert_false(val & DMA_ISR_TEIF);
+}
+
+static void stm32_add_test(const char *name, const TestData *td,
+                           GTestDataFunc fn)
+{
+    g_autofree char *full_name = g_strdup_printf(
+        "stm32_dma/%s", name);
+    qtest_add_data_func(full_name, td, fn);
+}
+
+/* Convenience macro for adding a test with a predictable function name. */
+#define add_test(name, td) stm32_add_test(#name, td, test_##name)
+
+int main(int argc, char **argv)
+{
+    TestData testdata;
+    QTestState *s;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    s = qtest_start("-machine stm32vldiscovery");
+    g_test_set_nonfatal_assertions();
+
+    TestData *td = &testdata;
+    td->qts = s;
+    td->dma = &dma;
+    td->chans = dma_chans;
+    add_test(m2m, td);
+    add_test(width, td);
+    add_test(triggers, td);
+    add_test(interrupts, td);
+
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
-- 
2.48.1


