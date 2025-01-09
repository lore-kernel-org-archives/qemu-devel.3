Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9929E7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 09:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVoZg-0001y1-Pi; Thu, 09 Jan 2025 04:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tVoZR-0001q8-Vw; Thu, 09 Jan 2025 04:11:19 -0500
Received: from m.syntacore.com ([178.249.69.228] helo=pmg.syntacore.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivan.klokov@syntacore.com>)
 id 1tVoZN-0003jI-Fg; Thu, 09 Jan 2025 04:11:16 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by pmg.syntacore.com (Proxmox) with ESMTP id 6D3E9B41CDC;
 Thu,  9 Jan 2025 12:10:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=m; bh=HhEb5OGThDap061IAiGTEWz
 6cH1TOOlieuqHwg3ZsEs=; b=IdlofsHEw1ZZmN5Acln16/YupnGmMp5JRVbCW9M
 vnTb/qxiGnty/ElG17LJuci3hbhv4MBG8H9F+v/Y+qXTS4lIqf1hgTix//SOVanD
 EJO6NR5wi3EEo+AOaTJXHkgpPdkjp+bowBldLCmTeD3FLziNy/v2yFyMWXajfvPN
 DbnSxAqecroIW45FFpC/zDTKQTkCU2KOBDAHJrBXuNIYJSwFUKw8VgW7U7atOp16
 JuTlKx82d4SHB9o++8hoSK6tq0BgGWOKyLfce+3vXcd6t0ukIstVeeJVKz+BwHos
 kDq0+ZwjuB8CWq/DfLwCOpRN3zrQ8vT1xsM49ky65dFddnA==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 by pmg.syntacore.com (Proxmox) with ESMTPS id 5A7E4B41CC9;
 Thu,  9 Jan 2025 12:10:54 +0300 (MSK)
Received: from VirtualBox.corp.yadro.com (10.76.4.56) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 9 Jan 2025 12:09:33 +0300
From: Ivan Klokov <ivan.klokov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, <farosas@suse.de>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>, Ivan Klokov <ivan.klokov@syntacore.com>
Subject: [PATCH v9 2/2] tests/qtest: QTest example for RISC-V CSR register
Date: Thu, 9 Jan 2025 12:10:44 +0300
Message-ID: <20250109091044.32723-3-ivan.klokov@syntacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109091044.32723-1-ivan.klokov@syntacore.com>
References: <20250109091044.32723-1-ivan.klokov@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.76.4.56]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=ivan.klokov@syntacore.com; helo=pmg.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 tests/qtest/meson.build      |  2 +-
 tests/qtest/riscv-csr-test.c | 56 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/riscv-csr-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c5..7eb1199d91 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -273,7 +273,7 @@ qtests_s390x = \
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



