Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F0C25B7B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFe-0003yO-Fi; Wed, 15 May 2024 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFY-0003vh-A2
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFM-0002qH-Oj
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4200ee78e56so31000015e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785726; x=1716390526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iDW8kJImre1GGGvGAhRzSp3Q8czb8IIa/mCnb39qel0=;
 b=hk5OZlsuBUtsKxLiz2Vr5lVyILKgKFgNSzdCOo3vlj1mDnRD2oO8QFsS4o++2Gg99I
 x12p6o6U5lJoaF6B38XBg9Yj6n4tUbm05HHXB9ofc4JsWgRLmhlcxDC1zgvxUsL5G+8Q
 OuIapn+b9vmLjwZvQAfUbJ/r8s/cbcMtl4dJdHbXtI+kyYFfLa0Z8/hHc7SqUNZxx7ox
 Kr/raagjWKR4qlRJmd3qE9vqpfGI33vmmIRUtsKa2XSsyYslDvpWlY0S2TJ0aTZ+iXCW
 4glGKdnvPZxb4Uy906wIBb0STYQtHbMTRLkj6zeP45qJ5ahTVphBY1k+95Vt32KhXe8Y
 pYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785726; x=1716390526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDW8kJImre1GGGvGAhRzSp3Q8czb8IIa/mCnb39qel0=;
 b=GqSlPF+rcWhVY67+bgfWFhdv1/rsO4MwfnrnZwoZWTM766m/rXtQFSQshXNXwS+33g
 C+WTUUVDSrpq9GncNIAt7u0LxAZZVSXpLQh1XIpg2p+3NPHvckOcVL0EC+jyRsKpCYVQ
 pCtzMByEUUvTXu7rG9j4wdejLwbUzJQVZqNEtZ0Qf0wgRJ5oXWnsIQEhtA70m0zXS8lK
 /eaXglWY5NgladelnNh6ABakkQ9FsnmQE/itPlhW7rfDHc4VBRgTFSHVvDTfTXaJ9oJf
 eumfwqhXNNJv/9/FCoRXePJDKB1tGg2yJW3b/kz0JfRLFv179QzG6E22nvU76C23413X
 JhAA==
X-Gm-Message-State: AOJu0YzQDJY540vwc+BvZzdMAquoqlYsvbdfSv9yh9H5JOxthgkMuid3
 Mnn1WVbX+gyVPBqR1YgY+Qgv7mcYHbVzeDR/k9tsb6v3+zL02XafCkCLv0SZYGUW1LXYjFBu7FN
 cRwE=
X-Google-Smtp-Source: AGHT+IE1W8U3gXMCS5JuOesFM3uTZ21STI5e7kHGf+HbP90u9kORd7sxhSaQ6EUn8HPnSN7n4rPLwQ==
X-Received: by 2002:a05:600c:4f06:b0:420:1094:65d with SMTP id
 5b1f17b1804b1-42010940753mr97907845e9.12.1715785726480; 
 Wed, 15 May 2024 08:08:46 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 08/28] target/i386: Convert do_xrstor_{fpu, mxcr,
 sse} to X86Access
Date: Wed, 15 May 2024 17:08:17 +0200
Message-Id: <20240515150837.259747-9-richard.henderson@linaro.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 target/i386/tcg/fpu_helper.c | 46 ++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 8fbe6e00ce..f21cdb45ea 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2725,39 +2725,41 @@ void helper_xsaveopt(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
     do_xsave(env, ptr, rfbm, inuse, inuse, GETPC());
 }
 
-static void do_xrstor_fpu(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_fpu(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, fpuc, fpus, fptag;
     target_ulong addr;
-    X86Access ac;
 
-    fpuc = cpu_lduw_data_ra(env, ptr + XO(legacy.fcw), ra);
-    fpus = cpu_lduw_data_ra(env, ptr + XO(legacy.fsw), ra);
-    fptag = cpu_lduw_data_ra(env, ptr + XO(legacy.ftw), ra);
+    fpuc = access_ldw(ac, ptr + XO(legacy.fcw));
+    fpus = access_ldw(ac, ptr + XO(legacy.fsw));
+    fptag = access_ldw(ac, ptr + XO(legacy.ftw));
     cpu_set_fpuc(env, fpuc);
     cpu_set_fpus(env, fpus);
+
     fptag ^= 0xff;
     for (i = 0; i < 8; i++) {
         env->fptags[i] = ((fptag >> i) & 1);
     }
 
     addr = ptr + XO(legacy.fpregs);
-    access_prepare(&ac, env, addr, 8 * 16, MMU_DATA_LOAD, ra);
 
     for (i = 0; i < 8; i++) {
-        floatx80 tmp = do_fldt(&ac, addr);
+        floatx80 tmp = do_fldt(ac, addr);
         ST(i) = tmp;
         addr += 16;
     }
 }
 
-static void do_xrstor_mxcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_mxcsr(X86Access *ac, target_ulong ptr)
 {
-    cpu_set_mxcsr(env, cpu_ldl_data_ra(env, ptr + XO(legacy.mxcsr), ra));
+    CPUX86State *env = ac->env;
+    cpu_set_mxcsr(env, access_ldl(ac, ptr + XO(legacy.mxcsr)));
 }
 
-static void do_xrstor_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_sse(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
     target_ulong addr;
 
@@ -2769,8 +2771,8 @@ static void do_xrstor_sse(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
     addr = ptr + XO(legacy.xmm_regs);
     for (i = 0; i < nb_xmm_regs; i++) {
-        env->xmm_regs[i].ZMM_Q(0) = cpu_ldq_data_ra(env, addr, ra);
-        env->xmm_regs[i].ZMM_Q(1) = cpu_ldq_data_ra(env, addr + 8, ra);
+        env->xmm_regs[i].ZMM_Q(0) = access_ldq(ac, addr);
+        env->xmm_regs[i].ZMM_Q(1) = access_ldq(ac, addr + 8);
         addr += 16;
     }
 }
@@ -2850,20 +2852,24 @@ static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 
 static void do_fxrstor(CPUX86State *env, target_ulong ptr, uintptr_t ra)
 {
+    X86Access ac;
+
     /* The operand must be 16 byte aligned */
     if (ptr & 0xf) {
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    do_xrstor_fpu(env, ptr, ra);
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_LOAD, ra);
+    do_xrstor_fpu(&ac, ptr);
 
     if (env->cr[4] & CR4_OSFXSR_MASK) {
-        do_xrstor_mxcsr(env, ptr, ra);
+        do_xrstor_mxcsr(&ac, ptr);
         /* Fast FXRSTOR leaves out the XMM registers */
         if (!(env->efer & MSR_EFER_FFXSR)
             || (env->hflags & HF_CPL_MASK)
             || !(env->hflags & HF_LMA_MASK)) {
-            do_xrstor_sse(env, ptr, ra);
+            do_xrstor_sse(&ac, ptr);
         }
     }
 }
@@ -2876,6 +2882,7 @@ void helper_fxrstor(CPUX86State *env, target_ulong ptr)
 static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr_t ra)
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
+    X86Access ac;
 
     rfbm &= env->xcr0;
 
@@ -2914,9 +2921,12 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
+    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
+                   MMU_DATA_LOAD, ra);
+
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
-            do_xrstor_fpu(env, ptr, ra);
+            do_xrstor_fpu(&ac, ptr);
         } else {
             do_fninit(env);
             memset(env->fpregs, 0, sizeof(env->fpregs));
@@ -2925,9 +2935,9 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_SSE_MASK) {
         /* Note that the standard form of XRSTOR loads MXCSR from memory
            whether or not the XSTATE_BV bit is set.  */
-        do_xrstor_mxcsr(env, ptr, ra);
+        do_xrstor_mxcsr(&ac, ptr);
         if (xstate_bv & XSTATE_SSE_MASK) {
-            do_xrstor_sse(env, ptr, ra);
+            do_xrstor_sse(&ac, ptr);
         } else {
             do_clear_sse(env);
         }
-- 
2.34.1


