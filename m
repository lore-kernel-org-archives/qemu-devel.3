Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4890CCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmje-0000m3-SD; Thu, 23 Oct 2025 00:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjd-0000lm-H1
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmja-0007Li-RE
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:33 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7a26ea3bf76so493386b3a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192929; x=1761797729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9XbgZW7IzDyAXZnviNEx7NHDzaOb9b3BNClb4gl2bI=;
 b=mr7xTSueu4BcaVP6vkcUN97zQQK/Uustyzax357VaxQpjSs4PL+V5qu0iinS4ypEAL
 Iz918WXzLFaEROxiPknpo417UeG8I/NxGjnG179ks5U33HlWGRvImdCdhr8rHq8Uj0N3
 OIk+8UAz9rPOFwwcCAYj2QkMTzgNucW2y0S1u9ViEWuO4GbwpKGa262olN8vksywF0cp
 xEvIG3ir36Ygg7f3UutcQ1weMXPqvm6LYmetH8avP3lMD/3xscQN82PQegb5Hktw/5pq
 kjfBwSchPz202+0ggmZepiCl0Kqk8I39K2IdWyt3PVWQ+q91w4kshI+XImZR405fNJkZ
 pziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192929; x=1761797729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9XbgZW7IzDyAXZnviNEx7NHDzaOb9b3BNClb4gl2bI=;
 b=CPv02YZZC0lFKyM7ilgNIMvhD+OyEbA6tt90gDVSHoEOY8FmgODbMRKnYiOh3UB8Ax
 A9aqglGF0iDK0cvUVz+yYmZxrQEqbo7KO3cB9OAIUduMCWDOlShQuHHS8hP8gBjYC8vZ
 jFFXxpRcoGoczL/2H7F2x8Y015XCcpP2lZFjKFNYcBNbI3LPpkgXN4UlURoQirydkKro
 LKE8Yap03Zf07l1RP+4kfqOwKsLclbXeAYvVGmzXhkluRkX6fUHbb/7U02o6YLWQo+LR
 LzmLXN03+2s3AHnF9tW8ePpBSMgDAyB764CHaipZWn/bSTlT3KMwq9WAWlmjfgHrKBNC
 /gbg==
X-Gm-Message-State: AOJu0Yw/0fKsBkdPBDLLurSTpNTrrKfNGO0nkSfgGmToHwIGJJIbizwo
 zQCektnLd9x+8YEDGIbL3L8I241Jh4hVOxUgUinovGbWp5YR4ppLC1IixBm+Xg==
X-Gm-Gg: ASbGncsc8ME3HKVOBKGmb1WODAvZZcg8PPbvZZvyAragLFY0Nk4/nI+dHymE45hKiwo
 8CaWr3KPoERLY3KSguPIxVtlfU/OcNX6c9K1hXFOSrydwC/9zn7RRN5Cq3WgpTBEZ5kXufOJwud
 j6PAzpaJXSqfNs9vfh3Q0fYzxd4CSX0d+9s1JqAxu/hu9+DTK9/kThgCu/gN4nZ7BAOINLkYLIM
 nv7NP1m340L2Wa1bMYdlB+W/l7oDrz7y/8SBE3jEeRrK+bRz6guYi6t78nIhexKhgDrhq8HYnXg
 pyhpNaG760bqwblgfEB4KdgK0Hm2vS1jTRfhQmugs/+2/w1go1utzEZSzi8kP7rFE8fIRMfJLlS
 f3Meli/8JGR6oY+9oBEszyXQSTX91vLpI1B8XU7d87NkbFIfqmUT0PQfyWzQE0l85l7NrukmJ/g
 +uKBDNYA7hZnjY6dAwo7szGEVYg2tMPuVOa5qEOsiNl0EWcfNnZlrcwt05Tmubm8rpwT8jtx96w
 1emLAsC9vQTcURIfMSl
X-Google-Smtp-Source: AGHT+IFX+2NDE7OnE5IFWB+oyOX5MnQv1fKKy4mVZzTVBH3UhcXwcHXU29ZRg7d8GjeqBALl93aqeA==
X-Received: by 2002:a05:6a20:918a:b0:2ef:1d19:3d3 with SMTP id
 adf61e73a8af0-334a84c3963mr30723922637.14.1761192928624; 
 Wed, 22 Oct 2025 21:15:28 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:27 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 12/37] target/riscv: Introduce mo_endian() helper
Date: Thu, 23 Oct 2025 14:14:10 +1000
Message-ID: <20251023041435.1775208-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

mo_endian() returns the target endianness from DisasContext.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251010155045.78220-13-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                      | 18 +++++++++++++++---
 target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvi.c.inc       |  4 ++--
 target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
 target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
 target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
 10 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2e6f39aa02..e1f4dc5ffd 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -126,6 +126,18 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
     return ctx->misa_ext & ext;
 }
 
+static inline MemOp mo_endian(DisasContext *ctx)
+{
+    /*
+     * A couple of bits in MSTATUS set the endianness:
+     *  - MSTATUS_UBE (User-mode),
+     *  - MSTATUS_SBE (Supervisor-mode),
+     *  - MSTATUS_MBE (Machine-mode)
+     * but we don't implement that yet.
+     */
+    return MO_TE;
+}
+
 #ifdef TARGET_RISCV32
 #define get_xl(ctx)    MXL_RV32
 #elif defined(CONFIG_USER_ONLY)
@@ -142,7 +154,7 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
-#define mxl_memop(ctx) ((get_xl(ctx) + 1) | MO_TE)
+#define mxl_memop(ctx) ((get_xl(ctx) + 1) | mo_endian(ctx))
 
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
@@ -1135,7 +1147,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
     MemOp size = mop & MO_SIZE;
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
@@ -1156,7 +1168,7 @@ static bool gen_cmpxchg(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_tl(dest, src1, dest, src2, ctx->mem_idx, mop);
 
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index 8737e8d60d..a7a3278d24 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -35,7 +35,7 @@ static bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1;
 
     mop |= MO_ALIGN;
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
 
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
@@ -65,7 +65,7 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l2 = gen_new_label();
 
     mop |= MO_ALIGN;
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
 
     decode_save_opc(ctx, 0);
     src1 = get_address(ctx, a->rs1, 0);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 62b7535815..ffea0c2a1f 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -60,7 +60,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
@@ -85,7 +85,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     } else {
         memop |= MO_ATOM_IFALIGN;
     }
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
 
     decode_save_opc(ctx, 0);
     addr = get_address(ctx, a->rs1, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 878417eae9..89fb0f604a 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -48,7 +48,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -71,7 +71,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 9a03058f46..54b9b4f241 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -402,7 +402,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
 {
     bool out;
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
@@ -504,7 +504,7 @@ static bool gen_store_i128(DisasContext *ctx, arg_sb *a, MemOp memop)
 
 static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
 {
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
diff --git a/target/riscv/insn_trans/trans_rvzacas.c.inc b/target/riscv/insn_trans/trans_rvzacas.c.inc
index 6458ac4f24..8d94b83ce9 100644
--- a/target/riscv/insn_trans/trans_rvzacas.c.inc
+++ b/target/riscv/insn_trans/trans_rvzacas.c.inc
@@ -76,7 +76,7 @@ static bool gen_cmpxchg64(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGv src1 = get_address(ctx, a->rs1, 0);
     TCGv_i64 src2 = get_gpr_pair(ctx, a->rs2);
 
-    mop |= MO_TE;
+    mop |= mo_endian(ctx);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     tcg_gen_atomic_cmpxchg_i64(dest, src1, dest, src2, ctx->mem_idx, mop);
 
@@ -121,7 +121,7 @@ static bool trans_amocas_q(DisasContext *ctx, arg_amocas_q *a)
     TCGv_i64 desth = get_gpr(ctx, a->rd == 0 ? 0 : a->rd + 1, EXT_NONE);
     MemOp memop = MO_ALIGN | MO_UO;
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_concat_i64_i128(src2, src2l, src2h);
     tcg_gen_concat_i64_i128(dest, destl, desth);
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 172c2c19c1..0d3ba40e52 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -185,7 +185,7 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
 
     tcg_gen_addi_tl(addr, sp, stack_adj - reg_size);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv dest = dest_gpr(ctx, i);
@@ -239,7 +239,7 @@ static bool trans_cm_push(DisasContext *ctx, arg_cm_push *a)
 
     tcg_gen_subi_tl(addr, sp, reg_size);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     for (i = X_Sn + 11; i >= 0; i--) {
         if (reg_bitmap & (1 << i)) {
             TCGv val = get_gpr(ctx, i, EXT_NONE);
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 5355cd46c3..791ee51f65 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -49,7 +49,7 @@ static bool trans_flh(DisasContext *ctx, arg_flh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
@@ -74,7 +74,7 @@ static bool trans_fsh(DisasContext *ctx, arg_fsh *a)
     REQUIRE_FPU;
     REQUIRE_ZFHMIN_OR_ZFBFMIN(ctx);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     decode_save_opc(ctx, 0);
     t0 = get_gpr(ctx, a->rs1, EXT_NONE);
     if (a->imm) {
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index 89eed00758..0b6ad57965 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -105,7 +105,7 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
@@ -135,7 +135,7 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
     decode_save_opc(ctx, RISCV_UW2_ALWAYS_STORE_AMO);
     src1 = get_address(ctx, a->rs1, 0);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_atomic_xchg_tl(dest, src1, src2, SS_MMU_INDEX(ctx), memop);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 2f31842791..f8b95c6498 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -349,7 +349,7 @@ static bool gen_fload_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_ld_i64(rd, addr, ctx->mem_idx, memop);
     if ((memop & MO_SIZE) == MO_32) {
         gen_nanbox_s(rd, rd);
@@ -370,7 +370,7 @@ static bool gen_fstore_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv_i64 rd = cpu_fpr[a->rd];
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_st_i64(rd, addr, ctx->mem_idx, memop);
 
     return true;
@@ -570,7 +570,7 @@ static bool gen_load_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rd, rd);
@@ -591,7 +591,7 @@ static bool gen_store_inc(DisasContext *ctx, arg_th_meminc *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
     tcg_gen_addi_tl(rs1, rs1, imm);
     gen_set_gpr(ctx, a->rs1, rs1);
@@ -747,7 +747,7 @@ static bool gen_load_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv rd = dest_gpr(ctx, a->rd);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_ld_tl(rd, addr, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd, rd);
 
@@ -765,7 +765,7 @@ static bool gen_store_idx(DisasContext *ctx, arg_th_memidx *a, MemOp memop,
     TCGv data = get_gpr(ctx, a->rd, EXT_NONE);
     TCGv addr = get_th_address_indexed(ctx, a->rs1, a->rs2, a->imm2, zext_offs);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, memop);
 
     return true;
@@ -926,7 +926,7 @@ static bool gen_loadpair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_ld_tl(t1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_ld_tl(t2, addr2, ctx->mem_idx, memop);
     gen_set_gpr(ctx, a->rd1, t1);
@@ -965,7 +965,7 @@ static bool gen_storepair_tl(DisasContext *ctx, arg_th_pair *a, MemOp memop,
     addr1 = get_address(ctx, a->rs, imm);
     addr2 = get_address(ctx, a->rs, memop_size(memop) + imm);
 
-    memop |= MO_TE;
+    memop |= mo_endian(ctx);
     tcg_gen_qemu_st_tl(data1, addr1, ctx->mem_idx, memop);
     tcg_gen_qemu_st_tl(data2, addr2, ctx->mem_idx, memop);
     return true;
-- 
2.51.0


