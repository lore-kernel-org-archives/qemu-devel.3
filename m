Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0493EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFe-0003y7-5X; Wed, 15 May 2024 11:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003wD-QE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFN-0002qw-SI
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:02 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso53208795e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785728; x=1716390528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6S9A0jxcxnkPHJaqWqoqo+edkANvVkLpXEGqNBGzxw=;
 b=k2yITbFI/7OwAtb68bTKRPHLiL7JWqxO1U3JbAxEwpeoj2cMARUmsiy9Iixv2weu+C
 dyXyQd3lbx9OUbF8JaaVcY1ay/AMY6lO5djZiQbhjWkn6LS4LObiR6QUIRwT5kW5u051
 x1wSvIzk2I43VIK9QHT/O9U/0wdcQJd18gqv1aGIUdq7OQTJ3lwPka2RyCL0LlVZwb+X
 YTlPGIKJ0+YEX69eNhL683fT8ZaQEgL7lm2H2fxXnROa9iD0cqDStDn+qM/ekWtslG7I
 O7QikZflh9mYY7aq/aca2m0tT/GtfSFtZjP/c5+egoiPiUP9SsMUXIyQNFp1k4KWTRN6
 bJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785728; x=1716390528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6S9A0jxcxnkPHJaqWqoqo+edkANvVkLpXEGqNBGzxw=;
 b=ZHAvUZicJRL7MC0dZR98THO2mWuNGEgh2A15BCkeA8HjtXpmBQsrKuFq+ULjuhwy4Y
 4rpvBY3FkZJQ+Gjx706/RBwSrnzYRKyy2M4j+FeCmPGblD20cKOUrZQ/xWi7DtWNu6JN
 rJxTQT1CcwjR2D9VBVcJY3de2H9yWYMsZchZWAFXgf2pEHv7DsGxNWTJ9aiMjby/yHaL
 6vWNgNTm4OOFo1wAvLwHUG8cWDlz3r0lOF9D9MOJgvDJm2CClN5RrMFZ4Df9vTTyVIL4
 OYJx0DSrREobG2XZb4i5+cStahk7s1Lp+lg/Ize5XPfDwX4tB9doW/L8Zw2GdJZCmPWO
 CKDw==
X-Gm-Message-State: AOJu0YxLEvrvOrGarqmHw/0HyBTHF0nRUKYpJDJMRIvL7HPIt3DfXabx
 a2e89wCFAG1m8U0Ry/QsLGJSg1QjYNzUwye9OaimrwbQOWZJ08wVKKnYdKzskz6rcnrzY0h+aXb
 s+2o=
X-Google-Smtp-Source: AGHT+IGBq1xr6u8sWyjD48+VKzXlefPCthXcEzG7qhD17gpkRTsCAkh5VmKwovzUYZC5ie4azTnPwg==
X-Received: by 2002:a05:600c:26cc:b0:418:4aac:a576 with SMTP id
 5b1f17b1804b1-41fead64fdemr151824865e9.39.1715785728563; 
 Wed, 15 May 2024 08:08:48 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 11/28] target/i386: Convert do_xrstor_* to X86Access
Date: Wed, 15 May 2024 17:08:20 +0200
Message-Id: <20240515150837.259747-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


