Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97136C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwqy-00071p-U8; Wed, 02 Jul 2025 08:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwju-0004hn-2Z
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:03 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjd-0002E8-Nv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:58 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2647052fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459923; x=1752064723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g282VnLG4FRWjvt3Oj566nXSR9/d2h3hitvgyLII8mU=;
 b=z2gmFofZfVWPutMUUUwyH1wCO5fRm3CyP9Hn2Y85REuAf2Dw9YXohyu0bDUR3UW1eZ
 m/HbNTwmZfpKww3G3b2e6javIr99dVm8ZE2YNgKLiTp8wC3LcpBxDcc64R/q0q2HfW2O
 LlRjFPKmT2QHhtkAjP9+7GJH+RoQO9nRJC7vwZtTZL5ApZTd/j8G/vXourH4uwnlI0WS
 cYLMz7iX9oHzdYaYSNdJbODPHY+coGR8mN7ftc22KkNaNZwPT8t4JF0LaWqlhSiVgK+e
 N8OHMpB1e9yklWn/J/ianXUugYomUxCnFeOa4hfq0JrPKnFDCRrOmNw9lrxh9BOkY5zT
 yc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459923; x=1752064723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g282VnLG4FRWjvt3Oj566nXSR9/d2h3hitvgyLII8mU=;
 b=hTmpVfo0TKSPwBdfj4Z/ub/y+RcqjzB+213j0iIv0fXC5Nqqbb04VcMhhR7RV4R+N7
 5HM2JGtjjY3sODEZDcNnlEk4Ekd67WjORl3S7iRWEgvwkPiK9cOHV+X+xRfZh3vwrAg+
 ZXJSLu1fxUII4JMmdAq/wXpp8o4QtmwX5umR5bGW9vOGulY3hEosZV36ZRyk/2zFN6D6
 sYITBhsLSqBqe6krsu3Jihta/CcLK5b52/3IPvETbmq6dVxPlWaEnkPezYax7tsenlTe
 d4bhJAB2ejaIyE8ql6yxLam8RdG9Uzm0mtKwJPHOsHqEdY2E4MtHsnRm2yP52hisBD9C
 WkMQ==
X-Gm-Message-State: AOJu0Yze/kH2pRsXbdFr7HR6nkFb7dDdoI2+V3bbOeNCQ99lREMD95WC
 SzLnSWZ7SvIu4kTdxcM0eM0Jjv0oiYcG5BjMtSUEZq9QfJD498AqhrZFyJW5Qoh/zTqg3LnMAYx
 j7SAgUK0=
X-Gm-Gg: ASbGncvbp7vEfvAqGsKceixwf2RNBUyiSQDyy1iabYMyZD9j+MvlfZiQC0CIO+pRq/S
 qPJNM5GUFLusNCHtW9fuNjA/ElVRCcd18Tro5xBPSF8cyFIveq1eiJM9ULvwHVjNxNWZ/5wZ5l4
 pcXF0orK5udw2kbXmaPUKCtJ4YUPNkTnB86TkdI+V7dJovHtUnzpafFcQi2c+wCnOJgmEMIbEXZ
 KqKhWOpo60N7FhUb88QaYQoKxtaRa7NS3G3Nx2vlHnVfC2j1kqkvB4CPxrHIpr0YBtVqdRC5J+w
 MswbG7baxShUdYAzdbaMp2veIJlIvyzW2ogXbQucGe8iElJjsVZdadd7u2jZqBwCH164oQ==
X-Google-Smtp-Source: AGHT+IFtzZgay5GeuHplCYQJcHbGS3uHHtH2qS4Sdb1Tf6WYovaUmO9dJT4GiyioqEuVxr2Wb/3CaQ==
X-Received: by 2002:a05:6870:9686:b0:29d:c764:f873 with SMTP id
 586e51a60fabf-2f5c7abccefmr2113221fac.31.1751459923269; 
 Wed, 02 Jul 2025 05:38:43 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 71/97] target/arm: Implement SVE2p1 PEXT
Date: Wed,  2 Jul 2025 06:33:44 -0600
Message-ID: <20250702123410.761208-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  2 +
 target/arm/tcg/vec_internal.h  | 74 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    | 27 +++++++++++++
 target/arm/tcg/translate-sve.c | 36 +++++++++++++++++
 target/arm/tcg/sve.decode      |  6 +++
 5 files changed, 145 insertions(+)

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
index 5efd257c50..236927c640 100644
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
+    unsigned stride;
+    bool invert;
+} DecodeCounter;
+
+static inline DecodeCounter
+decode_counter(unsigned png, unsigned vl, unsigned v_esz)
+{
+    DecodeCounter ret = { .stride = 1 };
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
+                ret.stride = 1 << shift;
+            }
+        }
+    }
+    return ret;
+}
+
 #endif /* TARGET_ARM_VEC_INTERNAL_H */
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index cc706db901..59ba1caf02 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -7825,3 +7825,30 @@ DO_FCVTLT(sve2_fcvtlt_sd, uint64_t, uint32_t, H1_8, H1_4, float32_to_float64)
 
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
+    uint64_t mask = pred_esz_masks[v_esz + ctz32(p.stride)];
+
+    /*
+     * Convert from element count to byte count and adjust
+     * for the portion of the 4*VL counter to be extracted.
+     */
+    int b_count = (p.count << v_esz) - vl * part;
+
+    do_zero(vd, pl);
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


