Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D35C83F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 14:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjgOx-0006wO-Bl; Thu, 29 Aug 2024 10:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sjgOv-0006mC-Ft
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:45:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1sjgOt-0002tc-0H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 10:45:29 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c0a9f2b967so843796a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724942725; x=1725547525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FipoVkQ9gkOn2t82W0M6/yWJgg9Wigs02TS+sGC+E0=;
 b=ZleeLa2mGnAF1HR4D5GaIDD9b40QkuDVuN0m6haIVq0/Z5uY1G8Od4DxjqaQ2dEYq1
 ND92aiXodbz++VIZYAMxLirvnz41/DoaEeYHT60kuNp7QsNa44hSE4w8+1GPjg0BJHod
 VqDiOjf1xkiscOrQlj9iCsOc5Ji/Gz4RTEzIZPLIiZM8Nlsg6xebe0HLICsbGUfpja4s
 e1hoGHqrYZ8RGlccLE28Gzbk6E8kgsDHu9MXVzE8L3JJArStnOguuUYV99h23of2a8Ws
 QnSguFPaTOX/wdqtmV2o//MJ3rJZYlT7+F2FudGjEusG2AX+7ymsEwL5HQTKe+a7uvk3
 iOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724942725; x=1725547525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FipoVkQ9gkOn2t82W0M6/yWJgg9Wigs02TS+sGC+E0=;
 b=PDUXjmIDQCnLJ1k3lZms/CTd0DBvi0YKR/f7b7pftTqgFPogR5VJG2BQEbU7Ext91m
 pjobcGCkB8U5JRMwL30qD18et5jed1aALL7ZXoRFb4iu2zXpqmzScFUJTxfSN59PgOGn
 jRfWxPYXZb6OYnDNzDMREL8IzCEFbyR0IB/WefnFqf57RGRbkWUIlGNc2hyZa3It93Qp
 L0oR3ZUgoLumi70qSq2Cqlq7fKTuUre04XNisZWBziBXCZ16KPPhkmut1FMzHvs8JrBm
 nVW7dVnjp+njcOS8q1azMb+NtvlWS4uUqPJqq3fE6uUKE3JntSev7M6uvV1nR6BDlI29
 YtRA==
X-Gm-Message-State: AOJu0YzMEsk8xWPTePYVV687S4VKeX76rjOSCl4M5kleAUvbxlmQnFnh
 jzNrXhNf+V6ldT1Bk9nJdxtAwRYhmGrBRf7sNEBJ2R9Qq1GEcRdk0Oy29gdH
X-Google-Smtp-Source: AGHT+IHg8jxCDW6ZWSMhTlUHXWS6maN+8RjgL/Q5+4gRrpj7d0EiCeMzBiwUYhCoXsvhFnL2FS7yjQ==
X-Received: by 2002:a05:6402:51cb:b0:5be:fadc:e13c with SMTP id
 4fb4d7f45d1cf-5c21ed34d91mr2727163a12.4.1724942724685; 
 Thu, 29 Aug 2024 07:45:24 -0700 (PDT)
Received: from top.fritz.box (p4fd6b0d7.dip0.t-ipconnect.de. [79.214.176.215])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989035f80sm87313166b.78.2024.08.29.07.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:45:24 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v2 1/1] linux-user: add openat2 support in linux-user
Date: Thu, 29 Aug 2024 16:44:15 +0200
Message-ID: <20240829144413.6942-4-mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240829144413.6942-2-mvogt@redhat.com>
References: <20240829144413.6942-2-mvogt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=michael.vogt@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds support for the `openat2()` syscall in the
`linux-user` userspace emulator.

It is implemented by extracting a new helper `maybe_do_fake_open()`
out of the exiting `do_guest_openat()` and share that with the
new `do_guest_openat2()`. Unfortunatly we cannot just make
do_guest_openat2() a superset of do_guest_openat() because the
openat2() syscall is stricter with the argument checking and
will return an error for invalid flags or mode combinations (which
open()/openat() will ignore).

Note that in this commit using openat2() for a "faked" file in
/proc will ignore the "resolve" flags. This is not great but it
seems similar to the exiting behavior when openat() is called
with a dirfd to "/proc". Here too the fake file lookup may
not catch the special file because "realpath()" is used to
determine if the path is in /proc. Alternatively to ignoring
we could simply fail with `-TARGET_ENOSYS` (or similar) if
`resolve` flags are passed and we found something that looks
like a file in /proc that needs faking.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
Buglink: https://github.com/osbuild/bootc-image-builder/issues/619
---
 linux-user/syscall.c      | 98 +++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h |  7 +++
 meson.build               |  1 +
 3 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d5415674d..c241c6d3a0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -85,6 +85,10 @@
 #include <sys/kcov.h>
 #endif
 
+#ifdef HAVE_OPENAT2_H
+#include <linux/openat2.h>
+#endif
+
 #define termios host_termios
 #define winsize host_winsize
 #define termio host_termio
@@ -653,6 +657,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+#ifdef HAVE_OPENAT2_H
+safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
+              const struct open_how *, how, size_t, size)
+#endif
 #if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
@@ -8334,8 +8342,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
 }
 #endif
 
-int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
-                    int flags, mode_t mode, bool safe)
+static int maybe_do_fake_open(CPUArchState *cpu_env, int dirfd,
+                              const char *fname, int flags, mode_t mode,
+                              bool safe, bool *use_returned_fd)
 {
     g_autofree char *proc_name = NULL;
     const char *pathname;
@@ -8362,6 +8371,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
 #endif
         { NULL, NULL, NULL }
     };
+    *use_returned_fd = true;
 
     /* if this is a file from /proc/ filesystem, expand full name */
     proc_name = realpath(fname, NULL);
@@ -8418,12 +8428,87 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
+    *use_returned_fd = false;
+    return -1;
+}
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
+                    int flags, mode_t mode, bool safe)
+{
+    bool use_returned_fd;
+    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, flags, mode, safe,
+                                &use_returned_fd);
+    if (use_returned_fd)
+        return fd;
+
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, path(fname), flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, path(fname), flags, mode);
+    }
+}
+
+#ifdef HAVE_OPENAT2_H
+static int do_guest_openat2(CPUArchState *cpu_env, int dirfd, const char *fname,
+                            struct open_how *how)
+{
+    /*
+     * Ideally we would pass "how->resolve" flags into this helper too but
+     * the lookup for files that need faking is based on "realpath()" so
+     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
+     * be honored right now.
+     */
+    bool use_returned_fd;
+    int fd = maybe_do_fake_open(cpu_env, dirfd, fname, how->flags, how->mode,
+                                true, &use_returned_fd);
+    if (use_returned_fd)
+        return fd;
+
+    return safe_openat2(dirfd, fname, how, sizeof(struct open_how));
+}
+
+static int do_openat2(CPUArchState *cpu_env, abi_long arg1, abi_long arg2,
+                      abi_long arg3, abi_long arg4)
+{
+    struct open_how how = {0};
+    struct target_open_how *target_how = NULL;
+    int ret;
+
+    char *p = lock_user_string(arg2);
+    if (!p) {
+        ret = -TARGET_EFAULT;
+        goto out;
+    }
+    if (!(lock_user_struct(VERIFY_READ, target_how, arg3, 1))) {
+        ret = -TARGET_EFAULT;
+        goto out;
+    }
+    size_t target_open_how_struct_size = arg4;
+    if (target_open_how_struct_size < sizeof(struct target_open_how)) {
+        ret = -TARGET_EINVAL;
+        goto out;
+    }
+    if (target_open_how_struct_size > sizeof(struct target_open_how)) {
+        qemu_log_mask(LOG_UNIMP, "Unimplemented openat2 open_how size: %lu\n",
+                      target_open_how_struct_size);
+        ret = -TARGET_E2BIG;
+        goto out;
     }
+
+    how.flags = target_to_host_bitmask(target_how->flags, fcntl_flags_tbl);
+    how.mode = tswap64(target_how->mode);
+    how.resolve = tswap64(target_how->resolve);
+    ret = get_errno(do_guest_openat2(cpu_env, arg1, p, &how));
+
+    fd_trans_unregister(ret);
+ out:
+    if (target_how)
+        unlock_user_struct(target_how, arg3, 0);
+    if (p)
+        unlock_user(p, arg2, 0);
+    return ret;
 }
+#endif
 
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
 {
@@ -9197,6 +9282,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
+#if defined(TARGET_NR_openat2) && defined(HAVE_OPENAT2_H)
+    case TARGET_NR_openat2:
+        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
+        return ret;
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a00b617cae..2a79ae13c9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2754,4 +2754,11 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+/* from kernel's include/uapi/linux/openat2.h */
+struct target_open_how {
+    abi_ullong flags;
+    abi_ullong mode;
+    abi_ullong resolve;
+};
+
 #endif
diff --git a/meson.build b/meson.build
index fbda17c987..220ccbcbe6 100644
--- a/meson.build
+++ b/meson.build
@@ -2465,6 +2465,7 @@ config_host_data.set('CONFIG_LINUX_MAGIC_H', cc.has_header('linux/magic.h'))
 config_host_data.set('CONFIG_VALGRIND_H', cc.has_header('valgrind/valgrind.h'))
 config_host_data.set('HAVE_BTRFS_H', cc.has_header('linux/btrfs.h'))
 config_host_data.set('HAVE_DRM_H', cc.has_header('libdrm/drm.h'))
+config_host_data.set('HAVE_OPENAT2_H', cc.has_header('linux/openat2.h'))
 config_host_data.set('HAVE_PTY_H', cc.has_header('pty.h'))
 config_host_data.set('HAVE_SYS_DISK_H', cc.has_header('sys/disk.h'))
 config_host_data.set('HAVE_SYS_IOCCOM_H', cc.has_header('sys/ioccom.h'))
-- 
2.45.2


