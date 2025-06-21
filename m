Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DE2C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT830-0004Ny-15; Sat, 21 Jun 2025 19:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82R-0002Ip-TR
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:23 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82P-00059z-Tj
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2345398b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550060; x=1751154860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W529ldEjzy97zWkcEgDHs6DmFN7fipK/apSbHWeYFrk=;
 b=v//lRmsflmM0/2xIAZmZLqNGii2KROIeLg4S9MKi1RXWr2FDrL3h3w7V/QE/OTYrVv
 OG2AEbiu+TSay6H4bJFtfuU5yEMGIq6lOa7NPn/w8IqESn79vMYUF9ItW8T+4eL/zQ9x
 gvkgDCz5UbzHkxBEohc9vAMNuZOzB5IRpl60fPGx2XYoYbA6/xMUbnk8Q2p2fhP+BI8N
 3Uj9M+zxGJoBism1fc/y6A40JtqrLLOrKx+JOKU470KQEaDMF2o896NMFEg4h3fxKK1S
 R3Pwt7xXv8T0ghXGiLa8ToHuvrZoEXUVbutXQ7ziuvPNapcWF14IHuVjX5l7gZZvWPfX
 snZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550060; x=1751154860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W529ldEjzy97zWkcEgDHs6DmFN7fipK/apSbHWeYFrk=;
 b=DrmW+yzUN7Rv5IWmvJ/REOEXfUoE6kh7x9YfUAnQyGyJSAw2fYceACm8QoNi7ASV99
 j3iwlc22718HGLzYeF2nXgcTECLU+xwLWyhHIGJy/WPitAeWvsY1DYS7ltDGtX10KLD3
 W8CxyTqKADQ2CvIH9bvC5U+nlREyvJ3gh+lI605MnvtnAsqH6iobV5ILGRKRlm1xcThi
 U0SUdU5wGl8EW0cZULsH9VvkAvkLc81HqpPIR/sXtyGaX1e3aG6mLvdGbMkGMrppaq9i
 r3JLZ0yfPiLeFT0R04SjnDJjeBgirisjbTQSc+nZG2y+7aLtlSpTAfODCI0dtAHtOfTo
 uQ5g==
X-Gm-Message-State: AOJu0YxXdbEUwMZ9suwz3t2tRI20i+WtjqNRM9SmoPXfbY06ANypUJUX
 LrtHAD/DCHws8MOXsrIvLag5n9KDDOqSnDx8/fsMmk6YRfl7w/lD/Q+dlePgvhYtKCgKr6mJHfh
 vdon16oY=
X-Gm-Gg: ASbGncsSqfcRuZX2f9f5yF1Y8rMJ5QksmiNMOpP2kBaiI0Y1+cMSJ3coF7jSF2W9sW/
 MLVHpNQxalNn3Re5GPN/0jNPOLd7PCGESD0rQFA5DEz5wIhMfqSdSebd6KAJdSXW/HBUkOxAixt
 WLXxi+o7Ip7zZ+KjREJB5bNPvvyBoLXCkmCwN+hlHu4m32tPyJekiAK3pnOWIkw4qjxfBekWb32
 WcKslpwhCVbeH8hPpDJISFID5b9nRnI2m9aJ6ei4MNsLSm++vhEU5URYfAjTSSUqh/6C0uWoWXh
 evrkR1mu7j2T5EVOwH/AOMYsjB8yaRorBJgo89QP82Ifk29eECpDlNr8vJOtTHVgnjxfZB7Gl26
 CFXwz3oWldUDgUX0YwRZ9
X-Google-Smtp-Source: AGHT+IEz2wNRaz+GVOvajHRKspO4iCu0Zo3fe6WNX/Gem2pqQIdsI9VEIc011V+zLvbKPaTP5DCX6A==
X-Received: by 2002:a05:6a00:4b53:b0:73d:fdd9:a55 with SMTP id
 d2e1a72fcca58-7490f54939fmr11328114b3a.8.1750550060381; 
 Sat, 21 Jun 2025 16:54:20 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 065/101] target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
Date: Sat, 21 Jun 2025 16:50:01 -0700
Message-ID: <20250621235037.74091-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/arm/tcg/helper-sme.h    | 15 +++++++
 target/arm/tcg/sme_helper.c    | 52 ++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 73 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 17 ++++++++
 4 files changed, 157 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 118cb8a7a4..98cab8d920 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -297,3 +297,18 @@ DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_sqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_sqrshrun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_sclamp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_sclamp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_sclamp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_sclamp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_uclamp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uclamp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uclamp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uclamp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sme2_fclamp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme2_fclamp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme2_fclamp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sme2_bfclamp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 76c8ee0448..c8e6a56600 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2000,3 +2000,55 @@ UZP4(sme2_uzp4_d, uint64_t, )
 UZP4(sme2_uzp4_q, Int128, )
 
 #undef UZP4
+
+#define ICLAMP(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    size_t stride = sizeof(ARMVectorReg) / sizeof(TYPE);        \
+    size_t elements = simd_oprsz(desc) / sizeof(TYPE);          \
+    size_t nreg = simd_data(desc);                              \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+    for (size_t e = 0; e < elements; e++) {                     \
+        TYPE nn = n[H(e)], mm = m[H(e)];                        \
+        for (size_t r = 0; r < nreg; r++) {                     \
+            TYPE *dd = &d[r * stride + H(e)];                   \
+            *dd = MIN(MAX(*dd, nn), mm);                        \
+        }                                                       \
+    }                                                           \
+}
+
+ICLAMP(sme2_sclamp_b, int8_t, H1)
+ICLAMP(sme2_sclamp_h, int16_t, H2)
+ICLAMP(sme2_sclamp_s, int32_t, H4)
+ICLAMP(sme2_sclamp_d, int64_t, H8)
+
+ICLAMP(sme2_uclamp_b, uint8_t, H1)
+ICLAMP(sme2_uclamp_h, uint16_t, H2)
+ICLAMP(sme2_uclamp_s, uint32_t, H4)
+ICLAMP(sme2_uclamp_d, uint64_t, H8)
+
+#undef ICLAMP
+
+#define FCLAMP(NAME, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm,                 \
+                  float_status *fpst, uint32_t desc)            \
+{                                                               \
+    size_t stride = sizeof(ARMVectorReg) / sizeof(TYPE);        \
+    size_t elements = simd_oprsz(desc) / sizeof(TYPE);          \
+    size_t nreg = simd_data(desc);                              \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+    for (size_t e = 0; e < elements; e++) {                     \
+        TYPE nn = n[H(e)], mm = m[H(e)];                        \
+        for (size_t r = 0; r < nreg; r++) {                     \
+            TYPE *dd = &d[r * stride + H(e)];                   \
+            *dd = TYPE##_minnum(TYPE##_maxnum(*dd, nn, fpst), mm, fpst); \
+        }                                                       \
+    }                                                           \
+}
+
+FCLAMP(sme2_fclamp_h, float16, H2)
+FCLAMP(sme2_fclamp_s, float32, H4)
+FCLAMP(sme2_fclamp_d, float64, H8)
+FCLAMP(sme2_bfclamp, bfloat16, H2)
+
+#undef FCLAMP
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 675d27f428..f4af2dd98d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1468,3 +1468,76 @@ static gen_helper_gvec_3 * const uzp2_fns[] = {
 };
 TRANS_FEAT(UZP_2, aa64_sme2, do_zipuzp_2, a, uzp2_fns)
 
+static bool trans_FCLAMP(DisasContext *s, arg_zzz_en *a)
+{
+    static gen_helper_gvec_3_ptr * const fn[] = {
+        gen_helper_sme2_bfclamp,
+        gen_helper_sme2_fclamp_h,
+        gen_helper_sme2_fclamp_s,
+        gen_helper_sme2_fclamp_d,
+    };
+    TCGv_ptr fpst;
+    int vl;
+
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (a->esz == MO_8
+        ? dc_isar_feature(aa64_sme2_b16b16, s)
+        : dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (!sme_sm_enabled_check(s)) {
+        return true;
+    }
+
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+    vl = vec_full_reg_size(s);
+
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->zd),
+                       vec_full_reg_offset(s, a->zn),
+                       vec_full_reg_offset(s, a->zm),
+                       fpst, vl, vl, a->n, fn[a->esz]);
+    return true;
+}
+
+static bool do_clamp(DisasContext *s, arg_zzz_en *a,
+                     gen_helper_gvec_3 * const fn[4])
+{
+    int vl;
+
+    if (dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (!sme_sm_enabled_check(s)) {
+        return true;
+    }
+
+    /*
+     * Clamp is just a min+max, easily supported by most host
+     * vector operations -- we already have such an expansion in
+     * translate-sve.c for a single output.
+     * TODO: Add support in gvec for multiple simultaneous output,
+     * and/or copy to temporary upon overlap.
+     */
+    vl = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->zd),
+                       vec_full_reg_offset(s, a->zn),
+                       vec_full_reg_offset(s, a->zm),
+                       vl, vl, a->n, fn[a->esz]);
+    return true;
+}
+
+static gen_helper_gvec_3 * const sclamp_fns[] = {
+    gen_helper_sme2_sclamp_b,
+    gen_helper_sme2_sclamp_h,
+    gen_helper_sme2_sclamp_s,
+    gen_helper_sme2_sclamp_d,
+};
+TRANS(SCLAMP, do_clamp, a, sclamp_fns)
+
+static gen_helper_gvec_3 * const uclamp_fns[] = {
+    gen_helper_sme2_uclamp_b,
+    gen_helper_sme2_uclamp_h,
+    gen_helper_sme2_uclamp_s,
+    gen_helper_sme2_uclamp_d,
+};
+TRANS(UCLAMP, do_clamp, a, uclamp_fns)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index dc762e262c..ca73a58a68 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -859,3 +859,20 @@ UZP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 1    \
                 &zzz_e zd=%zd_ax2
 UZP_2           11000001 00    1 zm:5 110101 zn:5 .... 1    \
                 &zzz_e zd=%zd_ax2 esz=4
+
+&zzz_en         zd zn zm esz n
+
+FCLAMP          11000001 esz:2 1 zm:5 110000 zn:5 .... 0    \
+                &zzz_en zd=%zd_ax2 n=2
+FCLAMP          11000001 esz:2 1 zm:5 110010 zn:5 ...0 0    \
+                &zzz_en zd=%zd_ax4 n=4
+
+SCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 0    \
+                &zzz_en zd=%zd_ax2 n=2
+SCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 0    \
+                &zzz_en zd=%zd_ax4 n=4
+
+UCLAMP          11000001 esz:2 1 zm:5 110001 zn:5 .... 1    \
+                &zzz_en zd=%zd_ax2 n=2
+UCLAMP          11000001 esz:2 1 zm:5 110011 zn:5 ...0 1    \
+                &zzz_en zd=%zd_ax4 n=4
-- 
2.43.0


