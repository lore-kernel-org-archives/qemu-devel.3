Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799CDC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 20:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg86z-0003eY-OY; Thu, 06 Feb 2025 15:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83s-00082e-Kt
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:21 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tg83j-0001Ba-D6
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 15:01:18 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2f9cd9601b8so2318162a91.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738872060; x=1739476860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rib88K3Vq9r86qb9m6rKUTkXJDCx+ZO4Ay+fuRWmhO4=;
 b=iXWTIvOQVQIMlnRKcFL5Y4xb8qYRLoL5I+qAOFvuXppPpneKfEVxfGsej9iVcgLjy9
 scLc1Up3KoLFduT0v8VUiDMu7TFe1ubdFw600agDTopAZpR9idPKVT6KSZOl64G55oTi
 8zjNojbYJijju1i7cmJ1HiY+G+5cT1fooLNdYrgQv1jC9KvMAe89T5cpmbXbJwurBgBj
 CnBuDlFMoet5cg8q8u+9E4imu+7jxAIa3Nitqy3HSB+FldGOV8XKY2SPCFNdWupZX6vz
 nWB+4b8FK4XRsJKg3Ono4qbpcwDVpa1nDdRFe36vD75EezH3+Eb8TLlFnpd6RHxraQez
 +2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738872060; x=1739476860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rib88K3Vq9r86qb9m6rKUTkXJDCx+ZO4Ay+fuRWmhO4=;
 b=JILrvaNrDoYd0QpfNOnW/EUYOybbsVTThHJHmd70JTKuxfdfXfw3o29wrWWs1JnHOR
 1ntc9MbOnWGADX90Q7ePxP4hrFwmGTPB8H2GdJt+xcxzsrnidkJWPTlKIQ2t+6VkRE9o
 cOzbZHbZF7LFAHghNyctkXZOU+i8KcqtCNiS3d19jmFxdf41PwMQpM3MxlcOIFvCXrzF
 Q9yWuWiF3GIGHmvILEznXpW9JNDyF/Lm7Mw0NQnM0j74ICO2wUq/Hf+jpI64pupFXhVI
 72kLkPfHhG1LTPBqFthRG3jpWTNvK1Vcpz30bz4m/0n/1dGnFHl1GYrJuRVhzClAkMzm
 gCqQ==
X-Gm-Message-State: AOJu0Yw0+43sZfsFSlxielrs3fyw8giPtlXydltjX6sjmTCcvoKtNuMa
 MDHcVWsm/LwlbNUI1/7PjEaYt7H30jnf2lb1DNWEwJDUdhXxBBassTuTFEgsQip0h+KLTzSpCDQ
 c
X-Gm-Gg: ASbGncsAyDCZWyyAuSqslKa4K/nrpwjaVKc7NGIKR97xsv3CRm4uUBWVZkJxO6RqFuM
 aVq4WfKPXMmWtc7sAfMLusXTC5nRBlzSr6kcAN+fwLuvZ+UGFHBHnCAIkErjU2ZLaLmcEhLWhZz
 ePoK1jJYdJRx15l8EtBQ8kEis4MaZ8KORxlp2POhQBy5VEqrPYTGKV/iD+bRNJxzWZz34bKqKda
 GbmgvgVmamU455EsLqEmOI1kS1Zq1sj8KcxvCoqMzL3Y4v+hPQozx/fl0pWJLpxNeyKQMLZQ9O7
 rtC99YFtcLKBPWOxSQTu73SurpyJ/i6jQGWv1laC+jvcqRk=
X-Google-Smtp-Source: AGHT+IEy++1Q1IbH4pWGbalvvGkHUBEQqesgaIeNFVbrDb74zdVc680Cn6uIjPhsoU1MoQcqyTHvFg==
X-Received: by 2002:a17:90b:3596:b0:2ee:b2e6:4276 with SMTP id
 98e67ed59e1d1-2fa243e9aaamr497446a91.27.1738872060324; 
 Thu, 06 Feb 2025 12:01:00 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa09b3ee24sm1808857a91.36.2025.02.06.12.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 12:01:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 59/61] target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
Date: Thu,  6 Feb 2025 11:57:13 -0800
Message-ID: <20250206195715.2150758-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206195715.2150758-1-richard.henderson@linaro.org>
References: <20250206195715.2150758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 target/arm/tcg/helper-sme.h    | 15 +++++++++
 target/arm/tcg/sme_helper.c    | 52 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 56 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 17 +++++++++++
 4 files changed, 140 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index a4216c8f3b..6f66e84f38 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -293,3 +293,18 @@ DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
index a88b602314..850d130512 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1949,3 +1949,55 @@ UZP4(sme2_uzp4_d, uint64_t, )
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
index c449760add..e71e3ec8e3 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1464,3 +1464,59 @@ static gen_helper_gvec_3 * const uzp2_fns[] = {
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
+
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (!(a->esz == MO_8
+          ? dc_isar_feature(aa64_sme2_b16b16, s)
+          : dc_isar_feature(aa64_sme2, s))) {
+        return false;
+    }
+
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        TCGv_ptr fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_A64_F16 : FPST_A64);
+
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zm),
+                           fpst, svl, svl, a->n, fn[a->esz]);
+    }
+    return true;
+}
+
+static bool do_clamp(DisasContext *s, arg_zzz_en *a,
+                     gen_helper_gvec_3 * const fn[4])
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zm),
+                           svl, svl, a->n, fn[a->esz]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_3 * const sclamp_fns[] = {
+    gen_helper_sme2_sclamp_b,
+    gen_helper_sme2_sclamp_h,
+    gen_helper_sme2_sclamp_s,
+    gen_helper_sme2_sclamp_d,
+};
+TRANS_FEAT(SCLAMP, aa64_sme2, do_clamp, a, sclamp_fns)
+
+static gen_helper_gvec_3 * const uclamp_fns[] = {
+    gen_helper_sme2_uclamp_b,
+    gen_helper_sme2_uclamp_h,
+    gen_helper_sme2_uclamp_s,
+    gen_helper_sme2_uclamp_d,
+};
+TRANS_FEAT(UCLAMP, aa64_sme2, do_clamp, a, uclamp_fns)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index bd485a26f0..9bbf89b15c 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -855,3 +855,20 @@ UZP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 1    \
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


