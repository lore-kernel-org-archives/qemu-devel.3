Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7CA606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSUwX-0008V5-Dm; Sun, 15 Nov 2026 02:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwS-0008Tq-U3; Sun, 15 Nov 2026 02:46:26 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwN-0004oC-Ca; Sun, 15 Nov 2026 02:46:24 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBXneRGY_lqf5owBg--.2726S2;
 Sun, 15 Nov 2026 15:46:14 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFnQ_Y_lqF+j6AA--.34770S4;
 Sun, 15 Nov 2026 15:46:13 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 1/5] tests/qtest: Add attrs support to qtest server memory
 commands
Date: Sun, 15 Nov 2026 15:46:03 +0800
Message-Id: <20261115074607.456045-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
References: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFnQ_Y_lqF+j6AA--.34770S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWr4tsgAcAAAsY
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoW3uryrCrW8urWfKF1DCr1UAwb_yoW8Gw4fCo
 WSgFnFya47t3Z7Cr929r1DJ34DXayUur97AwsYkwn8Kay8WrWq9ay5JFsxWa4jqayrGryk
 X3WfXr4xXF1jv397n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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
 SPF_PASS=-0.001, WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT,WEIRD_QUOTING
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend qtest memory access commands to accept an optional attrs argument.

Supported attrs:
- secure (x86/Arm)
- space=non-secure|secure|root|realm (Arm-only)

For memory commands, parse attrs, select the corresponding AddressSpace
with cpu_asidx_from_attrs(), and issue accesses with the matching
MemTxAttrs.

Cover scalar and bulk memory commands, including:
- read{b,w,l,q} / write{b,w,l,q}
- read / write
- b64read / b64write
- memset

Also reject invalid attrs and excessive arguments, and document the new
command forms in qtest.c, and use qtest_send_memtx_error() to return
ERR for memory access failures.

Preserve legacy no-attrs semantics for compatibility: those commands
continue to ignore MemTxResult and return OK.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 system/qtest.c | 349 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 293 insertions(+), 56 deletions(-)

diff --git a/system/qtest.c b/system/qtest.c
index 5ff3f9f27d8..d0fd11f3502 100644
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
@@ -122,6 +123,14 @@ IrqInterceptState irq_intercept_state;
  * PIO and memory access:
  * """"""""""""""""""""""
  *
+ * Memory access commands allow specifying memory transaction attributes,
+ * which is useful for testing devices that behave differently based on
+ * security state (e.g., Arm TrustZone/CCA or System Management Mode in x86).
+ *
+ * Only the following attributes are supported by the qtest server:
+ * ``secure`` sets MemTxAttrs.secure=1 (x86/Arm).
+ * ``space=...`` is Arm-specific and accepts: non-secure, secure, root, realm.
+ *
  * .. code-block:: none
  *
  *  > outb ADDR VALUE
@@ -217,6 +226,36 @@ IrqInterceptState irq_intercept_state;
  *  > memset ADDR SIZE VALUE
  *  < OK
  *
+ * Memory commands accept an optional ATTRS argument after their existing
+ * operands:
+ *
+ * .. code-block:: none
+ *
+ *  > read{b,w,l,q} ADDR [ATTRS]
+ *  > write{b,w,l,q} ADDR VALUE [ATTRS]
+ *  > read ADDR SIZE [ATTRS]
+ *  > write ADDR SIZE DATA [ATTRS]
+ *  > b64read ADDR SIZE [ATTRS]
+ *  > b64write ADDR SIZE B64_DATA [ATTRS]
+ *  > memset ADDR SIZE VALUE [ATTRS]
+ *
+ * Representative examples:
+ *
+ * .. code-block:: none
+ *
+ *  > readl ADDR secure
+ *  < OK VALUE
+ *
+ * .. code-block:: none
+ *
+ *  > b64read ADDR SIZE space=root
+ *  < OK B64_DATA
+ *
+ * .. code-block:: none
+ *
+ *  > writeq ADDR VALUE space=realm
+ *  < OK
+ *
  * ADDR, SIZE, VALUE are all integers parsed with strtoul() with a base of 0.
  * For 'memset' a zero size is permitted and does nothing.
  *
@@ -367,6 +406,141 @@ static void qtest_init_irq_intercept(int num_irqs)
     irq_intercept_state.num_irqs = num_irqs;
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
+            qtest_send(chr, "ERR space=<...> is Arm-specific\n");
+            return false;
+        }
+
+        if (strcmp(space, "non-secure") == 0) {
+            sec_space = ARMSS_NonSecure;
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
+static void qtest_send_memtx_error(CharFrontend *chr, MemTxResult result)
+{
+    qtest_sendf(chr, "ERR memory access failed 0x%x\n", result);
+}
+
+static MemTxResult qtest_write_sized(AddressSpace *as, uint64_t addr,
+                                     MemTxAttrs attrs, uint64_t value,
+                                     char size)
+{
+    switch (size) {
+    case 'b': {
+        uint8_t data = value;
+        return address_space_write(as, addr, attrs, &data, 1);
+    }
+    case 'w': {
+        uint16_t data = value;
+        tswap16s(&data);
+        return address_space_write(as, addr, attrs, &data, 2);
+    }
+    case 'l': {
+        uint32_t data = value;
+        tswap32s(&data);
+        return address_space_write(as, addr, attrs, &data, 4);
+    }
+    case 'q': {
+        uint64_t data = value;
+        tswap64s(&data);
+        return address_space_write(as, addr, attrs, &data, 8);
+    }
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static MemTxResult qtest_read_sized(AddressSpace *as, uint64_t addr,
+                                    MemTxAttrs attrs, char size,
+                                    uint64_t *value)
+{
+    switch (size) {
+    case 'b': {
+        uint8_t data = 0;
+        MemTxResult result = address_space_read(as, addr, attrs, &data, 1);
+        *value = data;
+        return result;
+    }
+    case 'w': {
+        uint16_t data = 0;
+        MemTxResult result = address_space_read(as, addr, attrs, &data, 2);
+        *value = tswap16(data);
+        return result;
+    }
+    case 'l': {
+        uint32_t data = 0;
+        MemTxResult result = address_space_read(as, addr, attrs, &data, 4);
+        *value = tswap32(data);
+        return result;
+    }
+    case 'q': {
+        uint64_t data = 0;
+        MemTxResult result = address_space_read(as, addr, attrs, &data, 8);
+        *value = tswap64(data);
+        return result;
+    }
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static void qtest_process_command(CharFrontend *chr, gchar **words)
 {
     const gchar *command;
@@ -527,33 +701,29 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                strcmp(words[0], "writeq") == 0) {
         uint64_t addr;
         uint64_t value;
+        MemTxResult result;
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
+        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
 
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
+        result = qtest_write_sized(as, addr, attrs, value, words[0][5]);
+        if (words[3] && result != MEMTX_OK) {
+            qtest_send_memtx_error(chr, result);
+            return;
         }
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "readb") == 0 ||
@@ -561,51 +731,62 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                strcmp(words[0], "readl") == 0 ||
                strcmp(words[0], "readq") == 0) {
         uint64_t addr;
-        uint64_t value = UINT64_C(-1);
+        uint64_t value = 0;
+        MemTxResult result;
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
+        if (!qtest_parse_mem_attrs(chr, words[2], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
 
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
+        result = qtest_read_sized(as, addr, attrs, words[0][4], &value);
+        if (words[2] && result != MEMTX_OK) {
+            qtest_send_memtx_error(chr, result);
+            return;
         }
         qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
     } else if (strcmp(words[0], "read") == 0) {
         g_autoptr(GString) enc = NULL;
         uint64_t addr, len;
         uint8_t *data;
+        MemTxResult result;
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
 
-        data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
+        data = g_malloc0(len);
+        result = address_space_read(as, addr, attrs, data, len);
+        if (words[3] && result != MEMTX_OK) {
+            g_free(data);
+            qtest_send_memtx_error(chr, result);
+            return;
+        }
 
         enc = qemu_hexdump_line(NULL, data, len, 0, 0);
 
@@ -616,17 +797,32 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         uint64_t addr, len;
         uint8_t *data;
         gchar *b64_data;
+        MemTxResult result;
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
+        if (!qtest_parse_mem_attrs(chr, words[3], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
 
-        data = g_malloc(len);
-        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                           len);
+        data = g_malloc0(len);
+        result = address_space_read(as, addr, attrs, data, len);
+        if (words[3] && result != MEMTX_OK) {
+            g_free(data);
+            qtest_send_memtx_error(chr, result);
+            return;
+        }
         b64_data = g_base64_encode(data, len);
         qtest_sendf(chr, "OK %s\n", b64_data);
 
@@ -636,14 +832,20 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
         uint64_t addr, len, i;
         uint8_t *data;
         size_t data_len;
+        MemTxResult result;
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
-
         data_len = strlen(words[3]);
         if (data_len < 3) {
             qtest_send(chr, "ERR invalid argument size\n");
@@ -659,47 +861,75 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            len);
+        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            g_free(data);
+            return;
+        }
+        result = address_space_write(as, addr, attrs, data, len);
         g_free(data);
+        if (words[4] && result != MEMTX_OK) {
+            qtest_send_memtx_error(chr, result);
+            return;
+        }
 
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "memset") == 0) {
         uint64_t addr, len;
-        uint8_t *data;
         unsigned long pattern;
+        MemTxResult result;
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
-            data = g_malloc(len);
+            uint8_t *data = g_malloc(len);
+
             memset(data, pattern, len);
-            address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
-                                data, len);
+            result = address_space_write(as, addr, attrs, data, len);
             g_free(data);
+            if (words[4] && result != MEMTX_OK) {
+                qtest_send_memtx_error(chr, result);
+                return;
+            }
         }
 
         qtest_send(chr, "OK\n");
-    }  else if (strcmp(words[0], "b64write") == 0) {
+    } else if (strcmp(words[0], "b64write") == 0) {
         uint64_t addr, len;
         uint8_t *data;
         size_t data_len;
         gsize out_len;
+        MemTxResult result;
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
-
         data_len = strlen(words[3]);
         if (data_len < 3) {
             qtest_send(chr, "ERR invalid argument size\n");
@@ -714,8 +944,15 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
-                            out_len);
+        if (!qtest_parse_mem_attrs(chr, words[4], &attrs) ||
+            !qtest_get_mem_as(chr, attrs, &as)) {
+            return;
+        }
+        result = address_space_write(as, addr, attrs, data, out_len);
+        if (words[4] && result != MEMTX_OK) {
+            qtest_send_memtx_error(chr, result);
+            return;
+        }
 
         qtest_send(chr, "OK\n");
     } else if (strcmp(words[0], "endianness") == 0) {
-- 
2.34.1


