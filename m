Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A82C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthc-0003BS-Ad; Thu, 11 Jul 2024 09:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthH-0001mi-Gq
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:55 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth7-000646-Ag
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52e94eaf5efso1208097e87.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703913; x=1721308713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nfyQtkiwwsL75LQyY+1VpdO3jlXGa6ezaQj3z/0lsxc=;
 b=I7+rZf5SRGBdjXjs1wM+FwiIM2QC+jJhMsFZcjFjlZN7MHKOd62sTpTVmhZvI1q7z+
 Gn0PuncP59XV/GdQsYzyJ0T9vzblXNiEalXSWLDqxiriDkViIfXXBAolzZX+l8u5sCsx
 +1oJx2vnHtYXjVqh3+DGYtBzIXT/MXb9WCwyO0lg6m31dadsxVF+FCyJpjDHSAopkokB
 nQjJF2feC5lWzBSqJVsM2BeLy5FsoFtI490bYvfxbFXudJdIXi5TI7Q9Ur3ZzIfO27T0
 aPcy9xcCpG2QgC4aDsypMxGHUm4r6+qHKYPxBlAPi6NAQkFsotP6U51o1lhOIMtocqKU
 rs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703913; x=1721308713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nfyQtkiwwsL75LQyY+1VpdO3jlXGa6ezaQj3z/0lsxc=;
 b=dbQ5Q5cVnbpMJ3VYdGMdlMZL+9geXjsDDDXh/x6vHrgk2k73YqHUCeG7ivbYRwwNfA
 TysmJKto5js/3VbFr0uiM5H+dfvAwG+CGmVAWqjX6jc/e3s3QtyUG+vmDo5pUGIDJrUE
 3HBMY3qZWChZ10nNUH9cAjZtuES8r1Fu1O1OJOk39COO4qnPSUOLbqZl66ye4bOIkQ0J
 h4/84+wqWMsbiig+WFdNLyxU3PEQIT3Z4ZGM9lxuGtolMrDOeMPREjat/woYdumZj9e5
 0yUV1npPociYEGY3asAScbuuydvEekrZV2rHpX2mIzdwwalBb3YGreBVChiDJhWOTjNl
 poYg==
X-Gm-Message-State: AOJu0Yyf9phxeed0KQNbIpVUxtHARa6WkL+JOqHOl8ZkCsOcrPlSkBgH
 9O6dPg41XdSAaFQJe+79JtpsYo9gsMkx81oZV7xorMiWlNIVHv9KU1uee7oweB4O1YmWPDMlquD
 tS6Q=
X-Google-Smtp-Source: AGHT+IHewWYSazXg+D/SDJuOFMvaPjGQZTsJOCcLEWkYPc6x73SglLgLRBF1zb90PAKhyajJUbnfTw==
X-Received: by 2002:ac2:5f56:0:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-52eb99a31f1mr4717141e87.40.1720703913461; 
 Thu, 11 Jul 2024 06:18:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/24] hw/arm: In STM32L4x5 SOC, connect USART devices to EXTI
Date: Thu, 11 Jul 2024 14:18:16 +0100
Message-Id: <20240711131822.3909903-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

The USART devices were previously connecting their outbound IRQs
directly to the CPU because the EXTI wasn't handling direct lines
interrupts.
Now the USART connects to the EXTI inbound GPIOs, and the EXTI connects
its IRQs to the CPU.
The existing QTest for the USART (tests/qtest/stm32l4x5_usart-test.c)
checks that USART1_IRQ in the CPU is pending when expected so it
confirms that the connection through the EXTI still works.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240707085927.122867-4-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stm32l4x5_soc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 38f7a2d5d9f..fac83d349c8 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -81,6 +81,10 @@ static const int exti_irq[NUM_EXTI_IRQ] = {
 #define RCC_BASE_ADDRESS 0x40021000
 #define RCC_IRQ 5
 
+#define EXTI_USART1_IRQ 26
+#define EXTI_UART4_IRQ 29
+#define EXTI_LPUART1_IRQ 31
+
 static const int exti_or_gates_out[NUM_EXTI_OR_GATES] = {
     23, 40, 63, 1,
 };
@@ -129,10 +133,6 @@ static const hwaddr uart_addr[] = {
 
 #define LPUART_BASE_ADDRESS 0x40008000
 
-static const int usart_irq[] = { 37, 38, 39 };
-static const int uart_irq[] = { 52, 53 };
-#define LPUART_IRQ 70
-
 static void stm32l4x5_soc_initfn(Object *obj)
 {
     Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
@@ -297,6 +297,7 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         }
     }
 
+    /* Connect SYSCFG to EXTI */
     for (unsigned i = 0; i < GPIO_NUM_PINS; i++) {
         qdev_connect_gpio_out(DEVICE(&s->syscfg), i,
                               qdev_get_gpio_in(DEVICE(&s->exti), i));
@@ -322,15 +323,10 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
         sysbus_mmio_map(busdev, 0, usart_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->exti),
+                                                       EXTI_USART1_IRQ + i));
     }
 
-    /*
-     * TODO: Connect the USARTs, UARTs and LPUART to the EXTI once the EXTI
-     * can handle other gpio-in than the gpios. (e.g. Direct Lines for the
-     * usarts)
-     */
-
     /* UART devices */
     for (int i = 0; i < STM_NUM_UARTS; i++) {
         g_autofree char *name = g_strdup_printf("uart%d-out", STM_NUM_USARTS + i + 1);
@@ -343,7 +339,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
             return;
         }
         sysbus_mmio_map(busdev, 0, uart_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, uart_irq[i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->exti),
+                                                       EXTI_UART4_IRQ + i));
     }
 
     /* LPUART device*/
@@ -356,7 +353,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
     sysbus_mmio_map(busdev, 0, LPUART_BASE_ADDRESS);
-    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, LPUART_IRQ));
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(&s->exti),
+                                                   EXTI_LPUART1_IRQ));
 
     /* APB1 BUS */
     create_unimplemented_device("TIM2",      0x40000000, 0x400);
-- 
2.34.1


