Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0DFC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 19:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Q21-0008H7-Fn; Tue, 07 May 2024 14:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1w-0008Bz-KA; Tue, 07 May 2024 14:59:12 -0400
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1s4Q1t-0006Aq-QR; Tue, 07 May 2024 14:59:12 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 950FFC0D30;
 Tue,  7 May 2024 20:59:07 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id rRhCOOj9oPHE; Tue,  7 May 2024 20:59:07 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 20766C0D05;
 Tue,  7 May 2024 20:59:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 20766C0D05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1715108347;
 bh=IrR2Qad9VCbTE2UXFB7znMO4uXFwPBsww9btUNUzoLQ=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=iBJWW5Iushq9As6knhZAr2A6kTMU6O0DT2RCom6Xa1EMibDuVCxMFtUkiJcCwwg36
 d3hjqp4lYE2l09iEiw4znVXs+GyQu1yAHPMNTZ5ZeGO1rnNaedcrpkvx1yOfZ6NW8X
 S6XFU6OaI2Pyh93/8blmrgaZmgktdEWuPi9m6G7U=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id giaDoVpdQgOG; Tue,  7 May 2024 20:59:07 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 25264C0D30;
 Tue,  7 May 2024 20:59:06 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/4] tests/qtest: Check STM32L4x5 clock connections
Date: Tue,  7 May 2024 20:55:41 +0200
Message-ID: <20240507185854.34572-5-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
References: <20240507185854.34572-1-ines.varhol@telecom-paris.fr>
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

For USART, GPIO and SYSCFG devices, check that clock frequency before
and after enabling the peripheral clock in RCC is correct.

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 tests/qtest/stm32l4x5.h             | 40 +++++++++++++++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   | 23 +++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 19 ++++++++++++--
 tests/qtest/stm32l4x5_usart-test.c  | 26 +++++++++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/stm32l4x5.h

diff --git a/tests/qtest/stm32l4x5.h b/tests/qtest/stm32l4x5.h
new file mode 100644
index 0000000000..b8ef6698b2
--- /dev/null
+++ b/tests/qtest/stm32l4x5.h
@@ -0,0 +1,40 @@
+/*
+ * QTest testcase header for STM32L4X5 :
+ * used for consolidating common objects in stm32l4x5_*-test.c
+ *
+ * Copyright (c) 2024 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2024 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/*
+ * MSI (4 MHz) is used as system clock source after startup
+ * from Reset.
+ * AHB, APB1 and APB2 prescalers are set to 1 at reset.
+ */
+#define SYSCLK_FREQ_HZ 4000000
+#define RCC_AHB2ENR 0x4002104C
+#define RCC_APB1ENR1 0x40021058
+#define RCC_APB1ENR2 0x4002105C
+#define RCC_APB2ENR 0x40021060
+
+
+static inline uint32_t get_clock_freq_hz(QTestState *qts, const char *pa=
th)
+{
+    uint32_t clock_freq_hz =3D 0;
+    QDict *r;
+
+    r =3D qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments':"
+        " { 'path': %s, 'property': 'clock-freq-hz'} }", path);
+    g_assert_false(qdict_haskey(r, "error"));
+    clock_freq_hz =3D qdict_get_int(r, "return");
+    qobject_unref(r);
+    return clock_freq_hz;
+}
+
+
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gp=
io-test.c
index 72a7823406..5c62125736 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "stm32l4x5.h"
=20
 #define GPIO_BASE_ADDR 0x48000000
 #define GPIO_SIZE      0x400
@@ -505,6 +506,26 @@ static void test_bsrr_brr(const void *data)
     gpio_writel(gpio, ODR, reset(gpio, ODR));
 }
=20
+static void test_clock_enable(void)
+{
+    /*
+     * For each GPIO, enable its clock in RCC
+     * and check that its clock frequency changes to SYSCLK_FREQ_HZ
+     */
+    unsigned int gpio_id;
+
+    for (uint32_t gpio =3D GPIO_A; gpio <=3D GPIO_H; gpio +=3D GPIO_B - =
GPIO_A) {
+        gpio_id =3D get_gpio_id(gpio);
+        g_autofree char *path =3D g_strdup_printf("/machine/soc/gpio%c",
+                                                gpio_id + 'a');
+        g_assert_cmpuint(get_clock_freq_hz(global_qtest, path), =3D=3D, =
0);
+        /* Enable the gpio clock */
+        writel(RCC_AHB2ENR, readl(RCC_AHB2ENR) | (0x1 << gpio_id));
+        g_assert_cmpuint(get_clock_freq_hz(global_qtest, path), =3D=3D,
+                         SYSCLK_FREQ_HZ);
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
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index 506ca08bc2..2ff0d5e9e0 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -10,6 +10,7 @@
=20
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
+#include "stm32l4x5.h"
=20
 #define SYSCFG_BASE_ADDR 0x40010000
 #define SYSCFG_MEMRMP 0x00
@@ -26,7 +27,8 @@
 #define INVALID_ADDR 0x2C
=20
 /* SoC forwards GPIOs to SysCfg */
-#define SYSCFG "/machine/soc"
+#define SOC "/machine/soc"
+#define SYSCFG "/machine/soc/syscfg"
 #define EXTI "/machine/soc/exti"
=20
 static void syscfg_writel(unsigned int offset, uint32_t value)
@@ -41,7 +43,7 @@ static uint32_t syscfg_readl(unsigned int offset)
=20
 static void syscfg_set_irq(int num, int level)
 {
-   qtest_set_irq_in(global_qtest, SYSCFG, NULL, num, level);
+   qtest_set_irq_in(global_qtest, SOC, NULL, num, level);
 }
=20
 static void system_reset(void)
@@ -301,6 +303,17 @@ static void test_irq_gpio_multiplexer(void)
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
 }
=20
+static void test_clock_enable(void)
+{
+    g_assert_cmpuint(get_clock_freq_hz(global_qtest, SYSCFG), =3D=3D, 0)=
;
+
+    /* Enable SYSCFG clock */
+    writel(RCC_APB2ENR, readl(RCC_APB2ENR) | (0x1 << 0));
+
+    g_assert_cmpuint(get_clock_freq_hz(global_qtest, SYSCFG), =3D=3D,
+                                       SYSCLK_FREQ_HZ);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -325,6 +338,8 @@ int main(int argc, char **argv)
                    test_irq_pin_multiplexer);
     qtest_add_func("stm32l4x5/syscfg/test_irq_gpio_multiplexer",
                    test_irq_gpio_multiplexer);
+    qtest_add_func("stm32l4x5/syscfg/test_clock_enable",
+                   test_clock_enable);
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_u=
sart-test.c
index 8902518233..7a5671be99 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -12,6 +12,7 @@
 #include "libqtest.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
 #include "hw/registerfields.h"
+#include "stm32l4x5.h"
=20
 #define RCC_BASE_ADDR 0x40021000
 /* Use USART 1 ADDR, assume the others work the same */
@@ -296,6 +297,30 @@ static void test_send_str(void)
     qtest_quit(qts);
 }
=20
+static void check_clock(QTestState *qts, const char *path, uint32_t rcc_=
reg,
+                        uint32_t reg_offset)
+{
+    g_assert_cmpuint(get_clock_freq_hz(qts, path), =3D=3D, 0);
+    qtest_writel(qts, rcc_reg, qtest_readl(qts, rcc_reg) | (0x1 << reg_o=
ffset));
+    g_assert_cmpuint(get_clock_freq_hz(qts, path), =3D=3D, SYSCLK_FREQ_H=
Z);
+}
+
+static void test_clock_enable(void)
+{
+    /*
+     * For each USART device, enable its clock in RCC
+     * and check that its clock frequency is SYSCLK_FREQ_HZ
+     */
+    QTestState *qts =3D qtest_init("-M b-l475e-iot01a");
+
+    check_clock(qts, "machine/soc/usart[0]", RCC_APB2ENR, 14);
+    check_clock(qts, "machine/soc/usart[1]", RCC_APB1ENR1, 17);
+    check_clock(qts, "machine/soc/usart[2]", RCC_APB1ENR1, 18);
+    check_clock(qts, "machine/soc/uart[0]", RCC_APB1ENR1, 19);
+    check_clock(qts, "machine/soc/uart[1]", RCC_APB1ENR1, 20);
+    check_clock(qts, "machine/soc/lpuart1", RCC_APB1ENR2, 0);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -308,6 +333,7 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/usart/send_char", test_send_char);
     qtest_add_func("stm32l4x5/usart/receive_str", test_receive_str);
     qtest_add_func("stm32l4x5/usart/send_str", test_send_str);
+    qtest_add_func("stm32l4x5/usart/clock_enable", test_clock_enable);
     ret =3D g_test_run();
=20
     return ret;
--=20
2.43.2


