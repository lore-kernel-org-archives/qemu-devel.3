Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F94606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSUwg-0008W8-Nn; Sun, 15 Nov 2026 02:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwS-0008Tl-DZ; Sun, 15 Nov 2026 02:46:25 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwN-0004oO-7g; Sun, 15 Nov 2026 02:46:24 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCXR5xIY_lqlJowBg--.39700S2; 
 Sun, 15 Nov 2026 15:46:16 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFnQ_Y_lqF+j6AA--.34770S6;
 Sun, 15 Nov 2026 15:46:14 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 3/5] tests/qtest: Add libqtest attrs helpers for memory
 accesses
Date: Sun, 15 Nov 2026 15:46:05 +0800
Message-Id: <20261115074607.456045-4-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
References: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFnQ_Y_lqF+j6AA--.34770S6
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWr4tsgAdAAAsc
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw1xtw1kAw17Zw1xJrW5KFg_yoW5WFyfXo
 WrtF4jq34DXwnrZrW0vryxGr9rXw47CF45Xwn5t3W5Ka4rGrn09a1fKanxZa4j9F1rGrWk
 JFZ7XrWYgrWIyFZ7n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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

Expose libqtest APIs for qtest memory commands with optional attrs:
- qtest_{read,write}{b,w,l,q}_attrs()
- qtest_mem{read,write,set}_attrs()
- qtest_buf{read,write}_attrs()

Keep the existing libqtest memory access helpers as wrappers passing
NULL attrs, so current users remain unchanged.

Also add matching libqtest-single shortcut wrappers for the *_attrs
helpers.

Add response assertions and typed failure helpers for negative tests,
so callers do not have to parse raw qtest responses.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest-single.h | 156 ++++++++++++++
 tests/qtest/libqtest.h        | 275 +++++++++++++++++++++++++
 tests/qtest/libqtest.c        | 375 +++++++++++++++++++++++++++++-----
 3 files changed, 753 insertions(+), 53 deletions(-)

diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index 851724cbcb8..2812b86bd45 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -291,6 +291,162 @@ static inline void memwrite(uint64_t addr, const void *data, size_t size)
     qtest_memwrite(global_qtest, addr, data, size);
 }
 
+/**
+ * writeb_attrs:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes an 8-bit value to guest memory with optional transaction attributes.
+ */
+static inline void writeb_attrs(uint64_t addr, uint8_t value, const char *attrs)
+{
+    qtest_writeb_attrs(global_qtest, addr, value, attrs);
+}
+
+/**
+ * writew_attrs:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes a 16-bit value to guest memory with optional transaction attributes.
+ */
+static inline void writew_attrs(uint64_t addr, uint16_t value,
+                                const char *attrs)
+{
+    qtest_writew_attrs(global_qtest, addr, value, attrs);
+}
+
+/**
+ * writel_attrs:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes a 32-bit value to guest memory with optional transaction attributes.
+ */
+static inline void writel_attrs(uint64_t addr, uint32_t value,
+                                const char *attrs)
+{
+    qtest_writel_attrs(global_qtest, addr, value, attrs);
+}
+
+/**
+ * writeq_attrs:
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes a 64-bit value to guest memory with optional transaction attributes.
+ */
+static inline void writeq_attrs(uint64_t addr, uint64_t value,
+                                const char *attrs)
+{
+    qtest_writeq_attrs(global_qtest, addr, value, attrs);
+}
+
+/**
+ * readb_attrs:
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads an 8-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+static inline uint8_t readb_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readb_attrs(global_qtest, addr, attrs);
+}
+
+/**
+ * readw_attrs:
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads a 16-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+static inline uint16_t readw_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readw_attrs(global_qtest, addr, attrs);
+}
+
+/**
+ * readl_attrs:
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads a 32-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+static inline uint32_t readl_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readl_attrs(global_qtest, addr, attrs);
+}
+
+/**
+ * readq_attrs:
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads a 64-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+static inline uint64_t readq_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readq_attrs(global_qtest, addr, attrs);
+}
+
+/**
+ * memread_attrs:
+ * @addr: Guest address to read from.
+ * @data: Pointer to where memory contents will be stored.
+ * @size: Number of bytes to read.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Read guest memory into a buffer with optional transaction attributes.
+ */
+static inline void memread_attrs(uint64_t addr, void *data, size_t size,
+                                 const char *attrs)
+{
+    qtest_memread_attrs(global_qtest, addr, data, size, attrs);
+}
+
+/**
+ * memwrite_attrs:
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes that will be written to guest memory.
+ * @size: Number of bytes to write.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Write a buffer to guest memory with optional transaction attributes.
+ */
+static inline void memwrite_attrs(uint64_t addr, const void *data, size_t size,
+                                  const char *attrs)
+{
+    qtest_memwrite_attrs(global_qtest, addr, data, size, attrs);
+}
+
+/**
+ * memset_attrs:
+ * @addr: Guest address to write to.
+ * @pattern: Byte pattern to fill the guest memory region with.
+ * @size: Number of bytes to write.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Write a pattern to guest memory with optional transaction attributes.
+ */
+static inline void memset_attrs(uint64_t addr, uint8_t pattern, size_t size,
+                                const char *attrs)
+{
+    qtest_memset_attrs(global_qtest, addr, pattern, size, attrs);
+}
+
 /**
  * clock_step_next:
  *
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 9c17da930e1..a999fc3e52f 100644
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
@@ -716,6 +738,32 @@ uint64_t qtest_csr_call(QTestState *s, const char *name,
  */
 void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size);
 
+/**
+ * qtest_bufread_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @data: Pointer to where memory contents will be stored.
+ * @size: Number of bytes to read.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Read guest memory into a buffer and receive using a base64 encoding with
+ * optional transaction attributes.
+ */
+void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
+                         const char *attrs);
+
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
@@ -739,6 +787,35 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
 void qtest_bufwrite(QTestState *s, uint64_t addr,
                     const void *data, size_t size);
 
+/**
+ * qtest_bufwrite_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes that will be written to guest memory.
+ * @size: Number of bytes to write.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Write a buffer to guest memory and transmit using a base64 encoding with
+ * optional transaction attributes.
+ */
+void qtest_bufwrite_attrs(QTestState *s, uint64_t addr,
+                          const void *data, size_t size,
+                          const char *attrs);
+
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
@@ -750,6 +827,204 @@ void qtest_bufwrite(QTestState *s, uint64_t addr,
  */
 void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
 
+/**
+ * qtest_writeb_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes an 8-bit value to guest memory with optional transaction attributes.
+ */
+void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
+                        const char *attrs);
+
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
+/**
+ * qtest_writew_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes a 16-bit value to guest memory with optional transaction attributes.
+ */
+void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
+                        const char *attrs);
+
+/**
+ * qtest_writel_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes a 32-bit value to guest memory with optional transaction attributes.
+ */
+void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
+                        const char *attrs);
+
+/**
+ * qtest_writeq_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Writes a 64-bit value to guest memory with optional transaction attributes.
+ */
+void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
+                        const char *attrs);
+
+/**
+ * qtest_readb_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads an 8-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs);
+
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
+/**
+ * qtest_readw_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads a 16-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs);
+
+/**
+ * qtest_readl_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads a 32-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs);
+
+/**
+ * qtest_readq_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Reads a 64-bit value from guest memory with optional transaction attributes.
+ *
+ * Returns: Value read.
+ */
+uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs);
+
+/**
+ * qtest_memread_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @data: Pointer to where memory contents will be stored.
+ * @size: Number of bytes to read.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Read guest memory into a buffer with optional transaction attributes.
+ */
+void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
+                         const char *attrs);
+
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
+/**
+ * qtest_memwrite_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes that will be written to guest memory.
+ * @size: Number of bytes to write.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Write a buffer to guest memory with optional transaction attributes.
+ */
+void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, const char *attrs);
+
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
+/**
+ * qtest_memset_attrs:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @patt: Byte pattern to fill the guest memory region with.
+ * @size: Number of bytes to write.
+ * @attrs: Optional transaction attributes string.
+ *
+ * Write a pattern to guest memory with optional transaction attributes.
+ */
+void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t patt, size_t size,
+                        const char *attrs);
+
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
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 3b2e31240e7..91f7525bdf1 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -820,6 +820,37 @@ gchar **qtest_raw_cmd(QTestState *s, const char *fmt, ...)
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
@@ -827,6 +858,14 @@ static void qtest_rsp(QTestState *s)
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
@@ -1341,66 +1380,44 @@ uint32_t qtest_inl(QTestState *s, uint16_t addr)
     return qtest_big_endian(s) ? bswap32(v) : v;
 }
 
-static void qtest_write(QTestState *s, const char *cmd, uint64_t addr,
-                        uint64_t value)
-{
-    qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
-    qtest_rsp(s);
-}
-
 void qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
 {
-    qtest_write(s, "writeb", addr, value);
+    qtest_writeb_attrs(s, addr, value, NULL);
 }
 
 void qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
 {
-    qtest_write(s, "writew", addr, value);
+    qtest_writew_attrs(s, addr, value, NULL);
 }
 
 void qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
 {
-    qtest_write(s, "writel", addr, value);
+    qtest_writel_attrs(s, addr, value, NULL);
 }
 
 void qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
 {
-    qtest_write(s, "writeq", addr, value);
-}
-
-static uint64_t qtest_read(QTestState *s, const char *cmd, uint64_t addr)
-{
-    gchar **args;
-    int ret;
-    uint64_t value;
-
-    qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
-    args = qtest_rsp_args(s, 2);
-    ret = qemu_strtou64(args[1], NULL, 0, &value);
-    g_assert(!ret);
-    g_strfreev(args);
-
-    return value;
+    qtest_writeq_attrs(s, addr, value, NULL);
 }
 
 uint8_t qtest_readb(QTestState *s, uint64_t addr)
 {
-    return qtest_read(s, "readb", addr);
+    return qtest_readb_attrs(s, addr, NULL);
 }
 
 uint16_t qtest_readw(QTestState *s, uint64_t addr)
 {
-    return qtest_read(s, "readw", addr);
+    return qtest_readw_attrs(s, addr, NULL);
 }
 
 uint32_t qtest_readl(QTestState *s, uint64_t addr)
 {
-    return qtest_read(s, "readl", addr);
+    return qtest_readl_attrs(s, addr, NULL);
 }
 
 uint64_t qtest_readq(QTestState *s, uint64_t addr)
 {
-    return qtest_read(s, "readq", addr);
+    return qtest_readq_attrs(s, addr, NULL);
 }
 
 static int hex2nib(char ch)
@@ -1418,23 +1435,7 @@ static int hex2nib(char ch)
 
 void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
 {
-    uint8_t *ptr = data;
-    gchar **args;
-    size_t i;
-
-    if (!size) {
-        return;
-    }
-
-    qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
-    args = qtest_rsp_args(s, 2);
-
-    for (i = 0; i < size; i++) {
-        ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
-        ptr[i] |= hex2nib(args[1][2 + (i * 2) + 1]);
-    }
-
-    g_strfreev(args);
+    qtest_memread_attrs(s, addr, data, size, NULL);
 }
 
 uint64_t qtest_rtas_call(QTestState *s, const char *name,
@@ -1499,23 +1500,76 @@ void qtest_add_data_func(const char *str, const void *data,
 }
 
 void qtest_bufwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
+{
+    qtest_bufwrite_attrs(s, addr, data, size, NULL);
+}
+
+void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
+{
+    qtest_bufread_attrs(s, addr, data, size, NULL);
+}
+
+void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
+{
+    qtest_memwrite_attrs(s, addr, data, size, NULL);
+}
+
+void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
+{
+    qtest_memset_attrs(s, addr, pattern, size, NULL);
+}
+
+static bool qtest_has_attrs(const char *attrs)
+{
+    return attrs && attrs[0];
+}
+
+void qtest_bufwrite_attrs(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, const char *attrs)
 {
     gchar *bdata;
 
     bdata = g_base64_encode(data, size);
     qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
     s->ops.send(s, bdata);
+    if (qtest_has_attrs(attrs)) {
+        s->ops.send(s, " ");
+        s->ops.send(s, attrs);
+    }
     s->ops.send(s, "\n");
     qtest_rsp(s);
     g_free(bdata);
 }
 
-void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
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
+void qtest_bufread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
+                         const char *attrs)
 {
     gchar **args;
     size_t len;
 
-    qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
+    } else {
+        qtest_sendf(s, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    }
     args = qtest_rsp_args(s, 2);
 
     g_base64_decode_inplace(args[1], &len);
@@ -1529,7 +1583,171 @@ void qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
     g_strfreev(args);
 }
 
-void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
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
+static void qtest_write_attrs(QTestState *s, const char *cmd,
+                              uint64_t addr, uint64_t value,
+                              const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %s\n",
+                    cmd, addr, value, attrs);
+    } else {
+        qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
+    }
+    qtest_rsp(s);
+}
+
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
+static uint64_t qtest_read_attrs(QTestState *s, const char *cmd,
+                                 uint64_t addr, const char *attrs)
+{
+    gchar **args;
+    int ret;
+    uint64_t value;
+
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "%s 0x%" PRIx64 " %s\n", cmd, addr, attrs);
+    } else {
+        qtest_sendf(s, "%s 0x%" PRIx64 "\n", cmd, addr);
+    }
+    args = qtest_rsp_args(s, 2);
+    ret = qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
+    g_strfreev(args);
+
+    return value;
+}
+
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
+void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
+                        const char *attrs)
+{
+    qtest_write_attrs(s, "writeb", addr, value, attrs);
+}
+
+void qtest_writeb_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                       uint8_t value, const char *attrs)
+{
+    qtest_write_attrs_assert_failure(s, "writeb", addr, value, attrs);
+}
+
+void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
+                        const char *attrs)
+{
+    qtest_write_attrs(s, "writew", addr, value, attrs);
+}
+
+void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
+                        const char *attrs)
+{
+    qtest_write_attrs(s, "writel", addr, value, attrs);
+}
+
+void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
+                        const char *attrs)
+{
+    qtest_write_attrs(s, "writeq", addr, value, attrs);
+}
+
+uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs)
+{
+    return qtest_read_attrs(s, "readb", addr, attrs);
+}
+
+void qtest_readb_attrs_assert_failure(QTestState *s, uint64_t addr,
+                                      const char *attrs)
+{
+    qtest_read_attrs_assert_failure(s, "readb", addr, attrs);
+}
+
+uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs)
+{
+    return qtest_read_attrs(s, "readw", addr, attrs);
+}
+
+uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs)
+{
+    return qtest_read_attrs(s, "readl", addr, attrs);
+}
+
+uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs)
+{
+    return qtest_read_attrs(s, "readq", addr, attrs);
+}
+
+void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data,
+                         size_t size, const char *attrs)
+{
+    uint8_t *ptr = data;
+    gchar **args;
+    size_t i;
+
+    if (!size) {
+        return;
+    }
+
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx %s\n", addr, size, attrs);
+    } else {
+        qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    }
+    args = qtest_rsp_args(s, 2);
+
+    for (i = 0; i < size; i++) {
+        ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
+        ptr[i] |= hex2nib(args[1][2 + (i * 2) + 1]);
+    }
+
+    g_strfreev(args);
+}
+
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
+void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, const char *attrs)
 {
     const uint8_t *ptr = data;
     size_t i;
@@ -1545,17 +1763,68 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
         sprintf(&enc[i * 2], "%02x", ptr[i]);
     }
 
-    qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s %s\n",
+                    addr, size, enc, attrs);
+    } else {
+        qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
+    }
     qtest_rsp(s);
     g_free(enc);
 }
 
-void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
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
+void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t pattern,
+                        size_t size, const char *attrs)
 {
-    qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size, pattern);
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x %s\n",
+                    addr, size, pattern, attrs);
+    } else {
+        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n",
+                    addr, size, pattern);
+    }
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
-- 
2.34.1


