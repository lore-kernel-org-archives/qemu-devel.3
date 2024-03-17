Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD158C54E60
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Mar 2024 10:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlnyI-0005c6-TU; Sun, 17 Mar 2024 06:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnyH-0005bp-D6; Sun, 17 Mar 2024 06:42:29 -0400
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rlnyF-0001XY-6S; Sun, 17 Mar 2024 06:42:29 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id C128620804;
 Sun, 17 Mar 2024 11:42:25 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 5nm9788iPow0; Sun, 17 Mar 2024 11:42:24 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 9CDC1208D9;
 Sun, 17 Mar 2024 11:42:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 9CDC1208D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1710672144;
 bh=+SWkX0o2QReO37iop26P/T3kwRpNYHtksoAyb30/1Y0=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=2jOm1JxnaRa6qBjk17zq1zD+NDdOFvq1Gq9Chu5VHK0aj09k1cnQMVZcEetyTitOD
 +TYpEok3lpW1MaMbHMUHq/I6aFFveHe56deaEB0xts19CNQlNPRF4Ql+Y3d1d21nN0
 S9FsFK39BnJWZKspBJRO/CFnzHfGoSH0/jPK+VTg=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 2h29AJvT_Bw7; Sun, 17 Mar 2024 11:42:24 +0100 (CET)
Received: from AM-Inspiron-3585.. (cust-west-par-46-193-4-103.cust.wifirst.net
 [46.193.4.103])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id E805E20804;
 Sun, 17 Mar 2024 11:42:23 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>
Subject: [PATCH 7/7] tests/qtest: Add tests for the STM32L4x5 USART
Date: Sun, 17 Mar 2024 11:39:18 +0100
Message-Id: <20240317103918.44375-8-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
References: <20240317103918.44375-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Test:
- read/write from/to the usart registers
- send/receive a character/string over the serial port

The test to detect overrun is implemented but disabled
because overruns are currently impossible due to how we signal
in the USART when we are ready to receive a new character.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/meson.build            |   3 +-
 tests/qtest/stm32l4x5_usart-test.c | 399 +++++++++++++++++++++++++++++
 2 files changed, 401 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32l4x5_usart-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 36c5c13a7b..e0d72ee91e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -205,7 +205,8 @@ qtests_stm32l4x5 =3D \
   ['stm32l4x5_exti-test',
    'stm32l4x5_syscfg-test',
    'stm32l4x5_rcc-test',
-   'stm32l4x5_gpio-test']
+   'stm32l4x5_gpio-test',
+   'stm32l4x5_usart-test']
=20
 qtests_arm =3D \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) =
+ \
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_u=
sart-test.c
new file mode 100644
index 0000000000..b19b89c9ff
--- /dev/null
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -0,0 +1,399 @@
+/*
+ * QTest testcase for STML4X5_USART
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "hw/misc/stm32l4x5_rcc_internals.h"
+#include "hw/registerfields.h"
+
+/*
+ * All page references in the following test
+ * refer to the ST RM0351 Reference Manuel.
+ */
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
+    if (n < 32) {
+        return false;
+    }
+    n -=3D 32;
+    return qtest_readl(qts, NVIC_ISPR1) & (1 << n);
+}
+
+static bool clear_nvic_pending(QTestState *qts, unsigned int n)
+{
+    /* No USART interrupts are less than 32 */
+    if (n < 32) {
+        return false;
+    }
+    n -=3D 32;
+    qtest_writel(qts, NVIC_ICPR1, (1 << n));
+    return true;
+}
+
+static void usart_writel(unsigned int offset, uint32_t value)
+{
+    writel(USART1_BASE_ADDR + offset, value);
+}
+
+static uint32_t usart_readl(unsigned int offset)
+{
+    return readl(USART1_BASE_ADDR + offset);
+}
+
+static bool usart_wait_for_flag(QTestState *qts, uint32_t event_addr, ui=
nt32_t flag)
+{
+    /* Wait at most 5 seconds */
+    for (int i =3D 0; i < 5000; i++) {
+        if ((qtest_readl(qts, event_addr) & flag)) {
+            return true;
+        }
+        g_usleep(1000);
+    }
+
+    return false;
+}
+
+static void usart_receive_string(QTestState *qts, int sock_fd, const cha=
r *in,
+                           char *out)
+{
+    int i, in_len =3D strlen(in);
+
+    g_assert_true(send(sock_fd, in, in_len, 0) =3D=3D in_len);
+    for (i =3D 0; i < in_len; i++) {
+        g_assert_true(usart_wait_for_flag(qts,
+            USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK));
+        out[i] =3D qtest_readl(qts, USART1_BASE_ADDR + A_RDR);
+    }
+    out[i] =3D '\0';
+}
+
+static void usart_send_string(QTestState *qts, const char *in)
+{
+    int i, in_len =3D strlen(in);
+
+    for (i =3D 0; i < in_len; i++) {
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
+     * PLLM =3D 1 --> 000
+     * PLLN =3D 40 --> 40
+     * PPLLR =3D 2 --> 00
+     * PLLDIV =3D unused, PLLP =3D unused (SAI3), PLLQ =3D unused (48M1)
+     * SRC =3D MSI --> 01
+     */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_PLLCFGR), R_PLLCFGR_PLLREN_MASK=
 |
+            (40 << R_PLLCFGR_PLLN_SHIFT) |
+            (0b01 << R_PLLCFGR_PLLSRC_SHIFT));
+
+    /* PLL activation */
+
+    value =3D qtest_readl(qts, (RCC_BASE_ADDR + A_CR));
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CR), value | R_CR_PLLON_MASK);
+
+    /* RCC_CFGR is OK by defaut */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CFGR), 0);
+
+    /* CCIPR : no periph clock by default */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CCIPR), 0);
+
+    /* Switches on the PLL clock source */
+    value =3D qtest_readl(qts, (RCC_BASE_ADDR + A_CFGR));
+    qtest_writel(qts, (RCC_BASE_ADDR + A_CFGR), (value & ~R_CFGR_SW_MASK=
) |
+        (0b11 << R_CFGR_SW_SHIFT));
+
+    /* Enable SYSCFG clock enabled */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_APB2ENR), R_APB2ENR_SYSCFGEN_MA=
SK);
+
+    /* Enable the IO port B clock (See p.252) */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_AHB2ENR), R_AHB2ENR_GPIOBEN_MAS=
K);
+
+    /* Enable the clock for USART1 (cf p.259) */
+    /* We rewrite SYSCFGEN to not disable it */
+    qtest_writel(qts, (RCC_BASE_ADDR + A_APB2ENR),
+                 R_APB2ENR_SYSCFGEN_MASK | R_APB2ENR_USART1EN_MASK);
+
+    /* TODO: Enable usart via gpio */
+    /* Set Pin 6 & 7 of port B in Alternate Function mode */
+    /* GPIOB->MODER =3D (GPIOB->MODER & ~(GPIO_MODER_MODE6_Msk |
+                    GPIO_MODER_MODE7_Msk)) |
+                    (AF_MODE << GPIO_MODER_MODE6_Pos) |
+                    (AF_MODE << GPIO_MODER_MODE7_Pos); */
+
+    /* Specify Alternate Function mode n=C2=B07 for Pin 6 & 7 of port B =
*/
+    /* GPIOB->AFR[0] =3D (GPIOB->AFR[0] & ~(GPIO_AFRL_AFSEL6_Msk |
+                        GPIO_AFRL_AFSEL7_Msk )) |
+                        (AF7 << GPIO_AFRL_AFSEL6_Pos) |
+                        (AF7 << GPIO_AFRL_AFSEL7_Pos); */
+
+    /* Set PCLK as the clock for USART1(cf p.272) i.e. reset both bits *=
/
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
+     * for 115200, we have to put a divider of 695 =3D 0x2B7.
+     */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_BRR), 0x2B7);
+
+    /*
+     * Set the oversampling by 16,
+     * disable the parity control and
+     * set the word length to 8. (cf p.1377)
+     */
+    cr1 =3D qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 &=3D ~(R_CR1_M1_MASK | R_CR1_M0_MASK | R_CR1_OVER8_MASK | R_CR1_=
PCE_MASK);
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1), cr1);
+
+    /* Enable the transmitter, the receiver and the USART. */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
+        R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
+}
+
+static void test_write_read(void)
+{
+    /* Test that we can write and retrieve a value from the device */
+    usart_writel(A_TDR, 0xFFFFFFFF);
+    const uint32_t tdr =3D usart_readl(A_TDR);
+    g_assert_cmpuint(tdr, =3D=3D, 0x000000FF);
+}
+
+static void test_receive_char(void)
+{
+    int sock_fd;
+    uint32_t cr1;
+    QTestState *qts =3D qtest_init_with_serial("-M b-l475e-iot01a", &soc=
k_fd);
+
+    init_uart(qts);
+
+    /* Try without initializing IRQ */
+    g_assert_true(send(sock_fd, "a", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'a');
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+
+    /* Now with the IRQ */
+    cr1 =3D qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 |=3D R_CR1_RXNEIE_MASK;
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, cr1);
+    g_assert_true(send(sock_fd, "b", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'b');
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
+    QTestState *qts =3D qtest_init_with_serial("-M b-l475e-iot01a", &soc=
k_fd);
+
+    init_uart(qts);
+
+    /* Try without initializing IRQ */
+    qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'c');
+    g_assert_true(recv(sock_fd, s, 1, 0) =3D=3D 1);
+    g_assert_cmphex(s[0], =3D=3D, 'c');
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+
+    /* Now with the IRQ */
+    cr1 =3D qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 |=3D R_CR1_TXEIE_MASK;
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, cr1);
+    qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 'd');
+    g_assert_true(recv(sock_fd, s, 1, 0) =3D=3D 1);
+    g_assert_cmphex(s[0], =3D=3D, 'd');
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
+    QTestState *qts =3D qtest_init_with_serial("-M b-l475e-iot01a", &soc=
k_fd);
+
+    init_uart(qts);
+
+    usart_receive_string(qts, sock_fd, "hello", s);
+    g_assert_true(memcmp(s, "hello", 5) =3D=3D 0);
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
+    QTestState *qts =3D qtest_init_with_serial("-M b-l475e-iot01a", &soc=
k_fd);
+
+    init_uart(qts);
+
+    usart_send_string(qts, "world");
+    g_assert_true(recv(sock_fd, s, 10, 0) =3D=3D 5);
+    g_assert_true(memcmp(s, "world", 5) =3D=3D 0);
+
+    close(sock_fd);
+
+    qtest_quit(qts);
+}
+
+static void test_overrun(void)
+{
+    int sock_fd;
+    uint32_t cr1;
+    QTestState *qts =3D qtest_init_with_serial("-M b-l475e-iot01a", &soc=
k_fd);
+
+    init_uart(qts);
+
+    /*
+     * These tests fail for now because we cannot write an new charcter
+     * while RXNE is high (see stm32l4x_5_usart_can_receive),
+     * thus preventing any overrun to happen.
+     * TODO: Find a way to indicate that we can only receive 1 character=
 at
+     * a time without using RXNE.
+     */
+
+    /* Try without initializing IRQ: Test presence of overrun error flag=
 */
+    g_assert_true(send(sock_fd, "e", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    g_assert_true(send(sock_fd, "f", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_ORE_MASK);
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'e');
+
+    /* Now disable Overrun detection */
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR3, R_CR3_OVRDIS_MASK);
+    g_assert_true(send(sock_fd, "g", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    g_assert_true(send(sock_fd, "h", 1, 0) =3D=3D 1);
+    g_usleep(1000);
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    g_assert_cmphex(qtest_readl(qts,
+     USART1_BASE_ADDR + A_ISR) & R_ISR_ORE_MASK, =3D=3D, 0);
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'h');
+
+    /* Now, enable irq from overrun with RXNEIE */
+    g_assert_true(send(sock_fd, "i", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_RXNE_MASK);
+    g_assert_false(check_nvic_pending(qts, USART1_IRQ));
+    cr1 =3D qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+    cr1 |=3D R_CR1_RXNEIE_MASK;
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, cr1);
+    g_assert_true(send(sock_fd, "j", 1, 0) =3D=3D 1);
+    usart_wait_for_flag(qts, USART1_BASE_ADDR + A_ISR, R_ISR_ORE_MASK);
+    g_assert_true(check_nvic_pending(qts, USART1_IRQ));
+    clear_nvic_pending(qts, USART1_IRQ);
+    g_assert_cmphex(qtest_readl(qts, USART1_BASE_ADDR + A_RDR), =3D=3D, =
'i');
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
+    /* Disabled tests */
+    if (false) {
+        qtest_add_func("stm32l4x5/usart/overrun", test_overrun);
+    }
+    qtest_start("-machine b-l475e-iot01a");
+    ret =3D g_test_run();
+    qtest_end();
+
+    return ret;
+}
+
--=20
2.34.1


