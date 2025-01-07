Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A12E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4bI-00031M-On; Tue, 07 Jan 2025 03:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aj-0000kn-E6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:35 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aZ-0003TW-V6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:33 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165cb60719so225494505ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237122; x=1736841922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqI39TuDqE4vQdnfHNeM4g2zaOgoY6Dj8Hx1jpjCZw8=;
 b=SRHEd0SXlkfcXu1wGK7yOtWYwlO6nsHSiOK8Et8AWUYCXMWjsWg7TnybQYM1LApn0J
 uSJnb8ZpSkZmVpLR278u1Oc7mQfl2nC2kr0qn9zTIlok1GNRYk5SyvaB4TJc/wD3dDmZ
 ojKWTSR4eLjeRpO1evdG0+qVvXq5bCu2eeJ1sL90G7eRrQvtfStJTCQk4eL9575ZP0iM
 Xdxe5ZP3s3iTlibS/Sbr6OzPGeWi7t5eNtYCCllJ9qFOVD8UV3p+6goa2aYpdLfEwN5O
 X84PNiot/nTaTOIffdtobvp2JO7XCjcQhS4xMV7DWd5l9y0ZpnIsILV+d6asftV8ybav
 tdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237122; x=1736841922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqI39TuDqE4vQdnfHNeM4g2zaOgoY6Dj8Hx1jpjCZw8=;
 b=KuHrYTPd8jkauWrsj+unbfNl8DCKDmhdzOQ3G9p7bxQBytzIA/OxmcGtyzqG07J04g
 OUUNFRe63DB3s0128ANHHxaeWy+Uwv2zlAp4OJ4RGO01dxNkVng2oWa2kIxXam6hPhd1
 ApSYl1BYVhz8nT3OM8YVLKADUOykLfQI5FDYXX9S5X0SXqH5t9b1WeH1op0ffPUlBEWX
 h58NhuoEItQNH+OI3iplGYtvHqL6Z8CPu5MqFHEw8gYAneSnx7rzBpNPk4F2MyZ6v7YO
 WGkk+yc2lqUTJoSdbVouk3fLVS2GjfTXz5Y87lzIV1Le8yaCTgtTLID40iEcUHjvFz06
 94nQ==
X-Gm-Message-State: AOJu0YyjwIfsH5cwqf1Yna23Evua1SWFyJIFPrNLWNjauvFuulqqu1x+
 3tK1qi3AHqdyZIfobgfPGF8CvRhVycX0umUSCnLMTcSjBKQz8HT/f4m5D6IUcq/lIciXTHGJL/p
 D
X-Gm-Gg: ASbGnctAD0rfxpzHGpverjTo+JUxoxxkn8zgsT8t0sZP6ql245v1zKj9dU/5IqAuyab
 mtXQL4ZloUr4X3FTMbgAkLdvTUMfSnLrRgJHtlproxnFP2eKY49xfhix3UYbnRzD5c5gz9SMcYp
 gVX6g1dteXnMzxmWAYrmHkGPvl83Z/ZpoF2gBGNVlJbsvxe+bm2WNhGdpkF7XerFcnUZtQem+W7
 BRi8m94A2keoNbQmcguK+DR93hT206nz24wQTHUZzwgVqKAc+8Fi0eACiWOmNDwoLZPVG12rtp+
 pyHd5h88wuYjaoBWxA==
X-Google-Smtp-Source: AGHT+IGJaJzBW2gacUl8oAr2RwgDeZ91eAvuE0SrcjjhKFno700zkhiVOU6nw/Bq+TBxh8iCtdH4iQ==
X-Received: by 2002:a05:6a00:4096:b0:729:c7b:9385 with SMTP id
 d2e1a72fcca58-72abdd7bdecmr90528957b3a.6.1736237122520; 
 Tue, 07 Jan 2025 00:05:22 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 64/81] tcg: Merge INDEX_op_orc_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:55 -0800
Message-ID: <20250107080112.1175095-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h          | 3 +--
 target/arm/tcg/translate-sve.c | 2 +-
 target/tricore/translate.c     | 2 +-
 tcg/optimize.c                 | 6 ++++--
 tcg/tcg-op.c                   | 8 ++++----
 tcg/tcg.c                      | 6 ++----
 tcg/tci.c                      | 5 ++---
 tcg/tci/tcg-target.c.inc       | 2 +-
 8 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index f3321822f2..bd9fa7a35e 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
+DEF(orc, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -92,7 +93,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(orc_i32, 1, 2, 0, 0)
 DEF(eqv_i32, 1, 2, 0, 0)
 DEF(nand_i32, 1, 2, 0, 0)
 DEF(nor_i32, 1, 2, 0, 0)
@@ -148,7 +148,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(orc_i64, 1, 2, 0, 0)
 DEF(eqv_i64, 1, 2, 0, 0)
 DEF(nand_i64, 1, 2, 0, 0)
 DEF(nor_i64, 1, 2, 0, 0)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e303196592..5d8a6d554f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -622,7 +622,7 @@ static void gen_bsl2n_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m, TCGv_i64 k)
      *       =         | ~(m | k)
      */
     tcg_gen_and_i64(n, n, k);
-    if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
         tcg_gen_or_i64(m, m, k);
         tcg_gen_orc_i64(d, n, m);
     } else {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1f8b3e6d91..5ae685cc5b 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -4113,7 +4113,7 @@ static void decode_bit_orand(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_or_tl);
         break;
     case OPC2_32_BIT_OR_NOR_T:
-        if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_orc_tl);
         } else {
diff --git a/tcg/optimize.c b/tcg/optimize.c
index b0e7457eb0..39b72e8738 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -472,7 +472,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_andc_vec:
         return x & ~y;
 
-    CASE_OP_32_64_VEC(orc):
+    case INDEX_op_orc:
+    case INDEX_op_orc_vec:
         return x | ~y;
 
     CASE_OP_32_64_VEC(eqv):
@@ -2972,7 +2973,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_or_vec:
             done = fold_or(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(orc):
+        case INDEX_op_orc:
+        case INDEX_op_orc_vec:
             done = fold_orc(&ctx, op);
             break;
         case INDEX_op_qemu_ld_a32_i32:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 503d395ac8..bf481060fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -710,8 +710,8 @@ void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_orc_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_not_i32(t0, arg2);
@@ -2318,8 +2318,8 @@ void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_orc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_orc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_orc_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_not_i64(t0, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 672e8ce40e..1d043254dd 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -995,8 +995,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
-    OUTOP(INDEX_op_orc_i32, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_orc_i64, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
 };
 
 #undef OUTOP
@@ -5425,8 +5424,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
+    case INDEX_op_orc:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 9f31af67b1..97d86c8348 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -561,7 +561,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
-        CASE_32_64(orc)
+        case INDEX_op_orc:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | ~regs[r2];
             break;
@@ -1138,14 +1138,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_or:
+    case INDEX_op_orc:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_orc_i32:
-    case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 7ad0d44b82..c1d975cb0b 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -700,7 +700,7 @@ static const TCGOutOpBinary outop_or = {
 static void tgen_orc(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_orc_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_orc, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_orc = {
-- 
2.43.0


