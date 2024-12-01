Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F243ED49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlaz-0001Od-Tc; Sun, 01 Dec 2024 10:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaQ-000842-TS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:18 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaN-0005Dx-OX
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:14 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5f1d1068451so1040940eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065810; x=1733670610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7DfhKl5l0B+Z8DabpkQFpZe+bGRJiOCeuNJ2rOocdo=;
 b=QTTDB/aDx6IgHJz0AlEymJGPEZMd6cXtuvu4hmOLndxaOt6P/dqjHEQ5vlGvz3f/O6
 3t+sujc6QWeqhRM8S/G5buQsKwbtzFGA8h1pYW/nxfkFoCgSVofka0WfhXTwp0QS1lSV
 6UCqnZXiSsuRT+jlN9HH0uB2ons3o/SuM3W8sdPQs3yGYTyuABEu8TbFeHT2l6yUcoZJ
 +jHA3/4ZjoHJY0ZhzT+flTvfLpTqx9iro4R8N64BkCPWIZs1B5nRU2ryNSgOKTZ/flm8
 MN9cqceqvM8DdTAgy5uwEJqi6rSFC1N7qtNpWhWZG8l3k9J3suvfsuwYF5Ube4R8dVNq
 BA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065810; x=1733670610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7DfhKl5l0B+Z8DabpkQFpZe+bGRJiOCeuNJ2rOocdo=;
 b=qNFKQFLxD1gWyqTZUAFb8RlF5LdGYBeh6JcB2kCLaTv7pLFYOC9/MeEtlWLDKi7lY4
 hXavSiWEoHjA0imuQOxVgKuPNV5WKptjeYHLf5Ao8ds5FCA+kemvXP3yObiZJ7Bx3RlM
 W/InVExaVA06R8+Idpg1H9LVSbGI0b1tkaEFY2MY+AsUCgEGsigCSQhhIXB2NSimktgq
 jR/v3xk99pZOdR1PNbRU6IHYK/4rolyKS8YffgRr1+ppPwAoyd+/cWqmpSOykknlbCoj
 XoOJlr2+kYCtdF34aoHVe6Bl6tWG3E5leH8Hsk9sYXirRa2CM41cE/BSrn8vJSCFbIRl
 Jnxw==
X-Gm-Message-State: AOJu0Yzz09rZP7I7CoIc8e1K8dLUZescOOpKmaGqEm2YQGNCEzqoMJ9+
 ilSH2YMNjJj4BraOy01/DDzXvVdIp0b+icfPNXpxn5TZBhbyykEW/TRcvGuZdbFUtqUEXIIDqQ0
 S6OM=
X-Gm-Gg: ASbGnctNtDvluzk3Ibaoxje6jHOV+iDZ7pSKVeEal35wvS2pdpTm9+XxZVtHHUsjMs1
 zHIY2PDlLbS6ozoOapz7hwmOGJD8QMdstKVjDIGSCpJ1pGxZvarMtjKGs5RPVBTTYd1yphUZaQc
 6TMKqHnmeJCePGhYW9q3RuMAYdclf+vKlDMXDWTVMgAmiIOt8G7eta/BWfqtAJ7XfpTfPGKsUDI
 Zc4py0lHScY4U1kFCNsah9V7gFVLINETPaE3N3WE0Uu7cPsCiUZ5cjDZeWceg/2pFK/ul5k/bwR
 RKlPO2GXunsH6iT7u0jFpgZwxhG7PEez4uVT
X-Google-Smtp-Source: AGHT+IEhPH2KVUIMJbnMmtdQaAwxfokzaVx0XYgdMYJhwVRJwxRK9gs1kE/HumEzNSLQxcZlRC/xuQ==
X-Received: by 2002:a4a:ee0f:0:b0:5ee:e2eb:ea57 with SMTP id
 006d021491bc7-5f209fc7ea5mr12761755eaf.0.1733065810131; 
 Sun, 01 Dec 2024 07:10:10 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 54/67] target/arm: Convert FRINT* (vector) to decodetree
Date: Sun,  1 Dec 2024 09:05:53 -0600
Message-ID: <20241201150607.12812-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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
 target/arm/tcg/translate-a64.c | 176 ++++++++++++---------------------
 target/arm/tcg/a64.decode      |  26 +++++
 2 files changed, 88 insertions(+), 114 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1e8cb07992..98a42feb7d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9221,6 +9221,21 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
 
 TRANS(FSQRT_v, do_fp1_vector, a, &f_scalar_fsqrt, -1)
 
+TRANS(FRINTN_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_TIEEVEN)
+TRANS(FRINTP_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_POSINF)
+TRANS(FRINTM_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_NEGINF)
+TRANS(FRINTZ_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_ZERO)
+TRANS(FRINTA_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_TIEAWAY)
+TRANS(FRINTI_v, do_fp1_vector, a, &f_scalar_frint, -1)
+TRANS(FRINTX_v, do_fp1_vector, a, &f_scalar_frintx, -1)
+
+TRANS_FEAT(FRINT32Z_v, aa64_frint, do_fp1_vector, a,
+           &f_scalar_frint32, FPROUNDING_ZERO)
+TRANS_FEAT(FRINT32X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint32, -1)
+TRANS_FEAT(FRINT64Z_v, aa64_frint, do_fp1_vector, a,
+           &f_scalar_frint64, FPROUNDING_ZERO)
+TRANS_FEAT(FRINT64X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint64, -1)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9532,25 +9547,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x7b: /* FCVTZU */
         gen_helper_vfp_touqd(tcg_rd, tcg_rn, tcg_constant_i32(0), tcg_fpstatus);
         break;
-    case 0x18: /* FRINTN */
-    case 0x19: /* FRINTM */
-    case 0x38: /* FRINTP */
-    case 0x39: /* FRINTZ */
-    case 0x58: /* FRINTA */
-    case 0x79: /* FRINTI */
-        gen_helper_rintd(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
-    case 0x59: /* FRINTX */
-        gen_helper_rintd_exact(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
-    case 0x1e: /* FRINT32Z */
-    case 0x5e: /* FRINT32X */
-        gen_helper_frint32_d(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
-    case 0x1f: /* FRINT64Z */
-    case 0x5f: /* FRINT64X */
-        gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
     default:
     case 0x4: /* CLS, CLZ */
     case 0x5: /* NOT */
@@ -9562,6 +9558,17 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
     case 0x7f: /* FSQRT */
+    case 0x18: /* FRINTN */
+    case 0x19: /* FRINTM */
+    case 0x38: /* FRINTP */
+    case 0x39: /* FRINTZ */
+    case 0x58: /* FRINTA */
+    case 0x79: /* FRINTI */
+    case 0x59: /* FRINTX */
+    case 0x1e: /* FRINT32Z */
+    case 0x5e: /* FRINT32X */
+    case 0x1f: /* FRINT64Z */
+    case 0x5f: /* FRINT64X */
         g_assert_not_reached();
     }
 }
@@ -10106,46 +10113,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_widening(s, opcode, is_q, size, rn, rd);
             return;
-        case 0x18: /* FRINTN */
-        case 0x19: /* FRINTM */
-        case 0x38: /* FRINTP */
-        case 0x39: /* FRINTZ */
-            rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            /* fall through */
-        case 0x59: /* FRINTX */
-        case 0x79: /* FRINTI */
-            need_fpstatus = true;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
-        case 0x58: /* FRINTA */
-            rmode = FPROUNDING_TIEAWAY;
-            need_fpstatus = true;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x7c: /* URSQRTE */
             if (size == 3) {
                 unallocated_encoding(s);
                 return;
             }
             break;
-        case 0x1e: /* FRINT32Z */
-        case 0x1f: /* FRINT64Z */
-            rmode = FPROUNDING_ZERO;
-            /* fall through */
-        case 0x5e: /* FRINT32X */
-        case 0x5f: /* FRINT64X */
-            need_fpstatus = true;
-            if ((size == 3 && !is_q) || !dc_isar_feature(aa64_frint, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         default:
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
@@ -10153,6 +10126,17 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x2f: /* FABS */
         case 0x6f: /* FNEG */
         case 0x7f: /* FSQRT */
+        case 0x18: /* FRINTN */
+        case 0x19: /* FRINTM */
+        case 0x38: /* FRINTP */
+        case 0x39: /* FRINTZ */
+        case 0x59: /* FRINTX */
+        case 0x79: /* FRINTI */
+        case 0x58: /* FRINTA */
+        case 0x1e: /* FRINT32Z */
+        case 0x1f: /* FRINT64Z */
+        case 0x5e: /* FRINT32X */
+        case 0x5f: /* FRINT64X */
             unallocated_encoding(s);
             return;
         }
@@ -10241,33 +10225,25 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_vfp_touls(tcg_res, tcg_op,
                                          tcg_constant_i32(0), tcg_fpstatus);
                     break;
-                case 0x18: /* FRINTN */
-                case 0x19: /* FRINTM */
-                case 0x38: /* FRINTP */
-                case 0x39: /* FRINTZ */
-                case 0x58: /* FRINTA */
-                case 0x79: /* FRINTI */
-                    gen_helper_rints(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
-                case 0x59: /* FRINTX */
-                    gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
                 case 0x7c: /* URSQRTE */
                     gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
-                case 0x1e: /* FRINT32Z */
-                case 0x5e: /* FRINT32X */
-                    gen_helper_frint32_s(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
-                case 0x1f: /* FRINT64Z */
-                case 0x5f: /* FRINT64X */
-                    gen_helper_frint64_s(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
                 case 0x2f: /* FABS */
                 case 0x6f: /* FNEG */
                 case 0x7f: /* FSQRT */
+                case 0x18: /* FRINTN */
+                case 0x19: /* FRINTM */
+                case 0x38: /* FRINTP */
+                case 0x39: /* FRINTZ */
+                case 0x58: /* FRINTA */
+                case 0x79: /* FRINTI */
+                case 0x59: /* FRINTX */
+                case 0x1e: /* FRINT32Z */
+                case 0x5e: /* FRINT32X */
+                case 0x1f: /* FRINT64Z */
+                case 0x5f: /* FRINT64X */
                     g_assert_not_reached();
                 }
             }
@@ -10301,7 +10277,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     int rn, rd;
     bool is_q;
     bool is_scalar;
-    bool only_in_vector = false;
 
     int pass;
     TCGv_i32 tcg_rmode = NULL;
@@ -10355,31 +10330,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x3d: /* FRECPE */
     case 0x3f: /* FRECPX */
         break;
-    case 0x18: /* FRINTN */
-        only_in_vector = true;
-        rmode = FPROUNDING_TIEEVEN;
-        break;
-    case 0x19: /* FRINTM */
-        only_in_vector = true;
-        rmode = FPROUNDING_NEGINF;
-        break;
-    case 0x38: /* FRINTP */
-        only_in_vector = true;
-        rmode = FPROUNDING_POSINF;
-        break;
-    case 0x39: /* FRINTZ */
-        only_in_vector = true;
-        rmode = FPROUNDING_ZERO;
-        break;
-    case 0x58: /* FRINTA */
-        only_in_vector = true;
-        rmode = FPROUNDING_TIEAWAY;
-        break;
-    case 0x59: /* FRINTX */
-    case 0x79: /* FRINTI */
-        only_in_vector = true;
-        /* current rounding mode */
-        break;
     case 0x1a: /* FCVTNS */
         rmode = FPROUNDING_TIEEVEN;
         break;
@@ -10416,6 +10366,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
     case 0x7f: /* FSQRT (vector) */
+    case 0x18: /* FRINTN */
+    case 0x19: /* FRINTM */
+    case 0x38: /* FRINTP */
+    case 0x39: /* FRINTZ */
+    case 0x58: /* FRINTA */
+    case 0x59: /* FRINTX */
+    case 0x79: /* FRINTI */
         unallocated_encoding(s);
         return;
     }
@@ -10427,11 +10384,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* FRINTxx is only in the vector form */
-        if (only_in_vector) {
-            unallocated_encoding(s);
-            return;
-        }
     }
 
     if (!fp_access_check(s)) {
@@ -10507,17 +10459,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x7b: /* FCVTZU */
                 gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x18: /* FRINTN */
-            case 0x19: /* FRINTM */
-            case 0x38: /* FRINTP */
-            case 0x39: /* FRINTZ */
-            case 0x58: /* FRINTA */
-            case 0x79: /* FRINTI */
-                gen_helper_advsimd_rinth(tcg_res, tcg_op, tcg_fpstatus);
-                break;
-            case 0x59: /* FRINTX */
-                gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
-                break;
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
@@ -10525,6 +10466,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x2f: /* FABS */
             case 0x6f: /* FNEG */
             case 0x7f: /* FSQRT */
+            case 0x18: /* FRINTN */
+            case 0x19: /* FRINTM */
+            case 0x38: /* FRINTP */
+            case 0x39: /* FRINTZ */
+            case 0x58: /* FRINTA */
+            case 0x79: /* FRINTI */
+            case 0x59: /* FRINTX */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f6b334b148..4bd72d7f7f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1697,3 +1697,29 @@ FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
 
 FSQRT_v         0.10 1110 111 11001 11111 0 ..... .....     @qrr_h
 FSQRT_v         0.10 1110 1.1 00001 11111 0 ..... .....     @qrr_sd
+
+FRINTN_v        0.00 1110 011 11001 10001 0 ..... .....     @qrr_h
+FRINTN_v        0.00 1110 0.1 00001 10001 0 ..... .....     @qrr_sd
+
+FRINTM_v        0.00 1110 011 11001 10011 0 ..... .....     @qrr_h
+FRINTM_v        0.00 1110 0.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINTP_v        0.00 1110 111 11001 10001 0 ..... .....     @qrr_h
+FRINTP_v        0.00 1110 1.1 00001 10001 0 ..... .....     @qrr_sd
+
+FRINTZ_v        0.00 1110 111 11001 10011 0 ..... .....     @qrr_h
+FRINTZ_v        0.00 1110 1.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINTA_v        0.10 1110 011 11001 10001 0 ..... .....     @qrr_h
+FRINTA_v        0.10 1110 0.1 00001 10001 0 ..... .....     @qrr_sd
+
+FRINTX_v        0.10 1110 011 11001 10011 0 ..... .....     @qrr_h
+FRINTX_v        0.10 1110 0.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINTI_v        0.10 1110 111 11001 10011 0 ..... .....     @qrr_h
+FRINTI_v        0.10 1110 1.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINT32Z_v      0.00 1110 0.1 00001 11101 0 ..... .....     @qrr_sd
+FRINT32X_v      0.10 1110 0.1 00001 11101 0 ..... .....     @qrr_sd
+FRINT64Z_v      0.00 1110 0.1 00001 11111 0 ..... .....     @qrr_sd
+FRINT64X_v      0.10 1110 0.1 00001 11111 0 ..... .....     @qrr_sd
-- 
2.43.0


