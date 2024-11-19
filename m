Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0799CD44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8h-0005vt-71; Tue, 19 Nov 2024 09:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8c-0005sj-Ci
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:30 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8a-0006D1-2l
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43158625112so30503295e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026206; x=1732631006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Sdn+fHZSuW869Y/sZVE+aCL+8h470EXCSMBPbW6o5fA=;
 b=Axo7xINgEzl/1c6O2bU/HxBLKiU9/VM2rVzreNSOZFIxeNBCjQF2tXrC04WJJY7IqQ
 cxt4eW54hYfQGDc9yeC/wCpMOadcIMR5DOeQirx4Jg1PUyQpVhs/eSRF3BVNJ7M6GlCh
 uujGR3UQDYSwE2tyHbw0DpOG2yX9GnexE2TgslOQdAZx8glmu1a7Kl4ElKNy4zK/nEw/
 NUIjf0PQgNB55+75+Q2x+POWhetWp1H21RMU8TuPr662ELlKLwmgDX6Eec2vrhNdjRue
 2XhCzu5nvrBWzzW1tnfw7X9+7uPS6JnBRAH3Z+YKcZv3j/WzeiVMvAm4hw6G8sa0Dc5z
 mgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026206; x=1732631006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sdn+fHZSuW869Y/sZVE+aCL+8h470EXCSMBPbW6o5fA=;
 b=MQVJgGloN/MSgxtXU7PlAb8qXFAdZrMloJakFzHiVPmE57AIlZHnLS0YDx9DfLb+3+
 6qMeDW4H8AoItgggo6Mc7fpv0OkTJvZVQSP8UQdhHOJHCnpq0ULmeNYWb7B9GaB+wG0V
 p0gaqCzzm+FB7SgbWXZ6PhYOiwaGZTQmiPN0RVIIhPfnpWURv7gAVbF6m+QCp7QLbbHx
 B5OhlvZJyY2SM3tnCWmyQRwL/Srf2kRZuvB3vrAEDuX7XOnzI3gids2DuGP9etltCEvp
 r9NReOF1KpCfXHAQ1fyDZ2GTIW+dfhODSo2ITCn7M3aikZcgyBPciW3UDAQ0R34lFTOh
 Ld0Q==
X-Gm-Message-State: AOJu0Yz0ANcGDGeKCsmMZzJI/HUS3xRygAvBiCoM+Cjx2btMq9cJ3URS
 yHoBONi8LVn00g57adnbj5N3fzR4UUNWnDJETifzKxvu2SDDJAvqH9I6fPLJunhGvH7MUgvzYIG
 A
X-Google-Smtp-Source: AGHT+IGMW1NWkZpZx/bm22TpGK3J4Bn4HejKt7cIh4dy6NenDlv3KFx1pXA/oBikVMci33agj9jVCw==
X-Received: by 2002:a05:600c:5487:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-432df78a529mr120535315e9.23.1732026206495; 
 Tue, 19 Nov 2024 06:23:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/15] tests/qtest/cmsdk-apb-watchdog-test: Test INTEN as
 counter enable
Date: Tue, 19 Nov 2024 14:23:13 +0000
Message-Id: <20241119142321.1853732-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

The following tests focus on making sure the counter is not running
out of reset and the proper use of INTEN as the counter enable. As
described in:

https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model

The new tests have to target an MPS2 machine because the original
machine used by the test (stellaris) has a variation of the
cmsdk_apb_watchdog that locks INTEN when it is programmed to 1. The
stellaris machine also does not reproduce the problem of the counter
running out of cold reset due to the way the clocks are initialized.

Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
Reviewed-by: Stephen Longfield <slongfield@google.com>
Message-id: 20241115160328.1650269-6-roqueh@google.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/cmsdk-apb-watchdog-test.c | 215 ++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index fe535a553cc..53538f98c99 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -68,6 +68,16 @@ static const CMSDKAPBWatchdogTestArgs machine_info[] = {
     },
 };
 
+static void system_reset(QTestState *qtest)
+{
+    QDict *resp;
+
+    resp = qtest_qmp(qtest, "{'execute': 'system_reset'}");
+    g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+    qtest_qmp_eventwait(qtest, "RESET");
+}
+
 static void test_watchdog(const void *ptr)
 {
     const CMSDKAPBWatchdogTestArgs *args = ptr;
@@ -159,6 +169,199 @@ static void test_clock_change(const void *ptr)
     qtest_end();
 }
 
+/* Tests the counter is not running after reset. */
+static void test_watchdog_reset(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    g_assert_cmphex(readl(wdog_base + WDOGCONTROL), ==, 0);
+
+    /*
+     * The counter should not be running if WDOGCONTROL.INTEN has not been set,
+     * as it is the case after a cold reset.
+     */
+    clock_step(15 * tick + 1);
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /* Let the counter run before reset */
+    writel(wdog_base + WDOGLOAD, 3000);
+    writel(wdog_base + WDOGCONTROL, 1);
+
+    /* Verify it is running */
+    clock_step(1000 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 3000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 2000);
+
+    system_reset(global_qtest);
+
+    /* Check defaults after reset */
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /* The counter should not be running after reset. */
+    clock_step(1000 * tick + 1);
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    qtest_end();
+}
+
+/*
+ * Tests inten works as the counter enable based on this description:
+ *
+ * Enable the interrupt event, WDOGINT. Set HIGH to enable the counter and the
+ * interrupt, or LOW to disable the counter and interrupt. Reloads the counter
+ * from the value in WDOGLOAD when the interrupt is enabled, after previously
+ * being disabled.
+ */
+static void test_watchdog_inten(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /*
+     * When WDOGLOAD is written to, the count is immediately restarted from the
+     * new value.
+     *
+     * Note: the counter should not be running as long as WDOGCONTROL.INTEN is
+     * not set
+     */
+    writel(wdog_base + WDOGLOAD, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+
+    /* Set HIGH WDOGCONTROL.INTEN to enable the counter and the interrupt */
+    writel(wdog_base + WDOGCONTROL, 1);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3500);
+
+    /* or LOW to disable the counter and interrupt. */
+    writel(wdog_base + WDOGCONTROL, 0);
+    clock_step(100 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3500);
+
+    /*
+     * Reloads the counter from the value in WDOGLOAD when the interrupt is
+     * enabled, after previously being disabled.
+     */
+    writel(wdog_base + WDOGCONTROL, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+
+    /* Test counter is still on */
+    clock_step(50 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3950);
+
+    /*
+     * When WDOGLOAD is written to, the count is immediately restarted from the
+     * new value.
+     *
+     * Note: the counter should be running since WDOGCONTROL.INTEN is set
+     */
+    writel(wdog_base + WDOGLOAD, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 5000);
+    clock_step(4999 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    /* Finally disable and check the conditions don't change */
+    writel(wdog_base + WDOGCONTROL, 0);
+    clock_step(10 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 5000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    qtest_end();
+}
+
+/*
+ * Tests the following custom behavior:
+ *
+ * The Luminary version of this device ignores writes to this register after the
+ * guest has enabled interrupts (so they can only be disabled again via reset).
+ */
+static void test_watchdog_inten_luminary(const void *ptr)
+{
+    const CMSDKAPBWatchdogTestArgs *args = ptr;
+    hwaddr wdog_base = args->wdog_base;
+    int64_t tick = args->tick;
+    g_autofree gchar *cmdline = g_strdup_printf("-machine %s", args->machine);
+    qtest_start(cmdline);
+    g_assert_cmpuint(readl(wdog_base + WDOGRIS), ==, 0);
+
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    /*
+     * When WDOGLOAD is written to, the count is immediately restarted from the
+     * new value.
+     *
+     * Note: the counter should not be running as long as WDOGCONTROL.INTEN is
+     * not set
+     */
+    writel(wdog_base + WDOGLOAD, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 4000);
+
+    /* Set HIGH WDOGCONTROL.INTEN to enable the counter and the interrupt */
+    writel(wdog_base + WDOGCONTROL, 1);
+    clock_step(500 * tick + 1);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3500);
+
+    /*
+     * The Luminary version of this device ignores writes to this register after
+     * the guest has enabled interrupts
+     */
+    writel(wdog_base + WDOGCONTROL, 0);
+    clock_step(100 * tick);
+    g_assert_cmpuint(readl(wdog_base + WDOGLOAD), ==, 4000);
+    g_assert_cmpuint(readl(wdog_base + WDOGVALUE), ==, 3400);
+    g_assert_cmphex(readl(wdog_base + WDOGCONTROL), ==, 0x1);
+
+    /* They can only be disabled again via reset */
+    system_reset(global_qtest);
+
+    /* Check defaults after reset */
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGCONTROL), ==, 0);
+
+    /* The counter should not be running after reset. */
+    clock_step(1000 * tick + 1);
+    g_assert_cmphex(readl(wdog_base + WDOGLOAD), ==, WDOGLOAD_DEFAULT);
+    g_assert_cmphex(readl(wdog_base + WDOGVALUE), ==, WDOGVALUE_DEFAULT);
+
+    qtest_end();
+}
+
 int main(int argc, char **argv)
 {
     int r;
@@ -172,10 +375,22 @@ int main(int argc, char **argv)
         qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_clock_change",
                             &machine_info[MACHINE_LM3S811EVB],
                             test_clock_change);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_reset",
+                            &machine_info[MACHINE_LM3S811EVB],
+                            test_watchdog_reset);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_inten_luminary",
+                            &machine_info[MACHINE_LM3S811EVB],
+                            test_watchdog_inten_luminary);
     }
     if (qtest_has_machine(machine_info[MACHINE_MPS2_AN385].machine)) {
         qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_mps2",
                             &machine_info[MACHINE_MPS2_AN385], test_watchdog);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_reset_mps2",
+                            &machine_info[MACHINE_MPS2_AN385],
+                            test_watchdog_reset);
+        qtest_add_data_func("/cmsdk-apb-watchdog/watchdog_inten",
+                            &machine_info[MACHINE_MPS2_AN385],
+                            test_watchdog_inten);
     }
 
     r = g_test_run();
-- 
2.34.1


