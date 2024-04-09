Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540BECD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3df-00038a-Df; Tue, 09 Apr 2024 01:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dd-00037u-RY
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:17 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dc-0005El-06
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:17 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-229a90b7aa9so2326353fac.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638994; x=1713243794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kKpDLagrZYAiIJ964rsnwQrd7WyWBxSid17PdqzgjX0=;
 b=tkpTZW2nPICETU9UfFP2cTlfekW5vFsULFYfpFaHzrkchYlHUMzGZEE5v0x1bk2OzY
 0656o1tIZ1PPP9PB4rMlXgbjufykdRG9ys38IKYuZ5n9EXRnP9VdwFz9gF7TcYOdHhiD
 Y7jIq5htreMAat13hBlNxTdpccwhAajYBGq6SKBwg2TPORHwIg7GN9ZNklEUc3R3JZUN
 VYOGkfTJITr0XbJ6fOaODYvkLwdqftpGrqbwabmuv7f/pPV5ZhxAeif9PO+rEpFKlkZN
 njlw7nVVVw7DeYcW4GY8tZlzHZ3rpXQTceXCvdAAozTR4ovwk46gPsoPXfrf3DkFN5x+
 +3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638994; x=1713243794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKpDLagrZYAiIJ964rsnwQrd7WyWBxSid17PdqzgjX0=;
 b=KKKqeSO4I1rb8iKZUPs/K4Z5aMZRl3mh6dpgXlt2GgW8lv1DPn0snguWvYtH6lQ2RU
 IPhdio1LCXRmpS5k/J4bG13sFLLtLZusE4iPbK0i1MfHPpDfKQtWO1oHN/81UmIg/LwY
 Zo/AZFjCY/Rwy/ORrXNgzbVRapbysrs7JXwOlmHWY5MO3KGEslVtBoYl9W3sxIotDGAk
 NOj17OF8eO5ApQytPhdgCSTwdVgDIgVZaPJ95/BbY2sS7lI3gulN02nzSXmbJiU5qDo6
 oaGZM3UE7glUYcrzpEIr7yis9rb3z7k8RuKPsY+BpN+rIZX0Ufr1iU+FPhxpKzLaFIq+
 no2w==
X-Gm-Message-State: AOJu0YyoaJyQsvs7TmukmzMrkYthRfkQR7nRFeDF/Mdy8oGUEbGgfzrB
 MWhM/y6e5Cnkh0zGqfQtjUcyFP+bBuqisqzMNtPkDkW5OL4UQvFTmpGwan+iVy/RSKKnAqF9Fsx
 9
X-Google-Smtp-Source: AGHT+IGUeHvwCT7WiTYTkcBex9eGNTkbGu24+Zg4WmwOkvqSR2Cm/Afd6kAZkl36lsZhR1zH5BaHqA==
X-Received: by 2002:a05:6870:82a1:b0:22e:bc50:3492 with SMTP id
 q33-20020a05687082a100b0022ebc503492mr10175727oae.47.1712638994360; 
 Mon, 08 Apr 2024 22:03:14 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/28] target/i386: Convert do_xsave_{fpu, mxcr,
 sse} to X86Access
Date: Mon,  8 Apr 2024 19:02:41 -1000
Message-Id: <20240409050302.1523277-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 52 +++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index e6fa161aa0..643e017bef 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2518,11 +2518,11 @@ void helper_frstor(CPUX86State *env, target_ulong ptr, int data32)
 
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
@@ -2530,35 +2530,37 @@ static void do_xsave_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
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
-    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_STORE, GETPC());
 
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
 
@@ -2570,8 +2572,8 @@ static void do_xsave_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     addr = ptr + XO(legacy.xmm_regs);
     for (i = 0; i < nb_xmm_regs; i++) {
-        cpu_stq_data_ra(env, addr, env->xmm_regs[i].ZMM_Q(0), ra);
-        cpu_stq_data_ra(env, addr + 8, env->xmm_regs[i].ZMM_Q(1), ra);
+        access_stq(ac, addr, env->xmm_regs[i].ZMM_Q(0));
+        access_stq(ac, addr + 8, env->xmm_regs[i].ZMM_Q(1));
         addr += 16;
     }
 }
@@ -2618,20 +2620,24 @@ static void do_xsave_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
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
@@ -2659,6 +2665,7 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
                      uint64_t inuse, uint64_t opt, uintptr_t ra)
 {
     uint64_t old_bv, new_bv;
+    X86Access ac;
 
     /* The OS must have enabled XSAVE.  */
     if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
@@ -2674,15 +2681,18 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
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


