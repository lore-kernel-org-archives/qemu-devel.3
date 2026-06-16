Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839ABCD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiF-0004g2-9J; Tue, 16 Jun 2026 06:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiE-0004eM-3E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:06 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQi9-0003Zo-JG
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:05 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c8585c51f1fso1922350a12.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604480; x=1782209280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PXnFZHopZftR9I1+ORxmZPXUGH/4V8C4QlkDG+My/vE=;
 b=rmebFsS/LMpIllHAzpmPqU8n15q4igxcEWB2sKTbENKjgWnekhiGh3AjIRuHedoqZ2
 Big6wNjfa8x02XTSquvEpP0XUTpGBqhwRv8FXNn7da/IVtEMnKwR2MB0Ix9KhyFJB3HE
 K7SY/VdvwOrvey8PzR2uVpReHVyiLaJodJ0iveQMAQYaTFITrfyFOT6DwZuQLpkjKwMR
 A0dpQS4I+hHqEPIjsvQ57EueIRfoclyXx1iqpjwo1WzdlH6yeHl9i2enwfr0xpW9Yj3b
 /C5CtvNtMYa629n/BToVs3Gd9uXiqVwMgu1YPpqYAGhZiXF6/ktrLlH0QmPO4rjQWYaV
 CK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604480; x=1782209280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PXnFZHopZftR9I1+ORxmZPXUGH/4V8C4QlkDG+My/vE=;
 b=pomNxJBwtajc+mVEuEgumBbo2wPs7ocQ1FhjTAEDtf5yYy7oI2YNxxcyBD+YHYR0Cy
 A9uaOFpc25pYI7AtU55DNPMifKDafC2r40A0OqmYF1WFRd7dbMCpJUmqnfO326mSqX+4
 3Rn3GLEYyIMKaJNgX4LleoBcOo37Wl450PKjlbtLIIpXOwEFSX1PFH7wKYE9nqrsD77B
 B5LbpkMZBbBuPyp4/uMmRZeJR9JZhlMxaBvxNzn2V217fq8rZNIheoJk1ptNlqhiJPwG
 0GNVRJmJrVV+f4dz554SsDyzPO0m8nYuYwdH9kKkm7iJPvQmu5psZE9ko1HRgnoonKYL
 ks8g==
X-Gm-Message-State: AOJu0YxwpFTaB8ckDulAi5jvh9gbyxhALNUwaHoRDNpRaQj2+VBKZqCt
 1nzF/1KzrnapWJ7EOu1/JV1ksGjivw5CS0FzkURUJbSPk7p764Pf4rjXYAJwtdt7
X-Gm-Gg: Acq92OEJ89HGq4cDKwIUr2FJjZs9e0FJFRbAnw9qh2owEwRV+ok3J0aijJdbFVqwRF7
 DWQKbIr1znACLzmbxNoZN7zNAk3wHkhE4TiGG1CuhuM1ERcy5NieFdrjJkAwBuBg8If5ytf7woP
 F2H4zAM4oiKjj+WlMhnP2uNS86gqhLOdSlnXw/w5Bh0Px251ZlCkiqWm/AUDOUloFDlcm0+7j8s
 P97SbUcCs+dQIHARnV4zibPWBWz+f5ZjAYlTJLh68SRuj5gpMH3+8L2kGNwB6q3DZwOCFp7cMQf
 oGj85EFGHbLQgzM/PH7xycpQs+NvblX9RSGg3DpAinIgu0ZtAjGlnx7gEUr7x1zqLic0whvXokJ
 7pEi5pLXb1SFeNAr5K5g3MuEDx4LzjTfkTrKvoa6YiVNwi1pNWPTTQqN8J4j6XfaV/XtV/YWKqg
 wNPdefcQwS3G4zMNCBeaWeSTO8oELkefWaZ6/dAkbf
X-Received: by 2002:a05:6a21:b84:b0:3b3:bf9c:7c3b with SMTP id
 adf61e73a8af0-3b7e2200a2fmr2719638637.8.1781604480109; 
 Tue, 16 Jun 2026 03:08:00 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:59 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 42/83] target/riscv: Initialize DisasContext::mo_endian once
Date: Tue, 16 Jun 2026 20:04:45 +1000
Message-ID: <20260616100527.1939565-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The data access endianness is constant during a translation
block; rather than calling the mo_endian() method each time,
initialize the DisasContext::mo_endianness field once in
TranslatorOps::init_disas_context().

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index 3132386801..5405db9ea5 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -121,6 +121,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* Data endianness from MSTATUS UBE/SBE/MBE */
+    MemOp mo_endianness;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -156,7 +158,7 @@ static inline MemOp mo_endian(DisasContext *ctx)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | (ctx)->mo_endianness)
 
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1159,7 +1161,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
 
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
@@ -1180,7 +1182,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
-    mop |= mo_endian(ctx);
+    mop |= ctx->mo_endianness;
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
@@ -1363,6 +1365,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
+    ctx->mo_endianness = mo_endian(ctx);
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 62c0fe673d..44c1696fe4 100644
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
index ffea0c2a1f..3b9a745520 100644
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
index 89fb0f604a..e935523c93 100644
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
index fea05d02cc..e47b16a7fa 100644
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
index 8d94b83ce9..79bca1e957 100644
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
index 0f307affec..79b0b2c63b 100644
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
index 0d3ba40e52..71b4ca5473 100644
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
index 791ee51f65..f36b46c211 100644
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
index cb9c5419fa..a813232887 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -113,7 +113,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -143,7 +143,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    memop |= mo_endian(ctx);
+    memop |= ctx->mo_endianness;
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_trans/trans_xmips.c.inc
index c1a30156d3..1b9993a9b0 100644
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
index f8b95c6498..f4e3051000 100644
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
index f50c52f22c..8068cc1aec 100644
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
2.54.0


