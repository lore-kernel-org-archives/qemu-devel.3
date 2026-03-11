Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF745112584F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:51:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Lpy-0003Ga-Bg; Wed, 11 Mar 2026 11:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w0Lpf-00039t-Iy; Wed, 11 Mar 2026 11:50:50 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w0Lpd-0001a3-BH; Wed, 11 Mar 2026 11:50:47 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCH3dFOj7FpMXHJAA--.50242S2;
 Wed, 11 Mar 2026 23:50:38 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwW5JGj7Fpf8UAAA--.812S5;
 Wed, 11 Mar 2026 23:50:37 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v2 2/2] tests/qtest: Add qtest-attrs-test for memory access with
 attrs
Date: Wed, 11 Mar 2026 23:49:34 +0800
Message-Id: <20260311154934.1575429-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
References: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwW5JGj7Fpf8UAAA--.812S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWmwb-oGPwAAs6
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XrWfCF45ur15XF17Gw4rXwb_yoWfGr1UpF
 WUCFn0yFsIvF1xXanxXa17Gwn0grs7Ca4UCFs8Gr1rAF48AFnrtFyUua4YgrWDt3y0qr18
 u3WvyFZrGayDJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Add qtest-attrs-test to exercise qtest memory commands with optional attrs
on aarch64 (virt, secure=on) and x86 (pc, tcg).

The test covers:
- ARM (virt machine): exercises all supported ARM security spaces
  (non-secure, secure, root, realm).
- x86 (pc machine): exercises secure attrs accesses
  (SMM address-space path).

The test also covers libqtest-single *_attrs shortcut wrappers and
verifies that space=non-secure behaves like omitting attrs.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/meson.build        |   4 +-
 tests/qtest/qtest-attrs-test.c | 234 +++++++++++++++++++++++++++++++++
 2 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index be4fa627b5..c11759e23f 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -115,6 +115,7 @@ qtests_i386 = \
    'drive_del-test',
    'cpu-plug-test',
    'migration-test',
+   'qtest-attrs-test',
   ]
 
 if dbus_display and config_all_devices.has_key('CONFIG_VGA')
@@ -270,7 +271,8 @@ qtests_aarch64 = \
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
index 0000000000..ce204c2c95
--- /dev/null
+++ b/tests/qtest/qtest-attrs-test.c
@@ -0,0 +1,234 @@
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
+ * Default RAM size is 128 MiB on both machines used below.
+ * Keep test addresses in low RAM and away from device MMIO regions.
+ */
+#define TEST_ADDR_OFFSET    0x1000ULL
+#define TEST_ARM_BASE       0x40000000ULL
+#define TEST_X86_BASE       0x0ULL
+
+#define TEST_ADDR_ARM       (TEST_ARM_BASE + TEST_ADDR_OFFSET)
+#define TEST_ADDR_X86       (TEST_X86_BASE + TEST_ADDR_OFFSET)
+
+#define ARM_MACHINE_ARGS    "-machine virt,secure=on -cpu cortex-a57"
+#define X86_MACHINE_ARGS    "-machine pc -accel tcg"
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
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM, 0x11, NULL);
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM, NULL);
+    g_assert_cmpuint(val, ==, 0x11);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x1, 0x22, "secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x1, "secure");
+    g_assert_cmpuint(val, ==, 0x22);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x2, 0x33, "space=realm");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x2, "space=realm");
+    g_assert_cmpuint(val, ==, 0x33);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x3, 0x44, "space=root");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x3, "space=root");
+    g_assert_cmpuint(val, ==, 0x44);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x4, 0x55, "space=secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x4, "space=secure");
+    g_assert_cmpuint(val, ==, 0x55);
+
+    /* space=non-secure is equivalent to no attrs argument */
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x5, 0x66, "space=non-secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x5, NULL);
+    g_assert_cmpuint(val, ==, 0x66);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_ARM + 0x6, 0x77, NULL);
+    val = qtest_readb_attrs(qts, TEST_ADDR_ARM + 0x6, "space=non-secure");
+    g_assert_cmpuint(val, ==, 0x77);
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
+    qtest_memwrite_attrs(qts, TEST_ADDR_ARM + 0x100,
+                         wbuf, sizeof(wbuf), NULL);
+    qtest_memread_attrs(qts, TEST_ADDR_ARM + 0x100,
+                        rbuf, sizeof(rbuf), NULL);
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_ARM + 0x200,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM + 0x200,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_ARM + 0x300,
+                         wbuf, sizeof(wbuf), "space=realm");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM + 0x300,
+                        rbuf, sizeof(rbuf), "space=realm");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memset_attrs(qts, TEST_ADDR_ARM + 0x400,
+                       0xa5, sizeof(rbuf), "space=root");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM + 0x400,
+                        rbuf, sizeof(rbuf), "space=root");
+    for (i = 0; i < sizeof(rbuf); i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0xa5);
+    }
+
+    qtest_memset_attrs(qts, TEST_ADDR_ARM + 0x500,
+                       0x5a, sizeof(rbuf), "space=non-secure");
+    qtest_memread_attrs(qts, TEST_ADDR_ARM + 0x500,
+                        rbuf, sizeof(rbuf), NULL);
+    for (i = 0; i < sizeof(rbuf); i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0x5a);
+    }
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
+    writeb_attrs(TEST_ADDR_ARM + 0x600, 0x5a, "secure");
+    val = readb_attrs(TEST_ADDR_ARM + 0x600, "secure");
+    g_assert_cmpuint(val, ==, 0x5a);
+
+    writel_attrs(TEST_ADDR_ARM + 0x604,
+                 0xa5a5a5a5, "space=realm");
+    g_assert_cmphex(readl_attrs(TEST_ADDR_ARM + 0x604, "space=realm"), ==,
+                    0xa5a5a5a5U);
+
+    memwrite_attrs(TEST_ADDR_ARM + 0x608,
+                   wbuf, sizeof(wbuf), "space=non-secure");
+    memread_attrs(TEST_ADDR_ARM + 0x608,
+                  rbuf, sizeof(rbuf), NULL);
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
+    if (!qtest_has_machine("pc")) {
+        g_test_skip("pc machine not available");
+        return;
+    }
+
+    qts = qtest_init(X86_MACHINE_ARGS);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_X86, 0x11, NULL);
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86, NULL);
+    g_assert_cmpuint(val, ==, 0x11);
+
+    qtest_writeb_attrs(qts, TEST_ADDR_X86 + 0x1, 0xaa, "secure");
+    val = qtest_readb_attrs(qts, TEST_ADDR_X86 + 0x1, "secure");
+    g_assert_cmpuint(val, ==, 0xaa);
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
+    if (!qtest_has_machine("pc")) {
+        g_test_skip("pc machine not available");
+        return;
+    }
+
+    qts = qtest_init(X86_MACHINE_ARGS);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x100, wbuf, sizeof(wbuf), NULL);
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x100, rbuf, sizeof(rbuf), NULL);
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memwrite_attrs(qts, TEST_ADDR_X86 + 0x180,
+                         wbuf, sizeof(wbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x180,
+                        rbuf, sizeof(rbuf), "secure");
+    g_assert(memcmp(wbuf, rbuf, sizeof(wbuf)) == 0);
+
+    qtest_memset_attrs(qts, TEST_ADDR_X86 + 0x200,
+                       0x3c, sizeof(rbuf), "secure");
+    qtest_memread_attrs(qts, TEST_ADDR_X86 + 0x200,
+                        rbuf, sizeof(rbuf), "secure");
+    for (i = 0; i < sizeof(rbuf); i++) {
+        g_assert_cmpuint(rbuf[i], ==, 0x3c);
+    }
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
+
+    qtest_add_func("/qtest/x86/attrs/scalar", test_x86_scalar_attrs);
+    qtest_add_func("/qtest/x86/attrs/bulk", test_x86_bulk_attrs);
+
+    return g_test_run();
+}
-- 
2.34.1


