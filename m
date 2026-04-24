Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22DBFB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DT-0002gM-BD; Fri, 24 Apr 2026 00:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DR-0002Zr-JQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:33 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8DP-0003ab-Sq
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:33 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-679b072ed3aso3637036eaf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005151; x=1777609951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW+LW+Nt1rhrQi5WxMDAPWgTbe7PVFsy6KMvcn0ZFDU=;
 b=iC13CAbZhv+xodDtkAH+3iEGg9NG9mM6Gwki2RVGqe/I1EsW5Z3EYroTKxwh8N5znM
 MiqLoFicbZ1CyNBPHPXwVc9bAkmN3iP2UrQV5zeKViabHsLyLpNfitjbVaJ0Bg5TUoPk
 /s/G1dTZt+YHs11Dr6HE80CpO9LAMy7H2ggZCbNQMJmAVzOBgUsc0RHPbTEDJwhrXypM
 9XhCcTAENA8V8CCxMFdFozZ0f90Jkb9s4e+S2aHXhEEZsM4N8C7bCXf+fiuRQ85G8M/6
 4kT78q056b//T4ev00cS2S7W1x87kgVaYpRMrDIE2Fl9O1xk7quBr/QKb/A8PYzF+OwB
 BHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005151; x=1777609951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wW+LW+Nt1rhrQi5WxMDAPWgTbe7PVFsy6KMvcn0ZFDU=;
 b=nk00EKbynz3x9ljZZa+sUaMhfXM9b5T/mmCFxpMTAljjgdPlbFAbFgmcCfDFYp/gvi
 Bjeio+riVuaRhwQeykpbGPSdPI1E52lND+DduEnwsx5hVEEB7n6zlYV0JWbOn227PWRu
 FJ1xHcwLeR6dTFQvvJStO5nzZXA1WVaEy8aHxdRR13R6UcRc/0Y75BZqQL8f/Lq0DB30
 ZtmUJqwwHaoGPCMQeu4KZ1UNlhZvVBlRxgOJth38HgpItl67VyohQgpJJha9zNOkF6yr
 O0n6GogwA+znol4JHCaRvmVfZB1M5nmVH9Vt/PN6FXBd3KdfcVW/w09zyz+wGyNaN+U1
 USzA==
X-Gm-Message-State: AOJu0YzdG6Tc+dYdTKh6Y2ZGZOk2YoGUfc9FnqzmpLCw8a1BYiQrAESg
 +DArda2ZX6CILBbjdl6qC8tuOPKVNiZYbyW/OXTx/afquyt03swHAsav2azis7UimeN9A6zCPgl
 LWzd4l2g=
X-Gm-Gg: AeBDiet/hvBFhcGfM7PgoWhBZIiwUhe0a7XViqzeTVkbVtFqpcv63tVMn2qM6B68lOf
 lLkQ2gcV2VJpJEKpr2f575+zljw/zl5SFiuD7RGp/MVdO3H6Jlc7tleODm0f1ICw21q3tRt283f
 +N3L33x7YeVo3QlhHCVAXw0lMellt2POhN1WmmWYE+AMmh3OLy/2v1KU/SqNS67Se+rVy97Ycyq
 bnOPGjfjxIn8hilHtRsqJqYPO1IOykxzJ62I/dbKVoQixMmKZAO4MHHGI13dknudsY01vJaQZGM
 hQbqh0SzAHyyD0SP6KNC6EcSeLkQ/Siz4djOdAoDgV8pDvW3/1X4qwA11OI39QMaoeYDEGHxRkX
 AVkpg5IOnrRr5bCrfQwkjgV83+gEeASozCjQGhU/WmWBEtcrf30Q68z7sYRha+UEwJ2EtzPCJWA
 LLqd43XuDOKxNlPCvmHOML8/RxiEYjSo/gdy8swWqmmXsljwKKpbPHW9ERtl1jpQ==
X-Received: by 2002:a05:6820:198e:b0:695:a86:91a1 with SMTP id
 006d021491bc7-6950a86f145mr5420990eaf.24.1777005150515; 
 Thu, 23 Apr 2026 21:32:30 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 32/40] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Fri, 24 Apr 2026 14:30:06 +1000
Message-ID: <20260424043014.46305-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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
 target/arm/tcg/fp8_helper.c      | 42 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 16 ++++++++++++
 target/arm/tcg/a64.decode        |  1 +
 4 files changed, 61 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 6530d1a6da..023a49e12f 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -16,3 +16,5 @@ DEF_HELPER_FLAGS_4(sme2_fcvtl_hb, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sve2_bfcvtn_bh, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fcvt_bh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(advsimd_fcvt_bs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 6241297269..fecd9cca0b 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -480,3 +480,45 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
+                             CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc);
+    uint32_t *n = vn, *m = vm, scratch[4];
+    uint8_t *d = vd + 8 * ctx.high;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    if (vd == vm) {
+        m = memcpy(scratch, vm, 16);
+    }
+
+    switch (ctx.f8fmt) {
+    case OFP8_E5M2:
+        for (size_t i = 0; i < 4; ++i) {
+            float32 e = n[H2(i)];
+            d[H1(i + 0)] = float32_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+        }
+        for (size_t i = 0; i < 4; ++i) {
+            float16 e = m[H2(i)];
+            d[H1(i + 4)] = float16_to_float8_e5m2(e, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    case OFP8_E4M3:
+        for (size_t i = 0; i < 4; ++i) {
+            float16 e = n[H2(i)];
+            d[H1(i + 0)] = float16_to_float8_e4m3(e, ctx.scale, osc, &ctx.stat);
+        }
+        for (size_t i = 0; i < 4; ++i) {
+            float16 e = m[H2(i)];
+            d[H1(i + 4)] = float16_to_float8_e4m3(e, ctx.scale, osc, &ctx.stat);
+        }
+        break;
+    default:
+        float8_invalid_output(d, 8, &ctx.stat);
+        break;
+    }
+
+    fp8_finish(env, &ctx);
+    clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 93c883de88..6013226266 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6536,6 +6536,22 @@ static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
     return true;
 }
 
+static bool trans_FCVTN_bs(DisasContext *s, arg_qrrr_e *a)
+{
+    if (!dc_isar_feature(aa64_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && fp_access_check(s)) {
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           tcg_env, 16, vec_full_reg_size(s),
+                           (a->q << 1) | FPST_A64 << 2,
+                           gen_helper_advsimd_fcvt_bs);
+    }
+    return true;
+}
+
 static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
 {
     if (fp_access_check(s)) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 71456d44e1..a9cf259b9b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1202,6 +1202,7 @@ FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


