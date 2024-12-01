Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68B1D49776
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlc8-0005db-Jc; Sun, 01 Dec 2024 10:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaZ-00006S-A3
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:23 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaW-0005IP-ME
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:23 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71d40573d03so1323208a34.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065819; x=1733670619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7H/eAuOkB9hv1gYHcyXcdX5tNJOxN4RD+OXx/sePD4=;
 b=cjNZsQB5u+cVeZota8d3deso4N3V3ukklBezb7xlPmXuwV1qWW4RABLY+UqT4k+8vi
 jS681Ds9ArpheYGFaKAnAIdQmLtnK9p70q33bbvtnI+MfzFogTKZ6NmaKIOfMhkxdcjl
 BPPBWsvJFUxzK6DqilZDjYMkVsjEkh6MmnYorQ8MSmNDZwUWkiR1q7GikayoV/eZgkre
 OzrMNF9lPPBgvuohwYyY9RyJf8nHCwLXERzJIrwg397LwnZ7fMQ8Vyefs/zxHNpz68ri
 pwBMn5HKvZopmg3T8DGfMdIPAfjDrRmFlXFDwvjq58F0Aj29VeKI3EjiHSuh+XxJ7p1C
 7lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065819; x=1733670619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7H/eAuOkB9hv1gYHcyXcdX5tNJOxN4RD+OXx/sePD4=;
 b=wuIKBJJ51bD+Qs/N8DrGE5Kfef0jjD6VnBkPxWfN9mmnP3fiuSxx7Mjs1ydteSSrHF
 zxkC6sWNDDFdFbKj9Nx1fs4hvE+wheHfopXuPLsEI3eH0y6kOxwWJYjt2hQswn0D9WHw
 qVWPZSlClQhpNr/UU3xM/RfQZ2/G4O/D3NSLRvAFcyMfSIUrsbL2yb/mH0ofa32fW3Zo
 bJ3QJHBQIGuMcaXK0K1Kulw9lGLB5sw1gfPvhhTtuLNMwutG4mjcnQ5kn1/ap3Afxaum
 MxER0yqwDHka/g9anBiV5WXbusfIe8y3DpEBzWlFNiei2RLNIC4yjED/WdSbHk9tSj4N
 NFBw==
X-Gm-Message-State: AOJu0Yy65C/5NuqiYvcTJK+4ZihH4QhKeyq5w5lyUYG84F1FuIclok8n
 WZVyUj9I1bUGdpbfrxcBYOowAJmz4nQki/m2KvMKKBsOG9QlLPwKWfjXft7Exid6qYnerRy5U9I
 J+5I=
X-Gm-Gg: ASbGncsixpui5LDEAxe5bsfDEuEY1JL2VfLHmT+9c900nl1vRUikuciQR7/+29UJIzt
 nt8PYZEbswFGcnd7pncpez1qEaC506kv0KNQEdgsGoWveKXyy2oAKmo/IE8N33/mWfGyH1Tom2i
 m0J6PqPNIZTjnwwK5Btdjp3vk6w8+HHZIQ8hhTFbWtlmj3W7cNE47BOlI34ZG+Xy7d0ULnISlw0
 dTY0gxmNx6///5A2DKDTynlhjLHNv0WcE0V7vg4FBE7dYO4hj1cp3ciSOD/2Ickx1iaB7aRsG9D
 Jx0XQB058x16jOEEhggS/5f08AhVZtp4KMDE
X-Google-Smtp-Source: AGHT+IHHuGVemKtrjTVkdFanlAgT2/zmS1GoJGd73wZrCAZtxUIZLw8djAqDwwFQH7/DTuIUbTIq9w==
X-Received: by 2002:a05:6830:6a9a:b0:70f:3720:16bb with SMTP id
 46e09a7af769-71d65cf342dmr11251513a34.19.1733065819473; 
 Sun, 01 Dec 2024 07:10:19 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 62/67] target/arm: Convert FCVT* (vector,
 integer) to decodetree
Date: Sun,  1 Dec 2024 09:06:01 -0600
Message-ID: <20241201150607.12812-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

Remove handle_2misc_64 as these were the last insns decoded
by that function.  Remove helper_advsimd_f16to[su]inth as unused;
we now always go through helper_vfp_to[su]hh or a specialized
vector function instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |   2 +
 target/arm/tcg/helper-a64.h    |   2 -
 target/arm/tcg/helper-a64.c    |  32 -----
 target/arm/tcg/translate-a64.c | 227 +++++++++++----------------------
 target/arm/tcg/vec_helper.c    |   2 +
 target/arm/tcg/a64.decode      |  25 ++++
 6 files changed, 102 insertions(+), 188 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 0c8a56c3ae..64aa603465 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -665,6 +665,8 @@ DEF_HELPER_FLAGS_4(gvec_vcvt_ud, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rz_ds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rz_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ud, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index ac7ca190fa..3c0774139b 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -74,8 +74,6 @@ DEF_HELPER_3(advsimd_mulx2h, i32, i32, i32, ptr)
 DEF_HELPER_4(advsimd_muladd2h, i32, i32, i32, i32, ptr)
 DEF_HELPER_2(advsimd_rinth_exact, f16, f16, ptr)
 DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
-DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
-DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 
 DEF_HELPER_2(exception_return, void, env, i64)
 DEF_HELPER_FLAGS_2(dc_zva, TCG_CALL_NO_WG, void, env, i64)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 3de564e0fe..28de7468cd 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -618,38 +618,6 @@ uint32_t HELPER(advsimd_rinth)(uint32_t x, void *fp_status)
     return ret;
 }
 
-/*
- * Half-precision floating point conversion functions
- *
- * There are a multitude of conversion functions with various
- * different rounding modes. This is dealt with by the calling code
- * setting the mode appropriately before calling the helper.
- */
-
-uint32_t HELPER(advsimd_f16tosinth)(uint32_t a, void *fpstp)
-{
-    float_status *fpst = fpstp;
-
-    /* Invalid if we are passed a NaN */
-    if (float16_is_any_nan(a)) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_int16(a, fpst);
-}
-
-uint32_t HELPER(advsimd_f16touinth)(uint32_t a, void *fpstp)
-{
-    float_status *fpst = fpstp;
-
-    /* Invalid if we are passed a NaN */
-    if (float16_is_any_nan(a)) {
-        float_raise(float_flag_invalid, fpst);
-        return 0;
-    }
-    return float16_to_uint16(a, fpst);
-}
-
 static int el_from_spsr(uint32_t spsr)
 {
     /* Return the exception level that this SPSR is requesting a return to,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f49c86a114..a570ae1153 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9360,56 +9360,38 @@ static gen_helper_gvec_2_ptr * const f_fcvtzu_vf[] = {
 TRANS(FCVTZU_vf, do_gvec_op2_fpst,
       a->esz, a->q, a->rd, a->rn, a->shift, f_fcvtzu_vf)
 
-static void handle_2misc_64(DisasContext *s, int opcode, bool u,
-                            TCGv_i64 tcg_rd, TCGv_i64 tcg_rn,
-                            TCGv_i32 tcg_rmode, TCGv_ptr tcg_fpstatus)
-{
-    /* Handle 64->64 opcodes which are shared between the scalar and
-     * vector 2-reg-misc groups. We cover every integer opcode where size == 3
-     * is valid in either group and also the double-precision fp ops.
-     * The caller only need provide tcg_rmode and tcg_fpstatus if the op
-     * requires them.
-     */
-    switch (opcode) {
-    case 0x1a: /* FCVTNS */
-    case 0x1b: /* FCVTMS */
-    case 0x1c: /* FCVTAS */
-    case 0x3a: /* FCVTPS */
-    case 0x3b: /* FCVTZS */
-        gen_helper_vfp_tosqd(tcg_rd, tcg_rn, tcg_constant_i32(0), tcg_fpstatus);
-        break;
-    case 0x5a: /* FCVTNU */
-    case 0x5b: /* FCVTMU */
-    case 0x5c: /* FCVTAU */
-    case 0x7a: /* FCVTPU */
-    case 0x7b: /* FCVTZU */
-        gen_helper_vfp_touqd(tcg_rd, tcg_rn, tcg_constant_i32(0), tcg_fpstatus);
-        break;
-    default:
-    case 0x4: /* CLS, CLZ */
-    case 0x5: /* NOT */
-    case 0x7: /* SQABS, SQNEG */
-    case 0x8: /* CMGT, CMGE */
-    case 0x9: /* CMEQ, CMLE */
-    case 0xa: /* CMLT */
-    case 0xb: /* ABS, NEG */
-    case 0x2f: /* FABS */
-    case 0x6f: /* FNEG */
-    case 0x7f: /* FSQRT */
-    case 0x18: /* FRINTN */
-    case 0x19: /* FRINTM */
-    case 0x38: /* FRINTP */
-    case 0x39: /* FRINTZ */
-    case 0x58: /* FRINTA */
-    case 0x79: /* FRINTI */
-    case 0x59: /* FRINTX */
-    case 0x1e: /* FRINT32Z */
-    case 0x5e: /* FRINT32X */
-    case 0x1f: /* FRINT64Z */
-    case 0x5f: /* FRINT64X */
-        g_assert_not_reached();
-    }
-}
+static gen_helper_gvec_2_ptr * const f_fcvt_s_vi[] = {
+    gen_helper_gvec_vcvt_rm_sh,
+    gen_helper_gvec_vcvt_rm_ss,
+    gen_helper_gvec_vcvt_rm_sd,
+};
+
+static gen_helper_gvec_2_ptr * const f_fcvt_u_vi[] = {
+    gen_helper_gvec_vcvt_rm_uh,
+    gen_helper_gvec_vcvt_rm_us,
+    gen_helper_gvec_vcvt_rm_ud,
+};
+
+TRANS(FCVTNS_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_nearest_even, f_fcvt_s_vi)
+TRANS(FCVTNU_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_nearest_even, f_fcvt_u_vi)
+TRANS(FCVTPS_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_up, f_fcvt_s_vi)
+TRANS(FCVTPU_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_up, f_fcvt_u_vi)
+TRANS(FCVTMS_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_down, f_fcvt_s_vi)
+TRANS(FCVTMU_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_down, f_fcvt_u_vi)
+TRANS(FCVTZS_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_to_zero, f_fcvt_s_vi)
+TRANS(FCVTZU_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_to_zero, f_fcvt_u_vi)
+TRANS(FCVTAS_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_ties_away, f_fcvt_s_vi)
+TRANS(FCVTAU_vi, do_gvec_op2_fpst,
+      a->esz, a->q, a->rd, a->rn, float_round_ties_away, f_fcvt_u_vi)
 
 static void handle_2misc_fcmp_zero(DisasContext *s, int opcode,
                                    bool is_scalar, bool is_u, bool is_q,
@@ -9770,30 +9752,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-        case 0x5a: /* FCVTNU */
-        case 0x5b: /* FCVTMU */
-        case 0x7a: /* FCVTPU */
-        case 0x7b: /* FCVTZU */
-            need_fpstatus = true;
-            rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
-        case 0x5c: /* FCVTAU */
-        case 0x1c: /* FCVTAS */
-            need_fpstatus = true;
-            rmode = FPROUNDING_TIEAWAY;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x3c: /* URECPE */
             if (size == 3) {
                 unallocated_encoding(s);
@@ -9843,6 +9801,16 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x5f: /* FRINT64X */
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
+        case 0x1a: /* FCVTNS */
+        case 0x1b: /* FCVTMS */
+        case 0x3a: /* FCVTPS */
+        case 0x3b: /* FCVTZS */
+        case 0x5a: /* FCVTNU */
+        case 0x5b: /* FCVTMU */
+        case 0x7a: /* FCVTPU */
+        case 0x7b: /* FCVTZU */
+        case 0x5c: /* FCVTAU */
+        case 0x1c: /* FCVTAS */
             unallocated_encoding(s);
             return;
         }
@@ -9883,26 +9851,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         tcg_rmode = NULL;
     }
 
-    if (size == 3) {
-        /* All 64-bit element operations can be shared with scalar 2misc */
-        int pass;
-
-        /* Coverity claims (size == 3 && !is_q) has been eliminated
-         * from all paths leading to here.
-         */
-        tcg_debug_assert(is_q);
-        for (pass = 0; pass < 2; pass++) {
-            TCGv_i64 tcg_op = tcg_temp_new_i64();
-            TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-
-            handle_2misc_64(s, opcode, u, tcg_res, tcg_op,
-                            tcg_rmode, tcg_fpstatus);
-
-            write_vec_element(s, tcg_res, rd, pass, MO_64);
-        }
-    } else {
+    {
         int pass;
 
         assert(size == 2);
@@ -9915,22 +9864,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x1a: /* FCVTNS */
-                case 0x1b: /* FCVTMS */
-                case 0x1c: /* FCVTAS */
-                case 0x3a: /* FCVTPS */
-                case 0x3b: /* FCVTZS */
-                    gen_helper_vfp_tosls(tcg_res, tcg_op,
-                                         tcg_constant_i32(0), tcg_fpstatus);
-                    break;
-                case 0x5a: /* FCVTNU */
-                case 0x5b: /* FCVTMU */
-                case 0x5c: /* FCVTAU */
-                case 0x7a: /* FCVTPU */
-                case 0x7b: /* FCVTZU */
-                    gen_helper_vfp_touls(tcg_res, tcg_op,
-                                         tcg_constant_i32(0), tcg_fpstatus);
-                    break;
                 case 0x7c: /* URSQRTE */
                     gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
@@ -9950,6 +9883,16 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 case 0x5e: /* FRINT32X */
                 case 0x1f: /* FRINT64Z */
                 case 0x5f: /* FRINT64X */
+                case 0x1a: /* FCVTNS */
+                case 0x1b: /* FCVTMS */
+                case 0x1c: /* FCVTAS */
+                case 0x3a: /* FCVTPS */
+                case 0x3b: /* FCVTZS */
+                case 0x5a: /* FCVTNU */
+                case 0x5b: /* FCVTMU */
+                case 0x5c: /* FCVTAU */
+                case 0x7a: /* FCVTPU */
+                case 0x7b: /* FCVTZU */
                     g_assert_not_reached();
                 }
             }
@@ -10018,36 +9961,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x3d: /* FRECPE */
     case 0x3f: /* FRECPX */
         break;
-    case 0x1a: /* FCVTNS */
-        rmode = FPROUNDING_TIEEVEN;
-        break;
-    case 0x1b: /* FCVTMS */
-        rmode = FPROUNDING_NEGINF;
-        break;
-    case 0x1c: /* FCVTAS */
-        rmode = FPROUNDING_TIEAWAY;
-        break;
-    case 0x3a: /* FCVTPS */
-        rmode = FPROUNDING_POSINF;
-        break;
-    case 0x3b: /* FCVTZS */
-        rmode = FPROUNDING_ZERO;
-        break;
-    case 0x5a: /* FCVTNU */
-        rmode = FPROUNDING_TIEEVEN;
-        break;
-    case 0x5b: /* FCVTMU */
-        rmode = FPROUNDING_NEGINF;
-        break;
-    case 0x5c: /* FCVTAU */
-        rmode = FPROUNDING_TIEAWAY;
-        break;
-    case 0x7a: /* FCVTPU */
-        rmode = FPROUNDING_POSINF;
-        break;
-    case 0x7b: /* FCVTZU */
-        rmode = FPROUNDING_ZERO;
-        break;
     case 0x7d: /* FRSQRTE */
         break;
     default:
@@ -10063,6 +9976,16 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x79: /* FRINTI */
     case 0x1d: /* SCVTF */
     case 0x5d: /* UCVTF */
+    case 0x1a: /* FCVTNS */
+    case 0x1b: /* FCVTMS */
+    case 0x1c: /* FCVTAS */
+    case 0x3a: /* FCVTPS */
+    case 0x3b: /* FCVTZS */
+    case 0x5a: /* FCVTNU */
+    case 0x5b: /* FCVTMU */
+    case 0x5c: /* FCVTAU */
+    case 0x7a: /* FCVTPU */
+    case 0x7b: /* FCVTZU */
         unallocated_encoding(s);
         return;
     }
@@ -10128,23 +10051,9 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             read_vec_element_i32(s, tcg_op, rn, pass, MO_16);
 
             switch (fpop) {
-            case 0x1a: /* FCVTNS */
-            case 0x1b: /* FCVTMS */
-            case 0x1c: /* FCVTAS */
-            case 0x3a: /* FCVTPS */
-            case 0x3b: /* FCVTZS */
-                gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
-                break;
             case 0x3d: /* FRECPE */
                 gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x5a: /* FCVTNU */
-            case 0x5b: /* FCVTMU */
-            case 0x5c: /* FCVTAU */
-            case 0x7a: /* FCVTPU */
-            case 0x7b: /* FCVTZU */
-                gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
-                break;
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
@@ -10159,6 +10068,16 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x58: /* FRINTA */
             case 0x79: /* FRINTI */
             case 0x59: /* FRINTX */
+            case 0x1a: /* FCVTNS */
+            case 0x1b: /* FCVTMS */
+            case 0x1c: /* FCVTAS */
+            case 0x3a: /* FCVTPS */
+            case 0x3b: /* FCVTZS */
+            case 0x5a: /* FCVTNU */
+            case 0x5b: /* FCVTMU */
+            case 0x5c: /* FCVTAU */
+            case 0x7a: /* FCVTPU */
+            case 0x7b: /* FCVTZU */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 9b269a4f18..0aee38a3bc 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2537,6 +2537,8 @@ DO_VCVT_FIXED(gvec_vcvt_rz_hu, helper_vfp_touhh_round_to_zero, uint16_t)
         clear_tail(d, oprsz, simd_maxsz(desc));                         \
     }
 
+DO_VCVT_RMODE(gvec_vcvt_rm_sd, helper_vfp_tosqd, uint64_t)
+DO_VCVT_RMODE(gvec_vcvt_rm_ud, helper_vfp_touqd, uint64_t)
 DO_VCVT_RMODE(gvec_vcvt_rm_ss, helper_vfp_tosls, uint32_t)
 DO_VCVT_RMODE(gvec_vcvt_rm_us, helper_vfp_touls, uint32_t)
 DO_VCVT_RMODE(gvec_vcvt_rm_sh, helper_vfp_toshh, uint16_t)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ea838ad04f..4f85ffb8be 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1793,6 +1793,31 @@ SCVTF_vi        0.00 1110 0.1 00001 11011 0 ..... .....     @qrr_sd
 UCVTF_vi        0.10 1110 011 11001 11011 0 ..... .....     @qrr_h
 UCVTF_vi        0.10 1110 0.1 00001 11011 0 ..... .....     @qrr_sd
 
+FCVTNS_vi       0.00 1110 011 11001 10101 0 ..... .....     @qrr_h
+FCVTNS_vi       0.00 1110 0.1 00001 10101 0 ..... .....     @qrr_sd
+FCVTNU_vi       0.10 1110 011 11001 10101 0 ..... .....     @qrr_h
+FCVTNU_vi       0.10 1110 0.1 00001 10101 0 ..... .....     @qrr_sd
+
+FCVTPS_vi       0.00 1110 111 11001 10101 0 ..... .....     @qrr_h
+FCVTPS_vi       0.00 1110 1.1 00001 10101 0 ..... .....     @qrr_sd
+FCVTPU_vi       0.10 1110 111 11001 10101 0 ..... .....     @qrr_h
+FCVTPU_vi       0.10 1110 1.1 00001 10101 0 ..... .....     @qrr_sd
+
+FCVTMS_vi       0.00 1110 011 11001 10111 0 ..... .....     @qrr_h
+FCVTMS_vi       0.00 1110 0.1 00001 10111 0 ..... .....     @qrr_sd
+FCVTMU_vi       0.10 1110 011 11001 10111 0 ..... .....     @qrr_h
+FCVTMU_vi       0.10 1110 0.1 00001 10111 0 ..... .....     @qrr_sd
+
+FCVTZS_vi       0.00 1110 111 11001 10111 0 ..... .....     @qrr_h
+FCVTZS_vi       0.00 1110 1.1 00001 10111 0 ..... .....     @qrr_sd
+FCVTZU_vi       0.10 1110 111 11001 10111 0 ..... .....     @qrr_h
+FCVTZU_vi       0.10 1110 1.1 00001 10111 0 ..... .....     @qrr_sd
+
+FCVTAS_vi       0.00 1110 011 11001 11001 0 ..... .....     @qrr_h
+FCVTAS_vi       0.00 1110 0.1 00001 11001 0 ..... .....     @qrr_sd
+FCVTAU_vi       0.10 1110 011 11001 11001 0 ..... .....     @qrr_h
+FCVTAU_vi       0.10 1110 0.1 00001 11001 0 ..... .....     @qrr_sd
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
-- 
2.43.0


