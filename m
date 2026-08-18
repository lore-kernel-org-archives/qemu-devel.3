Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A27C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThS-0003UY-FX; Tue, 18 Aug 2026 19:58:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThQ-0003A8-HV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:32 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThO-0005Iq-7S
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:32 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-462df62f872so612795fac.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097509; x=1787702309;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=walM9amJpXt04r73SicP+udgdtfWMlL5B9KhxqbK5fo=;
 b=k1GZRduQhGtYNcZiedNkdZC2BLFNynoSZnsmQUqjNl5xdIUY9lYnAufKbIYqefEFKs
 A3J32YMZ6ckujRg8xyKRLW2v7BXm53FPuuTHWBbUNWTqd0l6YX+5o7i0httG0ieWxEvI
 jKg5K+mrnsEYIYEuu3Fvnpt2w6t9BfRGrbQ7/v3Qj06JMgDOOCAJWL4Bum7lRab3uYA0
 OrqiltsuzbAOLz0CuKAuTrzIirYgCAn+HZZMb4pJYuqdkS1e+aQ2ps8tuWp50xACUKOW
 NxXhbMRWOrSbCzOWzxXFLnYsKqWT8DPm8JSV0kJCGEzBfzgnMoJYwUhqTAZEUT4YfQGn
 dCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097509; x=1787702309;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=walM9amJpXt04r73SicP+udgdtfWMlL5B9KhxqbK5fo=;
 b=Wkw0apdRPkCVziCvSgaRZC1UoTNj08vb9cvNF+xCtjbmqSkiSh26dFueGh7TiCWSb7
 vixblsiSl+xTkW0Xg+IcHvjE1AELBVaJMB0kuU0Wry4cp0RewQPhLsEwxTASaqqGgiFK
 raC4kpfuv5RxXRdrbYLpiOBeJGpgFkATLjontk27/JvsZhwdb7bfguaYX29vnTw9SbFG
 eYAf0b0g8LQq+IK9Qsk0Xj8p4YTMye87MEeeyMR1U8SgEMnfr+82x+A8ePnbEmZ/j5X2
 9SMEzgfvkg3til7sEXjUXMmZnn7tpihZ6fZtbNNK9c9wkX+IIXQgXJntpXHFn3Y3lpOy
 QnUw==
X-Gm-Message-State: AOJu0YzeNEh+6XgBt/GrhbavWqdbp8+WzIHQ2il9n70OA11C7InP0MZD
 YRHmwtgmnGN800vmMPhJ6PWO+jlUzVG7xT9lnJknfYh/jbSsMBu5OfwS6db8JribGiE=
X-Gm-Gg: AR+sD10vYJ9bs8CYZLM0fKYn7Va0cEahzbZ9BkJkT5P7gdBp2B+fB/yy6vcYgTESW8z
 RioMlKF1xsZ0sd0O6fulexLm+3MvmO+M0goSY+8mSjYQ4caC38yOKCcUN6wnpWY+9txDf3MFbi3
 pR4eZ7TN9KpNAKBCG4yn/4rTNswEtF/9x4LS2xLdgNYOxPMxrrfWyOPUrGUVAn+j8JyhskNsjGl
 zfDs1VaXKNttPSz9V2AAeqO0ms/olkMqnZ/F7d85jfWF/jt5uZIjLTabhFE7SGR1ry/3V74oFLU
 rfUWGHZL+I6E4y1ANAE3j2k/1+7BRg+jXj7TiKlezFPYQLhGFulB0IGTQPe9XSYf7OioWQfaYez
 8DlZmx9+9m35JtaiSotQJ0POeaP5ZbK6RgVaETZSgdsKti8U71YFcGbkNb1fXd6ToD5c97C5REw
 QHOjf7vl6gj4tCD7VVQGqmF1Wb7mhJBBRQdgqtiFexdQoA7EU=
X-Received: by 2002:a05:6808:c2c5:b0:4b2:8d7b:41ac with SMTP id
 5614622812f47-4b2ba83cd37mr942497b6e.6.1787097508897; 
 Tue, 18 Aug 2026 16:58:28 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:27 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:22 -0600
Subject: [PATCH v4 29/40] bsd-user: Add os-thread.h with thr and context
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-29-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Michal Meloun <mmel@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8588; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=A879ZcsiYseaZwooAsMMnN7S3pUGLlKywqzWm9EbWMw=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFNaSyLIV+MoXT6F8pjicS4ODPRPftW2bRBI
 3hAT/fN5n2JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxTRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQD61g/+P4G6uThZX7ObMr2K6k+gqXsEMx9raVW
 bnc8221b71X9jc6QMYe54fqPkUOJ0tJ8+2aq/U/uPtwoocstQP88yI8cIV0dMbrU4nDDzGbVQrF
 C/doSQFDfF/PzmKh6MV+JVY7IJowewJHzph4rLrjsLuhgdauNxHpHenSrXqy2Lt1PxgIzj/5Afy
 Nu2HnggBZqgxrKgvI6OFlhgjyAu+8nuPFpB4CD+Smhpi1/kx4ht9OyJjOYewY5w3eEUYEtzIm5j
 qmPwdxG/38cHMV1+YDfeqRMVye9br9UjbqELdoTlujfkRFjmHlGoqyq0nD+WmP1H4/WV3No4Gry
 beiwt4PBVgPtJx5y3xNZFCQcz8exOWW1+fLLKZfzHJrgO20oqpP4QgVCdkh48jAP+ahzzvw8rub
 gdAPHiZ+w1WU7ChNReguFtHh58AYDya43XBj4igWGmP2utApkZcCCRSCRipPDL9LVaYibzJg0IG
 03X9LtqZhj1LPpi/Dh54BndIjWCN4+ExwRXUQOkZTR4jYNItjxuCrMz+FyixAKawSSOiZL4Oh/b
 rjDkmT5JmIN/TnN+BgiTTr0W9OYq8K955Ne5b2iLaFwPqPvartvs1aT8wHTR+e6/OcPeE1P5j1c
 rkNdEDAuvX4+VnG8GbIxxY/V7WFbxRTDM3gOFmVXZsIjqyPcu6NU=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2b.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
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
index 0000000000..d3f1f01b13
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
+    ret = get_errno(thr_set_name(tid, p));
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
+    unlock_user(ucp, arg1, 0);
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
+        return ret;
+    }
+
+    /* Restore the context in arg2 to the current context. */
+    ucp = lock_user(VERIFY_READ, arg2, sizeof(target_ucontext_t), 1);
+    if (ucp == 0) {
+        return -TARGET_EFAULT;
+    }
+    ret = set_mcontext(env, &ucp->uc_mcontext, 0);
+    target_to_host_sigset(&sigmask, &ucp->uc_sigmask);
+    unlock_user(ucp, arg2, 0);
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
2.55.0


