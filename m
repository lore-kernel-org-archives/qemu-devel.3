Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD8C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 07:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whMxv-0001V2-LX; Wed, 08 Jul 2026 03:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxg-0001E2-Dg; Wed, 08 Jul 2026 03:44:55 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1whMxc-0004ox-Hj; Wed, 08 Jul 2026 03:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783496689; x=1815032689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a1HiUrie66+g1winFi/TX6rr3qR32JNggLRLVwW+dzc=;
 b=Hl2bwNbKxQbkUoJKywenchZPgbzHTvYBEzAm7vnoyejpG4fRbMmwXZtJ
 dfy7cKeQavqaSG1e/rxFeafksjauqc6G2AIaZFBeAiQzPLk1yBli+7cTJ
 FasIF/VLSAp5y6ZAjln3IrLhD3M15CqnDox7MOvFrRMyJPz+6JzFay89y
 tb//v+tFO9VG7B0b4RIWeZN3jmhAQkJ8yuS+1IS7scoD2FfS/rnlEkWMI
 eLQiJgoKsHFaY5GW/2p3Ixet4rK5GkR192MKkFDHIsk+VYkuYMQV3KUs0
 pHeC+nFjnv2ycvxgjpKTRfa0tmG+8dncX2zEvt2oaJzvDhIZR35FrflDS w==;
X-CSE-ConnectionGUID: 0N+XMIp5Tje6tDLKv5ZLXg==
X-CSE-MsgGUID: zfUrta/bRz2hkJ7hmJ2O5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84343480"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="84343480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2026 00:44:12 -0700
X-CSE-ConnectionGUID: q4Ws/thgRq65AcknsPiFWQ==
X-CSE-MsgGUID: 2alYY3AmRDmGaYRcNicr2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; d="scan'208";a="251556122"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 08 Jul 2026 00:44:07 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 26/26] tests/qtest: Add HPET test case to verify FSB store
Date: Wed,  8 Jul 2026 16:10:52 +0800
Message-Id: <20260708081052.2276617-27-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260708081052.2276617-1-zhao1.liu@intel.com>
References: <20260708081052.2276617-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add an HPET qtest case to exercise the FSB interrupt delivery path.
This verifies the memory store logic for both the C and Rust
implementations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * New commit.
---
 tests/qtest/hpet-test.c | 77 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build |  1 +
 2 files changed, 78 insertions(+)
 create mode 100644 tests/qtest/hpet-test.c

diff --git a/tests/qtest/hpet-test.c b/tests/qtest/hpet-test.c
new file mode 100644
index 000000000000..b96069e6e00f
--- /dev/null
+++ b/tests/qtest/hpet-test.c
@@ -0,0 +1,77 @@
+/*
+ * QTest testcase for the HPET
+ *
+ * Copyright (C) 2026 Intel Corporation.
+ *
+ * Authors:
+ *  Zhao Liu <zhao1.liu@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/timer.h"
+#include "hw/timer/hpet.h"
+
+#define HPET_TN_BASE_ADDR(n)    (HPET_TN_BASE + (n) * 0x20)
+#define HPET_TN_CFG_ADDR(n)     (HPET_TN_BASE_ADDR(n) + HPET_TN_CFG)
+#define HPET_TN_CMP_ADDR(n)     (HPET_TN_BASE_ADDR(n) + HPET_TN_CMP)
+#define HPET_TN_FSB_ADDR(n)     (HPET_TN_BASE_ADDR(n) + HPET_TN_ROUTE)
+
+/*
+ * Normally, the MSI should be written to the Local APIC address space.
+ * However, since the goal for current MSI testing is to verify
+ * memory store and load, use a RAM for simplicity.
+ */
+#define MSI_TARGET_ADDR         0x100000
+#define MSI_DATA                0x19680718U
+
+static void test_hpet_fsb_store(void)
+{
+    QTestState *s;
+    uint32_t got;
+    uint64_t tn_cfg;
+
+    s = qtest_init("-machine pc,hpet=on -global hpet.msi=on");
+
+    qtest_writel(s, MSI_TARGET_ADDR, 0);
+    g_assert_cmphex(qtest_readl(s, MSI_TARGET_ADDR), ==, 0);
+
+    /* Ensure HPET (timer 0) supports FSB first. */
+    tn_cfg = qtest_readq(s, HPET_BASE + HPET_TN_CFG_ADDR(0));
+    g_assert(tn_cfg & HPET_TN_FSB_CAP);
+
+    /* Configure FSB for timer 0. */
+    qtest_writeq(s, HPET_BASE + HPET_TN_FSB_ADDR(0),
+                 ((uint64_t)MSI_TARGET_ADDR << 32) | MSI_DATA);
+
+    /* Enable the timer 0's interrupt and FSB (non-periodic mode). */
+    qtest_writeq(s, HPET_BASE + HPET_TN_CFG_ADDR(0),
+                 tn_cfg | HPET_TN_ENABLE | HPET_TN_FSB_ENABLE);
+
+    /*
+     * Expire time: 0x100 = 256 ticks.
+     * Considering HPET_CLK_PERIOD, it's 2560 ns.
+     */
+    qtest_writeq(s, HPET_BASE + HPET_TN_CMP_ADDR(0), 0x100);
+
+    /* Start main counter to run - arm the timer 0. */
+    qtest_writeq(s, HPET_BASE + HPET_CFG, HPET_CFG_ENABLE);
+
+    /* Advance 10000 ns, which is enough for timer 0 to expire. */
+    qtest_clock_step(s, 10000);
+
+    /* The 32-bit data must now be in guest RAM now, little-endian. */
+    got = qtest_readl(s, MSI_TARGET_ADDR);
+    g_assert_cmphex(got, ==, MSI_DATA);
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/hpet/fsb-store", test_hpet_fsb_store);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 822e0bd28697..d47d93df316d 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -111,6 +111,7 @@ qtests_i386 = \
    config_all_devices.has_key('CONFIG_PARALLEL') ? ['bios-tables-test'] : []) +             \
   qtests_pci +                                                                              \
   qtests_cxl +                                                                              \
+  (config_all_devices.has_key('CONFIG_HPET') ? ['hpet-test'] : []) +                        \
   [
    'hd-geo-test',
    'boot-order-test',
-- 
2.34.1


