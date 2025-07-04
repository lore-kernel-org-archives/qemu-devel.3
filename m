Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64684C83F0F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjGx-0000pU-71; Fri, 04 Jul 2025 12:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFM-00045M-AB
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFJ-0006uM-4O
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:43 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a52874d593so927665f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646399; x=1752251199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UvKe3+Dw5YGWmoQlTXHshRFBmp9WtV0jlsVuUUDS5kM=;
 b=wOwJ5CdPdBIoijYZBXnKybQR4ERIUbYaPGDl+2OgSI+yyCuLLgo/3FuKDYX7pprKQj
 TnaypmgL0SWj9Cdk4J5A1UkiBEUR3/r3dNV0HrVscRB0Sm8TeQKaG4lVrKl1rUSY6eqX
 QAEmtW/sqBs0qLyZIkIxR64JlgL96Hq+m5UFaAsASNRlkkQHb9Cac/LpkSSeGV4Ejv9L
 uULD05wnu0JtUMME7ga7Y7G1KpwvmpMFFDmF2aKzp/qprMa0cUEJZajx5o9eXrJFl9g8
 zf4AZTbXNM3/l04n3mAGFC2vFSV65d9WSFMjAYrAHUNiN4n9xsGNQNDpQrJEjB0Dnu69
 p4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646399; x=1752251199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UvKe3+Dw5YGWmoQlTXHshRFBmp9WtV0jlsVuUUDS5kM=;
 b=EE3E3Z9h8fry3MMYAkgFyHPkxOVdbeLRW07H4BklpahTrwUIJuVW2YaeJO8/GOyXFB
 cl98Su6OcpdUw3/BKZ4CP1oAkM9qnIkkjcvs86Os9ZJBFThV6Pf51BZGRpOdpu2G4dW8
 /h2WRPN88g4G4dePNw/RPIx54E58yGkZIGhzFBDXg80HijeyxEkbwH7JoDGMMLD1UyCD
 HE0mi4b7cUuVfARSVft/KKvKYzWflRAa0I5DM1G/YZmkC77cOLP2chExBlGowDN8LRdk
 wH3RCXo2i8V8tBlchvOg5GLghA4X5yM1Ki2amPT1AHG9a3OR1Inh4EdjacoxPKMpO/sm
 XI+A==
X-Gm-Message-State: AOJu0Yw2puRf3S3EaF/K24J6uVgRKDC5Iq3ZIxKBz86dPMsC8Oo3JsqP
 HBka4bknIIH0SbzhqQKybYdK/fDnjgJ9er4Cbx7DLqNdS2o30xLOQTnk8yH10//gVQNTf0RighF
 TClrG
X-Gm-Gg: ASbGncvXy0Ld4zxSXu0ltr3N40hsva81pJV7N2AzJlZSlFk48FLAyfsTqGjWue1b5Xh
 nFnqkahD+Z8eRW7W57z7WoyUVA+/2dRbsFJ9spRbW1natZtlB3MmJiw5I3OlSK3+elqB4xwS6bh
 FC2bkl3Gq6FrxSk69xihh2k7DO1jpaSd0BpvWRnyj6jKgaj+WqMWfvxDG/7mrBkuMCcdl0SulSk
 Ifn8qs7SzMDYCSS8HwRw4a2snu6UavcHBKmwUG0aBQLE4fKsLhw40AUnBK+B9Qju3iChHEmCDkH
 Ukhs3YC/z9CeMEFIyesRMcEvOBt5JD5aVvPpBhuH2p5EfMAs4RSeE5H8DqqOnIetsEHiqPlXh7h
 f+gU=
X-Google-Smtp-Source: AGHT+IE7YezRxTwqjArzNKUZElxZdSEhMLOCBS/gFiQZf96KZLDSJgaknHavOrAcCIHJ10NUgT4tnQ==
X-Received: by 2002:adf:9d8c:0:b0:3b3:1e2e:ee07 with SMTP id
 ffacd0b85a97d-3b496626856mr2381255f8f.56.1751646399443; 
 Fri, 04 Jul 2025 09:26:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 102/119] target/arm: Implement PMOV for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 17:24:42 +0100
Message-ID: <20250704162501.249138-103-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-91-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  8 +++
 target/arm/tcg/vec_internal.h  | 34 ++++++++++++
 target/arm/tcg/sve.decode      | 17 ++++++
 target/arm/tcg/sve_helper.c    | 50 +++++++++++++++++
 target/arm/tcg/translate-sve.c | 98 ++++++++++++++++++++++++++++++++++
 5 files changed, 207 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 733828a8806..04b9545c11e 100644
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
index 61c67bb35e7..957bf6d9fca 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index af4fb966bf9..3271c9cf78c 100644
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
 
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index def841fd52f..a9dc3c44b22 100644
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
index a918da31fe1..01c4eaa5856 100644
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
-- 
2.43.0


