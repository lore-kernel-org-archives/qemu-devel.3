Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF831CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 09:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq8X0-0000cf-9O; Fri, 29 Mar 2024 05:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rq8Wx-0000cV-PW
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 05:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rq8Wv-0008Kq-Rf
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 05:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711704488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1v/Cl11JfQI+9HzG3Z7J4flqNzx/RAyH+MAy1AhQtC0=;
 b=GvcE/zsHd12YWDJtVeGWGKFrxDiavK5wgepqmo0qfIZzMXKmvTuj14Gx5kQrYA9knEsXBA
 b0wFFUBPoCupuVwuPgWXOKXl/T1Ov/c4mM5O/P6N6LGZzupjIY+ZdFoLqYF5V/ywuNKzmY
 /xjQO4PuRfGFVrIfrdXJB8C69EK526U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-o5rc7PsrPx6uMhOoXqVYqA-1; Fri, 29 Mar 2024 05:28:06 -0400
X-MC-Unique: o5rc7PsrPx6uMhOoXqVYqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BDA0800262;
 Fri, 29 Mar 2024 09:28:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A581717AA3;
 Fri, 29 Mar 2024 09:27:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Subject: [PATCH for-9.0] tests/qtest: Fix STM32L4x5 GPIO test on 32-bit
Date: Fri, 29 Mar 2024 10:27:47 +0100
Message-ID: <20240329092747.298259-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 tests/qtest/stm32l4x5_gpio-test.c | 59 ++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gpio-test.c
index cc56be2031f7a5e0c501db02e7484ad70e54573c..0f6bda54d3c0704f4bbb982824d89bb2aca75367 100644
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
2.44.0


