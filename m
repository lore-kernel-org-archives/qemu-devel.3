Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2776C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xCz-000568-9X; Mon, 31 Aug 2026 04:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x0xCp-000550-S7
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:17:28 -0400
Received: from [115.124.30.124] (helo=out30-124.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x0xCl-000643-IK
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788164231; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=Vvzw+HWwQAV+FRzswR5pjOHE7KlJAQVRzyziFmgKm/k=;
 b=pelJGHHBI8/MBZRvyzuWoWihokKQihPmOCdUFIQXno6glY7WE2NgpddyKVgK1RMUQR6EbBuvTgNGwnc1P5LaeqU1A3ckdGY0kLOfN7GJpft+BhzEUDqyTBFZACAe/D97kjdnNSncboZc1Pxf5zeo36V6gH3oDWgWsoyqQhMeaxY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X9urG4y_1788164230; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X9urG4y_1788164230 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 31 Aug 2026 16:17:10 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@mailo.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH] hw/intc/bcm2835_ic: reject out-of-range FIQ source values
Date: Mon, 31 Aug 2026 16:17:09 +0800
Message-ID: <20260831081709.77725-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.124 (deferred)
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
---
 hw/intc/bcm2835_ic.c          | 13 +++++--
 tests/qtest/bcm2835-ic-test.c | 66 +++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |  2 +-
 3 files changed, 78 insertions(+), 3 deletions(-)
 create mode 100644 tests/qtest/bcm2835-ic-test.c

diff --git a/hw/intc/bcm2835_ic.c b/hw/intc/bcm2835_ic.c
index 71bf671761..262a620968 100644
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
index 0000000000..1e171ee092
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
index a13c4af989..149b395e53 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -274,7 +274,7 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test', 'xlnx-versal-trng-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test', 'bcm2835-ic-test'] : []) +  \
   (config_all_accel.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test', 'tpm-tis-i2c-swtpm-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
-- 
2.50.1 (Apple Git-155)


