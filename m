Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52DAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZU-0007NH-30; Sun, 26 May 2024 20:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZK-0007FF-Vp
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:31 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ3-0003bI-RD
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:30 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f8ecafd28cso2172585b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771011; x=1717375811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6S9A0jxcxnkPHJaqWqoqo+edkANvVkLpXEGqNBGzxw=;
 b=Ov+pbUbciM3bBfOO6IrKBOFlk/Natt3A/WHnMPeehJ8x51w2Iu7RoMZdmz8w/SUmUn
 FbiItVrSXG1AXyjYrL3wtlflozfGtmWTgkrB2gVP/DBJAwmT4jwHrIVyPTxGC4js4Tjo
 81gaHdz969WzMqkCpuIg8gvhu34c4sxN1Tz0xXFdiOrwIWrmd1Yk/FYKYYQBZk1fpNcb
 /cq1O0h5psL6Tc4TkgZ3m4lrS5XMlJxhpaYqArY7YsG3QilvncZfTRnc0MPxrkcnKze1
 RlWD77LWK5sr8HebpjC5C7i5T6qsWDTCnTQ9vzXz5o/Tnt6FIGA2+uLZYyr8aI4FWH3D
 ezFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771011; x=1717375811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6S9A0jxcxnkPHJaqWqoqo+edkANvVkLpXEGqNBGzxw=;
 b=BpSCddiibLdAmdDRbo42gKkZglv5cs0qwg6guPncAeJyalkG96JQeyZ+ykDldsKNTV
 aaaHz9PUYG/qjzYpElLFLAeyvQhi/ZgdQF+Ux67s3Sy/nS09NYhSgVNyw2dsVjPe4rWz
 uc9dAmI63/twyXjAsZ6OKEhsTdFHZSn5KyPeM71D9bDcfGQsWiXmg2BW12go3/kwCsGa
 27nVd+G+yr4cKdietw3GdCk18/z0bWj2xjj7vtg2+LnwK9bzceC29FjvJDWo/TrFMGw5
 EgCebtZeDtgrnqKIW2awOdW/K+WpBPel8dONaP2BU0kblbPZgjl6lwOvssANUKNnKsdK
 J0Ag==
X-Gm-Message-State: AOJu0YzlCMfrSlRCVj6ZiCTLmQpI2hoJkrO8k6M5CYoio0j4leXmnEiO
 wfoLU0z0gISEoZnXX4OM/K4qofPMHhgCWNExOoR4TTvu7pKS72lmbzdA29Hc0XmnGZG6AcgWic9
 +
X-Google-Smtp-Source: AGHT+IFyTa7BllHv/3GT/HuLnE6MgoDCN4KpFIzdr4HuxYscHd5mIP3tdOUr7LBMxrfG2Y/STuxySw==
X-Received: by 2002:a05:6a00:4093:b0:6e6:9f47:c18c with SMTP id
 d2e1a72fcca58-6f8f41a9f2dmr7955334b3a.33.1716771011329; 
 Sun, 26 May 2024 17:50:11 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 11/28] target/i386: Convert do_xrstor_* to X86Access
Date: Sun, 26 May 2024 17:49:44 -0700
Message-Id: <20240527005001.642825-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

The body of do_xrstor is now fully converted.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 51 ++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 356397a4ab..7796688514 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2800,8 +2800,9 @@ static void do_clear_sse(CPUX86State *env)
     }
 }
 
-static void do_xrstor_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_ymmh(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
 
     if (env->hflags & HF_CS64_MASK) {
@@ -2811,8 +2812,8 @@ static void do_xrstor_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     }
 
     for (i = 0; i < nb_xmm_regs; i++, ptr += 16) {
-        env->xmm_regs[i].ZMM_Q(2) = cpu_ldq_data_ra(env, ptr, ra);
-        env->xmm_regs[i].ZMM_Q(3) = cpu_ldq_data_ra(env, ptr + 8, ra);
+        env->xmm_regs[i].ZMM_Q(2) = access_ldq(ac, ptr);
+        env->xmm_regs[i].ZMM_Q(3) = access_ldq(ac, ptr + 8);
     }
 }
 
@@ -2832,29 +2833,32 @@ static void do_clear_ymmh(CPUX86State *env)
     }
 }
 
-static void do_xrstor_bndregs(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_bndregs(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     target_ulong addr = ptr + offsetof(XSaveBNDREG, bnd_regs);
     int i;
 
     for (i = 0; i < 4; i++, addr += 16) {
-        env->bnd_regs[i].lb = cpu_ldq_data_ra(env, addr, ra);
-        env->bnd_regs[i].ub = cpu_ldq_data_ra(env, addr + 8, ra);
+        env->bnd_regs[i].lb = access_ldq(ac, addr);
+        env->bnd_regs[i].ub = access_ldq(ac, addr + 8);
     }
 }
 
-static void do_xrstor_bndcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_bndcsr(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
+
     /* FIXME: Extend highest implemented bit of linear address.  */
     env->bndcs_regs.cfgu
-        = cpu_ldq_data_ra(env, ptr + offsetof(XSaveBNDCSR, bndcsr.cfgu), ra);
+        = access_ldq(ac, ptr + offsetof(XSaveBNDCSR, bndcsr.cfgu));
     env->bndcs_regs.sts
-        = cpu_ldq_data_ra(env, ptr + offsetof(XSaveBNDCSR, bndcsr.sts), ra);
+        = access_ldq(ac, ptr + offsetof(XSaveBNDCSR, bndcsr.sts));
 }
 
-static void do_xrstor_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xrstor_pkru(X86Access *ac, target_ulong ptr)
 {
-    env->pkru = cpu_ldq_data_ra(env, ptr, ra);
+    ac->env->pkru = access_ldq(ac, ptr);
 }
 
 static void do_fxrstor(X86Access *ac, target_ulong ptr)
@@ -2892,6 +2896,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
 {
     uint64_t xstate_bv, xcomp_bv, reserve0;
     X86Access ac;
+    unsigned size, size_ext;
 
     rfbm &= env->xcr0;
 
@@ -2905,7 +2910,10 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    xstate_bv = cpu_ldq_data_ra(env, ptr + XO(header.xstate_bv), ra);
+    size = sizeof(X86LegacyXSaveArea) + sizeof(X86XSaveHeader);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_LOAD, ra);
+
+    xstate_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
 
     if ((int64_t)xstate_bv < 0) {
         /* FIXME: Compact form.  */
@@ -2924,14 +2932,17 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
        describes only XCOMP_BV, but the description of the standard form
        of XRSTOR (Vol 1, Sec 13.8.1) checks bytes 23:8 for zero, which
        includes the next 64-bit field.  */
-    xcomp_bv = cpu_ldq_data_ra(env, ptr + XO(header.xcomp_bv), ra);
-    reserve0 = cpu_ldq_data_ra(env, ptr + XO(header.reserve0), ra);
+    xcomp_bv = access_ldq(&ac, ptr + XO(header.xcomp_bv));
+    reserve0 = access_ldq(&ac, ptr + XO(header.reserve0));
     if (xcomp_bv || reserve0) {
         raise_exception_ra(env, EXCP0D_GPF, ra);
     }
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_LOAD, ra);
+    size_ext = xsave_area_size(rfbm & xstate_bv, false);
+    if (size < size_ext) {
+        /* TODO: See if existing page probe has covered extra size. */
+        access_prepare(&ac, env, ptr, size_ext, MMU_DATA_LOAD, ra);
+    }
 
     if (rfbm & XSTATE_FP_MASK) {
         if (xstate_bv & XSTATE_FP_MASK) {
@@ -2953,14 +2964,14 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_YMM_MASK) {
         if (xstate_bv & XSTATE_YMM_MASK) {
-            do_xrstor_ymmh(env, ptr + XO(avx_state), ra);
+            do_xrstor_ymmh(&ac, ptr + XO(avx_state));
         } else {
             do_clear_ymmh(env);
         }
     }
     if (rfbm & XSTATE_BNDREGS_MASK) {
         if (xstate_bv & XSTATE_BNDREGS_MASK) {
-            do_xrstor_bndregs(env, ptr + XO(bndreg_state), ra);
+            do_xrstor_bndregs(&ac, ptr + XO(bndreg_state));
             env->hflags |= HF_MPX_IU_MASK;
         } else {
             memset(env->bnd_regs, 0, sizeof(env->bnd_regs));
@@ -2969,7 +2980,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     }
     if (rfbm & XSTATE_BNDCSR_MASK) {
         if (xstate_bv & XSTATE_BNDCSR_MASK) {
-            do_xrstor_bndcsr(env, ptr + XO(bndcsr_state), ra);
+            do_xrstor_bndcsr(&ac, ptr + XO(bndcsr_state));
         } else {
             memset(&env->bndcs_regs, 0, sizeof(env->bndcs_regs));
         }
@@ -2978,7 +2989,7 @@ static void do_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm, uintptr
     if (rfbm & XSTATE_PKRU_MASK) {
         uint64_t old_pkru = env->pkru;
         if (xstate_bv & XSTATE_PKRU_MASK) {
-            do_xrstor_pkru(env, ptr + XO(pkru_state), ra);
+            do_xrstor_pkru(&ac, ptr + XO(pkru_state));
         } else {
             env->pkru = 0;
         }
-- 
2.34.1


