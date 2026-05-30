Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E482ACD6E55
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrO-0000CE-0W; Sat, 30 May 2026 19:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrM-0000Aw-CV
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:52 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrK-0007X1-KC
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:52 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2bf02708e8fso21742775ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182769; x=1780787569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDR0Y4sXlbZK7TrziuxhbkAjyW4mGMb7eMYpZqe9/Ss=;
 b=Zc8uI/QPjtwgWAfbz0LJTp1KtwU60KdbKezxAfWuYGT0ZCj4m5LxbRaSypyzvEYW6E
 NW5SISbXvNN/uDH5HMryK/rTWe3+bdt9/7rpg0cVF1ItxLGgCC6TdhAAABNFWRkeb0/t
 y2r2mpNnqTsFGyzAcqnXvrK/EKjNIKpcKg297ETF134WExG+vxjCIt5oOXtQ52Qm5ut8
 UGiIkrQWM8PFLk39mfzYAp9EE0EVymBpyzwGP7x62Q0vZN/czlsFj2deFLpKMds/CzyR
 LSPRtH+L9o2kzBcj8eVf5Mq9F4nTOZ3sb1ogccadmRyTvK57eY/4WAtksjKVbOHkH8Fg
 80jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182769; x=1780787569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TDR0Y4sXlbZK7TrziuxhbkAjyW4mGMb7eMYpZqe9/Ss=;
 b=LPhxSrptbCgF9r7Z3Azu2v7fUm/6lt7xfXK70tQOSbiL7XSUiKE/zJWc73tqbEh4Ev
 l2FySuzEUoLND+nC0DrIPPk2nPVdV09XJK9x691zKuCYNZKeU9Wzj73szscmEH2vuH4U
 yTN6qrB+47QWFL73t30JxBOBatQ4iXo5YVHqBXNFhG9xvaFNWdfXCpUMipY9E64d84rL
 mA4CJSLN8E1zbN/xHMwqlxwjSGdpWI7UiUWNT7qwEsZrHrftH5EpHD1ClEAoUV4ivS4f
 lEqTeoyv2hLsYsn//VLzMG34M0Ki9GrsrjRwEy0Xx/JqpG/cxiJSokPp9JZdf3zkM0Nl
 i86Q==
X-Gm-Message-State: AOJu0YzBJoV0qaBKSjpATJq29iEbyY7G0PkN0Ia1Ti4J2lawnASooZyI
 Unr7BvBOgDV+znRCP4OuoBY8Mpuq6jKeEzohZnYp0eZRw1jz3Nk2MB8g0iRciQ9XCBVj2SLHSig
 y136c9S0=
X-Gm-Gg: Acq92OFQlNVQJt0QpUzAc2S2QMDrgCHaRQ+HfcnndQkIjra2vIB6PVKt/Bc/LIIFRye
 1HMX6texkFgMb9Bd12qVAJ5CO7qecdqfQ9mHvFRmwok0n8r//0O1deavLTRwy53/P37ta++KcSG
 kti59Axg5vACjBoXOEWhklU03au/uuF4BEeBBjDIEglCQrMZcDAMY5Ohg0eWztuoEbrVJDuVKpt
 QFjSg0lFLohkM8QM5rVpCE1Wx6M2TwZqLQ2tzXm2sRYnT38unJGOx49FwATIn4BFEAVSd9wOI7F
 CmEfMPtpRXakAsDN0C95sIKnPd6tWPbOpEbJnNM6KgzZIzlVpNlQlys6JMW+ZLTbWOwN4ws5wO/
 zqqnArr0UrtJPjiNL3Yr+5pLk+DHWPCE/pPM3xydl11zS+7LItbhkSpFnIkd7AXZ25Go5Iopq4H
 4ve1ABbL3Q/9ymwr+LMJnKFB2VN/q4T92Wcbuh7Eg=
X-Received: by 2002:a05:6a21:2d43:b0:3b2:b0f7:50f with SMTP id
 adf61e73a8af0-3b427fc9892mr5455003637.41.1780182769007; 
 Sat, 30 May 2026 16:12:49 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 16/41] target/arm: Implement FCVT,
 FCVTN (FP32 to FP8) for SME
Date: Sat, 30 May 2026 16:12:04 -0700
Message-ID: <20260530231229.400441-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


