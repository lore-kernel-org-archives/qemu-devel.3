Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E894C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6NQx-0005HF-7j; Tue, 15 Sep 2026 03:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6NQi-0005H4-2A
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:18:12 -0400
Received: from [115.124.30.130] (helo=out30-130.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1x6NQc-0001tP-G2
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 03:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789456667; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=jFpOEwglzwEaaMPTo726zjiUwVC0Tpwvm2mmY210qVU=;
 b=SUc4nB+U+Hajr0LWrpb5SAStaGo7V9B7NZJIEYorSYup3aghg7ye2F+w9MRHc9lB1ibm7we6UlaYwATep3ZNaWtxRjtUYYectO5vLoAJM6JlaWqqjFylacFYaR/ju7bPN3ZuIkdl6GviG1l14VPTNIBaJcdC9TuDl9QyC2egvg4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045133197;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0XB0Sdfo_1789456664; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0XB0Sdfo_1789456664 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 15 Sep 2026 15:17:44 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/net/opencores_eth: clamp MII register read to local PHY
 array
Date: Tue, 15 Sep 2026 15:17:43 +0800
Message-ID: <20260915071743.22125-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.130 (deferred)
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
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

mii_read_host() uses the guest-supplied register index directly to read
from Mii.regs[], which has only MII_REG_MAX (16) entries.  The adjacent
mii_write_host() already rejects idx >= MII_REG_MAX, but the read path
did not, so a guest writing MIIADDRESS.RGAD to 16..31 and then setting
MIICOMMAND.RSTAT caused a host-side out-of-bounds read.

Return 0xffff for out-of-range indices; this matches the value already
used for reads with FIAD != DEFAULT_PHY and is the conventional value
for unimplemented MII registers.

Add a qtest on the lx60 board that programs RGAD == 16 and triggers the
read command, verifying MIIRX_DATA reads 0xffff instead of crashing or
tripping sanitizer checks.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4364
Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 hw/net/opencores_eth.c           |  3 ++
 tests/qtest/meson.build          |  3 ++
 tests/qtest/opencores-eth-test.c | 66 ++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 tests/qtest/opencores-eth-test.c

diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 5a07bcde09..a4cf72e0c4 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -130,6 +130,9 @@ static void mii_write_host(Mii *s, unsigned idx, uint16_t v)
 
 static uint16_t mii_read_host(Mii *s, unsigned idx)
 {
+    if (idx >= MII_REG_MAX) {
+        return 0xffff;
+    }
     trace_open_eth_mii_read(idx, s->regs[idx]);
     return s->regs[idx];
 }
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c3593f7530..deb1c59c1f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -217,6 +217,9 @@ qtests_sparc64 = \
   qtests_filter + \
   ['prom-env-test', 'boot-serial-test']
 
+qtests_xtensa = \
+  (config_all_devices.has_key('CONFIG_OPENCORES_ETH') ? ['opencores-eth-test'] : [])
+
 qtests_npcm7xx = \
   ['npcm7xx_adc-test',
    'npcm7xx_gpio-test',
diff --git a/tests/qtest/opencores-eth-test.c b/tests/qtest/opencores-eth-test.c
new file mode 100644
index 0000000000..39f04fd4c3
--- /dev/null
+++ b/tests/qtest/opencores-eth-test.c
@@ -0,0 +1,66 @@
+/*
+ * QTest regression test for OpenCores Ethernet MII register read
+ *
+ * Copyright (c) 2026 Bin Guo
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/*
+ * lx60 (MMU) maps its system_io at 0xf0000000; open_eth registers live at
+ * offset 0x0d030000 inside that region.
+ */
+#define OPEN_ETH_BASE 0xfd030000
+
+/* 32-bit word register indices */
+#define OPEN_ETH_MIICOMMAND  (OPEN_ETH_BASE + 0x2c)
+#define OPEN_ETH_MIIADDRESS  (OPEN_ETH_BASE + 0x30)
+#define OPEN_ETH_MIIRX_DATA  (OPEN_ETH_BASE + 0x38)
+
+#define MIIADDRESS_FIAD      0x00000001
+#define MIIADDRESS_RGAD_SHIFT 8
+#define MIICOMMAND_RSTAT     0x00000002
+
+/*
+ * Regression test for GitLab issue #4364:
+ * MIIADDRESS.RGAD is a 5-bit field (0..31), but the local PHY register
+ * array only has 16 entries.  A read with RGAD >= 16 must not perform an
+ * out-of-bounds access.
+ */
+static void test_mii_register_out_of_range(void)
+{
+    QTestState *s;
+
+    s = qtest_init("-machine lx60");
+
+    /* Select default PHY (FIAD == 1) and first out-of-range register. */
+    qtest_writel(s, OPEN_ETH_MIIADDRESS,
+                 MIIADDRESS_FIAD | (16 << MIIADDRESS_RGAD_SHIFT));
+
+    /* Trigger MII read command. */
+    qtest_writel(s, OPEN_ETH_MIICOMMAND, MIICOMMAND_RSTAT);
+
+    /*
+     * With the bug, the read path evaluates s->regs[16] and trips ASan/UBSan.
+     * With the fix, MIIRX_DATA.PRSD should read as 0xffff (unimplemented PHY
+     * register), matching the non-default-PHY fallback in the driver.
+     */
+    g_assert_cmphex(qtest_readl(s, OPEN_ETH_MIIRX_DATA), ==, 0xffff);
+
+    qtest_quit(s);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (qtest_has_machine("lx60")) {
+        qtest_add_func("/opencores-eth/mii-register-out-of-range",
+                       test_mii_register_out_of_range);
+    }
+
+    return g_test_run();
+}
-- 
2.50.1 (Apple Git-155)


