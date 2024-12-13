Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6E9E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Zu-0007sM-OZ; Fri, 13 Dec 2024 12:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Y0-0008Gw-0Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:55 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xu-0001iq-At
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:51 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1544591f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111224; x=1734716024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PLy+/MFJVsBnaMYhANiuG7MuuzMJJdty2yJCk6wbBqc=;
 b=W4tQdKHXppUKRFshudGj+jTmY5NbpqNa/xDHtliCSekmQJabL5ERsCN4+yQrq18ZtT
 sQHTygp4At4T0MzPP4LOenGaenJyymNJmQLxZzSI86Vt1Zw0hhqa3KJhKOJoIOkiciDc
 T8wLsns9p1rqKSv/ROcrfLqpJ3XrLE4JptXkkLGY4t4cxPf1CyMXNNbBel/9m2KyKuJi
 iOsSOdW0in+HLjCVe0n5sAANoXBGn3snndecVfYIdki68WxsvRBiN4ibZBfPSD2l4+BQ
 pDiGVdxYRd6hxTO4B4spffOUJKAMA4+JagLjEER+a2ZKtmgSxYrxOw73Us6Gq4oAKl3J
 qxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111224; x=1734716024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PLy+/MFJVsBnaMYhANiuG7MuuzMJJdty2yJCk6wbBqc=;
 b=ijk7/05fbJ6M2MQN6F/dI8xO1MuF2baxrRp1zJsg37QUxnKMCXJ1seKDliN9yq5Dp1
 Y5fYBCbllKuxhWHvdqRNiMPW097CGrx5gVisEnEeq0H2+z0Z3iqLmiXuRTWJVxoCpJcr
 Pm7m7mak0IvKTTw8b+iaQyv7Swh2QkWSBa9qnwZ03wmGRfNMbtnmcACaAbacmWAllsNY
 wQJqAKkM95i1j0hJfA5eMhlfrwoRctSJnPp4EN4556+95aqQmaY/c/twsPjsBreztGWJ
 OBezENKvaeDR7JEy9PY08F1SHOr7eWnC3aJO+hh60Nu1HfBlymzqUUl0Nr9wm0ntwGTF
 IBLw==
X-Gm-Message-State: AOJu0YwuTC3nWMRmoyapWUeKNXyiOXBrb1zah69x0zTaYxF+UK3KfsM5
 7SvfIsFzJI4PCPaZjwcaU+UzLpChgtfTwrwCLzZDaANfvb61cET4Sr7CHSZA56SX2l1UHrl11eg
 2
X-Gm-Gg: ASbGncv4q9k7/Xj9ZfzkQPyvK50xHKdxC3lzgVmT1Ifp3wzX9nFZJGjtbWN264JiOrw
 4oZpbCs4ocbeOFGSbp+sfXvgMl1mgeveIWuxUy6JLnT7jk0mkIWxom5zXH8kXq1SjfjVAwvyyqV
 1kRlyzfDMMhPvJi6i6eM/rWVzQvRxD16yFLxCb1rnUevAW7muRCgW+Q5jwkzRsKl9EMT0rnw9XL
 +CvBP7t1ivBP30MNfRwkg+aBtXaZqLBKtH/bjc6poMUNxYr9ipUFFID8jfgTw==
X-Google-Smtp-Source: AGHT+IGmnCse30T09bzJlt9e52mr82kuWCnFYyyvTGKceI7/f99DywFoaMVD6gvQqZMLMHVWLVwBOw==
X-Received: by 2002:a5d:59ad:0:b0:385:ed16:c97 with SMTP id
 ffacd0b85a97d-3889ad35736mr2234995f8f.49.1734111223759; 
 Fri, 13 Dec 2024 09:33:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 68/85] target/arm: Convert URECPE and URSQRTE to decodetree
Date: Fri, 13 Dec 2024 17:32:12 +0000
Message-Id: <20241213173229.3308926-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
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

Remove handle_2misc_reciprocal as these were the last
insns decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-69-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   3 +
 target/arm/tcg/translate-a64.c | 139 ++-------------------------------
 2 files changed, 8 insertions(+), 134 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9b3b09c3bb2..f35d123821c 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 63cf25251b9..fa3170da860 100644
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
-- 
2.34.1


