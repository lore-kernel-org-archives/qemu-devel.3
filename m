Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B54CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPQD-0000cI-MT; Sat, 16 May 2026 20:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOy-0007J5-Rk
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:44 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOv-0005Dn-BP
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:40 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c7ffe8eeaf2so351706a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977836; x=1779582636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT7OexZ++nqH0+TQBAA8KZwuqR3fGnFfvg7Y1abp9k4=;
 b=jOB5MgzWvuV6uCl4j9RNacDRUVkI+drjFp2KJaYhORzsS3BMJz7cznxekmxC879GGa
 ylWskpZaNnU8DKzN/0hm3fL6ebq27zftHv5FdL8i+63a73kiTKY/VzNYybG6XAxVq1HQ
 BMeIqJ2TKgXMg8E4KFh8GG8XWaqzbUFbv9K9BJhkMYmamlxlH8dt/BsdczzHPDarOrvN
 Itju+hlUvcdxMNYphPFBF7QbUeW/FSNEyXZ0CHqfeORr8Z+/q53Y3VWKTmGe21cS7Gl3
 SJFV1O3gMKK6fEzf53ydJPE7dIdS0v/5NGU52XoyUJFBAc/HBHe6F4EG27u+igkagE3M
 T6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977836; x=1779582636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LT7OexZ++nqH0+TQBAA8KZwuqR3fGnFfvg7Y1abp9k4=;
 b=RiMZXiydSRxIuDCh4igKzPfbNEe1ypRJII+Cxyfb+7B3rXWWfXtjJMOJq7yi1LivGD
 FSalSMc7u3Etei5YfgX9umGlji2LyeJR9SmNHeKrHB4vLGYELn0kbRm4vWcmMOAdsmGD
 T4kvQyp7orIv1SkpzNsLH8VTu2lz3yrd1Gnud6lLtLSQvBUVue9B6rc9INhdFDcPWEhW
 i8NO2SC4RgiuusYSVkLiF8A6sydi/MbsxAwediGAFTV+Nm34xa8qiG5oJMLZsxNBR1Gl
 AgjNBWYKpWivOO1CrxFRLRAcKcB2DUzLEXXjjSGux73JaQT2FQmPlG3zAL+cg52ETvef
 Yt9A==
X-Gm-Message-State: AOJu0YwcElVnkXQcOMeTMTqmNLrkPWVMuckI2ZmW4Fc4A12z7HIgJBeL
 8XYc9qzUWrgNSlbGWWFePsVBBDcvgSWRlbUQzBZWOhVkkm96nx5Fm/1d1xTGkvVYRFEYghL5X8T
 SIpWx
X-Gm-Gg: Acq92OGcepgTk+l2WDW2j9FOqnEn5ndv3Jo5zkdBUNLoaXadhyAIVvKFw2lVKs9Ym22
 Zp8A94dWedVbQ486Otln52uPGkIQanpQe2LqcyADAzW30STrzbi7ephD0qm06pyQ5mdWd+Y+hLl
 AUQ3ZXdcxbaF6KUQ31Elra4+eL6kaa2xpgZx9LkRYK3KTlAgbYD9PgHB0/mES7SP4lXutrlssrW
 tzY7mHAJoUuqbit1is55ouiLtwcN/ssXWAFdFZacw7u/t/8BtCiAn6T2BPg5UkMOJFAezVCSGhU
 3/c13OehvSq7k2zf6P7+wYLAkMgQez5iE0kN+qO0LahEn1Zieenb0sspo6xgXW8BjIgn0TMAU9O
 DP4sNLr2hLpauHTNvjcltgS+BEnRYrTmD+GVUaTj6nDYlOfg5m/ZvMmGYduiYi8RADEp2mRYViO
 uirsbPw3ctDEIjHFaoROHxWpav+6jH
X-Received: by 2002:a05:6a00:909d:b0:837:6bb9:acd5 with SMTP id
 d2e1a72fcca58-83f3398a3c5mr9683858b3a.0.1778977835884; 
 Sat, 16 May 2026 17:30:35 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 38/63] target/arm: Implement LUTI2, LUTI4 for SVE
Date: Sat, 16 May 2026 17:29:37 -0700
Message-ID: <20260517003002.321430-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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
 target/arm/cpu-features.h      |  6 +++
 target/arm/tcg/translate.h     |  8 ++++
 target/arm/tcg/translate-a64.c |  1 +
 target/arm/tcg/translate-sve.c | 68 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      | 11 +++++-
 5 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index fd09bbc5cf..6d5994450f 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1649,6 +1649,12 @@ isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_f8cvt(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_lut(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_lut(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1648c2c96f..b703e75b70 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -90,6 +90,7 @@ typedef struct DisasContext {
     int vl;          /* current vector length in bytes */
     int svl;         /* current streaming vector length in bytes */
     int max_svl;     /* maximum implemented streaming vector length */
+    int max_any_vl;  /* maximum implemented vector length */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
     int vec_len;
     int vec_stride;
@@ -874,4 +875,11 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
         return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
     }
 
+#define TRANS_FEAT_SME1_NONSTREAMING(NAME, FEAT, FUNC, ...)       \
+    static bool trans_##NAME(DisasContext *s, arg_##NAME *a)      \
+    {                                                             \
+        s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);      \
+        return dc_isar_feature(FEAT, s) && FUNC(s, __VA_ARGS__);  \
+    }
+
 #endif /* TARGET_ARM_TRANSLATE_H */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 508d8e377b..ee71c63116 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10820,6 +10820,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->max_svl = arm_cpu->sme_max_vq * 16;
+    dc->max_any_vl = MAX(dc->max_svl, arm_cpu->sve_max_vq * 16);
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
     dc->bt = EX_TBFLAG_A64(tb_flags, BT);
     dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 13f7ab01af..ea0d66178e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8268,3 +8268,71 @@ TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
 TRANS_FEAT(LD1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, false, true)
 TRANS_FEAT(ST1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, true, true)
 TRANS_FEAT(ST1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, true, true)
+
+TRANS_FEAT_SME1_NONSTREAMING(LUTI2_1b, aa64_sme2_or_sve2_lut,
+                             gen_gvec_ool_zzz, gen_helper_gvec_luti2_b,
+                             a->rd, a->rn, a->rm, a->index)
+TRANS_FEAT_SME1_NONSTREAMING(LUTI2_1h, aa64_sme2_or_sve2_lut,
+                             gen_gvec_ool_zzz, gen_helper_gvec_luti2_h,
+                             a->rd, a->rn, a->rm, a->index)
+TRANS_FEAT_SME1_NONSTREAMING(LUTI4_1b, aa64_sme2_or_sve2_lut,
+                             gen_gvec_ool_zzz, gen_helper_gvec_luti4_b,
+                             a->rd, a->rn, a->rm, a->index)
+
+static bool trans_LUTI4_1h(DisasContext *s, arg_LUTI4_1h *a)
+{
+    if (!dc_isar_feature(aa64_sme2_or_sve2_lut, s)) {
+        return false;
+    }
+    s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);
+
+    /*
+     * The MaxImplementedAnyVL check happens in the decode pseudocode,
+     * before the Check*SVEEnabled check in the operation pseudocode.
+     */
+    if (s->max_any_vl < 32) {
+        unallocated_encoding(s);
+    } else if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+
+        /* Then there's a second check against CurrentVL. */
+        if (vsz < 32) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                               vec_full_reg_offset(s, a->rn),
+                               vec_full_reg_offset(s, a->rm),
+                               vsz, vsz, a->index,
+                               gen_helper_gvec_luti4_h);
+        }
+    }
+    return true;
+}
+
+static bool trans_LUTI4_2h(DisasContext *s, arg_LUTI4_2h *a)
+{
+    if (!dc_isar_feature(aa64_sme2_or_sve2_lut, s)) {
+        return false;
+    }
+    s->is_nonstreaming = !dc_isar_feature(aa64_sme2, s);
+
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        /*
+         * (Ab)use preg_tmp to merge two disjoint 128-bit quantities
+         * into a sequential 256-bit table.
+         */
+        QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, vfp.preg_tmp) < 32);
+        unsigned tmp_ofs = offsetof(CPUARMState, vfp.preg_tmp);
+        unsigned rn0_ofs = vec_full_reg_offset(s, a->rn);
+        unsigned rn1_ofs = vec_full_reg_offset(s, (a->rn + 1) % 32);
+
+        tcg_gen_gvec_mov(MO_64, tmp_ofs, rn0_ofs, 16, 16);
+        tcg_gen_gvec_mov(MO_64, tmp_ofs + 16, rn1_ofs, 16, 16);
+
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd), tmp_ofs,
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, a->index, gen_helper_gvec_luti4_h);
+    }
+    return true;
+}
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 72755b27af..e2106fc7f5 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -31,6 +31,7 @@
 %dtype_23_13    23:2 13:2
 %index3_22_19   22:1 19:2
 %index3_22_17   22:1 17:2
+%index3_22_12   22:2 12:1
 %index3_19_11   19:2 11:1
 %index2_20_11   20:1 11:1
 
@@ -1737,11 +1738,19 @@ RSUBHNT         01000101 .. 1 ..... 011 111 ..... .....  @rd_rn_rm
 MATCH           01000101 .. 1 ..... 100 ... ..... 0 .... @pd_pg_rn_rm
 NMATCH          01000101 .. 1 ..... 100 ... ..... 1 .... @pd_pg_rn_rm
 
-### SVE2 Histogram Computation
+### SVE2 Histogram Computation and Lookup Table
 
 HISTCNT         01000101 .. 1 ..... 110 ... ..... .....  @rd_pg_rn_rm
 HISTSEG         01000101 .. 1 ..... 101 000 ..... .....  @rd_rn_rm
 
+LUTI2_1b        01000101 index:2  1 rm:5 101100 rn:5 rd:5 &rrx_esz esz=0
+LUTI2_1h        01000101 ..       1 rm:5 101.10 rn:5 rd:5 \
+                &rrx_esz esz=1 index=%index3_22_12
+
+LUTI4_1b        01000101 index:1 11 rm:5 101001 rn:5 rd:5 &rrx_esz esz=0
+LUTI4_1h        01000101 index:2  1 rm:5 101111 rn:5 rd:5 &rrx_esz esz=1
+LUTI4_2h        01000101 index:2  1 rm:5 101101 rn:5 rd:5 &rrx_esz esz=1
+
 ## SVE2 floating-point pairwise operations
 
 FADDP           01100100 .. 010 00 0 100 ... ..... ..... @rdn_pg_rm
-- 
2.43.0


