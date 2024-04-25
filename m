Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDF6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWj-0002U9-8c; Thu, 25 Apr 2024 06:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWe-0002Lv-D8
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWc-0007GT-25
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34c1fff534fso190401f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041620; x=1714646420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yAS9t3kk5A9x2Pjb3tQZcenEOZB0rJVuXlQHac+bEsM=;
 b=IalBA5X2Rp+GGU1Do5ZCjjs3CZv0HJ22BPBb8RK+pH/zji1VCRZLca7gGIMmhMzFap
 662vafy8h4rBa9tzY7F526or7A7j9wJiZFm10ClVgQyQZ92aLaAIkUngghPTNbDsWtQB
 OpAPGgu+V5p6KqQuhtqUDsnKHm07n415UIL1Dln+sj6oCpgurLh0zOWSB6JZMFjlvzv+
 DArCLkpNfC5rBH5hF42BQwCMVqTS7fm3GicZMrLPak5VOS/2CE2fVZWKlJBL6MC5MB5/
 aiPAa8jchR2Dy2EcXsW7xuEOK+y0kyaE7lX9oT23PNQzJI9nXUmNjDaZsXbJPem3GJxo
 k1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041620; x=1714646420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAS9t3kk5A9x2Pjb3tQZcenEOZB0rJVuXlQHac+bEsM=;
 b=tm/LqvsLfjEZSemgu1sx4Pte83AQxx082wzf5DKWzcMs5RaBadhLfk5JEHnBxUxpfC
 mAf9Ftg/5e2rJmEVCHO2kXcnHqWPrR/JQUZ/a+2oXpY9ZNwHB989j3oyNXkeAbL9KOBt
 yJ4xry8ZmZwnaE+Vm1BPHbA1gImV3gjouaHoaxgm9aQZasxsLVOXc2HmyeSEK07UojCY
 Vf/vS9CwCL08dNJqe60/Ws1jRhkxY/ru7/w5X2DCAPiG43GVHKawuQR59e4eEMoGsRVv
 o1BNZJzGzModoOCsJLjnuuJwjMSoNufe/erinYt46VkbBNkawU5fcvtaMW7ALKgiT4iL
 p9Rw==
X-Gm-Message-State: AOJu0YwvUcGUBJrrwOVj/7AwXOhzs71aE64pSWMcGaHTj0GV5Ol/vl2A
 gyhXXIiWkBeO/uV9Y5cDDO47NOJvp4OClFMCewRd5wv2krLmz8BTkCIMEt3Rb8wUwpT4X1morcN
 C
X-Google-Smtp-Source: AGHT+IGCt3qRshf3yX4MYpDrl2XdVddBcxjrxq6OR3ijFrubGiZJocyBJcm/r2YNmR0Fev0jl1oSnQ==
X-Received: by 2002:adf:c04c:0:b0:349:eb59:c177 with SMTP id
 c12-20020adfc04c000000b00349eb59c177mr3540132wrf.11.1714041620518; 
 Thu, 25 Apr 2024 03:40:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/37] tests/qtest: Add tests for the STM32L4x5 USART
Date: Thu, 25 Apr 2024 11:39:58 +0100
Message-Id: <20240425103958.3237225-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

Test:
- read/write from/to the usart registers
- send/receive a character/string over the serial port

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240329174402.60382-6-arnaud.minier@telecom-paris.fr
[PMM: fix checkpatch nits, remove commented out code]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_usart-test.c | 315 +++++++++++++++++++++++++++++
 tests/qtest/meson.build            |   4 +-
 2 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_usart-test.c

diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
new file mode 100644
index 00000000000..89025182331
--- /dev/null
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -0,0 +1,315 @@
+/*
+ * QTest testcase for STML4X5_USART
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/stm32l4x5_rcc_internals.h"
+#include "hw/registerfields.h"
+
+#define RCC_BASE_ADDR 0x40021000
+/* Use USART 1 ADDR, assume the others work the same */
+#define USART1_BASE_ADDR 0x40013800
+
+/* See stm32l4x5_usart for definitions */
+REG32(CR1, 0x00)
+    FIELD(CR1, M1, 28, 1)
+    FIELD(CR1, OVER8, 15, 1)
+    FIELD(CR1, M0, 12, 1)
+    FIELD(CR1, PCE, 10, 1)
+    FIELD(CR1, TXEIE, 7, 1)
+    FIELD(CR1, RXNEIE, 5, 1)
+    FIELD(CR1, TE, 3, 1)
+    FIELD(CR1, RE, 2, 1)
+    FIELD(CR1, UE, 0, 1)
+REG32(CR2, 0x04)
+REG32(CR3, 0x08)
+    FIELD(CR3, OVRDIS, 12, 1)
+REG32(BRR, 0x0C)
+REG32(GTPR, 0x10)
+REG32(RTOR, 0x14)
+REG32(RQR, 0x18)
+REG32(ISR, 0x1C)
+    FIELD(ISR, TXE, 7, 1)
+    FIELD(ISR, RXNE, 5, 1)
+    FIELD(ISR, ORE, 3, 1)
+REG32(ICR, 0x20)
+REG32(RDR, 0x24)
+REG32(TDR, 0x28)
+
+#define NVIC_ISPR1 0XE000E204
+#define NVIC_ICPR1 0xE000E284
+#define USART1_IRQ 37
+
+static bool check_nvic_pending(QTestState *qts, unsigned int n)
+{
+    /* No USART interrupts are less than 32 */
+    assert(n > 32);
+    n -= 32;
+    return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
+}
+
+static bool clear_nvic_pending(QTestState *qts, unsigned int n)
+{
+    /* No USART interrupts are less than 32 */
+    assert(n > 32);
+    n -= 32;
+    qtest_writel(qts, NVIC_ICPR1, (1 << n));
+    return true;
+}
+
+/*
+ * Wait indefinitely for the flag to be updated.
+ * If this is run on a slow CI runner,
+ * the meson harness will timeout after 10 minutes for us.
+ */
+static bool usart_wait_for_flag(QTestState *qts, uint32_t event_addr,
+                                uint32_t flag)
+{
+    while (true) {
+        if ((qtest_readl(qts, event_addr) & flag)) {
+            return true;
+        }
+        g_usleep(1000);
+    }
+
+    return false;
+}
+
+static void usart_receive_string(QTestState *qts, int sock_fd, const char *in,
+                                 char *out)
+{
+    int i, in_len = strlen(in);
+
+    g_assert_true(send(sock_fd, in, in_len, 0) == in_len);
+    for (i = 0; i < in_len; i++) {
+        g_assert_true(usart_wait_for_flag(qts,
+            USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK));
+        out[i] = qtest_readl(qts, USART1_BASE_ADDR + A_RDR);
+    }
+    out[i] = '\0';
+}
+
+static void usart_send_string(QTestState *qts, const char *in)
+{
+    int i, in_len = strlen(in);
+
+    for (i = 0; i < in_len; i++) {
+        qtest_writel(qts, USART1_BASE_ADDR + A_TDR, in[i]);
+        g_assert_true(usart_wait_for_flag(qts,
+            USART1_BASE_ADDR + A_ISR, R_ISR_TXE_MASK));
+    }
+}
+
+/* Init the RCC clocks to run at 80 MHz */
+static void init_clocks(QTestState *qts)
+{
+    uint32_t value;
+
+    /* MSIRANGE can be set only when MSI is OFF or READY */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CR), R_CR_MSION_MASK);
+
+    /* Clocking from MSI, in case MSI was not the default source */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CFGR), 0);
+
+    /*
+     * Update PLL and set MSI as the source clock.
+     * PLLM = 1 --> 000
+     * PLLN = 40 --> 40
+     * PPLLR = 2 --> 00
+     * PLLDIV = unused, PLLP = unused (SAI3), PLLQ = unused (48M1)
+     * SRC = MSI --> 01
+     */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_PLLCFGR), R_PLLCFGR_PLLREN_MASK |
+            (40 << R_PLLCFGR_PLLN_SHIFT) |
+            (0b01 << R_PLLCFGR_PLLSRC_SHIFT));
+
+    /* PLL activation */
+
+    value = qtest_readl(qts, (RCC_BASE_ADDR + A_CR));
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CR), value | R_CR_PLLON_MASK);
+
+    /* RCC_CFGR is OK by defaut */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CFGR), 0);
+
+    /* CCIPR : no periph clock by default */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CCIPR), 0);
+
+    /* Switches on the PLL clock source */
+    value = qtest_readl(qts, (RCC_BASE_ADDR + A_CFGR));
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CFGR), (value & ~R_CFGR_SW_MASK) |
+        (0b11 << R_CFGR_SW_SHIFT));
+
+    /* Enable SYSCFG clock enabled */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_APB2ENR), R_APB2ENR_SYSCFGEN_MASK);
+
+    /* Enable the IO port B clock (See p.252) */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_AHB2ENR), R_AHB2ENR_GPIOBEN_MASK);
+
+    /* Enable the clock for USART1 (cf p.259) */
+    /* We rewrite SYSCFGEN to not disable it */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_APB2ENR),
+                 R_APB2ENR_SYSCFGEN_MASK | R_APB2ENR_USART1EN_MASK);
+
+    /* TODO: Enable usart via gpio */
+
+    /* Set PCLK as the clock for USART1(cf p.272) i.e. reset both bits */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CCIPR), 0);
+
+    /* Reset USART1 (see p.249) */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_APB2RSTR), 1 << 14);
+    qtest_writel(qts, (RCC_BASE_ADDR + A_APB2RSTR), 0);
+}
+
+static void init_uart(QTestState *qts)
+{
+    uint32_t cr1;
+
+    init_clocks(qts);
+
+    /*
+     * For 115200 bauds, see p.1349.
+     * The clock has a frequency of 80Mhz,
+     * for 115200, we have to put a divider of 695 = 0x2B7.
+     */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_BRR), 0x2B7);
+
+    /*
+     * Set the oversampling by 16,
+     * disable the parity control and
+     * set the word length to 8. (cf p.1377)
+     */
+    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 &= ~(R_CR1_M1_MASK | R_CR1_M0_MASK | R_CR1_OVER8_MASK | R_CR1_PCE_MASK);
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1), cr1);
+
+    /* Enable the transmitter, the receiver and the USART. */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
+        R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
+}
+
+static void test_write_read(void)
+{
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    /* Test that we can write and retrieve a value from the device */
+    qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 0xFFFFFFFF);
+    const uint32_t tdr = qtest_readl(qts, USART1_BASE_ADDR + A_TDR);
+    g_assert_cmpuint(tdr, ==, 0x000001FF);
+}
+
+static void test_receive_char(void)
+{
+    int sock_fd;
+    uint32_t cr1;
+    QTestState *qts = qtest_init_with_serial("-M b-l475e-iot01a", &sock_fd);
+
+    init_uart(qts);
+
+    /* Try without initializing IRQ */
+    g_assert_true(send(sock_fd, "a", 1, 0) == 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), ==, 'a');
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+
+    /* Now with the IRQ */
+    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 |= R_CR1_RXNEIE_MASK;
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, cr1);
+    g_assert_true(send(sock_fd, "b", 1, 0) == 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), ==, 'b');
+    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
+    clear_nvic_pending(qts, USART1_IRQ);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
+static void test_send_char(void)
+{
+    int sock_fd;
+    char s[1];
+    uint32_t cr1;
+    QTestState *qts = qtest_init_with_serial("-M b-l475e-iot01a", &sock_fd);
+
+    init_uart(qts);
+
+    /* Try without initializing IRQ */
+    qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'c');
+    g_assert_true(recv(sock_fd, s, 1, 0) == 1);
+    g_assert_cmphex(s[0], ==, 'c');
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+
+    /* Now with the IRQ */
+    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 |= R_CR1_TXEIE_MASK;
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, cr1);
+    qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'd');
+    g_assert_true(recv(sock_fd, s, 1, 0) == 1);
+    g_assert_cmphex(s[0], ==, 'd');
+    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
+    clear_nvic_pending(qts, USART1_IRQ);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
+static void test_receive_str(void)
+{
+    int sock_fd;
+    char s[10];
+    QTestState *qts = qtest_init_with_serial("-M b-l475e-iot01a", &sock_fd);
+
+    init_uart(qts);
+
+    usart_receive_string(qts, sock_fd, "hello", s);
+    g_assert_true(memcmp(s, "hello", 5) == 0);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
+static void test_send_str(void)
+{
+    int sock_fd;
+    char s[10];
+    QTestState *qts = qtest_init_with_serial("-M b-l475e-iot01a", &sock_fd);
+
+    init_uart(qts);
+
+    usart_send_string(qts, "world");
+    g_assert_true(recv(sock_fd, s, 10, 0) == 5);
+    g_assert_true(memcmp(s, "world", 5) == 0);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+    g_test_set_nonfatal_assertions();
+
+    qtest_add_func("stm32l4x5/usart/write_read", test_write_read);
+    qtest_add_func("stm32l4x5/usart/receive_char", test_receive_char);
+    qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
+    qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
+    qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    ret = g_test_run();
+
+    return ret;
+}
+
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 36c5c13a7bb..b128fa5a4bd 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -7,6 +7,7 @@ slow_qtests = {
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
   'qom-test' : 900,
+  'stm32l4x5_usart-test' : 600,
   'test-hmp' : 240,
   'pxe-test': 610,
   'prom-env-test': 360,
@@ -205,7 +206,8 @@ qtests_stm32l4x5 = \
   ['stm32l4x5_exti-test',
    'stm32l4x5_syscfg-test',
    'stm32l4x5_rcc-test',
-   'stm32l4x5_gpio-test']
+   'stm32l4x5_gpio-test',
+   'stm32l4x5_usart-test']
 
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
-- 
2.34.1


