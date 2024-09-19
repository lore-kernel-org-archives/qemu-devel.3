Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96247CDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGws-0006kj-TO; Thu, 19 Sep 2024 09:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005NH-8v
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwR-00014K-DT
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:30 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-374c180d123so519039f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751485; x=1727356285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VwKnY+1IgXpvlla7/Vsb9u5qFB4I2Y8EFn85fywIH7o=;
 b=J6oG9BIN9S75Fvzra1bnZ7VORsjtVtVwNFnqG13oWDkuDjfhZGHS+d2bPF/ZQ+XnzA
 wm1vr2CmJk0uOiS3WmxqvCloA/gW3b/tFP1BeZ81rJH5paeoLVel7n4j37U9C2fejF9L
 8uNuO+fKBbi9Cdnd+GuV43Fw2g027bAQInLM6yNLcnDwQjG4fVWGd4ynQmo9A/o9S2tn
 rcDb6jyvEru5nyXKU11m/qA9t4TaewjQGECpMplKQ5r4VPbwnpR5tHX/MC067dxTtEjg
 6188uSlMj1JNJOf4lsEsCJUFNBBS7sOdTracXJTTS87Cs+uiWk/vFu3WdcxJejpG4t6s
 AcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751485; x=1727356285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwKnY+1IgXpvlla7/Vsb9u5qFB4I2Y8EFn85fywIH7o=;
 b=in5Nchr7QXfwy+rZFvbGyg78HibiabQfevxpHYRCz3CUrTMiaaSMP5FBZkJG7a7mcW
 We43Ln3G5IdiR0GfzxL43IPsZFjcHG5GQwZQkl+ZYk6Gb+5l+jX/DY/og2Cdp9/6PZQG
 eVqLB4gRLRQVXyroHgnsVlD3Fzd8WRJB0LeA57pP10j2iyiOqSttVLN+TQERAiiUJcmL
 bLi/Sqt4xCzNK1fC1Q8ziQMlXKD3+Cs2w7YbQAxRgjVbsxy+LSa/IHR0TuorxGF0UmdQ
 N8bK8K1SM+TD8pnFNe4d5SxvMNpFeBJWvSJIWFLYKC3KqqFoLYJWsWuZzCkztEmaIphH
 k7yA==
X-Gm-Message-State: AOJu0YyhklA3JceKYJK1VH6k3t+7YWm/0YC/pwK0qT5hosHWYMxNVjJX
 O3dNVtOYoAyAsj1lvrowteR9UqS8jNW3cgML2sZU4j22LPXyX6HaVD/W1ZB3wKsa6o2fZBVSHV9
 +
X-Google-Smtp-Source: AGHT+IFLqS3DgFJlFVIRZzd6PSUHvYxhnY75kvjIdedbIu/hesgYkSW048XzDt0rCvPwBu56NfNByw==
X-Received: by 2002:a05:6000:1bca:b0:374:c847:85c with SMTP id
 ffacd0b85a97d-378d61e2c1fmr10713956f8f.24.1726751485348; 
 Thu, 19 Sep 2024 06:11:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/38] hw/char/stm32l4x5_usart.c: Enable USART ACK bit response
Date: Thu, 19 Sep 2024 14:10:58 +0100
Message-Id: <20240919131106.3362543-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
---
 hw/char/stm32l4x5_usart.c          | 16 +++++++++++++
 tests/qtest/stm32l4x5_usart-test.c | 36 +++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index fc5dcac0c45..3cf200c080d 100644
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
index c175ff3064f..64cebda60f0 100644
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
@@ -298,6 +300,37 @@ static void test_send_str(void)
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
@@ -310,6 +343,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/ack", test_ack);
     ret = g_test_run();
 
     return ret;
-- 
2.34.1


