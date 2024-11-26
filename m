Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50006D3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvQR-00085J-ED; Tue, 26 Nov 2024 08:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQH-0007y1-EN
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:11 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQC-0003ZX-QQ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a742481aso4720145e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626963; x=1733231763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxPG+MKvhWdDsZNig39E+VzWYlvVWASoU0oHPcJiLXI=;
 b=QX0SvUVmG4h5ZH9qubP/JWX2Z1BRTCxd1CGZ8rm0udeVkStO+lMWhBmHohR7cPYY8u
 IWBf+30AjGsaYvMUUpY938VqFEu0WIaA6m+OnBuclKVRNp76cON9bvsuYdrvz4MVvwe+
 /tUFbBHjcKx7qzFsiotaX0JRMtiyZMJwWICuCAOJ2iNM8YuROH7pmkNO+jMpo0dax7Jq
 v6oQeC9qc1C93yb1akfcIfPJzepYRi+4JEIrILTxl4hvgWy+ATPGhFomXsfiooc80+7K
 DiWVjF/r+VY+i6YonZQ684pTJHyoz7mAn2cA7ABzM7mzVUh4TSyErz7MOcvgN+SBU6+1
 67Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626963; x=1733231763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxPG+MKvhWdDsZNig39E+VzWYlvVWASoU0oHPcJiLXI=;
 b=dDEH835HRSSFR8PNh39NE9Kw4d84mS9y0j6xNKT4P3r9f6bz6Hfp/WQm1cW/QkKLDq
 oRJE+et/sSif5BgE05PBZ9t8unSGXkD+scHNWkZZ+QLIc0LcxGboh/4tgp2oiGyah3oT
 wfFONY/+lWTPQk9Cu7gEkUaXwGbCb1++G0FtGaVUgl9bqqlchNbw2nGE7udnVTJ+nCa6
 GMJCMAvws+fC8XkKP8EY7sTtDnkPV8bSy005nOpVllFjwSG4htzAFsZ66jtebzvRHU6E
 V/K7VrAgJHmWcgrdEKmtZAZ/HdYogMrNn8oiTtUW6oTKBVxhcbmxT+tZz2RwqwBD0wmu
 TOGg==
X-Gm-Message-State: AOJu0Yw/K7DFWYfj+kflfr8isKfNQBgZKbsw22ypGvxS8VeiC8921+Go
 kXGYmt1xvGT8Xch7c4KK80/Zulx1vKbqNjPcHBQI+sm6lg9WdR9ala19LMvwLtBDTnYK5Qg7gd+
 E
X-Gm-Gg: ASbGncsf39xZOjDsF/9TdGEFjv3hsQEHdWj8J7L9PDRsoIU8mX7ao8bjc9z5M64Bw47
 4j+acySrLmbJToynIl2j4oR9xgqf1N3a4Sa+tQ/uOwe1tGvqC4gBFGODW8n/yioxna8uL8tMEBJ
 I3MIWSIu/2ls2mZRKUIy1xbjZhomO4osfqYJqQJWN+zcd2RkbF+MnCTeC2qFkmiQX/6Fok2bjfa
 KztyPCB1I4Mg98t3kEC4pFYF3rZ2MrX0J8HIS0IruXMJtDm9JWOJGE4VRELmIQACfDoZQat
X-Google-Smtp-Source: AGHT+IGF0YKThHkrnYNvhw1uMZivM40ptauYqYMSUzxW1x7zfgQHvs7yk3QIX6u1wrz4kCsrai8GCA==
X-Received: by 2002:a05:600c:5122:b0:433:c76d:d57e with SMTP id
 5b1f17b1804b1-433ce420ad8mr142152885e9.5.1732626962288; 
 Tue, 26 Nov 2024 05:16:02 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4349eeb375fsm78750925e9.3.2024.11.26.05.16.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 02/13] target/mips: Rename gen_store_gpr() ->
 gen_store_gpr_tl()
Date: Tue, 26 Nov 2024 14:15:34 +0100
Message-ID: <20241126131546.66145-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

MIPS gen_store_gpr() takes a target-specific TCGv argument.
Rename it as gen_store_gpr_tl() to clarify, like other TCG
core helpers.

Mechanical change doing:

  $ sed -i -e 's/gen_store_gpr/gen_store_gpr_tl/' \
     $(git grep -l gen_store_gpr)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |   2 +-
 target/mips/tcg/lcsr_translate.c          |   4 +-
 target/mips/tcg/msa_translate.c           |   2 +-
 target/mips/tcg/mxu_translate.c           |  20 +-
 target/mips/tcg/octeon_translate.c        |   6 +-
 target/mips/tcg/translate.c               | 120 +++++-----
 target/mips/tcg/tx79_translate.c          |   6 +-
 target/mips/tcg/vr54xx_translate.c        |   2 +-
 target/mips/tcg/micromips_translate.c.inc |  12 +-
 target/mips/tcg/mips16e_translate.c.inc   |   2 +-
 target/mips/tcg/nanomips_translate.c.inc  | 260 +++++++++++-----------
 11 files changed, 218 insertions(+), 218 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index f1aa706a357..49f174d3617 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -156,7 +156,7 @@ void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
 void gen_move_low32(TCGv ret, TCGv_i64 arg);
 void gen_move_high32(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
-void gen_store_gpr(TCGv t, int reg);
+void gen_store_gpr_tl(TCGv t, int reg);
 #if defined(TARGET_MIPS64)
 void gen_load_gpr_hi(TCGv_i64 t, int reg);
 void gen_store_gpr_hi(TCGv_i64 t, int reg);
diff --git a/target/mips/tcg/lcsr_translate.c b/target/mips/tcg/lcsr_translate.c
index 193b211049c..2ca5562b480 100644
--- a/target/mips/tcg/lcsr_translate.c
+++ b/target/mips/tcg/lcsr_translate.c
@@ -23,7 +23,7 @@ static bool trans_CPUCFG(DisasContext *ctx, arg_CPUCFG *a)
 
     gen_load_gpr_tl(src1, a->rs);
     gen_helper_lcsr_cpucfg(dest, tcg_env, src1);
-    gen_store_gpr(dest, a->rd);
+    gen_store_gpr_tl(dest, a->rd);
 
     return true;
 }
@@ -38,7 +38,7 @@ static bool gen_rdcsr(DisasContext *ctx, arg_r *a,
     check_cp0_enabled(ctx);
     gen_load_gpr_tl(src1, a->rs);
     func(dest, tcg_env, src1);
-    gen_store_gpr(dest, a->rd);
+    gen_store_gpr_tl(dest, a->rd);
 
     return true;
 }
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 6f6eaab93aa..25939da4b3e 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -553,7 +553,7 @@ static bool trans_CFCMSA(DisasContext *ctx, arg_msa_elm *a)
     telm = tcg_temp_new();
 
     gen_helper_msa_cfcmsa(telm, tcg_env, tcg_constant_i32(a->ws));
-    gen_store_gpr(telm, a->wd);
+    gen_store_gpr_tl(telm, a->wd);
 
     return true;
 }
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 002447a10d7..9525aebc053 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -706,7 +706,7 @@ static void gen_mxu_s32m2i(DisasContext *ctx)
         gen_load_mxu_cr(t0);
     }
 
-    gen_store_gpr(t0, Rb);
+    gen_store_gpr_tl(t0, Rb);
 }
 
 /*
@@ -731,7 +731,7 @@ static void gen_mxu_s8ldd(DisasContext *ctx, bool postmodify)
     gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
     if (postmodify) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
 
     switch (optn3) {
@@ -816,7 +816,7 @@ static void gen_mxu_s8std(DisasContext *ctx, bool postmodify)
     gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, (int8_t)s8);
     if (postmodify) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
     gen_load_mxu_gpr(t1, XRa);
 
@@ -865,7 +865,7 @@ static void gen_mxu_s16ldd(DisasContext *ctx, bool postmodify)
     gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, s10);
     if (postmodify) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
 
     switch (optn2) {
@@ -924,7 +924,7 @@ static void gen_mxu_s16std(DisasContext *ctx, bool postmodify)
     gen_load_gpr_tl(t0, Rb);
     tcg_gen_addi_tl(t0, t0, s10);
     if (postmodify) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
     gen_load_mxu_gpr(t1, XRa);
 
@@ -1538,7 +1538,7 @@ static void gen_mxu_s32ldxx(DisasContext *ctx, bool reversed, bool postinc)
     gen_store_mxu_gpr(t1, XRa);
 
     if (postinc) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
 }
 
@@ -1573,7 +1573,7 @@ static void gen_mxu_s32stxx(DisasContext *ctx, bool reversed, bool postinc)
                         ctx->default_tcg_memop_mask);
 
     if (postinc) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
 }
 
@@ -1610,7 +1610,7 @@ static void gen_mxu_s32ldxvx(DisasContext *ctx, bool reversed,
     gen_store_mxu_gpr(t1, XRa);
 
     if (postinc) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
 }
 
@@ -1643,7 +1643,7 @@ static void gen_mxu_lxx(DisasContext *ctx, uint32_t strd2, MemOp mop)
     tcg_gen_add_tl(t0, t0, t1);
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mop | ctx->default_tcg_memop_mask);
-    gen_store_gpr(t1, Ra);
+    gen_store_gpr_tl(t1, Ra);
 }
 
 /*
@@ -1679,7 +1679,7 @@ static void gen_mxu_s32stxvx(DisasContext *ctx, bool reversed,
                         ctx->default_tcg_memop_mask);
 
     if (postinc) {
-        gen_store_gpr(t0, Rb);
+        gen_store_gpr_tl(t0, Rb);
     }
 }
 
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 6b0dbf946d8..587f4f8f692 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -90,7 +90,7 @@ static bool trans_EXTS(DisasContext *ctx, arg_EXTS *a)
     t0 = tcg_temp_new();
     gen_load_gpr_tl(t0, a->rs);
     tcg_gen_sextract_tl(t0, t0, a->p, a->lenm1 + 1);
-    gen_store_gpr(t0, a->rt);
+    gen_store_gpr_tl(t0, a->rt);
     return true;
 }
 
@@ -106,7 +106,7 @@ static bool trans_CINS(DisasContext *ctx, arg_CINS *a)
     t0 = tcg_temp_new();
     gen_load_gpr_tl(t0, a->rs);
     tcg_gen_deposit_z_tl(t0, t0, a->p, a->lenm1 + 1);
-    gen_store_gpr(t0, a->rt);
+    gen_store_gpr_tl(t0, a->rt);
     return true;
 }
 
@@ -125,7 +125,7 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
         tcg_gen_andi_i64(t0, t0, 0xffffffff);
     }
     tcg_gen_ctpop_tl(t0, t0);
-    gen_store_gpr(t0, a->rd);
+    gen_store_gpr_tl(t0, a->rd);
     return true;
 }
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13fbe5d378f..629846a596d 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1198,7 +1198,7 @@ void gen_load_gpr_tl(TCGv t, int reg)
     }
 }
 
-void gen_store_gpr(TCGv t, int reg)
+void gen_store_gpr_tl(TCGv t, int reg)
 {
     assert(reg >= 0 && reg <= ARRAY_SIZE(cpu_gpr));
     if (reg != 0) {
@@ -1246,7 +1246,7 @@ static inline void gen_load_srsgpr(int from, int to)
 
         tcg_gen_ld_tl(t0, addr, sizeof(target_ulong) * from);
     }
-    gen_store_gpr(t0, to);
+    gen_store_gpr_tl(t0, to);
 }
 
 static inline void gen_store_srsgpr(int from, int to)
@@ -2049,42 +2049,42 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LWU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LD:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LLD:
     case R6_OPC_LLD:
         op_ld_lld(t0, t0, mem_idx, ctx);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LDL:
         t1 = tcg_temp_new();
         gen_load_gpr_tl(t1, rt);
         gen_lxl(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UQ);
-        gen_store_gpr(t1, rt);
+        gen_store_gpr_tl(t1, rt);
         break;
     case OPC_LDR:
         t1 = tcg_temp_new();
         gen_load_gpr_tl(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UQ);
-        gen_store_gpr(t1, rt);
+        gen_store_gpr_tl(t1, rt);
         break;
     case OPC_LDPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UQ);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
 #endif
     case OPC_LWPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SL);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LWE:
         mem_idx = MIPS_HFLAG_UM;
@@ -2092,7 +2092,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LW:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LHE:
         mem_idx = MIPS_HFLAG_UM;
@@ -2100,7 +2100,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LH:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SW |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LHUE:
         mem_idx = MIPS_HFLAG_UM;
@@ -2108,21 +2108,21 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LHU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UW |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LBE:
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LB:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_SB);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LBUE:
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LBU:
         tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_UB);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_LWLE:
         mem_idx = MIPS_HFLAG_UM;
@@ -2132,7 +2132,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         gen_load_gpr_tl(t1, rt);
         gen_lxl(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
-        gen_store_gpr(t1, rt);
+        gen_store_gpr_tl(t1, rt);
         break;
     case OPC_LWRE:
         mem_idx = MIPS_HFLAG_UM;
@@ -2142,7 +2142,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         gen_load_gpr_tl(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
-        gen_store_gpr(t1, rt);
+        gen_store_gpr_tl(t1, rt);
         break;
     case OPC_LLE:
         mem_idx = MIPS_HFLAG_UM;
@@ -2150,7 +2150,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LL:
     case R6_OPC_LL:
         op_ld_ll(t0, t0, mem_idx, ctx);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     }
 }
@@ -2227,7 +2227,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
     /* compare the address against that of the preceding LL */
     gen_base_offset_addr(ctx, addr, base, offset);
     tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
-    gen_store_gpr(tcg_constant_tl(0), rt);
+    gen_store_gpr_tl(tcg_constant_tl(0), rt);
     tcg_gen_br(done);
 
     gen_set_label(l1);
@@ -2237,7 +2237,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llval, val,
                               eva ? MIPS_HFLAG_UM : ctx->mem_idx, tcg_mo);
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_llval);
-    gen_store_gpr(t0, rt);
+    gen_store_gpr_tl(t0, rt);
 
     gen_set_label(done);
 }
@@ -2344,7 +2344,7 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
             tcg_gen_ext32s_tl(t0, t0);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr_tl(t0, rt);
         }
         break;
     case OPC_ADDIU:
@@ -2373,7 +2373,7 @@ static void gen_arith_imm(DisasContext *ctx, uint32_t opc,
             /* operands of same sign, result different sign */
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr_tl(t0, rt);
         }
         break;
     case OPC_DADDIU:
@@ -2564,7 +2564,7 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
             /* operands of same sign, result different sign */
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
-            gen_store_gpr(t0, rd);
+            gen_store_gpr_tl(t0, rd);
         }
         break;
     case OPC_ADDU:
@@ -2600,7 +2600,7 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
              */
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
-            gen_store_gpr(t0, rd);
+            gen_store_gpr_tl(t0, rd);
         }
         break;
     case OPC_SUBU:
@@ -2634,7 +2634,7 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
             /* operands of same sign, result different sign */
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
-            gen_store_gpr(t0, rd);
+            gen_store_gpr_tl(t0, rd);
         }
         break;
     case OPC_DADDU:
@@ -2668,7 +2668,7 @@ static void gen_arith(DisasContext *ctx, uint32_t opc,
              */
             generate_exception(ctx, EXCP_OVERFLOW);
             gen_set_label(l1);
-            gen_store_gpr(t0, rd);
+            gen_store_gpr_tl(t0, rd);
         }
         break;
     case OPC_DSUBU:
@@ -2940,7 +2940,7 @@ static inline void gen_r6_ld(target_long addr, int reg, int memidx,
 {
     TCGv t0 = tcg_temp_new();
     tcg_gen_qemu_ld_tl(t0, tcg_constant_tl(addr), memidx, memop);
-    gen_store_gpr(t0, reg);
+    gen_store_gpr_tl(t0, reg);
 }
 
 static inline void gen_pcrel(DisasContext *ctx, int opc, target_ulong pc,
@@ -3948,8 +3948,8 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t1, rt);
-        gen_store_gpr(t0, lsq_rt1);
+        gen_store_gpr_tl(t1, rt);
+        gen_store_gpr_tl(t0, lsq_rt1);
         break;
     case OPC_GSLQC1:
         check_cp1_enabled(ctx);
@@ -4140,12 +4140,12 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     switch (opc) {
     case OPC_GSLBX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_GSLHX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SW |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_GSLWX:
         gen_base_offset_addr(ctx, t0, rs, offset);
@@ -4154,7 +4154,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         }
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSLDX:
@@ -4164,7 +4164,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         }
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
 #endif
     case OPC_GSLWXC1:
@@ -4682,7 +4682,7 @@ fail:
         gen_reserved_instruction(ctx);
         return;
     }
-    gen_store_gpr(t0, rt);
+    gen_store_gpr_tl(t0, rt);
 }
 
 static void gen_bshfl(DisasContext *ctx, uint32_t op2, int rt, int rd)
@@ -8276,7 +8276,7 @@ static void gen_mftr(CPUMIPSState *env, DisasContext *ctx, int rt, int rd,
         }
     }
     trace_mips_translate_tr("mftr", rt, u, sel, h);
-    gen_store_gpr(t0, rd);
+    gen_store_gpr_tl(t0, rd);
     return;
 
 die:
@@ -9048,7 +9048,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
             gen_load_fpr32(ctx, fp0, fs);
             tcg_gen_ext_i32_tl(t0, fp0);
         }
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_MTC1:
         gen_load_gpr_tl(t0, rt);
@@ -9061,7 +9061,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
         break;
     case OPC_CFC1:
         gen_helper_1e0i(cfc1, t0, fs);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_CTC1:
         gen_load_gpr_tl(t0, rt);
@@ -9073,7 +9073,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
 #if defined(TARGET_MIPS64)
     case OPC_DMFC1:
         gen_load_fpr64(ctx, t0, fs);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_DMTC1:
         gen_load_gpr_tl(t0, rt);
@@ -9087,7 +9087,7 @@ static void gen_cp1(DisasContext *ctx, uint32_t opc, int rt, int fs)
             gen_load_fpr32h(ctx, fp0, fs);
             tcg_gen_ext_i32_tl(t0, fp0);
         }
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case OPC_MTHC1:
         gen_load_gpr_tl(t0, rt);
@@ -10848,16 +10848,16 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
     switch (rd) {
     case 0:
         gen_helper_rdhwr_cpunum(t0, tcg_env);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case 1:
         gen_helper_rdhwr_synci_step(t0, tcg_env);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case 2:
         translator_io_start(&ctx->base);
         gen_helper_rdhwr_cc(t0, tcg_env);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         /*
          * Break the TB to be able to take timer interrupts immediately
          * after reading count. DISAS_STOP isn't sufficient, we need to ensure
@@ -10868,7 +10868,7 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         break;
     case 3:
         gen_helper_rdhwr_ccres(t0, tcg_env);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case 4:
         check_insn(ctx, ISA_MIPS_R6);
@@ -10880,25 +10880,25 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
             generate_exception(ctx, EXCP_RI);
         }
         gen_helper_rdhwr_performance(t0, tcg_env);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case 5:
         check_insn(ctx, ISA_MIPS_R6);
         gen_helper_rdhwr_xnp(t0, tcg_env);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case 29:
 #if defined(CONFIG_USER_ONLY)
         tcg_gen_ld_tl(t0, tcg_env,
                       offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
 #else
         if ((ctx->hflags & MIPS_HFLAG_CP0) ||
             (ctx->hflags & MIPS_HFLAG_HWRENA_ULR)) {
             tcg_gen_ld_tl(t0, tcg_env,
                           offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
-            gen_store_gpr(t0, rt);
+            gen_store_gpr_tl(t0, rt);
         } else {
             gen_reserved_instruction(ctx);
         }
@@ -11257,7 +11257,7 @@ void gen_ldxs(DisasContext *ctx, int base, int index, int rd)
     }
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
-    gen_store_gpr(t1, rd);
+    gen_store_gpr_tl(t1, rd);
 }
 
 static void gen_sync(int stype)
@@ -11344,20 +11344,20 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
     switch (opc) {
     case OPC_LBUX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case OPC_LHX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SW);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case OPC_LWX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_LDX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
 #endif
     }
@@ -14284,7 +14284,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
 
             gen_load_gpr_tl(t0, rs);
             gen_helper_yield(t0, tcg_env, t0);
-            gen_store_gpr(t0, rd);
+            gen_store_gpr_tl(t0, rd);
         }
         break;
     default:
@@ -14465,42 +14465,42 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
                 case OPC_DMT:
                     check_cp0_mt(ctx);
                     gen_helper_dmt(t0);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                     break;
                 case OPC_EMT:
                     check_cp0_mt(ctx);
                     gen_helper_emt(t0);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                     break;
                 case OPC_DVPE:
                     check_cp0_mt(ctx);
                     gen_helper_dvpe(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                     break;
                 case OPC_EVPE:
                     check_cp0_mt(ctx);
                     gen_helper_evpe(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                     break;
                 case OPC_DVP:
                     check_insn(ctx, ISA_MIPS_R6);
                     if (ctx->vp) {
                         gen_helper_dvp(t0, tcg_env);
-                        gen_store_gpr(t0, rt);
+                        gen_store_gpr_tl(t0, rt);
                     }
                     break;
                 case OPC_EVP:
                     check_insn(ctx, ISA_MIPS_R6);
                     if (ctx->vp) {
                         gen_helper_evp(t0, tcg_env);
-                        gen_store_gpr(t0, rt);
+                        gen_store_gpr_tl(t0, rt);
                     }
                     break;
                 case OPC_DI:
                     check_insn(ctx, ISA_MIPS_R2);
                     save_cpu_state(ctx, 1);
                     gen_helper_di(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                     /*
                      * Stop translation as we may have switched
                      * the execution mode.
@@ -14511,7 +14511,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
                     check_insn(ctx, ISA_MIPS_R2);
                     save_cpu_state(ctx, 1);
                     gen_helper_ei(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                     /*
                      * DISAS_STOP isn't sufficient, we need to ensure we break
                      * out of translated code to check for pending interrupts.
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index 9a204a2d884..90d63e5dfc4 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -64,14 +64,14 @@ bool decode_ext_tx79(DisasContext *ctx, uint32_t insn)
 
 static bool trans_MFHI1(DisasContext *ctx, arg_r *a)
 {
-    gen_store_gpr(cpu_HI[1], a->rd);
+    gen_store_gpr_tl(cpu_HI[1], a->rd);
 
     return true;
 }
 
 static bool trans_MFLO1(DisasContext *ctx, arg_r *a)
 {
-    gen_store_gpr(cpu_LO[1], a->rd);
+    gen_store_gpr_tl(cpu_LO[1], a->rd);
 
     return true;
 }
@@ -341,7 +341,7 @@ static bool trans_LQ(DisasContext *ctx, arg_i *a)
 
     /* Lower half */
     tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
-    gen_store_gpr(t0, a->rt);
+    gen_store_gpr_tl(t0, a->rt);
 
     /* Upper half */
     tcg_gen_addi_i64(addr, addr, 8);
diff --git a/target/mips/tcg/vr54xx_translate.c b/target/mips/tcg/vr54xx_translate.c
index d1e9f0e51cd..99ce81b7159 100644
--- a/target/mips/tcg/vr54xx_translate.c
+++ b/target/mips/tcg/vr54xx_translate.c
@@ -45,7 +45,7 @@ static bool trans_mult_acc(DisasContext *ctx, arg_r *a,
 
     gen_helper_mult_acc(t0, tcg_env, t0, t1);
 
-    gen_store_gpr(t0, a->rd);
+    gen_store_gpr_tl(t0, a->rd);
     return true;
 }
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index fd85977bb8b..cb3dbd264a0 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -979,11 +979,11 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         }
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t1, rd);
+        gen_store_gpr_tl(t1, rd);
         gen_op_addr_addi(ctx, t0, t0, 4);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t1, rd + 1);
+        gen_store_gpr_tl(t1, rd + 1);
         break;
     case SWP:
         gen_load_gpr_tl(t1, rd);
@@ -1002,11 +1002,11 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
         }
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t1, rd);
+        gen_store_gpr_tl(t1, rd);
         gen_op_addr_addi(ctx, t0, t0, 8);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_store_gpr(t1, rd + 1);
+        gen_store_gpr_tl(t1, rd + 1);
         break;
     case SDP:
         gen_load_gpr_tl(t1, rd);
@@ -1268,7 +1268,7 @@ static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
 
                 save_cpu_state(ctx, 1);
                 gen_helper_di(t0, tcg_env);
-                gen_store_gpr(t0, rs);
+                gen_store_gpr_tl(t0, rs);
                 /*
                  * Stop translation as we may have switched the execution
                  * mode.
@@ -1283,7 +1283,7 @@ static void gen_pool32axf(CPUMIPSState *env, DisasContext *ctx, int rt, int rs)
 
                 save_cpu_state(ctx, 1);
                 gen_helper_ei(t0, tcg_env);
-                gen_store_gpr(t0, rs);
+                gen_store_gpr_tl(t0, rs);
                 /*
                  * DISAS_STOP isn't sufficient, we need to ensure we break out
                  * of translated code to check for pending interrupts.
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index 52a34b3c4b9..ceb41be0c26 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -295,7 +295,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
     gen_op_addr_add(ctx, t0, t0, t2);
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
                        ctx->default_tcg_memop_mask);
-    gen_store_gpr(t1, regidx);
+    gen_store_gpr_tl(t1, regidx);
 }
 
 static void gen_mips16_restore(DisasContext *ctx,
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 99ce1f96564..31a31c00979 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1005,8 +1005,8 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
     } else {
         tcg_gen_extr_i64_tl(tmp1, tmp2, tval);
     }
-    gen_store_gpr(tmp1, reg1);
-    gen_store_gpr(tmp2, reg2);
+    gen_store_gpr_tl(tmp1, reg1);
+    gen_store_gpr_tl(tmp2, reg2);
     tcg_gen_st_i64(tval, tcg_env, offsetof(CPUMIPSState, llval_wp));
     tcg_gen_st_tl(taddr, tcg_env, offsetof(CPUMIPSState, lladdr));
 }
@@ -1098,7 +1098,7 @@ static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
         tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx,
                           mo_endian(ctx) | MO_SL | ctx->default_tcg_memop_mask);
         tcg_gen_ext32s_tl(t0, t0);
-        gen_store_gpr(t0, this_rt);
+        gen_store_gpr_tl(t0, this_rt);
         counter++;
     }
 
@@ -1336,14 +1336,14 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
                 if (ctx->vp) {
                     check_cp0_enabled(ctx);
                     gen_helper_dvp(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                 }
                 break;
             case NM_EVP:
                 if (ctx->vp) {
                     check_cp0_enabled(ctx);
                     gen_helper_evp(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                 }
                 break;
             }
@@ -1368,7 +1368,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 
             /* operands of same sign, result different sign */
             tcg_gen_setcondi_tl(TCG_COND_LT, t0, t1, 0);
-            gen_store_gpr(t0, rd);
+            gen_store_gpr_tl(t0, rd);
         }
         break;
     case NM_MUL:
@@ -1424,12 +1424,12 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
                     /* DMT */
                     check_cp0_mt(ctx);
                     gen_helper_dmt(t0);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                 } else if (rs == 0) {
                     /* DVPE */
                     check_cp0_mt(ctx);
                     gen_helper_dvpe(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                 } else {
                     gen_reserved_instruction(ctx);
                 }
@@ -1439,12 +1439,12 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
                     /* EMT */
                     check_cp0_mt(ctx);
                     gen_helper_emt(t0);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                 } else if (rs == 0) {
                     /* EVPE */
                     check_cp0_mt(ctx);
                     gen_helper_evpe(t0, tcg_env);
-                    gen_store_gpr(t0, rt);
+                    gen_store_gpr_tl(t0, rt);
                 } else {
                     gen_reserved_instruction(ctx);
                 }
@@ -1486,7 +1486,7 @@ static void gen_pool32a0_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 
             gen_load_gpr_tl(t0, rs);
             gen_helper_yield(t0, tcg_env, t0);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr_tl(t0, rt);
         }
         break;
 #endif
@@ -1585,7 +1585,7 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_RDDSP:
             gen_helper_rddsp(t0, tcg_constant_tl(imm), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_WRDSP:
             gen_load_gpr_tl(t0, ret);
@@ -1594,12 +1594,12 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTP:
             gen_helper_extp(t0, tcg_constant_tl(v2 >> 3),
                             tcg_constant_tl(v1), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_EXTPDP:
             gen_helper_extpdp(t0, tcg_constant_tl(v2 >> 3),
                               tcg_constant_tl(v1), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         }
         break;
@@ -1608,11 +1608,11 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         switch (extract32(ctx->opcode, 12, 1)) {
         case NM_SHLL_QB:
             gen_helper_shll_qb(t0, tcg_constant_tl(v2 >> 2), v0_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_SHRL_QB:
             gen_helper_shrl_qb(t0, tcg_constant_tl(v2 >> 2), v0_t);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         }
         break;
@@ -1626,22 +1626,22 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTR_W:
             gen_helper_extr_w(t0, tcg_constant_tl(v2 >> 3),
                               tcg_constant_tl(v1), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_EXTR_R_W:
             gen_helper_extr_r_w(t0, tcg_constant_tl(v2 >> 3),
                                 tcg_constant_tl(v1), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_EXTR_RS_W:
             gen_helper_extr_rs_w(t0, tcg_constant_tl(v2 >> 3),
                                  tcg_constant_tl(v1), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_EXTR_S_H:
             gen_helper_extr_s_h(t0, tcg_constant_tl(v2 >> 3),
                                 tcg_constant_tl(v1), tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         }
         break;
@@ -1843,7 +1843,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             check_dsp(ctx);
             gen_load_gpr_tl(v1_t, rs);
             gen_helper_extr_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         }
         break;
@@ -1897,7 +1897,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTRV_R_W:
             check_dsp(ctx);
             gen_helper_extr_r_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         default:
             gen_reserved_instruction(ctx);
@@ -1916,7 +1916,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTPV:
             check_dsp(ctx);
             gen_helper_extp(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_MSUB:
             check_dsp(ctx);
@@ -1939,7 +1939,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTRV_RS_W:
             check_dsp(ctx);
             gen_helper_extr_rs_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         }
         break;
@@ -1955,7 +1955,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTPDPV:
             check_dsp(ctx);
             gen_helper_extpdp(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         case NM_MSUBU:
             check_dsp(ctx);
@@ -1980,7 +1980,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTRV_S_H:
             check_dsp(ctx);
             gen_helper_extr_s_h(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
-            gen_store_gpr(t0, ret);
+            gen_store_gpr_tl(t0, ret);
             break;
         }
         break;
@@ -2003,70 +2003,70 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
     case NM_ABSQ_S_QB:
         check_dsp_r2(ctx);
         gen_helper_absq_s_qb(v0_t, v0_t, tcg_env);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_ABSQ_S_PH:
         check_dsp(ctx);
         gen_helper_absq_s_ph(v0_t, v0_t, tcg_env);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_ABSQ_S_W:
         check_dsp(ctx);
         gen_helper_absq_s_w(v0_t, v0_t, tcg_env);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEQ_W_PHL:
         check_dsp(ctx);
         tcg_gen_andi_tl(v0_t, v0_t, 0xFFFF0000);
         tcg_gen_ext32s_tl(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEQ_W_PHR:
         check_dsp(ctx);
         tcg_gen_andi_tl(v0_t, v0_t, 0x0000FFFF);
         tcg_gen_shli_tl(v0_t, v0_t, 16);
         tcg_gen_ext32s_tl(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEQU_PH_QBL:
         check_dsp(ctx);
         gen_helper_precequ_ph_qbl(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEQU_PH_QBR:
         check_dsp(ctx);
         gen_helper_precequ_ph_qbr(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEQU_PH_QBLA:
         check_dsp(ctx);
         gen_helper_precequ_ph_qbla(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEQU_PH_QBRA:
         check_dsp(ctx);
         gen_helper_precequ_ph_qbra(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEU_PH_QBL:
         check_dsp(ctx);
         gen_helper_preceu_ph_qbl(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEU_PH_QBR:
         check_dsp(ctx);
         gen_helper_preceu_ph_qbr(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEU_PH_QBLA:
         check_dsp(ctx);
         gen_helper_preceu_ph_qbla(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_PRECEU_PH_QBRA:
         check_dsp(ctx);
         gen_helper_preceu_ph_qbra(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_REPLV_PH:
         check_dsp(ctx);
@@ -2074,7 +2074,7 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
         tcg_gen_shli_tl(t0, v0_t, 16);
         tcg_gen_or_tl(v0_t, v0_t, t0);
         tcg_gen_ext32s_tl(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_REPLV_QB:
         check_dsp(ctx);
@@ -2084,12 +2084,12 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
         tcg_gen_shli_tl(t0, v0_t, 16);
         tcg_gen_or_tl(v0_t, v0_t, t0);
         tcg_gen_ext32s_tl(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_BITREV:
         check_dsp(ctx);
         gen_helper_bitrev(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_INSV:
         check_dsp(ctx);
@@ -2098,13 +2098,13 @@ static void gen_pool32axf_4_nanomips_insn(DisasContext *ctx, uint32_t opc,
 
             gen_load_gpr_tl(tv0, rt);
             gen_helper_insv(v0_t, tcg_env, v0_t, tv0);
-            gen_store_gpr(v0_t, ret);
+            gen_store_gpr_tl(v0_t, ret);
         }
         break;
     case NM_RADDU_W_QB:
         check_dsp(ctx);
         gen_helper_raddu_w_qb(v0_t, v0_t);
-        gen_store_gpr(v0_t, ret);
+        gen_store_gpr_tl(v0_t, ret);
         break;
     case NM_BITSWAP:
         gen_bitswap(ctx, OPC_BITSWAP, ret, rs);
@@ -2141,19 +2141,19 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case 0:
             /* NM_SHRA_QB */
             gen_helper_shra_qb(t0, tcg_constant_tl(rd >> 2), rs_t);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr_tl(t0, rt);
             break;
         case 1:
             /* NM_SHRA_R_QB */
             gen_helper_shra_r_qb(t0, tcg_constant_tl(rd >> 2), rs_t);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr_tl(t0, rt);
             break;
         }
         break;
     case NM_SHRL_PH:
         check_dsp_r2(ctx);
         gen_helper_shrl_ph(t0, tcg_constant_tl(rd >> 1), rs_t);
-        gen_store_gpr(t0, rt);
+        gen_store_gpr_tl(t0, rt);
         break;
     case NM_REPL_QB:
         check_dsp(ctx);
@@ -2166,7 +2166,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
                      (uint32_t)imm << 8  |
                      (uint32_t)imm;
             result = (int32_t)result;
-            gen_store_gpr(tcg_constant_tl(result), rt);
+            gen_store_gpr_tl(tcg_constant_tl(result), rt);
         }
         break;
     default:
@@ -2229,7 +2229,7 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 
                 save_cpu_state(ctx, 1);
                 gen_helper_di(t0, tcg_env);
-                gen_store_gpr(t0, rt);
+                gen_store_gpr_tl(t0, rt);
             /* Stop translation as we may have switched the execution mode */
                 ctx->base.is_jmp = DISAS_STOP;
             }
@@ -2241,7 +2241,7 @@ static void gen_pool32axf_nanomips_insn(CPUMIPSState *env, DisasContext *ctx)
 
                 save_cpu_state(ctx, 1);
                 gen_helper_ei(t0, tcg_env);
-                gen_store_gpr(t0, rt);
+                gen_store_gpr_tl(t0, rt);
             /* Stop translation as we may have switched the execution mode */
                 ctx->base.is_jmp = DISAS_STOP;
             }
@@ -2622,29 +2622,29 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     switch (extract32(ctx->opcode, 7, 4)) {
     case NM_LBX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case NM_LHX:
     /*case NM_LHXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                         mo_endian(ctx) | MO_SW | ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case NM_LWX:
     /*case NM_LWXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                         mo_endian(ctx) | MO_SL | ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case NM_LBUX:
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_UB);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case NM_LHUX:
     /*case NM_LHUXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                         mo_endian(ctx) | MO_UW | ctx->default_tcg_memop_mask);
-        gen_store_gpr(t0, rd);
+        gen_store_gpr_tl(t0, rd);
         break;
     case NM_SBX:
         check_nms(ctx);
@@ -3041,70 +3041,70 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_CMPGU_EQ_QB:
         check_dsp(ctx);
         gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGU_LT_QB:
         check_dsp(ctx);
         gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGU_LE_QB:
         check_dsp(ctx);
         gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGDU_EQ_QB:
         check_dsp_r2(ctx);
         gen_helper_cmpgu_eq_qb(v1_t, v1_t, v2_t);
         tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGDU_LT_QB:
         check_dsp_r2(ctx);
         gen_helper_cmpgu_lt_qb(v1_t, v1_t, v2_t);
         tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_CMPGDU_LE_QB:
         check_dsp_r2(ctx);
         gen_helper_cmpgu_le_qb(v1_t, v1_t, v2_t);
         tcg_gen_deposit_tl(cpu_dspctrl, cpu_dspctrl, v1_t, 24, 4);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PACKRL_PH:
         check_dsp(ctx);
         gen_helper_packrl_ph(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PICK_QB:
         check_dsp(ctx);
         gen_helper_pick_qb(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PICK_PH:
         check_dsp(ctx);
         gen_helper_pick_ph(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_ADDQ_S_W:
         check_dsp(ctx);
         gen_helper_addq_s_w(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SUBQ_S_W:
         check_dsp(ctx);
         gen_helper_subq_s_w(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_ADDSC:
         check_dsp(ctx);
         gen_helper_addsc(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_ADDWC:
         check_dsp(ctx);
         gen_helper_addwc(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_ADDQ_S_PH:
         check_dsp(ctx);
@@ -3112,12 +3112,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* ADDQ_PH */
             gen_helper_addq_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* ADDQ_S_PH */
             gen_helper_addq_s_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3127,12 +3127,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* ADDQH_PH */
             gen_helper_addqh_ph(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* ADDQH_R_PH */
             gen_helper_addqh_r_ph(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3142,12 +3142,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* ADDQH_W */
             gen_helper_addqh_w(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* ADDQH_R_W */
             gen_helper_addqh_r_w(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3157,12 +3157,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* ADDU_QB */
             gen_helper_addu_qb(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* ADDU_S_QB */
             gen_helper_addu_s_qb(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3172,12 +3172,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* ADDU_PH */
             gen_helper_addu_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* ADDU_S_PH */
             gen_helper_addu_s_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3187,12 +3187,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* ADDUH_QB */
             gen_helper_adduh_qb(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* ADDUH_R_QB */
             gen_helper_adduh_r_qb(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3202,12 +3202,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SHRAV_PH */
             gen_helper_shra_ph(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SHRAV_R_PH */
             gen_helper_shra_r_ph(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3217,12 +3217,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SHRAV_QB */
             gen_helper_shra_qb(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SHRAV_R_QB */
             gen_helper_shra_r_qb(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3232,12 +3232,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SUBQ_PH */
             gen_helper_subq_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SUBQ_S_PH */
             gen_helper_subq_s_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3247,12 +3247,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SUBQH_PH */
             gen_helper_subqh_ph(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SUBQH_R_PH */
             gen_helper_subqh_r_ph(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3262,12 +3262,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SUBQH_W */
             gen_helper_subqh_w(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SUBQH_R_W */
             gen_helper_subqh_r_w(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3277,12 +3277,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SUBU_QB */
             gen_helper_subu_qb(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SUBU_S_QB */
             gen_helper_subu_s_qb(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3292,12 +3292,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SUBU_PH */
             gen_helper_subu_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SUBU_S_PH */
             gen_helper_subu_s_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3307,12 +3307,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SUBUH_QB */
             gen_helper_subuh_qb(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SUBUH_R_QB */
             gen_helper_subuh_r_qb(v1_t, v1_t, v2_t);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3322,12 +3322,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SHLLV_PH */
             gen_helper_shll_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* SHLLV_S_PH */
             gen_helper_shll_s_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
@@ -3340,7 +3340,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
                 TCGv_i32 sa_t = tcg_constant_i32(rd);
                 gen_helper_precr_sra_ph_w(v1_t, sa_t, v1_t,
                                           cpu_gpr[rt]);
-                gen_store_gpr(v1_t, rt);
+                gen_store_gpr_tl(v1_t, rt);
             }
             break;
         case 1:
@@ -3349,7 +3349,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
                 TCGv_i32 sa_t = tcg_constant_i32(rd);
                 gen_helper_precr_sra_r_ph_w(v1_t, sa_t, v1_t,
                                             cpu_gpr[rt]);
-                gen_store_gpr(v1_t, rt);
+                gen_store_gpr_tl(v1_t, rt);
             }
             break;
        }
@@ -3357,32 +3357,32 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_MULEU_S_PH_QBL:
         check_dsp(ctx);
         gen_helper_muleu_s_ph_qbl(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MULEU_S_PH_QBR:
         check_dsp(ctx);
         gen_helper_muleu_s_ph_qbr(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MULQ_RS_PH:
         check_dsp(ctx);
         gen_helper_mulq_rs_ph(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MULQ_S_PH:
         check_dsp_r2(ctx);
         gen_helper_mulq_s_ph(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MULQ_RS_W:
         check_dsp_r2(ctx);
         gen_helper_mulq_rs_w(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MULQ_S_W:
         check_dsp_r2(ctx);
         gen_helper_mulq_s_w(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_APPEND:
         check_dsp_r2(ctx);
@@ -3395,32 +3395,32 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_MODSUB:
         check_dsp(ctx);
         gen_helper_modsub(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHRAV_R_W:
         check_dsp(ctx);
         gen_helper_shra_r_w(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHRLV_PH:
         check_dsp_r2(ctx);
         gen_helper_shrl_ph(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHRLV_QB:
         check_dsp(ctx);
         gen_helper_shrl_qb(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHLLV_QB:
         check_dsp(ctx);
         gen_helper_shll_qb(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHLLV_S_W:
         check_dsp(ctx);
         gen_helper_shll_s_w(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHILO:
         check_dsp(ctx);
@@ -3434,12 +3434,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_MULEQ_S_W_PHL:
         check_dsp(ctx);
         gen_helper_muleq_s_w_phl(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MULEQ_S_W_PHR:
         check_dsp(ctx);
         gen_helper_muleq_s_w_phr(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_MUL_S_PH:
         check_dsp_r2(ctx);
@@ -3447,44 +3447,44 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* MUL_PH */
             gen_helper_mul_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         case 1:
             /* MUL_S_PH */
             gen_helper_mul_s_ph(v1_t, v1_t, v2_t, tcg_env);
-            gen_store_gpr(v1_t, ret);
+            gen_store_gpr_tl(v1_t, ret);
             break;
         }
         break;
     case NM_PRECR_QB_PH:
         check_dsp_r2(ctx);
         gen_helper_precr_qb_ph(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PRECRQ_QB_PH:
         check_dsp(ctx);
         gen_helper_precrq_qb_ph(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PRECRQ_PH_W:
         check_dsp(ctx);
         gen_helper_precrq_ph_w(v1_t, v1_t, v2_t);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PRECRQ_RS_PH_W:
         check_dsp(ctx);
         gen_helper_precrq_rs_ph_w(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_PRECRQU_S_QB_PH:
         check_dsp(ctx);
         gen_helper_precrqu_s_qb_ph(v1_t, v1_t, v2_t, tcg_env);
-        gen_store_gpr(v1_t, ret);
+        gen_store_gpr_tl(v1_t, ret);
         break;
     case NM_SHRA_R_W:
         check_dsp(ctx);
         gen_helper_shra_r_w(v1_t, tcg_constant_tl(rd), v1_t);
-        gen_store_gpr(v1_t, rt);
+        gen_store_gpr_tl(v1_t, rt);
         break;
     case NM_SHRA_R_PH:
         check_dsp(ctx);
@@ -3493,12 +3493,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SHRA_PH */
             gen_helper_shra_ph(v1_t, t0, v1_t);
-            gen_store_gpr(v1_t, rt);
+            gen_store_gpr_tl(v1_t, rt);
             break;
         case 1:
             /* SHRA_R_PH */
             gen_helper_shra_r_ph(v1_t, t0, v1_t);
-            gen_store_gpr(v1_t, rt);
+            gen_store_gpr_tl(v1_t, rt);
             break;
         }
         break;
@@ -3509,12 +3509,12 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         case 0:
             /* SHLL_PH */
             gen_helper_shll_ph(v1_t, t0, v1_t, tcg_env);
-            gen_store_gpr(v1_t, rt);
+            gen_store_gpr_tl(v1_t, rt);
             break;
         case 2:
             /* SHLL_S_PH */
             gen_helper_shll_s_ph(v1_t, t0, v1_t, tcg_env);
-            gen_store_gpr(v1_t, rt);
+            gen_store_gpr_tl(v1_t, rt);
             break;
         default:
             gen_reserved_instruction(ctx);
@@ -3524,7 +3524,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_SHLL_S_W:
         check_dsp(ctx);
         gen_helper_shll_s_w(v1_t, tcg_constant_tl(rd), v1_t, tcg_env);
-        gen_store_gpr(v1_t, rt);
+        gen_store_gpr_tl(v1_t, rt);
         break;
     case NM_REPL_PH:
         check_dsp(ctx);
@@ -3787,7 +3787,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 imm = extract32(ctx->opcode, 0, 12);
                 gen_load_gpr_tl(t0, rs);
                 tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, imm);
-                gen_store_gpr(t0, rt);
+                gen_store_gpr_tl(t0, rt);
             }
             break;
         case NM_ADDIUNEG:
@@ -4106,7 +4106,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         case NM_UALH:
                             tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
                                             mo_endian(ctx) | MO_SW | MO_UNALN);
-                            gen_store_gpr(t0, rt);
+                            gen_store_gpr_tl(t0, rt);
                             break;
                         case NM_UASH:
                             gen_load_gpr_tl(t1, rt);
@@ -4292,7 +4292,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         case NM_LWM:
                             tcg_gen_qemu_ld_tl(t1, va, ctx->mem_idx,
                                                memop | mo_endian(ctx) | MO_SL);
-                            gen_store_gpr(t1, this_rt);
+                            gen_store_gpr_tl(t1, this_rt);
                             if ((this_rt == rs) &&
                                 (counter != (count - 1))) {
                                 /* UNPREDICTABLE */
-- 
2.45.2


