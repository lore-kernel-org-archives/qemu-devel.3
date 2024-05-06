Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F6DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3mnN-0000ob-9O; Sun, 05 May 2024 21:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmj-0007wO-9z
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:53 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3mmM-0002WQ-16
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:04:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ecd9dab183so27659965ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 18:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714957468; x=1715562268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AzJX13H5XAT/STnLyLHYROGAmOMJ6FHS58wYnuWTLMg=;
 b=GH7RP8y9IzevXJ75JktIpUVeTZvLSCXGxKAvWyLhaL+qFb28MUgaUVmAYJtMQcEcgw
 XY+JTDkkOAjq67HMBazXDMViPs4TVv8M/p7Q25muzcjd4TCvlJnCn6dgQVxz+umUA6s1
 2H/0stCEdRj8J1Fj4rQXg9yM+TTh3g/iaw3wAb4rTOJwzB4ydF4RXOCvBadtPMVKjDTQ
 b41Y2jWH4X7SwWhkGU7smD/5I2GmfhSAxrrHy12A7SxFq/wwCdKSGe+5sY4PKoI8+7vL
 4RdvOnY3rtZCOCc7KcoGFsBg8HLSlko+Qb+7RJr9srct6oSKB7KZwbVRnuoTgRiTUAVL
 7SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714957468; x=1715562268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzJX13H5XAT/STnLyLHYROGAmOMJ6FHS58wYnuWTLMg=;
 b=BF3XfkTRnEKHgA6p2QBke+SdNVEUFVVPhnz5vxL619lcswT9eB60nDhh9Op8Eksm0T
 yKEaLKD3xumdXtLCAHFSwdo4hFg7g1kk7Le7dB61oztYravDn3Www17S6GMZjsaSQeJC
 7GkGdkDwFx+dsyEWlfxWOoLhhmHs6I/BSzQAgykwqWRdbU0aj/gx4lZP0eg9EUsnPKZt
 P+dT/ylaC73GudfGN4G6k64/U5PzZrKXWsdOasbT0JQO9HlH+00XbsRzEqgcdZje/cfp
 /LFzYuhIeEw/zxn1OtcWSfNI8HBrMlrCVNoVoQFKOt7WVoa/g4cq3preUiJm8ppNoteu
 erWg==
X-Gm-Message-State: AOJu0Yy6LMIONMgZn0wmm4jlqrOClYm15ZpnZXEg4g38AOWdB1ZXMSKf
 9bp5IXEDKgGnL2GAnlySF2epeP5qtJT9FU655zX5A0FYGMUrWNvbq6OqmqjCYBPg/KdefPxf2Ta
 N
X-Google-Smtp-Source: AGHT+IEYM6ycDBLQFjU5NbSjosWdEPnPvkwZewpUTQ0oMR0P72P0I4GUqdSdcAG9JZzrUoCGvbX+4A==
X-Received: by 2002:a17:90a:c24d:b0:2b2:826d:a387 with SMTP id
 d13-20020a17090ac24d00b002b2826da387mr12181278pjx.14.1714957468428; 
 Sun, 05 May 2024 18:04:28 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 pv7-20020a17090b3c8700b002a5f44353d2sm8958232pjb.7.2024.05.05.18.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 May 2024 18:04:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 28/57] target/arm: Convert FMLAL, FMLSL to decodetree
Date: Sun,  5 May 2024 18:03:34 -0700
Message-Id: <20240506010403.6204-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
References: <20240506010403.6204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 target/arm/tcg/a64.decode      |  10 +++
 target/arm/tcg/translate-a64.c | 144 ++++++++++-----------------------
 2 files changed, 51 insertions(+), 103 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 16e9675335..9aa4fb9bd0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -797,6 +797,11 @@ FMLA_v          0.00 1110 0.1 ..... 11001 1 ..... ..... @qrrr_sd
 FMLS_v          0.00 1110 110 ..... 00001 1 ..... ..... @qrrr_h
 FMLS_v          0.00 1110 1.1 ..... 11001 1 ..... ..... @qrrr_sd
 
+FMLAL_v         0.00 1110 001 ..... 11101 1 ..... ..... @qrrr_h
+FMLSL_v         0.00 1110 101 ..... 11101 1 ..... ..... @qrrr_h
+FMLAL2_v        0.10 1110 001 ..... 11001 1 ..... ..... @qrrr_h
+FMLSL2_v        0.10 1110 101 ..... 11001 1 ..... ..... @qrrr_h
+
 FCMEQ_v         0.00 1110 010 ..... 00100 1 ..... ..... @qrrr_h
 FCMEQ_v         0.00 1110 0.1 ..... 11100 1 ..... ..... @qrrr_sd
 
@@ -877,3 +882,8 @@ FMLS_vi         0.00 1111 11 0 ..... 0101 . 0 ..... .....   @qrrx_d
 FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
 FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
 FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
+
+FMLAL_vi        0.00 1111 10 .. .... 0000 . 0 ..... .....   @qrrx_h
+FMLSL_vi        0.00 1111 10 .. .... 0100 . 0 ..... .....   @qrrx_h
+FMLAL2_vi       0.10 1111 10 .. .... 1000 . 0 ..... .....   @qrrx_h
+FMLSL2_vi       0.10 1111 10 .. .... 1100 . 0 ..... .....   @qrrx_h
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index be63f46247..a082ce8441 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5257,6 +5257,24 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 };
 TRANS(FMINNMP_v, do_fp3_vector, a, f_vector_fminnmp)
 
+static bool do_fmlal(DisasContext *s, arg_qrrr_e *a, bool is_s, bool is_2)
+{
+    if (fp_access_check(s)) {
+        int data = (is_2 << 1) | is_s;
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm), tcg_env,
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           data, gen_helper_gvec_fmlal_a64);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMLAL_v, aa64_fhm, do_fmlal, a, false, false)
+TRANS_FEAT(FMLSL_v, aa64_fhm, do_fmlal, a, true, false)
+TRANS_FEAT(FMLAL2_v, aa64_fhm, do_fmlal, a, false, true)
+TRANS_FEAT(FMLSL2_v, aa64_fhm, do_fmlal, a, true, true)
+
 TRANS(ADDP_v, do_gvec_fn3, a, gen_gvec_addp)
 TRANS(SMAXP_v, do_gvec_fn3_no64, a, gen_gvec_smaxp)
 TRANS(SMINP_v, do_gvec_fn3_no64, a, gen_gvec_sminp)
@@ -5448,6 +5466,24 @@ static bool do_fmla_vector_idx(DisasContext *s, arg_qrrx_e *a, bool neg)
 TRANS(FMLA_vi, do_fmla_vector_idx, a, false)
 TRANS(FMLS_vi, do_fmla_vector_idx, a, true)
 
+static bool do_fmlal_idx(DisasContext *s, arg_qrrx_e *a, bool is_s, bool is_2)
+{
+    if (fp_access_check(s)) {
+        int data = (a->idx << 2) | (is_2 << 1) | is_s;
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm), tcg_env,
+                           a->q ? 16 : 8, vec_full_reg_size(s),
+                           data, gen_helper_gvec_fmlal_idx_a64);
+    }
+    return true;
+}
+
+TRANS_FEAT(FMLAL_vi, aa64_fhm, do_fmlal_idx, a, false, false)
+TRANS_FEAT(FMLSL_vi, aa64_fhm, do_fmlal_idx, a, true, false)
+TRANS_FEAT(FMLAL2_vi, aa64_fhm, do_fmlal_idx, a, false, true)
+TRANS_FEAT(FMLSL2_vi, aa64_fhm, do_fmlal_idx, a, true, true)
+
 /*
  * Advanced SIMD scalar pairwise
  */
@@ -10905,78 +10941,6 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating point op subgroup of C3.6.16. */
-static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
-{
-    /* For floating point ops, the U, size[1] and opcode bits
-     * together indicate the operation. size[0] indicates single
-     * or double.
-     */
-    int fpopcode = extract32(insn, 11, 5)
-        | (extract32(insn, 23, 1) << 5)
-        | (extract32(insn, 29, 1) << 6);
-    int is_q = extract32(insn, 30, 1);
-    int size = extract32(insn, 22, 1);
-    int rm = extract32(insn, 16, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    if (size == 1 && !is_q) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (fpopcode) {
-    case 0x1d: /* FMLAL  */
-    case 0x3d: /* FMLSL  */
-    case 0x59: /* FMLAL2 */
-    case 0x79: /* FMLSL2 */
-        if (size & 1 || !dc_isar_feature(aa64_fhm, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (fp_access_check(s)) {
-            int is_s = extract32(insn, 23, 1);
-            int is_2 = extract32(insn, 29, 1);
-            int data = (is_2 << 1) | is_s;
-            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm), tcg_env,
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               data, gen_helper_gvec_fmlal_a64);
-        }
-        return;
-
-    default:
-    case 0x18: /* FMAXNM */
-    case 0x19: /* FMLA */
-    case 0x1a: /* FADD */
-    case 0x1b: /* FMULX */
-    case 0x1c: /* FCMEQ */
-    case 0x1e: /* FMAX */
-    case 0x1f: /* FRECPS */
-    case 0x38: /* FMINNM */
-    case 0x39: /* FMLS */
-    case 0x3a: /* FSUB */
-    case 0x3e: /* FMIN */
-    case 0x3f: /* FRSQRTS */
-    case 0x58: /* FMAXNMP */
-    case 0x5a: /* FADDP */
-    case 0x5b: /* FMUL */
-    case 0x5c: /* FCMGE */
-    case 0x5d: /* FACGE */
-    case 0x5e: /* FMAXP */
-    case 0x5f: /* FDIV */
-    case 0x78: /* FMINNMP */
-    case 0x7a: /* FABD */
-    case 0x7d: /* FACGT */
-    case 0x7c: /* FCMGT */
-    case 0x7e: /* FMINP */
-        unallocated_encoding(s);
-        return;
-    }
-}
-
 /* Integer op subgroup of C3.6.16. */
 static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
 {
@@ -11245,16 +11209,13 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x3: /* logic ops */
         disas_simd_3same_logic(s, insn);
         break;
-    case 0x18 ... 0x31:
-        /* floating point ops, sz[1] and U are part of opcode */
-        disas_simd_3same_float(s, insn);
-        break;
     default:
         disas_simd_3same_int(s, insn);
         break;
     case 0x14: /* SMAXP, UMAXP */
     case 0x15: /* SMINP, UMINP */
     case 0x17: /* ADDP */
+    case 0x18 ... 0x31: /* floating point ops */
         unallocated_encoding(s);
         break;
     }
@@ -12520,22 +12481,15 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         is_fp = 2;
         break;
-    case 0x00: /* FMLAL */
-    case 0x04: /* FMLSL */
-    case 0x18: /* FMLAL2 */
-    case 0x1c: /* FMLSL2 */
-        if (is_scalar || size != MO_32 || !dc_isar_feature(aa64_fhm, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        size = MO_16;
-        /* is_fp, but we pass tcg_env not fp_status.  */
-        break;
     default:
+    case 0x00: /* FMLAL */
     case 0x01: /* FMLA */
+    case 0x04: /* FMLSL */
     case 0x05: /* FMLS */
     case 0x09: /* FMUL */
+    case 0x18: /* FMLAL2 */
     case 0x19: /* FMULX */
+    case 0x1c: /* FMLSL2 */
         unallocated_encoding(s);
         return;
     }
@@ -12654,22 +12608,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         }
         return;
 
-    case 0x00: /* FMLAL */
-    case 0x04: /* FMLSL */
-    case 0x18: /* FMLAL2 */
-    case 0x1c: /* FMLSL2 */
-        {
-            int is_s = extract32(opcode, 2, 1);
-            int is_2 = u;
-            int data = (index << 2) | (is_2 << 1) | is_s;
-            tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, rd),
-                               vec_full_reg_offset(s, rn),
-                               vec_full_reg_offset(s, rm), tcg_env,
-                               is_q ? 16 : 8, vec_full_reg_size(s),
-                               data, gen_helper_gvec_fmlal_idx_a64);
-        }
-        return;
-
     case 0x08: /* MUL */
         if (!is_long && !is_scalar) {
             static gen_helper_gvec_3 * const fns[3] = {
-- 
2.34.1


