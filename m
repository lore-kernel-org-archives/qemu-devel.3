Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E81BC25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZM-0007HH-I8; Sun, 26 May 2024 20:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZJ-0007Cq-94
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-0003ga-Im
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:24 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-24ca21014ccso1196450fac.1
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771018; x=1717375818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/3mRVbjkwDF9eBMMUHlCcFHLaNSo0keoR5CYS7AGJ4=;
 b=b4tx9VX2ipo3QWJaCnvPeV8jHd8yj1SiW2CVowcTU/pl05dR1wZRAxJ4b0A1aoz78s
 Qx/8U4UVQJI4uuFO0Tse14J3qSIbBN3rdBnJbIL+zw1aAVxjBfsxCkz/km3W+/+rwFSe
 OKT2CUUM5N/py7AuR1uE63mlxnYcpDwh4AIma4D1GAblyPcrEVg7AD7nm05hCrddMVH8
 jqBrXEGQSuR3EyB6SWnMlJ/A3Pzjrwp7kvdrztiJxGfbxFJxeyHbqhubldZNXQImY7zp
 k+1zofvqLl4Vu/vNQtb6I1DKFFnjLRSWp1Q14ZzK17COZVFBJbG5yn25NQ6/ItrXhDGA
 sZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771018; x=1717375818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/3mRVbjkwDF9eBMMUHlCcFHLaNSo0keoR5CYS7AGJ4=;
 b=UsO1NYG6zmEr+RLLSSEBpBbHqG19etmpyx00tB2VAtzJdZGtGS/7Wu/4aiiNkBxFnn
 nD2lWsePvwJd6dhYn7h0wfNqaoDS517lqX0mQ/SpWSRYBmo8cwxZ1H283eNk5/B7rSyj
 QNSNZzQuVw7jvzkwlxrcRFjaIDUhny4fHjD0aFEgxgvqYxTer3mrBIu5jFFK5AD6eb9U
 btJEC27S+xO9CAT7yo3UAa7zk4sqvLwsAiuWVcVgyamaGaGnn3bMSJEx/EehmPjAk6Pi
 dAOcj8qWvHfKMfLZqOAomcrBoXowfIGp1I2jv2CVsICo/uhKbu2AV+4eKfGWBJPfaBtB
 GZ9A==
X-Gm-Message-State: AOJu0Yx9OLcOdEpULJP9qO9iOmMtu4dAWwPy5D6XEapOmHQWsFDu0VNm
 O0u+NTt8lNiCxfc5G9ZcxqZ55StgguctACyRDmSdMlKb2wVacEX59dT+14xnnzStehuzFljOPEt
 H
X-Google-Smtp-Source: AGHT+IFA2iVpuarcuYSqSufpVwNrRJR1oc/ymReMRy4jXMKIE+b98HZvw+ZA5QwO7USzbFcaK6mcyg==
X-Received: by 2002:a05:6870:e256:b0:24f:ef6b:353e with SMTP id
 586e51a60fabf-24fef6b7416mr2348778fac.36.1716771018523; 
 Sun, 26 May 2024 17:50:18 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 20/28] linux-user/i386: Return boolean success from
 restore_sigcontext
Date: Sun, 26 May 2024 17:49:53 -0700
Message-Id: <20240527005001.642825-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Invert the sense of the return value and use bool.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 51 ++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 6763b4bda8..9e6d883ea1 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -564,12 +564,12 @@ static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
     return 0;
 }
 
-static int
-restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
+static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
 {
-    int err = 1;
     abi_ulong fpstate_addr;
     unsigned int tmpflags;
+    struct target_fpstate *fpstate;
+    bool ok;
 
 #ifndef TARGET_X86_64
     cpu_x86_load_seg(env, R_GS, tswap16(sc->gs));
@@ -617,29 +617,27 @@ restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
     //          regs->orig_eax = -1;            /* disable syscall checks */
 
     fpstate_addr = tswapl(sc->fpstate);
-    if (fpstate_addr != 0) {
-        struct target_fpstate *fpstate;
-        if (!lock_user_struct(VERIFY_READ, fpstate, fpstate_addr,
-                              sizeof(struct target_fpstate))) {
-            return err;
-        }
-#ifndef TARGET_X86_64
-        if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
-            cpu_x86_frstor(env, fpstate_addr, 1);
-            err = 0;
-        } else {
-            err = xrstor_sigcontext(env, &fpstate->fxstate,
-                                    fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
-        }
-#else
-        err = xrstor_sigcontext(env, fpstate, fpstate_addr);
-#endif
-        unlock_user_struct(fpstate, fpstate_addr, 0);
-    } else {
-        err = 0;
+    if (fpstate_addr == 0) {
+        return true;
     }
+    if (!lock_user_struct(VERIFY_READ, fpstate, fpstate_addr,
+                          sizeof(struct target_fpstate))) {
+        return false;
+    }
+#ifndef TARGET_X86_64
+    if (!(env->features[FEAT_1_EDX] & CPUID_FXSR)) {
+        cpu_x86_frstor(env, fpstate_addr, 1);
+        ok = true;
+    } else {
+        ok = !xrstor_sigcontext(env, &fpstate->fxstate,
+                                fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
+    }
+#else
+    ok = !xrstor_sigcontext(env, fpstate, fpstate_addr);
+#endif
+    unlock_user_struct(fpstate, fpstate_addr, 0);
 
-    return err;
+    return ok;
 }
 
 /* Note: there is no sigreturn on x86_64, there is only rt_sigreturn */
@@ -665,8 +663,9 @@ long do_sigreturn(CPUX86State *env)
     set_sigmask(&set);
 
     /* restore registers */
-    if (restore_sigcontext(env, &frame->sc))
+    if (!restore_sigcontext(env, &frame->sc)) {
         goto badframe;
+    }
     unlock_user_struct(frame, frame_addr, 0);
     return -QEMU_ESIGRETURN;
 
@@ -690,7 +689,7 @@ long do_rt_sigreturn(CPUX86State *env)
     target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
 
-    if (restore_sigcontext(env, &frame->uc.tuc_mcontext)) {
+    if (!restore_sigcontext(env, &frame->uc.tuc_mcontext)) {
         goto badframe;
     }
 
-- 
2.34.1


