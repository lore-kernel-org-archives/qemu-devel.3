Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904E4CD98E6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 04:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRFY-0006B7-3P; Fri, 19 Jun 2026 00:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1waRFW-00068q-3s
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:54:38 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1waRFR-0006qk-DX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 00:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1781844852;
 bh=TZliqZd4JuVhVVLPINQl6DrD5OvhAcx3VT87g5WGH2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p+ikQtu7WvDt9HDeyVcOK2H9XL6i0xbBIKoPnxnFRcypmGlh+XVxCYoNJFX+Iah3i
 MID0pFS93gnFNyDnc4/qnaG6J0xfpef1VOAjtpXK56Fvnte1MtMeWxUpLbGEcJ6AB9
 sgz5DauF5Gmnb7M4gwofFhyAqNwL8o4OkDZvKi2446TrW0pRpWKobRHkb+pxpXtuq1
 UR2cHQJOvSdQpQyTrj//3P3u8/uv3lqBJqDSXyg65lXQHn8CkoRm5eXFRdV1d2SJ/Y
 7zD0YLw1L3+A0H2nvfbNe7WFb1hWrWBFf6MggWNo3TPMjckOzIyH0GaxJeX7dFdAea
 1LWYx/2RLKzKg==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id B70CD2FF55B;
 Fri, 19 Jun 2026 04:54:12 +0000 (UTC)
Received: from pc.. (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 190A037C967;
 Fri, 19 Jun 2026 12:54:12 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>,
 Ziyang Zhang <functioner@sjtu.edu.cn>
Subject: [RFC PATCH v2 1/1] contrib/plugins: add a minimal dlcall plugin
Date: Fri, 19 Jun 2026 12:54:04 +0800
Message-Id: <20260619045404.820960-2-functioner@sjtu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619045404.820960-1-functioner@sjtu.edu.cn>
References: <20260617130742.769234-1-functioner@sjtu.edu.cn>
 <20260619045404.820960-1-functioner@sjtu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a minimal dlcall plugin that lets the guest invoke host functions
through magic system calls. The plugin registers a vCPU syscall filter
callback that intercepts a reserved syscall number and dispatches a set
of pass-through operations: querying host attributes, loading and freeing
shared libraries, resolving symbols, retrieving the last library error,
and invoking a host function through a common interface.

The magic syscall number defaults to 4096 and can be overridden at load
time with the "syscall_num=N" argument; values low enough to clash with a
real syscall are rejected.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 contrib/plugins/dlcall.c    | 229 ++++++++++++++++++++++++++++++++++++
 contrib/plugins/meson.build |   1 +
 2 files changed, 230 insertions(+)
 create mode 100644 contrib/plugins/dlcall.c

diff --git a/contrib/plugins/dlcall.c b/contrib/plugins/dlcall.c
new file mode 100644
index 0000000000..c48907fcd5
--- /dev/null
+++ b/contrib/plugins/dlcall.c
@@ -0,0 +1,229 @@
+/*
+ * Copyright (C) 2026, Ziyang Zhang <functioner@sjtu.edu.cn>
+ *
+ * dlcall plugin: lets a guest invoke host functions via a magic
+ * system call. This grants the guest full host access (dlopen/dlsym and
+ * arbitrary function calls), so use it only with trusted guests.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include <glib.h>
+#include <dlfcn.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * The magic system call number for dlcall.
+ *
+ * It defaults to DLCALL_SYSCALL_DEFAULT and can be overridden at load time
+ * with the "syscall_num=N" argument. To avoid hijacking a real syscall the
+ * guest might issue, N must be at least DLCALL_SYSCALL_MIN: every Linux ABI
+ * keeps its syscall numbers well below this, so any number from here up is free.
+ */
+enum {
+    DLCALL_SYSCALL_DEFAULT = 4096,
+    DLCALL_SYSCALL_MIN = 4096,
+};
+
+static int64_t dlcall_syscall_num = DLCALL_SYSCALL_DEFAULT;
+
+/*
+ * dlcall calling convention.
+ *
+ * The guest issues the magic system call (dlcall_syscall_num). The first
+ * argument (a1) is one of the call IDs below; the remaining arguments (a2, a3,
+ * a4, ...) are that ID's operands. All pointer operands are guest virtual
+ * addresses that the plugin dereferences as host addresses directly. This
+ * assumes guest_base is 0, so the guest and host address spaces coincide;
+ * with a non-zero guest_base every pointer operand would be off by guest_base
+ * and the dereferences would hit unrelated host memory. Results are written
+ * back through caller-provided "out" pointers rather than returned in the
+ * syscall value.
+ *
+ * The syscall return value (*sysret) only reports dispatch status: 0 on a
+ * recognised ID, -EINVAL for an unknown one. The actual success/failure of an
+ * operation (e.g. a NULL handle from dlopen) is delivered through its out
+ * pointer, exactly like the underlying libdl call.
+ *
+ * Operands per ID:
+ *
+ *   DLCALL_ID_GET_HOST_ATTRIBUTE
+ *     a2  const char *key        in:  attribute name to query
+ *     a3  const char **attr_ptr  out: matching value, or NULL if unknown
+ *
+ *   DLCALL_ID_LOAD_LIBRARY                            (wraps dlopen)
+ *     a2  const char *path       in:  library path
+ *     a3  int flags              in:  dlopen() flags (e.g. RTLD_NOW)
+ *     a4  void **handle_ptr      out: library handle, or NULL on failure
+ *
+ *   DLCALL_ID_GET_PROC_ADDRESS                        (wraps dlsym)
+ *     a2  void *handle           in:  library handle
+ *     a3  const char *name       in:  symbol name
+ *     a4  void **entry_ptr       out: symbol address, or NULL if not found
+ *
+ *   DLCALL_ID_FREE_LIBRARY                            (wraps dlclose)
+ *     a2  void *handle           in:  library handle
+ *     a3  int *ret_ptr           out: dlclose() return value (0 on success)
+ *
+ *   DLCALL_ID_GET_LIBRARY_ERROR                       (wraps dlerror)
+ *     a2  const char **error_ptr out: last libdl error string, or NULL
+ *
+ *   DLCALL_ID_INVOKE_PROC                             (calls the symbol)
+ *     a2  void *proc             in:  function pointer, signature
+ *                                     void (*)(void *arg1, void *arg2)
+ *     a3  void *arg1             in:  first argument forwarded to proc
+ *     a4  void *arg2             in:  second argument forwarded to proc
+ */
+enum DlcallID {
+    DLCALL_ID_GET_HOST_ATTRIBUTE,
+    DLCALL_ID_LOAD_LIBRARY,
+    DLCALL_ID_GET_PROC_ADDRESS,
+    DLCALL_ID_FREE_LIBRARY,
+    DLCALL_ID_GET_LIBRARY_ERROR,
+    DLCALL_ID_INVOKE_PROC,
+};
+
+static inline const char *query_host_attribute(const char *key)
+{
+    if (strcmp(key, "emu") == 0) {
+        return "qemu";
+    }
+    return NULL;
+}
+
+static inline void invoke_proc(void *proc, void *arg1, void *arg2)
+{
+    typedef void (*Func)(void * /*arg1*/, void * /*arg2*/);
+    Func func = (Func) proc;
+    func(arg1, arg2);
+}
+
+static bool vcpu_syscall_filter(qemu_plugin_id_t id, unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *sysret)
+{
+    if (num == dlcall_syscall_num) {
+        switch (a1) {
+        /* Query host attribute by a reserved key. */
+        case DLCALL_ID_GET_HOST_ATTRIBUTE: {
+            const char *key = (const char *) a2;
+            const char **attr_ptr = (const char **) a3;
+            assert(attr_ptr);
+            *attr_ptr = query_host_attribute(key);
+            *sysret = 0;
+            break;
+        }
+
+        /* Load a shared library. */
+        case DLCALL_ID_LOAD_LIBRARY: {
+            const char *path = (const char *) a2;
+            int flags = (int) a3;
+            void **handle_ptr = (void **) a4;
+            assert(handle_ptr);
+            *handle_ptr = dlopen(path, flags);
+            *sysret = 0;
+            break;
+        }
+
+        /* Get the address of a function in a shared library. */
+        case DLCALL_ID_GET_PROC_ADDRESS: {
+            void *handle = (void *) a2;
+            const char *name = (const char *) a3;
+            void **entry_ptr = (void **) a4;
+            assert(entry_ptr);
+            *entry_ptr = dlsym(handle, name);
+            *sysret = 0;
+            break;
+        }
+
+        /* Free a shared library. */
+        case DLCALL_ID_FREE_LIBRARY: {
+            void *handle = (void *) a2;
+            int *ret_ptr = (int *) a3;
+            *ret_ptr = dlclose(handle);
+            *sysret = 0;
+            break;
+        }
+
+        /* Get the last error message for a library event. */
+        case DLCALL_ID_GET_LIBRARY_ERROR: {
+            const char **error_ptr = (const char **) a2;
+            *error_ptr = dlerror();
+            *sysret = 0;
+            break;
+        }
+
+        /* Invoke a function of a common interface. */
+        case DLCALL_ID_INVOKE_PROC: {
+            void *proc = (void *) a2;
+            void *arg1 = (void *) a3;
+            void *arg2 = (void *) a4;
+            assert(proc);
+            invoke_proc(proc, arg1, arg2);
+            *sysret = 0;
+            break;
+        }
+
+        default:
+            *sysret = -EINVAL;
+            break;
+        }
+        return true;
+    }
+    return false;
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    if (info->system_emulation) {
+        fprintf(stderr, "plugin dlcall: only useful for user emulation\n");
+        return -1;
+    }
+
+    for (int i = 0; i < argc; i++) {
+        char *opt = argv[i];
+        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
+        if (g_strcmp0(tokens[0], "syscall_num") == 0) {
+            const char *val = tokens[1];
+            char *endptr = NULL;
+            guint64 num;
+            if (!val || *val == '\0') {
+                fprintf(stderr,
+                        "plugin dlcall: missing value for syscall_num\n");
+                return -1;
+            }
+            num = g_ascii_strtoull(val, &endptr, 0);
+            if (*endptr != '\0' || g_strrstr(val, "-") != NULL) {
+                fprintf(stderr,
+                        "plugin dlcall: invalid syscall_num '%s'\n", val);
+                return -1;
+            }
+            if (num < DLCALL_SYSCALL_MIN || num > G_MAXINT64) {
+                fprintf(stderr,
+                        "plugin dlcall: syscall_num %s is out of range; "
+                        "it must be >= %d to avoid clashing with a real "
+                        "syscall\n", val, DLCALL_SYSCALL_MIN);
+                return -1;
+            }
+            dlcall_syscall_num = (int64_t) num;
+        } else {
+            fprintf(stderr, "plugin dlcall: unknown option '%s'\n", opt);
+            return -1;
+        }
+    }
+
+    qemu_plugin_register_vcpu_syscall_filter_cb(id, vcpu_syscall_filter);
+
+    return 0;
+}
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
index 099319e7a1..e17f3e5387 100644
--- a/contrib/plugins/meson.build
+++ b/contrib/plugins/meson.build
@@ -2,6 +2,7 @@ contrib_plugins = [
 'bbv.c',
 'cache.c',
 'cflow.c',
+'dlcall.c',
 'drcov.c',
 'execlog.c',
 'hotblocks.c',
-- 
2.34.1


