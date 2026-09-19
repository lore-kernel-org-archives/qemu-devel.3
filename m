Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8768C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yGD-00041P-7t; Sat, 19 Sep 2026 12:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFi-0003UL-Nu
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:28 -0400
Received: from mail-oo2-x0f.google.com ([2607:f8b0:4864:31::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFg-0008Ov-Bl
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:26 -0400
Received: by mail-oo2-x0f.google.com with SMTP id
 006d021491bc7-6b1ae6f1635so631048eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836563; x=1790441363;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m6HuqtOac4hCxmmGEz1goJPq/1bZlzLbLWZw2Cnvmg4=;
 b=AOGrUqP+Wlvx3xomRsZuMVt+mwu2SVAiH+SGbjdowjpyubQHehBBZYOw0D4Yce20ZD
 uKCV1NZlOFXwqrhCsKufr1OQaa1N4gLZxwwoa9hXh2uL0oMyJqqeYgDda9BIwGXitpCE
 tEo0bd5EQGS107P+XwHCMnptwAsusXN0Gdojc3Pnh0Z6XXyZEBb5s869JlO51qiRpsVc
 ejGBOiOBnfwRPOkOmm/h3hYySKIxvJpYVI+3ZDhqCmezTT+fLoGUcPzCBK4O2N97GxCg
 2jUzWAwJCC0fRAbhF1miORCtz3A/dEUseLuJMNEOc+F2zsilmhWhuYogSdfOkmEXcBum
 jSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836563; x=1790441363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m6HuqtOac4hCxmmGEz1goJPq/1bZlzLbLWZw2Cnvmg4=;
 b=ai9+eFeyq/Ywd8LFGr2uzF6GWZa5p3GXx5A76k1PffdUFFvaUbTO3hJbJk1kJJhMwN
 WIlkEj4R31TbBPzYd8yVRVqX1q2NemjQtR3n4HoyAmKu4NDIG7JROjP1KoSYJSYBl4hi
 h6s3ahBfcrf7ga/7MQfu6TeUYw8qHxUveJwEnH8gxcPNWl1RC8eTnRh1zrwgxAgDngJj
 Fv5ESmeA7z313WoLffCHLP2IUz4WqcfEmt74+8S+MlNpAJOdwUTKUnwckjawTL6EZPer
 stvXRdIQ+Dm+INcVsJkG27QIa5V2335hn/kWemrynDDxEssxwwLW4MLIsLnPcQ3vUdu5
 iSAg==
X-Gm-Message-State: AFuF++kY9pGmRNG+6gW4GclcORIwl8jWMOvXo8rdFLQNtGySDkFRwfY6
 zRvEU5x63+PQfd4fcVYzD7dj2zr1+Z7a38Mz+sHTkCoDaP90jYo6beBavtDhACMy0I+SYsZlagQ
 8YQkfQEM=
X-Gm-Gg: AYBFou1L8pCQICr3JTi9Rbn2+WcUXEMDKia3NpSGem/hcuZg6LDKeHU/7057FtuLUDw
 ozuhf73nFEn8ZjDr9Van9OADF8FEieYjS93w5Qpc7pE87KzfepieFS4MWMxAQDmwMBZeJKgGAku
 G71u/6F0QxftodsxT5ZSI/nNKFC30OmcL+3pFrWUR7rAR8LvwKjkhGGXF/2jzhHcOkUlJSNzbBf
 VaoAmN4Xvb+7aMQNrIHvZKurjALDDBquCQ6aue8dn+wFJySgSJI3B13uQD7NspwMGqcmJFRWrMc
 P5WRYZtI8xigigIDGg3ZLd7XL82UKq4iOJAgSNbxLGot8FmKk0SgLia3Eyhfb6ZfXRGWfKQyPEs
 oVB3nb2FX9bq+HWjpJS3S7tevCo3fpZU8JlJnB5AdSaTOkYPOLaniaeOaFN59zd/av2o20YLFP6
 7FSoCXfMaZ5t15DKvtbJtSARkBrNwQqReyL+QEFukmfZWSjX3SZ0SgWqpgNaIwkNl7sZqm
X-Received: by 2002:a05:6820:1891:b0:6cd:3fdc:a934 with SMTP id
 006d021491bc7-6cd3fecc3fbmr2590441eaf.81.1789836563227; 
 Sat, 19 Sep 2026 09:49:23 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 28/41] bsd-user: Add time system call dispatch
Date: Sat, 19 Sep 2026 10:47:56 -0600
Message-ID: <20260919164810.70151-29-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::f; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0f.google.com
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

Wire up time-related system calls in the FreeBSD syscall dispatcher:
nanosleep, clock_nanosleep, clock_gettime, clock_settime, clock_getres,
gettimeofday, settimeofday, adjtime, ntp_adjtime, ntp_gettime,
clock_getcpuclockid2, utimes, lutimes, futimes, futimesat,
ktimer_create, ktimer_delete, ktimer_settime, ktimer_gettime,
select, pselect, ppoll, kqueue, freebsd11_kevent, kevent,
setitimer, getitimer, futimens, utimensat, and sigtimedwait.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 133 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |  18 +++++
 bsd-user/qemu.h               |  41 +++++++++++
 bsd-user/syscall_defs.h       | 121 +++++++++++++++++++++++++++++++
 4 files changed, 313 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 521660e8c8..cc66be3b7c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -48,6 +48,7 @@
 #include "os-signal.h"
 #include "os-file.h"
 #include "os-socket.h"
+#include "os-time.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -89,6 +90,15 @@ safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
 safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
 safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 
+/* used in os-time */
+safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
+    rmtp);
+safe_syscall4(int, clock_nanosleep, clockid_t, clock_id, int, flags,
+    const struct timespec *, rqtp, struct timespec *, rmtp);
+safe_syscall6(int, kevent, int, kq, const struct kevent *, changelist,
+    int, nchanges, struct kevent *, eventlist, int, nevents,
+    const struct timespec *, timeout);
+
 int g_posix_timers[32] = { 0, } ;
 
 /* used in os-proc */
@@ -1028,9 +1038,132 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_getdtablesize();
         break;
 
+        /*
+         * time related system calls.
+         */
+    case TARGET_FREEBSD_NR_nanosleep: /* nanosleep(2) */
+        ret = do_freebsd_nanosleep(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_clock_nanosleep: /* clock_nanosleep(2) */
+        ret = do_freebsd_clock_nanosleep(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_clock_gettime: /* clock_gettime(2) */
+        ret = do_freebsd_clock_gettime(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_clock_settime: /* clock_settime(2) */
+        ret = do_freebsd_clock_settime(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_clock_getres: /* clock_getres(2) */
+        ret = do_freebsd_clock_getres(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_gettimeofday: /* gettimeofday(2) */
+        ret = do_freebsd_gettimeofday(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_settimeofday: /* settimeofday(2) */
+        ret = do_freebsd_settimeofday(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_adjtime: /* adjtime(2) */
+        ret = do_freebsd_adjtime(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_ntp_adjtime: /* ntp_adjtime(2) */
+        ret = do_freebsd_ntp_adjtime(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_clock_getcpuclockid2: /* Not documented. */
+        ret = do_freebsd_clock_getcpuclockid2(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_ntp_gettime: /* ntp_gettime(2) */
+        ret = do_freebsd_ntp_gettime(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_utimes: /* utimes(2) */
+        ret = do_freebsd_utimes(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_lutimes: /* lutimes(2) */
+        ret = do_freebsd_lutimes(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_futimes: /* futimes(2) */
+        ret = do_freebsd_futimes(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_futimesat: /* futimesat(2) */
+        ret = do_freebsd_futimesat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_ktimer_create: /* timer_create(2) */
+        ret = do_freebsd_ktimer_create(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_ktimer_delete: /* timer_delete(2) */
+        ret = do_freebsd_ktimer_delete(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_ktimer_settime: /* timer_settime(2) */
+        ret = do_freebsd_ktimer_settime(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_ktimer_gettime: /* timer_gettime(2) */
+        ret = do_freebsd_ktimer_gettime(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_select: /* select(2) */
+        ret = do_freebsd_select(env, arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_pselect: /* pselect(2) */
+        ret = do_freebsd_pselect(env, arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_ppoll: /* ppoll(2) */
+        ret = do_freebsd_ppoll(env, arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_kqueue: /* kqueue(2) */
+        ret = do_freebsd_kqueue();
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_kevent: /* kevent(2) */
+        ret = do_freebsd_freebsd11_kevent(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_kevent: /* kevent(2) */
+        ret = do_freebsd_kevent(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_setitimer: /* setitimer(2) */
+        ret = do_freebsd_setitimer(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getitimer: /* getitimer(2) */
+        ret = do_freebsd_getitimer(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_futimens: /* futimens(2) */
+        ret = do_freebsd_futimens(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_utimensat: /* utimensat(2) */
+        ret = do_freebsd_utimensat(arg1, arg2, arg3, arg4);
+        break;
+
         /*
          * signal system calls
          */
+    case TARGET_FREEBSD_NR_sigtimedwait: /* sigtimedwait(2) */
+        ret = do_freebsd_sigtimedwait(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_sigaction: /* sigaction(2) */
         ret = do_bsd_sigaction(arg1, arg2, arg3);
         break;
diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
index ee18b23422..b1ff5c0cd5 100644
--- a/bsd-user/freebsd/qemu-os.h
+++ b/bsd-user/freebsd/qemu-os.h
@@ -62,6 +62,24 @@ abi_long host_to_target_itimerspec(abi_ulong target_addr,
         struct itimerspec *host_its);
 int get_timer_id(abi_long arg);
 
+/* os-socket.c */
+abi_long t2h_freebsd_cmsg(struct msghdr *msgh,
+                struct target_msghdr *target_msgh);
+abi_long h2t_freebsd_cmsg(struct target_msghdr *target_msgh,
+                struct msghdr *msgh);
+
+/* os-thread.c */
+abi_long t2h_freebsd_rtprio(struct rtprio *host_rtp, abi_ulong target_addr);
+abi_long h2t_freebsd_rtprio(abi_ulong target_addr, struct rtprio *host_rtp);
+abi_long do_freebsd_thr_new(CPUArchState *env, abi_ulong target_param_addr,
+        int32_t param_size);
+
+/* os-extattr.c */
+struct acl;
+abi_long t2h_freebsd_acl(struct acl *host_acl, abi_ulong target_addr);
+abi_long h2t_freebsd_acl(abi_ulong target_addr, struct acl *host_acl);
+abi_long t2h_freebsd_acl_type(acl_type_t *host_type, abi_long target_type);
+
 /* os-stat.c */
 abi_long h2t_freebsd11_stat(abi_ulong target_addr,
         struct freebsd11_stat *host_st);
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 60d1adf560..069baa7011 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -249,6 +249,47 @@ abi_long do_freebsd_sysctlbyname(CPUArchState *env, abi_ulong namep,
         abi_ulong newlen);
 abi_long do_freebsd_sysarch(CPUArchState *env, abi_long arg1, abi_long arg2);
 
+/* os-thread.c */
+extern pthread_mutex_t *new_freebsd_thread_lock_ptr;
+extern pthread_mutex_t *freebsd_umtx_wait_lck_ptr;
+void *new_freebsd_thread_start(void *arg);
+abi_long freebsd_lock_umtx(abi_ulong target_addr, abi_long tid,
+        size_t tsz, void *t);
+abi_long freebsd_unlock_umtx(abi_ulong target_addr, abi_long id);
+abi_long freebsd_umtx_wait(abi_ulong targ_addr, abi_ulong id,
+        size_t tsz, void *t);
+abi_long freebsd_umtx_wake(abi_ulong target_addr, uint32_t n_wake);
+abi_long freebsd_umtx_wake_unsafe(abi_ulong target_addr, uint32_t n_wake);
+abi_long freebsd_umtx_mutex_wake(abi_ulong target_addr, abi_long val);
+abi_long freebsd_umtx_wait_uint(abi_ulong obj, uint32_t val, size_t tsz,
+        void *t);
+abi_long freebsd_umtx_wait_uint_private(abi_ulong obj, uint32_t val,
+        size_t tsz, void *t);
+abi_long freebsd_umtx_wake_private(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_nwake_private(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_mutex_wake2(abi_ulong obj, uint32_t val);
+abi_long freebsd_umtx_sem2_wait(abi_ulong obj, size_t tsz, void *t);
+abi_long freebsd_umtx_sem2_wake(abi_ulong obj);
+abi_long freebsd_umtx_sem_wait(abi_ulong obj, size_t tsz, void *t);
+abi_long freebsd_umtx_sem_wake(abi_ulong obj);
+abi_long freebsd_lock_umutex(abi_ulong target_addr, uint32_t id,
+        void *ts, size_t tsz, int mode, abi_ulong val);
+abi_long freebsd_unlock_umutex(abi_ulong target_addr, uint32_t id);
+abi_long freebsd_cv_wait(abi_ulong target_ucond_addr,
+        abi_ulong target_umtx_addr, struct timespec *ts, int wflags);
+abi_long freebsd_cv_signal(abi_ulong target_ucond_addr);
+abi_long freebsd_cv_broadcast(abi_ulong target_ucond_addr);
+abi_long freebsd_rw_rdlock(abi_ulong target_addr, long fflag,
+        size_t tsz, void *t);
+abi_long freebsd_rw_wrlock(abi_ulong target_addr, long fflag,
+        size_t tsz, void *t);
+abi_long freebsd_rw_unlock(abi_ulong target_addr);
+abi_long freebsd_umtx_shm(abi_ulong target_addr, long fflag);
+abi_long freebsd_umtx_robust_list(abi_ulong target_addr, size_t rbsize);
+abi_long freebsd_set_ceiling(abi_ulong target_addr, uint32_t ceiling,
+        uint32_t *old_ceiling);
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /* user access */
 
 #define VERIFY_READ  PAGE_READ
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 75f2d6fa36..9fa16e0863 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -639,6 +639,127 @@ struct target_specialfd_eventfd {
     int flags;
 };
 
+/*
+ * FreeBSD thread and user mutex support.
+ */
+
+/* sys/thr.h */
+#define TARGET_THR_SUSPENDED    0x0001
+#define TARGET_THR_SYSTEM_SCOPE 0x0002
+
+struct target_freebsd_thr_param {
+    abi_ulong   start_func; /* thread entry function. */
+    abi_ulong   arg;        /* argument for entry function. */
+    abi_ulong   stack_base; /* stack base address. */
+    abi_ulong   stack_size; /* stack size. */
+    abi_ulong   tls_base;   /* tls base address. */
+    abi_ulong   tls_size;   /* tls size. */
+    abi_ulong   child_tid;  /* address to store new TID. */
+    abi_ulong   parent_tid; /* parent access the new TID here. */
+    int32_t     flags;      /* thread flags. */
+    abi_ulong   rtp;        /* Real-time scheduling priority. */
+    abi_ulong   spare[3];   /* spares. */
+};
+
+/* sys/rtprio.h */
+struct target_freebsd_rtprio {
+    uint16_t    type;
+    uint16_t    prio;
+};
+
+typedef struct {
+    CPUArchState *env;
+    long parent_tid;
+    pthread_mutex_t mutex;
+    pthread_cond_t cond;
+    pthread_t thread;
+    sigset_t sigmask;
+    struct target_freebsd_thr_param param;
+} new_freebsd_thread_info_t;
+
+/* sys/utmx.h */
+/* op code for _umtx_op */
+#define TARGET_UMTX_OP_LOCK                 0
+#define TARGET_UMTX_OP_UNLOCK               1
+#define TARGET_UMTX_OP_WAIT                 2
+#define TARGET_UMTX_OP_WAKE                 3
+#define TARGET_UMTX_OP_MUTEX_TRYLOCK        4
+#define TARGET_UMTX_OP_MUTEX_LOCK           5
+#define TARGET_UMTX_OP_MUTEX_UNLOCK         6
+#define TARGET_UMTX_OP_SET_CEILING          7
+#define TARGET_UMTX_OP_CV_WAIT              8
+#define TARGET_UMTX_OP_CV_SIGNAL            9
+#define TARGET_UMTX_OP_CV_BROADCAST         10
+#define TARGET_UMTX_OP_WAIT_UINT            11
+#define TARGET_UMTX_OP_RW_RDLOCK            12
+#define TARGET_UMTX_OP_RW_WRLOCK            13
+#define TARGET_UMTX_OP_RW_UNLOCK            14
+#define TARGET_UMTX_OP_WAIT_UINT_PRIVATE    15
+#define TARGET_UMTX_OP_WAKE_PRIVATE         16
+#define TARGET_UMTX_OP_MUTEX_WAIT           17
+#define TARGET_UMTX_OP_MUTEX_WAKE           18
+#define TARGET_UMTX_OP_SEM_WAIT             19
+#define TARGET_UMTX_OP_SEM_WAKE             20
+#define TARGET_UMTX_OP_NWAKE_PRIVATE        21
+#define TARGET_UMTX_OP_MUTEX_WAKE2          22
+#define TARGET_UMTX_OP_SEM2_WAIT            23
+#define TARGET_UMTX_OP_SEM2_WAKE            24
+#define TARGET_UMTX_OP_SHM                  25
+#define TARGET_UMTX_OP_ROBUST_LISTS         26
+
+/* flags for UMTX_OP_CV_WAIT */
+#define TARGET_CVWAIT_CHECK_UNPARKING       0x01
+#define TARGET_CVWAIT_ABSTIME               0x02
+#define TARGET_CVWAIT_CLOCKID               0x04
+
+#define TARGET_UMTX_UNOWNED                 0x0
+#define TARGET_UMUTEX_UNOWNED               0x0
+#define TARGET_UMTX_CONTESTED               (abi_ulong)(-1)
+#define TARGET_UMUTEX_CONTESTED             0x80000000U
+
+/* flags for umutex */
+#define TARGET_UMUTEX_ERROR_CHECK   0x0002  /* Error-checking mutex */
+#define TARGET_UMUTEX_PRIO_INHERIT  0x0004  /* Priority inherited mutex */
+#define TARGET_UMUTEX_PRIO_PROTECT  0x0008  /* Priority protect mutex */
+
+#define TARGET_UMUTEX_TRY           1
+#define TARGET_UMUTEX_WAIT          2
+
+/* urwlock flags */
+#define TARGET_URWLOCK_PREFER_READER    0x0002
+#define TARGET_URWLOCK_WRITE_OWNER      0x80000000U
+#define TARGET_URWLOCK_WRITE_WAITERS    0x40000000U
+#define TARGET_URWLOCK_READ_WAITERS     0x20000000U
+#define TARGET_URWLOCK_MAX_READERS      0x1fffffffU
+#define TARGET_URWLOCK_READER_COUNT(c)  ((c) & TARGET_URWLOCK_MAX_READERS)
+
+/*
+ * sys/acl.h
+ */
+#define TARGET_FREEBSD_ACL_MAX_ENTRIES          254
+
+/* vaild acl_type_t arguments */
+#define TARGET_FREEBSD_ACL_TYPE_ACCESS_OLD      0x00000000
+#define TARGET_FREEBSD_ACL_TYPE_DEFAULT_OLD     0x00000001
+#define TARGET_FREEBSD_ACL_TYPE_ACCESS          0x00000002
+#define TARGET_FREEBSD_ACL_TYPE_DEFAULT         0x00000003
+#define TARGET_FREEBSD_ACL_TYPE_NFS4            0x00000004
+
+struct target_freebsd_acl_entry {
+    uint32_t    ae_tag;
+    uint32_t    ae_id;
+    uint32_t    ae_perm;
+    uint16_t    ae_entry_type;
+    uint16_t    ae_flags;
+};
+
+struct target_freebsd_acl {
+    uint32_t            acl_maxcnt;
+    uint32_t            acl_cnt;
+    int32_t             acl_spare[4];
+    struct target_freebsd_acl_entry  acl_entry[TARGET_FREEBSD_ACL_MAX_ENTRIES];
+};
+
 /*
  *  sys/uuid.h
  */
-- 
2.55.0


