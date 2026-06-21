Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9258BCDB46F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hS-00034Z-GE; Sun, 21 Jun 2026 00:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hM-00033H-9G
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:20 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hJ-0005GR-JO
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:20 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6a0a38a013eso2732365eaf.0
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015736; x=1782620536;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qJdpcnA/pubOSjeaUNEhasCsXKeN7JqeeghV9uwvoN0=;
 b=KYrj40PnBbnWeoRJPy5pjQs4TAa3+3O+2jAMiMfWtPW7Lp/yMPjFWtgYfDconOxsWI
 FNMG+UutjoRRFWZlkcMJepaHtj4mztaN307T1Ppm9G22i5HSWbYmgRdmP8MV7n6FHZnx
 lmWPGcXK2LNXsE3rNtyY17qBzJKIShg9ONVk3xiddpkd10CcGee8AxGJ4BlM71LwRJSE
 pLeNJPS07HUygYl2Go/DlBdkAX8sieh8B+PlSnN3VT3LFbmU8bNsU0HrfKk7Yj7evBih
 naXUvW7VP0saEk1MbAJsLRwE9q3WcZGh3SsE2+xZJd1D1CaEpykpLoKMPPkwp+kITQWg
 t71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015736; x=1782620536;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qJdpcnA/pubOSjeaUNEhasCsXKeN7JqeeghV9uwvoN0=;
 b=BX6/qnd9iNUd+ZaNRHidtOvK3aD4puzdVzIg0pN7BBlQjN/6qo3OP+BzWXgnqj+eDD
 xBCzpXHpGfm25usTjYZS3js6r9sbq3Z9BHhwbFNMELFgc/y1rudcTrZpPlw37Thf/L4B
 nCULF9/jeMBVviyIPOxNwQX4H/bEHZ4aGsn3CMm9OuhoW7t/K8jqayfr0wKDy358Jjmw
 cNOhBAmHp6bJJegEB9/qiO5DlTzTFdZpwiNWfAipSyUyTIQlHph/LQmOSbooAUCGrS6l
 dMLgKYVtVI2iQnrmitwo7UUvynApqTJMuXKY9hm6mjuu9rwa4v1gbCFMKD3KpEsRtncH
 joKQ==
X-Gm-Message-State: AOJu0YxUfYa29NecSbKpwwX0hAlwg9yqTSWWfITUsKsLN55fXK6iYJFe
 ajURQc2w7Ut9cR5wxoz+bnHLxh5Jd0JHkQhV02ijJxEtdhcjWpAWorn4diHgrNg/y9Q=
X-Gm-Gg: AfdE7cn6gmA/gWEsb41vUr7Pa8FDvGZ49EP6cXKchBdlzNj4wqRYpU1AYDSXIRActU7
 H6QmSF1/PpuHtXXYBSvHVgBRj0f/6TG6w4G6G1LmncUQre3PBhLbwkDu97wAufls0N9Bwc++Xsy
 XkxcpX/KNREkNxodWjxZKqjmSMrlj+DYkxbdaMvIcJS06noSnrG0dLiOQsXZ212DqPsEds5DBZs
 i5bU/mmx6IMrXFu9Radue2z7ARrPmoHkjK/eomX97fJSIXMNA37SZV3bhVPfSw2D/CcTAd2KsxF
 c/L+OXVP+wpc1q4ZFcwFVAhka4Al0KGoJzTO52lSoY/cYJTeqgyyj6QiEihvWAoJGrbr7V956+m
 v5e7AFV0p7iIt/8mZ0JLSaBXLbLAoXz4uklhfVrrElo6CNaOk6QfhBKFEpkiscuN1t+Ljlsae9G
 o=
X-Received: by 2002:a05:6820:81d3:b0:69e:3360:6338 with SMTP id
 006d021491bc7-6a0da0c155bmr5704070eaf.13.1782015736275; 
 Sat, 20 Jun 2026 21:22:16 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:15 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:12 -0600
Subject: [PATCH v3 25/40] bsd-user: Add time system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-25-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5728; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=y3Vuu7lK1MqMZYO2mhPEDp/h9PnmLtrlbeRS6fMLxGc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z/ZzFAEz+l2ztNNvfOEk/3vXnJOO9EgVtBk
 TBRWKpxgjqJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfwAKCRBsHNEofbAR
 AKBwD/97NQqFj5diIIfG4Lb4Cr0wSoO7XgoxucI3OoXfVar+31R8N4GbrCYpPzyT4GHnhwsH+ca
 8Bpt1BMfL7b5Kvc1LScOXeHy53jJM/akyOYywdD7WPzYnl1FUnF559kk3B4O9Vw0Bk8ONx563CU
 j+J/BMiD8JPMjM3lUCJNN7739SJyCeUWer2S++1M9AxJKiPDhP8IjBd/c5iLBm7HgrV8WPDsZbb
 nJXoINYJ76KwHr7T1ZhwuGZ9LGRdCSY+W1Jpu6Kl0UwxjkjVkWauvWuBu8Lau51EIjXK28sYmv2
 bEQDkEwgIHm/eFlsGaMHB5scpYT94yXhtfrkRmjd18bL0f2hNvsKbfJE5aGhAHhtA3+vWyvHafd
 BM7qxfeJuMSg9awVW20dlw+RwcCfL97ojEZOQn3Y3ni+rwPaFLrnyxfxKxIShChtPpyrS7iK068
 kdeTYV2cGgtF+FtK84B7exQMBx1CBSoT5nEHgTHoLUrv+Uw/DYDl+GDXw/I8stUn8Hu6YQW19nJ
 nTlm8DPveya1kyJpJ1We0x0BxPariP9XQ/0x+1RIDq+kpcnVwm1PUdLDpbumjnM38xaUE4ma7Hg
 O0hzM1xM/BTDzRWAtHDp2iKfks4yoZ+Xsjot19QfT6aHZ0jCc4WqSWlhrYa0SVfY4pYHNfFR1um
 JEi8VPMqglkzOpQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 020d16fda3..cc66be3b7c 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -48,6 +48,7 @@
 #include "os-signal.h"
 #include "os-file.h"
 #include "os-socket.h"
+#include "os-time.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -1037,9 +1038,132 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
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

-- 
2.52.0


