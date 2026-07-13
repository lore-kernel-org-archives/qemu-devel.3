Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734A5C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIen-0000mE-99; Mon, 13 Jul 2026 11:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeV-0008Uz-Gh
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeS-0001Dr-Gm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so30532345e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956779; x=1784561579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B0sy5Lm7b0VDs6vzO5OthwvktTgTbrm6ExUOslb6lTo=;
 b=rBl3hHgh9yG/Rf0Ncekjxqi4oiukgLpUza7j3dWBVpx1B0zU0Lk2r5y+wthsPtGemZ
 oFM3uTjZ2KzSVA7HBYYFBqwzqj0p6iDqbKLZ0hCT0ppyCXu0HHI2fuB5cNX54O4zwzhH
 wm5XMZqwksTlfwEpYCaGRDKBJ6FaPIeK28isLPLokStASlT+CoOQnQUMwAWDQLb8NUYB
 UFyfxB8RJADrsoAUkTsWH3UmxTABlLqd61C6eRg4V2TbXlTQcFXGN/n6x5AS+1FoKy45
 0youzVWvdxS2K8CZ3TwBAvttXRKg1PAmf/DVhGXukfaCJdXK4o7/ldTILeeg1/C69vp8
 u2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956779; x=1784561579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B0sy5Lm7b0VDs6vzO5OthwvktTgTbrm6ExUOslb6lTo=;
 b=Fh1UkJVfBwwNThZ3bvK6/djo4XDM5cRbTxOm4kMt5mkgHbCe/mmhLdMNxd3yRt2BKh
 Sf2U3hYwYsX7TTVy8JYMY6Nz9Rn9WiUmK1QcEscwsYfLMWbPrnvgZ9ySNACPsfpcYcZ8
 8WKVKmOgCzuuwDfZGdAHdp9p4CqxupPT9Ino/XD/0AR1PHD1qStxVxOENj67g56GAMbq
 ETVemjgSOkVpI8lV93VCHr2E7UilrrGs5D4KSM/CyK3mou0ZgJCM9tqODH4VWOv3B4q4
 GEKPjrl/7dReP833WA0mbQat/M+XCfTHeKJj7B4XMPOGsT5dW8h1lUj7esenXSohmRmW
 2dhQ==
X-Gm-Message-State: AOJu0YyvF1oszXYuytmQ1aJLdoDpPay8qTf0aXgj9sHLpT+zdZvt1KY0
 qwjNZ4RALiP3cqTdtl/MqL1p9gW2+crbdS1OMuaLYnAF6E9Y1yzj0UMLerRR5S6FrzKKjDRXqoR
 6ib3F5czahQ==
X-Gm-Gg: AfdE7clb6CoyQUYmhSJGKP1CqvG623UIC1Y4hOImajpwZHQuCfur2b3tF2HnMfhDLqp
 4k6ExgLG8NuQDaq4c4QE75sM2YbgDr4A15Qs0BbVHv0+inV64wRFdAnfCoHV65xf5n+xjLJl7Ln
 Bs/B89ptHD8rX5+8h0Q6q/Y8DX+JSEmhGjPKhbsxRxXf6LR9q+i5kFgC23FX0gG5x70mfVWKFdV
 sPqttE7xfSaJJI9hbCnwtqSZVoqPCYc8xcprEFhqLg094xozPSeU6rMP2wBvkD+YOwABILjggwt
 qUxyvUuZBEdtWl6koepL4uY3TtAXq0okNsNUYyWb8oZ5Go3iNgueMwAiOyiyx+CXkhSmTDUbHFj
 JtDHuxc8vtZcuyqDAR57wI5P3YJ2x9/OtEbESZ93IOrx6eEbq9ZzkMlfCX0FynlztOybxaXEagS
 sLtsu7QTy3ttv8OzGZbva/HYpDdPtFTKaUdRpjOPPzIwLf9cjKzMlHHEQLR2HQgCsm3wIv6/JMq
 p4Qi47sCXe8cGV/6LTmDg==
X-Received: by 2002:a05:600c:4f94:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-493f882e0e2mr92295515e9.31.1783956778683; 
 Mon, 13 Jul 2026 08:32:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/26] hw/misc/stm32_rcc: Correct offset-to-irq calculation
Date: Mon, 13 Jul 2026 16:32:33 +0100
Message-ID: <20260713153233.3391818-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

In the STM32 RCC, there is a block of 5 "enable" registers, each of
which has 32 bits; each bit determines the level of one of the 5 * 32
= 160 enable_irq output lines.  The code calculates the irq to be
worked on using
  irq_offset = ((addr - STM32_RCC_AHB1_ENR) / 4) * 32;

This assumes that the registers are all consecutive; however, there
is a gap between the AHB1/2/3 registers and the APB1/2 registers, so
for the APB1/2 registers we calculate a number that is 32 too high
and can index off the end of the enable_irq[] array.

The handling of the reset registers has an identical bug.

Adjust the calculation of irq_offset to cope with the gap, and fix
the case labels so accesses to the gap fall into the default
LOG_UNIMP rather than being treated as if they were an actual
register.

Coverity CID: 1663683, 1663686
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20260709104832.1989240-1-peter.maydell@linaro.org
---
 hw/misc/stm32_rcc.c         | 31 +++++++++++++++++++++++++++----
 include/hw/misc/stm32_rcc.h |  6 +++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 74ea29b1560..5cfb39e5607 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -53,6 +53,27 @@ static uint64_t stm32_rcc_read(void *opaque, hwaddr addr, unsigned int size)
     return value;
 }
 
+static int reg_offset_to_irq_offset(hwaddr addr)
+{
+    /*
+     * The reset and enable registers aren't all consecutive. In getting the
+     * irq index from the register offset, we need to account for the gap
+     * between the AHB regs and the APB regs.
+     */
+    switch (addr) {
+    case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
+        return ((addr - STM32_RCC_AHB1_RSTR) / 4) * 32;
+    case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
+        return ((addr - STM32_RCC_APB1_RSTR) / 4) * 32 + STM32_RCC_N_AHB_IRQS;
+    case STM32_RCC_AHB1_ENR ... STM32_RCC_AHB3_ENR:
+        return ((addr - STM32_RCC_AHB1_ENR) / 4) * 32;
+    case STM32_RCC_APB1_ENR ... STM32_RCC_APB2_ENR:
+        return ((addr - STM32_RCC_APB1_ENR) / 4) * 32 + STM32_RCC_N_AHB_IRQS;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void stm32_rcc_write(void *opaque, hwaddr addr,
                             uint64_t val64, unsigned int size)
 {
@@ -69,11 +90,12 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
     }
 
     switch (addr) {
-    case STM32_RCC_AHB1_RSTR...STM32_RCC_APB2_RSTR:
+    case STM32_RCC_AHB1_RSTR ... STM32_RCC_AHB3_RSTR:
+    case STM32_RCC_APB1_RSTR ... STM32_RCC_APB2_RSTR:
         prev_value = s->regs[addr / 4];
         s->regs[addr / 4] = value;
 
-        irq_offset = ((addr - STM32_RCC_AHB1_RSTR) / 4) * 32;
+        irq_offset = reg_offset_to_irq_offset(addr);
         for (int i = 0; i < 32; i++) {
             new_value = extract32(value, i, 1);
             if (extract32(prev_value, i, 1) && !new_value) {
@@ -82,11 +104,12 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
             }
         }
         return;
-    case STM32_RCC_AHB1_ENR...STM32_RCC_APB2_ENR:
+    case STM32_RCC_AHB1_ENR ... STM32_RCC_AHB3_ENR:
+    case STM32_RCC_APB1_ENR ... STM32_RCC_APB2_ENR:
         prev_value = s->regs[addr / 4];
         s->regs[addr / 4] = value;
 
-        irq_offset = ((addr - STM32_RCC_AHB1_ENR) / 4) * 32;
+        irq_offset = reg_offset_to_irq_offset(addr);
         for (int i = 0; i < 32; i++) {
             new_value = extract32(value, i, 1);
             if (!extract32(prev_value, i, 1) && new_value) {
diff --git a/include/hw/misc/stm32_rcc.h b/include/hw/misc/stm32_rcc.h
index 4dccacc2db5..a94781bf347 100644
--- a/include/hw/misc/stm32_rcc.h
+++ b/include/hw/misc/stm32_rcc.h
@@ -65,7 +65,11 @@
 
 #define STM32_RCC_NREGS ((STM32_RCC_DCKCFGR2 >> 2) + 1)
 #define STM32_RCC_PERIPHERAL_SIZE 0x400
-#define STM32_RCC_NIRQS (32 * 5) /* 32 bits per reg, 5 en/rst regs */
+
+/* 32 bits per reg, 3 AHB regs and 2 APB regs */
+#define STM32_RCC_N_AHB_IRQS (32 * 3)
+#define STM32_RCC_N_APB_IRQS (32 * 2)
+#define STM32_RCC_NIRQS (STM32_RCC_N_AHB_IRQS + STM32_RCC_N_APB_IRQS)
 
 #define STM32_RCC_GPIO_IRQ_OFFSET 0
 
-- 
2.43.0


