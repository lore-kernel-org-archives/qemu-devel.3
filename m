Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5FCCD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzx2-00018f-DY; Fri, 15 May 2026 17:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzx0-00017p-K3
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:06 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzwy-0002lF-Bf
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:06 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7de46b8e432so377125a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880003; x=1779484803;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a60hp1dWf4eFBFrwG12fEXtrHfuIhsG0O5ntFeHEAEI=;
 b=DwuoUjAnBsAHZpaL3y1M5n6Z/Esdx1j7b+yi5J6DZthuDpdZl+gaPDWLg2SRlhP/L4
 eCCaPVmym/nIJzIWUpbdzzo0bwJqoaGaFRSe0FuZy3eXDeYfNsGh/ba/P8u64LROfCZu
 E7pSzbzIahUqdyjI+2QuvJwR9h7h/zBiOP73P7Nm+u4KiQ7RyZKK/8K9nXf2X14FrSm8
 4J60YRiFJAUG16F+7b/JoUjfiVgqAgdpdIkk1ogdn8ipzlNvz9AhTgpGavWrw46EMCwZ
 sct+kaZhUwloyubsoRA5KWgogRr497tzxtVyfpLgR8m5I8r5uQGIQepf+9wJWTOORSUi
 UvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880003; x=1779484803;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a60hp1dWf4eFBFrwG12fEXtrHfuIhsG0O5ntFeHEAEI=;
 b=X/R28QZc9xXnubgLji4mAcRYQCPZ9fNR9p9Vcwkyyr7dTCL8pT5ta9KBE7JDxE9Dq4
 xS9ORkDhIfYEQSRnK8rfp3q1HAezljOr335XJtF6hFWltVAuK/aC5W4vr6BUoPOlo3p3
 vtCByiuFX4Ck785dX8aoHs/U0dyvVhR89mS+YhMRw8BsjxgNVAHrYrAn0BR0ZdQhJkJ0
 RqArfY914KRvTqyJgs2BvrgpfOunY287B8GNol3WxRiQCi3V8gR7ij9GGIGuaCOoJKcA
 vPwc0TjuKlyRjPH6vHCdG78V+0cJZjE1ZYgOpOZCzvUWEJwU7GSSMrHmqdukjaVWelG5
 xrtg==
X-Gm-Message-State: AOJu0Yy2nvHhVfud7TGr3NDJjnyVxHTqZZ61kQyumrN5X5njqILM+k29
 2rKNtnK38QI2O6Obcfjxp9AMx4spYbVvVf5qxVUWaHvbk3IDpQSYjRyQ9pedGPT6YWk=
X-Gm-Gg: Acq92OEpAVdV5ttpqYQpJ/dKsIjvprilGp2vQORc4/dAnuCfjXsl8aXbRs+DwlrDVG4
 daeXFCK+dsVxm+nZZBsk+x3wwjIe4ks0UltKNWhf49ENNaxB1ZYgHDYMvjiRGqEh+AfsT+XiNvb
 SKH8yMKBPrhFZa5XwJ+0rbeZSEbY5VXyjgwty5npwDacwVWT8EYpFlxxxSsRAPUAjj1XwKyz+cI
 LGnIZxvSzbWu6mCygLUx+X/YEfhuXoUw33biOJQrOftqE6DmiJO4fLdJJ4EimjBIUC0itXr+Mz2
 PEyfvEmaBPj6kcnwDYP8NHb6vh+cVVsT/ci+zNUefm9q3kJJXCxNa/iL/uQ3MumS2vIv/zq8rwP
 p2YRwtSqr5mfy54qja0FMh8S4bge5g70w5X435j0JOpCdpI83/as5GIdWM2EFSL+X0ejXr92SGF
 pbqKVRmd6OoDBvTTS+eI5a
X-Received: by 2002:a05:6830:928:b0:7dc:e08d:d9ec with SMTP id
 46e09a7af769-7e4f2b24e30mr4239780a34.15.1778880002797; 
 Fri, 15 May 2026 14:20:02 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:02 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:02 -0600
Subject: [PATCH 03/66] bsd-user: Add bsd-signal.h with sigaction through
 sigreturn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-misc-2026q2-v1-3-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9451; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=eUrsSwz/1wp5sSzubNugfDrEiOHWJVZBMoyOulKj8eY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43hky3oL9OyJENcyns0mztbZjbURUCvTZvTU
 HZ1mdQ4CjWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4QAKCRBsHNEofbAR
 ALvND/9LyXrLJZR+pXS2y44Dlfwp92J2aHQCuydji5Vx++xAMDo1VUrRPeyd3WXfgNmiqIVOiwZ
 6ZRRsnNUOmrZOM0BwBMWTkxXl6DBBNKworwnCoUw5tpFYcj9ez7rpAjI9smcRThwxJ8RK2B4Rxm
 h/FfnfglLrNY43QLhW3JfIloIruv44APZHCYz9/Gi8eyhB2ozHJWTUSckR7o3jYasC2IblUEanI
 qy7s2okwGiuQ20O7l2swutyoOjaXy1U0w593WlRx0wK2htbGfT9YD2nj9E9G8XoDPMGhx0YzSId
 lkEZqZd8LFJGoRKyyf0Yf9ps+0t4bdKYQTGuXSH8GwFwuwBYIACmdEs/kha2Of0NQCUAF3kG29o
 9s6n93FAgZ1fTLvRPdgJT6LzMEF2l9vrTeyUg2v8KQjpf4JGRVMGOXjy6L/uFXxUJUTLsPUSi/P
 Y8HA9UNOZoXCNDc8WXHwEo9qQqwvKP9jVdPWAA1cVnQWOSMefbmX+IVOvDdDp6TvY+o+BgpeTMA
 eDWp9n4HrmjcCm7ixw29ZFVa8xNQeYIQLeP1wdwJyesTP5a/zGBa7JFjMJBZV7CNnsQg4P9WLI+
 F+1WU1BpFKTIehkcbYpR+afyQ3iWGMgYxHybOjd0TEucjWRAYsDjWQ0ane7W1jyLveyyqhyuYXW
 V5cnMLquTw8aFaA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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
index 3e5e41e1b1..8ec206256b 100644
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
+    unlock_user_struct(target_sevp, target_addr, 1);
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


