Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98ABC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83B-0005Ng-P2; Sat, 21 Jun 2025 19:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82N-00029f-PT
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:20 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82L-00053U-KQ
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2101864b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550056; x=1751154856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qB2fCZyqKRVWX4yWtUbC+1sPNjKEGeBmoyOL1s1O+Ig=;
 b=AVh/19A4YEw9k0iTvbKNernFBMCxgNnYkvUBDliEG2WY/PNTx6Kl4RU3VkoNEMCfUi
 SbmSykPYDAlNVINRSiUpWpdKfLFgpzFUoB3I8yq4AuZ89y/BEb81Y4SS2k4KjHspIN4w
 1QkWfidOEhSmFKLAOM8E1dLAckFDTJL9Eohrrr0g1AGPc2snTVglZ/2iLg5pdbmNY40o
 SUxuBiMjeoeaNvy++l7ntytAMGcsEZTTLen5XPMq9MWeBQwkgoBQ7YIcuU/j11BUjtim
 Vi5opUAMm4ICc1FeMyMxH5i7PaDfBquSDuV3kesPpIU/3VIwSotXtuy3eR5oFkN2/U01
 KSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550056; x=1751154856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qB2fCZyqKRVWX4yWtUbC+1sPNjKEGeBmoyOL1s1O+Ig=;
 b=nab3WKju/gHwrj+eydIUme8jCz+wgecHIkuW4G+IGTeOvcQATQyLwEsS0Xr3qwJKOA
 FZCM+EgWeX0UOgbkn8dK0eqmGhwlirhKrsIceci0F3KvDzxctoFTsLi7GJlwHAE56DSh
 TbWADhM+V79g9kKragcqPJoGdw+WVtoJX7WcMCZlqJjIDRG2276qla3Gqre6uKtkET1W
 VLkc9HIQFYducdHNr3bbpWb5izTO5JmXd0UB2o1fPziNT/TY8B/IRj/clhCjQysQgAIe
 1Qc7jqN13vs+lNhPRZC69DwDTtCSWetlEds6z7vFF5Dpc3bpzh0YGBBhQWKDFOSR5HtP
 Vprg==
X-Gm-Message-State: AOJu0YwK/4OwQZMfxxNCY5YKxEZFakhd+Iz6NIA87QA+sMv/rln8JH5B
 98QRnZFRgGjhiFz1gZ1COt0YiC+LjTlj6iLZdoRi/aOsP2HR854k9WcODi1m7BRzle57Qrm1WjA
 YgUn0Ex4=
X-Gm-Gg: ASbGncshfAmOHzBf7OiHaC2gsqZsiDfLg2pY0fG/AIdvQEIPySMvJyUy55dC0U46K6z
 4KDJsdFBYH3I2RWxEaHsQV4Mtm3xq3491CnIX3oUii6ar/xVbY3qYopZMPvRq/n2s3KUgsb1d1X
 bYWO2pxWephnBZCAXmiDeIt5o17i9y1sIvhG1QHqygk/Vt3ypckknSiJULy1mu+1YOIEZeRUtvP
 YNb8g3+vAeQp51TAS8WToK97N1658mNT1jc+UHclp+HgTZvdlX6EDj5qQbbJQiMcI2V3R71QTi/
 oabylOOm2KFRTftP09cmqNeHhPuic6Y3aITM1qyJZDqxO6gFmWzIUtQkj7ubp+iRYGrnjEsJLMy
 RPj7d7VlM5bbEZyv4lqfRZE+iVlhWECk=
X-Google-Smtp-Source: AGHT+IERe/v5znRqwC9KMASOBj+GQP3uh2fANNkZbbv67QscsFax1Jp74jf3hxR9aFlfzB8s2FD4Ng==
X-Received: by 2002:a05:6a21:9996:b0:215:ef08:5555 with SMTP id
 adf61e73a8af0-22026c2ecc2mr10974814637.11.1750550056114; 
 Sat, 21 Jun 2025 16:54:16 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 058/101] target/arm: Implement SME2 SQCVT, UQCVT, SQCVTU
Date: Sat, 21 Jun 2025 16:49:54 -0700
Message-ID: <20250621235037.74091-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/arm/tcg/helper-sme.h    |  20 ++++++
 target/arm/tcg/sme_helper.c    | 116 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  35 ++++++++++
 target/arm/tcg/sme.decode      |  22 +++++++
 4 files changed, 193 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 04db920299..cd8d5ea3a7 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -220,3 +220,23 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_w, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqcvt_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvt_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtu_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtu_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvt_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvt_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtu_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqcvtn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvtn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvtn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtun_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqcvtun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 2a6635010a..23dd03c77f 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1532,6 +1532,64 @@ void HELPER(sme2_fcvt_n)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define SQCVT2(NAME, TW, TN, HW, HN, SAT)                       \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(s0[HW(i)]);                              \
+        d[HN(i) + n] = SAT(s1[HW(i)]);                          \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVT2(sme2_sqcvt_sh, int32_t, int16_t, H4, H2, do_ssat_h)
+SQCVT2(sme2_uqcvt_sh, uint32_t, uint16_t, H4, H2, do_usat_h)
+SQCVT2(sme2_sqcvtu_sh, int32_t, uint16_t, H4, H2, do_usat_h)
+
+#undef SQCVT2
+
+#define SQCVT4(NAME, TW, TN, HW, HN, SAT)                       \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(s0[HW(i)]);                              \
+        d[HN(i) + n] = SAT(s1[HW(i)]);                          \
+        d[HN(i) + 2 * n] = SAT(s2[HW(i)]);                      \
+        d[HN(i) + 3 * n] = SAT(s3[HW(i)]);                      \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVT4(sme2_sqcvt_sb, int32_t, int8_t, H4, H2, do_ssat_b)
+SQCVT4(sme2_uqcvt_sb, uint32_t, uint8_t, H4, H2, do_usat_b)
+SQCVT4(sme2_sqcvtu_sb, int32_t, uint8_t, H4, H2, do_usat_b)
+
+SQCVT4(sme2_sqcvt_dh, int64_t, int16_t, H8, H2, do_ssat_h)
+SQCVT4(sme2_uqcvt_dh, uint64_t, uint16_t, H8, H2, do_usat_h)
+SQCVT4(sme2_sqcvtu_dh, int64_t, uint16_t, H8, H2, do_usat_h)
+
+#undef SQCVT4
+
 /* Convert and interleave */
 void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
@@ -1563,6 +1621,64 @@ void HELPER(sme2_fcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define SQCVTN2(NAME, TW, TN, HW, HN, SAT)                      \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(2 * i + 0)] = SAT(s0[HW(i)]);                      \
+        d[HN(2 * i + 1)] = SAT(s1[HW(i)]);                      \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVTN2(sme2_sqcvtn_sh, int32_t, int16_t, H4, H2, do_ssat_h)
+SQCVTN2(sme2_uqcvtn_sh, uint32_t, uint16_t, H4, H2, do_usat_h)
+SQCVTN2(sme2_sqcvtun_sh, int32_t, uint16_t, H4, H2, do_usat_h)
+
+#undef SQCVTN2
+
+#define SQCVTN4(NAME, TW, TN, HW, HN, SAT)                      \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(4 * i + 0)] = SAT(s0[HW(i)]);                      \
+        d[HN(4 * i + 1)] = SAT(s1[HW(i)]);                      \
+        d[HN(4 * i + 2)] = SAT(s2[HW(i)]);                      \
+        d[HN(4 * i + 3)] = SAT(s3[HW(i)]);                      \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQCVTN4(sme2_sqcvtn_sb, int32_t, int8_t, H4, H1, do_ssat_b)
+SQCVTN4(sme2_uqcvtn_sb, uint32_t, uint8_t, H4, H1, do_usat_b)
+SQCVTN4(sme2_sqcvtun_sb, int32_t, uint8_t, H4, H1, do_usat_b)
+
+SQCVTN4(sme2_sqcvtn_dh, int64_t, int16_t, H8, H2, do_ssat_h)
+SQCVTN4(sme2_uqcvtn_dh, uint64_t, uint16_t, H8, H2, do_usat_h)
+SQCVTN4(sme2_sqcvtun_dh, int64_t, uint16_t, H8, H2, do_usat_h)
+
+#undef SQCVTN4
+
 /* Expand and convert */
 void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a96d5ace43..96838b19e7 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1312,3 +1312,38 @@ TRANS_FEAT(FRINTM, aa64_sme2, do_zz_fpst, a, float_round_down,
            FPST_A64, gen_helper_gvec_vrint_rm_s)
 TRANS_FEAT(FRINTA, aa64_sme2, do_zz_fpst, a, float_round_ties_away,
            FPST_A64, gen_helper_gvec_vrint_rm_s)
+
+static bool do_zz(DisasContext *s, arg_zz_n *a, int data,
+                  gen_helper_gvec_2 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+
+        for (int i = 0, n = a->n; i < n; ++i) {
+            tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd + i),
+                               vec_full_reg_offset(s, a->zn + i),
+                               svl, svl, data, fn);
+        }
+    }
+    return true;
+}
+
+TRANS_FEAT(SQCVT_sh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvt_sh)
+TRANS_FEAT(UQCVT_sh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvt_sh)
+TRANS_FEAT(SQCVTU_sh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtu_sh)
+
+TRANS_FEAT(SQCVT_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvt_sb)
+TRANS_FEAT(UQCVT_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvt_sb)
+TRANS_FEAT(SQCVTU_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtu_sb)
+
+TRANS_FEAT(SQCVT_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvt_dh)
+TRANS_FEAT(UQCVT_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvt_dh)
+TRANS_FEAT(SQCVTU_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtu_dh)
+
+TRANS_FEAT(SQCVTN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtn_sb)
+TRANS_FEAT(UQCVTN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvtn_sb)
+TRANS_FEAT(SQCVTUN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_sb)
+
+TRANS_FEAT(SQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtn_dh)
+TRANS_FEAT(UQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvtn_dh)
+TRANS_FEAT(SQCVTUN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index dffd4f5ff8..491c6231ea 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -725,6 +725,8 @@ FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
+@zz_1x4         ........ ... ..... ...... ..... zd:5        \
+                &zz_n n=1 zn=%zn_ax4
 @zz_2x1         ........ ... ..... ...... zn:5  .....       \
                 &zz_n n=1 zd=%zd_ax2
 @zz_2x2         ........ ... ..... ...... .... . .....      \
@@ -759,3 +761,23 @@ FRINTM          11000001 101 01010 111000 ....0 ....0       @zz_2x2
 FRINTM          11000001 101 11010 111000 ...00 ...00       @zz_4x4
 FRINTA          11000001 101 01100 111000 ....0 ....0       @zz_2x2
 FRINTA          11000001 101 11100 111000 ...00 ...00       @zz_4x4
+
+SQCVT_sh        11000001 001 00011 111000 ....0 .....       @zz_1x2
+UQCVT_sh        11000001 001 00011 111000 ....1 .....       @zz_1x2
+SQCVTU_sh       11000001 011 00011 111000 ....0 .....       @zz_1x2
+
+SQCVT_sb        11000001 001 10011 111000 ...00 .....       @zz_1x4
+UQCVT_sb        11000001 001 10011 111000 ...01 .....       @zz_1x4
+SQCVTU_sb       11000001 011 10011 111000 ...00 .....       @zz_1x4
+
+SQCVT_dh        11000001 101 10011 111000 ...00 .....       @zz_1x4
+UQCVT_dh        11000001 101 10011 111000 ...01 .....       @zz_1x4
+SQCVTU_dh       11000001 111 10011 111000 ...00 .....       @zz_1x4
+
+SQCVTN_sb       11000001 001 10011 111000 ...10 .....       @zz_1x4
+UQCVTN_sb       11000001 001 10011 111000 ...11 .....       @zz_1x4
+SQCVTUN_sb      11000001 011 10011 111000 ...10 .....       @zz_1x4
+
+SQCVTN_dh       11000001 101 10011 111000 ...10 .....       @zz_1x4
+UQCVTN_dh       11000001 101 10011 111000 ...11 .....       @zz_1x4
+SQCVTUN_dh      11000001 111 10011 111000 ...10 .....       @zz_1x4
-- 
2.43.0


