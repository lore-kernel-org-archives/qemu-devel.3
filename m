Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87CFC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yHi-0005me-8F; Sat, 19 Sep 2026 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFp-0003if-LL
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:34 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFn-0008Q2-UD
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:33 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6f5fc5so803189eaf.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836571; x=1790441371;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hPSthJIovrntwFBfq1pmFnZ8Gyy72MTs0mluUnzf20=;
 b=ROCMD0x8WbQkSqkTsCin6OTBcXFeoUtubnZ8GExvW92fUBi5oVrxfM/RqONHH1DqcG
 NBgsozBqbR26O5VYEcKYpkx48mVwVP3SZsLSoQskUWXME3tp86hDVk11F+MH7PmUp/r0
 CjvNY1ENM1sXqgBdtp/cKVRPrkAsT/qF74C6Soa7ATA2Co4IadpnbWR9wxsFbKlYr7gu
 HMZvyuEIQ8MsqnuOumzkQsyNQqmRO2D5kKo0MFUer5iGQQ2aFPr3mrfgH2SAyEoaQtrX
 2ro6lsY3lMbwgpjJGl43iO9y/08daJiWwQ5qZ3YlCfXYlksEDPkYXDo7XdZyIMPfUc4+
 guuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836571; x=1790441371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5hPSthJIovrntwFBfq1pmFnZ8Gyy72MTs0mluUnzf20=;
 b=nyFqpAjLeHh7O9PeQuM029NijuIENgWWLFahXCvO0dT+7W/8mTmTL6HaySvH9f/JOb
 CevKBmibnus0s2CA2QuGlFaKJWnGsC5Ju+JWynnAGlUqGobLn/cm9AQ2pY2B0GZOKreI
 J4thL/AuezyLQ4v2Oo1MGD2viUadXNSpY1D1Nv8LP/XCnD17acin5/CjGjxxkmT4esNm
 yOcdrgdPOtD3SoXy8BwcPTH7XtBbmV7suQSwyVLcO7IutyoOuhKGWdY8eOPGeTii2FMk
 Xq6inSuQtu9d0GRGrfi85Dm56iQhvxp3PtgjYYWIkyawd+mey6z/l4rfOVZ2PkoKwUCz
 MUIA==
X-Gm-Message-State: AFuF++lX/k8T0ig/ms6IFZu3qN0p604bJ96lpcK4w3rVk8YikYTWz67Z
 wDLjpj9DrI7chZTFsY8jNeQ7ev084PnRCGiS1/GC92gA7oZgswzQ6WilOYPtghcHUm19eNr/lqw
 MHqf6MKc=
X-Gm-Gg: AYBFou3sFz6MQwPld8zmY7ayagp0Y+yOtNcLXCQyV8pNDARf5ZixxHqzPaZjwHRso8W
 6ZxzT9QdulH5MxK6cZrUUIsnnfPx1n9oXX4LWXb67eBhAbZdJ2oY9smvOtxw41EGgET9Uf9LR3Q
 cn39gJ3gp67NL6oSzCGTwZGiridpu5acd0bY4s94tQcLCz6mPLIOJ854hViur3prFgogEZqK4LF
 VeC+8+ngG0taiYS2SnFMUWX/w3mVoWcoFjvHeWEVmalO68jQXZhuADeOOhJWNgNTh/ReluMleYY
 NhdPZ/ojY1upjTwK5mR+werf4Yk7N3xF+LCE07FhVTt9fzAGDzAah4+el9Vz9eZaaWcevk56r6f
 nfqbUUpYEGsSRDEIANftHgk33wZfbx68tdE+LBh4EmlIOKcbqysSopyH+uiI3e3aT6esfBq3lXy
 P5gZcczfYbedo+TBCqcU/93nb+AzUpV6a4i0drOVxyQgcH9lzQiT6++hn7Fw==
X-Received: by 2002:a05:6820:c90:b0:6b1:39b1:80ee with SMTP id
 006d021491bc7-6ca9a849aaamr5065909eaf.24.1789836570859; 
 Sat, 19 Sep 2026 09:49:30 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/41] bsd-user: Add thread system call dispatch
Date: Sat, 19 Sep 2026 10:48:00 -0600
Message-ID: <20260919164810.70151-33-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
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

Wire up thread-related system calls: thr_new, thr_set_name, thr_self,
thr_suspend, thr_wake, thr_kill, thr_kill2, thr_exit, rtprio_thread,
getcontext, setcontext, swapcontext, and _umtx_op.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 55 +++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index f2c3ff25e8..0c729da0ab 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1293,6 +1293,61 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_setfib(arg1);
         break;
 
+        /*
+         * thread system calls
+         */
+    case TARGET_FREEBSD_NR_thr_new: /* thr_new(2) */
+        ret = do_freebsd_thr_new(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_set_name: /* thr_set_name(2) */
+        ret = do_freebsd_thr_set_name(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_self: /* thr_self(2) */
+        ret = do_freebsd_thr_self(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_suspend: /* thr_suspend(2) */
+        ret = do_freebsd_thr_suspend(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_wake: /* thr_wake(2) */
+        ret = do_freebsd_thr_wake(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_kill: /* thr_kill(2) */
+        ret = do_freebsd_thr_kill(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_kill2: /* thr_kill2(2) */
+        ret = do_freebsd_thr_kill2(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_thr_exit: /* thr_exit(2) */
+        ret = do_freebsd_thr_exit(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_rtprio_thread: /* rtprio_thread(2) */
+        ret = do_freebsd_rtprio_thread(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getcontext: /* getcontext(2) */
+        ret = do_freebsd_getcontext(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_setcontext: /* setcontext(2) */
+        ret = do_freebsd_setcontext(env, arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_swapcontext: /* swapcontext(2) */
+        ret = do_freebsd_swapcontext(env, arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR__umtx_op: /* undocumented */
+        ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.55.0


