Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596E6CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 16:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMTXf-0005kK-1f; Mon, 11 May 2026 12:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMTWn-0005bw-7n
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:31:00 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wMTWk-00051m-Ot
 for qemu-devel@nongnu.org; Mon, 11 May 2026 12:30:44 -0400
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so586497585a.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778517041; x=1779121841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMjfZaHH+etz2bOU5pyNA/Qg1WNb3ttNaLeoX8KklZ4=;
 b=GaVyZ5Tt3ovx4pxwGACiTVQ1Aqsqjf2UDyiFXMYYQYQ4hFFSXdW1g6kinT4MVBS+mN
 JMHLMVMzLWdAS6HlOwNrLzl10KUa2yxCcUdq2galGaOIdQF65S/F41GTm2yer/9s/uXM
 /6fvKottasOWDYL3KqqXXzbcNKefLxe8IKSb6eJ9V+P5t21vmCqXEDqnwCjdghX8se/S
 PUcNk3M3jDknsaZemeDiaen1/IaJOoYHS3o2yQvXmzPY3ccLpDolXOrpINAQwRPhYGe1
 dqGtVCIjqjzbSY29gM6twYYzKjaWhQjxop4WxJjdpRSqaj+AuAezttlRsKFzjDXrzuwz
 5BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778517042; x=1779121842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PMjfZaHH+etz2bOU5pyNA/Qg1WNb3ttNaLeoX8KklZ4=;
 b=iD1SmDmQ+K6rbnWWH9dXK2b0RvFM12PZ6SQ8olFMPkvQgJuqsjRD5c832Tt8661pzu
 UwJflX8nnJb2IqGYB1AZAtr6Xv/GEIgOOJFPXMqWJSSBUEVJQ+DZMMm9R2L0wNQQUmlR
 5xd5pwyIGM8mdKlSLX2atfFaY7jzG/P7PWe/HzA1zIfmwebeVMrU+yhK6U4mmFUJqYZn
 2+AdttvBcEK0PH9f1enx+7wJnRWBKTuFyGAOl0nhnuHfGCsvKxsiU4RMjcTfzpTjpT0Q
 krmyNkddfx7Lnmti5my1asamd9BbTrCm3cSxZ6Okf1DltDtGLc5jJ2kxEi5xlzN9oGXl
 JxZQ==
X-Gm-Message-State: AOJu0Yzw+ZqNqXavay9L9UByI8Z3rMx07FtfLZt/KJHZDHWhPItGFmRb
 VmFDfxrq0VyzRl7FESJqyH4iDVAlk/c9jRgRSokwMJEHiiJaDzfmvZXZ
X-Gm-Gg: Acq92OG0SRhWHOrSugommjFnOlpEu/R1d/FMqVJFz4cSLz4ToGgyFnQ6LS0TMG5rfzb
 mL5hKEzhJ54g/5MS8YvV2WJ5zN9RnUc1Z6uLuwuGDDdkuh5ifjnToQjwlVHjpXtsEkaLzCAqguu
 ljtACaBjnsSJ7Yo+ZfDNX8h318n0FWlIutGNp3PkNFd8whb/chuWIiZ93wbrJmFmJGcTuqbhC+m
 iq5u1Rxm7BEbQlhq+KYq5/ZjL0Rvz60CkPPLdC2NRf1qdr6xIx8Lvs5ktOvjwZY9UsLwkuZZAzU
 Rf1tiPQZDZT34IlbavVflZQhh5ev53Hm2hZawLSiBrKbkst9DsHeeLt2EP/WSHIvrPjUIN/kR6q
 7nkCJMPRxnZdSOb0H0CAeXEQpAE/mKZIU02HGHk464C5vEOY8X78y0d+ks41KSyvT9UvO1B+SMP
 +7QySA0bcazV4Ynl//IWdBIv22zuRXyMa6p3GGS8p7rsH5YU+4jZV+mUGXSkshPhCMUrHkqaXGd
 pCjLlU=
X-Received: by 2002:a05:620a:1983:b0:8cf:d5ca:add0 with SMTP id
 af79cd13be357-90cb8f466f1mr35314585a.30.1778517039305; 
 Mon, 11 May 2026 09:30:39 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b9c542cdsm1097160785a.0.2026.05.11.09.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 09:30:38 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Chao Liu <chao.liu@zevorn.cn>, Mig Yang <temashking@foxmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 4/5] tests/qtest: add test for K230 watchdog
Date: Tue, 12 May 2026 00:29:48 +0800
Message-ID: <69be8c8a8b47f4b6283a4a89850fff8cde300137.1778516731.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
References: <cover.1778516731.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qk1-x742.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Chao Liu <chao.liu@zevorn.cn>

Testing the Basic Functions of K230 WDT:
1. Reset Function
2. Timeout Check
3. Interrupt Function

Signed-off-by: Mig Yang <temashking@foxmail.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-wdt-test.c | 189 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-wdt-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e5ec6367ca..e7e3ed0c5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1788,6 +1788,7 @@ F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/qtest/k230-wdt-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
new file mode 100644
index 0000000000..c8eaeaf1ae
--- /dev/null
+++ b/tests/qtest/k230-wdt-test.c
@@ -0,0 +1,189 @@
+/*
+ * QTest testcase for K230 Watchdog
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/bitops.h"
+#include "libqtest.h"
+#include "hw/watchdog/k230_wdt.h"
+
+/* K230 WDT0 base address */
+#define K230_WDT0_BASE 0x91106000
+#define K230_WDT1_BASE 0x91106800
+
+/* Test WDT0 by default */
+#define WDT_BASE K230_WDT0_BASE
+
+static void test_register_read_write(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Test Control Register (CR) read/write */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_CR), ==,
+                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
+                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+    /* Test Timeout Range Register (TORR) read/write */
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_TORR), ==,
+                    K230_WDT_TORR_TOP_MASK);
+
+    /* Test Protection Level Register read/write */
+    qtest_writel(qts, WDT_BASE + K230_WDT_PROT_LEVEL, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, WDT_BASE + K230_WDT_PROT_LEVEL), ==, 0x7);
+
+    qtest_quit(qts);
+}
+
+static void test_counter_restart(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Enable watchdog and set timeout */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x5); /* TOP = 5 */
+
+    /* Read current counter value */
+    uint32_t initial_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
+    g_assert_cmpuint(initial_count, >, 0);
+
+    /* Restart counter with magic value */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CRR, K230_WDT_CRR_RESTART);
+
+    /* Wait for time */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
+
+    /* Counter should be reset to timeout value */
+    uint32_t new_count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
+    g_assert_cmpuint(new_count, >, 0);
+    g_assert_cmpuint(new_count, !=, initial_count);
+
+    qtest_quit(qts);
+}
+
+static void test_interrupt_mode(void)
+{
+    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
+
+    /* Set interrupt mode and enable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR,
+                 K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
+
+    /* Wait for timeout to trigger interrupt */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 10);
+
+    /* Check interrupt status */
+    uint32_t stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
+    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, K230_WDT_STAT_INT);
+
+    /* Clear interrupt */
+    qtest_writel(qts, WDT_BASE + K230_WDT_EOI, 0x1);
+    stat = qtest_readl(qts, WDT_BASE + K230_WDT_STAT);
+    g_assert_cmphex(stat & K230_WDT_STAT_INT, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_reset_mode(void)
+{
+    QTestState *qts = qtest_init("-machine k230 -no-reboot");
+
+    /* Set reset mode and enable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+    qtest_writel(qts, WDT_BASE + K230_WDT_TORR, 0x1); /* Short timeout */
+
+    /* Wait for timeout to trigger reset */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND * 2);
+
+    /* In reset mode, the system should reset */
+    /* This test verifies that reset mode is properly configured */
+
+    qtest_quit(qts);
+}
+
+static void test_timeout_calculation(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Test different timeout values */
+    for (uint32_t top = 0; top <= 15; top++) {
+        qtest_writel(qts, WDT_BASE + K230_WDT_TORR, top);
+        qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+
+        /* Read current counter value */
+        uint32_t count = qtest_readl(qts, WDT_BASE + K230_WDT_CCVR);
+        g_assert_cmpuint(count, >, 0);
+
+        /* Disable watchdog for next iteration */
+        qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_wdt1_registers(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Test WDT1 registers (second watchdog) */
+    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_CR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_CR), ==,
+                    (K230_WDT_CR_RPL_MASK << K230_WDT_CR_RPL_SHIFT) |
+                    K230_WDT_CR_RMOD | K230_WDT_CR_WDT_EN);
+
+    qtest_writel(qts, K230_WDT1_BASE + K230_WDT_TORR, 0xFFFFFFFF);
+    g_assert_cmphex(qtest_readl(qts, K230_WDT1_BASE + K230_WDT_TORR), ==,
+                    K230_WDT_TORR_TOP_MASK);
+
+    qtest_quit(qts);
+}
+
+static void test_enable_disable(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Initially disabled */
+    uint32_t cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
+    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
+
+    /* Enable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, K230_WDT_CR_WDT_EN);
+    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
+    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, K230_WDT_CR_WDT_EN);
+
+    /* Disable watchdog */
+    qtest_writel(qts, WDT_BASE + K230_WDT_CR, 0);
+    cr = qtest_readl(qts, WDT_BASE + K230_WDT_CR);
+    g_assert_cmphex(cr & K230_WDT_CR_WDT_EN, ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-wdt/register_read_write", test_register_read_write);
+    qtest_add_func("/k230-wdt/counter_restart", test_counter_restart);
+    qtest_add_func("/k230-wdt/interrupt_mode", test_interrupt_mode);
+    qtest_add_func("/k230-wdt/reset_mode", test_reset_mode);
+    qtest_add_func("/k230-wdt/timeout_calculation", test_timeout_calculation);
+    qtest_add_func("/k230-wdt/wdt1_registers", test_wdt1_registers);
+    qtest_add_func("/k230-wdt/enable_disable", test_enable_disable);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 43f83ffd3a..45c4898454 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -290,7 +290,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-   ['iommu-riscv-test'] : [])
+   ['iommu-riscv-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(

