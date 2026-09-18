Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EAAC982D9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAD-0005SU-6o; Fri, 18 Sep 2026 00:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA9-0005NT-GJ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:25 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA7-0004B5-Ic
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:25 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-80a6fbf797dso67333a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705522; x=1790310322;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yauLkwe0Wh6vvIGKrOK0Q6uatxr0RlPtom0vJwzNFiw=;
 b=Thgs74Lz3cFVziknHdajb3zDxbcbnBZjiKwftI037pkf9wKLZ1nMx7WIP0rsBRuWIS
 LO9Uc0jrbWd82yQ8AbWYThDqKlusyXKckEWLy45HOiNckIxHNnwtcMdiP1ndzAzvnjE7
 3hx9OpjSts8m3Z3ABeECkU2C1354IAeyO7OocAiQtoSU0IKzzYfQJX0VU1Dh9Ghozk1F
 yc5OeYmvhXx7+iEIy0gbPj0EuQKXDOo9SdpMgOPmwy3tQxbN6A0Ws6cOS72FOmX1aJJK
 pJrvodTeHkAxflfLumAr3QpFh2Uc88x9D1glruvLyzVBrr6e2xK/bVCqB+5VYKvyEB+o
 3qAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705522; x=1790310322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yauLkwe0Wh6vvIGKrOK0Q6uatxr0RlPtom0vJwzNFiw=;
 b=JWCkKQLreytB04zpEgLG+pIfiyPZk5lB0RS+ruhNPoufCmOBb3EeIlDnmHGFQ3w19a
 6oe+GmHzpDJzHROk+KLP75LYCSg2VkDf0NPqxytNWoW8rb/0b5Zvn4PmWkwWrqM3DcVV
 U4uTytrztbvqEzovik/SBvG67wkhK0PXwKeo1KUGRrWkjJ3fbPEFWbe5e9vfQNZE15Vb
 eoHwjYqTVOFnOfmRYm9itJTATxoNFqBP/34S2SA99X5PJwDzfvpVPQvt3eCr60cNRSjO
 dHckHZTiNuqoW7eZhlfGfpmsTqXeqK0QMMZzBSRm+OfrHpZufo2aA5+OvZ0r6QHzODl2
 1EnA==
X-Gm-Message-State: AFuF++lL/ZPxqvon+GLmqS7CtKlRjXSqm+jOoi+eurjCIkbl0w6b3w+H
 /9JkeSC1ASsB3UR91vS9PejQo8dnz22qupuyY2iM0C9TaPk5PjVSz9Ks4lCXtIQWszrEEdLPZnA
 i2xxFH5g=
X-Gm-Gg: AYBFou2GaIt/Q2oOi0sSJ1RE2i8VFX72IGKXd3jMZ1lDGzD82qOx3XKuV/64i18cu7z
 7+BuyXWHhXvj7HQ+eQjSFZHV9jgqGW7FDm8Yad0LOdUKS20ZbrQcU0xhvKHHwiu0yRg2Dns3k0J
 b05kd3ZR77oIHxcPLk7h9SR1/w2yCA637ptYFS18HY/5bqmyz2LVX6Y5ZjB5RrcTaGKcvHuOL0J
 euR6fzymt834ggfYzWDvgG6om7V5bBtSnNPWfWrxJVIot+aUVqI5plpZEubTa9zyl9SSxy5jthT
 Z9qRjX0DumodcaQwLPozh8juw2bIE4tTyNh0fo/G735HlS9UhQS89itEGnEacLlZoq9XoqNYSkK
 pi+K9vNbJ3FFg1XUeIVavT6i1Fj1Ig3Mb6m+QSzl0jJHuKFQMaVZSQtZm6A7XJgIuHulkcKfb8p
 k4M3+FAL1/rGyk0X67LMKsnTGMZTKrVv2lChq5ChYSLVuslEpRb9vB33OiIXxu5W+ZIOPr
X-Received: by 2002:a05:6830:63cc:b0:806:24fd:7c10 with SMTP id
 46e09a7af769-80ddf374602mr1330987a34.7.1789705522548; 
 Thu, 17 Sep 2026 21:25:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/41] bsd-user: Add poll, poll2, lseek, pipe,
 and swap system call shims
Date: Thu, 17 Sep 2026 22:23:54 -0600
Message-ID: <20260918042422.38713-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add do_bsd_poll, do_bsd_lseek, do_bsd_pipe, do_bsd_swapon,
do_freebsd13_swapoff, and do_bsd_swapoff to bsd-file.h. Also add
target_pollfd structure to syscall_defs.h and include poll.h in
os-syscall.c.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-file.h           | 136 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-file.h    |  26 +++++++
 bsd-user/freebsd/os-syscall.c |  34 +++++++++
 bsd-user/syscall_defs.h       |   6 ++
 4 files changed, 202 insertions(+)

diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 7ef9470c4e..0fefc07232 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -55,6 +55,10 @@ ssize_t safe_pwrite(int fd, void *buf, size_t nbytes, off_t offset);
 ssize_t safe_writev(int fd, const struct iovec *iov, int iovcnt);
 ssize_t safe_pwritev(int fd, const struct iovec *iov, int iovcnt, off_t offset);
 
+int safe_ppoll(struct pollfd *fds, nfds_t nfds,
+               const struct timespec *restrict timeout,
+               const sigset_t *restrict newsigmask);
+
 /* read(2) */
 static abi_long do_bsd_read(abi_long arg1, abi_long arg2, abi_long arg3)
 {
@@ -925,4 +929,136 @@ static abi_long do_bsd_undelete(abi_long arg1)
     return ret;
 }
 
+/* poll(2) */
+static abi_long do_bsd_poll(abi_long arg1, abi_long arg2, abi_long arg3)
+{
+    abi_long ret;
+    nfds_t i, nfds = arg2;
+    int timeout = arg3;
+    struct pollfd *pfd;
+    struct target_pollfd *target_pfd;
+    struct timespec ts, *pts = NULL;
+
+    target_pfd = lock_user(VERIFY_WRITE, arg1,
+            sizeof(struct target_pollfd) * nfds, 1);
+    if (!target_pfd) {
+        return -TARGET_EFAULT;
+    }
+    pfd = alloca(sizeof(struct pollfd) * nfds);
+    for (i = 0; i < nfds; i++) {
+        pfd[i].fd = tswap32(target_pfd[i].fd);
+        pfd[i].events = tswap16(target_pfd[i].events);
+    }
+
+    if (timeout != INFTIM) {
+        ts.tv_sec = timeout / 1000;
+        ts.tv_nsec = (timeout % 1000) * 1000000;
+        pts = &ts;
+    }
+
+    ret = get_errno(safe_ppoll(pfd, nfds, pts, NULL));
+
+    if (!is_error(ret)) {
+        for (i = 0; i < nfds; i++) {
+            target_pfd[i].revents = tswap16(pfd[i].revents);
+        }
+    }
+    unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
+
+    return ret;
+}
+
+/* lseek(2) */
+static abi_long do_bsd_lseek(CPUArchState *env, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    abi_long ret;
+#if TARGET_ABI_BITS == 32
+    int64_t res;
+
+    /* 32-bit arch's use two 32 registers for 64 bit return value */
+    if (regpairs_aligned(env) != 0) {
+        res = lseek(arg1, target_arg64(arg3, arg4), arg5);
+    } else {
+        res = lseek(arg1, target_arg64(arg2, arg3), arg4);
+    }
+    if (res == -1) {
+        ret = get_errno(res);
+        set_second_rval(env, 0xFFFFFFFF);
+    } else {
+#ifdef TARGET_BIG_ENDIAN
+        ret = ((res >> 32) & 0xFFFFFFFF);
+        set_second_rval(env, res & 0xFFFFFFFF);
+#else
+        ret = res & 0xFFFFFFFF;
+        set_second_rval(env, (res >> 32) & 0xFFFFFFFF);
+#endif
+    }
+#else
+    ret = get_errno(lseek(arg1, arg2, arg3));
+#endif
+    return ret;
+}
+
+/* pipe(2) */
+static abi_long do_bsd_pipe(CPUArchState *env, abi_ulong pipedes)
+{
+    abi_long ret;
+    int host_pipe[2];
+    int host_ret = pipe(host_pipe);
+
+    if (host_ret != -1) {
+        set_second_rval(env, host_pipe[1]);
+        ret = host_pipe[0];
+    } else {
+        ret = get_errno(host_ret);
+    }
+    return ret;
+}
+
+/* swapon(2) */
+static abi_long do_bsd_swapon(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(swapon(path(p)));
+    UNLOCK_PATH(p, arg1);
+
+    return ret;
+}
+
+#ifdef TARGET_FREEBSD_NR_freebsd13_swapoff
+/* swapoff(2) */
+static abi_long do_freebsd13_swapoff(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, arg1);
+    ret = get_errno(swapoff(path(p), 0));
+    UNLOCK_PATH(p, arg1);
+
+    return ret;
+}
+#endif
+
+/* swapoff(2) */
+static abi_long do_bsd_swapoff(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+
+    LOCK_PATH(p, arg1);
+#ifdef TARGET_FREEBSD_NR_freebsd13_swapoff
+    ret = get_errno(swapoff(path(p), arg2));
+#else
+    ret = get_errno(swapoff(path(p)));
+#endif
+    UNLOCK_PATH(p, arg1);
+
+    return ret;
+}
+
 #endif /* BSD_FILE_H */
diff --git a/bsd-user/freebsd/os-file.h b/bsd-user/freebsd/os-file.h
index d5d91336ea..c1da52789a 100644
--- a/bsd-user/freebsd/os-file.h
+++ b/bsd-user/freebsd/os-file.h
@@ -14,6 +14,32 @@
  * Asynchronous I/O.
  */
 
+/* pipe2(2) */
+static abi_long do_bsd_pipe2(CPUArchState *env, abi_ulong pipedes, int flags)
+{
+    int host_pipe[2];
+    int host_ret = pipe2(host_pipe, flags);
+    /* XXXss - flags should be translated from target to host. */
+
+    if (host_ret == -1) {
+        return get_errno(host_ret);
+    }
+
+    /*
+     * pipe2() returns it's second FD by copying it back to userspace and not in
+     * a second register like pipe(2): set_second_rval(env, host_pipe[1]);
+     *
+     * Copy the FD's back to userspace:
+     */
+    if (put_user_s32(host_pipe[0], pipedes) ||
+        put_user_s32(host_pipe[1], pipedes + sizeof(host_pipe[0]))) {
+        close(host_pipe[0]);
+        close(host_pipe[1]);
+        return -TARGET_EFAULT;
+    }
+    return 0;
+}
+
 /* chflagsat(2) */
 static inline abi_long do_bsd_chflagsat(int fd, abi_ulong path,
         abi_ulong flags, int atflags)
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 4fc230e8e5..228daed4c4 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -26,6 +26,7 @@
 #include <sys/mount.h>
 #include <sys/sysctl.h>
 #include <utime.h>
+#include <poll.h>
 
 #include "include/gdbstub/syscalls.h"
 
@@ -66,6 +67,9 @@ safe_syscall3(ssize_t, writev, int, fd, const struct iovec *, iov, int, iovcnt);
 safe_syscall4(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
     off_t, offset);
 
+safe_syscall4(int, ppoll, struct pollfd *, fds, nfds_t, nfds,
+    const struct timespec *, restrict_timeout, const sigset_t *,
+    restrict_newsigmask);
 safe_syscall6(ssize_t, copy_file_range, int, infd, off_t *, inoffp, int, outfd,
     off_t *, outoffp, size_t, len, unsigned int, flags);
 
@@ -696,6 +700,36 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_undelete(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_poll: /* poll(2) */
+        ret = do_bsd_poll(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_lseek: /* lseek(2) */
+        ret = do_bsd_lseek(env, arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd10_pipe: /* pipe(2) */
+        ret = do_bsd_pipe(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_pipe2: /* pipe2(2) */
+        ret = do_bsd_pipe2(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_swapon: /* swapon(2) */
+        ret = do_bsd_swapon(arg1);
+        break;
+
+#if TARGET_FREEBSD_NR_freebsd13_swapoff
+    case TARGET_FREEBSD_NR_freebsd13_swapoff: /* freebsd13_swapoff(2) */
+        ret = do_freebsd13_swapoff(arg1);
+        break;
+#endif
+
+    case TARGET_FREEBSD_NR_swapoff: /* swapoff(2) */
+        ret = do_bsd_swapoff(arg1, arg2);
+        break;
+
     case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
         ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
         break;
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 88dd7a763a..75122ad521 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -547,6 +547,12 @@ struct target_in_addr {
 #define safe_ioctl(...) safe_syscall(SYS_ioctl, __VA_ARGS__)
 #define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
 
+struct target_pollfd {
+    int32_t fd;         /* file descriptor */
+    int16_t events;     /* requested events */
+    int16_t revents;    /* returned events */
+};
+
 /* So far all target and host bitmasks are the same */
 #undef  target_to_host_bitmask
 #define target_to_host_bitmask(x, tbl) (x)
-- 
2.55.0


