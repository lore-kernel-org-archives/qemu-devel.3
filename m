Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4736CC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThA-0002FE-IU; Tue, 18 Aug 2026 19:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh8-0002El-V8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:14 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTh7-0005H9-2z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:14 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4ab89cff9c7so224674b6e.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097492; x=1787702292;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c78UEnfYMuPb3ThtXQ1/u6SuURDhXHNgr6oLS7XK4BM=;
 b=hqPg1ebyAN4DNEk2bnzrW3e0+3eQr7tj7DB7afF4/elvJ44dm8uF38SI5IbuYlRvL1
 8rfutKeAFWKffpe8WE5m77P0J6zOtk87YXGtqj9Itxq+9IeM2c6CalzsuvXQnK5HCC35
 4ClrH6j7DoZu0tXmpFM4/2v4C+iKENh8+DpP7tQW6n41VjPG5OMF7l77jlsWkVyKtM8S
 RMx3ALlVWf1Prngl1aAEC7geg5YptzmhS6essve+42vra1d9h4Wu+V6FTtFl0Ayehbu1
 eXmnM7P3TvYv/qNMvd3OfIqhkuMJ2xVp8zpqKSrEHqZoz1Hcju++a9L7ZzXefa61KM9x
 3ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097492; x=1787702292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c78UEnfYMuPb3ThtXQ1/u6SuURDhXHNgr6oLS7XK4BM=;
 b=Bs8oepTPALL3WYh5wcpYFXLq+QyklBn52TkgcgiPJeS+GR88wUvQBlCYqWUl9X5vmz
 rVUPnONMBXNNy+FWmuWCOGhBLO0vWq/2SY9mYpuTDXTvfYWR/yEF9LXT/I0sq/RftFbZ
 te984Ew50NSo2OEPtOanPrxpTdSCT3XA2n4tP5bgGnNjQ1dc2sePXRA1lUVwgI7NTAdx
 2PcRfFPsBBxA0uSE1hKzxIKs/35DuI/+bL3x2sdkYn++AflY529Q+F81ZDmEcczkEiU8
 OYy8uAOzjJ5F16mCZR02mp1pSQYmlqctlHqlBY8ZtiiAyNzE0t+jt5cRy906/Rcx8TTV
 5oXQ==
X-Gm-Message-State: AOJu0Yw+4k79BxlcXVfBacqTbHFcEl7tv7Kwm7rN7d64BbMSoBX19PNk
 5McPsN2D9i1IZ2IkkVwayRTxcx9Wox1AVgsrouNPJrKW0XZuopY2LsP5FPyGSIEjnFA=
X-Gm-Gg: AR+sD131QS+oSo6MAAo5jnV95/ggI2s0CGXsAlhWNn6E7ueTVJwVlB+mHpy2C8xw1Vn
 4hCxwTWIwRG5qI5Cj2cvl2OQaU/JL24zmzaPFSfRHzoq9TSJSnj0qxRoID0KZ6/N3FJ/5sqi1wc
 IcO0YkbuYcKfhbPeFO+2G4h08qOOLMDSarXAxbWa1FmZ/3mU8yUrRmqlCOyKSjt4/o8KRerb/uh
 4uNj7G0hGWy1s+5qTrCOBYHgTXCcMTw0QJmo3ggCEm+Ysh6LbOzBbjG7g/O0/UjCfiPqT97NPcL
 Hq/QT426DidIQWpsPRnAiu1HCgXs91xHiU3KT/31ft1OaYGoPzYkP8boY5Oo/fQyZcOI4S4c51C
 5QXT76syTY/zPPvnraWt+dxcD8yUUZvgfj4A7QTo7U6lxYGVFtWsjMiiSxVOppy7HIaN9yt/R7V
 IeJuDP+QNZqq7o7ho/SQ2g/DsXf0FA1SNESS83CWYsWc7Devo=
X-Received: by 2002:a05:6808:c293:b0:495:da89:c578 with SMTP id
 5614622812f47-4b2bc9af497mr334126b6e.9.1787097491785; 
 Tue, 18 Aug 2026 16:58:11 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:14 -0600
Subject: [PATCH v4 21/40] bsd-user: Add os-time.h with clock and
 time-of-day functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-misc-2026q2-v4-21-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7008; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=0gOFrVaT36VrlnuAghVKuW4loVvp8HHzs2zcO+k+ZLU=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFAGI5Afa2e7KacfRyEfBcbM9U/RDEyjOHGN
 Zq0nyj3GJKJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxQBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQCtRxAA47YrgckialL/aELxB3zl6XbKDz9dyEH
 cuAhj7rMFB0AwPPKlUb+5zUJqKC9Hnds6WYR4zuKQrOZkUUjZ2xVL7jBiVfBSEeVmwxYznEUoGi
 5b2hvjE1weoWLE44ZyKwEl4/63Cj8z6tqlcrwBfAULHl5/k1hRzZtXXenezV4LKixMZN2W91Rmr
 /S56a4zSOV136uetXpVGnyu89ETqHs0bjih64ZZqrxsklU3Yax6kSuVHZK2/CGskEDmhqQSsEi4
 MvwCAbn3oUyXkSoKkrzSEDWfK7Y1q4roGP64MWlurZpkLnzEoWOuuvEPHSZ2093sa9Ufy9ISWkq
 tghbWFxIHE624XzQR+P0fSpgVeoWzMHmu4bOjdKkUsIrfbWzpD8/TCjxN9eCZQD50MMCpYuX+KG
 sFkAO4raFzp2WsUj5Q0clfv5ZO6Ueow+zDb7w2aR15u075tcofmbPP8VeiDQ9cNIPU9MAgRr/nG
 78kcGukIBi0AME1+TYMgNqkTPENdVyzTxG37Do0f7hNnS2vNFWjxszTd8GkmZ2g8OjpiFGQVcOU
 UOG4NlXz7gWFSC7bh8PzNCuIm07DOQ2mboYP62I1AvMm8q9KI4Dqp7ypaEokzzvlizl6fT5DFtv
 xlS568/f3anESt8+ZeWSq9egIiehRwkidfZBHsN7/KFQ4Gwo0cnw=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22c.google.com
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
 bsd-user/freebsd/os-time.h | 225 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 225 insertions(+)

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


