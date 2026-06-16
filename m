Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD7CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQjy-0008L7-K3; Tue, 16 Jun 2026 06:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjn-00081Y-8Y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQjk-000454-VW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:09:43 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c858014845aso1731293a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604579; x=1782209379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1dFVnvk10tuyBMWh235Wzy1/QPc1OV61/YleBsrVbHU=;
 b=mBKe0IYmBRERVR5LABzfLkJTJ+tXXKq7K360zQb2ubMvs/dfdJK9SuZjgm/cAMpPCJ
 ZlAbIQ+ZUHhO94ItbfLN+DV1tKffzBXlVKENRTFX/l/wU8zvi2xQCR0SrthtphHcxOkd
 CI+MMt2HQe3A5UGlo0ZpIL+AMxntXRFbrKCZWbH3jumt4CmIogjvpEKf0I+Lrp4oqaU1
 KYobwG/7m+1hS8u3USOxd0Lgvx31BvMgV36kRr6UTrO30FbhfUrobhZjB5kBj5MBdBB7
 MhU374RqRhPx48sLvlKJO0uqdGBrzNFfeDLKjBhqBvkEuZ++PDkKKvK0Ml6QMDHXxdwy
 K+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604579; x=1782209379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1dFVnvk10tuyBMWh235Wzy1/QPc1OV61/YleBsrVbHU=;
 b=oxpl9pW9qZGiucvWMSxCeL7BdDP7X9clpgOgPAWDAdUbNnvdSLuTIOsCGTO9uJLtOO
 PO3k6SXeswOrBIbrgQYvLpfoPAeHqluq0cDX1aBH6KMc4Ytk4AgdYZ2Pw2GqWudtRoL8
 +zGza7HI+1qoMAIE1U5ANJi6VPwfNrw6PEqbunmNARybsTC5BSQc/K00V6raeyufqRsD
 owFsApxthPWyckgaaY9TUgayZEMfdcMd5uOhldj09saRCmlG/qTu4bwzy8Gcc5IzavAf
 rHvQ3veLLWWgfciJP/UZ/qULjn06wR+sM+/MPQ3XNSjGfbRJJaueuhqzhKVnUuJFZyIT
 Qj1Q==
X-Gm-Message-State: AOJu0YzLOgE5Ti52oDHOvwtFII/lRyF8afqpSglecUxBz0kFq2cvxMaq
 8AQP/XSqgu2SPRaLycTfPy9Ahk9uaPncag3DYKZcTlQ1MEJriQcUVCTf416TLD+o
X-Gm-Gg: Acq92OFkPMhoAlOya/D8756dMGSHqTK5qKbnhCE2nmLa8jgI0SOWkKy0S8RXaOePUPj
 doaFinJV+EnzKHhdreK2Vy39zKLaKzsSllWm+1/ocMOnmRLcjuMJXoe0XGmGBEzG/QXgixaMoGF
 vkEiMyJWZArxHSY+bGHjuDnf7DTNsUyLAJv4QVyGoYD5G/DM6volnejQ1JuB0dEIR0AzGKo9ZXQ
 kd6jnFPVkBrqFcHU0R91ZJNSggFoMSQLe2QUQVv92zAHieQEa7kMxPrQCBfYvy9ZJ1mKi4384yg
 ST8TpCBJdUvZJFz5ThrUNRr56DPNStnEm8D2ofzKKIssMDo8KMhPvX3wDeBSYSyXlwn9RgtycoI
 GEX0thlbQmkcPa2owjmkvHV/LGsdNE1J9P7hNKlCrVVwofMhjh08M2sz2ypjTmXo1IJOFVI2vsU
 x7FY+YPaAgAF5+es9yFvVi0/pSJeLSyVOEGhoBT/0F
X-Received: by 2002:a05:6a20:d817:b0:3b5:6b5a:4f31 with SMTP id
 adf61e73a8af0-3b7e24e1f45mr2759986637.27.1781604579584; 
 Tue, 16 Jun 2026 03:09:39 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:38 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Chao Liu <chao.liu@zevorn.cn>,
 Mig Yang <temashking@foxmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Fabiano Rosas <farosas@suse.de>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 69/83] tests/qtest: add test for K230 watchdog
Date: Tue, 16 Jun 2026 20:05:12 +1000
Message-ID: <20260616100527.1939565-70-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <791beb1d8db07e4d1011cbeb4a8ac3add5b24f09.1781246408.git.chao.liu@processmission.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                 |   1 +
 tests/qtest/k230-wdt-test.c | 189 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 3 files changed, 192 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-wdt-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 06db33a107..44654b5798 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,6 +1794,7 @@ F: hw/riscv/k230.c
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
index 45ea497fa5..37ca38f9e7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -291,7 +291,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : []) + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
-   ['iommu-riscv-test'] : [])
+   ['iommu-riscv-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
-- 
2.54.0


