Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCBBCD4F56
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VI-0000MV-08; Mon, 18 May 2026 17:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VG-0000Kx-0b
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:58 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VD-0000Pu-NN
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:27:57 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dcdaf06498so1876579a34.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139674; x=1779744474;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=doZWlcvFs6yrl3gyf9KMB/0Q6Da4SHxguQNEvyrWiV0=;
 b=evPBn6aTqxRSndkHi3jNgq3lQYYroiS3Ms+yek70Xi8ifEPJjyLAghvfvurQqluv+y
 x+ryvheIFvbzOesUeONy6XHSLBFVevNc4NgCukaXKQ08eQ6QjZlNAUWVyvTSS0Soqocj
 ujZ+UPCs20/ljr/qosi0Ujb2icIRzyFTq7jhu2J2C5L9ws1pa9Ck+n6m9q3qkrYuoP2p
 phlWaeLJY9RCH/8vodHoqZAsgBYOUJC3S0MUMctl5I0l24sWabf/inAiTAhTLLbctN22
 kt+eS+5ocYtBPsRw/33XOBrt4pCtp/nWnDyC8mrvYp1YnQHTZYrHAMXoRb3t3qkcizhM
 A7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139674; x=1779744474;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=doZWlcvFs6yrl3gyf9KMB/0Q6Da4SHxguQNEvyrWiV0=;
 b=XO7Eerf7PnixSKbwkpMpZKeJzRlETzsWex2wsExDO9WtMP+hKRj2tOkGKPYQSHDo1A
 spuDwm/wtpeKAcyQjOwADL62byWLST1DKmR6S+XXD8xECgJG14408d/J0bBpf8G9dXJo
 pJwgx3qR1H8dHsnNluhttD4La2yuEaa59+MC8hHXeTHLwIvk9oUurwRy5BYUt8Y+DU+m
 XTVlkNd1U/BA4xbHOW1JarczMXZPAaOIGuoHoiwzGyJkI+is8dGpzDAa/jpbnfcWkSBy
 1eFDKhm0EEQWXLT56ahSBS7/4GWBi+zr5vkrIr4yGJPyzMQoFNMkW0n+i5qEVmaV0b/r
 MBoQ==
X-Gm-Message-State: AOJu0Ywx8OxKRJumLrHUflPYxJ/rLjv4dxdgtXgBMzH4pyC7kRIHH5/N
 ulbP8PBMcyWAVcBVECYP9MzF+NVa2WP/6vggVfNSLGhS6UJeIWI/nrXVqrbLWqksp68=
X-Gm-Gg: Acq92OE6zmJvUQS5BW/b5FGPenm/fe0AmmZZRrQGcKAW2vVzQHJUI6WPE3iUnW4hW2R
 QrbEXnPV9u3CFJ2H3ifP+qDoCdNFfz9cAe80wyjIx1KvrClMYf/6H3yxn/qVVZwSAEECcE1s8qG
 i8OqtX4eK9cFVw+4TxBFtwNu8RabWaBf2GNu48AUd60ktrXnuGT09EJBxelZJhwsopZvnZa7/qK
 IafVn7YG+s0JFntn8yx/uOY6HfV9nQkJuoVEnKwsQaoO3At7Hidn1iHq58ejzexbgdc+gYsI8Cm
 YM0HBL0WPlRIBsGE1N/qQk9K4UPovH1XNGrJ3CDgV1dzlni6QKRON6LyK2SYPoGawLzd1BIoSsY
 WdyZQ5/CBQ7U8hfhIn+5BKPWlc9MC5FSj1zjGSO6jBAMQTMZ4RKcxKL+tWZTqXSNapWiMssAGt2
 X9n4olZ7L7XA==
X-Received: by 2002:a05:6830:3c0e:b0:7dc:dd91:b5b1 with SMTP id
 46e09a7af769-7e4ea032147mr11177962a34.5.1779139674589; 
 Mon, 18 May 2026 14:27:54 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:27:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:21 -0600
Subject: [PATCH v2 03/37] bsd-user: Add bsd-signal.h with sigaction through
 sigreturn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-3-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9451; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=4+ns6JSAZOiGSFUyi3un+hWlDWcb4wxEsybCSx7hGBU=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RGagXnnjvd/GB4JEH4Z+aKe0o99SziCu4oJ
 ehujFoF7hGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERgAKCRBsHNEofbAR
 ANf/D/4rs/kHHpI2v91/FX6TQI8nZjwkIAv7KtVR4CKCrCULPy1hSM8AAOLPbd0AyscG7KUbNj+
 a7nE3QySMqLc0IEM5+WawiA1lJ+iiiFrLBhWkYAN2qBQ2FUKEQy0OHuWAQdFuOs4vcR0ESPhC4C
 /pjoJSh3A690/e8U9LnXzhcdq0KmzdxoEDKfobrc62D+wIiJc4xLxkPHgiPwe0x0WE4opA+1GGB
 +OwU7kRULmkFttjQW973o5Uk/2VK2ex2shm/pU8noD8XpnngGbbnVnZ+jrGuawpYvM57MbWZzHW
 Ay6csWvpvzgVKcHbPmWsTJvGmwHQT7hrO4aM6cz2xLpuSWUZOCx1hSrX9EfEflTKwbmR1Vn3FwX
 /miCCt2XnBzEKl11HiP5MrPIQvFV+C/Refs5j64Nf5NlgYEZFB65juFHffdEqvNhhd6aCZscjED
 PVk1JWWW7/f8dl2tsCzEzegRdoGkDPBBWK6jR46H0obmmCetOBCz+vKY6azlZtCyLHxi9TAJSO1
 /C6+6ujUqfXW0SGnIKOT1/gaMOELSg2LIdeMqXZPlSWY0kBYejoUhrEHM8gvsu0gA0aHdRqmv5+
 QwrGUxYuVxMwE0yXEbY0JNoxrlJdYyrSUh2pdySG/y34hvyxEhs3b/jKgVvUlAYqieGgkQ7j4FA
 082L4WzsRtaj0Rg==
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

Add the first set of signal-related system call shims: sigaction,
sigprocmask, sigpending, sigsuspend, and sigreturn. Also add the
do_sigprocmask and target_to_host_sigevent helper functions to signal.c
and their declarations to signal-common.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/bsd-signal.h         | 151 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   1 +
 bsd-user/signal-common.h      |   4 ++
 bsd-user/signal.c             |  67 +++++++++++++++++++
 4 files changed, 223 insertions(+)

diff --git a/bsd-user/bsd-signal.h b/bsd-user/bsd-signal.h
new file mode 100644
index 0000000000..49e58d7436
--- /dev/null
+++ b/bsd-user/bsd-signal.h
@@ -0,0 +1,151 @@
+/*
+ * signal related system call shims
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef BSD_SIGNAL_H
+#define BSD_SIGNAL_H
+
+#include <signal.h>
+
+/* sigaction(2) */
+static inline abi_long do_bsd_sigaction(abi_long arg1, abi_long arg2,
+                                        abi_long arg3)
+{
+    abi_long ret;
+    struct target_sigaction *old_act, act, oact, *pact;
+
+    if (arg2) {
+        if (!lock_user_struct(VERIFY_READ, old_act, arg2, 1)) {
+            return -TARGET_EFAULT;
+        }
+        act._sa_handler = old_act->_sa_handler;
+        act.sa_flags = old_act->sa_flags;
+        memcpy(&act.sa_mask, &old_act->sa_mask, sizeof(target_sigset_t));
+        unlock_user_struct(old_act, arg2, 0);
+        pact = &act;
+    } else {
+        pact = NULL;
+    }
+    ret = get_errno(do_sigaction(arg1, pact, &oact));
+    if (!is_error(ret) && arg3) {
+        if (!lock_user_struct(VERIFY_WRITE, old_act, arg3, 0)) {
+            return -TARGET_EFAULT;
+        }
+        old_act->_sa_handler = oact._sa_handler;
+        old_act->sa_flags = oact.sa_flags;
+        memcpy(&old_act->sa_mask, &oact.sa_mask, sizeof(target_sigset_t));
+        unlock_user_struct(old_act, arg3, 1);
+    }
+    return ret;
+}
+
+
+/* sigprocmask(2) */
+static inline abi_long do_bsd_sigprocmask(abi_long arg1, abi_ulong arg2,
+                                          abi_ulong arg3)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set, oldset, *set_ptr;
+    int how;
+
+    ret = 0;
+    if (arg2) {
+        p = lock_user(VERIFY_READ, arg2, sizeof(target_sigset_t), 1);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        target_to_host_sigset(&set, p);
+        unlock_user(p, arg2, 0);
+        set_ptr = &set;
+        switch (arg1) {
+        case TARGET_SIG_BLOCK:
+            how = SIG_BLOCK;
+            break;
+        case TARGET_SIG_UNBLOCK:
+            how = SIG_UNBLOCK;
+            break;
+        case TARGET_SIG_SETMASK:
+            how = SIG_SETMASK;
+            break;
+        default:
+            return -TARGET_EINVAL;
+        }
+    } else {
+        how = 0;
+        set_ptr = NULL;
+    }
+    ret = do_sigprocmask(how, set_ptr, &oldset);
+    if (!is_error(ret) && arg3) {
+        p = lock_user(VERIFY_WRITE, arg3, sizeof(target_sigset_t), 0);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_sigset(p, &oldset);
+        unlock_user(p, arg3, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+
+/* sigpending(2) */
+static inline abi_long do_bsd_sigpending(abi_long arg1)
+{
+    abi_long ret;
+    void *p;
+    sigset_t set;
+
+    ret = get_errno(sigpending(&set));
+    if (!is_error(ret)) {
+        p = lock_user(VERIFY_WRITE, arg1, sizeof(target_sigset_t), 0);
+        if (p == NULL) {
+            return -TARGET_EFAULT;
+        }
+        host_to_target_sigset(p, &set);
+        unlock_user(p, arg1, sizeof(target_sigset_t));
+    }
+    return ret;
+}
+
+/* sigsuspend(2) */
+static inline abi_long do_bsd_sigsuspend(CPUArchState *env, abi_long arg1,
+                                         abi_long arg2)
+{
+    CPUState *cpu = env_cpu(env);
+    TaskState *ts = cpu->opaque;
+    void *p;
+    abi_long ret;
+
+    p = lock_user(VERIFY_READ, arg1, sizeof(target_sigset_t), 1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    target_to_host_sigset(&ts->sigsuspend_mask, p);
+    unlock_user(p, arg1, 0);
+
+    ret = get_errno(sigsuspend(&ts->sigsuspend_mask));
+    /* XXX Trivially true until safe_syscall */
+    if (ret != -TARGET_ERESTART) {
+        ts->in_sigsuspend = true;
+    }
+
+    return ret;
+}
+
+/* sigreturn(2) */
+static inline abi_long do_bsd_sigreturn(CPUArchState *env, abi_long arg1)
+{
+    if (block_signals()) {
+        return -TARGET_ERESTART;
+    }
+    return do_sigreturn(env, arg1);
+}
+
+/* sigvec(2) - not defined */
+/* sigblock(2) - not defined */
+/* sigsetmask(2) - not defined */
+/* sigstack(2) - not defined */
+
+#endif /* BSD_SIGNAL_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index d402c64726..7fefdb569f 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -38,6 +38,7 @@
 #include "bsd-mem.h"
 #include "bsd-proc.h"
 #include "bsd-misc.h"
+#include "bsd-signal.h"
 
 /* BSD dependent syscall shims */
 #include "os-stat.h"
diff --git a/bsd-user/signal-common.h b/bsd-user/signal-common.h
index 4e634e04a3..9071757873 100644
--- a/bsd-user/signal-common.h
+++ b/bsd-user/signal-common.h
@@ -32,6 +32,7 @@ int block_signals(void); /* Returns non zero if signal pending */
 long do_rt_sigreturn(CPUArchState *env);
 int do_sigaction(int sig, const struct target_sigaction *act,
                 struct target_sigaction *oact);
+int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset);
 abi_long do_sigaltstack(abi_ulong uss_addr, abi_ulong uoss_addr, abi_ulong sp);
 long do_sigreturn(CPUArchState *env, abi_ulong addr);
 void force_sig_fault(int sig, int code, abi_ulong addr);
@@ -42,6 +43,9 @@ void process_pending_signals(CPUArchState *env);
 void queue_signal(CPUArchState *env, int sig, int si_type,
                   target_siginfo_t *info);
 void signal_init(void);
+abi_long target_to_host_sigevent(struct sigevent *host_sevp,
+                                 abi_ulong target_addr);
+int target_to_host_signal(int sig);
 void target_to_host_sigset(sigset_t *d, const target_sigset_t *s);
 
 /*
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 3e5e41e1b1..3f2f823051 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -346,6 +346,33 @@ int block_signals(void)
     return qatomic_xchg(&ts->signal_pending, 1);
 }
 
+abi_long target_to_host_sigevent(struct sigevent *host_sevp,
+                                               abi_ulong target_addr)
+{
+    struct target_sigevent *target_sevp;
+
+    if (!lock_user_struct(VERIFY_READ, target_sevp, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    /*
+     * This union is awkward on 64 bit systems because it has a 32 bit
+     * integer and a pointer in it; we follow the conversion approach
+     * used for handling sigval types in signal.c so the guest should get
+     * the correct value back even if we did a 64 bit byteswap and it's
+     * using the 32 bit integer.
+     */
+    host_sevp->sigev_value.sival_ptr =
+        (void *)(uintptr_t)target_sevp->sigev_value.sival_ptr;
+    host_sevp->sigev_signo =
+        target_to_host_signal(tswap32(target_sevp->sigev_signo));
+    host_sevp->sigev_notify = tswap32(target_sevp->sigev_notify);
+    host_sevp->_sigev_un._threadid = tswap32(target_sevp->_sigev_un._threadid);
+
+    unlock_user_struct(target_sevp, target_addr, 0);
+    return 0;
+}
+
 /* Returns 1 if given signal should dump core if not handled. */
 static int core_dump_signal(int sig)
 {
@@ -725,6 +752,46 @@ int do_sigaction(int sig, const struct target_sigaction *act,
     return ret;
 }
 
+int do_sigprocmask(int how, const sigset_t *set, sigset_t *oldset)
+{
+    TaskState *ts = get_task_state(thread_cpu);
+
+    if (oldset) {
+        *oldset = ts->signal_mask;
+    }
+
+    if (set) {
+        int i;
+
+        if (block_signals()) {
+            return -TARGET_ERESTART;
+        }
+
+        switch (how) {
+        case SIG_BLOCK:
+            sigorset(&ts->signal_mask, &ts->signal_mask, set);
+            break;
+        case SIG_UNBLOCK:
+            for (i = 1; i <= NSIG; ++i) {
+                if (sigismember(set, i)) {
+                    sigdelset(&ts->signal_mask, i);
+                }
+            }
+            break;
+        case SIG_SETMASK:
+            ts->signal_mask = *set;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* Silently ignore attempts to change blocking status of KILL or STOP */
+        sigdelset(&ts->signal_mask, SIGKILL);
+        sigdelset(&ts->signal_mask, SIGSTOP);
+    }
+    return 0;
+}
+
 static inline abi_ulong get_sigframe(struct target_sigaction *ka,
         CPUArchState *env, size_t frame_size)
 {

-- 
2.52.0


