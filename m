Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF3AC44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLx-0002a4-6k; Wed, 22 Jul 2026 08:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLn-0002RF-Tl; Wed, 22 Jul 2026 08:47:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLm-0001dB-2r; Wed, 22 Jul 2026 08:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=ZTTjQwxL0o26VsxY7NB6uaD074sJLQ5p+S/4W2/DC90=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=s7Xk7+cwnok3bMtQUSXviao2BszlrpeWskFguCBTuCbhaQMoZNiW9M4kd/l+Hf99a
 TYyLvpMVaQeic21WuyeVgs0Fx8Ap1c/HX/Xee4rWihA15pvDAUss1NemKcgcSlY14Y
 hve/Y396xFiny/eQ92llVIavcSx67lm9pwpUZ06Yg91oewCdxj30oZz8f1O2NTXMOG
 it1UqQWNvKqJ02Wi9lFCaaWm3+O/c65+o629orpQS0bYNPsfg9XrNB9HsIoJ7AD4aJ
 K18s0a8RkhXrBwTOIkE9rRLaqfSyRTuMGu6l3EWT0H3EALae5TzK9cwXR+Bz1wmfqC
 tJoKhuDwc3TVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58AF51C3AFD;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A0C733F3757;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4A85017EE3; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 084/122] hw/misc/stm32_rcc: Correct offset-to-irq
 calculation
Date: Wed, 22 Jul 2026 15:45:33 +0300
Message-ID: <20260722124622.31034-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit 3c2749443429a2a6b60bfa5c32964628631dfa23)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 26672b5b24a..ae806b6aa81 100644
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
index ffbdf202ea5..fc7ef6af5f7 100644
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
2.47.3


