Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E33E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPiK-0003yT-86; Wed, 11 Dec 2024 11:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPi3-0002ao-SR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:12 -0500
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPi0-0002PN-Op
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:37:11 -0500
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8f1505045so38661966d6.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733935027; x=1734539827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EpKA/iOFJSFdv6RbKF6BAQMwjgLDFCgI5Q7qdtCxis=;
 b=Fjh89zRvtBVVZWyMjoV2d7o/OwaaIZSXnRPbRDanXCltVEAkkRCvVC8ofXbpYikieF
 3obdeVic0VYKGv5vX6UgiZHW2qzPiT0+1qhFBcxNXZJ+Px8MN+P9bYnjfXVHH6UTAnnn
 +7iSk/dKAg9uyVIA46i/u5PZCTSwt2dfs0ZlDWJ2sgUEIAX7ngJjT2ZFkskZXNC3h6ZU
 4e6SvFYJH6SVfUtFnn5L4pf72itccSvhziQ5VDIuXnEtC5hGNiAQG5gOOjmOxYP8nslv
 5mhysqGh5k9REE2jF6rU6LD6qkVJCZr6VW14qvVCxHZUbGBbRd1bidn/kkpjPQ2ebFBN
 JYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733935027; x=1734539827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7EpKA/iOFJSFdv6RbKF6BAQMwjgLDFCgI5Q7qdtCxis=;
 b=EDFjl+kWEToxOg/3gZL/cfclbBW1LlyD7qQk8ksJXK328a8BxP+orqXyXRYHRTZ6E1
 8jj/IecD8bShOg+8WoM8TpLeiU/25OO1uczX+PyEKL6Z1+NILWaU+967kNzM/sLKymNK
 cj4GjZU3I9repgY8mt5LKAYjbAMKXlnWT4I71i9nQJCQlDsiWb4r0q5qib8syv2I/RjT
 BX7YvtJRaMSvwPkQlPS2J/ixJDp4BFj6luWEMs12edKc5JvebnCKGpYBdn23VjhGcHF3
 F2sWcEnuZKSkE2kjj97jef6WXmEr/Z/IxQHAeZPfWzJZUJJEtCHi6TZM93CHEnq5tpw3
 9Plw==
X-Gm-Message-State: AOJu0Yx1Ksn7dwOCNsrlAX4yPU3R0C8kcPOVu3eelur00BYpMUVCaPfv
 aPv9vXYziOvOIWP7EkLB+9IRlCu6Ya2TY6lbZzmRsdfhW+JaLVFEWTKB0SQ8p8Vcegyi/5Pc5Sc
 ez+JXrR5W
X-Gm-Gg: ASbGncvz4N7jNB35gS+IQbVYccwz2gsud9sfExGteTlATbuV/ByGfsI+PkUvbB9av+F
 eIA3fjCJV9vz6sjUzWIB9cN08S7THMj3s+l7c6fPikFpGrRcxjaq3z/lwirH0VkCxC+ZqRbGQdw
 I8PTUVMLC4Xysc/v7vDo6fwrrleWRk9QQ3/5cyfD+REpXuoyEc5Awn6xgV5aQ3kb/Gq8qSTA+A6
 TEv4FYMysGBTXpSi4N6LLJ9dwrYq/5WczbgDntxY5qIGfILaHIUxicZ3HAkIQ==
X-Google-Smtp-Source: AGHT+IG1r6znNX2qBjtzIBOtORjhL5GPCRu6WuVveTjnBVBb9lfZFo3BCSApZa48UXPTmy54i6a/RQ==
X-Received: by 2002:ad4:5fc8:0:b0:6d4:19a0:202 with SMTP id
 6a1803df08f44-6d934b900fdmr69015846d6.33.1733935027477; 
 Wed, 11 Dec 2024 08:37:07 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:37:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 68/69] target/arm: Convert URECPE and URSQRTE to decodetree
Date: Wed, 11 Dec 2024 10:30:35 -0600
Message-ID: <20241211163036.2297116-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2d.google.com
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

Remove handle_2misc_reciprocal as these were the last
insns decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 139 ++-------------------------------
 target/arm/tcg/a64.decode      |   3 +
 2 files changed, 8 insertions(+), 134 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 63cf25251b..fa3170da86 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9163,6 +9163,8 @@ TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
 TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
 TRANS(REV16_v, do_gvec_fn2, a, gen_gvec_rev16)
 TRANS(REV32_v, do_gvec_fn2, a, gen_gvec_rev32)
+TRANS(URECPE_v, do_gvec_fn2, a, gen_gvec_urecpe)
+TRANS(URSQRTE_v, do_gvec_fn2, a, gen_gvec_ursqrte)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -9506,51 +9508,6 @@ static gen_helper_gvec_2_ptr * const f_frsqrte[] = {
 };
 TRANS(FRSQRTE_v, do_gvec_op2_fpst, a->esz, a->q, a->rd, a->rn, 0, f_frsqrte)
 
-static void handle_2misc_reciprocal(DisasContext *s, int opcode,
-                                    bool is_scalar, bool is_u, bool is_q,
-                                    int size, int rn, int rd)
-{
-    bool is_double = (size == 3);
-
-    if (is_double) {
-        g_assert_not_reached();
-    } else {
-        TCGv_i32 tcg_op = tcg_temp_new_i32();
-        TCGv_i32 tcg_res = tcg_temp_new_i32();
-        int pass, maxpasses;
-
-        if (is_scalar) {
-            maxpasses = 1;
-        } else {
-            maxpasses = is_q ? 4 : 2;
-        }
-
-        for (pass = 0; pass < maxpasses; pass++) {
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
-
-            switch (opcode) {
-            case 0x3c: /* URECPE */
-                gen_helper_recpe_u32(tcg_res, tcg_op);
-                break;
-            case 0x3d: /* FRECPE */
-            case 0x3f: /* FRECPX */
-            case 0x7d: /* FRSQRTE */
-            default:
-                g_assert_not_reached();
-            }
-
-            if (is_scalar) {
-                write_fp_sreg(s, rd, tcg_res);
-            } else {
-                write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-            }
-        }
-        if (!is_scalar) {
-            clear_vec_high(s, is_q, rd);
-        }
-    }
-}
-
 static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
                                   int size, int rn, int rd)
 {
@@ -9609,10 +9566,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     bool is_q = extract32(insn, 30, 1);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    bool need_fpstatus = false;
-    int rmode = -1;
-    TCGv_i32 tcg_rmode;
-    TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
     case 0xc ... 0xf:
@@ -9625,28 +9578,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
-        case 0x3c: /* URECPE */
-            if (size == 3) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_reciprocal(s, opcode, false, u, is_q, size, rn, rd);
-            return;
         case 0x17: /* FCVTL, FCVTL2 */
             if (!fp_access_check(s)) {
                 return;
             }
             handle_2misc_widening(s, opcode, is_q, size, rn, rd);
             return;
-        case 0x7c: /* URSQRTE */
-            if (size == 3) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         default:
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
@@ -9684,6 +9621,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x6d: /* FCMLE (zero) */
         case 0x3d: /* FRECPE */
         case 0x7d: /* FRSQRTE */
+        case 0x3c: /* URECPE */
+        case 0x7c: /* URSQRTE */
             unallocated_encoding(s);
             return;
         }
@@ -9708,75 +9647,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         unallocated_encoding(s);
         return;
     }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (need_fpstatus || rmode >= 0) {
-        tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
-    } else {
-        tcg_fpstatus = NULL;
-    }
-    if (rmode >= 0) {
-        tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
-    } else {
-        tcg_rmode = NULL;
-    }
-
-    {
-        int pass;
-
-        assert(size == 2);
-        for (pass = 0; pass < (is_q ? 4 : 2); pass++) {
-            TCGv_i32 tcg_op = tcg_temp_new_i32();
-            TCGv_i32 tcg_res = tcg_temp_new_i32();
-
-            read_vec_element_i32(s, tcg_op, rn, pass, MO_32);
-
-            {
-                /* Special cases for 32 bit elements */
-                switch (opcode) {
-                case 0x7c: /* URSQRTE */
-                    gen_helper_rsqrte_u32(tcg_res, tcg_op);
-                    break;
-                default:
-                case 0x7: /* SQABS, SQNEG */
-                case 0x2f: /* FABS */
-                case 0x6f: /* FNEG */
-                case 0x7f: /* FSQRT */
-                case 0x18: /* FRINTN */
-                case 0x19: /* FRINTM */
-                case 0x38: /* FRINTP */
-                case 0x39: /* FRINTZ */
-                case 0x58: /* FRINTA */
-                case 0x79: /* FRINTI */
-                case 0x59: /* FRINTX */
-                case 0x1e: /* FRINT32Z */
-                case 0x5e: /* FRINT32X */
-                case 0x1f: /* FRINT64Z */
-                case 0x5f: /* FRINT64X */
-                case 0x1a: /* FCVTNS */
-                case 0x1b: /* FCVTMS */
-                case 0x1c: /* FCVTAS */
-                case 0x3a: /* FCVTPS */
-                case 0x3b: /* FCVTZS */
-                case 0x5a: /* FCVTNU */
-                case 0x5b: /* FCVTMU */
-                case 0x5c: /* FCVTAU */
-                case 0x7a: /* FCVTPU */
-                case 0x7b: /* FCVTZU */
-                    g_assert_not_reached();
-                }
-            }
-            write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
-        }
-    }
-    clear_vec_high(s, is_q, rd);
-
-    if (tcg_rmode) {
-        gen_restore_rmode(tcg_rmode, tcg_fpstatus);
-    }
+    g_assert_not_reached();
 }
 
 /* C3.6 Data processing - SIMD, inc Crypto
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9b3b09c3bb..f35d123821 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1863,6 +1863,9 @@ FRECPE_v        0.00 1110 1.1 00001 11011 0 ..... .....     @qrr_sd
 FRSQRTE_v       0.10 1110 111 11001 11011 0 ..... .....     @qrr_h
 FRSQRTE_v       0.10 1110 1.1 00001 11011 0 ..... .....     @qrr_sd
 
+URECPE_v        0.00 1110 101 00001 11001 0 ..... .....     @qrr_s
+URSQRTE_v       0.10 1110 101 00001 11001 0 ..... .....     @qrr_s
+
 &fcvt_q         rd rn esz q shift
 @fcvtq_h        . q:1 . ...... 001 .... ...... rn:5 rd:5    \
                 &fcvt_q esz=1 shift=%fcvt_f_sh_h
-- 
2.43.0


