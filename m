Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5F6F588F0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Sc-0000WX-I3; Tue, 21 Apr 2026 01:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rz-0008J2-3v
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:07 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rx-0006nl-2t
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:15:06 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35691a231a7so2536612a91.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748503; x=1777353303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEaE+Gz4pYUADHfndZN2FYmsXkuJHrO7JwM42EplOck=;
 b=EtyXz6i2tuBI3azUy2iFLBeG2wBEu/xNHbdMpIzwcJh+A2idfR4iNvj9KFvejQrgEH
 Ud0keRSTqnEROixSX7qsUjuWFLI45hrMuCvpQnAq7jsQbr+Xqg1pr315KifRIEaYFWYv
 LljjwnADoTm0E2Q/UXsAZPe13dA5iMyq2bZkaHiQAFeoB2V1kdvO1Jt0BlSV8Gpnjto7
 rZx2yiHChaKJMCMvK22e5O3QJ20LYSIFQugY0ij5WQ53vBsri83OJO/aOIrqc78C5cEs
 GClukZIP9o1dwB/YxVPReoW5SGG2tv9jMDMzGs8TxC2Un7bJVB0diHLg4Fnax7L9Q6A6
 Blyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748503; x=1777353303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEaE+Gz4pYUADHfndZN2FYmsXkuJHrO7JwM42EplOck=;
 b=N4NAsS9e1/0qEYAkE0ls1N2/CNRuBQJyNIsHgjUh6MJpnvQQu1r7iJFBlnGqiXJ7PC
 W+oRhwQe8uRwaGRVpJZ7MyGIwp6QQnTtUI2VrJFcKhXG3h5G/PIEsprf9k4ZgUQcjfma
 +2wV76FWLMc37a3wRS+ZAxPlfGdXz1j6gslzAp3tMj5TJGljIHWZzIuqPzQFLmubDyDn
 jqvQmwdZuPR+T0xVMRMph4G0uRASk9gg156wFE9xrfNiXoafDFecXT4pub++nb1x2IAg
 8lskDFEoKYEb2S1zlRwEVHHetLC2JX0cesNV+3MkranxNwfBJOmvXsHIe6n9h8niszqY
 XrJA==
X-Gm-Message-State: AOJu0Yz4jZnV9ICujaU8WLna1ssL4GdVRoDrfFMKiPTOx9Qs/Cws2Lk+
 Xpkc151air8EL4n9OJVj7UYm7J5sPSg2mU8Poqe37AukaipEVhueeQtgRTzw2AHhCZl7NWSqsiY
 u69tCHDc=
X-Gm-Gg: AeBDievpb/u7I0itrE70OLP+3gmMUkXtFDeaqRaKpGUIqI517A+N8MUU6TRr5euYEdd
 sP2J8fxg9xDP2DbTLUar6iIBrJUGk1lFgXFSRj1gnsBQ66VsMBTD8XrSzgwhYO4K8pD3p3poYfr
 wJyjk7Kx/4nIz+tA5SbNvLuCoytGMuFqCkZz5Fi3izsCBK/xx8E7f78PgKZvX97Wn7urM4uR6Ii
 zSfcZ9R5+tYQX5a7e9Kci2K+SIPa5DVhDu7WSPBuKgnUnDXTHcD/iWuTPOuLwkdxI7+5UcQSZQ9
 Jhgxas8heNEiBSB0nxtL0leOfggrXTxWcLvkHBBHLFOaqTUT9rAkTJJQHwlACeNgtDn8mxdUX/w
 NnwP2MCq0FTyUJSzYz2UpfsLZ5xNgN3g92gsAM0QFQ/XE1F1ycLry3ibV9RcRQh34fpswlrOYIM
 4GNr8/F0H9KEMli+SjCWWCCp8mdcDs7grFiOT7VZCv
X-Received: by 2002:a17:902:d592:b0:2b0:ccad:de1a with SMTP id
 d9443c01a7336-2b5f9f3aa58mr158637985ad.30.1776748503316; 
 Mon, 20 Apr 2026 22:15:03 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:15:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 30/37] target/arm: Implement BFCVTN for SVE
Date: Tue, 21 Apr 2026 15:13:39 +1000
Message-ID: <20260421051346.41106-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 55 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c   |  3 ++
 target/arm/tcg/sve.decode        |  2 ++
 4 files changed, 62 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index b5dc2b7064..bbc8d69e28 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -12,3 +12,5 @@ DEF_HELPER_FLAGS_4(advsimd_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 2b1955508d..ad5a2dc64d 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -77,6 +77,15 @@ static FP8Context fp8_src_start(CPUARMState *env, uint32_t desc, int scale_mask)
     return fp8_start(env, desc, f8fmt, scale);
 }
 
+static FP8Context fp8_dst_start(CPUARMState *env, uint32_t desc)
+{
+    uint64_t fpmr = env->vfp.fpmr;
+    FPMRType f8fmt = FIELD_EX64(fpmr, FPMR, F8D);
+    int scale = FIELD_SEX64(fpmr, FPMR, NSCALE);
+
+    return fp8_start(env, desc, f8fmt, scale);
+}
+
 /*
  * Invalid input format is treated as snan, then the conversion operation
  * converts to default nan and raises invalid.
@@ -101,6 +110,13 @@ static void float16_invalid_input(float16 *d, size_t nelem, float_status *s)
     float_raise(float_flag_invalid | float_flag_invalid_snan, s);
 }
 
+/* Invalid output format writes -1 and raises invalid.  */
+static void float8_invalid_output(uint8_t *d, size_t nelem, float_status *s)
+{
+    memset(d, -1, nelem);
+    float_raise(float_flag_invalid, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -377,3 +393,42 @@ void HELPER(sme2_fcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint16_t *n0 = vn;
+    uint16_t *n1 = vn + sizeof(ARMVectorReg);
+    uint8_t *d = vd;
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            bfloat16 e0 = n0[H2(i)];
+            bfloat16 e1 = n1[H2(i)];
+            d[H1(2 * i + 0)] =
+                bfloat16_to_float8_e5m2(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(2 * i + 1)] =
+                bfloat16_to_float8_e5m2(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            bfloat16 e0 = n0[H2(i)];
+            bfloat16 e1 = n1[H2(i)];
+            d[H1(2 * i + 0)] =
+                bfloat16_to_float8_e4m3(e0, ctx.scale, osc, &ctx.stat);
+            d[H1(2 * i + 1)] =
+                bfloat16_to_float8_e4m3(e1, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, oprsz, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e31ab609f9..54f1b253c6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4098,6 +4098,9 @@ TRANS_FEAT(BF1CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
 TRANS_FEAT(BF2CVTLT, aa64_sme2_or_sve2_f8cvt, do_f8cvt, a,
            gen_helper_sve2_bfcvt, true, true)
 
+TRANS_FEAT(BFCVTN, aa64_sme2_or_sve2_f8cvt, do_f8cvt,
+           a, gen_helper_sve2_bfcvtn_bh, false, false)
+
 /*
  *** SVE Floating Point Compare with Zero Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index ca110f4bc1..b6ef8ed8de 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1101,6 +1101,8 @@ BF2CVT          01100101 00 001 000 001111 ..... .....          @rd_rn_e0
 BF1CVTLT        01100101 00 001 001 001110 ..... .....          @rd_rn_e0
 BF2CVTLT        01100101 00 001 001 001111 ..... .....          @rd_rn_e0
 
+BFCVTN          01100101 00 001 010 001110 ....0 .....          @rd_rnx2 esz=1
+
 ### SVE FP Compare with Zero Group
 
 FCMGE_ppz0      01100101 .. 0100 00 001 ... ..... 0 ....        @pd_pg_rn
-- 
2.43.0


