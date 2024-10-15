Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B94D1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jmZ-0001eJ-4o; Tue, 15 Oct 2024 11:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmI-0001N5-0Z
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmE-00014a-Bq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:05 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cb47387ceso31127195ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007281; x=1729612081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rF1ojij3TR1AnKGJCPi5nkzBARfzhp/al33DST0Rg3Y=;
 b=LApVN5UgdZt/JwSYovHFzzaUQ2E8r77qRd03CaQMetILwDSZOKmNWjG9evaarQkmkh
 +DT4BiUs88HyT288gqxPzNnzqGTYIYTBuHik5rBXeUQaO9p0pOnS+Fjg3G9alLuCkehq
 RLnbZ0Twdb4TTO3uwngVf/TYc+sBUo7fKzW1P8jdyIDcKToxVh7SvM1x6ix/9V4Kk487
 FHMZx1ofkzm/1bF2HbXfwCvt/YsovBM4mj5yXPsUJV+n5KhcYiFcVpE4+tlPj8oHHE/+
 EfvVTR8QxRJDu3dsgTEfus2MnFI/f7Nh4uiHW0hq7BtGhrUaxuknPVo56vTBzcNJJdBA
 OmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007281; x=1729612081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rF1ojij3TR1AnKGJCPi5nkzBARfzhp/al33DST0Rg3Y=;
 b=XiJKRBvonTm+r+q+sW4pS9P8R4oCvfMZiAG7XXHuXQcY3VCgCNRjoiMMlCgK5PCmo0
 7Z/ju+hFARS2qcxCxgoy4IjGRxp1m2jUp8N9uqBzemXcBl1xO7piIm/8g+uRLtV/5p5m
 kOIQC5zgj9o3xWGU8+ql5EoOg3asCTbSI713m77D9G0mNF4+IavCFuUyf8v8rlK3gLBv
 FEr3p7C1vp6G+ewVX4DqRbvhRvbXQordufSgLL/gU+20FHuvtfyYUTlc4t6Gd3Zj1emM
 bksB/RukplpXF3wva6Ox9mf0m86L40kgNSJcm52TjKcRzUisCRwP7KF3Mxf2nZrjudl2
 j0KQ==
X-Gm-Message-State: AOJu0Yyp25sRz1YSG5CiHticMcev9O6nBeytJmd/FZjhEPsSTzAh5md8
 g9nFo+t95QJca9s2ynz5ICIltn9THUH9TcfSMzO/UPKpkISBAwt+Dql33C5s/XPCxAyvEvkhaPu
 D
X-Google-Smtp-Source: AGHT+IH+MexrVQm53bi9vE+yz0yk9ZhkfNgoP0rj+56anG7hG6CB06HErI3x+E4eADvtPV+KpqMprA==
X-Received: by 2002:a17:902:d491:b0:20c:c694:f6c6 with SMTP id
 d9443c01a7336-20d27f2763dmr8964315ad.49.1729007280181; 
 Tue, 15 Oct 2024 08:48:00 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1807100asm13473155ad.304.2024.10.15.08.47.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:47:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 27/33] target/mips: Replace MO_TE by mo_endian()
Date: Tue, 15 Oct 2024 12:44:36 -0300
Message-ID: <20241015154443.71763-28-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace compile-time MO_TE evaluation by runtime mo_endian() one,
which expand target endianness from DisasContext.

Mechanical change using:

  $ sed -i -e 's/MO_TE/mo_endian(ctx)/' \
     $(git grep -l MO_TE target/mips)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241010215015.44326-11-philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c           |  10 +-
 target/mips/tcg/translate.c               | 120 +++++++++++-----------
 target/mips/tcg/tx79_translate.c          |   8 +-
 target/mips/tcg/micromips_translate.c.inc |  22 ++--
 target/mips/tcg/mips16e_translate.c.inc   |  12 +--
 target/mips/tcg/nanomips_translate.c.inc  |  37 ++++---
 6 files changed, 106 insertions(+), 103 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index dd512ce7a48..35ebb0397da 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -4803,19 +4803,19 @@ static void decode_opc_mxu__pool17(DisasContext *ctx)
 
     switch (opcode) {
     case OPC_MXU_LXW:
-          gen_mxu_lxx(ctx, strd2, MO_TE | MO_UL);
+          gen_mxu_lxx(ctx, strd2, mo_endian(ctx) | MO_UL);
           break;
     case OPC_MXU_LXB:
-          gen_mxu_lxx(ctx, strd2, MO_TE | MO_SB);
+          gen_mxu_lxx(ctx, strd2, mo_endian(ctx) | MO_SB);
           break;
     case OPC_MXU_LXH:
-          gen_mxu_lxx(ctx, strd2, MO_TE | MO_SW);
+          gen_mxu_lxx(ctx, strd2, mo_endian(ctx) | MO_SW);
           break;
     case OPC_MXU_LXBU:
-          gen_mxu_lxx(ctx, strd2, MO_TE | MO_UB);
+          gen_mxu_lxx(ctx, strd2, mo_endian(ctx) | MO_UB);
           break;
     case OPC_MXU_LXHU:
-          gen_mxu_lxx(ctx, strd2, MO_TE | MO_UW);
+          gen_mxu_lxx(ctx, strd2, mo_endian(ctx) | MO_UW);
           break;
     default:
         MIPS_INVAL("decode_opc_mxu");
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6ba8371658c..c0b97539a29 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1964,9 +1964,9 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
     gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(mem_idx));      \
 }
 #endif
-OP_LD_ATOMIC(ll, MO_TE | MO_SL);
+OP_LD_ATOMIC(ll, mo_endian(ctx) | MO_SL);
 #if defined(TARGET_MIPS64)
-OP_LD_ATOMIC(lld, MO_TE | MO_UQ);
+OP_LD_ATOMIC(lld, mo_endian(ctx) | MO_UQ);
 #endif
 #undef OP_LD_ATOMIC
 
@@ -2073,12 +2073,12 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_LWU:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LD:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2090,33 +2090,33 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LDL:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxl(ctx, t1, t0, mem_idx, MO_TE | MO_UQ);
+        gen_lxl(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxr(ctx, t1, t0, mem_idx, MO_TE | MO_UQ);
+        gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr(t1, rt);
         break;
     case OPC_LDPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UQ);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr(t0, rt);
         break;
 #endif
     case OPC_LWPC:
         t1 = tcg_constant_tl(pc_relative_pc(ctx));
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_SL);
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SL);
         gen_store_gpr(t0, rt);
         break;
     case OPC_LWE:
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LW:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_SL |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2124,7 +2124,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LH:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_SW |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_SW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2132,7 +2132,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_LHU:
-        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, MO_TE | MO_UW |
+        tcg_gen_qemu_ld_tl(t0, t0, mem_idx, mo_endian(ctx) | MO_UW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -2156,7 +2156,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LWL:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxl(ctx, t1, t0, mem_idx, MO_TE | MO_UL);
+        gen_lxl(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
         break;
@@ -2166,7 +2166,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     case OPC_LWR:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        gen_lxr(ctx, t1, t0, mem_idx, MO_TE | MO_UL);
+        gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
         tcg_gen_ext32s_tl(t1, t1);
         gen_store_gpr(t1, rt);
         break;
@@ -2194,7 +2194,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
     switch (opc) {
 #if defined(TARGET_MIPS64)
     case OPC_SD:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SDL:
@@ -2208,14 +2208,14 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_SW:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SHE:
         mem_idx = MIPS_HFLAG_UM;
         /* fall through */
     case OPC_SH:
-        tcg_gen_qemu_st_tl(t1, t0, mem_idx, MO_TE | MO_UW |
+        tcg_gen_qemu_st_tl(t1, t0, mem_idx, mo_endian(ctx) | MO_UW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_SBE:
@@ -2281,7 +2281,7 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
     case OPC_LWC1:
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
-            tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_SL |
+            tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                                 ctx->default_tcg_memop_mask);
             gen_store_fpr32(ctx, fp0, ft);
         }
@@ -2290,14 +2290,14 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, ft);
-            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_UL |
+            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                                 ctx->default_tcg_memop_mask);
         }
         break;
     case OPC_LDC1:
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ |
+            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                                 ctx->default_tcg_memop_mask);
             gen_store_fpr64(ctx, fp0, ft);
         }
@@ -2306,7 +2306,7 @@ static void gen_flt_ldst(DisasContext *ctx, uint32_t opc, int ft,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, ft);
-            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ |
+            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                                 ctx->default_tcg_memop_mask);
         }
         break;
@@ -2987,14 +2987,14 @@ static inline void gen_pcrel(DisasContext *ctx, int opc, target_ulong pc,
     case R6_OPC_LWPC:
         offset = sextract32(ctx->opcode << 2, 0, 21);
         addr = addr_add(ctx, pc, offset);
-        gen_r6_ld(addr, rs, ctx->mem_idx, MO_TE | MO_SL);
+        gen_r6_ld(addr, rs, ctx->mem_idx, mo_endian(ctx) | MO_SL);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_LWUPC:
         check_mips_64(ctx);
         offset = sextract32(ctx->opcode << 2, 0, 21);
         addr = addr_add(ctx, pc, offset);
-        gen_r6_ld(addr, rs, ctx->mem_idx, MO_TE | MO_UL);
+        gen_r6_ld(addr, rs, ctx->mem_idx, mo_endian(ctx) | MO_UL);
         break;
 #endif
     default:
@@ -3021,7 +3021,7 @@ static inline void gen_pcrel(DisasContext *ctx, int opc, target_ulong pc,
             check_mips_64(ctx);
             offset = sextract32(ctx->opcode << 3, 0, 21);
             addr = addr_add(ctx, (pc & ~0x7), offset);
-            gen_r6_ld(addr, rs, ctx->mem_idx, MO_TE | MO_UQ);
+            gen_r6_ld(addr, rs, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
             break;
 #endif
         default:
@@ -4160,10 +4160,10 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
     case OPC_GSLQ:
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rt);
         gen_store_gpr(t0, lsq_rt1);
@@ -4172,10 +4172,10 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         check_cp1_enabled(ctx);
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_fpr64(ctx, t1, rt);
         gen_store_fpr64(ctx, t0, lsq_rt1);
@@ -4184,11 +4184,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
         gen_load_gpr(t1, lsq_rt1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_GSSQC1:
@@ -4196,11 +4196,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         t1 = tcg_temp_new();
         gen_base_offset_addr(ctx, t0, rs, lsq_offset);
         gen_load_fpr64(ctx, t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
         gen_load_fpr64(ctx, t1, lsq_rt1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
 #endif
@@ -4213,7 +4213,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_load_fpr32(ctx, fp0, rt);
             t1 = tcg_temp_new();
             tcg_gen_ext_i32_tl(t1, fp0);
-            gen_lxl(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UL);
+            gen_lxl(ctx, t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL);
             tcg_gen_trunc_tl_i32(fp0, t1);
             gen_store_fpr32(ctx, fp0, rt);
             break;
@@ -4224,7 +4224,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_load_fpr32(ctx, fp0, rt);
             t1 = tcg_temp_new();
             tcg_gen_ext_i32_tl(t1, fp0);
-            gen_lxr(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UL);
+            gen_lxr(ctx, t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL);
             tcg_gen_trunc_tl_i32(fp0, t1);
             gen_store_fpr32(ctx, fp0, rt);
             break;
@@ -4234,7 +4234,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_base_offset_addr(ctx, t0, rs, shf_offset);
             t1 = tcg_temp_new();
             gen_load_fpr64(ctx, t1, rt);
-            gen_lxl(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UQ);
+            gen_lxl(ctx, t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
             gen_store_fpr64(ctx, t1, rt);
             break;
         case OPC_GSLDRC1:
@@ -4242,7 +4242,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             gen_base_offset_addr(ctx, t0, rs, shf_offset);
             t1 = tcg_temp_new();
             gen_load_fpr64(ctx, t1, rt);
-            gen_lxr(ctx, t1, t0, ctx->mem_idx, MO_TE | MO_UQ);
+            gen_lxr(ctx, t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
             gen_store_fpr64(ctx, t1, rt);
             break;
 #endif
@@ -4360,7 +4360,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         gen_store_gpr(t0, rt);
         break;
     case OPC_GSLHX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SW |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SW |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -4369,7 +4369,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SL |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -4379,7 +4379,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rt);
         break;
@@ -4390,7 +4390,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
         fp0 = tcg_temp_new_i32();
-        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_SL |
+        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                             ctx->default_tcg_memop_mask);
         gen_store_fpr32(ctx, fp0, rt);
         break;
@@ -4400,7 +4400,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_fpr64(ctx, t0, rt);
         break;
@@ -4413,34 +4413,34 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
     case OPC_GSSHX:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UW |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UW |
                            ctx->default_tcg_memop_mask);
         break;
     case OPC_GSSWX:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSSDX:
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
 #endif
     case OPC_GSSWXC1:
         fp0 = tcg_temp_new_i32();
         gen_load_fpr32(ctx, fp0, rt);
-        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                             ctx->default_tcg_memop_mask);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSSDXC1:
         t1 = tcg_temp_new();
         gen_load_fpr64(ctx, t1, rt);
-        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                             ctx->default_tcg_memop_mask);
         break;
 #endif
@@ -10779,7 +10779,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
 
-            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SL);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
             tcg_gen_trunc_tl_i32(fp0, t0);
             gen_store_fpr32(ctx, fp0, fd);
         }
@@ -10789,7 +10789,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         check_cp1_registers(ctx, fd);
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
+            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
             gen_store_fpr64(ctx, fp0, fd);
         }
         break;
@@ -10799,7 +10799,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
 
-            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
+            tcg_gen_qemu_ld_i64(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
             gen_store_fpr64(ctx, fp0, fd);
         }
         break;
@@ -10808,7 +10808,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i32 fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, fs);
-            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TE | MO_UL);
+            tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL);
         }
         break;
     case OPC_SDXC1:
@@ -10817,7 +10817,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, fs);
-            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
+            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
         }
         break;
     case OPC_SUXC1:
@@ -10826,7 +10826,7 @@ static void gen_flt3_ldst(DisasContext *ctx, uint32_t opc,
         {
             TCGv_i64 fp0 = tcg_temp_new_i64();
             gen_load_fpr64(ctx, fp0, fs);
-            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, MO_TE | MO_UQ);
+            tcg_gen_qemu_st_i64(fp0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
         }
         break;
     }
@@ -11476,7 +11476,7 @@ void gen_ldxs(DisasContext *ctx, int base, int index, int rd)
         gen_op_addr_add(ctx, t0, t1, t0);
     }
 
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
     gen_store_gpr(t1, rd);
 }
 
@@ -11567,16 +11567,16 @@ static void gen_mips_lx(DisasContext *ctx, uint32_t opc,
         gen_store_gpr(t0, rd);
         break;
     case OPC_LHX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SW);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SW);
         gen_store_gpr(t0, rd);
         break;
     case OPC_LWX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_SL);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL);
         gen_store_gpr(t0, rd);
         break;
 #if defined(TARGET_MIPS64)
     case OPC_LDX:
-        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TE | MO_UQ);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
         gen_store_gpr(t0, rd);
         break;
 #endif
@@ -13719,7 +13719,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case R6_OPC_SC:
-        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_SL, false);
+        gen_st_cond(ctx, rt, rs, imm, mo_endian(ctx) | MO_SL, false);
         break;
     case R6_OPC_LL:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -13765,7 +13765,7 @@ static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 #endif
 #if defined(TARGET_MIPS64)
     case R6_OPC_SCD:
-        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_UQ, false);
+        gen_st_cond(ctx, rt, rs, imm, mo_endian(ctx) | MO_UQ, false);
         break;
     case R6_OPC_LLD:
         gen_ld(ctx, op1, rt, rs, imm);
@@ -14448,7 +14448,7 @@ static void decode_opc_special3(CPUMIPSState *env, DisasContext *ctx)
             return;
         case OPC_SCE:
             check_cp0_enabled(ctx);
-            gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_SL, true);
+            gen_st_cond(ctx, rt, rs, imm, mo_endian(ctx) | MO_SL, true);
             return;
         case OPC_CACHEE:
             check_eva(ctx);
@@ -14912,7 +14912,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
         if (ctx->insn_flags & INSN_R5900) {
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
-        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_SL, false);
+        gen_st_cond(ctx, rt, rs, imm, mo_endian(ctx) | MO_SL, false);
         break;
     case OPC_CACHE:
         check_cp0_enabled(ctx);
@@ -15191,7 +15191,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             check_insn_opc_user_only(ctx, INSN_R5900);
         }
         check_mips_64(ctx);
-        gen_st_cond(ctx, rt, rs, imm, MO_TE | MO_UQ, false);
+        gen_st_cond(ctx, rt, rs, imm, mo_endian(ctx) | MO_UQ, false);
         break;
     case OPC_BNVC: /* OPC_BNEZALC, OPC_BNEC, OPC_DADDI */
         if (ctx->insn_flags & ISA_MIPS_R6) {
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index 1d290b86a98..ae3f5e19c43 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -340,12 +340,12 @@ static bool trans_LQ(DisasContext *ctx, arg_i *a)
     tcg_gen_andi_tl(addr, addr, ~0xf);
 
     /* Lower half */
-    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
     gen_store_gpr(t0, a->rt);
 
     /* Upper half */
     tcg_gen_addi_i64(addr, addr, 8);
-    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_ld_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
     gen_store_gpr_hi(t0, a->rt);
     return true;
 }
@@ -364,12 +364,12 @@ static bool trans_SQ(DisasContext *ctx, arg_i *a)
 
     /* Lower half */
     gen_load_gpr(t0, a->rt);
-    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
 
     /* Upper half */
     tcg_gen_addi_i64(addr, addr, 8);
     gen_load_gpr_hi(t0, a->rt);
-    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, MO_TE | MO_UQ);
+    tcg_gen_qemu_st_i64(t0, addr, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
     return true;
 }
 
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 343d64a0e85..171508f7deb 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -977,23 +977,23 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
             gen_reserved_instruction(ctx);
             return;
         }
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
         tcg_gen_movi_tl(t1, 4);
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_SL |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
         break;
     case SWP:
         gen_load_gpr(t1, rd);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         tcg_gen_movi_tl(t1, 4);
         gen_op_addr_add(ctx, t0, t0, t1);
         gen_load_gpr(t1, rd + 1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         break;
 #ifdef TARGET_MIPS64
@@ -1002,23 +1002,23 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
             gen_reserved_instruction(ctx);
             return;
         }
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd);
         tcg_gen_movi_tl(t1, 8);
         gen_op_addr_add(ctx, t0, t0, t1);
-        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr(t1, rd + 1);
         break;
     case SDP:
         gen_load_gpr(t1, rd);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         tcg_gen_movi_tl(t1, 8);
         gen_op_addr_add(ctx, t0, t0, t1);
         gen_load_gpr(t1, rd + 1);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UQ |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         break;
 #endif
@@ -2572,13 +2572,13 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
             gen_st(ctx, mips32_op, rt, rs, offset);
             break;
         case SC:
-            gen_st_cond(ctx, rt, rs, offset, MO_TE | MO_SL, false);
+            gen_st_cond(ctx, rt, rs, offset, mo_endian(ctx) | MO_SL, false);
             break;
 #if defined(TARGET_MIPS64)
         case SCD:
             check_insn(ctx, ISA_MIPS3);
             check_mips_64(ctx);
-            gen_st_cond(ctx, rt, rs, offset, MO_TE | MO_UQ, false);
+            gen_st_cond(ctx, rt, rs, offset, mo_endian(ctx) | MO_UQ, false);
             break;
 #endif
         case LD_EVA:
@@ -2659,7 +2659,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
                 mips32_op = OPC_SHE;
                 goto do_st_lr;
             case SCE:
-                gen_st_cond(ctx, rt, rs, offset, MO_TE | MO_SL, true);
+                gen_st_cond(ctx, rt, rs, offset, mo_endian(ctx) | MO_SL, true);
                 break;
             case SWE:
                 mips32_op = OPC_SWE;
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index f80d35225e8..ef7a0ec0d38 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -135,7 +135,7 @@ static void decr_and_store(DisasContext *ctx, unsigned regidx, TCGv t0)
     tcg_gen_movi_tl(t2, -4);
     gen_op_addr_add(ctx, t0, t0, t2);
     gen_load_gpr(t1, regidx);
-    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                        ctx->default_tcg_memop_mask);
 }
 
@@ -184,25 +184,25 @@ static void gen_mips16_save(DisasContext *ctx,
     case 4:
         gen_base_offset_addr(ctx, t0, 29, 12);
         gen_load_gpr(t1, 7);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 3:
         gen_base_offset_addr(ctx, t0, 29, 8);
         gen_load_gpr(t1, 6);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 2:
         gen_base_offset_addr(ctx, t0, 29, 4);
         gen_load_gpr(t1, 5);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 1:
         gen_base_offset_addr(ctx, t0, 29, 0);
         gen_load_gpr(t1, 4);
-        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TE | MO_UL |
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
     }
 
@@ -297,7 +297,7 @@ static void decr_and_load(DisasContext *ctx, unsigned regidx, TCGv t0)
 
     tcg_gen_movi_tl(t2, -4);
     gen_op_addr_add(ctx, t0, t0, t2);
-    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TESL |
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TE | MO_SL |
                        ctx->default_tcg_memop_mask);
     gen_store_gpr(t1, regidx);
 }
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 06204585f23..d462173348f 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -998,7 +998,8 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
     TCGv tmp2 = tcg_temp_new();
 
     gen_base_offset_addr(ctx, taddr, base, offset);
-    tcg_gen_qemu_ld_i64(tval, taddr, ctx->mem_idx, MO_TE | MO_UQ | MO_ALIGN);
+    tcg_gen_qemu_ld_i64(tval, taddr, ctx->mem_idx,
+                        mo_endian(ctx) | MO_UQ | MO_ALIGN);
     if (disas_is_bigendian(ctx)) {
         tcg_gen_extr_i64_tl(tmp2, tmp1, tval);
     } else {
@@ -1075,7 +1076,7 @@ static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
         gen_base_offset_addr(ctx, va, 29, this_offset);
         gen_load_gpr(t0, this_rt);
         tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
-                           MO_TE | MO_UL | ctx->default_tcg_memop_mask);
+                          mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask);
         counter++;
     }
 
@@ -1095,8 +1096,8 @@ static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
         int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
         int this_offset = u - ((counter + 1) << 2);
         gen_base_offset_addr(ctx, va, 29, this_offset);
-        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx, MO_TE | MO_SL |
-                        ctx->default_tcg_memop_mask);
+        tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx,
+                          mo_endian(ctx) | MO_SL | ctx->default_tcg_memop_mask);
         tcg_gen_ext32s_tl(t0, t0);
         gen_store_gpr(t0, this_rt);
         counter++;
@@ -2647,13 +2648,13 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     case NM_LHX:
     /*case NM_LHXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                           MO_TE | MO_SW | ctx->default_tcg_memop_mask);
+                        mo_endian(ctx) | MO_SW | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_LWX:
     /*case NM_LWXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                           MO_TE | MO_SL | ctx->default_tcg_memop_mask);
+                        mo_endian(ctx) | MO_SL | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_LBUX:
@@ -2663,7 +2664,7 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
     case NM_LHUX:
     /*case NM_LHUXS:*/
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                           MO_TE | MO_UW | ctx->default_tcg_memop_mask);
+                        mo_endian(ctx) | MO_UW | ctx->default_tcg_memop_mask);
         gen_store_gpr(t0, rd);
         break;
     case NM_SBX:
@@ -2676,14 +2677,14 @@ static void gen_p_lsx(DisasContext *ctx, int rd, int rs, int rt)
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                           MO_TE | MO_UW | ctx->default_tcg_memop_mask);
+                        mo_endian(ctx) | MO_UW | ctx->default_tcg_memop_mask);
         break;
     case NM_SWX:
     /*case NM_SWXS:*/
         check_nms(ctx);
         gen_load_gpr(t1, rd);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                           MO_TE | MO_UL | ctx->default_tcg_memop_mask);
+                        mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask);
         break;
     case NM_LWC1X:
     /*case NM_LWC1XS:*/
@@ -3737,7 +3738,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
 
                     tcg_gen_movi_tl(t0, addr);
                     tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx,
-                                       MO_TE | MO_SL
+                                       mo_endian(ctx) | MO_SL
                                             | ctx->default_tcg_memop_mask);
                 }
                 break;
@@ -3755,7 +3756,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     gen_load_gpr(t1, rt);
 
                     tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                                       MO_TE | MO_UL
+                                       mo_endian(ctx) | MO_UL
                                             | ctx->default_tcg_memop_mask);
                 }
                 break;
@@ -4135,13 +4136,13 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         switch (extract32(ctx->opcode, 11, 4)) {
                         case NM_UALH:
                             tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx,
-                                               MO_TE | MO_SW | MO_UNALN);
+                                            mo_endian(ctx) | MO_SW | MO_UNALN);
                             gen_store_gpr(t0, rt);
                             break;
                         case NM_UASH:
                             gen_load_gpr(t1, rt);
                             tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
-                                               MO_TE | MO_UW | MO_UNALN);
+                                            mo_endian(ctx) | MO_UW | MO_UNALN);
                             break;
                         }
                     }
@@ -4163,7 +4164,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 case NM_P_SC:
                     switch (ctx->opcode & 0x03) {
                     case NM_SC:
-                        gen_st_cond(ctx, rt, rs, s, MO_TE | MO_SL, false);
+                        gen_st_cond(ctx, rt, rs, s, mo_endian(ctx) | MO_SL,
+                                    false);
                         break;
                     case NM_SCWP:
                         check_xnp(ctx);
@@ -4276,7 +4278,8 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         check_xnp(ctx);
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
-                        gen_st_cond(ctx, rt, rs, s, MO_TE | MO_SL, true);
+                        gen_st_cond(ctx, rt, rs, s, mo_endian(ctx) | MO_SL,
+                                    true);
                         break;
                     case NM_SCWPE:
                         check_xnp(ctx);
@@ -4319,7 +4322,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         switch (extract32(ctx->opcode, 11, 1)) {
                         case NM_LWM:
                             tcg_gen_qemu_ld_tl(t1, va, ctx->mem_idx,
-                                               memop | MO_TE | MO_SL);
+                                               memop | mo_endian(ctx) | MO_SL);
                             gen_store_gpr(t1, this_rt);
                             if ((this_rt == rs) &&
                                 (counter != (count - 1))) {
@@ -4330,7 +4333,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                             this_rt = (rt == 0) ? 0 : this_rt;
                             gen_load_gpr(t1, this_rt);
                             tcg_gen_qemu_st_tl(t1, va, ctx->mem_idx,
-                                               memop | MO_TE | MO_UL);
+                                               memop | mo_endian(ctx) | MO_UL);
                             break;
                         }
                         counter++;
-- 
2.45.2


