Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B034EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZI-0003mX-5l; Fri, 04 Jul 2025 10:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPO-0002qj-09
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:29:02 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPH-0001ZB-41
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:57 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2edec6c5511so332943fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639330; x=1752244130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7CuGJQsP3KAFwwlG5UMmN6IEmCLus5slAxw2lKnap7o=;
 b=U/OcQAiBLr0RDRgp2EHrvKDCwqGwiLF/QSmSBroW90KvefBhYZZh9hq/hm4AJcShSo
 TK9JndZVcPBnNfBWYiN/sYr3h+fYb2HT5T0URfZeGCluIXH7LJAQjrxAK2oMyRnZCHGp
 FgoMSO8vmpXvt6NYh4vtYz9sl276lKuO7uNH3mi/78OJIDNmfrZdu9/b3liAlq6ZWG5+
 5t33kCgdVuddvh8cj/6925fk9dc/QSwQB3io8QYSwWkR+3qxsqVra8FsY5iJkHJVP9NQ
 EvIKfOnaP4IknxTEfheQd5fWI3C8pEREmzHp2mYSzpfh/0DXeRr2AZmu1Dw152cBwQqt
 xjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639330; x=1752244130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7CuGJQsP3KAFwwlG5UMmN6IEmCLus5slAxw2lKnap7o=;
 b=VH1J4jfG5T2PgCRbSuyjf7L+USckT3AXDM7C9pyUTFoynJh21SUn+PRgJNolHA9sax
 ikP67MtWrDml2x7Pev+xQKpUfdp8Lv396aaD2Ws+DkwzLeofY8fJICqc/3k7b2o6rCOB
 qw67yk4/h0jsMIGGH5p1kjcb0U3A+Jmsyi1CX+4Dq7yX5Sg3ywiHsj79rmDSv+SiNNal
 raHauPaKBnYvQmvf562rKsP2RsXiwe4upa1fbZ7YovWm8TF3SQVbCiCrvbQrL7alWDBF
 ouVHHBYWfUQynGfaN5UYs9JfT+r36y546nPSUCKr5mq1Xp88XCdRvAW2XcBrHRZpc9Sp
 pHyw==
X-Gm-Message-State: AOJu0YxYnVzRVKiuI2JG52FV95aYoD5TI3X4OWLrwRrrBdV5F1rkxudj
 shsME7UBrBzlINCDpLVqU4ffhCQO+r6O89fV59+8KyPqK/j1pGLqzSTJqt64/G5MHrml+2bjHHc
 D1Jo9J7k=
X-Gm-Gg: ASbGnctlQfnwBBVtilBx71EXRfNmjSo6WpGYVixreMQbhSKzbTZn1vag4IOeIR96Uv9
 kcoTIIg/FDIseoVI8VmPXKnMNa/0ntykdBqdvQj5ryDwN7c0M1K97C+C7xG/sLEeDC49a/gzqOU
 bCJCr8wDFVxTn9wBCmACyZ127rI5IKXOE/+assYt6mtmcdJ0fpKhW06svfMnoGhV2ASu0Mh7O6/
 klxZsZ+hYKEqU6gP8YkGJtAfzIULwRQS30mqSDq4rkXc+FGlbi3FED3UVBMn2YTijAG1PtoDDVd
 uuFqkMNA5GJD39sYo/4kGlXZ7QpiFrcfBwWqBXx1+ZHIiwFwPQ+Uk9lxy+PBib+EVuUCw0Y8d/a
 ku+vRnzF+OwmimAmhi5QiDlWAA2P+j1N24j0cMymHRN15XIIh
X-Google-Smtp-Source: AGHT+IHFYz4QZxL+tWYXxMvV2L9BZaRZrjo7FvWEjt53EpwdE4VV6u9+0eXqrw4oyKCKAai3atQqsQ==
X-Received: by 2002:a05:6870:288a:b0:2d4:d07c:7cc5 with SMTP id
 586e51a60fabf-2f796a0304bmr1547429fac.12.1751639329797; 
 Fri, 04 Jul 2025 07:28:49 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 091/108] target/arm: Implement ZIPQ, UZPQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 08:20:54 -0600
Message-ID: <20250704142112.1018902-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 10 ++++++++++
 target/arm/tcg/sve_helper.c    | 29 +++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 19 ++++++++++++++++++-
 target/arm/tcg/sve.decode      |  6 ++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 04b9545c11..0f510ea610 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -701,12 +701,22 @@ DEF_HELPER_FLAGS_4(sve_zip_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_zip_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_zip_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p1_zipq_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_zipq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_zipq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_zipq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_uzp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_uzp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_uzp_q, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_uzpq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_trn_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index a9dc3c44b2..dbbfbc12b9 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3550,6 +3550,35 @@ DO_UZP(sve_uzp_s, uint32_t, H1_4)
 DO_UZP(sve_uzp_d, uint64_t, H1_8)
 DO_UZP(sve2_uzp_q, Int128, )
 
+typedef void perseg_zzz_fn(void *vd, void *vn, void *vm, uint32_t desc);
+
+static void do_perseg_zzz(void *vd, void *vn, void *vm,
+                          uint32_t desc, perseg_zzz_fn *fn)
+{
+    intptr_t oprsz = simd_oprsz(desc);
+
+    desc = simd_desc(16, 16, simd_data(desc));
+    for (intptr_t i = 0; i < oprsz; i += 16) {
+        fn(vd + i, vn + i, vm + i, desc);
+    }
+}
+
+#define DO_PERSEG_ZZZ(NAME, FUNC) \
+    void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+    { do_perseg_zzz(vd, vn, vm, desc, FUNC); }
+
+DO_PERSEG_ZZZ(sve2p1_uzpq_b, helper_sve_uzp_b)
+DO_PERSEG_ZZZ(sve2p1_uzpq_h, helper_sve_uzp_h)
+DO_PERSEG_ZZZ(sve2p1_uzpq_s, helper_sve_uzp_s)
+DO_PERSEG_ZZZ(sve2p1_uzpq_d, helper_sve_uzp_d)
+
+DO_PERSEG_ZZZ(sve2p1_zipq_b, helper_sve_zip_b)
+DO_PERSEG_ZZZ(sve2p1_zipq_h, helper_sve_zip_h)
+DO_PERSEG_ZZZ(sve2p1_zipq_s, helper_sve_zip_s)
+DO_PERSEG_ZZZ(sve2p1_zipq_d, helper_sve_zip_d)
+
+#undef DO_PERSEG_ZZZ
+
 #define DO_TRN(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)         \
 {                                                                      \
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 01c4eaa585..28cfcb9cb4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2606,11 +2606,19 @@ TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
                         gen_helper_sve2_zip_q, a,
                         QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
 
+static gen_helper_gvec_3 * const zipq_fns[4] = {
+    gen_helper_sve2p1_zipq_b, gen_helper_sve2p1_zipq_h,
+    gen_helper_sve2p1_zipq_s, gen_helper_sve2p1_zipq_d,
+};
+TRANS_FEAT(ZIPQ1, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           zipq_fns[a->esz], a, 0)
+TRANS_FEAT(ZIPQ2, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           zipq_fns[a->esz], a, 16 / 2)
+
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
     gen_helper_sve_uzp_s, gen_helper_sve_uzp_d,
 };
-
 TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 0)
 TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
@@ -2621,6 +2629,15 @@ TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
 TRANS_FEAT_NONSTREAMING(UZP2_q, aa64_sve_f64mm, do_interleave_q,
                         gen_helper_sve2_uzp_q, a, 16)
 
+static gen_helper_gvec_3 * const uzpq_fns[4] = {
+    gen_helper_sve2p1_uzpq_b, gen_helper_sve2p1_uzpq_h,
+    gen_helper_sve2p1_uzpq_s, gen_helper_sve2p1_uzpq_d,
+};
+TRANS_FEAT(UZPQ1, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           uzpq_fns[a->esz], a, 0)
+TRANS_FEAT(UZPQ2, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           uzpq_fns[a->esz], a, 1 << a->esz)
+
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
     gen_helper_sve_trn_s, gen_helper_sve_trn_d,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 3271c9cf78..e98275eec1 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -657,6 +657,12 @@ UZP2_q          00000101 10 1 ..... 000 011 ..... .....         @rd_rn_rm_e0
 TRN1_q          00000101 10 1 ..... 000 110 ..... .....         @rd_rn_rm_e0
 TRN2_q          00000101 10 1 ..... 000 111 ..... .....         @rd_rn_rm_e0
 
+# SVE2.1 permute vector elements (quadwords)
+ZIPQ1           01000100 .. 0 ..... 111 000 ..... .....         @rd_rn_rm
+ZIPQ2           01000100 .. 0 ..... 111 001 ..... .....         @rd_rn_rm
+UZPQ1           01000100 .. 0 ..... 111 010 ..... .....         @rd_rn_rm
+UZPQ2           01000100 .. 0 ..... 111 011 ..... .....         @rd_rn_rm
+
 ### SVE Permute - Predicated Group
 
 # SVE compress active elements
-- 
2.43.0


