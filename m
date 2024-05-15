Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6D1C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFf-0003yv-RE; Wed, 15 May 2024 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003wF-Rm
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFU-000357-0x
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:01 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41fd5dc03easo43231865e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785734; x=1716390534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IG0If/b6VQnjtJdCAv7RGvLxbc+5Pp5q/Lqtx4PykE=;
 b=oHax7iaYoFpItOTnbTcfio3qEzv4x0NtN2GVjSiUAI4q1/Tyqizd+iZphHlDAOKZKz
 DmNK2exapw03SsNvJl7eN49EDU6WD9kVMK0vjWd2d00WiTpeim6CiTIb9JX4SzXhRoPm
 OcjHrEVK8Oitik+CAf/vitQ72iVU2hpNMOv4rseOHc2WxwQOgwt2w4PZcsEg9YePPgHk
 P3pnoH8WXcqGVVXUvC8dQvb/A8oDWduFC7gF+oGSWZ4DyRqp6pAS1VI0xacpwA0gvPWG
 E8CUKxHF1xqp0apdGYhrwTRXxR9APhHmL3c/TUnMBr9a6RaWL5i/Q5QVoa8asmGV/NrF
 jZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785734; x=1716390534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IG0If/b6VQnjtJdCAv7RGvLxbc+5Pp5q/Lqtx4PykE=;
 b=Ynsy1DeQp5j75fQHCxt3v65wtADfOktRYZZgHUTRx8HnTD+VaGS3fGhqtDjU8QZyP+
 lPlj05Euj/u9tbCJq7pQ0nlShl5Ot8fJ2xyl3SdavPc3zRUxFFLBUNqtBBaiaHKih1Q4
 uyZSDFje/xBIt1BmldXABmVN/1gddZeDvnvR3A83YBuwQRw+JOwBBXomwTuTrxKx7+0d
 aZ62iVoBKySB3luYTGYtcgWAoqRjaq54IF8ZKv6+oXF0D1Xbzmh6KW7AocQV2iPlbf07
 n/xhpKmMtG2O5rzZqoyu3Ln2HZ4fFxy8hWG2UaGOW3JPEQ+z0jQAuSLH8HGKvSXDZqjC
 ldmg==
X-Gm-Message-State: AOJu0YxNAaLiGGtYO43DIQvSb3k/RgB3o+XCbpynY2j/RRKzRyGNvund
 jldClEzl+OupcshUX0bTx5vHW7GDgiQaphi+ZFIGvIfHrfg02dF9nhHJgvwoyMOlHHIGNhEn4Np
 Y8AM=
X-Google-Smtp-Source: AGHT+IF3OTUWUVNqZmzAZs5d+vLZTHk/0IXPGwlyAwJ0/9uK2jQposHxtV+cGt2Z5FBz+97Ts4Ee0A==
X-Received: by 2002:a05:600c:138b:b0:419:f9ae:e50 with SMTP id
 5b1f17b1804b1-41fead6ac32mr122146905e9.37.1715785734719; 
 Wed, 15 May 2024 08:08:54 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 19/28] linux-user/i386: Fix -mregparm=3 for signal delivery
Date: Wed, 15 May 2024 17:08:28 +0200
Message-Id: <20240515150837.259747-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 linux-user/i386/signal.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 3271ebd333..6763b4bda8 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -405,8 +405,6 @@ void setup_frame(int sig, struct target_sigaction *ka,
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
         goto give_sigsegv;
 
-    __put_user(sig, &frame->sig);
-
     setup_sigcontext(&frame->sc, &frame->fpstate, env, set->sig[0],
             frame_addr + offsetof(struct sigframe, fpstate));
 
@@ -428,6 +426,13 @@ void setup_frame(int sig, struct target_sigaction *ka,
     env->regs[R_ESP] = frame_addr;
     env->eip = ka->_sa_handler;
 
+    /* Store argument for both -mregparm=3 and standard. */
+    env->regs[R_EAX] = sig;
+    __put_user(sig, &frame->sig);
+    /* The kernel clears EDX and ECX even though there is only one arg. */
+    env->regs[R_EDX] = 0;
+    env->regs[R_ECX] = 0;
+
     cpu_x86_load_seg(env, R_DS, __USER_DS);
     cpu_x86_load_seg(env, R_ES, __USER_DS);
     cpu_x86_load_seg(env, R_SS, __USER_DS);
@@ -449,9 +454,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                     target_sigset_t *set, CPUX86State *env)
 {
     abi_ulong frame_addr;
-#ifndef TARGET_X86_64
-    abi_ulong addr;
-#endif
     struct rt_sigframe *frame;
     int i;
 
@@ -461,14 +463,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
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
@@ -508,9 +502,13 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
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


