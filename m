Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE0CFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtGE-0006wd-Vh; Mon, 07 Oct 2024 15:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtFC-0005hs-LY; Mon, 07 Oct 2024 15:18:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtFA-0004G6-QH; Mon, 07 Oct 2024 15:18:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 421F49624F;
 Mon,  7 Oct 2024 22:16:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1089514F72F;
 Mon,  7 Oct 2024 22:16:56 +0300 (MSK)
Received: (nullmailer pid 2592756 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jacob Abrams <satur9nine@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 18/32] hw/char/stm32l4x5_usart.c: Enable USART ACK bit
 response
Date: Mon,  7 Oct 2024 22:16:35 +0300
Message-Id: <20241007191654.2592616-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jacob Abrams <satur9nine@gmail.com>

SW modifying USART_CR1 TE bit should cuase HW to respond by altering
USART_ISR TEACK bit, and likewise for RE and REACK bit.

This resolves some but not all issues necessary for the official STM USART
HAL driver to function as is.

Fixes: 87b77e6e01ca ("hw/char/stm32l4x5_usart: Enable serial read and write")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
Signed-off-by: Jacob Abrams <satur9nine@gmail.com>
Message-id: 20240911043255.51966-1-satur9nine@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 6cce0dcc6f7aaaeb7f17577776da510b04f67c99)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index fc5dcac0c4..3cf200c080 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,6 +154,21 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 9)
 
+static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
+{
+    if (s->cr1 & R_CR1_TE_MASK) {
+        s->isr |= R_ISR_TEACK_MASK;
+    } else {
+        s->isr &= ~R_ISR_TEACK_MASK;
+    }
+
+    if (s->cr1 & R_CR1_RE_MASK) {
+        s->isr |= R_ISR_REACK_MASK;
+    } else {
+        s->isr &= ~R_ISR_REACK_MASK;
+    }
+}
+
 static void stm32l4x5_update_irq(Stm32l4x5UsartBaseState *s)
 {
     if (((s->isr & R_ISR_WUF_MASK) && (s->cr3 & R_CR3_WUFIE_MASK))        ||
@@ -456,6 +471,7 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
     case A_CR1:
         s->cr1 = value;
         stm32l4x5_update_params(s);
+        stm32l4x5_update_isr(s);
         stm32l4x5_update_irq(s);
         return;
     case A_CR2:
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 8902518233..0630f8d53b 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -36,6 +36,8 @@ REG32(GTPR, 0x10)
 REG32(RTOR, 0x14)
 REG32(RQR, 0x18)
 REG32(ISR, 0x1C)
+    FIELD(ISR, REACK, 22, 1)
+    FIELD(ISR, TEACK, 21, 1)
     FIELD(ISR, TXE, 7, 1)
     FIELD(ISR, RXNE, 5, 1)
     FIELD(ISR, ORE, 3, 1)
@@ -191,7 +193,7 @@ static void init_uart(QTestState *qts)
 
     /* Enable the transmitter, the receiver and the USART. */
     qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
-        R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
+        cr1 | R_CR1_UE_MASK | R_CR1_RE_MASK | R_CR1_TE_MASK);
 }
 
 static void test_write_read(void)
@@ -296,6 +298,37 @@ static void test_send_str(void)
     qtest_quit(qts);
 }
 
+static void test_ack(void)
+{
+    uint32_t cr1;
+    uint32_t isr;
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    init_uart(qts);
+
+    cr1 = qtest_readl(qts, (USART1_BASE_ADDR + A_CR1));
+
+    /* Disable the transmitter and receiver. */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
+        cr1 & ~(R_CR1_RE_MASK | R_CR1_TE_MASK));
+
+    /* Test ISR ACK for transmitter and receiver disabled */
+    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
+    g_assert_false(isr & R_ISR_TEACK_MASK);
+    g_assert_false(isr & R_ISR_REACK_MASK);
+
+    /* Enable the transmitter and receiver. */
+    qtest_writel(qts, (USART1_BASE_ADDR + A_CR1),
+        cr1 | (R_CR1_RE_MASK | R_CR1_TE_MASK));
+
+    /* Test ISR ACK for transmitter and receiver disabled */
+    isr = qtest_readl(qts, (USART1_BASE_ADDR + A_ISR));
+    g_assert_true(isr & R_ISR_TEACK_MASK);
+    g_assert_true(isr & R_ISR_REACK_MASK);
+
+    qtest_quit(qts);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -308,6 +341,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/ack", test_ack);
     ret = g_test_run();
 
     return ret;
-- 
2.39.5


