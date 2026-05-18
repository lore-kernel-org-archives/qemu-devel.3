Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EAFCD4F56
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5VZ-0000Tm-La; Mon, 18 May 2026 17:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VX-0000TT-DK
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:15 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5VT-0000UT-FO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:13 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-47cacb4ed99so1829934b6e.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139689; x=1779744489;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=81DVU7JcCo7Uv+OZ8nvEUHmEh8rFjVkk4TGoU8OO4S4=;
 b=O8sdcEpnzuBZ8HClotxSlsdrVqg9ZDgPSVP6DxckCKJKPo/K7I9OXJ0qM+voy4Y02c
 +gJppe5F7dBXU1FDuy3Vm47snBdKKCaOEJ8PIg28Y8WnaKOWncycL+KsCNdfGN9SmHmr
 MdOTRU6eKMsGuNiQ0o17x6YrlVG28ziKZZpkHdg/r/9lYxvupQMeEyaF3/N6GVimoZU5
 Aky8oMtnRhCqYw0+90OGYLe8+TM+NrKIFL/VyePokjte0IvsZnfCralUH26vcUVrMLV4
 pOADkkW4hB+fDNx2Kkinwzx1YNxS60B1ejn3ezDc5S22opXyu5iNRJbXAMl/IEFa2x/X
 PHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139689; x=1779744489;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=81DVU7JcCo7Uv+OZ8nvEUHmEh8rFjVkk4TGoU8OO4S4=;
 b=Yg7HPDgA4f4lbdb/RqCp3zmmBOXo8F/xb+nLgRDO+dq83gzpEVdrgMXnDmxJTk5rcW
 4GRAybVyxSgAXTijIRiZ2QMDFI/+Pj4d7fCzB7WUrF3DB1059RGMeF6I/Xl7n/lo/Ekq
 M7xbGTz8szY69jj7C/UjOf+E4As3RKV9dJbQ+vc0eQngG5RKZwv6azESMH5bXBgQswFR
 eW5/RMT7kkI31tM/uob92JFb85rwQU6vkFKErd9b1znYfrImZcK8A755btG8q1vIViC4
 COE8C+7iWjuNYxdoJeXkxQicEpnnzhon9+MrUdp/r7gQlFhjURBXSNqfKZ1s15hk3wmL
 XjbA==
X-Gm-Message-State: AOJu0YzEvb1Z6pXix23T1NraLxwxydzrtilPl2MT/2ledQix+klxoD9J
 7y29+jS8O1tNMt1Ubfe2JWsSWv5eKz53GYzQUWJObDPImG662xg/va7XLX4zie4xIlg=
X-Gm-Gg: Acq92OEsEAXhx7o6VUQRJTiOd5XNmBQqLqKMd6BwOG4BtzeU42fQ0YUQEx3Np369zei
 /gRwNnHTWRgWaJsYARv5PXUnDygvk4gILjbGBbGFctAuNFK5WZpf4HOQ0fTBes1DYSH1aXjSbdS
 snHu9em9sQa7x0FI6wiYtwMEJ15h6/GJgoGHqXvmPP6iMpsegM1Twar6oZunkhefgEWqsQe+ahh
 9aPZa8yNI4W6tuP445VJ7BiqZXhxl22y1FFOWNRS4qClnstJeqJ6u3enceIf6odTGIqeSnwAkhi
 rbqXEw7rV/ymfxR2pe7eAl3uLHHoVafovz0M+ZIzLwF9KpKxDfuw+kwMaDBRax2Cd13nC41bEyQ
 Pbfa43rDjf5pF6ze/kcI3XsYjSOnP6h97I9k+lg0dA2Ex/OBidcmvmpzgUKufbjqiH6VgiS2lKt
 e7L3/djJMqHguJnTxReRvW
X-Received: by 2002:a05:6808:4fc8:b0:463:efb4:f9a2 with SMTP id
 5614622812f47-482e59468bbmr11112428b6e.28.1779139688948; 
 Mon, 18 May 2026 14:28:08 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:35 -0600
Subject: [PATCH v2 17/37] bsd-user: Add os-time.h with clock and
 time-of-day functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-misc-2026q2-v2-17-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Sean Bruno <sbruno@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7793; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=m//p52qNBouEG3rg+3PIxl6T03rB5SiqGv+OBONuHk8=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RHphMMt6sZI7C/TmASTYIc+6tPRsR4B+DnL
 IYoZHYtQsWJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguERwAKCRBsHNEofbAR
 ALPvD/4xgQGamKqw5qVasshVJtrp6GZIzXor6ntLNJFvKqmI0peQdzdSEWqHkSuvZLZzTFIdyZP
 P9Jd+B4dXuNBLEPROdOnfp3C9Dam/k3m5AS7F9jzCn63M0tE0K9sc0bWQyUC8maWZSsG5GR3Ktc
 dFzOsZNGPNpKx6izMnyI2mLUrF+qUs4MlCYNBwFlFzF7tJyMLNXfhvpakYo/piuWqnRVUzsCDsq
 7G6nfLlxJyrWPifR0RAWzW5pJj2W70jlHKWv/VCL5M9KBUkqgeL8hGra4MlRZC14BLGC1eUvjbz
 d+YZmxEGSB0TeMSa6i1/JEcnp6vlAoiwJy6TGQvmAjSYS6lCqESWWViPf5cgK2+D1k7kXlNqMC1
 psiGeFxyL73n3LF6zyRKLJ3KfGBSJXpB6fZVqJiqHUkUaug51qqR6W7Max0wvdZvRwTvb5RxScS
 pesOZPyG7sXmZEVdQofY2gmjagHfrrnDxN3470fpdDrRg02NDiRp0RfvMLrHxiwEoSr5iP5zAiy
 BkO/l7uz8/Pj8Yjb3nkjvhlbnPhblzsZ3OM3roH8/w0RL4XRlNm93ay+F9KxMAIEmaiymD0FTTK
 12rWMef+7rHUHYvA4OckUV/ASKx9ELqEg4ix4fkEXQ1plo7sPs9M/8QrbOh5JFwsKSZWmxPBxLh
 s7mAgiWxm99nesw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::232;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x232.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c |   9 ++
 bsd-user/freebsd/os-time.h    | 221 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 230 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 5d3a66e360..6fbd2da261 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -89,6 +89,15 @@ safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len, int,
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
 /* used in os-proc */
 safe_syscall4(pid_t, wait4, pid_t, wpid, int *, status, int, options,
     struct rusage *, rusage);
diff --git a/bsd-user/freebsd/os-time.h b/bsd-user/freebsd/os-time.h
new file mode 100644
index 0000000000..16b71e6234
--- /dev/null
+++ b/bsd-user/freebsd/os-time.h
@@ -0,0 +1,221 @@
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
+            ret = h2t_freebsd_timespec(arg2, &rem);
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
+            h2t_freebsd_timespec(arg4, &rem);
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
+        if (h2t_freebsd_timespec(arg2, &ts)) {
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
+        if (h2t_freebsd_timespec(arg2, &ts)) {
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
2.52.0


