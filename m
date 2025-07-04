Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C001C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFU-0004u8-9S; Fri, 04 Jul 2025 12:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFE-00037d-EI
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:36 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFC-0006sW-6p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:36 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso856837f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646393; x=1752251193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eeZvVSPwrM1m3u4R9Oc0rM/pY0R9OQhJ862Rvp43gmQ=;
 b=DOchkQ/KB97x3XFqfbsR+agJpBFjs/ddMLgpn7Mgs4IWhqj6vYwrZoWWVlTcabOGu4
 gRhAkLca5e1AC+o4xb9OM8zUI72l5mC3Pb39Q+s0+gmCqSrnm1Uoel/nv4UYiy/cFtzy
 bJ1rtWx/ggydKy6AmLDFzVYNXn1807UDV4jt2TJi7BNkuvtpvn+6t5jlY+IliwrlTe33
 kjdNU5+pCsSRp7E41hp3R9ONpCnunUcHeIff9db6sFGUplwIr1DH9aU7VXGF73dWBGn0
 54J3796J83zyKCZgzGMAF09cMVpqz9m0VPqIv79NvQtFz7UBU7DR+7jA5NzBAOr/gGLm
 fu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646393; x=1752251193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeZvVSPwrM1m3u4R9Oc0rM/pY0R9OQhJ862Rvp43gmQ=;
 b=d5wpz351b7xIaL3otHcwElq0E94BXMonNmi1TyhuAtsKU+0oMoLa56q3uXYk6l9pA2
 MFuFUdolvE28eMaStt914X55AaE7/NH/QJpuTtlbuQCh6+aoDk5ldTAI7zSXReFSPEKS
 V1YRw1LalY/Ab1VHdkhgUbIc1C81HeaibJE4hW7Jy/6LWkU7Pg7CFb4ucRYnNj8/zWl6
 hUy7bf+eFjrediDnlMZgKyyfeIEsjiwFC1DioiaG0khD51PUsGsSOk/aUdfvAaw25vRh
 saUyYP5JQ1xOMY3lvcI/lZ9S6FT6F0Dt9U+aJRDpQRBsJEz6bEQwwBTUSXgg3WsLU1IQ
 0CcQ==
X-Gm-Message-State: AOJu0Yy0gPtB5wJjPaH3Jn5tR1+qkA6RGgjLveJXPUu9jBToUmZo3xzw
 aQGh3QUhKR3jMhmC7H6sA+nwISGtcngpWSvq7Pd4XANSTlmNo1c8Qa+bEy7dOph5VFiEibYYNYu
 ILUgE
X-Gm-Gg: ASbGncte7vbbXWpBnwHCESUstXyVkcp2G4VslvgZVejuGNE3k6anhxRsNE8El7xnX/v
 KYQiB4FLbjgrcNMF6kU3BSHdCm8zenp9ct8Vqbg0e65L5O/AgovY8Q/Hps9ktHRKnYb5re7CFOR
 8g7osMtW4lSbZ+7flcVhjBxIY8gVyaHwihyP5FlnQ398ZjoqF5/crWWnBC2pE1gtkqqmG1x8kMS
 dJu16Esg55tyGnSAQL1hUQr6qi3sqAUSt2/kG3Gzyfl/4AB7E14t1tTu+RaD4iHMNXFxcNNFMcy
 cBVqQObgmhfDt5r+QX6ZjeAqc1QM8TucyMmolbTA+Seu5MY48J6kSHtkTInvIJdBbk9P
X-Google-Smtp-Source: AGHT+IHZMW/KdMaDqZIHJKx+Y9jXw34YGGSdeimgu8YwxWSptPQKDSa91JcdEsCNyMKCuyy3JS3NpA==
X-Received: by 2002:a05:6000:22c6:b0:3b3:a6e1:135c with SMTP id
 ffacd0b85a97d-3b497038f3dmr2277114f8f.42.1751646392642; 
 Fri, 04 Jul 2025 09:26:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 094/119] target/arm: Implement SVE2p1 PEXT
Date: Fri,  4 Jul 2025 17:24:34 +0100
Message-ID: <20250704162501.249138-95-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: <qemu-devel.nongnu.org>
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
Message-id: 20250704142112.1018902-83-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  2 +
 target/arm/tcg/vec_internal.h  | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  6 +++
 target/arm/tcg/sve_helper.c    | 28 +++++++++++++
 target/arm/tcg/translate-sve.c | 36 +++++++++++++++++
 5 files changed, 146 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 5f5ecc2e0de..ec82d0a4e74 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2953,3 +2953,5 @@ DEF_HELPER_FLAGS_4(sve2p1_uminqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(pext, TCG_CALL_NO_RWG, void, ptr, i32, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 5efd257c50d..61c67bb35e7 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -337,4 +337,78 @@ bfloat16 helper_sme2_ah_fmin_b16(bfloat16 a, bfloat16 b, float_status *fpst);
 float32 sve_f16_to_f32(float16 f, float_status *fpst);
 float16 sve_f32_to_f16(float32 f, float_status *fpst);
 
+/*
+ * Decode helper functions for predicate as counter.
+ */
+
+typedef struct {
+    unsigned count;
+    unsigned lg2_stride;
+    bool invert;
+} DecodeCounter;
+
+static inline DecodeCounter
+decode_counter(unsigned png, unsigned vl, unsigned v_esz)
+{
+    DecodeCounter ret = { };
+
+    /* C.f. Arm pseudocode CounterToPredicate. */
+    if (likely(png & 0xf)) {
+        unsigned p_esz = ctz32(png);
+
+        /*
+         * maxbit = log2(pl(bits) * 4)
+         *        = log2(vl(bytes) * 4)
+         *        = log2(vl) + 2
+         * maxbit_mask = ones<maxbit:0>
+         *             = (1 << (maxbit + 1)) - 1
+         *             = (1 << (log2(vl) + 2 + 1)) - 1
+         *             = (1 << (log2(vl) + 3)) - 1
+         *             = (pow2ceil(vl) << 3) - 1
+         */
+        ret.count = png & (((unsigned)pow2ceil(vl) << 3) - 1);
+        ret.count >>= p_esz + 1;
+
+        ret.invert = (png >> 15) & 1;
+
+        /*
+         * The Arm pseudocode for CounterToPredicate expands the count to
+         * a set of bits, and then the operation proceeds as for the original
+         * interpretation of predicates as a set of bits.
+         *
+         * We can avoid the expansion by adjusting the count and supplying
+         * an element stride.
+         */
+        if (unlikely(p_esz != v_esz)) {
+            if (p_esz < v_esz) {
+                /*
+                 * For predicate esz < vector esz, the expanded predicate
+                 * will have more bits set than will be consumed.
+                 * Adjust the count down, rounding up.
+                 * Consider p_esz = MO_8, v_esz = MO_64, count 14:
+                 * The expanded predicate would be
+                 *    0011 1111 1111 1111
+                 * The significant bits are
+                 *    ...1 ...1 ...1 ...1
+                 */
+                unsigned shift = v_esz - p_esz;
+                unsigned trunc = ret.count >> shift;
+                ret.count = trunc + (ret.count != (trunc << shift));
+            } else {
+                /*
+                 * For predicate esz > vector esz, the expanded predicate
+                 * will have bits set only at power-of-two multiples of
+                 * the vector esz.  Bits at other multiples will all be
+                 * false.  Adjust the count up, and supply the caller
+                 * with a stride of elements to skip.
+                 */
+                unsigned shift = p_esz - v_esz;
+                ret.count <<= shift;
+                ret.lg2_stride = shift;
+            }
+        }
+    }
+    return ret;
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a3221308ad4..b7622577594 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -60,6 +60,7 @@
 %rn_ax2         6:4 !function=times_2
 
 %pnd            0:3 !function=plus_8
+%pnn            5:3 !function=plus_8
 
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
@@ -823,6 +824,11 @@ WHILE_lt_cnt4   00100101 .. 1 ..... 0110 . 1 ..... 1 . ...  @while_cnt
 WHILE_gt_cnt2   00100101 .. 1 ..... 0100 . 0 ..... 1 . ...  @while_cnt
 WHILE_gt_cnt4   00100101 .. 1 ..... 0110 . 0 ..... 1 . ...  @while_cnt
 
+# SVE2.1 extract mask predicate from predicate-as-counter
+&pext           rd rn esz imm
+PEXT_1          00100101 esz:2 1 00000 0111 00 imm:2 ... 1 rd:4  &pext rn=%pnn
+PEXT_2          00100101 esz:2 1 00000 0111 010 imm:1 ... 1 rd:4 &pext rn=%pnn
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 625734fff9a..866f85ba306 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7821,3 +7821,31 @@ DO_FCVTLT(sve2_fcvtlt_sd, uint64_t, uint32_t, H1_8, H1_4, float32_to_float64)
 
 #undef DO_FCVTLT
 #undef DO_FCVTNT
+
+void HELPER(pext)(void *vd, uint32_t png, uint32_t desc)
+{
+    int pl = FIELD_EX32(desc, PREDDESC, OPRSZ);
+    int vl = pl * 8;
+    unsigned v_esz = FIELD_EX32(desc, PREDDESC, ESZ);
+    int part = FIELD_EX32(desc, PREDDESC, DATA);
+    DecodeCounter p = decode_counter(png, vl, v_esz);
+    uint64_t mask = pred_esz_masks[v_esz + p.lg2_stride];
+    ARMPredicateReg *d = vd;
+
+    /*
+     * Convert from element count to byte count and adjust
+     * for the portion of the 4*VL counter to be extracted.
+     */
+    int b_count = (p.count << v_esz) - vl * part;
+
+    memset(d, 0, sizeof(*d));
+    if (p.invert) {
+        if (b_count <= 0) {
+            do_whilel(vd, mask, vl, vl);
+        } else if (b_count < vl) {
+            do_whileg(vd, mask, vl - b_count, vl);
+        }
+    } else if (b_count > 0) {
+        do_whilel(vd, mask, MIN(b_count, vl), vl);
+    }
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 2e29dff9895..6ad4d1e289c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3336,6 +3336,42 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     return true;
 }
 
+static bool do_pext(DisasContext *s, arg_pext *a, int n)
+{
+    TCGv_i32 t_png;
+    TCGv_ptr t_pd;
+    int pl;
+
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    t_png = tcg_temp_new_i32();
+    tcg_gen_ld16u_i32(t_png, tcg_env,
+                      pred_full_reg_offset(s, a->rn) ^
+                      (HOST_BIG_ENDIAN ? 6 : 0));
+
+    t_pd = tcg_temp_new_ptr();
+    pl = pred_full_reg_size(s);
+
+    for (int i = 0; i < n; ++i) {
+        int rd = (a->rd + i) % 16;
+        int part = a->imm * n + i;
+        unsigned desc = 0;
+
+        desc = FIELD_DP32(desc, PREDDESC, OPRSZ, pl);
+        desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+        desc = FIELD_DP32(desc, PREDDESC, DATA, part);
+
+        tcg_gen_addi_ptr(t_pd, tcg_env, pred_full_reg_offset(s, rd));
+        gen_helper_pext(t_pd, t_png, tcg_constant_i32(desc));
+    }
+    return true;
+}
+
+TRANS_FEAT(PEXT_1, aa64_sme2_or_sve2p1, do_pext, a, 1)
+TRANS_FEAT(PEXT_2, aa64_sme2_or_sve2p1, do_pext, a, 2)
+
 /*
  *** SVE Integer Wide Immediate - Unpredicated Group
  */
-- 
2.43.0


