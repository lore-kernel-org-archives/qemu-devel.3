Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9AC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lfY-0001Ym-Nb; Wed, 16 Sep 2026 05:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfH-0000ry-JE; Wed, 16 Sep 2026 05:10:54 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lfF-0007sd-GT; Wed, 16 Sep 2026 05:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549562; bh=/Inds8RpC1VCwY69p2FrWRXm3JurcKDInEgFSG3Tf7U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AuzAc28viSy2nVLH4z5MTsybfGFf0uoNSEm31aAygw12Y75AQLmvi3Q7rAxMDocpq
 pjCA09UCKZhIgYRYNh2oWo6qq25LcsW3mHLI2Dc2ENu1R9YgYnhlUP4cDSP097psFb
 RH6XORnJwCad7yg3XgHtCalQGLaxPYR1Ve3xIbolqP8L6/SuzPf3qJjAQGOq9hccJe
 9X74MVoMZ0mw2aUxryt98nKdQqNSA8tJXiXbs4JffN2ca/J6XWOT1lP6wDRVQMLlX4
 k9u6SvTg90E7r4Avc7HKe9paY50QgWYFLhzT/8UQaSXibUi6dSQZ+g+BEy0QXlWAco
 jfcxWfGwCJAzg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 68D521D56EB;
 Wed, 16 Sep 2026 12:06:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 14985429E48;
 Wed, 16 Sep 2026 12:06:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id EB2AE5A7C5; Wed, 16 Sep 2026 12:06:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Guo <guobin@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 54/57] hw/intc/bcm2835_ic: reject out-of-range FIQ
 source values
Date: Wed, 16 Sep 2026 12:04:18 +0300
Message-ID: <20260916090516.677749-54-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

The FIQ_CONTROL register accepts a 7-bit source selector, but only
sources 0..71 (64 GPU + 8 ARM IRQs) exist.  Values 96..127 cause
bcm2835_ic_update() to call extract32(arm_irq_level, start, 1) with
start >= 32, which trips the assertion in bitops.h and aborts QEMU.

Reject writes that select a non-existent source and log a guest error,
so that a malicious or buggy guest cannot kill the emulator.

Add a qtest that verifies both valid and out-of-range FIQ source
selections on raspi3b.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4368
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260831081709.77725-1-guobin@linux.alibaba.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 2a8b740e7acf4bcf54f0f186d9184d764cd06f01)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 71bf671761b..262a620968f 100644
--- a/hw/intc/bcm2835_ic.c
+++ b/hw/intc/bcm2835_ic.c
@@ -139,10 +139,19 @@ static void bcm2835_ic_write(void *opaque, hwaddr offset, uint64_t val,
     BCM2835ICState *s = opaque;
 
     switch (offset) {
-    case FIQ_CONTROL:
-        s->fiq_select = extract32(val, 0, 7);
+    case FIQ_CONTROL: {
+        unsigned fiq_select = extract32(val, 0, 7);
+
+        if (fiq_select >= GPU_IRQS + ARM_IRQS) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: FIQ select %u out of range\n",
+                          __func__, fiq_select);
+            return;
+        }
+        s->fiq_select = fiq_select;
         s->fiq_enable = extract32(val, 7, 1);
         break;
+    }
     case IRQ_ENABLE_1:
         s->gpu_irq_enable |= val;
         break;
diff --git a/tests/qtest/bcm2835-ic-test.c b/tests/qtest/bcm2835-ic-test.c
new file mode 100644
index 00000000000..1e171ee0924
--- /dev/null
+++ b/tests/qtest/bcm2835-ic-test.c
@@ -0,0 +1,66 @@
+/*
+ * QTest testcase for the BCM2835 Interrupt Controller
+ *
+ * Copyright (c) 2026 Bin Guo <guobin@linux.alibaba.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#define IC_BASE     0x3f00b200
+#define FIQ_CONTROL (IC_BASE + 0x0c)
+
+static void test_fiq_select_out_of_range(void)
+{
+    uint32_t val;
+
+    /*
+     * Only FIQ sources 0..71 exist.  Source 96 used to trigger an assertion
+     * in bcm2835_ic_update() because extract32(arm_irq_level, 32, 1) was
+     * called with start >= 32.  Make sure the write is rejected and QEMU
+     * keeps running.
+     */
+    writel(FIQ_CONTROL, 0xe0); /* fiq_select = 96, fiq_enable = 1 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0);
+
+    /* The first source past the ARM IRQ range should also be rejected. */
+    writel(FIQ_CONTROL, 0xc8); /* fiq_select = 72, fiq_enable = 1 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0);
+}
+
+static void test_fiq_select_valid(void)
+{
+    uint32_t val;
+
+    /* Select the highest valid ARM IRQ source (64 + 7 = 71). */
+    writel(FIQ_CONTROL, 0xc7); /* fiq_select = 71, fiq_enable = 1 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0xc7);
+
+    /* Select the highest valid GPU IRQ source. */
+    writel(FIQ_CONTROL, 0x3f); /* fiq_select = 63, fiq_enable = 0 */
+    val = readl(FIQ_CONTROL);
+    g_assert_cmpint(val, ==, 0x3f);
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/bcm2835/bcm2835-ic/fiq-select-out-of-range",
+                   test_fiq_select_out_of_range);
+    qtest_add_func("/bcm2835/bcm2835-ic/fiq-select-valid",
+                   test_fiq_select_valid);
+
+    qtest_start("-machine raspi3b");
+    ret = g_test_run();
+    qtest_end();
+
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 12ad4c0ad6e..3dea60902b9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -259,7 +259,7 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test', 'bcm2835-ic-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
-- 
2.47.3


