Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F72FB44A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Dq-0003m5-UZ; Fri, 24 Apr 2026 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Dm-0003XN-1a
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:55 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Dj-0003qq-TC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:53 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d37e7d7fso1765202b6e.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005170; x=1777609970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6QZiWltGbVrdRcMlM7BU/F3AZKV96hBT2gFmldp0qc=;
 b=L87rs7n2miVSGMHKpB+5TLgaZZBusU8WFdDraLu5D3muZF9g0IhsU+4nT3eogtHerj
 jq7TX1Z8mDFM8J3BRiHlO90/RelAE9nTY18Nfi2C1o4o8fsl+WyIcuDPvw+0K6RiG+8O
 AYzV2exVzV/3h5MGmiWiMC6JK0Mdc4z0FoRd0yv9te9EEYfNY2lpZ1pLTlXBA+J5nqrW
 bEShFyqQfDwObSv+y8Mbq6+lsnLN0BpfS+x7fvRB7b3/bFDay9rCDUodT1VIWqCfwV8w
 YKVXZRAxHV1M0N16K3V3jsdRZXKVMc8hNO2fAyjTHdZ4ko+HoBwPTv9v9J37+bGLoby5
 29aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005170; x=1777609970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d6QZiWltGbVrdRcMlM7BU/F3AZKV96hBT2gFmldp0qc=;
 b=rYY4NIOroY4B59kOwRCUQNeoZmlqlv9LNmP5RxQdw8mcRHTzhRIQrOd4XIDBIsWD7Y
 0Rgqp2tU/+tC4cLydCvlK2y3xzsh/sxM7/pTcqvuXaOZA22xoWUtjykniJT1f7W5qDju
 b82eEvaCz+J+sUdNnIaN/KVdFX+2m6LNqr0Yfyr7zLzWzc0aMj9RfX6/CAhQUdJtRJ1f
 zP2J4FAYa10VT3tmSQvTwhmzbljceTeu71D0ZDzxknLIX6je10qzpvdpPXAzHCtYz4uD
 hRfrg4PWYyonBuMbkGW2yNg3rDIclVNy+Ibu7kpznCw+k5Hlg9eAhjayTUkmOlCjOPKd
 84kA==
X-Gm-Message-State: AOJu0YxLF7zlaKhC6q0HbKIDUjRVq5F6029M/PJ3jdNcGmDNJ+tqbv6/
 vyGa+nbMgUR5ATqpxiR0MpaCxAae/xibbmEqss2PNymIO3oLFN9Lfvd6QO4nQleeWuZKxA45Vj4
 Cv1n3S5E=
X-Gm-Gg: AeBDiesVEe6HQX2Jl842iwouztApLhDFqDIy+gzH0PvB5H8qja/1gtGc9VCRP6d+1KJ
 /jFv250k+gE83eDu0fkVNIAS3/QE9dWHdWZtVnglkWAucxQFEUTMT2VPr7854KHqgyRYmhh2oAF
 uYj0P4GROgugn4WBdw7GYaFaE6EAaeJkJcHXq5pLd3uL0pgICRSeRzUpKXZfu5ViatsWfxyXpaS
 /HmZEtQ8gOSoBH5dNjkLa61RNgkBO/4b0kArqvbTKw/T8TbbVrJYmZgbjpslzmeP7LE2WZ9Ly5v
 7jIlijcj7+KQ0jW2+xzfJtr+yne1uJHTBHAWePuiPIJNAhAmIilSIbW+UNGBkGvot0ghr0pqzk/
 IoBwUaXj8GEalDttoN1MKBA2wPmYBRSV8UGLM7t1FJN0qwNlFFN9b3fj7wGL3zvG1RT974tXF7Y
 0/am993tMyvK3Ld9NsbT7r+2mHp3dnDsBgNagetTnIdptGk/E928mVC5HpkdzZzQ==
X-Received: by 2002:a05:6808:15a0:b0:47a:8c2:a551 with SMTP id
 5614622812f47-47a08c2b6d8mr4772853b6e.16.1777005169539; 
 Thu, 23 Apr 2026 21:32:49 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 38/40] target/arm: Implement LUTI2, LUTI4 for SVE
Date: Fri, 24 Apr 2026 14:30:12 +1000
Message-ID: <20260424043014.46305-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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
index 7f1a394ef0..3a48c12a54 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1630,6 +1630,12 @@ isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
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
index 4001f2fc36..68d67274af 100644
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
@@ -884,4 +885,11 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
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
index 165dfa4484..2f42b89115 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10819,6 +10819,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->max_svl = arm_cpu->sme_max_vq * 16;
+    dc->max_any_vl = MAX(dc->max_svl, arm_cpu->sve_max_vq * 16);
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
     dc->bt = EX_TBFLAG_A64(tb_flags, BT);
     dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index eff3e71ade..b5232c8b0d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8267,3 +8267,71 @@ TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
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
index 7fce189b36..a11ea08eb3 100644
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


