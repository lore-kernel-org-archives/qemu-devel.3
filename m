Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253AFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32b-00087j-S9; Tue, 10 Dec 2024 11:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31x-0007Xi-7o
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:14 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31v-0007UL-F6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:12 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-540215984f0so2050382e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847850; x=1734452650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qH4CPUTXR8BSz86LZEoH93nMlJ9bGid/Em49QpR++nw=;
 b=DP2cVLeCn/ic9OUu9KTrmPtLJ8qQHJoAgdFcaSNlGW+TJ5G9iSMdSKSqDkUoThlGaa
 7hEaSkdxFKMK1VkGt2FDT1+v+kWZ+b0zIbMYzJuUjgawhz1uw/+q5GVT6qSiTSkCMqEQ
 XLwlT7CcXu7IzQCHOuN8Kl0qTx+F8O6cPcUan3pfQ6R5Wivq98qBuL4FOC5nMFdis1xn
 m9vCSl/W53PdaJD+UsExjgxKXMDEpYznYuzRo7W1cGNF0B9TTTAPrQBn5YtTQVd5v8OV
 TE7JsCldgkmkjXB989oHdvfAXUm5/lJfj7ND1cv4gb3OrSoQ1G327npiixLJOP+kvJsu
 drDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847850; x=1734452650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qH4CPUTXR8BSz86LZEoH93nMlJ9bGid/Em49QpR++nw=;
 b=cQXo/BRoWEuX/XHmr1MyY43zhO31+jkcb4R0K0DawRgX3XR232WxGXSHKtcJaXXgqf
 31tbytg5O/0IX/SHfU3c7jSrckg7Xr9/PPrlk+yMi+XaLh6qabAIXdWlZxFcSW4RsYHG
 cEdi/kRxt6bX31FC6yQWWAk1ENnxtoIH5aDQn6Lqs6p2DjIs6y9nIm10YgpND7TVff2C
 zp7KqXs7lhulyuGd8OXcl7VS9FifuPYLcAAZoBONgyX3WZ8dFSCIb69funVAjuy1YYSX
 zaUsMiwtVCTsPiGmPcBJa4WzyBBUNkrLDRwWhCnES4QlU5sAOsCRCJ2UVJYC6RYRyNAa
 Qvyg==
X-Gm-Message-State: AOJu0Yw4mtWWJxjahxckqexGpgIcGP2RtqbCidq9hKX7BnpvW68YdkLZ
 khEZ9hsOna5AxCc7WyNwaFdjhJkdIhlsafgzQKxl/7O8v8iJW84utQqcBYF2lD/BLR1XieeUeJ9
 Pu4IAbPLL
X-Gm-Gg: ASbGncsqLA5Pl0/AkvN7GhxvLfaBobthVL92z/iBVjgHqRvHX6SdXApuBfkTlFkvpmn
 TVd5l/h0kS2k/LqYEPQ7AzXUZ1VcOLSIM200P6BEUaCeX21o+8kT9j2AJkYFkSf4S8blLyFTwIg
 4itjs8vmj/jLU+w8UbhEMRIBXH/zg3/na5OfmF1M9evv8q5PHGJuqvqwqfHoDkdKZXA/63CsCNk
 /Y7no6Sxyy3sxtw9R1zmOUDxRkOqOu0T0d+rNaP+Mk/7Pes+q0Kzqfx3eA=
X-Google-Smtp-Source: AGHT+IGwnhFWnZ1GDaNiDinrrC67w6gnGfGoqWwOud9BX+hm2A29jPOi1osW1iUXq9DRmmSqFbSakw==
X-Received: by 2002:a05:6512:ea0:b0:540:2092:934 with SMTP id
 2adb3069b0e04-540240cd264mr1538453e87.25.1733847849638; 
 Tue, 10 Dec 2024 08:24:09 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:08 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 50/69] target/arm: Convert FCVTN, BFCVTN to decodetree
Date: Tue, 10 Dec 2024 10:17:14 -0600
Message-ID: <20241210161733.1830573-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
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
 target/arm/tcg/translate-a64.c | 89 ++++++++++++++++++----------------
 target/arm/tcg/a64.decode      |  5 ++
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f9d203f7e6..f04d03ff6e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9051,6 +9051,49 @@ TRANS(SQXTUN_v, do_2misc_narrow_vector, a, f_scalar_sqxtun)
 TRANS(SQXTN_v, do_2misc_narrow_vector, a, f_scalar_sqxtn)
 TRANS(UQXTN_v, do_2misc_narrow_vector, a, f_scalar_uqxtn)
 
+static void gen_fcvtn_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i32 tcg_lo = tcg_temp_new_i32();
+    TCGv_i32 tcg_hi = tcg_temp_new_i32();
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_i32 ahp = get_ahp_flag();
+
+    tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, n);
+    gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
+    gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
+    tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
+    tcg_gen_extu_i32_i64(d, tcg_lo);
+}
+
+static void gen_fcvtn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_vfp_fcvtsd(tmp, n, tcg_env);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_fcvtn[] = {
+    NULL,
+    gen_fcvtn_hs,
+    gen_fcvtn_sd,
+};
+TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
+
+static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
+{
+    TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_bfcvt_pair(tmp, n, fpst);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_vector_bfcvtn[] = {
+    NULL,
+    gen_bfcvtn_hs,
+    NULL,
+};
+TRANS_FEAT(BFCVTN_v, aa64_bf16, do_2misc_narrow_vector, a, f_vector_bfcvtn)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9633,33 +9676,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
-        case 0x16: /* FCVTN, FCVTN2 */
-            /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
-            if (size == 2) {
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                gen_helper_vfp_fcvtsd(tmp, tcg_op, tcg_env);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            } else {
-                TCGv_i32 tcg_lo = tcg_temp_new_i32();
-                TCGv_i32 tcg_hi = tcg_temp_new_i32();
-                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                TCGv_i32 ahp = get_ahp_flag();
-
-                tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
-                gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
-                tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tcg_lo);
-            }
-            break;
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            {
-                TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                gen_helper_bfcvt_pair(tmp, tcg_op, fpst);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            }
-            break;
         case 0x56:  /* FCVTXN, FCVTXN2 */
             {
                 /*
@@ -9675,6 +9691,8 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         default:
         case 0x12: /* XTN, SQXTUN */
         case 0x14: /* SQXTN, UQXTN */
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             g_assert_not_reached();
         }
 
@@ -10088,21 +10106,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                 unallocated_encoding(s);
                 return;
             }
-            /* fall through */
-        case 0x16: /* FCVTN, FCVTN2 */
-            /* handle_2misc_narrow does a 2*size -> size operation, but these
-             * instructions encode the source size rather than dest size.
-             */
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
-            return;
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            if (!dc_isar_feature(aa64_bf16, s) || size != 2) {
-                unallocated_encoding(s);
-                return;
-            }
             if (!fp_access_check(s)) {
                 return;
             }
@@ -10155,6 +10158,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             break;
         default:
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             unallocated_encoding(s);
             return;
         }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 295329448f..456912cd7c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -21,6 +21,7 @@
 
 %rd             0:5
 %esz_sd         22:1 !function=plus_2
+%esz_hs         22:1 !function=plus_1
 %esz_hsd        22:2 !function=xor_2
 %hl             11:1 21:1
 %hlm            11:1 20:2
@@ -74,6 +75,7 @@
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
+@qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1676,3 +1678,6 @@ XTN             0.00 1110 ..1 00001 00101 0 ..... .....     @qrr_e
 SQXTUN_v        0.10 1110 ..1 00001 00101 0 ..... .....     @qrr_e
 SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
+
+FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
+BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
-- 
2.43.0


