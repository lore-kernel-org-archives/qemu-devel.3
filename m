Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5CFCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmg-0000iJ-MX; Tue, 26 May 2026 10:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsme-0000eH-Ey
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:28 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmc-0001Ma-EQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:28 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so5697724f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805765; x=1780410565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LBubfPlRL2OEyIUISq0TynA64sXx3nlSkrR2/26xoFQ=;
 b=YaTgnZNK8j/gt1k/C5cfciqijpJtEiGUw7HLKu1GK2yTG/sRjApKi7C8M5xB8BYR8U
 M9nBcojgWw4wQAw62AAvbL7VDdwvO0zczgKvl+zHdMYONFbzeh3GIxLHnk3GYxOzTlGB
 LjJkR2ELozi/DQ1DIQQ3L4fvg9sLFYLHTu8P/jPpdA/WIqcpBzgv3ZnqORLsyjwHTJbf
 tpjdnYbm8qgy8/hkAudBTr1B7HUU6u1252pYizO7yY4aTK7rYsMstfLMZT+gv9sldAml
 WSshsJL710U2VC5XaI2hs68VIJCDGCodMJrGL3kXh5hu55ZEAEKw8vRX76rU3Ni7t7el
 IrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805765; x=1780410565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LBubfPlRL2OEyIUISq0TynA64sXx3nlSkrR2/26xoFQ=;
 b=blmSacHmUTT1mM9TdjHHnARHv0jHlzBuAqI0JtnbBvCcYShmD3xpjPfJTIVbWsN2Fs
 92RmLAyY+Aqu8IcGprk8OrAkM+gaKUNunDGABxaoaNQcCsLBV8AHvvxc6xC9kggJTHe9
 y6We8dx3kiK7jUnC4sRRE495B3YrYqHSFOUBRGT/HyoFE0q+Q2YWGxYBto5bSBfCwIml
 GlL/DSJ0Ni4mBWgm9xxLgCjlXHtVWI25V6OrUFA5IFyTzDIK96dVAXX3/FMbSzPpURd5
 uv1I7zbJuBtzP7Z8MJmwCdrmhAOwXTYMAYfgzh7ckiW/mokDl0N6det/sr5qUu9a3o44
 4MAg==
X-Gm-Message-State: AOJu0YxNGkwFn5gqpg2sbUydkisKUfhti7rRizNbh2weVQ0v8CyVJtq2
 mzqkU2t60OdE7OoFo+fMvdZwjITiRCYnkiEk9b2Xg3wUf1xZIhOj+EpBCDH4qHkDWDxHmtEhxLR
 dVEyt
X-Gm-Gg: Acq92OEKTXDvqgkAh85qzwPRRWojy9DExrShlV+J6Z0ZATPRtEwDZmXgbHgnP0XBLOW
 ZgLDcXM0JSM3iiIjlP4Xi4sH+5SXnBHMMZJNdpoZXRQGScnFe4rTiOceRSaTEFpeLY8a8kj51aF
 Li8owUdUwxaW49NIf1+y68wUr9YaxQ6M2C9qd89xcAAarH+qDcfgvPhYG6dc5hZ6tshIsFrxO6j
 EhrcUdxRSJ/T0FDOhaKM/+DHhX6a/n9CpvBihfiFYH1+EO2XnL821q9XvOuWaNO/LaeWO9U/oA9
 NYzuqV+2+tBuWiMssSQCOtI/3RiKVrxQrl0oEyoWz/qKzuqJf6pm76OnBDJ9WGwJkdH7YlrEPd1
 k9RuyYXmP8PdQWUK6I12e+jiwkG2djGTDUiFMslN/0keNEaSkxGS6o9041vPBWNVcH4efSfGKKp
 kacDFZiTdXiDAkfp29hwLoq6N0yIFoD4NUMwm4VwiwL98fC/dUm7+2cObZ7+9ZxyEaWaA6YpDFx
 fD1tcrPI8/uZAuhzBazSGoVATrzqh9b18fEESxL7Q==
X-Received: by 2002:a05:6000:1888:b0:45e:73a5:e5e4 with SMTP id
 ffacd0b85a97d-45eb38b9243mr31922255f8f.33.1779805764975; 
 Tue, 26 May 2026 07:29:24 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/54] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
Date: Tue, 26 May 2026 15:28:29 +0100
Message-ID: <20260526142850.2326589-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260522220306.235200-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h        |  5 +++++
 target/arm/tcg/a64.decode        |  5 +++++
 target/arm/tcg/helper-a64-defs.h |  7 ++++++
 target/arm/tcg/translate-a64.c   | 14 ++++++++++++
 target/arm/tcg/vec_helper64.c    | 38 ++++++++++++++++++++++++++++++++
 target/arm/tcg/vec_internal.h    |  7 ++++++
 6 files changed, 76 insertions(+)

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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e3971db3f..b5f953ab0a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6475,6 +6475,20 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
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
index 249a257177..cb55a2b441 100644
--- a/target/arm/tcg/vec_helper64.c
+++ b/target/arm/tcg/vec_helper64.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "internals.h"
 #include "helper.h"
 #include "helper-a64.h"
 #include "helper-sme.h"
@@ -140,3 +141,40 @@ void HELPER(simd_tblx)(void *vd, void *vm, CPUARMState *env, uint32_t desc)
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
+ */
+#define DO_FAMINMAX(NAME, TYPE, MIN)                                    \
+TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)                     \
+{                                                                       \
+    float_status local = *s;                                            \
+    set_flush_to_zero(false, &local);                                   \
+    set_flush_inputs_to_zero(false, &local);                            \
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
-- 
2.43.0


