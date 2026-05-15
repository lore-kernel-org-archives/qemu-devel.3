Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7384FCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxS-0001oe-KR; Fri, 15 May 2026 17:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxQ-0001jx-HJ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:32 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxO-000326-Ee
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:32 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dca4debedaso351651a34.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880029; x=1779484829;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8tkVLpax9YF+0bcdoU8w4zYIme0vzuVmf3yEPa2DXjo=;
 b=K3yvrWRFQK+HdjaGPtoCzBHO+EpGEGaFUNJqZ6o0Y6UV34sxJxgh4HKQQf48Ta81/5
 pogAzmygmo2XcDjTKpKiO4poNaq1N6k7kMvYW9VqNZcxOHY5c9E6lirhe40LPJ2/BUat
 Njk+xmVz3d7lVs1GPZC8UEAhQ/bIByJ5DmEgXO30nvQ8fuopHr1FyG58FIVwsb96HbvH
 PrivZZ4eb8+olgBEoXmksDF0jiDn6XdqiCnFh71aeYzQAF3XCNp+aht7xy1fNBjWY4TJ
 IOmieuckULgj/lceEIjETLvJ0Thupr2T6jtLPdaM96RtwDRNGA7A62WuBjETuOHytDT2
 frzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880029; x=1779484829;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8tkVLpax9YF+0bcdoU8w4zYIme0vzuVmf3yEPa2DXjo=;
 b=j+Uj+fmHn0CwieZZNJtayYh1XHg1qaFHkw2+6p72t2hJ/wnFpPriR1ZwWJlfwYMnOX
 KJT4ISentZPfRGgXXDlHSotE1j8+rtVwgaejwgxvzs3ZzeaJ1A65wikXwa2DxHMn7vFx
 A+w4IOtMDF4sxvBss3pqBhop4hURi2dT2SYjbdfDgabEao+0Z9Q4u96mWd7Fl58htXtx
 AshaSCF2EzIQFlbrqT9R07REWRbb5p64sixOldEoGSbPkrXSu0LuK01d+OVY62bCBBl8
 22PW4DZGxltT+Cr8EN0RTom4v0r2p8pF9C/73xJVXHG6H9FxGhB0lPaY5USzY06JpzJB
 1kyQ==
X-Gm-Message-State: AOJu0YwvEPl5vKIP0N4zh/L0fERjQLATpxO6L34Z6SEwannv/NdSPiS7
 8DjCJvyWsn+4Uqe4KJ3QxQ62wKDIrUGLy22e+mtNwhNsCjfhPnMlkNCeD7ZWsrK9QZk=
X-Gm-Gg: Acq92OF4NFYBKuLP6O2aEKl+piG1DeiZMS/SoExEtHqDrnUJ8crqC9GfKdlfV7u74rG
 CyrTy5VLotBJvOYrqGWG4LaHcwY0Di6F/8lu6P28XHb+kEvOjziVQw7t8rrE0vQPpiwukV2Oui3
 8nXNSMVqJa+77KBdNu4rLPTklFy+OspYdeUnO0lhD6o9O2+EzqxSm4p0Qts9s46KT4V3+9UwW6I
 YVC3hKIKfi5tWG1S1UUdLuvlH62eb4iIzbdGoZFPSI1SZstEy5Nf/IpDPGgrWUzWIaSUG7X7thM
 tueU84+I173biJZ5ys2ybpgyblkOMArj9FgGNJvC25CyV2fpy7NpsO0zaSt2p50UCHKACteONku
 rY/owRSWm6i5Wb+Gq/j+dMOac6dxA4svatMirYxj3fCeQGWFpN29LMUhekwuH6KiWCF9lR+Ydqe
 hQk+WsD154z2fYxcKw+RsP
X-Received: by 2002:a05:6830:91a:b0:7e4:411:7ad with SMTP id
 46e09a7af769-7e4fa0afc39mr4230017a34.24.1778880028893; 
 Fri, 15 May 2026 14:20:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:25 -0600
Subject: [PATCH 26/66] bsd-user: Add os-thread.h with thr and context functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-26-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Michal Meloun <mmel@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8569; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=+uAoW3bPRS/NVFT+C5oQicSpiAo2hsPqpobk13lE4rI=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43k68MOpm/xwwkv/VxBqif4nv8lJF5PciuDi
 xKz0CcPwISJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 AKLMD/9ROAm0FbshCK/r5pgrOfeztUvtfluv/+8UtjZ56DmPVlIz8kCBIwIA15Hj4Efh8JkBps7
 EaDqDTR5h/6Y3YSyBjWBHKKuWuLBnOKJ/KueK37tzXCzTuWRFeLkA5XcRhdAVrUFI1VsvlJHFd3
 5HyuK9097PciHt+stad7tZPNjYUHIMh07P7A6oZ5LvXuji8WM1dbOE46gSesWR9hAqSFqotwM29
 e25TyVm9h9wpNiY2Nrb+Ik0ltxE6Md2NHlMb49yTe73XY1wx9tT6yC2yseY0EPZ/DaCUJp12FRj
 16Rd1fbWBTwFg5N2K1ucuCdCIFqTtYljh2lTc9EftuT+D8yZD/jhaE1e3FYc9UJlplzHnRggvkg
 6MxjlDMbzEfiRSLNVX6WoJrGgtVCTgpVZ/qM98jPij3xFS/RAOOf/vcI69YZvl/aTUM30QtUe5y
 9nHUlAMdr7fxw/SvBUv5+taZaGpfwesOeuTWE7X/Ke8QLsTAVv1/NiwVvfsrEYwYVSz6n2YeR49
 h/4wLBWGJjrnkbEE2J3NVUnoDW3DgtFuJQ3QNRVheZpbMsbshuaUTojtUJSB4NLxJPE5nZuvcVv
 OAuCgpVUbaXMp7gnGZIzqjO2fdzbI8QB1YnJxuyd/KkA9CfeJgsmcgAB91fMxvoGRLL8g1wnPTN
 PDDcLTh1UQ/N+tQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32f.google.com
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

Add thread management system call shims: thr_self, thr_exit, thr_kill,
thr_kill2, thr_suspend, thr_wake, thr_set_name, rtprio_thread,
getcontext, setcontext, and swapcontext.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c |   6 ++
 bsd-user/freebsd/os-thread.h  | 244 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 250 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index cc66be3b7c..f2c3ff25e8 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -49,6 +49,7 @@
 #include "os-file.h"
 #include "os-socket.h"
 #include "os-time.h"
+#include "os-thread.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -90,6 +91,11 @@ safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
 safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
 safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 
+/* used in os-thread */
+safe_syscall1(int, thr_suspend, struct timespec *, timeout);
+safe_syscall5(int, _umtx_op, void *, obj, int, op, unsigned long, val, void *,
+    uaddr, void *, uaddr2);
+
 /* used in os-time */
 safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
     rmtp);
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
new file mode 100644
index 0000000000..d063ea1b05
--- /dev/null
+++ b/bsd-user/freebsd/os-thread.h
@@ -0,0 +1,244 @@
+/*
+ * FreeBSD thread and user mutex related system call shims
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_THREAD_H
+#define FREEBSD_OS_THREAD_H
+
+#include <sys/thr.h>
+#include <sys/rtprio.h>
+#include <sys/umtx.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+int safe_thr_suspend(struct timespec *timeout);
+int safe__umtx_op(void *, int, unsigned long, void *, void *);
+
+#if defined(HOST_BIG_ENDIAN) == defined(TARGET_BIG_ENDIAN) && \
+    (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
+#define _UMTX_OPTIMIZED
+#if defined(TARGET_ABI32)
+#define QEMU_UMTX_OP(n) (UMTX_OP__32BIT | (n))
+#else
+#define QEMU_UMTX_OP(n) (n)
+#endif /* TARGET_ABI32 */
+#else
+#define QEMU_UMTX_OP(n) (n)
+#endif
+
+static inline abi_long do_freebsd_thr_self(abi_ulong target_id)
+{
+    abi_long ret;
+    long tid;
+
+    ret = get_errno(thr_self(&tid));
+    if (!is_error(ret)) {
+        if (put_user_sal(tid, target_id)) {
+            return -TARGET_EFAULT;
+        }
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_thr_exit(CPUArchState *env,
+        abi_ulong tid_addr)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *ts;
+
+    if (block_signals()) {
+        return -TARGET_ERESTART;
+    }
+
+    pthread_mutex_lock(new_freebsd_thread_lock_ptr);
+
+    ts = cpu->opaque;
+
+    if (tid_addr) {
+        /* Signal target userland that it can free the stack. */
+        if (!put_user_sal(1, tid_addr)) {
+            freebsd_umtx_wake_unsafe(tid_addr, INT_MAX);
+        }
+    }
+
+    object_unparent(OBJECT(env_cpu(env)));
+    object_unref(OBJECT(env_cpu(env)));
+    /*
+     * At this point the CPU should be unrealized and removed
+     * from cpu lists. We can clean-up the rest of the thread
+     * data without the lock held.
+     */
+
+    pthread_mutex_unlock(new_freebsd_thread_lock_ptr);
+
+    thread_cpu = NULL;
+    g_free(ts);
+    rcu_unregister_thread();
+    pthread_exit(NULL);
+    /* Doesn't return */
+    return 0;
+}
+
+static inline abi_long do_freebsd_thr_kill(long id, int sig)
+{
+
+    return get_errno(thr_kill(id, target_to_host_signal(sig)));
+}
+
+static inline abi_long do_freebsd_thr_kill2(pid_t pid, long id, int sig)
+{
+
+    return get_errno(thr_kill2(pid, id, target_to_host_signal(sig)));
+}
+
+static inline abi_long do_freebsd_thr_suspend(abi_ulong target_ts)
+{
+    abi_long ret;
+    struct timespec ts;
+
+    if (target_ts != 0) {
+        if (t2h_freebsd_timespec(&ts, target_ts)) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(safe_thr_suspend(&ts));
+    } else {
+        ret = get_errno(safe_thr_suspend(NULL));
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_thr_wake(long tid)
+{
+
+    return get_errno(thr_wake(tid));
+}
+
+static inline abi_long do_freebsd_thr_set_name(long tid, abi_ulong target_name)
+{
+    abi_long ret;
+    void *p;
+
+    p = lock_user_string(target_name);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = thr_set_name(tid, p);
+    unlock_user(p, target_name, 0);
+
+    return ret;
+}
+
+static inline abi_long do_freebsd_rtprio_thread(int function, lwpid_t lwpid,
+        abi_ulong target_addr)
+{
+    int ret;
+    struct rtprio rtp;
+
+    ret = t2h_freebsd_rtprio(&rtp, target_addr);
+    if (!is_error(ret)) {
+        ret = get_errno(rtprio_thread(function, lwpid, &rtp));
+    }
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_rtprio(target_addr, &rtp);
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_getcontext(CPUArchState *env, abi_ulong arg1)
+{
+    abi_long ret;
+    target_ucontext_t *ucp;
+    sigset_t sigmask;
+
+    if (arg1 == 0) {
+        return -TARGET_EINVAL;
+    }
+    ret = do_sigprocmask(0, NULL, &sigmask);
+    if (!is_error(ret)) {
+        ucp = lock_user(VERIFY_WRITE, arg1, sizeof(target_ucontext_t), 0);
+        if (ucp == 0) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_mcontext(env, &ucp->uc_mcontext, TARGET_MC_GET_CLEAR_RET);
+        host_to_target_sigset(&ucp->uc_sigmask, &sigmask);
+        memset(ucp->__spare__, 0, sizeof(ucp->__spare__));
+        unlock_user(ucp, arg1, sizeof(target_ucontext_t));
+    }
+    return ret;
+}
+
+static inline abi_long do_freebsd_setcontext(CPUArchState *env, abi_ulong arg1)
+{
+    abi_long ret;
+    target_ucontext_t *ucp;
+    sigset_t sigmask;
+    if (arg1 == 0) {
+        return -TARGET_EINVAL;
+    }
+    ucp = lock_user(VERIFY_READ, arg1, sizeof(target_ucontext_t), 1);
+    if (ucp == 0) {
+        return -TARGET_EFAULT;
+    }
+    ret = set_mcontext(env, &ucp->uc_mcontext, 0);
+    target_to_host_sigset(&sigmask, &ucp->uc_sigmask);
+    unlock_user(ucp, arg1, sizeof(target_ucontext_t));
+    if (!is_error(ret)) {
+        (void)do_sigprocmask(SIG_SETMASK, &sigmask, NULL);
+    }
+    return ret == 0 ? -TARGET_EJUSTRETURN : ret;
+}
+
+/* swapcontext(2) */
+static inline abi_long do_freebsd_swapcontext(CPUArchState *env, abi_ulong arg1,
+        abi_ulong arg2)
+{
+    abi_long ret;
+    target_ucontext_t *ucp;
+    sigset_t sigmask;
+
+    if (arg1 == 0 || arg2 == 0) {
+        return -TARGET_EINVAL;
+    }
+    /* Save current context in arg1. */
+    ret = do_sigprocmask(0, NULL, &sigmask);
+    if (!is_error(ret)) {
+        ucp = lock_user(VERIFY_WRITE, arg1, sizeof(target_ucontext_t), 0);
+        if (ucp == 0) {
+            return -TARGET_EFAULT;
+        }
+        ret = get_mcontext(env, &ucp->uc_mcontext, TARGET_MC_GET_CLEAR_RET);
+        host_to_target_sigset(&ucp->uc_sigmask, &sigmask);
+        memset(ucp->__spare__, 0, sizeof(ucp->__spare__));
+        unlock_user(ucp, arg1, sizeof(target_ucontext_t));
+    }
+    if (is_error(ret)) {
+            return ret;
+    }
+
+    /* Restore the context in arg2 to the current context. */
+    ucp = lock_user(VERIFY_READ, arg2, sizeof(target_ucontext_t), 1);
+    if (ucp == 0) {
+        return -TARGET_EFAULT;
+    }
+    ret = set_mcontext(env, &ucp->uc_mcontext, 0);
+    target_to_host_sigset(&sigmask, &ucp->uc_sigmask);
+    unlock_user(ucp, arg2, sizeof(target_ucontext_t));
+    if (!is_error(ret)) {
+        (void)do_sigprocmask(SIG_SETMASK, &sigmask, NULL);
+    }
+    return ret == 0 ? -TARGET_EJUSTRETURN : ret;
+}
+
+
+#define safe_g2h_untagged(x) ((x) != 0 ? g2h_untagged(x) : NULL)
+
+/*
+ * undocumented _umtx_op(void *obj, int op, u_long val, void *uaddr,
+ *                           void *target_time);
+ */
+
+#endif /* FREEBSD_OS_THREAD_H */

-- 
2.52.0


