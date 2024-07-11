Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA6CC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthM-00022d-0L; Thu, 11 Jul 2024 09:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRthB-0001Pw-Db
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:49 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00063J-CI
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:49 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2eeb1ba040aso10571781fa.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703908; x=1721308708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XfAVsgQDT/HbaBCdOwb0gSnwgvZsbdnywkY0i3JxQAE=;
 b=mQdhHu9Mxx/h86ZF0UUIW1OFvRGoggcPm36fzKdNFPki8Y2HG6zHKltZidB5dJPVLe
 0vlJdffrDay1U+0COmxctjNaMveTKtqaDhWIrhzKbfqK4QhG/Rv3eZTZenCjAKCUeraw
 m5CMtzkNlyK/AlASgyQzPfYOnYciD3Mg4vccbx/+a2fQplla6UUK6KqeujOg1DEhGGvI
 CO1XTHm/DdH7zNXmMtEmn5RYgtj4FX3LPhCYdWy8IqwXnPIEzPPx9jhaQMrvlmTheEI3
 Oj2M32qYbSs0CtKIN5jR4xrdTuWWT1tivx6Enn95dFhBhb3gvXKfbbZ+PVSvmY0anRU6
 fFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703908; x=1721308708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfAVsgQDT/HbaBCdOwb0gSnwgvZsbdnywkY0i3JxQAE=;
 b=NaB9C/UADUrpz0JkiISH1LtAIucENIPQqlST9QoIlcLtA8RK7JVdtEjeCWLmxKbRVR
 TKBwLn+VwIVtpJEDOC41E5XXE6d/50hxhEzSjQab39HoAyhdUzi2n0lB9wtCOI+W4orw
 j7oh6/WWl7ZbQIo9m0qwCL4JLWzVWd5irA7bIWj2SXtVrNq/WjBMlS0am4ei1Ni3IsIv
 w28uf3E80E34Tg3/jqWXZ+lLFlv3zRBHgPF4STizdpPwnDDYhmXVqPuVUWdO9AurYr0E
 FT6WAHtVoizWtL9cMfbkS2VYobgdSZJs1/NhGuryEd+6HWbAVK9z/3ZfYlZ20lKFvF1F
 tkXQ==
X-Gm-Message-State: AOJu0Yxln8MqnfBmahFwsUC6rkyt4evlr0k/nG++ZuJbDq15VX7RNmjX
 eBq6oFqw3KTdzDX7+k48xEkKTns9DquBPMy6ZiB+YrZOWB1vL7hS0rmAczZll/Npc3dC8KlbhL1
 WtCA=
X-Google-Smtp-Source: AGHT+IEbJ2hkLuvv2312Kv0rCCFPqBC6mhQ6ixu8ZHzDpv1lQigXaWVkUYIN290N5+VO1fYd8l2uJA==
X-Received: by 2002:ac2:47e4:0:b0:52c:a8c4:4d99 with SMTP id
 2adb3069b0e04-52eb99da430mr4255197e87.68.1720703908369; 
 Thu, 11 Jul 2024 06:18:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/24] target/arm: Rename FPCR_ QC, NZCV macros to FPSR_
Date: Thu, 11 Jul 2024 14:18:05 +0100
Message-Id: <20240711131822.3909903-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

The QC, N, Z, C, V bits live in the FPSR, not the FPCR. Rename the
macros that define these bits accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-8-peter.maydell@linaro.org
---
 target/arm/cpu.h                  | 17 ++++++++++-------
 target/arm/tcg/mve_helper.c       |  8 ++++----
 target/arm/tcg/translate-m-nocp.c | 16 ++++++++--------
 target/arm/tcg/translate-vfp.c    |  2 +-
 target/arm/vfp_helper.c           |  8 ++++----
 5 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 53232239197..c75b0a73aec 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1697,6 +1697,7 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPSR_MASK 0xf800009f
 #define FPCR_MASK 0x07ff9f00
 
+/* FPCR bits */
 #define FPCR_IOE    (1 << 8)    /* Invalid Operation exception trap enable */
 #define FPCR_DZE    (1 << 9)    /* Divide by Zero exception trap enable */
 #define FPCR_OFE    (1 << 10)   /* Overflow exception trap enable */
@@ -1708,18 +1709,20 @@ void vfp_set_fpscr(CPUARMState *env, uint32_t val);
 #define FPCR_FZ     (1 << 24)   /* Flush-to-zero enable bit */
 #define FPCR_DN     (1 << 25)   /* Default NaN enable bit */
 #define FPCR_AHP    (1 << 26)   /* Alternative half-precision */
-#define FPCR_QC     (1 << 27)   /* Cumulative saturation bit */
-#define FPCR_V      (1 << 28)   /* FP overflow flag */
-#define FPCR_C      (1 << 29)   /* FP carry flag */
-#define FPCR_Z      (1 << 30)   /* FP zero flag */
-#define FPCR_N      (1 << 31)   /* FP negative flag */
 
 #define FPCR_LTPSIZE_SHIFT 16   /* LTPSIZE, M-profile only */
 #define FPCR_LTPSIZE_MASK (7 << FPCR_LTPSIZE_SHIFT)
 #define FPCR_LTPSIZE_LENGTH 3
 
-#define FPCR_NZCV_MASK (FPCR_N | FPCR_Z | FPCR_C | FPCR_V)
-#define FPCR_NZCVQC_MASK (FPCR_NZCV_MASK | FPCR_QC)
+/* FPSR bits */
+#define FPSR_QC     (1 << 27)   /* Cumulative saturation bit */
+#define FPSR_V      (1 << 28)   /* FP overflow flag */
+#define FPSR_C      (1 << 29)   /* FP carry flag */
+#define FPSR_Z      (1 << 30)   /* FP zero flag */
+#define FPSR_N      (1 << 31)   /* FP negative flag */
+
+#define FPSR_NZCV_MASK (FPSR_N | FPSR_Z | FPSR_C | FPSR_V)
+#define FPSR_NZCVQC_MASK (FPSR_NZCV_MASK | FPSR_QC)
 
 /**
  * vfp_get_fpsr: read the AArch64 FPSR
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 234f395b093..03ebef5ef21 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -1115,21 +1115,21 @@ static void do_vadc(CPUARMState *env, uint32_t *d, uint32_t *n, uint32_t *m,
 
     if (update_flags) {
         /* Store C, clear NZV. */
-        env->vfp.fpsr &= ~FPCR_NZCV_MASK;
-        env->vfp.fpsr |= carry_in * FPCR_C;
+        env->vfp.fpsr &= ~FPSR_NZCV_MASK;
+        env->vfp.fpsr |= carry_in * FPSR_C;
     }
     mve_advance_vpt(env);
 }
 
 void HELPER(mve_vadc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.fpsr & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPSR_C;
     do_vadc(env, vd, vn, vm, 0, carry_in, false);
 }
 
 void HELPER(mve_vsbc)(CPUARMState *env, void *vd, void *vn, void *vm)
 {
-    bool carry_in = env->vfp.fpsr & FPCR_C;
+    bool carry_in = env->vfp.fpsr & FPSR_C;
     do_vadc(env, vd, vn, vm, -1, carry_in, false);
 }
 
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 875f6a8725d..b92773b4af5 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -332,7 +332,7 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
         if (dc_isar_feature(aa32_mve, s)) {
             /* QC is only present for MVE; otherwise RES0 */
             TCGv_i32 qc = tcg_temp_new_i32();
-            tcg_gen_andi_i32(qc, tmp, FPCR_QC);
+            tcg_gen_andi_i32(qc, tmp, FPSR_QC);
             /*
              * The 4 vfp.qc[] fields need only be "zero" vs "non-zero";
              * here writing the same value into all elements is simplest.
@@ -340,9 +340,9 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
             tcg_gen_gvec_dup_i32(MO_32, offsetof(CPUARMState, vfp.qc),
                                  16, 16, qc);
         }
-        tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_NZCV_MASK);
         fpscr = load_cpu_field_low32(vfp.fpsr);
-        tcg_gen_andi_i32(fpscr, fpscr, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(fpscr, fpscr, ~FPSR_NZCV_MASK);
         tcg_gen_or_i32(fpscr, fpscr, tmp);
         store_cpu_field_low32(fpscr, vfp.fpsr);
         break;
@@ -390,7 +390,7 @@ static bool gen_M_fp_sysreg_write(DisasContext *s, int regno,
         tcg_gen_deposit_i32(control, control, sfpa,
                             R_V7M_CONTROL_SFPA_SHIFT, 1);
         store_cpu_field(control, v7m.control[M_REG_S]);
-        tcg_gen_andi_i32(tmp, tmp, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, ~FPSR_NZCV_MASK);
         gen_helper_vfp_set_fpscr(tcg_env, tmp);
         s->base.is_jmp = DISAS_UPDATE_NOCHAIN;
         break;
@@ -457,7 +457,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
     case ARM_VFP_FPSCR_NZCVQC:
         tmp = tcg_temp_new_i32();
         gen_helper_vfp_get_fpscr(tmp, tcg_env);
-        tcg_gen_andi_i32(tmp, tmp, FPCR_NZCVQC_MASK);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_NZCVQC_MASK);
         storefn(s, opaque, tmp, true);
         break;
     case QEMU_VFP_FPSCR_NZCV:
@@ -466,7 +466,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
          * helper call for the "VMRS to CPSR.NZCV" insn.
          */
         tmp = load_cpu_field_low32(vfp.fpsr);
-        tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, FPSR_NZCV_MASK);
         storefn(s, opaque, tmp, true);
         break;
     case ARM_VFP_FPCXT_S:
@@ -476,7 +476,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
         tmp = tcg_temp_new_i32();
         sfpa = tcg_temp_new_i32();
         gen_helper_vfp_get_fpscr(tmp, tcg_env);
-        tcg_gen_andi_i32(tmp, tmp, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, tmp, ~FPSR_NZCV_MASK);
         control = load_cpu_field(v7m.control[M_REG_S]);
         tcg_gen_andi_i32(sfpa, control, R_V7M_CONTROL_SFPA_MASK);
         tcg_gen_shli_i32(sfpa, sfpa, 31 - R_V7M_CONTROL_SFPA_SHIFT);
@@ -529,7 +529,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
         sfpa = tcg_temp_new_i32();
         fpscr = tcg_temp_new_i32();
         gen_helper_vfp_get_fpscr(fpscr, tcg_env);
-        tcg_gen_andi_i32(tmp, fpscr, ~FPCR_NZCV_MASK);
+        tcg_gen_andi_i32(tmp, fpscr, ~FPSR_NZCV_MASK);
         control = load_cpu_field(v7m.control[M_REG_S]);
         tcg_gen_andi_i32(sfpa, control, R_V7M_CONTROL_SFPA_MASK);
         tcg_gen_shli_i32(sfpa, sfpa, 31 - R_V7M_CONTROL_SFPA_SHIFT);
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 0d9788e8103..cd5b8483576 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -834,7 +834,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
         case ARM_VFP_FPSCR:
             if (a->rt == 15) {
                 tmp = load_cpu_field_low32(vfp.fpsr);
-                tcg_gen_andi_i32(tmp, tmp, FPCR_NZCV_MASK);
+                tcg_gen_andi_i32(tmp, tmp, FPSR_NZCV_MASK);
             } else {
                 tmp = tcg_temp_new_i32();
                 gen_helper_vfp_get_fpscr(tmp, tcg_env);
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index a8c89a910f6..85e50ede373 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -196,7 +196,7 @@ uint32_t vfp_get_fpsr(CPUARMState *env)
     fpsr |= vfp_get_fpsr_from_host(env);
 
     i = env->vfp.qc[0] | env->vfp.qc[1] | env->vfp.qc[2] | env->vfp.qc[3];
-    fpsr |= i ? FPCR_QC : 0;
+    fpsr |= i ? FPSR_QC : 0;
     return fpsr;
 }
 
@@ -222,7 +222,7 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
          * The bit we set within vfp.qc[] is arbitrary; the array as a
          * whole being zero/non-zero is what counts.
          */
-        env->vfp.qc[0] = val & FPCR_QC;
+        env->vfp.qc[0] = val & FPSR_QC;
         env->vfp.qc[1] = 0;
         env->vfp.qc[2] = 0;
         env->vfp.qc[3] = 0;
@@ -234,7 +234,7 @@ void vfp_set_fpsr(CPUARMState *env, uint32_t val)
      * fp_status, and QC is in vfp.qc[]. Store the NZCV bits there,
      * and zero any of the other FPSR bits.
      */
-    val &= FPCR_NZCV_MASK;
+    val &= FPSR_NZCV_MASK;
     env->vfp.fpsr = val;
 }
 
@@ -1156,7 +1156,7 @@ uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
     uint32_t z = (pair >> 32) == 0;
 
     /* Store Z, clear NCV, in FPSCR.NZCV.  */
-    env->vfp.fpsr = (env->vfp.fpsr & ~FPCR_NZCV_MASK) | (z * FPCR_Z);
+    env->vfp.fpsr = (env->vfp.fpsr & ~FPSR_NZCV_MASK) | (z * FPSR_Z);
 
     return result;
 }
-- 
2.34.1


