Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFC9C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgp-00027X-Hd; Tue, 18 Aug 2026 19:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgo-00026S-6F
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:54 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgm-0005Em-1K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:53 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a40bcc8d69so362249b6e.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097471; x=1787702271;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kHhsfnAsmurtQcuXQ4RBX7OuSGOb2edhhIFQh+yntY0=;
 b=FdbFRGqGvJB0oOVlNImcRnVDlXILG5UjbRQVW6GK1VsFnRT/uKjRzLceMFB8nLeRt0
 EoMkHPpNhd31TfpdoEvs/Oe6Kmltd3+HsUMux7TK7jOwZ/jJ+FWrti5i10CwnytIgTvA
 NmzDXgfJkuMDHAZRFS3ZoBcU7mBhGH2ty62D4TSCQKKKx3rcOPeyM6o6hGzlRkL5RG48
 L+cBQ+v7IJAC6WEf4xRv1ZPoQWYZ08qCLrpbv1rfMq9vkoNubTxC9qihyom7hOuBwQBo
 Zls7o5RB05IugZn0MWS6Fv7oisBE3YPjsOkp5CKGrXOGm0r1jNIkRTz3+a12W+/7XFUV
 TVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097471; x=1787702271;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kHhsfnAsmurtQcuXQ4RBX7OuSGOb2edhhIFQh+yntY0=;
 b=erjVJRXwpeX1v1idBWjQ/20CVTJsKfoNADoLpMUDTBgwLQPg0zbgCxrStkH2oHl4wz
 oHDloF+rKV/aBSWPejHsdeYZkF52Zhfd8CMug5IGOcngdUhk9WnvBuIoFqnOP692sre2
 FbU2mSzazTDf+yK8vb1uslqVkAUWjWejt9nmaHrpOKgS8Jhia5zv0ZudahHFpAt7P+VR
 ueaMIlMVUWLWO9C/kit9GOvqaBKv6wz9Q19PLQ7A/AghpDGrK58nEaJmpUKAT0j8xaWR
 nl8pFc35qqzpyZiKChx+TxmfiPFME5gNio8aQRQdTPihved0qkeB/MPqeZNJjufdDDJI
 xgEw==
X-Gm-Message-State: AOJu0YwB1ICkG/Mvg0Cl3bW5E2AnclNOAusWhKeV0sj3LCHRC6TA+Lrr
 7AVDM3LqmJA12/u1pqke93bZ5Z4x29ETPf9zuEoVTsNDKfZ9BwCLWt+tkMMAQKLI4No=
X-Gm-Gg: AR+sD10QFwCZFXrn5QLDqjKejtcEJytStF2Ovu/3Q0uT4Ui/q3xsWgIxCJOEFSLnB+8
 FwKnaGTZ/4SNsRGFPHJtIA4tcdsXH3ZXnVBUxsxeyXDgu3EeV8SbQ/OuJnm5Q7vH1AFifk39nPb
 yRyJALFIDeswPE/wu+kxV07POcdNXP1ZDVmwMY+lyA0BmXMDFbtUptxXI+MiZmfE0b/6obDd5hB
 QeAzoBMustu8grk3FegZ9UgcyWLb3JnflsDjbB2Vr5vBGefgF6XtR1gYeaV2flCeH2HA/UD8rzm
 +PmnZ8+m8ytm0TyEdCwCmwtCN+TePOSUqvhKOtT3iBfyztORxVHZdB8zER1dBfveFBcbcBJO4KV
 tRDfEe/dAsEE4meO5o6IL3Y2p5gfSPxSBz9tPK+zmzQp5DGF337UJuc4Ukw68+1pPktPdl6zbJF
 e/lyqU3Cr/FKxk2nhFzM2ANpPL81lS//bcIk3AGFL9ENtPZc8=
X-Received: by 2002:a05:6808:3305:b0:495:f74a:b572 with SMTP id
 5614622812f47-4b2bc97d844mr374240b6e.5.1787097470845; 
 Tue, 18 Aug 2026 16:57:50 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:05 -0600
Subject: [PATCH v4 12/40] bsd-user: Add poll, poll2, lseek, pipe, and swap
 system call shims
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-12-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8653; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=yYNNi2kjb5//RpHVzDtDTaGab5HnAtRMdCAJ5uxS50s=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPExg1u/UUYvj/2b0JE9EpYPKpOArY1L5LtH+
 sxT3SylKMqJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxMRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAakBAA3uLgCKNzwcuSm+BsJg2gKnO77Nw7wd+
 TKHkYs+oayUm8DtkxbuPmYa8NWx+FMxqbpkxIzTZkYmLJAo+cKcEuFWxgT2FPmCH7KRhtkYYUi1
 VVk89Q3cUirX1kZyg5JG5ArQLX9odjhYtbEswjwZsrT2dUi6BBvI/HFeUqa1AYpZ2aaLuk+Nbfj
 bcrWO1i99VCyCmRRyBeuGOdlHsYMTXsONkuK7rgkKNxWt1uBR+/Mg8vyzMoBu9c4ASDQkBQIFGO
 T80yNjP7ajKrkI6cxWjulSU77uS2fuAOp5yTfu3JzEkd+QbViL+lmNpLPnMJBfUjIXmJaLYhOXv
 7j8cf4lZP40YeBkvDLwkTUYF9k28kPDoGrAVHaReSVU0m0eEk87NOhcnRE+QhFQ+rNd0bTGij7d
 ZH72wS9UI1XueC0jnjStBALpYNMYfSaV584PAynQainl7U39rlouIR6PvG5rPeb458IqSkugdCB
 8bssQKJ7uh8gg146ruVCNzdZKEvJILqcK600b2/U/aK1ipYeOVHJ7ieyN0XPcXOrO74YgL7RufT
 9CpuABiE7ZjH7Ky+FruMwtiDUnpBWvQKBDD87niRFeIhYQq5UqDmub32mo1jpX/FRc84CC5Sb0G
 JJaXuQLB9l28ilrEvwfhWrLjVg4JtWEDt2gTEpPZbrn8UbHI4VwY=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::231;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x231.google.com
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
 bsd-user/bsd-file.h           | 136 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-file.h    |  26 ++++++++
 bsd-user/freebsd/os-syscall.c |  34 +++++++++++
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


