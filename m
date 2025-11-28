Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFB2D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 09:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOuNr-0004XX-1N; Fri, 28 Nov 2025 04:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4204b036a=Moritz.Haase@bmw.de>)
 id 1vOuNU-0004Vi-0N
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:02:56 -0500
Received: from esa14.hc324-48.eu.iphmx.com ([207.54.69.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4204b036a=Moritz.Haase@bmw.de>)
 id 1vOuNO-0002Ph-PM
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 04:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
 t=1764320570; x=1795856570;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xqQOQrQZ5f3TyevjFaG2rk7jwi4vHfA1IpfCeV5Fzyk=;
 b=FGc51jL6ipGK0kQ8FjHcXdht6mFrQN+3Dlto/JzEHv4MaiEq/CalrS33
 4f/153+Pjp8F/9C/c0hM/CSsPsfj0bpQ18HTpw2qUf/hcWBKrIDgMxm2r
 WuqvsHY8DIYuRz9vl5ybZAvD8kUhTF5JfbxeA0nRjcFUkH1cyXPZWdDIC o=;
X-CSE-ConnectionGUID: 9XY9bJbWRSKCVgbNzqj2Tg==
X-CSE-MsgGUID: X5VTXvFeSieETRo4iOug9g==
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 28 Nov 2025 10:02:16 +0100
Received: from unknown (HELO esabb4.muc) ([10.31.187.135]) by esagw1.muc with
 ESMTP/TLS; 28 Nov 2025 10:02:15 +0100
Received: from smucmp15f.bmwgroup.net (HELO smucmp15f.europe.bmw.corp)
 ([10.30.13.140]) by esabb4.muc with ESMTP/TLS; 28 Nov 2025 10:02:15 +0100
Received: from smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44) by
 smucmp15f.europe.bmw.corp (2a03:1e80:a15:58f::1:4e) with Microsoft SMTP
 Server (version=TLS; Fri, 28 Nov 2025 10:02:14 +0100
Received: from q1054628.de-cci.bmwgroup.net (10.30.85.205) by
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44) with Microsoft SMTP
 Server (version=TLS; Fri, 28 Nov 2025 10:02:14 +0100
X-CSE-ConnectionGUID: WhtqvqPmRXaTV4oPSFT4SA==
X-CSE-MsgGUID: WhfxwAOYSIemSQYn6r7yWw==
X-CSE-ConnectionGUID: QEO4mlH7SsONwxHKxcTSSg==
X-CSE-MsgGUID: cbZ5mu1lQPO0jwhC0+FD6A==
From: Moritz Haase <Moritz.Haase@bmw.de>
To: <qemu-devel@nongnu.org>
CC: Moritz Haase <Moritz.Haase@bmw.de>, <petrosagg@resin.io>,
 <nghiant2710@gmail.com>, <forumi0721@gmail.com>, <laurent@vivier.eu>,
 <berrange@redhat.com>, <mjt@tls.msk.ru>
Subject: [PATCH v5] linux-user: add option to intercept execve() syscalls
Date: Fri, 28 Nov 2025 10:01:32 +0100
Message-ID: <20251128090132.2977069-1-Moritz.Haase@bmw.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp16b.europe.bmw.corp (2a03:1e80:a15:58f::1:44) To
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44)
Received-SPF: pass client-ip=207.54.69.24;
 envelope-from=prvs=4204b036a=Moritz.Haase@bmw.de;
 helo=esa14.hc324-48.eu.iphmx.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order for one to use QEMU user mode emulation under a chroot, it is
required to use binfmt_misc. This can be avoided by QEMU never doing a raw
execve() to the host system, which is especially useful in environments
where binfmt_misc can't be used.

Introduce a new option, -execve, that uses the current QEMU interpreter to
intercept execve(). In addition, execve mode can also be en- and disabled
using the 'QEMU_EXECVE' env var.

qemu_execve() will prepend the interpreter path, similar to what binfmt_misc
would do, and then pass the modified execve() to the host.

It is necessary to parse hashbang scripts in that function otherwise the
kernel will try to run the interpreter of a script without QEMU and get an
invalid exec format error.

Note that a previous incarnation of this patch was submitted a few years ago
(see [0]) by Petros Angelatos as the original author who confirmed that it's
OK to resubmit it.

CC: petrosagg@resin.io
CC: nghiant2710@gmail.com
CC: forumi0721@gmail.com
CC: laurent@vivier.eu
CC: berrange@redhat.com
CC: mjt@tls.msk.ru

Signed-off-by: Petros Angelatos <petrosagg@resin.io>
[MH: Adapted to match coding style; Simplified implementation; Added additional
comments; Improved env var handling]
Signed-off-by: Moritz Haase <Moritz.Haase@bmw.de>

[0]: https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-21843-1-git-send-email-petrosagg@gmail.com/

---

v5:

This is actually v2 of this re-incarnation. Sending it as v5, so it shows as the
most recent version in patchew.

- Simplify implementation by removing possibility to pass script files as 'user
  executables' to qemu, i.e. run 'qemu-<arch> foo.sh'. It's sufficient (at least
  for our use-cases) to restrict this to 'execve()' itself to mimic Kernel
  behaviour with execve mode disabled.
- Add a number of comments to the code to hopefully explain better what's going
  on (when modifying argv for instance).
- Reworked sign-off statements according to review feedback.

v1:

We've been using this feature internally for at least five years by now.
Prior to submission, the code was updated to (hopefully) conform to the
current QEMU coding style.

I'd be happy to add test cases for this feature, but I'd need some pointers
given that I'm a first-time contributor. Thanks!
---
 linux-user/linuxload.c      |  97 ++++++++++++++++++++++++
 linux-user/loader.h         |   1 +
 linux-user/main.c           |  54 +++++++++++++
 linux-user/syscall.c        | 146 +++++++++++++++++++++++++++++++++---
 linux-user/user-internals.h |   1 +
 5 files changed, 287 insertions(+), 12 deletions(-)

diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
index 85d700953e..d75d70fe60 100644
--- a/linux-user/linuxload.c
+++ b/linux-user/linuxload.c
@@ -138,6 +138,103 @@ abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
     return sp;
 }
 
+/**
+ * Prepares script files for execution.
+ *
+ * Checks whether the given file is a script, i.e. starts with a shebang (#!).
+ * If so, the first line is parsed to extract the interpreter name and (if
+ * given) the single argument and bprm is updated accordingly.
+ *
+ * Returns 0 on success, 1 if the file is not a script, <0 for errors.
+ */
+int load_script_file(const char *filename, struct linux_binprm *bprm)
+{
+    int retval, fd;
+    char *i_name = NULL;
+    char **new_argv = NULL;
+    char *cp;
+    char buf[BPRM_BUF_SIZE];
+
+    /* Check if it is a script */
+    fd = open(filename, O_RDONLY);
+    if (fd == -1) {
+        return fd;
+    }
+
+    retval = read(fd, buf, BPRM_BUF_SIZE);
+    close(fd);
+
+    if (retval == -1) {
+        return retval;
+    }
+
+     /* if we have less than 2 bytes, we can guess it is not executable */
+    if (retval < 2) {
+        return -ENOEXEC;
+    }
+
+    /*
+     * Extract interpreter and argument (if given).
+     *
+     * Adapted from the kernel:
+     * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/binfmt_script.c
+     */
+    if ((buf[0] == '#') && (buf[1] == '!')) {
+        /* Ensure buffer is 0-terminated. */
+        buf[BPRM_BUF_SIZE - 1] = '\0';
+        /* Find end of first line, we might have read more than one... */
+        cp = strchr(buf, '\n');
+        /* ... or the first line might have been truncated. */
+        if (cp == NULL) {
+            cp = buf + BPRM_BUF_SIZE - 1;
+        }
+        /* Truncate buffer to first line. */
+        *cp = '\0';
+        /* Truncate trailing whitespace on the first line. */
+        while (cp > buf) {
+            cp--;
+            if ((*cp == ' ') || (*cp == '\t')) {
+                *cp = '\0';
+            } else {
+                break;
+            }
+        }
+        /* Skip (optional) whitespace between shebang and interpreter name. */
+        for (cp = buf + 2; (*cp == ' ') || (*cp == '\t'); cp++) {
+            /* nothing */ ;
+        }
+        if (*cp == '\0') {
+            return -ENOEXEC; /* No interpreter name found */
+        }
+        /* We now have identified the beginning of the interpreter name. */
+        i_name = cp;
+
+        /*
+         * Skip over the interpreter name till we hit end of string or
+         * whitespace (that may separate an optional argument).
+         */
+        for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++) {
+            /* nothing */ ;
+        }
+        /* Mark the end of the interpreter name and skip whitespace behind it. */
+        while ((*cp == ' ') || (*cp == '\t')) {
+            *cp++ = '\0';
+        }
+
+        /* We now have identified the beginning of the argument. */
+        if (*cp) {
+            new_argv = g_new0(char*, 1 + 1);
+            new_argv[0] = g_strdup(cp);
+        }
+        bprm->argv = new_argv;
+        bprm->filename = g_strdup(i_name);
+
+        return 0;
+    } else {
+        return 1;
+    }
+}
+
 int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
                 struct image_info *infop, struct linux_binprm *bprm)
 {
diff --git a/linux-user/loader.h b/linux-user/loader.h
index da9ad28db5..2beedc5f0d 100644
--- a/linux-user/loader.h
+++ b/linux-user/loader.h
@@ -90,6 +90,7 @@ int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
 uint32_t get_elf_eflags(int fd);
 int load_elf_binary(struct linux_binprm *bprm, struct image_info *info);
 int load_flt_binary(struct linux_binprm *bprm, struct image_info *info);
+int load_script_file(const char *filename, struct linux_binprm *bprm);
 
 abi_long memcpy_to_target(abi_ulong dest, const void *src,
                           unsigned long len);
diff --git a/linux-user/main.c b/linux-user/main.c
index db751c0757..eb51c249df 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -128,6 +128,7 @@ static void usage(int exitcode);
 
 static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
 const char *qemu_uname_release;
+const char *qemu_execve_path = NULL;
 
 #if !defined(TARGET_DEFAULT_STACK_SIZE)
 /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
@@ -367,6 +368,56 @@ static void handle_arg_guest_base(const char *arg)
     have_guest_base = true;
 }
 
+static void handle_arg_execve(const char *arg)
+{
+    const char *execfn;
+    char buf[PATH_MAX];
+    char *ret;
+    int len;
+
+    /*
+     * Since the 'execve' command line option has no argument ('has_arg' is
+     * 'false'), this function will always receive NULL for 'arg' during
+     * argument parsing. If 'arg' is non-NULL, we are being called during env
+     * var handling, because QEMU_EXECVE is set.
+     */
+    if (arg != NULL) {
+        /*
+         * If the env var is set, check whether its value is '0'. In this case,
+         * we don't want to enable 'execve' mode and thus bail out. Please note
+         * that an empty value will NOT disable 'execve' mode.
+         */
+        if (!strcmp(arg, "0")) {
+            return;
+        }
+    }
+
+    /* try getauxval() */
+    execfn = (const char *)qemu_getauxval(AT_EXECFN);
+
+    if (execfn != 0) {
+        ret = realpath(execfn, buf);
+
+        if (ret != NULL) {
+            qemu_execve_path = g_strdup(buf);
+            return;
+        }
+    }
+
+    /* try /proc/self/exe */
+    len = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
+
+    if (len != -1) {
+        buf[len] = '\0';
+        qemu_execve_path = g_strdup(buf);
+        return;
+    }
+
+    fprintf(stderr, "qemu_execve: unable to determine interpreter's path\n");
+    exit(EXIT_FAILURE);
+}
+
+
 static void handle_arg_reserved_va(const char *arg)
 {
     char *p;
@@ -497,6 +548,9 @@ static const struct qemu_argument arg_table[] = {
      "uname",      "set qemu uname release string to 'uname'"},
     {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
      "address",    "set guest_base address to 'address'"},
+    {"execve",     "QEMU_EXECVE",      false, handle_arg_execve,
+     "",           "use this interpreter when a process calls execve() "
+     "(disabled if env var is '0', enabled for all other values / when empty)"},
     {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
      "size",       "reserve 'size' bytes for guest virtual address space"},
     {"t",          "QEMU_RTSIG_MAP",   true,  handle_arg_rtsig_map,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2060e561a2..ba89541126 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -127,6 +127,7 @@
 #include <libdrm/drm.h>
 #include <libdrm/i915_drm.h>
 #endif
+#include <linux/binfmts.h>
 #include "linux_loop.h"
 #include "uname.h"
 
@@ -8726,6 +8727,138 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
     return ret;
 }
 
+static int qemu_execve(const char *filename, char *argv[],
+                       char *envp[])
+{
+    char **new_argv;
+    int argc, ret, i, offset = 4;
+    struct linux_binprm *bprm;
+
+    /*
+     * When execve mode is disabled, we just execute the system call with the
+     * arguments as-is. When enabled, we run whatever is supposed to be executed
+     * via qemu.
+     */
+    if (qemu_execve_path == NULL || *qemu_execve_path == 0) {
+        /*
+         * Although execve() is not an interruptible syscall it is
+         * a special case where we must use the safe_syscall wrapper:
+         * if we allow a signal to happen before we make the host
+         * syscall then we will 'lose' it, because at the point of
+         * execve the process leaves QEMU's control. So we use the
+         * safe syscall wrapper to ensure that we either take the
+         * signal as a guest signal, or else it does not happen
+         * before the execve completes and makes it the other
+         * program's problem.
+         */
+        return safe_execve(filename, argv, envp);
+    }
+
+    /*
+     * To launch the new process via qemu, we need to modify the filename and
+     * argv[]. When executing a script we also need to splice in the
+     * interpreter and - if set - the interpreter argument into argv. This
+     * allows us to minic real Kernel behaviour: The Kernel allows one to
+     * execute scripts via execve(). QEMU however doesn't run scripts as
+     * 'user executables', i.e. 'qemu-<arch> foo.sh' results in an 'invalid
+     * exec format' error. 'qemu-<arch> <interpreter> foo.sh' works though,
+     * so this is what we do.
+     *
+     * That means that the expected argv layout is as follows:
+     *
+     * For binaries:
+     *   argv[0] = qemu-<arch>
+     *   argv[1] = -execve
+     *   argv[2] = -0
+     *   argv[3] = original argv[0] (as 'argv[0] override')
+     *   argv[4] = filename (as 'user executable' to run)
+     *   argv[5] = original argv[1]
+     *   ...
+     *
+     * For scripts:
+     *   argv[0] = qemu-<arch>
+     *   argv[1] = -execve
+     *   argv[2] = -0
+     *   argv[3] = interpreter (as 'argv[0] override')
+     *   argv[4] = interpreter (as 'user executable' to run)
+     *   argv[5] = interpreter argument (if any)
+     *   argv[6] = filename
+     *   argv[7] = original argv[1]
+     *   ...
+     */
+
+    /* Determine number of original arguments. */
+    for (argc = 0; argv[argc] != NULL; argc++) {
+        /* nothing */ ;
+    }
+
+    bprm = g_new0(struct linux_binprm, 1);
+    /* Check whether we want to execute a shell script or a binary. */
+    ret = load_script_file(filename, bprm);
+
+    /* Bail out in case of errors (file doesn't exist, ...). */
+    if (ret < 0) {
+        if (ret == -1) {
+            return get_errno(ret);
+        } else {
+            return -host_to_target_errno(ENOEXEC);
+        }
+    }
+
+    /*
+     * When executing a script, we need to splice in the interpreter and -
+     * if set - the argument into argv, so additional space is needed.
+     */
+    if (ret == 0) {
+        offset += (bprm->argv != NULL) ? 2 : 1;
+    }
+
+    /* Zeroed out to ensure array is NULL-terminated. */
+    new_argv = g_new0(char*, argc + offset + 1);
+
+    /*
+     * Copy the original arguments with offset. We don't copy argv[0] (which
+     * would become the 'user executable') as we need to override it with
+     * 'filename' (which might be fully-qualified). The original argv[0] is
+     * restored using the '-0' option.
+     */
+    for (i = 1; i < argc; i++) {
+        new_argv[i + offset] = argv[i];
+    }
+
+    new_argv[0] = g_strdup(qemu_execve_path);
+    /* Ensure execve mode lives on in the new instance. */
+    new_argv[1] = g_strdup("-execve");
+    /* '-0' is used to keep the original argv[0] intact. The actual value is set below. */
+    new_argv[2] = g_strdup("-0");
+    /*
+     * Pass 'filename', which might be a fully-qualified version of the
+     * original argv[0] as the 'user executable' to run to qemu.
+     */
+    new_argv[offset] = g_strdup(filename);
+
+    if (ret == 0) {
+        /*
+         * For scripts, set the interpreter as argv0 of the new process
+         * (argument to -0)...
+         */
+        new_argv[3] = bprm->filename;
+        /* ... and as the executable to execute. */
+        new_argv[4] = bprm->filename;
+
+        /* If set, add the interpreter argument as well. */
+        if (bprm->argv != NULL) {
+            new_argv[5] = bprm->argv[0];
+        }
+    } else {
+        /* For binaries, restore original argv[0]. */
+        new_argv[3] = argv[0];
+    }
+
+    /* See comment above re. why safe syscall handler is used. */
+    return safe_execve(qemu_execve_path, new_argv, envp);
+}
+
 static int do_execv(CPUArchState *cpu_env, int dirfd,
                     abi_long pathname, abi_long guest_argp,
                     abi_long guest_envp, int flags, bool is_execveat)
@@ -8791,17 +8924,6 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
     }
     *q = NULL;
 
-    /*
-     * Although execve() is not an interruptible syscall it is
-     * a special case where we must use the safe_syscall wrapper:
-     * if we allow a signal to happen before we make the host
-     * syscall then we will 'lose' it, because at the point of
-     * execve the process leaves QEMU's control. So we use the
-     * safe syscall wrapper to ensure that we either take the
-     * signal as a guest signal, or else it does not happen
-     * before the execve completes and makes it the other
-     * program's problem.
-     */
     p = lock_user_string(pathname);
     if (!p) {
         goto execve_efault;
@@ -8813,7 +8935,7 @@ static int do_execv(CPUArchState *cpu_env, int dirfd,
     }
     ret = is_execveat
         ? safe_execveat(dirfd, exe, argp, envp, flags)
-        : safe_execve(exe, argp, envp);
+        : qemu_execve(exe, argp, envp);
     ret = get_errno(ret);
 
     unlock_user(p, pathname, 0);
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index 7099349ec8..0fd97cdb4f 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -69,6 +69,7 @@ abi_long get_errno(abi_long ret);
 const char *target_strerror(int err);
 int get_osversion(void);
 void init_qemu_uname_release(void);
+extern const char *qemu_execve_path;
 void fork_start(void);
 void fork_end(pid_t pid);
 

