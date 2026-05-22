Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60219CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY1A-0006Tg-Lk; Fri, 22 May 2026 18:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY17-0006CY-6C
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY13-0002Un-Rm
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:06:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso54711255ad.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487608; x=1780092408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GEEKHq7P6kbtKoG9mpoolbgBO3rzFQo954EjHh4Tb8=;
 b=wkh/LRnQpMBxCly/Q6hF3azgxMnr7KCWfqKV4rgEeCMFC6HaBP1LnjDDrPCJQNdEQ0
 fdmVRd8B9bHPDhQIg/vvsS45pzSh33rIu9Auznta+kT/hTt4btdNLUyI0hNz1vKMBMfY
 5XgkUNadArb1S6RypVj3Mj3iqXC56A61AExZWv34YU06/IL30ZuXoSTXRHsL6dYgPHn0
 GmuLD1TdU5XBIdJEFCPi+HkuwT5EoowzJ2/pk/39zeMEGRogQtsrzVX4+uwj647Lh8C9
 YHGcDjEBBrixNroBNI/msh/JwfiX4DxtK+goqMPO4vPKU3htCWcE/qYc8CDBN1w4Vxym
 YLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487608; x=1780092408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8GEEKHq7P6kbtKoG9mpoolbgBO3rzFQo954EjHh4Tb8=;
 b=WiEi2DcOLqgWfiPMGoliHTMuGPwSxea1OSk9/vaXBiKxApitNPvXgWY1SAJRHbPEkD
 mA/uEkb7DH6N/GsAqnApMsTiJWNkmcyjZt8fDFjIOfSU8OyPAWy5ZA1RRjFY+G8QT0wQ
 BpBNTGujD3xOpKSKN8qXh74vyWZbrqWFhhGjpnKqjjmJc0zgr39iFiLZyK5fNjNd5UB9
 6MAOdVkGHjXQY1nfLzRIrmGQ75Gzv57zp+MIR6WETNX6MMtoyfNzgd0Qz8JCJALQJ+4C
 eL9q2YOJVu9VmmVrF5avavnsTQIev0vzopNQgnRipqUY2N9XlUo0tK4Q1gjOxmGBvZgk
 oeiA==
X-Gm-Message-State: AOJu0YxX92DZix7yC0ctfSmoQNehbkpuvFgycZ7cX2SPYIxCnw96YRwZ
 VsPHfZ1wGCWM2e46betp1ZD/KTwbv3p8Moonpt3DFZGpchcL9fT0LxJcdXyGlGbmwClbP/6ZhXe
 swES0
X-Gm-Gg: Acq92OH36ZpLzcnkMOUQtyzL5bm9eicit6OZruuZAGoJKL26xjWUzRCD5OQmjUNYcZy
 7BJQXV2pYJTa62iPb2uQ15lWJvW64t3+CiBbrEn/AezRW8aR5vd3OCAnRenpn5BKurrc/bQmZtw
 QU+GaGF70MZPeeFlSJjpBT2aE22GsG9dwu0r2Z4nvlC73+inpH6S2HZg04y9YQz6LOan68Jra3E
 8FMSvaVFwGYUeH+cSqXpo5lP4Qan200DVp1NfLMgIg1RfG8qzUa+thIArTK3rtJiknIojXowuTL
 /4dVVXB97w1ute5x3lgWL+ORRk7eRGur0BKHf7R5kBbGqBwWnbw+2Nvbg1quLJZXoUMXp7lhMw+
 xfEFevsgwy4wlPBFe9KI2O12m+Y9swrG9jUl11SsUs4n49H8ekYI5LL0VriXhx8VtvR5ZXMbZgr
 LhQd+KGR9t5F/kh87ztURNV8sVa99+MEJV92YJ5j8=
X-Received: by 2002:a17:903:1a08:b0:2bc:67cc:d1eb with SMTP id
 d9443c01a7336-2beb07261f3mr58898085ad.28.1779487608125; 
 Fri, 22 May 2026 15:06:48 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 41/64] target/arm: Implement LUTI2, LUTI4 for SVE
Date: Fri, 22 May 2026 15:02:43 -0700
Message-ID: <20260522220306.235200-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 target/arm/tcg/translate.h     |  1 +
 target/arm/tcg/translate-a64.c |  1 +
 target/arm/tcg/translate-sve.c | 68 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      | 11 +++++-
 5 files changed, 86 insertions(+), 1 deletion(-)

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
index 9dc0eed630..de6c5e4d2a 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e6d405ea69..14597e4d7f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10817,6 +10817,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->max_svl = arm_cpu->sme_max_vq * 16;
+    dc->max_any_vl = MAX(dc->max_svl, arm_cpu->sve_max_vq * 16);
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
     dc->bt = EX_TBFLAG_A64(tb_flags, BT);
     dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a339ffe454..2ee5a36c5a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8286,3 +8286,71 @@ TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
 TRANS_FEAT(LD1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, false, true)
 TRANS_FEAT(ST1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, true, true)
 TRANS_FEAT(ST1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, true, true)
+
+TRANS_FEAT_STREAMING_SME2(LUTI2_1b, aa64_sme2_or_sve2_lut,
+                          gen_gvec_ool_zzz, gen_helper_gvec_luti2_b,
+                          a->rd, a->rn, a->rm, a->index)
+TRANS_FEAT_STREAMING_SME2(LUTI2_1h, aa64_sme2_or_sve2_lut,
+                          gen_gvec_ool_zzz, gen_helper_gvec_luti2_h,
+                          a->rd, a->rn, a->rm, a->index)
+TRANS_FEAT_STREAMING_SME2(LUTI4_1b, aa64_sme2_or_sve2_lut,
+                          gen_gvec_ool_zzz, gen_helper_gvec_luti4_b,
+                          a->rd, a->rn, a->rm, a->index)
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


