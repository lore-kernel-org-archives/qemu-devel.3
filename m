Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABDFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIFAK-0007JB-Ms; Wed, 29 Apr 2026 20:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA5-0006pf-RD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:51 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIFA2-0006Ns-N1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso190803b3a.2
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508505; x=1778113305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOfkYu9xRyUGvcHcCTU6Jy0Z7oGzIMpohmpmqr8Pmng=;
 b=bkutybNX1ZxIJGx/FBn3Tzx0JAPPciA8DOgmcgX+YeCeo0hzO2SiFTuSHOLpeEPJ96
 vPxqSfz9VvC2jNXfHM0AiuVTJFpmJjM05cnXzxB/97cvNUSw2je97cnsjV6QIJ5sybId
 frurZDmDRMYSdgAJrwe3lJAjiUMWa5FRKS8aGDc6a+nRqGiYe/PDMA37WNmpstCbhDow
 qmDchyPMnfonKjvgZC9E/iaIodnlwOM97F4i4hBBDlKtAo/dw2GkfX4u7ZGRZiKy5TYX
 E1Bb0Q2GPCBU3PEMUqcRSgqVxAw4wvTBSgPsOX86WIMRZ7PobWzgl6jGS2DsJWjYs0WH
 CE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508505; x=1778113305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BOfkYu9xRyUGvcHcCTU6Jy0Z7oGzIMpohmpmqr8Pmng=;
 b=UuuVvGkIlptwZrhv7YzpTi9O1xdWZSYsYi8uXco51+6++2DLcDaTWDBDB2zDiiwacY
 Ja63lAdNi0Wd5Gxjr5bpP47Z5BxrfJabSz+Um6FF/PvfQcPzXdtc+XtvmXERD34Jtwgl
 t2J9/hlMscaOywRgZ175e2fOLg81bj3fGgVymyf6DdNfK3jKyIU4qlIG2iTwmpA61BRd
 vEUw1/8bf4n4huE3C31cpJQDfhMUWKz0f2LSCaCVZmx6HhOBTPn0de+rMm+2qrq7nF0w
 1QWOLQka++wiHi5koAVFcjIKUmoj8AQZrYejgEPSOQ6KPHShS6i00vl1Lg8nLaavR9qW
 8C+Q==
X-Gm-Message-State: AOJu0YwgfHmlNRzS13BxsmaVl9whQWXWvVXBQlSRxt2VgSr3t32RiGqj
 zKFE51LMOIcYk9KZNvANbVXnJHI1CztmCG1w6G57eqwv1psfBTQyf6q8hm03V9Gy85DAIHr5ptb
 GSxS7SgQ=
X-Gm-Gg: AeBDievZCQgVwjXpg+OV4Bbrzfmv3+Iw+gP4S/1CVCcuwXdiC293gZkT5c9ljYNhJSq
 64/xUdFxiyOxBLRRyZB1M5Hg03L80iU8p2aNxi7wGOGi+vAmn1TF3Gn/Ju4KdeGBpCchGsRSQEA
 wuyTm/i8/UhRQpa+QFFWZe/+BfiMPS6iQn/ZJXEfbakCaLk/SkjE6+GzKdyklKikYvPiWj1lvNQ
 65ENTGAU8t9VJUy9ouLRUjD1yuBgZXHf0ra97EeRujmmQuG0QsfBFuXaQD7DcsmXZj7AYyV4q0M
 52Ps9+G8ywEBjuLhzm+PShZj+I3AiXrHp2qvSdhFBSGUwe/GVaKFpi6wuG6tCe7LKuAmwLNFihP
 D1xQRR6DJfiD+puR7NZB82cnG2LkTTOFpt9whzKbg6PhL04ZW9vWshNoWLl05R6fL+nQo57YlWz
 I/zaa1fgXLDdE/mV9Q8xar+7xNv1HjVDtEbpp389ft
X-Received: by 2002:a05:6a00:1749:b0:82a:1529:2b4f with SMTP id
 d2e1a72fcca58-834fdc82311mr861513b3a.44.1777508504760; 
 Wed, 29 Apr 2026 17:21:44 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 24/47] target/arm: Implement BF1CVT, BF1CVTL, BF2CVT,
 BF2CVTL for SME
Date: Thu, 30 Apr 2026 10:20:23 +1000
Message-ID: <20260430002046.59739-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  2 +
 target/arm/tcg/fp8_helper.c      | 79 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 19 ++++++++
 target/arm/tcg/sme.decode        |  5 ++
 4 files changed, 105 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 18ff483bb0..966f83d796 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -5,3 +5,5 @@
 
 DEF_HELPER_FLAGS_4(advsimd_bfcvtl, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index a4c7c44e6f..7598871f87 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -164,3 +164,82 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_finish(env, &ctx);
 }
+
+void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vectors_overlap(vd, 2, vn, 1)) {
+        n = memcpy(&scratch, vn, oprsz);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i)];
+            d0[H2(i)] = fcvt_fp8e5m2_to_b16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e = n[H1(i) + nelem];
+            d1[H2(i)] = fcvt_fp8e5m2_to_b16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i)];
+            d0[H2(i)] = fcvt_fp8e4m3_to_b16(e, ctx.scale, &ctx.stat);
+        }
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e = n[H1(i) + nelem];
+            d1[H2(i)] = fcvt_fp8e4m3_to_b16(e, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
+
+void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e5m2 e0 = n[H1(2 * i + 0)];
+            float8_e5m2 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = fcvt_fp8e5m2_to_b16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = fcvt_fp8e5m2_to_b16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < nelem; ++i) {
+            float8_e4m3 e0 = n[H1(2 * i + 0)];
+            float8_e4m3 e1 = n[H1(2 * i + 1)];
+            d0[H2(i)] = fcvt_fp8e4m3_to_b16(e0, ctx.scale, &ctx.stat);
+            d1[H2(i)] = fcvt_fp8e4m3_to_b16(e1, ctx.scale, &ctx.stat);
+        }
+        break;
+    default:
+        bfloat16_invalid_input(d0, nelem, &ctx.stat);
+        memcpy(d1, d0, oprsz);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 88c1d78c40..2841b2b8cb 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -22,6 +22,7 @@
 #include "helper-a64.h"
 #include "helper-sme.h"
 #include "helper-sve.h"
+#include "helper-fp8.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "tcg/tcg-op.h"
@@ -1532,6 +1533,24 @@ TRANS_FEAT(UUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_bh)
 TRANS_FEAT(UUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_hs)
 TRANS_FEAT(UUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_sd)
 
+static bool do_f8cvt(DisasContext *s, arg_zz_n *a,
+                     gen_helper_gvec_2_ptr *fn, bool issrc2)
+{
+    if (fpmr_access_check(s) && sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_2_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           tcg_env, svl, svl,
+                           issrc2 | (FPST_ZA << 2), fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(BF1CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 0)
+TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
+TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
+TRANS_FEAT(BF2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 1)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 7a8e1abb59..df9586c1a5 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -853,6 +853,11 @@ UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
 
+BF1CVT          11000001 011 00110 111000 ..... ....0       @zz_2x1
+BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
+BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
+BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


