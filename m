Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DE6E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Yc-0003bn-U4; Fri, 13 Dec 2024 12:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xg-0007jf-UF
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xe-0001f6-UX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:32 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso1800750f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111209; x=1734716009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1RVhb1E6KdPM5w5M3RKYCjBHFJdX2lNxNRf5tJorseo=;
 b=FPZLGozgI4zP6Sg5WY8n05Kow8pO2JnWbxGtkZloParqmZJmY+4BDNrhR4NWbj72jr
 gGnUI92wWPktmj3CH/H0bX0mjBuLDRPLmO9EaEDUae2iN1cp5MON6jprN5HlIEAhzo5W
 rRiSxSOegrBHZCyGPwEtWf5JPzcX1CbUHV8XXIskvBjcaiPiQbwMRXp+fZ/4Ye/qDoH7
 sm4l0eD1oIz5KASxYrzr+DyYqXtXN6/IC/RtN+xq4vVPsZRW/r2TQSNFqKDjEnK0hgEa
 C3zuuHUrXxPjDmwG238EZZoWqlK7VKyomL4gqkExhmg35GNSZ8lNscvVwclYBPYfTQJj
 eI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111209; x=1734716009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RVhb1E6KdPM5w5M3RKYCjBHFJdX2lNxNRf5tJorseo=;
 b=qKaIUGsSIu5akBNohgvwINRlXfE173i4xrfPxdeYROy5G5pPy3tTifDX9tHol8M/4C
 fzMz4ZsRFnrKPXEX+NzPQFqGxRzH6FeLiEejYRe0/14MYo83D9Zl0TSF/MdWd78WrOIG
 7mCslrg1Dz/ZjH8SCcpXTHZOOCl6R/xIrx4BvQaKgSQ3uBhr19D6nIaCdaSdCtdnJwRO
 xSUspgzxvPE/WwiWMjEqnmyEmY3LD6wLntZkW2FDwwKYua4zfEaWtUumX5kIbXA/O3pY
 F1nGFxPVta5qkOfd7SsDHACrI+MwOhE9Tu8dBFlxmPuSgsp2aoNAhvwoqMI2b85vSt2F
 G0OQ==
X-Gm-Message-State: AOJu0Yxdzcz9fbkrPijwW/F6zS/3mI/JJy0PVumMHrBZ6QWhmds9nANu
 MOlsncW0Lieui+2KeT0Qeggs/WvUwJgQaWCPgOSySKr5a2HUQMh4o9oOhZOdegtDE+BExi/vmnf
 p
X-Gm-Gg: ASbGncsOpFsemBEHc7KQxs2Ld9TgTJn8IU8V+r51OvYvSUrGmKjokJafgLHCkzUfqJ3
 +k4KRKKs8Yj5Y2XlnXLBahtUyIkWdZIxnvSce1MM8N9OZtiI+EMS9kKDPPYbCEjzVJo2wE+83Iq
 iObUf0P+/CT5qd5MRvCVOjAgSUa930noRY4KqTjj3sVxOXYMCk6gr0nNgIUHER7VVdmom+cEImF
 lDkoiJ9VNwT5WjlJjz3YyhrH3WhzMMmBHEyzncTzofrHf6eL7MPDrC71BLKhg==
X-Google-Smtp-Source: AGHT+IGUBmkdVXL3ZUwPD3Y5yBSE39e71u/tJHU0KVRLMf2hThVCWegN4OqqBy6MiFjaFvhKuebEdA==
X-Received: by 2002:a05:6000:78a:b0:385:fb40:e549 with SMTP id
 ffacd0b85a97d-3888e0bfca2mr3094697f8f.55.1734111209168; 
 Fri, 13 Dec 2024 09:33:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/85] target/arm: Convert FABS, FNEG (vector) to decodetree
Date: Fri, 13 Dec 2024 17:31:58 +0000
Message-Id: <20241213173229.3308926-55-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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
Message-id: 20241211163036.2297116-55-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  7 +++++
 target/arm/tcg/translate-a64.c | 54 +++++++++++++++-------------------
 2 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ec0d46a563c..f46bd1a715e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -77,6 +77,7 @@
 @qrr_s          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=2
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
+@qrr_sd         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_sd
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1687,3 +1688,9 @@ FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
 
 SHLL_v          0.10 1110 ..1 00001 00111 0 ..... .....     @qrr_e
+
+FABS_v          0.00 1110 111 11000 11111 0 ..... .....     @qrr_h
+FABS_v          0.00 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
+
+FNEG_v          0.10 1110 111 11000 11111 0 ..... .....     @qrr_h
+FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c5d456de3be..fd7f7ae7146 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9149,6 +9149,20 @@ static bool trans_SHLL_v(DisasContext *s, arg_qrr_e *a)
     return true;
 }
 
+static bool do_fabs_fneg_v(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
+{
+    int check = fp_access_check_vector_hsd(s, a->q, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    gen_gvec_fn2(s, a->q, a->rd, a->rn, fn, a->esz);
+    return true;
+}
+
+TRANS(FABS_v, do_fabs_fneg_v, a, gen_gvec_fabs)
+TRANS(FNEG_v, do_fabs_fneg_v, a, gen_gvec_fneg)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9447,12 +9461,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * requires them.
      */
     switch (opcode) {
-    case 0x2f: /* FABS */
-        gen_vfp_absd(tcg_rd, tcg_rn);
-        break;
-    case 0x6f: /* FNEG */
-        gen_vfp_negd(tcg_rd, tcg_rn);
-        break;
     case 0x7f: /* FSQRT */
         gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
@@ -9497,6 +9505,8 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x9: /* CMEQ, CMLE */
     case 0xa: /* CMLT */
     case 0xb: /* ABS, NEG */
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
         g_assert_not_reached();
     }
 }
@@ -9968,13 +9978,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         opcode |= (extract32(size, 1, 1) << 5) | (u << 6);
         size = is_double ? 3 : 2;
         switch (opcode) {
-        case 0x2f: /* FABS */
-        case 0x6f: /* FNEG */
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x1d: /* SCVTF */
         case 0x5d: /* UCVTF */
         {
@@ -10099,6 +10102,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
         case 0x56: /* FCVTXN, FCVTXN2 */
+        case 0x2f: /* FABS */
+        case 0x6f: /* FNEG */
             unallocated_encoding(s);
             return;
         }
@@ -10171,12 +10176,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x2f: /* FABS */
-                    gen_vfp_abss(tcg_res, tcg_op);
-                    break;
-                case 0x6f: /* FNEG */
-                    gen_vfp_negs(tcg_res, tcg_op);
-                    break;
                 case 0x7f: /* FSQRT */
                     gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
                     break;
@@ -10220,6 +10219,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
+                case 0x2f: /* FABS */
+                case 0x6f: /* FNEG */
                     g_assert_not_reached();
                 }
             }
@@ -10362,17 +10363,14 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x7b: /* FCVTZU */
         rmode = FPROUNDING_ZERO;
         break;
-    case 0x2f: /* FABS */
-    case 0x6f: /* FNEG */
-        only_in_vector = true;
-        need_fpst = false;
-        break;
     case 0x7d: /* FRSQRTE */
         break;
     case 0x7f: /* FSQRT (vector) */
         only_in_vector = true;
         break;
     default:
+    case 0x2f: /* FABS */
+    case 0x6f: /* FNEG */
         unallocated_encoding(s);
         return;
     }
@@ -10474,12 +10472,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x59: /* FRINTX */
                 gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x2f: /* FABS */
-                tcg_gen_andi_i32(tcg_res, tcg_op, 0x7fff);
-                break;
-            case 0x6f: /* FNEG */
-                tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-                break;
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
@@ -10487,6 +10479,8 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
             default:
+            case 0x2f: /* FABS */
+            case 0x6f: /* FNEG */
                 g_assert_not_reached();
             }
 
-- 
2.34.1


