Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3233FF60C4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 04:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7QOS-00011t-K9; Tue, 31 Mar 2026 00:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7QON-0000zn-3o; Tue, 31 Mar 2026 00:07:51 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7QOK-0002HD-DU; Tue, 31 Mar 2026 00:07:50 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwD3iWWQSMtp08g9AA--.23002S2;
 Tue, 31 Mar 2026 12:07:44 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwSJR6SMtpYqQHAA--.18366S6;
 Tue, 31 Mar 2026 12:07:37 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH 3/4] tests/qtest: Add qtest-attrs-test for memory access attrs
Date: Tue, 31 Mar 2026 12:06:58 +0800
Message-Id: <20260331040659.401397-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
References: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwSJR6SMtpYqQHAA--.18366S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWnKzfEBswAAsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZF47Kw4fZw4rKFW5GrW3KFg_yoW8GrW3uo
 WfJF12q3W7t3W3Gr92krZ7CrWqqa92kFsxJr40qw1UXF1xGF42yw13JFZxX34rtw48J34U
 GFZrKr1Syrs7trn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add qtest-attrs-test to exercise qtest memory access commands with attrs
on both aarch64 and x86.

The test covers:
- Arm virt,secure=on: scalar and bulk accesses across non-secure,
  secure, and root spaces, plus negative coverage for realm and for
  non-secure accesses into secure-only RAM
- x86 q35: normal accesses
- libqtest-single *_attrs shortcut wrappers

For negative cases, use qtest_raw_cmd() to check that accesses which
miss the intended AddressSpace fail with ERR responses emitted via
qtest_send_memtx_error().

On Arm, the test targets the virt machine's secure-only RAM window so
that the requested attrs must select the correct address space.

Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
builds.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/meson.build        |   7 +-
 tests/qtest/qtest-attrs-test.c | 350 +++++++++++++++++++++++++++++++++
 2 files changed, 355 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5..87aa104d23 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -115,6 +115,7 @@ qtests_i386 = \
    'drive_del-test',
    'cpu-plug-test',
    'migration-test',
+   'qtest-attrs-test',
   ]
 
 if dbus_display and config_all_devices.has_key('CONFIG_VGA')
@@ -249,7 +250,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-   'boot-serial-test']
+   'boot-serial-test',
+   'qtest-attrs-test',]
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
 qtests_aarch64 = \
@@ -270,7 +272,8 @@ qtests_aarch64 = \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-   'migration-test']
+   'migration-test',
+   'qtest-attrs-test']
 
 qtests_s390x = \
   qtests_filter + \
diff --git a/tests/qtest/qtest-attrs-test.c b/tests/qtest/qtest-attrs-test.c
new file mode 100644
index 0000000000..cd6b81e505
--- /dev/null
+++ b/tests/qtest/qtest-attrs-test.c
@@ -0,0 +1,350 @@
+/*
+ * QTest for memory access with transaction attributes
+ *
+ * Verify optional attrs argument support for qtest memory commands.
+ *
+ * Copyright (c) 2026 Phytium Technology
+ *
+ * Author:
+ *  Tao Tang <tangtao1634@phytium.com.cn>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqtest-single.h"
+
+/*
+ * The Arm virt test uses both the default non-secure RAM at 0x4000_0000 and
+ * the secure-only RAM window at 0x0e00_0000. The x86 q35 test only exercises
+ * regular RAM that is visible from both the default and SMM address spaces.
+ */
+#define TEST_ADDR_OFFSET_NS     0x1000ULL
+#define TEST_ADDR_OFFSET_S      0xe000000ULL
+#define TEST_ARM_SEC_BASE       0x0ULL
+#define TEST_ARM_NS_BASE        0x40000000ULL
+#define TEST_X86_BASE           0x0ULL
+
+#define TEST_ADDR_ARM_S         (TEST_ARM_SEC_BASE + TEST_ADDR_OFFSET_S)
+#define TEST_ADDR_ARM_NS        (TEST_ARM_NS_BASE + TEST_ADDR_OFFSET_NS)
+#define TEST_ADDR_X86           (TEST_X86_BASE + TEST_ADDR_OFFSET_NS)
+
+#define ARM_MACHINE_ARGS        "-machine virt,secure=on -accel tcg"
+#define X86_MACHINE_ARGS        "-machine q35,smm=on -m 1G -accel tcg"
+
+static void G_GNUC_PRINTF(3, 4) assert_qtest_response(QTestState *qts,
+                                                      const char *expected,
+                                                      const char *fmt, ...)
+{
+    va_list ap;
+    g_autofree gchar *cmd = NULL;
+    g_autofree gchar *line = NULL;
+    g_auto(GStrv) response = NULL;
+
+    va_start(ap, fmt);
+    cmd = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    response = qtest_raw_cmd(qts, "%s", cmd);
+    line = g_strjoinv(" ", response);
+    g_assert_cmpstr(line, ==, expected);
+}
+
+static void G_GNUC_PRINTF(2, 3) assert_qtest_error_prefix(QTestState *qts,
+                                                          const char *fmt, ...)
+{
+    va_list ap;
+    g_autofree gchar *cmd = NULL;
+    g_auto(GStrv) response = NULL;
+
+    va_start(ap, fmt);
+    cmd = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    response = qtest_raw_cmd(qts, "%s", cmd);
+    g_assert_cmpstr(response[0], ==, "ERR");
+}
+
+static void test_arm_scalar_attrs(void)
+{
+    QTestState *qts;
+    uint8_t val;
+
+    if (!qtest_has_machine("virt")) {
+        g_test_skip("virt machine not available");
+        return;
+    }
+
+    qts = qtest_init(ARM_MACHINE_ARGS);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM_NS, 0x11, NULL);
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM_NS, NULL);
+    g_assert_cmpuint(val, ==, 0x11);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM_NS + 0x1, 0x22, "space=non-secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM_NS + 0x1, "space=non-secure");
+    g_assert_cmpuint(val, ==, 0x22);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM_S + 0x2, 0x33, "secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM_S + 0x2, "secure");
+    g_assert_cmpuint(val, ==, 0x33);
+
+    assert_qtest_response(qts, "ERR invalid attrs argument",
+                          "readb 0x%" PRIx64 " invalid\n",
+                          (uint64_t)(TEST_ADDR_ARM_NS + 0x2));
+    assert_qtest_response(qts,
+                          "ERR invalid space value. Valid space: "
+                          "secure/non-secure/root/realm",
+                          "readb 0x%" PRIx64 " space=invalid\n",
+                          (uint64_t)(TEST_ADDR_ARM_NS + 0x2));
+    assert_qtest_response(qts, "ERR too many arguments",
+                          "writeb 0x%" PRIx64 " 0x44 secure extra\n",
+                          (uint64_t)(TEST_ADDR_ARM_NS + 0x2));
+
+    assert_qtest_error_prefix(qts, "writeb 0x%" PRIx64 " 0x44 space=realm\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x3));
+    assert_qtest_error_prefix(qts, "readb 0x%" PRIx64 " space=realm\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x3));
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM_S + 0x4, 0x55, "space=root");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM_S + 0x4, "space=root");
+    g_assert_cmpuint(val, ==, 0x55);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM_S + 0x5, 0x66, "space=secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM_S + 0x5, "space=secure");
+    g_assert_cmpuint(val, ==, 0x66);
+
+    qtest_writeb(qts, TEST_ADDR_ARM_NS + 0x6, 0x77);
+    val = qtest_readb(qts, TEST_ADDR_ARM_NS + 0x6);
+    g_assert_cmpuint(val, ==, 0x77);
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM_NS + 0x6, "space=non-secure");
+    g_assert_cmpuint(val, ==, 0x77);
+
+    assert_qtest_error_prefix(qts,
+                              "writeb 0x%" PRIx64 " 0x77 space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x7));
+    assert_qtest_error_prefix(qts, "readb 0x%" PRIx64 " space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x7));
+
+    qtest_quit(qts);
+}
+
+static void test_arm_bulk_attrs(void)
+{
+    QTestState *qts;
+    uint8_t wbuf[16] = {
+        0x00, 0x11, 0x22, 0x33,
+        0x44, 0x55, 0x66, 0x77,
+        0x88, 0x99, 0xaa, 0xbb,
+        0xcc, 0xdd, 0xee, 0xff,
+    };
+    uint8_t rbuf[16];
+    size_t i;
+
+    if (!qtest_has_machine("virt")) {
+        g_test_skip("virt machine not available");
+        return;
+    }
+
+    qts = qtest_init(ARM_MACHINE_ARGS);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_ARM_NS + 0x100,
+                         wbuf, sizeof(wbuf), NULL);
+    qtest_memread_attrs(qts, TEST_ADDR_ARM_NS + 0x100,
+                        rbuf, sizeof(rbuf), NULL);
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_ARM_NS + 0x200,
+                         wbuf, sizeof(wbuf), "space=non-secure");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM_NS + 0x200,
+                        rbuf, sizeof(rbuf), "space=non-secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_ARM_S + 0x300,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM_S + 0x300,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memset_attrs(qts, TEST_ADDR_ARM_S + 0x400,
+                       0xa5, sizeof(rbuf), "space=root");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM_S + 0x400,
+                        rbuf, sizeof(rbuf), "space=root");
+    for (i = 0; i < sizeof(rbuf); i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0xa5);
+    }
+
+    qtest_bufwrite_attrs(qts, TEST_ADDR_ARM_NS + 0x500,
+                         wbuf, sizeof(wbuf), "space=non-secure");
+    qtest_bufread_attrs(qts, TEST_ADDR_ARM_NS + 0x500,
+                        rbuf, sizeof(rbuf), "space=non-secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_bufwrite_attrs(qts, TEST_ADDR_ARM_S + 0x600,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_bufread_attrs(qts, TEST_ADDR_ARM_S + 0x600,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite(qts, TEST_ADDR_ARM_NS + 0x700, wbuf, 4);
+    qtest_memread(qts, TEST_ADDR_ARM_NS + 0x700, rbuf, 4);
+    g_assert(memcmp(wbuf, rbuf, 4) == 0);
+
+    qtest_memset(qts, TEST_ADDR_ARM_NS + 0x710, 0xa5, 4);
+    qtest_memread(qts, TEST_ADDR_ARM_NS + 0x710, rbuf, 4);
+    for (i = 0; i < 4; i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0xa5);
+    }
+
+    qtest_bufwrite(qts, TEST_ADDR_ARM_NS + 0x720, wbuf, 4);
+    qtest_bufread(qts, TEST_ADDR_ARM_NS + 0x720, rbuf, 4);
+    g_assert(memcmp(wbuf, rbuf, 4) == 0);
+
+    assert_qtest_error_prefix(qts, "write 0x%" PRIx64 " 0x%zx 0x00112233 "
+                              "space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x730),
+                              (size_t)4);
+    assert_qtest_error_prefix(qts, "read 0x%" PRIx64 " 0x%zx "
+                              "space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x730), (size_t)4);
+    assert_qtest_error_prefix(qts, "memset 0x%" PRIx64 " 0x%zx 0xa5 "
+                              "space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x740),
+                              (size_t)4);
+    assert_qtest_error_prefix(qts, "b64write 0x%" PRIx64 " 0x%zx AQIDBA== "
+                              "space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x750),
+                              (size_t)4);
+    assert_qtest_error_prefix(qts, "b64read 0x%" PRIx64 " 0x%zx "
+                              "space=non-secure\n",
+                              (uint64_t)(TEST_ADDR_ARM_S + 0x750), (size_t)4);
+    assert_qtest_response(qts, "ERR too many arguments",
+                          "write 0x%" PRIx64 " 0x%zx 0x00112233 secure "
+                          "extra\n",
+                          (uint64_t)(TEST_ADDR_ARM_NS + 0x760),
+                          (size_t)4);
+
+    qtest_quit(qts);
+}
+
+static void test_arm_single_shortcuts_attrs(void)
+{
+    uint8_t val;
+    uint8_t wbuf[4] = { 0x10, 0x20, 0x30, 0x40 };
+    uint8_t rbuf[4];
+
+    if (!qtest_has_machine("virt")) {
+        g_test_skip("virt machine not available");
+        return;
+    }
+
+    qtest_start(ARM_MACHINE_ARGS);
+
+    writeb_attrs(TEST_ADDR_ARM_S + 0x700, 0x5a, "secure");
+    val = readb_attrs(TEST_ADDR_ARM_S + 0x700, "secure");
+    g_assert_cmpuint(val, ==, 0x5a);
+
+    writel_attrs(TEST_ADDR_ARM_S + 0x704,
+                 0xa5a5a5a5, "space=root");
+    g_assert_cmphex(readl_attrs(TEST_ADDR_ARM_S + 0x704, "space=root"), ==,
+                    0xa5a5a5a5U);
+
+    memwrite_attrs(TEST_ADDR_ARM_NS + 0x708,
+                   wbuf, sizeof(wbuf), "space=non-secure");
+    memread_attrs(TEST_ADDR_ARM_NS + 0x708,
+                  rbuf, sizeof(rbuf), "space=non-secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_end();
+}
+
+static void test_x86_scalar_attrs(void)
+{
+    QTestState *qts;
+    uint8_t val;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    qts = qtest_init(X86_MACHINE_ARGS);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_X86, 0x11, NULL);
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86, NULL);
+    g_assert_cmpuint(val, ==, 0x11);
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86, "secure");
+    g_assert_cmpuint(val, ==, 0x11);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_X86 + 0x1, 0x22, "secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86 + 0x1, "secure");
+    g_assert_cmpuint(val, ==, 0x22);
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86 + 0x1, NULL);
+    g_assert_cmpuint(val, ==, 0x22);
+    assert_qtest_response(qts, "ERR space=<...> is Arm-specific",
+                          "readb 0x%" PRIx64 " space=secure\n",
+                          (uint64_t)(TEST_ADDR_X86 + 0x2));
+
+    qtest_quit(qts);
+}
+
+static void test_x86_bulk_attrs(void)
+{
+    QTestState *qts;
+    uint8_t wbuf[8] = { 1, 2, 3, 4, 5, 6, 7, 8 };
+    uint8_t rbuf[8];
+    size_t i;
+
+    if (!qtest_has_machine("q35")) {
+        g_test_skip("q35 machine not available");
+        return;
+    }
+
+    qts = qtest_init(X86_MACHINE_ARGS);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x100, wbuf, sizeof(wbuf), NULL);
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x100,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x180,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x180,
+                        rbuf, sizeof(rbuf), NULL);
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memset_attrs(qts, TEST_ADDR_X86 + 0x200,
+                       0x3c, sizeof(rbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x200,
+                        rbuf, sizeof(rbuf), NULL);
+    for (i = 0; i < sizeof(rbuf); i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0x3c);
+    }
+
+    qtest_bufwrite_attrs(qts, TEST_ADDR_X86 + 0x280,
+                         wbuf, sizeof(wbuf), NULL);
+    qtest_bufread_attrs(qts, TEST_ADDR_X86 + 0x280,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+    assert_qtest_response(qts, "ERR too many arguments",
+                          "read 0x%" PRIx64 " 0x%zx secure extra\n",
+                          (uint64_t)(TEST_ADDR_X86 + 0x300),
+                          sizeof(rbuf));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/qtest/arm/attrs/scalar", test_arm_scalar_attrs);
+    qtest_add_func("/qtest/arm/attrs/bulk", test_arm_bulk_attrs);
+    qtest_add_func("/qtest/arm/attrs/single_shortcuts",
+                   test_arm_single_shortcuts_attrs);
+    qtest_add_func("/qtest/x86/attrs/scalar", test_x86_scalar_attrs);
+    qtest_add_func("/qtest/x86/attrs/bulk", test_x86_bulk_attrs);
+
+    return g_test_run();
+}
-- 
2.34.1


