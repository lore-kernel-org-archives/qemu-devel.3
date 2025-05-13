Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710D4C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 06:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEjE6-0001bJ-Lj; Tue, 13 May 2025 02:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAt-0005S2-Cb; Tue, 13 May 2025 02:31:50 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uEjAl-00026a-Rv; Tue, 13 May 2025 02:31:32 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 13 May
 2025 14:29:07 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 13 May 2025 14:29:07 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 15/25] test/qtest: Introduce a new aspeed-hace-utils.c to
 place common testcases
Date: Tue, 13 May 2025 14:28:45 +0800
Message-ID: <20250513062901.2256865-16-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
References: <20250513062901.2256865-1-jamin_lin@aspeedtech.com>
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

The test cases for the ASPEED HACE model were originally placed in
aspeed_hace-test.c. However, this test file only supports ARM32. To enable
compatibility with all ASPEED SoCs, including the AST2700, which uses the
AArch64 architecture, this update introduces a new source file,
aspeed-hace-utils.c.

All common APIs and test cases have been moved from aspeed_hace-test.c to
aspeed-hace-utils.c to facilitate reuse across different ASPEED SoCs.
As a result, these test cases can now be reused for AST2700 and future ASPEED
SoC testing.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-hace-utils.h |  71 +++++
 tests/qtest/aspeed-hace-utils.c | 455 ++++++++++++++++++++++++++++
 tests/qtest/aspeed_hace-test.c  | 515 ++------------------------------
 tests/qtest/meson.build         |   1 +
 4 files changed, 547 insertions(+), 495 deletions(-)
 create mode 100644 tests/qtest/aspeed-hace-utils.h
 create mode 100644 tests/qtest/aspeed-hace-utils.c

diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-utils.h
new file mode 100644
index 0000000000..598577c69b
--- /dev/null
+++ b/tests/qtest/aspeed-hace-utils.h
@@ -0,0 +1,71 @@
+/*
+ * QTest testcase for the ASPEED Hash and Crypto Engine
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright 2021 IBM Corp.
+ */
+
+#ifndef TESTS_ASPEED_HACE_UTILS_H
+#define TESTS_ASPEED_HACE_UTILS_H
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+
+#define HACE_CMD                 0x10
+#define  HACE_SHA_BE_EN          BIT(3)
+#define  HACE_MD5_LE_EN          BIT(2)
+#define  HACE_ALGO_MD5           0
+#define  HACE_ALGO_SHA1          BIT(5)
+#define  HACE_ALGO_SHA224        BIT(6)
+#define  HACE_ALGO_SHA256        (BIT(4) | BIT(6))
+#define  HACE_ALGO_SHA512        (BIT(5) | BIT(6))
+#define  HACE_ALGO_SHA384        (BIT(5) | BIT(6) | BIT(10))
+#define  HACE_SG_EN              BIT(18)
+#define  HACE_ACCUM_EN           BIT(8)
+
+#define HACE_STS                 0x1c
+#define  HACE_RSA_ISR            BIT(13)
+#define  HACE_CRYPTO_ISR         BIT(12)
+#define  HACE_HASH_ISR           BIT(9)
+#define  HACE_RSA_BUSY           BIT(2)
+#define  HACE_CRYPTO_BUSY        BIT(1)
+#define  HACE_HASH_BUSY          BIT(0)
+#define HACE_HASH_SRC            0x20
+#define HACE_HASH_DIGEST         0x24
+#define HACE_HASH_KEY_BUFF       0x28
+#define HACE_HASH_DATA_LEN       0x2c
+#define HACE_HASH_CMD            0x30
+
+/* Scatter-Gather Hash */
+#define SG_LIST_LEN_LAST         BIT(31)
+struct AspeedSgList {
+        uint32_t len;
+        uint32_t addr;
+} __attribute__ ((__packed__));
+
+struct AspeedMasks {
+    uint32_t src;
+    uint32_t dest;
+    uint32_t len;
+};
+
+void aspeed_test_md5(const char *machine, const uint32_t base,
+                     const uint32_t src_addr);
+void aspeed_test_sha256(const char *machine, const uint32_t base,
+                        const uint32_t src_addr);
+void aspeed_test_sha512(const char *machine, const uint32_t base,
+                        const uint32_t src_addr);
+void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
+                           const uint32_t src_addr);
+void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
+                           const uint32_t src_addr);
+void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
+                              const uint32_t src_addr);
+void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
+                              const uint32_t src_addr);
+void aspeed_test_addresses(const char *machine, const uint32_t base,
+                           const struct AspeedMasks *expected);
+
+#endif /* TESTS_ASPEED_HACE_UTILS_H */
+
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-utils.c
new file mode 100644
index 0000000000..8582847945
--- /dev/null
+++ b/tests/qtest/aspeed-hace-utils.c
@@ -0,0 +1,455 @@
+/*
+ * QTest testcase for the ASPEED Hash and Crypto Engine
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright 2021 IBM Corp.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qemu/bitops.h"
+#include "aspeed-hace-utils.h"
+
+/*
+ * Test vector is the ascii "abc"
+ *
+ * Expected results were generated using command line utitiles:
+ *
+ *  echo -n -e 'abc' | dd of=/tmp/test
+ *  for hash in sha512sum sha256sum md5sum; do $hash /tmp/test; done
+ *
+ */
+static const uint8_t test_vector[] = {0x61, 0x62, 0x63};
+
+static const uint8_t test_result_sha512[] = {
+    0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba, 0xcc, 0x41, 0x73, 0x49,
+    0xae, 0x20, 0x41, 0x31, 0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
+    0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a, 0x21, 0x92, 0x99, 0x2a,
+    0x27, 0x4f, 0xc1, 0xa8, 0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
+    0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a, 0xc9, 0x4f,
+    0xa5, 0x4c, 0xa4, 0x9f};
+
+static const uint8_t test_result_sha256[] = {
+    0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41, 0x40, 0xde,
+    0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
+    0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad};
+
+static const uint8_t test_result_md5[] = {
+    0x90, 0x01, 0x50, 0x98, 0x3c, 0xd2, 0x4f, 0xb0, 0xd6, 0x96, 0x3f, 0x7d,
+    0x28, 0xe1, 0x7f, 0x72};
+
+/*
+ * The Scatter-Gather Test vector is the ascii "abc" "def" "ghi", broken
+ * into blocks of 3 characters as shown
+ *
+ * Expected results were generated using command line utitiles:
+ *
+ *  echo -n -e 'abcdefghijkl' | dd of=/tmp/test
+ *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
+ *
+ */
+static const uint8_t test_vector_sg1[] = {0x61, 0x62, 0x63, 0x64, 0x65, 0x66};
+static const uint8_t test_vector_sg2[] = {0x67, 0x68, 0x69};
+static const uint8_t test_vector_sg3[] = {0x6a, 0x6b, 0x6c};
+
+static const uint8_t test_result_sg_sha512[] = {
+    0x17, 0x80, 0x7c, 0x72, 0x8e, 0xe3, 0xba, 0x35, 0xe7, 0xcf, 0x7a, 0xf8,
+    0x23, 0x11, 0x6d, 0x26, 0xe4, 0x1e, 0x5d, 0x4d, 0x6c, 0x2f, 0xf1, 0xf3,
+    0x72, 0x0d, 0x3d, 0x96, 0xaa, 0xcb, 0x6f, 0x69, 0xde, 0x64, 0x2e, 0x63,
+    0xd5, 0xb7, 0x3f, 0xc3, 0x96, 0xc1, 0x2b, 0xe3, 0x8b, 0x2b, 0xd5, 0xd8,
+    0x84, 0x25, 0x7c, 0x32, 0xc8, 0xf6, 0xd0, 0x85, 0x4a, 0xe6, 0xb5, 0x40,
+    0xf8, 0x6d, 0xda, 0x2e};
+
+static const uint8_t test_result_sg_sha256[] = {
+    0xd6, 0x82, 0xed, 0x4c, 0xa4, 0xd9, 0x89, 0xc1, 0x34, 0xec, 0x94, 0xf1,
+    0x55, 0x1e, 0x1e, 0xc5, 0x80, 0xdd, 0x6d, 0x5a, 0x6e, 0xcd, 0xe9, 0xf3,
+    0xd3, 0x5e, 0x6e, 0x4a, 0x71, 0x7f, 0xbd, 0xe4};
+
+/*
+ * The accumulative mode requires firmware to provide internal initial state
+ * and message padding (including length L at the end of padding).
+ *
+ * This test vector is a ascii text "abc" with padding message.
+ *
+ * Expected results were generated using command line utitiles:
+ *
+ *  echo -n -e 'abc' | dd of=/tmp/test
+ *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
+ */
+static const uint8_t test_vector_accum_512[] = {
+    0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
+
+static const uint8_t test_vector_accum_256[] = {
+    0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
+
+static const uint8_t test_result_accum_sha512[] = {
+    0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba, 0xcc, 0x41, 0x73, 0x49,
+    0xae, 0x20, 0x41, 0x31, 0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
+    0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a, 0x21, 0x92, 0x99, 0x2a,
+    0x27, 0x4f, 0xc1, 0xa8, 0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
+    0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a, 0xc9, 0x4f,
+    0xa5, 0x4c, 0xa4, 0x9f};
+
+static const uint8_t test_result_accum_sha256[] = {
+    0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41, 0x40, 0xde,
+    0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
+    0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad};
+
+static void write_regs(QTestState *s, uint32_t base, uint32_t src,
+                       uint32_t length, uint32_t out, uint32_t method)
+{
+        qtest_writel(s, base + HACE_HASH_SRC, src);
+        qtest_writel(s, base + HACE_HASH_DIGEST, out);
+        qtest_writel(s, base + HACE_HASH_DATA_LEN, length);
+        qtest_writel(s, base + HACE_HASH_CMD, HACE_SHA_BE_EN | method);
+}
+
+void aspeed_test_md5(const char *machine, const uint32_t base,
+                     const uint32_t src_addr)
+
+{
+    QTestState *s = qtest_init(machine);
+
+    uint32_t digest_addr = src_addr + 0x01000000;
+    uint8_t digest[16] = {0};
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
+
+    write_regs(s, base, src_addr, sizeof(test_vector),
+               digest_addr, HACE_ALGO_MD5);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_md5, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_sha256(const char *machine, const uint32_t base,
+                        const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t digest_addr = src_addr + 0x1000000;
+    uint8_t digest[32] = {0};
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
+
+    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr,
+               HACE_ALGO_SHA256);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_sha256, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_sha512(const char *machine, const uint32_t base,
+                        const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t digest_addr = src_addr + 0x1000000;
+    uint8_t digest[64] = {0};
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
+
+    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr,
+               HACE_ALGO_SHA512);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_sha512, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_sha256_sg(const char *machine, const uint32_t base,
+                           const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t src_addr_1 = src_addr + 0x1000000;
+    const uint32_t src_addr_2 = src_addr + 0x2000000;
+    const uint32_t src_addr_3 = src_addr + 0x3000000;
+    const uint32_t digest_addr = src_addr + 0x4000000;
+    uint8_t digest[32] = {0};
+    struct AspeedSgList array[] = {
+        {  cpu_to_le32(sizeof(test_vector_sg1)),
+           cpu_to_le32(src_addr_1) },
+        {  cpu_to_le32(sizeof(test_vector_sg2)),
+           cpu_to_le32(src_addr_2) },
+        {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
+           cpu_to_le32(src_addr_3) },
+    };
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr_1, test_vector_sg1, sizeof(test_vector_sg1));
+    qtest_memwrite(s, src_addr_2, test_vector_sg2, sizeof(test_vector_sg2));
+    qtest_memwrite(s, src_addr_3, test_vector_sg3, sizeof(test_vector_sg3));
+    qtest_memwrite(s, src_addr, array, sizeof(array));
+
+    write_regs(s, base, src_addr,
+               (sizeof(test_vector_sg1)
+                + sizeof(test_vector_sg2)
+                + sizeof(test_vector_sg3)),
+               digest_addr, HACE_ALGO_SHA256 | HACE_SG_EN);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_sg_sha256, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_sha512_sg(const char *machine, const uint32_t base,
+                           const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t src_addr_1 = src_addr + 0x1000000;
+    const uint32_t src_addr_2 = src_addr + 0x2000000;
+    const uint32_t src_addr_3 = src_addr + 0x3000000;
+    const uint32_t digest_addr = src_addr + 0x4000000;
+    uint8_t digest[64] = {0};
+    struct AspeedSgList array[] = {
+        {  cpu_to_le32(sizeof(test_vector_sg1)),
+           cpu_to_le32(src_addr_1) },
+        {  cpu_to_le32(sizeof(test_vector_sg2)),
+           cpu_to_le32(src_addr_2) },
+        {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
+           cpu_to_le32(src_addr_3) },
+    };
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, src_addr_1, test_vector_sg1, sizeof(test_vector_sg1));
+    qtest_memwrite(s, src_addr_2, test_vector_sg2, sizeof(test_vector_sg2));
+    qtest_memwrite(s, src_addr_3, test_vector_sg3, sizeof(test_vector_sg3));
+    qtest_memwrite(s, src_addr, array, sizeof(array));
+
+    write_regs(s, base, src_addr,
+               (sizeof(test_vector_sg1)
+                + sizeof(test_vector_sg2)
+                + sizeof(test_vector_sg3)),
+               digest_addr, HACE_ALGO_SHA512 | HACE_SG_EN);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_sg_sha512, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_sha256_accum(const char *machine, const uint32_t base,
+                              const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t buffer_addr = src_addr + 0x1000000;
+    const uint32_t digest_addr = src_addr + 0x4000000;
+    uint8_t digest[32] = {0};
+    struct AspeedSgList array[] = {
+        {  cpu_to_le32(sizeof(test_vector_accum_256) | SG_LIST_LEN_LAST),
+           cpu_to_le32(buffer_addr) },
+    };
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, buffer_addr, test_vector_accum_256,
+                   sizeof(test_vector_accum_256));
+    qtest_memwrite(s, src_addr, array, sizeof(array));
+
+    write_regs(s, base, src_addr, sizeof(test_vector_accum_256),
+               digest_addr, HACE_ALGO_SHA256 | HACE_SG_EN | HACE_ACCUM_EN);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_accum_sha256, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_sha512_accum(const char *machine, const uint32_t base,
+                              const uint32_t src_addr)
+{
+    QTestState *s = qtest_init(machine);
+
+    const uint32_t buffer_addr = src_addr + 0x1000000;
+    const uint32_t digest_addr = src_addr + 0x4000000;
+    uint8_t digest[64] = {0};
+    struct AspeedSgList array[] = {
+        {  cpu_to_le32(sizeof(test_vector_accum_512) | SG_LIST_LEN_LAST),
+           cpu_to_le32(buffer_addr) },
+    };
+
+    /* Check engine is idle, no busy or irq bits set */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Write test vector into memory */
+    qtest_memwrite(s, buffer_addr, test_vector_accum_512,
+                   sizeof(test_vector_accum_512));
+    qtest_memwrite(s, src_addr, array, sizeof(array));
+
+    write_regs(s, base, src_addr, sizeof(test_vector_accum_512),
+               digest_addr, HACE_ALGO_SHA512 | HACE_SG_EN | HACE_ACCUM_EN);
+
+    /* Check hash IRQ status is asserted */
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
+
+    /* Clear IRQ status and check status is deasserted */
+    qtest_writel(s, base + HACE_STS, 0x00000200);
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
+
+    /* Read computed digest from memory */
+    qtest_memread(s, digest_addr, digest, sizeof(digest));
+
+    /* Check result of computation */
+    g_assert_cmpmem(digest, sizeof(digest),
+                    test_result_accum_sha512, sizeof(digest));
+
+    qtest_quit(s);
+}
+
+void aspeed_test_addresses(const char *machine, const uint32_t base,
+                           const struct AspeedMasks *expected)
+{
+    QTestState *s = qtest_init(machine);
+
+    /*
+     * Check command mode is zero, meaning engine is in direct access mode,
+     * as this affects the masking behavior of the HASH_SRC register.
+     */
+    g_assert_cmphex(qtest_readl(s, base + HACE_CMD), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
+
+
+    /* Check that the address masking is correct */
+    qtest_writel(s, base + HACE_HASH_SRC, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, expected->src);
+
+    qtest_writel(s, base + HACE_HASH_DIGEST, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==,
+                    expected->dest);
+
+    qtest_writel(s, base + HACE_HASH_DATA_LEN, 0xffffffff);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==,
+                    expected->len);
+
+    /* Reset to zero */
+    qtest_writel(s, base + HACE_HASH_SRC, 0);
+    qtest_writel(s, base + HACE_HASH_DIGEST, 0);
+    qtest_writel(s, base + HACE_HASH_DATA_LEN, 0);
+
+    /* Check that all bits are now zero */
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
+    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
+
+    qtest_quit(s);
+}
+
diff --git a/tests/qtest/aspeed_hace-test.c b/tests/qtest/aspeed_hace-test.c
index ce86a44672..42a306af2a 100644
--- a/tests/qtest/aspeed_hace-test.c
+++ b/tests/qtest/aspeed_hace-test.c
@@ -6,584 +6,109 @@
  */
 
 #include "qemu/osdep.h"
-
 #include "libqtest.h"
 #include "qemu/bitops.h"
+#include "aspeed-hace-utils.h"
 
-#define HACE_CMD                 0x10
-#define  HACE_SHA_BE_EN          BIT(3)
-#define  HACE_MD5_LE_EN          BIT(2)
-#define  HACE_ALGO_MD5           0
-#define  HACE_ALGO_SHA1          BIT(5)
-#define  HACE_ALGO_SHA224        BIT(6)
-#define  HACE_ALGO_SHA256        (BIT(4) | BIT(6))
-#define  HACE_ALGO_SHA512        (BIT(5) | BIT(6))
-#define  HACE_ALGO_SHA384        (BIT(5) | BIT(6) | BIT(10))
-#define  HACE_SG_EN              BIT(18)
-#define  HACE_ACCUM_EN           BIT(8)
-
-#define HACE_STS                 0x1c
-#define  HACE_RSA_ISR            BIT(13)
-#define  HACE_CRYPTO_ISR         BIT(12)
-#define  HACE_HASH_ISR           BIT(9)
-#define  HACE_RSA_BUSY           BIT(2)
-#define  HACE_CRYPTO_BUSY        BIT(1)
-#define  HACE_HASH_BUSY          BIT(0)
-#define HACE_HASH_SRC            0x20
-#define HACE_HASH_DIGEST         0x24
-#define HACE_HASH_KEY_BUFF       0x28
-#define HACE_HASH_DATA_LEN       0x2c
-#define HACE_HASH_CMD            0x30
-/* Scatter-Gather Hash */
-#define SG_LIST_LEN_LAST         BIT(31)
-struct AspeedSgList {
-        uint32_t len;
-        uint32_t addr;
-} __attribute__ ((__packed__));
-
-/*
- * Test vector is the ascii "abc"
- *
- * Expected results were generated using command line utitiles:
- *
- *  echo -n -e 'abc' | dd of=/tmp/test
- *  for hash in sha512sum sha256sum md5sum; do $hash /tmp/test; done
- *
- */
-static const uint8_t test_vector[] = {0x61, 0x62, 0x63};
-
-static const uint8_t test_result_sha512[] = {
-    0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba, 0xcc, 0x41, 0x73, 0x49,
-    0xae, 0x20, 0x41, 0x31, 0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
-    0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a, 0x21, 0x92, 0x99, 0x2a,
-    0x27, 0x4f, 0xc1, 0xa8, 0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
-    0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a, 0xc9, 0x4f,
-    0xa5, 0x4c, 0xa4, 0x9f};
-
-static const uint8_t test_result_sha256[] = {
-    0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41, 0x40, 0xde,
-    0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
-    0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad};
-
-static const uint8_t test_result_md5[] = {
-    0x90, 0x01, 0x50, 0x98, 0x3c, 0xd2, 0x4f, 0xb0, 0xd6, 0x96, 0x3f, 0x7d,
-    0x28, 0xe1, 0x7f, 0x72};
-
-/*
- * The Scatter-Gather Test vector is the ascii "abc" "def" "ghi", broken
- * into blocks of 3 characters as shown
- *
- * Expected results were generated using command line utitiles:
- *
- *  echo -n -e 'abcdefghijkl' | dd of=/tmp/test
- *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
- *
- */
-static const uint8_t test_vector_sg1[] = {0x61, 0x62, 0x63, 0x64, 0x65, 0x66};
-static const uint8_t test_vector_sg2[] = {0x67, 0x68, 0x69};
-static const uint8_t test_vector_sg3[] = {0x6a, 0x6b, 0x6c};
-
-static const uint8_t test_result_sg_sha512[] = {
-    0x17, 0x80, 0x7c, 0x72, 0x8e, 0xe3, 0xba, 0x35, 0xe7, 0xcf, 0x7a, 0xf8,
-    0x23, 0x11, 0x6d, 0x26, 0xe4, 0x1e, 0x5d, 0x4d, 0x6c, 0x2f, 0xf1, 0xf3,
-    0x72, 0x0d, 0x3d, 0x96, 0xaa, 0xcb, 0x6f, 0x69, 0xde, 0x64, 0x2e, 0x63,
-    0xd5, 0xb7, 0x3f, 0xc3, 0x96, 0xc1, 0x2b, 0xe3, 0x8b, 0x2b, 0xd5, 0xd8,
-    0x84, 0x25, 0x7c, 0x32, 0xc8, 0xf6, 0xd0, 0x85, 0x4a, 0xe6, 0xb5, 0x40,
-    0xf8, 0x6d, 0xda, 0x2e};
-
-static const uint8_t test_result_sg_sha256[] = {
-    0xd6, 0x82, 0xed, 0x4c, 0xa4, 0xd9, 0x89, 0xc1, 0x34, 0xec, 0x94, 0xf1,
-    0x55, 0x1e, 0x1e, 0xc5, 0x80, 0xdd, 0x6d, 0x5a, 0x6e, 0xcd, 0xe9, 0xf3,
-    0xd3, 0x5e, 0x6e, 0x4a, 0x71, 0x7f, 0xbd, 0xe4};
-
-/*
- * The accumulative mode requires firmware to provide internal initial state
- * and message padding (including length L at the end of padding).
- *
- * This test vector is a ascii text "abc" with padding message.
- *
- * Expected results were generated using command line utitiles:
- *
- *  echo -n -e 'abc' | dd of=/tmp/test
- *  for hash in sha512sum sha256sum; do $hash /tmp/test; done
- */
-static const uint8_t test_vector_accum_512[] = {
-    0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
-
-static const uint8_t test_vector_accum_256[] = {
-    0x61, 0x62, 0x63, 0x80, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18};
-
-static const uint8_t test_result_accum_sha512[] = {
-    0xdd, 0xaf, 0x35, 0xa1, 0x93, 0x61, 0x7a, 0xba, 0xcc, 0x41, 0x73, 0x49,
-    0xae, 0x20, 0x41, 0x31, 0x12, 0xe6, 0xfa, 0x4e, 0x89, 0xa9, 0x7e, 0xa2,
-    0x0a, 0x9e, 0xee, 0xe6, 0x4b, 0x55, 0xd3, 0x9a, 0x21, 0x92, 0x99, 0x2a,
-    0x27, 0x4f, 0xc1, 0xa8, 0x36, 0xba, 0x3c, 0x23, 0xa3, 0xfe, 0xeb, 0xbd,
-    0x45, 0x4d, 0x44, 0x23, 0x64, 0x3c, 0xe8, 0x0e, 0x2a, 0x9a, 0xc9, 0x4f,
-    0xa5, 0x4c, 0xa4, 0x9f};
-
-static const uint8_t test_result_accum_sha256[] = {
-    0xba, 0x78, 0x16, 0xbf, 0x8f, 0x01, 0xcf, 0xea, 0x41, 0x41, 0x40, 0xde,
-    0x5d, 0xae, 0x22, 0x23, 0xb0, 0x03, 0x61, 0xa3, 0x96, 0x17, 0x7a, 0x9c,
-    0xb4, 0x10, 0xff, 0x61, 0xf2, 0x00, 0x15, 0xad};
-
-static void write_regs(QTestState *s, uint32_t base, uint32_t src,
-                       uint32_t length, uint32_t out, uint32_t method)
-{
-        qtest_writel(s, base + HACE_HASH_SRC, src);
-        qtest_writel(s, base + HACE_HASH_DIGEST, out);
-        qtest_writel(s, base + HACE_HASH_DATA_LEN, length);
-        qtest_writel(s, base + HACE_HASH_CMD, HACE_SHA_BE_EN | method);
-}
-
-static void test_md5(const char *machine, const uint32_t base,
-                     const uint32_t src_addr)
-
-{
-    QTestState *s = qtest_init(machine);
-
-    uint32_t digest_addr = src_addr + 0x01000000;
-    uint8_t digest[16] = {0};
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
-
-    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr, HACE_ALGO_MD5);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_md5, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-static void test_sha256(const char *machine, const uint32_t base,
-                        const uint32_t src_addr)
-{
-    QTestState *s = qtest_init(machine);
-
-    const uint32_t digest_addr = src_addr + 0x1000000;
-    uint8_t digest[32] = {0};
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
-
-    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr, HACE_ALGO_SHA256);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_sha256, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-static void test_sha512(const char *machine, const uint32_t base,
-                        const uint32_t src_addr)
-{
-    QTestState *s = qtest_init(machine);
-
-    const uint32_t digest_addr = src_addr + 0x1000000;
-    uint8_t digest[64] = {0};
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, src_addr, test_vector, sizeof(test_vector));
-
-    write_regs(s, base, src_addr, sizeof(test_vector), digest_addr, HACE_ALGO_SHA512);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_sha512, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-static void test_sha256_sg(const char *machine, const uint32_t base,
-                        const uint32_t src_addr)
-{
-    QTestState *s = qtest_init(machine);
-
-    const uint32_t src_addr_1 = src_addr + 0x1000000;
-    const uint32_t src_addr_2 = src_addr + 0x2000000;
-    const uint32_t src_addr_3 = src_addr + 0x3000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
-    uint8_t digest[32] = {0};
-    struct AspeedSgList array[] = {
-        {  cpu_to_le32(sizeof(test_vector_sg1)),
-           cpu_to_le32(src_addr_1) },
-        {  cpu_to_le32(sizeof(test_vector_sg2)),
-           cpu_to_le32(src_addr_2) },
-        {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
-           cpu_to_le32(src_addr_3) },
-    };
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, src_addr_1, test_vector_sg1, sizeof(test_vector_sg1));
-    qtest_memwrite(s, src_addr_2, test_vector_sg2, sizeof(test_vector_sg2));
-    qtest_memwrite(s, src_addr_3, test_vector_sg3, sizeof(test_vector_sg3));
-    qtest_memwrite(s, src_addr, array, sizeof(array));
-
-    write_regs(s, base, src_addr,
-               (sizeof(test_vector_sg1)
-                + sizeof(test_vector_sg2)
-                + sizeof(test_vector_sg3)),
-               digest_addr, HACE_ALGO_SHA256 | HACE_SG_EN);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_sg_sha256, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-static void test_sha512_sg(const char *machine, const uint32_t base,
-                        const uint32_t src_addr)
-{
-    QTestState *s = qtest_init(machine);
-
-    const uint32_t src_addr_1 = src_addr + 0x1000000;
-    const uint32_t src_addr_2 = src_addr + 0x2000000;
-    const uint32_t src_addr_3 = src_addr + 0x3000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
-    uint8_t digest[64] = {0};
-    struct AspeedSgList array[] = {
-        {  cpu_to_le32(sizeof(test_vector_sg1)),
-           cpu_to_le32(src_addr_1) },
-        {  cpu_to_le32(sizeof(test_vector_sg2)),
-           cpu_to_le32(src_addr_2) },
-        {  cpu_to_le32(sizeof(test_vector_sg3) | SG_LIST_LEN_LAST),
-           cpu_to_le32(src_addr_3) },
-    };
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, src_addr_1, test_vector_sg1, sizeof(test_vector_sg1));
-    qtest_memwrite(s, src_addr_2, test_vector_sg2, sizeof(test_vector_sg2));
-    qtest_memwrite(s, src_addr_3, test_vector_sg3, sizeof(test_vector_sg3));
-    qtest_memwrite(s, src_addr, array, sizeof(array));
-
-    write_regs(s, base, src_addr,
-               (sizeof(test_vector_sg1)
-                + sizeof(test_vector_sg2)
-                + sizeof(test_vector_sg3)),
-               digest_addr, HACE_ALGO_SHA512 | HACE_SG_EN);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_sg_sha512, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-static void test_sha256_accum(const char *machine, const uint32_t base,
-                        const uint32_t src_addr)
-{
-    QTestState *s = qtest_init(machine);
-
-    const uint32_t buffer_addr = src_addr + 0x1000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
-    uint8_t digest[32] = {0};
-    struct AspeedSgList array[] = {
-        {  cpu_to_le32(sizeof(test_vector_accum_256) | SG_LIST_LEN_LAST),
-           cpu_to_le32(buffer_addr) },
-    };
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, buffer_addr, test_vector_accum_256,
-                   sizeof(test_vector_accum_256));
-    qtest_memwrite(s, src_addr, array, sizeof(array));
-
-    write_regs(s, base, src_addr, sizeof(test_vector_accum_256),
-               digest_addr, HACE_ALGO_SHA256 | HACE_SG_EN | HACE_ACCUM_EN);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_accum_sha256, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-static void test_sha512_accum(const char *machine, const uint32_t base,
-                        const uint32_t src_addr)
-{
-    QTestState *s = qtest_init(machine);
-
-    const uint32_t buffer_addr = src_addr + 0x1000000;
-    const uint32_t digest_addr = src_addr + 0x4000000;
-    uint8_t digest[64] = {0};
-    struct AspeedSgList array[] = {
-        {  cpu_to_le32(sizeof(test_vector_accum_512) | SG_LIST_LEN_LAST),
-           cpu_to_le32(buffer_addr) },
-    };
-
-    /* Check engine is idle, no busy or irq bits set */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Write test vector into memory */
-    qtest_memwrite(s, buffer_addr, test_vector_accum_512,
-                   sizeof(test_vector_accum_512));
-    qtest_memwrite(s, src_addr, array, sizeof(array));
-
-    write_regs(s, base, src_addr, sizeof(test_vector_accum_512),
-               digest_addr, HACE_ALGO_SHA512 | HACE_SG_EN | HACE_ACCUM_EN);
-
-    /* Check hash IRQ status is asserted */
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0x00000200);
-
-    /* Clear IRQ status and check status is deasserted */
-    qtest_writel(s, base + HACE_STS, 0x00000200);
-    g_assert_cmphex(qtest_readl(s, base + HACE_STS), ==, 0);
-
-    /* Read computed digest from memory */
-    qtest_memread(s, digest_addr, digest, sizeof(digest));
-
-    /* Check result of computation */
-    g_assert_cmpmem(digest, sizeof(digest),
-                    test_result_accum_sha512, sizeof(digest));
-
-    qtest_quit(s);
-}
-
-struct masks {
-    uint32_t src;
-    uint32_t dest;
-    uint32_t len;
-};
-
-static const struct masks ast2600_masks = {
+static const struct AspeedMasks ast2600_masks = {
     .src  = 0x7fffffff,
     .dest = 0x7ffffff8,
     .len  = 0x0fffffff,
 };
 
-static const struct masks ast2500_masks = {
+static const struct AspeedMasks ast2500_masks = {
     .src  = 0x3fffffff,
     .dest = 0x3ffffff8,
     .len  = 0x0fffffff,
 };
 
-static const struct masks ast2400_masks = {
+static const struct AspeedMasks ast2400_masks = {
     .src  = 0x0fffffff,
     .dest = 0x0ffffff8,
     .len  = 0x0fffffff,
 };
 
-static void test_addresses(const char *machine, const uint32_t base,
-                           const struct masks *expected)
-{
-    QTestState *s = qtest_init(machine);
-
-    /*
-     * Check command mode is zero, meaning engine is in direct access mode,
-     * as this affects the masking behavior of the HASH_SRC register.
-     */
-    g_assert_cmphex(qtest_readl(s, base + HACE_CMD), ==, 0);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, 0);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
-
-
-    /* Check that the address masking is correct */
-    qtest_writel(s, base + HACE_HASH_SRC, 0xffffffff);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, expected->src);
-
-    qtest_writel(s, base + HACE_HASH_DIGEST, 0xffffffff);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, expected->dest);
-
-    qtest_writel(s, base + HACE_HASH_DATA_LEN, 0xffffffff);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, expected->len);
-
-    /* Reset to zero */
-    qtest_writel(s, base + HACE_HASH_SRC, 0);
-    qtest_writel(s, base + HACE_HASH_DIGEST, 0);
-    qtest_writel(s, base + HACE_HASH_DATA_LEN, 0);
-
-    /* Check that all bits are now zero */
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_SRC), ==, 0);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DIGEST), ==, 0);
-    g_assert_cmphex(qtest_readl(s, base + HACE_HASH_DATA_LEN), ==, 0);
-
-    qtest_quit(s);
-}
-
 /* ast2600 */
 static void test_md5_ast2600(void)
 {
-    test_md5("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_md5("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_sha256_ast2600(void)
 {
-    test_sha256("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_sha256("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_sha256_sg_ast2600(void)
 {
-    test_sha256_sg("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_sha256_sg("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_sha512_ast2600(void)
 {
-    test_sha512("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_sha512("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_sha512_sg_ast2600(void)
 {
-    test_sha512_sg("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_sha512_sg("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_sha256_accum_ast2600(void)
 {
-    test_sha256_accum("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_sha256_accum("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_sha512_accum_ast2600(void)
 {
-    test_sha512_accum("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
+    aspeed_test_sha512_accum("-machine ast2600-evb", 0x1e6d0000, 0x80000000);
 }
 
 static void test_addresses_ast2600(void)
 {
-    test_addresses("-machine ast2600-evb", 0x1e6d0000, &ast2600_masks);
+    aspeed_test_addresses("-machine ast2600-evb", 0x1e6d0000, &ast2600_masks);
 }
 
 /* ast2500 */
 static void test_md5_ast2500(void)
 {
-    test_md5("-machine ast2500-evb", 0x1e6e3000, 0x80000000);
+    aspeed_test_md5("-machine ast2500-evb", 0x1e6e3000, 0x80000000);
 }
 
 static void test_sha256_ast2500(void)
 {
-    test_sha256("-machine ast2500-evb", 0x1e6e3000, 0x80000000);
+    aspeed_test_sha256("-machine ast2500-evb", 0x1e6e3000, 0x80000000);
 }
 
 static void test_sha512_ast2500(void)
 {
-    test_sha512("-machine ast2500-evb", 0x1e6e3000, 0x80000000);
+    aspeed_test_sha512("-machine ast2500-evb", 0x1e6e3000, 0x80000000);
 }
 
 static void test_addresses_ast2500(void)
 {
-    test_addresses("-machine ast2500-evb", 0x1e6e3000, &ast2500_masks);
+    aspeed_test_addresses("-machine ast2500-evb", 0x1e6e3000, &ast2500_masks);
 }
 
 /* ast2400 */
 static void test_md5_ast2400(void)
 {
-    test_md5("-machine palmetto-bmc", 0x1e6e3000, 0x40000000);
+    aspeed_test_md5("-machine palmetto-bmc", 0x1e6e3000, 0x40000000);
 }
 
 static void test_sha256_ast2400(void)
 {
-    test_sha256("-machine palmetto-bmc", 0x1e6e3000, 0x40000000);
+    aspeed_test_sha256("-machine palmetto-bmc", 0x1e6e3000, 0x40000000);
 }
 
 static void test_sha512_ast2400(void)
 {
-    test_sha512("-machine palmetto-bmc", 0x1e6e3000, 0x40000000);
+    aspeed_test_sha512("-machine palmetto-bmc", 0x1e6e3000, 0x40000000);
 }
 
 static void test_addresses_ast2400(void)
 {
-    test_addresses("-machine palmetto-bmc", 0x1e6e3000, &ast2400_masks);
+    aspeed_test_addresses("-machine palmetto-bmc", 0x1e6e3000, &ast2400_masks);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6b5161a643..bb14a22ebe 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -360,6 +360,7 @@ if gnutls.found()
 endif
 
 qtests = {
+  'aspeed_hace-test': files('aspeed-hace-utils.c', 'aspeed_hace-test.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
   'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
-- 
2.43.0


