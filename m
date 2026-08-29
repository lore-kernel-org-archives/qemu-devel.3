Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7294C61DD6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 04:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0AY7-0008VR-Fh; Sat, 29 Aug 2026 00:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vae1207@gmail.com>) id 1x08Rs-0004ou-8G
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 22:05:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vae1207@gmail.com>) id 1x08Ro-0007pH-UG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 22:05:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d58efc7356so18747735ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 19:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787969131; x=1788573931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lt9h49RURpF5cpPX/SYI3haQspCU9BJRLrs+VVb4Avk=;
 b=IF+fnZi7Xej6rRGAyf7nLi3Q5iOf+Xf+opr1PDrBQKQNVIduMrW2u487Wmz9TGB6+H
 qZlKiwTUQdrwSpPO+hIr+2obG9LOpooTg28tIgLTALzTeb11oW18/gIJOFWkY395PUAR
 CvhDUinO2/M4VMN1lxA1I/ziXPU3G1nusPEi0fFX09zszC7VZK/oDxn+6uLDokhjmWX6
 LPgFYe4+E+zSaY7NTG/uKq9op/cwD94kQghFDeNIEIVJA+j5LkpDAAaPgWd6AjXA81fp
 lAnwrmw7aI45tiWtAQoT5YGLKxg79SEg00E5mqodqzdEA1bttnfIGCCqPsm54DhNiznu
 TRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787969131; x=1788573931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lt9h49RURpF5cpPX/SYI3haQspCU9BJRLrs+VVb4Avk=;
 b=JAo6TV30qkTEx0HYzjbnBd6YR777MzfA44M6M95605TpoRFLo9eYlXx8FGz7qA5UPR
 FG4ZfINn4UAQls53V1HsPW/Kcuh0vhXKw/W90gDMUWJxV/lNZAaY3SE4WDXVrxpzeQr1
 9HGuLDRx00gffsYtQc+0ngWSN9zU5FBCgXZMygmlb/LZL+zT7pCGDuDwBxDYl/S468zY
 Ss84+rihXSm7eLKgE+oJbUi45gf7Nsyaq0taBbzOtp2FxQG4IUWMRmW8PQLMuc0SSi3/
 K8WzoOeGL/EoHWunrBmdeCZ7M5Jk9vbG2YuHSz8lU6z9IjB2nMfffvk53qLOpNUHZMHb
 QnWw==
X-Gm-Message-State: AFuF++kMRH6augzuKX8L5H7EE84hss9ozCbPOYJws1K8Zj6IFcgQDT3N
 xXvafjXAmqNAjfmUVC/LGcFXmKK4ixrTqArT5J/txmnIa05PFZEBiI8C931lyZsH
X-Gm-Gg: AYBFou1KuR8+GdJq8tB0Na8MuowGGL58S2i9En/RruzFKKIo1dFVpIMhCkIuDG6NOrQ
 yD2YBVyKHd0EwjFzaD0KaGwaUIV69hQIfJFXgKBCOSAe2jyuj9+OGdzzRUHYPG7wsIK8DCDXUd9
 jQ3vPnpbe/Z3ZCY+/nuWaYg6w2LyBW0da4mS//zQAb1sn2cTzMkOr+KraDF0q4Ra8ykhsi+VSHE
 IuR92cUCTdsda56niNf8z9M1LvmDLESByjeTADYZjQ4MIqJHMm6OSVFjpScDSHtHjWtIcnPHFak
 geBXxMiu3jzR0NRczCOxTL0IFx03bmwQZgITIajBVpJXKf/YkHKkP322/kbpUH5vZL/VC4B1oCx
 WrADIKM0KBTIAi72I2bNni+HYonAjqCXGAn53SWpxWXWb6MQ4N5/qVZziFHkZz/gbC/qgUeX3c7
 v9sClysvw/AcD4KKLt6zT9d6nSkwr0cim/FJ4u9Amb4L71WAJ5Nw/HnkM0AWee/ZYcxmXwrg==
X-Received: by 2002:a17:902:cf4b:b0:2d7:71e:575d with SMTP id
 d9443c01a7336-2d74df04c8amr202211195ad.9.1787969131305; 
 Fri, 28 Aug 2026 19:05:31 -0700 (PDT)
Received: from localhost.localdomain ([180.213.79.228])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d759869aeesm10592695ad.46.2026.08.28.19.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 19:05:30 -0700 (PDT)
From: JunWei Li <vae1207@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chenhuacai@canaan-creative.com,
 JunWei Li <vae1207@gmail.com>
Subject: [PATCH 3/3] tests/qtest: add k230-pmu-test
Date: Sat, 29 Aug 2026 10:02:29 +0800
Message-Id: <20260829020229.389742-4-vae1207@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260829020229.389742-1-vae1207@gmail.com>
References: <20260829020229.389742-1-vae1207@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=vae1207@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Aug 2026 00:20:10 -0400
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

Add qtest coverage for the K230 PMU: register reset values, write masks, interrupt triggering and W1C clearing through the input pads, and PAD70/PAD71 output behaviour.

Signed-off-by: JunWei Li <vae1207@gmail.com>
---
 tests/qtest/k230-pmu-test.c | 136 ++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build     |   3 +-
 2 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-pmu-test.c

diff --git a/tests/qtest/k230-pmu-test.c b/tests/qtest/k230-pmu-test.c
new file mode 100644
index 0000000000..9f24b18f19
--- /dev/null
+++ b/tests/qtest/k230-pmu-test.c
@@ -0,0 +1,136 @@
+/*
+ * QTest for the K230 PMU Unit.
+ *
+ * Copyright (c) 2026 LiJunWei <vae1207@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * K230 Technical Reference Manual V0.3.1 (2024-11-18):
+ * https://github.com/revyos/external-docs/blob/master/K230/en-us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "hw/misc/k230_pmu.h"
+
+#define PMU_BASE 0x91000000
+
+static void test_reset_values(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT0_TO_CTL * 4), ==,
+                    0xfff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT1_TO_CTL * 4), ==,
+                    0xfff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT0_TO_CPU * 4), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_DETECT_EN * 4), ==,
+                    0x810);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_DETECT_TYP * 4), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_DETECT_CLR * 4), ==, 0);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_LONG_PRESS_TRIGGER * 4),
+                    ==, 0x17700);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_LONG_PRESS_SHUTDOWN * 4),
+                    ==, 0x4e200);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_SHORT_PRESS_TRIGGER * 4),
+                    ==, 0x3e800);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_LEVEL_DEBOUNCE * 4), ==,
+                    0x100);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_EDGE_NUMBER * 4), ==, 0x1);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_SYSCTRL * 4), ==, 0x1);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_OUT_DELAY_SET * 4), ==,
+                    0x1100640);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_IO_CFG0 * 4), ==, 0x1124);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_IO_CFG6 * 4), ==, 0x10a4);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_IO_CFG7 * 4), ==, 0x1084);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_NORMAL_TIMER_VAL * 4), ==,
+                    0x780);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_OUT_EVENT_CTRL * 4), ==,
+                    0x5c);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_OUT_LOGIC_CTRL * 4), ==,
+                    0x2);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_STATE * 4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_write_masks(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    /* Reserved bits are write-ignored and read as zero. */
+    qtest_writel(qts, PMU_BASE + R_INT_DETECT_EN * 4, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_DETECT_EN * 4), ==,
+                    0x1fff);
+    qtest_writel(qts, PMU_BASE + R_INT_DETECT_TYP * 4, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_DETECT_TYP * 4), ==,
+                    0x1fffff);
+    qtest_writel(qts, PMU_BASE + R_IO_CFG0 * 4, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_IO_CFG0 * 4), ==, 0x3def);
+    qtest_writel(qts, PMU_BASE + R_SYSCTRL * 4, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_SYSCTRL * 4), ==, 0x3);
+
+    /* PMU_INT_STATE_REG is read-only. */
+    qtest_writel(qts, PMU_BASE + R_INT_STATE * 4, 0xffffffff);
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_STATE * 4), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_interrupt_clear(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_irq_intercept_out_named(qts, "/machine/soc/k230-pmu",
+                                  "sysbus-irq");
+
+    /*
+     * PAD68 (input 4) edge/level detection is enabled by default
+     * (PMU_INT_DETECT_EN bit 4).  Raise the input and gate the
+     * corresponding interrupt through PMU_INT0_TO_CPU.
+     */
+    qtest_writel(qts, PMU_BASE + R_INT0_TO_CPU * 4, BIT(4));
+    qtest_set_irq_in(qts, "/machine/soc/k230-pmu", NULL, 4, 1);
+
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_STATE * 4) & BIT(4),
+                    ==, BIT(4));
+    g_assert_cmpuint(qtest_get_irq(qts, 0), ==, 1);
+
+    /* CLR bit 1 clears the int4 edge/level state (W1C). */
+    qtest_writel(qts, PMU_BASE + R_INT_DETECT_CLR * 4, BIT(1));
+    g_assert_cmphex(qtest_readl(qts, PMU_BASE + R_INT_STATE * 4) & BIT(4),
+                    ==, 0);
+    g_assert_cmpuint(qtest_get_irq(qts, 0), ==, 0);
+
+    qtest_quit(qts);
+}
+
+static void test_pad_outputs(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+
+    qtest_irq_intercept_out_named(qts, "/machine/soc/k230-pmu",
+                                  "sysbus-irq");
+
+    /* PAD70/PAD71 follow the PMU_SYSCTRL_REG to_ctrl bits. */
+    qtest_writel(qts, PMU_BASE + R_SYSCTRL * 4, 0x0);
+    g_assert_cmpuint(qtest_get_irq(qts, 1), ==, 0);
+    g_assert_cmpuint(qtest_get_irq(qts, 2), ==, 0);
+
+    qtest_writel(qts, PMU_BASE + R_SYSCTRL * 4, 0x3);
+    g_assert_cmpuint(qtest_get_irq(qts, 1), ==, 1);
+    g_assert_cmpuint(qtest_get_irq(qts, 2), ==, 1);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230/pmu/reset-values", test_reset_values);
+    qtest_add_func("/k230/pmu/write-masks", test_write_masks);
+    qtest_add_func("/k230/pmu/interrupt-clear", test_interrupt_clear);
+    qtest_add_func("/k230/pmu/pad-outputs", test_pad_outputs);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..daa5b6a284 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,8 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ?
+   ['k230-wdt-test', 'k230-pmu-test'] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.20.1


