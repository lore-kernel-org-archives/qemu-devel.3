Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD0AE7719A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4av-0001Tc-NA; Tue, 07 Jan 2025 03:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4ad-0000aJ-Bl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4aV-0003Py-Jk
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:05:27 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so229445625ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736237117; x=1736841917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CHFUnh0RBclR9IpQj61mNcDkRQ6jk2Qx+gwSgNjK0Rs=;
 b=QkbaNppJkimRkeZvX3ZKiqgJou8nABpi/J+np75HpyqPEb12mJtDR8gxtfTCCEbcW3
 TjO/7h/56jI+nEqXSaxNG1K+LyE7uN93sNFHjSerWlgyvv+0h84tLoV2ZJQ45CKIfIXy
 cabxvmksPK+aCXKCUvVUcU74qIBd+j718pSinUOT4ikarL1pmmLb9YY59yGmssQrFdOn
 xqqn8k2iw76vQswsDx4ko9Ls71kxqCK1coGzUySsnezev8rclmdHT8GTTX6xnXYQ1Kfj
 /4zUwDI3U1EW9f/By/39+QT6wFGgAmzWZLZGnhPBFfBl2zRUJNYkmFvnaHZgk9SsKCAn
 HeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736237117; x=1736841917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CHFUnh0RBclR9IpQj61mNcDkRQ6jk2Qx+gwSgNjK0Rs=;
 b=pImAkeGvMUodjWRENW/Z32FL5FNJL8n2yQIAgxiAwCshHMjgoIzrYLPFNFcYLD7mnU
 eJlTZ+kjrSuSabr4EJWZOeX5xV6o7uYuE1d/1xV7Ok7UVc7e8k+/CBD31KVe6kWc47DD
 KJA/MUBqQyeKaAaWKYFc94YjuCG/IJe1g4KB2Khb+8EzYW6xK0EAMz3RXy5Tnf+6pic9
 qExB1vVqtuRvgYyGYH5tSf3DMG/pka8L7LUoI0IhKgBRxBq8+m1B5F6Y0XT5WEqpQOjw
 TswnMluPEsXqVS4AYAta9FQb9UCiHNHI2AvQ4Gy71ogDHuwZ6gEl9y0RnAIxCtZ3z1Z9
 RhMA==
X-Gm-Message-State: AOJu0Yx3AjJRqjGHLL24cPUZfd/IsplE90hjM+rOoc74Ijd4STPxN/f6
 EotvkD7YSscAoN7uiSdBRE7VHXHb4AHBCjZskq+XtfE9ykHs37tA4EYnRjT+bfplA9Vuc++0UDO
 T
X-Gm-Gg: ASbGncv9tWulTwOePyJwDpEf3FOtUAe1l15WOY2owBzK8bIu9fZ0aP7qvTU7AxjECHd
 kQfCUVdiK+WqpbJ4HpwPHD+W0FJl7/eNKpgxFRJRiFREveIJ4YtPmzAltzxaWLjsH7ZfaIFsYyN
 svo+86DadDeeiRvjUCJpBmERHJkgQj6JUaeAZDZdcJtJf4thwqVkw8Od+FwI3XVj83ePjijhc88
 N9tohg1m1X70At0oYh7oht+EJRVcQJ3va+0K8IjqGeRJ7D7VgExz7RwonQrQZq1pXbO46fzI1zV
 Q06rM0Qbnqnx3sVvRA==
X-Google-Smtp-Source: AGHT+IETapbLaVw61f0YLfylXH517C3f7w/+g1YCPUJ81XYOV5IxVVx4x3elHQn9eL2n6a8etkqSVA==
X-Received: by 2002:a05:6300:6681:b0:1e1:a48f:1212 with SMTP id
 adf61e73a8af0-1e73746a7e2mr3708867637.4.1736237117188; 
 Tue, 07 Jan 2025 00:05:17 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84eb5dsm32577852b3a.86.2025.01.07.00.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:05:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 59/81] tcg: Merge INDEX_op_andc_{i32,i64}
Date: Tue,  7 Jan 2025 00:00:50 -0800
Message-ID: <20250107080112.1175095-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h          | 3 +--
 target/arm/tcg/translate-a64.c | 2 +-
 target/tricore/translate.c     | 2 +-
 tcg/optimize.c                 | 6 ++++--
 tcg/tcg-op.c                   | 8 ++++----
 tcg/tcg.c                      | 6 ++----
 tcg/tci.c                      | 5 ++---
 tcg/tci/tcg-target.c.inc       | 2 +-
 8 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index fda5181cf4..33c10cacf6 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -41,6 +41,7 @@ DEF(mov, 1, 1, 0, TCG_OPF_INT | TCG_OPF_NOT_PRESENT)
 
 DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
+DEF(andc, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -91,7 +92,6 @@ DEF(bswap16_i32, 1, 1, 1, 0)
 DEF(bswap32_i32, 1, 1, 1, 0)
 DEF(not_i32, 1, 1, 0, 0)
 DEF(neg_i32, 1, 1, 0, 0)
-DEF(andc_i32, 1, 2, 0, 0)
 DEF(orc_i32, 1, 2, 0, 0)
 DEF(eqv_i32, 1, 2, 0, 0)
 DEF(nand_i32, 1, 2, 0, 0)
@@ -149,7 +149,6 @@ DEF(bswap32_i64, 1, 1, 1, 0)
 DEF(bswap64_i64, 1, 1, 1, 0)
 DEF(not_i64, 1, 1, 0, 0)
 DEF(neg_i64, 1, 1, 0, 0)
-DEF(andc_i64, 1, 2, 0, 0)
 DEF(orc_i64, 1, 2, 0, 0)
 DEF(eqv_i64, 1, 2, 0, 0)
 DEF(nand_i64, 1, 2, 0, 0)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bd814849c1..ed606b25c8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8250,7 +8250,7 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     tcg_gen_subi_i32(tcg_t2, tcg_t0, 1);
 
     nzcv = a->nzcv;
-    has_andc = tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0);
+    has_andc = tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0);
     if (nzcv & 8) { /* N */
         tcg_gen_or_i32(cpu_NF, cpu_NF, tcg_t1);
     } else {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6819b77668..1f8b3e6d91 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3980,7 +3980,7 @@ static void decode_bit_andacc(DisasContext *ctx)
                     pos1, pos2, &tcg_gen_andc_tl, &tcg_gen_and_tl);
         break;
     case OPC2_32_BIT_AND_NOR_T:
-        if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
+        if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
             gen_bit_2op(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                         pos1, pos2, &tcg_gen_or_tl, &tcg_gen_andc_tl);
         } else {
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 465e29494a..3c9f74e4dd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -467,7 +467,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     CASE_OP_32_64(neg):
         return -x;
 
-    CASE_OP_32_64_VEC(andc):
+    case INDEX_op_andc:
+    case INDEX_op_andc_vec:
         return x & ~y;
 
     CASE_OP_32_64_VEC(orc):
@@ -2837,7 +2838,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_and_vec:
             done = fold_and(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(andc):
+        case INDEX_op_andc:
+        case INDEX_op_andc_vec:
             done = fold_andc(&ctx, op);
             break;
         CASE_OP_32_64(brcond):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 68818cbb0c..d87bd13375 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -668,8 +668,8 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_andc_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_andc_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_not_i32(t0, arg2);
@@ -2264,8 +2264,8 @@ void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_andc_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_andc_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
-    } else if (tcg_op_supported(INDEX_op_andc_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_andc_i64, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_not_i64(t0, arg2);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a037295710..52f0d55e31 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -993,8 +993,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     [0 ... NB_OPS - 1] = &outop_notreached,
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
-    OUTOP(INDEX_op_andc_i32, TCGOutOpBinary, outop_andc),
-    OUTOP(INDEX_op_andc_i64, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
 };
 
 #undef OUTOP
@@ -5426,8 +5425,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_add:
     case INDEX_op_and:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
+    case INDEX_op_andc:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 8d7fb385a5..b7023648ff 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -557,7 +557,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
-        CASE_32_64(andc)
+        case INDEX_op_andc:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & ~regs[r2];
             break;
@@ -1138,6 +1138,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
 
     case INDEX_op_add:
     case INDEX_op_and:
+    case INDEX_op_andc:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
@@ -1146,8 +1147,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-    case INDEX_op_andc_i32:
-    case INDEX_op_andc_i64:
     case INDEX_op_orc_i32:
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 3a4c65fcec..8575b94fb7 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -682,7 +682,7 @@ static const TCGOutOpBinary outop_and = {
 static void tgen_andc(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_andc_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_andc, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_andc = {
-- 
2.43.0


