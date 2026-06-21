Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766B3CD98F0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9gu-0002ve-S7; Sun, 21 Jun 2026 00:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gs-0002v2-UM
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:51 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9gr-00053r-DU
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:21:50 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6a0ddedcd00so753389eaf.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015708; x=1782620508;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iZPcdsv0Y6loh0IkwO4iwB8tZ2b1qwhxFkRMVauSAoM=;
 b=slZDwCNP8C2Svq4o1MMax0ll9FHC6BOkyEVrBYTiiigReOLte89nBh/A3RvVhst3Vs
 5I7Z1HCCkvCUCXZHnuOJPXp3vTKHcOYxsBvwOJQlo9AB+X0pHgS9CUthpHsfRbKTW8aT
 ltN2n4qS8O0HVCI+ixZ5fWzqSxMlQ7nnLF/YILXRg6/BB41Wuz5twuy9vREdZvI7UFcQ
 QvJ7WwOeBNFRf3n4RsqxvveSWAWF22bB20Ux9dOpYhJiTp16r4WfvX1lgbw+ALIrdnH4
 gQno6olemzqA2Gi2bPW5mHSdzN1mLVi8T2PeiFgVI8u+qXtDkeFpfuerZCA7oa8Dn62r
 qXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015708; x=1782620508;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iZPcdsv0Y6loh0IkwO4iwB8tZ2b1qwhxFkRMVauSAoM=;
 b=P53xyBwe8nwXbbb+ANFxbX2hctnzMD9vNTuEODEGEzTkcdtp50YtOgMJIjzg1z7T6i
 3JfU39P9q/N7aQgH9Qfp7pOb/SMU0jE6BDDH+BxGGSzYuxeYwLvYWlVm20ipRy7/LkgC
 AfRI8B/t73uWlOihuHZLPpWpzrRMCmlC0Y28uQOOtriSv28OqJrkDNRn92SV9cBQvtUn
 JL+zZFWKGkB1NHIoOA4v2LEnEL09FLy26KIKTL4O/91OsCjWPZ4eP0SY5zJhClQYYFpx
 rzfFqosdgBITFXgfadnmX1ecFSTeMX+ef+p0fsBwqgNyOqJtNlKil+MIha7Ik6Ti6K5T
 C9RQ==
X-Gm-Message-State: AOJu0YxBeyzu/pwyVPiNKxoaCxQdNe/XoNzgqQzzTtGVz7nRkH0E8FIS
 ZlU4BNPpX+P+xAkWLESvzbJQW9a4GiMgcP3UlExBVk2wxb6+52QQEk30FIqCx5F2O/8=
X-Gm-Gg: AfdE7cmByaX+60R1dlIU/hqerYwfKeoX2VaoJn3zRNMHZi2Tz3CwSll1Awn3m/UHNPH
 xfSe1VG159k+SX+p3tkL39y9QUeJiKacsIPcpUSz6g8EAnGu7vXzmiTn4WEhjVChidtuOVTkIlJ
 3OUOe4Xcd2O1e6/5Xgceat6prNiTR2fdYqHOfiSbLs0qoSzJ2Ndg+ktH8kSD13y/Xe899Am8cwz
 2KHr20lpyDiWgg/rYxLiVrAybV6ndpkCVFdUqerozhCM4DS+DjHvlsg6Sa7kD2xMVTdbJaxPcUC
 MVUuizXVgs7YSIabRmYAU19/rutgssXbqqllZnSGpbMQ3jpr/7TYtd6TcdyB7wHR9eR+pV4Q3A2
 mSOuiOWUYHxeAYg4AUdRyMTy9pOa5TQyF0eZ7f2IrDRhy5b12RdZvmpKUXwz1cVX4zxdIG0fBmc
 g=
X-Received: by 2002:a05:6820:138e:b0:69d:a224:6ee7 with SMTP id
 006d021491bc7-6a0d89d1a64mr7727314eaf.54.1782015708130; 
 Sat, 20 Jun 2026 21:21:48 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:21:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:19:54 -0600
Subject: [PATCH v3 07/40] bsd-user: Add signal system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-7-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=4Ub/2xph8KTLMe7XHxz740Bfv668ZuKAhgHFetlKwm0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2Z98r1/DpFIEauw5O7pttoWFmz3S8r0QuwLS
 K8SpNAD4BeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmfQAKCRBsHNEofbAR
 AHf1D/9fe2B3I7FwDfkXGru5n4JSsXiXFiTp3EXB6UjkOHcZlBEuxbApYtwLH0XjKW5JpN+EiqX
 P+x8JQCUe5z1WzpOPjFuUzToWZSgQoYl2DjuDOAQUPNzO71FjMPGHqGUEV59I2IsUhZr7MycGG3
 J6pG0R+sNdui6Gwlhy5I5ZTgoXrJmOsLYdhNvKXD2GIRUECjOWN8fgwF/B6srFxQsZm8zKCvPha
 036/HvtZpzb6rI2AxwFyRU/AVPxH9PwV8PfgQiOjrTz6a/6AdvO9+NOXZ5i0Bl2rF9cHiuw3wSv
 biRVdxU400NaY97dm62Dz3mJLgfmYVNu8ySW3X3+VHRnsSkbw1GgO04wJD4fbqRpr7OvZitucXD
 YVnEEQVymaHYRA5IIdMwkOWWY5+uXpNYI2Clv4ZKOakfAPSQ46ECxlXqWjIHIAzMPUu2D77CyMO
 +ZiQvxzCyHa6HykOeZHcEjapaDGscFBD6MKRuV6rdNT3vfkxnLE2Yc2aTK3qctCXDR5l/r59QBF
 nDdZbOZ22fIBUgQqusHD34OJR2JxWDnMXSBPCh0MmXM+q7JTXFL4BYtdt9dmsU0gcmabUoQGp6z
 yxLxR3vDk/05XQYyY68AAxzBKvA1KvRdB5bujBQEmQNxMcQMKEAKg/j91lNXdE8nnHmxf681clO
 Bnx6HZqXIC3ZoLw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2d.google.com
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

Wire up the signal-related system calls in the FreeBSD syscall
dispatcher: sigaction, sigprocmask, sigpending, sigsuspend, sigreturn,
sigwait, sigwaitinfo, sigqueue, sigaltstack, kill, and pdkill.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7fefdb569f..06148fe3ce 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -43,6 +43,7 @@
 /* BSD dependent syscall shims */
 #include "os-stat.h"
 #include "os-proc.h"
+#include "os-signal.h"
 #include "os-misc.h"
 
 /* I/O */
@@ -950,6 +951,53 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_getdtablesize();
         break;
 
+        /*
+         * signal system calls
+         */
+    case TARGET_FREEBSD_NR_sigaction: /* sigaction(2) */
+        ret = do_bsd_sigaction(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigprocmask: /* sigprocmask(2) */
+        ret = do_bsd_sigprocmask(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigpending: /* sigpending(2) */
+        ret = do_bsd_sigpending(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sigsuspend: /* sigsuspend(2) */
+        ret = do_bsd_sigsuspend(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sigreturn: /* sigreturn(2) */
+        ret = do_bsd_sigreturn(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sigwait: /* sigwait(2) */
+        ret = do_bsd_sigwait(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigwaitinfo: /* sigwaitinfo(2) */
+        ret = do_bsd_sigwaitinfo(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sigqueue: /* sigqueue(2) */
+        ret = do_bsd_sigqueue(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sigaltstack: /* sigaltstack(2) */
+        ret = do_bsd_sigaltstack(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_kill: /* kill(2) */
+        ret = do_bsd_kill(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_pdkill: /* pdkill(2) */
+        ret = do_freebsd_pdkill(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */

-- 
2.52.0


