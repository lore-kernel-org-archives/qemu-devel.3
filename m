Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A782CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlYk-0006lD-9r; Wed, 20 May 2026 14:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYi-0006fz-3J
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:20 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYf-0000SP-Nw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:19 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-368f25ff4c4so2746079a91.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301336; x=1779906136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIbMN4r3U2SxBsEoDmJt1f/jmTRyiQ3ShGW/a86bR/4=;
 b=Z3FXBrqcRbraN7GjbZG7GvfKGIsTy364wExwYXfo7i4YnEVcqCvoB5QSwa7042FUEu
 Qm2DV+OzUxhlARhqK3Wa7mYc8RQC1H7teLbHzlEj0zWquDWDIyzjT5psvUdUEIDY8WfP
 X0u8KiGKbFSYsZYxNWLyJoenLji1YcLABZXzfvgnSd7XYyxjtn9pms0u5lt7xfO1E9OJ
 iQjdDY5vydUljhlJDp4MJOWHItjIy7D0fNOAlhPL/Hqs7cJQ92HrSQ3KN0y0977aCq8E
 IcitOfYnqEDBlhoqv9DWcis0tGmCMoVCeRR0zeHzYNDE6d9uwP/9HBUkp/jdt0q5Q7R6
 2DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301336; x=1779906136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIbMN4r3U2SxBsEoDmJt1f/jmTRyiQ3ShGW/a86bR/4=;
 b=iWkzFrWqHNg8z2WUOn88ZJAMmZx9CaJ5NWXe7hRvdt5TPO/1XZegBKw/IHaEQLcGal
 eSYmK4K7uwJXB2jCcKnFRcMQnbGAiDUptKIpYzS6XsuFvURoCuxR4g+bR2gA0XraXjhZ
 7/e6mldrmJuzL8ZIuBlWPXDgZkgM6VmfE1A06geTML7LYbsq6FQ1VWJEzVRyFtXaR8v+
 z1vCuDsKWj6sv93Iv93HXDXvd9ODRXmYSJIIY5c78tutK86gaCDXt8ljBnwUgkjnl5mU
 nQI/vL4s40hJMd2s+azCRt6lWNV7e8TtR6oA654NhKS7MnmDpsl4qSzQwuz8reZBfoYm
 TFcg==
X-Gm-Message-State: AOJu0YylSOGuyftTgTIiV170Szo9RgooRmuYg06ueLziUmMMdEnSoc6g
 69TEOBrU0V8/e9NKe1DeOCt+a0rqARYNACHqmTpsmCy2hlaDztx3UkGgWHjVvuizVcTKxeHJEGH
 835PAPkQ=
X-Gm-Gg: Acq92OHu966PeJ0SSBwKunkQ1dAkfw1XpPDz5+fTXSS6TL6UF8eVur+MFobqJ9442Oe
 m7TfLfmRKC4aYy/Q3GmpOxtIdlAQOuOS133ydP8w2jhlZAcjg0T+NMu42tBcPribWBaOKWhdJjr
 SLUK0XK9NqQk4myXH1zbd+DBJjFICyiCMTlnkln0YjnjRtnF+69pDzCDAJpEvsns4gAIvi4Tb+K
 /2zVwS7HCxH76cDbGYPnP+hSusno/DT+Pbo3BdkUe00AW7DRBFWdJCq/JsEWxUsDpvhyxZsFPz4
 bXpme1J4XN3FYgKRf5b2Dpir2HiLZ6wE2YnaOXSAE2kLyS2YE2uv+fb6nrjsXB07Y3bxovZxPi7
 rz3YEzHtXZh+2G2xIpW7L0/+q/Zmi7ZiSXOuJKBz2Rr1ar7J6h8BzvEw6eQN7SRy3bhkeSF3XQx
 o4GS7AkNZIAAsP1A5viUksAFmep54z
X-Received: by 2002:a17:90b:33c1:b0:365:a5f6:4a5c with SMTP id
 98e67ed59e1d1-369518af9admr22757919a91.1.1779301335939; 
 Wed, 20 May 2026 11:22:15 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 02/64] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
Date: Wed, 20 May 2026 11:21:11 -0700
Message-ID: <20260520182213.872945-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  7 ++++++
 target/arm/tcg/vec_internal.h    |  7 ++++++
 target/arm/tcg/translate-a64.c   | 14 ++++++++++++
 target/arm/tcg/vec_helper64.c    | 37 ++++++++++++++++++++++++++++++++
 target/arm/tcg/a64.decode        |  5 +++++
 6 files changed, 75 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 50776347a5..21a1f941dd 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1062,6 +1062,11 @@ static inline bool isar_feature_aa64_ats1a(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64ISAR2, ATS1A);
 }
 
+static inline bool isar_feature_aa64_faminmax(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64ISAR3, FAMINMAX) != 0;
+}
+
 static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically.  */
diff --git a/target/arm/tcg/helper-a64-defs.h b/target/arm/tcg/helper-a64-defs.h
index 3c3c5dddb7..215df1201b 100644
--- a/target/arm/tcg/helper-a64-defs.h
+++ b/target/arm/tcg/helper-a64-defs.h
@@ -145,6 +145,13 @@ DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst,
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(gvec_famax_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(gvec_famin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, fpst, i32)
+
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(exception_return, void, env, i64)
 #endif
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 4edd2b4fc1..5c3f51eed3 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -342,6 +342,13 @@ bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
 
+float16 float16_famax(float16, float16, float_status *);
+float16 float16_famin(float16, float16, float_status *);
+float32 float32_famax(float32, float32, float_status *);
+float32 float32_famin(float32, float32, float_status *);
+float64 float64_famax(float64, float64, float_status *);
+float64 float64_famin(float64, float64, float_status *);
+
 /*
  * Decode helper functions for predicate as counter.
  */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9a27c4c6ec..3c6559964b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6478,6 +6478,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 };
 TRANS(FMINNMP_v, do_fp3_vector, a, 0, f_vector_fminnmp)
 
+static gen_helper_gvec_3_ptr * const f_vector_famax[3] = {
+    gen_helper_gvec_famax_h,
+    gen_helper_gvec_famax_s,
+    gen_helper_gvec_famax_d,
+};
+TRANS_FEAT(FAMAX, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famax)
+
+static gen_helper_gvec_3_ptr * const f_vector_famin[3] = {
+    gen_helper_gvec_famin_h,
+    gen_helper_gvec_famin_s,
+    gen_helper_gvec_famin_d,
+};
+TRANS_FEAT(FAMIN, aa64_faminmax, do_fp3_vector, a, 0, f_vector_famin)
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
index 249a257177..dce5e0505e 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "helper.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
@@ -140,3 +141,39 @@ void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
     memcpy(vd, &result, 16);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+/*
+ * Use float_minmax_ismag to get the absolute value min/max.
+ * Avoid float_minmax_is{num,number} so that we get normal NaN processing.
+ * If the result is not a nan, take the absolute value.
+ *
+ * Note this operation squashes FZ, FIZ, and AH to 0.
+ * Create a fresh status with default behaviour and propagate exceptions.
+ */
+#define DO_FAMINMAX(NAME, TYPE, MIN)                                    \
+TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)                     \
+{                                                                       \
+    float_status local = {};                                            \
+    arm_set_default_fp_behaviours(&local);                              \
+    TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
+    if (!TYPE##_is_any_nan(r)) {                                        \
+        r = TYPE##_abs(r);                                              \
+    }                                                                   \
+    float_raise(get_float_exception_flags(&local)                       \
+                & ~float_flag_input_denormal_used, s);                  \
+    return r;                                                           \
+}
+
+DO_FAMINMAX(famax, float16, 0)
+DO_FAMINMAX(famin, float16, float_minmax_ismin)
+DO_FAMINMAX(famax, float32, 0)
+DO_FAMINMAX(famin, float32, float_minmax_ismin)
+DO_FAMINMAX(famax, float64, 0)
+DO_FAMINMAX(famin, float64, float_minmax_ismin)
+
+DO_3OP(gvec_famax_h, float16_famax, float16)
+DO_3OP(gvec_famin_h, float16_famin, float16)
+DO_3OP(gvec_famax_s, float32_famax, float32)
+DO_3OP(gvec_famin_s, float32_famin, float32)
+DO_3OP(gvec_famax_d, float64_famax, float64)
+DO_3OP(gvec_famin_d, float64_famin, float64)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38b..666a293540 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1193,6 +1193,11 @@ RSUBHN          0.10 1110 ..1 ..... 01100 0 ..... ..... @qrrr_e
 PMULL_p8        0.00 1110 001 ..... 11100 0 ..... ..... @qrrr_b
 PMULL_p64       0.00 1110 111 ..... 11100 0 ..... ..... @qrrr_b
 
+FAMAX           0.00 1110 110 ..... 00011 1 ..... ..... @qrrr_h
+FAMAX           0.00 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
+FAMIN           0.10 1110 110 ..... 00011 1 ..... ..... @qrrr_h
+FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


