Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F1E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32a-0007w6-2T; Tue, 10 Dec 2024 11:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL320-0007fv-28
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:16 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31y-0007Um-6G
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5401be44b58so2712320e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847852; x=1734452652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYb+n5bf8yfbIFORvUjBb1Jdgr3gp8V9Adl24WCF1Ss=;
 b=RUDL7Rtwv6THCmNjKbO2m2KmXFpL65OrOr91GEtB4OR11h6gaHAnM+Cwv5ItU4kOoz
 65KJ2tsoLTklhRolXsSkh8pcM+Lxc6F8bpu/pOeJul3DyPM7wpdG2iDXOb3CTuK5ggWv
 jPATS5D8nb2h05W8N8GnUm90gLI7J8ruff9234gDb/oZiFf/CC+84gsKj93i5Yu6Ov6z
 6Qlt6FiNfTNkzhNmlw9vSn0Pp18w1aQnqjCHbTmyJ+9Gcx1kRjgRGdtvv4/b2kpa/M5j
 CdILpe5mHfekPxHXXQIMHC0PWevhbd+HFSnfft5cVrYk/TpQ9tYHKdzna22yofvGBTPL
 7zdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847852; x=1734452652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYb+n5bf8yfbIFORvUjBb1Jdgr3gp8V9Adl24WCF1Ss=;
 b=S12OWAmRVzEEaJVzcF/MRHAmeQ76PUyxZ4Xi1OdHoFJxv6bXt5g3Sv0O3bt9bZtDJs
 N7MyfMuwvRMEiqhHCRVce3BBSoCHjDO+DeYJ8R8iGZSrIlQKe6yhg7mE0i2uw4w7Gv9g
 MKeYjlygyCNu8Q4QIyt9zJwr+7iPkBn6lAOOQiNuA2tz1trPgck0jw2tTypnTufeX8PS
 g29bAR0/y1z60lHOrgtHHPDv67EVNpxV/PAI32l2I6+4p0uhjDeXvPX7Wd62oaQTBUtX
 TK0DrcbicQxTC2tpf81ir2ggU86aHhzvSLdMY8iUlPor22/zVK5xmGx7WgFGAL2P969Y
 tazA==
X-Gm-Message-State: AOJu0Ywy2LAumDBpeD12ifHQao9gP0J17jGudGmcmwqjBMdUgJ6GFoKa
 RwPXIZQhtN+6ouXyEiVrpUz0AXvRbe+8ZjCTgUoHL7ookYTSJeptGCs4hOFf1rOw7tHJ8546T7K
 yGzLUnbDE
X-Gm-Gg: ASbGncuDxIKxotYL2pukrZGUjnAoiVAYq9xtx5s81NsBHr/VLoYIH54RJVI4PAVPHgn
 dRQAaJwcPiP6cM1GwacIRsFIemhZBQNL4oe/AZR2ChtKDRgeMjwupU6FKksDEKNzjnWB41a6ydc
 jYiYX6YMhDKoddCfkyyi9CboPE0L33PKY9YaNSqthZaGHRxwrkfKtpsIS3Ezx9INuOPzaIdobaI
 f4wTMio/b0eEAm2DSZf+mucWUxS2MzXO5TXn9ZB238ap/El6KtfVixk5vE=
X-Google-Smtp-Source: AGHT+IHdx36mYMgLluXFTdQDrK2oYzFJJgmFZQkSJv8YdUj8eq5VJICLKWpiJch6Q23sE2fpScm71Q==
X-Received: by 2002:ac2:42cc:0:b0:53e:2e6b:3858 with SMTP id
 2adb3069b0e04-53e2e6b3920mr5992264e87.48.1733847852504; 
 Tue, 10 Dec 2024 08:24:12 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 51/69] target/arm: Convert FCVTXN to decodetree
Date: Tue, 10 Dec 2024 10:17:15 -0600
Message-ID: <20241210161733.1830573-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
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

Remove handle_2misc_narrow as this was the last insn decoded
by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 101 +++++++--------------------------
 target/arm/tcg/a64.decode      |   4 ++
 2 files changed, 24 insertions(+), 81 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f04d03ff6e..7bbfd64eba 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8975,6 +8975,24 @@ static ArithOneOp * const f_scalar_uqxtn[] = {
 };
 TRANS(UQXTN_s, do_2misc_narrow_scalar, a, f_scalar_uqxtn)
 
+static void gen_fcvtxn_sd(TCGv_i64 d, TCGv_i64 n)
+{
+    /*
+     * 64 bit to 32 bit float conversion
+     * with von Neumann rounding (round to odd)
+     */
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    gen_helper_fcvtx_f64_to_f32(tmp, n, tcg_env);
+    tcg_gen_extu_i32_i64(d, tmp);
+}
+
+static ArithOneOp * const f_scalar_fcvtxn[] = {
+    NULL,
+    NULL,
+    gen_fcvtxn_sd,
+};
+TRANS(FCVTXN_s, do_2misc_narrow_scalar, a, f_scalar_fcvtxn)
+
 #undef WRAP_ENV
 
 static bool do_gvec_fn2(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
@@ -9078,6 +9096,7 @@ static ArithOneOp * const f_vector_fcvtn[] = {
     gen_fcvtn_sd,
 };
 TRANS(FCVTN_v, do_2misc_narrow_vector, a, f_vector_fcvtn)
+TRANS(FCVTXN_v, do_2misc_narrow_vector, a, f_scalar_fcvtxn)
 
 static void gen_bfcvtn_hs(TCGv_i64 d, TCGv_i64 n)
 {
@@ -9647,68 +9666,6 @@ static void handle_2misc_reciprocal(DisasContext *s, int opcode,
     }
 }
 
-static void handle_2misc_narrow(DisasContext *s, bool scalar,
-                                int opcode, bool u, bool is_q,
-                                int size, int rn, int rd)
-{
-    /* Handle 2-reg-misc ops which are narrowing (so each 2*size element
-     * in the source becomes a size element in the destination).
-     */
-    int pass;
-    TCGv_i64 tcg_res[2];
-    int destelt = is_q ? 2 : 0;
-    int passes = scalar ? 1 : 2;
-
-    if (scalar) {
-        tcg_res[1] = tcg_constant_i64(0);
-    }
-
-    for (pass = 0; pass < passes; pass++) {
-        TCGv_i64 tcg_op = tcg_temp_new_i64();
-        NeonGenOne64OpFn *genfn = NULL;
-        NeonGenOne64OpEnvFn *genenvfn = NULL;
-
-        if (scalar) {
-            read_vec_element(s, tcg_op, rn, pass, size + 1);
-        } else {
-            read_vec_element(s, tcg_op, rn, pass, MO_64);
-        }
-        tcg_res[pass] = tcg_temp_new_i64();
-
-        switch (opcode) {
-        case 0x56:  /* FCVTXN, FCVTXN2 */
-            {
-                /*
-                 * 64 bit to 32 bit float conversion
-                 * with von Neumann rounding (round to odd)
-                 */
-                TCGv_i32 tmp = tcg_temp_new_i32();
-                assert(size == 2);
-                gen_helper_fcvtx_f64_to_f32(tmp, tcg_op, tcg_env);
-                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
-            }
-            break;
-        default:
-        case 0x12: /* XTN, SQXTUN */
-        case 0x14: /* SQXTN, UQXTN */
-        case 0x16: /* FCVTN, FCVTN2 */
-        case 0x36: /* BFCVTN, BFCVTN2 */
-            g_assert_not_reached();
-        }
-
-        if (genfn) {
-            genfn(tcg_res[pass], tcg_op);
-        } else if (genenvfn) {
-            genenvfn(tcg_res[pass], tcg_env, tcg_op);
-        }
-    }
-
-    for (pass = 0; pass < 2; pass++) {
-        write_vec_element(s, tcg_res[pass], rd, destelt + pass, MO_32);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /* AdvSIMD scalar two reg misc
  *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
  * +-----+---+-----------+------+-----------+--------+-----+------+------+
@@ -9780,15 +9737,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
             rmode = FPROUNDING_TIEAWAY;
             break;
         case 0x56: /* FCVTXN, FCVTXN2 */
-            if (size == 2) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, true, opcode, u, false, size - 1, rn, rd);
-            return;
         default:
             unallocated_encoding(s);
             return;
@@ -10101,16 +10049,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_reciprocal(s, opcode, false, u, is_q, size, rn, rd);
             return;
-        case 0x56: /* FCVTXN, FCVTXN2 */
-            if (size == 2) {
-                unallocated_encoding(s);
-                return;
-            }
-            if (!fp_access_check(s)) {
-                return;
-            }
-            handle_2misc_narrow(s, false, opcode, 0, is_q, size - 1, rn, rd);
-            return;
         case 0x17: /* FCVTL, FCVTL2 */
             if (!fp_access_check(s)) {
                 return;
@@ -10160,6 +10098,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         default:
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
+        case 0x56: /* FCVTXN, FCVTXN2 */
             unallocated_encoding(s);
             return;
         }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 456912cd7c..d8902dfb22 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -74,6 +74,7 @@
 
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
+@qrr_s          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=2
 @qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_hs         . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=%esz_hs
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
@@ -1648,6 +1649,8 @@ SQXTUN_s        0111 1110 ..1 00001 00101 0 ..... .....     @rr_e
 SQXTN_s         0101 1110 ..1 00001 01001 0 ..... .....     @rr_e
 UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
 
+FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
@@ -1680,4 +1683,5 @@ SQXTN_v         0.00 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 UQXTN_v         0.10 1110 ..1 00001 01001 0 ..... .....     @qrr_e
 
 FCVTN_v         0.00 1110 0.1 00001 01101 0 ..... .....     @qrr_hs
+FCVTXN_v        0.10 1110 011 00001 01101 0 ..... .....     @qrr_s
 BFCVTN_v        0.00 1110 101 00001 01101 0 ..... .....     @qrr_h
-- 
2.43.0


