Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D4AC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwmC-0007Uu-6z; Wed, 02 Jul 2025 08:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjV-0004Lf-Mh
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:41 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjH-00026j-5Y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:34 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2f3dab2a2a9so919477fac.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459901; x=1752064701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCFPCu/gN8JqS1B0Jg8H+7PKNfaTWdrPwXJJawyLt9I=;
 b=GbPQIWo2XJfqPOBEefywrsKKI5kK3Y74W31CtWAULKQHFrWdxfFwcodKfgXiMgHPVf
 /TV3ge2W+cidABKy35J7e+LRoJDLNqH0DJXOn0hXwwUgSzlJoCLjI1SVEdCPFihOOgso
 7ATr7y6XlpKjcN+PFZ+gNnzRTdQ+gblUbsn0j59mfEVFDtyDGFpsYhwZUBDFuDtZpVUf
 QmWLl8TMeqPBUkGEyWUmo5pS8sv/IrAY6Qt/Hi3xsI7eYUxEM9X0Kv1A0/rsAL4DWDu6
 odTQRIDsmbSXal/Ahc+RvH2mm0WdnWlnQgPvBj5OxRKSvfuaAC6PH+1gSCioElEB3Q9I
 Lngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459901; x=1752064701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VCFPCu/gN8JqS1B0Jg8H+7PKNfaTWdrPwXJJawyLt9I=;
 b=Bbnbjz779OzuvkTI36p9uZLNL3iq/OIlIFeq50BD8AlqzCyAxhnkA+ZjKImSty6N0w
 KDVHkRYTBF6VZsc/xdAZcRvB3rzR1za7Qr5evbDtdafGsb0ALYZBYUJSBYzSGwtPp3kM
 bxWZSkGO5yT7XmxoktbZum6ZL3GNzC0lymocAZtskVBNbQgOQJJS7e9WzokUbOj7DgRb
 wl/IC65Wxuzy8s1zQAF+FyCCjba443Le1QG3jgGoVjuEWdVlaPxZf4O2WOU3KN5doD33
 GLsyU3fOD6taI0nZsUQyf1aW2aBbuyj4Zo4m6hMzpCXdwnQyak0XCieq2Jyfkz5bTb+V
 GjfQ==
X-Gm-Message-State: AOJu0YxRQOIxmJBQin8ifNdCcvAugVjz6HBjhA8mk5XEFlu2F1qLS42J
 9BUrY++lQm6g5RJxOOSlq57xhFmeJ1GGW73Ke8PkuVR78n/IBsJjhGmz+7fFs1dzuHA5pFm75bR
 rSlY95lU=
X-Gm-Gg: ASbGnctkrR/dgIv+fqjSVoKZs5mJpV6gJDBW/8NVvr9wZ4SGXwHKBeqrv6TNLAyxBKE
 4iD5hWHCFhtxwQJaNLTXeABTS5f9NBWHCj5toAXPi7DMgyDtRbMfhQk+0E8XvSMDYpi+oy7XYQF
 h7MmYXK/au+aXVqOL7DW0afD3hkbF8rOHbaRv7Yp6r03zsy+b1V7meOqvxXIczJGRgkepINXPCU
 TPNE6wMnWtXSWiZJLimiIV0SKRBHB8okmmS+SL45plN2vfA8AmzhEFsFqvCaybPsbOZV7K+mdvN
 1M9+vPust597brqBjgpvb3rQsfHLDU97fVwqzXmkMShiMCPzikU+bOnm8Nk4v7WpSh463Q==
X-Google-Smtp-Source: AGHT+IHuLtHCErnnYYrAV/BGccdQ6mSxRO8tomU2TwjtfLRtdl8EjW6Cz26Jf7DPmPFfz/I9h7qUyQ==
X-Received: by 2002:a05:6871:2203:b0:2d6:49df:a649 with SMTP id
 586e51a60fabf-2f5a8b81a91mr1934506fac.31.1751459900853; 
 Wed, 02 Jul 2025 05:38:20 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 54/97] target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
Date: Wed,  2 Jul 2025 06:33:27 -0600
Message-ID: <20250702123410.761208-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    |  20 ++++++
 target/arm/tcg/sme_helper.c    | 120 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  33 +++++++++
 target/arm/tcg/sme.decode      |  37 ++++++++++
 4 files changed, 210 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 7e21f1095a..97428bcd6b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -266,3 +266,23 @@ DEF_HELPER_FLAGS_3(sme2_uzp4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 83646a3665..987880e310 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1619,6 +1619,66 @@ SQCVT4(sme2_sqcvtu_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVT4
 
+#define SQRSHR2(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i) + n] = SAT(RSHR(s1[HW(i)], shift));             \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR2(sme2_sqrshr_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_h)
+SQRSHR2(sme2_uqrshr_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_h)
+SQRSHR2(sme2_sqrshru_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_h)
+
+#undef SQRSHR2
+
+#define SQRSHR4(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i) + n] = SAT(RSHR(s1[HW(i)], shift));             \
+        d[HN(i) + 2 * n] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(i) + 3 * n] = SAT(RSHR(s3[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR4(sme2_sqrshr_sb, int32_t, int8_t, H4, H2, do_srshr, do_ssat_b)
+SQRSHR4(sme2_uqrshr_sb, uint32_t, uint8_t, H4, H2, do_urshr, do_usat_b)
+SQRSHR4(sme2_sqrshru_sb, int32_t, uint8_t, H4, H2, do_srshr, do_usat_b)
+
+SQRSHR4(sme2_sqrshr_dh, int64_t, int16_t, H8, H2, do_srshr, do_ssat_h)
+SQRSHR4(sme2_uqrshr_dh, uint64_t, uint16_t, H8, H2, do_urshr, do_usat_h)
+SQRSHR4(sme2_sqrshru_dh, int64_t, uint16_t, H8, H2, do_srshr, do_usat_h)
+
+#undef SQRSHR4
+
 /* Convert and interleave */
 void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
@@ -1708,6 +1768,66 @@ SQCVTN4(sme2_sqcvtun_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVTN4
 
+#define SQRSHRN2(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(2 * i + 0)] = SAT(RSHR(s0[HW(i)], shift));         \
+        d[HN(2 * i + 1)] = SAT(RSHR(s1[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHRN2(sme2_sqrshrn_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_h)
+SQRSHRN2(sme2_uqrshrn_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_h)
+SQRSHRN2(sme2_sqrshrun_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_h)
+
+#undef SQRSHRN2
+
+#define SQRSHRN4(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(4 * i + 0)] = SAT(RSHR(s0[HW(i)], shift));         \
+        d[HN(4 * i + 1)] = SAT(RSHR(s1[HW(i)], shift));         \
+        d[HN(4 * i + 2)] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(4 * i + 3)] = SAT(RSHR(s3[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHRN4(sme2_sqrshrn_sb, int32_t, int8_t, H4, H1, do_srshr, do_ssat_b)
+SQRSHRN4(sme2_uqrshrn_sb, uint32_t, uint8_t, H4, H1, do_urshr, do_usat_b)
+SQRSHRN4(sme2_sqrshrun_sb, int32_t, uint8_t, H4, H1, do_srshr, do_usat_b)
+
+SQRSHRN4(sme2_sqrshrn_dh, int64_t, int16_t, H8, H2, do_srshr, do_ssat_h)
+SQRSHRN4(sme2_uqrshrn_dh, uint64_t, uint16_t, H8, H2, do_urshr, do_usat_h)
+SQRSHRN4(sme2_sqrshrun_dh, int64_t, uint16_t, H8, H2, do_srshr, do_usat_h)
+
+#undef SQRSHRN4
+
 /* Expand and convert */
 void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index de9545ee6d..d413efd20e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1474,3 +1474,36 @@ static gen_helper_gvec_2 * const uzp4_fns[] = {
     gen_helper_sme2_uzp4_q,
 };
 TRANS_FEAT(UZP_4, aa64_sme2, do_zipuzp_4, a, uzp4_fns)
+
+static bool do_zz_rshr(DisasContext *s, arg_rshr *a, gen_helper_gvec_2 *fn)
+{
+    if (sve_access_check(s)) {
+        int vl = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vl, vl, a->shift, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SQRSHR_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_sh)
+TRANS_FEAT(UQRSHR_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_sh)
+TRANS_FEAT(SQRSHRU_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_sh)
+
+TRANS_FEAT(SQRSHR_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_sb)
+TRANS_FEAT(SQRSHR_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_dh)
+TRANS_FEAT(UQRSHR_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_sb)
+TRANS_FEAT(UQRSHR_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_dh)
+TRANS_FEAT(SQRSHRU_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_sb)
+TRANS_FEAT(SQRSHRU_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_dh)
+
+TRANS_FEAT(SQRSHRN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sh)
+TRANS_FEAT(UQRSHRN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sh)
+TRANS_FEAT(SQRSHRUN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sh)
+
+TRANS_FEAT(SQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sb)
+TRANS_FEAT(SQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_dh)
+TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
+TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
+TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
+TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 81783b4705..05d513efba 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -811,3 +811,40 @@ UZP_4           11000001 esz:2 1 10110 111000 ...00 ... 10   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 UZP_4           11000001 001     10111 111000 ...00 ... 10   \
                 &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
+
+### SME2 Multi-vector SVE Constructive Binary
+
+&rshr           zd zn shift
+
+%rshr_sh_shift  16:4 !function=rsub_16
+%rshr_sb_shift  16:5 !function=rsub_32
+%rshr_dh_shift  22:1 16:5 !function=rsub_64
+
+@rshr_sh        ........ .... .... ...... ..... zd:5        \
+                &rshr zn=%zn_ax2 shift=%rshr_sh_shift
+@rshr_sb        ........ ... ..... ...... ..... zd:5        \
+                &rshr zn=%zn_ax4 shift=%rshr_sb_shift
+@rshr_dh        ........ ... ..... ...... ..... zd:5        \
+                &rshr zn=%zn_ax4 shift=%rshr_dh_shift
+
+SQRSHR_sh       11000001 1110 .... 110101 ....0 .....       @rshr_sh
+UQRSHR_sh       11000001 1110 .... 110101 ....1 .....       @rshr_sh
+SQRSHRU_sh      11000001 1111 .... 110101 ....0 .....       @rshr_sh
+
+SQRSHR_sb       11000001 011 ..... 110110 ...00 .....       @rshr_sb
+SQRSHR_dh       11000001 1.1 ..... 110110 ...00 .....       @rshr_dh
+UQRSHR_sb       11000001 011 ..... 110110 ...01 .....       @rshr_sb
+UQRSHR_dh       11000001 1.1 ..... 110110 ...01 .....       @rshr_dh
+SQRSHRU_sb      11000001 011 ..... 110110 ...10 .....       @rshr_sb
+SQRSHRU_dh      11000001 1.1 ..... 110110 ...10 .....       @rshr_dh
+
+SQRSHRN_sh      01000101 1011 .... 001010 ....0 .....       @rshr_sh
+UQRSHRN_sh      01000101 1011 .... 001110 ....0 .....       @rshr_sh
+SQRSHRUN_sh     01000101 1011 .... 000010 ....0 .....       @rshr_sh
+
+SQRSHRN_sb      11000001 011 ..... 110111 ...00 .....       @rshr_sb
+SQRSHRN_dh      11000001 1.1 ..... 110111 ...00 .....       @rshr_dh
+UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
+UQRSHRN_dh      11000001 1.1 ..... 110111 ...01 .....       @rshr_dh
+SQRSHRUN_sb     11000001 011 ..... 110111 ...10 .....       @rshr_sb
+SQRSHRUN_dh     11000001 1.1 ..... 110111 ...10 .....       @rshr_dh
-- 
2.43.0


