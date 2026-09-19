Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDAEC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFq-0003Y3-F9; Sat, 19 Sep 2026 12:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFi-0003UC-Ai
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:26 -0400
Received: from mail-oo2-x0c.google.com ([2607:f8b0:4864:31::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFf-0008Ok-Mj
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:26 -0400
Received: by mail-oo2-x0c.google.com with SMTP id
 006d021491bc7-6b1ae6f1635so631044eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836561; x=1790441361;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q4gjGaNr4yxlY8ZppEOnVIAMeRkY3pfpMP0U3O5LX0E=;
 b=elhAsL6nRve96TKqgtsdeejyxOBbqEn15NCC/oGlqOqoIdCi7A0Jy6ISVZEmX/9ACp
 xStPqUXUES68t5IZm5VPFlX9IisTH+GQ/pEOwMSALxJSwLZesaxlclu20RxVEqyJDMFv
 aV34z/2pqLONYRoszzaVwY0aV/W3Y/48GOWpQaHtCWFuuMamezC2b6apkDE1vS8RoMIW
 yVQZTaOyTSqGGQLLF3AwaLJQLp63NsH5mMFFjmZVvJ1plnCDJYnd6cAB406n9pY42PNl
 BMIT6Ilpty5AqKADeWTaBT8/EBL4Q7Q+NBTGRw3Y5fffHxtC822n1tCOQVTxfECBRXHT
 dFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836561; x=1790441361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q4gjGaNr4yxlY8ZppEOnVIAMeRkY3pfpMP0U3O5LX0E=;
 b=etxvHICsez6RUrdA2bb7FxbXjin4Tx7oOadjcbizqkiXPjP5PTreD1GaHUpvAmHRqO
 mqxfeNz1C3EC1mxI/TdWVQGm/khNVxBSELsb5y7pOhASD3eAOapXHE97q/b+tUYuciyW
 T6am8x9CK9bpx7Onok5lsJd2LSlsa8uQMM+xQG5xQ/cyEb8cCIZ98Tofm9BXduD0fwQQ
 O2ySh6+l7Kr5R0dsgwLHp2uUJtEMwxjImd4Kzk12q5ITiZ23IL6Yxx5IPwncxNEy2/DT
 RMDJ1IufCiNOXgkDp0haSVxmAbEUd2O9gctNQOWmUwGaexgyYKq65SihMAmlDI8QRruW
 t9Mg==
X-Gm-Message-State: AFuF++kDKg+3fXUn+w8TkZvcgJLfBD4OIFTfhb4wVzEXJap8Z0Zozscb
 85a+N0fclK3LPkpvUwCmaN7FJCTcAY0Ew1hhcWyVvSv7lMDIpFcOxxPUun5R5js18Ovmtixuvbt
 fYXt7jSM=
X-Gm-Gg: AYBFou1egRQseMWiHH1NWJjbeSEQXGZ/cpbDBKSkEZ5MVcm26wG5Rc/M4uiLRZTTGzn
 mtqDVkqobXsfh5L236U/ZbVqOhSBIjjy0Rg+EXV7U2UuTly5W1KwDgfqACYhYGd7MOXXELDNljq
 fuRy3r7TqYuu54dgKrNCsU2phTzHr+EbrfnyCrC7x12+d/9or4boY1GeOW1mHy6auJP1M9i32nT
 NtLYqcRdzvMA+SzFhyu1oAUBn8uU2I8KOpe7pdX0/sW0BYEy2ECKeuvMEvwN/6kNYEmJibPn5gW
 3eGPJWJr3LI/TcqFOiFE7V2QWIa1uZBHD0QGAuTYrIcYhlRvMuyp8rhI0RSWzTMs9AhFspCrs5l
 nSASwXV8xflRrCy1yJODa1zd3w40N6lGF5eR9rTuNVpmqIpO9ECOZ/hX3FvALrdrBDsjpGAEVnk
 lQ7PbZgWrf5GzqQqcKlP/nFBwEFrZUYqj+1mieK92kWTpl0UbYXQdQO0hO3cs=
X-Received: by 2002:a05:6820:820:b0:6cd:3fdc:a92e with SMTP id
 006d021491bc7-6cd3fecc3d7mr2698431eaf.75.1789836561152; 
 Sat, 19 Sep 2026 09:49:21 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:19 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/41] bsd-user: Add os-time.c and time-related type definitions
Date: Sat, 19 Sep 2026 10:47:55 -0600
Message-ID: <20260919164810.70151-28-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::c; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0c.google.com
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

Add os-time.c with time conversion helpers (t2h/h2t functions for
timespec, timeval, timex, ntptimeval, itimerspec) and POSIX timer
helper functions. Also add target_freebsd_timex, target_freebsd_ntptimeval,
target_freebsd_itimerspec, kevent structures, and timer definitions
to syscall_defs.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build  |   3 +-
 bsd-user/freebsd/os-syscall.c |   2 +
 bsd-user/freebsd/os-time.c    | 347 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-time.h    |   3 +
 bsd-user/freebsd/qemu-os.h    |  30 +++
 bsd-user/syscall_defs.h       |  41 ++++
 6 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 bsd-user/freebsd/os-time.c

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 83593a1e20..163d5657db 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -8,6 +8,7 @@ bsd_user_ss.add(files(
   'os-socket.c',
   'os-stat.c',
   'os-sys.c',
-  'os-syscall.c'),
+  'os-syscall.c',
+  'os-time.c'),
   bsd_syscall_nr
 )
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5d3a66e360..521660e8c8 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -89,6 +89,8 @@ safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
 safe_syscall3(ssize_t, recvmsg, int, s, struct msghdr *, msg, int, flags);
 safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 
+int g_posix_timers[32] = { 0, } ;
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
new file mode 100644
index 0000000000..0dae7dc008
--- /dev/null
+++ b/bsd-user/freebsd/os-time.c
@@ -0,0 +1,347 @@
+/*
+ * FreeBSD time related system call helpers
+ *
+ * Copyright (c) 2013-2015 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+
+#include <errno.h>
+#include <time.h>
+#include <sys/timex.h>
+#include <sys/types.h>
+#include <sys/select.h>
+#include <sys/umtx.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+/*
+ * FreeBSD time conversion functions
+ */
+abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
+{
+    struct target_freebsd_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_READ, target_tv, target_tv_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(tv->tv_sec, &target_tv->tv_sec);
+    __get_user(tv->tv_usec, &target_tv->tv_usec);
+    unlock_user_struct(target_tv, target_tv_addr, 0);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr)
+{
+    struct target_freebsd_timeval *target_tv;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tv, target_tv_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(tv->tv_sec, &target_tv->tv_sec);
+    __put_user(tv->tv_usec, &target_tv->tv_usec);
+    unlock_user_struct(target_tv, target_tv_addr, 1);
+
+    return 0;
+}
+
+abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr)
+{
+    struct target_freebsd_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_READ, target_ts, target_ts_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(ts->tv_sec, &target_ts->tv_sec);
+    __get_user(ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_ts_addr, 0);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespec *ts)
+{
+    struct target_freebsd_timespec *target_ts;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ts, target_ts_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(ts->tv_sec, &target_ts->tv_sec);
+    __put_user(ts->tv_nsec, &target_ts->tv_nsec);
+    unlock_user_struct(target_ts, target_ts_addr, 1);
+
+    return 0;
+}
+
+abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
+        abi_ulong target_ut_size, void *host_t, size_t *host_tsz)
+{
+    abi_long ret;
+
+    if (target_ut_size <= sizeof(struct target_freebsd_timespec)) {
+        ret = t2h_freebsd_timespec((struct timespec *)host_t, target_ut_addr);
+        if (ret == 0) {
+            *host_tsz = sizeof(struct timespec);
+        }
+        return ret;
+    } else {
+        struct target_freebsd__umtx_time *target_ut;
+        struct _umtx_time *ut = (struct _umtx_time *)host_t;
+
+        if (!lock_user_struct(VERIFY_READ, target_ut, target_ut_addr, 1)) {
+            return -TARGET_EFAULT;
+        }
+        if (t2h_freebsd_timespec(&ut->_timeout, h2g(&target_ut->_timeout))) {
+            unlock_user_struct(target_ut, target_ut_addr, 0);
+            return -TARGET_EFAULT;
+        }
+        __get_user(ut->_flags, &target_ut->_flags);
+        __get_user(ut->_clockid, &target_ut->_clockid);
+        unlock_user_struct(target_ut, target_ut_addr, 0);
+
+        if (target_ut_size > sizeof(struct target_freebsd__umtx_time)) {
+            *host_tsz = sizeof(struct _umtx_time) + sizeof(struct timespec);
+        } else {
+            *host_tsz = sizeof(struct _umtx_time);
+        }
+
+        return 0;
+    }
+}
+
+abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr)
+{
+    struct target_freebsd_timex *target_tx;
+
+    if (!lock_user_struct(VERIFY_READ, target_tx, target_tx_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+    __get_user(host_tx->modes, &target_tx->modes);
+    __get_user(host_tx->offset, &target_tx->offset);
+    __get_user(host_tx->freq, &target_tx->freq);
+    __get_user(host_tx->maxerror, &target_tx->maxerror);
+    __get_user(host_tx->esterror, &target_tx->esterror);
+    __get_user(host_tx->status, &target_tx->status);
+    __get_user(host_tx->constant, &target_tx->constant);
+    __get_user(host_tx->precision, &target_tx->precision);
+    __get_user(host_tx->tolerance, &target_tx->tolerance);
+    __get_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __get_user(host_tx->jitter, &target_tx->jitter);
+    __get_user(host_tx->shift, &target_tx->shift);
+    __get_user(host_tx->stabil, &target_tx->stabil);
+    __get_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __get_user(host_tx->calcnt, &target_tx->calcnt);
+    __get_user(host_tx->errcnt, &target_tx->errcnt);
+    __get_user(host_tx->stbcnt, &target_tx->stbcnt);
+    unlock_user_struct(target_tx, target_tx_addr, 0);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex *host_tx)
+{
+    struct target_freebsd_timex *target_tx;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_tx, target_tx_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(host_tx->modes, &target_tx->modes);
+    __put_user(host_tx->offset, &target_tx->offset);
+    __put_user(host_tx->freq, &target_tx->freq);
+    __put_user(host_tx->maxerror, &target_tx->maxerror);
+    __put_user(host_tx->esterror, &target_tx->esterror);
+    __put_user(host_tx->status, &target_tx->status);
+    __put_user(host_tx->constant, &target_tx->constant);
+    __put_user(host_tx->precision, &target_tx->precision);
+    __put_user(host_tx->tolerance, &target_tx->tolerance);
+    __put_user(host_tx->ppsfreq, &target_tx->ppsfreq);
+    __put_user(host_tx->jitter, &target_tx->jitter);
+    __put_user(host_tx->shift, &target_tx->shift);
+    __put_user(host_tx->stabil, &target_tx->stabil);
+    __put_user(host_tx->jitcnt, &target_tx->jitcnt);
+    __put_user(host_tx->calcnt, &target_tx->calcnt);
+    __put_user(host_tx->errcnt, &target_tx->errcnt);
+    __put_user(host_tx->stbcnt, &target_tx->stbcnt);
+    unlock_user_struct(target_tx, target_tx_addr, 1);
+
+    return 0;
+}
+
+abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
+        struct ntptimeval *ntv)
+{
+    struct target_freebsd_ntptimeval *target_ntv;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_ntv, target_ntv_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+    __put_user(ntv->time.tv_sec, &target_ntv->time.tv_sec);
+    __put_user(ntv->time.tv_nsec, &target_ntv->time.tv_nsec);
+    __put_user(ntv->maxerror, &target_ntv->maxerror);
+    __put_user(ntv->esterror, &target_ntv->esterror);
+    __put_user(ntv->tai, &target_ntv->tai);
+    __put_user(ntv->time_state, &target_ntv->time_state);
+    unlock_user_struct(target_ntv, target_ntv_addr, 1);
+
+    return 0;
+}
+
+/*
+ * select(2) fdset copy functions
+ */
+abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr, int n)
+{
+    int i, nw, j, k;
+    abi_ulong b, *target_fds;
+
+    nw = (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
+    target_fds = lock_user(VERIFY_READ, target_fds_addr,
+            sizeof(abi_ulong) * nw, 1);
+    if (target_fds == NULL) {
+        return -TARGET_EFAULT;
+    }
+    FD_ZERO(fds);
+    k = 0;
+    for (i = 0; i < nw; i++) {
+        /* grab the abi_ulong */
+        __get_user(b, &target_fds[i]);
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            /* check the bit inside the abi_ulong */
+            if ((b >> j) & 1) {
+                FD_SET(k, fds);
+            }
+            k++;
+        }
+    }
+    unlock_user(target_fds, target_fds_addr, 0);
+
+    return 0;
+}
+
+abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
+        abi_ulong target_fds_addr, int n)
+{
+
+    if (target_fds_addr) {
+        if (copy_from_user_fdset(fds, target_fds_addr, n)) {
+            return -TARGET_EFAULT;
+        }
+        *fds_ptr = fds;
+    } else {
+        *fds_ptr = NULL;
+    }
+
+    return 0;
+}
+
+abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *fds, int n)
+{
+    int i, nw, j, k;
+    abi_long v;
+    abi_ulong *target_fds;
+
+    nw = (n + TARGET_ABI_BITS - 1) / TARGET_ABI_BITS;
+    target_fds = lock_user(VERIFY_WRITE, target_fds_addr,
+            sizeof(abi_ulong) * nw, 0);
+    if (target_fds == NULL) {
+        return -TARGET_EFAULT;
+    }
+    k = 0;
+    for (i = 0; i < nw; i++) {
+        v = 0;
+        for (j = 0; j < TARGET_ABI_BITS; j++) {
+            v |= ((FD_ISSET(k, fds) != 0) << j);
+            k++;
+        }
+        __put_user(v, &target_fds[i]);
+    }
+    unlock_user(target_fds, target_fds_addr, sizeof(abi_ulong) * nw);
+
+    return 0;
+}
+
+abi_int next_free_host_timer(void)
+{
+    int k ;
+    /* FIXME: Does finding the next free slot require a lock? */
+    for (k = 0; k < ARRAY_SIZE(g_posix_timers); k++) {
+        if (g_posix_timers[k] == 0) {
+            g_posix_timers[k] = 1;
+            return k;
+        }
+    }
+    return -1;
+}
+
+int host_to_target_timerid(int timerid)
+{
+    int k;
+
+    for (k = 0; k < ARRAY_SIZE(g_posix_timers); k++) {
+        if (g_posix_timers[k] == timerid) {
+            return TIMER_MAGIC | k;
+        }
+    }
+
+    return -1;
+}
+
+abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+                                                 abi_ulong target_addr)
+{
+    struct target_freebsd_itimerspec *target_itspec;
+
+    if (!lock_user_struct(VERIFY_READ, target_itspec, target_addr, 1)) {
+        return -TARGET_EFAULT;
+    }
+
+    host_itspec->it_interval.tv_sec =
+                            tswapal(target_itspec->it_interval.tv_sec);
+    host_itspec->it_interval.tv_nsec =
+                            tswapal(target_itspec->it_interval.tv_nsec);
+    host_itspec->it_value.tv_sec = tswapal(target_itspec->it_value.tv_sec);
+    host_itspec->it_value.tv_nsec = tswapal(target_itspec->it_value.tv_nsec);
+
+    unlock_user_struct(target_itspec, target_addr, 0);
+    return 0;
+}
+
+abi_long host_to_target_itimerspec(abi_ulong target_addr,
+                                               struct itimerspec *host_its)
+{
+    struct target_freebsd_itimerspec *target_itspec;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_itspec, target_addr, 0)) {
+        return -TARGET_EFAULT;
+    }
+
+    target_itspec->it_interval.tv_sec = tswapal(host_its->it_interval.tv_sec);
+    target_itspec->it_interval.tv_nsec = tswapal(host_its->it_interval.tv_nsec);
+
+    target_itspec->it_value.tv_sec = tswapal(host_its->it_value.tv_sec);
+    target_itspec->it_value.tv_nsec = tswapal(host_its->it_value.tv_nsec);
+
+    unlock_user_struct(target_itspec, target_addr, 1);
+    return 0;
+}
+
+/* Convert QEMU provided timer ID back to internal 16bit index format */
+int get_timer_id(abi_long arg)
+{
+    int timerid = arg;
+
+    if ((timerid & TIMER_MAGIC_MASK) != TIMER_MAGIC) {
+        return -TARGET_EINVAL;
+    }
+
+    timerid &= 0xffff;
+
+    if (timerid >= ARRAY_SIZE(g_posix_timers)) {
+        return -TARGET_EINVAL;
+    }
+
+    return timerid;
+}
diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
index 05cb5db7d1..213bd16850 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -202,6 +202,9 @@ static inline abi_long do_freebsd_ntp_adjtime(abi_ulong target_tx_addr)
     if (ret == 0) {
         ret = get_errno(ntp_adjtime(&host_tx));
     }
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_timex(target_tx_addr, &host_tx);
+    }
 
     return ret;
 }
diff --git a/bsd-user/freebsd/qemu-os.h b/bsd-user/freebsd/qemu-os.h
index 12adc50928..ee18b23422 100644
--- a/bsd-user/freebsd/qemu-os.h
+++ b/bsd-user/freebsd/qemu-os.h
@@ -32,6 +32,36 @@
 
 struct freebsd11_stat;
 
+/* os-time.c */
+abi_long t2h_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr);
+abi_long h2t_freebsd_timeval(struct timeval *tv, abi_ulong target_tv_addr);
+
+abi_long t2h_freebsd_timespec(struct timespec *ts, abi_ulong target_ts_addr);
+abi_long h2t_freebsd_timespec(abi_ulong target_ts_addr, struct timespec *ts);
+
+abi_long t2h_freebsd_umtx_time(abi_ulong target_ut_addr,
+        abi_ulong target_ut_size, void *host_t, size_t *host_tsz);
+
+abi_long t2h_freebsd_timex(struct timex *host_tx, abi_ulong target_tx_addr);
+abi_long h2t_freebsd_timex(abi_ulong target_tx_addr, struct timex *host_tx);
+
+abi_long h2t_freebsd_ntptimeval(abi_ulong target_ntv_addr,
+        struct ntptimeval *ntv);
+
+abi_ulong copy_from_user_fdset(fd_set *fds, abi_ulong target_fds_addr, int n);
+abi_ulong copy_from_user_fdset_ptr(fd_set *fds, fd_set **fds_ptr,
+        abi_ulong target_fds_addr, int n);
+abi_long copy_to_user_fdset(abi_ulong target_fds_addr, const fd_set *fds,
+        int n);
+
+abi_int next_free_host_timer(void);
+int host_to_target_timerid(int timerid);
+abi_long target_to_host_itimerspec(struct itimerspec *host_itspec,
+        abi_ulong target_addr);
+abi_long host_to_target_itimerspec(abi_ulong target_addr,
+        struct itimerspec *host_its);
+int get_timer_id(abi_long arg);
+
 /* os-stat.c */
 abi_long h2t_freebsd11_stat(abi_ulong target_addr,
         struct freebsd11_stat *host_st);
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index f4bb687388..75f2d6fa36 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -155,6 +155,47 @@ struct target_freebsd_timeval {
 #endif
 };
 
+/* compare to sys/timex.h */
+struct target_freebsd_ntptimeval {
+    struct target_freebsd_timespec  time;
+    abi_long    maxerror;
+    abi_long    esterror;
+    abi_long    tai;
+    int32_t     time_state;
+};
+
+struct target_freebsd_itimerspec {
+    struct target_freebsd_timespec it_interval;
+    struct target_freebsd_timespec it_value;
+};
+
+struct target_freebsd_timex {
+    uint32_t    modes;
+    abi_long    offset;
+    abi_long    freq;
+    abi_long    maxerror;
+    abi_long    esterror;
+    int32_t     status;
+    abi_long    constant;
+    abi_long    precision;
+    abi_long    tolerance;
+
+    abi_long    ppsfreq;
+    abi_long    jitter;
+    int32_t     shift;
+    abi_long    stabil;
+    abi_long    jitcnt;
+    abi_long    calcnt;
+    abi_long    errcnt;
+    abi_long    stbcnt;
+};
+
+/* Maxiumum of 32 active POSIX timers allowed at any one time. */
+extern int g_posix_timers[32];
+
+#define TIMER_MAGIC 0x0caf0000
+#define TIMER_MAGIC_MASK 0xffff0000
+
 /*
  * sys/event.h
  */
-- 
2.55.0


