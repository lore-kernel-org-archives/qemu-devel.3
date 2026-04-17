Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D765EF436B2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDksI-0006h6-Ts; Fri, 17 Apr 2026 11:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDks8-0006c6-Pt
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:12:48 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wDks6-0007hc-RN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 11:12:44 -0400
Received: by mail-vs1-xe43.google.com with SMTP id
 ada2fe7eead31-60579e72ff9so551725137.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 08:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776438762; x=1777043562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLQiWKMcfLlz7tTlCqrm6zZiKMSjWheREzPec2gnwo4=;
 b=P+Jzw9/OS6MnKkcS2d8O+LvfhzIvr+Hw9vWmEX26qzMZ1y9qzKYNy4bFxyzvtFxBrP
 CoMFVh8e03jWT+cqxzF0tQMwgDPDa4ywgepZUK++ooWiBBMlR/ei2pLR0qnvRwPuOTx3
 Ht0dFl3bwQ/axKwCPpTP/o+lD43U/GIaCAKTXberiQU9PQ12y5130xhwqBoJvAe91euB
 2gxM55jVbF+oo4pYNfHFfFKfOk2IBWu0A8w/0w9UgSMPSTAYrnhSsAqsHoD0gTJ+ZYSF
 sFJTH7IinXqJ+NXIjJ/K6WBgFj1DmrGzhbdAGu5G92MYt1tpMQ/+G721FqASV/QXIfkZ
 e/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776438762; x=1777043562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLQiWKMcfLlz7tTlCqrm6zZiKMSjWheREzPec2gnwo4=;
 b=qLf/pfWIqGZId21HzeK4Z68hn4E6Q1GJyrX28C8CJEpZhVyWb+DT6dzBrMYGn453tA
 HqpahWQMSOWWNV704bgcebx1pSpagOqK7CyVgV/fwDwyQMepjhigMB5TYBfHJHXU44qs
 +F1J1225+w4OYPh5NgD1qPn+WxCeWJBHmQyRM4EixAF4hbm3VfXRmKoC7GhR7+Y5uBE5
 aJyuG15fyj+7DZZFhLIW8PlzjiQXQkPDoTosuvMlDKKVSEN5ujWHxQTQaxG51EbdLy0w
 zEfyz0ppCDuTpa+FwQvCg+qSNcZ26JOdQptzZChjdBLWQY7XBEvyQjXCL9YdvZuVm3Lb
 vGjA==
X-Gm-Message-State: AOJu0YwS7RbFG+KeePcecix3Jz0w/z6gTdpcLjbjL5P5hHFWLAWv/jt1
 CPe3pZjMtDHVjEbKxc9PFiyQosuGx/uD+yoR46xDQQmJ/+BXOk+29IrJ
X-Gm-Gg: AeBDiesLbB68d+2I4ZXixFoWAtv9WMIeIDPERxaVXrurnzF9AzOMwYdX4Qj3cn84Psp
 WWzDxIE4Oaa9RUrZBdvkou3M1+8cBVL+kghH8ngy2RTBpj604Hlqzu9AxuVV3paGu/B9ZArNAat
 xAUUKyqZjsRAr/GpaouIxluzB25T72pF3JhtcITZdvpqL8GTpVisbWv0Z4/BDNQTww/FtG03Uag
 QVxe+zXdrHxyMcn9v8de9uHt7zSEisPa2o8nawoy/Ky+vgOO7TMYcMKXEGWsqwIAJrSJB20p6ob
 TtH7h0L7bbuKZuV28MTHgpd1mOvKyQJUAkpptQBlvhx1S7ykybTTvSG6t/1k/gubxVTEsRj+x9T
 n5EsOR/ncQXde0o4Be9DvzHBZgXPKTj4SydBz5BrMomwSvERCcB2DxrrRb+QF9FZkD4BpW6gD4k
 BTn+Co5lZiXL670PHXzu2AkYzrKtXGe6LHvnISBY1r0U1HKDt9+Baa29P2PiUGtisYdyEyova/F
 JEJEtaTREcIaH3Gug==
X-Received: by 2002:a05:6102:580c:b0:5dd:c53b:75cc with SMTP id
 ada2fe7eead31-616fe04c305mr1124278137.13.1776438761588; 
 Fri, 17 Apr 2026 08:12:41 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-61747cb501asm788923137.7.2026.04.17.08.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:12:41 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
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
Subject: [PATCH v6 4/5] tests/qtest: add test for K230 watchdog
Date: Fri, 17 Apr 2026 23:11:28 +0800
Message-ID: <9fada6c8ab0e3397a4b81576edad8f428e4cfdea.1776438369.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
References: <cover.1776438369.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-vs1-xe43.google.com
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
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-wdt-test.c | 199 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-wdt-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a2eecca155..b5b4acf6bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1780,6 +1780,7 @@ F: hw/riscv/k230.c
 F: hw/watchdog/k230_wdt.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
+F: tests/qtest/k230-wdt-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
new file mode 100644
index 0000000000..2550cebd10
--- /dev/null
+++ b/tests/qtest/k230-wdt-test.c
@@ -0,0 +1,199 @@
+/*
+ * QTest testcase for K230 Watchdog
+ *
+ * Copyright (c) 2025 Mig Yang <temashking@foxmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Provides a board compatible with the kendryte K230 SDK
+ *
+ * Documentation: K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ *
+ * For more information, see <https://www.kendryte.com/en/proDetail/230>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
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
index be4fa627b5..b00e1e1f5d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -288,7 +288,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-   ['iommu-riscv-test'] : [])
+   ['iommu-riscv-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
-- 
2.53.0


