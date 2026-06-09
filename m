Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D41CD98CA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:29:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX270-0001pn-G2; Tue, 09 Jun 2026 15:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21v-0003aI-3A
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21o-00044P-HP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso61964475ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032883; x=1781637683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybfc9/84kaK89cj9awAqOn1QSIiEVQTPnx128PRnNeE=;
 b=hd8D7rBSZltuNZk27FzH4LAnLlIAAcifd1M6UMbh6Zc0xUtgPT5UvGHIyJ9UBfl1Pj
 Gw2C3dKEPNlEXexmGSJb1m0t/GYE8Moc8rutbyiql8lrHp1tscWK5sL/PVuaWyxoeMpg
 8gOiKH4Bnhd7xW+suDA0apuYxi9y9gpfDuv6kcmeuCip2Jcz2q+Otz5wMTqeQgjEolIO
 YUSKTdPajAdGnytKURfOL5mqqnu1M5Fv8P6kce3OC1zqrCI1jUPdEpCileVC3kBhHzqA
 s4WlXnFR5cGGjU6i4qyBAeJvFZBroIhHajr0Yvzbc8++gKfoTSM88JjL4MuWZH2fLTn/
 CW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032883; x=1781637683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ybfc9/84kaK89cj9awAqOn1QSIiEVQTPnx128PRnNeE=;
 b=gMmXll1JE+y5MGTh01rLpIQdlYeI3zXgz3phND1QblucL4qwIIfBRxdZPq2OMAzxYf
 0350JkVxkRtyY/lnUOrfvCbFJ66I7C20wjuVNg42B36DBY6f7YBGD7htKeUA0NAl7mxQ
 KHTVwuiSDeDBCy1AkUBbgrEqwXaVZq8ormeG/oHeBeASBgFYFpI0czPC0Di6Xrbc061J
 nsL7hgMvfZ1T5xmLQH5qQzN5E/a/QPsWMUT1id34582HfcZtpD5iP549T4InwPymXnkQ
 q6I6Hs4xGUqtarN5r017iyjZZxTyRyBtI8CAY7soo47oEJTShiXHNEI/rQFMnBveow0M
 2veQ==
X-Gm-Message-State: AOJu0YyMcBKBjhkGDxGgQQ4xMT8W/SoOc4AGmxaLa/YzZCEhd1KgojiW
 VRJ4Sc+b1NQxkLfFnqVNW7cMBR153weCFf2P5IXVGUrxGd53orQsLTJnUcIwVU1Kd740kaXsDTu
 unebV42c=
X-Gm-Gg: Acq92OElQqxUK2+rw/h95s6E6jgU5x1/noh/vE/b2JSorStZgNlPZ/IqN+RTSCHMGNS
 XUXwgcIU6bPVEWXwezHRv91uwy7ZdR7u0f3aAITxq0ArufSE5DcwCw+dioXDQpZ9OXI/GunrWsJ
 bbWzaH9U6uhkwk2sx8dhtcyEA9YyG68SrfuuIEmz0VSB5xWSMzSKCuip4i1VJJeG52Y6cn1XzhU
 TYS6WrhzuIp3wkqd52TVhJrnvU9u6ekPnhTBgPzk8watn1UWFblwrGCh/tunobt09kyqjrzbXJB
 1K/bEeE4PHdPBvKPHOrfxQVFToXhdo8Fn1lElBDfCO7WF5o7svgHSivILMen9PqPaStN7tK3g4t
 J7Gk6dlM4gSjGf6BibAgTXDNwM1LsP2cSWTM/LSn2TPVFYy6D2VGe4N31c/UxbDnOwgQwSdALT5
 EkP4MHnLG0PGy/JZQZRymk50UipAGOSpmLGydeL2I=
X-Received: by 2002:a17:903:3847:b0:2c0:c262:b917 with SMTP id
 d9443c01a7336-2c1e80e429amr255049135ad.5.1781032882959; 
 Tue, 09 Jun 2026 12:21:22 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 16/45] target/arm: Implement FCVTN,
 FCVTN2 (32- to 8-bit fp) for AdvSIMD
Date: Tue,  9 Jun 2026 12:20:40 -0700
Message-ID: <20260609192110.752384-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 target/arm/tcg/fp8_helper.c      | 33 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   | 16 ++++++++++++++++
 target/arm/tcg/a64.decode        |  1 +
 4 files changed, 52 insertions(+)

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
index 8e7982a888..0b86ed9eb9 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -187,6 +187,13 @@ static uint8_t fcvt_f16_to_fp8(float16 x, fcvt_fp8_output_fn *f8fmt,
     return f8fmt(&p, scale, saturate, s);
 }
 
+static uint8_t fcvt_f32_to_fp8(float32 x, fcvt_fp8_output_fn *f8fmt,
+                               int scale, bool saturate, float_status *s)
+{
+    FloatParts64 p = float32_unpack_canonical(x, s);
+    return f8fmt(&p, scale, saturate, s);
+}
+
 void HELPER(advsimd_bfcvtl)(void *vd, void *vn, CPUARMState *env, uint32_t desc)
 {
     FP8Context ctx = fp8_src_start(env, desc, 0x3f);
@@ -406,3 +413,29 @@ void HELPER(gvec_fcvt_bh)(void *vd, void *vn, void *vm,
     fp8_cvt_finish(env, &ctx);
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(advsimd_fcvt_bs)(void *vd, void *vn, void *vm,
+                             CPUARMState *env, uint32_t desc)
+{
+    FP8Context ctx = fp8_dst_start(env, desc, false);
+    fcvt_fp8_output_fn *output_fmt = fcvt_fp8_output_fmt[ctx.f8fmt];
+    uint32_t *n = vn, *m = vm, scratch[4];
+    uint8_t *d = vd + 8 * ctx.high;
+    bool osc = FIELD_EX64(env->vfp.fpmr, FPMR, OSC);
+
+    if (vd == vm) {
+        m = memcpy(scratch, vm, 16);
+    }
+
+    for (size_t i = 0; i < 4; ++i) {
+        d[H1(i + 0)] = fcvt_f32_to_fp8(n[H4(i)], output_fmt,
+                                       ctx.scale, osc, &ctx.stat);
+    }
+    for (size_t i = 0; i < 4; ++i) {
+        d[H1(i + 4)] = fcvt_f32_to_fp8(m[H4(i)], output_fmt,
+                                       ctx.scale, osc, &ctx.stat);
+    }
+
+    fp8_cvt_finish(env, &ctx);
+    clear_tail(vd, ctx.high ? 16 : 8, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 9415419f19..75be92ce15 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -6620,6 +6620,22 @@ static bool trans_FCVTN_bh(DisasContext *s, arg_qrrr_e *a)
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
index b08895d917..610047846f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1213,6 +1213,7 @@ FSCALE          0.10 1110 110 ..... 00111 1 ..... ..... @qrrr_h
 FSCALE          0.10 1110 1.1 ..... 11111 1 ..... ..... @qrrr_sd
 
 FCVTN_bh        0.00 1110 010 ..... 11110 1 ..... ..... @qrrr_h
+FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 
 ### Advanced SIMD scalar x indexed element
 
-- 
2.43.0


