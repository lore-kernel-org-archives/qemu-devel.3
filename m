Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2457BCD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcIS-0007C5-Qx; Tue, 02 Jun 2026 23:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI2-0006fw-W8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:11 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcI0-0003dR-E6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-842307473b5so2558261b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457347; x=1781062147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XREooIk8/Ytryetxg3cSydG2ExCCSz7Qnq/NqYJ+6FE=;
 b=KwW1ISu5YFtpbPeFiQyeXsFcQRXZqXJDWM5uLQBr/SrvUAb45JtbIK75w8xGClxIh+
 9J1m/pCBGSL9rFwwoMcywDB9vj7irPl1X5zydn4e5sAUrtW9L5QKzr+X+ijI+m7rJ28y
 sonyUD2CpdoyQLebc9SeTrwYUtR0v1L7O/0GN1ngdxuL6pK57bctn3yx0qSVwkwsedZy
 pLDj4vLj4G3/IxEeXt9rgwXukj7Q1B0T3t9vni1k1/UlLXuvD7ksZcxDdVcwA7NorisJ
 NGzDDRsvVtqrlwDRwJWsdWPAhed87Mn584bqRzmfh3Opago5bbxIro+f6F0b4R7k6AdQ
 zENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457347; x=1781062147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XREooIk8/Ytryetxg3cSydG2ExCCSz7Qnq/NqYJ+6FE=;
 b=l9ebRS/lp6JS3/6kKmYtzy93+z2ocHRoGvb8o1+GdSp+zS7+owYOTfRtv+KhE9pJRX
 7quUCYtVo3VaAZeI/iFENTr/JP5S9LHAQd+aZq/WGLvu+B3CuPJpZIf9AWf456ib6dLB
 HGBjxr1VScqlWgDnz6bVG1VjBvNz/3ZXVBvJAFkNnbs2nbvyqvn/777Em8g1XZy01KEJ
 RoA4WuCHTAbfii1lnvlMHcFf5FSkbp03jvcYf2IlSRXf2mR9zZm1T7/UsUYc9Xbr40Li
 3Kp84RJqqqCprauFexq2zri7N8IXMQ0QTu6cynyIUtlSB28daNQj9A4roJwkyLqbhUOe
 cT4g==
X-Gm-Message-State: AOJu0YwwgV0Vvo9Jhb+866rzpDAZbtxBGHUsKCz3MTpgqrng5gJfptRj
 jZBMCrwQUblpg0yvn2rGMEIWWkmsh4jH+0/I8FJBVpYigfZDZgPKpvGRxiGGl4nWSczyj6Q24V/
 LWqBiKVM=
X-Gm-Gg: Acq92OE/MOhXWKIWxM0j2lMk+7KNPt29O+MswPEWTM1FxVyOFzHXX/n1QdU4jqHUn4c
 BQZVyTSSqXW2kk7bZNlQs3YBnsbnqZb2OnTud59zJw9pyJXJdMWTETo9LpVDclSLPhGCUrOYDFq
 XZwvcjKX66BzNq5bELdumsit7rWwVPZjwuaVZxHCF37GGDNtRj4D/gUTBYfREGjU6anpcXPTLQJ
 8OYOPmmRYPZnfCwtMjFNE5akwBk+1G8zIFkQiAU48YFf6HQdsQNa9fOZs+yHj0bsJ1vJfXwJAo9
 nT8n3VPYksLJo9+x632pkSXo5c60n3MtYbGVQ5foS67rFCeSjuA84Eo8cXQWM/JsVVOpgYlP+fN
 taPfFMVZzCyL38xl44LKJqTuZbt0qtcNy54rERHt6k7Ytpk51SWU4XJVLAVQiHcZQY0LlFJ/3Ux
 7RGbZUTrKvYaGdZvQiTAixe3/QP2+nu7UPDteahc0=
X-Received: by 2002:a05:6a00:bd84:b0:837:db4e:a35d with SMTP id
 d2e1a72fcca58-84284e8e33amr1652325b3a.23.1780457346807; 
 Tue, 02 Jun 2026 20:29:06 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 15/45] target/arm: Implement FCVTN (16- to 8-bit fp) for
 AdvSIMD
Date: Tue,  2 Jun 2026 20:28:24 -0700
Message-ID: <20260603032855.106930-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 target/arm/tcg/fp8_helper.c      | 37 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 15 +++++++++++++
 target/arm/tcg/a64.decode        |  2 ++
 4 files changed, 56 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index bbc8d69e28..6530d1a6da 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -14,3 +14,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvt_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index ffeaf02f97..8e7982a888 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -180,6 +180,13 @@ static uint8_t fcvt_b16_to_fp8(bfloat16 x, fcvt_fp8_output_fn *f8fmt,
     return f8fmt(&p, scale, saturate, s);
 }
 
+static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = float16_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -369,3 +376,33 @@ void HELPER(sve2_bfcvtn_bh)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 
     fp8_cvt_finish(env, &ctx);
 }
+
+void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, true);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint16_t *n = vn;
+    uint16_t *m = vm;
+    uint8_t *d = vd;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 2;
+    ARMVectorReg scratch;
+
+    if (vd == vm) {
+        m = memcpy(&scratch, vm, oprsz);
+    }
+
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H1(i)] = fcvt_f16_to_fp8(n[H2(i)], output_fmt,
+                                   ctx.scale, osc, &ctx.stat);
+    }
+    for (size_t i = 0; i < nelem; ++i) {
+        d[H1(i) + nelem] = fcvt_f16_to_fp8(m[H2(i)], output_fmt,
+                                           ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5266bbc413..9415419f19 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6605,6 +6605,21 @@ static gen_helper_gvec_3_ptr * const f_vector_fscale[3] = {
 };
 TRANS_FEAT(FSCALE, aa64_f8cvt, do_fp3_vector, a, 0, f_vector_fscale)
 
+static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, a->q ? 16 : 8, vec_full_reg_size(s),
+                           FPST_A64 << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 3c806259f9..b08895d917 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1212,6 +1212,8 @@ FAMIN           0.10 1110 1.1 ..... 11011 1 ..... ..... @qrrr_sd
 FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
+FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
-- 
2.43.0


