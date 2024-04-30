Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F524C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfT-00038w-7F; Tue, 30 Apr 2024 12:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf6-0002RF-1y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:49:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf2-0005dv-Ca
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41b5dd5af48so41875405e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495735; x=1715100535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VylbFy608JaMdlrgDDqUtKt4A2n5A1FKfIrh4yBh2fQ=;
 b=yg15D4XEmQ2Oh8HiDSFcitUYKFr1iFJM32Y2KpysOnfz3fV7XewShKu8ZSLfUq8yQ/
 JZ1kj/hoAfQGn9jKLXO6uifYEmS9XRuqP0uM0UTrUTWuw/tloZune/Ea2HmnCLBDJe5o
 IlPfPCWgfLR8qhkZIFSPu5l6Lv92PM4qyvgxlkL/5ITjwHyAoc54vEtmBptlF/9d6klY
 BptBR7DI5iz+QduDwylohhrkkbejZWlP8Pnrngu/7ZfsjzoMd5Xbaba8ebmVe8misy9w
 SClwnlfwggGAZGn/CbQE1qBZrioUg7oFKDBynGOgFODOBfkL+tWWl3iwhs+prEeSvxX8
 yXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495735; x=1715100535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VylbFy608JaMdlrgDDqUtKt4A2n5A1FKfIrh4yBh2fQ=;
 b=r5TZ/eUSPFL5RmWYuiQeF1+yv75utAuoXGKLnjMQbAomlKnt8VZqs5o71+3H21yERF
 uw1t0FgUjAHCK1D0PWZ1lc3FGKJqc0zoDmlVM2wbV432R0ROl8I4FOA2gcThk3spUIOV
 UKXh8oFhXo+Ezf59rwhkdkR4zQxwaJemTHgJbANJAKcQGQXBO4DFeYv+dmJXl2kCkem4
 htngS0CTkAXFADlENnhSUuG3lnqF9Wa2414BUxGJ8WFpuIs1wb91dfx/Cqt9GzCxY9rY
 ifqYxaZBTKnjrprV6L02uz4wsIgQqvAcD43q0AT6dQMR3M4APuiItg5N7DYSB56Xu13E
 6RhQ==
X-Gm-Message-State: AOJu0Yy56J+O0AxOq6T1Zc5WQ2J4pNWBkNLHYO/5J4ZZFKbfLWE/XIzt
 nND+8Axv89x/eJenXvXr0pIOXcm/t+XP2Vn0i7EQY6DMxCO57r16jvUrJVZ99PpHXOe+R0XKj9C
 9
X-Google-Smtp-Source: AGHT+IHmp0C05/TO6Etr2XvHlMugVhdRnA8BZQAOse3wQY0v4LNlkv9CWOPOX8yi9cofzO3LmhIB2Q==
X-Received: by 2002:a05:600c:1d9d:b0:418:60d6:8622 with SMTP id
 p29-20020a05600c1d9d00b0041860d68622mr83774wms.18.1714495734918; 
 Tue, 30 Apr 2024 09:48:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/21] hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5 SoC
Date: Tue, 30 Apr 2024 17:48:39 +0100
Message-Id: <20240430164842.4074734-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Exposing SYSCFG inputs to the SoC is practical in order to wire the SoC
to the optional DM163 display from the board code (GPIOs outputs need
to be connected to both SYSCFG inputs and DM163 inputs).

STM32L4x5 SYSCFG in-irq interception needed to be changed accordingly.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240424200929.240921-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stm32l4x5_soc.c              |  6 ++++--
 tests/qtest/stm32l4x5_gpio-test.c   | 13 ++++++++-----
 tests/qtest/stm32l4x5_syscfg-test.c | 17 ++++++++++-------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 39924822f3d..38f7a2d5d9f 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -1,8 +1,8 @@
 /*
  * STM32L4x5 SoC family
  *
- * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
- * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ * Copyright (c) 2023-2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023-2024 Inès Varhol <ines.varhol@telecom-paris.fr>
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
@@ -250,6 +250,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
         }
     }
 
+    qdev_pass_gpios(DEVICE(&s->syscfg), dev_soc, NULL);
+
     /* EXTI device */
     busdev = SYS_BUS_DEVICE(&s->exti);
     if (!sysbus_realize(busdev, errp)) {
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gpio-test.c
index 0f6bda54d3c..72a78234066 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -43,6 +43,9 @@
 #define OTYPER_PUSH_PULL 0
 #define OTYPER_OPEN_DRAIN 1
 
+/* SoC forwards GPIOs to SysCfg */
+#define SYSCFG "/machine/soc"
+
 const uint32_t moder_reset[NUM_GPIOS] = {
     0xABFFFFFF,
     0xFFFFFEBF,
@@ -284,7 +287,7 @@ static void test_gpio_output_mode(const void *data)
     uint32_t gpio = test_gpio_addr(data);
     unsigned int gpio_id = get_gpio_id(gpio);
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
 
     /* Set a bit in ODR and check nothing happens */
     gpio_set_bit(gpio, ODR, pin, 1);
@@ -319,7 +322,7 @@ static void test_gpio_input_mode(const void *data)
     uint32_t gpio = test_gpio_addr(data);
     unsigned int gpio_id = get_gpio_id(gpio);
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
 
     /* Configure a line as input, raise it, and check that the pin is high */
     gpio_set_2bits(gpio, MODER, pin, MODER_INPUT);
@@ -348,7 +351,7 @@ static void test_pull_up_pull_down(const void *data)
     uint32_t gpio = test_gpio_addr(data);
     unsigned int gpio_id = get_gpio_id(gpio);
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
 
     /* Configure a line as input with pull-up, check the line is set high */
     gpio_set_2bits(gpio, MODER, pin, MODER_INPUT);
@@ -378,7 +381,7 @@ static void test_push_pull(const void *data)
     uint32_t gpio = test_gpio_addr(data);
     uint32_t gpio2 = GPIO_BASE_ADDR + (GPIO_H - gpio);
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
 
     /* Setting a line high externally, configuring it in push-pull output */
     /* And checking the pin was disconnected */
@@ -425,7 +428,7 @@ static void test_open_drain(const void *data)
     uint32_t gpio = test_gpio_addr(data);
     uint32_t gpio2 = GPIO_BASE_ADDR + (GPIO_H - gpio);
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
 
     /* Setting a line high externally, configuring it in open-drain output */
     /* And checking the pin was disconnected */
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
index 59bac829b7d..506ca08bc24 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -1,8 +1,8 @@
 /*
  * QTest testcase for STM32L4x5_SYSCFG
  *
- * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
- * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -25,6 +25,10 @@
 #define SYSCFG_SWPR2 0x28
 #define INVALID_ADDR 0x2C
 
+/* SoC forwards GPIOs to SysCfg */
+#define SYSCFG "/machine/soc"
+#define EXTI "/machine/soc/exti"
+
 static void syscfg_writel(unsigned int offset, uint32_t value)
 {
     writel(SYSCFG_BASE_ADDR + offset, value);
@@ -37,8 +41,7 @@ static uint32_t syscfg_readl(unsigned int offset)
 
 static void syscfg_set_irq(int num, int level)
 {
-   qtest_set_irq_in(global_qtest, "/machine/soc/syscfg",
-                    NULL, num, level);
+   qtest_set_irq_in(global_qtest, SYSCFG, NULL, num, level);
 }
 
 static void system_reset(void)
@@ -197,7 +200,7 @@ static void test_interrupt(void)
      * Test that GPIO rising lines result in an irq
      * with the right configuration
      */
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+    qtest_irq_intercept_in(global_qtest, EXTI);
 
     /* GPIOA is the default source for EXTI lines 0 to 15 */
 
@@ -230,7 +233,7 @@ static void test_irq_pin_multiplexer(void)
      * Test that syscfg irq sets the right exti irq
      */
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+    qtest_irq_intercept_in(global_qtest, EXTI);
 
     syscfg_set_irq(0, 1);
 
@@ -257,7 +260,7 @@ static void test_irq_gpio_multiplexer(void)
      * Test that an irq is generated only by the right GPIO
      */
 
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+    qtest_irq_intercept_in(global_qtest, EXTI);
 
     /* GPIOA is the default source for EXTI lines 0 to 15 */
 
-- 
2.34.1


