Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A242FD49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlX2-0001WS-VO; Sun, 01 Dec 2024 10:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWx-0001RQ-Sc
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:39 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWw-0004HO-2u
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:39 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5f1dbf0d060so1349543eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065597; x=1733670397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbSOuaVS3UhdNndDA52zyxjvqy1cGPMdHxDKwf2zdCU=;
 b=I0WejCgPE/tqbfV+TlEo3kzXGDw++tdXxGiW66lc6vP9NMFZF4x7RIFQ/IBea1G+2v
 i6nG+Ltcc3fWy65pvnMAfmqmCZI6geeuIj8+4zokgszQXkWa74JH+Qxzvnakw36QAqeE
 pQzRWaoYvEH0xca9UPS0hcKn98yUXPRLfJARr3h5KQapfNztUVC69zvAP1iHQUniwQIr
 W0jQ35YaHiQPObH9F592rLHqyLpA/XRrgIx5RxkW4AvCX+XPeZEMd7CPtIw6IWbKS9PZ
 bQUnbGJjzbVRQevh8sZrW+Y3YEw+OTy29bbmVe/QU1GPAUZyFjJVCZ+XwtA7C1t6+EGg
 dggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065597; x=1733670397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbSOuaVS3UhdNndDA52zyxjvqy1cGPMdHxDKwf2zdCU=;
 b=xJSahRSyV1hXNy9tjL5sHup4PyivdoL1owUOUohqVtMcQ/V+XZBMVB33kErOuVeak3
 o/igfnNgNMH2uqJhx5gtKDXLPrawloXeHd/u7eHOtIvUuUD7l+Aeugunc2t9LKDSobRh
 NJAzm8gOREQlJTg/flrwiwsXKE7a7YmrCHBRj4Zmfq92+iToapKlIfra881B95qNlCtq
 hEEzuno5I9lnjKry7pfZDy9FHvZuZ63FbBPKO9MtJE7NbBxRb3bxf51/UpS9aInGKcNE
 jQ92Mf3VfYT+zfoOL6PRQ4to0c0lmkxgVuQIORhmTyJtwpBzAhtcGwXa/S42QckjXJPZ
 EBJQ==
X-Gm-Message-State: AOJu0YzozEHMRtdQOEfxzW4UVvBocjVHo5Ugx3bbO2T/r6MMZooBNpUc
 1eSH2YPiyiNRBbZglPnA9e1L8j+YFJFWkefg2NR4f+CZ7g5edyPtq7jLJJYXVFD6LinOurX7RSr
 WGAw=
X-Gm-Gg: ASbGncu+Rrtpa2qNRsWjRBONU5deHAric6abMXRGouGUa37GIxQpAZqpMMPuuVNWvJr
 tBtvUSxCUeQSGH1vOToFkkW8EpUWBRNdYUlxX4m72/U73MMwmbJUSR4EJU00ibBgdiGx4U3o+kk
 4jjzMxibCSC5qnRqyopgqfa1bfwp3jp3MgRZLTTAV+YeWaHDpnNwr0nxAs1GeBgcQZh5hjLWmgD
 7VFdjUbBRxWwwkjHHYl2TbRwxf8+8H6j+EHzBKRWDzg0wCIquJZxdcsQYForZO9VZq7b+Brq5Os
 v3vDNSXsLOzBfIXhmTF2gqBmDZmFfZYVscbk
X-Google-Smtp-Source: AGHT+IFdd9V1EBSHMybYaP36KjC1I0aLCnh0c2jfMYjBPIyCdjGLeIeKljPb9SwKCYwFolVt4Y554w==
X-Received: by 2002:a05:6830:f94:b0:71d:5f65:ce48 with SMTP id
 46e09a7af769-71d65d2809cmr16484201a34.28.1733065596713; 
 Sun, 01 Dec 2024 07:06:36 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 24/67] target/arm: Pass fpstatus to vfp_sqrt*
Date: Sun,  1 Dec 2024 09:05:23 -0600
Message-ID: <20241201150607.12812-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 87731e0be4..c976c15b08 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8405,8 +8405,8 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrts;
+        break;
     case 0x6: /* BFCVT */
         gen_fpst = gen_helper_bfcvt;
         break;
@@ -8454,7 +8454,6 @@ static void handle_fp_1src_single(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_sreg(s, rd, tcg_res);
 }
 
@@ -8471,8 +8470,8 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
 
     switch (opcode) {
     case 0x3: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_res, tcg_op, tcg_env);
-        goto done;
+        gen_fpst = gen_helper_vfp_sqrtd;
+        break;
     case 0x8: /* FRINTN */
     case 0x9: /* FRINTP */
     case 0xa: /* FRINTM */
@@ -8517,7 +8516,6 @@ static void handle_fp_1src_double(DisasContext *s, int opcode, int rd, int rn)
         gen_fpst(tcg_res, tcg_op, fpst);
     }
 
- done:
     write_fp_dreg(s, rd, tcg_res);
 }
 
@@ -9460,7 +9458,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_vfp_negd(tcg_rd, tcg_rn);
         break;
     case 0x7f: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_env);
+        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     case 0x1a: /* FCVTNS */
     case 0x1b: /* FCVTMS */
@@ -10403,6 +10401,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
         case 0x7f: /* FSQRT */
+            need_fpstatus = true;
             if (size == 3 && !is_q) {
                 unallocated_encoding(s);
                 return;
@@ -10632,7 +10631,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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


