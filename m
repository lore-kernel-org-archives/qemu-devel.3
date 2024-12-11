Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B435E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhz-0002Ax-78; Wed, 11 Dec 2024 11:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhW-0000gk-B1
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:38 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhU-0002Eu-67
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:37 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d87ceb58a0so55622376d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934995; x=1734539795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzA39dBwjs0cXUlOc3PuuZkvbHgGKF20J1/fBY4KUXM=;
 b=usqGa3Pzf6mmivCyi9x6B8cD14cdkP1ffY2Qh0iT96B3Nneon8HgZlOxA78r+j/WNY
 bh4uzl+azgOPP4Z6216bxcYrAG0eqM/+ApxEDuJA0RP+dzEblaMJ+CBZ5T7t3lg8G9QL
 tfRskEDGHur/JmVgTvJmCiswGAcqYDFVqgKP7RN1JYVzIIPKCwUqwjLbXJ8b+dRnIHON
 DRbtHA6STPjg4WEvoCeVu+2OfZgEYxFQoF8MCqQ2G+/muG+261GyE0t/4J4fia38gT0I
 fKYQZJdbm/L6nFnv6BrYG+lARYMstFHsDkTEXYixfMzjyNdZBDFr8uEUOCNa8GM8iznM
 3FCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934995; x=1734539795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzA39dBwjs0cXUlOc3PuuZkvbHgGKF20J1/fBY4KUXM=;
 b=DKILW3OcT1M2EpaUy+ZPaiEF8jukXMFfG1xkqBEK6/oSCdJRSZE8tqwtEqJQAupUGy
 9W0TVwSIupMMcOXgTcXmy6TpeJfAzJIRin7y1sQDv0EMmpiUtI/OJO2nFwonVnPrTHzw
 XPQz/hl2MNKNYvCQ1IkVcg9KvsDmj8YdW16yB/GuIOeCP/cWJYN4SfExR7BT+kiumdUZ
 yE8C7GLkIFZSLz/o/xewdWWB2NMNtPaoZo5bDhQW+sKxmxxxgCbJhmmShub9bqP0vMNW
 YSWGNgThVT4gNfdXv+FpCB0PfPcFxlGEiH77LFDuJIfysGAlXJoR7o80k3qRY750xIhA
 uY0w==
X-Gm-Message-State: AOJu0Ywf754WATZ+oUp+vR0uRxu8rVIgFiU9yPq/z6507i0cKffxlCHf
 5efg8DNDdfO6ADBrYpoT0U2CoVM7n++rkex9T8aN4EhfuTGzmzI57SqRQdFUIvQCBOB4IjQ9vG0
 M9gJkV8m9
X-Gm-Gg: ASbGncuyvkpnr25FarEhSPIXOQ0qbH36uuFwZNFMvdsSTw5Aa9rsW+cwlX1sYWjn9uc
 mEZcus6lZKgY/9IPennJQ6oU53XmYu6ftU2QNSDd8SH+O69AY3yZJ719EVpqfapzF4byDHeRWfD
 IPslOUKcvUGHurptu86xw86OYt6sCvwyW90MwMEldtpG7ijmcZmWk/Y9DoD5BMLmdxxneEfeVI4
 KxikxqMLGb5xAW+N7y33wgGfyCzEOTq/x3r+rm/mFyl6gOG4vAs/n7m6V1b2Q==
X-Google-Smtp-Source: AGHT+IHwVgNCX3egGPjxv9aem+A0YHkol2Bapo0bVAw6JMY7qyR27rqHRDo1/KW8zsag9knIOv98aw==
X-Received: by 2002:a05:6214:2428:b0:6d8:ac5d:b83e with SMTP id
 6a1803df08f44-6d934c0fce6mr64874696d6.47.1733934995198; 
 Wed, 11 Dec 2024 08:36:35 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 55/69] target/arm: Convert FSQRT (vector) to decodetree
Date: Wed, 11 Dec 2024 10:30:22 -0600
Message-ID: <20241211163036.2297116-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2c.google.com
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
 target/arm/tcg/translate-a64.c | 69 ++++++++++++++++++++++++----------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index fd7f7ae714..287e9338a4 100644
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
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f46bd1a715..1e0eb4a748 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1694,3 +1694,6 @@ FABS_v          0.00 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
 
 FNEG_v          0.10 1110 111 11000 11111 0 ..... .....     @qrr_h
 FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
+
+FSQRT_v         0.10 1110 111 11001 11111 0 ..... .....     @qrr_h
+FSQRT_v         0.10 1110 1.1 00001 11111 0 ..... .....     @qrr_sd
-- 
2.43.0


