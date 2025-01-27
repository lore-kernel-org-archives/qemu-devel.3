Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6069BC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 23:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcYUt-0006Sc-9z; Mon, 27 Jan 2025 18:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUh-0006LU-3d
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:15 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcYUd-0005XE-7G
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 18:26:14 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so6622017a91.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 15:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738020370; x=1738625170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnjx8Waa96G3DLJHBV92lDnt+x0jZGLfU8ED3iHDbpE=;
 b=nTS8vb05LdYEEDfJ7gtcFi2h37MHPZs6OS/XDBi6qUPgJJmhvtveaV3KQtrzdjLvcj
 n9uuZg3QJcHxdx0KByCpN+KlIggVVculUOksnrmMQxOtVsS6D9G+S0idV/zJ5DzPFqMh
 1CVxN3zNWeoWBPx3ykg5zw40Es8tM9YKCdLm3xrJMnZ7Kks5WR8xNWiGU+iKlUFpLHaR
 3w/V0BtQzXPAZdH/V3KfKGR/E3TbY2kc/t+bwciwM6Ry2YK1Btxa3M3lmrxHQEjxtPZC
 27u4833fBbn6IP+mLGcOUpNv69s1PTB3j76I3glPyZdWNnlLJKDt/l1RfvAIXNUKB5Zl
 hRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738020370; x=1738625170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnjx8Waa96G3DLJHBV92lDnt+x0jZGLfU8ED3iHDbpE=;
 b=B/tERWCdCmaF/C55gPh8AhmgjpXFi07J+xv1mOf/zUaiM9N1KoCoYdG5qieggocTh6
 f/ZkMwMO0YsCNwaH0UnuMNyKcjQwPi6vBv7bNBMwkbVozjaC9rul36z+l+7mXMpEmiHB
 kxu7QgBLWvE8stNdRFcIUntIjnl1zEBcQK775578YuW8v6Hdj80CboJ7NsaoC1j5pPIN
 K2QbytTgm+PzVWMAzL3Xmz2Dp9firMCC1DvjoL1R9gzpxf4n++GYSg5062dg3FjF1VL9
 yvO+gVUMs+4jBKUWNr3v2OCGx4gW5XCyjnTCfxiCeJ4dnvWC+ad+yKZcVrffIUiWSo4X
 HHwg==
X-Gm-Message-State: AOJu0YyvhhDPAXqWkGsUOhfA9aG9if02jOhvGPqp+4xJN+BsLUxbQaeX
 Ll8rEGa6YPplc/tAuoU/YaWmgozj5hGsJQLBaNxuHYjq1rRZCkWA/irKG4K+buofdC6+qgm+WSk
 8
X-Gm-Gg: ASbGncup/aCLFPH38Ilhtu+pcfqTi5/Pad1zVZPkrCGEPKXWj35A8jXDROfE13ZUddl
 zd0gduVJfPDnB/rppmb5aGIdBkAvsMQBJXbs0SYpuZu8iQvOx+QzX0yDJSatA7AyCABfvprUx7/
 cpAyA7zuQHPszP5utBsE1rA1AZLREEP853ks/jNJrxBBS6Tv84kMHnHauZXvu23SiefsOFVHm5O
 naRvVoDNF54oI89OKwMZ4ySp1G4YZviCYfAnQx24bQozasuPmGDOx7ssg7t08Wicv48+kn0z4LB
 rVPrCLihDJP21Ek6pWt+Zqr7NqmwFzI165HYc1CY9EGo5t9lgA==
X-Google-Smtp-Source: AGHT+IHkilFV59dT5kQ79bCcS9qzeo756x0ErVdKJ06Fi4IKVCh6Yc0a3dSoPcXClJ7JGhBPhzIFhw==
X-Received: by 2002:a17:90b:3a0e:b0:2ee:b4bf:2d06 with SMTP id
 98e67ed59e1d1-2f782cb9fe6mr57602224a91.19.1738020369660; 
 Mon, 27 Jan 2025 15:26:09 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffb1b31esm7833000a91.47.2025.01.27.15.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 15:26:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Subject: [PATCH 05/22] target/arm: Rename FPST_FPCR_AH* to FPST_AH*
Date: Mon, 27 Jan 2025 15:25:47 -0800
Message-ID: <20250127232604.20386-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127232604.20386-1-richard.henderson@linaro.org>
References: <20250127232604.20386-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 14 +++++++-------
 target/arm/tcg/translate-a64.c |  8 ++++----
 target/arm/tcg/translate-sve.c |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index cc753419ed..d4ae39c469 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -678,8 +678,8 @@ typedef enum ARMFPStatusFlavour {
     FPST_A64,
     FPST_A32_F16,
     FPST_A64_F16,
-    FPST_FPCR_AH,
-    FPST_FPCR_AH_F16,
+    FPST_AH,
+    FPST_AH_F16,
     FPST_STD,
     FPST_STD_F16,
 } ARMFPStatusFlavour;
@@ -700,11 +700,11 @@ typedef enum ARMFPStatusFlavour {
  *   for AArch32 operations controlled by the FPCR where FPCR.FZ16 is to be used
  * FPST_A64_F16
  *   for AArch64 operations controlled by the FPCR where FPCR.FZ16 is to be used
- * FPST_FPCR_AH:
+ * FPST_AH:
  *   for AArch64 operations which change behaviour when AH=1 (specifically,
  *   bfloat16 conversions and multiplies, and the reciprocal and square root
  *   estimate/step insns)
- * FPST_FPCR_AH_F16:
+ * FPST_AH_F16:
  *   ditto, but for half-precision operations
  * FPST_STD
  *   for A32/T32 Neon operations using the "standard FPSCR value"
@@ -729,10 +729,10 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
     case FPST_A64_F16:
         offset = offsetof(CPUARMState, vfp.fp_status_f16_a64);
         break;
-    case FPST_FPCR_AH:
+    case FPST_AH:
         offset = offsetof(CPUARMState, vfp.ah_fp_status);
         break;
-    case FPST_FPCR_AH_F16:
+    case FPST_AH_F16:
         offset = offsetof(CPUARMState, vfp.ah_fp_status_f16);
         break;
     case FPST_STD:
@@ -755,7 +755,7 @@ static inline TCGv_ptr fpstatus_ptr(ARMFPStatusFlavour flavour)
 static inline ARMFPStatusFlavour select_fpst(DisasContext *s, MemOp esz)
 {
     if (s->fpcr_ah) {
-        return esz == MO_16 ? FPST_FPCR_AH_F16 : FPST_FPCR_AH;
+        return esz == MO_16 ? FPST_AH_F16 : FPST_AH;
     } else {
         return esz == MO_16 ? FPST_A64_F16 : FPST_A64;
     }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 35d409685c..715760a17b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6135,7 +6135,7 @@ static bool trans_BFMLAL_v(DisasContext *s, arg_qrrr_e *a)
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
         gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
-                          s->fpcr_ah ? FPST_FPCR_AH : FPST_A64, a->q,
+                          s->fpcr_ah ? FPST_AH : FPST_A64, a->q,
                           gen_helper_gvec_bfmlal);
     }
     return true;
@@ -6892,7 +6892,7 @@ static bool trans_BFMLAL_vi(DisasContext *s, arg_qrrx_e *a)
     if (fp_access_check(s)) {
         /* Q bit selects BFMLALB vs BFMLALT. */
         gen_gvec_op4_fpst(s, true, a->rd, a->rn, a->rm, a->rd,
-                          s->fpcr_ah ? FPST_FPCR_AH : FPST_A64,
+                          s->fpcr_ah ? FPST_AH : FPST_A64,
                           (a->idx << 1) | a->q,
                           gen_helper_gvec_bfmlal_idx);
     }
@@ -8866,7 +8866,7 @@ TRANS(FRINTX_s, do_fp1_scalar, a, &f_scalar_frintx, -1)
 
 static bool trans_BFCVT_s(DisasContext *s, arg_rr_e *a)
 {
-    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_FPCR_AH : FPST_A64;
+    ARMFPStatusFlavour fpsttype = s->fpcr_ah ? FPST_AH : FPST_A64;
     TCGv_i32 t32;
     int check;
 
@@ -9691,7 +9691,7 @@ static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 
 static void gen_bfcvtn_ah_hs(TCGv_i64 d, TCGv_i64 n)
 {
-    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR_AH);
+    TCGv_ptr fpst = fpstatus_ptr(FPST_AH);
     TCGv_i32 tmp = tcg_temp_new_i32();
     gen_helper_bfcvt_pair(tmp, n, fpst);
     tcg_gen_extu_i32_i64(d, tmp);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 3811316a2d..cb6bb27622 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3985,7 +3985,7 @@ TRANS_FEAT(FCVT_hs, aa64_sve, gen_gvec_fpst_arg_zpz,
 
 TRANS_FEAT(BFCVT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvt, a, 0,
-           s->fpcr_ah ? FPST_FPCR_AH : FPST_A64)
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVT_dh, aa64_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvt_dh, a, 0, FPST_A64)
@@ -7136,7 +7136,7 @@ TRANS_FEAT(FCVTNT_ds, aa64_sve2, gen_gvec_fpst_arg_zpz,
 
 TRANS_FEAT(BFCVTNT, aa64_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
-           s->fpcr_ah ? FPST_FPCR_AH : FPST_A64)
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
@@ -7198,7 +7198,7 @@ static bool do_BFMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
 {
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal,
                               a->rd, a->rn, a->rm, a->ra, sel,
-                              s->fpcr_ah ? FPST_FPCR_AH : FPST_A64);
+                              s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzzw, aa64_sve_bf16, do_BFMLAL_zzzw, a, false)
@@ -7209,7 +7209,7 @@ static bool do_BFMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sel)
     return gen_gvec_fpst_zzzz(s, gen_helper_gvec_bfmlal_idx,
                               a->rd, a->rn, a->rm, a->ra,
                               (a->index << 1) | sel,
-                              s->fpcr_ah ? FPST_FPCR_AH : FPST_A64);
+                              s->fpcr_ah ? FPST_AH : FPST_A64);
 }
 
 TRANS_FEAT(BFMLALB_zzxw, aa64_sve_bf16, do_BFMLAL_zzxw, a, false)
-- 
2.43.0


