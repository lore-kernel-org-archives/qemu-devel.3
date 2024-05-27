Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F060C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZP-0007Il-6w; Sun, 26 May 2024 20:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZA-00077k-SE
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:22 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ2-0003b8-Us
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:19 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b9794dad09so1215077eaf.3
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771010; x=1717375810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W7kdXBVphE/G8J+gJEIX1gz3O6+dJRyyNI2VZW5z4A=;
 b=ipLPt+HA3Pf6K7NWLA6YRqZOz/qqp3GMS2OCV0dD5U4aBfqx9KMtl0b1l16ITn4mOE
 ILlQ6OEKtiWl1HCl4AXfsdXQ1wU6z1P2CsVQKuxkBXeeNET+59vcLjHmd5lOWC7kfeGA
 ppC8pkIqWF75kURAe7MuLoBOMdkvXTkQg1E9raCgGKi/Nqg7l737mD2A+lC6/jwdEwF4
 T+FHU8Tq69gjovIXS9Avr0vnBmGBOQsnUzSg2AljALjdVPZ/FK+J3kxBmg+MoHxNpYNc
 BwsefpdqNrRqFCj3K8IEpoYoch6aUsJKzEJogvM2/Yd10NP2xVUd86L986gK//ArmSJz
 Uhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771010; x=1717375810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W7kdXBVphE/G8J+gJEIX1gz3O6+dJRyyNI2VZW5z4A=;
 b=XuyVPr0ehGuZxksm+kyhOBRrPsvyL7kdYboLGhCkOV58908FfFOxhY/qTARwJ9OsDY
 WEz+i5BtEXTNSNa/hAEyuu5n59/8tjbygqRST1jhc2t2t1oJr7Cl+IpuSIla7/3offXC
 +sLWRIgVfma29E02+EVKmOlVUA9U8xBmTnVMiboU3hqOHnUZI+ScxN/QlriJ9s1iY42p
 V8Z9ybi9KUHBuHmEIg/f2RK1eC2w41jq9bNTyw64TZmLBSSIzEMp8iVbCBCqs3qC06j3
 urxNKSRjUNChRRCAlZ/SPowgOwqceR4t/Ly6rJdgjHPX3cuc0BhGEOINQ/G1qnMycF19
 Nh1Q==
X-Gm-Message-State: AOJu0Yw9O0alzvB8wTnjPxO62a6+hXm7OyMLucGLdkpssR8iDzQRMmYW
 Oa0/zmMsHf9102m2YzOtI9eIvc+PhsVnbz46I7uCAGeQ4ATpn5iCrKxJPE1ZP+5fWfHX5+RY4eN
 f
X-Google-Smtp-Source: AGHT+IGDlBAaWioWHwMofoTXDV/4jtd0d7ODpScT2knPuDScP0kYMsfRLEKOwWEOoVqDIQ7zbO1sjw==
X-Received: by 2002:a05:6870:b512:b0:24c:b769:3cfe with SMTP id
 586e51a60fabf-24cb7695718mr7664734fac.28.1716771010429; 
 Sun, 26 May 2024 17:50:10 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/28] target/i386: Convert do_xsave_* to X86Access
Date: Sun, 26 May 2024 17:49:43 -0700
Message-Id: <20240527005001.642825-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

The body of do_xsave is now fully converted.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/fpu_helper.c | 47 ++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4dcb0b92ff..356397a4ab 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2579,8 +2579,9 @@ static void do_xsave_sse(X86Access *ac, target_ulong ptr)
     }
 }
 
-static void do_xsave_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
+static void do_xsave_ymmh(X86Access *ac, target_ulong ptr)
 {
+    CPUX86State *env = ac->env;
     int i, nb_xmm_regs;
 
     if (env->hflags & HF_CS64_MASK) {
@@ -2590,33 +2591,36 @@ static void do_xsave_ymmh(CPUX86State *env, target_ulong ptr, uintptr_t ra)
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
@@ -2669,6 +2673,7 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
 {
     uint64_t old_bv, new_bv;
     X86Access ac;
+    unsigned size;
 
     /* The OS must have enabled XSAVE.  */
     if (!(env->cr[4] & CR4_OSXSAVE_MASK)) {
@@ -2684,8 +2689,8 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
     rfbm &= env->xcr0;
     opt &= rfbm;
 
-    access_prepare(&ac, env, ptr, sizeof(X86LegacyXSaveArea),
-                   MMU_DATA_STORE, ra);
+    size = xsave_area_size(opt, false);
+    access_prepare(&ac, env, ptr, size, MMU_DATA_STORE, ra);
 
     if (opt & XSTATE_FP_MASK) {
         do_xsave_fpu(&ac, ptr);
@@ -2698,22 +2703,22 @@ static void do_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm,
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


