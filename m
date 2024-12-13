Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5288E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Xe-0007cR-OG; Fri, 13 Dec 2024 12:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XM-0007BZ-H9
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:14 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XK-0001aa-4O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so992517f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111188; x=1734715988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DCQB6BPKkO4wRdcs1RI2PINATLxFcMWBk80QRmMqCso=;
 b=KEk9W75VUmiHvKsTggRZ2Fcyj0wRy2j2hrKAZhP0eiT7qnq/IboaUiEf672i2oUfbQ
 FTS5um1W5AecWRy8teKIlbf+soeTMBO+zNsgX7uQANB++0NJ5kztGPxQEcAJ0LpvEPTQ
 Ai+A/4IjWP/O5C54D572iPdH5sfJ8TW1ShkggRcQCoZVaoyaPR+X7pED0erij5RBLNnf
 zwkYCpbTnOhuAu2JYzjgE9ebvFgGC+WdR/CRHKktITtGAV+CCIc1fs00xvEAK4rfXkOX
 Bx0p/1mD71TUmUKm1b3qSFK/axBoVmAJ2T9r0KNOQZ9wU/swX1h7EX60p9kVT1qtX1ms
 08qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111188; x=1734715988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCQB6BPKkO4wRdcs1RI2PINATLxFcMWBk80QRmMqCso=;
 b=JMoGdiAwgd0PVcq70utyZtMhgGqgbBfjBAGmfkrYBeHRcQCXd9kVhyPFA5ejw8kyVT
 GgWbrS6s0W2mWGesKMSGk9ng1RQp4zFf9uXcEdEzH6wj/ACFxukNcZ2OSLxNqTuHMpA8
 xz1/HDhmq4REEgiuIxKvpaP4z/tZe4YE4AuS/YU590mlWvB7FEP54/O+P0mLP9QYNY4m
 XZblEpnZciX+I4YPySYW27NRBoulonX5uYVB912tFJooePThYmmVyToefu5KM2MpGYOU
 T2RGW3Zu1HslKro0t8fl2O31zIuoAUzOsD2gBRwM3Pe7+5XJvpPqNwK4P6OtjpgjyB4O
 oAUw==
X-Gm-Message-State: AOJu0Yw5rJVW82StjT0gO4DjTPry28hvfeJYCeea9eP0NWGUknLSxCv/
 f0HbGppck1q7xluqgFtBiTA5kUhmHaGB25bFMimWbNor/pAUQFW3Gv8hZwEvTI0w4e8NNHVpYuB
 G
X-Gm-Gg: ASbGncscIbrs3jAe8ofvQm4UzCF+3wVUVFy4vkLAepZPkCrO9xLCHKcied6nWggOcKZ
 z/cuFBPY3LPTRjhLBgXbJc2fzhdh+hQVBmQzSISOBRDuic16mZAqI3NI8frdyqaOd7tG1Z52Avs
 s0u3bo7HPDc4G79CKcfZaOV8jVTRY0eq80c3gy3KSJjc3OinceZPl3TBa2yBbCX+aq/rGC+grls
 w54+rIZg/mte8XwKNnPlQsXMKE59ynk4sP82i46kMElnuNnVJDj7wMXn2dlNQ==
X-Google-Smtp-Source: AGHT+IG6ZA3nrpCKnpI9vHJ7ApZkAor7b8SF1KUAocK2u3Cq6Dczqf6c+l78kx4LLoVNpX+HuTwVwA==
X-Received: by 2002:a05:6000:791:b0:385:f44a:a64 with SMTP id
 ffacd0b85a97d-38880ad1d01mr3044083f8f.24.1734111188366; 
 Fri, 13 Dec 2024 09:33:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/85] target/arm: Convert SQABS, SQNEG to decodetree
Date: Fri, 13 Dec 2024 17:31:39 +0000
Message-Id: <20241213173229.3308926-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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
Message-id: 20241211163036.2297116-36-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  11 +++
 target/arm/tcg/translate-a64.c | 123 +++++++++++++++++++++------------
 2 files changed, 89 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5b9f7caa7fb..17ecdac9dbd 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -47,6 +47,7 @@
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
 @rr_s           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=2
 @rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
+@rr_e           ........ esz:2 . ..... ...... rn:5 rd:5 &rr_e
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 @rr_hsd         ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_hsd
 
@@ -1626,3 +1627,13 @@ UQRSHRN_si      0111 11110 .... ... 10011 1 ..... .....     @shri_s
 SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_b
 SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_h
 SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_s
+
+# Advanced SIMD scalar two-register miscellaneous
+
+SQABS_s         0101 1110 ..1 00000 01111 0 ..... .....     @rr_e
+SQNEG_s         0111 1110 ..1 00000 01111 0 ..... .....     @rr_e
+
+# Advanced SIMD two-register miscellaneous
+
+SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
+SQNEG_v         0.10 1110 ..1 00000 01111 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 95bb2b1ca9e..9bb9668d111 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8817,6 +8817,78 @@ static bool trans_FMOV_xu(DisasContext *s, arg_rr *a)
     return true;
 }
 
+typedef struct ENVScalar1 {
+    NeonGenOneOpEnvFn *gen_bhs[3];
+    NeonGenOne64OpEnvFn *gen_d;
+} ENVScalar1;
+
+static bool do_env_scalar1(DisasContext *s, arg_rr_e *a, const ENVScalar1 *f)
+{
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    if (a->esz == MO_64) {
+        TCGv_i64 t = read_fp_dreg(s, a->rn);
+        f->gen_d(t, tcg_env, t);
+        write_fp_dreg(s, a->rd, t);
+    } else {
+        TCGv_i32 t = tcg_temp_new_i32();
+
+        read_vec_element_i32(s, t, a->rn, 0, a->esz);
+        f->gen_bhs[a->esz](t, tcg_env, t);
+        write_fp_sreg(s, a->rd, t);
+    }
+    return true;
+}
+
+static bool do_env_vector1(DisasContext *s, arg_qrr_e *a, const ENVScalar1 *f)
+{
+    if (a->esz == MO_64 && !a->q) {
+        return false;
+    }
+    if (!fp_access_check(s)) {
+        return true;
+    }
+    if (a->esz == MO_64) {
+        TCGv_i64 t = tcg_temp_new_i64();
+
+        for (int i = 0; i < 2; ++i) {
+            read_vec_element(s, t, a->rn, i, MO_64);
+            f->gen_d(t, tcg_env, t);
+            write_vec_element(s, t, a->rd, i, MO_64);
+        }
+    } else {
+        TCGv_i32 t = tcg_temp_new_i32();
+        int n = (a->q ? 16 : 8) >> a->esz;
+
+        for (int i = 0; i < n; ++i) {
+            read_vec_element_i32(s, t, a->rn, i, a->esz);
+            f->gen_bhs[a->esz](t, tcg_env, t);
+            write_vec_element_i32(s, t, a->rd, i, a->esz);
+        }
+    }
+    clear_vec_high(s, a->q, a->rd);
+    return true;
+}
+
+static const ENVScalar1 f_scalar_sqabs = {
+    { gen_helper_neon_qabs_s8,
+      gen_helper_neon_qabs_s16,
+      gen_helper_neon_qabs_s32 },
+    gen_helper_neon_qabs_s64,
+};
+TRANS(SQABS_s, do_env_scalar1, a, &f_scalar_sqabs)
+TRANS(SQABS_v, do_env_vector1, a, &f_scalar_sqabs)
+
+static const ENVScalar1 f_scalar_sqneg = {
+    { gen_helper_neon_qneg_s8,
+      gen_helper_neon_qneg_s16,
+      gen_helper_neon_qneg_s32 },
+    gen_helper_neon_qneg_s64,
+};
+TRANS(SQNEG_s, do_env_scalar1, a, &f_scalar_sqneg)
+TRANS(SQNEG_v, do_env_vector1, a, &f_scalar_sqneg)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9129,13 +9201,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
          */
         tcg_gen_not_i64(tcg_rd, tcg_rn);
         break;
-    case 0x7: /* SQABS, SQNEG */
-        if (u) {
-            gen_helper_neon_qneg_s64(tcg_rd, tcg_env, tcg_rn);
-        } else {
-            gen_helper_neon_qabs_s64(tcg_rd, tcg_env, tcg_rn);
-        }
-        break;
     case 0xa: /* CMLT */
         cond = TCG_COND_LT;
     do_cmop:
@@ -9198,6 +9263,7 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
         gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
         break;
     default:
+    case 0x7: /* SQABS, SQNEG */
         g_assert_not_reached();
     }
 }
@@ -9540,8 +9606,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x7: /* SQABS / SQNEG */
-        break;
     case 0xa: /* CMLT */
         if (u) {
             unallocated_encoding(s);
@@ -9640,6 +9704,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     default:
     case 0x3: /* USQADD / SUQADD */
+    case 0x7: /* SQABS / SQNEG */
         unallocated_encoding(s);
         return;
     }
@@ -9669,18 +9734,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         read_vec_element_i32(s, tcg_rn, rn, 0, size);
 
         switch (opcode) {
-        case 0x7: /* SQABS, SQNEG */
-        {
-            NeonGenOneOpEnvFn *genfn;
-            static NeonGenOneOpEnvFn * const fns[3][2] = {
-                { gen_helper_neon_qabs_s8, gen_helper_neon_qneg_s8 },
-                { gen_helper_neon_qabs_s16, gen_helper_neon_qneg_s16 },
-                { gen_helper_neon_qabs_s32, gen_helper_neon_qneg_s32 },
-            };
-            genfn = fns[size][u];
-            genfn(tcg_rd, tcg_env, tcg_rn);
-            break;
-        }
         case 0x1a: /* FCVTNS */
         case 0x1b: /* FCVTMS */
         case 0x1c: /* FCVTAS */
@@ -9698,6 +9751,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
                                  tcg_fpstatus);
             break;
         default:
+        case 0x7: /* SQABS, SQNEG */
             g_assert_not_reached();
         }
 
@@ -10055,12 +10109,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             return;
         }
         break;
-    case 0x7: /* SQABS, SQNEG */
-        if (size == 3 && !is_q) {
-            unallocated_encoding(s);
-            return;
-        }
-        break;
     case 0xc ... 0xf:
     case 0x16 ... 0x1f:
     {
@@ -10231,6 +10279,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
     default:
     case 0x3: /* SUQADD, USQADD */
+    case 0x7: /* SQABS, SQNEG */
         unallocated_encoding(s);
         return;
     }
@@ -10321,13 +10370,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         tcg_gen_clrsb_i32(tcg_res, tcg_op);
                     }
                     break;
-                case 0x7: /* SQABS, SQNEG */
-                    if (u) {
-                        gen_helper_neon_qneg_s32(tcg_res, tcg_env, tcg_op);
-                    } else {
-                        gen_helper_neon_qabs_s32(tcg_res, tcg_env, tcg_op);
-                    }
-                    break;
                 case 0x2f: /* FABS */
                     gen_vfp_abss(tcg_res, tcg_op);
                     break;
@@ -10376,6 +10418,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_frint64_s(tcg_res, tcg_op, tcg_fpstatus);
                     break;
                 default:
+                case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
                 }
             } else {
@@ -10391,17 +10434,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                         gen_helper_neon_cnt_u8(tcg_res, tcg_op);
                     }
                     break;
-                case 0x7: /* SQABS, SQNEG */
-                {
-                    NeonGenOneOpEnvFn *genfn;
-                    static NeonGenOneOpEnvFn * const fns[2][2] = {
-                        { gen_helper_neon_qabs_s8, gen_helper_neon_qneg_s8 },
-                        { gen_helper_neon_qabs_s16, gen_helper_neon_qneg_s16 },
-                    };
-                    genfn = fns[size][u];
-                    genfn(tcg_res, tcg_env, tcg_op);
-                    break;
-                }
                 case 0x4: /* CLS, CLZ */
                     if (u) {
                         if (size == 0) {
@@ -10418,6 +10450,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     }
                     break;
                 default:
+                case 0x7: /* SQABS, SQNEG */
                     g_assert_not_reached();
                 }
             }
-- 
2.34.1


