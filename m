Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7C3CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vl-0000XO-6X; Mon, 18 May 2026 17:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vc-0000Ur-Vx
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:21 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Va-0000Vq-2y
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:20 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso2948061a34.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139695; x=1779744495;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8Ux4G6M9Fv0nwLtFscsvZGnjN/b2cZpTTDBQ0OTQp0=;
 b=LQPet8oXoEsO9mFPu2hq5G7wCqkZ/it+SyQVk2tBOubTQOb/Y85lgCPgY5AYLw32Y1
 uZLYkDEJeLVpViwm+J3x65toqc4dbb7x0Oej8Ucp8dM5NPKRL/SeAflv1f6cItER0t2d
 NWwuZ+6j0pRkwx7KkdtQsWbaOLd6LV6U7ZxOy+dwra6YiOdkr7TbOgab2Af6qjBE2VrB
 1isnKo97+DZrjUkcZfPEgPtLg+xwjBcc2Kqkl/nEhc/Mmreirwb4DQUi+1suF9km8ABK
 wJrje4j4ro/Qfs55x1tdP5jMDR52EpOdHQesqjWbK7f7doYOq/We7EfMbpJpG4R8IVA6
 HFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139695; x=1779744495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+8Ux4G6M9Fv0nwLtFscsvZGnjN/b2cZpTTDBQ0OTQp0=;
 b=htdC0MY13PAqu5xgrAInctwB4cQyDBqp1uKy4cR+1XwtyeUGYNdcCy+C7KjJJGm031
 zIt7pPxP1hrn1uR2RZDQcDdxfvgRwrpGZoMh1gIYW+FaswAH3N0nx+Fr1k/zZOvKp6EX
 JK5XJ1l+lCnptXMfVIssd1OnTWkCrzyFepPf1nm3z3wnEB5stkZllKbxBvbyQrKqLw0r
 xhT7XF5Pe8oW2hfjZlYKNTclCXjmS5vJu1kjQkvmVmsF7MXyLG6k9jAz9AW99yQ+jXtc
 wJgjRSOt3hqimsHEjwbEb356sAiUCtA+2pxoIG5+N3kBBHU4WqcWtShQl5vftWCIEsdR
 Z1zw==
X-Gm-Message-State: AOJu0Yzn2EgCyzDhFCkGdmuPzSnwvUkGUyIyiZDrlhM5NFm5J8xvmkD/
 ZLAPOcdUZePJphNtbhl9EfsU8w5hG9OHoG4VN9DTSKj69gpXCFyM6maiQn9pbK5rpSg=
X-Gm-Gg: Acq92OEEfKBUsjGyGP9UGJBD/peC5evfaGAbhxQZrqG0HP70ERAB+QeIvrG3O1GAC3U
 oAKTcZIt7/fJUU83IzCVjCGCApbCvBznRufQMRA743lBZIobQX0ji3aofrhhsQZv2EV/VgM11q/
 doiE/NEkPLe+5bXCOOlVtIeg2xeFWckUQzvYolW6ON3lzXRvd0s/J2yiqzcLzGqqAgvacXQbP9k
 FD1IlmX3KF142xAXFP0vbdD8c1U4daAGcexvWrw3MhouCy266XdBzpg71kj7Qw3LcTchqEITWs9
 jJHKE4qr6Fb+Q4PN2sJPtezGiaaPCJh4o2GKYOOtYtEy8r9Sg1cgRv04Rq/fnKT58PeOQxK/VbL
 uU+Vf+bQfgyxCiBr+M3QrbbOZfIafseCz09lvDk0/0Pmd8JYl2zqeFeZ2lAERJfrxLpz6+sK8Q6
 p4QTgzfXIkdA==
X-Received: by 2002:a05:6830:90b:b0:7dc:1bcd:43be with SMTP id
 46e09a7af769-7e49a9379f2mr10129938a34.5.1779139695293; 
 Mon, 18 May 2026 14:28:15 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:41 -0600
Subject: [PATCH v2 23/37] bsd-user: Add time system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-23-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=y/M4lfN1u9uogW+bC03bPRccqF4MOtoBLBj5D18mpLY=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RIFYh+m+c6vLv4b8kqiNi45fNu9405XPeVT
 lruuhra0L2JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESAAKCRBsHNEofbAR
 AB2aD/4poG/I3X1440nqhNS1my7JsoSHgRqW4BRX6m7imf8iiSLeRujmPOe/fe/Rq8VCn1TXHuc
 TSOIc43cN+ayvHgK9l0Gel6jR/PWu3FtUFKzuyn87LMSF5XXC9Xv4F43kDO/s1UvMMyejPzhsYW
 WZTUrOwi+crgfNHEU7u+e2rdRVBVhVi4dBM+oTUVAaaYSx4Tf99teRrAxW/eGaadvsaOh7ke3Tg
 tpYNThb7IA42QZvzh3cvCGdtLFxInBIlUq0LK4/MZq0hd0ZRf+SrMSpNTEyDPYLdgxNYEXLGV3A
 mqJcLRNzKoRDa5jkA3B9uPEMtEGfzeIAARS8w3L/V0H+J0yviges2N42sNwrQTeKlIn7T89dWiH
 f+DF9aUvdAQJPt+dBUjQe04DnLUgqovaxM5Jk3Z21h9AJvFJjjkX0jUO4gqyodoJ+1lee69Gmc8
 FjfWRvXza7ypbZSQdBV/XoGQC74VS7CLs9rRi5oFWcyWes0eEG74jYbEl/TWA4ougCLFc6uQiud
 Ig/u1PwS4qcOUy91hLLrwZ+gMYzED91eenXuxe9G4g//EwFSTaPwXausN3baHsAl8Tm3a1I9BNQ
 Lwa8APyM6yVdyzfsXqX4gpc0pY5QPyXzk8ri7SnYKKVhvDUZt4amAiAVSHTeTjLF5cuiOqgyXEL
 HGm21ybRSBS7rvQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::333;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x333.google.com
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


