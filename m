Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28121CD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX23D-00047w-Os; Tue, 09 Jun 2026 15:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21D-0003Dh-47
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:21:57 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX20x-00044C-Bt
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:21:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2c0c2c7e0c5so40496475ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032882; x=1781637682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDxUg/mo/tbA5dQbgvqIVl1Z85CmD8z4LHfJdkAjRh8=;
 b=eW6q7BWp4H9mP4wLuumkAs3NKVzydKKLQRvIgpFtN5MFpT/WwHEFw1kc8hwBtVGTU8
 YNP0SIGxqt/17GB8w3m3WzWz9zLgV1opVra5xbzaJ0i0MlewsHeB9woycAG3oOvlRHsg
 0tCIo0u9F0UiNGSO8Frlhd0mGUCGeTVuUScwV/61TYVhQfO7RHF7+neDUQFBf8kUUdQD
 9nvI/hPO3bkb25YcbTSbAdH/LjmdfVfmWH0cLEtZ8An2h2sr/BY5TwEw3H3huBVITyQf
 4awvD6e9ApvoNbbYPKFZpTMH49qC+H3/hXHAgJaeYj9fwh6Bvfhbe4H6ZnbKwrm9Voav
 wJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032882; x=1781637682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FDxUg/mo/tbA5dQbgvqIVl1Z85CmD8z4LHfJdkAjRh8=;
 b=D56CyA063tbzfYOLLZG4aldqs/U4cDdsapWp0naxzMu8na/kc4iMZPgwC4xidp4ie4
 f+OGqjqkMYogQDCNu9c7BBlPxZ035s55zXtD845FRV7KP8Ei1U/eoH4t31teeUqpVLpT
 eUBZeZqlILBe44pduxB3Kql/tipE5ql360spWAp40kUDhwwMP9tZplfiY/uYVk0VZgwF
 qbdpAYw882GTxkLSbQ6tm5f8LmaObaZ4GyxRJtBKliMbcJ2cL1/klT33hu/HMQq2PZRO
 VZOi0fsKsrMZmPiQPvu4eDX4gKy+yYygszW0lkvD58ZlcEsUF9VAUukhE4rZa1SvqP1q
 mh/g==
X-Gm-Message-State: AOJu0YwBtjktB2t8wAxnebK+IgcX16DzciZVs6Dv5dTxyvij7YZ2mEqq
 j2BiJl+2zgjeqL1p5wrW69hL8zxra1AnbmggqHipCA1namrgx5L7O1sQDgNEToekcz04WhNz5qK
 fLJVToLk=
X-Gm-Gg: Acq92OErJp8dJPsXNlSlPTtcA/cpeqiKQ+8/euqN/3KkKTA8hNbX2zJAdRXnlg5merM
 8kLldsI170L4HHrGUxnq1AnQ4TZZXaCJG7z0VT8PGgJeIcxRQThoC/4fNcNER3EX6boKKEOWoZC
 67vp398HSHHDZlDG6LBFxB75xlKbBCbf2hiWHuAjuL9jFiT3H8Nsi5LUiA7tUOaK/x+2Sy93Zbi
 jIJ/gofix+BGZfWkyut92pgIHHr4Jm3aZMhrsiQcoGNhl3jiheTgdbzukiZDarBoTNyR17oJ6kp
 QfUXQtehhFf6tt4uy689Ur7VnzOdIpHcdyt6DQMGzBswtvNFk3gPRav0WgU/KYnmsAFuJxq53Hg
 Dms5IC4n8uFzEa0i3yTWTQ3P8Ew2OJ65l+ok3O0qgExSll4DlYw1kHA6QzgSnE8f0Hn6yGqsz3F
 aNWp8FpBZU/foruMc6BXYhIrJBN1oA+E379Jj7tPM=
X-Received: by 2002:a17:903:2381:b0:2c2:27be:39a7 with SMTP id
 d9443c01a7336-2c2a1c9ac2emr52031735ad.29.1781032882318; 
 Tue, 09 Jun 2026 12:21:22 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 15/45] target/arm: Implement FCVTN (16- to 8-bit fp) for
 AdvSIMD
Date: Tue,  9 Jun 2026 12:20:39 -0700
Message-ID: <20260609192110.752384-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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


