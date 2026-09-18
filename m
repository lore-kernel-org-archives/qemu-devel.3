Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D296C88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QA2-0005Kn-Lt; Fri, 18 Sep 2026 00:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QA1-0005K8-L8
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:17 -0400
Received: from mail-oi2-x0f.google.com ([2607:f8b0:4864:32::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7Q9z-00049m-Td
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:25:17 -0400
Received: by mail-oi2-x0f.google.com with SMTP id
 46e09a7af769-7fcb425fc2bso151787a34.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705515; x=1790310315;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4s+zO78YhAlvSbx1P5A7DHRUJ8bdtiX0ksZky7VNtEA=;
 b=DBRZ16ajVRtkUPXZgWM5uNoa2+h9Puai+GB0yS8NK9tPljT3Sd/4cntr3Tgxi3zL2p
 7IVPFU6GME9NUfkawuNIp2uVU9rS5TDhkkZTbrM6YeyiIevNN6b5gtHBaeDM9dA6xBfe
 qI6L6VckvTpdy96sNS2MlsOEAwJnYU9gUXJGv5D7L2wAviHwJvziI/DbG2g9Kgz/Xeu3
 xgefu+Z0pKAMBeb5lKB0glK+m683nT2caqp2K/eV6iPyY9+44lehLTAOPu0YnJg/DNYf
 /npQTumajMNh/nW6KIP9baYoQ0pskgzPPKKjVX9ituPQF+6HE705MbMsj0hMOP/tt4pl
 m9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705515; x=1790310315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4s+zO78YhAlvSbx1P5A7DHRUJ8bdtiX0ksZky7VNtEA=;
 b=nUuelyeV4V4fQb2k5YR9P/dQ0+4ivHgFDQPwmX1TIM1Z3cmFyUIVb3TGf+J+giN7YT
 xAJ9np+Mhc2ETjZcpuUbmIlUG6i9h//t8/oyiMyFBYu5Sqaopj5r1GJ7nx1gbbg3FNe/
 RzIPkUUAQHvwQ6ieT8tEEprvT/gThLmUBBN8VV3hutHtYYKJ6ahfWIY/JCnr7oYeiVPu
 7EdHq3+zWd9KKp7OLfiiD3+Yqt5oH767tqgspukZQ7FxRBgicVM/ocvNxat6jC8d9uM+
 YL4Uv2McCp7DFqwtSq6ASoxTSooDZOm7i4m/wOPZglXgxw3asZWdbLCltfrrFDr5R/Dv
 +4mA==
X-Gm-Message-State: AFuF++kjZZN/ElVKYblTGhLqGudgtT3PdkERhpgGa5Dl3delxpAc8TH5
 5nhY2UVimjk/PCegyvTUI1wfdMOkZZA7HwW7VV/eR30SFftpYopxxEoKf8uoC8HsB5OZfmqBNVm
 FIU7dk3M=
X-Gm-Gg: AYBFou1CN9vflvBTW5io8pyHy9oO6LrYB6gqSwDkA0RAh8usjCSeecWYhaNV5JdTTGI
 RXRCYEE3YKgL/tFdrONsR5heglGmdYo9ge2QVVo4NtCq90JHz0ANpbKpj69BenujKiAUBIdMOHV
 WWLAuy6/n7GrvUHvYPvgoYFy47NOjo1J95yfbMYAfjsGQ9zDs0gWOVO7XvY78GaUAUtOtjK3Nu/
 UbCgnPjwQcxQ0mpn/acwMgxOH9E4VxM96ojnBr0/juADiiOvsxn59P0jjq/OyMyULyc2MijiWby
 i/+ZMYQsGjq+N9lz0dPRrheByxyhs5Re8zIjK14a9E4j52UK4Lz2QpmPaYJnnyucfmG4LtofBc3
 xmLC79ApwW8LrOlwIo5Qbbxfy4PqpZ84HcqPabCQpwMtTX3nJZJLhaS5Fq+dMJCQa4U706lzzCR
 8bkCxlkseGugFus4ighYl9FN+pofSBCjRDFTBO8oGM8JkW9A0nzO9GFxbCpQ==
X-Received: by 2002:a05:6830:4708:b0:7e9:cf6f:aef8 with SMTP id
 46e09a7af769-80de115f4f6mr1595015a34.11.1789705514861; 
 Thu, 17 Sep 2026 21:25:14 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:25:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Stacey Son <sson@FreeBSD.org>, Kyle Evans <kevans@FreeBSD.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/41] bsd-user: Add signal system call dispatch
Date: Thu, 17 Sep 2026 22:23:47 -0600
Message-ID: <20260918042422.38713-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::f; envelope-from=imp@bsdimp.com;
 helo=mail-oi2-x0f.google.com
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
 bsd-user/freebsd/os-syscall.c | 48 +++++++++++++++++++++++++++++++++++
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


