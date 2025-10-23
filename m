Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6212CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54Z-0004KR-9v; Thu, 23 Oct 2025 19:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54X-0004G8-Dg
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54V-0007OU-33
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-290b48e09a7so17500535ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263415; x=1761868215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtZNpnlw4+L5jAKmRWNcn/XGLeOEOfDtLm9V40+Oe64=;
 b=j+oph1KdkGcVLWoUUvnAGd4UgkMxBg2LGSDeayr4RRkBVLFd999hvH/cc8u9nfu+9n
 RDQtVonA4xQ9bVi5viqPluRxgkxDqvgFdSwkinKW4lslPxjqvhbmQw+Oec/s9nnSkvPa
 TP16aFt93UdD62uL3ryevo+lqZC7wrrfLG2mOLXDEYnQ/M3yLhVogCbFuXdzP5MLo2qA
 B1WUKqh2EMJMB7VW8ivtBKiZhPAl53mNCnatXqLaV9I1yt0ctH6sxrl72KurmpMtLVu8
 dPsJ1ti4jiWRxqOZWQvC6+/CbAlXy3sW6dCyyLouDcBcTb7t88Lp/mwHNxVcTWsUeZux
 QXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263415; x=1761868215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtZNpnlw4+L5jAKmRWNcn/XGLeOEOfDtLm9V40+Oe64=;
 b=iGeTEHpGsdC4oVri+Hewmu1BkcS5RLsssYu2FOsaBOVRPAeXWICwJGU+uFfT6TJ6qo
 paPK9LupOANJLhwsvN+P3OCNh+V07uoNRRH+4R9BgB0KgCAm82Bt05zZkQsPWH503n7y
 So+ivDNG4iH3xcmBfVusgU59O6u5qJfcp7UdbZSAz9bMM5I10VO98DP/JfTsqPDB1ZZY
 znWcYUntXAEa4zL8tIcAR2ZXJBVGPh5Xn/9HziQrpMrhZWIPi1nPEuEkIpuX7rCK6CAH
 /LqtC7be0ufqzrlT8P0gSHgvxUF425R6WZlp7WvI433i9P/2E0JR0fjDYBLGQrt35mSv
 Hvsg==
X-Gm-Message-State: AOJu0YzTD3OVEyrEy2OywR/zwacJxjYvZlqxDdB6iDJizdqPUYbIJA14
 HCw8DuOGaJZ1FptPeF2RfR5DkcllsSIkJ3UFP84eCl0HHhH6RuooyfP4KJJf5g==
X-Gm-Gg: ASbGncuklgLwCxpowshEsLcgAK6qb6Uyw7h3v1bwJ8mu6l9PaDgsoFQberwBI+yXi0Z
 p9DacO+9KvZQodF/zawMTusU+ZgEP3lOL7+pSZOOkUxcfhfTGBuVUwweKu3AaYaGourmI9y4KYm
 BCdrGKRWyyCxDQm/G9cIzBXZVchF7V+QgCyDM6Xt5ThHyBFqGelDgn3vHKwZPBApa69dcL+kHVR
 MXlrRaPZxw6Rbd1EasDQP/HG9qL3CA81kJu9N6Jo5xOlUes6IwYklWMLDPM5u0aJ7T2/zR91N/3
 4RI4hkTdAghQ1iiShHwNzBUW6/T/H0fBVqRPf0azhPBZSXLx4NXlRpiujsUSv50Qqg18kb510A7
 98Bklm12Qf2ge1stWSXiGYTl5FMmAj4ZobZv/ApzYfYq7iesD7GViCoH0Q0m/ql0o2G7dbgU83n
 Y7QiN7BadhiRnD17LLlEDSYhe6EDsBNbOJhMALpIqDwvw0fKR93VY4Tx6tMKfs6v+r6RnPIc1WW
 9mczsB3/K3mDeD75fY=
X-Google-Smtp-Source: AGHT+IFlm/LAFCk7oeWl07Umc85RtCYCsSjZ8WxyEzQ3kaPihIlk3REhnD1hb1w4kpioENTJ/uvwyg==
X-Received: by 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id
 d9443c01a7336-290c9c89dbbmr372055375ad.7.1761263415152; 
 Thu, 23 Oct 2025 16:50:15 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:14 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 11/25] target/riscv: Factor MemOp variable out when MO_TE is
 set
Date: Fri, 24 Oct 2025 09:49:13 +1000
Message-ID: <20251023234927.1864284-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In preparation of automatically replacing the MO_TE flag
in the next commit, use an local @memop variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-12-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvd.c.inc       |  6 ++++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  6 ++++--
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  5 +++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  6 ++++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  8 ++++++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 10 ++++++----
 6 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 3385820678..62b7535815 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -42,7 +42,7 @@
 static bool trans_fld(DisasContext *ctx, arg_fld *a)
 {
     TCGv addr;
-    MemOp memop = MO_TE | MO_UQ;
+    MemOp memop = MO_UQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
@@ -60,6 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
+    memop |= MO_TE;
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -72,7 +73,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
 static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
 {
     TCGv addr;
-    MemOp memop = MO_TE | MO_UQ;
+    MemOp memop = MO_UQ;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVD);
@@ -84,6 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
+    memop |= MO_TE;
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 150e2b9a7d..878417eae9 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -43,11 +43,12 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 {
     TCGv_i64 dest;
     TCGv addr;
-    MemOp memop = MO_TE | MO_UL;
+    MemOp memop = MO_UL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -65,11 +66,12 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
 static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
 {
     TCGv addr;
-    MemOp memop = MO_TE | MO_UL;
+    MemOp memop = MO_UL;
 
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
+    memop |= MO_TE;
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index d850b14264..6458ac4f24 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -119,12 +119,13 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     TCGv_i64 src2h = get_gpr(ctx, a->rs2 == 0 ? 0 : a->rs2 + 1, EXT_NONE);
     TCGv_i64 destl = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
+    MemOp memop = MO_ALIGN | MO_UO;
 
+    memop |= MO_TE;
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
-    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx,
-                                (MO_ALIGN | MO_TE | MO_UO));
+    tcg_gen_atomic_cmpxchg_i128(dest, src1, dest, src2, ctx->mem_idx, memop);
 
     tcg_gen_extr_i128_i64(destl, desth, dest);
 
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index c8dc102c8e..172c2c19c1 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -175,7 +175,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
         return false;
     }
 
-    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
+    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_UL : MO_UQ;
     int reg_size = memop_size(memop);
     target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
                              a->spimm;
@@ -185,6 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
 
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
 
+    memop |= MO_TE;
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest = dest_gpr(ctx, i);
@@ -228,7 +229,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
         return false;
     }
 
-    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_TE | MO_UL : MO_TE | MO_UQ;
+    MemOp memop = get_ol(ctx) == MXL_RV32 ? MO_UL : MO_UQ;
     int reg_size = memop_size(memop);
     target_ulong stack_adj = ROUND_UP(ctpop32(reg_bitmap) * reg_size, 16) +
                              a->spimm;
@@ -238,6 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
 
     tcg_gen_subi_tl(addr, sp, reg_size);
 
+    memop |= MO_TE;
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val = get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index eec478afcb..5355cd46c3 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -42,12 +42,14 @@
 
 static bool trans_flh(DisasContext *ctx, arg_flh *a)
 {
+    MemOp memop = MO_UW;
     TCGv_i64 dest;
     TCGv t0;
 
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
+    memop |= MO_TE;
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -57,7 +59,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     }
 
     dest = cpu_fpr[a->rd];
-    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, MO_TE | MO_UW);
+    tcg_gen_qemu_ld_i64(dest, t0, ctx->mem_idx, memop);
     gen_nanbox_h(dest, dest);
 
     mark_fs_dirty(ctx);
@@ -66,11 +68,13 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
 
 static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
 {
+    MemOp memop = MO_UW;
     TCGv t0;
 
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
+    memop |= MO_TE;
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -79,7 +83,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
         t0 = temp;
     }
 
-    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TE | MO_UW);
+    tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, memop);
 
     return true;
 }
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index c555596617..89eed00758 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -100,12 +100,13 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    MemOp memop = MO_ALIGN | MO_SL;
 
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
-                           (MO_ALIGN | MO_TE | MO_SL));
+    memop |= MO_TE;
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
@@ -129,12 +130,13 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
 
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    MemOp memop = MO_ALIGN | MO_SQ;
 
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx),
-                           (MO_ALIGN | MO_TE | MO_SQ));
+    memop |= MO_TE;
+    tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
-- 
2.51.0


