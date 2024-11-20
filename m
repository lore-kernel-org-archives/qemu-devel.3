Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1274D6E2CD
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7t-00022F-4c; Wed, 20 Nov 2024 02:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tDf7p-00020N-4c; Wed, 20 Nov 2024 02:27:45 -0500
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tDf7m-000815-Cg; Wed, 20 Nov 2024 02:27:44 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 27FCFE0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1732087658;
 bh=wmeSqoVGvMzlf402PU8ZusnH/EFnjksm9+MU6IqoiHc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=Qk/ZT3B4IgbzDFSUwWBBTlZzy1mgIvc9iFwVBN9yavgpF+TDepSjmf/0iDnE/qA3H
 ajeyY3Boh+FDx5w8dBr6psOlMngVB5YuGuif2VQMr4TRaXtttz+Iu+0EIrx1xPagYJ
 bUoDQ6vRshyKVTFozkD1jfsgbcgOF5NR32fFdQGCbyLgdhUzrymwJU0/+uJf+YPcN+
 40sEJkVezS0G7Xbcp33Jo5vg4E9fdrP5dRpndv4cUF0YmwA9j3nhLz/kplShxfAj1I
 PaIuLV+NlNwslqZBwWFMFhPVJ3wH4wLRTHuo2pXnhPCSDgWXtP1YDBzr2VoDCmcHiv
 w41uwG9peDY8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1732087658;
 bh=wmeSqoVGvMzlf402PU8ZusnH/EFnjksm9+MU6IqoiHc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ucn3qoFMcIXY7uqWUvEoBLlWcNdqgEBPSJcBN5i6JYKm5PFkAZdKbfTlAidXJp1X2
 9+J+BFd9VtVxvqN7XPoomsfqmdESnW1i9caDUzS9CW1W4LLD2MrvMhYgRPrJjK1voh
 SCXPIewLfbgxjBjpgIgr6/bRVf1B2G5dW8L/ZAwda4zgLoNLn6Veqdf6F5Rs0C17Gn
 i/c2K2b7fcarbp1lwn9dg4jLv5iUXiHpas7NFc9cIjCBN+lW3uFVT/V6eppgsHz/OW
 1bpNcu0OCiLdBHfK5EFf+Qo8QSxduet6yLnETralRIgFqoj1QSATJVZSnushIdG/RD
 GCii7DAn3PrSA==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [RFC PATCH v7 2/2] tests/qtest: QTest example for RISC-V CSR register
Date: Wed, 20 Nov 2024 10:27:12 +0300
Message-ID: <20241120072712.65302-3-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120072712.65302-1-ivan.klokov@syntacore.com>
References: <20241120072712.65302-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=ivan.klokov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f2f35367ae..3aad77b3a9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -272,7 +272,7 @@ qtests_s390x = \
 qtests_riscv32 = \
   (config_all_devices.has_key('CONFIG_SIFIVE_E_AON') ? ['sifive-e-aon-watchdog-test'] : [])
 
-qtests_riscv64 = \
+qtests_riscv64 = ['riscv-csr-test'] + \
   (unpack_edk2_blobs ? ['bios-tables-test'] : [])
 
 qos_test_ss = ss.source_set()
diff --git a/tests/qtest/riscv-csr-test.c b/tests/qtest/riscv-csr-test.c
new file mode 100644
index 0000000000..ff5c29e6c6
--- /dev/null
+++ b/tests/qtest/riscv-csr-test.c
@@ -0,0 +1,56 @@
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
+#include "libqtest.h"
+
+#define CSR_MVENDORID       0xf11
+#define CSR_MISELECT        0x350
+
+static void run_test_csr(void)
+{
+    uint64_t res;
+    uint64_t val = 0;
+
+    QTestState *qts = qtest_init("-machine virt -cpu veyron-v1");
+
+    res = qtest_csr_call(qts, "get_csr", 0, CSR_MVENDORID, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0x61f);
+
+    val = 0xff;
+    res = qtest_csr_call(qts, "set_csr", 0, CSR_MISELECT, &val);
+
+    g_assert_cmpint(res, ==, 0);
+
+    val = 0;
+    res = qtest_csr_call(qts, "get_csr", 0, CSR_MISELECT, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0xff);
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/cpu/csr", run_test_csr);
+
+    return g_test_run();
+}
-- 
2.34.1


