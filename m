Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC64C001CC
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 13:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvzZ5-0007n8-Pq; Sun, 14 Apr 2024 09:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rvzZ1-0007kA-Rf; Sun, 14 Apr 2024 09:06:31 -0400
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rvzYw-0007Et-0W; Sun, 14 Apr 2024 09:06:30 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 5F41AC064E;
 Sun, 14 Apr 2024 15:06:18 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id oWntk_Dx0LQf; Sun, 14 Apr 2024 15:06:17 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id D375CC062F;
 Sun, 14 Apr 2024 15:06:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr D375CC062F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713099977;
 bh=/o1ab/cxfRN6X232LswwPlcMA4iU/ZqxyADyzyD45ek=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=m2C8M+I6hRKb9bitarjXjFymZzOj9vLOb9fYRqt6Q1ymlP7lpWEViYkQUEjQkIq3g
 7o7h/OQtFE3BbWLVz+2ScwYPdP+duZGNLGFSDPrkHYy7MWzTqoAaFeZMm4SIjib7rm
 /DkL2Z1EM/jN51BLhBJnMBF3lXzFNbLcS0vxdL1I=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 7dghrslxCNKr; Sun, 14 Apr 2024 15:06:17 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id D923BC0593;
 Sun, 14 Apr 2024 15:06:16 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v4 2/5] hw/arm : Pass STM32L4x5 SYSCFG gpios to STM32L4x5 SoC
Date: Sun, 14 Apr 2024 15:05:45 +0200
Message-ID: <20240414130604.182059-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
References: <20240414130604.182059-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Exposing SYSCFG inputs to the SoC is practical in order to wire the SoC
to the optional DM163 display from the board code (GPIOs outputs need
to be connected to both SYSCFG inputs and DM163 inputs).

STM32L4x5 SYSCFG in-irq interception needed to be changed accordingly.

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/stm32l4x5_soc.c              |  6 ++++--
 tests/qtest/stm32l4x5_gpio-test.c   | 12 +++++++-----
 tests/qtest/stm32l4x5_syscfg-test.c | 16 +++++++++-------
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 40e294f838..c4b45e6956 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -1,8 +1,8 @@
 /*
  * STM32L4x5 SoC family
  *
- * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
- * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
  *
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
@@ -221,6 +221,8 @@ static void stm32l4x5_soc_realize(DeviceState *dev_so=
c, Error **errp)
         }
     }
=20
+    qdev_pass_gpios(DEVICE(&s->syscfg), dev_soc, NULL);
+
     /* EXTI device */
     busdev =3D SYS_BUS_DEVICE(&s->exti);
     if (!sysbus_realize(busdev, errp)) {
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gp=
io-test.c
index 0f6bda54d3..495a6fc413 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -43,6 +43,8 @@
 #define OTYPER_PUSH_PULL 0
 #define OTYPER_OPEN_DRAIN 1
=20
+#define SYSCFG "/machine/soc"
+
 const uint32_t moder_reset[NUM_GPIOS] =3D {
     0xABFFFFFF,
     0xFFFFFEBF,
@@ -284,7 +286,7 @@ static void test_gpio_output_mode(const void *data)
     uint32_t gpio =3D test_gpio_addr(data);
     unsigned int gpio_id =3D get_gpio_id(gpio);
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
=20
     /* Set a bit in ODR and check nothing happens */
     gpio_set_bit(gpio, ODR, pin, 1);
@@ -319,7 +321,7 @@ static void test_gpio_input_mode(const void *data)
     uint32_t gpio =3D test_gpio_addr(data);
     unsigned int gpio_id =3D get_gpio_id(gpio);
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
=20
     /* Configure a line as input, raise it, and check that the pin is hi=
gh */
     gpio_set_2bits(gpio, MODER, pin, MODER_INPUT);
@@ -348,7 +350,7 @@ static void test_pull_up_pull_down(const void *data)
     uint32_t gpio =3D test_gpio_addr(data);
     unsigned int gpio_id =3D get_gpio_id(gpio);
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
=20
     /* Configure a line as input with pull-up, check the line is set hig=
h */
     gpio_set_2bits(gpio, MODER, pin, MODER_INPUT);
@@ -378,7 +380,7 @@ static void test_push_pull(const void *data)
     uint32_t gpio =3D test_gpio_addr(data);
     uint32_t gpio2 =3D GPIO_BASE_ADDR + (GPIO_H - gpio);
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
=20
     /* Setting a line high externally, configuring it in push-pull outpu=
t */
     /* And checking the pin was disconnected */
@@ -425,7 +427,7 @@ static void test_open_drain(const void *data)
     uint32_t gpio =3D test_gpio_addr(data);
     uint32_t gpio2 =3D GPIO_BASE_ADDR + (GPIO_H - gpio);
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/syscfg");
+    qtest_irq_intercept_in(global_qtest, SYSCFG);
=20
     /* Setting a line high externally, configuring it in open-drain outp=
ut */
     /* And checking the pin was disconnected */
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index ed4801798d..eed9d5940b 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -1,8 +1,8 @@
 /*
  * QTest testcase for STM32L4x5_SYSCFG
  *
- * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
- * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
@@ -25,6 +25,9 @@
 #define SYSCFG_SWPR2 0x28
 #define INVALID_ADDR 0x2C
=20
+#define EXTI "/machine/soc/exti"
+#define SYSCFG "/machine/soc"
+
 static void syscfg_writel(unsigned int offset, uint32_t value)
 {
     writel(SYSCFG_BASE_ADDR + offset, value);
@@ -37,8 +40,7 @@ static uint32_t syscfg_readl(unsigned int offset)
=20
 static void syscfg_set_irq(int num, int level)
 {
-   qtest_set_irq_in(global_qtest, "/machine/soc/syscfg",
-                    NULL, num, level);
+   qtest_set_irq_in(global_qtest, SYSCFG, NULL, num, level);
 }
=20
 static void system_reset(void)
@@ -197,7 +199,7 @@ static void test_interrupt(void)
      * Test that GPIO rising lines result in an irq
      * with the right configuration
      */
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+    qtest_irq_intercept_in(global_qtest, EXTI);
=20
     /* GPIOA is the default source for EXTI lines 0 to 15 */
=20
@@ -230,7 +232,7 @@ static void test_irq_pin_multiplexer(void)
      * Test that syscfg irq sets the right exti irq
      */
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+    qtest_irq_intercept_in(global_qtest, EXTI);
=20
     syscfg_set_irq(0, 1);
=20
@@ -257,7 +259,7 @@ static void test_irq_gpio_multiplexer(void)
      * Test that an irq is generated only by the right GPIO
      */
=20
-    qtest_irq_intercept_in(global_qtest, "/machine/soc/exti");
+    qtest_irq_intercept_in(global_qtest, EXTI);
=20
     /* GPIOA is the default source for EXTI lines 0 to 15 */
=20
--=20
2.43.2


