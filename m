Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6FACEACC8
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 14:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svdcE-0008Lb-EG; Tue, 01 Oct 2024 10:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svdcB-0008Df-Ia; Tue, 01 Oct 2024 10:12:35 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1svdc9-0003Bx-FP; Tue, 01 Oct 2024 10:12:35 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 1 Oct
 2024 10:43:36 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 1 Oct 2024 10:43:36 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v7 8/8] tests/qtest:ast2700-gpio-test: Add GPIO test case for
 AST2700
Date: Tue, 1 Oct 2024 10:43:34 +0800
Message-ID: <20241001024334.834807-9-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001024334.834807-1-jamin_lin@aspeedtech.com>
References: <20241001024334.834807-1-jamin_lin@aspeedtech.com>
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

Add GPIO test cases to test output and input pins from A0 to D7 for AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/ast2700-gpio-test.c | 95 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |  3 ++
 2 files changed, 98 insertions(+)
 create mode 100644 tests/qtest/ast2700-gpio-test.c

diff --git a/tests/qtest/ast2700-gpio-test.c b/tests/qtest/ast2700-gpio-test.c
new file mode 100644
index 0000000000..9275845564
--- /dev/null
+++ b/tests/qtest/ast2700-gpio-test.c
@@ -0,0 +1,95 @@
+/*
+ * QTest testcase for the ASPEED AST2700 GPIO Controller.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "qapi/qmp/qdict.h"
+#include "libqtest-single.h"
+
+#define AST2700_GPIO_BASE 0x14C0B000
+#define GPIOA0_CONTROL 0x180
+
+static void test_output_pins(const char *machine, const uint32_t base)
+{
+    QTestState *s = qtest_init(machine);
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    uint32_t pin = 0;
+
+    for (char c = 'A'; c <= 'D'; c++) {
+        for (int i = 0; i < 8; i++) {
+            offset = base + (pin * 4);
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
+
+    qtest_quit(s);
+}
+
+static void test_input_pins(const char *machine, const uint32_t base)
+{
+    QTestState *s = qtest_init(machine);
+    char name[16];
+    uint32_t offset = 0;
+    uint32_t value = 0;
+    uint32_t pin = 0;
+
+    for (char c = 'A'; c <= 'D'; c++) {
+        for (int i = 0; i < 8; i++) {
+            sprintf(name, "gpio%c%d", c, i);
+            offset = base + (pin * 4);
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
+
+    qtest_quit(s);
+}
+
+static void test_2700_input_pins(void)
+{
+    test_input_pins("-machine ast2700-evb",
+                    AST2700_GPIO_BASE + GPIOA0_CONTROL);
+}
+
+static void test_2700_output_pins(void)
+{
+    test_output_pins("-machine ast2700-evb",
+                     AST2700_GPIO_BASE + GPIOA0_CONTROL);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/ast2700/gpio/input_pins", test_2700_input_pins);
+    qtest_add_func("/ast2700/gpio/output_pins", test_2700_output_pins);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 310865e49c..e1b62d34d8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -209,6 +209,8 @@ qtests_aspeed = \
   ['aspeed_hace-test',
    'aspeed_smc-test',
    'aspeed_gpio-test']
+qtests_aspeed64 = \
+  ['ast2700-gpio-test']
 
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


