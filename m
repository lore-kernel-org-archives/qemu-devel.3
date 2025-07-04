Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF762C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhRC-00062u-LQ; Fri, 04 Jul 2025 10:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM4-0004VJ-PQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:34 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLz-00085H-CO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:32 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-60bd30dd387so544955eaf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639124; x=1752243924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsCup+gJOZBgnqsU6/l1yujbu9XY09yoYQpIK5Jy3OY=;
 b=f3zzvXMc/vNmrUcVTJ9ccD2I6shxrEkAynztvCPm2rN1+108hynApNbpCkxFj6oCen
 3qK6YkAfqQkTLHePyxC5lJOsLcpfuulKEPc+kYg7oMxPoP4oETRQSdghRIOvltpHEMOG
 K7QVxDwDiv5tw/70qY+/qc2s7zTpTqLhRuH/vouDENkGqgoc7gQ66j8U9gQ723GBIL2/
 UKStu6CqTrX6KZGRiX3WlE1VXQi+wnzHslJm0JNZm9JJdnjlgTVOAvteXs04WGnYlJzC
 P5u7SoaxuXNdTvE0lzOPiAsdblp0EXS13F2hofAnKgoWW4yYZAMjGNJHeOiUAsVQbDFb
 vwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639124; x=1752243924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsCup+gJOZBgnqsU6/l1yujbu9XY09yoYQpIK5Jy3OY=;
 b=RhcozH9NKGDRJCSNu3ELYEUKGJ3NNcZidhOROkdFp6qhKgeG9Fai58aL0vQBlWnrIK
 E2zaVsa96NAf+r3m9eOkm9/f7HeCSyjtXyL2nfqheuaYMjUtUCIW8EZQaT1JrhaAmPF0
 lIY2vIATFx5AXX5NdHR8XP6O7xqpdR5qE4wCLAlK5onybMVG5zaJYMxIrDjLWgi2FkI9
 B6EfiOQo8+k8kx15STzoVkKqhejYBtMRCHWqNhhzi3/GAvAvMpglNA142XY998xjD/zx
 bL+AyZfPPCodCQNZl5A2wXaC9Q7MWAfCiY0WspV7ozRVzRL61QWppW1hOvDEd1+SCN5G
 jy4Q==
X-Gm-Message-State: AOJu0Yz+Ooozet/qXon4GPpJFcnodycVmCfkKsjYknxNksbvlrLGvLbP
 C4BkcEV943+NJyEWhPRjlH0ycqbsh/zq2QcxuAbEgL1CXmyTe4zfj0uL/+oHTyAQebDPa3iL2G9
 PlPpDaAo=
X-Gm-Gg: ASbGnct76O1rdeUPyly4kWjZPUdFuanOkBQMA6gwkyU+RxSLCY1DFqCKKZLu8c9ZtWk
 dxFSzBipB+z2+NGoklOCmzxDgPOKgt2/osx9cmmqdzW2qNxlxUJ+NAnAH1iNPN8tKka6HYfxBLJ
 Wk+wn3hqMr2iDFyeS44FrHoLl+LwDidJIYDSqyoC9rywtjkS6Cz9Uz63UhoeTG3TPRK8lB7cD0r
 /zv8VRJX0u+HiCVJJdv2AignJPC1I4G6+zumeu3Bsh9uCiqPnO38RGqEed5tadjN0YQMt3u1wmi
 HgI16RAah1l8HUVQXGelPMz5Amf7Z67Co02YMUwSOOFj6bFuQ57xUP4TF+IS0zUtx12CxeTFpBV
 4ZEyydUdxXPabuF0QLa0IrlT1QaXfBRrYN7reV7j8kAXE0hjn
X-Google-Smtp-Source: AGHT+IH6B77nrQxWj8cnGybkz92pJ7wjnYcIRVyzf17wJjUXqn7+RDmJxjklM9EASMtqwAZm94RQKQ==
X-Received: by 2002:a05:6820:2108:b0:611:f241:b8f5 with SMTP id
 006d021491bc7-6138fd8960fmr1969094eaf.5.1751639124321; 
 Fri, 04 Jul 2025 07:25:24 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 066/108] target/arm: Implement SME2 FCLAMP, SCLAMP, UCLAMP
Date: Fri,  4 Jul 2025 08:20:29 -0600
Message-ID: <20250704142112.1018902-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 15 +++++++
 target/arm/tcg/sme_helper.c    | 56 +++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 75 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      | 17 ++++++++
 4 files changed, 163 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 06b95da3c3..78ba3d1f20 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -298,3 +298,18 @@ DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
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
index cf0e655bdd..8a1f9fbf3d 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -2062,3 +2062,59 @@ UZP4(sme2_uzp4_d, uint64_t, )
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
+/*
+ * Note the argument ordering to minnum and maxnum must match
+ * the ARM pseudocode so that NaNs are propagated properly.
+ */
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
+            *dd = TYPE##_minnum(TYPE##_maxnum(nn, *dd, fpst), mm, fpst); \
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
index d52ccf2ac5..99e4056316 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1547,3 +1547,78 @@ static gen_helper_gvec_3 * const uzp2_fns[] = {
     gen_helper_sme2_uzp2_q,
 };
 TRANS_FEAT(UZP_2, aa64_sme2, do_zipuzp_2, a, uzp2_fns)
+
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
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    /* This insn uses MO_8 to encode BFloat16. */
+    if (a->esz == MO_8 && !dc_isar_feature(aa64_sme_b16b16, s)) {
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
+    if (!dc_isar_feature(aa64_sme2, s)) {
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
index c1f73d9f63..47adcb5a15 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -860,3 +860,20 @@ UZP_2           11000001 esz:2 1 zm:5 110100 zn:5 .... 1    \
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


