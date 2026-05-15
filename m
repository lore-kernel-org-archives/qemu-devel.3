Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12B5CD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxU-0001ug-9m; Fri, 15 May 2026 17:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxS-0001og-Kq
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:34 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxR-00032X-5A
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:34 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-47c6f914617so193517b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880032; x=1779484832;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VjcpVZ6ruto1s3vfaA9tu6Wodi+LdfzqPHS4wMxKL5U=;
 b=JtKjS2PyFbWItwKHdsT6skpew5DqIYLIMi60HpeS0SDtUSv0NIF0yy1WuGfpJcZk9Q
 wbM6jITxlydpafj3XaJVOKnY8L10W78FgnWLBvmdtuyRxp3vgnXiW8X0GboozBzChBpy
 3SwNJAW+tPO0lZyedSwMsuVfQHNNMf4qedQFWi2mvHCpPWhL8HRt/DnRxuPWFWBqthzd
 YXLxYmFK9XOKLD4Q6/7Bm6h65bmJiMq2TeOKuuA3p/ZfBqEEc8qIiy29w16I8s/cpGjF
 IPpF3a+YVRtwfn1btGxj8Z6EcXD8OG0Y5h5NoKSU0Chzxxy7GgcthR8FlyI06aCuk1ts
 iBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880032; x=1779484832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VjcpVZ6ruto1s3vfaA9tu6Wodi+LdfzqPHS4wMxKL5U=;
 b=R1iekopbum3JPsPorfDbkghebgz3fiDydC5LWybOqN7UiUbIVMr3GDD/zLlxMyZq6s
 XwjksGnOX8mkMtYDU9Kkx1TdS4+mLvtNhxc7ik8XO/B5ostujnI53UWi6JdKSNC8TFbM
 Oc0pp5Qr4uNc5r86mz9KPnVhcFCRlVb0weBGuIUIS9wN9yMBCc+ogobe/xbaQvu2atkl
 lokp2tdd8rfNYwcLFdLOZGpHbOXqhgeAhkfc3DASgsx36APDcYfxKHuBQYoQsPwb4r2c
 9WBl8c/OLJriBn3c3U8p4LLdJL/lSeeI0CvlfBzrrcAF7IdtfA26J4TOeZQSkyAm58ar
 bFUg==
X-Gm-Message-State: AOJu0YzBfj6+eGjgsG50aGhXJMQCg5+nfKTn1q9Fe4nuflywk4WwBEhb
 UzKEeDxndqXa4nQRj4ltQjTL81AWRp2x/4lROaNuIV00e0k2QiltyYJzC33hvfK1EFw=
X-Gm-Gg: Acq92OFgfyNJ4np9bIMVziqJuDVCpCgE1gXwBpg2xzf6/sH8XOV9Y7nYYPXK/P9VJ7r
 yDUb12+nCObWK4iQCXB2jbC65EMgDD1FvnxMBCvolHscFDeqR3gD4LJOkTurbeYBKRtqa5g1IaO
 MkRmRhEkoe0ioHBccG98UuQ9SaiW2djpbnAMAygZYUffrKRxWzx+iDprPm1BPo0yzAjRCxD9ulm
 XdECGZMTMVR/rjfgtt1BOiWAut0zbYhxoKZ+ozUwNqgWUWoiikIcfKe1Zb+6jGiFFeXiqXZuzBv
 yyX3wxfPunT26AsHdaBLmin8+t+O0SYlVogvV2FzyGFWXBIzXTI2gOeQu3dlKDPisu+s/VjHjOf
 Np5QaZWYBeveGnLFvStR1CZv/1/Ho2DyQwfpkebIkNmRoPcLdZsJussik+lwUAIcqLXR5JtQIgi
 NHrrIR3wm4zg==
X-Received: by 2002:a05:6809:2c3:10b0:482:ed84:1a25 with SMTP id
 5614622812f47-482ed843efemr1940390b6e.47.1778880032078; 
 Fri, 15 May 2026 14:20:32 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:31 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:28 -0600
Subject: [PATCH 29/66] bsd-user: Add thread system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-29-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=asnQtYV47YyPo4EF9BS4x3B4tv7oCfQH0yj2OEdHsb0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43k6JlRcRKDxHwljYHvshj2chGIxHAbznsCj
 ddu4iA85sGJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 AH/VD/0e1iVZsePfw5GKvnFdV4DdSqgbci/868qPQ2fifesSEVkRp59uli9GuD5Os7kakqfyMvV
 8LabKktwg/4o9h//kZuwN6/3Sl/GAD5bpc34RdVYltWpkBFjntUuOc3Wa1r7rk7ERgmjL0XXfOf
 udYfiDsGAPQmy8gK35xaJn9pynPPWGDxpN0vwBnrGfq0LHGrzzLcpYsUlD8OpSwibig5Cu6lQ3Z
 v/PIMaYsIb/ma6LZFx/qt9XYwTt1BC+XIR77drjAldoMM//tji8AW0lWdjW/T2Tl4/iA1dzEHLR
 iwOuT8kji0AES/xcQdS/f1TPDjxRZchq1EsvwLXhWzByzhRvETQvLvA14LYKWKqj1h7lbJ7tbr3
 SKgCa3CP22YXP6DQt24hnCP2Alus4wEIjUBRuLRhaxYO9+uM1i+IeDZuW9EX3tGFPrNf3WCmpnf
 Tlj/MX2lZOnh/phijl4t8RZDQrqHfJLe5NGwHVUPpbfhrFvRS0NLHxKf0PQ+AP2ylD/4RTacjRj
 JdKxtav/HjEyI8spxChfkrd/OMSY3gOIMN9uxsR2dLSb/CaqmjYzzJrByeoRzA1DvjlAwplwXtv
 qYfDn1SVWTUb1XGkNUmHKRHpLEuJvmlbg4eoGgRe10+hVAHeFLFitMRg7IclQ3LzweEqCceADyx
 CcP0MyKtfGVIFkw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::230;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x230.google.com
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

Wire up thread-related system calls: thr_new, thr_set_name, thr_self,
thr_suspend, thr_wake, thr_kill, thr_kill2, thr_exit, rtprio_thread,
getcontext, setcontext, swapcontext, and _umtx_op.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c | 55 +++++++++++++++++++++++++++++++++++++++++++
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
2.52.0


