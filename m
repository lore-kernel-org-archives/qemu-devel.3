Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3180CFC287
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewV-0006dj-8i; Tue, 15 Oct 2024 06:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewR-0006cA-T1
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewO-0005vU-Mx
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso2868200f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988691; x=1729593491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M8ybSySdBrTfoTyOvuNiOXF0pf6l+kJWpSoUB+F85eg=;
 b=X4rGLBNsTbqic3h1iXLqpkQRvxwjEH/MW80EdH7FPzU7c+Lq9IBQPBhMbCMb3NXNbI
 0QJMPJiXpKimkZwfRc2xaKk8E4YytClb4fOIuxE0rldrwjjWIeZFuO/KdAjVb4zzFC3Y
 XekotZ8cnzjj1opqHH78+IV1pIl0pbiW6dM4Ahe7YimUQ3m+GlCX0xOeEEyRda0vFBVe
 9vHUSIK0Mgnj2s7ykcE9698YJ8tVGVBLX/CZCYiyB6dtujggL/JeRvEuGT2Q9BxPpFuU
 /DNy6gdaaCdXa0yDGnWgAZPiGwAPlAz18mk1j8TiZBnnrWT+/XGpplzKa5Zi3oobfFw7
 P2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988691; x=1729593491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8ybSySdBrTfoTyOvuNiOXF0pf6l+kJWpSoUB+F85eg=;
 b=rLybIxeJ0gjxW+bAnZFSx0S0In3dZbESTUc8FFhcFl0iuqdR04h7NOHZDk+tsKY4i2
 gFzRQ7NZ1eVKw+mniegUTGaz1ry5oqt7kpoiiXrAWu8FnSNQslIPFrYx5dUp1HIIPKgO
 xIx2BBeRsxZgpRnZFXX7zwRut6uHgSNkRJoHleMfF/vqiNb7oiOcFxGtQZhLYqSNUteE
 +oCozJ2IGAB05WvFCcOyqk61d5Ql4vcfzh7fLyPLd8ImBIdJXSfmjcw+g3BsJUwMvPd8
 abzzKJoO3AT9z0YDZyM0y2MnFMG24WorAiEOt8e4jYZO8zupLm2KOVGFswZhv7voBJK8
 OG/w==
X-Gm-Message-State: AOJu0YwrsP34vCCz/M27UzyBMz6ucHNDBIACJrtK0hIX0IafNuIv3ZuY
 70yqvlpUuppXIBn2Rn4LKpphyq2qUtonjvKJW8sn/1khYXgnRuz+Wr9roO+wN/McSrtFCeYjNm7
 L
X-Google-Smtp-Source: AGHT+IGsrKFXwjv1eFj9i5LlS5b17Oxlv1IL1kjR35+bDDJdb7MDOES10JugcSXN+DRoPb9Gt5em2w==
X-Received: by 2002:a05:6000:b10:b0:37d:4846:42c3 with SMTP id
 ffacd0b85a97d-37d551b6ee1mr8241723f8f.22.1728988691167; 
 Tue, 15 Oct 2024 03:38:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/28] hw/arm/stm32f405: Add RCC device to stm32f405 SoC
Date: Tue, 15 Oct 2024 11:37:43 +0100
Message-Id: <20241015103808.133024-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Román Cárdenas Rodríguez <rcardenas.rod@gmail.com>

Add the reset and clock controller device to the stm32f405 SoC.

Signed-off-by: Roman Cardenas Rodriguez <rcardenas.rod@gmail.com>
[PMM: tweak commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/stm32.rst      |  3 ++-
 include/hw/arm/stm32f405_soc.h |  2 ++
 hw/arm/stm32f405_soc.c         | 12 +++++++++++-
 hw/arm/Kconfig                 |  1 +
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index 3b640f3ee07..ca7a55841b4 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -36,6 +36,7 @@ Supported devices
  * SPI controller
  * System configuration (SYSCFG)
  * Timer controller (TIMER)
+ * Reset and Clock Controller (RCC) (STM32F4 only, reset and enable only)
 
 Missing devices
 ---------------
@@ -53,7 +54,7 @@ Missing devices
  * Power supply configuration (PWR)
  * Random Number Generator (RNG)
  * Real-Time Clock (RTC) controller
- * Reset and Clock Controller (RCC)
+ * Reset and Clock Controller (RCC) (other features than reset and enable)
  * Secure Digital Input/Output (SDIO) interface
  * USB OTG
  * Watchdog controller (IWDG, WWDG)
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
index d15c03c4b5d..2eeada64ded 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -25,6 +25,7 @@
 #ifndef HW_ARM_STM32F405_SOC_H
 #define HW_ARM_STM32F405_SOC_H
 
+#include "hw/misc/stm32_rcc.h"
 #include "hw/misc/stm32f4xx_syscfg.h"
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
@@ -55,6 +56,7 @@ struct STM32F405State {
 
     ARMv7MState armv7m;
 
+    STM32RccState rcc;
     STM32F4xxSyscfgState syscfg;
     STM32F4xxExtiState exti;
     STM32F2XXUsartState usart[STM_NUM_USARTS];
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index 2ad5b79a069..72ae62156f3 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
+#define RCC_ADDR                       0x40023800
 #define SYSCFG_ADD                     0x40013800
 static const uint32_t usart_addr[] = { 0x40011000, 0x40004400, 0x40004800,
                                        0x40004C00, 0x40005000, 0x40011400,
@@ -59,6 +60,8 @@ static void stm32f405_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32_RCC);
+
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32F4XX_SYSCFG);
 
     for (i = 0; i < STM_NUM_USARTS; i++) {
@@ -160,6 +163,14 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    /* Reset and clock controller */
+    dev = DEVICE(&s->rcc);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rcc), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, RCC_ADDR);
+
     /* System configuration controller */
     dev = DEVICE(&s->syscfg);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->syscfg), errp)) {
@@ -276,7 +287,6 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("GPIOH",       0x40021C00, 0x400);
     create_unimplemented_device("GPIOI",       0x40022000, 0x400);
     create_unimplemented_device("CRC",         0x40023000, 0x400);
-    create_unimplemented_device("RCC",         0x40023800, 0x400);
     create_unimplemented_device("Flash Int",   0x40023C00, 0x400);
     create_unimplemented_device("BKPSRAM",     0x40024000, 0x400);
     create_unimplemented_device("DMA1",        0x40026000, 0x400);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index e7b9cfb59c0..f1e981622a1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -397,6 +397,7 @@ config STM32F405_SOC
     bool
     select ARM_V7M
     select OR_IRQ
+    select STM32_RCC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
-- 
2.34.1


