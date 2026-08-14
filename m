Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86970C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 03:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuj2N-0006D0-VI; Thu, 13 Aug 2026 23:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuj2M-0006Ck-UT; Thu, 13 Aug 2026 23:56:54 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1wuj2J-0007sT-Sl; Thu, 13 Aug 2026 23:56:54 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBH3lIBkn5qJId5Aw--.28194S2; 
 Fri, 14 Aug 2026 11:56:49 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwfXPskX5qW1IjAA--.62931S7;
 Fri, 14 Aug 2026 11:56:34 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v5 4/5] tests/qtest: Add qtest-attrs-test for memory access attrs
Date: Fri, 14 Aug 2026 11:56:27 +0800
Message-Id: <20260814035628.3924513-5-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
References: <20260814035628.3924513-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwfXPskX5qW1IjAA--.62931S7
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAHBWp+G0sCDgAAsL
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZF45WFyxJFy5Cw18XFyxKrg_yoW5JFWDKo
 WftF42q347Z3Zxur92vryxJrZFq3y0kFs8Jw4vqr1jg3WxKF1aya1ftFZxX34DKw1rJ34U
 GFZ2gryfKr4Iyr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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

Add reusable response assertion helpers and structured attrs failure
helpers to libqtest. Use the structured APIs for negative memory access
tests, while retaining raw protocol commands for malformed command
shapes that the typed APIs cannot express.

On Arm, the test targets the virt machine's secure-only RAM window so
that the requested attrs must select the correct address space.

Also wire qtest-attrs-test into the aarch64 and i386/x86_64 qtest
builds.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 tests/qtest/libqtest.c         | 156 +++++++++++++++++
 tests/qtest/libqtest.h         | 111 ++++++++++++
 tests/qtest/meson.build        |   7 +-
 tests/qtest/qtest-attrs-test.c | 305 +++++++++++++++++++++++++++++++++
 4 files changed, 577 insertions(+), 2 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 37aa69e1297..533b6f34599 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -812,6 +812,37 @@ gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
     return qtest_rsp_words(s);
 }
 
+void qtest_cmd_assert_response(QTestState *s, const char *expected,
+                               const char *fmt, ...)
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
+    response = qtest_raw_cmd(s, "%s", cmd);
+    line = g_strjoinv(" ", response);
+    g_assert_cmpstr(line, ==, expected);
+}
+
+void qtest_cmd_assert_failure(QTestState *s, const char *fmt, ...)
+{
+    va_list ap;
+    g_autofree gchar *cmd = NULL;
+    g_auto(GStrv) response = NULL;
+
+    va_start(ap, fmt);
+    cmd = g_strdup_vprintf(fmt, ap);
+    va_end(ap);
+
+    response = qtest_raw_cmd(s, "%s", cmd);
+    g_assert_cmpstr(response[0], ==, "ERR");
+}
+
 static void qtest_rsp(QTestState *s)
 {
     gchar **words = qtest_rsp_args(s, 0);
@@ -819,6 +850,14 @@ static void qtest_rsp(QTestState *s)
     g_strfreev(words);
 }
 
+static void qtest_rsp_assert_failure(QTestState *s)
+{
+    gchar **words = qtest_rsp_words(s);
+
+    g_assert_cmpstr(words[0], ==, "ERR");
+    g_strfreev(words);
+}
+
 static int qtest_query_target_endianness(QTestState *s)
 {
     gchar **args;
@@ -1438,6 +1477,24 @@ void qtest_bufwrite_attrs(QTestState *s, uint64_t addr, const void *data,
     g_free(bdata);
 }
 
+void qtest_bufwrite_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                         const void *data, size_t size,
+                                         const char *attrs)
+{
+    gchar *bdata;
+
+    bdata = g_base64_encode(data, size);
+    qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
+    s->ops.send(s, bdata);
+    if (qtest_has_attrs(attrs)) {
+        s->ops.send(s, " ");
+        s->ops.send(s, attrs);
+    }
+    s->ops.send(s, "\n");
+    qtest_rsp_assert_failure(s);
+    g_free(bdata);
+}
+
 void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
                          const char *attrs)
 {
@@ -1462,6 +1519,18 @@ void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
     g_strfreev(args);
 }
 
+void qtest_bufread_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                        size_t size, const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx %s\n",
+                    addr, size, attrs);
+    } else {
+        qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    }
+    qtest_rsp_assert_failure(s);
+}
+
 static void qtest_write_attrs(QTestState *s, const char *cmd,
                               uint64_t addr, uint64_t value,
                               const char *attrs)
@@ -1475,6 +1544,20 @@ static void qtest_write_attrs(QTestState *s, const char *cmd,
     qtest_rsp(s);
 }
 
+static void qtest_write_attrs_assert_failure(QTestState *s, const char *cmd,
+                                              uint64_t addr, uint64_t value,
+                                              const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %s\n",
+                    cmd, addr, value, attrs);
+    } else {
+        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n",
+                    cmd, addr, value);
+    }
+    qtest_rsp_assert_failure(s);
+}
+
 static uint64_t qtest_read_attrs(QTestState *s, const char *cmd,
                                  uint64_t addr, const char *attrs)
 {
@@ -1495,12 +1578,29 @@ static uint64_t qtest_read_attrs(QTestState *s, const char *cmd,
     return value;
 }
 
+static void qtest_read_attrs_assert_failure(QTestState *s, const char *cmd,
+                                             uint64_t addr, const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "%s 0x%" PRIx64 " %s\n", cmd, addr, attrs);
+    } else {
+        qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
+    }
+    qtest_rsp_assert_failure(s);
+}
+
 void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
                         const char *attrs)
 {
     qtest_write_attrs(s, "writeb", addr, value, attrs);
 }
 
+void qtest_writeb_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                       uint8_t value, const char *attrs)
+{
+    qtest_write_attrs_assert_failure(s, "writeb", addr, value, attrs);
+}
+
 void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
                         const char *attrs)
 {
@@ -1524,6 +1624,12 @@ uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs)
     return qtest_read_attrs(s, "readb", addr, attrs);
 }
 
+void qtest_readb_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                      const char *attrs)
+{
+    qtest_read_attrs_assert_failure(s, "readb", addr, attrs);
+}
+
 uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs)
 {
     return qtest_read_attrs(s, "readw", addr, attrs);
@@ -1565,6 +1671,17 @@ void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data,
     g_strfreev(args);
 }
 
+void qtest_memread_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                        size_t size, const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
+    } else {
+        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    }
+    qtest_rsp_assert_failure(s);
+}
+
 void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
                           size_t size, const char *attrs)
 {
@@ -1592,6 +1709,31 @@ void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
     g_free(enc);
 }
 
+void qtest_memwrite_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                         const void *data, size_t size,
+                                         const char *attrs)
+{
+    const uint8_t *ptr = data;
+    size_t i;
+    char *enc;
+
+    g_assert(size);
+    enc = g_malloc(2 * size + 1);
+
+    for (i = 0; i < size; i++) {
+        sprintf(&enc[i * 2], "%02x", ptr[i]);
+    }
+
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s %s\n",
+                    addr, size, enc, attrs);
+    } else {
+        qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
+    }
+    qtest_rsp_assert_failure(s);
+    g_free(enc);
+}
+
 void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t pattern,
                         size_t size, const char *attrs)
 {
@@ -1605,6 +1747,20 @@ void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t pattern,
     qtest_rsp(s);
 }
 
+void qtest_memset_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                       uint8_t pattern, size_t size,
+                                       const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x %s\n",
+                    addr, size, pattern, attrs);
+    } else {
+        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n",
+                    addr, size, pattern);
+    }
+    qtest_rsp_assert_failure(s);
+}
+
 QDict *qtest_vqmp_assert_failure_ref(QTestState *qts,
                                      const char *fmt, va_list args)
 {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 715c363de30..db6adf565c5 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -252,6 +252,28 @@ void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
 gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
     G_GNUC_PRINTF(2, 3);
 
+/**
+ * qtest_cmd_assert_response:
+ * @s: #QTestState instance to operate on.
+ * @expected: expected qtest response line.
+ * @fmt: qtest protocol text to send, formatted like sprintf().
+ *
+ * Sends a qtest command and asserts that its response matches @expected.
+ */
+void qtest_cmd_assert_response(QTestState *s, const char *expected,
+                               const char *fmt, ...)
+    G_GNUC_PRINTF(3, 4);
+
+/**
+ * qtest_cmd_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @fmt: qtest protocol text to send, formatted like sprintf().
+ *
+ * Sends a qtest command and asserts that its response starts with ``ERR``.
+ */
+void qtest_cmd_assert_failure(QTestState *s, const char *fmt, ...)
+    G_GNUC_PRINTF(2, 3);
+
 /**
  * qtest_socket_server:
  * @socket_path: the UNIX domain socket path
@@ -706,6 +728,18 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size);
 void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
                          const char *attrs);
 
+/**
+ * qtest_bufread_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @size: Number of bytes to read.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed base64 memory read fails.
+ */
+void qtest_bufread_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                        size_t size, const char *attrs);
+
 /**
  * qtest_memwrite:
  * @s: #QTestState instance to operate on.
@@ -744,6 +778,20 @@ void qtest_bufwrite_attrs(QTestState *s, uint64_t addr,
                           const void *data, size_t size,
                           const char *attrs);
 
+/**
+ * qtest_bufwrite_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes to write.
+ * @size: Number of bytes to write.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed base64 memory write fails.
+ */
+void qtest_bufwrite_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                         const void *data, size_t size,
+                                         const char *attrs);
+
 /**
  * qtest_memset:
  * @s: #QTestState instance to operate on.
@@ -767,6 +815,18 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
 void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
                         const char *attrs);
 
+/**
+ * qtest_writeb_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed 8-bit memory write fails.
+ */
+void qtest_writeb_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                       uint8_t value, const char *attrs);
+
 /**
  * qtest_writew_attrs:
  * @s: #QTestState instance to operate on.
@@ -815,6 +875,17 @@ void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
  */
 uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs);
 
+/**
+ * qtest_readb_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed 8-bit memory read fails.
+ */
+void qtest_readb_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                      const char *attrs);
+
 /**
  * qtest_readw_attrs:
  * @s: #QTestState instance to operate on.
@@ -864,6 +935,18 @@ uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs);
 void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
                          const char *attrs);
 
+/**
+ * qtest_memread_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @size: Number of bytes to read.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed hexadecimal memory read fails.
+ */
+void qtest_memread_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                        size_t size, const char *attrs);
+
 /**
  * qtest_memwrite_attrs:
  * @s: #QTestState instance to operate on.
@@ -877,6 +960,20 @@ void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
 void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
                           size_t size, const char *attrs);
 
+/**
+ * qtest_memwrite_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes to write.
+ * @size: Number of bytes to write.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed hexadecimal memory write fails.
+ */
+void qtest_memwrite_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                         const void *data, size_t size,
+                                         const char *attrs);
+
 /**
  * qtest_memset_attrs:
  * @s: #QTestState instance to operate on.
@@ -890,6 +987,20 @@ void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
 void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t patt, size_t size,
                         const char *attrs);
 
+/**
+ * qtest_memset_attrs_assert_failure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @patt: Byte pattern to fill the guest memory region with.
+ * @size: Number of bytes to write.
+ * @attrs: Transaction attributes string.
+ *
+ * Assert that an attributed memory fill fails.
+ */
+void qtest_memset_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                       uint8_t patt, size_t size,
+                                       const char *attrs);
+
 /**
  * qtest_clock_step_next:
  * @s: #QTestState instance to operate on.
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f7c7d06620e..fd59050fd27 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -120,6 +120,7 @@ qtests_i386 = \
    'drive_del-test',
    'cpu-plug-test',
    'migration-test',
+   'qtest-attrs-test',
   ]
 
 if dbus_display and config_all_devices.has_key('CONFIG_VGA')
@@ -257,7 +258,8 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-   'boot-serial-test']
+   'boot-serial-test',
+   'qtest-attrs-test',]
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
 qtests_aarch64 = \
@@ -278,7 +280,8 @@ qtests_aarch64 = \
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
index 00000000000..f429000b29d
--- /dev/null
+++ b/tests/qtest/qtest-attrs-test.c
@@ -0,0 +1,305 @@
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


