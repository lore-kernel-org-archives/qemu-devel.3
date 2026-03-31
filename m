Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DCE10F9302
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7gTL-0008Rl-0V; Tue, 31 Mar 2026 17:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7dDn-0007Hl-Be
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:49:47 -0400
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7dDh-0000Ki-9D
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:49:45 -0400
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 1ABD21009F96B;
 Wed,  1 Apr 2026 01:38:12 +0800 (CST)
Received: from xuklXiaoxin (unknown [202.120.32.222])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id C9BE237C8CA;
 Wed,  1 Apr 2026 01:38:11 +0800 (CST)
From: XU Kailiang <xukl2019@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 XU Kailiang <xukl2019@sjtu.edu.cn>
Subject: [PATCH v1 3/3] contrib/plugins: handle more loader open syscalls in
 the syscall filter demos
Date: Wed,  1 Apr 2026 01:36:26 +0800
Message-ID: <20260331173656.35305-4-xukl2019@sjtu.edu.cn>
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

Extend both syscall-filter demo plugins so the library redirection logic
handles open() and openat2() in addition to openat().

For openat2(), keep the fast path for unrelated library loads by reading
the guest pathname first and only decoding struct open_how after the
pathname matches the demo library name. Update the example README files
and overview text so the reproduced commands and behavior describe all
supported loader entry points.

Signed-off-by: XU Kailiang <xukl2019@sjtu.edu.cn>
Co-authored-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 .../README.rst                                |  5 +-
 .../plugins/syscall_filter_callback_qsort.c   | 61 +++++++++++++++--
 .../syscall_filter_zlib-example/README.rst    |  5 +-
 contrib/plugins/syscall_filter_zlib.c         | 65 +++++++++++++++++--
 docs/about/emulation.rst                      |  6 +-
 5 files changed, 124 insertions(+), 18 deletions(-)

diff --git a/contrib/plugins/syscall_filter_callback_qsort-example/README.rst b/contrib/plugins/syscall_filter_callback_qsort-example/README.rst
index e2bba7e2b6..ab758e358b 100644
--- a/contrib/plugins/syscall_filter_callback_qsort-example/README.rst
+++ b/contrib/plugins/syscall_filter_callback_qsort-example/README.rst
@@ -8,8 +8,9 @@ interception on ``qemu-x86_64``.
 
 * ``callback-demo.c`` is linked against ``libdemo-callback-qsort.so`` and calls
   ``callback_qsort()`` directly.
-* The plugin intercepts the loader's ``openat()`` and returns a file
-  descriptor for ``./libdemo-callback-qsort-thunk.so`` instead.
+* The plugin intercepts the loader's ``open()``, ``openat()``, or
+  ``openat2()`` and returns a file descriptor for
+  ``./libdemo-callback-qsort-thunk.so`` instead.
 * ``callback-thunk.S`` issues a ``START`` magic syscall for ``qsort()`` and a
   ``RESUME`` magic syscall from a guest return trampoline.
 * ``contrib/plugins/syscall_filter_callback_qsort.c`` runs host ``qsort()``
diff --git a/contrib/plugins/syscall_filter_callback_qsort.c b/contrib/plugins/syscall_filter_callback_qsort.c
index 45a83cb5b1..8c6c0ddb91 100644
--- a/contrib/plugins/syscall_filter_callback_qsort.c
+++ b/contrib/plugins/syscall_filter_callback_qsort.c
@@ -4,7 +4,7 @@
  * x86_64-only prototype that demonstrates a callback-capable syscall filter
  * plugin by redirecting a qsort() thunk library and bridging comparator calls
  * back into guest translated code with ucontext. The loader redirection
- * handles openat().
+ * handles open(), openat(), and openat2().
  *
  * This demo intentionally assumes a linux-user run with guest_base == 0 on a
  * little-endian 64-bit host, so guest virtual addresses are directly usable
@@ -36,7 +36,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 #define GUEST_STRING_LIMIT (1 << 20)
 #define CALLBACK_QSORT_MAX_ELEMS (1 << 20)
 #define CALLBACK_QSORT_STACK_SIZE (1 << 20)
+#define X86_64_OPEN_NR 2
 #define X86_64_OPENAT_NR 257
+#define X86_64_OPENAT2_NR 437
+
+typedef struct GuestOpenHow {
+    uint64_t flags;
+    uint64_t mode;
+} GuestOpenHow;
 
 typedef enum CallbackQsortPhase {
     CALLBACK_QSORT_PHASE_IDLE,
@@ -128,6 +135,19 @@ static void write_reg64(VcpuState *vcpu, struct qemu_plugin_register *reg,
     g_assert(success);
 }
 
+static void read_guest_buffer(uint64_t addr, void *dst, size_t len)
+{
+    g_autoptr(GByteArray) data = g_byte_array_sized_new(len);
+
+    if (len == 0) {
+        return;
+    }
+
+    g_byte_array_set_size(data, len);
+    g_assert(qemu_plugin_read_memory_vaddr(addr, data, len));
+    memcpy(dst, data->data, len);
+}
+
 static bool write_guest_u64(uint64_t addr, uint64_t value)
 {
     GByteArray data = {
@@ -138,6 +158,13 @@ static bool write_guest_u64(uint64_t addr, uint64_t value)
     return qemu_plugin_write_memory_vaddr(addr, &data);
 }
 
+static void read_guest_open_how(uint64_t addr, uint64_t guest_size,
+                                GuestOpenHow *how)
+{
+    g_assert(guest_size >= sizeof(*how));
+    read_guest_buffer(addr, how, sizeof(*how));
+}
+
 static char *read_guest_cstring(uint64_t addr)
 {
     g_autoptr(GByteArray) data = g_byte_array_sized_new(GUEST_STRING_CHUNK);
@@ -273,23 +300,49 @@ static bool handle_library_open(int64_t num, uint64_t a1, uint64_t a2,
     g_autofree char *path = NULL;
     g_autofree char *thunk_path = NULL;
     g_autofree char *out = NULL;
+    GuestOpenHow how = { 0 };
+    uint64_t path_addr;
+    int dirfd;
+    int flags;
+    mode_t mode;
     int fd;
 
-    if (num != X86_64_OPENAT_NR) {
+    if (num == X86_64_OPEN_NR) {
+        dirfd = AT_FDCWD;
+        path_addr = a1;
+        flags = (int)a2;
+        mode = (mode_t)a3;
+    } else if (num == X86_64_OPENAT_NR) {
+        dirfd = (int)a1;
+        path_addr = a2;
+        flags = (int)a3;
+        mode = (mode_t)a4;
+    } else if (num == X86_64_OPENAT2_NR) {
+        dirfd = (int)a1;
+        path_addr = a2;
+        flags = 0;
+        mode = 0;
+    } else {
         return false;
     }
 
-    path = read_guest_cstring(a2);
+    path = read_guest_cstring(path_addr);
     if (path == NULL || !guest_path_matches_bridge(path)) {
         return false;
     }
 
+    if (num == X86_64_OPENAT2_NR) {
+        read_guest_open_how(a3, a4, &how);
+        flags = (int)how.flags;
+        mode = (mode_t)how.mode;
+    }
+
     thunk_path = build_thunk_path(path);
     if (access(thunk_path, F_OK) != 0) {
         return false;
     }
 
-    fd = openat((int)a1, thunk_path, (int)a3, (mode_t)a4);
+    fd = openat(dirfd, thunk_path, flags, mode);
     g_assert(fd >= 0);
 
     *sysret = fd;
diff --git a/contrib/plugins/syscall_filter_zlib-example/README.rst b/contrib/plugins/syscall_filter_zlib-example/README.rst
index 4920187a2b..0a1cd555ca 100644
--- a/contrib/plugins/syscall_filter_zlib-example/README.rst
+++ b/contrib/plugins/syscall_filter_zlib-example/README.rst
@@ -8,8 +8,9 @@ This directory contains the guest-side pieces used by
 
 * ``zcompress-demo.c`` is linked against ``libdemo-zlib.so`` and calls the
   compression helpers directly.
-* The plugin intercepts the loader's ``openat()`` call and returns a file
-  descriptor for ``./libdemo-zlib-thunk.so`` instead.
+* The plugin intercepts the loader's ``open()``, ``openat()``, or
+  ``openat2()`` call and returns a file descriptor for
+  ``./libdemo-zlib-thunk.so`` instead.
 * ``zcompress-thunk.c`` exposes a tiny compression API as thin wrappers around
   magic syscalls.
 * The plugin filters those magic syscalls and executes the host zlib
diff --git a/contrib/plugins/syscall_filter_zlib.c b/contrib/plugins/syscall_filter_zlib.c
index e8f430cbaf..59e3750c90 100644
--- a/contrib/plugins/syscall_filter_zlib.c
+++ b/contrib/plugins/syscall_filter_zlib.c
@@ -5,10 +5,10 @@
  * local library interception with a host zlib compression example.
  *
  * When the guest dynamic loader attempts to open "./libdemo-zlib.so", this
- * plugin intercepts openat() and instead returns a file descriptor for
- * "libdemo-zlib-thunk.so" in the same directory. The thunk library then
- * forwards compression requests through magic syscalls, which are handled by
- * this plugin and executed by the host's zlib implementation.
+ * plugin intercepts open(), openat(), or openat2() and instead returns a file
+ * descriptor for "libdemo-zlib-thunk.so" in the same directory. The thunk
+ * library then forwards compression requests through magic syscalls, which are
+ * handled by this plugin and executed by the host's zlib implementation.
  *
  * This demo intentionally assumes a linux-user run with guest_base == 0 on a
  * little-endian 64-bit host, so guest virtual addresses are directly usable
@@ -40,7 +40,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 #define ZLIB_COMPRESS_MAX_BUFFER (128 * 1024 * 1024)
 #define GUEST_STRING_CHUNK 64
 #define GUEST_STRING_LIMIT (1 << 20)
+#define X86_64_OPEN_NR 2
 #define X86_64_OPENAT_NR 257
+#define X86_64_OPENAT2_NR 437
+
+typedef struct GuestOpenHow {
+    uint64_t flags;
+    uint64_t mode;
+} GuestOpenHow;
 
 static char *read_guest_cstring(uint64_t addr)
 {
@@ -68,6 +75,25 @@ static char *read_guest_cstring(uint64_t addr)
     return NULL;
 }
 
+static void read_guest_buffer(uint64_t addr, void *dst, size_t len)
+{
+    g_autoptr(GByteArray) data = g_byte_array_sized_new(len);
+
+    if (len == 0) {
+        return;
+    }
+
+    g_byte_array_set_size(data, len);
+    g_assert(qemu_plugin_read_memory_vaddr(addr, data, len));
+    memcpy(dst, data->data, len);
+}
+
+static void read_guest_open_how(uint64_t addr, uint64_t guest_size,
+                                GuestOpenHow *how)
+{
+    g_assert(guest_size >= sizeof(*how));
+    read_guest_buffer(addr, how, sizeof(*how));
+}
 static bool guest_path_matches_zlib_compress(const char *path)
 {
     g_autofree char *basename = g_path_get_basename(path);
@@ -92,22 +118,47 @@ static bool handle_library_open(int64_t num, uint64_t a1, uint64_t a2,
     g_autofree char *path = NULL;
     g_autofree char *thunk_path = NULL;
     g_autofree char *out = NULL;
+    GuestOpenHow how = { 0 };
+    uint64_t path_addr;
+    int dirfd;
+    int flags;
+    mode_t mode;
     int fd;
 
-    if (num != X86_64_OPENAT_NR) {
+    if (num == X86_64_OPEN_NR) {
+        dirfd = AT_FDCWD;
+        path_addr = a1;
+        flags = (int)a2;
+        mode = (mode_t)a3;
+    } else if (num == X86_64_OPENAT_NR) {
+        dirfd = (int)a1;
+        path_addr = a2;
+        flags = (int)a3;
+        mode = (mode_t)a4;
+    } else if (num == X86_64_OPENAT2_NR) {
+        dirfd = (int)a1;
+        path_addr = a2;
+        flags = 0;
+        mode = 0;
+    } else {
         return false;
     }
 
-    path = read_guest_cstring(a2);
+    path = read_guest_cstring(path_addr);
     if (path == NULL || !guest_path_matches_zlib_compress(path)) {
         return false;
     }
+    if (num == X86_64_OPENAT2_NR) {
+        read_guest_open_how(a3, a4, &how);
+        flags = (int)how.flags;
+        mode = (mode_t)how.mode;
+    }
     thunk_path = build_thunk_path(path);
     if (access(thunk_path, F_OK) != 0) {
         return false;
     }
 
-    fd = openat((int)a1, thunk_path, (int)a3, (mode_t)a4);
+    fd = openat(dirfd, thunk_path, flags, mode);
     g_assert(fd >= 0);
 
     *sysret = fd;
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 4afec85ff6..8630300b37 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -246,9 +246,9 @@ side example lives in ``contrib/plugins/syscall_filter_zlib-example``.
 
 The plugin does two things:
 
-* It filters the guest ``openat()`` that the dynamic loader issues for
-  ``./libdemo-zlib.so`` and instead returns a file descriptor for
-  ``libdemo-zlib-thunk.so``.
+* It filters the guest ``open()``, ``openat()``, or ``openat2()`` that the
+  dynamic loader issues for ``./libdemo-zlib.so`` and instead returns a file
+  descriptor for ``libdemo-zlib-thunk.so``.
 * It filters magic syscalls from the thunk library and runs the host's zlib
   ``compressBound()``, ``compress2()``, and ``uncompress()`` implementations
   directly on guest buffers.
-- 
2.53.0


