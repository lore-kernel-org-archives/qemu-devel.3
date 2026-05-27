Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A43CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSKdi-00063j-E6; Wed, 27 May 2026 16:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdg-00062b-2g
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSKdd-00054C-6g
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:14:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso57742355e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779912839; x=1780517639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbZDU+VsyaWTWWF5avuwtLUIRzR/V2SulJj+2x8w4LM=;
 b=Dk+OKNuiBItdhnjpiwheaEVeuOlhLNG5HEjdME3vcbJYtqkbnYBaxKN5H3LQtmY8eM
 F8O/YKBZcGHr+JOwBjCycR+y5+ZWXuZWbrD69/bJT4W/K2ddjzKbvPSTAEdM6X3//cjg
 ExwDUvSxJhPsTyHHseJA9V+kZU6+xuXk+iscIND3eeSoejL2Ad/rGd63Is/mLHOeqIzf
 aV64BgAG+L79T+3K0okrzILvZ/CAljtt/Wv1a2VMJhemIeX/SR4ipqf2zYxTUssUyNTf
 k4x5VGnNocsEtua1ceIHWgQmxFqpItVAMyG8ul5pF+wZzngMcZEodE3JWknANfrZDSYz
 xpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912839; x=1780517639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UbZDU+VsyaWTWWF5avuwtLUIRzR/V2SulJj+2x8w4LM=;
 b=af+qWlSMAiRFXWz/mEYhrURNZEThwMrhJldlXIXp2QTN71KULkG3XcdW2AxAuZeu+N
 enY4h+TYhmEcLmdhlHPcoXuJoXiOgQslN49WBpdExLlm02uBU5qnseUh6vzzu8aYeYE4
 RrHtaN+VppZ8Bp2waa2W3pjJKR2UXlwDfSggBF7kvWqHvbVL2yaCRNX7iD/PFkPQPOyg
 qmoHYkISfPg8JKLiNnThddqOMj/3kZISG3I1moGJFxSGfQWk5dMhVN6aI8sjI6fiAdl3
 UNjXloyV+pKHf4Y7o5MsTc7ggPR3t0dUN33DHTru5jDfKaYL+X/grJS+J7Hc1YBg6i76
 +vBQ==
X-Gm-Message-State: AOJu0YxsyPHhAu5b1to8xVziQNdZOX6uiZ+SoPF2n0lokUgZoZgF+Bnf
 PQe+wdwRTfPPEBdhzKb07GMqkOAS9vrRXpjRhB0H4lY+Yr9y+XzOp0bm9u7kD+Q6WW4TqgRawJN
 x8cekH94Q7g==
X-Gm-Gg: Acq92OHJmPoh3gWY5Tx1Fe2pnTVA3Z2Y68kG1tPwYSOiOyStNj2be5ePJ6GfmSdc+i/
 z9RJX/6MSWEkUYG2xK2L4Lh4nct8fybVjWyYsDjLrP3DQyi50lt19YEKzJMEn2xmnCZtcAOjNNo
 EfDdHZi3N+e9iR+V1Jnfvv0UpLAHwp25cOrmtNywi4O3QM9xbwv9Wmio88GZ9Jb1zTKz1VQA3qo
 qQOg1S+SkmVUr95tPO5SENIv5QKzeFIbFFOleb32FXIJhHdorpXJ4LeMWaHsL3y7JDZ6sMchYxZ
 CD4YVVP8tQSZXa6wGJScez9H0ooBtfExGNBixVs/U4cKXM3/UErFRdMTZe/WeMVmaCJxzlDO105
 S+hESiq5A/LTZp8/EVZhFTqRG6XNVyvvcArok19RJE4MZEG5u+N6svCaHehtJ9OQiyyExI99nIj
 qaefAe7T8E1gdYuwqDK8GdD5sE/QsAba1kMg7h/wr+x2Us9ZFaghcBCdrfLQ+vPzgI3Q==
X-Received: by 2002:a05:600c:4e4b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-49069da61c3mr211843245e9.21.1779912838916; 
 Wed, 27 May 2026 13:13:58 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a296bsm8008488f8f.21.2026.05.27.13.13.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 13:13:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>
Subject: [PATCH v11 01/12] target/riscv: Initialize DisasContext::mo_endian
 once
Date: Wed, 27 May 2026 22:13:37 +0200
Message-ID: <20260527201348.29511-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527201348.29511-1-philmd@linaro.org>
References: <20260527201348.29511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

The data access endianness is constant during a translation
block; rather than calling the mo_endian() method each time,
initialize the DisasContext::mo_endianness field once in
TranslatorOps::init_disas_context().

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c                      |  9 ++++++---
 target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       |  8 ++++----
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
 target/riscv/insn_trans/trans_rvzalasr.c.inc  |  4 ++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
 target/riscv/insn_trans/trans_xmips.c.inc     |  8 ++++----
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
 target/riscv/insn_trans/trans_zilsd.c.inc     |  4 ++--
 13 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1e4f3402569..9367f159f90 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -120,6 +120,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    MemOp mo_endianness;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -155,7 +157,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
 
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1156,7 +1158,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
 
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
@@ -1177,7 +1179,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
@@ -1360,6 +1362,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
+    ctx->mo_endianness = mo_endian(ctx);
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 62c0fe673d7..44c1696fe4d 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1;
 
     mop |= MO_ALIGN;
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
 
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
@@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l2 = gen_new_label();
 
     mop |= MO_ALIGN;
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
 
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index ffea0c2a1f9..3b9a745520a 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 89fb0f604ad..e935523c93c 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2c82ae41a77..2de74fac3a8 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -392,7 +392,7 @@ static bool gen_load_i128(DisasContext *ctx, arg_lb *a, MemOp memop)
         }
     } else {
         tcg_gen_qemu_ld_i128(t16, addrl, ctx->mem_idx, memop);
-        if (mo_endian(ctx) == MO_LE) {
+        if (ctx->mo_endianness == MO_LE) {
             tcg_gen_extr_i128_i64(tl, th, t16);
         } else {
             tcg_gen_extr_i128_i64(th, tl, t16);
@@ -409,7 +409,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -508,7 +508,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
         tcg_gen_ext_tl_i64(tl, src2l);
         tcg_gen_ext_tl_i64(th, src2h);
 
-        if (mo_endian(ctx) == MO_LE) {
+        if (ctx->mo_endianness == MO_LE) {
             tcg_gen_concat_i64_i128(t16, tl, th);
         } else {
             tcg_gen_concat_i64_i128(t16, th, tl);
@@ -520,7 +520,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 8d94b83ce94..79bca1e9572 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
 
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
 
@@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
     MemOp memop = MO_ALIGN | MO_UO;
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
diff --git a/target/riscv/insn_trans/trans_rvzalasr.c.inc b/target/riscv/insn_trans/trans_rvzalasr.c.inc
index 0f307affecf..79b0b2c63b8 100644
--- a/target/riscv/insn_trans/trans_rvzalasr.c.inc
+++ b/target/riscv/insn_trans/trans_rvzalasr.c.inc
@@ -29,7 +29,7 @@ static bool gen_load_acquire(DisasContext *ctx, arg_lb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | mo_endian(ctx);
+    memop |= MO_ALIGN | ctx->mo_endianness;
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, memop);
@@ -79,7 +79,7 @@ static bool gen_store_release(DisasContext *ctx, arg_sb_aqrl *a, MemOp memop)
         return false;
     }
 
-    memop |= MO_ALIGN | mo_endian(ctx);
+    memop |= MO_ALIGN | ctx->mo_endianness;
     memop |= (ctx->cfg_ptr->ext_zama16b) ? MO_ATOM_WITHIN16 : 0;
 
     /* Add a memory barrier implied by RL (mandatory) and AQ (optional) */
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 0d3ba40e52a..71b4ca5473c 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
 
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest = dest_gpr(ctx, i);
@@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
 
     tcg_gen_subi_tl(addr, sp, reg_size);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val = get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 791ee51f652..f36b46c2118 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 0b6ad57965c..43f586dce97 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index c1a30156d36..1b9993a9b07 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -47,7 +47,7 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
 /* Load Doubleword Pair. */
 static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 {
-    MemOp memop = MO_SQ | mo_endian(ctx);
+    MemOp memop = MO_SQ | ctx->mo_endianness;
 
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -71,7 +71,7 @@ static bool trans_ldp(DisasContext *ctx, arg_ldp *a)
 /* Load Word Pair. */
 static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 {
-    MemOp memop = MO_SL | mo_endian(ctx);
+    MemOp memop = MO_SL | ctx->mo_endianness;
 
     REQUIRE_XMIPSLSP(ctx);
 
@@ -94,7 +94,7 @@ static bool trans_lwp(DisasContext *ctx, arg_lwp *a)
 /* Store Doubleword Pair. */
 static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 {
-    MemOp memop = MO_UQ | mo_endian(ctx);
+    MemOp memop = MO_UQ | ctx->mo_endianness;
 
     REQUIRE_XMIPSLSP(ctx);
     REQUIRE_64_OR_128BIT(ctx);
@@ -116,7 +116,7 @@ static bool trans_sdp(DisasContext *ctx, arg_sdp *a)
 /* Store Word Pair. */
 static bool trans_swp(DisasContext *ctx, arg_swp *a)
 {
-    MemOp memop = MO_SL | mo_endian(ctx);
+    MemOp memop = MO_SL | ctx->mo_endianness;
 
     REQUIRE_XMIPSLSP(ctx);
 
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index f8b95c6498b..f4e30510007 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) == MO_32) {
         gen_nanbox_s(rd, rd);
@@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
 
     return true;
@@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
 
@@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
 
     return true;
@@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
diff --git a/target/riscv/insn_trans/trans_zilsd.c.inc b/target/riscv/insn_trans/trans_zilsd.c.inc
index f50c52f22c9..8068cc1aec4 100644
--- a/target/riscv/insn_trans/trans_zilsd.c.inc
+++ b/target/riscv/insn_trans/trans_zilsd.c.inc
@@ -30,7 +30,7 @@ static bool gen_load_i64(DisasContext *ctx, arg_ld *a)
     TCGv addr = get_address(ctx, a->rs1, a->imm);
     TCGv_i64 tmp = tcg_temp_new_i64();
 
-    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_ld_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endianness);
 
     if (a->rd == 0) {
         return true;
@@ -85,7 +85,7 @@ static bool gen_store_i64(DisasContext *ctx, arg_sd *a)
     } else {
         tcg_gen_concat_tl_i64(tmp, data_low, data_high);
     }
-    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | mo_endian(ctx));
+    tcg_gen_qemu_st_i64(tmp, addr, ctx->mem_idx, MO_SQ | ctx->mo_endianness);
 
     return true;
 }
-- 
2.53.0


