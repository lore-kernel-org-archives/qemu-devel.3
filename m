Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CB8C982D2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7QBD-0006iA-JS; Fri, 18 Sep 2026 00:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAv-0006GV-Bk
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:26:14 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7QAt-0004QR-Pw
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 00:26:13 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7fcb425fb68so149360a34.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 21:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789705561; x=1790310361;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T5VFNKpjfwVhXvcVbNvhtkKH4RjHMlqu1CWJ8L9VSDY=;
 b=KINEd9pJOPRAJrz2dSEt+jmk3EA42KZ/7mlq53EE8So+/tdqk83Qspr8hoNx1HplIq
 v4kTwIC3o1zRhqBTnHSyNMXOZI2Q5VgHk8MaisCDoZOisVNp0IunyffBKmWjuo3NpEG3
 3EmDA02Cnywji3g66NWdInCiSORni4tPCgtPnmjChEXZ/nn409vaaSxkdzVJroAfBlyF
 6L+A/fEDVpWbOi8jni2vi97fjrl+utyfOar9/LnI18PdElqIScLI4cNxoEFe9piR57qU
 m88nkczFjPoPj+II7Bp1qYIvsKSURwdK3oYQf73Y/x6eBGE+A+oLLeLGRwpMSR145wte
 El3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789705561; x=1790310361;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T5VFNKpjfwVhXvcVbNvhtkKH4RjHMlqu1CWJ8L9VSDY=;
 b=aoZOvk0hrtVhWG5sPvG/a2u4/Df2JpomAsKoRb6X6ihdIx6Gl2KjxvJaCWSgUqxDBT
 If6ulTwCaSRFsn3LcH5l7zRZUVJgcJRFx82BcDBoARNx8vFEYHGJ/mvHoN4XZiS9HraZ
 BIARI6guowUxSRM6dWlfGK31eokydOyyxl6BjO1R0cvE3Fau2Grv5WBUmJh6IX8IUaM5
 PJvc5F47D3/Xt2wFkytNt4RLr50OQNVUT7hJuGo/Bt/4Mp3gOQSkGTifRZOTwjbGSmEd
 wTgw7dwUSqOm5UUNoAqCEubW8dMPB2CsXsyK+1h3Zr/Rm2UjnV5piXa6kvQiLTQqjzjk
 +s8g==
X-Gm-Message-State: AFuF++kg6CoOK8ZKbW3e8oaIuMYhqtzaXFdBBtl2Ip6YHVZV5Hi9cpnq
 opd/+eK9zX9wJoV7gsfjb/VchBEc2VXnfglO4fK9ixHjW3deTNjWndJ+5OYRQNJEKYqxp8KPNxt
 odL19HRc=
X-Gm-Gg: AYBFou24wJsEqNUbEkshcI+S1OPC/3uo511nbUVUjqTL66F4Qgsil3YXKkFvGLN7g5g
 zT4A4XXCZOwRlpqIJr98R+WdKvspivRraqFkH48tn9iQYR1/4ZAgYSiB7ZJdd4nKAEwKbmx7zvK
 2dTzytMOln88aWKFyB9Ftj1ieGfqA9JtqNoOHJs2s9CpGNTjeab7jfX9qa8lnyIczWBix4aNEkL
 kvCKT3XEF6TJI/ymNdM5pERwlMAT7/p30q2AnIfSa4wfIw51P8xezjoynTdP6MYs1yhVcVPHGzf
 akkpOyfN06hz4lm5VBd8y4AmYPB/L3JzAJ9IhCbzkHM4nAKIjUWAslngEcTQCg8K9QW2ZDIm0/m
 ZvrPJpwXdRsZNFi3ZXGnOqaUzsyNhIC6hnCZ1dus0pHLnPShDDbL0rElUt+G11Ieox/7IQ6L3iV
 VjR3SYw+oybQQxo/hf3iMJb7o1RQWvB6haIs4vfZNOqVa/YAN1pOz7KqIH8g==
X-Received: by 2002:a05:6830:6d13:b0:805:77ba:1235 with SMTP id
 46e09a7af769-80de2de66cdmr1510528a34.23.1789705560736; 
 Thu, 17 Sep 2026 21:26:00 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-80e51d627b5sm489718a34.20.2026.09.17.21.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 21:26:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 41/41] bsd-user Update random_seed on thread creation
Date: Thu, 17 Sep 2026 22:24:22 -0600
Message-ID: <20260918042422.38713-42-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918042422.38713-1-imp@bsdimp.com>
References: <20260918042422.38713-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

Initialize / update cpu->random_seed in similar locations to the
linux-user code. Set it just before we create the thread, and update it
in the thread startup code.

Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 63c17e10d0..15872f03fd 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -14,6 +14,7 @@
 #include "signal-common.h"
 #include "target_arch_cpu.h"
 #include "target_arch_thread.h"
+#include "qemu/guest-random.h"
 #include "tcg/startup.h"
 #include "exec/tb-flush.h"
 
@@ -142,7 +143,7 @@ void *new_freebsd_thread_start(void *arg)
     target_thread_set_upcall(env, info->param.start_func, info->param.arg,
         info->param.stack_base, info->param.stack_size);
     target_cpu_set_tls(env, info->param.tls_base);
-
+    qemu_guest_random_seed_thread_part2(cpu->random_seed);
     /* Enable signals */
     sigprocmask(SIG_SETMASK, &info->sigmask, NULL);
     /* Signal to the parent that we're ready. */
@@ -1657,6 +1658,7 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
      */
     sigfillset(&sigmask);
     sigprocmask(SIG_BLOCK, &sigmask, &info.sigmask);
+    cpu->random_seed = qemu_guest_random_seed_thread_part1();
 
     ret = pthread_create(&info.thread, &attr, new_freebsd_thread_start, &info);
 
-- 
2.55.0


