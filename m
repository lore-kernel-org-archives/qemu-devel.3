Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC63C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvDu-0008SR-53; Wed, 03 Jul 2024 04:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sOvDj-0008Mb-3u; Wed, 03 Jul 2024 04:20:07 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sOvDV-0001YK-VT; Wed, 03 Jul 2024 04:20:06 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 9CBF6C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1719994790;
 bh=prcsTwi5I7mEiXMEbBIgQFKX18SycA5CTnU1CIbDC7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=uONaH8QNHDE2kHkJXURkWhjWF0t+OqLdjrSsJUZ5tgt5w27GSvwrHoDzCFNAPY0QH
 HKToSbod/i5ovRxDGb/t2fsPAJzP2ivkuQbkRgTLc/cJQ08xglY98kUKnvbT7RygrX
 gVzyNiNEV6kOmwqckFyQScqhdZMM9L4mBPxlPWP/DGNF9mTKEnRryLBEeZ6DBSBABa
 RbroXLIE6XCHuzMBqOn7TxpwgLF7zPpWNVMnjwlEaTCWq1pzt+cGCceKT3Igdg9afN
 FJoDQYpx36IZgZ1vvQO3m0vCeb2hPlD9uKvgMNWRbjxb6X+oCH7WACKRbWqyCyin9q
 qKZyodpbDipAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1719994790;
 bh=prcsTwi5I7mEiXMEbBIgQFKX18SycA5CTnU1CIbDC7w=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=o+bbl1I8Wbm/cwHhSU46nbawZAZKvuP7L/kasrWA465H2C3AVQ4RYZz0gQPC/od46
 owHkn5fxRqJfEN3bloRwLx032lJU5QyX1lCe22k/qUKfkSN52SZiDRy1KeNTu9mD04
 mNAJcxSeu8kTjTdtvDOF5QxIecaCS9GX6elJ2yipdUsndRC0JpF/3diKRHXIeTun5y
 Hmw8EchJgWh66oCA10zTrwmyFGGEnuilghxxtPqgvCDMkX0duIIku8fe3kvnfV+k+s
 Mmn3giiZxHYPIGqGTfXXLZSspO1okEaAtgoc4Of9uWy+HSNqFnpJDp20mXhZClAGV/
 s5IAoAC2GChFQ==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v4 2/2] tests/qtest: QTest example for RISC-V CSR register
Date: Wed, 3 Jul 2024 11:19:39 +0300
Message-ID: <20240703081939.498641-3-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703081939.498641-1-ivan.klokov@syntacore.com>
References: <20240703081939.498641-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Added demo for reading CSR register from qtest environment.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
---
 tests/qtest/meson.build      |  2 +
 tests/qtest/riscv-csr-test.c | 86 ++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tests/qtest/riscv-csr-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 12792948ff..45d651da99 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -259,6 +259,8 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
+qtests_riscv32 += ['riscv-csr-test']
+
 qos_test_ss = ss.source_set()
 qos_test_ss.add(
   'ac97-test.c',
diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
new file mode 100644
index 0000000000..e9af9ca724
--- /dev/null
+++ b/tests/qtest/riscv-csr-test.c
@@ -0,0 +1,86 @@
+/*
+ * QTest testcase for RISC-V CSRs
+ *
+ * Copyright (c) 2024 Syntacore.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "libqtest.h"
+
+static uint64_t qcsr_call(QTestState *qts, const char *name, uint64_t cpu,
+                           int csrno, uint64_t *val)
+{
+    uint64_t res = 0;
+
+    res = qtest_csr_call(qts, name, cpu, csrno, val);
+
+    return res;
+}
+
+static int qcsr_get_csr(QTestState *qts, uint64_t cpu,
+        int csrno, uint64_t *val)
+{
+    int res;
+
+    res = qcsr_call(qts, "get_csr", cpu, csrno, val);
+
+    return res;
+}
+
+static int qcsr_set_csr(QTestState *qts, uint64_t cpu,
+        int csrno, uint64_t *val)
+{
+    int res;
+
+    res = qcsr_call(qts, "set_csr", cpu, csrno, val);
+
+    return res;
+}
+
+static void run_test_csr(void)
+{
+
+    uint64_t res;
+    uint64_t val = 0;
+
+    res = qcsr_call(global_qtest, "get_csr", 0, 0xf11, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0x100);
+
+    val = 0xff;
+    res = qcsr_call(global_qtest, "set_csr", 0, 0x342, &val);
+
+    g_assert_cmpint(res, ==, 0);
+
+    val = 0;
+    res = qcsr_call(global_qtest, "get_csr", 0, 0x342, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0xff);
+
+    qtest_quit(global_qtest);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/cpu/csr", run_test_csr);
+
+    qtest_start("-machine virt -cpu any,mvendorid=0x100");
+
+    return g_test_run();
+
+}
-- 
2.34.1


