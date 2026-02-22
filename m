Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99596C624D5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 08:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vu4mt-00010I-Ra; Sun, 22 Feb 2026 03:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vu4mq-0000yq-AA; Sun, 22 Feb 2026 03:25:56 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vu4mk-0005aH-3K; Sun, 22 Feb 2026 03:25:56 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDnPNCHvZppzxB3AA--.4403S2;
 Sun, 22 Feb 2026 16:25:43 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB3z+x9vZpp+HAcAA--.49763S4;
 Sun, 22 Feb 2026 16:25:40 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 1/2] tests/qtest: Support for memory access with secure/space
 attr
Date: Sun, 22 Feb 2026 16:25:28 +0800
Message-Id: <20260222082529.491384-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
References: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3z+x9vZpp+HAcAA--.49763S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWmaIJsAKQAAsr
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw13WFWxZF1xJF1xKry3Arb_yoW5tryfCo
 WSgF1qv3srJw47ur9a9r9rtr17W395uryxZr4Fyr15Ka4xur47uay3tF43Xr1qkF1rGr9r
 WF4kXF18Wr42y3s3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Introduce `*_secure` and `*_space` commands to the qtest protocol and
libqtest API. This allows testing devices that behave differently based
on security state (e.g., ARM TrustZone/CCA or x86 SMM).

- `*_secure` commands specify the SECURE parameter (0 or 1) and are
  compatible with x86 and ARM.
- `*_space` commands specify the ARM security space (0-3) and are
  ARM-specific.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 system/qtest.c                | 482 ++++++++++++++++++++++++++++++++++
 tests/qtest/libqtest-single.h | 133 ++++++++++
 tests/qtest/libqtest.c        | 249 ++++++++++++++++++
 tests/qtest/libqtest.h        | 281 ++++++++++++++++++++
 4 files changed, 1145 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index e42b83ce67..2140aaac99 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -217,6 +217,60 @@ static void *qtest_server_send_opaque;
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
+ * Two variants are available:
+ *
+ * 1. ``*_secure`` commands: Available on x86 and ARM.
+ * Only specifies the SECURE parameter (0 or 1).
+ * When SECURE=1, uses the secure AddressSpace. The asidx argument to
+ * cpu_get_address_space() can only be 1 on x86 (SMM mode, X86ASIdx_SMM) and
+ * ARM (Secure state, ARMASIdx_S); all other targets always use 0 for the asidx
+ * parameter. When issuing ``*_secure`` commands, we assert that the secure
+ * AddressSpace must exist.
+ *
+ * 2. ``*_space`` commands: ARM-specific.
+ * Only specifies the SPACE parameter (0-3).
+ * SECURE is auto-derived: secure=1 for Secure(0)/Root(2), secure=0 for
+ * NonSecure(1)/Realm(3), following ARM's arm_space_is_secure() semantics.
+ *
+ * Secure variants with .secure attribute (x86/ARM):
+ * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ *
+ * .. code-block:: none
+ *
+ *  > writeb_secure ADDR VALUE SECURE
+ *  < OK
+ *  > readb_secure ADDR SECURE
+ *  < OK VALUE
+ *  > read_secure ADDR SIZE SECURE
+ *  < OK DATA
+ *  > write_secure ADDR SIZE DATA SECURE
+ *  < OK
+ *  > memset_secure ADDR SIZE VALUE SECURE
+ *  < OK
+ *
+ * Space variants with .space attribute (ARM-specific):
+ * ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ *
+ * .. code-block:: none
+ *
+ *  > writeb_space ADDR VALUE SPACE
+ *  < OK
+ *  > readb_space ADDR SPACE
+ *  < OK VALUE
+ *  > read_space ADDR SIZE SPACE
+ *  < OK DATA
+ *  > write_space ADDR SIZE DATA SPACE
+ *  < OK
+ *  > memset_space ADDR SIZE VALUE SPACE
+ *  < OK
+ *
  * IRQ management:
  * """""""""""""""
  *
@@ -668,6 +722,434 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
             g_free(data);
         }
 
+        qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "writeb_secure") == 0 ||
+               strcmp(words[0], "writew_secure") == 0 ||
+               strcmp(words[0], "writel_secure") == 0 ||
+               strcmp(words[0], "writeq_secure") == 0) {
+        /*
+         * *_secure commands: x86/ARM compatible.
+         * Only specifies SECURE parameter.
+         */
+        uint64_t addr, value, secure;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        g_assert(words[1] && words[2] && words[3]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &value);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[3], NULL, 0, &secure);
+        g_assert(ret == 0);
+
+        attrs.secure = secure & 1;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            /* Secure AddressSpace must be available when issuing secure commands */
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        if (words[0][5] == 'b') {
+            uint8_t data = value;
+            address_space_write(as, addr, attrs, &data, 1);
+        } else if (words[0][5] == 'w') {
+            uint16_t data = value;
+            tswap16s(&data);
+            address_space_write(as, addr, attrs, &data, 2);
+        } else if (words[0][5] == 'l') {
+            uint32_t data = value;
+            tswap32s(&data);
+            address_space_write(as, addr, attrs, &data, 4);
+        } else if (words[0][5] == 'q') {
+            uint64_t data = value;
+            tswap64s(&data);
+            address_space_write(as, addr, attrs, &data, 8);
+        }
+        qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "readb_secure") == 0 ||
+               strcmp(words[0], "readw_secure") == 0 ||
+               strcmp(words[0], "readl_secure") == 0 ||
+               strcmp(words[0], "readq_secure") == 0) {
+        uint64_t addr, secure;
+        uint64_t value = UINT64_C(-1);
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        g_assert(words[1] && words[2]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &secure);
+        g_assert(ret == 0);
+
+        attrs.secure = secure & 1;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        if (words[0][4] == 'b') {
+            uint8_t data;
+            address_space_read(as, addr, attrs, &data, 1);
+            value = data;
+        } else if (words[0][4] == 'w') {
+            uint16_t data;
+            address_space_read(as, addr, attrs, &data, 2);
+            value = tswap16(data);
+        } else if (words[0][4] == 'l') {
+            uint32_t data;
+            address_space_read(as, addr, attrs, &data, 4);
+            value = tswap32(data);
+        } else if (words[0][4] == 'q') {
+            address_space_read(as, addr, attrs, &value, 8);
+            tswap64s(&value);
+        }
+        qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
+    } else if (strcmp(words[0], "read_secure") == 0) {
+        g_autoptr(GString) enc = NULL;
+        uint64_t addr, len, secure;
+        uint8_t *data;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        g_assert(words[1] && words[2] && words[3]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[3], NULL, 0, &secure);
+        g_assert(ret == 0);
+        g_assert(len);
+
+        attrs.secure = secure & 1;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        data = g_malloc(len);
+        address_space_read(as, addr, attrs, data, len);
+
+        enc = qemu_hexdump_line(NULL, data, len, 0, 0);
+        qtest_sendf(chr, "OK 0x%s\n", enc->str);
+        g_free(data);
+    } else if (strcmp(words[0], "write_secure") == 0) {
+        uint64_t addr, len, i, secure;
+        uint8_t *data;
+        size_t data_len;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        g_assert(words[1] && words[2] && words[3] && words[4]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[4], NULL, 0, &secure);
+        g_assert(ret == 0);
+
+        data_len = strlen(words[3]);
+        if (data_len < 3) {
+            qtest_send(chr, "ERR invalid argument size\n");
+            return;
+        }
+
+        attrs.secure = secure & 1;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        data = g_malloc(len);
+        for (i = 0; i < len; i++) {
+            if ((i * 2 + 4) <= data_len) {
+                data[i] = hex2nib(words[3][i * 2 + 2]) << 4;
+                data[i] |= hex2nib(words[3][i * 2 + 3]);
+            } else {
+                data[i] = 0;
+            }
+        }
+        address_space_write(as, addr, attrs, data, len);
+        g_free(data);
+
+        qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "memset_secure") == 0) {
+        uint64_t addr, len, secure;
+        uint8_t *data;
+        unsigned long pattern;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        g_assert(words[1] && words[2] && words[3] && words[4]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtoul(words[3], NULL, 0, &pattern);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[4], NULL, 0, &secure);
+        g_assert(ret == 0);
+
+        attrs.secure = secure & 1;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        if (len) {
+            data = g_malloc(len);
+            memset(data, pattern, len);
+            address_space_write(as, addr, attrs, data, len);
+            g_free(data);
+        }
+
+        qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "writeb_space") == 0 ||
+               strcmp(words[0], "writew_space") == 0 ||
+               strcmp(words[0], "writel_space") == 0 ||
+               strcmp(words[0], "writeq_space") == 0) {
+        /* *_space commands: ARM-specific. */
+        uint64_t addr, value, space;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        if (!target_arm() && !target_aarch64()) {
+            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
+            return;
+        }
+
+        g_assert(words[1] && words[2] && words[3]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &value);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[3], NULL, 0, &space);
+        g_assert(ret == 0);
+
+        attrs.space = space & 3;
+        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        if (words[0][5] == 'b') {
+            uint8_t data = value;
+            address_space_write(as, addr, attrs, &data, 1);
+        } else if (words[0][5] == 'w') {
+            uint16_t data = value;
+            tswap16s(&data);
+            address_space_write(as, addr, attrs, &data, 2);
+        } else if (words[0][5] == 'l') {
+            uint32_t data = value;
+            tswap32s(&data);
+            address_space_write(as, addr, attrs, &data, 4);
+        } else if (words[0][5] == 'q') {
+            uint64_t data = value;
+            tswap64s(&data);
+            address_space_write(as, addr, attrs, &data, 8);
+        }
+        qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "readb_space") == 0 ||
+               strcmp(words[0], "readw_space") == 0 ||
+               strcmp(words[0], "readl_space") == 0 ||
+               strcmp(words[0], "readq_space") == 0) {
+        uint64_t addr, space;
+        uint64_t value = UINT64_C(-1);
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        if (!target_arm() && !target_aarch64()) {
+            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
+            return;
+        }
+
+        g_assert(words[1] && words[2]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &space);
+        g_assert(ret == 0);
+
+        attrs.space = space & 3;
+        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        if (words[0][4] == 'b') {
+            uint8_t data;
+            address_space_read(as, addr, attrs, &data, 1);
+            value = data;
+        } else if (words[0][4] == 'w') {
+            uint16_t data;
+            address_space_read(as, addr, attrs, &data, 2);
+            value = tswap16(data);
+        } else if (words[0][4] == 'l') {
+            uint32_t data;
+            address_space_read(as, addr, attrs, &data, 4);
+            value = tswap32(data);
+        } else if (words[0][4] == 'q') {
+            address_space_read(as, addr, attrs, &value, 8);
+            tswap64s(&value);
+        }
+        qtest_sendf(chr, "OK 0x%016" PRIx64 "\n", value);
+    } else if (strcmp(words[0], "read_space") == 0) {
+        g_autoptr(GString) enc = NULL;
+        uint64_t addr, len, space;
+        uint8_t *data;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        if (!target_arm() && !target_aarch64()) {
+            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
+            return;
+        }
+
+        g_assert(words[1] && words[2] && words[3]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[3], NULL, 0, &space);
+        g_assert(ret == 0);
+        g_assert(len);
+
+        attrs.space = space & 3;
+        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        data = g_malloc(len);
+        address_space_read(as, addr, attrs, data, len);
+
+        enc = qemu_hexdump_line(NULL, data, len, 0, 0);
+        qtest_sendf(chr, "OK 0x%s\n", enc->str);
+        g_free(data);
+    } else if (strcmp(words[0], "write_space") == 0) {
+        uint64_t addr, len, i, space;
+        uint8_t *data;
+        size_t data_len;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        if (!target_arm() && !target_aarch64()) {
+            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
+            return;
+        }
+
+        g_assert(words[1] && words[2] && words[3] && words[4]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[4], NULL, 0, &space);
+        g_assert(ret == 0);
+
+        data_len = strlen(words[3]);
+        if (data_len < 3) {
+            qtest_send(chr, "ERR invalid argument size\n");
+            return;
+        }
+
+        attrs.space = space & 3;
+        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        data = g_malloc(len);
+        for (i = 0; i < len; i++) {
+            if ((i * 2 + 4) <= data_len) {
+                data[i] = hex2nib(words[3][i * 2 + 2]) << 4;
+                data[i] |= hex2nib(words[3][i * 2 + 3]);
+            } else {
+                data[i] = 0;
+            }
+        }
+        address_space_write(as, addr, attrs, data, len);
+        g_free(data);
+
+        qtest_send(chr, "OK\n");
+    } else if (strcmp(words[0], "memset_space") == 0) {
+        uint64_t addr, len, space;
+        uint8_t *data;
+        unsigned long pattern;
+        MemTxAttrs attrs;
+        AddressSpace *as;
+        int ret;
+
+        if (!target_arm() && !target_aarch64()) {
+            qtest_send(chr, "ERR *_space commands are ARM-specific\n");
+            return;
+        }
+
+        g_assert(words[1] && words[2] && words[3] && words[4]);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtoul(words[3], NULL, 0, &pattern);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[4], NULL, 0, &space);
+        g_assert(ret == 0);
+
+        attrs.space = space & 3;
+        attrs.secure = (attrs.space == 0 || attrs.space == 2) ? 1 : 0;
+
+        if (attrs.secure) {
+            as = cpu_get_address_space(first_cpu, 1);
+            g_assert(as);
+        } else {
+            as = first_cpu->as;
+        }
+
+        if (len) {
+            data = g_malloc(len);
+            memset(data, pattern, len);
+            address_space_write(as, addr, attrs, data, len);
+            g_free(data);
+        }
+
         qtest_send(chr, "OK\n");
     }  else if (strcmp(words[0], "b64write") == 0) {
         uint64_t addr, len;
diff --git a/tests/qtest/libqtest-single.h b/tests/qtest/libqtest-single.h
index 851724cbcb..d7c89154e3 100644
--- a/tests/qtest/libqtest-single.h
+++ b/tests/qtest/libqtest-single.h
@@ -291,6 +291,139 @@ static inline void memwrite(uint64_t addr, const void *data, size_t size)
     qtest_memwrite(global_qtest, addr, data, size);
 }
 
+/*
+ * *_secure commands: only available with x86/ARM.
+ */
+
+static inline void writeb_secure(uint64_t addr, uint8_t value,
+                                 unsigned secure)
+{
+    qtest_writeb_secure(global_qtest, addr, value, secure);
+}
+
+static inline void writew_secure(uint64_t addr, uint16_t value,
+                                 unsigned secure)
+{
+    qtest_writew_secure(global_qtest, addr, value, secure);
+}
+
+static inline void writel_secure(uint64_t addr, uint32_t value,
+                                 unsigned secure)
+{
+    qtest_writel_secure(global_qtest, addr, value, secure);
+}
+
+static inline void writeq_secure(uint64_t addr, uint64_t value,
+                                 unsigned secure)
+{
+    qtest_writeq_secure(global_qtest, addr, value, secure);
+}
+
+static inline uint8_t readb_secure(uint64_t addr, unsigned secure)
+{
+    return qtest_readb_secure(global_qtest, addr, secure);
+}
+
+static inline uint16_t readw_secure(uint64_t addr, unsigned secure)
+{
+    return qtest_readw_secure(global_qtest, addr, secure);
+}
+
+static inline uint32_t readl_secure(uint64_t addr, unsigned secure)
+{
+    return qtest_readl_secure(global_qtest, addr, secure);
+}
+
+static inline uint64_t readq_secure(uint64_t addr, unsigned secure)
+{
+    return qtest_readq_secure(global_qtest, addr, secure);
+}
+
+static inline void memread_secure(uint64_t addr, void *data, size_t size,
+                                  unsigned secure)
+{
+    qtest_memread_secure(global_qtest, addr, data, size, secure);
+}
+
+static inline void memwrite_secure(uint64_t addr, const void *data,
+                                   size_t size, unsigned secure)
+{
+    qtest_memwrite_secure(global_qtest, addr, data, size, secure);
+}
+
+static inline void memset_secure(uint64_t addr, uint8_t pattern,
+                                 size_t size, unsigned secure)
+{
+    qtest_memset_secure(global_qtest, addr, pattern, size, secure);
+}
+
+/**
+ * *_space commands: ARM-specific.
+ * Only specifies SPACE parameter, SECURE is auto-derived using
+ * arm_space_is_secure-like semantics.
+ */
+static inline void writeb_space(uint64_t addr, uint8_t value,
+                                unsigned space)
+{
+    qtest_writeb_space(global_qtest, addr, value, space);
+}
+
+static inline void writew_space(uint64_t addr, uint16_t value,
+                                unsigned space)
+{
+    qtest_writew_space(global_qtest, addr, value, space);
+}
+
+static inline void writel_space(uint64_t addr, uint32_t value,
+                                unsigned space)
+{
+    qtest_writel_space(global_qtest, addr, value, space);
+}
+
+static inline void writeq_space(uint64_t addr, uint64_t value,
+                                unsigned space)
+{
+    qtest_writeq_space(global_qtest, addr, value, space);
+}
+
+static inline uint8_t readb_space(uint64_t addr, unsigned space)
+{
+    return qtest_readb_space(global_qtest, addr, space);
+}
+
+static inline uint16_t readw_space(uint64_t addr, unsigned space)
+{
+    return qtest_readw_space(global_qtest, addr, space);
+}
+
+static inline uint32_t readl_space(uint64_t addr, unsigned space)
+{
+    return qtest_readl_space(global_qtest, addr, space);
+}
+
+static inline uint64_t readq_space(uint64_t addr, unsigned space)
+{
+    return qtest_readq_space(global_qtest, addr, space);
+}
+
+static inline void memread_space(uint64_t addr, void *data, size_t size,
+                                 unsigned space)
+{
+    qtest_memread_space(global_qtest, addr, data, size, space);
+}
+
+static inline void memwrite_space(uint64_t addr, const void *data,
+                                  size_t size, unsigned space)
+{
+    qtest_memwrite_space(global_qtest, addr, data, size, space);
+}
+
+static inline void memset_space(uint64_t addr, uint8_t pattern,
+                                size_t size, unsigned space)
+{
+    qtest_memset_space(global_qtest, addr, pattern, size, space);
+}
+
 /**
  * clock_step_next:
  *
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 794d870085..308428829b 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1447,6 +1447,255 @@ void qtest_memset(QTestState *s, uint64_t addr, uint8_t pattern, size_t size)
     qtest_rsp(s);
 }
 
+/**
+ * qtest_*_secure commands: only available with x86/ARM.
+ */
+static void qtest_write_secure(QTestState *s, const char *cmd, uint64_t addr,
+                               uint64_t value, unsigned secure)
+{
+    qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %u\n",
+                cmd, addr, value, secure);
+    qtest_rsp(s);
+}
+
+static uint64_t qtest_read_secure(QTestState *s, const char *cmd,
+                                  uint64_t addr, unsigned secure)
+{
+    gchar **args;
+    int ret;
+    uint64_t value;
+
+    qtest_sendf(s, "%s 0x%" PRIx64 " %u\n", cmd, addr, secure);
+    args = qtest_rsp_args(s, 2);
+    ret = qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
+    g_strfreev(args);
+
+    return value;
+}
+
+void qtest_writeb_secure(QTestState *s, uint64_t addr, uint8_t value,
+                         unsigned secure)
+{
+    qtest_write_secure(s, "writeb_secure", addr, value, secure);
+}
+
+void qtest_writew_secure(QTestState *s, uint64_t addr, uint16_t value,
+                         unsigned secure)
+{
+    qtest_write_secure(s, "writew_secure", addr, value, secure);
+}
+
+void qtest_writel_secure(QTestState *s, uint64_t addr, uint32_t value,
+                         unsigned secure)
+{
+    qtest_write_secure(s, "writel_secure", addr, value, secure);
+}
+
+void qtest_writeq_secure(QTestState *s, uint64_t addr, uint64_t value,
+                         unsigned secure)
+{
+    qtest_write_secure(s, "writeq_secure", addr, value, secure);
+}
+
+uint8_t qtest_readb_secure(QTestState *s, uint64_t addr, unsigned secure)
+{
+    return qtest_read_secure(s, "readb_secure", addr, secure);
+}
+
+uint16_t qtest_readw_secure(QTestState *s, uint64_t addr, unsigned secure)
+{
+    return qtest_read_secure(s, "readw_secure", addr, secure);
+}
+
+uint32_t qtest_readl_secure(QTestState *s, uint64_t addr, unsigned secure)
+{
+    return qtest_read_secure(s, "readl_secure", addr, secure);
+}
+
+uint64_t qtest_readq_secure(QTestState *s, uint64_t addr, unsigned secure)
+{
+    return qtest_read_secure(s, "readq_secure", addr, secure);
+}
+
+void qtest_memread_secure(QTestState *s, uint64_t addr, void *data,
+                          size_t size, unsigned secure)
+{
+    uint8_t *ptr = data;
+    gchar **args;
+    size_t i;
+
+    if (!size) {
+        return;
+    }
+
+    qtest_sendf(s, "read_secure 0x%" PRIx64 " 0x%zx %u\n", addr, size, secure);
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
+void qtest_memwrite_secure(QTestState *s, uint64_t addr, const void *data,
+                           size_t size, unsigned secure)
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
+    qtest_sendf(s, "write_secure 0x%" PRIx64 " 0x%zx 0x%s %u\n",
+                addr, size, enc, secure);
+    qtest_rsp(s);
+    g_free(enc);
+}
+
+void qtest_memset_secure(QTestState *s, uint64_t addr, uint8_t pattern,
+                         size_t size, unsigned secure)
+{
+    qtest_sendf(s, "memset_secure 0x%" PRIx64 " 0x%zx 0x%02x %u\n",
+                addr, size, pattern, secure);
+    qtest_rsp(s);
+}
+
+/**
+ * *_space commands: ARM-specific
+ */
+
+static void qtest_write_space(QTestState *s, const char *cmd,
+                              uint64_t addr, uint64_t value, unsigned space)
+{
+    qtest_sendf(s, "%s 0x%" PRIx64 " 0x%" PRIx64 " %u\n",
+                cmd, addr, value, space);
+    qtest_rsp(s);
+}
+
+static uint64_t qtest_read_space(QTestState *s, const char *cmd,
+                                 uint64_t addr, unsigned space)
+{
+    gchar **args;
+    int ret;
+    uint64_t value;
+
+    qtest_sendf(s, "%s 0x%" PRIx64 " %u\n", cmd, addr, space);
+    args = qtest_rsp_args(s, 2);
+    ret = qemu_strtou64(args[1], NULL, 0, &value);
+    g_assert(!ret);
+    g_strfreev(args);
+
+    return value;
+}
+
+void qtest_writeb_space(QTestState *s, uint64_t addr, uint8_t value,
+                        unsigned space)
+{
+    qtest_write_space(s, "writeb_space", addr, value, space);
+}
+
+void qtest_writew_space(QTestState *s, uint64_t addr, uint16_t value,
+                        unsigned space)
+{
+    qtest_write_space(s, "writew_space", addr, value, space);
+}
+
+void qtest_writel_space(QTestState *s, uint64_t addr, uint32_t value,
+                        unsigned space)
+{
+    qtest_write_space(s, "writel_space", addr, value, space);
+}
+
+void qtest_writeq_space(QTestState *s, uint64_t addr, uint64_t value,
+                        unsigned space)
+{
+    qtest_write_space(s, "writeq_space", addr, value, space);
+}
+
+uint8_t qtest_readb_space(QTestState *s, uint64_t addr, unsigned space)
+{
+    return qtest_read_space(s, "readb_space", addr, space);
+}
+
+uint16_t qtest_readw_space(QTestState *s, uint64_t addr, unsigned space)
+{
+    return qtest_read_space(s, "readw_space", addr, space);
+}
+
+uint32_t qtest_readl_space(QTestState *s, uint64_t addr, unsigned space)
+{
+    return qtest_read_space(s, "readl_space", addr, space);
+}
+
+uint64_t qtest_readq_space(QTestState *s, uint64_t addr, unsigned space)
+{
+    return qtest_read_space(s, "readq_space", addr, space);
+}
+
+void qtest_memread_space(QTestState *s, uint64_t addr, void *data,
+                         size_t size, unsigned space)
+{
+    uint8_t *ptr = data;
+    gchar **args;
+    size_t i;
+
+    if (!size) {
+        return;
+    }
+
+    qtest_sendf(s, "read_space 0x%" PRIx64 " 0x%zx %u\n", addr, size, space);
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
+void qtest_memwrite_space(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, unsigned space)
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
+    qtest_sendf(s, "write_space 0x%" PRIx64 " 0x%zx 0x%s %u\n",
+                addr, size, enc, space);
+    qtest_rsp(s);
+    g_free(enc);
+}
+
+void qtest_memset_space(QTestState *s, uint64_t addr, uint8_t pattern,
+                        size_t size, unsigned space)
+{
+    qtest_sendf(s, "memset_space 0x%" PRIx64 " 0x%zx 0x%02x %u\n",
+                addr, size, pattern, space);
+    qtest_rsp(s);
+}
+
 QDict *qtest_vqmp_assert_failure_ref(QTestState *qts,
                                      const char *fmt, va_list args)
 {
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 9c118c89ca..57d6be7ca8 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -705,6 +705,287 @@ void qtest_bufwrite(QTestState *s, uint64_t addr,
  */
 void qtest_memset(QTestState *s, uint64_t addr, uint8_t patt, size_t size);
 
+/*
+ * qtest_*_secure commands: only available with x86/ARM.
+ */
+
+/**
+ * qtest_writeb_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Writes an 8-bit value to memory with secure attribute (x86/ARM).
+ */
+void qtest_writeb_secure(QTestState *s, uint64_t addr, uint8_t value,
+                         unsigned secure);
+
+/**
+ * qtest_writew_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Writes a 16-bit value to memory with secure attribute (x86/ARM).
+ */
+void qtest_writew_secure(QTestState *s, uint64_t addr, uint16_t value,
+                         unsigned secure);
+
+/**
+ * qtest_writel_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Writes a 32-bit value to memory with secure attribute (x86/ARM).
+ */
+void qtest_writel_secure(QTestState *s, uint64_t addr, uint32_t value,
+                         unsigned secure);
+
+/**
+ * qtest_writeq_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Writes a 64-bit value to memory with secure attribute (x86/ARM).
+ */
+void qtest_writeq_secure(QTestState *s, uint64_t addr, uint64_t value,
+                         unsigned secure);
+
+/**
+ * qtest_readb_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Reads an 8-bit value from memory with secure attribute (x86/ARM).
+ *
+ * Returns: Value read.
+ */
+uint8_t qtest_readb_secure(QTestState *s, uint64_t addr, unsigned secure);
+
+/**
+ * qtest_readw_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Reads a 16-bit value from memory with secure attribute (x86/ARM).
+ *
+ * Returns: Value read.
+ */
+uint16_t qtest_readw_secure(QTestState *s, uint64_t addr, unsigned secure);
+
+/**
+ * qtest_readl_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Reads a 32-bit value from memory with secure attribute (x86/ARM).
+ *
+ * Returns: Value read.
+ */
+uint32_t qtest_readl_secure(QTestState *s, uint64_t addr, unsigned secure);
+
+/**
+ * qtest_readq_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Reads a 64-bit value from memory with secure attribute (x86/ARM).
+ *
+ * Returns: Value read.
+ */
+uint64_t qtest_readq_secure(QTestState *s, uint64_t addr, unsigned secure);
+
+/**
+ * qtest_memread_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @data: Pointer to where memory contents will be stored.
+ * @size: Number of bytes to read.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Read guest memory into a buffer with secure attribute (x86/ARM).
+ */
+void qtest_memread_secure(QTestState *s, uint64_t addr, void *data,
+                          size_t size, unsigned secure);
+
+/**
+ * qtest_memwrite_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes that will be written to guest memory.
+ * @size: Number of bytes to write.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Write a buffer to guest memory with secure attribute (x86/ARM).
+ */
+void qtest_memwrite_secure(QTestState *s, uint64_t addr, const void *data,
+                           size_t size, unsigned secure);
+
+/**
+ * qtest_memset_secure:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @patt: Byte pattern to fill the guest memory region with.
+ * @size: Number of bytes to write.
+ * @secure: 1 for secure access, 0 for non-secure.
+ *
+ * Write a pattern to guest memory with secure attribute (x86/ARM).
+ */
+void qtest_memset_secure(QTestState *s, uint64_t addr, uint8_t patt,
+                         size_t size, unsigned secure);
+
+
+/*
+ * qtest_*_space commands: ARM-specific.
+ * Only specifies SPACE parameter, SECURE is auto-derived using
+ * arm_space_is_secure-like semantics.
+ */
+
+/**
+ * qtest_writeb_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Writes an 8-bit value to memory with ARM security space (ARM-specific).
+ */
+void qtest_writeb_space(QTestState *s, uint64_t addr, uint8_t value,
+                        unsigned space);
+
+/**
+ * qtest_writew_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Writes a 16-bit value to memory with ARM security space (ARM-specific).
+ */
+void qtest_writew_space(QTestState *s, uint64_t addr, uint16_t value,
+                        unsigned space);
+
+/**
+ * qtest_writel_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Writes a 32-bit value to memory with ARM security space (ARM-specific).
+ */
+void qtest_writel_space(QTestState *s, uint64_t addr, uint32_t value,
+                        unsigned space);
+
+/**
+ * qtest_writeq_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @value: Value being written.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Writes a 64-bit value to memory with ARM security space (ARM-specific).
+ */
+void qtest_writeq_space(QTestState *s, uint64_t addr, uint64_t value,
+                        unsigned space);
+
+/**
+ * qtest_readb_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Reads an 8-bit value from memory with ARM security space (ARM-specific).
+ *
+ * Returns: Value read.
+ */
+uint8_t qtest_readb_space(QTestState *s, uint64_t addr, unsigned space);
+
+/**
+ * qtest_readw_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Reads a 16-bit value from memory with ARM security space (ARM-specific).
+ *
+ * Returns: Value read.
+ */
+uint16_t qtest_readw_space(QTestState *s, uint64_t addr, unsigned space);
+
+/**
+ * qtest_readl_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Reads a 32-bit value from memory with ARM security space (ARM-specific).
+ *
+ * Returns: Value read.
+ */
+uint32_t qtest_readl_space(QTestState *s, uint64_t addr, unsigned space);
+
+/**
+ * qtest_readq_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Reads a 64-bit value from memory with ARM security space (ARM-specific).
+ *
+ * Returns: Value read.
+ */
+uint64_t qtest_readq_space(QTestState *s, uint64_t addr, unsigned space);
+
+/**
+ * qtest_memread_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to read from.
+ * @data: Pointer to where memory contents will be stored.
+ * @size: Number of bytes to read.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Read guest memory into a buffer with ARM security space (ARM-specific).
+ */
+void qtest_memread_space(QTestState *s, uint64_t addr, void *data,
+                         size_t size, unsigned space);
+
+/**
+ * qtest_memwrite_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @data: Pointer to the bytes that will be written to guest memory.
+ * @size: Number of bytes to write.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Write a buffer to guest memory with ARM security space (ARM-specific).
+ */
+void qtest_memwrite_space(QTestState *s, uint64_t addr, const void *data,
+                          size_t size, unsigned space);
+
+/**
+ * qtest_memset_space:
+ * @s: #QTestState instance to operate on.
+ * @addr: Guest address to write to.
+ * @patt: Byte pattern to fill the guest memory region with.
+ * @size: Number of bytes to write.
+ * @space: Security space (0=Secure, 1=NonSecure, 2=Root, 3=Realm).
+ *
+ * Write a pattern to guest memory with ARM security space (ARM-specific).
+ */
+void qtest_memset_space(QTestState *s, uint64_t addr, uint8_t patt,
+                        size_t size, unsigned space);
+
 /**
  * qtest_clock_step_next:
  * @s: #QTestState instance to operate on.
-- 
2.34.1


