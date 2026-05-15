Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC677CD4F46
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxP-0001hc-RH; Fri, 15 May 2026 17:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxM-0001XB-OT
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:28 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxK-0002za-Ts
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:28 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-47cbd445021so260338b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880026; x=1779484826;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8Ux4G6M9Fv0nwLtFscsvZGnjN/b2cZpTTDBQ0OTQp0=;
 b=KYQxR7ERD3u3B0QdzKIfKTg9gSYZeqgrfQnBy0WU0A9B3GqGHQjeN6mrnK9fb3242J
 3OXpOMFP3FtrzjqZ5h1yfBEkAJcct8p4D8ASAODKt+I6sC76Sd2L6Re5l8HDDXWrcokK
 4XnNa3cUp2Y0QUd+/HLBFOmW+n32OK4V7nhaGM2U0/kB87Ex0+SFlf9bFkJkXbBvjh03
 obU503YtzofqP5TIAZXtoyIWCQisXiSA0qC6IuuqrXidw0sFDFg4NZF+qZ/la++RRWaB
 6nb45ewIfi38gqS7gCed/sfGnxKGDo1FB3rEFkut0jlz8qO+Kz1mxg5HESJ1vUiU1pMI
 yxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880026; x=1779484826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+8Ux4G6M9Fv0nwLtFscsvZGnjN/b2cZpTTDBQ0OTQp0=;
 b=iqwbJCWv3vQ9BeQQaaiigLZwb1+HzzeyecVp3F3sEXbSs0EJKLNqe66Al+7jVkYLTz
 9XgmbbgtydpkvgE/YFcEVuH9HXnS8KjkwKqXxJcTTJhN5YbVASKYu+5XT0ahyLowDA/c
 QVf0DxjqK+lbvMuaDMdvfcWY0nHmOEGkycQFq5d8/eg13i7DW1+PbZm2v+AKVSkKwWLV
 Ce+VqovBYVQSWIbfB9oj5qGDXZe13Ce7lX6Mr38hmP4R2Sa8BaF9i55qxg3FNlFjHqIw
 Hk+hPC2TS6tyeqrLO0js6ttNM2VVgbM5uR+hQl3iNVhty9BO9aFx/JzETcfBjVFE40dH
 ocFg==
X-Gm-Message-State: AOJu0YwoO6MUGP++1sYZqzb3gQOplZMviJAOdUUGZmZlAPVgcpPNUCbz
 BhQby6h84zhf6X/58Y+0dxy2u+noNbHWNS6L844BaCFziRIVvpysVcec3bZYuqWcH6M=
X-Gm-Gg: Acq92OF3Ebtf4Hb9/UMQZpyDESIJ5XBguvrL8iN3PnQS7lKAwFCcN2d5QmjwnxTErlm
 arHBpXDC5JBrTJhBFFV3aqBRqd9vdiyp8Q9vQd6INmCyyLaNprRvar+j/fsG+gb18HWhEOlcTsH
 Ox3kunwalgYtbqtGmd5SpqiR7bd06mkSdQ6Y9Beud2AjBTvZkUFtsyAZ8/voHBk31+Btq3gjODl
 eXKOgU+Z0go3dUimhtwVI9yfL+vGezyxmSRSOQtJnFihAp6VNREvhgMR9ktdRCM/mh6H5/j/jf4
 0Jhn/49pSLKhsEiF9d8dtV4w7sksCGePoP0pk88Z6aJjvn8OVEsgHRlgzU58sGlRTpOHzUsZGPg
 BtEpffullqezcSuuFWNIg/t6B8oalqd9djzU0oqeiO1y3AvEAfhObxRoBG2bbUNpDXBg7R+1JeK
 QPswLdGW0Y66JlaNSbvory
X-Received: by 2002:a05:6808:3029:b0:462:aa0f:4375 with SMTP id
 5614622812f47-482e5789699mr3502449b6e.39.1778880025679; 
 Fri, 15 May 2026 14:20:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:25 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:22 -0600
Subject: [PATCH 23/66] bsd-user: Add time system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-23-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=y/M4lfN1u9uogW+bC03bPRccqF4MOtoBLBj5D18mpLY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43jUAbt4o89J4tBcZHNPMwBha2BpiRTP5Bxq
 kz1WAYcCaiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN4wAKCRBsHNEofbAR
 APKkEACo/WMlOHpMs/74M9a/W9kSP0v4Y45BLU/dwbq9ULe++Jm39iGeXWd0fRPWFSfb79AcTyP
 z+cdjIxRxdHfOEhy8J+n3LJvq2Cqz2jnoATK/nFd9pUjpCNqKH+n6/u6sGxPVvlOKDAIcOKGS52
 9db+kJuIqKjf5JmwUPuJKY80ILIrT2CpEE/nIiHwDjbFSKiD8mUIbpBTgdx1w+mQi8xgtrm37Ju
 Vy6vW2phwhPZ2ilwuSUboBqjclyVeuAp1eXJ8h1FgN0K5EeY5TtSznsNNXwkGyIy7MWu/GAMPW7
 llhWAOwJOYVlcQisuCpnE2J+ppUllDANukj7sbkIQxXOblD+Dn8O0ivZwaQRCAdnNHhhxcOknqd
 6cLhy/QaVHABL86k1cFY9hgUufIlJanxUeqWmD/CW83nmEwlfl60ds5PKV29UUUh/NqOnCEsUbF
 778bbBuEAI71ZhLocsD/NgN3jIoEnhmjlWKxOO0OLkyvpk/b3ZNbN+yXpkFnhvl7s9Jc+iFrBWI
 4Md/dnZUmRFkncYz7DDCgQiapV+RiuhVZkEVj/N96JjjP53GWxhfC0yk1o37/Xbr2ed+B1jW+74
 mI099mdMYszzSAw2qZ44yDjiYNo9Qv/TJws0s55gw+EBSNPkOD7hwLXhrjX4HeeBPDXCVZQMcdr
 Ip4yarOeF8XRcaA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22d;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22d.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
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


