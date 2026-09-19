Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CCAC982D7
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yI5-000716-Oj; Sat, 19 Sep 2026 12:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yG5-00041U-S3
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:52 -0400
Received: from mail-oo2-x2a.google.com ([2607:f8b0:4864:31::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yG4-0008S2-Fq
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:49 -0400
Received: by mail-oo2-x2a.google.com with SMTP id
 006d021491bc7-6c901f4bfffso1001234eaf.2
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836587; x=1790441387;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T5VFNKpjfwVhXvcVbNvhtkKH4RjHMlqu1CWJ8L9VSDY=;
 b=FN4fO+Ce0dYhjZKzUT41kKVOhknSqjNUmnZ5lya9rGNWUaQzsjnTdb/6rFhzE94mJ0
 8wC4vrn1WbDeXUu7SAwHCcbhtfkR1jG1BanJLm3nIuUIoECBKnH+I/1D3Y6Qm4jL+Hy+
 E7GgQOLlX2UVbxH2qqrbVhtNI9EwTr6jNFpdxQQy5V6wl8cVJOLoM5lHF0uQAHuEbTsI
 IlVYKMwXYF/1VHl5l3KD8B5MQ2Jo34UKWxb5gBbwwdYyB9YhXXtEOFo0tA07PuSIpFRX
 YizstAGyeQkCj86SpktbLdKa533HmcbL0kkPksKzSj0DApr1NF2U0R6flPzeCrwXNwIr
 iwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836587; x=1790441387;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T5VFNKpjfwVhXvcVbNvhtkKH4RjHMlqu1CWJ8L9VSDY=;
 b=ILnlFKduB/sSxnCN6GSXcQGvhOmJv7xNisgAlqH3WMJHxXyns5M2HO78w1tbtyaDGb
 yLjWNBB3cm4cdgpPaLhidLKvHCr53jCVzKhAvDf2o2LP0Z66AqMh2DEunRkADo0l+2yG
 UCxvcW8201U76khrdEdEyAskp/9w8jhfpvEzA1tGnyG0MUcPIjf1ZZJon6u68tcfsa2E
 XcBewuj2YvX96u1MI89frs+FM0Nu7HFa9Qx2wEc5kCFWO+VRXY9R+3D+MImObW7vGAme
 /EfENpUM060vqLm9PmLCB3y56WccP2jzxWILn5mjIoI5FsyYE+SZrUAI27BoiH1Akz7c
 0B4w==
X-Gm-Message-State: AFuF++lT4fkVg+qesYGFIXSsAQUDjIGxqAo6nLoK8MgXJ3I7rTvGLG9e
 mSLH7w5CDMt/ABySgbb2kjUKksqK9VRGUDv1MkXJwkUeTLi1Ql/neTrB3h/lATjfG+tn6FxObPt
 9rpvRCm0=
X-Gm-Gg: AYBFou2C3drdWzEhsgxO80TclWpdTHC5H7ajMLK5Q1yPgRbfomij56X64AnLZXG7Iu7
 xkv3jQ7wV/5934blOk/RIe3cHPznN5+sFHJcjPQYgf5xHvsj3a+GYNplTsNBJzeJp4KJzIbcRV8
 6W7bBnsccGJWDLQ72o2pSD26WIKMqT8HPPdIZgXNfN4gGc82fE4JUTlHAEmmDxQ3F05F7xNZcOt
 KrG44Heo/Klj87hYR85MRdHx2TfWTsa9A6mV+fmLtlcyZf+QpOMaGvojnTWH5a1h1cePjFz9H3G
 qeMoSzdpv/R+CCCKhshX6MJep7tBQYHaBYmvTi7uCr/NGM7IIhoDNUNGwtg1yNM1O2ARLAzT1qO
 TFcsvYK6Ah5jphPvp+R9JhIRrBPq+xwZvguYCM6MlFKxcno4W8TKL5jEt4lnT0SqWR8GJORH7HA
 IfNXzt5T1raHDAJFx+jRNjv7JaJLfKbz8h2mRdySvRFTHIN4mxTST8IwAWZg==
X-Received: by 2002:a05:6820:222a:b0:6ba:1878:2a6c with SMTP id
 006d021491bc7-6ca9a54782emr5931424eaf.4.1789836586853; 
 Sat, 19 Sep 2026 09:49:46 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:46 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 41/41] bsd-user Update random_seed on thread creation
Date: Sat, 19 Sep 2026 10:48:09 -0600
Message-ID: <20260919164810.70151-42-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::2a;
 envelope-from=imp@bsdimp.com; helo=mail-oo2-x2a.google.com
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


