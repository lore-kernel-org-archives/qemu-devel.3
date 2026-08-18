Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7407C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTgY-0001wv-88; Tue, 18 Aug 2026 19:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgW-0001we-Qh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:36 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwTgV-0005DD-8F
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:57:36 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-455ee8f529dso147933fac.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097454; x=1787702254;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xb+YdlNPBadeoze7HAOEC8N9fCWlgAmWnIBHdbTxjjg=;
 b=pOEK2Zq738Nlr6swiwK3OQBZRhmk8adPvoLq7KM5dV86OFdFH2+7t9V5TXRp+MPZV9
 HDe3jCIzqsPNF+jWLcTcA+be9tZFsLLz1J8ZClEDSMde7ucjOkoTnmFqW23RFHO7wbjl
 jV+m2aHE2H3s3y6hpXcg6zVdmOOIKL/RPREGSu2YqyIEFOBihvbZBtQtHZ8JpX2Vd/4Q
 i2IFbbyr4PdydfBavYu+sNvMKxPURlOfAbjgT7W6bLWAo5Ul+adJN8Dg7PqtEykapI6S
 nDw4kCAom5hG037+MllePFryExkZxATiv8foBOIEbe+DD/zfhY2s6An3nmyXniPkiqS6
 Z+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097454; x=1787702254;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xb+YdlNPBadeoze7HAOEC8N9fCWlgAmWnIBHdbTxjjg=;
 b=D1auRZSBfrMGHK4e5Lxf4eA1Fu1slzBf5db8XMv5n9U/3wu9CV1QhCx92L3Gh/gcID
 a8LAIxfyyjtCk3JwW8fkulIp7+JJyiE1nE9cdfrHHhcDDV+/JGh2STtEqLEfm8kAdkHn
 FqaU3zHGR7YSL9md7nA8zOrLKzL5FTwEBLRMuazGCdDvfjOXuT9LqyfOO/DMno9kzCNQ
 QJ1/lYv4M7JDZC9KFO94a2An5b7/4pPK6fpAXW+Aosy0BkEFVkeAL+/61Ma+LD9Ioxzp
 t3BzmAW3oFlQBFdj49c2MYHyofNz6sa2EY3L7QvlDcWKnU0APSJP0ZvYpMH1Q1reg+WZ
 hZSA==
X-Gm-Message-State: AOJu0Yzr7OlE2gTPfB87d8yWcsnrnHT/cHhc1uh76PkP31uFd/87qL36
 0HoqwwITAb381WfBHdl1/o2UUWDoAjVk61NzdPNjUm3qHL5ut9/MOCSl+msMvIlWyBjy2NyqmUv
 foy1l5Fg=
X-Gm-Gg: AR+sD10+WXoi9QYIhtSPi5rtlsW2zNHwsV7zn4/osTWKxDkCtOHWZbNCnJV8N2Og9Bt
 Ec5I6bqCMaa1nbXLA1wFO7Jn0EAii566P0IdGXaiIxM+OgP/nDtUBtz1XlpXpLBIPEi65tNm394
 GykNoAU13dPXx0h/YHSMsWZrpwddSuv21wz+wfsQiOJDfdkgfTgX7iVXXGEcwowghdo9v+s1ev+
 hW9lN6Gk0wgMmeSK7PKYKpfuOIjE8GHZFKKoYbZSEd0ij/BdnsBJDVOx6wm7Bru2mmaDCr6rBsj
 9N6wrV3tuA/ujYNS+C/Y4RQJeGDxa2oOGHodu4GJ6dn6w/VfON3BOwl1j71vc5tCujeHJnChFcB
 oBzDFgHyPOx4Y8k0tIKde239b3PuxjdUqG2ISmP4Wk3yXnoB8Ru5rMgWG1pX5RexZWS49R4YtDH
 ZmjpnFY7z5fRc292yE5sP6qObQXGdCQNluIJDvS6UO2VYR6qw=
X-Received: by 2002:a05:6808:4fe5:b0:4b2:69a1:26e0 with SMTP id
 5614622812f47-4b2bcacd70amr399948b6e.15.1787097454061; 
 Tue, 18 Aug 2026 16:57:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:57:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:55:58 -0600
Subject: [PATCH v4 05/40] bsd-user: Add signal system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-5-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2738; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=36BJktEl6AtJLhxPMlpnlHsCaLT7KBc84/1auyINFA0=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPEm2CQJtotXk19JVdMUKS4rjkvJ64IIsmCHN
 7XV5PmbXkiJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxJhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBbyg/9EVUABfX/JTANAjb0m5xUsrDAAXUuhps
 AZolyWGq1+e/uTUWqf9DqLnylE7xvq1QN0uNXCBks4CiZCBsnpGu3Mp7Ta0H0u5kl4/KfjMOlWe
 ktaTdFEuk3xKWMIL+D8FAMVBicgPBCHSJm+jt0FJhjAWLgAqNrRg8VUq6tdorSPnOLlY1W6bNXr
 ND99vwngI+EWj5o7SP0SFsH6VGfnOXMeh1r0iVXSU/PtvRahDJVKJiBHIOraBpp+K8kowi3iSlm
 Ef1Z8IKJ0T5tdng7/CeDuHaVnloJXt1shbbFVFjodfr/dOfB4bgaJ99jBviLcFvQ0cfGDHnp8lc
 FBoqhQP1qq3QkueETca7Q2AoqpYc+HPxpLtQceSusK9mfItMjljnD0TnO0xTX2GJmAdZexOsg7P
 0YelxDQ3XgGasT49up7HJz3NzKk6TyCbimM5mNDRbJoyXwn8NHSn6DPLdh6JpAestVaMk3XA0I5
 I8GhQfnZ4+ZX88ZsXtQ10+S7XnAY2XTbAuyQiLnv3YVCMmoAcwSjyOpfIktGSgI72xwBPUIj/PJ
 3OgX0hXVhFsJ4fy6h9ILHxOhzUk8+6h55K63fSURlggfRy4B89DgB5+Z+QBeRMRVlzueCnNxGb+
 LxnQmDxLuwgug5UbXDo6s0cnVpJGIiqU2UT7zQkUcR90LFCdI8to=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
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
2.55.0


