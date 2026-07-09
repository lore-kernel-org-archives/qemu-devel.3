Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EF3C44506
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmJ8-0007oO-Ph; Thu, 09 Jul 2026 06:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmJ3-0007ny-Q2
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:48:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whmJ2-0002nP-5V
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:48:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10009715e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783594114; x=1784198914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rqtLfoBh3sPx8aGTGZbZdz7/c1WiWr68tf4T0IZ5WmM=;
 b=R0HKsArP50u+KP51BWKk0wb0cKzH52DF3vwX9srwxFwXOvMepHob3HyIuaDBa1PLnE
 I3zL1BHreQfTthQMYD9lN0ASzbTrezEiP1jtb1MmajUMmlx/EzDLFidLvcx3qvYrAi6x
 1zOKBvHqps4MedTcYRDIow8BhTMVCvquYzpDxoRLIdxyeJnLfq46KthUPUsIHExKiZOL
 xWksRiaDMxo7vTV8jZUWgccme+03Bh4HOXeH7huJdIFUJxAX5NNoKweNuqigbC0XAuc1
 sAqkhnmA1quVgqCnAmL3e4Adv4JGmXJCWxTOZh1bpzjPcASCD/tmczor8B1ZsEMnIZig
 /r0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783594114; x=1784198914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rqtLfoBh3sPx8aGTGZbZdz7/c1WiWr68tf4T0IZ5WmM=;
 b=o5/nydknCnKJCVTGxh6GtNdVYS96ffgihg8hWoO0ML8aooIX4x2DgSXrQkrC/bdlb/
 Y2Q4mvPPWYDimlCvxCMdyAx3NhfOBDaErO6lPf4Ap+5CijU3oKpbiz2gE4+z49b6iMQR
 hxoVT89ckOxdYNBqygmtoZdPC/eEaiayQmWM4zdnjNf+XZeOp4wy2dcbvZvpkLPmxkIO
 j9m6jm7cjkE3M1B4Yl3v/oYaI8UVyOKjjEm0SM5H8vTIRLaqBN+TtpX46NT9m1U7f2rZ
 fl3s35/acfBeeM7Iu0+bEk0GdkJQox8kzTXUrP/5TckuaYGVuC/qmnkLxuBZ0QKtyVFg
 5gVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4O8uFWSCyTRvjCVDUPfVKhSEeMIUoRcsappDiMvCuHJASmCIYvOuKesUuio0WykDoLQqGc8rm07Ru@nongnu.org
X-Gm-Message-State: AOJu0YxORIaUTurupr91DD8OF3sKShqZEN9o1lYnhxFBr3oo2QdHKfVr
 KGpjZT1lv+Mr6oViu212xXR7GxS2vkZT5U6w3mJSxbsrdN/a4zNpncXPoByS0eInY3Q=
X-Gm-Gg: AfdE7cl+PFAog/AiDpsGIx/ioBAH5M9VG6rck1Ab/cbVd3yzzB2jOoWDY9JqmwHCCPv
 IquhRskbFa+Clvca9tQb8b8R7rawL6EqdKxxH9ChK3KxJIc+kVA8M9MBHtuM2zBrQ/7kMlVKvbJ
 Q03D1v4ekJVzBKDXOE2F/Fm+Qvq33TDfWY6N5lb7IjiPzusOiomwEqTQQuih7uemg8op2OtqmGr
 pPQ2Sh5kZ1FHCu746PTayQCGxP1CyMt+cI05jgqQNgEq6abZi/sva7DA1E3mkWExvDYBmQmv8fX
 veZBImyLktQ28vWueDdEAeRjU3mB0qRmLPNndk+HwWaBjQ2BxTIWqsiAujMxpRxTdPYuwm4LrEB
 sT92Pv5HOP2JW9RLcxepIsohK660o0YTzUWwO03LNj/9j4T2GEOhcp3osNtMljdu8tnQpneAmLq
 xTjNezJlMN0/Szb5Bi8aeXWVuPkePGFmxfQtm6f0OXkLp29eY5qyR9HTxRnZjZ+MvyUhhiFd5S3
 bxn8LowMTOjX1TM94WZsw==
X-Received: by 2002:a05:600c:3115:b0:493:c862:3f2d with SMTP id
 5b1f17b1804b1-493ed78e5bfmr16231385e9.5.1783594113761; 
 Thu, 09 Jul 2026 03:48:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm89325445e9.14.2026.07.09.03.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:48:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] hw/misc/stm32_rcc: Correct offset-to-irq calculation
Date: Thu,  9 Jul 2026 11:48:32 +0100
Message-ID: <20260709104832.1989240-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
---
 hw/misc/stm32_rcc.c         | 31 +++++++++++++++++++++++++++----
 include/hw/misc/stm32_rcc.h |  6 +++++-
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 74ea29b156..5cfb39e560 100644
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
index 4dccacc2db..a94781bf34 100644
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


