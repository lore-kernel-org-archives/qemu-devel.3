Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2343CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYd-0002yq-Ap; Wed, 10 Jun 2026 12:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYT-0002fR-Cr
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYR-0006FS-I3
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so5012458f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781108002; x=1781712802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PWmBr2J2uHzctO6k7c0bcJtZDBQylgOkegKSegXlwOg=;
 b=ryHYk/515BMf90PxPl8IS9UWOn+wu6qHJf7FLqBZtDqbWiyFbis5n3LdZBWiFxBTk4
 ZhpAvzdVjsvgCARe0j+9htjfTkUEjOeUBE7uIAWAgZMxk1Z1DNW2IbPogALd395kq4Yg
 gL9oy7PJX/7Fj7yZoVCfOeY9UrB5Kyk23L/Q48326u8HWPHtWz/AIGlPrctWIeE9E7I4
 S9ScyBrMJzt16sxDVNNy2phx2VndXhr3sn5eVtSKDYOUSnYjnah7r2Oez/Vzuj64WVG3
 iKTxv/OHRvXKQzRoBqcF+VrLXNrHy4Qy9mDtASn63urkNlv4WkppKSY4FIiTZXBMoMMA
 A3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781108002; x=1781712802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PWmBr2J2uHzctO6k7c0bcJtZDBQylgOkegKSegXlwOg=;
 b=YZcgV++QSueoHMe/CFB/4jHjItF/HUMyDtRRdR4ekfO8PWuzjgUFFbq5V5inMhwJ9t
 isV2u2ulrvBL+aSNi3302UZqx/Pev97JpAYzYYk6SZaNYWPcFdqsVfZl9NdcQ8RY1QK9
 DBf9W97LuhtLzvHvDzdogk/A3QXuivyllN2ndOlB/CPdo2gtFpS7gz6S659uGaRPJf42
 O1NvMm3H4dFT++qumkarV7lkvFCSO7BBsQQ2eu0jhyAchN5tBHuRFTp78eAwX42psSSx
 1Sa2+ko1vxCNMHOpvZqIcyfiniZ2urXXLbkK2TXfo+T19GzOI3Pg/fK38KnQewAWrA2p
 gOYQ==
X-Gm-Message-State: AOJu0YyQQ8D39HfOBFVeNvv7xjjpPhRA/y9aYxT+Y5WqLdWYW1d69xQD
 0In5ouKkNzBq9SbPzCXxVHJTsUFi7L3gLR+DorgLT7aqcn+6FgqDCbrk5bdur1kDZvvbzkPoEAV
 NktPO
X-Gm-Gg: Acq92OH1JC8tmIZYiIVpa6e2JtZi8v0bhy7Ai7BjNcEP9eN2nk0OEkMS4um0psgH+Kf
 JBFidyxXj76ZPPL7gpPciSKsCb68ipON1j91FNYWkrKfh6h+wkyy95hiKsjR4DmYjEwQUXr4A9n
 qRz5g/iWIf3lOWJX89GNDh6hCHBdrENcVxTSOg0Iyl/wS7bLf7XXEeW7NpAQSiKdsP3wfzhhjyB
 4ywDBy5XsHsLI2OkDWgIv0rapYEy8dzFsi23NyELmHJjZKXxrZyGyDFgPhOQ/v3sJ3hj6wTSOGt
 G1jjgFEHJTJTW5o3lJDu9f3xl/LnSZKh3FV8TsEC8pKfmdceyzOUoTbnBImC3CnQRUVR91zs1S9
 wiI3Whm4V8HP9/+i0yxwfDLSrkMaJ3Q93T3eiszXZj9MHXWN42nwu6yASL2U6IV27adfZ+fa8bH
 3g1FenMkmwNfUZsRrCjQFM5x1Elt0TRTQ7sJG8NEmZKucOFn6oV31JAnTsKjzSMqoCvbBc0CUJV
 xeNXw//a0yso2C7KvHX5reBi4p+KEPV91OhUMtBT7g=
X-Received: by 2002:a5d:598b:0:b0:45e:73b3:8118 with SMTP id
 ffacd0b85a97d-46030512fa1mr40230612f8f.29.1781108002139; 
 Wed, 10 Jun 2026 09:13:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/71] target/arm: Implement FMLALL{BB, BT, TB, TT} for AdvSIMD
Date: Wed, 10 Jun 2026 17:11:48 +0100
Message-ID: <20260610161202.2235298-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode        |  7 ++++
 target/arm/tcg/fp8_helper.c      | 55 ++++++++++++++++++++++++++++++++
 target/arm/tcg/helper-fp8-defs.h |  3 ++
 target/arm/tcg/translate-a64.c   |  3 ++
 4 files changed, 68 insertions(+)

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
diff --git a/target/arm/tcg/fp8_helper.c b/target/arm/tcg/fp8_helper.c
index 71d30aa33a..ceeb96b9cc 100644
--- a/target/arm/tcg/fp8_helper.c
+++ b/target/arm/tcg/fp8_helper.c
@@ -630,6 +630,16 @@ static float16 f8dotadd_h(uint64_t a, uint64_t b, int n, float16 c,
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
@@ -674,3 +684,48 @@ void HELPER(gvec_fmla_idx_hb)(void *vd, void *vn, void *vm,
 
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 30715cbd65..dcc6b5ae6d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7497,6 +7497,9 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a,
 TRANS_FEAT(FMLAL_hb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS_FEAT(FMLAL_hb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
 
+TRANS_FEAT(FMLALL_sb_v, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS_FEAT(FMLALL_sb_vi, aa64_f8fma, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
+
 static bool do_int3_vector_idx(DisasContext *s, arg_qrrx_e *a,
                                gen_helper_gvec_3 * const fns[2])
 {
-- 
2.43.0


