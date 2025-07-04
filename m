Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E000FC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUU-00048x-5p; Fri, 04 Jul 2025 10:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPJ-0002Yw-3y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:55 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPG-0001Vf-0B
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2f3dab2a2a9so901254fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639329; x=1752244129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhncQ8PgMWVSdnpTDImGfIqrCJDDTsezGTJZF5sS3cw=;
 b=Qn8/eL0gPnBOPntSDHdourGjv+dzmRx25/dkaeBXHZdmp3ZswxYfE9sKn6Fs1KYKQt
 S2AyZsxDxBP3Ft7x7eZM2Mnnjc/QrCR/tegBxu3ZQ7TkWbQOBo1a5FvYdx25w7ydFOdW
 RFNn+xyPwtKIKsEyQg6ozCXZ8t5qTG2Z5K/Kfj412s3FjVB0nzhH3Tn5iH69F19c1u9+
 qVS45z1RHtU3UB350cRSzt4mg922dtgN/eNsXBUcAasTozJFRjfFzMSzgvW4K8OLm70z
 TBaNJrDVYBKZSjqGpDjgFLK605eAxk9F+8t1QmQytCaLkJBHl4c/zVr2m/wuQc6RhlIb
 WO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639329; x=1752244129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhncQ8PgMWVSdnpTDImGfIqrCJDDTsezGTJZF5sS3cw=;
 b=hg7zl5wFDXQw48UwpgPWlKhaegvqD0Td/h/WnjQiu/cgIN6R73AlbFnXA7eMBjIXxl
 4hignrO0rQ9xMKMyc5n33mHmfj5nQC+zqmc+CvMf0902xB11mTFRTl4zm/6YrGY5Fsvf
 kaXFXfS+Bab0GC73Skztf1Og/wKusmlReAhL764LqajlMRw7lwClLXkTL4/xGdZFUOp9
 zati1nsmEj1CRzegtgXQeDQm41cgRpHNpr1uGjhIutlLeY5Y1nyHArj/6fKmp/49TZK/
 z/ggBvazRAaSHN/NSE3RIKl8KfgzJqn8aZAYEE+DbF0BuEjI5Z4yzgwEPejynk/teKox
 LtFw==
X-Gm-Message-State: AOJu0YyePD9lB+aLlDqIF+7QIBPG36Ff8mOmDR/6Q1/IoVOBvoD3BDgF
 oXYT8aWIpogUhswg3rkFE1/UMSqz/WDhA4NOKNSowd1CU5GrFI2idUWus0gwuzukZHoYTbWgsQL
 q/RzP6bc=
X-Gm-Gg: ASbGncuR/sEWJ1zfyVECAKjNlGHgudKw2QonLhuh/JK4TWpZe9SqmtjBXIMnkx3rfM/
 gKyC4b21i+rmsV0aJ3Am8Dk6IJW+Y6MnsFott7YEgYXXQyi2eu48aS2VduSklUUOarW8ABbLcEd
 JlRkr445jaNIm/N1QBV02zxxBAfUpT+jxSrTRJNeN3cQWDjO4hKtieOaZ69KhcaTnMII2KsHppu
 xFH1Ccdt9oyYoHt0P9CSD5TupChAw3piNcD3g3FzOdG/hXiT70I9lXIEIEIwH/ySWt6NOV2P3iW
 821EMvEzPdTBPX60OBnvOoGRE7ElJSvwIZnhCp7p9sh8SgemAeQox+zDlCWPdXLONz3wAUsMHGs
 dljS+2a0B+W7qllnS5aqLuwNJ1u9L6h1bVIvw7gnZqZn+vhz3
X-Google-Smtp-Source: AGHT+IEe1REoTQfMU3yTvKkFgCwIjuMZLd6nPXC0UR9DAwHQiYtClgtdzi7baoK6WRyMi1A8jXismA==
X-Received: by 2002:a05:6870:aa05:b0:29e:559b:d694 with SMTP id
 586e51a60fabf-2f796ccbfc7mr1928386fac.32.1751639328740; 
 Fri, 04 Jul 2025 07:28:48 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 090/108] target/arm: Implement PMOV for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 08:20:53 -0600
Message-ID: <20250704142112.1018902-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  8 +++
 target/arm/tcg/vec_internal.h  | 34 ++++++++++++
 target/arm/tcg/sve_helper.c    | 50 +++++++++++++++++
 target/arm/tcg/translate-sve.c | 98 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      | 17 ++++++
 5 files changed, 207 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 733828a880..04b9545c11 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -3020,3 +3020,11 @@ DEF_HELPER_FLAGS_4(sve2p1_andqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_andqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_andqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_andqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(pmov_pv_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(pmov_pv_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(pmov_pv_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(pmov_vp_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(pmov_vp_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(pmov_vp_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 61c67bb35e..957bf6d9fc 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -411,4 +411,38 @@ decode_counter(unsigned png, unsigned vl, unsigned v_esz)
     return ret;
 }
 
+/* Extract @len bits from an array of uint64_t at offset @pos bits. */
+static inline uint64_t extractn(uint64_t *p, unsigned pos, unsigned len)
+{
+    uint64_t x;
+
+    p += pos / 64;
+    pos = pos % 64;
+
+    x = p[0];
+    if (pos + len > 64) {
+        x = (x >> pos) | (p[1] << (-pos & 63));
+        pos = 0;
+    }
+    return extract64(x, pos, len);
+}
+
+/* Deposit @len bits into an array of uint64_t at offset @pos bits. */
+static inline void depositn(uint64_t *p, unsigned pos,
+                            unsigned len, uint64_t val)
+{
+    p += pos / 64;
+    pos = pos % 64;
+
+    if (pos + len <= 64) {
+        p[0] = deposit64(p[0], pos, len, val);
+    } else {
+        unsigned len0 = 64 - pos;
+        unsigned len1 = len - len0;
+
+        p[0] = deposit64(p[0], pos, len0, val);
+        p[1] = deposit64(p[1], 0, len1, val >> len0);
+    }
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index def841fd52..a9dc3c44b2 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3035,6 +3035,56 @@ void HELPER(sve_rev_d)(void *vd, void *vn, uint32_t desc)
     }
 }
 
+/*
+ * TODO: This could use half_shuffle64 and similar bit tricks to
+ * expand blocks of bits at once.
+ */
+#define DO_PMOV_PV(NAME, ESIZE)                                 \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    unsigned vl = simd_oprsz(desc);                             \
+    unsigned idx = simd_data(desc);                             \
+    unsigned elements = vl / ESIZE;                             \
+    ARMPredicateReg *d = vd;                                    \
+    ARMVectorReg *s = vs;                                       \
+    memset(d, 0, sizeof(*d));                                   \
+    for (unsigned e = 0; e < elements; ++e) {                   \
+        depositn(d->p, e * ESIZE, 1, extractn(s->d, elements * idx + e, 1)); \
+    }                                                           \
+}
+
+DO_PMOV_PV(pmov_pv_h, 2)
+DO_PMOV_PV(pmov_pv_s, 4)
+DO_PMOV_PV(pmov_pv_d, 8)
+
+#undef DO_PMOV_PV
+
+/*
+ * TODO: This could use half_unshuffle64 and similar bit tricks to
+ * compress blocks of bits at once.
+ */
+#define DO_PMOV_VP(NAME, ESIZE)                                 \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    unsigned vl = simd_oprsz(desc);                             \
+    unsigned idx = simd_data(desc);                             \
+    unsigned elements = vl / ESIZE;                             \
+    ARMVectorReg *d = vd;                                       \
+    ARMPredicateReg *s = vs;                                    \
+    if (idx == 0) {                                             \
+        memset(d, 0, vl);                                       \
+    }                                                           \
+    for (unsigned e = 0; e < elements; ++e) {                   \
+        depositn(d->d, elements * idx + e, 1, extractn(s->p, e * ESIZE, 1)); \
+    }                                                           \
+}
+
+DO_PMOV_VP(pmov_vp_h, 2)
+DO_PMOV_VP(pmov_vp_s, 4)
+DO_PMOV_VP(pmov_vp_d, 8)
+
+#undef DO_PMOV_VP
+
 typedef void tb_impl_fn(void *, void *, void *, void *, uintptr_t, bool);
 
 static inline void do_tbl1(void *vd, void *vn, void *vm, uint32_t desc,
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index a918da31fe..01c4eaa585 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2386,6 +2386,104 @@ static gen_helper_gvec_3 * const tbx_fns[4] = {
 };
 TRANS_FEAT(TBX, aa64_sve2, gen_gvec_ool_arg_zzz, tbx_fns[a->esz], a, 0)
 
+static bool trans_PMOV_pv(DisasContext *s, arg_PMOV_pv *a)
+{
+    static gen_helper_gvec_2 * const fns[4] = {
+        NULL,                 gen_helper_pmov_pv_h,
+        gen_helper_pmov_pv_s, gen_helper_pmov_pv_d
+    };
+    unsigned vl, pl, vofs, pofs;
+    TCGv_i64 tmp;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    if (a->esz != MO_8) {
+        tcg_gen_gvec_2_ool(pred_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vl, vl, a->imm, fns[a->esz]);
+        return true;
+    }
+
+    /*
+     * Copy the low PL bytes from vector Zn, zero-extending to a
+     * multiple of 8 bytes, so that Pd is properly cleared.
+     */
+
+    pl = vl / 8;
+    pofs = pred_full_reg_offset(s, a->rd);
+    vofs = vec_full_reg_offset(s, a->rn);
+
+    QEMU_BUILD_BUG_ON(sizeof(ARMPredicateReg) != 32);
+    for (unsigned i = 32; i >= 8; i >>= 1) {
+        if (pl & i) {
+            tcg_gen_gvec_mov(MO_64, pofs, vofs, i, i);
+            pofs += i;
+            vofs += i;
+        }
+    }
+    switch (pl & 7) {
+    case 0:
+        return true;
+    case 2:
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld16u_i64(tmp, tcg_env, vofs + (HOST_BIG_ENDIAN ? 6 : 0));
+        break;
+    case 4:
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld32u_i64(tmp, tcg_env, vofs + (HOST_BIG_ENDIAN ? 4 : 0));
+        break;
+    case 6:
+        tmp = tcg_temp_new_i64();
+        tcg_gen_ld_i64(tmp, tcg_env, vofs);
+        tcg_gen_extract_i64(tmp, tmp, 0, 48);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_st_i64(tmp, tcg_env, pofs);
+    return true;
+}
+
+static bool trans_PMOV_vp(DisasContext *s, arg_PMOV_pv *a)
+{
+    static gen_helper_gvec_2 * const fns[4] = {
+        NULL,                 gen_helper_pmov_vp_h,
+        gen_helper_pmov_vp_s, gen_helper_pmov_vp_d
+    };
+    unsigned vl;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+
+    if (a->esz == MO_8) {
+        /*
+         * The low PL bytes are copied from Pn to Zd unchanged.
+         * We know that the unused portion of Pn is zero, and
+         * that imm == 0, so the balance of Zd must be zeroed.
+         */
+        tcg_gen_gvec_mov(MO_64, vec_full_reg_offset(s, a->rd),
+                         pred_full_reg_offset(s, a->rn),
+                         size_for_gvec(vl / 8), vl);
+    } else {
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->rd),
+                           pred_full_reg_offset(s, a->rn),
+                           vl, vl, a->imm, fns[a->esz]);
+    }
+    return true;
+}
+
 static bool trans_UNPK(DisasContext *s, arg_UNPK *a)
 {
     static gen_helper_gvec_2 * const fns[4][2] = {
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index af4fb966bf..3271c9cf78 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -30,6 +30,7 @@
 %size_23        23:2
 %dtype_23_13    23:2 13:2
 %index3_22_19   22:1 19:2
+%index3_22_17   22:1 17:2
 %index3_19_11   19:2 11:1
 %index2_20_11   20:1 11:1
 
@@ -594,6 +595,22 @@ INSR_r          00000101 .. 1 00100 001110 ..... .....          @rdn_rm
 # SVE reverse vector elements
 REV_v           00000101 .. 1 11000 001110 ..... .....          @rd_rn
 
+# SVE move predicate to/from vector
+
+PMOV_pv         00000101 00 101 01 0001110 rn:5 0 rd:4          \
+                &rri_esz esz=0 imm=0
+PMOV_pv         00000101 00 101 1 imm:1 0001110 rn:5 0 rd:4     &rri_esz esz=1
+PMOV_pv         00000101 01 101 imm:2 0001110 rn:5 0 rd:4       &rri_esz esz=2
+PMOV_pv         00000101 1. 101 .. 0001110 rn:5 0 rd:4          \
+                &rri_esz esz=3 imm=%index3_22_17
+
+PMOV_vp         00000101 00 101 01 1001110 0 rn:4 rd:5          \
+                &rri_esz esz=0 imm=0
+PMOV_vp         00000101 00 101 1 imm:1 1001110 0 rn:4 rd:5     &rri_esz esz=1
+PMOV_vp         00000101 01 101 imm:2 1001110 0 rn:4 rd:5       &rri_esz esz=2
+PMOV_vp         00000101 1. 101 .. 1001110 0 rn:4 rd:5          \
+                &rri_esz esz=3 imm=%index3_22_17
+
 # SVE vector table lookup
 TBL             00000101 .. 1 ..... 001100 ..... .....          @rd_rn_rm
 
-- 
2.43.0


