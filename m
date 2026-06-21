Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F92CDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hd-0003Ba-6x; Sun, 21 Jun 2026 00:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hW-00036H-C0
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:31 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hQ-0005Ic-Ga
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:29 -0400
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-6a0eb989530so433125eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015743; x=1782620543;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3oObxpLj8nYhSS5eWFV4JzUsYWuFhvft7QmFGBajXwY=;
 b=iTQ9oDHjgimLP2YZ29Sl58H4Ul6Oq6NenlTUFeby28Im/6DzzRdsywY9RmD/RqOw2F
 1wbek0XJqYnQ+cWMyUA/vnjGBuTkrEDfcOnZTrPlTtA6rL1AvPr/U7tM6JdL0g6r6RcX
 6u4kmVz0KrN+TUR/rhd3syfHq8ZabmN7oUT76XbrkFOD7Liigs0t79LsyjzGrSI06/iz
 v8AFvSW3498hLLx+vM95rSgwN81L3OiwIFpBqJoX6+DBph66wtHLkDxB3vv0iHyCltiH
 XZrPs+JLKW1EO+UgaqWkeaaW00uqD3FpEIBYnF1rVP5KeoMK+5c4NlgjDXPQuQHN/UQx
 2KKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015743; x=1782620543;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3oObxpLj8nYhSS5eWFV4JzUsYWuFhvft7QmFGBajXwY=;
 b=c6AOZE2NHRpp8lwFHfedu49VDmLTlbFwroclemCF3ryocZW3wwigAgOM+C2k9IWyCa
 Xm3g3nw5kKAwPcRh4079LljVyvgWEdgxq0klnAjaI8UWnbFq6S136NCFTlECM5kHeyro
 0+EJgKwMwkr9hFe26pJ2wsx1MUGLG1rMIdCq/7jsQ90WlmG7vKSMFbBBHryW/6ct6qhQ
 rE/0CwEe2UfBZHdI5vfnZE8u5Fe5Qm2RSctNBigsne10AI7TKJEx8LngP9n+BoktqkNq
 iRfMgkDXKSgegqXElQLKUweg0sIf9K+bQ30UHwgmcBasIqFJa9a+ZmGskfEIgQa7/9gk
 W2Bg==
X-Gm-Message-State: AOJu0YySqRul0+xWx7Lcqj1ZdhsmHzwDTZ12LSLx1TkvRW4Mzq8YtsTO
 +/2HcaDNi5f3E1YuPKL14AY3cs6OsLGmt4oECQyI3ZGh5nljBHlxu91pnmUxGc8b2bs=
X-Gm-Gg: AfdE7cl4aAuPyE6y1xA3SdbIAqIQvXXzTwTZIn46kiLAg5LXwLUzqtlTNu98OjJaJ2e
 4d33RFCp3gkv24CZtpcn9tuaaJcKhpfcqSd2h5QV2EZyZLH1y+y0mIMuBMS51u8BjT67XYymEME
 iIlu5HFNAEbH5Pj+HR19SbUvHDOTjHqbtORlk4tURVXmXDpMacT9Rq5cNyFCNhnPl0TVmQN6i/c
 E9MKC63Fi1F9HpaknhrYpQSTrwVwNmK30LAHD1C9Vc8+fu4cOqvU0U8/JNc/20c8gX2fvmy8UjB
 3kj8/Kulxj6bXByHlZWFlgE9Te61HEBp9r0tK0/B8K+7gtgN5HFr0CrSscyOVSCPd/uE1acUWPL
 MVzEleKtz0VNLHtndVt5VR9dEURMjoIqvi3dLMXir7nKOIgev7OYp/9+Y3dtdK+Srg2o0YMap5y
 w=
X-Received: by 2002:a05:6820:198f:b0:694:6acf:a420 with SMTP id
 006d021491bc7-6a0d88787fcmr7977324eaf.15.1782015742770; 
 Sat, 20 Jun 2026 21:22:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:16 -0600
Subject: [PATCH v3 29/40] bsd-user: Add do_freebsd__umtx_op to os-thread.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-29-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Sean Bruno <sbruno@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=72546; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=MQKXFhl3QW01f3iV8CF2mBbhYDfUQ8EkOGn94AYVzsc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aAtFzd0ysiLi+g9mSY+lRMHPjXHC/kcXOhI
 wRRvhM9NumJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 AEhsEACKghZVhMO5NSPog193ysU4FMsPQg7Eqaf/oeCEGUi+7XRxxe4kKwa4XSWn1zHFk8mHeOc
 GTxXZd5LBd4FNOZ5leoMc9aMthWFn+Uv2T593j8vNxpk+Aj6OjpVnPzFT+VmEL+0idkTct8ATbd
 eRTc4MQ7a3DZiLWL0F1h7ixQ1mbfTTKU3NqQhGauBe0gucRAZ46XUvOgbVLRpFcaKrmCqpnxZ+7
 whw928rhmcxZ4RrXyNXEUG0PfKd2z+KOd3Q+B43jfatCwUF1iQk3Ov/WT5Q562//KJxu8w6EcX4
 SG/rZ4C/NXFV5sijcsEOMWHrvglmuAoMFHHRIFXfs4SiuWRNZyO0ji+ld9OUxC8uPZJWNPRiVOu
 Q3lvrH3GPWb17UbnF6nPjZSKIYyZuxn2j8p3bk3VAqs6qxNzW2zxXL3gmwZ4AVk/CU0tMvNEy9n
 aDqd9wws543RX8A2xPhEHfEyCUii0yXeqWakNKwR+4xERU4Kyy1r9dUoBbdUGJKPciJXJZqm3WJ
 Tu4iyz7aNNGgj0I8ZfqgHJtEvlfkDgv1iCyBBUx45uHeF06SMH/b+L0aUwsTEgRhMHHbGX2I1dS
 c7pFzCyq9T4YyBXMp7pBkXUZaDG0e3rfscaZIkAF8R+3qO6oGeUush/98TcQWgSLssYuZ2Y/+98
 rHaSl33nRbPLf1g==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c44;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc44.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Add the _umtx_op system call implementation with support for
UMTX lock/unlock, mutex operations, condition variables, reader-writer
locks, semaphores, shared memory, and robust lists.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/meson.build |    1 +
 bsd-user/freebsd/os-thread.c | 1682 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-thread.h |  352 +++++++++
 3 files changed, 2035 insertions(+)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 163d5657db..db531604ad 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -9,6 +9,7 @@ bsd_user_ss.add(files(
   'os-stat.c',
   'os-sys.c',
   'os-syscall.c',
+  'os-thread.c',
   'os-time.c'),
   bsd_syscall_nr
 )
diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
new file mode 100644
index 0000000000..63c17e10d0
--- /dev/null
+++ b/bsd-user/freebsd/os-thread.c
@@ -0,0 +1,1682 @@
+/*
+ * FreeBSD thr emulation support code
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <machine/atomic.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+#include "signal-common.h"
+#include "target_arch_cpu.h"
+#include "target_arch_thread.h"
+#include "tcg/startup.h"
+#include "exec/tb-flush.h"
+
+#include "os-thread.h"
+
+/* #define DEBUG_UMTX(...)   fprintf(stderr, __VA_ARGS__) */
+/* #define DEBUG_UMTX(...) qemu_log(__VA_ARGS__) */
+#define DEBUG_UMTX(...)
+
+#define DETECT_DEADLOCK 0
+#define DEADLOCK_TO     1200
+
+#define NEW_STACK_SIZE  0x40000
+
+/* sys/_umtx.h */
+struct target_umtx {
+    abi_ulong   u_owner;    /* Owner of the mutex. */
+};
+
+struct target_umutex {
+    uint32_t    m_owner;    /* Owner of the mutex */
+    uint32_t    m_flags;    /* Flags of the mutex */
+    uint32_t    m_ceiling[2];   /* Priority protect ceiling */
+    abi_ulong   m_rb_lnk;   /* Robust linkage. */
+#if TARGET_ABI_BITS == 32
+    uint32_t    m_pad;
+#endif
+    uint32_t    m_spare;
+    uint32_t    m_count;    /* QEMU-internal; takes one spare. */
+};
+
+struct target_ucond {
+    uint32_t    c_has_waiters;  /* Has waiters in kernel */
+    uint32_t    c_flags;    /* Flags of the condition variable */
+    uint32_t    c_clockid;  /* Clock id */
+    uint32_t    c_spare[1];
+};
+
+struct target_urwlock {
+    uint32_t    rw_state;
+    uint32_t    rw_flags;
+    uint32_t    rw_blocked_readers;
+    uint32_t    rw_blocked_writers;
+    uint32_t    rw_spare[4];
+};
+
+struct target__usem {
+    uint32_t    _has_waiters;
+    uint32_t    _count;
+    uint32_t    _flags;
+};
+
+struct target__usem2 {
+    uint32_t    _count;
+    uint32_t    _flags;
+};
+
+struct target_umtx_robust_lists_params {
+    abi_ulong   robust_list_offset;
+#if TARGET_ABI_BITS == 32
+    uint32_t    m_pad1;
+#endif
+    abi_ulong   robust_priv_list_offset;
+#if TARGET_ABI_BITS == 32
+    uint32_t    m_pad2;
+#endif
+    abi_ulong   robust_inact_offset;
+#if TARGET_ABI_BITS == 32
+    uint32_t    m_pad3;
+#endif
+};
+
+/*
+ * !!! These mutexes must be reset in fork_end() (in bsd-user/main.c).
+ */
+static pthread_mutex_t new_thread_lock = PTHREAD_MUTEX_INITIALIZER;
+pthread_mutex_t *new_freebsd_thread_lock_ptr = &new_thread_lock;
+static pthread_mutex_t umtx_wait_lck = PTHREAD_MUTEX_INITIALIZER;
+pthread_mutex_t *freebsd_umtx_wait_lck_ptr = &umtx_wait_lck;
+
+static void rtp_to_schedparam(const struct rtprio *rtp, int *policy,
+        struct sched_param *param)
+{
+
+    switch (rtp->type) {
+    case RTP_PRIO_REALTIME:
+        *policy = SCHED_RR;
+        param->sched_priority = RTP_PRIO_MAX - rtp->prio;
+        break;
+
+    case RTP_PRIO_FIFO:
+        *policy = SCHED_FIFO;
+        param->sched_priority = RTP_PRIO_MAX - rtp->prio;
+        break;
+
+    default:
+        *policy = SCHED_OTHER;
+        param->sched_priority = 0;
+        break;
+    }
+}
+
+void *new_freebsd_thread_start(void *arg)
+{
+    new_freebsd_thread_info_t *info = arg;
+    CPUArchState *env;
+    CPUState *cpu;
+    long tid;
+
+    rcu_register_thread();
+    tcg_register_thread();
+    env = info->env;
+    cpu = env_cpu(env);
+    thread_cpu = cpu;
+    (void)thr_self(&tid);
+
+    /* copy out the child TID to both locations */
+    if (info->param.child_tid) {
+        put_user_ual(tid, info->param.child_tid);
+    }
+    if (info->param.parent_tid) {
+        put_user_ual(tid, info->param.parent_tid);
+    }
+
+    /* Set arch dependent registers to start thread. */
+    target_thread_set_upcall(env, info->param.start_func, info->param.arg,
+        info->param.stack_base, info->param.stack_size);
+    target_cpu_set_tls(env, info->param.tls_base);
+
+    /* Enable signals */
+    sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
+    /* Signal to the parent that we're ready. */
+    pthread_mutex_lock(&info->mutex);
+    pthread_cond_broadcast(&info->cond);
+    pthread_mutex_unlock(&info->mutex);
+    /* Wait until the parent has finished. */
+    pthread_mutex_lock(new_freebsd_thread_lock_ptr);
+    pthread_mutex_unlock(new_freebsd_thread_lock_ptr);
+
+    cpu_loop(env);
+    /* never exits */
+
+    return NULL;
+}
+
+/*
+ * FreeBSD user mutex (_umtx) emulation
+ */
+static int tcmpset_al(abi_ulong *addr, abi_ulong a, abi_ulong b)
+{
+    abi_ulong current = tswapal(a);
+    abi_ulong new = tswapal(b);
+
+#ifdef TARGET_ABI32
+    return atomic_cmpset_acq_32(addr, current, new);
+#else
+    return atomic_cmpset_acq_64(addr, current, new);
+#endif
+}
+
+#ifdef _UMTX_OPTIMIZED
+static int optimized_umtx_op(abi_ulong obj, int op, abi_ulong val,
+    void *uaddr1, void *uaddr2)
+{
+
+    return get_errno(safe__umtx_op(g2h_untagged(obj), QEMU_UMTX_OP(op), val,
+                                   uaddr1, uaddr2));
+}
+
+#else /* !_UMTX_OPTIMIZED */
+
+/*
+ * _cv_mutex keeps other threads from doing a signal or broadcast until
+ * the thread is actually asleep and ready.  This is a global mutex for all
+ * condition vars so I am sure performance may be a problem if there are lots
+ * of CVs.
+ *
+ */
+static struct umutex _cv_mutex;
+
+static int tcmpset_32(uint32_t *addr, uint32_t a, uint32_t b)
+{
+    uint32_t current = tswap32(a);
+    uint32_t new = tswap32(b);
+
+    return atomic_cmpset_acq_32(addr, current, new);
+}
+
+#endif /* _UMTX_OPTIMIZED */
+
+static abi_long _umtx_wait_uint(uint32_t *addr, uint32_t target_val,
+        size_t tsz, void *t, const char *where)
+{
+#if DETECT_DEADLOCK
+    abi_long ret;
+    long cnt = 0;
+
+    /* target_val has already been tswap'ed. */
+    if (t == NULL) {
+        struct timespec ts;
+
+        ts.tv_sec = 5;
+        ts.tv_nsec = 0;
+
+        do {
+            if (target_val != *addr) {
+                return 0;
+            }
+
+            ret = get_errno(safe__umtx_op(addr, QEMU_UMTX_OP(UMTX_OP_WAIT_UINT),
+                    target_val, NULL, &ts));
+
+            if (ret != -TARGET_ETIMEDOUT) {
+                return ret;
+            }
+            if (cnt++ > DEADLOCK_TO) {
+                fprintf(stderr, "QEMU: Deadlock in %s from %s\n",
+                        __func__, where);
+                abort();
+            }
+        } while (1);
+    } else
+#endif
+        return get_errno(safe__umtx_op(addr, QEMU_UMTX_OP(UMTX_OP_WAIT_UINT),
+            target_val, (void *)tsz, t));
+}
+
+abi_long freebsd_umtx_wait_uint(abi_ulong obj, uint32_t target_val,
+        size_t tsz, void *t)
+{
+    /* target_val has already been tswap'ed. */
+
+    DEBUG_UMTX("<WAIT> %s: _umtx_op(%p, %d, 0x%x, %d, %p)\n", __func__,
+               g2h_untagged(obj), UMTX_OP_WAIT_UINT, target_val, (int)tsz, t);
+
+    return _umtx_wait_uint(g2h_untagged(obj), target_val, tsz, t, __func__);
+}
+
+static abi_long _umtx_wait_uint_private(uint32_t *addr, uint32_t target_val,
+        size_t tsz, void *t, const char *where)
+{
+#if DETECT_DEADLOCK
+    abi_long ret;
+    long cnt = 0;
+
+    /* target_val has already been tswap'ed. */
+    if (t == NULL) {
+        struct timespec ts;
+
+        ts.tv_sec = 5;
+        ts.tv_nsec = 0;
+
+        do {
+            if (target_val != *addr) {
+                return 0;
+            }
+
+            ret = get_errno(safe__umtx_op(addr,
+                QEMU_UMTX_OP(UMTX_OP_WAIT_UINT_PRIVATE), target_val, NULL,
+                &ts));
+
+            if (ret != -TARGET_ETIMEDOUT) {
+                return ret;
+            }
+            if (cnt++ > DEADLOCK_TO) {
+                fprintf(stderr, "QEMU: Deadlock in %s from %s\n", __func__,
+                        where);
+                abort();
+            }
+        } while (1);
+    } else
+#endif /* DETECT_DEADLOCK */
+    {
+        return get_errno(safe__umtx_op(addr,
+            QEMU_UMTX_OP(UMTX_OP_WAIT_UINT_PRIVATE), target_val, (void *)tsz,
+            t));
+    }
+}
+
+abi_long freebsd_umtx_wait_uint_private(abi_ulong obj, uint32_t target_val,
+        size_t tsz, void *t)
+{
+    DEBUG_UMTX("<WAIT_UINT_PRIVATE> %s: _umtx_op(%p (%u), %d, 0x%x, %d, %p)\n",
+        __func__, g2h_untagged(obj), tswap32(*(uint32_t *)g2h_untagged(obj)),
+        UMTX_OP_WAIT_UINT_PRIVATE, target_val, (int)tsz, t);
+
+    return _umtx_wait_uint_private(g2h_untagged(obj), target_val, tsz, t,
+        __func__);
+}
+
+static abi_long _umtx_wait(abi_ulong *addr, abi_ulong target_val, size_t tsz,
+        void *t, const char *where)
+{
+#if DETECT_DEADLOCK
+    abi_long ret;
+    long cnt = 0;
+
+    /* target_val has already been tswap'ed. */
+
+    if (t == NULL) {
+        struct timespec ts;
+
+        ts.tv_sec = 5;
+        ts.tv_nsec = 0;
+
+        do {
+            if (target_val != *addr) {
+                return 0;
+            }
+
+            ret = get_errno(safe__umtx_op(addr, QEMU_UMTX_OP(UMTX_OP_WAIT),
+                        target_val, NULL, &ts));
+            if (ret != -TARGET_ETIMEDOUT) {
+                return ret;
+            }
+
+            if (cnt++ > DEADLOCK_TO) {
+                fprintf(stderr, "QEMU: Deadlock in %s from %s\n", __func__,
+                        where);
+                abort();
+            }
+        } while (1);
+    } else
+#endif /* DETECT_DEADLOCK */
+    {
+        return get_errno(safe__umtx_op(addr, QEMU_UMTX_OP(UMTX_OP_WAIT),
+                target_val, (void *)tsz, t));
+    }
+}
+
+abi_long freebsd_umtx_wait(abi_ulong targ_addr, abi_ulong target_id, size_t tsz,
+        void *t)
+{
+
+    /* target_id has already been tswap'ed. */
+
+    /* We want to check the user memory but not lock it.  We might sleep. */
+    if (!access_ok(VERIFY_READ, targ_addr, sizeof(abi_ulong))) {
+        return -TARGET_EFAULT;
+    }
+
+    DEBUG_UMTX("<WAIT> %s: _umtx_op(%p, %d, 0x%llx, %d, %p)\n",
+        __func__, g2h_untagged(targ_addr), UMTX_OP_WAIT, (long long)target_id,
+        (int)tsz, t);
+    return _umtx_wait(g2h_untagged(targ_addr), target_id, tsz, t, __func__);
+}
+
+
+abi_long freebsd_umtx_wake_private(abi_ulong obj, uint32_t val)
+{
+
+    DEBUG_UMTX("<WAKE_PRIVATE> %s: _umtx_op(%p (%d), %d, %u, NULL, NULL)\n",
+        __func__, g2h_untagged(obj), tswap32(*(uint32_t *)g2h_untagged(obj)),
+        UMTX_OP_WAKE_PRIVATE, val);
+    return get_errno(safe__umtx_op(g2h_untagged(obj),
+        QEMU_UMTX_OP(UMTX_OP_WAKE_PRIVATE), val, NULL, NULL));
+}
+
+#if defined(UMTX_OP_NWAKE_PRIVATE)
+#define BATCH_SIZE 128
+abi_long freebsd_umtx_nwake_private(abi_ulong target_array_addr, uint32_t num)
+{
+#ifdef _UMTX_OPTIMIZED
+    abi_ulong *tp;
+    uintptr_t uaddrs[BATCH_SIZE];
+    int count, error, i, j;
+
+    if (!access_ok(VERIFY_READ, target_array_addr, num * sizeof(abi_ulong))) {
+        return -TARGET_EFAULT;
+    }
+
+    /*
+     * If we haven't relocated the guest, there's a 1:1 mapping so we can avoid
+     * having to g2h_untagged() each address and just pass it through as-is.
+     */
+    if (!have_guest_base && !reserved_va) {
+        return optimized_umtx_op(target_array_addr, UMTX_OP_NWAKE_PRIVATE, num,
+            NULL, NULL);
+    }
+
+    tp = (abi_ulong *)g2h_untagged(target_array_addr);
+    for (i = 0, count = num; i < num; i += BATCH_SIZE, count -= BATCH_SIZE) {
+        for (j = i; j < i + MIN(BATCH_SIZE, count); j++) {
+            uaddrs[j % BATCH_SIZE] = (uintptr_t)g2h_untagged(tp[j]);
+        }
+
+        /*
+         * This one should not be passed as compat32 at this point; we've
+         * converted them all to host pointers.
+         */
+        error = get_errno(safe__umtx_op(uaddrs, UMTX_OP_NWAKE_PRIVATE,
+            MIN(BATCH_SIZE, count), NULL, NULL));
+        if (is_error(error)) {
+            return error;
+        }
+    }
+
+    return 0;
+#else
+    int i;
+    abi_ulong *uaddr;
+    abi_long ret = 0;
+
+    DEBUG_UMTX("<NWAKE_PRIVATE> %s: _umtx_op(%p, %d, %d, NULL, NULL) Waking: ",
+        __func__, g2h_untagged(target_array_addr), UMTX_OP_NWAKE_PRIVATE, num);
+
+    if (!access_ok(VERIFY_READ, target_array_addr, num * sizeof(abi_ulong))) {
+        return -TARGET_EFAULT;
+    }
+
+    uaddr = (abi_ulong *)g2h_untagged(target_array_addr);
+    for (i = 0; i < (int32_t)num; i++) {
+        DEBUG_UMTX("%p (%u) ", g2h_untagged(tswapal(uaddr[i])),
+            tswap32(*(uint32_t *)g2h_untagged(tswapal(uaddr[i]))));
+        ret = get_errno(safe__umtx_op(g2h_untagged(tswapal(uaddr[i])),
+            UMTX_OP_WAKE_PRIVATE, INT_MAX, NULL, NULL));
+        if (is_error(ret)) {
+            DEBUG_UMTX("\n");
+            return ret;
+        }
+    }
+    DEBUG_UMTX("\n");
+    return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+#endif /* UMTX_OP_NWAKE_PRIVATE */
+
+#if defined(UMTX_OP_MUTEX_WAKE2)
+abi_long freebsd_umtx_mutex_wake2(abi_ulong target_addr, uint32_t flags)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_addr, sizeof(struct target_umutex))) {
+        return -TARGET_EFAULT;
+    }
+
+    DEBUG_UMTX("<MUTEX WAKE2> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+        __func__, g2h_untagged(target_addr), UMTX_OP_MUTEX_WAKE2, flags);
+    return optimized_umtx_op(target_addr, UMTX_OP_MUTEX_WAKE2, flags, NULL,
+        NULL);
+#else
+    uint32_t count, owner, *addr;
+    struct target_umutex *target_umutex;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_umutex, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    pthread_mutex_lock(&umtx_wait_lck);
+    __get_user(count, &target_umutex->m_count);
+    __get_user(owner, &target_umutex->m_owner);
+    while ((owner & TARGET_UMUTEX_CONTESTED) == 0 && (count > 1 ||
+            (count == 1 && (owner & ~TARGET_UMUTEX_CONTESTED) != 0))) {
+        if (tcmpset_32(&target_umutex->m_owner, owner,
+                    (owner | TARGET_UMUTEX_CONTESTED)))
+            break;
+
+        /* owner has changed */
+        __get_user(owner, &target_umutex->m_owner);
+    }
+    pthread_mutex_unlock(&umtx_wait_lck);
+    addr = &target_umutex->m_owner;
+    /* tcmpset_32 above writes to guest, and addr is just a key below */
+    unlock_user_struct(target_umutex, target_addr, 0);
+
+    return get_errno(safe__umtx_op(addr, UMTX_OP_WAKE_PRIVATE, 1, NULL,
+        NULL));
+#endif /* _UMTX_OPTIMIZED */
+}
+#endif /* UMTX_OP_MUTEX_WAKE2 */
+
+abi_long freebsd_umtx_sem2_wait(abi_ulong obj, size_t tsz, void *t)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, obj, sizeof(struct target__usem2))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(obj, UMTX_OP_SEM2_WAIT, 1,
+        (void *)(uintptr_t)tsz, t);
+#else
+    struct target__usem2 *t__usem2;
+    uint32_t count, flags;
+    uint32_t *addr;
+    abi_long ret = 0;
+
+    if (!lock_user_struct(VERIFY_WRITE, t__usem2, obj, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    /*
+     * Make sure the count field has the has USEM_HAS_WAITERS flag set
+     * so userland will always call freebsd_umtx_sem2_wake().
+     */
+    for (;;) {
+        __get_user(count, &t__usem2->_count);
+        if (USEM_COUNT(count) != 0) {
+            unlock_user_struct(t__usem2, obj, 1);
+            return 0;
+        }
+        if ((count & USEM_HAS_WAITERS) != 0) {
+            break;
+        }
+        if (tcmpset_32(&t__usem2->_count, count, (count | USEM_HAS_WAITERS))) {
+            break;
+        }
+    }
+
+    __get_user(flags, &t__usem2->_flags);
+    addr = &t__usem2->_count;
+    unlock_user_struct(t__usem2, obj, 1);
+
+    if ((flags & USYNC_PROCESS_SHARED) == 0) {
+        DEBUG_UMTX("<WAIT SEM2> %s: _umtx_op(%p, %d, %p)\n",
+            __func__, addr, UMTX_OP_WAIT_UINT_PRIVATE, (int)tsz, t);
+
+#if DETECT_DEADLOCK
+        if (t != NULL) {
+            ret = _umtx_wait_uint_private(addr, tswap32(USEM_HAS_WAITERS), tsz,
+                t, __func__);
+        } else {
+            for (;;) {
+                struct timespec ts;
+
+                ts.tv_sec = 120;
+                ts.tv_nsec = 0;
+
+                ret = _umtx_wait_uint_private(addr, tswap32(USEM_HAS_WAITERS),
+                                              0, (void *)&ts, __func__);
+                if (ret == 0) {
+                    break;
+                }
+                if (ret != -ETIMEDOUT) {
+                    break;
+                }
+                if (!lock_user_struct(VERIFY_READ, t__usem2, obj, 1)) {
+                    return -TARGET_EFAULT;
+                }
+                __get_user(count, &t__usem2->_count);
+                unlock_user_struct(t__usem2, obj, 0);
+                if (USEM_COUNT(count) != 0) {
+                    fprintf(stderr, "QEMU:(%s) TIMEOUT (count!=0)\n", __func__);
+                    ret = 0;
+                    break;
+                }
+                if (ret == -ETIMEDOUT) {
+                    fprintf(stderr, "QEMU:(%s) TIMEOUT (exiting)\n", __func__);
+                    exit(-1);
+                }
+            }
+        }
+#else
+        ret = _umtx_wait_uint_private(addr, tswap32(USEM_HAS_WAITERS),
+                                      tsz, t, __func__);
+#endif /* DETECT_DEADLOCK */
+    } else {
+        DEBUG_UMTX("<WAIT SEM2> %s: _umtx_op(%p, %d, %p)\n",
+                   __func__, addr, UMTX_OP_WAIT_UINT, (int)tsz, t);
+#if DETECT_DEADLOCK
+        if (t != NULL) {
+            ret = _umtx_wait_uint(addr, tswap32(USEM_HAS_WAITERS), tsz, t,
+                                  __func__);
+        } else {
+            for (;;) {
+                struct timespec ts;
+
+                ts.tv_sec = 120;
+                ts.tv_nsec = 0;
+
+                ret = _umtx_wait_uint(addr, tswap32(USEM_HAS_WAITERS), 0,
+                                      (void *)&ts, __func__);
+                if (ret == 0) {
+                    break;
+                }
+                if (ret != -ETIMEDOUT) {
+                    break;
+                }
+                if (!lock_user_struct(VERIFY_READ, t__usem2, obj, 1)) {
+                    return -TARGET_EFAULT;
+                }
+                __get_user(count, &t__usem2->_count);
+                unlock_user_struct(t__usem2, obj, 0);
+                if (USEM_COUNT(count) != 0) {
+                    fprintf(stderr, "QEMU:(%s) TIMEOUT (count!=0)\n", __func__);
+                    ret = 0;
+                    break;
+                }
+                if (ret == -ETIMEDOUT) {
+                    fprintf(stderr, "QEMU:(%s) TIMEOUT (exiting)\n", __func__);
+                    exit(-1);
+                }
+            }
+        }
+#else
+        ret = _umtx_wait_uint(addr, tswap32(USEM_HAS_WAITERS), tsz, t,
+                              __func__);
+#endif /* DETECT_DEADLOCK */
+    }
+    return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_umtx_sem2_wake(abi_ulong obj)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_READ, obj, sizeof(struct target__usem2))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(obj, UMTX_OP_SEM2_WAKE, 1, NULL, NULL);
+#else
+    struct target__usem2 *t__usem2;
+    uint32_t *addr, flags;
+    abi_long ret;
+
+    if (!lock_user_struct(VERIFY_READ, t__usem2, obj, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(flags, &t__usem2->_flags);
+    addr = &t__usem2->_count;
+    unlock_user_struct(t__usem2, obj, 0);
+
+    if ((flags & USYNC_PROCESS_SHARED) == 0) {
+        DEBUG_UMTX("<WAKE SEM2> %s: _umtx_op(%p, %d, %d, NULL, NULL)\n",
+                   __func__,  addr, UMTX_OP_WAKE_PRIVATE, INT_MAX);
+        ret = get_errno(safe__umtx_op(addr, UMTX_OP_WAKE_PRIVATE, INT_MAX, NULL,
+                                      NULL));
+    } else {
+        DEBUG_UMTX("<WAKE SEM2> %s: _umtx_op(%p, %d, %d, NULL, NULL)\n",
+                   __func__,  addr, UMTX_OP_WAKE, INT_MAX);
+        ret = get_errno(safe__umtx_op(addr, UMTX_OP_WAKE, INT_MAX, NULL, NULL));
+    }
+
+    return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_umtx_sem_wait(abi_ulong obj, size_t tsz, void *t)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, obj, sizeof(struct target__usem))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(obj, UMTX_OP_SEM_WAIT, 1,
+        (void *)(uintptr_t)tsz, t);
+#else
+        struct target__usem *t__usem;
+        uint32_t count, flags, *addr;
+        abi_long ret;
+
+        if (!lock_user_struct(VERIFY_WRITE, t__usem, obj, 0)) {
+                return -TARGET_EFAULT;
+        }
+
+        __get_user(count, &t__usem->_count);
+        if (count != 0) {
+                unlock_user_struct(t__usem, obj, 1);
+                return 0;
+        }
+
+        /*
+         * Make sure the _has_waiters field is set so userland will always
+         * call freebsd_umtx_sem_wake().
+         */
+        __put_user(1, &t__usem->_has_waiters);
+
+        __get_user(flags, &t__usem->_flags);
+        addr = &t__usem->_count;
+        unlock_user_struct(t__usem, obj, 1);
+
+        if ((flags &  USYNC_PROCESS_SHARED) == 0) {
+            DEBUG_UMTX("<WAIT SEM> %s: _umtx_op(%p, %d, %d, NULL, NULL)\n",
+                       __func__,  &t__usem->_count, UMTX_OP_WAKE_PRIVATE, 0);
+            ret = _umtx_wait_uint_private(addr, 0, tsz, t, __func__);
+        } else {
+            DEBUG_UMTX("<WAIT SEM> %s: _umtx_op(%p, %d, %d, NULL, NULL)\n",
+                       __func__,  &t__usem->_count, UMTX_OP_WAKE, 0);
+            ret = _umtx_wait_uint(addr, 0, tsz, t, __func__);
+        }
+
+        return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_umtx_sem_wake(abi_ulong obj)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, obj, sizeof(struct target__usem))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(obj, UMTX_OP_SEM_WAKE, 1, NULL, NULL);
+#else
+    struct target__usem *t__usem;
+        uint32_t flags, *addr;
+        abi_long ret;
+
+        if (!lock_user_struct(VERIFY_READ, t__usem, obj, 1)) {
+                return -TARGET_EFAULT;
+        }
+        __get_user(flags, &t__usem->_flags);
+        addr = &t__usem->_count;
+        unlock_user_struct(t__usem, obj, 0);
+
+        if ((flags & USYNC_PROCESS_SHARED) == 0) {
+            DEBUG_UMTX("<WAKE SEM> %s: _umtx_op(%p, %d, %d, NULL, NULL)\n",
+                       __func__,  &t__usem->_count, UMTX_OP_WAKE_PRIVATE, 1);
+            ret = get_errno(safe__umtx_op(addr, UMTX_OP_WAKE_PRIVATE, 1, NULL,
+                                          NULL));
+        } else {
+            DEBUG_UMTX("<WAKE SEM> %s: _umtx_op(%p, %d, %d, NULL, NULL)\n",
+                       __func__,  &t__usem->_count, UMTX_OP_WAKE, 1);
+            ret = get_errno(safe__umtx_op(addr, UMTX_OP_WAKE, 1, NULL, NULL));
+        }
+
+        return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long t2h_freebsd_rtprio(struct rtprio *host_rtp, abi_ulong target_addr)
+{
+    struct target_freebsd_rtprio *target_rtp;
+
+    if (!lock_user_struct(VERIFY_READ, target_rtp, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_rtp->type, &target_rtp->type);
+    __get_user(host_rtp->prio, &target_rtp->prio);
+    unlock_user_struct(target_rtp, target_addr, 0);
+    return 0;
+}
+
+abi_long h2t_freebsd_rtprio(abi_ulong target_addr, struct rtprio *host_rtp)
+{
+    struct target_freebsd_rtprio *target_rtp;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rtp, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_rtp->type, &target_rtp->type);
+    __put_user(host_rtp->prio, &target_rtp->prio);
+    unlock_user_struct(target_rtp, target_addr, 1);
+    return 0;
+}
+
+/* XXX We should never see this? OP_LOCK and OP_UNLOCK are now RESERVED{0,1} */
+abi_long freebsd_lock_umtx(abi_ulong target_addr, abi_long id, size_t tsz,
+        void *t)
+{
+    abi_long ret;
+    abi_long owner;
+
+    gemu_log("This is unreachable.");
+
+    /*
+     * XXX Note that memory at umtx_addr can change and so we need to be
+     * careful and check for faults.
+     */
+    for (;;) {
+        struct target_umtx *target_umtx;
+
+        if (!lock_user_struct(VERIFY_WRITE, target_umtx, target_addr, 0)) {
+            return -TARGET_EFAULT;
+        }
+        /* Check the simple uncontested case. */
+        if (tcmpset_al(&target_umtx->u_owner,
+                TARGET_UMTX_UNOWNED, id)) {
+            unlock_user_struct(target_umtx, target_addr, 1);
+            return 0;
+        }
+        /* Check to see if the lock is contested but free. */
+        __get_user(owner, &target_umtx->u_owner);
+
+        if (TARGET_UMTX_CONTESTED == owner) {
+            if (tcmpset_al(&target_umtx->u_owner, TARGET_UMTX_CONTESTED,
+                        id | TARGET_UMTX_CONTESTED)) {
+                unlock_user_struct(target_umtx, target_addr, 1);
+                return 0;
+            }
+            /* We failed because it changed on us, restart. */
+            unlock_user_struct(target_umtx, target_addr, 1);
+            continue;
+        }
+
+        /* Set the contested bit and sleep. */
+        do {
+            __get_user(owner, &target_umtx->u_owner);
+            if (owner & TARGET_UMTX_CONTESTED) {
+                break;
+            }
+        } while (!tcmpset_al(&target_umtx->u_owner, owner,
+                    owner | TARGET_UMTX_CONTESTED));
+
+        __get_user(owner, &target_umtx->u_owner);
+        unlock_user_struct(target_umtx, target_addr, 1);
+
+        /* Byte swap, if needed, to match what is stored in user mem. */
+        owner = tswapal(owner);
+        DEBUG_UMTX("<WAIT> %s: _umtx_op(%p, %d, 0x%llx, NULL, NULL)\n",
+            __func__, g2h_untagged(target_addr), UMTX_OP_WAIT,
+            (long long)owner);
+        ret = _umtx_wait(g2h_untagged(target_addr), owner, tsz, t, __func__);
+        if (is_error(ret)) {
+            return ret;
+        }
+    }
+}
+
+/* XXX We should never see this? OP_LOCK and OP_UNLOCK are now RESERVED{0,1} */
+abi_long freebsd_unlock_umtx(abi_ulong target_addr, abi_long id)
+{
+    abi_ulong owner;
+    struct target_umtx *target_umtx;
+
+    gemu_log("This is unreachable.");
+    if (!lock_user_struct(VERIFY_WRITE, target_umtx, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(owner, &target_umtx->u_owner);
+    if ((owner & ~TARGET_UMTX_CONTESTED) != id) {
+        unlock_user_struct(target_umtx, target_addr, 1);
+        return -TARGET_EPERM;
+    }
+    /* Check the simple uncontested case. */
+    if ((owner & ~TARGET_UMTX_CONTESTED) == 0) {
+        if (tcmpset_al(&target_umtx->u_owner, owner,
+            TARGET_UMTX_UNOWNED)) {
+            unlock_user_struct(target_umtx, target_addr, 1);
+            return 0;
+        }
+    }
+    /* This is a contested lock. Unlock it. */
+    __put_user(TARGET_UMTX_UNOWNED, &target_umtx->u_owner);
+    unlock_user_struct(target_umtx, target_addr, 1);
+
+    /* Wake up all those contesting it. */
+    DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+            __func__, g2h_untagged(target_addr), UMTX_OP_WAKE, 0);
+    return get_errno(safe__umtx_op(g2h_untagged(target_addr),
+        QEMU_UMTX_OP(UMTX_OP_WAKE), 0, 0, 0));
+}
+
+abi_long freebsd_umtx_wake(abi_ulong target_addr, uint32_t n_wake)
+{
+
+    DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+            __func__, g2h_untagged(target_addr), UMTX_OP_WAKE, n_wake);
+    return get_errno(safe__umtx_op(g2h_untagged(target_addr),
+        QEMU_UMTX_OP(UMTX_OP_WAKE), n_wake, NULL, 0));
+}
+
+abi_long freebsd_umtx_wake_unsafe(abi_ulong target_addr, uint32_t n_wake)
+{
+
+    DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+            __func__, g2h_untagged(target_addr), UMTX_OP_WAKE, n_wake);
+    return get_errno(_umtx_op(g2h_untagged(target_addr),
+        QEMU_UMTX_OP(UMTX_OP_WAKE), n_wake, NULL, 0));
+}
+
+abi_long freebsd_umtx_mutex_wake(abi_ulong obj, abi_long val)
+{
+
+    DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%llx, NULL, NULL)\n",
+            __func__, g2h_untagged(obj), UMTX_OP_WAKE, (long long)val);
+    return get_errno(safe__umtx_op(g2h_untagged(obj),
+        QEMU_UMTX_OP(UMTX_OP_MUTEX_WAKE), val, NULL, NULL));
+}
+
+abi_long freebsd_lock_umutex(abi_ulong target_addr, uint32_t id,
+        void *ts, size_t tsz, int mode, abi_ulong val)
+{
+#ifdef _UMTX_OPTIMIZED
+    int op;
+
+    if (!access_ok(VERIFY_WRITE, target_addr, sizeof(struct target_umutex))) {
+        return -TARGET_EFAULT;
+    }
+
+    switch (mode) {
+    case TARGET_UMUTEX_WAIT:
+        op = UMTX_OP_MUTEX_WAIT;
+        DEBUG_UMTX("<MUTEX WAIT> %s: _umtx_op(%p, %d, 0x%llx, %p, %p)\n",
+                __func__, g2h_untagged(target_addr), op, (long long)val,
+                (void *)(uintptr_t)tsz, ts);
+        break;
+    case TARGET_UMUTEX_TRY:
+        op = UMTX_OP_MUTEX_TRYLOCK;
+        DEBUG_UMTX("<MUTEX TRYLOCK> %s: _umtx_op(%p, %d, 0x%llx, %p, %p)\n",
+                __func__, g2h_untagged(target_addr), op, (long long)val,
+                (void *)(uintptr_t)tsz, ts);
+        break;
+    default:
+        op = UMTX_OP_MUTEX_LOCK;
+        DEBUG_UMTX("<MUTEX LOCK> %s: _umtx_op(%p, %d, 0x%llx, %p, %p)\n",
+                __func__, g2h_untagged(target_addr), op, (long long)val,
+                (void *)(uintptr_t)tsz, ts);
+        break;
+    }
+
+    return optimized_umtx_op(target_addr, op, val, (void *)(uintptr_t)tsz, ts);
+#else
+    struct target_umutex *target_umutex;
+    uint32_t owner, flags, count, *addr;
+    int ret = 0;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_umutex, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    for (;;) {
+
+        __get_user(owner, &target_umutex->m_owner);
+
+        if ((owner & ~TARGET_UMUTEX_CONTESTED) == 0) {
+            /* Lock is unowned. */
+            if (TARGET_UMUTEX_WAIT == mode) {
+                /* Waiting on an unlocked mutex; bail out. */
+                unlock_user_struct(target_umutex, target_addr, 1);
+                return 0;
+            }
+
+            /* Attempt to acquire it, preserve the contested bit ("owner"). */
+            while ((owner & ~TARGET_UMUTEX_CONTESTED) == 0 &&
+                    !tcmpset_32(&target_umutex->m_owner, owner, owner | id)) {
+                __get_user(owner, &target_umutex->m_owner);
+            }
+
+            if ((owner & ~TARGET_UMUTEX_CONTESTED) == 0) {
+                /*
+                 * The acquire succeeded, because we didn't observe owner with
+                 * a different id.
+                 */
+                unlock_user_struct(target_umutex, target_addr, 1);
+                return 0;
+            }
+
+            /* Otherwise, someone beat us to it; carry on. */
+        }
+
+        __get_user(flags, &target_umutex->m_flags);
+        if ((flags & TARGET_UMUTEX_ERROR_CHECK) != 0 &&
+                (owner & ~TARGET_UMUTEX_CONTESTED) == id) {
+            unlock_user_struct(target_umutex, target_addr, 1);
+            return -TARGET_EDEADLK;
+        }
+
+        if (TARGET_UMUTEX_TRY == mode) {
+            unlock_user_struct(target_umutex, target_addr, 1);
+            return -TARGET_EBUSY;
+        }
+
+        /* Set the contested bit and sleep. */
+        while ((owner & TARGET_UMUTEX_CONTESTED) == 0) {
+            if (tcmpset_32(&target_umutex->m_owner, owner,
+                    owner | TARGET_UMUTEX_CONTESTED)) {
+                /*
+                 * Keep our local view of owner consistent with what we think
+                 * we've set it to.  We're about to sleep on it, and we don't
+                 * really want a spurious return from _umtx_op because of this.
+                 */
+                owner |= TARGET_UMUTEX_CONTESTED;
+
+                break;
+            } else {
+                __get_user(owner, &target_umutex->m_owner);
+            }
+        }
+
+        /*
+         * If it changed during the above loop, we may be able to acquire now.
+         */
+        if ((owner & ~TARGET_UMUTEX_CONTESTED) == 0) {
+            continue;
+        }
+
+        pthread_mutex_lock(&umtx_wait_lck);
+        __get_user(count, &target_umutex->m_count);
+        count++;
+        __put_user(count, &target_umutex->m_count);
+        pthread_mutex_unlock(&umtx_wait_lck);
+
+        addr = &target_umutex->m_owner;
+
+        /* addr used only as key below, not dereferenced */
+        unlock_user_struct(target_umutex, target_addr, 1);
+
+        DEBUG_UMTX("<WAIT UMUTEX> %s: _umtx_op(%p, %d, 0x%x, %d, %jx) "
+            "count = %d\n", __func__, g2h_untagged(target_addr),
+            UMTX_OP_WAIT_PRIVATE, tswap32(target_umutex->m_owner), tsz,
+            (uintmax_t)ts, count);
+        ret = _umtx_wait_uint_private(addr, owner, tsz, (void *)ts, __func__);
+
+        if (!lock_user_struct(VERIFY_WRITE, target_umutex, target_addr, 0)) {
+            return -TARGET_EFAULT;
+        }
+
+        pthread_mutex_lock(&umtx_wait_lck);
+        __get_user(count, &target_umutex->m_count);
+        count--;
+        __put_user(count, &target_umutex->m_count);
+        pthread_mutex_unlock(&umtx_wait_lck);
+        if (ret != 0) {
+            unlock_user_struct(target_umutex, target_addr, 1);
+            break;
+        }
+    }
+    return ret;
+#endif  /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_unlock_umutex(abi_ulong target_addr, uint32_t id)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_addr, sizeof(struct target_umutex))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_addr, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
+#else
+    struct target_umutex *target_umutex;
+    uint32_t count, owner, *addr, flags;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_umutex, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    /* Make sure we own this mutex. */
+    __get_user(owner, &target_umutex->m_owner);
+    if ((owner & ~TARGET_UMUTEX_CONTESTED) != id) {
+        unlock_user_struct(target_umutex, target_addr, 1);
+        return -TARGET_EPERM;
+    }
+    pthread_mutex_lock(&umtx_wait_lck);
+    __get_user(count, &target_umutex->m_count);
+
+    /* Unlock it; set the contested bit as needed. */
+    flags = TARGET_UMUTEX_UNOWNED;
+    if (count > 1) {
+        flags |= TARGET_UMUTEX_CONTESTED;
+    }
+    __put_user(flags, &target_umutex->m_owner);
+    pthread_mutex_unlock(&umtx_wait_lck);
+
+    addr = &target_umutex->m_owner;
+
+    /* addr is used only as a key, so we can unlock before we use it below */
+    unlock_user_struct(target_umutex, target_addr, 1);
+
+    /*
+     * And wake up any that may be contested it.  We used to only do this if the
+     * lock wasn't contested coming in, but that could have changed in the
+     * interim.  Unconditionally issue the wakeup, in conjunction with the
+     * previous change of owner this should catch all cases.
+     */
+    DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+        __func__, g2h_untagged(target_addr), UMTX_OP_WAKE, 0);
+    return get_errno(safe__umtx_op(addr, UMTX_OP_WAKE_PRIVATE, 1, NULL, NULL));
+#endif  /* _UMTX_OPTIMIZED */
+}
+
+/*
+ * wflags CVWAIT_CHECK_UNPARKING, CVWAIT_ABSTIME, CVWAIT_CLOCKID
+ */
+abi_long freebsd_cv_wait(abi_ulong target_ucond_addr,
+        abi_ulong target_umtx_addr, struct timespec *ts, int wflags)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_ucond_addr,
+        sizeof(struct target_ucond))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_ucond_addr, UMTX_OP_CV_WAIT, wflags,
+        g2h_untagged(target_umtx_addr), ts);
+#else
+    abi_long ret;
+    long tid;
+    struct target_ucond *target_ucond;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ucond, target_ucond_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    /* Check the clock ID if needed. */
+    if ((wflags & TARGET_CVWAIT_CLOCKID) != 0) {
+        uint32_t clockid;
+
+        __get_user(clockid, &target_ucond->c_clockid);
+        if (clockid >= CLOCK_THREAD_CPUTIME_ID) {
+            /* Only HW clock id will work. */
+            unlock_user_struct(target_ucond, target_ucond_addr, 1);
+            return -TARGET_EINVAL;
+        }
+    }
+
+    thr_self(&tid);
+
+    /* Lock the _cv_mutex so we can safely unlock the user mutex */
+    safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_LOCK, 0, NULL, NULL);
+
+    /* Set c_has_waiters before releasing the user mutex! */
+    __put_user(1, &target_ucond->c_has_waiters);
+
+    /* unlock the user mutex */
+    ret = freebsd_unlock_umutex(target_umtx_addr, tid);
+    if (is_error(ret)) {
+        safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
+        unlock_user_struct(target_ucond, target_ucond_addr, 1);
+        return ret;
+    }
+
+    /* UMTX_OP_CV_WAIT unlocks _cv_mutex */
+    DEBUG_UMTX("<CV_WAIT> %s: _umtx_op(%p, %d, 0x%x, %p, NULL)\n",
+        __func__, g2h_untagged(target_ucond_addr), UMTX_OP_CV_WAIT, wflags,
+        &_cv_mutex);
+    ret = safe__umtx_op(g2h_untagged(target_ucond_addr), UMTX_OP_CV_WAIT,
+                        wflags, &_cv_mutex, ts);
+
+    if (is_error(ret)) {
+        safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
+        unlock_user_struct(target_ucond, target_ucond_addr, 1);
+        return ret;
+    }
+    ret = freebsd_lock_umutex(target_umtx_addr, tid, NULL, 0, TARGET_UMUTEX_TRY,
+        0);
+    safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
+    unlock_user_struct(target_ucond, target_ucond_addr, 1);
+
+    return ret;
+#endif  /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_cv_signal(abi_ulong target_ucond_addr)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_ucond_addr,
+        sizeof(struct target_ucond))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_ucond_addr, UMTX_OP_CV_SIGNAL, 0, NULL,
+        NULL);
+#else
+    abi_long ret;
+
+    if (!access_ok(VERIFY_WRITE, target_ucond_addr,
+                sizeof(struct target_ucond))) {
+        return -TARGET_EFAULT;
+    }
+
+    /* Lock the _cv_mutex to prevent a race in do_cv_wait(). */
+    safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_LOCK, 0, NULL, NULL);
+    DEBUG_UMTX("<CV_SIGNAL> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+            __func__, g2h_untagged(target_ucond_addr), UMTX_OP_CV_SIGNAL, 0);
+    ret = get_errno(safe__umtx_op(g2h_untagged(target_ucond_addr),
+                                  UMTX_OP_CV_SIGNAL, 0, NULL, NULL));
+    safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
+
+    return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_cv_broadcast(abi_ulong target_ucond_addr)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_ucond_addr,
+        sizeof(struct target_ucond))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_ucond_addr, UMTX_OP_CV_BROADCAST, 0, NULL,
+        NULL);
+#else
+    int ret;
+
+    if (!access_ok(VERIFY_WRITE, target_ucond_addr,
+                sizeof(struct target_ucond))) {
+        return -TARGET_EFAULT;
+    }
+
+    /* Lock the _cv_mutex to prevent a race in do_cv_wait(). */
+    safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_LOCK, 0, NULL, NULL);
+    DEBUG_UMTX("<CV_BROADCAST> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+        __func__, g2h_untagged(target_ucond_addr), UMTX_OP_CV_BROADCAST, 0);
+    ret = get_errno(safe__umtx_op(g2h_untagged(target_ucond_addr),
+                                  UMTX_OP_CV_BROADCAST, 0, NULL, NULL));
+    safe__umtx_op(&_cv_mutex, UMTX_OP_MUTEX_UNLOCK, 0, NULL, NULL);
+
+    return ret;
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag, size_t tsz,
+        void *t)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_addr, sizeof(struct target_urwlock))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_addr, UMTX_OP_RW_RDLOCK, fflag,
+        (void *)(uintptr_t)tsz, t);
+#else
+    struct target_urwlock *target_urwlock;
+    uint32_t flags, wrflags;
+    uint32_t state;
+    uint32_t blocked_readers;
+    abi_long ret;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(flags, &target_urwlock->rw_flags);
+    wrflags = TARGET_URWLOCK_WRITE_OWNER;
+    if (!(fflag & TARGET_URWLOCK_PREFER_READER) &&
+            !(flags & TARGET_URWLOCK_PREFER_READER)) {
+        wrflags |= TARGET_URWLOCK_WRITE_WAITERS;
+    }
+    for (;;) {
+        __get_user(state, &target_urwlock->rw_state);
+        /* try to lock it */
+        while (!(state & wrflags)) {
+            if (TARGET_URWLOCK_READER_COUNT(state) ==
+                TARGET_URWLOCK_MAX_READERS) {
+                unlock_user_struct(target_urwlock,
+                    target_addr, 1);
+                return -TARGET_EAGAIN;
+            }
+            if (tcmpset_32(&target_urwlock->rw_state, state,
+                (state + 1))) {
+                /* The acquired succeeded. */
+                unlock_user_struct(target_urwlock,
+                    target_addr, 1);
+                return 0;
+            }
+            __get_user(state, &target_urwlock->rw_state);
+        }
+        /* set read contention bit */
+        if (!tcmpset_32(&target_urwlock->rw_state, state,
+            state | TARGET_URWLOCK_READ_WAITERS)) {
+            /* The state has changed.  Start over. */
+            continue;
+        }
+
+        /* contention bit is set, increase read waiter count */
+        __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
+        while (!tcmpset_32(&target_urwlock->rw_blocked_readers,
+                    blocked_readers, blocked_readers + 1)) {
+            __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
+        }
+
+        ret = 0;
+        while (state & wrflags) {
+            /* sleep/wait */
+            unlock_user_struct(target_urwlock, target_addr, 1);
+            DEBUG_UMTX("<WAIT> %s: _umtx_op(%p, %d, 0x%x (0x%x), NULL, NULL)\n",
+                    __func__, &target_urwlock->rw_state,
+                    UMTX_OP_WAIT_UINT, tswap32(state),
+                    target_urwlock->rw_state);
+            ret = _umtx_wait_uint(&target_urwlock->rw_state, tswap32(state),
+                    tsz, t, __func__);
+            if (is_error(ret)) {
+                if (!lock_user_struct(VERIFY_WRITE, target_urwlock,
+                                      target_addr, 0)) {
+                    return ret;
+                }
+                goto rdlock_decrement;
+            }
+            if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr,
+                        0)) {
+                return -TARGET_EFAULT;
+            }
+            __get_user(state, &target_urwlock->rw_state);
+        }
+
+        /* decrease read waiter count */
+rdlock_decrement:
+        __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
+        while (!tcmpset_32(&target_urwlock->rw_blocked_readers,
+                    blocked_readers, (blocked_readers - 1))) {
+            __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
+        }
+        if (blocked_readers == 1) {
+            /* clear read contention bit */
+            __get_user(state, &target_urwlock->rw_state);
+            while (!tcmpset_32(&target_urwlock->rw_state, state,
+                state & ~TARGET_URWLOCK_READ_WAITERS)) {
+                __get_user(state, &target_urwlock->rw_state);
+            }
+        }
+        if (is_error(ret)) {
+            /* tcmpset_32 operates on the target memory, so don't double copy */
+            unlock_user_struct(target_urwlock, target_addr, 0);
+            return ret;
+        }
+    }
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag, size_t tsz,
+        void *t)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_addr, sizeof(struct target_urwlock))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_addr, UMTX_OP_RW_WRLOCK, fflag,
+        (void *)(uintptr_t)tsz, t);
+#else
+    struct target_urwlock *target_urwlock;
+    uint32_t blocked_readers, blocked_writers;
+    uint32_t state;
+    abi_long ret;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    blocked_readers = 0;
+    for (;;) {
+        __get_user(state, &target_urwlock->rw_state);
+        while (!(state & TARGET_URWLOCK_WRITE_OWNER) &&
+            TARGET_URWLOCK_READER_COUNT(state) == 0) {
+            if (tcmpset_32(&target_urwlock->rw_state, state,
+                        state | TARGET_URWLOCK_WRITE_OWNER)) {
+                unlock_user_struct(target_urwlock, target_addr, 1);
+                return 0;
+            }
+            __get_user(state, &target_urwlock->rw_state);
+        }
+
+        if (!(state & (TARGET_URWLOCK_WRITE_OWNER |
+                        TARGET_URWLOCK_WRITE_WAITERS)) &&
+                blocked_readers != 0) {
+            DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+                __func__, &target_urwlock->rw_state, UMTX_OP_WAKE,
+                tswap32(state));
+            ret = get_errno(safe__umtx_op(&target_urwlock->rw_state,
+                UMTX_OP_WAKE, INT_MAX, NULL, NULL));
+            unlock_user_struct(target_urwlock, target_addr, ret == 0);
+            return ret;
+        }
+        /* re-read the state */
+        __get_user(state, &target_urwlock->rw_state);
+
+        /* and set TARGET_URWLOCK_WRITE_WAITERS */
+        while (((state & TARGET_URWLOCK_WRITE_OWNER) ||
+                    TARGET_URWLOCK_READER_COUNT(state) != 0) &&
+                (state & TARGET_URWLOCK_WRITE_WAITERS) == 0) {
+            if (tcmpset_32(&target_urwlock->rw_state, state,
+                        state | TARGET_URWLOCK_WRITE_WAITERS)) {
+                break;
+            }
+            __get_user(state, &target_urwlock->rw_state);
+        }
+
+        /* contention bit is set, increase write waiter count */
+        __get_user(blocked_writers, &target_urwlock->rw_blocked_writers);
+        while (!tcmpset_32(&target_urwlock->rw_blocked_writers,
+                    blocked_writers, blocked_writers + 1)) {
+            __get_user(blocked_writers, &target_urwlock->rw_blocked_writers);
+        }
+
+        /* sleep */
+        ret = 0;
+        while ((state & TARGET_URWLOCK_WRITE_OWNER) ||
+                (TARGET_URWLOCK_READER_COUNT(state) != 0)) {
+            unlock_user_struct(target_urwlock, target_addr, 1);
+            DEBUG_UMTX("<WAIT> %s: _umtx_op(%p, %d, 0x%x(0x%x), NULL, NULL)\n",
+                    __func__, &target_urwlock->rw_blocked_writers,
+                    UMTX_OP_WAIT_UINT, tswap32(state),
+                    target_urwlock->rw_state);
+            ret = _umtx_wait_uint(&target_urwlock->rw_state,
+                        tswap32(state), tsz, t, __func__);
+            if (is_error(ret)) {
+                if (!lock_user_struct(VERIFY_WRITE, target_urwlock,
+                                      target_addr, 0)) {
+                    return ret;
+                }
+                goto wrlock_decrement;
+            }
+            if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr,
+                        0)) {
+                return -TARGET_EFAULT;
+            }
+            __get_user(state, &target_urwlock->rw_state);
+        }
+
+        /* decrease the write waiter count */
+wrlock_decrement:
+        __get_user(blocked_writers, &target_urwlock->rw_blocked_writers);
+        while (!tcmpset_32(&target_urwlock->rw_blocked_writers,
+                    blocked_writers, (blocked_writers - 1))) {
+            __get_user(blocked_writers, &target_urwlock->rw_blocked_writers);
+        }
+        if (blocked_writers == 1) {
+            /* clear write contention bit */
+            __get_user(state, &target_urwlock->rw_state);
+            while (!tcmpset_32(&target_urwlock->rw_state, state,
+                        state & ~TARGET_URWLOCK_WRITE_WAITERS)) {
+                __get_user(state, &target_urwlock->rw_state);
+            }
+            __get_user(blocked_readers, &target_urwlock->rw_blocked_readers);
+        } else {
+            blocked_readers = 0;
+        }
+        if (is_error(ret)) {
+            /* tcmpset_32 operates on the target memory, so don't double copy */
+            unlock_user_struct(target_urwlock, target_addr, 0);
+            return ret;
+        }
+    }
+#endif /* _UMTX_OPTIMIZED */
+}
+
+abi_long freebsd_rw_unlock(abi_ulong target_addr)
+{
+#ifdef _UMTX_OPTIMIZED
+    if (!access_ok(VERIFY_WRITE, target_addr, sizeof(struct target_urwlock))) {
+        return -TARGET_EFAULT;
+    }
+
+    return optimized_umtx_op(target_addr, UMTX_OP_RW_UNLOCK, 0, NULL, NULL);
+#else
+    struct target_urwlock *target_urwlock;
+    uint32_t flags, state, count = 0;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_urwlock, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    __get_user(flags, &target_urwlock->rw_flags);
+    __get_user(state, &target_urwlock->rw_state);
+
+    if (state & TARGET_URWLOCK_WRITE_OWNER) {
+        for (;;) {
+            if (!tcmpset_32(&target_urwlock->rw_state, state,
+                state & ~TARGET_URWLOCK_WRITE_OWNER)) {
+                /*
+                 * Update the state here because we want to make sure that
+                 * another thread didn't unste the flag from underneath us.
+                 * If they did, we throw EPERM as the kernel does.
+                 */
+                __get_user(state, &target_urwlock->rw_state);
+                if (!(state & TARGET_URWLOCK_WRITE_OWNER)) {
+                    unlock_user_struct(target_urwlock, target_addr, 1);
+                    return -TARGET_EPERM;
+                }
+            } else {
+                break;
+            }
+        }
+    } else if (TARGET_URWLOCK_READER_COUNT(state) != 0) {
+        /* decrement reader count */
+        for (;;) {
+            if (!tcmpset_32(&target_urwlock->rw_state, state, (state  - 1))) {
+                /*
+                 * Just as in the branch above; we update the state here because
+                 * we want to make sure the reader count didn't hit 0 while we
+                 * are still trying to decrement this. The kernel also returns
+                 * EPERM here.
+                 */
+                __get_user(state, &target_urwlock->rw_state);
+                if (TARGET_URWLOCK_READER_COUNT(state) == 0) {
+                    unlock_user_struct(target_urwlock, target_addr, 1);
+                    return -TARGET_EPERM;
+                 }
+            } else {
+                break;
+            }
+        }
+    } else {
+        unlock_user_struct(target_urwlock, target_addr, 1);
+        return -TARGET_EPERM;
+    }
+
+    if (!(flags & TARGET_URWLOCK_PREFER_READER)) {
+        if (state & TARGET_URWLOCK_WRITE_WAITERS) {
+            count = 1;
+        } else if (state & TARGET_URWLOCK_READ_WAITERS) {
+            count = INT_MAX;
+        }
+    } else {
+        if (state & TARGET_URWLOCK_READ_WAITERS) {
+            count = INT_MAX;
+        } else if (state & TARGET_URWLOCK_WRITE_WAITERS) {
+            count = 1;
+        }
+    }
+
+    /* rw_state used below as key only */
+    unlock_user_struct(target_urwlock, target_addr, 1);
+    if (count != 0) {
+        DEBUG_UMTX("<WAKE> %s: _umtx_op(%p, %d, 0x%x, NULL, NULL)\n",
+                __func__, &target_urwlock->rw_state, UMTX_OP_WAKE, count);
+        return get_errno(safe__umtx_op(&target_urwlock->rw_state, UMTX_OP_WAKE,
+                    count, NULL, NULL));
+    } else {
+        return 0;
+    }
+#endif  /* _UMTX_OPTIMIZED */
+}
+
+abi_long
+freebsd_umtx_shm(abi_ulong target_addr, long fflag)
+{
+
+    return get_errno(safe__umtx_op(NULL, QEMU_UMTX_OP(UMTX_OP_SHM), fflag,
+        g2h_untagged(target_addr), NULL));
+}
+
+abi_long
+freebsd_umtx_robust_list(abi_ulong target_addr, size_t rbsize)
+{
+#ifdef _UMTX_OPTIMIZED
+    struct target_umtx_robust_lists_params *tparams;
+    struct umtx_robust_lists_params hparams;
+    abi_long error;
+
+    if (rbsize < sizeof(*tparams)) {
+        return -TARGET_EINVAL;
+    }
+
+    if (!lock_user_struct(VERIFY_READ, tparams, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    hparams.robust_list_offset =
+        (uintptr_t)g2h_untagged(tparams->robust_list_offset);
+    hparams.robust_priv_list_offset =
+        (uintptr_t)g2h_untagged(tparams->robust_priv_list_offset);
+    hparams.robust_inact_offset =
+        (uintptr_t)g2h_untagged(tparams->robust_inact_offset);
+
+    error = optimized_umtx_op(0, UMTX_OP_ROBUST_LISTS, sizeof(hparams),
+        &hparams, NULL);
+    unlock_user_struct(tparams, target_addr, 0);
+    return error;
+#else
+    gemu_log("safe__umtx_op(..., UMTX_OP_ROBUST_LISTS. ...)  not supported\n");
+    return -TARGET_EOPNOTSUPP;
+#endif
+}
+
+abi_long do_freebsd_thr_new(CPUArchState *env,
+        abi_ulong target_param_addr, int32_t param_size)
+{
+    new_freebsd_thread_info_t info;
+    pthread_attr_t attr;
+    TaskState *ts;
+    CPUArchState *new_env;
+    CPUState *new_cpu;
+    struct target_freebsd_thr_param *target_param;
+    abi_ulong target_rtp_addr;
+    struct target_freebsd_rtprio *target_rtp;
+    struct rtprio *rtp_ptr, rtp;
+    CPUState *cpu = env_cpu(env);
+    TaskState *parent_ts = (TaskState *)cpu->opaque;
+    sigset_t sigmask;
+    struct sched_param sched_param;
+    int sched_policy;
+    int ret = 0;
+
+    memset(&info, 0, sizeof(info));
+
+    if (!lock_user_struct(VERIFY_READ, target_param, target_param_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    info.param.start_func = tswapal(target_param->start_func);
+    info.param.arg = tswapal(target_param->arg);
+    info.param.stack_base = tswapal(target_param->stack_base);
+    info.param.stack_size = tswapal(target_param->stack_size);
+    info.param.tls_base = tswapal(target_param->tls_base);
+    info.param.tls_size = tswapal(target_param->tls_size);
+    info.param.child_tid = tswapal(target_param->child_tid);
+    info.param.parent_tid = tswapal(target_param->parent_tid);
+    info.param.flags = tswap32(target_param->flags);
+    target_rtp_addr = info.param.rtp = tswapal(target_param->rtp);
+    unlock_user_struct(target_param, target_param_addr, 0);
+
+    thr_self(&info.parent_tid);
+
+    if (target_rtp_addr) {
+        if (!lock_user_struct(VERIFY_READ, target_rtp, target_rtp_addr, 1)) {
+            return -TARGET_EFAULT;
+        }
+        rtp.type = tswap16(target_rtp->type);
+        rtp.prio = tswap16(target_rtp->prio);
+        unlock_user_struct(target_rtp, target_rtp_addr, 0);
+        rtp_ptr = &rtp;
+    } else {
+        rtp_ptr = NULL;
+    }
+
+    /* Create a new CPU instance. */
+    ts = g_malloc0(sizeof(TaskState));
+    init_task_state(ts);
+
+    /* Grab a mutex so that thread setup appears atomic. */
+    pthread_mutex_lock(new_freebsd_thread_lock_ptr);
+
+    /*
+     * If this is our first additional thread, we need to ensure we
+     * generate code for parallel execution and flush old translations.
+     * Do this now so that the copy gets CF_PARALLEL too.
+     */
+    if (!(cpu->tcg_cflags & CF_PARALLEL)) {
+        cpu->tcg_cflags |= CF_PARALLEL;
+        tb_flush__exclusive_or_serial();
+    }
+
+    new_env = cpu_copy(env);
+
+    new_cpu = env_cpu(new_env);
+    new_cpu->opaque = ts;
+    ts->bprm = parent_ts->bprm;
+    ts->info = parent_ts->info;
+    ts->signal_mask = parent_ts->signal_mask;
+    ts->ts_tid = qemu_get_thread_id();
+
+    pthread_mutex_init(&info.mutex, NULL);
+    pthread_mutex_lock(&info.mutex);
+    pthread_cond_init(&info.cond, NULL);
+    info.env = new_env;
+
+    /* XXX check return values... */
+    pthread_attr_init(&attr);
+    pthread_attr_setstacksize(&attr, NEW_STACK_SIZE);
+    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+    if (rtp_ptr) {
+        rtp_to_schedparam(&rtp, &sched_policy, &sched_param);
+        pthread_attr_setschedpolicy(&attr, sched_policy);
+        pthread_attr_setschedparam(&attr, &sched_param);
+    }
+
+    /*
+     * It is not safe to deliver signals until the child has finished
+     * initializing, so temporarily block all signals.
+     */
+    sigfillset(&sigmask);
+    sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+
+    ret = pthread_create(&info.thread, &attr, new_freebsd_thread_start, &info);
+
+    sigprocmask(SIG_SETMASK, &info.sigmask, NULL);
+    pthread_attr_destroy(&attr);
+    if (ret == 0) {
+        /* Wait for the child to initialize. */
+        pthread_cond_wait(&info.cond, &info.mutex);
+    } else {
+        /* Creation of new thread failed. */
+        object_unparent(OBJECT(new_cpu));
+        object_unref(OBJECT(new_cpu));
+        g_free(ts);
+        ret = -host_to_target_errno(ret);
+    }
+
+    pthread_mutex_unlock(&info.mutex);
+    pthread_cond_destroy(&info.cond);
+    pthread_mutex_destroy(&info.mutex);
+    pthread_mutex_unlock(new_freebsd_thread_lock_ptr);
+
+    return ret;
+}
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index d3f1f01b13..4258b24095 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -240,5 +240,357 @@ static inline abi_long do_freebsd_swapcontext(CPUArchState *env, abi_ulong arg1,
  * undocumented _umtx_op(void *obj, int op, u_long val, void *uaddr,
  *                           void *target_time);
  */
+static inline abi_long do_freebsd__umtx_op(abi_ulong obj, int op, abi_ulong val,
+        abi_ulong uaddr, abi_ulong target_time)
+{
+    abi_long ret;
+#ifndef _UMTX_OPTIMIZED
+    struct _umtx_time ut[2];
+    struct timespec ts;
+    size_t utsz;
+    long tid;
+#endif
+
+    switch (op) {
+    case TARGET_UMTX_OP_WAIT:
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_wait(obj, val, uaddr,
+                                safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_wait(obj, tswapal(val), utsz, &ut);
+        } else {
+            ret = freebsd_umtx_wait(obj, tswapal(val), 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_WAKE:
+        /* args: obj *, nr_wakeup */
+        ret = freebsd_umtx_wake(obj, val);
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_LOCK:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_lock_umutex(obj, 0, safe_g2h_untagged(target_time), uaddr,
+                                  0, val);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_lock_umutex(obj, tid, ut, utsz, 0, tswapal(val));
+        } else {
+            ret = freebsd_lock_umutex(obj, tid, NULL, 0, 0, tswapal(val));
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_UNLOCK:
+#ifdef _UMTX_OPTIMIZED
+        ret = freebsd_unlock_umutex(obj, 0);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = freebsd_unlock_umutex(obj, tid);
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_TRYLOCK:
+#ifdef _UMTX_OPTIMIZED
+        ret = freebsd_lock_umutex(obj, 0, NULL, 0, TARGET_UMUTEX_TRY, val);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = freebsd_lock_umutex(obj, tid, NULL, 0, TARGET_UMUTEX_TRY,
+            tswapal(val));
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_WAIT:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_lock_umutex(obj, 0, safe_g2h_untagged(target_time), uaddr,
+            TARGET_UMUTEX_WAIT, val);
+#else
+        ret = get_errno(thr_self(&tid));
+        if (is_error(ret)) {
+            return ret;
+        }
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_lock_umutex(obj, tid, ut, utsz, TARGET_UMUTEX_WAIT,
+                tswapal(val));
+        } else {
+            ret = freebsd_lock_umutex(obj, tid, NULL, 0, TARGET_UMUTEX_WAIT,
+                tswapal(val));
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_MUTEX_WAKE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_mutex_wake(obj, val);
+        break;
+
+    case TARGET_UMTX_OP_SET_CEILING:
+        ret = 0; /* XXX quietly ignore these things for now */
+        break;
+
+    case TARGET_UMTX_OP_CV_WAIT:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_cv_wait(obj, uaddr, safe_g2h_untagged(target_time), val);
+#else
+        /*
+         * Initialization of the struct conv is done by
+         * bzero'ing everything in userland.
+         */
+        if (target_time != 0) {
+            if (t2h_freebsd_timespec(&ts, target_time)) {
+                return -TARGET_EFAULT;
+            }
+            ret = freebsd_cv_wait(obj, uaddr, &ts, val);
+        } else {
+            ret = freebsd_cv_wait(obj, uaddr, NULL, val);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_CV_SIGNAL:
+        /*
+         * XXX
+         * User code may check if c_has_waiters is zero.  Other
+         * than that it is assume that user code doesn't do
+         * much with the struct conv fields and is pretty
+         * much opauque to userland.
+         */
+        ret = freebsd_cv_signal(obj);
+        break;
+
+    case TARGET_UMTX_OP_CV_BROADCAST:
+        /*
+         * XXX
+         * User code may check if c_has_waiters is zero.  Other
+         * than that it is assume that user code doesn't do
+         * much with the struct conv fields and is pretty
+         * much opauque to userland.
+         */
+        ret = freebsd_cv_broadcast(obj);
+        break;
+
+    case TARGET_UMTX_OP_WAIT_UINT:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_wait_uint(obj, val, uaddr,
+                                     safe_g2h_untagged(target_time));
+#else
+        if (!access_ok(VERIFY_READ, obj, sizeof(abi_ulong))) {
+            return -TARGET_EFAULT;
+        }
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_wait_uint(obj, tswap32((uint32_t)val),
+                                         utsz, &ut);
+        } else {
+            ret = freebsd_umtx_wait_uint(obj, tswap32((uint32_t)val), 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_WAIT_UINT_PRIVATE:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_wait_uint_private(obj, val, uaddr,
+            safe_g2h_untagged(target_time));
+#else
+        if (!access_ok(VERIFY_READ, obj, sizeof(abi_ulong))) {
+            return -TARGET_EFAULT;
+        }
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_wait_uint_private(obj, tswap32((uint32_t)val),
+                    utsz, &ut);
+        } else {
+            ret = freebsd_umtx_wait_uint_private(obj, tswap32((uint32_t)val),
+                    0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_WAKE_PRIVATE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_wake_private(obj, val);
+        break;
+
+    case TARGET_UMTX_OP_RW_RDLOCK:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_rw_rdlock(obj, val, uaddr,
+                                safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_rw_rdlock(obj, val, utsz, &ut);
+        } else {
+            ret = freebsd_rw_rdlock(obj, val, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_RW_WRLOCK:
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_rw_wrlock(obj, val, uaddr,
+                                safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_rw_wrlock(obj, val, utsz, &ut);
+        } else {
+            ret = freebsd_rw_wrlock(obj, val, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_RW_UNLOCK:
+        ret = freebsd_rw_unlock(obj);
+        break;
+
+#ifdef UMTX_OP_MUTEX_WAKE2
+    case TARGET_UMTX_OP_MUTEX_WAKE2:
+        ret = freebsd_umtx_mutex_wake2(obj, val);
+        break;
+#endif /* UMTX_OP_MUTEX_WAKE2 */
+
+#ifdef UMTX_OP_NWAKE_PRIVATE
+    case TARGET_UMTX_OP_NWAKE_PRIVATE:
+        ret = freebsd_umtx_nwake_private(obj, val);
+        break;
+#endif /* UMTX_OP_NWAKE_PRIVATE */
+
+    case TARGET_UMTX_OP_SEM2_WAIT:
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(
+            (uaddr > sizeof(struct target_freebsd__umtx_time) ? VERIFY_WRITE :
+             VERIFY_READ), target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_sem2_wait(obj, uaddr,
+                                     safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            /* Kernel writes out the ut[1] if utsz >= _umtx_time + timespec. */
+            ret = freebsd_umtx_sem2_wait(obj, utsz, ut);
+            if (ret == -TARGET_EINTR && (ut[0]._flags & UMTX_ABSTIME) == 0 &&
+                utsz >= sizeof(struct target_freebsd__umtx_time) +
+                sizeof(struct target_freebsd_timespec)) {
+                abi_ulong cret;
+
+                cret = h2t_freebsd_timespec(target_time +
+                    sizeof(struct target_freebsd__umtx_time), &ut[1]._timeout);
+                if (is_error(cret)) {
+                    ret = cret;
+                }
+            }
+        } else {
+            ret = freebsd_umtx_sem2_wait(obj, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_SEM2_WAKE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_sem2_wake(obj);
+        break;
+    case TARGET_UMTX_OP_SEM_WAIT:
+        /* args: obj *, val, (void *)sizeof(ut), ut * */
+#ifdef _UMTX_OPTIMIZED
+        if (target_time != 0 && !access_ok(VERIFY_READ, target_time, uaddr)) {
+            return -TARGET_EFAULT;
+        }
+        ret = freebsd_umtx_sem_wait(obj, uaddr, safe_g2h_untagged(target_time));
+#else
+        if (target_time != 0) {
+            ret = t2h_freebsd_umtx_time(target_time, uaddr, ut, &utsz);
+            if (is_error(ret)) {
+                return ret;
+            }
+            ret = freebsd_umtx_sem_wait(obj, utsz, ut);
+        } else {
+            ret = freebsd_umtx_sem_wait(obj, 0, NULL);
+        }
+#endif
+        break;
+
+    case TARGET_UMTX_OP_SEM_WAKE:
+        /* Don't need to do access_ok(). */
+        ret = freebsd_umtx_sem_wake(obj);
+        break;
+    case TARGET_UMTX_OP_SHM:
+        ret = freebsd_umtx_shm(uaddr, val);
+        break;
+    case TARGET_UMTX_OP_ROBUST_LISTS:
+        ret = freebsd_umtx_robust_list(uaddr, val);
+        break;
+    default:
+        return -TARGET_EINVAL;
+    }
+    return ret;
+}
 
 #endif /* FREEBSD_OS_THREAD_H */

-- 
2.52.0


