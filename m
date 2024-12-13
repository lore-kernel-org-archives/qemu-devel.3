Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3023FE77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Y9-00009o-6K; Fri, 13 Dec 2024 12:34:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XM-0007BT-5N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:14 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XI-0001ZP-Q4
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:11 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so11938015e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111185; x=1734715985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iMzXhFrSqeJeJ1IC5x6epH+AF8QtsnesEkYCY/pLSp8=;
 b=ZY1d2/sQKs2OIXrODHw54F74cmbUTllr3RjftxDJHjcSgr6ALpc2O/J3I3NS8OdScu
 dhZ3c/9Rf0AHoOat2Harp2JGx1iKySrcseVSqTi0xkqwXb+qiS2tYb87qx4nSlxmX+2Z
 /TplqI5sRMFp3XbHTioOjhg7rKmoKCA6YX8sDHkLatkRqewSIomwe6imswWKett1b1VA
 jl/RJJoxn3xbkiZNhfaRlkM61IMzK3yKM6QNcV/VQiMy2z4JNrXiWNIEnx1lnQLdR6Lx
 pvOiFmjW4xKdiuYoTrIJIwwAjSrBsEp0KoWEI2p5Ihzqg0ck5norOiUKDzEpVLuQm9V6
 d6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111185; x=1734715985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMzXhFrSqeJeJ1IC5x6epH+AF8QtsnesEkYCY/pLSp8=;
 b=tlEkpEAAr67AvJWKOWIhVFPrinvQbQgtvQwC17TL99T+DXbou7pTwWmBEa9o/fCqS2
 QBDGTmRyN0N9feLwRCDjxAFjv7ljHtgmrhDMAk6BnuTZHTQWNk0qfdJZh2/qvQmujs2V
 3mY4FyIxIHtZZU1Jx79jKSvlyJuB3pkNabpXoQFVMtCLWcDsSdvVTubb82+Hf2aiUYg2
 T7m573e2JrMjxe17HTEPwIx+yAwOgPbjmXC7z+mr8xXjc3tB55x4b4lA1b696OaI014l
 WMsyWyVOQlMxwR+EAYbbTC1aD1cKY2/FM2Mfm6aRNa2oTtbyX9LxE8OKhhj4rxx6YU96
 /uZA==
X-Gm-Message-State: AOJu0YyM/8YkDTYmrWRzds4brBE8sX3LRDwfhLYY+PI6ohZcBZkKQnOo
 25vvNTF8hbIhhGNN2+lJcRi4cqBKuK+A4TD9iQaRV0IMcHUX4ZoFA2PIUWHDDHdkYewizWfeI9+
 h
X-Gm-Gg: ASbGnctJrjQpCt43DaLRrEMGgxNv2FwYDn/YBqFVaGm3R9Pmpm9yWuRTR3ZZ6va4agU
 WXdU07zsPX3gsq5kvTzaVFDMB2YQt8ALdDLv71gmdPqzzmbDgQTAIkqgMCb8eGKa7wRlKuGRJDL
 3oqGn+UHDopg2FhubyT0LIQv8H94xbGrC4UKTBAR6MtzPdEazjdw2ewsOA3CjErBuyuICN7U9bZ
 z3+1RSlVEDaxs+o0yTT+QNgh45R6AjacoMkD/nMn6l8SgvDQChlkaUoJIMgDQ==
X-Google-Smtp-Source: AGHT+IHUVn0zMWhOFdu+mcDHZJ7mxw3f3z+PH8oEWTwsPDpk9iSP7sLESra139rx5H/AvxI9tes6ww==
X-Received: by 2002:a05:600c:4e4e:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-4362aaa4969mr32525055e9.21.1734111185229; 
 Fri, 13 Dec 2024 09:33:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/85] target/arm: Convert handle_fpfpcvt to decodetree
Date: Fri, 13 Dec 2024 17:31:36 +0000
Message-Id: <20241213173229.3308926-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

This includes SCVTF, UCVTF, FCVT{N,P,M,Z,A}{S,U}.
Remove disas_fp_fixed_conv as those were the last insns
decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-33-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  40 ++++
 target/arm/tcg/translate-a64.c | 391 ++++++++++++++-------------------
 2 files changed, 209 insertions(+), 222 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 211346c4d90..5e170cec7a8 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1323,6 +1323,46 @@ FMAXV_s         0110 1110 00 11000 01111 10 ..... .....     @rr_q1e2
 FMINV_h         0.00 1110 10 11000 01111 10 ..... .....     @qrr_h
 FMINV_s         0110 1110 10 11000 01111 10 ..... .....     @rr_q1e2
 
+# Conversion between floating-point and fixed-point (general register)
+
+&fcvt           rd rn esz sf shift
+%fcvt_shift32   10:5 !function=rsub_32
+%fcvt_shift64   10:6 !function=rsub_64
+
+@fcvt32         0 ....... .. ...... 1..... rn:5 rd:5    \
+                &fcvt sf=0 esz=%esz_hsd shift=%fcvt_shift32
+@fcvt64         1 ....... .. ...... ...... rn:5 rd:5    \
+                &fcvt sf=1 esz=%esz_hsd shift=%fcvt_shift64
+
+SCVTF_g         . 0011110 .. 000010 ...... ..... .....  @fcvt32
+SCVTF_g         . 0011110 .. 000010 ...... ..... .....  @fcvt64
+UCVTF_g         . 0011110 .. 000011 ...... ..... .....  @fcvt32
+UCVTF_g         . 0011110 .. 000011 ...... ..... .....  @fcvt64
+
+FCVTZS_g        . 0011110 .. 011000 ...... ..... .....  @fcvt32
+FCVTZS_g        . 0011110 .. 011000 ...... ..... .....  @fcvt64
+FCVTZU_g        . 0011110 .. 011001 ...... ..... .....  @fcvt32
+FCVTZU_g        . 0011110 .. 011001 ...... ..... .....  @fcvt64
+
+# Conversion between floating-point and integer (general register)
+
+@icvt           sf:1 ....... .. ...... ...... rn:5 rd:5 \
+                &fcvt esz=%esz_hsd shift=0
+
+SCVTF_g         . 0011110 .. 100010 000000 ..... .....  @icvt
+UCVTF_g         . 0011110 .. 100011 000000 ..... .....  @icvt
+
+FCVTNS_g        . 0011110 .. 100000 000000 ..... .....  @icvt
+FCVTNU_g        . 0011110 .. 100001 000000 ..... .....  @icvt
+FCVTPS_g        . 0011110 .. 101000 000000 ..... .....  @icvt
+FCVTPU_g        . 0011110 .. 101001 000000 ..... .....  @icvt
+FCVTMS_g        . 0011110 .. 110000 000000 ..... .....  @icvt
+FCVTMU_g        . 0011110 .. 110001 000000 ..... .....  @icvt
+FCVTZS_g        . 0011110 .. 111000 000000 ..... .....  @icvt
+FCVTZU_g        . 0011110 .. 111001 000000 ..... .....  @icvt
+FCVTAS_g        . 0011110 .. 100100 000000 ..... .....  @icvt
+FCVTAU_g        . 0011110 .. 100101 000000 ..... .....  @icvt
+
 # Floating-point data processing (1 source)
 
 FMOV_s          00011110 .. 1 000000 10000 ..... .....      @rr_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b31a6d4dff3..67227e26767 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8524,227 +8524,196 @@ static bool trans_FCVT_s_dh(DisasContext *s, arg_rr *a)
     return true;
 }
 
-/* Handle floating point <=> fixed point conversions. Note that we can
- * also deal with fp <=> integer conversions as a special case (scale == 64)
- * OPTME: consider handling that special case specially or at least skipping
- * the call to scalbn in the helpers for zero shifts.
- */
-static void handle_fpfpcvt(DisasContext *s, int rd, int rn, int opcode,
-                           bool itof, int rmode, int scale, int sf, int type)
+static bool do_cvtf_scalar(DisasContext *s, MemOp esz, int rd, int shift,
+                           TCGv_i64 tcg_int, bool is_signed)
 {
-    bool is_signed = !(opcode & 1);
     TCGv_ptr tcg_fpstatus;
     TCGv_i32 tcg_shift, tcg_single;
     TCGv_i64 tcg_double;
 
-    tcg_fpstatus = fpstatus_ptr(type == 3 ? FPST_FPCR_F16 : FPST_FPCR);
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    tcg_shift = tcg_constant_i32(shift);
 
-    tcg_shift = tcg_constant_i32(64 - scale);
-
-    if (itof) {
-        TCGv_i64 tcg_int = cpu_reg(s, rn);
-        if (!sf) {
-            TCGv_i64 tcg_extend = tcg_temp_new_i64();
-
-            if (is_signed) {
-                tcg_gen_ext32s_i64(tcg_extend, tcg_int);
-            } else {
-                tcg_gen_ext32u_i64(tcg_extend, tcg_int);
-            }
-
-            tcg_int = tcg_extend;
+    switch (esz) {
+    case MO_64:
+        tcg_double = tcg_temp_new_i64();
+        if (is_signed) {
+            gen_helper_vfp_sqtod(tcg_double, tcg_int, tcg_shift, tcg_fpstatus);
+        } else {
+            gen_helper_vfp_uqtod(tcg_double, tcg_int, tcg_shift, tcg_fpstatus);
         }
+        write_fp_dreg(s, rd, tcg_double);
+        break;
 
-        switch (type) {
-        case 1: /* float64 */
-            tcg_double = tcg_temp_new_i64();
-            if (is_signed) {
-                gen_helper_vfp_sqtod(tcg_double, tcg_int,
-                                     tcg_shift, tcg_fpstatus);
-            } else {
-                gen_helper_vfp_uqtod(tcg_double, tcg_int,
-                                     tcg_shift, tcg_fpstatus);
-            }
-            write_fp_dreg(s, rd, tcg_double);
-            break;
-
-        case 0: /* float32 */
-            tcg_single = tcg_temp_new_i32();
-            if (is_signed) {
-                gen_helper_vfp_sqtos(tcg_single, tcg_int,
-                                     tcg_shift, tcg_fpstatus);
-            } else {
-                gen_helper_vfp_uqtos(tcg_single, tcg_int,
-                                     tcg_shift, tcg_fpstatus);
-            }
-            write_fp_sreg(s, rd, tcg_single);
-            break;
-
-        case 3: /* float16 */
-            tcg_single = tcg_temp_new_i32();
-            if (is_signed) {
-                gen_helper_vfp_sqtoh(tcg_single, tcg_int,
-                                     tcg_shift, tcg_fpstatus);
-            } else {
-                gen_helper_vfp_uqtoh(tcg_single, tcg_int,
-                                     tcg_shift, tcg_fpstatus);
-            }
-            write_fp_sreg(s, rd, tcg_single);
-            break;
-
-        default:
-            g_assert_not_reached();
+    case MO_32:
+        tcg_single = tcg_temp_new_i32();
+        if (is_signed) {
+            gen_helper_vfp_sqtos(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
+        } else {
+            gen_helper_vfp_uqtos(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
-    } else {
-        TCGv_i64 tcg_int = cpu_reg(s, rd);
-        TCGv_i32 tcg_rmode;
+        write_fp_sreg(s, rd, tcg_single);
+        break;
 
-        if (extract32(opcode, 2, 1)) {
-            /* There are too many rounding modes to all fit into rmode,
-             * so FCVTA[US] is a special case.
-             */
-            rmode = FPROUNDING_TIEAWAY;
+    case MO_16:
+        tcg_single = tcg_temp_new_i32();
+        if (is_signed) {
+            gen_helper_vfp_sqtoh(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
+        } else {
+            gen_helper_vfp_uqtoh(tcg_single, tcg_int, tcg_shift, tcg_fpstatus);
         }
+        write_fp_sreg(s, rd, tcg_single);
+        break;
 
-        tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
-
-        switch (type) {
-        case 1: /* float64 */
-            tcg_double = read_fp_dreg(s, rn);
-            if (is_signed) {
-                if (!sf) {
-                    gen_helper_vfp_tosld(tcg_int, tcg_double,
-                                         tcg_shift, tcg_fpstatus);
-                } else {
-                    gen_helper_vfp_tosqd(tcg_int, tcg_double,
-                                         tcg_shift, tcg_fpstatus);
-                }
-            } else {
-                if (!sf) {
-                    gen_helper_vfp_tould(tcg_int, tcg_double,
-                                         tcg_shift, tcg_fpstatus);
-                } else {
-                    gen_helper_vfp_touqd(tcg_int, tcg_double,
-                                         tcg_shift, tcg_fpstatus);
-                }
-            }
-            if (!sf) {
-                tcg_gen_ext32u_i64(tcg_int, tcg_int);
-            }
-            break;
-
-        case 0: /* float32 */
-            tcg_single = read_fp_sreg(s, rn);
-            if (sf) {
-                if (is_signed) {
-                    gen_helper_vfp_tosqs(tcg_int, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                } else {
-                    gen_helper_vfp_touqs(tcg_int, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                }
-            } else {
-                TCGv_i32 tcg_dest = tcg_temp_new_i32();
-                if (is_signed) {
-                    gen_helper_vfp_tosls(tcg_dest, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                } else {
-                    gen_helper_vfp_touls(tcg_dest, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                }
-                tcg_gen_extu_i32_i64(tcg_int, tcg_dest);
-            }
-            break;
-
-        case 3: /* float16 */
-            tcg_single = read_fp_sreg(s, rn);
-            if (sf) {
-                if (is_signed) {
-                    gen_helper_vfp_tosqh(tcg_int, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                } else {
-                    gen_helper_vfp_touqh(tcg_int, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                }
-            } else {
-                TCGv_i32 tcg_dest = tcg_temp_new_i32();
-                if (is_signed) {
-                    gen_helper_vfp_toslh(tcg_dest, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                } else {
-                    gen_helper_vfp_toulh(tcg_dest, tcg_single,
-                                         tcg_shift, tcg_fpstatus);
-                }
-                tcg_gen_extu_i32_i64(tcg_int, tcg_dest);
-            }
-            break;
-
-        default:
-            g_assert_not_reached();
-        }
-
-        gen_restore_rmode(tcg_rmode, tcg_fpstatus);
+    default:
+        g_assert_not_reached();
     }
+    return true;
 }
 
-/* Floating point <-> fixed point conversions
- *   31   30  29 28       24 23  22  21 20   19 18    16 15   10 9    5 4    0
- * +----+---+---+-----------+------+---+-------+--------+-------+------+------+
- * | sf | 0 | S | 1 1 1 1 0 | type | 0 | rmode | opcode | scale |  Rn  |  Rd  |
- * +----+---+---+-----------+------+---+-------+--------+-------+------+------+
- */
-static void disas_fp_fixed_conv(DisasContext *s, uint32_t insn)
+static bool do_cvtf_g(DisasContext *s, arg_fcvt *a, bool is_signed)
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int scale = extract32(insn, 10, 6);
-    int opcode = extract32(insn, 16, 3);
-    int rmode = extract32(insn, 19, 2);
-    int type = extract32(insn, 22, 2);
-    bool sbit = extract32(insn, 29, 1);
-    bool sf = extract32(insn, 31, 1);
-    bool itof;
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
 
-    if (sbit || (!sf && scale < 32)) {
-        unallocated_encoding(s);
-        return;
+    if (check <= 0) {
+        return check == 0;
     }
 
-    switch (type) {
-    case 0: /* float32 */
-    case 1: /* float64 */
-        break;
-    case 3: /* float16 */
-        if (dc_isar_feature(aa64_fp16, s)) {
-            break;
+    if (a->sf) {
+        tcg_int = cpu_reg(s, a->rn);
+    } else {
+        tcg_int = read_cpu_reg(s, a->rn, true);
+        if (is_signed) {
+            tcg_gen_ext32s_i64(tcg_int, tcg_int);
+        } else {
+            tcg_gen_ext32u_i64(tcg_int, tcg_int);
         }
-        /* fallthru */
-    default:
-        unallocated_encoding(s);
-        return;
     }
-
-    switch ((rmode << 3) | opcode) {
-    case 0x2: /* SCVTF */
-    case 0x3: /* UCVTF */
-        itof = true;
-        break;
-    case 0x18: /* FCVTZS */
-    case 0x19: /* FCVTZU */
-        itof = false;
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    handle_fpfpcvt(s, rd, rn, opcode, itof, FPROUNDING_ZERO, scale, sf, type);
+    return do_cvtf_scalar(s, a->esz, a->rd, a->shift, tcg_int, is_signed);
 }
 
+TRANS(SCVTF_g, do_cvtf_g, a, true)
+TRANS(UCVTF_g, do_cvtf_g, a, false)
+
+static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
+                           TCGv_i64 tcg_out, int shift, int rn,
+                           ARMFPRounding rmode)
+{
+    TCGv_ptr tcg_fpstatus;
+    TCGv_i32 tcg_shift, tcg_rmode, tcg_single;
+
+    tcg_fpstatus = fpstatus_ptr(esz == MO_16 ? FPST_FPCR_F16 : FPST_FPCR);
+    tcg_shift = tcg_constant_i32(shift);
+    tcg_rmode = gen_set_rmode(rmode, tcg_fpstatus);
+
+    switch (esz) {
+    case MO_64:
+        read_vec_element(s, tcg_out, rn, 0, MO_64);
+        switch (out) {
+        case MO_64 | MO_SIGN:
+            gen_helper_vfp_tosqd(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_64:
+            gen_helper_vfp_touqd(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_32 | MO_SIGN:
+            gen_helper_vfp_tosld(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_32:
+            gen_helper_vfp_tould(tcg_out, tcg_out, tcg_shift, tcg_fpstatus);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case MO_32:
+        tcg_single = read_fp_sreg(s, rn);
+        switch (out) {
+        case MO_64 | MO_SIGN:
+            gen_helper_vfp_tosqs(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_64:
+            gen_helper_vfp_touqs(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_32 | MO_SIGN:
+            gen_helper_vfp_tosls(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
+        case MO_32:
+            gen_helper_vfp_touls(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    case MO_16:
+        tcg_single = read_fp_hreg(s, rn);
+        switch (out) {
+        case MO_64 | MO_SIGN:
+            gen_helper_vfp_tosqh(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_64:
+            gen_helper_vfp_touqh(tcg_out, tcg_single, tcg_shift, tcg_fpstatus);
+            break;
+        case MO_32 | MO_SIGN:
+            gen_helper_vfp_toslh(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
+        case MO_32:
+            gen_helper_vfp_toulh(tcg_single, tcg_single,
+                                 tcg_shift, tcg_fpstatus);
+            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    gen_restore_rmode(tcg_rmode, tcg_fpstatus);
+}
+
+static bool do_fcvt_g(DisasContext *s, arg_fcvt *a,
+                      ARMFPRounding rmode, bool is_signed)
+{
+    TCGv_i64 tcg_int;
+    int check = fp_access_check_scalar_hsd(s, a->esz);
+
+    if (check <= 0) {
+        return check == 0;
+    }
+
+    tcg_int = cpu_reg(s, a->rd);
+    do_fcvt_scalar(s, (a->sf ? MO_64 : MO_32) | (is_signed ? MO_SIGN : 0),
+                   a->esz, tcg_int, a->shift, a->rn, rmode);
+
+    if (!a->sf) {
+        tcg_gen_ext32u_i64(tcg_int, tcg_int);
+    }
+    return true;
+}
+
+TRANS(FCVTNS_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, true)
+TRANS(FCVTNU_g, do_fcvt_g, a, FPROUNDING_TIEEVEN, false)
+TRANS(FCVTPS_g, do_fcvt_g, a, FPROUNDING_POSINF, true)
+TRANS(FCVTPU_g, do_fcvt_g, a, FPROUNDING_POSINF, false)
+TRANS(FCVTMS_g, do_fcvt_g, a, FPROUNDING_NEGINF, true)
+TRANS(FCVTMU_g, do_fcvt_g, a, FPROUNDING_NEGINF, false)
+TRANS(FCVTZS_g, do_fcvt_g, a, FPROUNDING_ZERO, true)
+TRANS(FCVTZU_g, do_fcvt_g, a, FPROUNDING_ZERO, false)
+TRANS(FCVTAS_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, true)
+TRANS(FCVTAU_g, do_fcvt_g, a, FPROUNDING_TIEAWAY, false)
+
 static void handle_fmov(DisasContext *s, int rd, int rn, int type, bool itof)
 {
     /* FMOV: gpr to or from float, double, or top half of quad fp reg,
@@ -8844,33 +8813,11 @@ static void disas_fp_int_conv(DisasContext *s, uint32_t insn)
     switch (opcode) {
     case 2: /* SCVTF */
     case 3: /* UCVTF */
-        itof = true;
-        /* fallthru */
     case 4: /* FCVTAS */
     case 5: /* FCVTAU */
-        if (rmode != 0) {
-            goto do_unallocated;
-        }
-        /* fallthru */
     case 0: /* FCVT[NPMZ]S */
     case 1: /* FCVT[NPMZ]U */
-        switch (type) {
-        case 0: /* float32 */
-        case 1: /* float64 */
-            break;
-        case 3: /* float16 */
-            if (!dc_isar_feature(aa64_fp16, s)) {
-                goto do_unallocated;
-            }
-            break;
-        default:
-            goto do_unallocated;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fpfpcvt(s, rd, rn, opcode, itof, rmode, 64, sf, type);
-        break;
+        goto do_unallocated;
 
     default:
         switch (sf << 7 | type << 5 | rmode << 3 | opcode) {
@@ -8924,7 +8871,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
         unallocated_encoding(s); /* in decodetree */
     } else if (extract32(insn, 21, 1) == 0) {
         /* Floating point to fixed point conversions */
-        disas_fp_fixed_conv(s, insn);
+        unallocated_encoding(s); /* in decodetree */
     } else {
         switch (extract32(insn, 10, 2)) {
         case 1: /* Floating point conditional compare */
-- 
2.34.1


