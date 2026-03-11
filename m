Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862461125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Lq0-0003Jk-Bj; Wed, 11 Mar 2026 11:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w0Lpg-0003A4-74; Wed, 11 Mar 2026 11:50:50 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w0Lpc-0001Zt-Pd; Wed, 11 Mar 2026 11:50:47 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnbppNj7FpndwACA--.1400S2;
 Wed, 11 Mar 2026 23:50:37 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwW5JGj7Fpf8UAAA--.812S4;
 Wed, 11 Mar 2026 23:50:36 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v2 1/2] tests/qtest: Add attrs argument support to memory access
 commands
Date: Wed, 11 Mar 2026 23:49:33 +0800
Message-Id: <20260311154934.1575429-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
References: <20260311154934.1575429-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwW5JGj7Fpf8UAAA--.812S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQALBWmwb-oGPQAAs4
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZF18Gr4ktrWkXr48Aw13urg_yoW8CrWfuo
 WfKF1qy347Xwnruryq9r1kJrsrX3yUCr1qqws5tr1UKa409rn09ay3tFsxZFyjqayrGry8
 XFs2qrWfWr4Iy3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Extend qtest memory access commands to accept an optional attrs argument.

Supported attrs:
- secure (ARM/x86-only, lowercase)
- space=non-secure|secure|root|realm (ARM-only, lowercase)

For memory commands, parse attrs and select AddressSpace via
cpu_asidx_from_attrs(), then issue accesses with the corresponding
MemTxAttrs.

Expose matching libqtest APIs:
- qtest_{read,write}{b,w,l,q}_attrs()
- qtest_mem{read,write,set}_attrs()

Also add libqtest-single wrappers for the *_attrs helpers.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 system/qtest.c                | 266 ++++++++++++++++++++++++++++------
 tests/qtest/libqtest-single.h |  61 ++++++++
 tests/qtest/libqtest.c        | 148 +++++++++++++++++++
 tests/qtest/libqtest.h        |  25 ++++
 4 files changed, 453 insertions(+), 47 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index cf90cd53ad..dbf3a63c57 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -22,6 +22,7 @@
 #include "hw/core/qdev.h"
 #include "hw/core/irq.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/arm-security.h"
 #include "qemu/accel.h"
 #include "system/cpu-timers.h"
 #include "qemu/config-file.h"
@@ -218,6 +219,39 @@ static void *qtest_server_send_opaque;
  * B64_DATA is an arbitrarily long base64 encoded string.
  * If the sizes do not match, the data will be truncated.
  *
+ * Memory access with MemTxAttrs:
+ * """"""""""""""""""""""""""""""
+ *
+ * The following commands allow specifying memory transaction attributes,
+ * which is useful for testing devices that behave differently based on
+ * security state (e.g., ARM TrustZone/CCA or System Management Mode in x86).
+ *
+ * The memory access commands above support one optional ATTRS argument:
+ *
+ * .. code-block:: none
+ *
+ *  > writeb ADDR VALUE
+ *  < OK
+ *  > writeb ADDR VALUE secure
+ *  < OK
+ *  > writeb ADDR VALUE space=realm
+ *  < OK
+ *  > readb ADDR secure
+ *  < OK VALUE
+ *  > readb ADDR space=root
+ *  < OK VALUE
+ *  > read ADDR SIZE space=secure
+ *  < OK DATA
+ *  > write ADDR SIZE DATA secure
+ *  < OK
+ *  > memset ADDR SIZE VALUE space=non-secure
+ *  < OK
+ *
+ * ``secure`` sets MemTxAttrs.secure=1 (x86/ARM).
+ * ``space=...`` is ARM-specific and accepts:
+ * non-secure, secure, root, realm.
+ * ``space=non-secure`` is equivalent to omitting ATTRS.
+ *
  * IRQ management:
  * """""""""""""""
  *
@@ -353,6 +387,135 @@ static void qtest_install_gpio_out_intercept(DeviceState *dev, const char *name,
     *disconnected = qdev_intercept_gpio_out(dev, icpt, name, n);
 }
 
+static bool qtest_parse_mem_attrs(CharFrontend *chr, const char *arg,
+                                  MemTxAttrs *attrs)
+{
+    if (!arg) {
+        *attrs = MEMTXATTRS_UNSPECIFIED;
+        return true;
+    }
+
+    if (strcmp(arg, "secure") == 0) {
+        *attrs = (MemTxAttrs){ .secure = 1 };
+        return true;
+    }
+
+    if (strncmp(arg, "space=", 6) == 0) {
+        const char *space = arg + 6;
+        ARMSecuritySpace sec_space;
+
+        if (!target_arm() && !target_aarch64()) {
+            qtest_send(chr, "ERR space=<...> is ARM-specific\n");
+            return false;
+        }
+
+        if (strcmp(space, "non-secure") == 0) {
+            *attrs = MEMTXATTRS_UNSPECIFIED;
+            return true;
+        } else if (strcmp(space, "secure") == 0) {
+            sec_space = ARMSS_Secure;
+        } else if (strcmp(space, "root") == 0) {
+            sec_space = ARMSS_Root;
+        } else if (strcmp(space, "realm") == 0) {
+            sec_space = ARMSS_Realm;
+        } else {
+            qtest_send(chr, "ERR invalid space value. Valid space: "
+                            "secure/non-secure/root/realm\n");
+            return false;
+        }
+
+        *attrs = (MemTxAttrs){
+            .space = sec_space,
+            .secure = arm_space_is_secure(sec_space),
+        };
+        return true;
+    }
+
+    qtest_send(chr, "ERR invalid attrs argument\n");
+    return false;
+}
+
+static bool qtest_get_mem_as(CharFrontend *chr, MemTxAttrs attrs,
+                             AddressSpace **as)
+{
+    int asidx;
+
+    /*
+     * cpu_asidx_from_attrs mainly uses attrs to call ->asidx_from_attrs. We use
+     * first_cpu as it's readily available.
+     */
+
+    asidx = cpu_asidx_from_attrs(first_cpu, attrs);
+    *as = cpu_get_address_space(first_cpu, asidx);
+    if (!*as) {
+        qtest_send(chr, "ERR address space unavailable for attrs\n");
+        return false;
+    }
+
+    return true;
+}
+
+static void qtest_write_sized(AddressSpace *as, uint64_t addr, MemTxAttrs attrs,
+                              uint64_t value, char size)
+{
+    switch (size) {
+    case 'b': {
+        uint8_t data = value;
+        address_space_write(as, addr, attrs, &data, 1);
+        break;
+    }
+    case 'w': {
+        uint16_t data = value;
+        tswap16s(&data);
+        address_space_write(as, addr, attrs, &data, 2);
+        break;
+    }
+    case 'l': {
+        uint32_t data = value;
+        tswap32s(&data);
+        address_space_write(as, addr, attrs, &data, 4);
+        break;
+    }
+    case 'q': {
+        uint64_t data = value;
+        tswap64s(&data);
+        address_space_write(as, addr, attrs, &data, 8);
+        break;
+    }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint64_t qtest_read_sized(AddressSpace *as, uint64_t addr,
+                                 MemTxAttrs attrs, char size)
+{
+    switch (size) {
+    case 'b': {
+        uint8_t data;
+        address_space_read(as, addr, attrs, &data, 1);
+        return data;
+    }
+    case 'w': {
+        uint16_t data;
+        address_space_read(as, addr, attrs, &data, 2);
+        return tswap16(data);
+    }
+    case 'l': {
+        uint32_t data;
+        address_space_read(as, addr, attrs, &data, 4);
+        return tswap32(data);
+    }
+    case 'q': {
+        uint64_t data;
+        address_space_read(as, addr, attrs, &data, 8);
+        return tswap64(data);
+    }
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void qtest_process_command(CharFrontend *chr, gchar **words)
 {
     const gchar *command;
@@ -510,34 +673,25 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                strcmp(words[0], "writeq") == 0) {
         uint64_t addr;
         uint64_t value;
+        MemTxAttrs attrs;
+        AddressSpace *as;
         int ret;
 
         g_assert(words[1] && words[2]);
+        if (words[3] && words[4]) {
+            qtest_send(chr, "ERR too many arguments\n");
+            return;
+        }
         ret = qemu_strtou64(words[1], NULL, 0, &addr);
         g_assert(ret == 0);
         ret = qemu_strtou64(words[2], NULL, 0, &value);
         g_assert(ret == 0);
-
-        if (words[0][5] == 'b') {
-            uint8_t data = value;
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 1);
-        } else if (words[0][5] == 'w') {
-            uint16_t data = value;
-            tswap16s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 2);
-        } else if (words[0][5] == 'l') {
-            uint32_t data = value;
-            tswap32s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 4);
-        } else if (words[0][5] == 'q') {
-            uint64_t data = value;
-            tswap64s(&data);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                &data, 8);
+        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
         }
+
+        qtest_write_sized(as, addr, attrs, value, words[0][5]);
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "readb") == 0 ||
                strcmp(words[0], "readw") == 0 ||
@@ -545,50 +699,50 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                strcmp(words[0], "readq") == 0) {
         uint64_t addr;
         uint64_t value = UINT64_C(-1);
+        MemTxAttrs attrs;
+        AddressSpace *as;
         int ret;
 
         g_assert(words[1]);
+        if (words[2] && words[3]) {
+            qtest_send(chr, "ERR too many arguments\n");
+            return;
+        }
         ret = qemu_strtou64(words[1], NULL, 0, &addr);
         g_assert(ret == 0);
-
-        if (words[0][4] == 'b') {
-            uint8_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 1);
-            value = data;
-        } else if (words[0][4] == 'w') {
-            uint16_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 2);
-            value = tswap16(data);
-        } else if (words[0][4] == 'l') {
-            uint32_t data;
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &data, 4);
-            value = tswap32(data);
-        } else if (words[0][4] == 'q') {
-            address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                               &value, 8);
-            tswap64s(&value);
+        if (!qtest_parse_mem_attrs(chr, words[2], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
         }
+
+        value = qtest_read_sized(as, addr, attrs, words[0][4]);
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
         g_autoptr(GString) enc = NULL;
         uint64_t addr, len;
         uint8_t *data;
+        MemTxAttrs attrs;
+        AddressSpace *as;
         int ret;
 
         g_assert(words[1] && words[2]);
+        if (words[3] && words[4]) {
+            qtest_send(chr, "ERR too many arguments\n");
+            return;
+        }
         ret = qemu_strtou64(words[1], NULL, 0, &addr);
         g_assert(ret == 0);
         ret = qemu_strtou64(words[2], NULL, 0, &len);
         g_assert(ret == 0);
         /* We'd send garbage to libqtest if len is 0 */
         g_assert(len);
+        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
 
         data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
+        address_space_read(as, addr, attrs, data, len);
 
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
@@ -619,13 +773,23 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         uint64_t addr, len, i;
         uint8_t *data;
         size_t data_len;
+        MemTxAttrs attrs;
+        AddressSpace *as;
         int ret;
 
         g_assert(words[1] && words[2] && words[3]);
+        if (words[4] && words[5]) {
+            qtest_send(chr, "ERR too many arguments\n");
+            return;
+        }
         ret = qemu_strtou64(words[1], NULL, 0, &addr);
         g_assert(ret == 0);
         ret = qemu_strtou64(words[2], NULL, 0, &len);
         g_assert(ret == 0);
+        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
 
         data_len = strlen(words[3]);
         if (data_len < 3) {
@@ -642,8 +806,7 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+        address_space_write(as, addr, attrs, data, len);
         g_free(data);
 
         qtest_send(chr, "OK\n");
@@ -651,26 +814,35 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         uint64_t addr, len;
         uint8_t *data;
         unsigned long pattern;
+        MemTxAttrs attrs;
+        AddressSpace *as;
         int ret;
 
         g_assert(words[1] && words[2] && words[3]);
+        if (words[4] && words[5]) {
+            qtest_send(chr, "ERR too many arguments\n");
+            return;
+        }
         ret = qemu_strtou64(words[1], NULL, 0, &addr);
         g_assert(ret == 0);
         ret = qemu_strtou64(words[2], NULL, 0, &len);
         g_assert(ret == 0);
         ret = qemu_strtoul(words[3], NULL, 0, &pattern);
         g_assert(ret == 0);
+        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
 
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                data, len);
+            address_space_write(as, addr, attrs, data, len);
             g_free(data);
         }
 
         qtest_send(chr, "OK\n");
-    }  else if (strcmp(words[0], "b64write") == 0) {
+    } else if (strcmp(words[0], "b64write") == 0) {
         uint64_t addr, len;
         uint8_t *data;
         size_t data_len;
diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index 851724cbcb..38d05ee61e 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -291,6 +291,67 @@ static inline void memwrite(uint64_t addr, const void *data, size_t size)
     qtest_memwrite(global_qtest, addr, data, size);
 }
 
+/*
+ * Memory commands with optional attrs argument.
+ */
+static inline void writeb_attrs(uint64_t addr, uint8_t value, const char *attrs)
+{
+    qtest_writeb_attrs(global_qtest, addr, value, attrs);
+}
+
+static inline void writew_attrs(uint64_t addr, uint16_t value, const char *attrs)
+{
+    qtest_writew_attrs(global_qtest, addr, value, attrs);
+}
+
+static inline void writel_attrs(uint64_t addr, uint32_t value, const char *attrs)
+{
+    qtest_writel_attrs(global_qtest, addr, value, attrs);
+}
+
+static inline void writeq_attrs(uint64_t addr, uint64_t value, const char *attrs)
+{
+    qtest_writeq_attrs(global_qtest, addr, value, attrs);
+}
+
+static inline uint8_t readb_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readb_attrs(global_qtest, addr, attrs);
+}
+
+static inline uint16_t readw_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readw_attrs(global_qtest, addr, attrs);
+}
+
+static inline uint32_t readl_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readl_attrs(global_qtest, addr, attrs);
+}
+
+static inline uint64_t readq_attrs(uint64_t addr, const char *attrs)
+{
+    return qtest_readq_attrs(global_qtest, addr, attrs);
+}
+
+static inline void memread_attrs(uint64_t addr, void *data, size_t size,
+                                 const char *attrs)
+{
+    qtest_memread_attrs(global_qtest, addr, data, size, attrs);
+}
+
+static inline void memwrite_attrs(uint64_t addr, const void *data, size_t size,
+                                  const char *attrs)
+{
+    qtest_memwrite_attrs(global_qtest, addr, data, size, attrs);
+}
+
+static inline void memset_attrs(uint64_t addr, uint8_t pattern, size_t size,
+                                const char *attrs)
+{
+    qtest_memset_attrs(global_qtest, addr, pattern, size, attrs);
+}
+
 /**
  * clock_step_next:
  *
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 051faf31e1..a548331f7c 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1447,6 +1447,154 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
     qtest_rsp(s);
 }
 
+static bool qtest_has_attrs(const char *attrs)
+{
+    return attrs && attrs[0];
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
+void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
+                        const char *attrs)
+{
+    qtest_write_attrs(s, "writeb", addr, value, attrs);
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
+void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, const char *attrs)
+{
+    const uint8_t *ptr = data;
+    size_t i;
+    char *enc;
+
+    if (!size) {
+        return;
+    }
+
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
+    qtest_rsp(s);
+    g_free(enc);
+}
+
+void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t pattern,
+                        size_t size, const char *attrs)
+{
+    if (qtest_has_attrs(attrs)) {
+        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x %s\n",
+                    addr, size, pattern, attrs);
+    } else {
+        qtest_sendf(s, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n",
+                    addr, size, pattern);
+    }
+    qtest_rsp(s);
+}
+
 QDict *qtest_vqmp_assert_failure_ref(QTestState *qts,
                                      const char *fmt, va_list args)
 {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 9c118c89ca..d00a83478a 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -705,6 +705,31 @@ void qtest_bufwrite(QTestState *s, uint64_t addr,
  */
 void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
 
+/*
+ * Memory commands with optional attrs argument.
+ */
+
+void qtest_writeb_attrs(QTestState *s, uint64_t addr, uint8_t value,
+                        const char *attrs);
+void qtest_writew_attrs(QTestState *s, uint64_t addr, uint16_t value,
+                        const char *attrs);
+void qtest_writel_attrs(QTestState *s, uint64_t addr, uint32_t value,
+                        const char *attrs);
+void qtest_writeq_attrs(QTestState *s, uint64_t addr, uint64_t value,
+                        const char *attrs);
+
+uint8_t qtest_readb_attrs(QTestState *s, uint64_t addr, const char *attrs);
+uint16_t qtest_readw_attrs(QTestState *s, uint64_t addr, const char *attrs);
+uint32_t qtest_readl_attrs(QTestState *s, uint64_t addr, const char *attrs);
+uint64_t qtest_readq_attrs(QTestState *s, uint64_t addr, const char *attrs);
+
+void qtest_memread_attrs(QTestState *s, uint64_t addr, void *data, size_t size,
+                         const char *attrs);
+void qtest_memwrite_attrs(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, const char *attrs);
+void qtest_memset_attrs(QTestState *s, uint64_t addr, uint8_t patt, size_t size,
+                        const char *attrs);
+
 /**
  * qtest_clock_step_next:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


