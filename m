Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D283CC5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgU-0001u2-K9; Tue, 18 Aug 2026 19:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgS-0001qS-OK
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:32 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgQ-0005CR-K7
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:32 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4a4cb36ae00so357674b6e.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097449; x=1787702249;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=isMuBHhI/dNebvc66IvHXOnjmMr0h/+Y4YeEnzJOcGs=;
 b=F5F05655aZM0igo9T3GGH7g7CuFg2Lgd8yWeNgwDwY3RMEYa6KC66VbB0ufqKEsyCG
 0eVouh2pGK7mljEyQyOzWa/qwLy2HcAjKZEWH4EWtgVCsBDecGPTKA4wbl0GUMofqD3g
 tJyat1R0CKCq5yLze1vRf/PobXY2UUOq1ZTh/uDbj0mBHVJkkVmuv4jwD43DewPlS29v
 Ac4DKrDX5U+HS3H8cPqNM3O7g/P7KkmAH+IIS+R/c9HRLH4YpwOemDQdjP129SHvp+YT
 MKZxBegvuw+Sx/W2bei5eiMZHUenTDPghYUbSNW8aheqZxnvK1LzIovdac5GnqMqNOxI
 6ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097449; x=1787702249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=isMuBHhI/dNebvc66IvHXOnjmMr0h/+Y4YeEnzJOcGs=;
 b=HebtlpmwVo4UyEIlhrKJW5WVsxQU1XNryNkjlq24UvTpe6T5uDA0Q8rkPAz+83M0Qn
 +cgwewqY3l85Imo27YeD8Fw497MyHnD4cPGOQA1jiT0sGhOqC3w6TDsbU62Fi8N2K1wh
 pqQjvEFkhJ+VYYVRZF1hMo0ucZaUPeml/HSth+UejjWNpNsaMBRAo4T+v2P/oS86hVlA
 ujSQ1TGRLB2BcwwzOcQRk0AOkmMcxvBBswSgJS0nfyVPPdmQplVovmjqS+sWRKRB+v7H
 RKafDQ2RhMHDgykx5YaJ8VZkbG8tUJjhv5eDlaZKbiQSfyrXt6WjDXb1AJJ1/BDQnqGo
 8aKA==
X-Gm-Message-State: AOJu0Yw70NaSSp4z0fAh1vVs4z8oE+jJzofGZZDVk8Lq5nUBhjzcaR0e
 6K7OUpUp3ffl8uWH1tOXVY8Kk6HzFsgbC5/nw5MJFT06TIPHjf4dvjwTAMZruRiyBLc=
X-Gm-Gg: AR+sD120Hzjhx63hm5dLR0mccxUX+3EA15SpH7SRMGtkd3hWtjsarF0JziGmJC6csxn
 R9HdVU0YfUNMaGd8PIBYPrSEnrxoy9e+XKBLfv4+lx7equHDqNC/Cnk/Hv/uZHjf8ZS3kJctQNz
 vILnHJf9Gw2c72e1CzDzFvc0qZNtL5lBqc46Ce7fsI97IOB+4Ps+fGocCYAZ5HgNs3N/2G5turm
 LTQ03z7wjVwB+++eyFyCQaFT4IujzXpGMGLcg0N/ixYzgI8vW6WXGsjceIcHJx1kCSOjahoee4P
 /zckqnIZvOFEWUqZ97HWzlB9cJCxIh9P62CLT2u5h06DY1+tGBskQ1elbnTTQmLsGx2OG/IcCJj
 1t5L2zGFq8eLcX4SlSamhRiW+pgsR1SbBB+tNsAkEDu60ZoRtLYWQuh3184LAWYCRTpKBkvGuzB
 BfTvCLi+l0jihjzdlxRI7dpzwjFTB/Dwv4jNQU11Mvf4sbu5uenA9e26FChA==
X-Received: by 2002:a05:6808:148b:b0:4b2:8e1c:2b36 with SMTP id
 5614622812f47-4b2bcb68105mr314089b6e.20.1787097449405; 
 Tue, 18 Aug 2026 16:57:29 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:55:56 -0600
Subject: [PATCH v4 03/40] bsd-user: Add bsd-signal.h with sigaction through
 sigreturn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-3-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9650; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=oUO6qnw8M2WT+brJJsIeDGb0dGGZiOpvDTnPwmkDNy8=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEiw3kNNkWYZEm/tnKhr6wtoGcaXxDLl4L+F
 E2p21dlRgqJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxIhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDb4Q/+NeoCRdhNaVqcmMxZ16AnQvbtW4z6jF0
 fb3F/3S4tkUretXJSYe9aCiUPzKcBRK+tWtEKUUlOG/AB+yu/wTTUi9gpp7obAelOtFPXaBysUu
 0787xcXyo2qUPGffAM+59jmd66eZkKaHXQD/Ya9MeyP81U5K8IANrtCrxC75N5kGuw2b9qrCx1b
 M2R4g++k1eu9olH16+ss+ocjuv4D052va1zb8Z0aGmsm7sGS69qGbSgcSaJ2YVFHP9VcjYXKXUd
 /0kXwTR9KV2X9oCkhjiYSlyG3GAJuXMNXwxy5VkmhNxEcSmOjnl/eoP1PbDSZWEhofr2VttY7/y
 6trct7JhvcMEcuezMcqsbUMBnQ//sO8RY7LegbKW5lCjtCwbBZ0gNgwfvCEqwvK/U3Dkd8vxkFy
 F6xlUOY/XrhhxexWUIEO59jrh9+6/NEH65Ua62ewGySgGOotXSdOBVTOdDgMXdIaEemmLUZkalx
 bamDkNjRStGSwQgL8Y3I45im5NoIG3PHsj5gIv/JdqilQ7wJBRezdiIa0Rx+++85Vu9nUlU/2NX
 /klxXEd0Vx6mMGJ0VXlTo+CPXAl85sVo9P8J+PfGpX5+zHo5w+Cs4e2NR4I+k3dq6p+M8E0IQ9h
 Ob/CMLH3Ttb5MQKV8hLmowQjB2vEVe8VYWlYgeWjxj2R5lHAF0eM=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x235.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
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
index 3e5e41e1b1..da7cf1d60b 100644
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
+        (void *)(uintptr_t)tswapal(target_sevp->sigev_value.sival_ptr);
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
2.55.0


