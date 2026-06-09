Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046C9CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23l-0004qI-4x; Tue, 09 Jun 2026 15:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21a-0003Kn-GB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:11 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21S-00043E-6J
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:07 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2bf0ddaf50fso41437245ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032879; x=1781637679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckaQZDadZRoEOPVRpAH1puA8ceVmvpoZOVmAYQNozxM=;
 b=MQFjpd/NXCq5CK+rk24AHXNuveJIdMn4uoG8PXdFN86ylkoub1NT+8fkAoaxYw4465
 UBt5iX+1WWU+aeU85znOCc85jHPccRiCHveHlVRCICVd5TfOcTt8JOOvAJGhcRAiuNPG
 TV1EJWEtdy/SXcARlali0h7BtuV2SwsQ03UFBUEPYMhHkY7Roivu/J8i5+wkEWN8FJvk
 Til9rLik1tbdtddg2tKHnEA8rX1gaLEUPNrLezvPkG3TgWF2gomxTrSxtijmtrGyMwMd
 FHSUoOocDmIqk134wVlBz0tTjXesjNdqAjO5K8IIZuNHVD3QjHZ8tY1Atx/miFBVF6Tl
 oFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032879; x=1781637679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckaQZDadZRoEOPVRpAH1puA8ceVmvpoZOVmAYQNozxM=;
 b=j1DxD83A9LtQUD3wtlofIcWkL0O6vdBvVLq+IzWAYOE+eGQCBCHet0S0ajr3mvxDiR
 lD55z/WEm1psVRtdYkMrmj1FJCjtul6+4zmV+sfASYzC1ysHvztlXgqOFxCyenloci5a
 Cnv3SVaVgjqQxn0WRD/WML2REuhIRgrZ9LDecgFHIv080rkHlk8psu19zR/9P5LrkxZH
 JbpQSRkHsNexGGAHw5j1SO1yeUYy7tGweiWbmjr+q7zWiCShVG539WW0yQ4BmkclkQhs
 Cu7cMTmAFxmOmVj7iFpCiolVBDX65fP96J9Jqkr//OmkZ0TtMSgMFgh+4olDR8aaZsyC
 0LSA==
X-Gm-Message-State: AOJu0Ywcsxi2uExsEdF+g0WUXauA3n4VkWAm93a1y7dj2rU/wtESIh2P
 eD3lWoMKiihWhA5Pn5bYuUEZ1v6WXzfgiwvYDcgSpSgLtaP4RjsPXcZdhKjz8OprmWIa8LFicST
 9igl8DVw=
X-Gm-Gg: Acq92OEQf7LJOZG7lKNuf2Pja+R/xmLx+vRzbTBfLhkjVVYohAWog6AA6evSGzIGuJl
 vmgFOoa80npuRSXDFg69i2NVTksnmnHc9ligSyoiTYDjXuSN3UjjcxxpZl7pimPDpOV00H4H+fh
 /2Ojtlte77aYgf8H67bBN6FLhs229Y8H0TeHI59ecRAVPHcKdWquQaHdxH1WYNb+wh6lCunrUHW
 5pHgkFjXwDGiRAGuHsj+sv3WEI5nsWJnTwme2jQvfA8VL0HTG2hkSIU3xaVGXqel0jKDkpXR9gu
 PsdEQc6PqXVOECqt1ts0RrRI/+1o8dJHjagB8lkp6lFro1OUfHoKeTOlYTk64YlR3uKLHCBKBqU
 Ez6Cd9J0MNSeyqvdw1L56se0NW2Sbw5FbT3mLmbMPNgJ+WBmosMBtNGZSLsxLEeFOuj52d+G3kY
 ElWGZSNyOxyEaOhezoun803CJlbWDQHVXAEuzYIeA=
X-Received: by 2002:a17:902:da8a:b0:2bf:305a:310d with SMTP id
 d9443c01a7336-2c1e7f92548mr258381085ad.24.1781032878561; 
 Tue, 09 Jun 2026 12:21:18 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 10/45] target/arm: Implement BF1CVT, BF1CVTL, BF2CVT,
 BF2CVTL for SME
Date: Tue,  9 Jun 2026 12:20:34 -0700
Message-ID: <20260609192110.752384-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 652a72e972..19a13a6506 100644
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


