Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B717F10F9304
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 21:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7gTL-0008SX-SJ; Tue, 31 Mar 2026 17:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7dE7-0007Pp-1a
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:50:07 -0400
Received: from smtp232.sjtu.edu.cn ([202.120.2.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xukl2019@sjtu.edu.cn>)
 id 1w7dE3-0000M9-4f
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:50:06 -0400
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp232.sjtu.edu.cn (Postfix) with ESMTPS id 0D1FB10097F65;
 Wed,  1 Apr 2026 01:38:09 +0800 (CST)
Received: from xuklXiaoxin (unknown [202.120.32.222])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id DAF7037C8CA;
 Wed,  1 Apr 2026 01:38:08 +0800 (CST)
From: XU Kailiang <xukl2019@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Ziyang Zhang <functioner@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Zhengwei Qi <qizhwei@sjtu.edu.cn>,
 XU Kailiang <xukl2019@sjtu.edu.cn>
Subject: [PATCH v1 2/3] contrib/plugins: add a callback-capable qsort prototype
Date: Wed,  1 Apr 2026 01:36:25 +0800
Message-ID: <20260331173656.35305-3-xukl2019@sjtu.edu.cn>
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

Add a second linux-user example that demonstrates a more advanced use of
the syscall filter API: redirecting a thunk library for qsort() and
bridging comparator callbacks back into guest translated code.

The guest-side prototype links against libdemo-callback-qsort.so. The
plugin redirects the loader's openat() to
libdemo-callback-qsort-thunk.so, runs host qsort() inside a ucontext
worker, and on each comparator invocation rewrites guest register state
and PC so execution continues in the guest comparator. The guest return
trampoline then resumes the suspended host call with a second magic
syscall.

At this stage, the loader redirection covers only the openat()-based
library load path. The follow-up patch in this series extends the same
prototype to open() and openat2().

Once the demo library path matches, the plugin asserts that opening the
thunk library succeeds. That is intentional here: this prototype is
meant to show the callback bridge once a known local thunk library is in
place, not fallback behavior when that local library is missing or
unusable.

Keep the scope explicit: this is an x86_64-only prototype intended to
show what the interface can support, not a general callback ABI.

Signed-off-by: XU Kailiang <xukl2019@sjtu.edu.cn>
Co-authored-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 contrib/plugins/meson.build                   |  12 +-
 .../Makefile                                  |  19 +
 .../README.rst                                |  46 ++
 .../callback-demo.c                           |  75 +++
 .../callback-qsort.h                          |  14 +
 .../callback-thunk.S                          |  38 ++
 .../plugins/syscall_filter_callback_qsort.c   | 431 ++++++++++++++++++
 7 files changed, 631 insertions(+), 4 deletions(-)
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/Makefile
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/README.rst
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-demo.c
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-qsort.h
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort-example/callback-thunk.S
 create mode 100644 contrib/plugins/syscall_filter_callback_qsort.c

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index aa3b95eeab..cc82255666 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -19,10 +19,14 @@ if host_os != 'windows'
   contrib_plugins += 'lockstep.c'
 endif
 
-if host_os != 'windows' and host_os != 'darwin' and
-   host_machine.endian() == 'little'
-  # The zlib syscall-filter demo assumes little-endian direct-pointer access.
-  contrib_plugins += 'syscall_filter_zlib.c'
+if host_os != 'windows' and host_os != 'darwin'
+  # The syscall-filter demos assume little-endian direct-pointer access.
+  if host_machine.endian() == 'little'
+    contrib_plugins += 'syscall_filter_zlib.c'
+    if supported_backends.contains('ucontext')
+      contrib_plugins += 'syscall_filter_callback_qsort.c'
+    endif
+  endif
 endif
 
 if 'cpp' in all_languages
diff --git a/contrib/plugins/syscall_filter_callback_qsort-example/Makefile b/contrib/plugins/syscall_filter_callback_qsort-example/Makefile
new file mode 100644
index 0000000000..0144e46790
--- /dev/null
+++ b/contrib/plugins/syscall_filter_callback_qsort-example/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CC ?= cc
+CFLAGS ?=
+LDFLAGS ?=
+RM ?= rm -f
+
+all: libdemo-callback-qsort-thunk.so callback-demo
+
+libdemo-callback-qsort-thunk.so: callback-thunk.S
+	$(CC) $(CFLAGS) -fPIC -shared callback-thunk.S -Wl,-soname,libdemo-callback-qsort.so -o $@ $(LDFLAGS)
+
+callback-demo: callback-demo.c callback-qsort.h libdemo-callback-qsort-thunk.so
+	$(CC) $(CFLAGS) callback-demo.c ./libdemo-callback-qsort-thunk.so -Wl,-rpath,'$$ORIGIN' -o $@ $(LDFLAGS)
+
+clean:
+	$(RM) libdemo-callback-qsort-thunk.so callback-demo
+
+.PHONY: all clean
diff --git a/contrib/plugins/syscall_filter_callback_qsort-example/README.rst b/contrib/plugins/syscall_filter_callback_qsort-example/README.rst
new file mode 100644
index 0000000000..e2bba7e2b6
--- /dev/null
+++ b/contrib/plugins/syscall_filter_callback_qsort-example/README.rst
@@ -0,0 +1,46 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Callback qsort bridge prototype
+===============================
+
+This directory contains a prototype for callback-capable local library
+interception on ``qemu-x86_64``.
+
+* ``callback-demo.c`` is linked against ``libdemo-callback-qsort.so`` and calls
+  ``callback_qsort()`` directly.
+* The plugin intercepts the loader's ``openat()`` and returns a file
+  descriptor for ``./libdemo-callback-qsort-thunk.so`` instead.
+* ``callback-thunk.S`` issues a ``START`` magic syscall for ``qsort()`` and a
+  ``RESUME`` magic syscall from a guest return trampoline.
+* ``contrib/plugins/syscall_filter_callback_qsort.c`` runs host ``qsort()``
+  inside a ``ucontext`` worker, yields on every comparator invocation, and
+  redirects control flow into the guest comparator with
+  ``qemu_plugin_set_pc()``.
+* This callback prototype is intentionally ``x86_64``-only. Supporting
+  additional targets would require target-specific register and ABI handling,
+  which is beyond the scope of this example.
+* The plugin is built only on hosts where ``ucontext`` is available.
+* To keep the prototype minimal, it assumes ``guest_base == 0`` on a
+  little-endian 64-bit host. For this x86_64 linux-user demo, that means guest
+  virtual addresses are directly usable as host pointers. In practice that
+  means running ``qemu-x86_64`` on a little-endian 64-bit host without forcing
+  a nonzero guest base.
+
+Build the guest-side prototype with::
+
+  make
+
+Then run it from this directory with QEMU linux-user and the plugin::
+
+  QEMU_BUILD=/path/to/qemu/build
+  $QEMU_BUILD/qemu-x86_64 \
+    -plugin $QEMU_BUILD/contrib/plugins/libsyscall_filter_callback_qsort.so \
+    -d plugin \
+    ./callback-demo
+
+The build links ``callback-demo`` against ``libdemo-callback-qsort-thunk.so``
+while giving that shared object the soname ``libdemo-callback-qsort.so``.
+Without the plugin, the program fails at startup because no
+``libdemo-callback-qsort.so`` file exists in the runtime search path. With the
+plugin, the guest sees a working library load even though the loader actually
+receives ``libdemo-callback-qsort-thunk.so``.
diff --git a/contrib/plugins/syscall_filter_callback_qsort-example/callback-demo.c b/contrib/plugins/syscall_filter_callback_qsort-example/callback-demo.c
new file mode 100644
index 0000000000..5e89d9f022
--- /dev/null
+++ b/contrib/plugins/syscall_filter_callback_qsort-example/callback-demo.c
@@ -0,0 +1,75 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <inttypes.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "callback-qsort.h"
+
+#define VALUE_COUNT 128
+
+static int compare_count;
+
+static int guest_compare_int32(const void *lhs, const void *rhs)
+{
+    const int32_t *a = lhs;
+    const int32_t *b = rhs;
+
+    compare_count++;
+    if (*a < *b) {
+        return -1;
+    }
+    if (*a > *b) {
+        return 1;
+    }
+    return 0;
+}
+
+static int is_sorted(const int32_t *values, size_t count)
+{
+    size_t i;
+
+    for (i = 1; i < count; i++) {
+        if (values[i - 1] > values[i]) {
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+int main(void)
+{
+    int32_t values[VALUE_COUNT];
+    size_t i;
+    int ret;
+
+    for (i = 0; i < VALUE_COUNT; i++) {
+        values[i] = (int32_t)(VALUE_COUNT - i);
+    }
+
+    ret = callback_qsort(values, VALUE_COUNT, sizeof(values[0]),
+                         guest_compare_int32);
+    if (ret != 0) {
+        fprintf(stderr, "callback_qsort failed: %d\n", ret);
+        return EXIT_FAILURE;
+    }
+
+    if (!is_sorted(values, VALUE_COUNT)) {
+        fprintf(stderr, "values are not sorted\n");
+        return EXIT_FAILURE;
+    }
+
+    if (compare_count == 0) {
+        fprintf(stderr, "guest comparator never ran\n");
+        return EXIT_FAILURE;
+    }
+
+    printf("callback demo sorted %u values with %d guest comparator calls\n",
+           VALUE_COUNT, compare_count);
+    puts("callback demo succeeded");
+    return EXIT_SUCCESS;
+}
diff --git a/contrib/plugins/syscall_filter_callback_qsort-example/callback-qsort.h b/contrib/plugins/syscall_filter_callback_qsort-example/callback-qsort.h
new file mode 100644
index 0000000000..4a1021841d
--- /dev/null
+++ b/contrib/plugins/syscall_filter_callback_qsort-example/callback-qsort.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CONTRIB_PLUGINS_SYSCALL_FILTER_CALLBACK_QSORT_EXAMPLE_CALLBACK_QSORT_H
+#define CONTRIB_PLUGINS_SYSCALL_FILTER_CALLBACK_QSORT_EXAMPLE_CALLBACK_QSORT_H
+
+#include <stddef.h>
+typedef int (*callback_qsort_cmp_fn)(const void *lhs, const void *rhs);
+
+int callback_qsort(void *base, size_t nmemb, size_t size,
+                   callback_qsort_cmp_fn cmp);
+
+#endif
diff --git a/contrib/plugins/syscall_filter_callback_qsort-example/callback-thunk.S b/contrib/plugins/syscall_filter_callback_qsort-example/callback-thunk.S
new file mode 100644
index 0000000000..a8d9607d5c
--- /dev/null
+++ b/contrib/plugins/syscall_filter_callback_qsort-example/callback-thunk.S
@@ -0,0 +1,38 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define MAGIC_SYSCALL 4096
+#define CALLBACK_BRIDGE_OP_START 1
+#define CALLBACK_BRIDGE_OP_RESUME 2
+
+    .text
+    .hidden callback_qsort_resume_trampoline
+    .globl callback_qsort
+    .type callback_qsort, @function
+callback_qsort:
+    /*
+     * callback_qsort(base, nmemb, elem_size, cmp_fn) arrives in
+     * %rdi, %rsi, %rdx, and %rcx. Shuffle those into the x86_64 Linux
+     * syscall ABI so START sees: op, base, nmemb, elem_size, cmp_fn,
+     * trampoline.
+     */
+    mov %rcx, %r8
+    mov %rdx, %r10
+    mov %rsi, %rdx
+    lea callback_qsort_resume_trampoline(%rip), %r9
+    mov %rdi, %rsi
+    mov $CALLBACK_BRIDGE_OP_START, %rdi
+    mov $MAGIC_SYSCALL, %rax
+    syscall
+    ret
+
+    .globl callback_qsort_resume_trampoline
+    .type callback_qsort_resume_trampoline, @function
+callback_qsort_resume_trampoline:
+    /* Sign-extend the guest comparator result into the RESUME argument. */
+    movslq %eax, %rsi
+    mov $CALLBACK_BRIDGE_OP_RESUME, %rdi
+    mov $MAGIC_SYSCALL, %rax
+    syscall
+    ret
diff --git a/contrib/plugins/syscall_filter_callback_qsort.c b/contrib/plugins/syscall_filter_callback_qsort.c
new file mode 100644
index 0000000000..45a83cb5b1
--- /dev/null
+++ b/contrib/plugins/syscall_filter_callback_qsort.c
@@ -0,0 +1,431 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * x86_64-only prototype that demonstrates a callback-capable syscall filter
+ * plugin by redirecting a qsort() thunk library and bridging comparator calls
+ * back into guest translated code with ucontext. The loader redirection
+ * handles openat().
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
+#include <stdlib.h>
+#include <string.h>
+#include <ucontext.h>
+#include <unistd.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+#define MAGIC_SYSCALL 4096
+#define CALLBACK_QSORT_OP_START 1
+#define CALLBACK_QSORT_OP_RESUME 2
+#define CALLBACK_QSORT_LIBRARY "libdemo-callback-qsort.so"
+#define CALLBACK_QSORT_THUNK_LIBRARY "libdemo-callback-qsort-thunk.so"
+#define GUEST_STRING_CHUNK 64
+#define GUEST_STRING_LIMIT (1 << 20)
+#define CALLBACK_QSORT_MAX_ELEMS (1 << 20)
+#define CALLBACK_QSORT_STACK_SIZE (1 << 20)
+#define X86_64_OPENAT_NR 257
+
+typedef enum CallbackQsortPhase {
+    CALLBACK_QSORT_PHASE_IDLE,
+    CALLBACK_QSORT_PHASE_NEED_CALLBACK,
+    CALLBACK_QSORT_PHASE_FINISHED,
+} CallbackQsortPhase;
+
+typedef struct CallbackQsortState {
+    uint64_t sort_base;
+    uint64_t guest_cmp_fn;
+    uint64_t guest_trampoline;
+    size_t nmemb;
+    size_t elem_size;
+    void *worker_stack;
+    uint64_t pending_guest_a;
+    uint64_t pending_guest_b;
+    int cmp_result;
+    unsigned int guest_callback_count;
+    CallbackQsortPhase phase;
+    ucontext_t plugin_ctx;
+    ucontext_t worker_ctx;
+} CallbackQsortState;
+
+typedef struct X86Registers {
+    struct qemu_plugin_register *rsp;
+    struct qemu_plugin_register *rdi;
+    struct qemu_plugin_register *rsi;
+} X86Registers;
+
+typedef struct VcpuState {
+    X86Registers regs;
+    GByteArray *buf;
+    CallbackQsortState *active_call;
+} VcpuState;
+
+static GPtrArray *vcpu_states;
+static __thread CallbackQsortState *tls_active_call;
+
+static VcpuState *get_vcpu_state(unsigned int vcpu_index)
+{
+    while (vcpu_states->len <= vcpu_index) {
+        g_ptr_array_add(vcpu_states, NULL);
+    }
+
+    if (g_ptr_array_index(vcpu_states, vcpu_index) == NULL) {
+        VcpuState *state = g_new0(VcpuState, 1);
+        state->buf = g_byte_array_sized_new(16);
+        g_ptr_array_index(vcpu_states, vcpu_index) = state;
+    }
+
+    return g_ptr_array_index(vcpu_states, vcpu_index);
+}
+
+static struct qemu_plugin_register *find_register(const char *name)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+
+    for (guint i = 0; i < regs->len; i++) {
+        qemu_plugin_reg_descriptor *reg =
+            &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+
+        if (strcmp(reg->name, name) == 0) {
+            return reg->handle;
+        }
+    }
+
+    return NULL;
+}
+
+static uint64_t read_reg64(VcpuState *vcpu, struct qemu_plugin_register *reg)
+{
+    bool success;
+
+    g_byte_array_set_size(vcpu->buf, 0);
+    success = qemu_plugin_read_register(reg, vcpu->buf);
+    g_assert(success);
+    g_assert(vcpu->buf->len == 8);
+    return *(uint64_t *)vcpu->buf->data;
+}
+
+static void write_reg64(VcpuState *vcpu, struct qemu_plugin_register *reg,
+                        uint64_t value)
+{
+    bool success;
+
+    g_byte_array_set_size(vcpu->buf, 8);
+    memcpy(vcpu->buf->data, &value, sizeof(value));
+    success = qemu_plugin_write_register(reg, vcpu->buf);
+    g_assert(success);
+}
+
+static bool write_guest_u64(uint64_t addr, uint64_t value)
+{
+    GByteArray data = {
+        .data = (guint8 *)&value,
+        .len = sizeof(value),
+    };
+
+    return qemu_plugin_write_memory_vaddr(addr, &data);
+}
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
+static bool guest_path_matches_bridge(const char *path)
+{
+    g_autofree char *basename = g_path_get_basename(path);
+
+    return strcmp(basename, CALLBACK_QSORT_LIBRARY) == 0;
+}
+
+static char *build_thunk_path(const char *path)
+{
+    g_autofree char *dirname = g_path_get_dirname(path);
+
+    if (strcmp(dirname, ".") == 0) {
+        return g_strdup(CALLBACK_QSORT_THUNK_LIBRARY);
+    }
+
+    return g_build_filename(dirname, CALLBACK_QSORT_THUNK_LIBRARY, NULL);
+}
+
+static int host_compare(const void *lhs, const void *rhs)
+{
+    CallbackQsortState *state = tls_active_call;
+    state->pending_guest_a = (uint64_t)(uintptr_t)lhs;
+    state->pending_guest_b = (uint64_t)(uintptr_t)rhs;
+
+    state->phase = CALLBACK_QSORT_PHASE_NEED_CALLBACK;
+    swapcontext(&state->worker_ctx, &state->plugin_ctx);
+    return state->cmp_result;
+}
+
+static void callback_qsort_worker(void)
+{
+    CallbackQsortState *state = tls_active_call;
+
+    qsort((void *)(uintptr_t)state->sort_base, state->nmemb, state->elem_size,
+          host_compare);
+    state->phase = CALLBACK_QSORT_PHASE_FINISHED;
+    swapcontext(&state->worker_ctx, &state->plugin_ctx);
+    g_assert_not_reached();
+}
+
+static void free_callback_state(CallbackQsortState *state)
+{
+    if (state == NULL) {
+        return;
+    }
+
+    g_free(state->worker_stack);
+    g_free(state);
+}
+
+static bool finalize_if_finished(unsigned int vcpu_index, VcpuState *vcpu,
+                                 uint64_t *sysret)
+{
+    CallbackQsortState *state = vcpu->active_call;
+    g_autofree char *out = NULL;
+
+    if (state->phase != CALLBACK_QSORT_PHASE_FINISHED) {
+        return false;
+    }
+
+    *sysret = 0;
+
+    out = g_strdup_printf(
+        "syscall_filter_callback_qsort: vcpu %u completed qsort "
+        "with %u guest callbacks\n",
+                          vcpu_index, state->guest_callback_count);
+    qemu_plugin_outs(out);
+
+    free_callback_state(state);
+    vcpu->active_call = NULL;
+    tls_active_call = NULL;
+    return true;
+}
+
+static void jump_to_guest_callback(VcpuState *vcpu, CallbackQsortState *state)
+{
+    uint64_t current_rsp = read_reg64(vcpu, vcpu->regs.rsp);
+    uint64_t callback_rsp = current_rsp - sizeof(uint64_t);
+    uint64_t guest_return;
+
+    g_assert((current_rsp & 0xf) == 0 || (current_rsp & 0xf) == 8);
+
+    if ((callback_rsp & 0xf) != 8) {
+        /*
+         * Rebuild the stack so the guest comparator sees a normal SysV
+         * function entry: %rsp points at its return address and
+         * %rsp % 16 == 8.
+         */
+        callback_rsp -= sizeof(uint64_t);
+        read_guest_buffer(current_rsp, &guest_return, sizeof(guest_return));
+        g_assert(write_guest_u64(current_rsp - sizeof(uint64_t),
+                                 guest_return));
+    }
+
+    g_assert(write_guest_u64(callback_rsp, state->guest_trampoline));
+
+    write_reg64(vcpu, vcpu->regs.rsp, callback_rsp);
+    write_reg64(vcpu, vcpu->regs.rdi, state->pending_guest_a);
+    write_reg64(vcpu, vcpu->regs.rsi, state->pending_guest_b);
+    state->guest_callback_count++;
+    qemu_plugin_set_pc(state->guest_cmp_fn);
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
+    if (path == NULL || !guest_path_matches_bridge(path)) {
+        return false;
+    }
+
+    thunk_path = build_thunk_path(path);
+    if (access(thunk_path, F_OK) != 0) {
+        return false;
+    }
+
+    fd = openat((int)a1, thunk_path, (int)a3, (mode_t)a4);
+    g_assert(fd >= 0);
+
+    *sysret = fd;
+    out = g_strdup_printf(
+        "syscall_filter_callback_qsort: redirected %s -> %s (fd=%d)\n",
+                          path, thunk_path, fd);
+    qemu_plugin_outs(out);
+    return true;
+}
+
+static bool handle_callback_start(unsigned int vcpu_index, VcpuState *vcpu,
+                                  uint64_t sort_base, uint64_t nmemb,
+                                  uint64_t elem_size, uint64_t cmp_fn,
+                                  uint64_t trampoline, uint64_t *sysret)
+{
+    CallbackQsortState *state;
+
+    g_assert(vcpu->active_call == NULL);
+    g_assert(elem_size > 0);
+    g_assert(nmemb > 0);
+    g_assert(nmemb <= CALLBACK_QSORT_MAX_ELEMS);
+    g_assert(cmp_fn != 0 && trampoline != 0);
+
+    state = g_new0(CallbackQsortState, 1);
+    state->sort_base = sort_base;
+    state->guest_cmp_fn = cmp_fn;
+    state->guest_trampoline = trampoline;
+    state->nmemb = nmemb;
+    state->elem_size = elem_size;
+    state->worker_stack = g_malloc(CALLBACK_QSORT_STACK_SIZE);
+    state->phase = CALLBACK_QSORT_PHASE_IDLE;
+
+    getcontext(&state->worker_ctx);
+    state->worker_ctx.uc_link = NULL;
+    state->worker_ctx.uc_stack.ss_sp = state->worker_stack;
+    state->worker_ctx.uc_stack.ss_size = CALLBACK_QSORT_STACK_SIZE;
+    makecontext(&state->worker_ctx, callback_qsort_worker, 0);
+
+    vcpu->active_call = state;
+    tls_active_call = state;
+    swapcontext(&state->plugin_ctx, &state->worker_ctx);
+
+    if (finalize_if_finished(vcpu_index, vcpu, sysret)) {
+        return true;
+    }
+
+    if (state->phase == CALLBACK_QSORT_PHASE_NEED_CALLBACK) {
+        jump_to_guest_callback(vcpu, state);
+        return true;
+    }
+
+    g_assert_not_reached();
+}
+
+static bool handle_callback_resume(unsigned int vcpu_index, VcpuState *vcpu,
+                                   int64_t cmp_result, uint64_t *sysret)
+{
+    CallbackQsortState *state = vcpu->active_call;
+
+    g_assert(state != NULL);
+
+    state->cmp_result = (int)cmp_result;
+    tls_active_call = state;
+    swapcontext(&state->plugin_ctx, &state->worker_ctx);
+
+    if (finalize_if_finished(vcpu_index, vcpu, sysret)) {
+        return true;
+    }
+
+    if (state->phase == CALLBACK_QSORT_PHASE_NEED_CALLBACK) {
+        jump_to_guest_callback(vcpu, state);
+        return true;
+    }
+
+    g_assert_not_reached();
+}
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    VcpuState *vcpu = get_vcpu_state(vcpu_index);
+
+    if (handle_library_open(num, a1, a2, a3, a4, sysret)) {
+        return true;
+    }
+
+    if (num != MAGIC_SYSCALL) {
+        return false;
+    }
+
+    switch (a1) {
+    case CALLBACK_QSORT_OP_START:
+        return handle_callback_start(vcpu_index, vcpu, a2, a3, a4, a5, a6,
+                                     sysret);
+    case CALLBACK_QSORT_OP_RESUME:
+        return handle_callback_resume(vcpu_index, vcpu, (int64_t)a2, sysret);
+    default:
+        return false;
+    }
+}
+
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    VcpuState *vcpu = get_vcpu_state(vcpu_index);
+
+    vcpu->regs.rsp = find_register("rsp");
+    vcpu->regs.rdi = find_register("rdi");
+    vcpu->regs.rsi = find_register("rsi");
+    g_assert(vcpu->regs.rsp != NULL);
+    g_assert(vcpu->regs.rdi != NULL);
+    g_assert(vcpu->regs.rsi != NULL);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (argc != 0) {
+        fprintf(stderr,
+                "syscall_filter_callback_qsort: this prototype plugin does not take arguments\n");
+        return -1;
+    }
+
+    if (strcmp(info->target_name, "x86_64") != 0) {
+        fprintf(stderr,
+                "syscall_filter_callback_qsort: unsupported linux-user target '%s' "
+                "(this prototype currently supports only x86_64)\n",
+                info->target_name);
+        return -1;
+    }
+
+    vcpu_states = g_ptr_array_new();
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+    return 0;
+}
-- 
2.53.0


