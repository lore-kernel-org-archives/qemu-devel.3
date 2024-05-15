Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63907C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:12:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFR-0003sk-0l; Wed, 15 May 2024 11:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFP-0003s5-O8
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:51 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFM-0002pp-QV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-420104e5336so26609185e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785726; x=1716390526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9YixNcV0VmfO6aoH+tEoVfr0IpNqbjtk188TFL76t0=;
 b=ZQ1gxE+RR0KV5yfEdlM6+b1LMWhZJ0Dd/nCDvwzcx0fjdoVoLCs781RwmzG19QEadC
 5YV157AiirWDNTosLpeEtPMQJLTa/BJ0nEyoF1Tm+9vARXvP/NMJ/n0BvuTaCoiZFJ3+
 LhzOJS0CfCNbKImTETXvnk6/aRpwKfzikJfO/lMAEqVxX4CNFVRE0A+KPOqDBm/8Ar/G
 hy221XVLHJ9BHe0i8ZUl5sjKdEhi1EQOtnqkOgxY+gq5QlxS8t1prXTkPGAxuodxEsCv
 j80oqXqta7pllaF1x/DRfzOB8exmeUT40zmK65MC8/KUL3msHz6SN3bW1uKqigyS56+l
 Fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785726; x=1716390526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9YixNcV0VmfO6aoH+tEoVfr0IpNqbjtk188TFL76t0=;
 b=J5JnBYy3E8vS5uGnZWf++pQsf6gKVjDqorwRCn0tqlcQXbXAOlnVe9SNQSfqznQWdA
 WhxKrX5Ah/PD7MnYKXivrERvikbo/MdBGzN0nE1wX3yGx2G6j0telTetA+YHzoWrsjvg
 axMGnKqjgn6akZxZKOoXFfLH9UyZnO2lpL/2Ter9XlbYOzrwDXjgVJ+BuY5lJL6Py96u
 UJEif20d7TdRfQ7t0TEhemolBQDLuVFYD64PkXEz7nRzqo9sFLmfqMlVrcO0nlOnz3Yf
 +l5Qx23wUdzyecJ20OcL+h6/f+vVxjcspEbosunaB7SPK6wusLwZ5+ZidGacVmARjEeX
 sFMA==
X-Gm-Message-State: AOJu0Yyp8tO1vpxsbWr9t59syr8Aux7629rEZYbCVMr9QBZ/+AKdaqDq
 hcSLzKurjUKAHwC0Y9fs12WnNMqKTGKu2h4Dr6SxI7fzy/Rl96FB2xnhamWQ33FR8WBoRZ3aS8r
 Q/3g=
X-Google-Smtp-Source: AGHT+IGl/xkcQbWkyWyczHDJZmQv50oqqNk9osB7+n48I3DuYyqxdb6m4jG1DkwuIznbKsuvcge6RA==
X-Received: by 2002:a05:600c:45d4:b0:41b:f4e1:381b with SMTP id
 5b1f17b1804b1-41fbc91f5a9mr179585225e9.2.1715785725828; 
 Wed, 15 May 2024 08:08:45 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 07/28] target/i386: Convert do_xsave_{fpu, mxcr,
 sse} to X86Access
Date: Wed, 15 May 2024 17:08:16 +0200
Message-Id: <20240515150837.259747-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 52 +++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index df12eac71e..8fbe6e00ce 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2519,11 +2519,11 @@ void helper_frstor(CPUX86State *env, target_ulong ptr, int data32)
 
 #define XO(X)  offsetof(X86XSaveArea, X)
 
-static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_fpu(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int fpus, fptag, i;
     target_ulong addr;
-    X86Access ac;
 
     fpus = (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
     fptag = 0;
@@ -2531,35 +2531,37 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
         fptag |= (env->fptags[i] << i);
     }
 
-    cpu_stw_data_ra(env, ptr + XO(legacy.fcw), env->fpuc, ra);
-    cpu_stw_data_ra(env, ptr + XO(legacy.fsw), fpus, ra);
-    cpu_stw_data_ra(env, ptr + XO(legacy.ftw), fptag ^ 0xff, ra);
+    access_stw(ac, ptr + XO(legacy.fcw), env->fpuc);
+    access_stw(ac, ptr + XO(legacy.fsw), fpus);
+    access_stw(ac, ptr + XO(legacy.ftw), fptag ^ 0xff);
 
     /* In 32-bit mode this is eip, sel, dp, sel.
        In 64-bit mode this is rip, rdp.
        But in either case we don't write actual data, just zeros.  */
-    cpu_stq_data_ra(env, ptr + XO(legacy.fpip), 0, ra); /* eip+sel; rip */
-    cpu_stq_data_ra(env, ptr + XO(legacy.fpdp), 0, ra); /* edp+sel; rdp */
+    access_stq(ac, ptr + XO(legacy.fpip), 0); /* eip+sel; rip */
+    access_stq(ac, ptr + XO(legacy.fpdp), 0); /* edp+sel; rdp */
 
     addr = ptr + XO(legacy.fpregs);
-    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_STORE, ra);
 
     for (i = 0; i < 8; i++) {
         floatx80 tmp = ST(i);
-        do_fstt(&ac, addr, tmp);
+        do_fstt(ac, addr, tmp);
         addr += 16;
     }
 }
 
-static void do_xsave_mxcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_mxcsr(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
     update_mxcsr_from_sse_status(env);
-    cpu_stl_data_ra(env, ptr + XO(legacy.mxcsr), env->mxcsr, ra);
-    cpu_stl_data_ra(env, ptr + XO(legacy.mxcsr_mask), 0x0000ffff, ra);
+    access_stl(ac, ptr + XO(legacy.mxcsr), env->mxcsr);
+    access_stl(ac, ptr + XO(legacy.mxcsr_mask), 0x0000ffff);
 }
 
-static void do_xsave_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_sse(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
     target_ulong addr;
 
@@ -2571,8 +2573,8 @@ static void do_xsave_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     addr = ptr + XO(legacy.xmm_regs);
     for (i = 0; i < nb_xmm_regs; i++) {
-        cpu_stq_data_ra(env, addr, env->xmm_regs[i].ZMM_Q(0), ra);
-        cpu_stq_data_ra(env, addr + 8, env->xmm_regs[i].ZMM_Q(1), ra);
+        access_stq(ac, addr, env->xmm_regs[i].ZMM_Q(0));
+        access_stq(ac, addr + 8, env->xmm_regs[i].ZMM_Q(1));
         addr += 16;
     }
 }
@@ -2619,20 +2621,24 @@ static void do_xsave_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
 static void do_fxsave(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
+    X86Access ac;
+
     /* The operand must be 16 byte aligned */
     if (ptr & 0xf) {
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    do_xsave_fpu(env, ptr, ra);
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_STORE, ra);
+    do_xsave_fpu(&ac, ptr);
 
     if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xsave_mxcsr(env, ptr, ra);
+        do_xsave_mxcsr(&ac, ptr);
         /* Fast FXSAVE leaves out the XMM registers */
         if (!(env->efer & MSR_EFER_FFXSR)
             || (env->hflags & HF_CPL_MASK)
             || !(env->hflags & HF_LMA_MASK)) {
-            do_xsave_sse(env, ptr, ra);
+            do_xsave_sse(&ac, ptr);
         }
     }
 }
@@ -2660,6 +2666,7 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
                      uint64_t inuse, uint64_t opt, uintptr_t ra)
 {
     uint64_t old_bv, new_bv;
+    X86Access ac;
 
     /* The OS must have enabled XSAVE.  */
     if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
@@ -2675,15 +2682,18 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     rfbm &= env->xcr0;
     opt &= rfbm;
 
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_STORE, ra);
+
     if (opt & XSTATE_FP_MASK) {
-        do_xsave_fpu(env, ptr, ra);
+        do_xsave_fpu(&ac, ptr);
     }
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that saving MXCSR is not suppressed by XSAVEOPT.  */
-        do_xsave_mxcsr(env, ptr, ra);
+        do_xsave_mxcsr(&ac, ptr);
     }
     if (opt & XSTATE_SSE_MASK) {
-        do_xsave_sse(env, ptr, ra);
+        do_xsave_sse(&ac, ptr);
     }
     if (opt & XSTATE_YMM_MASK) {
         do_xsave_ymmh(env, ptr + XO(avx_state), ra);
-- 
2.34.1


