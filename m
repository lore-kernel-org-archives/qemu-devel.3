Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04583CD1297
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3di-00039V-5z; Tue, 09 Apr 2024 01:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dg-000390-OE
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:20 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3df-0005G9-1w
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:20 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3c3aeef1385so2893280b6e.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712638998; x=1713243798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xn1vjagAhAGFyndA/SHEdLBYzd75+zPjvoYCTonqVpQ=;
 b=CXZHEw0NlNDWcym+UekgroJbNKZ0YsAXtQ8f2+fF0RyqeHygnhaQ90joTyaH8NlN+o
 JLxh1LpNMm7iEHihesL6vYfNEhGGfqUhFKqtokusKbw7/xTfFYBi3kpLjcGEa74LDvLe
 bbTsnsbO54tsWMPlpKTiEbI5tjFzHR/gIl7X6pGXKkuSstotLLpO0t2TkkdQqP84689P
 Fzvr7F2MzChO3ps2Uqdc+qbX73zLtd3Q/oT2lxghKYMITI1+FgueHLWxfjwLUep461qf
 x5aJoU4TTn7h6paba4/lWEQjmCJXfLXQxt2eVEeu80LInW83hoh7bwcrs4Hf1VEoajts
 MaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712638998; x=1713243798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xn1vjagAhAGFyndA/SHEdLBYzd75+zPjvoYCTonqVpQ=;
 b=gFGlXC2C8nSePTfKr5LuFRXP5DWIq0LDn0e3U0Zxv5j9ZyLzR4eGV29ljBtvE2gcen
 hSdu0ZNvHZevNafk4/9QWOEuglFRYLr2WffKM2TIIfxffayzkV+OWXTDYSMkAhRGMepK
 nYEllYGPeKSmqEz/mWXlSpxUZKryflxIz+oBVVtJk3tkXhMLXA5H3ldgeDKDNe1I8mSC
 uqDf+s+kNOKiaw7KQSNpGlHLMENNTD2B/eySShEAjVaRWnzqGKj6bn9eHxGoa1qsSPUt
 QR/XU8c6iSUXINAWe5/82oKiNHsywuMnmbI9a9X4P+3hC2k3Bm3ITyQ/EWp9ZsR8SJ8I
 ++fg==
X-Gm-Message-State: AOJu0Ywv2+95mcll5Qa1xIpbSV4EHMLoox2TdE6TK7slVzHQ57vz0p1q
 vNPU5y8q+czqPo30lafadgZ7g4F5FAmVR02/Mn2FzS/k2O6/j2oNRlDxRm+XSDtSI6hXdyWezf4
 x
X-Google-Smtp-Source: AGHT+IHdCNeIdg8t4fGtqaZ2+9B/ws56HK3HmBbhhIx7+vyJczVIbnfrpXz34X6p9vBhNoJyAHOVFw==
X-Received: by 2002:a05:6808:190e:b0:3c5:d512:22b5 with SMTP id
 bf14-20020a056808190e00b003c5d51222b5mr12711153oib.14.1712638997981; 
 Mon, 08 Apr 2024 22:03:17 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/28] target/i386: Convert do_xsave_* to X86Access
Date: Mon,  8 Apr 2024 19:02:44 -1000
Message-Id: <20240409050302.1523277-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

The body of do_xsave is now fully converted.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 47 ++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 23e22e4521..82a041f4bf 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2578,8 +2578,9 @@ static void do_xsave_sse(X86Access *ac, target_ulong ptr)
     }
 }
 
-static void do_xsave_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_ymmh(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
 
     if (env->hflags & HF_CS64_MASK) {
@@ -2589,33 +2590,36 @@ static void do_xsave_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
     }
 
     for (i = 0; i < nb_xmm_regs; i++, ptr += 16) {
-        cpu_stq_data_ra(env, ptr, env->xmm_regs[i].ZMM_Q(2), ra);
-        cpu_stq_data_ra(env, ptr + 8, env->xmm_regs[i].ZMM_Q(3), ra);
+        access_stq(ac, ptr, env->xmm_regs[i].ZMM_Q(2));
+        access_stq(ac, ptr + 8, env->xmm_regs[i].ZMM_Q(3));
     }
 }
 
-static void do_xsave_bndregs(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_bndregs(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     target_ulong addr = ptr + offsetof(XSaveBNDREG, bnd_regs);
     int i;
 
     for (i = 0; i < 4; i++, addr += 16) {
-        cpu_stq_data_ra(env, addr, env->bnd_regs[i].lb, ra);
-        cpu_stq_data_ra(env, addr + 8, env->bnd_regs[i].ub, ra);
+        access_stq(ac, addr, env->bnd_regs[i].lb);
+        access_stq(ac, addr + 8, env->bnd_regs[i].ub);
     }
 }
 
-static void do_xsave_bndcsr(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_bndcsr(X86Access *ac, target_ulong ptr)
 {
-    cpu_stq_data_ra(env, ptr + offsetof(XSaveBNDCSR, bndcsr.cfgu),
-                    env->bndcs_regs.cfgu, ra);
-    cpu_stq_data_ra(env, ptr + offsetof(XSaveBNDCSR, bndcsr.sts),
-                    env->bndcs_regs.sts, ra);
+    CPUX86State *env = ac->env;
+
+    access_stq(ac, ptr + offsetof(XSaveBNDCSR, bndcsr.cfgu),
+               env->bndcs_regs.cfgu);
+    access_stq(ac, ptr + offsetof(XSaveBNDCSR, bndcsr.sts),
+               env->bndcs_regs.sts);
 }
 
-static void do_xsave_pkru(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_pkru(X86Access *ac, target_ulong ptr)
 {
-    cpu_stq_data_ra(env, ptr, env->pkru, ra);
+    access_stq(ac, ptr, ac->env->pkru);
 }
 
 static void do_fxsave(X86Access *ac, target_ulong ptr)
@@ -2668,6 +2672,7 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
 {
     uint64_t old_bv, new_bv;
     X86Access ac;
+    unsigned size;
 
     /* The OS must have enabled XSAVE.  */
     if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
@@ -2683,8 +2688,8 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     rfbm &= env->xcr0;
     opt &= rfbm;
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_STORE, ra);
+    size = xsave_area_size(opt, false);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, ra);
 
     if (opt & XSTATE_FP_MASK) {
         do_xsave_fpu(&ac, ptr);
@@ -2697,22 +2702,22 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
         do_xsave_sse(&ac, ptr);
     }
     if (opt & XSTATE_YMM_MASK) {
-        do_xsave_ymmh(env, ptr + XO(avx_state), ra);
+        do_xsave_ymmh(&ac, ptr + XO(avx_state));
     }
     if (opt & XSTATE_BNDREGS_MASK) {
-        do_xsave_bndregs(env, ptr + XO(bndreg_state), ra);
+        do_xsave_bndregs(&ac, ptr + XO(bndreg_state));
     }
     if (opt & XSTATE_BNDCSR_MASK) {
-        do_xsave_bndcsr(env, ptr + XO(bndcsr_state), ra);
+        do_xsave_bndcsr(&ac, ptr + XO(bndcsr_state));
     }
     if (opt & XSTATE_PKRU_MASK) {
-        do_xsave_pkru(env, ptr + XO(pkru_state), ra);
+        do_xsave_pkru(&ac, ptr + XO(pkru_state));
     }
 
     /* Update the XSTATE_BV field.  */
-    old_bv = cpu_ldq_data_ra(env, ptr + XO(header.xstate_bv), ra);
+    old_bv = access_ldq(&ac, ptr + XO(header.xstate_bv));
     new_bv = (old_bv & ~rfbm) | (inuse & rfbm);
-    cpu_stq_data_ra(env, ptr + XO(header.xstate_bv), new_bv, ra);
+    access_stq(&ac, ptr + XO(header.xstate_bv), new_bv);
 }
 
 void helper_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
-- 
2.34.1


