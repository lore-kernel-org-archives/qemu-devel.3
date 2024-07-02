Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF56C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 01:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOS2e-0005St-Jz; Mon, 01 Jul 2024 21:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2a-0005S0-6k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sOS2X-0002Ch-0L
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 21:10:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2c8e422c40cso2056688a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 18:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719882633; x=1720487433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niG05aeHHNe9KFZ6CFq0rHqwgfpKzMy35BwCLWmdTuk=;
 b=GLC0jB47ZWvdDlN0m0r3gkdVfxLqoVYonXWx9ynkwVPkT6KMbZ/LoqD0URRdGtwHkK
 aaOJMUJVV5PLt8EENmwMSeoDZh4qZ5HFzs2EcHttAzwWryEeQbhetv7gDYt776w6xYcJ
 kU4Hnae5P/PArfw4uUVwG/uEYPl8BUiYcZFxIDjyEb5IJzGwoLnj8pwxjvFE6wsYuYsS
 pa1uMJHzt56g7RFhuc4G+8oT92SkXNFUhXoQ9RPDH7ivne1oreVcqoi1TaGHJ1Kb9ulU
 SpDoVZk8pA2LBD9rjluRBYj362AJ/O1e8SzBCy2bknIPn1Kcx6BLUGDVPQsEKJfiVt2j
 OrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719882633; x=1720487433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niG05aeHHNe9KFZ6CFq0rHqwgfpKzMy35BwCLWmdTuk=;
 b=UDeZBZms6QRJlKA/TeKUeSC5XcINidnfNn9ufAEXBG4uD/kjPuVRyvzrXDLSLnmw/Y
 gaMX1DlfLLtgBb+NU1icPkO/qO5SoQ6o2KgoIoiWRLKAdXqbqSwtC5d0V+j6t0t+ZiQ8
 olqeIyFMXgV0mQNUjkpuTmd6J1NZlB5kvW0KD2+Lus2zsOConfAaaQINofcpdSJKPFpG
 9MrUHWrPjLdy8DANTvFl969W0PpcuRx7WD43NnEhcJfNLUbdcea+vb7iWzCs79KZ/+u/
 r4N2ccRhodKQdUs5PrcB6bCFJ8sQE8Bt5QxDVKpuBr75ojBlbilr4Ro+t2wjHlP+zgs+
 g1IQ==
X-Gm-Message-State: AOJu0Yyw+8DyPWrfjaFpvdg5PBk/fc+8oBheBepqbLpfa13HwUqYcOkV
 ozpZqbQB30wBmYKpJM6cuWeKtibFAiQZJiIKjrj96np3Vemn+m65ugSwziFMA9/m7Mi03kYFBdJ
 W
X-Google-Smtp-Source: AGHT+IFeVIJejR7NcndOcOkH/PAMYNUur46+kb3o27/zCmgKorHaokJ+IgJmXUVv7OoEH5t9XSQZug==
X-Received: by 2002:a17:90b:230f:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2c93d700070mr4251981a91.18.1719882632648; 
 Mon, 01 Jul 2024 18:10:32 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c91ce1f198sm7480317a91.2.2024.07.01.18.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 18:10:31 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v3 7/7] tests/tcg/x86_64: add test for plugin memory access
Date: Mon,  1 Jul 2024 18:10:15 -0700
Message-Id: <20240702011015.325609-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
References: <20240702011015.325609-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Add an explicit test to check expected memory values are read/written.
For sizes 8, 16, 32, 64 and 128, we generate a load/store operation.
For size 8 -> 64, we generate an atomic __sync_val_compare_and_swap too.
For 128bits memory access, we rely on SSE2 instructions.

By default, atomic accesses are non atomic if a single cpu is running,
so we force creation of a second one by creating a new thread first.

load/store helpers code path can't be triggered easily in user mode (no
softmmu), so we can't test it here.

Can be run with:
make -C build/tests/tcg/x86_64-linux-user run-plugin-test-plugin-mem-access-with-libmem.so

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/x86_64/test-plugin-mem-access.c   | 89 +++++++++++++++++++++
 tests/tcg/x86_64/Makefile.target            |  7 ++
 tests/tcg/x86_64/check-plugin-mem-access.sh | 48 +++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 tests/tcg/x86_64/test-plugin-mem-access.c
 create mode 100755 tests/tcg/x86_64/check-plugin-mem-access.sh

diff --git a/tests/tcg/x86_64/test-plugin-mem-access.c b/tests/tcg/x86_64/test-plugin-mem-access.c
new file mode 100644
index 00000000000..7fdd6a55829
--- /dev/null
+++ b/tests/tcg/x86_64/test-plugin-mem-access.c
@@ -0,0 +1,89 @@
+#include <emmintrin.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+static void *data;
+
+#define DEFINE_STORE(name, type, value) \
+static void store_##name(void)          \
+{                                       \
+    *((type *)data) = value;            \
+}
+
+#define DEFINE_ATOMIC_OP(name, type, value)                 \
+static void atomic_op_##name(void)                          \
+{                                                           \
+    *((type *)data) = 0x42;                                 \
+    __sync_val_compare_and_swap((type *)data, 0x42, value); \
+}
+
+#define DEFINE_LOAD(name, type)                         \
+static void load_##name(void)                           \
+{                                                       \
+    register type var asm("eax") = *((type *) data);    \
+    (void)var;                                          \
+}
+
+DEFINE_STORE(u8, uint8_t, 0xf1)
+DEFINE_ATOMIC_OP(u8, uint8_t, 0xf1)
+DEFINE_LOAD(u8, uint8_t)
+DEFINE_STORE(u16, uint16_t, 0xf123)
+DEFINE_ATOMIC_OP(u16, uint16_t, 0xf123)
+DEFINE_LOAD(u16, uint16_t)
+DEFINE_STORE(u32, uint32_t, 0xff112233)
+DEFINE_ATOMIC_OP(u32, uint32_t, 0xff112233)
+DEFINE_LOAD(u32, uint32_t)
+DEFINE_STORE(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_ATOMIC_OP(u64, uint64_t, 0xf123456789abcdef)
+DEFINE_LOAD(u64, uint64_t)
+
+static void store_u128(void)
+{
+    _mm_store_si128(data, _mm_set_epi32(0xf1223344, 0x55667788,
+                                        0xf1234567, 0x89abcdef));
+}
+
+static void load_u128(void)
+{
+    __m128i var = _mm_load_si128(data);
+    (void)var;
+}
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
+    data = malloc(sizeof(__m128i));
+    atomic_op_u8();
+    store_u8();
+    load_u8();
+
+    atomic_op_u16();
+    store_u16();
+    load_u16();
+
+    atomic_op_u32();
+    store_u32();
+    load_u32();
+
+    atomic_op_u64();
+    store_u64();
+    load_u64();
+
+    store_u128();
+    load_u128();
+
+    free(data);
+}
diff --git a/tests/tcg/x86_64/Makefile.target b/tests/tcg/x86_64/Makefile.target
index 5fedf221174..5f7015fd8b4 100644
--- a/tests/tcg/x86_64/Makefile.target
+++ b/tests/tcg/x86_64/Makefile.target
@@ -14,6 +14,7 @@ X86_64_TESTS += noexec
 X86_64_TESTS += cmpxchg
 X86_64_TESTS += adox
 X86_64_TESTS += test-1648
+PLUGINS_TESTS += test-plugin-mem-access
 TESTS=$(MULTIARCH_TESTS) $(X86_64_TESTS) test-x86_64
 else
 TESTS=$(MULTIARCH_TESTS)
@@ -24,6 +25,12 @@ adox: CFLAGS=-O2
 run-test-i386-ssse3: QEMU_OPTS += -cpu max
 run-plugin-test-i386-ssse3-%: QEMU_OPTS += -cpu max
 
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	PLUGIN_ARGS=$(COMMA)print-accesses=true
+run-plugin-test-plugin-mem-access-with-libmem.so: \
+	CHECK_PLUGIN_OUTPUT_COMMAND= \
+	$(SRC_PATH)/tests/tcg/x86_64/check-plugin-mem-access.sh
+
 test-x86_64: LDFLAGS+=-lm -lc
 test-x86_64: test-i386.c test-i386.h test-i386-shift.h test-i386-muldiv.h
 	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/x86_64/check-plugin-mem-access.sh b/tests/tcg/x86_64/check-plugin-mem-access.sh
new file mode 100755
index 00000000000..92008e25a93
--- /dev/null
+++ b/tests/tcg/x86_64/check-plugin-mem-access.sh
@@ -0,0 +1,48 @@
+#!/usr/bin/env bash
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
+[ $# -eq 1 ] || die "usage: plugin_out_file"
+
+plugin_out=$1
+
+expected()
+{
+    cat << EOF
+,store_u8,.*,8,store,0xf1
+,atomic_op_u8,.*,8,load,0x42
+,atomic_op_u8,.*,8,store,0xf1
+,load_u8,.*,8,load,0xf1
+,store_u16,.*,16,store,0xf123
+,atomic_op_u16,.*,16,load,0x42
+,atomic_op_u16,.*,16,store,0xf123
+,load_u16,.*,16,load,0xf123
+,store_u32,.*,32,store,0xff112233
+,atomic_op_u32,.*,32,load,0x42
+,atomic_op_u32,.*,32,store,0xff112233
+,load_u32,.*,32,load,0xff112233
+,store_u64,.*,64,store,0xf123456789abcdef
+,atomic_op_u64,.*,64,load,0x42
+,atomic_op_u64,.*,64,store,0xf123456789abcdef
+,load_u64,.*,64,load,0xf123456789abcdef
+,store_u128,.*,128,store,0xf122334455667788f123456789abcdef
+,load_u128,.*,128,load,0xf122334455667788f123456789abcdef
+EOF
+}
+
+expected | while read line; do
+    check "$plugin_out" "$line"
+done
-- 
2.39.2


