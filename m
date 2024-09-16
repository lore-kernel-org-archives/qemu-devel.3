Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7576BC3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 08:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sq7VZ-0001ot-B2; Mon, 16 Sep 2024 04:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7V6-0000QL-MB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:29 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sq7Up-0005Dp-8U
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 04:54:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb2191107so31972825e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726476850; x=1727081650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdCrRRlRbQfrNYdX9012mUfHcuVziNRXWE1crIIitX8=;
 b=aAj8LQO8sfdN72nmwp/oeo9vlw+PQbC1gqmemm77W3q5YPwZA6hs3C6kf4X1MQTKXL
 4TWNnxwv72dp2oVGuidg6ktEgrxyeOepeV8GmXbitd5wrfwBMRJfjBJyaY9RwRT7C3Zx
 zv/rI3tyCsHKWua0WJiiVXGZW3xu9lWCuVAR6ctPvjS6tzB0KPTZyyuIreOdo8E7HbGC
 IC/t3MawgqA31sRA0LQfHBcSXXZxBc65bP3Lz/pm3/3kXgOvDSlCrAWx80etOruryNTf
 6CiNMpx1WKi+RfZ4xITFyAtsMxMYpVzQ1M865J6HWzjU6vsx5mJEGbZUm6iBErMUNJML
 Rl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726476850; x=1727081650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdCrRRlRbQfrNYdX9012mUfHcuVziNRXWE1crIIitX8=;
 b=iSXLRADJkfYB1Go5TaYgFjT8iRLx0JO9D8hIOvFfOg8GT4u5jW2vDOlkwIXkGHCSl6
 E2KG9MMJMN0n4t/ZyO/HyPCLBqFV86x189X7p4/DZXavBhzohYJYrKVAp00A15kI+/YE
 wAMMO5y4bjXesWu0wrMQo+23gL9FxgAcwnD99GKSNZwOFRuRYbWy44vGRi2/Tn1DE8+Q
 uRb4xndovPZNav7krWoraqTQbm1GjUHBTIPPQtUwe4qNR3AmK0qwyPNngAiljW16RAUp
 d/tcWwOoizWchchVn6ne6mje/Eya2JmHCs6KmYpxLrjIZWodq9TW+Wz67VAziY4u+g8+
 i3ww==
X-Gm-Message-State: AOJu0Yy3NxKZXC9/7246cB8pJDfme8AiXDYyDh11KJ99uYNS3ncWT7Zn
 Oz+USIY4GkGZNBIjATOrQVOhuyVeNfm0/pdVM14Sgg9pCoN2NP/VhZTnTfsY8LA=
X-Google-Smtp-Source: AGHT+IEUo2zCSJoAcfYzlnOzFML2Y6zAZpROqGFgxaHmZ0jIkU7+sea7zLY5RrSQzXu6VAb7LtEhww==
X-Received: by 2002:a05:600c:3b1d:b0:42a:a6aa:4135 with SMTP id
 5b1f17b1804b1-42cdb53fab7mr86097495e9.20.1726476849465; 
 Mon, 16 Sep 2024 01:54:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78044dfsm6572115f8f.94.2024.09.16.01.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 01:54:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CD275F952;
 Mon, 16 Sep 2024 09:54:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 09/18] tests/tcg/multiarch: add test for plugin memory
 access
Date: Mon, 16 Sep 2024 09:53:51 +0100
Message-Id: <20240916085400.1046925-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240916085400.1046925-1-alex.bennee@linaro.org>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Add an explicit test to check expected memory values are read/written.
8,16,32 load/store are tested for all arch.
64,128 load/store are tested for aarch64/x64.
atomic operations (8,16,32,64) are tested for x64 only.

By default, atomic accesses are non atomic if a single cpu is running,
so we force creation of a second one by creating a new thread first.

load/store helpers code path can't be triggered easily in user mode (no
softmmu), so we can't test it here.

Output of test-plugin-mem-access.c is the list of expected patterns in
plugin output. By reading stdout, we can compare to plugins output and
have a multiarch test.

Can be run with:
make -C build/tests/tcg/$ARCH-linux-user run-plugin-test-plugin-mem-access-with-libmem.so

Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240910172033.1427812-7-pierrick.bouvier@linaro.org>
---
 tests/tcg/multiarch/test-plugin-mem-access.c | 177 +++++++++++++++++++
 tests/tcg/alpha/Makefile.target              |   3 +
 tests/tcg/multiarch/Makefile.target          |  11 ++
 tests/tcg/multiarch/check-plugin-output.sh   |  36 ++++
 tests/tcg/ppc64/Makefile.target              |   5 +
 5 files changed, 232 insertions(+)
 create mode 100644 tests/tcg/multiarch/test-plugin-mem-access.c
 create mode 100755 tests/tcg/multiarch/check-plugin-output.sh

diff --git a/tests/tcg/multiarch/test-plugin-mem-access.c b/tests/tcg/multiarch/test-plugin-mem-access.c
new file mode 100644
index 0000000000..057b9aac9f
--- /dev/null
+++ b/tests/tcg/multiarch/test-plugin-mem-access.c
@@ -0,0 +1,177 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Check if we detect all memory accesses expected using plugin API.
+ * Used in conjunction with ./check-plugin-mem-access.sh check script.
+ * Output of this program is the list of patterns expected in plugin output.
+ *
+ * 8,16,32 load/store are tested for all arch.
+ * 64,128 load/store are tested for aarch64/x64.
+ * atomic operations (8,16,32,64) are tested for x64 only.
+ */
+
+#include <pthread.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#if defined(__x86_64__)
+#include <emmintrin.h>
+#elif defined(__aarch64__)
+#include <arm_neon.h>
+#endif /* __x86_64__ */
+
+static void *data;
+
+/* ,store_u8,.*,8,store,0xf1 */
+#define PRINT_EXPECTED(function, type, value, action)                 \
+do {                                                                  \
+    printf(",%s,.*,%d,%s,%s\n",                                       \
+           #function, (int) sizeof(type) * 8, action, value);         \
+}                                                                     \
+while (0)
+
+#define DEFINE_STORE(name, type, value)                  \
+                                                         \
+static void print_expected_store_##name(void)            \
+{                                                        \
+    PRINT_EXPECTED(store_##name, type, #value, "store"); \
+}                                                        \
+                                                         \
+static void store_##name(void)                           \
+{                                                        \
+    *((type *)data) = value;                             \
+    print_expected_store_##name();                       \
+}
+
+#define DEFINE_ATOMIC_OP(name, type, value)                    \
+                                                               \
+static void print_expected_atomic_op_##name(void)              \
+{                                                              \
+    PRINT_EXPECTED(atomic_op_##name, type, "0x0*42", "load");  \
+    PRINT_EXPECTED(atomic_op_##name, type, #value, "store");   \
+}                                                              \
+                                                               \
+static void atomic_op_##name(void)                             \
+{                                                              \
+    *((type *)data) = 0x42;                                    \
+    __sync_val_compare_and_swap((type *)data, 0x42, value);    \
+    print_expected_atomic_op_##name();                         \
+}
+
+#define DEFINE_LOAD(name, type, value)                  \
+                                                        \
+static void print_expected_load_##name(void)            \
+{                                                       \
+    PRINT_EXPECTED(load_##name, type, #value, "load");  \
+}                                                       \
+                                                        \
+static void load_##name(void)                           \
+{                                                       \
+                                                        \
+    /* volatile forces load to be generated. */         \
+    volatile type src = *((type *) data);               \
+    volatile type dest = src;                           \
+    (void)src, (void)dest;                              \
+    print_expected_load_##name();                       \
+}
+
+DEFINE_STORE(u8, uint8_t, 0xf1)
+DEFINE_LOAD(u8, uint8_t, 0xf1)
+DEFINE_STORE(u16, uint16_t, 0xf123)
+DEFINE_LOAD(u16, uint16_t, 0xf123)
+DEFINE_STORE(u32, uint32_t, 0xff112233)
+DEFINE_LOAD(u32, uint32_t, 0xff112233)
+
+#if defined(__x86_64__) || defined(__aarch64__)
+DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_LOAD(u64, uint64_t, 0xf123456789abcdef)
+
+static void print_expected_store_u128(void)
+{
+    PRINT_EXPECTED(store_u128, __int128,
+                   "0xf122334455667788f123456789abcdef", "store");
+}
+
+static void store_u128(void)
+{
+#ifdef __x86_64__
+    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
+                                        0xf1234567, 0x89abcdef));
+#else
+    const uint32_t init[4] = {0x89abcdef, 0xf1234567, 0x55667788, 0xf1223344};
+    uint32x4_t vec = vld1q_u32(init);
+    vst1q_u32(data, vec);
+#endif /* __x86_64__ */
+    print_expected_store_u128();
+}
+
+static void print_expected_load_u128(void)
+{
+    PRINT_EXPECTED(load_u128, __int128,
+                   "0xf122334455667788f123456789abcdef", "load");
+}
+
+static void load_u128(void)
+{
+#ifdef __x86_64__
+    __m128i var = _mm_load_si128(data);
+#else
+    uint32x4_t var = vld1q_u32(data);
+#endif
+    (void) var;
+    print_expected_load_u128();
+}
+#endif /* __x86_64__ || __aarch64__ */
+
+#if defined(__x86_64__)
+DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
+DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
+DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
+DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
+#endif /* __x86_64__ */
+
+static void *f(void *p)
+{
+    return NULL;
+}
+
+int main(void)
+{
+    /*
+     * We force creation of a second thread to enable cpu flag CF_PARALLEL.
+     * This will generate atomic operations when needed.
+     */
+    pthread_t thread;
+    pthread_create(&thread, NULL, &f, NULL);
+    pthread_join(thread, NULL);
+
+    /* allocate storage up to 128 bits */
+    data = malloc(16);
+
+    store_u8();
+    load_u8();
+
+    store_u16();
+    load_u16();
+
+    store_u32();
+    load_u32();
+
+#if defined(__x86_64__) || defined(__aarch64__)
+    store_u64();
+    load_u64();
+
+    store_u128();
+    load_u128();
+#endif /* __x86_64__ || __aarch64__ */
+
+#if defined(__x86_64__)
+    atomic_op_u8();
+    atomic_op_u16();
+    atomic_op_u32();
+    atomic_op_u64();
+#endif /* __x86_64__ */
+
+    free(data);
+}
diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index fdd7ddf64e..36d8ed1eae 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -12,4 +12,7 @@ test-cmov: EXTRA_CFLAGS=-DTEST_CMOV
 test-cmov: test-cond.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
+# Force generation of byte read/write
+test-plugin-mem-access: CFLAGS+=-mbwx
+
 run-test-cmov: test-cmov
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 5e3391ec9d..78b83d5575 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -170,5 +170,16 @@ run-plugin-semiconsole-with-%:
 TESTS += semihosting semiconsole
 endif
 
+# Test plugin memory access instrumentation
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	PLUGIN_ARGS=$(COMMA)print-accesses=true
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	CHECK_PLUGIN_OUTPUT_COMMAND= \
+	$(SRC_PATH)/tests/tcg/multiarch/check-plugin-output.sh \
+	$(QEMU) $<
+
+test-plugin-mem-access: CFLAGS+=-pthread -O0
+test-plugin-mem-access: LDFLAGS+=-pthread -O0
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)
diff --git a/tests/tcg/multiarch/check-plugin-output.sh b/tests/tcg/multiarch/check-plugin-output.sh
new file mode 100755
index 0000000000..80607f04b5
--- /dev/null
+++ b/tests/tcg/multiarch/check-plugin-output.sh
@@ -0,0 +1,36 @@
+#!/usr/bin/env bash
+
+# This script runs a given executable using qemu, and compare its standard
+# output with an expected plugin output.
+# Each line of output is searched (as a regexp) in the expected plugin output.
+
+set -euo pipefail
+
+die()
+{
+    echo "$@" 1>&2
+    exit 1
+}
+
+check()
+{
+    file=$1
+    pattern=$2
+    grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
+}
+
+[ $# -eq 3 ] || die "usage: qemu_bin exe plugin_out_file"
+
+qemu_bin=$1; shift
+exe=$1;shift
+plugin_out=$1; shift
+
+expected()
+{
+    $qemu_bin $exe ||
+        die "running $exe failed"
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
index 509a20be2b..1940886c73 100644
--- a/tests/tcg/ppc64/Makefile.target
+++ b/tests/tcg/ppc64/Makefile.target
@@ -55,4 +55,9 @@ PPC64_TESTS += signal_save_restore_xer
 PPC64_TESTS += xxspltw
 PPC64_TESTS += test-aes
 
+# ppc64 ABI uses function descriptors, and thus, QEMU can't find symbol for a
+# given instruction. Thus, we don't check output of mem-access plugin.
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+ CHECK_PLUGIN_OUTPUT_COMMAND=
+
 TESTS += $(PPC64_TESTS)
-- 
2.39.5


