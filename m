Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF225C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtjn-0001iw-1C; Wed, 19 Aug 2026 23:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjk-0001cR-5E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:41 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjg-00044y-SN
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso1707389b3a.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197595; x=1787802395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YDe9QslZfKvhuINTOB9JrcuDeFDRZ6aQd6kbXZ9uq/w=;
 b=hbvr0HbTu887iK45smGPhPHsFiqwXIJPibsgxHNRVKT7R2aT6YMC461G4UciPyoovx
 xxpsg+ME7EOrcmH/ZIFJMd3T/Mtlg2U+y4TJblw2tnU3BudbhocSDPKooSLSuP+ADVY4
 kf55pv5R68uX5fUx6cL7jd+PBcv1ezed3FGfHrsQ/boeiCm/o6fAiMCayr0DeCQSl4Ux
 xP8wqoWqWLzw4U9k2mLp9uWTCa2hKHrjYazI3fWhnOMNnlPe9+3MFIOjqMwnr/55S/9G
 VBFmW8HJpbuwukGpRY4d4nFZ/VQHXYjVDYqiAOUXMuuplkB6ELdG7xH0b0BFsmNzxqso
 2JSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197595; x=1787802395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YDe9QslZfKvhuINTOB9JrcuDeFDRZ6aQd6kbXZ9uq/w=;
 b=CoY0vwrFLERjfab5t2pMWXZzEBJ4uoeaFN/gI812t1Gy17VQcgTjlBFH+tlJ6s+37f
 3O8Ce2u/t5iqu0K2PDMeKfJqbzaDhQ5aJzlGOxt/foiHolDMGrCeLBRTKCHq0P5SpG4A
 c8LZeQj+s3JRkv3IltqHiJAvMGrUmHvruZnMVI5PzOP1xVg2+XR3VBtlG7Tb7NZVFcXg
 f4NTQ6XpJKYRqUC041N6yBpnGJBYVhD07PH278M6Zoz4Y3V+fwDpRuliCGw316mvYefI
 HCRxh6drILPx4Q7nBCJ98zdZD/W/LYSDGCvukFMl+lWMeQa4GvxaW+k8C01R6sQUJfG+
 TBgw==
X-Gm-Message-State: AOJu0YzTncqcigMQ55I2FuIS3BqXyls3q0s9glFz7BF2DJmrmFBNLaGq
 nLGpTpK9oFCvQ3t39dSPV44Cp9aJZ7b9kc9C7swoPcPI07LADuae8VkzhZU60Q==
X-Gm-Gg: AR+sD11irS2IRg9kVkf514bx5UYjIERZQBgeK52VV994GByBF1S+HUjTID1tJoQOtOX
 WtYx1yZ8ZiwQ8HebQCZVzVcEoTJXjGWYysR0YiFb7Fp0BU0Hm/ucqKNOzTVHeWifTpVmfq4qGiu
 VBVVZJAUobrwQyjURbBu0g8WH3+GcvNL54YbaF3NcGnBKVo4sINOWVwjn/CgyXq/v87pIUhd8L8
 1e9RKjtbv+qLn1DzD/pE7zR6is/WO/qsA+x3QYqtgNrsbHP17s9C8wfZ856xKIaSB+DmEXoOin3
 +yrZUbypwLgqCgYoLPz5loGPsxCMp7qprt+IYt6nVK7HMbvQoz05FkhMrI5mOKRXvlyO9jgkK4p
 20yD3PVixlo/Crs+2zRw9ULp1PNleC9e4qbDuVtLA/Si1JGzqrf+ifrk4jfcaDxfDsia0wNyb01
 b7I6aRAnpVE4BL1++c+sdxtjrkcVICZ/bvyq85HLkpHecLpQjxUA2wYEJrHKQ+tt30CHvoU5lvs
 pJxEA==
X-Received: by 2002:a05:6a21:7d02:b0:3c4:46ca:334b with SMTP id
 adf61e73a8af0-3cd016660e9mr19159698637.9.1787197595221; 
 Wed, 19 Aug 2026 20:46:35 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 37/93] disas/riscv: Move operand extractors earlier in file
Date: Thu, 20 Aug 2026 13:43:34 +1000
Message-ID: <20260820034430.1186695-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-2-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 870 +++++++++++++++++++++++++-------------------------
 1 file changed, 435 insertions(+), 435 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 2ba0a6a73a..e3fbc26626 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1259,6 +1259,401 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
     { rv_op_illegal, NULL }
 };
 
+/* operand extractors */
+
+static uint32_t operand_rd(rv_inst inst)
+{
+    return extract32(inst, 7, 5);
+}
+
+static uint32_t operand_rs1(rv_inst inst)
+{
+    return extract32(inst, 15, 5);
+}
+
+static uint32_t operand_rs2(rv_inst inst)
+{
+    return extract32(inst, 20, 5);
+}
+
+static uint32_t operand_rs3(rv_inst inst)
+{
+    return extract32(inst, 27, 5);
+}
+
+static uint32_t operand_aq(rv_inst inst)
+{
+    return extract32(inst, 26, 1);
+}
+
+static uint32_t operand_rl(rv_inst inst)
+{
+    return extract32(inst, 25, 1);
+}
+
+static uint32_t operand_pred(rv_inst inst)
+{
+    return extract32(inst, 24, 4);
+}
+
+static uint32_t operand_succ(rv_inst inst)
+{
+    return extract32(inst, 20, 4);
+}
+
+static uint32_t operand_rm(rv_inst inst)
+{
+    return extract32(inst, 12, 3);
+}
+
+static uint32_t operand_shamt5(rv_inst inst)
+{
+    return extract32(inst, 20, 5);
+}
+
+static uint32_t operand_shamt6(rv_inst inst)
+{
+    return extract32(inst, 20, 6);
+}
+
+static uint32_t operand_shamt7(rv_inst inst)
+{
+    return extract32(inst, 20, 7);
+}
+
+static uint32_t operand_crdq(rv_inst inst)
+{
+    return extract32(inst, 2, 3);
+}
+
+static uint32_t operand_crs1q(rv_inst inst)
+{
+    return extract32(inst, 7, 3);
+}
+
+static uint32_t operand_crs1rdq(rv_inst inst)
+{
+    return extract32(inst, 7, 3);
+}
+
+static uint32_t operand_crs2q(rv_inst inst)
+{
+    return extract32(inst, 2, 3);
+}
+
+static uint32_t calculate_xreg(uint32_t sreg)
+{
+    return sreg < 2 ? sreg + 8 : sreg + 16;
+}
+
+static uint32_t operand_sreg1(rv_inst inst)
+{
+    return calculate_xreg(extract32(inst, 7, 3));
+}
+
+static uint32_t operand_sreg2(rv_inst inst)
+{
+    return calculate_xreg(extract32(inst, 2, 3));
+}
+
+static uint32_t operand_crd(rv_inst inst)
+{
+    return extract32(inst, 7, 5);
+}
+
+static uint32_t operand_crs1(rv_inst inst)
+{
+    return extract32(inst, 7, 5);
+}
+
+static uint32_t operand_crs1rd(rv_inst inst)
+{
+    return extract32(inst, 7, 5);
+}
+
+static uint32_t operand_crs2(rv_inst inst)
+{
+    return extract32(inst, 2, 5);
+}
+
+static uint32_t operand_cimmsh5(rv_inst inst)
+{
+    return extract32(inst, 2, 5);
+}
+
+static uint32_t operand_csr12(rv_inst inst)
+{
+    return extract32(inst, 20, 12);
+}
+
+static int32_t operand_imm12(rv_inst inst)
+{
+    return sextract32(inst, 20, 12);
+}
+
+static int32_t operand_imm20(rv_inst inst)
+{
+    return sextract32(inst, 12, 20) << 12;
+}
+
+static int32_t operand_jimm20(rv_inst inst)
+{
+    return sextract32(inst, 31, 1) << 20 |
+        extract32(inst, 21, 10) << 1 |
+        extract32(inst, 20, 1) << 11 |
+        extract32(inst, 12, 8) << 12;
+}
+
+static int32_t operand_simm12(rv_inst inst)
+{
+    return sextract32(inst, 25, 7) << 5 |
+        extract32(inst, 7, 5);
+}
+
+static int32_t operand_sbimm12(rv_inst inst)
+{
+    return sextract32(inst, 31, 1) << 12 |
+        extract32(inst, 25, 6) << 5 |
+        extract32(inst, 8, 4) << 1 |
+        extract32(inst, 7, 1) << 11;
+}
+
+static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
+{
+    int imm = extract32(inst, 12, 1) << 5 |
+        extract32(inst, 2, 5);
+    if (isa == rv128) {
+        imm = imm ? imm : 64;
+    }
+    return imm;
+}
+
+static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
+{
+    int imm = extract32(inst, 12, 1) << 5 |
+        extract32(inst, 2, 5);
+    if (isa == rv128) {
+        imm = imm | (imm & 32) << 1;
+        imm = imm ? imm : 64;
+    }
+    return imm;
+}
+
+static int32_t operand_cimmi(rv_inst inst)
+{
+    return sextract32(inst, 12, 1) << 5 |
+        extract32(inst, 2, 5);
+}
+
+static int32_t operand_cimmui(rv_inst inst)
+{
+    return sextract32(inst, 12, 1) << 17 |
+        extract32(inst, 2, 5) << 12;
+}
+
+static uint32_t operand_cimmlwsp(rv_inst inst)
+{
+    return extract32(inst, 12, 1) << 5 |
+        extract32(inst, 4, 3) << 2 |
+        extract32(inst, 2, 2) << 6;
+}
+
+static uint32_t operand_cimmldsp(rv_inst inst)
+{
+    return extract32(inst, 12, 1) << 5 |
+        extract32(inst, 5, 2) << 3 |
+        extract32(inst, 2, 3) << 6;
+}
+
+static uint32_t operand_cimmlqsp(rv_inst inst)
+{
+    return extract32(inst, 12, 1) << 5 |
+        extract32(inst, 6, 1) << 4 |
+        extract32(inst, 2, 4) << 6;
+}
+
+static int32_t operand_cimm16sp(rv_inst inst)
+{
+    return sextract32(inst, 12, 1) << 9 |
+        extract32(inst, 6, 1) << 4 |
+        extract32(inst, 5, 1) << 6 |
+        extract32(inst, 3, 2) << 7 |
+        extract32(inst, 2, 1) << 5;
+}
+
+static int32_t operand_cimmj(rv_inst inst)
+{
+    return sextract32(inst, 12, 1) << 11 |
+        extract32(inst, 11, 1) << 4 |
+        extract32(inst, 9, 2) << 8 |
+        extract32(inst, 8, 1) << 10 |
+        extract32(inst, 7, 1) << 6 |
+        extract32(inst, 6, 1) << 7 |
+        extract32(inst, 3, 3) << 1 |
+        extract32(inst, 2, 1) << 5;
+}
+
+static int32_t operand_cimmb(rv_inst inst)
+{
+    return sextract32(inst, 12, 1) << 8 |
+        extract32(inst, 10, 2) << 3 |
+        extract32(inst, 5, 2) << 6 |
+        extract32(inst, 3, 2) << 1 |
+        extract32(inst, 2, 1) << 5;
+}
+
+static uint32_t operand_cimmswsp(rv_inst inst)
+{
+    return extract32(inst, 9, 4) << 2 |
+        extract32(inst, 7, 2) << 6;
+}
+
+static uint32_t operand_cimmsdsp(rv_inst inst)
+{
+    return extract32(inst, 10, 3) << 3 |
+        extract32(inst, 7, 3) << 6;
+}
+
+static uint32_t operand_cimmsqsp(rv_inst inst)
+{
+    return extract32(inst, 11, 2) << 4 |
+        extract32(inst, 7, 4) << 6;
+}
+
+static uint32_t operand_cimm4spn(rv_inst inst)
+{
+    return extract32(inst, 11, 2) << 4 |
+        extract32(inst, 7, 4) << 6 |
+        extract32(inst, 6, 1) << 2 |
+        extract32(inst, 5, 1) << 3;
+}
+
+static uint32_t operand_cimmw(rv_inst inst)
+{
+    return extract32(inst, 10, 3) << 3 |
+        extract32(inst, 6, 1) << 2 |
+        extract32(inst, 5, 1) << 6;
+}
+
+static uint32_t operand_cimmd(rv_inst inst)
+{
+    return extract32(inst, 10, 3) << 3 |
+        extract32(inst, 5, 2) << 6;
+}
+
+static uint32_t operand_cimmq(rv_inst inst)
+{
+    return extract32(inst, 11, 2) << 4 |
+        extract32(inst, 10, 1) << 8 |
+        extract32(inst, 5, 2) << 6;
+}
+
+static int32_t operand_vimm(rv_inst inst)
+{
+    return sextract32(inst, 15, 5);
+}
+
+static uint32_t operand_vuimm(rv_inst inst)
+{
+    return extract32(inst, 15, 5);
+}
+
+static uint32_t operand_vzimm11(rv_inst inst)
+{
+    return extract32(inst, 20, 11);
+}
+
+static uint32_t operand_vzimm10(rv_inst inst)
+{
+    return extract32(inst, 20, 10);
+}
+
+static uint32_t operand_vzimm6(rv_inst inst)
+{
+    return extract32(inst, 26, 1) << 5 |
+        extract32(inst, 15, 5);
+}
+
+static uint32_t operand_bs(rv_inst inst)
+{
+    return extract32(inst, 30, 2);
+}
+
+static uint32_t operand_rnum(rv_inst inst)
+{
+    return extract32(inst, 20, 4);
+}
+
+static uint32_t operand_vm(rv_inst inst)
+{
+    return extract32(inst, 25, 1);
+}
+
+static uint32_t operand_uimm_c_lb(rv_inst inst)
+{
+    return extract32(inst, 5, 1) << 1 |
+        extract32(inst, 6, 1);
+}
+
+static uint32_t operand_uimm_c_lh(rv_inst inst)
+{
+    return extract32(inst, 5, 1) << 1;
+}
+
+static uint32_t operand_zcmp_spimm(rv_inst inst)
+{
+    return extract32(inst, 2, 2) << 4;
+}
+
+static uint32_t operand_zcmp_rlist(rv_inst inst)
+{
+    return extract32(inst, 4, 4);
+}
+
+static uint32_t operand_imm6(rv_inst inst)
+{
+    return extract32(inst, 20, 6);
+}
+
+static uint32_t operand_imm2(rv_inst inst)
+{
+    return extract32(inst, 25, 2);
+}
+
+static uint32_t operand_immh(rv_inst inst)
+{
+    return extract32(inst, 26, 6);
+}
+
+static uint32_t operand_imml(rv_inst inst)
+{
+    return extract32(inst, 20, 6);
+}
+
+static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist, uint32_t spimm)
+{
+    int xlen_bytes_log2 = isa == rv64 ? 3 : 2;
+    int regs = rlist == 15 ? 13 : rlist - 3;
+    uint32_t stack_adj_base = ROUND_UP(regs << xlen_bytes_log2, 16);
+    return stack_adj_base + spimm;
+}
+
+static uint32_t operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
+{
+    return calculate_stack_adj(isa, operand_zcmp_rlist(inst),
+                               operand_zcmp_spimm(inst));
+}
+
+static uint32_t operand_tbl_index(rv_inst inst)
+{
+    return extract32(inst, 2, 8);
+}
+
+static uint32_t operand_lpl(rv_inst inst)
+{
+    return extract32(inst, 12, 20);
+}
+
 /* instruction metadata */
 
 const rv_opcode_data rvi_opcode_data[] = {
@@ -4155,442 +4550,47 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     case 2: op = rv_op_vaesem_vv; break;
                     case 3: op = rv_op_vaesef_vv; break;
                     case 16: op = rv_op_vsm4r_vv; break;
-                    case 17: op = rv_op_vgmul_vv; break;
-                    }
-                    break;
-                case 41:
-                    switch ((inst >> 15) & 0b11111) {
-                    case 0: op = rv_op_vaesdm_vs; break;
-                    case 1: op = rv_op_vaesdf_vs; break;
-                    case 2: op = rv_op_vaesem_vs; break;
-                    case 3: op = rv_op_vaesef_vs; break;
-                    case 7: op = rv_op_vaesz_vs; break;
-                    case 16: op = rv_op_vsm4r_vs; break;
-                    }
-                    break;
-                case 42: op = rv_op_vaeskf2_vi; break;
-                case 43: op = rv_op_vsm3c_vi; break;
-                case 44: op = rv_op_vghsh_vv; break;
-                case 45: op = rv_op_vsha2ms_vv; break;
-                case 46: op = rv_op_vsha2ch_vv; break;
-                case 47: op = rv_op_vsha2cl_vv; break;
-                }
-            }
-            break;
-        case 30:
-            switch (((inst >> 22) & 0b1111111000) |
-                    ((inst >> 12) & 0b0000000111)) {
-            case 0: op = rv_op_addd; break;
-            case 1: op = rv_op_slld; break;
-            case 5: op = rv_op_srld; break;
-            case 8: op = rv_op_muld; break;
-            case 12: op = rv_op_divd; break;
-            case 13: op = rv_op_divud; break;
-            case 14: op = rv_op_remd; break;
-            case 15: op = rv_op_remud; break;
-            case 256: op = rv_op_subd; break;
-            case 261: op = rv_op_srad; break;
-            }
-            break;
-        }
-        break;
-    }
-    dec->op = op;
-}
-
-/* operand extractors */
-
-static uint32_t operand_rd(rv_inst inst)
-{
-    return extract32(inst, 7, 5);
-}
-
-static uint32_t operand_rs1(rv_inst inst)
-{
-    return extract32(inst, 15, 5);
-}
-
-static uint32_t operand_rs2(rv_inst inst)
-{
-    return extract32(inst, 20, 5);
-}
-
-static uint32_t operand_rs3(rv_inst inst)
-{
-    return extract32(inst, 27, 5);
-}
-
-static uint32_t operand_aq(rv_inst inst)
-{
-    return extract32(inst, 26, 1);
-}
-
-static uint32_t operand_rl(rv_inst inst)
-{
-    return extract32(inst, 25, 1);
-}
-
-static uint32_t operand_pred(rv_inst inst)
-{
-    return extract32(inst, 24, 4);
-}
-
-static uint32_t operand_succ(rv_inst inst)
-{
-    return extract32(inst, 20, 4);
-}
-
-static uint32_t operand_rm(rv_inst inst)
-{
-    return extract32(inst, 12, 3);
-}
-
-static uint32_t operand_shamt5(rv_inst inst)
-{
-    return extract32(inst, 20, 5);
-}
-
-static uint32_t operand_shamt6(rv_inst inst)
-{
-    return extract32(inst, 20, 6);
-}
-
-static uint32_t operand_shamt7(rv_inst inst)
-{
-    return extract32(inst, 20, 7);
-}
-
-static uint32_t operand_crdq(rv_inst inst)
-{
-    return extract32(inst, 2, 3);
-}
-
-static uint32_t operand_crs1q(rv_inst inst)
-{
-    return extract32(inst, 7, 3);
-}
-
-static uint32_t operand_crs1rdq(rv_inst inst)
-{
-    return extract32(inst, 7, 3);
-}
-
-static uint32_t operand_crs2q(rv_inst inst)
-{
-    return extract32(inst, 2, 3);
-}
-
-static uint32_t calculate_xreg(uint32_t sreg)
-{
-    return sreg < 2 ? sreg + 8 : sreg + 16;
-}
-
-static uint32_t operand_sreg1(rv_inst inst)
-{
-    return calculate_xreg(extract32(inst, 7, 3));
-}
-
-static uint32_t operand_sreg2(rv_inst inst)
-{
-    return calculate_xreg(extract32(inst, 2, 3));
-}
-
-static uint32_t operand_crd(rv_inst inst)
-{
-    return extract32(inst, 7, 5);
-}
-
-static uint32_t operand_crs1(rv_inst inst)
-{
-    return extract32(inst, 7, 5);
-}
-
-static uint32_t operand_crs1rd(rv_inst inst)
-{
-    return extract32(inst, 7, 5);
-}
-
-static uint32_t operand_crs2(rv_inst inst)
-{
-    return extract32(inst, 2, 5);
-}
-
-static uint32_t operand_cimmsh5(rv_inst inst)
-{
-    return extract32(inst, 2, 5);
-}
-
-static uint32_t operand_csr12(rv_inst inst)
-{
-    return extract32(inst, 20, 12);
-}
-
-static int32_t operand_imm12(rv_inst inst)
-{
-    return sextract32(inst, 20, 12);
-}
-
-static int32_t operand_imm20(rv_inst inst)
-{
-    return sextract32(inst, 12, 20) << 12;
-}
-
-static int32_t operand_jimm20(rv_inst inst)
-{
-    return sextract32(inst, 31, 1) << 20 |
-        extract32(inst, 21, 10) << 1 |
-        extract32(inst, 20, 1) << 11 |
-        extract32(inst, 12, 8) << 12;
-}
-
-static int32_t operand_simm12(rv_inst inst)
-{
-    return sextract32(inst, 25, 7) << 5 |
-        extract32(inst, 7, 5);
-}
-
-static int32_t operand_sbimm12(rv_inst inst)
-{
-    return sextract32(inst, 31, 1) << 12 |
-        extract32(inst, 25, 6) << 5 |
-        extract32(inst, 8, 4) << 1 |
-        extract32(inst, 7, 1) << 11;
-}
-
-static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
-{
-    int imm = extract32(inst, 12, 1) << 5 |
-        extract32(inst, 2, 5);
-    if (isa == rv128) {
-        imm = imm ? imm : 64;
-    }
-    return imm;
-}
-
-static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
-{
-    int imm = extract32(inst, 12, 1) << 5 |
-        extract32(inst, 2, 5);
-    if (isa == rv128) {
-        imm = imm | (imm & 32) << 1;
-        imm = imm ? imm : 64;
+                    case 17: op = rv_op_vgmul_vv; break;
+                    }
+                    break;
+                case 41:
+                    switch ((inst >> 15) & 0b11111) {
+                    case 0: op = rv_op_vaesdm_vs; break;
+                    case 1: op = rv_op_vaesdf_vs; break;
+                    case 2: op = rv_op_vaesem_vs; break;
+                    case 3: op = rv_op_vaesef_vs; break;
+                    case 7: op = rv_op_vaesz_vs; break;
+                    case 16: op = rv_op_vsm4r_vs; break;
+                    }
+                    break;
+                case 42: op = rv_op_vaeskf2_vi; break;
+                case 43: op = rv_op_vsm3c_vi; break;
+                case 44: op = rv_op_vghsh_vv; break;
+                case 45: op = rv_op_vsha2ms_vv; break;
+                case 46: op = rv_op_vsha2ch_vv; break;
+                case 47: op = rv_op_vsha2cl_vv; break;
+                }
+            }
+            break;
+        case 30:
+            switch (((inst >> 22) & 0b1111111000) |
+                    ((inst >> 12) & 0b0000000111)) {
+            case 0: op = rv_op_addd; break;
+            case 1: op = rv_op_slld; break;
+            case 5: op = rv_op_srld; break;
+            case 8: op = rv_op_muld; break;
+            case 12: op = rv_op_divd; break;
+            case 13: op = rv_op_divud; break;
+            case 14: op = rv_op_remd; break;
+            case 15: op = rv_op_remud; break;
+            case 256: op = rv_op_subd; break;
+            case 261: op = rv_op_srad; break;
+            }
+            break;
+        }
+        break;
     }
-    return imm;
-}
-
-static int32_t operand_cimmi(rv_inst inst)
-{
-    return sextract32(inst, 12, 1) << 5 |
-        extract32(inst, 2, 5);
-}
-
-static int32_t operand_cimmui(rv_inst inst)
-{
-    return sextract32(inst, 12, 1) << 17 |
-        extract32(inst, 2, 5) << 12;
-}
-
-static uint32_t operand_cimmlwsp(rv_inst inst)
-{
-    return extract32(inst, 12, 1) << 5 |
-        extract32(inst, 4, 3) << 2 |
-        extract32(inst, 2, 2) << 6;
-}
-
-static uint32_t operand_cimmldsp(rv_inst inst)
-{
-    return extract32(inst, 12, 1) << 5 |
-        extract32(inst, 5, 2) << 3 |
-        extract32(inst, 2, 3) << 6;
-}
-
-static uint32_t operand_cimmlqsp(rv_inst inst)
-{
-    return extract32(inst, 12, 1) << 5 |
-        extract32(inst, 6, 1) << 4 |
-        extract32(inst, 2, 4) << 6;
-}
-
-static int32_t operand_cimm16sp(rv_inst inst)
-{
-    return sextract32(inst, 12, 1) << 9 |
-        extract32(inst, 6, 1) << 4 |
-        extract32(inst, 5, 1) << 6 |
-        extract32(inst, 3, 2) << 7 |
-        extract32(inst, 2, 1) << 5;
-}
-
-static int32_t operand_cimmj(rv_inst inst)
-{
-    return sextract32(inst, 12, 1) << 11 |
-        extract32(inst, 11, 1) << 4 |
-        extract32(inst, 9, 2) << 8 |
-        extract32(inst, 8, 1) << 10 |
-        extract32(inst, 7, 1) << 6 |
-        extract32(inst, 6, 1) << 7 |
-        extract32(inst, 3, 3) << 1 |
-        extract32(inst, 2, 1) << 5;
-}
-
-static int32_t operand_cimmb(rv_inst inst)
-{
-    return sextract32(inst, 12, 1) << 8 |
-        extract32(inst, 10, 2) << 3 |
-        extract32(inst, 5, 2) << 6 |
-        extract32(inst, 3, 2) << 1 |
-        extract32(inst, 2, 1) << 5;
-}
-
-static uint32_t operand_cimmswsp(rv_inst inst)
-{
-    return extract32(inst, 9, 4) << 2 |
-        extract32(inst, 7, 2) << 6;
-}
-
-static uint32_t operand_cimmsdsp(rv_inst inst)
-{
-    return extract32(inst, 10, 3) << 3 |
-        extract32(inst, 7, 3) << 6;
-}
-
-static uint32_t operand_cimmsqsp(rv_inst inst)
-{
-    return extract32(inst, 11, 2) << 4 |
-        extract32(inst, 7, 4) << 6;
-}
-
-static uint32_t operand_cimm4spn(rv_inst inst)
-{
-    return extract32(inst, 11, 2) << 4 |
-        extract32(inst, 7, 4) << 6 |
-        extract32(inst, 6, 1) << 2 |
-        extract32(inst, 5, 1) << 3;
-}
-
-static uint32_t operand_cimmw(rv_inst inst)
-{
-    return extract32(inst, 10, 3) << 3 |
-        extract32(inst, 6, 1) << 2 |
-        extract32(inst, 5, 1) << 6;
-}
-
-static uint32_t operand_cimmd(rv_inst inst)
-{
-    return extract32(inst, 10, 3) << 3 |
-        extract32(inst, 5, 2) << 6;
-}
-
-static uint32_t operand_cimmq(rv_inst inst)
-{
-    return extract32(inst, 11, 2) << 4 |
-        extract32(inst, 10, 1) << 8 |
-        extract32(inst, 5, 2) << 6;
-}
-
-static int32_t operand_vimm(rv_inst inst)
-{
-    return sextract32(inst, 15, 5);
-}
-
-static uint32_t operand_vuimm(rv_inst inst)
-{
-    return extract32(inst, 15, 5);
-}
-
-static uint32_t operand_vzimm11(rv_inst inst)
-{
-    return extract32(inst, 20, 11);
-}
-
-static uint32_t operand_vzimm10(rv_inst inst)
-{
-    return extract32(inst, 20, 10);
-}
-
-static uint32_t operand_vzimm6(rv_inst inst)
-{
-    return extract32(inst, 26, 1) << 5 |
-        extract32(inst, 15, 5);
-}
-
-static uint32_t operand_bs(rv_inst inst)
-{
-    return extract32(inst, 30, 2);
-}
-
-static uint32_t operand_rnum(rv_inst inst)
-{
-    return extract32(inst, 20, 4);
-}
-
-static uint32_t operand_vm(rv_inst inst)
-{
-    return extract32(inst, 25, 1);
-}
-
-static uint32_t operand_uimm_c_lb(rv_inst inst)
-{
-    return extract32(inst, 5, 1) << 1 |
-        extract32(inst, 6, 1);
-}
-
-static uint32_t operand_uimm_c_lh(rv_inst inst)
-{
-    return extract32(inst, 5, 1) << 1;
-}
-
-static uint32_t operand_zcmp_spimm(rv_inst inst)
-{
-    return extract32(inst, 2, 2) << 4;
-}
-
-static uint32_t operand_zcmp_rlist(rv_inst inst)
-{
-    return extract32(inst, 4, 4);
-}
-
-static uint32_t operand_imm6(rv_inst inst)
-{
-    return extract32(inst, 20, 6);
-}
-
-static uint32_t operand_imm2(rv_inst inst)
-{
-    return extract32(inst, 25, 2);
-}
-
-static uint32_t operand_immh(rv_inst inst)
-{
-    return extract32(inst, 26, 6);
-}
-
-static uint32_t operand_imml(rv_inst inst)
-{
-    return extract32(inst, 20, 6);
-}
-
-static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist, uint32_t spimm)
-{
-    int xlen_bytes_log2 = isa == rv64 ? 3 : 2;
-    int regs = rlist == 15 ? 13 : rlist - 3;
-    uint32_t stack_adj_base = ROUND_UP(regs << xlen_bytes_log2, 16);
-    return stack_adj_base + spimm;
-}
-
-static uint32_t operand_zcmp_stack_adj(rv_inst inst, rv_isa isa)
-{
-    return calculate_stack_adj(isa, operand_zcmp_rlist(inst),
-                               operand_zcmp_spimm(inst));
-}
-
-static uint32_t operand_tbl_index(rv_inst inst)
-{
-    return extract32(inst, 2, 8);
-}
-
-static uint32_t operand_lpl(rv_inst inst)
-{
-    return extract32(inst, 12, 20);
+    dec->op = op;
 }
 
 /* decode operands */
-- 
2.54.0


