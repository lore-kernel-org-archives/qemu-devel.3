Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A27D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlcC-00066W-HG; Sun, 01 Dec 2024 10:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaO-00083K-4A
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:14 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaI-0005Aa-Pu
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:10 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5f22ea6d645so800460eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065804; x=1733670604; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHIzYC7C0cm8CfZYGsJSw2lj65FECi8hrgKhTL/UKaM=;
 b=ocDaL+kogXIGkAPQ1TdBbBzoLA8UBQF8rSciNWe0g82vLHY81MHZMx2bpK5/Xvt4P8
 yry7/Gg3GjSgSh6RURUXKFDsqGdrwJRUnh6FgTY2fGBnqeZPOkyoUMbkSqrpm86/49uK
 6eMRGa0oJNszHKe8NS3dD/51qc32uq+sJ3nrNBHfFHf51i0SkKPvJlpDHQ0mDpB7nDrs
 ufPIYPvc5eWhSfwoLcWP6RnnQlp101hNSZ8AiwN/kLr1u76oi8M5aDea4pCvaM7wKW7/
 8uRr2t1T0Cn83PJhjt5YzctAv8ukpPANi3V4gOXuRyXkMpy7/JiL/baRy+T/LAVVC2uZ
 ePIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065804; x=1733670604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHIzYC7C0cm8CfZYGsJSw2lj65FECi8hrgKhTL/UKaM=;
 b=TBJUhKwz2CWkTYUoV/C4mZ+bpJRTR0vxaIhThksmkVZkK5IINZTzgOD6mDAxycFz5u
 /n3gkaxS6S+je+z0ogxoOYKq+Y0jeG/khIN/0LHBdQzJ2tUjzXJZcGl+np7NYvAh3L4r
 5Nkt5Mnywx4G7z/U/XiQRSasBQcaZve9CpavDdsI62AwHePbhCqByiHvRoYrToCVVEQx
 zExT/0YF0bdhIJbZItedeLAFZBfnfidYdUibUcVq+p1iway10N0kov9I3jqvTXhKj1Kr
 kcapK4K587Ta4tKHIVjl/UEdHyM+uquRimuhchERk4zTPvVVHUp9okOLxDC2KSe849oj
 n3Ag==
X-Gm-Message-State: AOJu0YzeyAgeI7KQNhplk/IPDIJk/qqtJcjpnQnIYEFBPORAjCwLrP0J
 MltGzV/KDzLXyUI9PKTQh5/7mm6vX/32dK0jK64BTvb+TMYTbq9nNQ5OD/kFpK0PMO0XZB52Cl2
 9ZjQ=
X-Gm-Gg: ASbGnctTNNXOE8qmSCLnjutLwI97fHBrHIKozzN4YP/xTHcdowjfVgNmDaORxahulZM
 i8A8Vb3hzZyWdEdgnEyPagEMPeF/juq+7DwnZi022sIamNjHxM+Lin9e8Gzmevtv+31OnXIZ/nF
 xpe9ej5Aws2sbnCz3poi83K1IrXg5ZjiRzW2x2yCAkieU2/MO9fv7ZXzxHk7pe8y185voT9K/dt
 DxGTrYDBF5zAuNIKlwjfWqYO7X/2M8JknfkeGRBAzoGnqHffmzoxoLzZXjFNi8FZhxuMiptcgbL
 57666+pIOHWrZitLi8o815juZx2+vvab1LWi
X-Google-Smtp-Source: AGHT+IHzDglMWWRhkLb1EF7JFLl/XIVLekW12XPYagwzju+SmZkqwZ9MsNhtF/32tqcu1BcPGenISQ==
X-Received: by 2002:a05:6830:4905:b0:71d:3fe2:2053 with SMTP id
 46e09a7af769-71d65cf6138mr14271417a34.21.1733065804496; 
 Sun, 01 Dec 2024 07:10:04 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 49/67] target/arm: Convert FCVTN, BFCVTN to decodetree
Date: Sun,  1 Dec 2024 09:05:48 -0600
Message-ID: <20241201150607.12812-50-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 89 ++++++++++++++++++----------------
 target/arm/tcg/a64.decode      |  5 ++
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6c44e9d8a1..8b76c307af 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9055,6 +9055,49 @@ TRANS(SQXTUN_v, do_2misc_narrow_vector, a, f_scalar_sqxtun)
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
@@ -9637,33 +9680,6 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
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
@@ -9679,6 +9695,8 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         default:
         case 0x12: /* XTN, SQXTUN */
         case 0x14: /* SQXTN, UQXTN */
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             g_assert_not_reached();
         }
 
@@ -10092,21 +10110,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
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
@@ -10159,6 +10162,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             break;
         default:
+        case 0x16: /* FCVTN, FCVTN2 */
+        case 0x36: /* BFCVTN, BFCVTN2 */
             unallocated_encoding(s);
             return;
         }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 9a01037446..1412b99241 100644
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


