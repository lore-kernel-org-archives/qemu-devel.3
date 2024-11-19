Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32168D44164
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8d-0005uO-SZ; Tue, 19 Nov 2024 09:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8b-0005qp-LE
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:29 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8Z-0006Cj-1c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3823194a879so2438011f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026205; x=1732631005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7Bp1jQcPnnxsGePAZailTgK43QTJpcLNz0TBWeIGdlE=;
 b=ygZf7+nQPjYEEk3aBHEmU3/UenbkK+oIOC34kzqsmt4Y3Y++z/PciC2Ig/jn1X4gZh
 NzdOI2x9aBkLzUTxDzKx8BCuoUJvEq9QscaSplbifVIccFPHH3acjNOhH1Suu2lyhvUf
 yNsr31vFvXnOk0S2iIBa/MWHphobL0IH/5yaMmlowVEq2iKgy3oIzlnGjzxA/1UnMm8r
 5DlNi8FPX4pX5Hz/OPqAn/WFvwxto/Ub+VX46KZYkzjDCJ/WbEBPRNqXO2s5NNXEWM0t
 mw9L6dogwXKVQPf8FsaTRUdup2IBzAAVFQV0TTina/EprlPaqLzb8STadfpNe8NPgXie
 /mYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026205; x=1732631005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Bp1jQcPnnxsGePAZailTgK43QTJpcLNz0TBWeIGdlE=;
 b=Og1Lxsa8dyjcYR/PQ/FVG0ZgvWuaBOXokkGzQbq+AdRqIS7MpLDxSVci7cDb7zPrLx
 VH3GlzeCtSkoUillvNa9dTF7WU0SzsQCaIwQS+RJ2fGfcI7KtoZttB1r2ryfEUpXwZTD
 QJjXZ9ZkM0hSkIEKXvGRlIcog5rIdfaVn0RQyycaVzzmtf8cOJ3EtWrWnnRdXqaO7XLL
 BS0tQQ7UxYsWLN3xkvspPk7qk0Zl2V2bEVL2up+SaIiOHWIz+aRZDrMxJHw82hjF26Sj
 Hcx9Eus0Fpj88krk308H1oXMzzLI+kffwMoAGdN0JKBU96nL1QIe57gZM3szIX221dMa
 EaBw==
X-Gm-Message-State: AOJu0Yx4RdTE9Y2teBdF/KlxPyXINmT5n3+l48bQEATHmw4Z4v/SZHvL
 lVe/+6or95tbIjTQI7GphslKLLb+vDR2xpIrQs4XxeypgswbBYDxNohZJbm8SDebLWfIqXKX8sI
 /
X-Google-Smtp-Source: AGHT+IF/CekAug2HSZL/GWDrXrwm91lmXwQMHeJq2THkcTsE35L5dYqDepWOaPhBKRzJ6BKUkCIz4w==
X-Received: by 2002:a05:6000:2a4:b0:382:22d6:1ce8 with SMTP id
 ffacd0b85a97d-3822590bb0emr12732442f8f.22.1732026205389; 
 Tue, 19 Nov 2024 06:23:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] tests/qtest/cmsdk-apb-watchdog-test: Parameterize tests
Date: Tue, 19 Nov 2024 14:23:11 +0000
Message-Id: <20241119142321.1853732-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Roque Arcudia Hernandez <roqueh@google.com>

Currently the CMSDK APB watchdog tests target an specialized version
of the device (luminaris using the lm3s811evb machine) that prevents
the development of tests for the more generic device documented in:

https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model

This patch allows the execution of the watchdog tests in an MPS2
machine (when applicable) which uses the generic version of the CMSDK
APB watchdog.

Finally the rules for compiling the test have to change because it is
possible not to have CONFIG_STELLARIS (required for the lm3s811evb
machine) while still having CONFIG_CMSDK_APB_WATCHDOG and the test
will fail. Due to the addition of the MPS2 machine CONFIG_MPS2
becomes also a dependency for the test compilation.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
Message-id: 20241115160328.1650269-4-roqueh@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/cmsdk-apb-watchdog-test.c | 114 +++++++++++++++++++-------
 tests/qtest/meson.build               |   3 +-
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index 00b5dbbc812..bdf6cfa2566 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -15,14 +15,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/hwaddr.h"
 #include "qemu/bitops.h"
 #include "libqtest-single.h"
 
-/*
- * lm3s811evb watchdog; at board startup this runs at 200MHz / 16 == 12.5MHz,
- * which is 80ns per tick.
- */
 #define WDOG_BASE 0x40000000
+#define WDOG_BASE_MPS2 0x40008000
 
 #define WDOGLOAD 0
 #define WDOGVALUE 4
@@ -37,39 +35,87 @@
 #define SYSDIV_SHIFT 23
 #define SYSDIV_LENGTH 4
 
-static void test_watchdog(void)
-{
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
+#define WDOGLOAD_DEFAULT 0xFFFFFFFF
+#define WDOGVALUE_DEFAULT 0xFFFFFFFF
 
-    writel(WDOG_BASE + WDOGCONTROL, 1);
-    writel(WDOG_BASE + WDOGLOAD, 1000);
+typedef struct CMSDKAPBWatchdogTestArgs {
+    int64_t tick;
+    hwaddr wdog_base;
+    const char *machine;
+} CMSDKAPBWatchdogTestArgs;
+
+enum {
+    MACHINE_LM3S811EVB,
+    MACHINE_MPS2_AN385,
+};
+
+/*
+ * lm3s811evb watchdog; at board startup this runs at 200MHz / 16 == 12.5MHz,
+ * which is 80ns per tick.
+ *
+ * IoTKit/ARMSSE dualtimer; driven at 25MHz in mps2-an385, so 40ns per tick
+ */
+static const CMSDKAPBWatchdogTestArgs machine_info[] = {
+    [MACHINE_LM3S811EVB] = {
+        .tick = 80,
+        .wdog_base = WDOG_BASE,
+        .machine = "lm3s811evb",
+    },
+    [MACHINE_MPS2_AN385] = {
+        .tick = 40,
+        .wdog_base = WDOG_BASE_MPS2,
+        .machine = "mps2-an385",
+    },
+};
+
+static void test_watchdog(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    writel(wdog_base + WDOGCONTROL, 1);
+    writel(wdog_base + WDOGLOAD, 1000);
 
     /* Step to just past the 500th tick */
-    clock_step(500 * 80 + 1);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 500);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 500);
 
     /* Just past the 1000th tick: timer should have fired */
-    clock_step(500 * 80);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 1);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 0);
+    clock_step(500 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 0);
 
     /* VALUE reloads at following tick */
-    clock_step(80);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 1000);
+    clock_step(tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1000);
 
     /* Writing any value to WDOGINTCLR clears the interrupt and reloads */
-    clock_step(500 * 80);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 500);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 1);
-    writel(WDOG_BASE + WDOGINTCLR, 0);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 1000);
-    g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
+    clock_step(500 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 500);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 1);
+    writel(wdog_base + WDOGINTCLR, 0);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1000);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    qtest_end();
 }
 
-static void test_clock_change(void)
+/*
+ * This test can only be executed in the stellaris board since it relies on a
+ * component of the board to change the clocking parameters of the watchdog.
+ */
+static void test_clock_change(const void *ptr)
 {
     uint32_t rcc;
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
 
     /*
      * Test that writing to the stellaris board's RCC register to
@@ -109,6 +155,8 @@ static void test_clock_change(void)
     writel(WDOG_BASE + WDOGINTCLR, 0);
     g_assert_cmpuint(readl(WDOG_BASE + WDOGVALUE), ==, 1000);
     g_assert_cmpuint(readl(WDOG_BASE + WDOGRIS), ==, 0);
+
+    qtest_end();
 }
 
 int main(int argc, char **argv)
@@ -117,15 +165,19 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_start("-machine lm3s811evb");
-
-    qtest_add_func("/cmsdk-apb-watchdog/watchdog", test_watchdog);
-    qtest_add_func("/cmsdk-apb-watchdog/watchdog_clock_change",
-                   test_clock_change);
+    if (qtest_has_machine(machine_info[MACHINE_LM3S811EVB].machine)) {
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog",
+                            &machine_info[MACHINE_LM3S811EVB], test_watchdog);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_clock_change",
+                            &machine_info[MACHINE_LM3S811EVB],
+                            test_clock_change);
+    }
+    if (qtest_has_machine(machine_info[MACHINE_MPS2_AN385].machine)) {
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_mps2",
+                            &machine_info[MACHINE_MPS2_AN385], test_watchdog);
+    }
 
     r = g_test_run();
 
-    qtest_end();
-
     return r;
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index aa93e984187..f2f35367ae7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -227,7 +227,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_CMSDK_APB_WATCHDOG') ? ['cmsdk-apb-watchdog-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_STELLARIS') or
+   config_all_devices.has_key('CONFIG_MPS2') ? ['cmsdk-apb-watchdog-test'] : []) + \
   (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
    config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
-- 
2.34.1


