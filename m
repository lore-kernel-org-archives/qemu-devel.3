Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFA4C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTil-0007JX-0A; Thu, 15 May 2025 04:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTi9-0004Ca-1n; Thu, 15 May 2025 04:13:01 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uFTi3-0001PC-QT; Thu, 15 May 2025 04:13:00 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 May
 2025 16:10:18 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 May 2025 16:10:18 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 28/28] test/qtest/hace: Add tests for AST2700
Date: Thu, 15 May 2025 16:10:00 +0800
Message-ID: <20250515081008.583578-29-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
References: <20250515081008.583578-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The HACE models in AST2600 and AST2700 are nearly identical. Based on the
AST2600 test cases, new tests have been added for AST2700.

Implemented test functions for SHA-256, SHA-384, SHA-512, and MD5.
Added scatter-gather and accumulation test variants.
For AST2700, the HACE controller base address starts at "0x12070000", and
the DRAM start address is "0x4_00000000".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/ast2700-hace-test.c | 98 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build         |  2 +
 2 files changed, 100 insertions(+)
 create mode 100644 tests/qtest/ast2700-hace-test.c

diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-test.c
new file mode 100644
index 0000000000..a400e2962b
--- /dev/null
+++ b/tests/qtest/ast2700-hace-test.c
@@ -0,0 +1,98 @@
+/*
+ * QTest testcase for the ASPEED Hash and Crypto Engine
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+#include "aspeed-hace-utils.h"
+
+static const struct AspeedMasks as2700_masks = {
+    .src  = 0x7fffffff,
+    .dest = 0x7ffffff8,
+    .key = 0x7ffffff8,
+    .len  = 0x0fffffff,
+    .src_hi  = 0x00000003,
+    .dest_hi = 0x00000003,
+    .key_hi = 0x00000003,
+};
+
+/* ast2700 */
+static void test_md5_ast2700(void)
+{
+    aspeed_test_md5("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha256_ast2700(void)
+{
+    aspeed_test_sha256("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha256_sg_ast2700(void)
+{
+    aspeed_test_sha256_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha384_ast2700(void)
+{
+    aspeed_test_sha384("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha384_sg_ast2700(void)
+{
+    aspeed_test_sha384_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha512_ast2700(void)
+{
+    aspeed_test_sha512("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha512_sg_ast2700(void)
+{
+    aspeed_test_sha512_sg("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha256_accum_ast2700(void)
+{
+    aspeed_test_sha256_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha384_accum_ast2700(void)
+{
+    aspeed_test_sha384_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_sha512_accum_ast2700(void)
+{
+    aspeed_test_sha512_accum("-machine ast2700a1-evb", 0x12070000, 0x400000000);
+}
+
+static void test_addresses_ast2700(void)
+{
+    aspeed_test_addresses("-machine ast2700a1-evb", 0x12070000, &as2700_masks);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("ast2700/hace/addresses", test_addresses_ast2700);
+    qtest_add_func("ast2700/hace/sha512", test_sha512_ast2700);
+    qtest_add_func("ast2700/hace/sha384", test_sha384_ast2700);
+    qtest_add_func("ast2700/hace/sha256", test_sha256_ast2700);
+    qtest_add_func("ast2700/hace/md5", test_md5_ast2700);
+
+    qtest_add_func("ast2700/hace/sha512_sg", test_sha512_sg_ast2700);
+    qtest_add_func("ast2700/hace/sha384_sg", test_sha384_sg_ast2700);
+    qtest_add_func("ast2700/hace/sha256_sg", test_sha256_sg_ast2700);
+
+    qtest_add_func("ast2700/hace/sha512_accum", test_sha512_accum_ast2700);
+    qtest_add_func("ast2700/hace/sha384_accum", test_sha384_accum_ast2700);
+    qtest_add_func("ast2700/hace/sha256_accum", test_sha256_accum_ast2700);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index bb14a22ebe..c587688f67 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -216,6 +216,7 @@ qtests_aspeed = \
    'aspeed_smc-test']
 qtests_aspeed64 = \
   ['ast2700-gpio-test',
+   'ast2700-hace-test',
    'ast2700-smc-test']
 
 qtests_stm32l4x5 = \
@@ -362,6 +363,7 @@ endif
 qtests = {
   'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
+  'ast2700-hace-test': files('aspeed-hace-utils.c', 'ast2700-hace-test.c'),
   'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-- 
2.43.0


