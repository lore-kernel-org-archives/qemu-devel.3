Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F00FC27C75
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhBs-0001V5-44; Thu, 13 Jun 2024 05:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sHhBp-0001TO-G5; Thu, 13 Jun 2024 05:56:17 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1sHhBn-0003AR-Jc; Thu, 13 Jun 2024 05:56:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com D1890C000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1718272573;
 bh=4PLq7nLSoYowS3FGi6aNtEJuvNHC/rt2Zb7qYwPm5FY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=zYzWvh+4d3f1wZyD4gq/nnoFD+Nh82cndz0i3xJOcdvEews6zjWvzFdBIn309i/zC
 1IH4Mq08QbRGwozFcIgDUBJFu4BuF+CjPSCCYy9lEtSCLtzloKlzdRcRepFWMLE0Zz
 HTCLv2gwwebATD4iXK4DNzBnqU3cyhLjKkVXiArQ8dDfY/RUhWWvk/cjOqyf8bs6mP
 0mLqt1oAxxxNC9TfT0E+I5yuWmJWtUJYiwPB42irMh+gX0qeYw7sYVBIWMYgYeUla+
 G3uGg8JmftIS97wk5syqHg1Q4GckL+3KUaMiS9/ff8MCGpRBHH56TTF+HM1tdMB3Dy
 1n5QQ+NYC4rLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1718272573;
 bh=4PLq7nLSoYowS3FGi6aNtEJuvNHC/rt2Zb7qYwPm5FY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=tEggZkgjqaapNj9nkWqYBOA8JoacWQYbsbFPTxY35We2LDjXv8FYSVLvmKC6v6J8n
 QKSnqOyJu6J4w/VyFHSRVDJ6im48bVm3zqS+znR+AKR11GlgYkr99aqyeIfhUOjAqb
 3oW1nlnzX962gZMSNdaG8gesPOjHUIp0hGmBKvu8OU3BQGHKobwWHC01n0tvrJH3wf
 72BlYgk9vB/6eYj1W/CYr0fjBzc6K7HbNYRJpvQsIbqikqHFVaL9ozVlHe9Kc1VEIh
 z2Wkpk69YbQAfAx8MxpvASGVJU+IM7Cqdejkrxf0CpMsu1TpwfcuGbPokD1XTwIeIZ
 Q7E5sNKhish3w==
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <bmeng.cn@gmail.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [PATCH 2/2] QTest example for RISC-V CSR register
Date: Thu, 13 Jun 2024 12:56:01 +0300
Message-ID: <20240613095601.16299-3-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613095601.16299-1-ivan.klokov@syntacore.com>
References: <20240613095601.16299-1-ivan.klokov@syntacore.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
 tests/qtest/meson.build      |  2 ++
 tests/qtest/riscv-csr-test.c | 68 ++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)
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
index 0000000000..715d5fe4b7
--- /dev/null
+++ b/tests/qtest/riscv-csr-test.c
@@ -0,0 +1,68 @@
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
+#include "qemu/error-report.h"
+
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+#include "qapi/qmp/qlist.h"
+#include "qapi/qmp/qstring.h"
+#include "qapi/qmp/qobject.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qobject-output-visitor.h"
+#include "qom/object_interfaces.h"
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "libqtest.h"
+
+#include "libqos/csr.h"
+#include "libqos/libqos.h"
+
+static void run_test_csr(void)
+{
+
+    uint64_t res;
+    uint64_t val = 0;
+
+    res = qcsr_get_csr(global_qtest, 0, 0xf11, &val);
+
+    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpint(val, ==, 0x100);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/cpu/csr", run_test_csr);
+
+    qtest_start("--nographic -machine virt -cpu any,mvendorid=0x100");
+
+    g_test_run();
+
+    qtest_quit(global_qtest);
+
+    return 0;
+
+}
-- 
2.34.1


