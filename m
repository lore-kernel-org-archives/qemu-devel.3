Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D155CD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZV-0008LM-S6; Wed, 20 May 2026 14:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZB-0007PQ-K4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:49 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ6-0000fH-Lc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:48 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36608b2f2dcso3219438a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301362; x=1779906162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LT7OexZ++nqH0+TQBAA8KZwuqR3fGnFfvg7Y1abp9k4=;
 b=njkW+hRgAV3gt6d6NSXumlUCC5vwjg5ACvn076vu5YMuTa+8vJPQ1W5XVDmSW5id+H
 8tbNJHr9YYbiW2DkpW4oVlINuuT/iqi7jfl8usixJcRndfUr0serhingTBCU/bU1d9dd
 Wno6/CDsjB72owXRqJJa/KKFIssup90AX9/DtGbmqVFFmmKP+9NElT7jdZslHbIzMTB7
 uQDpBK6l+TQrh7kXzLo3KcrQ7Jcnt71KDXhi19tXiVOSOt/6P41NVfB6qK5sd2yk0xuB
 +Gfw4chy84sKAGQ5EzbCuDkseYtfBp8FxVhl4XA/tS6DoECDW7RAFm5Q0mFSz/gKO4oy
 JtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301362; x=1779906162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LT7OexZ++nqH0+TQBAA8KZwuqR3fGnFfvg7Y1abp9k4=;
 b=C6J3p9Le1ZacjXiPTHL7fJ/niQV6+PG7a6t6QVsmlVnSkmjrLKz4uDmRI0LmAMzsXQ
 UQTtPTexIU53DHKFgrPNopa93hb+qoxlWLB9R4IZ1eQs9pjGLohADfDIx5bJLCk9tByI
 Xi3in6+gZD/DawhbI5XEuidJJK4FtQbE9us3Jdw1Y/c1oPuPAbvx/DYHJ+ZqFnVZsiYj
 gb/8EDZix3H2L4nUShScjlILZDDWwoc3SRpL7p1QjxGO2xeCP9eW09VV0kebtMC/KI/c
 kibwv4s4+CuGngh8ovHlEeEp+sNtqXVnyRmVTEfzF/mkhvOCWmxQNxRafW2EhmI4eels
 mQ6g==
X-Gm-Message-State: AOJu0Yxlx0qyzGUINVSPRKyv3OhHIWUoJkQLa/XOK1rTtKXUUinesjcZ
 CUousCCcaGc4jxJbNMwZc4sDKML5T754lcGIslTWU3zdaXnWk6WtUSH0dn6A0sHCCxP3Zzv3Cy3
 g0d6Yzwg=
X-Gm-Gg: Acq92OEU0dp8tDbhqzHOqy/xrRhjVcE7Jt9qjOZXsNEWpqIj7qogf/BXbcUqjaZP88V
 cmtO/YQQazKUfFeiNHvJRyMDLb/2pY3PuePXz9+ww9KHfza4bZY95/s3xncYQnlbB/bLiR3fvrl
 zmCJDohCUFr6cVhZ3qO9sSk7PIy5C709mCNPPDnB57zH8SswzMkaD/QEFpCQoelNcdR+IJZAQN2
 EwN+D2DtYJdxJW9/kNtQ7+z4CXKUKLerSO3Slzeldoa2rFRE5EF82kFQlN/f2x2G6NCXuoHOlYr
 CVLM8pp9RCiUsMIT3o7eu+5Zk/NCc6vdXIxUI/LqWaWEupdqtHIDYV9DAwEBUmlYp5VSx8RXer9
 IqPnkJWowfQWHX6oXW62XngurUV/d4BvQkGhap/536ccX1tIJUk1/vgMEmpeLo6Op4z6LDn/yRu
 vZw8Wo/dpoZGC/ymm9pyaLrPJlxtMOm3M7PdoqMeE=
X-Received: by 2002:a17:90b:90d:b0:369:7421:b36f with SMTP id
 98e67ed59e1d1-36974221037mr14013815a91.21.1779301361976; 
 Wed, 20 May 2026 11:22:41 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 39/64] target/arm: Implement LUTI2, LUTI4 for SVE
Date: Wed, 20 May 2026 11:21:48 -0700
Message-ID: <20260520182213.872945-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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


