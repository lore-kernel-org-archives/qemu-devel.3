Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA8BCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 23:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGQYG-0000yb-JM; Tue, 04 Nov 2025 18:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vGPKd-00041Y-20
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:16:51 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vGPKa-0007KP-TK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:16:50 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so1099558966b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 14:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762294606; x=1762899406; darn=nongnu.org;
 h=subject:date:cc:from:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=voo4jHzO7fTgG9Zl3uy5WwMebs0EnnF6JUdBlr2vQAg=;
 b=GBF2OVF4D7BOKdIB/Q4hXHBPKdd0yO2hx1cc7KU1mfn8V3kJN84XRLoCCBTRXptj9P
 rWjnuJziU8IeFzDK7H55d9J3AmX4kmDoJW9g3gXvdK8YJgYPvmpzcw5DThUflUmBEXqh
 D8p632GFVrS0IpmFFFmTQMfh46qAG8zNSjHuUXDD3MeiVz2DKjQDbeAm6uompMyI5JD/
 eLinqu7WNKh7qnhXIDS4vmeshBoNQ2xmBgwKL1GCZwtNT02EIQUcvaBgcqJfREvyBRFA
 c7OkfO+6NRZmUyPlK0vVZibUXhGlE+dAOJ8SvI+lfquaDHQg/xJOcmMys7Eyxzq4TePr
 xZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762294606; x=1762899406;
 h=subject:date:cc:from:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voo4jHzO7fTgG9Zl3uy5WwMebs0EnnF6JUdBlr2vQAg=;
 b=oyB39jxtVs+qaJhcePVy/VWLedDRgmAgHHYfA3NK8ZawZQy4JelwJkI7Wt/DckKEO6
 oTWIc3Wi1HKcUjdrRQPELlFuiQzwvvndtnIeWDWbZYnQ2F6vo22yz6Et6Jzp1bl2Y7F/
 InvH54vdwHiV0LD1IZBQxu6MPeolx24pJPOceTku/cyzkcOBZl3LeWbrcsFvFkyf49+3
 dNplncHcI7UCeFcuZq1Jkx4fFt2qQFEd7ZjHff2hSARtD3eK8zKn6k3MO/7DuQXAAbQF
 MOXyCDLtihgIDDwcZL8r9YJdP+ZrCi7MeU7HXmDFtUTIMl39oPo2cbXHGp61qgHlADQf
 52Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Tm1aoaKDq52/x+61NTPBZfO1ef+opotwfqYMlDVRSCAfBN+qq2gPTqZPGWQo942PwA9eSpR8a2Of@nongnu.org
X-Gm-Message-State: AOJu0YzjNrBi1YCaUs6no/AwRjo8kpjV7QzXH/K1WBIKQlvT70qmG8qf
 hGAock6zECD3DPDTmWhuJHynZcf+5Jhr3RPLyyHkxCc36C/bpIBFvcRVkZQrWe4E
X-Gm-Gg: ASbGncuglMbXig64nJZREu6Iza8RrfvElRLPTdViSrF9D7CEcHgGRcgBCmPe8qrXNxi
 aoc5h778QIsP7EAHAax4cCiWQ0NKk8fQ26qEEpSN9ihru39JC4wQNsNEyoiawvTinp3lJ6Hju53
 BCjIgRwjzGWNIFT97+Dkz5H3vo4HHj1xPyAlnF4siCy1Fdkhsnx0v6tkwbLRm/JV3jnNQb35umi
 cycYVtB/Oru3s53gR04WTzYxR/LmMr6UbULOqlo2bLFjvj9X1FFddPIg4+BhNO5XXehKSXWL5b/
 qM6Lx2N5yZt/9X+/SJdPyWo2a5yz6WDleJJFz0zRiKGH9mJU/e1SWY8TifA9rfvBHdvsvDdmMVs
 Qnp1OIIGk/BWx1uVNVI0uEmjLx+YOCobF8bfOES+2jQbN1TE1FOVHOzLIkoGANavnQLeE2pXQdc
 Kw6IxA1OmNZtmwy9LlQVw9gYA=
X-Google-Smtp-Source: AGHT+IHpA8tlD57Y0aakU4ByChivU27L2Mi4Ajf5ok186Y7CSb9g+tmGHyHQmnnn8VIuuCeMX9/NXA==
X-Received: by 2002:a17:907:d649:b0:b71:5079:9702 with SMTP id
 a640c23a62f3a-b7265298431mr81988366b.21.1762294605586; 
 Tue, 04 Nov 2025 14:16:45 -0800 (PST)
Received: from localhost (95C8783E.dsl.pool.telekom.hu. [149.200.120.62])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fe3a07dsm315255166b.64.2025.11.04.14.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:16:45 -0800 (PST)
Message-ID: <fba383dfd9b9551916b193081e9a2115.rbalint@gmail.com>
From: Balint Reczey <rbalint@gmail.com>
CC: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Date: Sun, 2 Nov 2025 14:26:45 +0100
Subject: [PATCH 1/1] user: add runtime switch to call safe_syscall via libc
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=rbalint@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Nov 2025 18:34:58 -0500
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

Add a libc-backed path for safe_syscall() that make syscalls via
libc's syscall(). This enables interposing syscalls via LD_PRELOAD when
running static guest binaries under a dynamically linked qemu-user.

The assembly implementation (safe_syscall_base()) remains the default.
A runtime switch or a set environment variable changes the behavior:

Command line: -libc-syscall
Environment: QEMU_LIBC_SYSCALL

Signed-off-by: Balint Reczey <balint@balintreczey.hu>
---
 bsd-user/main.c             | 11 +++++++
 common-user/meson.build     |  1 +
 common-user/safe-syscall.c  | 57 +++++++++++++++++++++++++++++++++++++
 docs/user/main.rst          | 28 ++++++++++++++++--
 include/user/safe-syscall.h | 25 +++++++++++-----
 linux-user/main.c           |  9 ++++++
 6 files changed, 122 insertions(+), 9 deletions(-)
 create mode 100644 common-user/safe-syscall.c

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 73aae8c327..9b3ff67859 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -38,6 +38,7 @@
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
+#include "user/safe-syscall.h"
 #include "accel/accel-ops.h"
 #include "tcg/startup.h"
 #include "qemu/timer.h"
@@ -166,6 +167,7 @@ static void usage(void)
            "-E var=value      sets/modifies targets environment variable(s)\n"
            "-U var            unsets targets environment variable(s)\n"
            "-B address        set guest_base address to address\n"
+           "-libc-syscall     use libc syscall() instead of assembly safe-syscall\n"
            "\n"
            "Debug options:\n"
            "-d item1[,...]    enable logging of specified items\n"
@@ -183,6 +185,8 @@ static void usage(void)
            "Environment variables:\n"
            "QEMU_STRACE       Print system calls and arguments similar to the\n"
            "                  'strace' program.  Enable by setting to any value.\n"
+           "QEMU_LIBC_SYSCALL Use libc syscall() instead of assembly safe-syscall.\n"
+           "                  Enable by setting to any value.\n"
            "You can use -E and -U options to set/unset environment variables\n"
            "for target process.  It is possible to provide several variables\n"
            "by repeating the option.  For example:\n"
@@ -310,6 +314,11 @@ int main(int argc, char **argv)
     qemu_add_opts(&qemu_trace_opts);
     qemu_plugin_add_opts();
 
+    /* Check QEMU_LIBC_SYSCALL environment variable */
+    if (getenv("QEMU_LIBC_SYSCALL")) {
+        qemu_use_libc_syscall = true;
+    }
+
     optind = 1;
     for (;;) {
         if (optind >= argc) {
@@ -380,6 +389,8 @@ int main(int argc, char **argv)
             have_guest_base = true;
         } else if (!strcmp(r, "drop-ld-preload")) {
             (void) envlist_unsetenv(envlist, "LD_PRELOAD");
+        } else if (!strcmp(r, "libc-syscall")) {
+            qemu_use_libc_syscall = true;
         } else if (!strcmp(r, "seed")) {
             seed_optarg = optarg;
         } else if (!strcmp(r, "one-insn-per-tb")) {
diff --git a/common-user/meson.build b/common-user/meson.build
index ac9de5b9e3..d44ffe1f56 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -7,4 +7,5 @@ common_user_inc += include_directories('host/' / host_arch)
 user_ss.add(files(
   'safe-syscall.S',
   'safe-syscall-error.c',
+  'safe-syscall.c',
 ))
diff --git a/common-user/safe-syscall.c b/common-user/safe-syscall.c
new file mode 100644
index 0000000000..d1476c3113
--- /dev/null
+++ b/common-user/safe-syscall.c
@@ -0,0 +1,57 @@
+/*
+ * safe-syscall.c: C implementation using libc's syscall()
+ * to handle signals occurring at the same time as system calls.
+ *
+ * Written by Balint Reczey <balint@balintreczey.hu>
+ *
+ * Copyright (C) 2025 Balint Reczey
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#if defined(__linux__)
+# include "special-errno.h"
+#elif defined(__FreeBSD__)
+# include "errno_defs.h"
+#endif
+#include "user/safe-syscall.h"
+#include <stdarg.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include "qemu/atomic.h"
+
+/* Global runtime toggle (default: false). */
+bool qemu_use_libc_syscall;
+
+/*
+ * libc-backed implementation: Make a system call via libc's syscall()
+ * if no guest signal is pending.
+ */
+long safe_syscall_libc(int *pending, long number, ...)
+{
+    va_list ap;
+    long arg1, arg2, arg3, arg4, arg5, arg6;
+    long ret;
+
+    /* Check if a guest signal is pending */
+    if (qatomic_read(pending)) {
+        errno = QEMU_ERESTARTSYS;
+        return -1;
+    }
+
+    va_start(ap, number);
+    /* Extract up to 6 syscall arguments */
+    arg1 = va_arg(ap, long);
+    arg2 = va_arg(ap, long);
+    arg3 = va_arg(ap, long);
+    arg4 = va_arg(ap, long);
+    arg5 = va_arg(ap, long);
+    arg6 = va_arg(ap, long);
+    va_end(ap);
+
+    /* Make the actual system call using libc's syscall() */
+    ret = syscall(number, arg1, arg2, arg3, arg4, arg5, arg6);
+
+    return ret;
+}
diff --git a/docs/user/main.rst b/docs/user/main.rst
index a8ddf91424..6b7e76dfe1 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -70,7 +70,7 @@ Command line options
 
 ::
 
-   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] program [arguments...]
+   qemu-i386 [-h] [-d] [-L path] [-s size] [-cpu model] [-g endpoint] [-B offset] [-R size] [-libc-syscall] program [arguments...]
 
 ``-h``
    Print the help
@@ -101,6 +101,15 @@ Command line options
    bytes). \"G\", \"M\", and \"k\" suffixes may be used when specifying
    the size.
 
+``-libc-syscall``
+   Use the host C library's ``syscall()`` entry point for guest system calls
+   instead of QEMU's built-in safe-syscall trampoline. By default this option
+   is disabled and QEMU uses its internal assembly implementation for
+   performance and precise control of signal-restart semantics. This switch is
+   primarily intended for debugging and integration scenarios (for example
+   when interposing on ``syscall()`` via ``LD_PRELOAD``). Available on Linux
+   and BSD user-mode builds.
+
 Debug options:
 
 ``-d item1,...``
@@ -135,6 +144,10 @@ QEMU_STRACE
    format are printed with information for six arguments. Many
    flag-style arguments don't have decoders and will show up as numbers.
 
+QEMU_LIBC_SYSCALL
+   When set to a non-empty value, behave as if ``-libc-syscall`` was specified
+   on the command line. Defaults to disabled.
+
 Other binaries
 ~~~~~~~~~~~~~~
 
@@ -231,7 +244,7 @@ Command line options
 
 ::
 
-   qemu-sparc64 [-h] [-d] [-L path] [-s size] [-bsd type] program [arguments...]
+   qemu-sparc64 [-h] [-d] [-L path] [-s size] [-bsd type] [-libc-syscall] program [arguments...]
 
 ``-h``
    Print the help
@@ -256,6 +269,11 @@ Command line options
    Set the type of the emulated BSD Operating system. Valid values are
    FreeBSD, NetBSD and OpenBSD (default).
 
+``-libc-syscall``
+   Use the host C library's ``syscall()`` entry point for guest system calls
+   instead of QEMU's built-in safe-syscall trampoline. See the Linux user-mode
+   option of the same name for details. Defaults to disabled.
+
 Debug options:
 
 ``-d item1,...``
@@ -266,3 +284,9 @@ Debug options:
    Run the emulation with one guest instruction per translation block.
    This slows down emulation a lot, but can be useful in some situations,
    such as when trying to analyse the logs produced by the ``-d`` option.
+
+Environment variables:
+
+QEMU_LIBC_SYSCALL
+   When set to a non-empty value, behave as if ``-libc-syscall`` was specified
+   on the command line. Defaults to disabled.
diff --git a/include/user/safe-syscall.h b/include/user/safe-syscall.h
index aa075f4d5c..02a95c24e9 100644
--- a/include/user/safe-syscall.h
+++ b/include/user/safe-syscall.h
@@ -125,16 +125,27 @@
  * kinds of restartability.
  */
 
-/* The core part of this function is implemented in assembly */
-long safe_syscall_base(int *pending, long number, ...);
-long safe_syscall_set_errno_tail(int value);
+/*
+ * The core part remains implemented in assembly; a C dispatcher selects
+ * runtime path.
+ */
+extern long safe_syscall_base(int *pending, long number, ...);
+extern long safe_syscall_set_errno_tail(int value);
+extern long safe_syscall_libc(int *pending, long number, ...);
+extern bool qemu_use_libc_syscall;
 
-/* These are defined by the safe-syscall.inc.S file */
+/*
+ * These symbols are defined for compatibility with signal handling code.
+ * In the C implementation, they are dummy symbols.
+ */
 extern char safe_syscall_start[];
 extern char safe_syscall_end[];
 
-#define safe_syscall(...)                                                 \
-    safe_syscall_base(&get_task_state(thread_cpu)->signal_pending,        \
-                      __VA_ARGS__)
+#define safe_syscall(...)                                               \
+    (qemu_use_libc_syscall ?                                            \
+     safe_syscall_libc(&get_task_state(thread_cpu)->signal_pending,     \
+                       __VA_ARGS__) :                                   \
+     safe_syscall_base(&get_task_state(thread_cpu)->signal_pending,     \
+                       __VA_ARGS__))
 
 #endif
diff --git a/linux-user/main.c b/linux-user/main.c
index db751c0757..de2a20efb4 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -40,6 +40,7 @@
 #include "qemu/plugin.h"
 #include "user/guest-base.h"
 #include "user/page-protection.h"
+#include "user/safe-syscall.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/user.h"
 #include "accel/accel-ops.h"
@@ -456,6 +457,12 @@ static void handle_arg_jitdump(const char *arg)
     perf_enable_jitdump();
 }
 
+static void handle_arg_libc_syscall(const char *arg)
+{
+    /* Enable libc-backed syscall implementation */
+    qemu_use_libc_syscall = true;
+}
+
 static QemuPluginList plugins = QTAILQ_HEAD_INITIALIZER(plugins);
 
 #ifdef CONFIG_PLUGIN
@@ -534,6 +541,8 @@ static const struct qemu_argument arg_table[] = {
      "",           "Generate a /tmp/perf-${pid}.map file for perf"},
     {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
      "",           "Generate a jit-${pid}.dump file for perf"},
+    {"libc-syscall", "QEMU_LIBC_SYSCALL", false, handle_arg_libc_syscall,
+     "",           "use libc syscall() instead of assembly safe-syscall"},
     {NULL, NULL, false, NULL, NULL, NULL}
 };
 
-- 
2.43.0


