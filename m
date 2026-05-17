Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E1DCD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPSO-00077A-OM; Sat, 16 May 2026 20:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS3-0006lq-Hq
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPS1-0006p1-AO
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:33:51 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8354461da74so445557b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778978028; x=1779582828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7WaWIKYy3emvF0VwlyQzMnR89eKObPqPn6UcKborl8=;
 b=PIuzys9nkIfUqCn8EWFwpHtC8D2bGm5G3K8lnKRbhPpcxARNEE21JNXV29lUcKfFb1
 BfSWWG96JzSdKDVxSFpfc3EoydqG3qNAZ3O5Biwpgy0cDySw2U0dNQm2w/XqOZLEgbkQ
 6s8yKkt/BgDTJulCj4j4oJWu+OQa1PTZddU4Ln+dGcDNpO+MEpLForHUQSBv1HVYqmwl
 tc5AeSUmCSb+oyGKN6F8nonOztYA/AE2eRqJmPXKv31DrhuA1lGLGnN5YHGuwIiUoc7k
 pJd6zc5lh9qvu7ISRwNbXXYppZUhDZswZPJgrrSrZMgD6yuzG+LjUFMUBBgMPfeKTXJS
 NhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778978028; x=1779582828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q7WaWIKYy3emvF0VwlyQzMnR89eKObPqPn6UcKborl8=;
 b=UrBO8qLs2V2k5My6xxSphQWoG5PUCroBe1wSQo5NfczACkhOsRQvfoKnBn2A6ty7/y
 15+GuVX72OVDUTa1N3la+STsBvtKZi0DeDJI7I4id9QZgLLPmoyj0DgECNkglrOHrw/I
 HNEwXhVxalGWrtAVziP60bfWXLndYW8rLqYYN+HMhSW1Wl30zgV89TUlSpiqpcYgBoyx
 GwhnnkNX5fXhga/UnVeGadp0C2SQ4xHuI5J2V4uWgIpp1PVuFyfqIymYAYExsaxwOJHm
 KxNaMOC1RAVbq03ZRfiEj3EzVeQwklyo2rwgjVwc5uXjKzhuIS1DBlIOaarFw+Pbf/8a
 1Ezg==
X-Gm-Message-State: AOJu0YzWU3OlLV9Lwi2pOo2dMrMBdJFg5uDnawi7eEwW1aax7XiBqv0U
 OHBgVPDflpwvAY1WRZpWPQS5qUCOIKyxGdaXIu68zj2Hxmu3c+Bq429pIQdnCrhbj4gmqYOCORx
 KLt5o
X-Gm-Gg: Acq92OEV46PrxOsJfTxKgdtz8iCpeSC0uiY5Nxhnj6BHeut4DS2Ztm/1IfQUi3+SSb8
 AyrvU8nmFdVqB7PyD9ADzm7jGBx6btrLEn9agChv9qLuquj6rcoP97jCeNLuhUeK0oqYpc1sI9j
 QTstEQ8ehnJgGRnHdaep/o8Tjzc81u3OA5u0f6VMrLq69rolWAi3cdIjiq8pzsSp8sxIF8uLgnR
 WrPIdv1+zP7KeS477E0Vk7XrOedZtqQdx8inbeN4fRYgxqvZ+VrL27ZCJP/7JdbaFWGgxiPK62Q
 obFKKhgT5GdP7wwZ1SpDe8ywqwJcsHZ/dIV/3hFjRuybhseKFPHaTdGTW5bUU+0cteKJOygimuF
 y/tzIViyiADWMfW4O8wZSSlNri7NMQgpHkPWm7Sp5LXsDUyypEGw7cX4sJsyCwmfGKfpmXv52a/
 cOQlLhSRNoeOZ7lb4cayqthZqC7ZBh
X-Received: by 2002:a05:6a20:3d8f:b0:3aa:c95f:f65 with SMTP id
 adf61e73a8af0-3b22ecfa3c2mr10955195637.32.1778978027619; 
 Sat, 16 May 2026 17:33:47 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm3010559a12.19.2026.05.16.17.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:33:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 47/63] target/arm: Implement FMLALL{BB, BT, TB,
 TT} for AdvSIMD
Date: Sat, 16 May 2026 17:29:46 -0700
Message-ID: <20260517003002.321430-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/tcg/fp8_helper.c      | 57 ++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-a64.c   |  3 ++
 target/arm/tcg/a64.decode        |  7 ++++
 4 files changed, 70 insertions(+)

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
index c873de65cd..de31903129 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -638,6 +638,16 @@ static float16 f8dotadd_h(uint64_t a, uint64_t b, int n, float16 c,
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
@@ -684,3 +694,50 @@ void HELPER(gvec_fmla_idx_hb)(void *vd, void *vn, void *vm,
     fp8_mul_finish(env, &ctx);
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
+    fp8_mul_finish(env, &ctx);
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
+    fp8_mul_finish(env, &ctx);
+    clear_tail(vd, oprsz, simd_maxsz(desc));
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1c1d4ad2f7..946c16d439 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7400,6 +7400,9 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a,
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


