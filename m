Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECE1C25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFS-0003tO-FN; Wed, 15 May 2024 11:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFP-0003rs-8a
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFN-0002qd-EE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so45366995e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785728; x=1716390528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8W7kdXBVphE/G8J+gJEIX1gz3O6+dJRyyNI2VZW5z4A=;
 b=MT8p7SnF6YcdPyP2SRVhF7e3k2T7a3ndnZZdaXC9O8tdaYWwbhE+47NcukEzbkm6Qb
 9v+nn7xwvdIEnjz7IP+JHmjc6zrwO78qqUKrHXvzbtZ4V2hE7mF7cij5wDlueJ71TCqd
 sNcEm0zrcYGkXwwXcGP2wLZIaec3qEgQQtMJ5B/LvSw7dn0K4M2o5zn1Y9OFmSH7mDUe
 bVRlN6k9Davz0OD8tCXg1Q1FVi9S0u7Dw5z6gEn36jLCmerwSti9ezY4l9PJUgz41LMZ
 srrtx4UUFWhcjJU0Ery10nvqe4v4aDUqgsJVVGoLqm62tzb7veB7t2jhkWcJwUlH3/2q
 xSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785728; x=1716390528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8W7kdXBVphE/G8J+gJEIX1gz3O6+dJRyyNI2VZW5z4A=;
 b=feag4mSshcN/LEFp7si1K57SHu2IB3kLBatje1cX5DJ8h9TKebJXFiRu7HaAOcHmPi
 kipWB0deQkCI+uTzHaZpNLSN2OlK2Cv/7uO0IU/pMJJGlRLMsWOehAx0sXre8xwkfCB5
 PhHP/EgEfTA1BE8Qkc2/47PYAEF+tPo9/X/sgPqoFXGuNlkBpAtIWTVgqTakpZ+O9xQ1
 e6fJAeE9S3fNq4zTA1Ct8t/OKMR1lBxOvixR//zMHSBGXqqvc38S1cxSpDGFBjsP3DET
 ZaYxDLqGq2RAQLSJecgB6I5/qLfBSXzzYejwYZ9/qiUexVOXALoz5hbSPY/pfr9NX5hD
 tGwQ==
X-Gm-Message-State: AOJu0Yw/l0IrTlZzndTRMTjbjSG2W3XI4WJrpDLW9O5yQRQRs2mehdPT
 ixYhmNGmubBVPNy8IAim33brzsKnTTRB+c0Ad6dR9BL4B0dlr3IkWVWSUr1VpSR5+BeeqPHKKKd
 NQxk=
X-Google-Smtp-Source: AGHT+IGmfqiTzkYKr4MqHX4f3/+/x4OBnWowk1fAOG/K9ahQgVfqAdhuCNwZkH5Jx/BsYY+RxWlkrQ==
X-Received: by 2002:a05:600c:3c83:b0:41b:8041:53c2 with SMTP id
 5b1f17b1804b1-41feac51e04mr161177545e9.15.1715785727847; 
 Wed, 15 May 2024 08:08:47 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 10/28] target/i386: Convert do_xsave_* to X86Access
Date: Wed, 15 May 2024 17:08:19 +0200
Message-Id: <20240515150837.259747-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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


