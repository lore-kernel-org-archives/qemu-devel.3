Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D31C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QAg-0005mE-7a; Fri, 18 Sep 2026 00:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAY-0005c7-Qr
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:50 -0400
Received: from mail-oi2-x0e.google.com ([2607:f8b0:4864:32::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAW-0004P4-Un
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:50 -0400
Received: by mail-oi2-x0e.google.com with SMTP id
 46e09a7af769-805cc8b4231so149079a34.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705548; x=1790310348;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5hPSthJIovrntwFBfq1pmFnZ8Gyy72MTs0mluUnzf20=;
 b=O2mvqwrrDUDfNAcca2QtpUc4p7sHeLM+fvh8xNbMX8MwfVj3cPU6tiU6FKK9XMLPqC
 ig4wkaQxKBmuwb7Dfp+nFG05AcYeCTH/3gnRI3d9sLDsVc7qPwyXxhjWWmfvslbpRYg/
 XJOWmZRhDHzPm+FayNTm1iIZXOvbx1fFXlxhqGLGCI1y6JRWemmQLuaLI4+Kw2Pf2XMU
 ehGbsUvcjfBP7T6LKoPyTSB6SJI/6uZ70hbDkdkUFIBEXY3mqI1MD6jQvzrHQLzIrAIo
 6gSPi5lovWuqFGghXQ/ipfxpx5omsT4gA5M3uofhw2noIbOCh1HK0sdqaTo9qwkuheaw
 aipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705548; x=1790310348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5hPSthJIovrntwFBfq1pmFnZ8Gyy72MTs0mluUnzf20=;
 b=bd1gQ3ZsQC6iueKLUhj18ArhruV5mWsD0wDRExp1jtoP7ceDb3Be37GcMR89peF2mW
 GH4oLt+JB5ern/ruB3uP2hxj6/08WslxSpTP9cVCWl480076B2VFPmRe3y1OAh003RrN
 7JRr+EaJlWDpIhZt1uYdP0znBX/KQ9Lm+apc5knCnKV1gty+4CISDYlt36QRdyCpvGlD
 dozxFAzRR7nErQ+4dWQtPoj+YE/SylqnXybr2+/zA1IQxTDz0ezMS6zr/DCmMLhl0unW
 oS5hT0nrjbsXVir8h5NANLj6rtcVYsx3OBmCxOvFCgOSnarCbHdhr545vbMz0BuXMZVO
 18gg==
X-Gm-Message-State: AFuF++nI0HuLdXm9/a5WjexEeJYoFYWRzzNkyRvPiHC9cSAlqYK4aEUr
 qEwDSXi3Jwx4soBewaFa36+5aSJIbyq88iAep52z1pj4moJW2Q6PWDrAoOH7vzQrH2B0UjfDz+Y
 7tWgrDqA=
X-Gm-Gg: AYBFou34ecZHLxZLCTa9bKA3fCRthn2pAtMCdwsYh+JmeKYP2wsIjfGadhKpPhGVOrH
 1zzFdeQToZy7OcgvETmEt1ymi1fGifyQ86Flp10iyUV9OlVrF9vnrCHOtVK0hJM15eWZGo6WO6e
 Wu7hogDOyjaEN7ujXJUE6iKEf67quFcO5vc1Rd8nsy0ISHbsRsxAeBCeE0ct/7qw0JunCvip51M
 SDqeVtJlud0rCPk+hzm0PSPZUEg6vrnZ+O7zdLOSp8v7kdvp4vJHJ5n94Xhu/bz9ZvvbkdDni8C
 i9qHk57hmoY354WcRBm9VhPLijjEYEMosQ4N3dmEMyWOAkgdTLU0BSWhuiMoFnGDgxVKcJsiT66
 u0Xf0+/ILLUySdLadQFUXXTGARxda4Pz++sjI6n3Y9FKVXIuU9nlpWRYgCEsRrgqM83O4i1LbXQ
 kAmrJIV8GPKBdWiLGU43Hnx6u879KqhTM9nqQGrqs8sFFnxW+ZCuBbWm5wvA==
X-Received: by 2002:a05:6830:44aa:b0:7fa:ac4f:78d with SMTP id
 46e09a7af769-80de2fdc722mr1658941a34.25.1789705547797; 
 Thu, 17 Sep 2026 21:25:47 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:47 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 32/41] bsd-user: Add thread system call dispatch
Date: Thu, 17 Sep 2026 22:24:13 -0600
Message-ID: <20260918042422.38713-33-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::e; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0e.google.com
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


