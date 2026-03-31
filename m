Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EC410F9303
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7gTL-0008RN-FX; Tue, 31 Mar 2026 17:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7d8v-0004tN-26
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:44:46 -0400
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7d8q-00089Y-CB
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:44:44 -0400
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 2BE7A1068BE6E;
 Wed,  1 Apr 2026 01:38:03 +0800 (CST)
Received: from xuklXiaoxin (unknown [202.120.32.222])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 04A9A37C8CA;
 Wed,  1 Apr 2026 01:38:03 +0800 (CST)
From: XU Kailiang <xukl2019@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 XU Kailiang <xukl2019@sjtu.edu.cn>
Subject: [PATCH v1 1/3] contrib/plugins: add a zlib compression filter example
Date: Wed,  1 Apr 2026 01:36:24 +0800
Message-ID: <20260331173656.35305-2-xukl2019@sjtu.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
References: <20260331173656.35305-1-xukl2019@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.232; envelope-from=xukl2019@sjtu.edu.cn;
 helo=smtp232.sjtu.edu.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 31 Mar 2026 17:18:00 -0400
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

Add a minimal linux-user plugin example that uses the syscall filter
callback API to intercept a guest library load and replace it with a
local thunk library.

The guest-side demo links against libdemo-zlib.so. When the guest
dynamic loader issues openat() for that library, the plugin returns a
file descriptor for libdemo-zlib-thunk.so instead. The thunk library
forwards compressBound(), compress2(), and uncompress() through magic
syscalls, which the plugin handles by calling the host zlib
implementation directly.

At this stage, the loader redirection covers only the openat()-based
library load path. The follow-up patch in this series extends the same
demo to open() and openat2().

Once the demo library path matches, the plugin asserts that opening the
thunk library succeeds. That is intentional here: this example is meant
to show the direct hand-off to a known local thunk library, not fallback
behavior when that local library is missing or unusable.

Document the assumptions and add a small example directory with a
Makefile so the behavior is easy to reproduce.

Signed-off-by: XU Kailiang <xukl2019@sjtu.edu.cn>
Co-authored-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 contrib/plugins/meson.build                   |  12 +-
 .../syscall_filter_zlib-example/Makefile      |  19 ++
 .../syscall_filter_zlib-example/README.rst    |  43 +++
 .../zcompress-demo.c                          |  94 ++++++
 .../zcompress-thunk.c                         |  35 +++
 .../zcompress-thunk.h                         |  16 ++
 contrib/plugins/syscall_filter_zlib.c         | 268 ++++++++++++++++++
 docs/about/emulation.rst                      |  41 +++
 8 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/Makefile
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/README.rst
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-demo.c
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.c
 create mode 100644 contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.h
 create mode 100644 contrib/plugins/syscall_filter_zlib.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 099319e7a1..aa3b95eeab 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -19,6 +19,12 @@ if host_os != 'windows'
   contrib_plugins += 'lockstep.c'
 endif
 
+if host_os != 'windows' and host_os != 'darwin' and
+   host_machine.endian() == 'little'
+  # The zlib syscall-filter demo assumes little-endian direct-pointer access.
+  contrib_plugins += 'syscall_filter_zlib.c'
+endif
+
 if 'cpp' in all_languages
   contrib_plugins += 'cpp.cpp'
 endif
@@ -26,8 +32,12 @@ endif
 t = []
 if get_option('plugins')
   foreach i : contrib_plugins
+    deps = plugins_deps
+    if i == 'syscall_filter_zlib.c'
+      deps = [plugins_deps, zlib]
+    endif
     t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+                       dependencies: deps)
   endforeach
 endif
 if t.length() > 0
diff --git a/contrib/plugins/syscall_filter_zlib-example/Makefile b/contrib/plugins/syscall_filter_zlib-example/Makefile
new file mode 100644
index 0000000000..f94b93e950
--- /dev/null
+++ b/contrib/plugins/syscall_filter_zlib-example/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CC ?= cc
+CFLAGS ?=
+LDFLAGS ?=
+RM ?= rm -f
+
+all: libdemo-zlib-thunk.so zcompress-demo
+
+libdemo-zlib-thunk.so: zcompress-thunk.c zcompress-thunk.h
+	$(CC) $(CFLAGS) -fPIC -shared zcompress-thunk.c -Wl,-soname,libdemo-zlib.so -o $@ $(LDFLAGS)
+
+zcompress-demo: zcompress-demo.c zcompress-thunk.h libdemo-zlib-thunk.so
+	$(CC) $(CFLAGS) zcompress-demo.c ./libdemo-zlib-thunk.so -Wl,-rpath,'$$ORIGIN' -o $@ $(LDFLAGS)
+
+clean:
+	$(RM) libdemo-zlib-thunk.so zcompress-demo
+
+.PHONY: all clean
diff --git a/contrib/plugins/syscall_filter_zlib-example/README.rst b/contrib/plugins/syscall_filter_zlib-example/README.rst
new file mode 100644
index 0000000000..4920187a2b
--- /dev/null
+++ b/contrib/plugins/syscall_filter_zlib-example/README.rst
@@ -0,0 +1,43 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+zlib compression syscall-filter example
+=======================================
+
+This directory contains the guest-side pieces used by
+``contrib/plugins/syscall_filter_zlib.c``:
+
+* ``zcompress-demo.c`` is linked against ``libdemo-zlib.so`` and calls the
+  compression helpers directly.
+* The plugin intercepts the loader's ``openat()`` call and returns a file
+  descriptor for ``./libdemo-zlib-thunk.so`` instead.
+* ``zcompress-thunk.c`` exposes a tiny compression API as thin wrappers around
+  magic syscalls.
+* The plugin filters those magic syscalls and executes the host zlib
+  ``compressBound()``, ``compress2()``, and ``uncompress()`` implementations
+  directly on guest buffers.
+* The example currently supports ``x86_64`` linux-user only. Extending the
+  syscall-number table for more targets is straightforward, but is outside the
+  scope of this patch.
+* To keep the demo small, the plugin assumes ``guest_base == 0`` on a
+  little-endian 64-bit host. For this x86_64 linux-user demo, that means guest
+  virtual addresses are directly usable as host pointers. In practice that
+  means running ``qemu-x86_64`` on a little-endian 64-bit host without forcing
+  a nonzero guest base.
+
+Build the guest-side demo with::
+
+  make
+
+Then run it from this directory with QEMU linux-user and the plugin::
+
+  QEMU_BUILD=/path/to/qemu/build
+  $QEMU_BUILD/qemu-x86_64 \
+    -plugin $QEMU_BUILD/contrib/plugins/libsyscall_filter_zlib.so \
+    -d plugin \
+    ./zcompress-demo
+
+The build links ``zcompress-demo`` against ``libdemo-zlib-thunk.so`` while
+giving that shared object the soname ``libdemo-zlib.so``. Without the plugin,
+the program fails at startup because no ``libdemo-zlib.so`` file exists in the
+runtime search path. With the plugin, the guest sees a working library load
+even though the loader actually receives ``libdemo-zlib-thunk.so``.
diff --git a/contrib/plugins/syscall_filter_zlib-example/zcompress-demo.c b/contrib/plugins/syscall_filter_zlib-example/zcompress-demo.c
new file mode 100644
index 0000000000..a199b8d290
--- /dev/null
+++ b/contrib/plugins/syscall_filter_zlib-example/zcompress-demo.c
@@ -0,0 +1,94 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "zcompress-thunk.h"
+
+#define INPUT_SIZE (8 * 1024 * 1024)
+#define Z_BEST_COMPRESSION 9
+
+static void fill_input(unsigned char *data, size_t len)
+{
+    static const unsigned char pattern[] =
+        "QEMU syscall filter zlib compression demo payload\n";
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
+    unsigned char *input = NULL;
+    unsigned char *compressed = NULL;
+    unsigned char *output = NULL;
+    size_t compressed_len;
+    size_t output_len;
+    size_t compressed_bound;
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
+    compressed_bound = zcompress_compress_bound(INPUT_SIZE);
+    if (compressed_bound == 0) {
+        fprintf(stderr, "zcompress_compress_bound failed\n");
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
+    if (zcompress_compress(input, INPUT_SIZE, compressed, &compressed_len,
+                           Z_BEST_COMPRESSION) != 0) {
+        fprintf(stderr, "zcompress_compress failed\n");
+        goto cleanup;
+    }
+
+    output_len = INPUT_SIZE;
+    if (zcompress_uncompress(compressed, compressed_len, output,
+                             &output_len) != 0) {
+        fprintf(stderr, "zcompress_uncompress failed\n");
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
+    printf("zlib demo compressed %u bytes to %zu bytes\n",
+           INPUT_SIZE, compressed_len);
+    puts("zlib demo round-tripped successfully");
+    ret = EXIT_SUCCESS;
+
+cleanup:
+    free(output);
+    free(compressed);
+    free(input);
+    return ret;
+}
diff --git a/contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.c b/contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.c
new file mode 100644
index 0000000000..1e498a728e
--- /dev/null
+++ b/contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.c
@@ -0,0 +1,35 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdint.h>
+#include <unistd.h>
+
+#include "zcompress-thunk.h"
+
+#define ZLIB_COMPRESS_MAGIC_SYSCALL 4096
+#define ZLIB_COMPRESS_OP_BOUND 1
+#define ZLIB_COMPRESS_OP_COMPRESS2 2
+#define ZLIB_COMPRESS_OP_UNCOMPRESS 3
+
+size_t zcompress_compress_bound(size_t source_len)
+{
+    return (size_t)syscall(ZLIB_COMPRESS_MAGIC_SYSCALL,
+                           ZLIB_COMPRESS_OP_BOUND, source_len);
+}
+
+int zcompress_compress(const void *source, size_t source_len,
+                       void *dest, size_t *dest_len, int level)
+{
+    return (int)syscall(ZLIB_COMPRESS_MAGIC_SYSCALL,
+                        ZLIB_COMPRESS_OP_COMPRESS2,
+                        source, source_len, dest, dest_len, level);
+}
+
+int zcompress_uncompress(const void *source, size_t source_len,
+                         void *dest, size_t *dest_len)
+{
+    return (int)syscall(ZLIB_COMPRESS_MAGIC_SYSCALL,
+                        ZLIB_COMPRESS_OP_UNCOMPRESS,
+                        source, source_len, dest, dest_len);
+}
diff --git a/contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.h b/contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.h
new file mode 100644
index 0000000000..f0092ff681
--- /dev/null
+++ b/contrib/plugins/syscall_filter_zlib-example/zcompress-thunk.h
@@ -0,0 +1,16 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CONTRIB_PLUGINS_SYSCALL_FILTER_ZLIB_EXAMPLE_ZCOMPRESS_THUNK_H
+#define CONTRIB_PLUGINS_SYSCALL_FILTER_ZLIB_EXAMPLE_ZCOMPRESS_THUNK_H
+
+#include <stddef.h>
+
+size_t zcompress_compress_bound(size_t source_len);
+int zcompress_compress(const void *source, size_t source_len,
+                       void *dest, size_t *dest_len, int level);
+int zcompress_uncompress(const void *source, size_t source_len,
+                         void *dest, size_t *dest_len);
+
+#endif
diff --git a/contrib/plugins/syscall_filter_zlib.c b/contrib/plugins/syscall_filter_zlib.c
new file mode 100644
index 0000000000..e8f430cbaf
--- /dev/null
+++ b/contrib/plugins/syscall_filter_zlib.c
@@ -0,0 +1,268 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Minimal linux-user plugin that demonstrates syscall filtering for
+ * local library interception with a host zlib compression example.
+ *
+ * When the guest dynamic loader attempts to open "./libdemo-zlib.so", this
+ * plugin intercepts openat() and instead returns a file descriptor for
+ * "libdemo-zlib-thunk.so" in the same directory. The thunk library then
+ * forwards compression requests through magic syscalls, which are handled by
+ * this plugin and executed by the host's zlib implementation.
+ *
+ * This demo intentionally assumes a linux-user run with guest_base == 0 on a
+ * little-endian 64-bit host, so guest virtual addresses are directly usable
+ * as host pointers.
+ */
+
+#include <fcntl.h>
+#include <glib.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <zlib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+#define MAGIC_SYSCALL 4096
+#define ZLIB_COMPRESS_OP_BOUND 1
+#define ZLIB_COMPRESS_OP_COMPRESS2 2
+#define ZLIB_COMPRESS_OP_UNCOMPRESS 3
+#define ZLIB_COMPRESS_LIBRARY "libdemo-zlib.so"
+#define ZLIB_COMPRESS_THUNK_LIBRARY "libdemo-zlib-thunk.so"
+#define ZLIB_COMPRESS_MAX_INPUT (64 * 1024 * 1024)
+#define ZLIB_COMPRESS_MAX_BUFFER (128 * 1024 * 1024)
+#define GUEST_STRING_CHUNK 64
+#define GUEST_STRING_LIMIT (1 << 20)
+#define X86_64_OPENAT_NR 257
+
+static char *read_guest_cstring(uint64_t addr)
+{
+    g_autoptr(GByteArray) data = g_byte_array_sized_new(GUEST_STRING_CHUNK);
+    g_autoptr(GString) str = g_string_sized_new(GUEST_STRING_CHUNK);
+    size_t offset;
+
+    for (offset = 0;
+         offset < GUEST_STRING_LIMIT;
+         offset += GUEST_STRING_CHUNK) {
+        g_byte_array_set_size(data, GUEST_STRING_CHUNK);
+        if (!qemu_plugin_read_memory_vaddr(addr + offset, data,
+                                           GUEST_STRING_CHUNK)) {
+            return NULL;
+        }
+
+        for (guint i = 0; i < data->len; i++) {
+            if (data->data[i] == '\0') {
+                return g_string_free(g_steal_pointer(&str), FALSE);
+            }
+            g_string_append_c(str, data->data[i]);
+        }
+    }
+
+    return NULL;
+}
+
+static bool guest_path_matches_zlib_compress(const char *path)
+{
+    g_autofree char *basename = g_path_get_basename(path);
+
+    return strcmp(basename, ZLIB_COMPRESS_LIBRARY) == 0;
+}
+
+static char *build_thunk_path(const char *path)
+{
+    g_autofree char *dirname = g_path_get_dirname(path);
+
+    if (strcmp(dirname, ".") == 0) {
+        return g_strdup(ZLIB_COMPRESS_THUNK_LIBRARY);
+    }
+
+    return g_build_filename(dirname, ZLIB_COMPRESS_THUNK_LIBRARY, NULL);
+}
+
+static bool handle_library_open(int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t *sysret)
+{
+    g_autofree char *path = NULL;
+    g_autofree char *thunk_path = NULL;
+    g_autofree char *out = NULL;
+    int fd;
+
+    if (num != X86_64_OPENAT_NR) {
+        return false;
+    }
+
+    path = read_guest_cstring(a2);
+    if (path == NULL || !guest_path_matches_zlib_compress(path)) {
+        return false;
+    }
+    thunk_path = build_thunk_path(path);
+    if (access(thunk_path, F_OK) != 0) {
+        return false;
+    }
+
+    fd = openat((int)a1, thunk_path, (int)a3, (mode_t)a4);
+    g_assert(fd >= 0);
+
+    *sysret = fd;
+    out = g_strdup_printf("syscall_filter_zlib: redirected %s -> %s (fd=%d)\n",
+                          path, thunk_path, fd);
+    qemu_plugin_outs(out);
+    return true;
+}
+
+static bool handle_compress_bound(int64_t num, uint64_t a1, uint64_t a2,
+                                  uint64_t *sysret)
+{
+    if (num != MAGIC_SYSCALL || a1 != ZLIB_COMPRESS_OP_BOUND) {
+        return false;
+    }
+
+    if (a2 > ZLIB_COMPRESS_MAX_INPUT) {
+        *sysret = 0;
+        return true;
+    }
+
+    *sysret = compressBound((uLong)a2);
+    return true;
+}
+
+static bool handle_compress2(int64_t num, uint64_t a1, uint64_t a2,
+                             uint64_t a3, uint64_t a4, uint64_t a5,
+                             uint64_t a6, uint64_t *sysret)
+{
+    g_autofree char *out = NULL;
+    const Bytef *source;
+    Bytef *dest;
+    uLongf *dest_lenp;
+    uLongf guest_dest_len;
+    int status;
+    int level = (int)a6;
+
+    if (num != MAGIC_SYSCALL || a1 != ZLIB_COMPRESS_OP_COMPRESS2) {
+        return false;
+    }
+
+    g_assert(a2 != 0 && a4 != 0 && a5 != 0);
+    g_assert(level == Z_DEFAULT_COMPRESSION ||
+             (level >= Z_NO_COMPRESSION && level <= Z_BEST_COMPRESSION));
+
+    dest_lenp = (uLongf *)(uintptr_t)a5;
+    guest_dest_len = *dest_lenp;
+
+    g_assert(a3 <= ZLIB_COMPRESS_MAX_INPUT);
+    g_assert(guest_dest_len <= ZLIB_COMPRESS_MAX_BUFFER);
+
+    source = (const Bytef *)(uintptr_t)a2;
+    dest = (Bytef *)(uintptr_t)a4;
+    *dest_lenp = guest_dest_len;
+    status = compress2(dest, dest_lenp, source, (uLong)a3, level);
+
+    if (status != Z_OK) {
+        *sysret = (uint64_t)(uint32_t)status;
+        return true;
+    }
+
+    *sysret = Z_OK;
+    out = g_strdup_printf(
+        "syscall_filter_zlib: compressed %" PRIu64
+        " guest bytes to %lu host bytes\n",
+                          a3, (unsigned long)*dest_lenp);
+    qemu_plugin_outs(out);
+    return true;
+}
+
+static bool handle_uncompress(int64_t num, uint64_t a1, uint64_t a2,
+                              uint64_t a3, uint64_t a4, uint64_t a5,
+                              uint64_t *sysret)
+{
+    g_autofree char *out = NULL;
+    const Bytef *source;
+    Bytef *dest;
+    uLongf *dest_lenp;
+    uLongf guest_dest_len;
+    int status;
+
+    if (num != MAGIC_SYSCALL || a1 != ZLIB_COMPRESS_OP_UNCOMPRESS) {
+        return false;
+    }
+
+    g_assert(a2 != 0 && a4 != 0 && a5 != 0);
+
+    dest_lenp = (uLongf *)(uintptr_t)a5;
+    guest_dest_len = *dest_lenp;
+
+    g_assert(a3 <= ZLIB_COMPRESS_MAX_BUFFER);
+    g_assert(guest_dest_len <= ZLIB_COMPRESS_MAX_INPUT);
+
+    source = (const Bytef *)(uintptr_t)a2;
+    dest = (Bytef *)(uintptr_t)a4;
+    *dest_lenp = guest_dest_len;
+    status = uncompress(dest, dest_lenp, source, (uLong)a3);
+
+    if (status != Z_OK) {
+        *sysret = (uint64_t)(uint32_t)status;
+        return true;
+    }
+
+    *sysret = Z_OK;
+    out = g_strdup_printf(
+        "syscall_filter_zlib: uncompressed %" PRIu64
+        " guest bytes to %lu host bytes\n",
+                          a3, (unsigned long)*dest_lenp);
+    qemu_plugin_outs(out);
+    return true;
+}
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    if (handle_library_open(num, a1, a2, a3, a4, sysret)) {
+        return true;
+    }
+
+    if (handle_compress_bound(num, a1, a2, sysret)) {
+        return true;
+    }
+
+    if (handle_compress2(num, a1, a2, a3, a4, a5, a6, sysret)) {
+        return true;
+    }
+
+    if (handle_uncompress(num, a1, a2, a3, a4, a5, sysret)) {
+        return true;
+    }
+
+    return false;
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (argc != 0) {
+        fprintf(stderr,
+                "syscall_filter_zlib: this example plugin does not take arguments\n");
+        return -1;
+    }
+
+    if (strcmp(info->target_name, "x86_64") != 0) {
+        fprintf(stderr,
+                "syscall_filter_zlib: unsupported linux-user target '%s' "
+                "(supported: x86_64)\n",
+                info->target_name);
+        return -1;
+    }
+
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    return 0;
+}
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 469f31bab6..4afec85ff6 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -235,6 +235,47 @@ basic plugins that are used to test and exercise the API during the
 ``make check-tcg`` target in ``tests/tcg/plugins`` that are never the
 less useful for basic analysis.
 
+Local Library Interception
+..........................
+
+``contrib/plugins/syscall_filter_zlib.c``
+
+This linux-user example shows how to use the syscall filter callback API to
+intercept a library load and replace it with a guest thunk library. The guest
+side example lives in ``contrib/plugins/syscall_filter_zlib-example``.
+
+The plugin does two things:
+
+* It filters the guest ``openat()`` that the dynamic loader issues for
+  ``./libdemo-zlib.so`` and instead returns a file descriptor for
+  ``libdemo-zlib-thunk.so``.
+* It filters magic syscalls from the thunk library and runs the host's zlib
+  ``compressBound()``, ``compress2()``, and ``uncompress()`` implementations
+  directly on guest buffers.
+
+This makes the motivation concrete without introducing callback semantics: the
+example looks like a plausible local compression offload, and the guest-visible
+API stays small and easy to reproduce.
+The example currently supports ``x86_64`` linux-user only. To keep the example
+minimal, it currently assumes ``guest_base == 0`` on a little-endian 64-bit
+host. For this x86_64 linux-user demo, that means guest virtual addresses are
+directly usable as host pointers.
+
+To reproduce the example on ``qemu-x86_64``::
+
+  $ ninja -C build contrib-plugins
+  $ cd contrib/plugins/syscall_filter_zlib-example
+  $ make
+  $ QEMU_BUILD=/path/to/qemu/build
+  $ $QEMU_BUILD/qemu-x86_64 \
+      -plugin $QEMU_BUILD/contrib/plugins/libsyscall_filter_zlib.so \
+      -d plugin \
+      ./zcompress-demo
+
+Without the plugin, the guest program fails at startup because
+``libdemo-zlib.so`` is missing. With the plugin, QEMU's plugin log shows the
+loader redirection plus native compression and decompression handling.
+
 Empty
 .....
 
-- 
2.53.0


