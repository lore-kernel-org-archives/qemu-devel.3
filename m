Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCBEC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvpUn-00040D-AX; Mon, 17 Aug 2026 01:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwhitakera@gmail.com>)
 id 1wvlsD-0007Fu-8t
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 21:10:45 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jwhitakera@gmail.com>)
 id 1wvlsB-00043l-2g
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 21:10:44 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38e7109321dso1842259a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786929041; x=1787533841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E2tJHyMNd1zyfeILSTwqVxtQLO/JZvWf/ioMqbTPTFA=;
 b=KqiERHfRqYgT/FPiLpa7u9K1VqGOJ82gMcEI0SKTmupJeahufLje1nwWWhJZKLouGX
 rAdFo8Qvtll20U18EUerC8RJiqhZ381ER2hX/tUT7ftWSaIT3Ta4Rns7l3IO1o/I1FzX
 bHCoBcGqE6UJiz87JkCy+dDwGlXMXOspWDpyYFCJdlfLncBqu+Wtz4ZPbIgv1/TayGg0
 tM7ZoNWsD5gr/9Ng3alDCrdjmkvevhmDE1dMW9DsnIZ+qZFR29nWrZXWQEQ2ectZqu+p
 SBXAjpt7KD7iHPcIu6hOjJvvl0zWF6b17vX0o5NHioazD7GgxLTq5lLvASVSG0aYQfTV
 0qgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786929041; x=1787533841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E2tJHyMNd1zyfeILSTwqVxtQLO/JZvWf/ioMqbTPTFA=;
 b=fb5XYfj1IFCzYUYxUwCP7fWebPp6PoNTtozvvIEU6xhcqMWC79rxpaH6Dzhu7Wjotf
 cAyyzOoCD/YKD6RI7aBODfYAoSeFU9GIOJ9ZZ7Fa6XMvdvdcCjMds+x1VXfb+23GYJFt
 IXRa2HE5rGB5ycdtvZnR1ajbxNZtUgHLYpGfeKvgEGmIVFUioVVgnvid78irr98pGIea
 tYpLjaEpDdazpxQzfObaGrpJECGDQ1ZNcHqhr0H3Tx+EHpWSWQydUZToLaVb4M9PfS8N
 EnuIg2MG0oGL8gU324AI4/dvoAzOCK/zaqkpHDMU5J+7HJVDb9ku8ylkBEG837kpG+rh
 JUFw==
X-Gm-Message-State: AOJu0YycfW6IGFoqE1RjZDNWqYcW4vZoRoXg/IvwcHSTgbtZLDPmGZpU
 s3rUtVAlZeIab1FlvZ7+/sw+sbYGocy0n218LwD0o8UkLk+RzoKm8J+s+uM4ug==
X-Gm-Gg: AR+sD11iqvcba0lES5tjzeNPeVKZZ8jwMIO4o+FrBI7LRUfNG1iuyTgM+3rgoWRlfJ7
 L6aZKPF9b50LFuZTzK/O+vIjldrAj1E0ArQC13Zq/U9Qx5drAFBf1Mtyj/Zm8ueerI6JvY/rZq4
 dsz0M0FPSanUJ+BOc6kq5pSMCeY2wOZOdaWFEixwuyl9Bt+CNiNWsa9d+dgI3jpYstsX4S+pQLV
 5KiBJ4OfzqI+lbNXj7KC1ifZLffM4SasE+RWOEEyuMGdvYkUCpyJiodOeH29AwruxtFIAVkiwEz
 wr5xMl244Oq98E9djWHJZkkKylN8AhsVM6AN1W7+4qc2W4p6Z1nutevIUg12bG/xCRZknKu0JTb
 FQ6Anq+QKK1dN5qSxClTJxGo2xIbopWDhcHwRoO7TWzPOQzAmnlbdX+YTTRTMoOCSJ34ANDgt4Z
 NJShAk+QFJ2AhYrjj+BKlBK6bxs7BEj3bGxdHgTg5UgSu9ITeNJUcFEJbCg22lYnHk45fmNQ==
X-Received: by 2002:a17:90b:1d45:b0:366:10f1:3d91 with SMTP id
 98e67ed59e1d1-3933b7c3b71mr22300494a91.1.1786929040702; 
 Sun, 16 Aug 2026 18:10:40 -0700 (PDT)
Received: from jacob-pop23u.lan ([2600:1700:88b2:a50:1523:2c7b:462a:c5fb])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267be8e35bsm37646eec.14.2026.08.16.18.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 18:10:40 -0700 (PDT)
From: Jacob Whitaker Abrams <jwhitakera@gmail.com>
X-Google-Original-From: Jacob Whitaker Abrams <satur9nine@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jacob Whitaker Abrams <satur9nine@gmail.com>
Subject: [PATCH] hw/char/stm32l4x5_usart.c: Support writes smaller than 32-bit
Date: Sun, 16 Aug 2026 18:10:08 -0700
Message-ID: <20260817011008.652105-1-satur9nine@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=jwhitakera@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Aug 2026 01:02:37 -0400
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

Official STM32CubeL4 drivers use and require support for 16-bit writes to
UART registers for proper function.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2540
Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
---
 hw/char/stm32l4x5_usart.c          | 93 +++++++++++++++++++++++-------
 tests/qtest/stm32l4x5_usart-test.c | 50 +++++++++++++++-
 2 files changed, 120 insertions(+), 23 deletions(-)

diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index dd1b099195..88c4a3b5a7 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -154,8 +154,15 @@ REG32(RDR, 0x24)
 REG32(TDR, 0x28)
     FIELD(TDR, TDR, 0, 9)
 
+#define ISR_RESET_VALUE (0x020000C0)
+
 static void stm32l4x5_update_isr(Stm32l4x5UsartBaseState *s)
 {
+    if (!(s->cr1 & R_CR1_UE_MASK)) {
+        s->isr = ISR_RESET_VALUE;
+        return;
+    }
+
     if (s->cr1 & R_CR1_TE_MASK) {
         s->isr |= R_ISR_TEACK_MASK;
     } else {
@@ -404,9 +411,11 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
                                      unsigned int size)
 {
     Stm32l4x5UsartBaseState *s = opaque;
+    hwaddr base = addr & ~0x3ULL;
+    unsigned int offset = addr & 0x3;
     uint64_t retvalue = 0;
 
-    switch (addr) {
+    switch (base) {
     case A_CR1:
         retvalue = s->cr1;
         break;
@@ -451,6 +460,13 @@ static uint64_t stm32l4x5_usart_base_read(void *opaque, hwaddr addr,
         break;
     }
 
+    /* Adjust for partial access */
+    if (size == 1) {
+        retvalue = (retvalue >> (offset * 8)) & 0xFF;
+    } else if (size == 2) {
+        retvalue = (retvalue >> (offset * 8)) & 0xFFFF;
+    }
+
     trace_stm32l4x5_usart_read(addr, retvalue);
 
     return retvalue;
@@ -460,55 +476,88 @@ static void stm32l4x5_usart_base_write(void *opaque, hwaddr addr,
                                   uint64_t val64, unsigned int size)
 {
     Stm32l4x5UsartBaseState *s = opaque;
-    const uint32_t value = val64;
+    hwaddr base = addr & ~0x3ULL;
+    unsigned int offset = addr & 0x3;
+    uint32_t value = (uint32_t)val64;
+
+    /* Build mask for partial access */
+    uint32_t mask;
+    if (size == 4) {
+        mask = 0xFFFFFFFF;
+    } else if (size == 2) {
+        mask = 0xFFFF << (offset * 8);
+    } else if (size == 1) {
+        mask = 0xFF << (offset * 8);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Unsupported access size %u\n", __func__, size);
+        return;
+    }
+    value = (value << (offset * 8)) & mask;
 
     trace_stm32l4x5_usart_write(addr, value);
 
-    switch (addr) {
-    case A_CR1:
-        s->cr1 = value;
+    switch (base) {
+    case A_CR1: {
+        uint32_t old = s->cr1;
+        s->cr1 = (old & ~mask) | value;
         stm32l4x5_update_params(s);
         stm32l4x5_update_isr(s);
         stm32l4x5_update_irq(s);
         return;
-    case A_CR2:
-        s->cr2 = value;
+    }
+    case A_CR2: {
+        uint32_t old = s->cr2;
+        s->cr2 = (old & ~mask) | value;
         stm32l4x5_update_params(s);
         return;
-    case A_CR3:
-        s->cr3 = value;
+    }
+    case A_CR3: {
+        uint32_t old = s->cr3;
+        s->cr3 = (old & ~mask) | value;
         return;
-    case A_BRR:
-        s->brr = value;
+    }
+    case A_BRR: {
+        uint32_t old = s->brr;
+        s->brr = (old & ~mask) | value;
         stm32l4x5_update_params(s);
         return;
-    case A_GTPR:
-        s->gtpr = value;
+    }
+    case A_GTPR: {
+        uint32_t old = s->gtpr;
+        s->gtpr = (old & ~mask) | value;
         return;
-    case A_RTOR:
-        s->rtor = value;
+    }
+    case A_RTOR: {
+        uint32_t old = s->rtor;
+        s->rtor = (old & ~mask) | value;
         return;
-    case A_RQR:
+    }
+    case A_RQR: {
+        /* RQR is write-only, assume full 32-bit access */
         usart_update_rqr(s, value);
         return;
+    }
     case A_ISR:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: ISR is read only !\n", __func__);
         return;
-    case A_ICR:
-        /* Clear the status flags */
+    case A_ICR: {
+        /* Clear flags: value is masked to written bytes */
         s->isr &= ~value;
         stm32l4x5_update_irq(s);
         return;
+    }
     case A_RDR:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: RDR is read only !\n", __func__);
         return;
-    case A_TDR:
-        s->tdr = value;
+    case A_TDR: {
+        uint32_t old = s->tdr;
+        s->tdr = (old & ~mask) | value;
         s->isr &= ~R_ISR_TXE_MASK;
         usart_transmit(NULL, G_IO_OUT, s);
         return;
+    }
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
@@ -521,12 +570,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
     .valid = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        .min_access_size = 2,
         .unaligned = false
     },
     .impl = {
         .max_access_size = 4,
-        .min_access_size = 4,
+        .min_access_size = 2,
         .unaligned = false
     },
 };
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index a72c5a685d..86b36915ac 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -332,6 +332,53 @@ static void test_ack(void)
     qtest_quit(qts);
 }
 
+static void test_isr_reset(void)
+{
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+    init_uart(qts);
+    /* ISR should show TEACK/REACK after UART init */
+    uint32_t isr = qtest_readl(qts, USART1_BASE_ADDR + A_ISR);
+    g_assert_true(isr & R_ISR_TEACK_MASK);
+    g_assert_true(isr & R_ISR_REACK_MASK);
+
+    /* Clear UE bit in CR1 -> USART disabled */
+    uint32_t cr1 = qtest_readl(qts, USART1_BASE_ADDR + A_CR1);
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, cr1 & ~R_CR1_UE_MASK);
+    /* ISR must reset to reset value 0x020000C0 when UE is cleared */
+    isr = qtest_readl(qts, USART1_BASE_ADDR + A_ISR);
+    g_assert_cmpuint(isr, ==, 0x020000C0);
+
+    qtest_quit(qts);
+}
+
+static void test_16bit_access(void)
+{
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    /* Test 16-bit write/read on RTOR */
+    qtest_writel(qts, USART1_BASE_ADDR + A_RTOR, 0x00000000);
+    qtest_writew(qts, USART1_BASE_ADDR + A_RTOR, 0xABCD);
+    uint16_t rtor16 = qtest_readw(qts, USART1_BASE_ADDR + A_RTOR);
+    g_assert_cmpuint(rtor16, ==, 0xABCD);
+    uint32_t rtor32 = qtest_readl(qts, USART1_BASE_ADDR + A_RTOR);
+    g_assert_cmpuint(rtor32, ==, 0x0000ABCD);
+
+    /* Test upper half 16-bit write */
+    qtest_writew(qts, USART1_BASE_ADDR + A_RTOR + 2, 0x1234);
+    rtor32 = qtest_readl(qts, USART1_BASE_ADDR + A_RTOR);
+    g_assert_cmpuint(rtor32, ==, 0x1234ABCD);
+
+    /* Test 16-bit write/read on CR1 */
+    qtest_writel(qts, USART1_BASE_ADDR + A_CR1, 0x00000000);
+    qtest_writew(qts, USART1_BASE_ADDR + A_CR1, 0x00FF);
+    uint16_t cr116 = qtest_readw(qts, USART1_BASE_ADDR + A_CR1);
+    g_assert_cmpuint(cr116, ==, 0x00FF);
+    uint32_t cr132 = qtest_readl(qts, USART1_BASE_ADDR + A_CR1);
+    g_assert_cmpuint(cr132, ==, 0x000000FF);
+
+    qtest_quit(qts);
+}
+
 static void check_clock(QTestState *qts, const char *path, uint32_t rcc_reg,
                         uint32_t reg_offset)
 {
@@ -369,7 +416,8 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
     qtest_add_func("stm32l4x5/usart/ack", test_ack);
+    qtest_add_func("stm32l4x5/usart/isr_reset", test_isr_reset);
+    qtest_add_func("stm32l4x5/usart/16bit_access", test_16bit_access);
     qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
     return g_test_run();
 }
-
-- 
2.43.0


