Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FB3CDB46F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hc-0003B7-MR; Sun, 21 Jun 2026 00:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hU-00034f-23
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:28 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hR-0005J9-K1
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:26 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a0e075cfafso712948eaf.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015744; x=1782620544;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VjcpVZ6ruto1s3vfaA9tu6Wodi+LdfzqPHS4wMxKL5U=;
 b=XsXW2exzjfs792Ll13pY/k731XjWi14FASOyjtIb6ZZ/3U+cQim7I0Orbkrwaj4qe6
 iXwVYdwdrz+U3ebL/JtcVPqf8eqTcSIykQltru1xG5Aav2mNTfm1WT3QBuoxSHbhtDmt
 BVR+GnBfGXSOGGHvAIDrQR2gsB0gBO6UNFmc4SMRz1RXTSmY14mx4uh5S5F0f9n9IEiY
 jFKLTBj2XKJvk67vXiy7bQ79sv7CDcsc3P3SPiqHja/zHSHqsXYzl8ej0N13rkMEMGHE
 cBOKymtJFKq/ErPKZp8Eh4m2XvqwMLtqOChKpayaRjF8zo69HghGvrxOjN8bYLnwzfDc
 t6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015744; x=1782620544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VjcpVZ6ruto1s3vfaA9tu6Wodi+LdfzqPHS4wMxKL5U=;
 b=LuUWdjR8BisHZDQIF4odeWsQPWR0T8s58WBOEx2MGf497u57Vidv3UIHdDTtpNiVo0
 Awrr2C2P0vARy07db6PxDI4fBMIJXEJkWnwwRdnuh2UM3sXOXv7dvxHcK04NySIuRKch
 FmNVRmeIyBdfd7r2OZobRnaKDOY4Uoippk5qERL5hQo0p39JhV3AtSSO+xfhQ13QzVSK
 lU35ew6DXeCxXH2TnoSVeFCsG8PABncDjlJLwDNTBsi+0q76ljnGublq/JpJ1a94Nd3e
 7h+9uu4NWp/xjkX/ib3KjZz4hn5XEZRO2l9zPfgVan8/ZXhWLx8vdDvtE5ao1MBHbmq2
 qj0w==
X-Gm-Message-State: AOJu0Yy1KcBeZOZnAPYWf7j/d+BktdPsSmAzmNpwxJvQIlfw/0kEC43w
 QS+bXMufb0d7WnXI1VB+lO72qfkzv5mq5QWPmN5s0CE/DM2ImQvojxicseZBwty1mxY=
X-Gm-Gg: AfdE7clNQa8s1RBt4+Q9Lktcdd0rZjXeG9r2HVnU38orim0nXCohH93MZ6av+/hXbbF
 +OCrrxFn9gPiEN+Tmi0iR8pPUBqJm/4L2LpIOGRNUNypO9rTZudDE2jpwN9F+c1HtgLF6ffc3gT
 CKOc3MoujcUVvHdQHwb9CAeCLz1B4fkA2Q/rJgESbYE4PtEQwb1966KOfW/khkjI4c9NB4ewOg8
 6aXv3NiVb4QZTs7JOP76C9TdGA2He7gimyPV2KO1MgfJUmpDOYBMA8tQB9MzwWXyGDABbfUCvxn
 zKYFL2N0aKvVROIcGDmmjh7/Rnf1Wq12tdTQ72ZSw+ZIO9QSExKmZiLZDrRyjazZOb3uiKCpV68
 gvBI0PVBfrd5qqDJlhUMUwuXjnsTBDGGVIJG7FaVcxysYUPtTqBw+XKvs7QOntZ0+dIysG0ROaj
 s=
X-Received: by 2002:a05:6820:7088:20b0:6a0:ff94:df7b with SMTP id
 006d021491bc7-6a0ff94e8dbmr216904eaf.35.1782015744211; 
 Sat, 20 Jun 2026 21:22:24 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:23 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:17 -0600
Subject: [PATCH v3 30/40] bsd-user: Add thread system call dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-30-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=asnQtYV47YyPo4EF9BS4x3B4tv7oCfQH0yj2OEdHsb0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aAbbsuk7Zhm4WMPRFxS6Qa02NNcPOs3cKhs
 zdzaOyAUhyJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgAAKCRBsHNEofbAR
 AO4MD/9wsNTq51t8hvcnYTniIpZYIJ1fno3acc6DRkwj0u067BFtdTgftEK+BOsGF5flAXOEMJ0
 z5ssZwcKZSm0R+rXExwUdBQI6o0ZUBV0EUK4DGqTtD4MXLQA4qxirlvQuUG1ldW7gbT5Iea4LIO
 xhY28oIJBXp6AJOG93gddipuHHRD2VCutz22UNn3wgu9ZMsNRPbLABC1Gp6WOE9Ms8RxsU5YSo8
 +2LGkyehNjDdWpKtuYY9QgC5L3lFmzNa9sXYYs/S+CJV1DcNoqVtAZFcQ3Advtm9W5HJBrkkGnj
 CpEDDmzeMkNsso+WyrPk8xOvJZ0A3E5JPi0vuuJKrxoYBHudl7HSppO6iRcCWC1PIJpPcNkb4em
 58bWLPf1Csfr6dckC0x2R0bQ/ylbwfTKo3DOPVcllMExsBHG3UGpjnJIK9UaPUeaDLFqga7dJ2H
 xl0gcKK2cHQSfuVKrUm5ysVX7PJvwSYvULHU9ZvUiDTqVBlWDIvJ8F4on2yayJ+czgYzuel1bZZ
 y3VAPEFBNPnvJ0bYcVh0vppzJLsWu6mxecGNkHOKn+O0zDmREch8U+VGT08gephPj5tUIrZo94A
 aGg95rbNc5PhSyLaJtshqOZl4QKaM7Cq9dg4jjxuwDrD3JUJYywUFCirGdY5hiPIzJRvee2/JRy
 fclRR8p7V9KvgKg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::c33;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc33.google.com
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


