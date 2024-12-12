Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE620E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpH-0003qu-T4; Thu, 12 Dec 2024 10:10:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpF-0003pc-Ry
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:01 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpD-0002ys-Os
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:01 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 196AB2110B;
 Thu, 12 Dec 2024 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQndaw5sHoonjIqRW2sm/7RzQQ38owA3RD7Nq7q/xWI=;
 b=o8QFwR47RVGwBazFWT9fernsAY1jrAkWGmd5W8CUIyBGqBO4BSM5SvSGe8hFOWhWrtpWcY
 FclOBbDZHZDLqSO2x3ixf4yQUpqbYZ8PmDwC+gAD22M5i6sbe5OOJSw2G/0WZ/PBwIwL6m
 Mlva8N/DPS8816OivJIS8xZ1qqGJyeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQndaw5sHoonjIqRW2sm/7RzQQ38owA3RD7Nq7q/xWI=;
 b=o0qXIl+zjQVZiqi+AlhByq7p57mLHuJ6T6qgykeQBiIYWLypZNlYRSsoOu/eXzXxXlsORG
 T3rJi8haO8v/DhDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQndaw5sHoonjIqRW2sm/7RzQQ38owA3RD7Nq7q/xWI=;
 b=o8QFwR47RVGwBazFWT9fernsAY1jrAkWGmd5W8CUIyBGqBO4BSM5SvSGe8hFOWhWrtpWcY
 FclOBbDZHZDLqSO2x3ixf4yQUpqbYZ8PmDwC+gAD22M5i6sbe5OOJSw2G/0WZ/PBwIwL6m
 Mlva8N/DPS8816OivJIS8xZ1qqGJyeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQndaw5sHoonjIqRW2sm/7RzQQ38owA3RD7Nq7q/xWI=;
 b=o0qXIl+zjQVZiqi+AlhByq7p57mLHuJ6T6qgykeQBiIYWLypZNlYRSsoOu/eXzXxXlsORG
 T3rJi8haO8v/DhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E02F213508;
 Thu, 12 Dec 2024 15:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gEzYKMT8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:09:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/22] tests/qtest: Use qtest_system_reset() instead of
 open-coded versions
Date: Thu, 12 Dec 2024 12:09:30 -0300
Message-Id: <20241212150949.16806-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email,
 suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Use the qtest_system_reset() function in various tests that were
previously open-coding the system-reset. Note that in several
cases this fixes a bug where the test did not wait for the RESET
QMP event before continuing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
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
index 16d0ffbdf6..6035ec2c61 100644
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
index c67b8cfe16..4c851c2cdb 100644
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
index 85eb8d7668..1c73dea8f7 100644
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
index c922d81bc0..7f58fc3746 100644
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
index 114f6bef27..2f7e75a339 100644
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
index c0686c7b30..3c6ea71feb 100644
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
index d5c71e2c0e..376c80e31c 100644
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
2.35.3


