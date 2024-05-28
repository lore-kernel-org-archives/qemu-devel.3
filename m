Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803DBC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxV1-0001iB-Ly; Tue, 28 May 2024 10:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUw-0001fo-11
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUs-000760-U1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35b447d78f1so458240f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905293; x=1717510093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hft4bieprUBhQb/iCkHZaG8gsd1lziCQes6UVxdv4c=;
 b=neu/4YblH9eAhYCg9TMLw413SRpyUD+DquQhmXlAcwhS/dd2gD3yzqG3zs0hIT8bEp
 bcTvuFhUdC0jKt4dyavn6cGlyXOstwLSnOQcHF2FgafAnIJ1oQmXXbGBo8AJK+U3Cl8G
 Z4nzpuwTnmJSVEUQiKyTby1wUi+2MXdGhLG/OEsrgD8m4flMzeYyrFR1KOTvnfItgLUK
 X6bjY56ZWz5grNaLhiNtLB7tmHdhIBZ1yzf+9Nxr8cQfcxmXIvgSdLNjPQ5BK+xnFZlZ
 /KAJ46C0LlStbOcqFDhVyZiPKcWdpdNfQKuixjC+u9aharSxAqwKD8JDpYdKrvknL7J+
 XAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905293; x=1717510093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3hft4bieprUBhQb/iCkHZaG8gsd1lziCQes6UVxdv4c=;
 b=GQ5Zwjt2BUxrtOxS1E/Z442VYXYQd2odv5YhsM4SsoJd5RlWAfuJRIAkIgAdd2r5ci
 zMO5N9Vv8LEEuORrUwgTp740ZjCtccTVJc2+OyYBhO+tWAugmnFE+h0lszxQ/VeooLin
 240x8j6/YOxF81CWk0knOIlFeA+3KIx7DTert1nYhOoGdA4KhxkoPowMEB5Ysm7+s7Ve
 SDnZ08MKgwnwHd5x8EAeBp5BO0mo4O+NELAoacVPIFJc6oBkueI+mcSvxihjpVwZuhh9
 vCtCDgkyhtxMPqLqGBgWVun2OtlY4WMIB6zyMe/UoMDP2SSGaPCJy+9AzZ5BZBdY7/ej
 6+LA==
X-Gm-Message-State: AOJu0Yw4FwZgmKGLhQDFPyITkqBnU83r4fNh9A3VmBx8d6dRgjys0uQX
 DOy4bO+Yl+Qyxc7Lf928+kcQeNm6BAU/1Sen3yAlowKeRkNBN8xtS5TZbW6xt7tHg2AL1kt1Z+4
 R
X-Google-Smtp-Source: AGHT+IHzbRVjktoLRED0TAXWcK3lBacP3jNhOLBiseD8xpwDf/CnI0qxoNZSj2gxBYOr5VUccYcDqQ==
X-Received: by 2002:adf:e507:0:b0:354:dd6a:a5cd with SMTP id
 ffacd0b85a97d-35506de26e4mr10020690f8f.33.1716905293562; 
 Tue, 28 May 2024 07:08:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/42] target/arm: Convert FNMUL to decodetree
Date: Tue, 28 May 2024 15:07:40 +0100
Message-Id: <20240528140753.3620597-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is the last instruction within disas_fp_2src,
so remove that and its subroutines.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240524232121.284515-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |   1 +
 target/arm/tcg/translate-a64.c | 177 +++++----------------------------
 2 files changed, 27 insertions(+), 151 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index e2678d919e5..cde4b86303d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -703,6 +703,7 @@ FADD_s          0001 1110 ..1 ..... 0010 10 ..... ..... @rrr_hsd
 FSUB_s          0001 1110 ..1 ..... 0011 10 ..... ..... @rrr_hsd
 FDIV_s          0001 1110 ..1 ..... 0001 10 ..... ..... @rrr_hsd
 FMUL_s          0001 1110 ..1 ..... 0000 10 ..... ..... @rrr_hsd
+FNMUL_s         0001 1110 ..1 ..... 1000 10 ..... ..... @rrr_hsd
 
 FMAX_s          0001 1110 ..1 ..... 0100 10 ..... ..... @rrr_hsd
 FMIN_s          0001 1110 ..1 ..... 0101 10 ..... ..... @rrr_hsd
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 878f83298f5..5ba30ba7c86 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4950,6 +4950,31 @@ static const FPScalar f_scalar_fmulx = {
 };
 TRANS(FMULX_s, do_fp3_scalar, a, &f_scalar_fmulx)
 
+static void gen_fnmul_h(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_mulh(d, n, m, s);
+    gen_vfp_negh(d, d);
+}
+
+static void gen_fnmul_s(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muls(d, n, m, s);
+    gen_vfp_negs(d, d);
+}
+
+static void gen_fnmul_d(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_ptr s)
+{
+    gen_helper_vfp_muld(d, n, m, s);
+    gen_vfp_negd(d, d);
+}
+
+static const FPScalar f_scalar_fnmul = {
+    gen_fnmul_h,
+    gen_fnmul_s,
+    gen_fnmul_d,
+};
+TRANS(FNMUL_s, do_fp3_scalar, a, &f_scalar_fnmul)
+
 static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
                           gen_helper_gvec_3_ptr * const fns[3])
 {
@@ -6932,156 +6957,6 @@ static void disas_fp_1src(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Floating-point data-processing (2 source) - single precision */
-static void handle_fp_2src_single(DisasContext *s, int opcode,
-                                  int rd, int rn, int rm)
-{
-    TCGv_i32 tcg_op1;
-    TCGv_i32 tcg_op2;
-    TCGv_i32 tcg_res;
-    TCGv_ptr fpst;
-
-    tcg_res = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR);
-    tcg_op1 = read_fp_sreg(s, rn);
-    tcg_op2 = read_fp_sreg(s, rm);
-
-    switch (opcode) {
-    case 0x8: /* FNMUL */
-        gen_helper_vfp_muls(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_vfp_negs(tcg_res, tcg_res);
-        break;
-    default:
-    case 0x0: /* FMUL */
-    case 0x1: /* FDIV */
-    case 0x2: /* FADD */
-    case 0x3: /* FSUB */
-    case 0x4: /* FMAX */
-    case 0x5: /* FMIN */
-    case 0x6: /* FMAXNM */
-    case 0x7: /* FMINNM */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (2 source) - double precision */
-static void handle_fp_2src_double(DisasContext *s, int opcode,
-                                  int rd, int rn, int rm)
-{
-    TCGv_i64 tcg_op1;
-    TCGv_i64 tcg_op2;
-    TCGv_i64 tcg_res;
-    TCGv_ptr fpst;
-
-    tcg_res = tcg_temp_new_i64();
-    fpst = fpstatus_ptr(FPST_FPCR);
-    tcg_op1 = read_fp_dreg(s, rn);
-    tcg_op2 = read_fp_dreg(s, rm);
-
-    switch (opcode) {
-    case 0x8: /* FNMUL */
-        gen_helper_vfp_muld(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_vfp_negd(tcg_res, tcg_res);
-        break;
-    default:
-    case 0x0: /* FMUL */
-    case 0x1: /* FDIV */
-    case 0x2: /* FADD */
-    case 0x3: /* FSUB */
-    case 0x4: /* FMAX */
-    case 0x5: /* FMIN */
-    case 0x6: /* FMAXNM */
-    case 0x7: /* FMINNM */
-        g_assert_not_reached();
-    }
-
-    write_fp_dreg(s, rd, tcg_res);
-}
-
-/* Floating-point data-processing (2 source) - half precision */
-static void handle_fp_2src_half(DisasContext *s, int opcode,
-                                int rd, int rn, int rm)
-{
-    TCGv_i32 tcg_op1;
-    TCGv_i32 tcg_op2;
-    TCGv_i32 tcg_res;
-    TCGv_ptr fpst;
-
-    tcg_res = tcg_temp_new_i32();
-    fpst = fpstatus_ptr(FPST_FPCR_F16);
-    tcg_op1 = read_fp_hreg(s, rn);
-    tcg_op2 = read_fp_hreg(s, rm);
-
-    switch (opcode) {
-    case 0x8: /* FNMUL */
-        gen_helper_advsimd_mulh(tcg_res, tcg_op1, tcg_op2, fpst);
-        gen_vfp_negh(tcg_res, tcg_res);
-        break;
-    default:
-    case 0x0: /* FMUL */
-    case 0x1: /* FDIV */
-    case 0x2: /* FADD */
-    case 0x3: /* FSUB */
-    case 0x4: /* FMAX */
-    case 0x5: /* FMIN */
-    case 0x6: /* FMAXNM */
-    case 0x7: /* FMINNM */
-        g_assert_not_reached();
-    }
-
-    write_fp_sreg(s, rd, tcg_res);
-}
-
-/* Floating point data-processing (2 source)
- *   31  30  29 28       24 23  22  21 20  16 15    12 11 10 9    5 4    0
- * +---+---+---+-----------+------+---+------+--------+-----+------+------+
- * | M | 0 | S | 1 1 1 1 0 | type | 1 |  Rm  | opcode | 1 0 |  Rn  |  Rd  |
- * +---+---+---+-----------+------+---+------+--------+-----+------+------+
- */
-static void disas_fp_2src(DisasContext *s, uint32_t insn)
-{
-    int mos = extract32(insn, 29, 3);
-    int type = extract32(insn, 22, 2);
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rm = extract32(insn, 16, 5);
-    int opcode = extract32(insn, 12, 4);
-
-    if (opcode > 8 || mos) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    switch (type) {
-    case 0:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_2src_single(s, opcode, rd, rn, rm);
-        break;
-    case 1:
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_2src_double(s, opcode, rd, rn, rm);
-        break;
-    case 3:
-        if (!dc_isar_feature(aa64_fp16, s)) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        handle_fp_2src_half(s, opcode, rd, rn, rm);
-        break;
-    default:
-        unallocated_encoding(s);
-    }
-}
-
 /* Floating-point data-processing (3 source) - single precision */
 static void handle_fp_3src_single(DisasContext *s, bool o0, bool o1,
                                   int rd, int rn, int rm, int ra)
@@ -7685,7 +7560,7 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
             break;
         case 2:
             /* Floating point data-processing (2 source) */
-            disas_fp_2src(s, insn);
+            unallocated_encoding(s); /* in decodetree */
             break;
         case 3:
             /* Floating point conditional select */
-- 
2.34.1


