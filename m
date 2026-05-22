Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172B6CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQY31-0002L5-UH; Fri, 22 May 2026 18:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1H-0006kQ-4U
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQY1C-0002af-Ma
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:07:01 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b45cb89f7eso53327205ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779487615; x=1780092415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXEB2UcZM2l2jdzFCAfmcvzI5GkMbps0o1syZVwrYgc=;
 b=uMdtoS+ZVhoxWIO2VNWtnAk6G7b+m1/9XYcLH0Jhc1yHi7Bfmp5WKWbNZP/6aqnSLp
 x3G4FCN4R7QF90+NlyoLNdzBhHEPauFSYxDWRxP+WOv5EnsNrSSfRQG5VLFEexImRkF2
 ZvvPG1C3kfLGphDOar2UwDXhv+xrmKRqkmRa8iBKqTGTpQP8r/ULY30LHx0Z0GBbKxkM
 v5Eo0lCGNCFQ3FFPeo/HNPuN0vcp27/NCIDPVBnxNTPabT9KT6leP02hFpsPOEstsbSA
 oMzePKz2h1rpSW+OxkNudO7TAVOT108wjlZ45v1Z7++3alQqPZab3xk3jyYKpgdB/Brq
 gUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779487615; x=1780092415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OXEB2UcZM2l2jdzFCAfmcvzI5GkMbps0o1syZVwrYgc=;
 b=ef3Xs2leFFTOr1jZV8HY5S2+sP44ls0rpQ28qzs5xJ4nUDcOI3jYPC5T0aGi7Nu6z6
 ewURS8KYXGXu9J0MfPOuekKrvhOLzYhaOXkGjuntXly32FspOR9Js0jQyftink5icVya
 bx8y2w1IzBytCWkBNOWhIz6pinEiq09p1utnRvdiFQjKlFTNQBwBCJHHuxGtCHsZratE
 //2sZEssO2wCyE4mI3vWEdlZQrXdHPSAKwGWMFrZQ6+KAZext7c4K1UbzWE0NCVNfYRU
 L+sBkAcVnW9vwqrrM/OSZOM0Kgr5EtTP7p60cPnKi8mG5cS0S8xk0JmMtoftobfM6VBP
 OjZw==
X-Gm-Message-State: AOJu0YwBQWOXFTBByO0c1hvyUqSyrsj7yHi7atVMBVAxxnxx1uhYpZr2
 ilanNT+eJaTv3XVDxS4ydwpq0ezkYiHHDHNW1CeslNI401RyN+fZPCJxMzExyNWDlUGlXJ0eIti
 Q+2RO
X-Gm-Gg: Acq92OELjsRH2meFOxWW24SMCR401r8ZsCAGIzHo0G7nypFKXmZ6MxcCJZ51yZL7uXr
 Rx9C3xneeX4f1l/5dMKP4GITk7cAOzH+8qDupzmEz3erzyovTVt1kxd1rsre7X+wzR9ofJgUQ4T
 kzyiawtb/UmVV/MjceL70Iradm2mTDxCVi0DGy8tUkVKLlzRAnfmrMw5OVBVsZE7RuPRO+iH+x3
 QV9ViuJjKnkHlrgVW/nmljNWsGK4O5PBHhAQ2gxbnYQnoRwcKUnsjMnRHqm94Wa5HhzWNKwdU0K
 wFDCDe8wsXZ7WDNTpRryOf5JaGoSEnR094cphRgvG+Y5Vun8sLT0HOqWtCmlQxVhZMOOIeSFXP3
 FfGTpF8Wm3FpgqxeI1P9lIn6/hPp+Pl7IaVFK/+nSbdI0JpzZs08X/BIt5a262/synM0S6TzkjB
 o5j//+npLqn91d/myr+O3V0w6ggAmg
X-Received: by 2002:a17:903:1b28:b0:2bd:606d:b342 with SMTP id
 d9443c01a7336-2beb05d366amr65140385ad.26.1779487615458; 
 Fri, 22 May 2026 15:06:55 -0700 (PDT)
Received: from stoup.. ([50.78.183.177]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b7920sm27835745ad.21.2026.05.22.15.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:06:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v7 50/64] target/arm: Implement FMLALL{BB, BT, TB,
 TT} for AdvSIMD
Date: Fri, 22 May 2026 15:02:52 -0700
Message-ID: <20260522220306.235200-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522220306.235200-1-richard.henderson@linaro.org>
References: <20260522220306.235200-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
 target/arm/tcg/helper-fp8-defs.h |  3 ++
 target/arm/tcg/fp8_helper.c      | 55 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  3 ++
 target/arm/tcg/a64.decode        |  7 ++++
 4 files changed, 68 insertions(+)

diff --git a/target/arm/tcg/helper-fp8-defs.h b/target/arm/tcg/helper-fp8-defs.h
index 7aa8366d94..802a3b430e 100644
--- a/target/arm/tcg/helper-fp8-defs.h
+++ b/target/arm/tcg/helper-fp8-defs.h
@@ -26,3 +26,6 @@ DEF_HELPER_FLAGS_4(sme2_fcvtn_bs, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_5(gvec_fmla_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(gvec_fmla_idx_hb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmla_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(gvec_fmla_idx_sb, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 316e151817..2e3eb43799 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -629,6 +629,16 @@ static float16 f8dotadd_h(uint64_t a, uint64_t b, int n, float16 c,
     return float16_round_pack_canonical(&p0, &ctx->stat);
 }
 
+static float32 f8dotadd_s(uint64_t a, uint64_t b, int n, float32 c,
+                          FP8MulContext *ctx)
+{
+    FloatParts64 p0 = f8dot(a, b, n, ctx);
+    FloatParts64 p1 = float32_unpack_canonical(c, &ctx->stat);
+
+    p0 = parts64_addsub(&p0, &p1, &ctx->stat, false);
+    return float32_round_pack_canonical(&p0, &ctx->stat);
+}
+
 void HELPER(gvec_fmla_hb)(void *vd, void *vn, void *vm,
                           CPUARMState *env, uint32_t desc)
 {
@@ -673,3 +683,48 @@ void HELPER(gvec_fmla_idx_hb)(void *vd, void *vn, void *vm,
 
     clear_tail(vd, oprsz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_fmla_sb)(void *vd, void *vn, void *vm,
+                          CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t idx = extract32(desc, SIMD_DATA_SHIFT, 2);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint8_t *n = vn;
+    uint8_t *m = vm;
+    float32 *d = vd;
+
+    for (size_t i = 0; i < nelem; i++) {
+        uint8_t e0 = n[H1(4 * i + idx)];
+        uint8_t e1 = m[H1(4 * i + idx)];
+
+        d[H4(i)] = f8dotadd_s(e0, e1, 1, d[H4(i)], &ctx);
+    }
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_fmla_idx_sb)(void *vd, void *vn, void *vm,
+                              CPUARMState *env, uint32_t desc)
+{
+    FP8MulContext ctx = fp8_mul_start(env, -1);
+    size_t idx_n = extract32(desc, SIMD_DATA_SHIFT, 2);
+    size_t idx_m = extract32(desc, SIMD_DATA_SHIFT + 2, 4);
+    size_t oprsz = simd_oprsz(desc);
+    size_t nelem = oprsz / 4;
+    uint8_t *n = vn;
+    uint8_t *m = vm;
+    float32 *d = vd;
+    size_t i = 0;
+
+    do {
+        uint8_t e1 = m[4 * i + H1(idx_m)];
+        do {
+            uint8_t e0 = n[H1(4 * i + idx_n)];
+            d[H4(i)] = f8dotadd_s(e0, e1, 1, d[H4(i)], &ctx);
+        } while (++i % 4 != 0);
+    } while (i < nelem);
+
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 61ca7ff920..a9e816fe3e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7397,6 +7397,9 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a,
 TRANS_FEAT(FMLAL_hb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
+TRANS_FEAT(FMLALL_sb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS_FEAT(FMLALL_sb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b89e83ce76..ef6d7dfeaa 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1209,6 +1209,10 @@ FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
                 &rxx idxm=0
 
+%fmlall_idxn    30:1 22:1
+FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
+                &rxx idxm=0 idxn=%fmlall_idxn
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1330,6 +1334,9 @@ SQDMLSL_vi      0.00 1111 10 . ..... 0111 . 0 ..... .....   @qrrx_s
 FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4
 
+FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
+                &rxx idxm=%hlm4 idxn=%fmlall_idxn
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


