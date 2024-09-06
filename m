Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE04CE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTZd-00011g-0a; Fri, 06 Sep 2024 03:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1smTZb-0000vd-GX
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:40:03 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1smTZY-0000nZ-IE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:40:02 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso160122366b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725608399; x=1726213199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrqYXIUGLDRsHKjqewIYMs5QmTq23Cn7xbIqlqdjDQk=;
 b=Te4JCDHnqgtIEwdVD/WvUmfWkq1viXQiT0+NVt85YOa1UbpPEXjfeJCoB2JY4KRqab
 F1WdCspV2WlfkkDmvRP4LYz3fuCIkOkSxaOxVWj+h08LFA0VXXn53npaEYvb+WzQkGEf
 Dvw3vWSloyJX+zHEPVqMRQfVVySQHCZfmkvIPfojdtduaAlCA9aZySPpJzkwT7F6Fl75
 qpQUKHdOjB4JmrNkaELPy5xQ3oIVpkXyE5r65B6ui+r/nDZBRpwYnyAUsk0xFfXUZml2
 At+1TgpLMk8PJPoDrqSg5SFHP2+H7vtNK30CA+fKTE3j8W1vRxOGY6tJQJAJV8tG+wBr
 85tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725608399; x=1726213199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrqYXIUGLDRsHKjqewIYMs5QmTq23Cn7xbIqlqdjDQk=;
 b=Fcc4xCQq5OrFo0AtjCzju6+bloMpJEey1ekEaHw7rhCI6sqpo10tF/PBprwQvJc6k8
 qJEK7R2oGPIea/7g5sxEiE8oa44Gqjmui/ei8ybVQPhKtDkXkj0FWlFmcEI+0FNmXcwb
 uVMOxFPdyH0pzsu6dTfI51dwsocePDROPyz8VkFb0RdbRwb6sAqSEykeOGDAovnwvXBs
 MLjv8fy84Oc4LRNvc+/E7IQO5TF2Ua4bwZajZlhQMP05CFulZQFfoJrZqhE7j0P8Kkrs
 3BG1ylsjvliWJUKQdboifOLnjQgveDJIkQDGDjtGIiIk+GMPa+4w479DNAFe/e4zI+G5
 GhMg==
X-Gm-Message-State: AOJu0Yxjp2HfSas/+XppYfOnF4HAzLYPhr5oHiZF6/HVYHYSkPGFYWsZ
 Ug+isqWHn25265E7/V8ygs5gIY/OWNJnjeMQDSfp1Y64zCqN/V7ytvZ0tTY5
X-Google-Smtp-Source: AGHT+IGHrPhGYXumc0XuWsWauSWeRzXqvYZ8s6AB40X94oZ1/R4cLmJVnu1YQnjFzqT75Sx/uxK4OA==
X-Received: by 2002:a17:907:a02:b0:a7a:bcbc:f7e1 with SMTP id
 a640c23a62f3a-a8a885f4462mr142029466b.15.1725608397811; 
 Fri, 06 Sep 2024 00:39:57 -0700 (PDT)
Received: from top.fritz.box (p4fdf9401.dip0.t-ipconnect.de. [79.223.148.1])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8aeacb588bsm19904466b.78.2024.09.06.00.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:39:57 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v4 1/1] linux-user: add openat2 support in linux-user
Date: Fri,  6 Sep 2024 09:39:14 +0200
Message-ID: <50c1b34064efe7e2901802e260f629ccdde7524b.1725607795.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1725607795.git.mvogt@redhat.com>
References: <cover.1725607795.git.mvogt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=michael.vogt@gmail.com; helo=mail-ej1-x631.google.com
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
new `do_guest_openat2()`. Unfortunately we cannot just make
do_guest_openat2() a superset of do_guest_openat() because the
openat2() syscall is stricter with the argument checking and
will return an error for invalid flags or mode combinations (which
open()/openat() will ignore).

The implementation is similar to SYSCALL_DEFINE(openat2), i.e.
a new `copy_struct_from_user()` is used that works the same
as the kernels version to support backwards-compatibility
for struct syscall argument.

Instead of including openat2.h we create a copy of `open_how`
as `open_how_ver0` to ensure that if the structure grows we
can log a LOG_UNIMP warning.

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
 linux-user/syscall.c      | 116 ++++++++++++++++++++++++++++++++++++--
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 119 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d5415674d..83c944508b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -602,6 +602,34 @@ static int check_zeroed_user(abi_long addr, size_t ksize, size_t usize)
     return 1;
 }
 
+/*
+ * Copies a target struct to a host struct, in a way that guarantees
+ * backwards-compatibility for struct syscall arguments.
+ *
+ * Similar to kernels uaccess.h:copy_struct_from_user()
+ */
+static int
+copy_struct_from_user(void *dst, size_t ksize, abi_ptr src, size_t usize)
+{
+    size_t size = MIN(ksize, usize);
+    size_t rest = MAX(ksize, usize) - size;
+
+    /* Deal with trailing bytes. */
+    if (usize < ksize) {
+        memset(dst + size, 0, rest);
+    } else if (usize > ksize) {
+        int ret = check_zeroed_user(src, ksize, usize);
+        if (ret <= 0) {
+            return ret ?: -TARGET_E2BIG;
+        }
+    }
+    /* Copy the interoperable parts of the struct. */
+    if (copy_from_user(dst, src, size)) {
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
 #define safe_syscall0(type, name) \
 static type safe_##name(void) \
 { \
@@ -653,6 +681,15 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, size_t, count)
 safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, count)
 safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
               int, flags, mode_t, mode)
+
+struct open_how_ver0 {
+    __u64 flags;
+    __u64 mode;
+    __u64 resolve;
+};
+safe_syscall4(int, openat2, int, dirfd, const char *, pathname, \
+              const struct open_how_ver0 *, how, size_t, size)
+
 #if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
 safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
               struct rusage *, rusage)
@@ -8334,8 +8371,9 @@ static int open_net_route(CPUArchState *cpu_env, int fd)
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
@@ -8362,6 +8400,7 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
 #endif
         { NULL, NULL, NULL }
     };
+    *use_returned_fd = true;
 
     /* if this is a file from /proc/ filesystem, expand full name */
     proc_name = realpath(fname, NULL);
@@ -8418,13 +8457,77 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
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
+    if (use_returned_fd) {
+        return fd;
+    }
+
     if (safe) {
-        return safe_openat(dirfd, path(pathname), flags, mode);
+        return safe_openat(dirfd, path(fname), flags, mode);
     } else {
-        return openat(dirfd, path(pathname), flags, mode);
+        return openat(dirfd, path(fname), flags, mode);
     }
 }
 
+
+static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
+                      abi_ptr guest_pathname, abi_ptr guest_open_how,
+                      abi_long guest_size)
+{
+    struct open_how_ver0 how = {0};
+    int ret;
+
+    if (guest_size < sizeof(struct target_open_how_ver0)) {
+        return -TARGET_EINVAL;
+    }
+    ret = copy_struct_from_user(&how, sizeof(how), guest_open_how, guest_size);
+    if (ret) {
+        if (ret == -TARGET_E2BIG) {
+            qemu_log_mask(LOG_UNIMP,
+                          "Unimplemented openat2 open_how size: %lu\n",
+                          guest_size);
+        }
+        return ret;
+    }
+    char *pathname = lock_user_string(guest_pathname);
+    if (!pathname) {
+        return -TARGET_EFAULT;
+    }
+
+    how.flags = target_to_host_bitmask(how.flags, fcntl_flags_tbl);
+    how.mode = tswap64(how.mode);
+    how.resolve = tswap64(how.resolve);
+
+    /*
+     * Ideally we would pass "how->resolve" flags into this helper too but
+     * the lookup for files that need faking is based on "realpath()" so
+     * neither a dirfd for "proc" nor restrictions via "resolve" flags can
+     * be honored right now.
+     */
+    bool use_returned_fd;
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
+                                true, &use_returned_fd);
+    if (use_returned_fd) {
+        return fd;
+    } else {
+        ret = get_errno(safe_openat2(dirfd, pathname, &how,
+                                     sizeof(struct open_how_ver0)));
+    }
+
+    fd_trans_unregister(ret);
+    unlock_user(pathname, guest_pathname, 0);
+    return ret;
+}
+
 ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
 {
     ssize_t ret;
@@ -9197,6 +9300,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         unlock_user(p, arg2, 0);
         return ret;
+#if defined(TARGET_NR_openat2)
+    case TARGET_NR_openat2:
+        ret = do_openat2(cpu_env, arg1, arg2, arg3, arg4);
+        return ret;
+#endif
 #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HANDLE)
     case TARGET_NR_name_to_handle_at:
         ret = do_name_to_handle_at(arg1, arg2, arg3, arg4, arg5);
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a00b617cae..74abcb4613 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2754,4 +2754,11 @@ struct target_sched_param {
     abi_int sched_priority;
 };
 
+/* from kernel's include/uapi/linux/openat2.h */
+struct target_open_how_ver0 {
+    abi_ullong flags;
+    abi_ullong mode;
+    abi_ullong resolve;
+};
+
 #endif
-- 
2.45.2


