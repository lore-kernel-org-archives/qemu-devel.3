Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BE7C5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKh-0002E9-RQ; Mon, 19 Aug 2024 20:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKT-000131-Gi
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKB-0001Du-Nl
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fee6435a34so30549575ad.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112110; x=1724716910;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPTf989pad3/FoSSLbYI6Bf0KGJN472MbzEtYRTcWJU=;
 b=3OQKwTj2e66/KxOuPoNbVEssFsPvXXSHwnoXj7+GTnxf4AeOLBhtFoqcGmEKvE+1jr
 ovKkXBQQQhI2MHQCd/4dOdhqU/u8VqAP2dnYbkR5h+3TK+mzLs7oNw8d3bDZlubyow25
 SybOY71Yeu+bGYyINeOEo4ui0WdQ1+277R7oXTYl7VhmMQ/Z+Hm7OJDUuyfOoscNhbfo
 eIahXVAS5ElRMz/yXGmDExeg9rnqL1caNy5wYJglOD+FoPHHyZyHysma1Y0hfPz38b6Y
 gkTRyGZ3T/lZtgcUnfWhbxuyoXUd1N0JPdtw3yXFQThb32amFxE6iXWyXSrnAlVUlxmi
 tUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112110; x=1724716910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WPTf989pad3/FoSSLbYI6Bf0KGJN472MbzEtYRTcWJU=;
 b=jeHnc1AiAeiLVTJqMngQMfRsBVLF/1EG7GsdrSxCLCCjuQuC9UtrqwKQpH5/k+u/d0
 hSMoDwcrNa79xlC1skmDmlh2hqoaQw+5l1jYgvyUvCO+Mwca0Zv22lcUHrP4u4GPSCrd
 LiqP0zL0O/3XJvP3t+auoi+g27RNcuyjwjrCQ5WAvtKv2HYYa2nBKe5PZwyqss8gumR7
 hVs+G6h/TGszp5wnVQgWFx6WSCQHk7XGrKW5KavSOMTGP4Qn6tGXN1Dm6A7QTCiHyb9i
 C3rxGmGG2ff69le52rqbYRkHPqsz/xBUFOWXGZEb2eMh+y7lwWmeHubPPPA37SwOjkbB
 RVYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYuvoJuAvzt3bg+RHUXDt7UNdS9WjtMuXzAY3EPR3buVqKVROYsbLBWnTj6FIk7VxDMwOY8lvKofD/@nongnu.org
X-Gm-Message-State: AOJu0Yx3D5JM2VkrQ3RddMCkvtePR4TH7worL8OzYYcNXO6KMgYGofUz
 cg8Gz6uob2ibn+2tzsrukSnewkZAfAZZY4/9bDWPxeB9qvhnCpIRez+ez2jHrpM=
X-Google-Smtp-Source: AGHT+IFbL20ZkOAmWbwGsOuZngNerulJ9YKp2UnZjpGN72xSFsf0sqEQCvDrazn2M+TPco+S2jWEoA==
X-Received: by 2002:a17:903:247:b0:201:ec02:2780 with SMTP id
 d9443c01a7336-20203e53202mr135545725ad.5.1724112110022; 
 Mon, 19 Aug 2024 17:01:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v5 12/15] target/riscv: implement zicfiss instructions
Date: Mon, 19 Aug 2024 17:01:26 -0700
Message-ID: <20240820000129.3522346-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

zicfiss has following instructions
 - sspopchk: pops a value from shadow stack and compares with x1/x5.
   If they dont match, reports a sw check exception with tval = 3.
 - sspush: pushes value in x1/x5 on shadow stack
 - ssrdp: reads current shadow stack
 - ssamoswap: swaps contents of shadow stack atomically

sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=0

If SSE=0, ssamoswap is illegal instruction exception.

This patch implements shadow stack operations for qemu-user and shadow
stack is not protected.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 target/riscv/cpu_bits.h                       |  2 +
 target/riscv/insn32.decode                    | 21 +++++-
 target/riscv/insn_trans/trans_rva.c.inc       | 41 +++++++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 73 +++++++++++++++++++
 target/riscv/translate.c                      |  5 ++
 5 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 48ce24dc32..bb62fbe9ec 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -690,6 +690,8 @@ typedef enum RISCVException {
 
 /* zicfilp defines lp violation results in sw check with tval = 2*/
 #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
+/* zicfiss defines ss violation results in sw check with tval = 3*/
+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
 
 #define RISCV_EXCP_INT_FLAG                0x80000000
 #define RISCV_EXCP_INT_MASK                0x7fffffff
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6533cb0758..676a7ea98e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -246,6 +246,7 @@ remud    0000001 .....  ..... 111 ..... 1111011 @r
 lr_w       00010 . . 00000 ..... 010 ..... 0101111 @atom_ld
 sc_w       00011 . . ..... ..... 010 ..... 0101111 @atom_st
 amoswap_w  00001 . . ..... ..... 010 ..... 0101111 @atom_st
+ssamoswap_w 01001 . . ..... ..... 010 ..... 0101111 @atom_st
 amoadd_w   00000 . . ..... ..... 010 ..... 0101111 @atom_st
 amoxor_w   00100 . . ..... ..... 010 ..... 0101111 @atom_st
 amoand_w   01100 . . ..... ..... 010 ..... 0101111 @atom_st
@@ -259,6 +260,7 @@ amomaxu_w  11100 . . ..... ..... 010 ..... 0101111 @atom_st
 lr_d       00010 . . 00000 ..... 011 ..... 0101111 @atom_ld
 sc_d       00011 . . ..... ..... 011 ..... 0101111 @atom_st
 amoswap_d  00001 . . ..... ..... 011 ..... 0101111 @atom_st
+ssamoswap_d 01001 . . ..... ..... 011 ..... 0101111 @atom_st
 amoadd_d   00000 . . ..... ..... 011 ..... 0101111 @atom_st
 amoxor_d   00100 . . ..... ..... 011 ..... 0101111 @atom_st
 amoand_d   01100 . . ..... ..... 011 ..... 0101111 @atom_st
@@ -1022,8 +1024,23 @@ amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 
 # *** Zimop may-be-operation extension ***
-mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
-mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+{
+  # zicfiss instructions carved out of mop.r
+  [
+    ssrdp     1100110 11100 00000 100 rd:5 1110011
+    sspopchk  1100110 11100 00001 100 00000 1110011 &r2 rs1=1 rd=0
+    sspopchk  1100110 11100 00101 100 00000 1110011 &r2 rs1=5 rd=0
+  ]
+  mop_r_n    1 . 00 .. 0111 .. ..... 100 ..... 1110011 @mop5
+}
+{
+  # zicfiss instruction carved out of mop.rr
+  [
+    sspush    1100111 00001  00000 100 00000 1110011 &r2_s rs2=1 rs1=0
+    sspush    1100111 00101  00000 100 00000 1110011 &r2_s rs2=5 rs1=0
+  ]
+  mop_rr_n   1 . 00 .. 1 ..... ..... 100 ..... 1110011 @mop3
+}
 
 # *** Zabhb Standard Extension ***
 amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 39bbf60f3c..a2d9c186fd 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -18,6 +18,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "exec/memop.h"
+
 #define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
     if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
         return false;                                     \
@@ -114,6 +116,25 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
 }
 
+static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_A_OR_ZAAMO(ctx);
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESL));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
 {
     REQUIRE_A_OR_ZAAMO(ctx);
@@ -183,6 +204,26 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
     return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
 }
 
+static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_A_OR_ZAAMO(ctx);
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESQ));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static bool trans_amoadd_d(DisasContext *ctx, arg_amoadd_d *a)
 {
     REQUIRE_64BIT(ctx);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
new file mode 100644
index 0000000000..bbe52ee648
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -0,0 +1,73 @@
+/*
+ * RISC-V translation routines for the Control-Flow Integrity Extension
+ *
+ * Copyright (c) 2024 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
+{
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv addr = tcg_temp_new();
+    TCGLabel *skip = gen_new_label();
+    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
+    TCGv data = tcg_temp_new();
+    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_qemu_ld_tl(data, addr, SS_MMU_INDEX(ctx),
+                       mxl_memop(ctx) | MO_ALIGN);
+    TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
+    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
+    tcg_gen_st_tl(tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL),
+                  tcg_env, offsetof(CPURISCVState, sw_check_code));
+    gen_helper_raise_exception(tcg_env,
+                  tcg_constant_i32(RISCV_EXCP_SW_CHECK));
+    gen_set_label(skip);
+    tcg_gen_addi_tl(addr, addr, tmp);
+    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+
+    return true;
+}
+
+static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
+{
+    if (!ctx->bcfi_enabled) {
+        return false;
+    }
+
+    TCGv addr = tcg_temp_new();
+    int tmp = (get_xl(ctx) == MXL_RV64) ? -8 : -4;
+    TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
+    tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+    tcg_gen_addi_tl(addr, addr, tmp);
+    tcg_gen_qemu_st_tl(data, addr, SS_MMU_INDEX(ctx),
+                       mxl_memop(ctx) | MO_ALIGN);
+    tcg_gen_st_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));
+
+    return true;
+}
+
+static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a)
+{
+    if (!ctx->bcfi_enabled || a->rd == 0) {
+        return false;
+    }
+
+    TCGv dest = tcg_temp_new();
+    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    gen_set_gpr(ctx, a->rd, dest);
+
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 42dc8d3600..cc427c00ac 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -144,6 +144,8 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
+
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
 {
@@ -1126,6 +1128,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     return translator_ldl(env, &ctx->base, pc);
 }
 
+#define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.c.inc"
 #include "insn_trans/trans_rvm.c.inc"
@@ -1156,6 +1160,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
 #include "insn_trans/trans_rvzcmop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
-- 
2.44.0


