Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E631FC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgCU-0005L6-Bd; Wed, 19 Aug 2026 09:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wwgCS-0005II-LV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:19:24 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rao232328@gmail.com>)
 id 1wwgCQ-0004sB-DH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 09:19:24 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso971785a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 06:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787145561; x=1787750361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5fSJnWphlhlECSW+wv6njLNgjR+jeMC/7N9v4OiIjw0=;
 b=V6ZPb3752T+LvNqqGK4MfhGU+sc8X6/phqHqqhIIEho+MdpG19Ic5WaRf2YWMH9OE9
 9bSnJHjj6KgxgQHlydUvcANlTkMLZWc8wCEcAjBrUQDC1/vHfRuoREzVQvbESMyh33Lh
 TTEp7L+LVcJI6J0iVyPP3MbZvMibJi8LjNnrH64hHl04J28uJuif7zZTpu1ZbGZHsX4e
 d5dhJm7c3Nj7AiJ+baMO5Lli4sZmNv4Z0EwW8iqbm+5VebNK9uGzP7qFSgPEF7Tq6QfU
 3IZr2ZJKJG1QMMw1QlRVCIP1ohWFsB+5QFn/i3YvLfJyanm3BJ6fd3CMxzHKudtEuurq
 Z9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145561; x=1787750361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5fSJnWphlhlECSW+wv6njLNgjR+jeMC/7N9v4OiIjw0=;
 b=WsuSQcLYOvHSxM7ECgXf+4fjLtk1DYhFlcalRkormybSMcnmvvJKg3FBRdqisZvwtt
 gKrmP0xhczuz1pjuXREPKtvm0pUCCnMRwP21ymCIimseSvTOeFev7aE8nlePCHOwGVN6
 j8byrqX6z/bsHafNqXdLK+rAaGem0LM+OPpHVIgORReurw/LUSAGBQsky3snE4iuPupq
 4n70xNkx4KjEPJzB9N6C8wwAVUBMGO+NgajYNQ7A0Kw7XkaoVpB1dTk4IbKslgPgfJEL
 DustNoD9yPUApjck/I2JSOezXwU58254ZAhEthztwhzfsOMIDJXT2p5uaktlcnhI5gv1
 exug==
X-Gm-Message-State: AFuF++ma4MLXFajA4kyENrBnSw1TpOuE9ZHVHsX/F2mRozxXratCxowp
 ytk4+b4gyiSD2UCUKRDkS8Fz9ECxOouWsBXzYzQhAFq0uyA2EoGKZstXw3FABUvet2O2Ag==
X-Gm-Gg: AR+sD12gzTsmZ6a1VbZbRCKP2I13rJEOJ/NFxqUsUPxsieDu9lazx+8EYYtv1SpwuYJ
 hzPyK9EGCZg55kIy3mpuO/C6ZvLY4WDehvyvBLGNLrsTEub0+0+yglDSSe5uXcWxn/Mmk4LLklR
 5AXEa3EvRQhnFwCWgeQUhzRBnkx2fLy/HRqiO+kc2MqafJFeaqRNZx5CZBazsYpIJ4ZmhTWvajU
 iSEwOhsf4rOLAqdc3uoQJepLT/9yFZE95fwd6JPLy5l1INErjX2W7Y0K2KEWtkwigdWuOp4AQIs
 +0UTkE3vfuExNFPQSVKu3r9Wfh1CK8KCIRvd83I35KY12DjJBIalXmv68qqYf1nTJT2jM8Ip8yT
 V8gikbQFrchIZ+NSGKQpkBYbg0bROlopQ3MewonXnwETyaNb7kt64/u/PcibSwXMiCqIbBGxZ5p
 t9kI1nGVknIOSUUDXX8KJlylRp3hDNHVjmBBj1hX7QysVdiQndRwSbHRrZ3pQUQwUJ1yJtxA==
X-Received: by 2002:a17:90b:2d05:b0:380:21b7:e727 with SMTP id
 98e67ed59e1d1-39581470f03mr8829771a91.14.1787145560919; 
 Wed, 19 Aug 2026 06:19:20 -0700 (PDT)
Received: from DESKTOP-DFGP8OG.lan ([156.226.169.41])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957fb12145sm2734387a91.4.2026.08.19.06.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:19:20 -0700 (PDT)
From: raoyi <rao232328@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 caojunze424 <caojunze424@gmail.com>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 raoyi <rao232328@gmail.com>
Subject: [PATCH v5 3/3] tests/qtest: add k230 dwapb timer test
Date: Wed, 19 Aug 2026 21:18:59 +0800
Message-ID: <20260819131859.9583-4-rao232328@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819131859.9583-1-rao232328@gmail.com>
References: <20260819131859.9583-1-rao232328@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=rao232328@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add qtest coverage for K230 DW APB timer, including free-running,
periodic, interrupt mask, disable behavior, current value, dynamic
reload, and multi-channel scenarios.

Add timer test file to MAINTAINERS.

Signed-off-by: raoyi <rao232328@gmail.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
---
 MAINTAINERS                         |   1 +
 tests/qtest/k230-dwapb-timer-test.c | 274 ++++++++++++++++++++++++++++
 tests/qtest/meson.build             |   3 +-
 3 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-dwapb-timer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cf689433ff..82e5643a93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1830,6 +1830,7 @@ F: hw/timer/dw-apb-timer.c
 F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: include/hw/timer/dw-apb-timer.h
+F: tests/qtest/k230-dwapb-timer-test.c
 F: tests/qtest/k230-wdt-test.c
 
 RX Machines
diff --git a/tests/qtest/k230-dwapb-timer-test.c b/tests/qtest/k230-dwapb-timer-test.c
new file mode 100644
index 0000000000..01bf03a8b6
--- /dev/null
+++ b/tests/qtest/k230-dwapb-timer-test.c
@@ -0,0 +1,274 @@
+/*
+ * QTest testcase for the DesignWare APB timer through the K230 machine
+ *
+ * Copyright (c) 2026 raoyi <rao232328@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "libqtest.h"
+
+#define TIMER_BASE 0x91105800
+#define K230_TIMER_NUM_CHANNELS 6
+#define K230_TIMER_DEFAULT_FREQ 50000000
+
+#define DW_APB_TIMER_STRIDE       0x14
+#define DW_APB_TIMER_N_LOAD_COUNT     0x00
+#define DW_APB_TIMER_N_CURRENT_VALUE  0x04
+#define DW_APB_TIMER_N_CONTROL        0x08
+#define DW_APB_TIMER_N_EOI            0x0c
+#define DW_APB_TIMER_N_INT_STATUS     0x10
+#define DW_APB_TIMER_INT_STATUS        0xa0
+#define DW_APB_TIMER_EOI               0xa4
+#define DW_APB_TIMER_RAW_INT_STATUS    0xa8
+#define DW_APB_TIMER_CONTROL_ENABLE        BIT(0)
+#define DW_APB_TIMER_CONTROL_MODE_PERIODIC BIT(1)
+#define DW_APB_TIMER_CONTROL_INT_MASK      BIT(2)
+
+#define TIMER_REG(n, reg) (TIMER_BASE + (n) * DW_APB_TIMER_STRIDE + (reg))
+#define TIMER_TICK_NS (NANOSECONDS_PER_SECOND / K230_TIMER_DEFAULT_FREQ)
+
+static void timer_load(QTestState *qts, int n, uint32_t value)
+{
+    qtest_writel(qts, TIMER_REG(n, DW_APB_TIMER_N_LOAD_COUNT), value);
+}
+
+static void timer_enable(QTestState *qts, int n, uint32_t ctrl)
+{
+    qtest_writel(qts, TIMER_REG(n, DW_APB_TIMER_N_CONTROL), ctrl);
+}
+
+static void timer_disable(QTestState *qts, int n)
+{
+    qtest_writel(qts, TIMER_REG(n, DW_APB_TIMER_N_CONTROL), 0);
+}
+
+static uint32_t timer_get_and_clear_status(QTestState *qts, int n)
+{
+    uint32_t int_status = qtest_readl(qts,
+                            TIMER_REG(n, DW_APB_TIMER_N_INT_STATUS));
+
+    if (int_status) {
+        qtest_readl(qts, TIMER_REG(n, DW_APB_TIMER_N_EOI));
+    }
+
+    return int_status;
+}
+
+static void test_timer_free_running(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(timer_get_and_clear_status(qts, 0), ==, 1);
+
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+    uint32_t cur = qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
+    g_assert_cmphex(cur, <, UINT32_MAX);
+    g_assert_cmphex(cur, >, 0);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_periodic(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int i;
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+
+    for (i = 0; i < 3; i++) {
+        qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+        g_assert_cmphex(timer_get_and_clear_status(qts, 0), ==, 1);
+        uint32_t cur = qtest_readl(qts,
+                          TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
+        g_assert_cmphex(cur, <=, 100);
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_timer_int_mask(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC |
+                        DW_APB_TIMER_CONTROL_INT_MASK);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)) & 1, ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_INT_STATUS), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_RAW_INT_STATUS) & 1, ==, 1);
+
+    /* Unmasking a pending interrupt must assert it immediately. */
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)), ==, 1);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_INT_STATUS) & 1, ==, 1);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_disable_clears_irq(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)) & 1, ==, 1);
+
+    timer_disable(qts, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_INT_STATUS)) & 1, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_current_disabled(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* TRM: "A '0' is always read back when the timer is not enabled" */
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+
+    timer_load(qts, 0, 9999);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE);
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+    uint32_t cur_enabled = qtest_readl(qts,
+                              TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
+    g_assert_cmphex(cur_enabled, >, 0);
+    g_assert_cmphex(cur_enabled, <, UINT32_MAX);
+
+    timer_disable(qts, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_dynamic_reload(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint32_t cur;
+
+    timer_load(qts, 0, 1000);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+
+    qtest_clock_step(qts, 100ULL * TIMER_TICK_NS);
+
+    timer_load(qts, 0, 200);
+
+    qtest_clock_step(qts, 901ULL * TIMER_TICK_NS + 1);
+    g_assert_cmphex(timer_get_and_clear_status(qts, 0), ==, 1);
+
+    qtest_clock_step(qts, 100ULL * TIMER_TICK_NS);
+    cur = qtest_readl(qts, TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE));
+    g_assert_cmphex(cur, ==, 99);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_all_channels(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    int i;
+
+    for (i = 0; i < K230_TIMER_NUM_CHANNELS; i++) {
+        timer_load(qts, i, 100 + i * 50);
+        timer_enable(qts, i, DW_APB_TIMER_CONTROL_ENABLE |
+                             DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+    }
+
+    /* Step past timer 0 expiry (load=100) - only timer 0 should fire */
+    qtest_clock_step(qts, 101ULL * TIMER_TICK_NS + 1);
+    uint32_t sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts & 1, ==, 1);
+    g_assert_cmphex(sts & 0x3e, ==, 0);
+
+    /* Step to timer 1 expiry (another 50 ticks) */
+    qtest_clock_step(qts, 50ULL * TIMER_TICK_NS + 1);
+    sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts & 0x3, ==, 0x3);
+    g_assert_cmphex(sts & 0x3c, ==, 0);
+
+    /* Step to expiry of all remaining timers (another 200 ticks) */
+    qtest_clock_step(qts, 200ULL * TIMER_TICK_NS + 1);
+    sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts, ==, 0x3f);
+
+    /* EOI_ALL clears all */
+    qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_EOI);
+    sts = qtest_readl(qts, TIMER_BASE + DW_APB_TIMER_INT_STATUS);
+    g_assert_cmphex(sts, ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_timer_reset(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    timer_load(qts, 0, 100);
+    timer_enable(qts, 0, DW_APB_TIMER_CONTROL_ENABLE |
+                        DW_APB_TIMER_CONTROL_MODE_PERIODIC);
+    qtest_clock_step(qts, 10ULL * TIMER_TICK_NS);
+
+    qtest_system_reset(qts);
+
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_LOAD_COUNT)), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CONTROL)), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_REG(0, DW_APB_TIMER_N_CURRENT_VALUE)), ==, 0);
+    g_assert_cmphex(qtest_readl(qts,
+                      TIMER_BASE + DW_APB_TIMER_RAW_INT_STATUS), ==, 0);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/dw-apb-timer/free_running", test_timer_free_running);
+    qtest_add_func("/dw-apb-timer/periodic", test_timer_periodic);
+    qtest_add_func("/dw-apb-timer/int_mask", test_timer_int_mask);
+    qtest_add_func("/dw-apb-timer/disable_clears_irq",
+                   test_timer_disable_clears_irq);
+    qtest_add_func("/dw-apb-timer/current_disabled",
+                   test_timer_current_disabled);
+    qtest_add_func("/dw-apb-timer/dynamic_reload",
+                   test_timer_dynamic_reload);
+    qtest_add_func("/dw-apb-timer/all_channels", test_timer_all_channels);
+    qtest_add_func("/dw-apb-timer/reset", test_timer_reset);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..bacd8719b4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-wdt-test', 'k230-dwapb-timer-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.53.0


