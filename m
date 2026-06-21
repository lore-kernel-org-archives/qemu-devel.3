Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF10CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gr-0002tz-0z; Sun, 21 Jun 2026 00:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gq-0002to-5Y
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:48 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9go-00052Y-3U
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:47 -0400
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-69e1eae4eb4so2772003eaf.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015705; x=1782620505;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j+cNbvuRLubDIqacxeKO9fWQDsE10nkqV1eof2bHpNs=;
 b=zVmm/X2D/UtaFazD8t74vjkPy/c6m7JK4k7va/EMvXDLnuCNCCvFC6OUQXiWjR5ILA
 WzaKq8MbuwdFl995ZTl3k8L0H3IjpszpTycq98XRRxnJdfxTo1w7zRAyWvq71ZopPcN5
 7FxqtfVnT530aaYVoODnmkdtiaO/VZ083K4Ed9QdtEJxg0JPNN6T//brhdt3hEpxQZpn
 RxqbDfgihmp2VP9FS4koOVUEo4M2e0sk5MW7weUvsiKB88a+kFZwNgYe7mwAr8ECwVI+
 V2thPUuY410N0LP/SRZ6xt+fav2rZm0Qfy171QVjqkjeim15XLu5ha3DpKiWL9igu6CS
 VdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015705; x=1782620505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j+cNbvuRLubDIqacxeKO9fWQDsE10nkqV1eof2bHpNs=;
 b=bCWqXgaJl60aCic6KDC/g54T0oSznvK4Wd6t7ftJ9TEvu3J9eRNrbQpYRIA8o0kgjV
 YQCPUbdGTyNw/8DosGUdD/xkJ3hnda6J4hnOhpLEB+qlxvXHoTVJSOkzamXfltmkMadc
 itbfx4tAiHhcTKPUL4xsnNshb8LxvG46tFujt/IdnFEibVU5G21rYO4DKEaFwhYVRuwu
 U7x34BckaKNB/xFy3YkQC3+mFT3j4T65YTChvV2va6Zm15qT3kkCJR/AKySM+o17SV57
 K99+bke87XbP2VN8UCHuwEiV0inFWMIntmmFHLrs3XZ7BnU7I7vriKzTL0Ty/gtnDhZy
 595Q==
X-Gm-Message-State: AOJu0YxVhJ8McFmga1PfvuHEEOHmEwWq0yX6acqNNOVieq0yyWVyuk1W
 cUCbbRAOyM/DknYWOJzmH9nnIGy+vzzygzE4aZAe00Q3rm8gYgQtxUd8DQ58mCdVf00=
X-Gm-Gg: AfdE7ck6e/bveMYXZzJI9/GG3oZUd2e6w4fomndoFz9BBYG1E67n3QjaSBwVViJGDRu
 geM+EJAPBmwyCROMxU5QSIefSUDaOE3PnptWwKuvcXzdGSpsQKQrTLx5fSS8fqiCLUhj1zFH6lL
 f6ODy6lu9jWuAQfTAD9PYl8b65x0cy25TAp4D17jQrPMWD7P5sJTqpmglyGr8bB6DeOlNSsgAlA
 VLNyHTliDEPRFE55EbW8MvI4aYCabbf1gItWZ0QEG/aGjvs8JbTpRb3b9FgjJ1GMayzGohyIB/E
 WwDRfE54H7Yz/+Ajk3S8TIFuaixi7E4HSZWpPrm4mWRsrwz3jR57qU9Bn6bN2JhA67Zsnhly9io
 +PVB8oi5sO2JTDboQAWwUOpZAYColTayUPgEpUamreFHvgzhYxiR/5HolfYibkKbmuy5HSs8Y5E
 s=
X-Received: by 2002:a05:6820:221c:b0:69e:8976:77d9 with SMTP id
 006d021491bc7-6a0de0d51ebmr5752092eaf.40.1782015704754; 
 Sat, 20 Jun 2026 21:21:44 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:52 -0600
Subject: [PATCH v3 05/40] bsd-user: Add bsd-signal.h with sigaction through
 sigreturn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260620-misc-2026q2-v3-5-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9527; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Kv2Qe9Ud9kAfSbvySlQ0ZUMuE6RsukrFKqBnZ6FuB7Q=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z90nnpAuw6+S1WOlfdsv7LkPsKxJKDIKRpu
 rRZP0P5VBuJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AAucEADEOmq/q9+BmyV1RV4uTpoKtKSFC20dk5n4Tx2KAwBgFef8Gd31plMVrpPlgQtni50h24V
 vUp5lrZAflwi29pndL4kqVG5DiDWQbO0pmTAWCZn9vTsxVz7tDFk6KQH5UXbCwObk3Q3Eq3OcuV
 V8Ycd810yzbN5phxNKNCPhvjOiONtZXSZhdgrzmtOJcs8WpV/UXe+n4tbK4ii3oYMGrTY5oG77T
 w+ETXxKUu0c15xu+VEDveJphJWN2v2/9M1qjrHht/ZI6qiK3uyGg4Htbd/rH5xwQKVWEGj8A83/
 EDLIBdcos7sKGCOVzBgXK2xxbfnwVbUnp68wuYhpYWEyy/WaYonj83h4l7JBTo/b51I/S1A+81r
 i0jsfthF9tbYGbm5ENefGvJ8lO/652csERL6Zlb4EcOBjYT8CRX4kLo7QSDdCNMdlm2482UH3Nr
 jEqm+3yq83fg0LH8NyN+sHXuiuq+I2e5sk3eSzv+B4/0zMjbcrWUtJW3DBJRpc6jCXfsKvVfGq9
 OK5wPZBPosKn1ccSmt/3yUXmVLs5xYYBQGzk//3awcT0xIsrbxhHUlK+Rtg1QEF2pVRI5WqeE9Q
 pKu5gNUyDs66cRF6lZh88Zs9kuBlHXTaZvihFutZH8ttpaM89O5kkZ4Fd4wXfxoordYETwIlh8I
 iRaGJGIYSTGLCVQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c41;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc41.google.com
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
2.52.0


