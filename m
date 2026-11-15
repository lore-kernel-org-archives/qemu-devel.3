Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DC606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSUwX-0008V6-Ev; Sun, 15 Nov 2026 02:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwS-0008Tp-RZ; Sun, 15 Nov 2026 02:46:25 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwP-0004om-6T; Sun, 15 Nov 2026 02:46:24 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwAnfdxJY_lq4EEHAg--.55240S2; 
 Sun, 15 Nov 2026 15:46:17 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFnQ_Y_lqF+j6AA--.34770S7;
 Sun, 15 Nov 2026 15:46:16 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 4/5] tests/qtest: Add qtest-attrs-test for memory access
 attrs
Date: Sun, 15 Nov 2026 15:46:06 +0800
Message-Id: <20261115074607.456045-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
References: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFnQ_Y_lqF+j6AA--.34770S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWr4tsgAdgAAse
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZF47Kw4fZw13GrWUCw4xtFb_yoW8JF48to
 WfJF42g3W2ya43Gr92krZ7Ar4qq3y0kFsxJF40qr18XF1xGF4avw43JFZxX398tw18J34U
 GFZxKr4Syrs7trn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add qtest-attrs-test to exercise qtest memory access commands with attrs
on both aarch64 and x86.

The test covers:

- Arm virt,secure=on: scalar and bulk accesses across non-secure,
secure, and root spaces, plus negative coverage for realm and for
non-secure accesses into secure-only RAM
- x86 q35: normal accesses
- libqtest-single *_attrs shortcut wrappers

For negative cases, check that accesses which miss the intended
AddressSpace fail with ERR responses emitted via qtest_send_memtx_error().
Use raw commands only for malformed protocol forms.

On Arm, the test targets the virt machine's secure-only RAM window so
that the requested attrs must select the correct address space.

Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
builds.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/qtest-attrs-test.c | 310 +++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |   7 +-
 2 files changed, 315 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c

diff --git a/tests/qtest/qtest-attrs-test.c b/tests/qtest/qtest-attrs-test.c
new file mode 100644
index 00000000000..9a69834f9fe
--- /dev/null
+++ b/tests/qtest/qtest-attrs-test.c
@@ -0,0 +1,310 @@
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
+    qtest_readb_attrs_assert_failure(qts, TEST_ADDR_ARM_NS + 0x2, "invalid");
+    qtest_readb_attrs_assert_failure(qts, TEST_ADDR_ARM_NS + 0x2,
+                                     "space=invalid");
+    qtest_cmd_assert_response(qts, "ERR too many arguments",
+                              "writeb 0x%" PRIx64 " 0x44 secure extra\n",
+                              (uint64_t)(TEST_ADDR_ARM_NS + 0x2));
+
+    qtest_writeb_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x3, 0x44,
+                                      "space=realm");
+    qtest_readb_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x3,
+                                     "space=realm");
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
+    qtest_writeb_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x7, 0x77,
+                                      "space=non-secure");
+    qtest_readb_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x7,
+                                     "space=non-secure");
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
+    uint8_t b64_fail_buf[4] = { 1, 2, 3, 4 };
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
+    qtest_memwrite_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x730,
+                                        wbuf, 4, "space=non-secure");
+    qtest_memread_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x730, 4,
+                                       "space=non-secure");
+    qtest_memset_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x740,
+                                      0xa5, 4, "space=non-secure");
+    qtest_bufwrite_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x750,
+                                        b64_fail_buf, sizeof(b64_fail_buf),
+                                        "space=non-secure");
+    qtest_bufread_attrs_assert_failure(qts, TEST_ADDR_ARM_S + 0x750,
+                                       sizeof(b64_fail_buf),
+                                       "space=non-secure");
+    qtest_cmd_assert_response(qts, "ERR too many arguments",
+                              "write 0x%" PRIx64 " 0x%zx 0x00112233 secure "
+                              "extra\n",
+                              (uint64_t)(TEST_ADDR_ARM_NS + 0x760),
+                              (size_t)4);
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
+    qtest_readb_attrs_assert_failure(qts, TEST_ADDR_X86 + 0x2,
+                                     "space=secure");
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
+    qtest_cmd_assert_response(qts, "ERR too many arguments",
+                              "read 0x%" PRIx64 " 0x%zx secure extra\n",
+                              (uint64_t)(TEST_ADDR_X86 + 0x300),
+                              sizeof(rbuf));
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    if (!qtest_has_accel("tcg")) {
+        g_test_skip("TCG accelerator not available");
+        return 0;
+    }
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 79946960869..9b08369d3bb 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -128,6 +128,7 @@ qtests_i386 = \
    'drive_del-test',
    'cpu-plug-test',
    'migration-test',
+   'qtest-attrs-test',
   ]
 
 if dbus_display and config_all_devices.has_key('CONFIG_VGA')
@@ -276,7 +277,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-   'boot-serial-test'] + \
+   'boot-serial-test',
+   'qtest-attrs-test',] + \
   (config_all_devices.has_key('CONFIG_ALLWINNER_A10')? ['allwinner-gpio-test'] : [])
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
@@ -302,7 +304,8 @@ qtests_aarch64 = \
   ['arm-cpu-features',
    'numa-test',
    'boot-serial-test',
-   'migration-test']
+   'migration-test',
+   'qtest-attrs-test']
 
 qtests_s390x = \
   (slirp.found() ? ['pxe-test'] : []) + \
-- 
2.34.1


