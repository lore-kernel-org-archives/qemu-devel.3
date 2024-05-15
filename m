Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C916C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFg-0003yw-5V; Wed, 15 May 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003wA-LP
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFU-00037z-NV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:02 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-420180b5922so31881795e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785735; x=1716390535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/3mRVbjkwDF9eBMMUHlCcFHLaNSo0keoR5CYS7AGJ4=;
 b=QlGP/HPL5kzNKbKAzEVzkeoA6QFr1XmDAvK0Zr47kZdqkCkipVdY84UMPJ2OT918tM
 2mlCPBmWTK1wRpW5iP14BUB219uya7STLPLmynLQFASHzW0NkgIvfYu/TZwWcbnItOxX
 nvg/lll7XAo3LShWZboHR4PfvtOoYgodyGtZn0NsGrPU5Op8Q0IcrOjjAaj6CbOiZjE+
 zfFGX4q4YgR0liHWYTee64B+JzPzgLQSv1IWnvnrZ11pqjHMiscaojFMDDbXqNfEf6a/
 v0AAX6JZT/Tl0D0Ye8Z3Fllm6P/cAc8C7XF1hydqI2gG52ZSDhVnWM1OffJfQmA8c5lr
 uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785735; x=1716390535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/3mRVbjkwDF9eBMMUHlCcFHLaNSo0keoR5CYS7AGJ4=;
 b=ncZRcJ1biLu9ht3Q2scn0gJv2/aaUqPNShokyNQoFkm5Nau75xe5g8u/Z+K8oK5yJr
 Rj5xDiul8gkYSYJ1OC5TnNLnsjt0m48RTyAJq3nHSi0AAuL7FOxwOOMNbsoFuMQ5OTbP
 8E3qVlOpaEmHgEu4kTllq01Xu5qOPgFu9HUvqa25fG8L9JWpMbzXtQMDG50N+rEvgc1o
 GJKVkIr64myr0KyHvemY1zyUDk9LBCpRggD0gm7NOpLVpk62NATDVf4bfL2tmKREBBOE
 Lps2jYahmxl+aPk49j4YIGogTSxcyNbxoUEiuQDNX7T1AeybHLfPW9if8Z5yncVY6b28
 wJ3A==
X-Gm-Message-State: AOJu0YyItTrjJfVXSjKG487Ihmf6j+odHgpxeH7dwXBLpkiDY282Zb0V
 PbygipkjgG9jelO0UUWix0+CP8mEGHRlOBPTykfFZR7rIcW4/ztzE72gZyj1sS/eaLZQDS7+u20
 U0h0=
X-Google-Smtp-Source: AGHT+IEu1Hivu18OxW0GDDnrfntMhx9klbZ0JtLUZUDikoHOwSRWdJTzn+YiJWPElT//QXQqZVljGg==
X-Received: by 2002:a05:600c:35cb:b0:420:32f:3ddc with SMTP id
 5b1f17b1804b1-420032f3f33mr135801965e9.24.1715785735441; 
 Wed, 15 May 2024 08:08:55 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 20/28] linux-user/i386: Return boolean success from
 restore_sigcontext
Date: Wed, 15 May 2024 17:08:29 +0200
Message-Id: <20240515150837.259747-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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


