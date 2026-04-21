Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65918F99C9C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Ry-0008Iu-Pi; Tue, 21 Apr 2026 01:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rm-00087l-VI
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:56 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rj-0006dO-4F
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:54 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so3450913a91.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748489; x=1777353289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiQ5icxQbNLrKse61brBqsCLHCU36Le6q/LoWKJ1fb4=;
 b=IZdQD3Ar4EjgyeoFwpPwSHv5iMbnVBZ9oH93MXAX6Bxgblo1Av14yDA2vfvI/CGcrB
 Z7foiASXKZqhYiv/HA5x5mzRHmdX0IJ2fGdtqfoFyZlXsgHwwClrf3WCEHoKMQkfWL1w
 Ze4MPAMSI1CtEGraZo116cPKGL1f4w/6wibwlOCKR/FilixxcmhKdcqWWFoUJoxkG7ut
 KFEwUSMsvqqTtSLvHBU3njoQrBa00uxCppDvwrAiD2Gk5nMOkq0EGFMIrp8Jfqs4I/ha
 aOGSrhYimVIgJMy/xZUrO5ySjrN/9W4s++snueYMWWHyn9WBhJHHeYA9LeSFovJFLDgO
 XUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748489; x=1777353289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BiQ5icxQbNLrKse61brBqsCLHCU36Le6q/LoWKJ1fb4=;
 b=kvoOA+jOaTMuyMsZGrCRtc6m5hltIc99UAO6OoW1e0nwnIxiJveuTdNZZ+un+hmEY7
 8/p0NHH0sWbUnXePPQ/l0HTU04TEd3gM2q2WLROlmtwUtZAgVA/acqcGMQQApIgnOSjR
 kK9wGkiOwRhSczph27o/UUqzpb2rrjmZcQJII+lG/PMEtqvtt9+3C/NEw6fw4spVi3BI
 PekFH6k/YTk9ICxGAjZ4Sv5xZA5wODYhzWnunUhvs2utkE8/tnzdc1mNu8gIZAUtWc9J
 nOxzlgL3I5d9SBp+Mm2xVsFrl5ybHyuY/ih+/e7nPL4JwMUAY2jsh0TPpN47/cNBqSa6
 XQcQ==
X-Gm-Message-State: AOJu0YxnlPPxjwMgxAfhZmPSPazKFZWSQIVz+l/6UyYZ876yAfoVl4kB
 oo/kLx9vagUwNsouuAKxR32ZnEewmYz0AQbWi8PrZx4M7eE4y8/U0J2mwPpQL17jB1QavXnXGoU
 XrMuVpyk=
X-Gm-Gg: AeBDieugy9cvl0wY+odLSLTbKdwHE7iGwsysN8BwvpPElIB36C6tWIgYXvqt8cToAZp
 wzCfh6mbrMFYaQL7jaXEKmqG9aumDWkZZAbmZSUbUhVJR9kayFpXxpm1JiSiczYLQtu2xe64cnX
 54G4QV2ZbP+i/M0+Lcg0xlPeoirWQpjNfxjaMpgRqky/AZA8dFriJqklOjl5pyRFlfgOWbjIqM6
 YOxCYy1upcEqkN94FcgfXMliBzkKqaRpsIe6s2Y6iN00oAg3ntp31QofwlZcAGfGMJ61dplBq1S
 L6dlx1RoW4csWFLDcJA5VjtGcz6TRj6tVSdR7Uv8svZHwptRmnimN8OF3fSx7O0XYAftIYHhIjo
 +aeBbht4gOz55sks+PMljjwLDiEO3uvCVXqGCTaN5oxleCL04xiywCcHAEjOnZeWekjNxINKNqp
 4dTzoWpVWKPkAFUHvfVyC+arQHC7ljWRYf66fiZOSD
X-Received: by 2002:a17:90b:1809:b0:35d:a3b4:2f00 with SMTP id
 98e67ed59e1d1-361403d53bdmr16776521a91.8.1776748488976; 
 Mon, 20 Apr 2026 22:14:48 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 24/37] target/arm: Implement BF1CVT, BF1CVTLT, BF2CVT,
 BF2CVTLT for SVE
Date: Tue, 21 Apr 2026 15:13:33 +1000
Message-ID: <20260421051346.41106-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 target/arm/cpu-features.h        |  6 ++++++
 target/arm/tcg/helper-fp8-defs.h |  1 +
 target/arm/tcg/fp8_helper.c      | 28 ++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   | 23 +++++++++++++++++++++++
 target/arm/tcg/sve.decode        |  6 ++++++
 5 files changed, 64 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 8a6e5d555b..7f1a394ef0 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1624,6 +1624,12 @@ isar_feature_aa64_sme2_or_sve2_faminmax(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_faminmax(id);
 }
 
+static inline bool
+isar_feature_aa64_sme2_or_sve2_f8cvt(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_f8cvt(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 0caaf63749..18ff483bb0 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -4,3 +4,4 @@
  */
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index a2efdd5cd7..b03345c670 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -121,3 +121,31 @@ void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
     fp8_finish(env, &ctx);
     clear_tail(vd, 16, simd_maxsz(desc));
 }
+
+void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn;
+    uint16_t *d = vd;
+    size_t nelem = simd_oprsz(desc) / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = float8_e5m2_to_bfloat16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(2 * i + ctx.high)];
+            d[H2(i)] = float8_e4m3_to_bfloat16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d, nelem, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 756c4373b5..1540cbd6de 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
@@ -4066,6 +4067,28 @@ TRANS_FEAT(FRSQRTE, aa64_sme_or_sve, gen_gvec_fpst_ah_arg_zz,
            s->fpcr_ah && dc_isar_feature(aa64_rpres, s) ?
            frsqrte_rpres_fns[a->esz] : frsqrte_fns[a->esz], a, 0)
 
+static bool do_f8cvt(DisasContext *s, arg_rr_esz *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2, bool isodd)
+{
+    if (fpmr_access_check(s) && sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           tcg_env, vsz, vsz,
+                           issrc2 | (isodd << 1) | (FPST_A64 << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(BF1CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, false, false)
+TRANS_FEAT(BF2CVT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, true, false)
+TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, false, true)
+TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
+           gen_helper_sve2_bfcvt, true, true)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 078a085a79..e7984fa8e0 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -108,6 +108,7 @@
 # Two operand
 @pd_pn          ........ esz:2 .. .... ....... rn:4 . rd:4      &rr_esz
 @rd_rn          ........ esz:2 ...... ...... rn:5 rd:5          &rr_esz
+@rd_rn_e0       ........ .. ...... ...... rn:5 rd:5             &rr_esz esz=0
 @rd_rnx2        ........ ... ..... ...... ..... rd:5            &rr_esz rn=%rn_ax2
 
 # Two operand with governing predicate, flags setting
@@ -1090,6 +1091,11 @@ FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
 FRSQRTE         01100101 .. 001 111 001100 ..... .....          @rd_rn
 
+BF1CVT          01100101 00 001 000 001110 ..... .....          @rd_rn_e0
+BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
+BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
+BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
-- 
2.43.0


