Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD7FCD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:16:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrU-0000Lv-Ry; Sat, 30 May 2026 19:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrU-0000Km-2L
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:13:00 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSrS-0007aS-7N
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:59 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c856db4fcacso1942966a12.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182777; x=1780787577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8638pdFBL8KDRGiBmUmVT7L/zfj6XnB9LqR0Mzcf5iM=;
 b=wGBu0joyEOUyHm2gsozMA0poMyxSdiyGQhVzZ0DlMKTbgDVUchVk4qoQs6CuC2sBJu
 EoRj830S0ieX7HKQ/VrX/crUieWZzA8sV2yqitgF+cc9d1NOwc/SR2rzQxdvSPLAq2wT
 8eYxyXfnpFC83GR/82/KaKfs3QnmlgRWWqnnKhlKxOp94hXM8Ub0Tw8R9QJkfzXtixmo
 9u3h4O9TAkpUcK3t6C2socMQmzN7lyx0qHyeSetbkhxOT1FKnJRGkQTblGfx/ypcF4R5
 Mgn7Z0qLbLXHXnLRH2M8SO2iCDa6iN+hPNOumNUhB4qtRir9WEOq6LEUd3zz8PZVb4yV
 Avug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182777; x=1780787577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8638pdFBL8KDRGiBmUmVT7L/zfj6XnB9LqR0Mzcf5iM=;
 b=MkCtcjaddReYHHEHTSWUiPx14TPpkrjwuKAM2kjbptblkG7KM8rNgUQHAlEtzxUhPv
 i2MUn2S8AECce8G1ipvMoPjz1odDcfPVCBXFcMVLl6uqgPdR2DxR419K2s9Kvtamaf40
 lqre/AHTCFEdDY/OfNaYzSHGxJsx2R2955fGpxOz91vf9Mc4/uYSMCP+jbxwrhG+WqW2
 HJXv2grFGmL1aduldR6To7iLUKiT0QpRmaH2d5Z5sm6X0DeuD+2VF61QVsJT2hazQZV3
 9FlNUkLGbAAiOYBw6pChrkSDo1ky7dvZEVt3OXqrDxVbsGW3QEbM+KQnO5JiI6AnZukv
 cgFA==
X-Gm-Message-State: AOJu0Yylgjl2kMq2up+3j+XTJCAXt3y90ChKXSLzSUMOBsvqfcbwpoOx
 9YsLRG50Ld9tEWwtk3LApRuDlAH3cAeDzKOJuPscjBNKIiuvxpzf490ogNM/cWg2xrqAGp6StDM
 MBCi5fE0=
X-Gm-Gg: Acq92OFb/Dlrbcu1rDWKbix5AUIzHqhcinioNbVQ6iJOj8d1RRHgClx8l/Nf0GEt2fG
 ZG7LhjWMBRARaxYSP4x8tChFyki1xewDOzxf0qjjrosBMKTwse9S5vB/Z/PuTiAqY56VCmNtrS/
 uF6cOkaRUog+mtZ1kW165PY9FdwoB6iaQxL9EoN2aVSRugFJGDPyhiEyWK80KXzvhkyYBNq87mi
 ybi0V63svwDVvEyqSCv0Vv7MzaCWhmEuihYP/H2Lkv/v8f8b8OopPAevHP6lkeYknMglc5HeTSk
 b9xpBd9nsIHGYAZ8EWEGpd956AbySgE01rJkva7vS+5FG2IfDo+8Vrg5yaXbDkspAsf4PgPPzrT
 o6EyTv6JyXlUBACBWiO73XXPbEHTfN+BwzIZ6h3n9aui3l111Yxlx8MM4HjY7ylL/fExSzOlpj+
 twSlhFTUsLC3LGNlBfLYudahseAYpiqd5VdsOrAKQ=
X-Received: by 2002:a05:6a21:4584:b0:3a2:e089:ae5a with SMTP id
 adf61e73a8af0-3b427e73a57mr5123330637.20.1780182776785; 
 Sat, 30 May 2026 16:12:56 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v8 27/41] target/arm: Implement FMLALL{BB, BT, TB,
 TT} for AdvSIMD
Date: Sat, 30 May 2026 16:12:15 -0700
Message-ID: <20260530231229.400441-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
index 4abf75531f..b58a55895b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7483,6 +7483,9 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a,
 TRANS_FEAT(FMLAL_hb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
+TRANS_FEAT(FMLALL_sb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS_FEAT(FMLALL_sb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 715d5f05d8..ee7391a13c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1220,6 +1220,10 @@ FCVTN_bs        0.00 1110 000 ..... 11110 1 ..... ..... @qrrr_h
 FMLAL_hb_v      0 idxn:1 00 1110 110 rm:5 11111 1 rn:5 rd:5 \
                 &rxx idxm=0
 
+%fmlall_idxn    30:1 22:1
+FMLALL_sb_v     0.00 1110 0.0 rm:5 110001 rn:5 rd:5 \
+                &rxx idxm=0 idxn=%fmlall_idxn
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
@@ -1341,6 +1345,9 @@ SQDMLSL_vi      0.00 1111 10 . ..... 0111 . 0 ..... .....   @qrrx_s
 FMLAL_hb_vi     0 idxn:1 00 1111 11 ... rm:3 0000 . 0 rn:5 rd:5 \
                 &rxx idxm=%hlm4
 
+FMLALL_sb_vi    0 . 10 1111 0 . ... rm:3 1000 . 0 rn:5 rd:5 \
+                &rxx idxm=%hlm4 idxn=%fmlall_idxn
+
 # Floating-point conditional select
 
 FCSEL           0001 1110 .. 1 rm:5 cond:4 11 rn:5 rd:5     esz=%esz_hsd
-- 
2.43.0


