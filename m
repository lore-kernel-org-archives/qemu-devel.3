Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D2FCFC286
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 10:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0ewX-0006g9-Vm; Tue, 15 Oct 2024 06:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewU-0006d4-6c
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0ewR-0005w2-Pp
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 06:38:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43111cff9d3so39035565e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 03:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728988694; x=1729593494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T/8MhemOTljPnrKxsD/elwfdUS+UpSgEuo6SU7bdXqc=;
 b=StWJIp6wYoDR3pn4xnxzp+F5RnqJwLE8GK/GOvRnScBklH9XJmmol/T6/kicn/MqsE
 zgLURScrDwCSe44vldvnf8di84rRTrib9lmv1swigFwLRxCMFIJKWv3jXo4JsSpz3nJ6
 k8KsctBj/hxZxzq3/Jkwe0domh2/AAuVr/QT6retjDEN/qEtsqh5blcJGRvd47PsdjSu
 urJ9fDPTqCpMTgbcKtifAXx30GUcGJmC/WEgqwkQNXBVu5z6iP/3iR1lQqz4sP0+sbl5
 VZG4Uf7At8R9cy3awqAaHFFN3etdIvr+PjYoPzgq+dtLllKr71Oz6CtazBwzpTyQwx0m
 YTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728988694; x=1729593494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/8MhemOTljPnrKxsD/elwfdUS+UpSgEuo6SU7bdXqc=;
 b=NM2uFJik46F0S5KXj3R2p9CQByXhaMV5V90hAr4CLrYL06OAGIf/o55WvByK2B3GVQ
 BVaxKBDAnBGWURbwek6X+GIwlFn0g/Mn3g7ciZGDZXho30fQdpk2QNxFvgU88X+W7aHc
 nCgiI+5q50Tizv2e9udSC9TxQ4mvJolyG/KqWUDwKnnNEMuGEHrytLtip54AfqJW3AXZ
 4dhdKs+fCjezM0vilz/7AO0EGPU7Dxli2BSSQ7/TV1a/DN9NaYTPpJYVihHItbWBxpTN
 fSkvuy3uqlFBhUbt8Qwu178SMGjho0fg4D/wEwcrethEaywpMI/Wao7G9Xgv9ROqYtn0
 eijQ==
X-Gm-Message-State: AOJu0YwCFF7y8SwVvWDbKGndFI2j0W+bTa4+dWj7vOxWgP0ityk1XymS
 fao8feeZzkn9SFbkbwSYpJGVppORF3vrQpSZSVHIctEkttpbbkIVO4jXOCxG94YF2GYe8AZ/jhz
 1
X-Google-Smtp-Source: AGHT+IFdcKp5HJzddTCUjS9tfz7zBA+EgrOh7T2My2DTFNrWmO31CBW896Gr8x4pLRIBNqWVDLjTbw==
X-Received: by 2002:a5d:5708:0:b0:37d:4fe9:b6a6 with SMTP id
 ffacd0b85a97d-37d551f2dbfmr8918582f8f.29.1728988694070; 
 Tue, 15 Oct 2024 03:38:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa7a06dsm1241635f8f.5.2024.10.15.03.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 03:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/28] tests/qtest: Check STM32L4x5 clock connections
Date: Tue, 15 Oct 2024 11:37:49 +0100
Message-Id: <20241015103808.133024-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015103808.133024-1-peter.maydell@linaro.org>
References: <20241015103808.133024-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

For USART, GPIO and SYSCFG devices, check that clock frequency before
and after enabling the peripheral clock in RCC is correct.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241003081105.40836-4-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5.h             | 42 +++++++++++++++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   | 23 ++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 20 ++++++++++++--
 tests/qtest/stm32l4x5_usart-test.c  | 26 ++++++++++++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/stm32l4x5.h

diff --git a/tests/qtest/stm32l4x5.h b/tests/qtest/stm32l4x5.h
new file mode 100644
index 00000000000..2d21cc666cc
--- /dev/null
+++ b/tests/qtest/stm32l4x5.h
@@ -0,0 +1,42 @@
+/*
+ * QTest testcase header for STM32L4X5 :
+ * used for consolidating common objects in stm32l4x5_*-test.c
+ *
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "libqtest.h"
+
+/* copied from clock.h */
+#define CLOCK_PERIOD_1SEC (1000000000llu << 32)
+#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) != 0) ? CLOCK_PERIOD_1SEC / (hz) : 0u)
+/*
+ * MSI (4 MHz) is used as system clock source after startup
+ * from Reset.
+ * AHB, APB1 and APB2 prescalers are set to 1 at reset.
+ */
+#define SYSCLK_PERIOD CLOCK_PERIOD_FROM_HZ(4000000)
+#define RCC_AHB2ENR 0x4002104C
+#define RCC_APB1ENR1 0x40021058
+#define RCC_APB1ENR2 0x4002105C
+#define RCC_APB2ENR 0x40021060
+
+
+static inline uint64_t get_clock_period(QTestState *qts, const char *path)
+{
+    uint64_t clock_period = 0;
+    QDict *r;
+
+    r = qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments':"
+        " { 'path': %s, 'property': 'qtest-clock-period'} }", path);
+    g_assert_false(qdict_haskey(r, "error"));
+    clock_period = qdict_get_int(r, "return");
+    qobject_unref(r);
+    return clock_period;
+}
+
+
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gpio-test.c
index 72a78234066..c0686c7b306 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "stm32l4x5.h"
 
 #define GPIO_BASE_ADDR 0x48000000
 #define GPIO_SIZE      0x400
@@ -505,6 +506,26 @@ static void test_bsrr_brr(const void *data)
     gpio_writel(gpio, ODR, reset(gpio, ODR));
 }
 
+static void test_clock_enable(void)
+{
+    /*
+     * For each GPIO, enable its clock in RCC
+     * and check that its clock period changes to SYSCLK_PERIOD
+     */
+    unsigned int gpio_id;
+
+    for (uint32_t gpio = GPIO_A; gpio <= GPIO_H; gpio += GPIO_B - GPIO_A) {
+        gpio_id = get_gpio_id(gpio);
+        g_autofree char *path = g_strdup_printf("/machine/soc/gpio%c/clk",
+                                                gpio_id + 'a');
+        g_assert_cmpuint(get_clock_period(global_qtest, path), ==, 0);
+        /* Enable the gpio clock */
+        writel(RCC_AHB2ENR, readl(RCC_AHB2ENR) | (0x1 << gpio_id));
+        g_assert_cmpuint(get_clock_period(global_qtest, path), ==,
+                         SYSCLK_PERIOD);
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -556,6 +577,8 @@ int main(int argc, char **argv)
     qtest_add_data_func("stm32l4x5/gpio/test_bsrr_brr2",
                         test_data(GPIO_D, 0),
                         test_bsrr_brr);
+    qtest_add_func("stm32l4x5/gpio/test_clock_enable",
+                   test_clock_enable);
 
     qtest_start("-machine b-l475e-iot01a");
     ret = g_test_run();
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
index 258417cd889..d5c71e2c0e7 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -10,6 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "stm32l4x5.h"
 
 #define SYSCFG_BASE_ADDR 0x40010000
 #define SYSCFG_MEMRMP 0x00
@@ -26,7 +27,9 @@
 #define INVALID_ADDR 0x2C
 
 /* SoC forwards GPIOs to SysCfg */
-#define SYSCFG "/machine/soc"
+#define SOC "/machine/soc"
+#define SYSCFG "/machine/soc/syscfg"
+#define SYSCFG_CLK "/machine/soc/syscfg/clk"
 #define EXTI "/machine/soc/exti"
 
 static void syscfg_writel(unsigned int offset, uint32_t value)
@@ -41,7 +44,7 @@ static uint32_t syscfg_readl(unsigned int offset)
 
 static void syscfg_set_irq(int num, int level)
 {
-   qtest_set_irq_in(global_qtest, SYSCFG, NULL, num, level);
+   qtest_set_irq_in(global_qtest, SOC, NULL, num, level);
 }
 
 static void system_reset(void)
@@ -301,6 +304,17 @@ static void test_irq_gpio_multiplexer(void)
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
 }
 
+static void test_clock_enable(void)
+{
+    g_assert_cmpuint(get_clock_period(global_qtest, SYSCFG_CLK), ==, 0);
+
+    /* Enable SYSCFG clock */
+    writel(RCC_APB2ENR, readl(RCC_APB2ENR) | (0x1 << 0));
+
+    g_assert_cmpuint(get_clock_period(global_qtest, SYSCFG_CLK), ==,
+                                       SYSCLK_PERIOD);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -325,6 +339,8 @@ int main(int argc, char **argv)
                    test_irq_pin_multiplexer);
     qtest_add_func("stm32l4x5/syscfg/test_irq_gpio_multiplexer",
                    test_irq_gpio_multiplexer);
+    qtest_add_func("stm32l4x5/syscfg/test_clock_enable",
+                   test_clock_enable);
 
     qtest_start("-machine b-l475e-iot01a");
     ret = g_test_run();
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 64cebda60f0..315bcee0042 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -12,6 +12,7 @@
 #include "libqtest.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
 #include "hw/registerfields.h"
+#include "stm32l4x5.h"
 
 #define RCC_BASE_ADDR 0x40021000
 /* Use USART 1 ADDR, assume the others work the same */
@@ -331,6 +332,30 @@ static void test_ack(void)
     qtest_quit(qts);
 }
 
+static void check_clock(QTestState *qts, const char *path, uint32_t rcc_reg,
+                        uint32_t reg_offset)
+{
+    g_assert_cmpuint(get_clock_period(qts, path), ==, 0);
+    qtest_writel(qts, rcc_reg, qtest_readl(qts, rcc_reg) | (0x1 << reg_offset));
+    g_assert_cmpuint(get_clock_period(qts, path), ==, SYSCLK_PERIOD);
+}
+
+static void test_clock_enable(void)
+{
+    /*
+     * For each USART device, enable its clock in RCC
+     * and check that its clock frequency is SYSCLK_PERIOD
+     */
+    QTestState *qts = qtest_init("-M b-l475e-iot01a");
+
+    check_clock(qts, "machine/soc/usart[0]/clk", RCC_APB2ENR, 14);
+    check_clock(qts, "machine/soc/usart[1]/clk", RCC_APB1ENR1, 17);
+    check_clock(qts, "machine/soc/usart[2]/clk", RCC_APB1ENR1, 18);
+    check_clock(qts, "machine/soc/uart[0]/clk", RCC_APB1ENR1, 19);
+    check_clock(qts, "machine/soc/uart[1]/clk", RCC_APB1ENR1, 20);
+    check_clock(qts, "machine/soc/lpuart1/clk", RCC_APB1ENR2, 0);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -344,6 +369,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
     qtest_add_func("stm32l4x5/usart/ack", test_ack);
+    qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
     ret = g_test_run();
 
     return ret;
-- 
2.34.1


