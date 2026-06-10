Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA117CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYH-00025v-V0; Wed, 10 Jun 2026 12:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYG-000232-NB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:12 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYE-0005xP-Ob
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:12 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4600ddc4017so4824011f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107989; x=1781712789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nHNiAxcsamDuqssqGG6CRDh6SRjbGKNnt1wIjn9qaVI=;
 b=uo5xYltD00luUyMeyPFEK6Dta4uwnh8se29uByJZ1lggu824matGrb7NvFA8+aJQ9q
 7/NZaXHyNWdpQpY2Ll/0z29hMjzZVqophcG2FwEbwRXmJfE+CgG0dd8JXFH1M2gCORW6
 5dd60dSNQwJuLWgkqsf3qHJf0n/CnsK7ttMxH+RIR7HhnOzZ1SrppBt1IogqwHKUhIQQ
 Jx+0Wfyp53wacrKudRl6T+58xiZ+4hOotVb0YtWkn3Z8fdUrnMNeOm5u3I6Tdifeanhc
 fxyCbvHxDNQS0WKVZQaMvz+Iz1baJSx1kEBbRg+VGv2QKAyitELEkiIGvTKtvze+eo9Z
 Y8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107989; x=1781712789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nHNiAxcsamDuqssqGG6CRDh6SRjbGKNnt1wIjn9qaVI=;
 b=Eoq651nxnfSmb6axRdivkX6k+2zmdTr3YbQILSj98bm2W5teQuxRHs10d9scw2gH26
 eT9Eo2wqTL+HezJ2l9+qazgafXXVWCmGdCdh23JrqBLBv4D1X7GQoUPnrhlz7TX1MI5Y
 hzPYJ7NN4MnsIASs53+D+KgfdS0oOeqJm5YEoxChi7i6P/q4gn1fTQTitLw3b1AbPFRy
 NQDrRTsi+FEtWNRfg7C6TU+MIWjCDBiHuRutFoQ7WpOUUB+fClHJX3DO+SCwAPkLbwSg
 YlWO38ki2PqObcXGcNT2kn0hFbxvDw25MEmgjZahDSmnu8kxOVGBfdHqitAnpVodhoN2
 o3Ww==
X-Gm-Message-State: AOJu0YzdFxwxlmj/sbx0gl60L/XjZgKBc3Y8WGx2YRdKHbK1nfzsKzmu
 xHglMd1ddO346FQpHVMp1aEcCVTIGVVrvsW7XGLB2E7i+xmiyqxhdVm5Vc+HHHlLVdheqKMykrg
 zbqyU
X-Gm-Gg: Acq92OEoK0KH7DSq/UfiDlyXmCo/hBmLTx5WBAk4KX706HGoI4fZl0MJk9HXhfd+7Vj
 BC4Dh36gPJpQlQ17yJPAoF2KLMdme7Hge8yDRdfg2TJJ+WCs4hsX9LNrgnf49hxgIXzZvUqV0hj
 tFEVBeWOUL0WDAipnWcWIv+T+tyzB7RkyXPUZg3khUff24jNcv69PrxILQjd8alNKp21/Jn2NT/
 +S11EH4msPda06+lzIT7g9MI2fygwXhlcWbNcx1ykY92/1iwkT+WlzIws53/q81l8KDFLASeS7O
 Efk/QRpVZKL+gpD9mTHJNiyJxLCD8oOFGN4B+ton0Fs0Ox2nX1TqhnUwSHwGgDTIlexdVb/mVZA
 wxYxUgzfznMMIPeBYDdKQNZS539VsDQVHO0gKdOiaEEKRXdH3A2AAAlC4T432dZUIuuQcz02KlE
 7MGqttqPiWQqQazyMaEHitHNgNGsv/nueZuTFaExJlMFybBD7qag9xd9qiYy2afAqCizVUiu6TO
 lZLKZ3S5CBM6/PXtTmJAKlguoPV3elEHwCXM9+PyYE=
X-Received: by 2002:adf:fa89:0:b0:453:e3a1:6580 with SMTP id
 ffacd0b85a97d-46030501f74mr27232904f8f.25.1781107989314; 
 Wed, 10 Jun 2026 09:13:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/71] target/arm: Implement LUTI2, LUTI4 for SVE
Date: Wed, 10 Jun 2026 17:11:39 +0100
Message-ID: <20260610161202.2235298-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  6 +++
 target/arm/tcg/sve.decode      | 11 +++++-
 target/arm/tcg/translate-a64.c |  1 +
 target/arm/tcg/translate-sve.c | 68 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate.h     |  1 +
 5 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index e285f57d25..8770fce2fa 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1674,6 +1674,12 @@ isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ffd505601c..25579d4ba0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10917,6 +10917,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vl = (EX_TBFLAG_A64(tb_flags, VL) + 1) * 16;
     dc->svl = (EX_TBFLAG_A64(tb_flags, SVL) + 1) * 16;
     dc->max_svl = arm_cpu->sme_max_vq * 16;
+    dc->max_any_vl = MAX(dc->max_svl, arm_cpu->sve_max_vq * 16);
     dc->pauth_active = EX_TBFLAG_A64(tb_flags, PAUTH_ACTIVE);
     dc->bt = EX_TBFLAG_A64(tb_flags, BT);
     dc->btype = EX_TBFLAG_A64(tb_flags, BTYPE);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 065f16d899..0e0bc4cbfe 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8287,3 +8287,71 @@ TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
 TRANS_FEAT(LD1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, false, true)
 TRANS_FEAT(ST1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, true, true)
 TRANS_FEAT(ST1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, true, true)
+
+TRANS_FEAT_STREAMING_IF(LUTI2_1b, aa64_sme2_or_sve2_lut, aa64_sme2,
+                        gen_gvec_ool_zzz, gen_helper_gvec_luti2_b,
+                        a->rd, a->rn, a->rm, a->index)
+TRANS_FEAT_STREAMING_IF(LUTI2_1h, aa64_sme2_or_sve2_lut, aa64_sme2,
+                        gen_gvec_ool_zzz, gen_helper_gvec_luti2_h,
+                        a->rd, a->rn, a->rm, a->index)
+TRANS_FEAT_STREAMING_IF(LUTI4_1b, aa64_sme2_or_sve2_lut, aa64_sme2,
+                        gen_gvec_ool_zzz, gen_helper_gvec_luti4_b,
+                        a->rd, a->rn, a->rm, a->index)
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
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index ae3897b456..462d4c1c74 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -91,6 +91,7 @@ typedef struct DisasContext {
     int vl;          /* current vector length in bytes */
     int svl;         /* current streaming vector length in bytes */
     int max_svl;     /* maximum implemented streaming vector length */
+    int max_any_vl;  /* maximum implemented vector length */
     bool vfp_enabled; /* FP enabled via FPSCR.EN */
     int vec_len;
     int vec_stride;
-- 
2.43.0


