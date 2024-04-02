Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB310C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbP8-0008Np-LD; Tue, 02 Apr 2024 06:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbP4-0008L8-8M
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:06 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrbOy-0003fL-KD
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:30:05 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-415584360c0so18040185e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712053795; x=1712658595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z0wrG3SHPfvp8oYYuwfJ6UUShS6yr2AWBhFDuw/bUJo=;
 b=bIfQCa/60y/rKUTJWf/QY3qsnEvE1Nq7twIGYyuRhO3SX3WPbZmcH8uOsil8nqoafW
 O7SywO37lNrbnU+Xeupk2hO/sC9ezWl/q+1/J5g6v4oVZTpTUeSG09PlDaoJWDOJpcQ4
 TDQNxTvTyXzu4+FZ6TV4FYk4PPLZNOPrtS9BBUtpUDKHqhrp6q9nJ6PUE3qCKnsyLxDX
 ACBAQwIlWsGj0WTcSxIG8kP7syzQTVal8ZBryfRp4RBmdq7qqYWxWxH6siHYCUnFhxxr
 HKalVemX+dX+h67A7DGK8fXh2OyTg6vuHSqLiH8lA4wSqFiZAkJ1PqmZI8ToDrBW4g3b
 /htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712053795; x=1712658595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0wrG3SHPfvp8oYYuwfJ6UUShS6yr2AWBhFDuw/bUJo=;
 b=nEqbtIE11e53B85T+U+47cdcq57Xg4vwtLp/rC19HuhirerkRkjOp/KvyXsalQzukd
 J7S6dOp1QmiNixjNsp4m7a0ubF5MD67y+8n6zEOyJneRPhUlF4ce6JXkEmMHrWxjyJcx
 tKHJkvSEH0y6YmvA6ay7x0QsknMJhqGMbeBk5u8aK8IJysjqvwydzwLAgv+BilHtN7C1
 GXNwi4f8ZFJPnwolJT7U/cRqu30y7Jc75SjWZGr+Zw8Bte9KiPJ5Y97H2dpt8GuaBk1a
 GqQ64rkwStZOwZbT4N7Qe+LzyrA7FpmyeOozCowgzeLrDLZjGTEVc06+whYiho0RBYuM
 1lpg==
X-Gm-Message-State: AOJu0YxlkaKq4WavPGT3pAB+wXWpgVm8zAjTWNLCMqhyeRf2OFmIdmy2
 DI9EuA91Ki5hsZDqx+gwcsAtQsY5467NxWAAkld4KGcP+6VhvedvRij+tZIbWjQZrtGqDJVzzdo
 n
X-Google-Smtp-Source: AGHT+IGG3jziZXHaZrHtdEtPV3sg+dgHdBj7zdVKW7WJtJrhIUTHv9zkspxgoILz3jeuJo0ebHRFVA==
X-Received: by 2002:a05:600c:3587:b0:414:ae9b:7d71 with SMTP id
 p7-20020a05600c358700b00414ae9b7d71mr9190322wmq.27.1712053795400; 
 Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20586175wmq.33.2024.04.02.03.29.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:29:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
Date: Tue,  2 Apr 2024 11:29:50 +0100
Message-Id: <20240402102951.3099078-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402102951.3099078-1-peter.maydell@linaro.org>
References: <20240402102951.3099078-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Cédric Le Goater <clg@redhat.com>

The test mangles the GPIO address and the pin number in the
qtest_add_data_func data parameter. Doing so, it assumes that the host
pointer size is always 64-bit, which breaks on 32-bit :

../tests/qtest/stm32l4x5_gpio-test.c: In function ‘test_gpio_output_mode’:
../tests/qtest/stm32l4x5_gpio-test.c:272:25: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  272 |     unsigned int pin = ((uint64_t)data) & 0xF;
      |                         ^
../tests/qtest/stm32l4x5_gpio-test.c:273:22: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  273 |     uint32_t gpio = ((uint64_t)data) >> 32;
      |                      ^

To fix, improve the mangling of the GPIO address and pin number fields
by using GPIO_SIZE so that the resulting value fits in a 32-bit pointer.
While at it, include some helpers to hide the details.

Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: Inès Varhol <ines.varhol@telecom-paris.fr>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20240329092747.298259-1-clg@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_gpio-test.c | 59 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gpio-test.c
index cc56be2031f..0f6bda54d3c 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -76,6 +76,17 @@ const uint32_t idr_reset[NUM_GPIOS] = {
     0x00000000
 };
 
+#define PIN_MASK        0xF
+#define GPIO_ADDR_MASK  (~(GPIO_SIZE - 1))
+
+static inline void *test_data(uint32_t gpio_addr, uint8_t pin)
+{
+    return (void *)(uintptr_t)((gpio_addr & GPIO_ADDR_MASK) | (pin & PIN_MASK));
+}
+
+#define test_gpio_addr(data)      ((uintptr_t)(data) & GPIO_ADDR_MASK)
+#define test_pin(data)            ((uintptr_t)(data) & PIN_MASK)
+
 static uint32_t gpio_readl(unsigned int gpio, unsigned int offset)
 {
     return readl(gpio + offset);
@@ -269,8 +280,8 @@ static void test_gpio_output_mode(const void *data)
      * Additionally, it checks that values written to ODR
      * when not in output mode are stored and not discarded.
      */
-    unsigned int pin = ((uint64_t)data) & 0xF;
-    uint32_t gpio = ((uint64_t)data) >> 32;
+    unsigned int pin = test_pin(data);
+    uint32_t gpio = test_gpio_addr(data);
     unsigned int gpio_id = get_gpio_id(gpio);
 
     qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
@@ -304,8 +315,8 @@ static void test_gpio_input_mode(const void *data)
      * corresponding GPIO line high/low : it should set the
      * right bit in IDR and send an irq to syscfg.
      */
-    unsigned int pin = ((uint64_t)data) & 0xF;
-    uint32_t gpio = ((uint64_t)data) >> 32;
+    unsigned int pin = test_pin(data);
+    uint32_t gpio = test_gpio_addr(data);
     unsigned int gpio_id = get_gpio_id(gpio);
 
     qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
@@ -333,8 +344,8 @@ static void test_pull_up_pull_down(const void *data)
      * Test that a floating pin with pull-up sets the pin
      * high and vice-versa.
      */
-    unsigned int pin = ((uint64_t)data) & 0xF;
-    uint32_t gpio = ((uint64_t)data) >> 32;
+    unsigned int pin = test_pin(data);
+    uint32_t gpio = test_gpio_addr(data);
     unsigned int gpio_id = get_gpio_id(gpio);
 
     qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
@@ -363,8 +374,8 @@ static void test_push_pull(const void *data)
      * disconnects the pin, that the pin can't be set or reset
      * externally afterwards.
      */
-    unsigned int pin = ((uint64_t)data) & 0xF;
-    uint32_t gpio = ((uint64_t)data) >> 32;
+    unsigned int pin = test_pin(data);
+    uint32_t gpio = test_gpio_addr(data);
     uint32_t gpio2 = GPIO_BASE_ADDR + (GPIO_H - gpio);
 
     qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
@@ -410,8 +421,8 @@ static void test_open_drain(const void *data)
      * However a pin set low externally shouldn't be disconnected,
      * and it can be set low externally when in open-drain mode.
      */
-    unsigned int pin = ((uint64_t)data) & 0xF;
-    uint32_t gpio = ((uint64_t)data) >> 32;
+    unsigned int pin = test_pin(data);
+    uint32_t gpio = test_gpio_addr(data);
     uint32_t gpio2 = GPIO_BASE_ADDR + (GPIO_H - gpio);
 
     qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
@@ -466,8 +477,8 @@ static void test_bsrr_brr(const void *data)
      * has the desired effect on ODR.
      * In BSRR, BSx has priority over BRx.
      */
-    unsigned int pin = ((uint64_t)data) & 0xF;
-    uint32_t gpio = ((uint64_t)data) >> 32;
+    unsigned int pin = test_pin(data);
+    uint32_t gpio = test_gpio_addr(data);
 
     gpio_writel(gpio, BSRR, (1 << pin));
     g_assert_cmphex(gpio_readl(gpio, ODR), ==, reset(gpio, ODR) | (1 << pin));
@@ -507,40 +518,40 @@ int main(int argc, char **argv)
      * is problematic since the pin was already high.
      */
     qtest_add_data_func("stm32l4x5/gpio/test_gpioc5_output_mode",
-                        (void *)((uint64_t)GPIO_C << 32 | 5),
+                        test_data(GPIO_C, 5),
                         test_gpio_output_mode);
     qtest_add_data_func("stm32l4x5/gpio/test_gpioh3_output_mode",
-                        (void *)((uint64_t)GPIO_H << 32 | 3),
+                        test_data(GPIO_H, 3),
                         test_gpio_output_mode);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_input_mode1",
-                        (void *)((uint64_t)GPIO_D << 32 | 6),
+                        test_data(GPIO_D, 6),
                         test_gpio_input_mode);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_input_mode2",
-                        (void *)((uint64_t)GPIO_C << 32 | 10),
+                        test_data(GPIO_C, 10),
                         test_gpio_input_mode);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_pull_up_pull_down1",
-                        (void *)((uint64_t)GPIO_B << 32 | 5),
+                        test_data(GPIO_B, 5),
                         test_pull_up_pull_down);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_pull_up_pull_down2",
-                        (void *)((uint64_t)GPIO_F << 32 | 1),
+                        test_data(GPIO_F, 1),
                         test_pull_up_pull_down);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_push_pull1",
-                        (void *)((uint64_t)GPIO_G << 32 | 6),
+                        test_data(GPIO_G, 6),
                         test_push_pull);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_push_pull2",
-                        (void *)((uint64_t)GPIO_H << 32 | 3),
+                        test_data(GPIO_H, 3),
                         test_push_pull);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_open_drain1",
-                        (void *)((uint64_t)GPIO_C << 32 | 4),
+                        test_data(GPIO_C, 4),
                         test_open_drain);
     qtest_add_data_func("stm32l4x5/gpio/test_gpio_open_drain2",
-                        (void *)((uint64_t)GPIO_E << 32 | 11),
+                        test_data(GPIO_E, 11),
                         test_open_drain);
     qtest_add_data_func("stm32l4x5/gpio/test_bsrr_brr1",
-                        (void *)((uint64_t)GPIO_A << 32 | 12),
+                        test_data(GPIO_A, 12),
                         test_bsrr_brr);
     qtest_add_data_func("stm32l4x5/gpio/test_bsrr_brr2",
-                        (void *)((uint64_t)GPIO_D << 32 | 0),
+                        test_data(GPIO_D, 0),
                         test_bsrr_brr);
 
     qtest_start("-machine b-l475e-iot01a");
-- 
2.34.1


