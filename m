Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDD4CF856E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 08:37:15 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swH8r-0003aX-Tm; Thu, 03 Oct 2024 04:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1swH8d-0003ZS-Rg
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 04:24:43 -0400
Received: from [2001:660:330f:2::de] (helo=zproxy3.enst.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1swH7z-00057F-Fg
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 04:24:35 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id AF8D7A085D;
 Thu,  3 Oct 2024 10:11:14 +0200 (CEST)
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id V8PZZ2g6RLC9; Thu,  3 Oct 2024 10:11:14 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy3.enst.fr (Postfix) with ESMTP id 2121FA08D1;
 Thu,  3 Oct 2024 10:11:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy3.enst.fr 2121FA08D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1727943074;
 bh=elbDLH2Z7tgiZHcCp8dN35rslZb0FrbBfhJcFwMk/M0=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=4zKYOWbFw7IG/o0eqdsI7eTVisHpso+asgwcLECVJfynmQ+afUb/Zw/b11gKf5c26
 isn3NbfvKKx/ZoFui8GTDz27Rj3cHOZMeCSCFJ+KyD9J2RqRDCp0HSYdGRF/2jLhLu
 iz3RlpdFcuru97WCYZonWaukRSTJxICnWJKLLo5A=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy3.enst.fr ([IPv6:::1])
 by localhost (zproxy3.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id c_bSxq77BK0f; Thu,  3 Oct 2024 10:11:14 +0200 (CEST)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:124::190c])
 by zproxy3.enst.fr (Postfix) with ESMTPSA id B167FA0677;
 Thu,  3 Oct 2024 10:11:13 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc@lmichel.fr>,
 qemu-arm@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PING PATCH v5 3/3] tests/qtest: Check STM32L4x5 clock connections
Date: Thu,  3 Oct 2024 10:10:06 +0200
Message-ID: <20241003081105.40836-4-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
References: <20241003081105.40836-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2001:660:330f:2::de
 (deferred)
Received-SPF: pass client-ip=2001:660:330f:2::de;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy3.enst.fr
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RDNS_NONE=0.793, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc@lmichel.fr>
---
 tests/qtest/stm32l4x5.h             | 42 +++++++++++++++++++++++++++++
 tests/qtest/stm32l4x5_gpio-test.c   | 23 ++++++++++++++++
 tests/qtest/stm32l4x5_syscfg-test.c | 20 ++++++++++++--
 tests/qtest/stm32l4x5_usart-test.c  | 26 ++++++++++++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/stm32l4x5.h

diff --git a/tests/qtest/stm32l4x5.h b/tests/qtest/stm32l4x5.h
new file mode 100644
index 0000000000..2d21cc666c
--- /dev/null
+++ b/tests/qtest/stm32l4x5.h
@@ -0,0 +1,42 @@
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
+#include "libqtest.h"
+
+/* copied from clock.h */
+#define CLOCK_PERIOD_1SEC (1000000000llu << 32)
+#define CLOCK_PERIOD_FROM_HZ(hz) (((hz) !=3D 0) ? CLOCK_PERIOD_1SEC / (h=
z) : 0u)
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
+static inline uint64_t get_clock_period(QTestState *qts, const char *pat=
h)
+{
+    uint64_t clock_period =3D 0;
+    QDict *r;
+
+    r =3D qtest_qmp(qts, "{ 'execute': 'qom-get', 'arguments':"
+        " { 'path': %s, 'property': 'qtest-clock-period'} }", path);
+    g_assert_false(qdict_haskey(r, "error"));
+    clock_period =3D qdict_get_int(r, "return");
+    qobject_unref(r);
+    return clock_period;
+}
+
+
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gp=
io-test.c
index 72a7823406..c0686c7b30 100644
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
+     * and check that its clock period changes to SYSCLK_PERIOD
+     */
+    unsigned int gpio_id;
+
+    for (uint32_t gpio =3D GPIO_A; gpio <=3D GPIO_H; gpio +=3D GPIO_B - =
GPIO_A) {
+        gpio_id =3D get_gpio_id(gpio);
+        g_autofree char *path =3D g_strdup_printf("/machine/soc/gpio%c/c=
lk",
+                                                gpio_id + 'a');
+        g_assert_cmpuint(get_clock_period(global_qtest, path), =3D=3D, 0=
);
+        /* Enable the gpio clock */
+        writel(RCC_AHB2ENR, readl(RCC_AHB2ENR) | (0x1 << gpio_id));
+        g_assert_cmpuint(get_clock_period(global_qtest, path), =3D=3D,
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
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index 258417cd88..d5c71e2c0e 100644
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
@@ -26,7 +27,9 @@
 #define INVALID_ADDR 0x2C
=20
 /* SoC forwards GPIOs to SysCfg */
-#define SYSCFG "/machine/soc"
+#define SOC "/machine/soc"
+#define SYSCFG "/machine/soc/syscfg"
+#define SYSCFG_CLK "/machine/soc/syscfg/clk"
 #define EXTI "/machine/soc/exti"
=20
 static void syscfg_writel(unsigned int offset, uint32_t value)
@@ -41,7 +44,7 @@ static uint32_t syscfg_readl(unsigned int offset)
=20
 static void syscfg_set_irq(int num, int level)
 {
-   qtest_set_irq_in(global_qtest, SYSCFG, NULL, num, level);
+   qtest_set_irq_in(global_qtest, SOC, NULL, num, level);
 }
=20
 static void system_reset(void)
@@ -301,6 +304,17 @@ static void test_irq_gpio_multiplexer(void)
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
 }
=20
+static void test_clock_enable(void)
+{
+    g_assert_cmpuint(get_clock_period(global_qtest, SYSCFG_CLK), =3D=3D,=
 0);
+
+    /* Enable SYSCFG clock */
+    writel(RCC_APB2ENR, readl(RCC_APB2ENR) | (0x1 << 0));
+
+    g_assert_cmpuint(get_clock_period(global_qtest, SYSCFG_CLK), =3D=3D,
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
=20
     qtest_start("-machine b-l475e-iot01a");
     ret =3D g_test_run();
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_u=
sart-test.c
index 64cebda60f..315bcee004 100644
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
@@ -331,6 +332,30 @@ static void test_ack(void)
     qtest_quit(qts);
 }
=20
+static void check_clock(QTestState *qts, const char *path, uint32_t rcc_=
reg,
+                        uint32_t reg_offset)
+{
+    g_assert_cmpuint(get_clock_period(qts, path), =3D=3D, 0);
+    qtest_writel(qts, rcc_reg, qtest_readl(qts, rcc_reg) | (0x1 << reg_o=
ffset));
+    g_assert_cmpuint(get_clock_period(qts, path), =3D=3D, SYSCLK_PERIOD)=
;
+}
+
+static void test_clock_enable(void)
+{
+    /*
+     * For each USART device, enable its clock in RCC
+     * and check that its clock frequency is SYSCLK_PERIOD
+     */
+    QTestState *qts =3D qtest_init("-M b-l475e-iot01a");
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
     ret =3D g_test_run();
=20
     return ret;
--=20
2.45.2


