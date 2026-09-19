Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229A8C982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yFZ-00037O-PL; Sat, 19 Sep 2026 12:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFW-00036K-Ra
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:15 -0400
Received: from mail-oi2-x18.google.com ([2607:f8b0:4864:32::18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFU-0008KM-9B
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:13 -0400
Received: by mail-oi2-x18.google.com with SMTP id
 46e09a7af769-7f4f1354076so408239a34.1
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836551; x=1790441351;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9olzYjwumX7R7LPQVvbR/Zq9y6lTKJ3ONx88TImvWwg=;
 b=xVkPciBA4JsCi89Sz+kVoBOPX3xNtxQyI7MuWHxQTkNrdGBrJDRkklI77xDbTr8ZVO
 DTPJvQ2ZiYkgqKZteyK8/4vVpvMGtzPeM8bDA+uhAL1wcSH9m3KtORGJSrIr3G6hGMev
 yU7C+BV1apI5qemt/pKKbOvuIt5Vg2AMs+wrRihunHwAKDKy1av5Bl/+VkTrVyj10ANo
 dyx9i+tzA7fZNaMLk456SJM4Baly3/NuQj5M4XfHOBiJGjypHjDNs8AjQxpEkvyXdLKJ
 xaL2WGptfkKhKSskOIUGPQMKgrJ66o9OFho/9X1Y0QqtOqlflma4FD9c7ONcETWMdEEA
 NBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836551; x=1790441351;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9olzYjwumX7R7LPQVvbR/Zq9y6lTKJ3ONx88TImvWwg=;
 b=zlJzLmajNpmu59Wdie654Axz7hcd0u/BP5POIgc1eTBHzGKDpw0xogHayh5vpGBWrn
 7dw+v2WNlGMqBTeP65LIzOH1kx0tPzdl6YKg03zYB32+HH9YDOW/QH4SApX7A1SkouRX
 7RdPv7/UfGiEdsklWfpYld3QTuCsI1s72RIHRy40XbH9Hov2M4NB1o2Gh9JAzjukAiQF
 6lretCw/tCrmyBvwV00Hk63D4vyxSjGWT9tKQCUxl48AZvbZBnOodz35wRtoxdNb58mk
 xsJ+WPLmXUEXrmEXukU2kKoxivi4oMFmNc5EC3OqkJ89AnIhOYTP9l5mVGn7pfqqO5lo
 iwKw==
X-Gm-Message-State: AFuF++kliLDT040OuE83ayLLrH2/iLn7MCJiyrkJWX54FebCKcWaAiZx
 4OgbDY34BtxfxrCtxokFLZkuDIZ1YpgjsrfDv/K5m2kqhsvtgpU78wBoZr4mCi57JsJZtEjslr9
 cFsXglt0=
X-Gm-Gg: AYBFou1hHMx4I62eCafSCGLY//Rop9Qd2CUmYtMXUOpKOsqvKeVs3JDpRHJyTqcxzeL
 6FSblhEb4iIUL35ZALiSPN+dsIZwvdB/HAM2E+xXJlOfWuF7A/488U9wBrflxAyonpMawvsgU1U
 s8yQ6htWqOf2igx8xbfHtN28B+Fx2i8qt6tvtvwrtXA6Yec37QeugY7x3usbp8XaEvzqbvQQcsZ
 PpKeN7KbvPEuQil8vk8fX2AlcRePgLoqpRXft0091/TXO5rxG+uBFl/mnAOwcf5u5jliwZThqnM
 QVsj45ECx1xzuLgkz88ZKG7ent42e4TxbGXFC9QemiseoFtP4beVDY4xLdM9nEcm15buEYyRJg4
 H5We4TwOAEZGAIxFAn9yZNhh/t+pfaPSf/RyjGGblS7cTvzmWUKcaovKSOb8y4RYlWUvwCNZ+In
 UPKHs5ZpCmY1/5Teh6aQuJzGzCinm9FRhe6PIiT3Y5biWY39MMpYm2AyWk/w==
X-Received: by 2002:a05:6820:f005:b0:6cd:3fdc:2668 with SMTP id
 006d021491bc7-6cd3fdc26b1mr2202558eaf.41.1789836550912; 
 Sat, 19 Sep 2026 09:49:10 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:09 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/41] bsd-user: Add os-time.h with clock and time-of-day
 functions
Date: Sat, 19 Sep 2026 10:47:50 -0600
Message-ID: <20260919164810.70151-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::18;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x18.google.com
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

Add the first part of FreeBSD time support: nanosleep, clock_nanosleep,
clock_gettime, clock_settime, clock_getres, gettimeofday, settimeofday,
adjtime, ntp_adjtime, and ntp_gettime. Also add safe_syscall wrappers
for nanosleep, clock_nanosleep, and kevent.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-time.h | 225 +++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)
 create mode 100644 bsd-user/freebsd/os-time.h

diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
new file mode 100644
index 0000000000..e387441d86
--- /dev/null
+++ b/bsd-user/freebsd/os-time.h
@@ -0,0 +1,225 @@
+/*
+ * FreeBSD time related system call shims
+ *
+ * Copyright (c) 2013-2015 Stacey Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef FREEBSD_OS_TIME_H
+#define FREEBSD_OS_TIME_H
+
+#include <sys/types.h>
+#include <sys/event.h>
+#include <sys/select.h>
+#include <sys/timex.h>
+#include <poll.h>
+#include <signal.h>
+#include <time.h>
+
+#include "qemu.h"
+#include "qemu-os.h"
+
+#include "bsd-socket.h"
+
+int safe_clock_nanosleep(clockid_t clock_id, int flags,
+     const struct timespec *rqtp, struct timespec *rmtp);
+int safe_nanosleep(const struct timespec *rqtp, struct timespec *rmtp);
+int safe_kevent(int, const struct kevent *, int, struct kevent *, int,
+     const struct timespec *);
+
+int __sys_ktimer_create(clockid_t, struct sigevent *restrict,
+     int *restrict);
+int __sys_ktimer_gettime(int, struct itimerspec *);
+int __sys_ktimer_settime(int, int, const struct itimerspec *restrict,
+     struct itimerspec *restrict);
+int __sys_ktimer_delete(int);
+
+/* nanosleep(2) */
+static inline abi_long do_freebsd_nanosleep(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct timespec req, rem;
+
+    ret = t2h_freebsd_timespec(&req, arg1);
+    if (!is_error(ret)) {
+        ret = get_errno(safe_nanosleep(&req, &rem));
+        if (ret == -TARGET_EINTR && arg2) {
+            if (h2t_freebsd_timespec(arg2, &rem) != 0) {
+                ret = -TARGET_EFAULT;
+            }
+        }
+    }
+
+    return ret;
+}
+
+/* clock_nanosleep(2) */
+static inline abi_long do_freebsd_clock_nanosleep(abi_long arg1, abi_long arg2,
+    abi_long arg3, abi_long arg4)
+{
+    struct timespec req, rem;
+    abi_long ret;
+    int clkid, flags;
+
+    clkid = arg1;
+    /* XXX Translate? */
+    flags = arg2;
+    ret = t2h_freebsd_timespec(&req, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(safe_clock_nanosleep(clkid, flags, &req, &rem));
+        if (ret == -TARGET_EINTR && arg4) {
+            if (h2t_freebsd_timespec(arg4, &rem) != 0) {
+                ret = -TARGET_EFAULT;
+            }
+        }
+    }
+
+    return ret;
+}
+
+/* clock_gettime(2) */
+static inline abi_long do_freebsd_clock_gettime(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct timespec ts;
+
+    ret = get_errno(clock_gettime(arg1, &ts));
+    if (!is_error(ret)) {
+        if (h2t_freebsd_timespec(arg2, &ts) != 0) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+/* clock_settime(2) */
+static inline abi_long do_freebsd_clock_settime(abi_long arg1, abi_long arg2)
+{
+    struct timespec ts;
+
+    if (t2h_freebsd_timespec(&ts, arg2) != 0) {
+        return -TARGET_EFAULT;
+    }
+
+    return get_errno(clock_settime(arg1, &ts));
+}
+
+/* clock_getres(2) */
+static inline abi_long do_freebsd_clock_getres(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    struct timespec ts;
+
+    ret = get_errno(clock_getres(arg1, &ts));
+    if (!is_error(ret)) {
+        if (h2t_freebsd_timespec(arg2, &ts) != 0) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+/* gettimeofday(2) */
+static inline abi_long do_freebsd_gettimeofday(abi_ulong arg1, abi_ulong arg2)
+{
+    abi_long ret;
+    struct timeval tv;
+    struct timezone tz, *target_tz; /* XXX */
+
+    if (arg2 != 0) {
+        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
+        __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
+        unlock_user_struct(target_tz, arg2, 1);
+    }
+    ret = get_errno(gettimeofday(&tv, arg2 != 0 ? &tz : NULL));
+    if (!is_error(ret)) {
+        if (h2t_freebsd_timeval(&tv, arg1)) {
+            return -TARGET_EFAULT;
+        }
+    }
+
+    return ret;
+}
+
+/* settimeofday(2) */
+static inline abi_long do_freebsd_settimeofday(abi_long arg1, abi_long arg2)
+{
+    struct timeval tv;
+    struct timezone tz, *target_tz; /* XXX */
+
+    if (arg2 != 0) {
+        if (!lock_user_struct(VERIFY_READ, target_tz, arg2, 0)) {
+            return -TARGET_EFAULT;
+        }
+        __get_user(tz.tz_minuteswest, &target_tz->tz_minuteswest);
+        __get_user(tz.tz_dsttime, &target_tz->tz_dsttime);
+        unlock_user_struct(target_tz, arg2, 1);
+    }
+    if (t2h_freebsd_timeval(&tv, arg1)) {
+        return -TARGET_EFAULT;
+    }
+
+    return get_errno(settimeofday(&tv, arg2 != 0 ? &tz : NULL));
+}
+
+/* adjtime(2) */
+static inline abi_long do_freebsd_adjtime(abi_ulong target_delta_addr,
+        abi_ulong target_old_addr)
+{
+    abi_long ret;
+    struct timeval host_delta, host_old;
+
+    ret = t2h_freebsd_timeval(&host_delta, target_delta_addr);
+    if (is_error(ret)) {
+        return ret;
+    }
+
+    if (target_old_addr) {
+        ret = get_errno(adjtime(&host_delta, &host_old));
+        if (is_error(ret)) {
+            return ret;
+        }
+        ret = h2t_freebsd_timeval(&host_old, target_old_addr);
+    } else {
+        ret = get_errno(adjtime(&host_delta, NULL));
+    }
+
+    return ret;
+}
+
+/* ntp_adjtime(2) */
+static inline abi_long do_freebsd_ntp_adjtime(abi_ulong target_tx_addr)
+{
+    abi_long ret;
+    struct timex host_tx;
+
+    ret = t2h_freebsd_timex(&host_tx, target_tx_addr);
+    if (ret == 0) {
+        ret = get_errno(ntp_adjtime(&host_tx));
+    }
+
+    return ret;
+}
+
+/* ntp_gettime(2) */
+static inline abi_long do_freebsd_ntp_gettime(abi_ulong target_ntv_addr)
+{
+    abi_long ret;
+    struct ntptimeval host_ntv;
+
+    ret = get_errno(ntp_gettime(&host_ntv));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_ntptimeval(target_ntv_addr, &host_ntv);
+    }
+
+    return ret;
+}
+
+
+
+#endif /* FREEBSD_OS_TIME_H */
-- 
2.55.0


