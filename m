Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39D7CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dv-0003E9-Py; Tue, 09 Apr 2024 01:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3du-0003DR-Cv
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:34 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dp-0005Kh-Q1
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:34 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c60019eecaso73182b6e.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639008; x=1713243808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lwz2AVaZ4jMxsAZ0LmeafrPRZnLD2nezi1yCURh51Zs=;
 b=ZZXtMsrMIMFCRBfcRuYB3Pzyi+O6Fu35oYPgbCQ0oHPfUYAif/kVHhgWYIKaSwgsqv
 jciv1xGynDGzRAsdM95rrQj7ieGqD7gZQfHHyPv0evcYR6MSAltbcHDvYPhq+xFbydUx
 Z1nbfE3pBYvJuXGD1HasbSIPITMhCnLT55XTBnMoJEmCdq/QH9de7/Zb7wpUuLdcX9aC
 h679+VRqYYJgRlm+gIuT497S4+mmZ2btO7g30Z3OPgSfhIemvDl/dOICPyTI86hBmQrs
 wZ7gJCd1nmthS9D53T3LIEipJYYs7xoPm5g3wEHN54l5DFkUeyplZmw2tadz+SziS6GK
 53FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639008; x=1713243808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lwz2AVaZ4jMxsAZ0LmeafrPRZnLD2nezi1yCURh51Zs=;
 b=LzUcc+0irV0fhmsTyNlb1mxmrpUv/xg6PQr3uVXV4s+QduDoUBVU8P3X3rWFsYQ1Ky
 DoxejkFagDQCSbVT0SiNVkbIYqrmEoPXIrArMr30CThqcjCORyWbHMWaUgnQGIPPK1FY
 Z2AUNeRJVWc3LvFZ/Dk0EdJYmoWgTK/cq+Y4d32ptGkI8OoLHhRfsnUCLu82KI1v/8a8
 voIWsJZitu5smwzeJgOoCv48z32cwKM1OSzRuiJrum+n6fddV8DlNTTthKerOKifAI+A
 rpOHoag2kXghXkCWIqKNgi9/kjSGI74+TsZ5f1GTv+PMTM7/0v9u1p6RbhzSgNdYiRKL
 SAgg==
X-Gm-Message-State: AOJu0YwvcoAryWElWVIlkhuIc6iyJwh5Jh3G0cb+ujBGUfvqvAyF8Lzh
 hi19RfZJo2XJ76QkuBZW7ycadJ7uyz6Y4s+DuG8zAcf6QVepL08lWyuvBNn8rl+5AbhioURY1Z7
 y
X-Google-Smtp-Source: AGHT+IHNlwSiPklgWyYmAAABjnTiVp9evlRj4pkPhVT5Lutkk1GqgHKb6QHsfqPXS3u5MZJG7FT0MA==
X-Received: by 2002:aca:2313:0:b0:3c5:e553:475a with SMTP id
 e19-20020aca2313000000b003c5e553475amr7552060oie.45.1712639008712; 
 Mon, 08 Apr 2024 22:03:28 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/28] linux-user/i386: Fix -mregparm=3 for signal delivery
Date: Mon,  8 Apr 2024 19:02:53 -1000
Message-Id: <20240409050302.1523277-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Since v2.6.19, the kernel has supported -mregparm=3.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 559b63c25b..f8cc0cff07 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -427,6 +427,11 @@ void setup_frame(int sig, struct target_sigaction *ka,
     env->regs[R_ESP] = frame_addr;
     env->eip = ka->_sa_handler;
 
+    /* Make -mregparm=3 work */
+    env->regs[R_EAX] = sig;
+    env->regs[R_EDX] = 0;
+    env->regs[R_ECX] = 0;
+
     cpu_x86_load_seg(env, R_DS, __USER_DS);
     cpu_x86_load_seg(env, R_ES, __USER_DS);
     cpu_x86_load_seg(env, R_SS, __USER_DS);
@@ -448,9 +453,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_sigset_t *set, CPUX86State *env)
 {
     abi_ulong frame_addr;
-#ifndef TARGET_X86_64
-    abi_ulong addr;
-#endif
     struct rt_sigframe *frame;
     int i;
 
@@ -460,14 +462,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
 
-    /* These fields are only in rt_sigframe on 32 bit */
-#ifndef TARGET_X86_64
-    __put_user(sig, &frame->sig);
-    addr = frame_addr + offsetof(struct rt_sigframe, info);
-    __put_user(addr, &frame->pinfo);
-    addr = frame_addr + offsetof(struct rt_sigframe, uc);
-    __put_user(addr, &frame->puc);
-#endif
     if (ka->sa_flags & TARGET_SA_SIGINFO) {
         frame->info = *info;
     }
@@ -507,9 +501,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->eip = ka->_sa_handler;
 
 #ifndef TARGET_X86_64
+    /* Store arguments for both -mregparm=3 and standard. */
     env->regs[R_EAX] = sig;
+    __put_user(sig, &frame->sig);
     env->regs[R_EDX] = frame_addr + offsetof(struct rt_sigframe, info);
+    __put_user(env->regs[R_EDX], &frame->pinfo);
     env->regs[R_ECX] = frame_addr + offsetof(struct rt_sigframe, uc);
+    __put_user(env->regs[R_ECX], &frame->puc);
 #else
     env->regs[R_EAX] = 0;
     env->regs[R_EDI] = sig;
-- 
2.34.1


