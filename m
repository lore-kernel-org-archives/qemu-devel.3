Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C4CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXzB-0001TQ-PI; Fri, 22 May 2026 18:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXy5-0007pa-TP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:55 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQXxz-0008NL-Pz
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:03:43 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-367d88b9940so5145321a91.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487417; x=1780092217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmG9bRRQESb91pzNwIOo7N0csVw/nZ8h2JxX2X42xfE=;
 b=IfruLMlUYv0KcmJzbC3qhzWYB5MAwQ1gu6TaXbIj9PclyAm1kc4AUF+4L41Q0xxqyD
 WzSVpntJcj3vCcqPPTBVOchNntw2CnZE58A0tctr7G8ClYbzydE1AT+L0cBpnx+glKwD
 aTk0J5cQr7I7xt0luS2ZQj2NHMppHK9U8jMiWfalxoEsPOsIoszK4BHs7zmmZYA/LEQv
 nzYeepx+6IEVYDVaeGATv/Z1JGBtxv5AwcbEUbgfwE/iOkJ6a92L91r163PAGBdZsa0n
 2ZejlenbcfusdU8JQt/dc5DwYLcpSTfqDjPO4u0U3L/BhECmtSBGBwDbfChBwVOOZGol
 3fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487417; x=1780092217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AmG9bRRQESb91pzNwIOo7N0csVw/nZ8h2JxX2X42xfE=;
 b=Te3maAbjMyRWmv2mrxLLHIIama7L5yXGkhFyTXUXyUzrzdjisgfLUKTusACOZNx2FG
 fGhMNcCFgDi37o4O1JBTmZvk1SxZrVNs0sqPoEzH5NTON9wfNjoMzgA67wLdet/LS6bx
 0XP8xmjYbU+rAr8yWGufl7cv/ojunid0fsvaXW3M/z6OQ1EpO/A2H7eituP2YqN3O3Z4
 jgQucBbT5YV0rbfcJwDCtcBSoo2ukiVzpS+9vUmtvwuvof1nahpjUnh5osggRV89v7pi
 BuX+t9ktrOUiMx7KaSkBpxQOaOrwx3ypRAy3AgsKAb8XS6vjN4EBo5SEE38MaI9/CvKt
 bNUw==
X-Gm-Message-State: AOJu0Yz44SVEcduf/AJTjovD29dbCfEoFi2m39s+jmMF6lo9V1V0me12
 WbdcDkAaCJAeMcYAA61FyF1ZIHyj+bkXhcF8NfUE1UU/aOnuXWuURwNrM5mK3bVX/+rFR9ZyUdC
 n3YMq
X-Gm-Gg: Acq92OGcAzx91xn2rzBOtOdP8vFXGhUZkReXPfHbPehlvnZsPkfKI56O3B+ttaK5xUZ
 pQ2g+5m1NuKLBMjCKRPMqVTiyru8/gh4whqN1ty5afk5viJXDmRv5JxOq/t/Bu+n7mTpSqN2buw
 LFZyOSFSIeJcmhgSuApN4zWHtNN7N1ptPkwXEy4X7Sz2P0lUyDz372HUkqG3Q5JnvA2vvEL2giq
 XpWiKsC2Iq/y0HqMUv9BY1AMZTALehM9bZIfbvlbSp5R6GaKQAUHF8wRv1SNT8IYlnwL2lo9bgX
 Axgyzl2hUpftE2aWHGTYHDL0mtfir7e9z+Hy8U7A9JkuTdYjyztp4B7TIvFy0mLc4bVfdk1lXWF
 2kTFD/sPtqqjwF3RgbFBtxfGuYpNnnbvINkKgL5ZAFT4sGb4bJfXzgP2dWPsdc/xrFUlHh9t+/8
 YEP8VjQoICxA5GkDW2hrhtiHuXvdCiLjlDGKD+IghpWCnhno/pjw==
X-Received: by 2002:a17:90b:3bcc:b0:366:3517:1a95 with SMTP id
 98e67ed59e1d1-36a6746f232mr4963048a91.0.1779487416641; 
 Fri, 22 May 2026 15:03:36 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a6772f486sm1726789a91.2.2026.05.22.15.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:03:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 29/64] target/arm: Implement BF1CVT, BF1CVTL, BF2CVT,
 BF2CVTL for SME
Date: Fri, 22 May 2026 15:02:31 -0700
Message-ID: <20260522220306.235200-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
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
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 47 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   | 19 +++++++++++++
 target/arm/tcg/sme.decode        |  5 ++++
 4 files changed, 73 insertions(+)

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
index c62fb2ffd6..aad03b0817 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -138,3 +138,50 @@ void HELPER(sve2_bfcvt)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(sme2_bfcvt_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
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
+    for (size_t i = 0; i < nelem; ++i) {
+        d0[H2(i)] = fcvt_fp8_to_b16(n[H1(i)], input_fmt,
+                                    ctx.scale, &ctx.stat);
+    }
+    for (size_t i = 0; i < nelem; ++i) {
+        d1[H2(i)] = fcvt_fp8_to_b16(n[H1(i + nelem)], input_fmt,
+                                    ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
+void HELPER(sme2_bfcvtl_hb)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_src_start(env, desc, 0x3f);
+    fp8_input_fn *input_fmt = fp8_input_fmt[ctx.f8fmt];
+    uint8_t *n = vn;
+    uint16_t *d0 = vd;
+    uint16_t *d1 = vd + sizeof(ARMVectorReg);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        uint8_t e0 = n[H1(2 * i + 0)];
+        uint8_t e1 = n[H1(2 * i + 1)];
+        d0[H2(i)] = fcvt_fp8_to_b16(e0, input_fmt, ctx.scale, &ctx.stat);
+        d1[H2(i)] = fcvt_fp8_to_b16(e1, input_fmt, ctx.scale, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
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


