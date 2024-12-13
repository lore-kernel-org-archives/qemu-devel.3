Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F836E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Yg-000457-8D; Fri, 13 Dec 2024 12:34:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xk-0007pO-O1
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:36 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xf-0001fI-LB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:36 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385df53e559so1604239f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111210; x=1734716010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4tifFC9D40iwr5FX6YfXLv5cKj82kQOZxP83JkYfn5I=;
 b=QLOzqPY1Ryy0RIjU9SSJZULOOGFDy/mdHk6W91fxK9oNQ7MxF8cMHr0ucJUDhLY9uU
 JBIUq4J9pxSBs+hgLv1ywps1676h2hsrLg3ckexDOFsKpP1BkUqro2I8wgDvsYDehcPF
 eLRdenBuLVZgHR6fTJGVGN/q/2RuR582dgXDyWjrYWhXZNgEemI9IqUPJ1paNLO6viis
 M9IItZ977/1RVXTKjvva4a/3aS/PQ2McRScwkLZujHESR/sqrUinTvIO2wDmnK3W3VTc
 KVYribHCrRS88PHnRIbGYfkQWFFnabEzU+8iAzWqwE89StJQ7KM6X6UwschFZOFb2h0k
 e1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111210; x=1734716010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4tifFC9D40iwr5FX6YfXLv5cKj82kQOZxP83JkYfn5I=;
 b=NcmjD4JgcsDd8S6BwG0oEK+8kz6ElrlKAUpYUORH6CgVXCgEjTUwglWWNP3M2JoeJH
 krD87QcMPJQw/DdZED1cf909Y+DfoALx3aSpv8yKuKkQA+R5Of0pUNwMzKhxGZ59hK4d
 4zfp8LCIjJbSd8U3hGJI9FyX/afAWRLgC+TNQSejyIUKfbsdHVIKRXfnZ1jPf8qfDmx/
 ZzO+K0hYbVAS1h1qqRskXK/6AG9Nmyz6t6wwCLoXUVUL+pNfPeY91izobo2YRs83/ytH
 kJTcX/Ufj6mt97Tyj9rev58FHTx74+mG0es0AbzKSYdxKE1mKbU5nsoHXUJ9axqfx4x+
 mx0Q==
X-Gm-Message-State: AOJu0YzRWQDlNJwinA8MEDbnDt2uoR2sANonm/VbKH9lPcfhGCy0vSdX
 720CUqCvK7pjZbEger2iSdIQKSBT9c5qLxy2e0oGfAY2Han+TRHvI4d4rMsn+PAM1qHPo7Q8Ipm
 r
X-Gm-Gg: ASbGncvoN38TpZeL6rEjjRg/NscLocjF6Ppf4uSBk8GlDiJgg5K1nQR88UDhTVj+YMs
 osPxd2Blat4O8IIJFiEkINYdyAeRBt36txh6nKXcQ8HNWhZZEG7PTEo2NHF1mmc7ouOoZlN7NLx
 6eyzqoLnV8tdEXLhtxHskq1wERyb2Vyl1ZklIzDrqwpabFonMrpSLke+CLWPoCIrqoAnWoLPvGL
 X2md+pEOehDUZtdL9PLF1y7dvkLBmOPWSk0P/Jmv9BDhHtXuWJduXCpLRpjuw==
X-Google-Smtp-Source: AGHT+IERuLm2hoxQEClkYPZyLxvZFzqT3+upuc/0TANisCvLkfu4kcH5hpAIbn28pKy3jXqXdamEgQ==
X-Received: by 2002:a5d:64ef:0:b0:385:f4db:e336 with SMTP id
 ffacd0b85a97d-38880af1626mr2187353f8f.2.1734111210180; 
 Fri, 13 Dec 2024 09:33:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 55/85] target/arm: Convert FSQRT (vector) to decodetree
Date: Fri, 13 Dec 2024 17:31:59 +0000
Message-Id: <20241213173229.3308926-56-peter.maydell@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-id: 20241211163036.2297116-56-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  3 ++
 target/arm/tcg/translate-a64.c | 69 ++++++++++++++++++++++++----------
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f46bd1a715e..1e0eb4a748e 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1694,3 +1694,6 @@ FABS_v          0.00 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
 
 FNEG_v          0.10 1110 111 11000 11111 0 ..... .....     @qrr_h
 FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
+
+FSQRT_v         0.10 1110 111 11001 11111 0 ..... .....     @qrr_h
+FSQRT_v         0.10 1110 1.1 00001 11111 0 ..... .....     @qrr_sd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fd7f7ae7146..287e9338a45 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9164,6 +9164,51 @@ static bool do_fabs_fneg_v(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 TRANS(FABS_v, do_fabs_fneg_v, a, gen_gvec_fabs)
 TRANS(FNEG_v, do_fabs_fneg_v, a, gen_gvec_fneg)
 
+static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
+                          const FPScalar1 *f, int rmode)
+{
+    TCGv_i32 tcg_rmode = NULL;
+    TCGv_ptr fpst;
+    int check = fp_access_check_vector_hsd(s, a->q, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    fpst = fpstatus_ptr(a->esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    if (rmode >= 0) {
+        tcg_rmode = gen_set_rmode(rmode, fpst);
+    }
+
+    if (a->esz == MO_64) {
+        TCGv_i64 t64 = tcg_temp_new_i64();
+
+        for (int pass = 0; pass < 2; ++pass) {
+            read_vec_element(s, t64, a->rn, pass, MO_64);
+            f->gen_d(t64, t64, fpst);
+            write_vec_element(s, t64, a->rd, pass, MO_64);
+        }
+    } else {
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        void (*gen)(TCGv_i32, TCGv_i32, TCGv_ptr)
+            = (a->esz == MO_16 ? f->gen_h : f->gen_s);
+
+        for (int pass = 0, n = (a->q ? 16 : 8) >> a->esz; pass < n; ++pass) {
+            read_vec_element_i32(s, t32, a->rn, pass, a->esz);
+            gen(t32, t32, fpst);
+            write_vec_element_i32(s, t32, a->rd, pass, a->esz);
+        }
+    }
+    clear_vec_high(s, a->q, a->rd);
+
+    if (rmode >= 0) {
+        gen_restore_rmode(tcg_rmode, fpst);
+    }
+    return true;
+}
+
+TRANS(FSQRT_v, do_fp1_vector, a, &f_scalar_fsqrt, -1)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9461,9 +9506,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
      * requires them.
      */
     switch (opcode) {
-    case 0x7f: /* FSQRT */
-        gen_helper_vfp_sqrtd(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
     case 0x1a: /* FCVTNS */
     case 0x1b: /* FCVTMS */
     case 0x1c: /* FCVTAS */
@@ -9507,6 +9549,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0xb: /* ABS, NEG */
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+    case 0x7f: /* FSQRT */
         g_assert_not_reached();
     }
 }
@@ -10004,13 +10047,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
             return;
-        case 0x7f: /* FSQRT */
-            need_fpstatus = true;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x3a: /* FCVTPS */
@@ -10104,6 +10140,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x56: /* FCVTXN, FCVTXN2 */
         case 0x2f: /* FABS */
         case 0x6f: /* FNEG */
+        case 0x7f: /* FSQRT */
             unallocated_encoding(s);
             return;
         }
@@ -10176,9 +10213,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             {
                 /* Special cases for 32 bit elements */
                 switch (opcode) {
-                case 0x7f: /* FSQRT */
-                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
                 case 0x1a: /* FCVTNS */
                 case 0x1b: /* FCVTMS */
                 case 0x1c: /* FCVTAS */
@@ -10221,6 +10255,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 case 0x7: /* SQABS, SQNEG */
                 case 0x2f: /* FABS */
                 case 0x6f: /* FNEG */
+                case 0x7f: /* FSQRT */
                     g_assert_not_reached();
                 }
             }
@@ -10365,12 +10400,10 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         break;
     case 0x7d: /* FRSQRTE */
         break;
-    case 0x7f: /* FSQRT (vector) */
-        only_in_vector = true;
-        break;
     default:
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+    case 0x7f: /* FSQRT (vector) */
         unallocated_encoding(s);
         return;
     }
@@ -10475,12 +10508,10 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x7f: /* FSQRT */
-                gen_helper_vfp_sqrth(tcg_res, tcg_op, tcg_fpstatus);
-                break;
             default:
             case 0x2f: /* FABS */
             case 0x6f: /* FNEG */
+            case 0x7f: /* FSQRT */
                 g_assert_not_reached();
             }
 
-- 
2.34.1


