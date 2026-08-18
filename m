Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA490C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThM-0002hP-N4; Tue, 18 Aug 2026 19:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThL-0002ge-OY
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:27 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThJ-0005IL-GP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:27 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4b1bf68b387so302006b6e.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097504; x=1787702304;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZ9crdZ+AEICpSsPVx2FsxC4bka5gEoH/Sr0jOMkzMI=;
 b=ufsTP1A8YO3i4Wia5pu0OhRd8yww20NFN8z/Yqbcw/0sPxc/0ypS0Ojzzj8aWObo5B
 Ff5WKiMC2p2hoZL9hCmZU7meDZ70fBfLa5yVA2mzqREzYiBmI8Yw8b1kvpgoQGihPFfz
 wSzeuw2ltAiJ3sjWBP1tUUMjsCN9nP91j4KNZ2mEwNupz1FrnaDf3VOvednuZFvxH9cP
 ANVB7UvnytE4qLxWPVEDCg7fixbA9DgkWIEoPXD6LQQRREMVqUjvflW33KkJR/Mx+CLO
 3BD8F6YF+1LRHi9IeAF8aeThCzQBQeF6qFjruALAJR0D+qc+zAuAnS9PpK0AI1aQ++bJ
 /E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097504; x=1787702304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cZ9crdZ+AEICpSsPVx2FsxC4bka5gEoH/Sr0jOMkzMI=;
 b=Lbr2DGGPe4Pmx9+fUshureI9gaDN9aKKs5+onCHmbH6fSA1jT2exo+Ex5SO5UNLapb
 5nkKnVymbt6BxyQPDSXOT/eKwGO5NsNocDlJK/kSFpSKCiESW+5+38gDDmDYi7+oyF2s
 j2CwV6UKYOfr9ssa3nJ/0PxYEM/tfpTdKhhAYhgm+m2us4XemwCCDi8OIOhSLn6TXYSX
 Ufy2UHUx3u0AJU/NdIM46fs2kIJdqAeM7KFQElGw6p5wXFMWxP6gIY6VTq/alBQdPPtK
 tkweeL2TJLBQFoKdxHc3G1zUCtfMhPdiiJy5AZN1J6y4zEFR44w8+5YQeFP01IXnBMKD
 hd+A==
X-Gm-Message-State: AOJu0Yy6z2Gi67vrvOomWf6J/WlOi4WmKGThbkcUw0KPKqs3/bIASt2n
 +MxvUHGGFdzKts+ORANIgV+LLgQrgOOHEinTkvlV18Ng2SARrHhjj9RSBHaS+5Avus0=
X-Gm-Gg: AR+sD13RZtAiBRBnYB5Hey+1mnMsy6L1RtKtsEiQxB+11U9wrD56XfMpb95EO86hgH9
 CmmVu+WqtAmBBjohyDJ0d+W4I/wYa0R193XrqaYU+eqyWrt6ka/yDckJhBNfRkz0w/rJclbJ00a
 Kemhs1eXdqZkh+XLIG8BZzpxvIl36wOoHW0t3k6MtKDvWR2KYTbIg5v2SkPrwcT07aBod2uMWMK
 ca93TO9mcxBMj8ZEiiMFBVt9iVXVAePMGOKJxPN5RAYXQffMLU/ounFTaUXzIcMPx2kI8z3imKC
 yk18dd124EXGz8GWJFluOqryREIZ/FR66L/lKCHH9RRX9uJ3s71GNM/9WB6/TAD01BQhZUmKMSj
 DPzxzHQib9/PAWgblwrisgP/77sMqtrd5mnJv47u/G4YrUQvJhLpRkP+2F/PvDImL/CZtK8br2i
 DW0WeljUhWD+SjMREY37/j6x7v/s5/bz/3Q5T9K8rXfbpBDgQ=
X-Received: by 2002:a05:6808:238b:b0:4a4:25b4:a0be with SMTP id
 5614622812f47-4b2bc8b7476mr441569b6e.2.1787097504327; 
 Tue, 18 Aug 2026 16:58:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:22 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:20 -0600
Subject: [PATCH v4 27/40] bsd-user: Add time system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-27-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15389; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=i8z+PoUhC8KCwArCtJ72qorGl2SD1QvYid+LW2z7TYA=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFJP+NYlRIULrFu3xllG/bx5AxJGpxH23SiT
 aQ0TYqltxuJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxSRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAWtxAArXHVf4y9jp0D9dTfGbytbiyQXl9zjPj
 H4B+b/OmQWbgTACoxFVxvI4mypC6FWd73u5Da2mFCKGEaTLjinG8FSvXnyvbpdL6YYoQJK8b/86
 +GO1tM2qpYfpI3ZMFV5zzEHycefsUy9lzTWltv0ucY1pW9SmcPkvPn1I9kPB8a/sit1lZVDKfGK
 LhP9AigYmX0vTvUgHE553/cZtdeCOM5coo+wsiWbBGHjBMYDQSVP1V+1zMtUxsilq5UiYR1GYNd
 UMMLUgY5k3UFssy7/tFkmNZKH/vsgiEShxgZkr3tEj35D6NC7C9FgN1iwrTAShSARl3+GSXJYUr
 dy1MaRa2UmmVFi4lchmEU8cmFfTqbaCU9Eo4lmILsbsEWbeb3xkp16k5rLBf9s8oB7Ky1f/k+J/
 AeoiqtPYlDGtIDAYXtQdninN1qBLKRp62qmGeIrbeB7KBQMkg0vmAIsQdwC+T7m1i35NhqepJlq
 HfJx+fBmW5KUhOmZUvxE/CYYAuy9+6he1AfXgns1OEI9bekHaYQu6TgwBbQbGDGCRJ9HAdbLXqT
 oNkM9l3dDAbtG8Y81pdF/ED8JKEpdSah5qn3WqTH+Fb3hGWaokEIDIB/lK27t9JM70j2jP4VbOS
 4BFxjVPRWimgJNvh6S45/5rkcVDOv3B/PdJEP18dRohVS68Bf+rg=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x234.google.com
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
 bsd-user/freebsd/os-syscall.c | 133 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/qemu-os.h    |  18 ++++++
 bsd-user/qemu.h               |  41 +++++++++++++
 bsd-user/syscall_defs.h       | 121 ++++++++++++++++++++++++++++++++++++++
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


