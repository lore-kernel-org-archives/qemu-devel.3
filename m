Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79C9F46C53
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lyn-0007Ci-Fg; Mon, 06 Apr 2026 11:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w9lyl-0007CI-Db
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:35:07 -0400
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w9lyh-0008C9-PW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:35:07 -0400
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id AB1E110272B30;
 Mon,  6 Apr 2026 23:34:45 +0800 (CST)
Received: from xuklXiaoxin (unknown [202.120.32.222])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 78EC537C8CA;
 Mon,  6 Apr 2026 23:34:45 +0800 (CST)
From: XU Kailiang <xukl2019@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 XU Kailiang <xukl2019@sjtu.edu.cn>
Subject: [PATCH v2 1/1] contrib/plugins: add syscall-filter passthrough zlib
 demo
Date: Mon,  6 Apr 2026 23:32:52 +0800
Message-ID: <20260406153331.8846-2-xukl2019@sjtu.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406153331.8846-1-xukl2019@sjtu.edu.cn>
References: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
 <20260406153331.8846-1-xukl2019@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232; envelope-from=xukl2019@sjtu.edu.cn;
 helo=smtp232.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a linux-user syscall-filter plugin that handles a small passthrough
protocol over a dedicated magic syscall number. The plugin supports three
operations: load HTL module, resolve HTL symbol, and invoke HTL entry with
a flat void * argument array plus return pointer.

Also add a zlib example under contrib/plugins/passthrough-examples/:
- guest thunk library (GTL): libz.so
- host thunk library (HTL): libz_HTL.so
- guest demo program: zlib-demo

The GTL constructor loads/resolves HTL entries through the plugin, wrapper
functions forward calls via the magic syscall, and the destructor closes the
HTL handle.

Build split:
- Meson builds host-side artifacts (plugin + HTL).
- Makefile builds guest-side artifacts (GTL + demo), with GUEST_CC
  overridable for cross guest builds.

Documentation is added to docs/about/emulation.rst and the example README
with reproducible build/run steps and current scope limitations (64-bit
little-endian guests, guest_base == 0 assumption for the demo).

Signed-off-by: XU Kailiang <xukl2019@sjtu.edu.cn>
Co-authored-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 contrib/plugins/meson.build                   |  11 ++
 contrib/plugins/passthrough-examples/Makefile |  23 +++
 .../plugins/passthrough-examples/README.rst   |  60 +++++++
 .../plugins/passthrough-examples/meson.build  |  19 ++
 .../passthrough-examples/passthrough-gtl.c    |  41 +++++
 .../passthrough-examples/passthrough-gtl.h    |  17 ++
 .../plugins/passthrough-examples/zlib-demo.c  |  90 ++++++++++
 .../plugins/passthrough-examples/zlib-gtl.c   |  72 ++++++++
 .../plugins/passthrough-examples/zlib-htl.c   |  37 ++++
 contrib/plugins/passthrough-protocol.h        |  14 ++
 contrib/plugins/passthrough.c                 | 162 ++++++++++++++++++
 docs/about/emulation.rst                      |  33 ++++
 12 files changed, 579 insertions(+)
 create mode 100644 contrib/plugins/passthrough-examples/Makefile
 create mode 100644 contrib/plugins/passthrough-examples/README.rst
 create mode 100644 contrib/plugins/passthrough-examples/meson.build
 create mode 100644 contrib/plugins/passthrough-examples/passthrough-gtl.c
 create mode 100644 contrib/plugins/passthrough-examples/passthrough-gtl.h
 create mode 100644 contrib/plugins/passthrough-examples/zlib-demo.c
 create mode 100644 contrib/plugins/passthrough-examples/zlib-gtl.c
 create mode 100644 contrib/plugins/passthrough-examples/zlib-htl.c
 create mode 100644 contrib/plugins/passthrough-protocol.h
 create mode 100644 contrib/plugins/passthrough.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 099319e7a1..70ab219c30 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -14,9 +14,18 @@ contrib_plugins = [
 'uftrace.c',
 ]
 
+passthrough_host_supported = (
+  host_os != 'darwin' and
+  host_machine.endian() == 'little' and
+  ['x86_64', 'aarch64', 'riscv64'].contains(host_machine.cpu_family())
+)
+
 if host_os != 'windows'
   # lockstep uses socket.h
   contrib_plugins += 'lockstep.c'
+  if passthrough_host_supported
+    contrib_plugins += 'passthrough.c'
+  endif
 endif
 
 if 'cpp' in all_languages
@@ -36,4 +45,6 @@ else
   run_target('contrib-plugins', command: [python, '-c', ''])
 endif
 
+subdir('passthrough-examples')
+
 plugin_modules += t
diff --git a/contrib/plugins/passthrough-examples/Makefile b/contrib/plugins/passthrough-examples/Makefile
new file mode 100644
index 0000000000..bf97d359ae
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+GUEST_CC ?= cc
+GUEST_CPPFLAGS ?=
+GUEST_CFLAGS ?=
+GUEST_LDFLAGS ?=
+RM ?= rm -f
+
+all: libz.so zlib-demo
+
+libz.so: zlib-gtl.c passthrough-gtl.c passthrough-gtl.h ../passthrough-protocol.h
+	$(GUEST_CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) -fPIC -shared \
+		zlib-gtl.c passthrough-gtl.c -Wl,-soname,libz.so \
+		-o $@ $(GUEST_LDFLAGS)
+
+zlib-demo: zlib-demo.c libz.so
+	$(GUEST_CC) $(GUEST_CPPFLAGS) $(GUEST_CFLAGS) zlib-demo.c -L. -lz \
+		-o $@ $(GUEST_LDFLAGS)
+
+clean:
+	$(RM) libz.so zlib-demo
+
+.PHONY: all clean
diff --git a/contrib/plugins/passthrough-examples/README.rst b/contrib/plugins/passthrough-examples/README.rst
new file mode 100644
index 0000000000..5551b63256
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/README.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Passthrough syscall-filter example
+==================================
+
+This directory contains a zlib demo for ``contrib/plugins/passthrough.c``.
+
+* ``libz.so`` is the guest thunk library (GTL). It exports zlib symbols to the
+  guest program.
+* ``libz_HTL.so`` is the host thunk library (HTL). It links to native zlib.
+* ``zlib-demo.c`` calls ``compressBound()``, ``compress2()``, and
+  ``uncompress()`` through normal zlib APIs.
+
+The GTL constructor initializes passthrough in three steps:
+
+1. Send a magic syscall to request loading the HTL for ``libz.so``.
+2. Send magic syscalls to resolve HTL entry addresses
+   (``compressBound_HTL``, ``compress2_HTL``, ``uncompress_HTL``).
+3. Cache those function pointers in GTL globals.
+
+The GTL destructor sends a magic syscall to close the loaded HTL handle.
+
+Each GTL wrapper then sends a magic syscall with:
+
+* the cached HTL function pointer,
+* a flat ``void *args[]`` payload holding addresses of wrapper-local argument
+  variables,
+* and a ``void *ret_ptr`` return-storage address.
+
+This example assumes 64-bit little-endian linux-user guests. To keep it small,
+it also assumes ``guest_base == 0`` on a little-endian 64-bit host.
+
+Direct execution of host callbacks back into guest translated code is not
+covered here. That requires additional target- and ABI-specific handling
+beyond this demo.
+
+Build:
+
+.. code-block:: sh
+
+  # 1) Build host-side passthrough pieces in QEMU's Meson tree.
+  #    This produces libpassthrough.so and libz_HTL.so.
+  ninja -C /path/to/qemu/build contrib-passthrough-examples
+
+  # 2) Build guest-side GTL + demo in this directory.
+  #    By default GUEST_CC=cc; override it for cross guest builds.
+  make
+  # make GUEST_CC=aarch64-linux-gnu-gcc
+
+Run:
+
+.. code-block:: sh
+
+  QEMU_BUILD=/path/to/qemu/build
+  HTL_DIR=$QEMU_BUILD/contrib/plugins/passthrough-examples
+  $QEMU_BUILD/qemu-x86_64 \
+    -E LD_LIBRARY_PATH=$PWD \
+    -plugin $QEMU_BUILD/contrib/plugins/libpassthrough.so,htl_dir=$HTL_DIR \
+    -d plugin \
+    ./zlib-demo
diff --git a/contrib/plugins/passthrough-examples/meson.build b/contrib/plugins/passthrough-examples/meson.build
new file mode 100644
index 0000000000..75f0420e1e
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/meson.build
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+passthrough_examples = []
+
+if passthrough_host_supported and get_option('plugins')
+  libz_htl = shared_library(
+    'z_HTL',
+    files('zlib-htl.c'),
+    install: false,
+    dependencies: [zlib],
+  )
+  passthrough_examples += [libz_htl]
+endif
+
+if passthrough_examples.length() > 0
+  alias_target('contrib-passthrough-examples', passthrough_examples)
+else
+  run_target('contrib-passthrough-examples', command: [python, '-c', ''])
+endif
diff --git a/contrib/plugins/passthrough-examples/passthrough-gtl.c b/contrib/plugins/passthrough-examples/passthrough-gtl.c
new file mode 100644
index 0000000000..96629b411e
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/passthrough-gtl.c
@@ -0,0 +1,41 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../passthrough-protocol.h"
+#include "passthrough-gtl.h"
+
+static long passthrough_syscall(uint64_t op, uint64_t a2, uint64_t a3,
+                                uint64_t a4)
+{
+    return syscall(PASSTHROUGH_MAGIC_SYSCALL, op, a2, a3, a4);
+}
+
+uint64_t passthrough_load_htl(const char *library)
+{
+    return (uint64_t)passthrough_syscall(PASSTHROUGH_OP_LOAD_HTL,
+                                         (uint64_t)(uintptr_t)library, 0, 0);
+}
+
+uint64_t passthrough_dlsym(uint64_t handle, const char *symbol)
+{
+    return (uint64_t)passthrough_syscall(PASSTHROUGH_OP_DLSYM, handle,
+                                         (uint64_t)(uintptr_t)symbol, 0);
+}
+
+void passthrough_invoke(PassthroughThunkEntry entry, void **args, void *ret)
+{
+    passthrough_syscall(PASSTHROUGH_OP_INVOKE,
+                        (uint64_t)(uintptr_t)entry,
+                        (uint64_t)(uintptr_t)args,
+                        (uint64_t)(uintptr_t)ret);
+}
+
+void passthrough_close_htl(uint64_t handle)
+{
+    passthrough_syscall(PASSTHROUGH_OP_CLOSE_HTL, handle, 0, 0);
+}
diff --git a/contrib/plugins/passthrough-examples/passthrough-gtl.h b/contrib/plugins/passthrough-examples/passthrough-gtl.h
new file mode 100644
index 0000000000..2ce927cc6e
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/passthrough-gtl.h
@@ -0,0 +1,17 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PASSTHROUGH_GTL_H
+#define PASSTHROUGH_GTL_H
+
+#include <stdint.h>
+
+typedef void (*PassthroughThunkEntry)(void **args, void *ret);
+
+uint64_t passthrough_load_htl(const char *library);
+uint64_t passthrough_dlsym(uint64_t handle, const char *symbol);
+void passthrough_invoke(PassthroughThunkEntry entry, void **args, void *ret);
+void passthrough_close_htl(uint64_t handle);
+
+#endif /* PASSTHROUGH_GTL_H */
diff --git a/contrib/plugins/passthrough-examples/zlib-demo.c b/contrib/plugins/passthrough-examples/zlib-demo.c
new file mode 100644
index 0000000000..0782f9bc36
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/zlib-demo.c
@@ -0,0 +1,90 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <zlib.h>
+
+#define INPUT_SIZE (8 * 1024 * 1024)
+
+static void fill_input(Bytef *data, size_t len)
+{
+    static const unsigned char pattern[] =
+        "QEMU passthrough syscall-filter demo payload\n";
+    size_t i;
+
+    for (i = 0; i < len; i++) {
+        data[i] = pattern[i % (sizeof(pattern) - 1)];
+        if ((i % 4096) == 0) {
+            data[i] = (unsigned char)(i >> 12);
+        }
+    }
+}
+
+int main(void)
+{
+    Bytef *input = NULL;
+    Bytef *compressed = NULL;
+    Bytef *output = NULL;
+    uLongf compressed_len;
+    uLongf output_len;
+    uLongf compressed_bound;
+    int ret = EXIT_FAILURE;
+
+    input = malloc(INPUT_SIZE);
+    if (input == NULL) {
+        perror("malloc");
+        goto cleanup;
+    }
+
+    fill_input(input, INPUT_SIZE);
+
+    compressed_bound = compressBound(INPUT_SIZE);
+    if (compressed_bound == 0) {
+        fprintf(stderr, "compressBound failed\n");
+        goto cleanup;
+    }
+
+    compressed = malloc(compressed_bound);
+    output = malloc(INPUT_SIZE);
+    if (compressed == NULL || output == NULL) {
+        perror("malloc");
+        goto cleanup;
+    }
+
+    compressed_len = compressed_bound;
+    if (compress2(compressed, &compressed_len, input, INPUT_SIZE,
+                  Z_BEST_COMPRESSION) != Z_OK) {
+        fprintf(stderr, "compress2 failed\n");
+        goto cleanup;
+    }
+
+    output_len = INPUT_SIZE;
+    if (uncompress(output, &output_len, compressed, compressed_len) != Z_OK) {
+        fprintf(stderr, "uncompress failed\n");
+        goto cleanup;
+    }
+
+    if (output_len != INPUT_SIZE || memcmp(input, output, INPUT_SIZE) != 0) {
+        fprintf(stderr, "round-trip mismatch\n");
+        goto cleanup;
+    }
+
+    if (compressed_len >= INPUT_SIZE) {
+        fprintf(stderr, "compressed output was not smaller than input\n");
+        goto cleanup;
+    }
+
+    printf("passthrough demo compressed %u bytes to %lu bytes\n",
+           INPUT_SIZE, (unsigned long)compressed_len);
+    puts("passthrough demo round-tripped successfully");
+    ret = EXIT_SUCCESS;
+
+cleanup:
+    free(output);
+    free(compressed);
+    free(input);
+    return ret;
+}
diff --git a/contrib/plugins/passthrough-examples/zlib-gtl.c b/contrib/plugins/passthrough-examples/zlib-gtl.c
new file mode 100644
index 0000000000..87b55e0c77
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/zlib-gtl.c
@@ -0,0 +1,72 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <zlib.h>
+
+#include "passthrough-gtl.h"
+
+enum ZlibThunkIndex {
+    ZLIB_THUNK_COMPRESS_BOUND,
+    ZLIB_THUNK_COMPRESS2,
+    ZLIB_THUNK_UNCOMPRESS,
+    ZLIB_THUNK_COUNT,
+};
+
+static const char gtl_library_name[] = "libz.so";
+static uint64_t gtl_htl_handle;
+static PassthroughThunkEntry gtl_entries[ZLIB_THUNK_COUNT];
+
+__attribute__((constructor))
+static void passthrough_gtl_init(void)
+{
+    gtl_htl_handle = passthrough_load_htl(gtl_library_name);
+    gtl_entries[ZLIB_THUNK_COMPRESS_BOUND] =
+        (PassthroughThunkEntry)(uintptr_t)
+        passthrough_dlsym(gtl_htl_handle, "compressBound_HTL");
+    gtl_entries[ZLIB_THUNK_COMPRESS2] = (PassthroughThunkEntry)(uintptr_t)
+        passthrough_dlsym(gtl_htl_handle, "compress2_HTL");
+    gtl_entries[ZLIB_THUNK_UNCOMPRESS] = (PassthroughThunkEntry)(uintptr_t)
+        passthrough_dlsym(gtl_htl_handle, "uncompress_HTL");
+}
+
+__attribute__((destructor))
+static void passthrough_gtl_fini(void)
+{
+    if (gtl_htl_handle != 0) {
+        passthrough_close_htl(gtl_htl_handle);
+        gtl_htl_handle = 0;
+    }
+    gtl_entries[ZLIB_THUNK_COMPRESS_BOUND] = NULL;
+    gtl_entries[ZLIB_THUNK_COMPRESS2] = NULL;
+    gtl_entries[ZLIB_THUNK_UNCOMPRESS] = NULL;
+}
+
+uLong compressBound(uLong sourceLen)
+{
+    void *args[] = { &sourceLen };
+    uLong ret = 0;
+
+    passthrough_invoke(gtl_entries[ZLIB_THUNK_COMPRESS_BOUND], args, &ret);
+    return ret;
+}
+
+int compress2(Bytef *dest, uLongf *destLen, const Bytef *source,
+              uLong sourceLen, int level)
+{
+    void *args[] = { &dest, &destLen, &source, &sourceLen, &level };
+    int ret = Z_ERRNO;
+
+    passthrough_invoke(gtl_entries[ZLIB_THUNK_COMPRESS2], args, &ret);
+    return ret;
+}
+
+int uncompress(Bytef *dest, uLongf *destLen, const Bytef *source,
+               uLong sourceLen)
+{
+    void *args[] = { &dest, &destLen, &source, &sourceLen };
+    int ret = Z_ERRNO;
+
+    passthrough_invoke(gtl_entries[ZLIB_THUNK_UNCOMPRESS], args, &ret);
+    return ret;
+}
diff --git a/contrib/plugins/passthrough-examples/zlib-htl.c b/contrib/plugins/passthrough-examples/zlib-htl.c
new file mode 100644
index 0000000000..99f9fac890
--- /dev/null
+++ b/contrib/plugins/passthrough-examples/zlib-htl.c
@@ -0,0 +1,37 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <zlib.h>
+
+void compressBound_HTL(void **args, void *ret);
+void compress2_HTL(void **args, void *ret);
+void uncompress_HTL(void **args, void *ret);
+
+void compressBound_HTL(void **args, void *ret)
+{
+    uLong sourceLen = *(uLong *)args[0];
+
+    *(uLong *)ret = compressBound(sourceLen);
+}
+
+void compress2_HTL(void **args, void *ret)
+{
+    Bytef *dest = *(Bytef **)args[0];
+    uLongf *destLen = *(uLongf **)args[1];
+    const Bytef *source = *(const Bytef **)args[2];
+    uLong sourceLen = *(uLong *)args[3];
+    int level = *(int *)args[4];
+
+    *(int *)ret = compress2(dest, destLen, source, sourceLen, level);
+}
+
+void uncompress_HTL(void **args, void *ret)
+{
+    Bytef *dest = *(Bytef **)args[0];
+    uLongf *destLen = *(uLongf **)args[1];
+    const Bytef *source = *(const Bytef **)args[2];
+    uLong sourceLen = *(uLong *)args[3];
+
+    *(int *)ret = uncompress(dest, destLen, source, sourceLen);
+}
diff --git a/contrib/plugins/passthrough-protocol.h b/contrib/plugins/passthrough-protocol.h
new file mode 100644
index 0000000000..e30cc6a186
--- /dev/null
+++ b/contrib/plugins/passthrough-protocol.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_PASSTHROUGH_PROTOCOL_H
+#define QEMU_PASSTHROUGH_PROTOCOL_H
+
+#define PASSTHROUGH_MAGIC_SYSCALL 4096
+#define PASSTHROUGH_OP_LOAD_HTL 1
+#define PASSTHROUGH_OP_DLSYM 2
+#define PASSTHROUGH_OP_INVOKE 3
+#define PASSTHROUGH_OP_CLOSE_HTL 4
+
+#endif /* QEMU_PASSTHROUGH_PROTOCOL_H */
diff --git a/contrib/plugins/passthrough.c b/contrib/plugins/passthrough.c
new file mode 100644
index 0000000000..feb7491b95
--- /dev/null
+++ b/contrib/plugins/passthrough.c
@@ -0,0 +1,162 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Minimal linux-user plugin that demonstrates local-library passthrough with
+ * the syscall filter API.
+ *
+ * The guest thunk library (GTL) can:
+ * 1) ask this plugin to load a host thunk library (HTL),
+ * 2) resolve HTL entry points,
+ * 3) invoke resolved HTL entry points with a void *args[] payload.
+ *
+ * This demo intentionally assumes 64-bit little-endian linux-user guests with
+ * guest_base == 0 on a little-endian 64-bit host, so guest virtual addresses
+ * are directly usable as host pointers.
+ */
+
+#include <glib.h>
+#include <gmodule.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <qemu-plugin.h>
+
+#include "passthrough-protocol.h"
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+typedef void (*PassthroughThunkEntry)(void **args, void *ret);
+
+static char *htl_dir;
+
+static char *build_htl_path(const char *guest_library)
+{
+    g_autofree char *basename = g_path_get_basename(guest_library);
+    g_autofree char *htl_basename = NULL;
+    const char *so = strstr(basename, ".so");
+
+    g_assert(so != NULL);
+    htl_basename = g_strdup_printf("%.*s_HTL%s",
+                                   (int)(so - basename), basename, so);
+    return g_build_filename(htl_dir, htl_basename, NULL);
+}
+
+static bool handle_load_htl(uint64_t library_ptr, uint64_t *sysret)
+{
+    g_autofree char *htl_path = NULL;
+    const char *guest_library = (const char *)(uintptr_t)library_ptr;
+    GModule *module;
+
+    g_assert(guest_library != NULL);
+    htl_path = build_htl_path(guest_library);
+    module = g_module_open(htl_path, G_MODULE_BIND_LOCAL);
+    g_assert(module != NULL);
+
+    *sysret = (uint64_t)(uintptr_t)module;
+    return true;
+}
+
+static bool handle_dlsym(uint64_t handle, uint64_t symbol_ptr, uint64_t *sysret)
+{
+    const char *symbol = (const char *)(uintptr_t)symbol_ptr;
+    GModule *module = (GModule *)(uintptr_t)handle;
+    gpointer func = NULL;
+
+    g_assert(module != NULL);
+    g_assert(symbol != NULL);
+    g_assert(g_module_symbol(module, symbol, &func));
+    g_assert(func != NULL);
+
+    *sysret = (uint64_t)(uintptr_t)func;
+    return true;
+}
+
+static bool handle_invoke(uint64_t func_ptr, uint64_t args_ptr,
+                          uint64_t ret_ptr, uint64_t *sysret)
+{
+    PassthroughThunkEntry entry = (PassthroughThunkEntry)(uintptr_t)func_ptr;
+
+    g_assert(entry != NULL);
+    entry((void **)(uintptr_t)args_ptr, (void *)(uintptr_t)ret_ptr);
+    *sysret = 0;
+    return true;
+}
+
+static bool handle_close_htl(uint64_t handle, uint64_t *sysret)
+{
+    GModule *module = (GModule *)(uintptr_t)handle;
+
+    g_assert(module != NULL);
+    g_assert(g_module_close(module));
+    *sysret = 0;
+    return true;
+}
+
+static bool passthrough_syscall_filter(qemu_plugin_id_t id,
+                                       unsigned int vcpu_index,
+                                       int64_t num, uint64_t a1, uint64_t a2,
+                                       uint64_t a3, uint64_t a4, uint64_t a5,
+                                       uint64_t a6, uint64_t a7, uint64_t a8,
+                                       uint64_t *sysret)
+{
+    if (num != PASSTHROUGH_MAGIC_SYSCALL) {
+        return false;
+    }
+
+    switch (a1) {
+    case PASSTHROUGH_OP_LOAD_HTL:
+        return handle_load_htl(a2, sysret);
+    case PASSTHROUGH_OP_DLSYM:
+        return handle_dlsym(a2, a3, sysret);
+    case PASSTHROUGH_OP_INVOKE:
+        return handle_invoke(a2, a3, a4, sysret);
+    case PASSTHROUGH_OP_CLOSE_HTL:
+        return handle_close_htl(a2, sysret);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void passthrough_exit(qemu_plugin_id_t id, void *userdata)
+{
+    g_free(htl_dir);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    int i;
+
+    if (info->system_emulation) {
+        fprintf(stderr,
+                "passthrough: this demo supports linux-user only\n");
+        return -1;
+    }
+
+    for (i = 0; i < argc; i++) {
+        g_auto(GStrv) tokens = g_strsplit(argv[i], "=", 2);
+
+        if (g_strcmp0(tokens[0], "htl_dir") == 0) {
+            g_assert(tokens[1] != NULL);
+            g_free(htl_dir);
+            htl_dir = g_strdup(tokens[1]);
+            continue;
+        }
+
+        fprintf(stderr, "passthrough: unsupported argument: %s\n", argv[i]);
+        return -1;
+    }
+
+    if (htl_dir == NULL) {
+        fprintf(stderr,
+                "passthrough: missing required argument htl_dir=PATH\n");
+        return -1;
+    }
+
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, passthrough_syscall_filter);
+    qemu_plugin_register_atexit_cb(id, passthrough_exit, NULL);
+    return 0;
+}
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 3b4c365933..0a9000c5cb 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -777,6 +777,39 @@ The plugin has a number of arguments, all of them are optional:
   * - l2assoc=A
     - L2 cache associativity (default: 16), implies ``l2=on``
 
+Passthrough
+...........
+
+``contrib/plugins/passthrough.c``
+
+This plugin demonstrates native library passthrough on top of the linux-user
+syscall filter API.
+
+This demo is currently limited to 64-bit little-endian linux-user guests:
+``x86_64``, ``aarch64``, and ``riscv64``. It also requires a
+64-bit little-endian host in the same architecture set, and assumes
+``guest_base == 0`` so guest virtual addresses are directly usable as host
+pointers.
+
+Direct execution of host callbacks back into guest translated code is not
+covered here. That requires additional target- and ABI-specific handling
+beyond this demo.
+
+Use it with a linux-user emulator and pass the HTL directory through
+``htl_dir``. For example::
+
+Here HTL means host thunk library, i.e. the host-side shared object loaded by
+the plugin from ``htl_dir``.
+
+  $ HTL_DIR=/path/to/examples
+  $ ./build/qemu-<target> \
+      -E LD_LIBRARY_PATH=$HTL_DIR \
+      -plugin ./build/contrib/plugins/libpassthrough.so,htl_dir=$HTL_DIR \
+      <guest-program>
+
+For complete runnable examples (zlib), see
+``contrib/plugins/passthrough-examples/README.rst``.
+
 Stop on Trigger
 ...............
 
-- 
2.53.0


