Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260BBCF6491
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svC9p-0005eM-EJ; Mon, 30 Sep 2024 04:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svC9Z-0004HH-Fc; Mon, 30 Sep 2024 04:53:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svC9W-00025U-BY; Mon, 30 Sep 2024 04:53:11 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 30 Sep
 2024 16:52:41 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 30 Sep 2024 16:52:41 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v6 8/8] hw/gpio/aspeed: Add test case for AST2700
Date: Mon, 30 Sep 2024 16:52:39 +0800
Message-ID: <20240930085239.3089901-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930085239.3089901-1-jamin_lin@aspeedtech.com>
References: <20240930085239.3089901-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add test case to test GPIO output and input pins from A0 to D7 for AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed_gpio-test.c | 77 ++++++++++++++++++++++++++++++++--
 tests/qtest/meson.build        |  3 ++
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
index d38f51d719..03b3b1c2b2 100644
--- a/tests/qtest/aspeed_gpio-test.c
+++ b/tests/qtest/aspeed_gpio-test.c
@@ -33,6 +33,10 @@
 #define GPIO_ABCD_DATA_VALUE 0x000
 #define GPIO_ABCD_DIRECTION  0x004
 
+/* AST2700 */
+#define AST2700_GPIO_BASE 0x14C0B000
+#define GPIOA0_CONTROL 0x180
+
 static void test_set_colocated_pins(const void *data)
 {
     QTestState *s = (QTestState *)data;
@@ -72,17 +76,82 @@ static void test_set_input_pins(const void *data)
     g_assert_cmphex(value, ==, 0xffffffff);
 }
 
+static void test_2700_output_pins(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    uint32_t pin = 0;
+
+    for (char c = 'A'; c <= 'D'; c++) {
+        for (int i = 0; i < 8; i++) {
+            offset = AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
+
+            /* output direction and output hi */
+            qtest_writel(s, offset, 0x00000003);
+            value = qtest_readl(s, offset);
+            g_assert_cmphex(value, ==, 0x00000003);
+
+            /* output direction and output low */
+            qtest_writel(s, offset, 0x00000002);
+            value = qtest_readl(s, offset);
+            g_assert_cmphex(value, ==, 0x00000002);
+            pin++;
+        }
+    }
+}
+
+static void test_2700_input_pins(const void *data)
+{
+    QTestState *s = (QTestState *)data;
+    char name[16];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    uint32_t pin = 0;
+
+    for (char c = 'A'; c <= 'D'; c++) {
+        for (int i = 0; i < 8; i++) {
+            sprintf(name, "gpio%c%d", c, i);
+            offset = AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
+            /* input direction */
+            qtest_writel(s, offset, 0);
+
+            /* set input */
+            qtest_qom_set_bool(s, "/machine/soc/gpio", name, true);
+            value = qtest_readl(s, offset);
+            g_assert_cmphex(value, ==, 0x00002000);
+
+            /* clear input */
+            qtest_qom_set_bool(s, "/machine/soc/gpio", name, false);
+            value = qtest_readl(s, offset);
+            g_assert_cmphex(value, ==, 0);
+            pin++;
+        }
+    }
+}
+
+
 int main(int argc, char **argv)
 {
+    const char *arch = qtest_get_arch();
     QTestState *s;
     int r;
 
     g_test_init(&argc, &argv, NULL);
 
-    s = qtest_init("-machine ast2600-evb");
-    qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
-                        test_set_colocated_pins);
-    qtest_add_data_func("/ast2600/gpio/set_input_pins", s, test_set_input_pins);
+    if (strcmp(arch, "aarch64") == 0) {
+        s = qtest_init("-machine ast2700-evb");
+        qtest_add_data_func("/ast2700/gpio/input_pins",
+                            s, test_2700_input_pins);
+        qtest_add_data_func("/ast2700/gpio/out_pins", s, test_2700_output_pins);
+    } else {
+        s = qtest_init("-machine ast2600-evb");
+        qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
+                            test_set_colocated_pins);
+        qtest_add_data_func("/ast2600/gpio/set_input_pins", s,
+                            test_set_input_pins);
+    }
+
     r = g_test_run();
     qtest_quit(s);
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 310865e49c..292980e3ad 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -209,6 +209,8 @@ qtests_aspeed = \
   ['aspeed_hace-test',
    'aspeed_smc-test',
    'aspeed_gpio-test']
+qtests_aspeed64 = \
+  ['aspeed_gpio-test']
 
 qtests_stm32l4x5 = \
   ['stm32l4x5_exti-test',
@@ -247,6 +249,7 @@ qtests_aarch64 = \
   (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-- 
2.34.1


