Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105DCE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Ym-0004uU-Ew; Fri, 13 Dec 2024 12:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xj-0007nd-45
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xg-0001fi-Lo
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:34 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso1079346f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111211; x=1734716011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V7uxB4CcHZe2ZEachsZ0tuLPAFTq4cpha72vkH9WMLY=;
 b=MVXo3Od3sKbNP+C9kOgPFHceYV0/0anZTykYzv7mKh3Jgg15q53r/Po/rREiYbqwmA
 lAq78PMA+1rD6zTAORDuE+twAY44U+FfABBd/NTl2YIcB2fQNesTPDvWiHNrWFWKWbqj
 pF/WRh2sckirsw0ZXa9Iykx1Mndvf0oWjnQv/5Jp+dOoQwvz6XAr0hs/aleROoFAVBl4
 jd7pO7MqjuSu0vzrZHuBvHz0WWhh+ct1GZ4TpgQRrI+d+FlIpCrK9FrgwBLv9pkFja2X
 V1uK8C7+j2lPeB4c110YmGtKzOfUBrUUMq5XiylFPoKh00gTkUEeKHRjMU00wVWjSFLW
 kbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111211; x=1734716011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V7uxB4CcHZe2ZEachsZ0tuLPAFTq4cpha72vkH9WMLY=;
 b=Wd8g0SZU5J+LnXVy7p5RiOXxLFO1WiCmH8zj+Cp/Tm9cQXjCUiCU3zbN0ynTzRWL0z
 5ZpF03SFxOqOvgSQqUXF9iWaHo2vZ3j+Qn/96jSAt3F5Hcz3P/qZ/uihJvPL2DyPBe/s
 NhFRgHSBsgDPgOjWqi8OJF5mZ9UjdzWNNB93odUlpIZ26bZ7EmGEem3++8QvZSd5egCj
 3BUK3gbiwkdoGD9gKUk6F3vDy9LhWmzlexWNYclprj5VRue9fg+TstQaJUoFw1a7B6ub
 t9eX4g3gVOFc5dSxHHbenrjUubcoIsYK/CeY36QQo+kWjDBw1yJQxvRonq3eC10dBI8I
 oVYQ==
X-Gm-Message-State: AOJu0Yxt7+0CufT+2zq2RIwWTW4/LSG1L1Wv02SSODV0F/badlYbvclw
 BaW3ZMMaXVL21uzAav0TOCJUUaz/ocsXPvRK0rD4Wf9Sag6T7xVu8a908idVCGYKTMys4U/soDt
 +
X-Gm-Gg: ASbGncvyOrH/d9oyOI6BrTGw2yE0LLgVlsAbxt8w3l0k1KC0RQpHTdtmtRbw99gdHWi
 X9DIxQduMKprJ8+i/Jg8I73iWBn3hmheHtqDyZ2kXKF722B9vZ0X62weeouUi3o6GuTh2278/J1
 H+f9utdyH3Z2wyHTGKhWR1K+d/Roy9o3lNb+RqKgCTVS9eeC67LuigZ4vV+VWAZFxkWXZHXD0GS
 YpzqxorHqNwTlecxYQtYQFKNmoCCElyVQ7KZGLkPMEhFozqHh+s+n4zf3MPFg==
X-Google-Smtp-Source: AGHT+IFVWDjyFfgnI3A6bASzrwq6J05vU6nfu5GrQatK7iJ+dzPFZtxjqcx33l73+M5AdMqGbV3pFQ==
X-Received: by 2002:a5d:5f55:0:b0:385:e303:8dd8 with SMTP id
 ffacd0b85a97d-38880ae11aemr2572008f8f.26.1734111211106; 
 Fri, 13 Dec 2024 09:33:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/85] target/arm: Convert FRINT* (vector) to decodetree
Date: Fri, 13 Dec 2024 17:32:00 +0000
Message-Id: <20241213173229.3308926-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
Message-id: 20241211163036.2297116-57-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  26 +++++
 target/arm/tcg/translate-a64.c | 176 ++++++++++++---------------------
 2 files changed, 88 insertions(+), 114 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1e0eb4a748e..5e02144f651 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 287e9338a45..0f924b07dcd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9209,6 +9209,21 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
 
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
@@ -9520,25 +9535,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
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
@@ -9550,6 +9546,17 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
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
@@ -10094,46 +10101,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10141,6 +10114,17 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10229,33 +10213,25 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10289,7 +10265,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     int rn, rd;
     bool is_q;
     bool is_scalar;
-    bool only_in_vector = false;
 
     int pass;
     TCGv_i32 tcg_rmode = NULL;
@@ -10343,31 +10318,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
@@ -10404,6 +10354,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
@@ -10415,11 +10372,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
@@ -10494,17 +10446,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
@@ -10512,6 +10453,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
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
 
-- 
2.34.1


