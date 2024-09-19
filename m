Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3D0CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 19:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srN9f-0004z7-He; Thu, 19 Sep 2024 15:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1srN9d-0004mX-FR
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:49:29 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1srN9b-00079s-CF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 15:49:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3787f30d892so802503f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 12:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726775366; x=1727380166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGzM9Uy7iaRLCBPq5Vhv0gDTAQa7ZQ0BP0cTFfMIfnc=;
 b=SCYJoeZMV5Z4wspd+lFoQMOwWxpAptTOcxX4u3cOalIn4GRg6FBnOpDlmmYeu7wSzl
 lpXi22qrPsmMxDpGZNFpWv29X50+ueOpCYpxD2Dndt11q+vguF7yAhkmuG+s9COZSi8T
 q0QHkFpnkMmjd4z1Kuigbfp+bMeT5Dr/e6lOzrgHcKxyL5dVwzc2QyYXg1rGqmo9dtrY
 p44W5YzowHR0g0SrA7bwg3qFPHcEWUvtaz4pjz81nLgKsWjOJYBXKYwMKPPKURr2lOLu
 nz0V1F5CMxcRAlDdHx9OvQztT3cP2GQx/SVq4c2YoiCSt5cVEEtjgcO+lqVnuot62Sc+
 Tzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726775366; x=1727380166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xGzM9Uy7iaRLCBPq5Vhv0gDTAQa7ZQ0BP0cTFfMIfnc=;
 b=jl24ODPaiuIb4oMxH9H7L7lPZZyEUETa7BoFuXE6ecVHqb0+W2+OfqfZ7IZVBDfCBM
 x+36GDHPGz+iY7L0k2ggrj0sbVch3eVM0DqjKUajoAm9jTZb2JP2HxLJh/30F4UnnKfp
 6ssJmRYr6GITvw03XsjO0elHtLct2apcVvI3osU2SJBv+UYQbOL7dYECKOyyWzVKuEpW
 UzSMhAYHTLm28Ao0taQUaS7dvnorqDhSgWAG+5Aofk0dJy5f/OLH3fSNDeJYRw8SJuak
 Lv11ed4OpL6mXTIA4lzNdLYa+C+rUMxn4A0L4c07KX5U+m05YwhiiFwDNkc5HAmInseg
 +AhQ==
X-Gm-Message-State: AOJu0YyD03NWNGcbqFEPt/AC9ScQttL/K2YPFewwhPrK69EGUs8YXjKH
 gKzQwBDmU8k7DJX1o3SqGHdSd302uRIKNWVPo83yuqRDEKws5471kf5l8PNY
X-Google-Smtp-Source: AGHT+IEhs1gugpAb1t88b3CV3+h0LyakyvbFW1MVzAh53hhKnqp3q1M+d2Soc4+sAQdQfEiRrrKosA==
X-Received: by 2002:adf:f04d:0:b0:374:b9d7:5120 with SMTP id
 ffacd0b85a97d-37a42278321mr300645f8f.23.1726775365357; 
 Thu, 19 Sep 2024 12:49:25 -0700 (PDT)
Received: from top.fritz.box (p4fd6b76f.dip0.t-ipconnect.de. [79.214.183.111])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e7804476sm16030356f8f.90.2024.09.19.12.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 12:49:24 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
X-Google-Original-From: Michael Vogt <mvogt@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Michael Vogt <mvogt@redhat.com>
Subject: [PATCH v5 1/1] linux-user: add openat2 support in linux-user
Date: Thu, 19 Sep 2024 21:46:46 +0200
Message-ID: <22d50b05f3387e23094eaf1f42ef4d435dd555b8.1726774919.git.mvogt@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726774919.git.mvogt@redhat.com>
References: <cover.1726774919.git.mvogt@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=michael.vogt@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 linux-user/syscall.c      | 107 +++++++++++++++++++++++++++++++++++++-
 linux-user/syscall_defs.h |   7 +++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b693aeff5b..99f3afece7 100644
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
+                              bool safe)
 {
     g_autofree char *proc_name = NULL;
     const char *pathname;
@@ -8418,6 +8456,17 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
         return fd;
     }
 
+    return -2;
+}
+
+int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *pathname,
+                    int flags, mode_t mode, bool safe)
+{
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, flags, mode, safe);
+    if (fd > -2) {
+        return get_errno(fd);
+    }
+
     if (safe) {
         return safe_openat(dirfd, path(pathname), flags, mode);
     } else {
@@ -8425,6 +8474,55 @@ int do_guest_openat(CPUArchState *cpu_env, int dirfd, const char *fname,
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
+    int fd = maybe_do_fake_open(cpu_env, dirfd, pathname, how.flags, how.mode,
+                                true);
+    if (fd > -2) {
+        return get_errno(fd);
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
@@ -9197,6 +9295,11 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
index 8ed53904ed..b83fa34663 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2753,4 +2753,11 @@ struct target_sched_param {
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


