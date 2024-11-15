Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C1D68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 16:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBzX1-0007wI-PN; Fri, 15 Nov 2024 11:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWz-0007vQ-4q
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:49 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBzWw-0003am-RN
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 11:50:48 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb5be4381dso20403011fa.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 08:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731689445; x=1732294245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXby9Lwvv6tS8EYvlf5Sy20J6KaSCeX254YtCAwIIqo=;
 b=qDs7113QLHm54bHLlT33WUHaM9TuEMrXxUu1c612j/f6Lsg3D0DePgR2QqnVjNiWym
 AN7xHkIya+XEDjae5BHDReVx2pWWYf3DQidSrfXczvTEBc9lYrR1CNkEdacZTDqbryba
 8DgxVsuDsOKzsVY5lKNZs8vG45MDUmu6mpC7jWQcTWtSR3QBq8prAJLpO4jJ6X+mRvoF
 bR0vqVmlOziXzsAQGQn+xApjITcA5/GA8omx9Yy36MwclfeIh4juIJGZ2BvGuCZdWV+Q
 FTBuGuQiu3ufEaofXgQxkNLIUlP9AF+/VvUZucWEOdgQ0bikT1uoAvgkHp4Tiz7zLKwX
 4Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689445; x=1732294245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VXby9Lwvv6tS8EYvlf5Sy20J6KaSCeX254YtCAwIIqo=;
 b=nyweDWm736smU6xQk9OY1XEBuC3mgxHpbTDmiDUNHjvQJsyD7qGeWxGKNVO1JrGiy4
 mLjsK5RRtBKXkRf5c0T5WGHC7CRd4XuEAImkCuRL++LqmUPG4+R92vhxc/2UH6lBriwd
 WdA1VpSXhVWrW2xzzNCVIzIKTx0xc8VVPCU+yDD71unGgLhToMigHTHdA9mI7Mq7nTYE
 MoBx+qFogvb7wwIvPMKhHpdNCFCwZDK7cZIl/zx9F9QX/uLjkoNvUU++PdRkIkrqJKlh
 3m1jPZqJLxRkCl2tST9PRKQoxrjPN3QzLZ+10QlUKwBB4bHJdas8+BdmyLpD0a38Ysu1
 tjFw==
X-Gm-Message-State: AOJu0YyhhKjTZBCKDSwalBYWFd4WsJei2rzOEHwlnl5Zg071BqIPYt+c
 XwvEXYq0KqvcmzJrwmuWlvcr4/j3V1tlVSYIh8vARSDkIa5NbD/c7p9OP3vMpd0DWSw10/0gjmx
 2
X-Google-Smtp-Source: AGHT+IF4E47ngh7oqY3fGn4sR/cBNSBhYq+NsUWfRmisCqPr253w8gD0Egu4FDh+o8QvxOyHFQRNRQ==
X-Received: by 2002:a2e:a58c:0:b0:2fc:a347:6d87 with SMTP id
 38308e7fff4ca-2ff6093a9b5mr19851401fa.13.1731689444747; 
 Fri, 15 Nov 2024 08:50:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac0aef0sm60386405e9.28.2024.11.15.08.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:50:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roque Arcudia Hernandez <roqueh@google.com>
Subject: [PATCH 2/3] tests/qtest: Use qtest_system_reset() instead of
 open-coded versions
Date: Fri, 15 Nov 2024 16:50:40 +0000
Message-Id: <20241115165041.1148095-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115165041.1148095-1-peter.maydell@linaro.org>
References: <20241115165041.1148095-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

Use the qtest_system_reset() function in various tests that were
previously open-coding the system-reset. Note that in several
cases this fixes a bug where the test did not wait for the RESET
QMP event before continuing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I can split this patch up if people prefer, but for test code
and given the size of the diffstat it didn't seem worthwhile.
---
 tests/qtest/bios-tables-test.c      |  4 ++--
 tests/qtest/boot-order-test.c       |  7 +------
 tests/qtest/hd-geo-test.c           |  9 +--------
 tests/qtest/q35-test.c              | 12 ++----------
 tests/qtest/qos-test.c              |  3 +--
 tests/qtest/stm32l4x5_gpio-test.c   | 10 +---------
 tests/qtest/stm32l4x5_syscfg-test.c | 12 ++----------
 7 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e79f3a03df0..da42e6e3eb5 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -959,7 +959,7 @@ static void test_acpi_piix4_tcg_bridge(void)
     free_test_data(&data);
 
     /* check that reboot/reset doesn't change any ACPI tables  */
-    qtest_qmp_send(data.qts, "{'execute':'system_reset' }");
+    qtest_system_reset(data.qts);
     process_acpi_tables(&data);
     free_test_data(&data);
 }
@@ -1216,7 +1216,7 @@ static void test_acpi_q35_multif_bridge(void)
     free_test_data(&data);
 
     /* check that reboot/reset doesn't change any ACPI tables  */
-    qtest_qmp_send(data.qts, "{'execute':'system_reset' }");
+    qtest_system_reset(data.qts);
     process_acpi_tables(&data);
     free_test_data(&data);
 }
diff --git a/tests/qtest/boot-order-test.c b/tests/qtest/boot-order-test.c
index c67b8cfe169..4c851c2cdb9 100644
--- a/tests/qtest/boot-order-test.c
+++ b/tests/qtest/boot-order-test.c
@@ -40,12 +40,7 @@ static void test_a_boot_order(const char *machine,
                       machine ?: "", test_args);
     actual = read_boot_order(qts);
     g_assert_cmphex(actual, ==, expected_boot);
-    qtest_qmp_assert_success(qts, "{ 'execute': 'system_reset' }");
-    /*
-     * system_reset only requests reset.  We get a RESET event after
-     * the actual reset completes.  Need to wait for that.
-     */
-    qtest_qmp_eventwait(qts, "RESET");
+    qtest_system_reset(qts);
     actual = read_boot_order(qts);
     g_assert_cmphex(actual, ==, expected_reboot);
     qtest_quit(qts);
diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index 85eb8d76687..1c73dea8f75 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -900,7 +900,6 @@ static void test_override_hot_unplug(TestArgs *args, const char *devid,
     QTestState *qts;
     char *joined_args;
     QFWCFG *fw_cfg;
-    QDict *response;
     int i;
 
     joined_args = g_strjoinv(" ", args->argv);
@@ -913,13 +912,7 @@ static void test_override_hot_unplug(TestArgs *args, const char *devid,
     /* unplug device an restart */
     qtest_qmp_device_del_send(qts, devid);
 
-    response = qtest_qmp(qts,
-                         "{ 'execute': 'system_reset', 'arguments': { }}");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    qobject_unref(response);
-
-    qtest_qmp_eventwait(qts, "RESET");
+    qtest_system_reset(qts);
 
     read_bootdevices(fw_cfg, expected2);
 
diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index c922d81bc02..7f58fc37469 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -83,7 +83,6 @@ static void test_smram_lock(void)
 {
     QPCIBus *pcibus;
     QPCIDevice *pcidev;
-    QDict *response;
     QTestState *qts;
 
     qts = qtest_init("-M q35");
@@ -107,10 +106,7 @@ static void test_smram_lock(void)
     g_assert(smram_test_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN) == false);
 
     /* reset */
-    response = qtest_qmp(qts, "{'execute': 'system_reset', 'arguments': {} }");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    qobject_unref(response);
+    qtest_system_reset(qts);
 
     /* check open is settable again */
     smram_set_bit(pcidev, MCH_HOST_BRIDGE_SMRAM_D_OPEN, false);
@@ -194,7 +190,6 @@ static void test_smram_smbase_lock(void)
 {
     QPCIBus *pcibus;
     QPCIDevice *pcidev;
-    QDict *response;
     QTestState *qts;
     int i;
 
@@ -237,10 +232,7 @@ static void test_smram_smbase_lock(void)
     }
 
     /* reset */
-    response = qtest_qmp(qts, "{'execute': 'system_reset', 'arguments': {} }");
-    g_assert(response);
-    g_assert(!qdict_haskey(response, "error"));
-    qobject_unref(response);
+    qtest_system_reset(qts);
 
     /* check RAM at SMBASE is available after reset */
     g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 114f6bef273..2f7e75a3392 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -103,8 +103,7 @@ static void restart_qemu_or_continue(char *path)
         old_path = g_strdup(path);
         qtest_start(path);
     } else { /* if cmd line is the same, reset the guest */
-        qobject_unref(qmp("{ 'execute': 'system_reset' }"));
-        qmp_eventwait("RESET");
+        qtest_system_reset(global_qtest);
     }
 }
 
diff --git a/tests/qtest/stm32l4x5_gpio-test.c b/tests/qtest/stm32l4x5_gpio-test.c
index c0686c7b306..3c6ea71febf 100644
--- a/tests/qtest/stm32l4x5_gpio-test.c
+++ b/tests/qtest/stm32l4x5_gpio-test.c
@@ -169,14 +169,6 @@ static uint32_t reset(uint32_t gpio, unsigned int offset)
     return 0x0;
 }
 
-static void system_reset(void)
-{
-    QDict *r;
-    r = qtest_qmp(global_qtest, "{'execute': 'system_reset'}");
-    g_assert_false(qdict_haskey(r, "error"));
-    qobject_unref(r);
-}
-
 static void test_idr_reset_value(void)
 {
     /*
@@ -214,7 +206,7 @@ static void test_idr_reset_value(void)
     gpio_writel(GPIO_H, OTYPER, 0xDEADBEEF);
     gpio_writel(GPIO_H, PUPDR, 0xDEADBEEF);
 
-    system_reset();
+    qtest_system_reset(global_qtest);
 
     uint32_t moder = gpio_readl(GPIO_A, MODER);
     uint32_t odr = gpio_readl(GPIO_A, ODR);
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
index d5c71e2c0e7..376c80e31ca 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -47,14 +47,6 @@ static void syscfg_set_irq(int num, int level)
    qtest_set_irq_in(global_qtest, SOC, NULL, num, level);
 }
 
-static void system_reset(void)
-{
-    QDict *response;
-    response = qtest_qmp(global_qtest, "{'execute': 'system_reset'}");
-    g_assert(qdict_haskey(response, "return"));
-    qobject_unref(response);
-}
-
 static void test_reset(void)
 {
     /*
@@ -182,7 +174,7 @@ static void test_set_only_bits(void)
     syscfg_writel(SYSCFG_SWPR2, 0x00000000);
     g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), ==, 0xFFFFFFFF);
 
-    system_reset();
+    qtest_system_reset(global_qtest);
 }
 
 static void test_clear_only_bits(void)
@@ -194,7 +186,7 @@ static void test_clear_only_bits(void)
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
     g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000000);
 
-    system_reset();
+    qtest_system_reset(global_qtest);
 }
 
 static void test_interrupt(void)
-- 
2.34.1


