Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B1DCA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4na-0001if-CC; Fri, 30 Aug 2024 12:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nX-0001ZR-U6
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:31 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nT-000711-8P
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:31 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d3c098792bso1547986a91.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036506; x=1725641306;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfMI0HVMe/9WD3eJ9OSyAXv9CNL2x4woRUtuakjh8IU=;
 b=umGGogUSKNywNIckFQ3VkqHijwNWX80t8Phy3NTzLoyZ/hlI4/2WgKXF2cyCoZnBSy
 DFiDnIZtYcIA6iNObKdyxlT8Qe/vGch75kcYlEVsINDn0fVjov7vQNTFPPbVsp+ffEhc
 bRuBMVRIwcTDBqbN5w1Zmvctfs6aQHqIuSEbzG1PUo5hKdKfuv7ArTCyk8riBYZbx7h4
 q8YIRyO7MLXTUM/hiKQh76S/KQPWAkyLztFZ9S9f7Z/fmeWbzhxJB6e967G/u1dModCc
 7aWZJNV5Uan6Q6bLsrWuhpCdMkfwNUusymyTGHcKGxyeNnUCdD3cUR8G5h12699SwdCM
 DBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036506; x=1725641306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfMI0HVMe/9WD3eJ9OSyAXv9CNL2x4woRUtuakjh8IU=;
 b=DxLcYoFr055QhgKbS1ModsR6iQYgoWwcrKuk0QhrS34+IKbtxwzgf7clc0KGIDu9BN
 gcdHrUkwTyu0v5NDPY5jWmY8lrHXE5HXhIeVtXIQXlVe+1kHrJU1vOOr37inXWAo6rPc
 BPkTv/Yg/7T1jHeIjXdfPZnH37GOgTFFqIj2f2gLPqAnfAddxVzyoQYFJk6sSnWx2oZl
 x9wwNfE6B5gRXCzI8qRmRhwgMalYBdGh70DvCJLVY5UUxaznq5di5kAR8RurOVtvYZeC
 ftSkQQwAyUw/R62i15rdyw3Oe4wk9niDU7vqkkNyF+JrJiac5eKq4XnHYdFvB1J3Tq+3
 92sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVquiXAwBRE90EiRUy9PQx5WPdwHStQMFf8yDNmIkz5GPbHMnJdkodtIALA1fY8B5l35PmqR2xpEcrG@nongnu.org
X-Gm-Message-State: AOJu0YwwjfqgQSgcMk7Sf4i5DxYv+dNsU5yWCauWyKOEpjFAUiyqORyL
 DiDtCokboMDH+liePBc8hMr/GeXwQsFn10I5v7dfNdXUPnOdJj4th6JeibF+kQk=
X-Google-Smtp-Source: AGHT+IHIzyPo70s+YbrRsvNEXMhQI01Sg2IdyD6c/0oe7E2WiWDMff4v+IKuUSZJfsdj/VjlJRef9Q==
X-Received: by 2002:a17:90b:224e:b0:2cb:55f9:b7c5 with SMTP id
 98e67ed59e1d1-2d8561a1482mr7372318a91.12.1725036505581; 
 Fri, 30 Aug 2024 09:48:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 16/20] target/riscv: implement zicfiss instructions
Date: Fri, 30 Aug 2024 09:47:52 -0700
Message-ID: <20240830164756.1154517-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_bits.h                       |   2 +
 target/riscv/insn32.decode                    |  21 +++-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 ++++++++++++++++++
 target/riscv/translate.c                      |   5 +
 4 files changed, 140 insertions(+), 2 deletions(-)
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
index 27108b992b..e9139ec1b9 100644
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
+    ssrdp     1100110 11100 00000 100 rd:5  1110011
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
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
new file mode 100644
index 0000000000..e3ebc4977c
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -0,0 +1,114 @@
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
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
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
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
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
+    TCGv dest = dest_gpr(ctx, a->rd);
+    tcg_gen_ld_tl(dest, tcg_env, offsetof(CPURISCVState, ssp));
+    gen_set_gpr(ctx, a->rd, dest);
+
+    return true;
+}
+
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
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESL));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
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
+    decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
+    src1 = get_address(ctx, a->rs1, 0);
+
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
+                           (MO_ALIGN | MO_TESQ));
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0ca10818f3..bccaf8e89a 100644
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
@@ -1127,6 +1129,8 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     return translator_ldl(env, &ctx->base, pc);
 }
 
+#define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.c.inc"
 #include "insn_trans/trans_rvm.c.inc"
@@ -1157,6 +1161,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "decode-insn16.c.inc"
 #include "insn_trans/trans_rvzce.c.inc"
 #include "insn_trans/trans_rvzcmop.c.inc"
+#include "insn_trans/trans_rvzicfiss.c.inc"
 
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
-- 
2.44.0


