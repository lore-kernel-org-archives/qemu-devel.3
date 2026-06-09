Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA0BCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX26T-0001Bx-D0; Tue, 09 Jun 2026 15:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21q-0003YB-3q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21e-00045D-OP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c0c32f6ce1so41249835ad.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032886; x=1781637686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPaxOES8BeN1kH/RpqJI24oCM++1OiCO9eL0RFjE2rc=;
 b=B7MXSOUehkU5NS0vmkG12jSvSFxhCM2vxryYlVn3iAgHL0Efi+54fdTbagJRiWUTD9
 LI0j5oKwefjg0bnO1Y+/kK3Kj6Pvf36QBbdX1PkSFJ2VN0+PsYQ4cxJAYmCbOZq7jxLX
 RGyjdaXNY1nmOxLU/s/Y1scHNZUlkpO8k/SzEuNvM9OdhqCuYtxnWPStlbgqc8iFjpYX
 ndUJ+mVKZt/+d4/U2uY0w3pKVgJ/N4qjpSZbhFYNEcLhcgdhS8dwOdXFYKdsNzFo1IWC
 TFjYXgZQRJbSFk6ELvtA2Yc3gHOeWzutYVYK6dmCXHiyQ1ucnYNzX8aGbCqIKQJq1IOd
 i1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032886; x=1781637686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LPaxOES8BeN1kH/RpqJI24oCM++1OiCO9eL0RFjE2rc=;
 b=AwHma1ASvaJjEmIjg9251iKsYv1fPXeTXh9UcchfglRnMOkKDPgjEenO6oOQIlzJRA
 4JljHWFq0zUbzc1zG43JPbW+0WUN9Ks8kSiOI7et+vzGCpg3AihAwoavBLc759xAav/R
 Ld1/fshHarjwvQ0tPJNZac9dIMfA0TUa9KEF5LyBoxbZZHMMRedWhkCbZfvVfA/xlSH6
 uY64yKyXnikJ0cHGSDdm/bHRBm9Ge/H034NkmQc29XebXDGtvdqm/b51SvbLqvfMYiMX
 kqYl0jiqzpe4b7JIcWxulFzVFBnPf9oW5b+AVIplmGe5gld4pegqof1Xsic8INRZi4Qd
 qgtA==
X-Gm-Message-State: AOJu0YyRLtNbVWo4IjWen4C7H/oekxW3gwUctvBgL1HKB7yChbkGbROZ
 lfL+u882D5t8B0HIelODHOfiBQJs8GSOVinZ2pds99PaK/p2/W4ODPaKCIdHjGf+CSxpBRhTsLE
 zefeuBT8=
X-Gm-Gg: Acq92OFjF2VrVbyVc1aeqLic7QU5UIkVt4yxS5e1pscQVsnTieRkqmsLrnMSdU53s4S
 HROb9Xo8TGNfZXUFGenD+t4vxLadZ19iam7VLh+Ea3TuXf2SPYiSbczCxeVFBwEwblp2U9Ibqfn
 JiEH8TCYwlXLaeaUrGnWMvbrmF61Z7mYqXKsrtj79ukYng1Zp/j3dLi1063jXLiHl2CNlY81xH+
 AtzO5EcLunAFH1JlYaFUsnXk8Z31cr/nfiX5A9xG+V9rhB3OkneocYqyvwCE5/goql//JkXt44n
 VAeMKGwuSLm/1eyJjy9xkRdMWipDtVoZhD4eaNuhf0XacTzb49oaXTHGb/0G+4ohd/9rcmpwajo
 gdBxdCwH/9ULPK3fG7PXp0S36jtyGUk7T3GTyp/C0ujoqxoSofXLe+L/F7aucbiZi6+gnxqZcK2
 QqPFWYUf98uARUxcHbbY0H77XunnDzrGmYrGfwOTc=
X-Received: by 2002:a17:903:2451:b0:2c0:d99a:2fc with SMTP id
 d9443c01a7336-2c1e78e4e7fmr247941285ad.2.1781032885762; 
 Tue, 09 Jun 2026 12:21:25 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 20/45] target/arm: Implement FCVT,
 FCVTN (FP32 to FP8) for SME
Date: Tue,  9 Jun 2026 12:20:44 -0700
Message-ID: <20260609192110.752384-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-fp8-defs.h |  2 ++
 target/arm/tcg/fp8_helper.c      | 59 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c   |  3 ++
 target/arm/tcg/sme.decode        |  3 ++
 4 files changed, 67 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 5863a6dbb8..36ae977431 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -21,3 +21,5 @@ DEF_HELPER_FLAGS_4(sve2_fcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnb_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_fcvtnt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 3bd57ff350..a39dc6f859 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -509,3 +509,62 @@ void HELPER(sve2_fcvtnt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(sme2_fcvt_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    ARMVectorReg scratch[4];
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n = vn;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    size_t stride = sizeof(ARMVectorReg) / 4;
+
+    if (vectors_overlap(vd, 1, vn, 4)) {
+        n = memcpy(scratch, vn, sizeof(scratch));
+    }
+
+    for (size_t i = 0; i < nelem; i++) {
+        for (size_t j = 0; j < 4; j++) {
+            d[H1(i + nelem * j)] = fcvt_f32_to_fp8(n[H4(i) + stride * j],
+                                                   output_fmt, ctx.scale,
+                                                   osc, &ctx.stat);
+        }
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
+
+void HELPER(sme2_fcvtn_bs)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n0 = vn;
+    uint32_t *n1 = vn + sizeof(ARMVectorReg);
+    uint32_t *n2 = vn + sizeof(ARMVectorReg) * 2;
+    uint32_t *n3 = vn + sizeof(ARMVectorReg) * 3;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+
+    for (size_t i = 0; i < nelem; ++i) {
+        float32 e0 = n0[H4(i)];
+        float32 e1 = n1[H4(i)];
+        float32 e2 = n2[H4(i)];
+        float32 e3 = n3[H4(i)];
+
+        d[H1(4 * i + 0)] = fcvt_f32_to_fp8(e0, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 1)] = fcvt_f32_to_fp8(e1, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 2)] = fcvt_f32_to_fp8(e2, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+        d[H1(4 * i + 3)] = fcvt_f32_to_fp8(e3, output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+}
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 49eee95d88..76bbacfb6e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1572,6 +1572,9 @@ static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
     return true;
 }
 
+TRANS_FEAT(FCVT_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvt_bs, 0)
+TRANS_FEAT(FCVTN_bs, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_fcvtn_bs, 0)
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a02bcc0e22..2b9e41a75a 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -865,6 +865,9 @@ BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
 FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
 
+FCVT_bs         11000001 001 10100 111000 ...00 .....       @zz_1x4
+FCVTN_bs        11000001 001 10100 111000 ...01 .....       @zz_1x4
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


