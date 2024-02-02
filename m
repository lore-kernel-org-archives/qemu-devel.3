Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5011C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 05:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVmWi-0007Bz-7g; Fri, 02 Feb 2024 00:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWg-0007A7-0V
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:46 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVmWd-0003KD-4n
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 00:55:45 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d71cb97937so16372295ad.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 21:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706853342; x=1707458142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULiNZjMoC+ixiCPJhcdGEZXbCkj2T5rK3rV/1qTi1po=;
 b=u79Jo7YIqDuLXv+XVa4GCyQV+PT+kXd1jBRA/Yf6xvEtcTVq5ZgM0myPzwxndIkJf6
 WPcshgVn5xN90YwlPUkcg/mLEkJcZdzsVnYPe8fVufUqpXiMWSNUBL/LPyn/YDgHoJx1
 EjTql9ZsQxuFlWuYP/yqBH6Ru3KLa9nMB8qMbfXJnfPMVB4raGhkc3HmDSFilgtldMNa
 Gqe0fAlJbFs5xdxjCWZ9eaYdCkVVDPT4KqTabRMSEEm57pDRBXkIm2DG+zYuvsksFjOk
 Vp0JQ691qciy+HbTD5TmV974Ouru1eeonVhTVfOiMGQ0XCDGkDWthjZHNNRlYpuky/FU
 cpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706853342; x=1707458142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ULiNZjMoC+ixiCPJhcdGEZXbCkj2T5rK3rV/1qTi1po=;
 b=ovCYxH2S2hepYJYEE7yfw3J8E3tkoaUsD/Bt32O8y2gqBSyaYIJSBBDXETg8OYmk53
 f93zsABbGJ2OnFDtPNKqN/iRG8/USH0C7D+cZ6tStY+L7OleBwNLm4yyi9YbLTdwd+xY
 buAQNhfGWI8CQ7ikV9OFFB7Q/C8xYBKmvoy+H6R9evS31hMLqLxsm3mzEqoRMrNWy9ge
 DojofZ7lUPZCmQlvcjrgVia1yiFxFX5obaqj6rmU+tNRleTcmuevYLK+B8/0CY4R+jfK
 du+dsbMXkTRoS7OXTJ3IV30R2sISDm8aNBYO1DKQLBVWLDSOxpgt4qJFrQXRgOEVVP20
 C74A==
X-Gm-Message-State: AOJu0YwkWNibOlJQDGTzD6vQT/xBvr68IBGPYCQ3kE1BT4lIOWKkklRl
 7AkxHgw8QZwGHs7MGjzK+S2apKfIBNT9ki5Fg7/KCAP6j8V6DztvSBZebmv3RVDXgmNiyxSpv38
 NZFc=
X-Google-Smtp-Source: AGHT+IEeVfdJzDAMouV3533MpWnvoDaurVMMDayuDEpske9cP5pKJCxOeXcmlC+Z5II5Cv+lSlhY+A==
X-Received: by 2002:a17:902:bf4c:b0:1d7:3067:aab5 with SMTP id
 u12-20020a170902bf4c00b001d73067aab5mr6327651pls.57.1706853341769; 
 Thu, 01 Feb 2024 21:55:41 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001d8a80cbb15sm752059plb.238.2024.02.01.21.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 21:55:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 54/57] target/sparc: Split cexc and ftt from env->fsr
Date: Fri,  2 Feb 2024 15:50:33 +1000
Message-Id: <20240202055036.684176-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202055036.684176-1-richard.henderson@linaro.org>
References: <20240202055036.684176-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

These two fields are adjusted by all FPop insns.
Having them separate makes it easier to set without masking.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231103173841.33651-20-richard.henderson@linaro.org>
---
 target/sparc/cpu.h        |  7 +++++-
 target/sparc/helper.h     |  2 +-
 target/sparc/fop_helper.c | 46 ++++++++++++++++++---------------------
 target/sparc/translate.c  | 31 ++++++++++++++++----------
 4 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 216155d231..c5be9e37de 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -176,6 +176,7 @@ enum {
 #define FSR_DZM   (1ULL << 24)
 #define FSR_NXM   (1ULL << 23)
 #define FSR_TEM_MASK (FSR_NVM | FSR_OFM | FSR_UFM | FSR_DZM | FSR_NXM)
+#define FSR_TEM_SHIFT  23
 
 #define FSR_NVA   (1ULL << 9)
 #define FSR_OFA   (1ULL << 8)
@@ -183,6 +184,7 @@ enum {
 #define FSR_DZA   (1ULL << 6)
 #define FSR_NXA   (1ULL << 5)
 #define FSR_AEXC_MASK (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR_NXA)
+#define FSR_AEXC_SHIFT 5
 
 #define FSR_NVC   (1ULL << 4)
 #define FSR_OFC   (1ULL << 3)
@@ -464,7 +466,10 @@ struct CPUArchState {
     target_ulong cond; /* conditional branch result (XXX: save it in a
                           temporary register when possible) */
 
-    target_ulong fsr;      /* FPU state register */
+    /* FPU State Register, in parts */
+    target_ulong fsr;       /* rm, tem, aexc, fcc* */
+    uint32_t fsr_cexc_ftt;  /* cexc, ftt */
+
     CPU_DoubleU fpr[TARGET_DPREGS];  /* floating point registers */
     uint32_t cwp;      /* index of current register window (extracted
                           from PSR) */
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 7c688edd62..7466164468 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -36,7 +36,7 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(get_fsr, TCG_CALL_NO_WG_SE, tl, env)
-DEF_HELPER_FLAGS_2(set_fsr, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_2(set_fsr_noftt, 0, void, env, tl)
 DEF_HELPER_FLAGS_2(fsqrts, 0, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, 0, f64, env, f64)
 DEF_HELPER_FLAGS_2(fsqrtq, 0, i128, env, i128)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index 755117ea08..ac30f88810 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -48,9 +48,7 @@ static inline Int128 f128_ret(float128 f)
 static void check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
 {
     target_ulong status = get_float_exception_flags(&env->fp_status);
-    target_ulong fsr = env->fsr;
-
-    fsr &= FSR_FTT_CEXC_NMASK;
+    uint32_t cexc = 0;
 
     if (unlikely(status)) {
         /* Keep exception flags clear for next time.  */
@@ -58,38 +56,33 @@ static void check_ieee_exceptions(CPUSPARCState *env, uintptr_t ra)
 
         /* Copy IEEE 754 flags into FSR */
         if (status & float_flag_invalid) {
-            fsr |= FSR_NVC;
+            cexc |= FSR_NVC;
         }
         if (status & float_flag_overflow) {
-            fsr |= FSR_OFC;
+            cexc |= FSR_OFC;
         }
         if (status & float_flag_underflow) {
-            fsr |= FSR_UFC;
+            cexc |= FSR_UFC;
         }
         if (status & float_flag_divbyzero) {
-            fsr |= FSR_DZC;
+            cexc |= FSR_DZC;
         }
         if (status & float_flag_inexact) {
-            fsr |= FSR_NXC;
+            cexc |= FSR_NXC;
         }
 
-        if ((fsr & FSR_CEXC_MASK) & ((fsr & FSR_TEM_MASK) >> 23)) {
-            CPUState *cs = env_cpu(env);
-
-            /* Unmasked exception, generate a trap.  Note that while
-               the helper is marked as NO_WG, we can get away with
-               writing to cpu state along the exception path, since
-               TCG generated code will never see the write.  */
-            env->fsr = fsr | FSR_FTT_IEEE_EXCP;
-            cs->exception_index = TT_FP_EXCP;
-            cpu_loop_exit_restore(cs, ra);
-        } else {
-            /* Accumulate exceptions */
-            fsr |= (fsr & FSR_CEXC_MASK) << 5;
+        if (cexc & (env->fsr >> FSR_TEM_SHIFT)) {
+            /* Unmasked exception, generate an IEEE trap. */
+            env->fsr_cexc_ftt = cexc | FSR_FTT_IEEE_EXCP;
+            cpu_raise_exception_ra(env, TT_FP_EXCP, ra);
         }
+
+        /* Accumulate exceptions */
+        env->fsr |= cexc << FSR_AEXC_SHIFT;
     }
 
-    env->fsr = fsr;
+    /* No trap, so FTT is cleared. */
+    env->fsr_cexc_ftt = cexc;
 }
 
 float32 helper_fadds(CPUSPARCState *env, float32 src1, float32 src2)
@@ -456,7 +449,7 @@ GEN_FCMP(fcmpeq_fcc3, float128, 26, 1);
 
 target_ulong cpu_get_fsr(CPUSPARCState *env)
 {
-    target_ulong fsr = env->fsr;
+    target_ulong fsr = env->fsr | env->fsr_cexc_ftt;
 
     /* VER is kept completely separate until re-assembly. */
     fsr |= env->def.fpu_version;
@@ -473,7 +466,7 @@ static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 {
     int rnd_mode;
 
-    env->fsr = fsr & ~FSR_VER_MASK;
+    env->fsr = fsr & ~(FSR_VER_MASK | FSR_CEXC_MASK | FSR_FTT_MASK);
 
     switch (fsr & FSR_RD_MASK) {
     case FSR_RD_NEAREST:
@@ -495,10 +488,13 @@ static void set_fsr_nonsplit(CPUSPARCState *env, target_ulong fsr)
 
 void cpu_put_fsr(CPUSPARCState *env, target_ulong fsr)
 {
+    env->fsr_cexc_ftt = fsr & (FSR_CEXC_MASK | FSR_FTT_MASK);
     set_fsr_nonsplit(env, fsr);
 }
 
-void helper_set_fsr(CPUSPARCState *env, target_ulong fsr)
+void helper_set_fsr_noftt(CPUSPARCState *env, target_ulong fsr)
 {
+    env->fsr_cexc_ftt &= FSR_FTT_MASK;
+    env->fsr_cexc_ftt |= fsr & FSR_CEXC_MASK;
     set_fsr_nonsplit(env, fsr);
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 25f93ec44a..5b9bbeb8ff 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1199,7 +1199,8 @@ static bool gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
 
 static void gen_op_clear_ieee_excp_and_FTT(void)
 {
-    tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
+    tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                   offsetof(CPUSPARCState, fsr_cexc_ftt));
 }
 
 static void gen_op_fmovs(TCGv_i32 dst, TCGv_i32 src)
@@ -1400,10 +1401,15 @@ static void gen_op_fcmpeq(int fccno, TCGv_i128 r_rs1, TCGv_i128 r_rs2)
 }
 #endif
 
-static void gen_op_fpexception_im(DisasContext *dc, int fsr_flags)
+static void gen_op_fpexception_im(DisasContext *dc, int ftt)
 {
-    tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_NMASK);
-    tcg_gen_ori_tl(cpu_fsr, cpu_fsr, fsr_flags);
+    /*
+     * CEXC is only set when succesfully completing an FPop,
+     * or when raising FSR_FTT_IEEE_EXCP, i.e. check_ieee_exception.
+     * Thus we can simply store FTT into this field.
+     */
+    tcg_gen_st_i32(tcg_constant_i32(ftt), tcg_env,
+                   offsetof(CPUSPARCState, fsr_cexc_ftt));
     gen_exception(dc, TT_FP_EXCP);
 }
 
@@ -4395,19 +4401,22 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 static bool do_ldfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop,
                      target_ulong new_mask, target_ulong old_mask)
 {
-    TCGv tmp, addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    TCGv tnew, told;
+
     if (addr == NULL) {
         return false;
     }
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    tmp = tcg_temp_new();
-    tcg_gen_qemu_ld_tl(tmp, addr, dc->mem_idx, mop | MO_ALIGN);
-    tcg_gen_andi_tl(tmp, tmp, new_mask);
-    tcg_gen_andi_tl(cpu_fsr, cpu_fsr, old_mask);
-    tcg_gen_or_tl(cpu_fsr, cpu_fsr, tmp);
-    gen_helper_set_fsr(tcg_env, cpu_fsr);
+    tnew = tcg_temp_new();
+    told = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(tnew, addr, dc->mem_idx, mop | MO_ALIGN);
+    tcg_gen_andi_tl(tnew, tnew, new_mask);
+    tcg_gen_andi_tl(told, cpu_fsr, old_mask);
+    tcg_gen_or_tl(tnew, tnew, told);
+    gen_helper_set_fsr_noftt(tcg_env, tnew);
     return advance_pc(dc);
 }
 
-- 
2.34.1


