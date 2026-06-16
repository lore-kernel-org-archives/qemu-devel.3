Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6BFCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZ3c-0001N8-8q; Tue, 16 Jun 2026 15:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ3a-0001Me-OB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <visitorckw@gmail.com>)
 id 1wZZ3X-0007e4-Fk
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:02:42 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8422f148dfcso2916587b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781636557; x=1782241357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwphlitC4oX8AgGTzJwdeXKuAewbvY6nCE2dpNNB1n0=;
 b=dIB8DqUtlfp2Cv43uunI3shxxEYT7tnixzIEAJq3prHBVyFBqs8YKQLA+sH5FKVCEV
 gxcmkV+hLbp5dqIMjb9c7FXgbN8IIcfSe7nO/b+N8B6O22tca9S5ubJnGYCN+7oVlay8
 pp+U7g/zL3Z9TrToccTQM2WsnCTSxfXN4sZgXZo74QBBq8a20xtb2hiW3ndxhzixuog3
 qZh4NTRHjtVdDH7hWf1SvtY/XTeo72h0yPFXs3Ao/wTy/mgKSPpD0U8B8puMiIh3F5kw
 WQFcMvm+j5kP9jNa/TXBvUyjOz+EbDJll6jAfrbuZvV9Qbv+FmyByJlOKdTSAbiE5esJ
 w74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636557; x=1782241357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BwphlitC4oX8AgGTzJwdeXKuAewbvY6nCE2dpNNB1n0=;
 b=phKKbnxs7V/0PnG9rnDVEtHD96gSEEv0JDNtwDEOp79rmpK450rZLLcIObz6qI7hvE
 ry5GDDvviWjzLWph/cR43FnoMwuWvLeo8qYKmmUbLeeoVc3B+D+loXWexaSRD6wjJWjI
 xTY/vM1m0sox+p76n1WOFY9w1XJrMEjF3/h/PQTh4PqR9UrN4Pv46iJHswd51sSjWQOF
 nnNuus2bZXYF2og9iQ/5xXuOKBtZ2PvPbbp6tgQg4MDhV7gyCdoo1Su2aKZU4rBvqDWz
 aSEmhkmkRhMSRl321XH61rf+UMUIz9uijVV9796Uf+yiopUmnCTIiF0DPi5mc/cIeejs
 sbiQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wpdG/3kQhJdL76B2cMrBBqEYnMQv4t9H+nWLksiXNLa0LVfi25e2QIERJlJLxciu9urFNu5NgEVXE@nongnu.org
X-Gm-Message-State: AOJu0YzRzDFTzCc1kpf1DR6L0KE6Zjka1ehl9mWAx8sx83tFhxk1gAI+
 z+hbVgFxMItquh2wZyrkJ9XAr/ATM5Nr4SvKBXL+CxXnibtI1ga1kKDD
X-Gm-Gg: Acq92OGHEcGxDI7ub+bOgWjnVoKwd9tlJQWtQpXYsZ6+FOJtiSmko/Q/6Ta7wKXDGQR
 +IxCpFUq2Jv7to07Ac0RnP7OnV8P8H+m5cUbA7Rw/wKPIcLpTBVYSykcA5LlRMQxitdDrZTAphz
 LTvcjGzCd1bMbcpayt8cDTvmpqv5JGtmvfgZGduu6oacGkTThehuyhhZi4m9u05Jb92ihGaYItW
 X7zVB4J/pc5K1VxDJjtWGJdwaJFWOI8xVlplW/BkJkJI+8HXIW8j6HFmRWa5sctSOdsh9h/L3vW
 m7ma0hmvBXo+rSkAs/7LeEjwWBNnV9ThTN7NZy3GFAkqrQNB8L4JtIvRSi3SNGo8E1+t7Z+1ndR
 G45yQpcjULe25oVyIKESxAYq5JiJsaychoKSMujkbU7dWO/kWeTah0gg0OgxdvspYQos3vCTVKf
 gpVqmfjQIzLunEmjScZGH6qgfY0UXGBiFHiE57A4+XXuE8Mmyq8XLqaWOJt2dIFxgeNFQOssQzV
 mUp+4CDaJlhkdSxk2d3xiR0xGYLo/k57g==
X-Received: by 2002:a05:6a00:2194:b0:842:7062:fb39 with SMTP id
 d2e1a72fcca58-845244407bdmr405858b3a.4.1781636556743; 
 Tue, 16 Jun 2026 12:02:36 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c474sm12671540b3a.2.2026.06.16.12.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:02:36 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com, alistair.francis@wdc.com,
 farosas@suse.de, lvivier@redhat.com
Cc: liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 5/5] tests/qtest: Add qtest for Milk-V Duo board
Date: Tue, 16 Jun 2026 19:01:47 +0000
Message-ID: <20260616190147.1286316-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616190147.1286316-1-visitorckw@gmail.com>
References: <20260616190147.1286316-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=visitorckw@gmail.com; helo=mail-pf1-x432.google.com
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

Add minimal qtest coverage for the Milk-V Duo machine to validate basic
MMIO mapping and register access.

Currently tested:
- Verify DW8250 UART component version and type signatures.
- Test read/write access to CV1800B clock bypass register.

Tested with:
$ meson test -C build -v qemu:qtest-riscv64/milkv-duo-test
[...]
Ok:                 1
Fail:               0

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  1 +
 tests/qtest/meson.build      |  3 +-
 tests/qtest/milkv-duo-test.c | 70 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/milkv-duo-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e197dcb5b2..472513537f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1807,6 +1807,7 @@ F: hw/riscv/milkv_duo.c
 F: include/hw/char/dw8250.h
 F: include/hw/misc/cv1800b_clk.h
 F: include/hw/riscv/cv1800b.h
+F: tests/qtest/milkv-duo-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4897325d84..38acbdc0c8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -293,7 +293,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : []) + \
+   ['milkv-duo-test']
 
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
diff --git a/tests/qtest/milkv-duo-test.c b/tests/qtest/milkv-duo-test.c
new file mode 100644
index 0000000000..06064b8733
--- /dev/null
+++ b/tests/qtest/milkv-duo-test.c
@@ -0,0 +1,70 @@
+/*
+ * QTest for Milk-V Duo Board
+ *
+ * Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+#define CV1800B_CLK_BASE            0x03002000
+#define CV1800B_CLK_BYPASS          0x030
+#define CV1800B_CLK_BYPASS_RESET    0xFFFFFFFF
+#define TEST_PATTERN_5A             0x5A5A5A5A
+#define TEST_PATTERN_A5             0xA5A5A5A5
+
+#define CV1800B_UART0_BASE          0x04140000
+#define DW_UART_UCV                 0xF8
+#define DW_UART_CTR                 0xFC
+#define DW_UART_VERSION_3_23A       0x3332332A
+#define DW_UART_TYPE_SIGNATURE      0x44570110
+
+static void test_milkv_duo_uart(void)
+{
+    QTestState *qts;
+    uint32_t component_version;
+    uint32_t component_type;
+
+    qts = qtest_init("-M milkv-duo");
+
+    component_version = qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_UCV);
+    g_assert_cmphex(component_version, ==, DW_UART_VERSION_3_23A);
+
+    component_type = qtest_readl(qts, CV1800B_UART0_BASE + DW_UART_CTR);
+    g_assert_cmphex(component_type, ==, DW_UART_TYPE_SIGNATURE);
+
+    qtest_quit(qts);
+}
+
+static void test_milkv_duo_clk(void)
+{
+    QTestState *qts;
+    uint32_t clk_bypass_val;
+
+    qts = qtest_init("-M milkv-duo");
+
+    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
+    g_assert_cmphex(clk_bypass_val, ==, CV1800B_CLK_BYPASS_RESET);
+
+    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTERN_5A);
+    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
+    g_assert_cmphex(clk_bypass_val, ==, TEST_PATTERN_5A);
+
+    qtest_writel(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS, TEST_PATTERN_A5);
+    clk_bypass_val = qtest_readl(qts, CV1800B_CLK_BASE + CV1800B_CLK_BYPASS);
+    g_assert_cmphex(clk_bypass_val, ==, TEST_PATTERN_A5);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/riscv/milkv-duo/uart", test_milkv_duo_uart);
+    qtest_add_func("/riscv/milkv-duo/clk", test_milkv_duo_clk);
+
+    return g_test_run();
+}
-- 
2.54.0.1136.gdb2ca164c4-goog


