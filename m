Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AE4C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAR-0005aV-61; Fri, 18 Sep 2026 00:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAK-0005Yi-DB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:36 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAH-0004NM-PZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:35 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-805bf8c2661so195644a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705533; x=1790310333;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9olzYjwumX7R7LPQVvbR/Zq9y6lTKJ3ONx88TImvWwg=;
 b=PPaQJMWjHHAIlSZsii0I/cYQp9o8y6gcTcaPdRgCO9WYQYeh6iJ8gOjgUsTu0iNU8U
 umtJL7uYAh232Yg5rqe5sF6jRpU0+JeqLcXVnB4cO8O6OgJRoy4oYrQJHk1gcw+EiEzX
 3R7wQsHl1i5+ys9zMiEyLP+k6Am6hDCeqEZX4HP9+GtsZKYTK622QHPrb8Fw0PrhJJ7p
 PfAzt+fVvvNLhrKSDrmHxTqlHfSeYjrV4OirvAMgsqqpIt52vc/xS5d5qiNzmBet2/Tf
 o25pB0vSlpD2txi4z5CNEaa7x6G6P6ELVi42k9Ar/Rju9rXDW1H/Y3vrTXLC6K2132P3
 LsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705533; x=1790310333;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9olzYjwumX7R7LPQVvbR/Zq9y6lTKJ3ONx88TImvWwg=;
 b=ob9YUvbNG8VaQBEESbf6egOLLE7dopzJvjZGLsr8sR1SDcm3LBnaHjEjmQLK7O9Pr6
 W+61bI7ng2Lxi7R6BsOs4QenNcLqRUFkWdWtVvYYNJ1sUqbOo/Yzk2tzMBjP8RsWzh40
 fgdSJ2LM/auN1ZX2RwX9RaFfnys3e0Ih/uO61EGIwTLLrxSD0od6EWxg7enuG3cqK5sf
 eqi3hgP7Iz1gAuGZjSOsLal4jaoB/3G2/XIN6BjIriZF6tFPcyTb008BXaF3feCwdFVZ
 b3RrjU6tRcTHKpuTqDof+spDS63LpSRcaDLLEKq0G7+dhCToGv9LUCs+bbR17AZoY7Va
 ++vA==
X-Gm-Message-State: AFuF++nXcCfrI9Axrf17BwjqkcXBhxa9JDQkI3QM3gOqVxq/Ugh3vbTI
 1kThXNoYBTxptNwvFD23JO3SzYOwAFVsjR3dxff49rZ3pjndmMlHL/KX2iTpbljr9c4HTRXG8g5
 /DQGgf+o=
X-Gm-Gg: AYBFou0Z0XcHCmWx4+xh9BlWDZ6qwtnM119dA9ljOJU5Elt/TqzpcuiInxorbhhHwl/
 5Z+60d6LjaGOm4A4NT3XN+j0gzV1RVBFIRlYtabGLJrmuX8nzd8Nwpq4E9KInAmz98QUvSfRsuT
 6k4xVNsP2Ke76o7zzYhls8GjG787th5wNRYhL9FttJ3j8qYy0nO9VJIONIFUOp97pF7/gVnustT
 xphEoUwyo9K1/+qCM04USyfjJPlcrmeNoD5PlzwherSPWhuTcWUwBLQvpAV8e1i+zEPS7sQF+N8
 VF1s6LdeDCj99wXGgpNZfpgpz3W0CxGrCPhlay1eWJ24cNEaJFcvcQzxkw1PJdQ4nEIN0FeC4SR
 iFk6vKE/iRzGRH81oazpK8xl0aGQOdpwvxboVV1FKp9DOBxCJVrujFvpZlzN9vIBk+UuVN9W57M
 Uaktn9IPXcM2FhcylP3BLXfcQkUxX+1qbEw/A6XMeJMtWPKRpjRVJTgyRkbQ==
X-Received: by 2002:a05:6830:6aa5:b0:806:104e:b770 with SMTP id
 46e09a7af769-80de2bd561dmr1660507a34.17.1789705532771; 
 Thu, 17 Sep 2026 21:25:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 22/41] bsd-user: Add os-time.h with clock and time-of-day
 functions
Date: Thu, 17 Sep 2026 22:24:03 -0600
Message-ID: <20260918042422.38713-23-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
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


