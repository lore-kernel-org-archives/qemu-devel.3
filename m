Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27C7C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yEx-0002n0-Lk; Sat, 19 Sep 2026 12:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEv-0002mT-Hr
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:37 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yEs-00089U-M9
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:48:37 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6c72bd8a017so1093764eaf.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836513; x=1790441313;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XelgfWwdeNzcqaiPuyQIjxp/lcvMRmayPY+XsptkFtA=;
 b=GEfUAusvOpulMBqB5JXyyIT669TqUp990ubwoyf1HWI09BFZ67kHJV9FwGXH9pCpHR
 Fb69VUm/oI7pO5ilJhbJEFcdJjHBUHp9CrQ4FzIzVdVIil8ISJ7vwc8nX1KQ2JGHkSXO
 Zk3AOZ0RK1wxVStM7kn91j5n0MxnsruWGj7F0EKHD7TNsa2jSso8+fKlePdueGJ2dS02
 q7S6st81Qq2/qXO3dX5gXHWAxmp/LF0efanneTTmeTPR4Ri6gpSyqNLRodzrliMgVvBP
 QOrvVBndycfmV/CGZQswBJB5RqgTGdOOXLY5o/Xsl/utgG4S7DiSeXQav9wq0t2vBjgn
 jvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836513; x=1790441313;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XelgfWwdeNzcqaiPuyQIjxp/lcvMRmayPY+XsptkFtA=;
 b=CTJtaK9v498WZxpTyCWaA5x+x0ENnyPpVtnh/hhrLNLvwfifTD1cKb2P46qSr0Zao8
 BLQeBNFKltKwxoK3soOeZiVjEOojr/dX/M5m9CwP/MYN/8VriuBRdZe6yAH8ORAh/CGT
 b76MloySr0aChVSZTNsbdLO/MoELWCSFho7Cd9arIC4e3qeTWqqBXbyvDxffjLKP9buH
 CSW1kVmr94Gvx8Svvhcj9TMCcY46mlSdKqYSDTUjiQFrEyAuhQzvmi26PUFyKlyb2ld7
 5LBwAxnhmQfBmHQ4dafJJ2ZPj2cfmMWdOzLwEsLMqEgDGYbpPidGtSSEr+IdRFxa3+AH
 IlFg==
X-Gm-Message-State: AFuF++l5h1Z4y1FpSawce3dNyix90Cirpu2lKxriT4UZO5hwP0W7Y9jp
 0Y0FoAlqIlHwGNsiPOvIuJ/NxEsUgZrpfbYZ39NnPcnYRimeYDPjaIkVcEaP32d94yiURS9E4AG
 P3p0gE+Y=
X-Gm-Gg: AYBFou29MFC9dyagtYDS4y2CYYsFzQnoJDlY4zbIvDZLz+WsOYCgilQh4tszlzCwScg
 9rdr0RZNkhV+qGuGRa7So6H7kS6QXK/eFOJwehXGkMgjnb66WHOpzMK5lyGe3tCDcWtETyRhBSB
 FnhkXRestslWQKIePO7B4+4D6Xqm1BOFsKWI5sOjSqQVNXoKMvyng50Y1I4AviZ9l4vKIUSrZZi
 S180/0K8hdWzVerg4CLPMO4bc6xjFE+EL9U8McIxDhb01YS4kX1cP2kd4DRb/akTtNQD1n2pXMr
 bbwBgkN5e4qbxPWOT4/fJPNSb+reOVho4i4sksNBndrdW4JnpY049PJ1Af7EU/C7L7bR/93WxUy
 xLNX+99kXsIpdemqKlk95WmZUaqeLM84f/5Sz6NEWbIsomOOdkSbatD1pGEkwbR2nG7fG6q4x+y
 l0igCA+Zk82sfhaWgqzterlUTQt17TCzkD1kdkFr531T8It6j6zPWAw4cBxVDIeFHsMsZ1
X-Received: by 2002:a05:6820:81c2:b0:6cd:3fbd:1d67 with SMTP id
 006d021491bc7-6cd3fbd2968mr2554624eaf.81.1789836513396; 
 Sat, 19 Sep 2026 09:48:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:48:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/41] bsd-user: Add bsd-signal.h with sigaction through
 sigreturn
Date: Sat, 19 Sep 2026 10:47:32 -0600
Message-ID: <20260919164810.70151-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::2b;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
 bsd-user/bsd-signal.h         | 151 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |   1 +
 bsd-user/signal-common.h      |   4 +
 bsd-user/signal.c             |  67 +++++++++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 bsd-user/bsd-signal.h

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


