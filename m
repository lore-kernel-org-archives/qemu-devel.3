Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EED8CD4F56
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vk-0000Wq-4O; Mon, 18 May 2026 17:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vc-0000Uq-Ut
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:21 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VZ-0000VU-1P
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:20 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c6f914617so1366012b6e.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139694; x=1779744494;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lRgIbZa5zVZI9ihk3p6ZJUVVoOaxd087DgvBy7iqbWQ=;
 b=NrwvFipAOAzFHzXU2pX4IbUBpxXU48D8drVaws8gnQq6EZeZtVQoQO01tZCBe4ZFZi
 HOAtn6fyd1Uomn+ivXTdlb6shdqJaJsbN81YrWADRWAye6KginL5YfbhNiMKuGw0qcaS
 OD6Amdqzh1IcMwpG62k4ugg23iac7kywmx8/DYL4LrutWIlvN6SPqNfUCkXkHYzmOaX2
 vpjGeu/M+jEGPJJtoUruUwWzDFl9mlacb2JOWuRtx9j+XpR8UrNqa0Ao9WGSoZbnw7Y2
 mlU1J3Vhq5eYWq7+9Zg/yJJKCMNQU/rZWiTN2gHyE1/iZ7P3oYTL1qitF1eSRm900hjz
 DgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139694; x=1779744494;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lRgIbZa5zVZI9ihk3p6ZJUVVoOaxd087DgvBy7iqbWQ=;
 b=ff6/wTQcKqJWb4gercSNOEdimUCWnzou+H/LALQuG5557+WjiCrr3dvxmk9q42ysLG
 QyUk38fWEZo5QEQYRABIair21dfR6ykAB6briaGVTH211BxhCx8bEXPJJPDlVtmxdSBY
 1dpV/GJsluudETzRXU9p9Z/V7+7OTcV59xjde3401nFIdlgLlRy65p9A9enUIJiZ7j9U
 2yTahoIyCTlpWn8kMujHEHoKDSEb1bq3++VbF3VeFeUDUMcj4OAO4RBQwK8oF/VV4MP8
 x/uMTyeM8DDqoD1eVGB8vjY/bmq5O8UUK8CgYC8BjngZ0rFoxnGXUKnFNRak8+E5lubX
 rr2Q==
X-Gm-Message-State: AOJu0Yxwz/yISob10ptgPW1mbceavGlReB395K7+iL18HZZx8Vt3uVz7
 lXaoP6Oz0wbFudhqIQuQgI+124dSNNUIU/E5HEEXuuyT4v/BTBOG/+WQqRxIkDbo8Xc=
X-Gm-Gg: Acq92OEHqVpGuqOQ2EqbpevDGdHudGgaSUSVTgl1n/UTkGnbIUfZaD8NogSdFMSZ2pu
 sHB8m2NYtQ/bXqDE3k4dfyO2D25wXEhyoFSiCJqgDSvraWWG9cB/oQ1KL465MoF0OPDaxSvDWCl
 gceKEr3/cFFSKGXhiTQ8fcjS1j32QBqcr1BUGXu24+yvmKrDxo+v56uZ8JyQgEttxXcMHpogN16
 fuqf78fBFumc0HWj7T2/Ape6ZflBgHQ/SxuZ/PQeaHSmeHc25aXtTLureWD7VssmoadNUfbkset
 7CCMAu+XbmtgW4hetD2Wme2EitFCG+U4YkW5Q9d0QrqN/EUEFuT3e3/Syjr39zNjzq4u8bfKHly
 iRmcEnf/Fe2ndCTlLZWDm6D9lcYbvXuN9cTOrKTFT6+y9sQtJW6gT9dQ5EaOmFPwveYIE+dYthJ
 +Tuoscymnckg==
X-Received: by 2002:a05:6808:f8c:b0:47c:3f6f:db97 with SMTP id
 5614622812f47-482e564d750mr10848042b6e.21.1779139693777; 
 Mon, 18 May 2026 14:28:13 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:13 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:40 -0600
Subject: [PATCH v2 22/37] bsd-user: Add os-time.c and time-related type
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-22-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13090; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=L7v65mJI2fLjLDk/Nuzxs+s7fXNRPx2eJpEFl8Z7fLc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RIXpw4x/bgodWYrWK9P/y3l9lx2wVC9TRda
 IaI/+yn+peJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AHO8D/sEzqfn1ZPArz7CmShI5W/3nhlCuEK90U7dc77+Q3fPZ+chWbDQLncKbxE0lski19Hn8ZA
 GoScK1UdiVKpAlqUWY3OaE3sn1pQ/VSk40b4R+CPvQmyYdaBPqX1nXwIX5IxdwbjXrMi6gvs1CQ
 VrdJS8gVqNx0lWdNPVJZJ8cc2Pixf+pgz+j0ugExvDTZi6J/wZddSIbjOq3BJpYAwnrpe9t2Xui
 n44eWIOrVbP0Do+SmqFUC/HmsCIrPIKPpQCkZR2fTbNTpT0pUm6I6fXgL/C3AgzvlPTYSqs3znl
 RFRQKavrtxlhvB+9fdYbl74b+Y0l/oIVpwxDx/uZJ6JXlBiMi3x8Xp2bZ3KJdYuHnu65hYPEpV7
 UafpMR8tH3A4J0e4D1iLpMjftzUxnRy8IYB9F9T46grHCkqvdUUEYSBS6Zu2OC5qLmjlDFdvDcZ
 iDCqhp+zJiYvvaG9F0/6PslIa6EVbBqqLy4ti5KovdRo8NLJOPVCZ1jcZXKP/zOYBwCnZ3HVNWj
 8+R6H8SD/exqYwnWc38p/6r9+HZzUNgdcU/uOWwDZLvit8zzxf3/+zBBD2VlqpY99L/W45qU7SR
 bBPXEd7fFK8vl510KmIMR5yLssI75k4vwTdY9WAfumFNbhKO9+7vJCOKpNGqoKIZsDqQb56NfAO
 wn+o9nSgxPF/CrQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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

Add os-time.c with time conversion helpers (t2h/h2t functions for
timespec, timeval, timex, ntptimeval, itimerspec) and POSIX timer
helper functions. Also add target_freebsd_timex, target_freebsd_ntptimeval,
target_freebsd_itimerspec, kevent structures, and timer definitions
to syscall_defs.h.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c |   2 +
 bsd-user/freebsd/os-time.c    | 346 ++++++++++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-time.h    |   3 +
 3 files changed, 351 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 6fbd2da261..020d16fda3 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -98,6 +98,8 @@ safe_syscall6(int, kevent, int, kq, const struct kevent *, changelist,
     int, nchanges, struct kevent *, eventlist, int, nevents,
     const struct timespec *, timeout);
 
+int g_posix_timers[32] = { 0, } ;
+
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
diff --git a/bsd-user/freebsd/os-time.c b/bsd-user/freebsd/os-time.c
new file mode 100644
index 0000000000..f1c1cc2c1a
--- /dev/null
+++ b/bsd-user/freebsd/os-time.c
@@ -0,0 +1,346 @@
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
index f24b6f35db..e91a3f9bcf 100644
--- a/bsd-user/freebsd/os-time.h
+++ b/bsd-user/freebsd/os-time.h
@@ -198,6 +198,9 @@ static inline abi_long do_freebsd_ntp_adjtime(abi_ulong target_tx_addr)
     if (ret == 0) {
         ret = get_errno(ntp_adjtime(&host_tx));
     }
+    if (!is_error(ret)) {
+        h2t_freebsd_timex(target_tx_addr, &host_tx);
+    }
 
     return ret;
 }

-- 
2.52.0


