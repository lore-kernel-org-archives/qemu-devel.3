Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E22BE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Yr-0005eQ-TF; Fri, 13 Dec 2024 12:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xj-0007nw-Iy
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:35 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xh-0001gJ-Jm
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:35 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so14348455e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111212; x=1734716012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pn78mn1Agyf2nTOFl8VtgeWSdcy/50LqPHioFwhttS0=;
 b=G3fqECKekdFM0jOG2biKDoqcM+MKdk1WizcHeQxqqU5SSXYH+t1KGPeO7BPDzrUlKM
 i8Gges+FqoKTGmjAcPNQwSDhSKgfoVKJm9IcBeji228eIp0IiB83EM949JHgB23KHdGi
 U44YUtqsu8iw+m0HMcSVpfOoaRPnESFS6E4G3bZc3ffP5nsXxWXUPXc0YvciC9wc2laN
 xVbSlaXTeRuRfyTF7L9GExx9UcjO0Gv67r//BTdRbhTD3UBoRmL77HEcwVOXCGe5Yq8d
 uUHoZCd3iqAh0HAH1r/5qYtgtPWUorzrbSccwMrQdC5q0AOIU4yrUkQibYBb0Ot0s7tq
 gz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111212; x=1734716012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pn78mn1Agyf2nTOFl8VtgeWSdcy/50LqPHioFwhttS0=;
 b=gDXvxp5TrGFjlY8D92QR9KCYyaW+bmVxS8CSP0TbtAzMROmrrCNXBvYejkgPn1DtPj
 yI0Nso6w9+kK2s5Z0Y6Kh5+yLuf0Rd5fJ53jz4C+TxfjiTq5RIEIXuKWx7NSJwQy/Ioo
 eUCwoeE4tkwR6hKpUuC0UyK3Db7mOBG0+rM/NyVAiydEBCb9L62P3pDbIXL4vUZDfEK0
 vueyEeznrLIdbwXqXyN84sLRd0WNaFd34LpxeuWRLdRct5oW6vQY5xfNX9CH94od7E7s
 2AJtwuOY/TKp4reBdZY3rTXGFwGw6hWZHEn6VmySYPUb6eLi/2Zaug6fqFzfVLLRTRjh
 NSmw==
X-Gm-Message-State: AOJu0YymxuJlN8IDQg673PsXzdVU3If8zqNh7BNcQSrwSkTUDX/8T4Ri
 tKNUrjKiBs8Y4tmVfFnHJNbaXMLbnWVTqKbHpldrr3khQJ2bPgsmEgwPiogj3ujnL9zsSL4q2pM
 a
X-Gm-Gg: ASbGnctJ5aCLk15qmNdrhzEcNH7TEOffwCr/15l19sVfFWUi2riy4cG0h3vJGTCOGP1
 t1AN+a6PLRZ2gUizMfzpCMqumG4gjDOSJ/4CECB+BopDW9hJLqiQkAnSO6gUQljcvku+X9OqCy2
 4sRNLCoroeGUqSv/G+YM8WAewkpkkwZf4nAyMisQ7JVRUMACjK9JwKUg0BWuxK6TB9UNpxDpiEh
 XAB4PpaVB5/5Nq1jeJzE1D8XNR07rHc980/0GoPgOkQ22HqncOsjplP5O7hmg==
X-Google-Smtp-Source: AGHT+IEDcoGofkxQaE8jG3NRuf3wY42CZnrCFlpQLd7Cxz+gSFq4pRVwjw/FMqiQQIiR1mTTzrZWyQ==
X-Received: by 2002:a05:600c:378f:b0:436:1b7a:c0b4 with SMTP id
 5b1f17b1804b1-4362aa1475cmr27008095e9.1.1734111212157; 
 Fri, 13 Dec 2024 09:33:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/85] target/arm: Convert FCVT* (vector,
 integer) scalar to decodetree
Date: Fri, 13 Dec 2024 17:32:01 +0000
Message-Id: <20241213173229.3308926-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Arm silliness with naming, the scalar insns described
as part of the vector instructions, as separate from
the "regular" scalar insns which output to general registers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-58-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  30 ++++++++
 target/arm/tcg/translate-a64.c | 133 ++++++++++++++-------------------
 2 files changed, 86 insertions(+), 77 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5e02144f651..f7fcc32adc5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1652,6 +1652,36 @@ UQXTN_s         0111 1110 ..1 00001 01001 0 ..... .....     @rr_e
 
 FCVTXN_s        0111 1110 011 00001 01101 0 ..... .....     @rr_s
 
+@icvt_h         . ....... .. ...... ...... rn:5 rd:5 \
+                &fcvt sf=0 esz=1 shift=0
+@icvt_sd        . ....... .. ...... ...... rn:5 rd:5 \
+                &fcvt sf=0 esz=%esz_sd shift=0
+
+FCVTNS_f        0101 1110 011 11001 10101 0 ..... .....     @icvt_h
+FCVTNS_f        0101 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
+FCVTNU_f        0111 1110 011 11001 10101 0 ..... .....     @icvt_h
+FCVTNU_f        0111 1110 0.1 00001 10101 0 ..... .....     @icvt_sd
+
+FCVTPS_f        0101 1110 111 11001 10101 0 ..... .....     @icvt_h
+FCVTPS_f        0101 1110 1.1 00001 10101 0 ..... .....     @icvt_sd
+FCVTPU_f        0111 1110 111 11001 10101 0 ..... .....     @icvt_h
+FCVTPU_f        0111 1110 1.1 00001 10101 0 ..... .....     @icvt_sd
+
+FCVTMS_f        0101 1110 011 11001 10111 0 ..... .....     @icvt_h
+FCVTMS_f        0101 1110 0.1 00001 10111 0 ..... .....     @icvt_sd
+FCVTMU_f        0111 1110 011 11001 10111 0 ..... .....     @icvt_h
+FCVTMU_f        0111 1110 0.1 00001 10111 0 ..... .....     @icvt_sd
+
+FCVTZS_f        0101 1110 111 11001 10111 0 ..... .....     @icvt_h
+FCVTZS_f        0101 1110 1.1 00001 10111 0 ..... .....     @icvt_sd
+FCVTZU_f        0111 1110 111 11001 10111 0 ..... .....     @icvt_h
+FCVTZU_f        0111 1110 1.1 00001 10111 0 ..... .....     @icvt_sd
+
+FCVTAS_f        0101 1110 011 11001 11001 0 ..... .....     @icvt_h
+FCVTAS_f        0101 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
+FCVTAU_f        0111 1110 011 11001 11001 0 ..... .....     @icvt_h
+FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0f924b07dcd..71f1d6f7786 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8674,6 +8674,16 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
                                  tcg_shift, tcg_fpstatus);
             tcg_gen_extu_i32_i64(tcg_out, tcg_single);
             break;
+        case MO_16 | MO_SIGN:
+            gen_helper_vfp_toshh(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
+        case MO_16:
+            gen_helper_vfp_touhh(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
         default:
             g_assert_not_reached();
         }
@@ -8717,6 +8727,42 @@ TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
 TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
 TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
 
+/*
+ * FCVT* (vector), scalar version.
+ * Which sounds weird, but really just means output to fp register
+ * instead of output to general register.  Input and output element
+ * size are always equal.
+ */
+static bool do_fcvt_f(DisasContext *s, arg_fcvt *a,
+                      ARMFPRounding rmode, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = tcg_temp_new_i64();
+    do_fcvt_scalar(s, a->esz | (is_signed ? MO_SIGN : 0),
+                   a->esz, tcg_int, a->shift, a->rn, rmode);
+
+    clear_vec(s, a->rd);
+    write_vec_element(s, tcg_int, a->rd, 0, a->esz);
+    return true;
+}
+
+TRANS(FCVTNS_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, true)
+TRANS(FCVTNU_f, do_fcvt_f, a, FPROUNDING_TIEEVEN, false)
+TRANS(FCVTPS_f, do_fcvt_f, a, FPROUNDING_POSINF, true)
+TRANS(FCVTPU_f, do_fcvt_f, a, FPROUNDING_POSINF, false)
+TRANS(FCVTMS_f, do_fcvt_f, a, FPROUNDING_NEGINF, true)
+TRANS(FCVTMU_f, do_fcvt_f, a, FPROUNDING_NEGINF, false)
+TRANS(FCVTZS_f, do_fcvt_f, a, FPROUNDING_ZERO, true)
+TRANS(FCVTZU_f, do_fcvt_f, a, FPROUNDING_ZERO, false)
+TRANS(FCVTAS_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, true)
+TRANS(FCVTAU_f, do_fcvt_f, a, FPROUNDING_TIEAWAY, false)
+
 static bool trans_FJCVTZS(DisasContext *s, arg_FJCVTZS *a)
 {
     if (!dc_isar_feature(aa64_jscvt, s)) {
@@ -9776,10 +9822,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     int size = extract32(insn, 22, 2);
     bool u = extract32(insn, 29, 1);
-    bool is_fcvt = false;
-    int rmode;
-    TCGv_i32 tcg_rmode;
-    TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
     case 0xc ... 0xf:
@@ -9824,15 +9866,8 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x5b: /* FCVTMU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
-            is_fcvt = true;
-            rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            break;
         case 0x1c: /* FCVTAS */
         case 0x5c: /* FCVTAU */
-            /* TIEAWAY doesn't fit in the usual rounding mode encoding */
-            is_fcvt = true;
-            rmode = FPROUNDING_TIEAWAY;
-            break;
         case 0x56: /* FCVTXN, FCVTXN2 */
         default:
             unallocated_encoding(s);
@@ -9851,59 +9886,7 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
         unallocated_encoding(s);
         return;
     }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (is_fcvt) {
-        tcg_fpstatus = fpstatus_ptr(FPST_FPCR);
-        tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
-    } else {
-        tcg_fpstatus = NULL;
-        tcg_rmode = NULL;
-    }
-
-    if (size == 3) {
-        TCGv_i64 tcg_rn = read_fp_dreg(s, rn);
-        TCGv_i64 tcg_rd = tcg_temp_new_i64();
-
-        handle_2misc_64(s, opcode, u, tcg_rd, tcg_rn, tcg_rmode, tcg_fpstatus);
-        write_fp_dreg(s, rd, tcg_rd);
-    } else {
-        TCGv_i32 tcg_rn = tcg_temp_new_i32();
-        TCGv_i32 tcg_rd = tcg_temp_new_i32();
-
-        read_vec_element_i32(s, tcg_rn, rn, 0, size);
-
-        switch (opcode) {
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x1c: /* FCVTAS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-            gen_helper_vfp_tosls(tcg_rd, tcg_rn, tcg_constant_i32(0),
-                                 tcg_fpstatus);
-            break;
-        case 0x5a: /* FCVTNU */
-        case 0x5b: /* FCVTMU */
-        case 0x5c: /* FCVTAU */
-        case 0x7a: /* FCVTPU */
-        case 0x7b: /* FCVTZU */
-            gen_helper_vfp_touls(tcg_rd, tcg_rn, tcg_constant_i32(0),
-                                 tcg_fpstatus);
-            break;
-        default:
-        case 0x7: /* SQABS, SQNEG */
-            g_assert_not_reached();
-        }
-
-        write_fp_sreg(s, rd, tcg_rd);
-    }
-
-    if (is_fcvt) {
-        gen_restore_rmode(tcg_rmode, tcg_fpstatus);
-    }
+    g_assert_not_reached();
 }
 
 /* AdvSIMD shift by immediate
@@ -10391,30 +10374,26 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         TCGv_i32 tcg_res = tcg_temp_new_i32();
 
         switch (fpop) {
-        case 0x1a: /* FCVTNS */
-        case 0x1b: /* FCVTMS */
-        case 0x1c: /* FCVTAS */
-        case 0x3a: /* FCVTPS */
-        case 0x3b: /* FCVTZS */
-            gen_helper_advsimd_f16tosinth(tcg_res, tcg_op, tcg_fpstatus);
-            break;
         case 0x3d: /* FRECPE */
             gen_helper_recpe_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
         case 0x3f: /* FRECPX */
             gen_helper_frecpx_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
+        case 0x7d: /* FRSQRTE */
+            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
+            break;
+        default:
+        case 0x1a: /* FCVTNS */
+        case 0x1b: /* FCVTMS */
+        case 0x1c: /* FCVTAS */
+        case 0x3a: /* FCVTPS */
+        case 0x3b: /* FCVTZS */
         case 0x5a: /* FCVTNU */
         case 0x5b: /* FCVTMU */
         case 0x5c: /* FCVTAU */
         case 0x7a: /* FCVTPU */
         case 0x7b: /* FCVTZU */
-            gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        case 0x7d: /* FRSQRTE */
-            gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
-            break;
-        default:
             g_assert_not_reached();
         }
 
-- 
2.34.1


