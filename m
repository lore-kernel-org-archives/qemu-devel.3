Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhXt-00009N-8n; Fri, 04 Jul 2025 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPD-0002VS-0C
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhP9-0001Kz-6p
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:46 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2efbbf5a754so772419fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639321; x=1752244121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/Z0QaESMiLPWMfgiOfCP9B9XT7+eJ9Wb4Gfz/S2ISE=;
 b=xU3wVrd4OAZXNnAHwxgiHN3vdiC4ilJpNzmT3Q8So+aJ5GyZsRtSX2N8O73dFycbKS
 cPsUhfu8NtCmwGFzh0AogftmI78yj7ej4b5EWHMf0vPJR37Ki779GjCvVNF+13qiChmE
 k6jOY2Ja303R+OndjEdPpZ7to/cuTbQZYPQn7nVqVInRo7j8cQExdn4xIwZnjw1vWk6k
 XPF9Ak6BPPdm26EA/C0vGAUZBdTW34j92mTGzVsQJHgnKZ39nMOTCmxRlgGQghy8bWNE
 FCwXQFiVfPQnKLBUdLA7y8ivUSob6oN3tGQcYsqmTO87F063L0g2HwH0aWer9DkhOF1/
 MJtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639321; x=1752244121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/Z0QaESMiLPWMfgiOfCP9B9XT7+eJ9Wb4Gfz/S2ISE=;
 b=cCvbvdf995UnDQ7/qx8sNk+EFklI5luiF5cOPO/XdGag2xqUTgA7F9HNdNGkPoCeDq
 m4kmvzEXy4Z+h3Cq4bzDhzStzMavID3vLYaP2XavG++08qQJ5CWoWJBGd1/snLFThicE
 1oi1GJkY/uiuxOtfo1dZtX8CgvXcWqGXcqmdNvl6p9cIzCxSlpG/3yPGJI2ojHMmdSCy
 lNQgiMdQ3OuRambs8UsfLnc+ip8p3doTPvOH87zSWXD/jJd7L0KrxOVgbB34RKsncZo8
 okv7bzVzM5c26C1hDN5yQb6NpDQwJvV21RU81jOoshQnpWOtGPlzWjGh5+sLUN2EpwIa
 PG1w==
X-Gm-Message-State: AOJu0YwG3VaJuHH0yt9zq2moxyaC2fyNj2pJjh6YC7dJyYHLBjcfbJK/
 csB+AaMloL45Q+XfwLjzEfTGeY/WnzwiBLV5Hz+f0f24WS/7pLXqa3/e2yAYoPSVETY5Ky5PsoH
 MuaDnpbI=
X-Gm-Gg: ASbGncvUNgnCV8XVtNWzrhaDPPwDBA56QBkYAMMJy7vVliDTqZVrfsCgK66lGAYI2lq
 YXAvO39ASr0857C/ZzEgrp0H3oU4xiiOEk5O6r9k05CEZXKYoZtX1/Q0FNaGgd9g0D8+OcbFLNI
 ahyAb9e2GP3c3+ihuyrz3DKDsgUC66HUu96ahTB6CkZN8+5DbhopqEkT7npJSHxJC3pA3P3JzNl
 rFQeGlTyn1+mJEfYc9kZvgN+9XW6qXDTVDftr21ke+huWfptldUqOomv6lsttNhFxPPUCNJLkD3
 pzWTzzJOU5jmtfTbbW2uyfHSdZ8rzDlT0FNXXcQZcbBvUHt/6YQgkirRu3Lfk88aWuIfLK/zSge
 f1402ASudyk+aaJ3fE35a16hbTPxoNtZXIT2VVq5ovm0+npx0p9NgEJ6R9pM=
X-Google-Smtp-Source: AGHT+IFfIxWK6uAIMTJAfi0nrBiMcHOejTpyGRFmxqlmLs3DOuxDmUs0wPQ+IYpYC0UgrWEk6T6b+Q==
X-Received: by 2002:a05:6871:e589:b0:2ef:98fc:6f59 with SMTP id
 586e51a60fabf-2f796e50a48mr1933660fac.35.1751639320829; 
 Fri, 04 Jul 2025 07:28:40 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 082/108] target/arm: Implement SVE2p1 PEXT
Date: Fri,  4 Jul 2025 08:20:45 -0600
Message-ID: <20250704142112.1018902-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  2 +
 target/arm/tcg/vec_internal.h  | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    | 28 +++++++++++++
 target/arm/tcg/translate-sve.c | 36 +++++++++++++++++
 target/arm/tcg/sve.decode      |  6 +++
 5 files changed, 146 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 5f5ecc2e0d..ec82d0a4e7 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -2953,3 +2953,5 @@ DEF_HELPER_FLAGS_4(sve2p1_uminqv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2p1_uminqv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(pext, TCG_CALL_NO_RWG, void, ptr, i32, i32)
diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 5efd257c50..61c67bb35e 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 625734fff9..866f85ba30 100644
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
index 2e29dff989..6ad4d1e289 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a3221308ad..b762257759 100644
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
-- 
2.43.0


