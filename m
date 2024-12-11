Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B14E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdm-0007Ny-1t; Wed, 11 Dec 2024 11:32:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdE-0005FM-5B
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:15 -0500
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPdC-0001Nx-Dq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:32:11 -0500
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4678664e22fso13283691cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934729; x=1734539529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5VrSZsZ86taNiV6RjVqL+y8dhQuQVzVoICeQS9NllM=;
 b=FWZjMWG5sqz7hEHwvYxaBy8odmvFpt0ThFyZWoy0/jG3g3jyrV8pCsrSqW6Kt7v5ZZ
 YL2oP7X38wk3kRAgk6g7Gvm58nMYPeoInwhHfzWwImP2RciW4VrQBq7qKT0nFerHB8WG
 msrWPdZtKsI2jIYl1vTx7HMyvGJJmM/X+smPcewJnE7Qqcx1M9w2GoDXZOlTjEP8MqJn
 akZHjuTw+BExFq656zXVyajEd/kU7zGR+oWSENoYyq6Ibwzivph1n7sufWYNIdMZ/3hk
 B+QKH0kjDQh3D4T1+obqJvPYPBfk66G7hAJk9K1nvKnwIL3JoEeU349CAdeTjX5IpQoI
 4F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934729; x=1734539529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r5VrSZsZ86taNiV6RjVqL+y8dhQuQVzVoICeQS9NllM=;
 b=fxEz361u5uFWc+zOvf4sDlEK/wEWFOz2O68F2R2eouwpeKt3hNgC8iU1khi/do5Uw0
 SUTS/KjUoW1+qRhOpcD8VWzH/ABaPRf1UCJPaFMGcDWKaEibSefIs2gmgwfPNCIhf756
 81TLdtsasWIchqZIIcG9eMCJ4oaOyafvFUHcNNZ0rh4d0tjHLYczDCOghNORIWDvNOev
 /m+xRrpeYcnU+l+sC4bgAx51lmEdLejuShFV2pNGmdxGONX0NFUOSewrfFVqusglyC0F
 HrP3eyjXV81mItJibjm/XmTJAOwDnZMbzeVbQ+mzOdwDESdIpnRXB/FmMd4aku5mMWyW
 iakg==
X-Gm-Message-State: AOJu0YzyTbjDCNlrkZ8Fsc2/sSWYomTOICwuSJWjeEMRn3S2cLDO4JGR
 khq2DHNJNTzw49+kBT3PYfSMiOhwTcrvCnL69EU98PsjlWNdYAKQ4yUZJ9wlyPCJjfiLJNLD0Zz
 GjMdc49AL
X-Gm-Gg: ASbGncvbhIG/KOSUHi9OzPWms4xuvNZUjkcpxaCWE7TggsNFL7qzxeNbotDywESqC0X
 5YW7CkPrpLmWkmLu8c3iBrFexmyJhkpkkXM/ECiV+lzXDq830Zq6ECRBEenTy//DCwehGk+Tkt9
 9pUf3gNF7EvfmnqlpPQcQNXNhy/ti0E8GKpUE3iTD6lNkIyAGCR19W8hsgzdIDK261Ic6IJ8lpu
 BOroL6uVi25s/fAMnqJURZRp6D9/ZaAZ4Q4XBuhaLR66q6Cc27M3IH2csdjXg==
X-Google-Smtp-Source: AGHT+IGiJ5VZ2DjFKJKYAO14xgUbl/mH4LULrCUqana3GExxkGWq/ZmgAgk9ZWT/CenMJMNBKs/ChA==
X-Received: by 2002:ac8:5a03:0:b0:467:6941:4ecc with SMTP id
 d75a77b69052e-4678935ec1dmr78844511cf.39.1733934729430; 
 Wed, 11 Dec 2024 08:32:09 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:32:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 25/69] target/arm: Pass fpstatus to vfp_sqrt*
Date: Wed, 11 Dec 2024 10:29:52 -0600
Message-ID: <20241211163036.2297116-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82c.google.com
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

Pass fpstatus not env, like most other fp helpers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  6 +++---
 target/arm/tcg/translate-a64.c | 15 +++++++--------
 target/arm/tcg/translate-vfp.c |  6 +++---
 target/arm/vfp_helper.c        | 12 ++++++------
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 58919b670e..0a697e752b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -133,9 +133,9 @@ DEF_HELPER_3(vfp_maxnumd, f64, f64, f64, ptr)
 DEF_HELPER_3(vfp_minnumh, f16, f16, f16, ptr)
 DEF_HELPER_3(vfp_minnums, f32, f32, f32, ptr)
 DEF_HELPER_3(vfp_minnumd, f64, f64, f64, ptr)
-DEF_HELPER_2(vfp_sqrth, f16, f16, env)
-DEF_HELPER_2(vfp_sqrts, f32, f32, env)
-DEF_HELPER_2(vfp_sqrtd, f64, f64, env)
+DEF_HELPER_2(vfp_sqrth, f16, f16, ptr)
+DEF_HELPER_2(vfp_sqrts, f32, f32, ptr)
+DEF_HELPER_2(vfp_sqrtd, f64, f64, ptr)
 DEF_HELPER_3(vfp_cmph, void, f16, f16, env)
 DEF_HELPER_3(vfp_cmps, void, f32, f32, env)
 DEF_HELPER_3(vfp_cmpd, void, f64, f64, env)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ca2b95510e..cfc73b8506 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8401,8 +8401,8 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrts;
+        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8450,7 +8450,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_sreg(s, rd, tcg_res);
 }
 
@@ -8467,8 +8466,8 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrtd;
+        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8513,7 +8512,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_dreg(s, rd, tcg_res);
 }
 
@@ -9459,7 +9457,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_vfp_negd(tcg_rd, tcg_rn);
         break;
     case 0x7f: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_env);
+        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     case 0x1a: /* FCVTNS */
     case 0x1b: /* FCVTMS */
@@ -10402,6 +10400,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
         case 0x7f: /* FSQRT */
+            need_fpstatus = true;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
@@ -10631,7 +10630,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_vfp_negs(tcg_res, tcg_op);
                     break;
                 case 0x7f: /* FSQRT */
-                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
+                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 case 0x1a: /* FCVTNS */
                 case 0x1b: /* FCVTMS */
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index b6fa28a7bf..c160a86e70 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -2424,17 +2424,17 @@ DO_VFP_2OP(VNEG, dp, gen_vfp_negd, aa32_fpdp_v2)
 
 static void gen_VSQRT_hp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrth(vd, vm, tcg_env);
+    gen_helper_vfp_sqrth(vd, vm, fpstatus_ptr(FPST_FPCR_F16));
 }
 
 static void gen_VSQRT_sp(TCGv_i32 vd, TCGv_i32 vm)
 {
-    gen_helper_vfp_sqrts(vd, vm, tcg_env);
+    gen_helper_vfp_sqrts(vd, vm, fpstatus_ptr(FPST_FPCR));
 }
 
 static void gen_VSQRT_dp(TCGv_i64 vd, TCGv_i64 vm)
 {
-    gen_helper_vfp_sqrtd(vd, vm, tcg_env);
+    gen_helper_vfp_sqrtd(vd, vm, fpstatus_ptr(FPST_FPCR));
 }
 
 DO_VFP_2OP(VSQRT, hp, gen_VSQRT_hp, aa32_fp16_arith)
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 62638d2b1f..f24992c798 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -314,19 +314,19 @@ VFP_BINOP(minnum)
 VFP_BINOP(maxnum)
 #undef VFP_BINOP
 
-dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, CPUARMState *env)
+dh_ctype_f16 VFP_HELPER(sqrt, h)(dh_ctype_f16 a, void *fpstp)
 {
-    return float16_sqrt(a, &env->vfp.fp_status_f16);
+    return float16_sqrt(a, fpstp);
 }
 
-float32 VFP_HELPER(sqrt, s)(float32 a, CPUARMState *env)
+float32 VFP_HELPER(sqrt, s)(float32 a, void *fpstp)
 {
-    return float32_sqrt(a, &env->vfp.fp_status);
+    return float32_sqrt(a, fpstp);
 }
 
-float64 VFP_HELPER(sqrt, d)(float64 a, CPUARMState *env)
+float64 VFP_HELPER(sqrt, d)(float64 a, void *fpstp)
 {
-    return float64_sqrt(a, &env->vfp.fp_status);
+    return float64_sqrt(a, fpstp);
 }
 
 static void softfloat_to_vfp_compare(CPUARMState *env, FloatRelation cmp)
-- 
2.43.0


