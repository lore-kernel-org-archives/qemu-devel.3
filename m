Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC75D3B98E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvQs-0008Nv-1G; Tue, 26 Nov 2024 08:16:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQX-0008Fy-UA
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvQU-0003cu-FX
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:25 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-434a7ee3d60so2665815e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732626980; x=1733231780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucDdwRNw1pepY0YQzDNULFb44Q37tueFbobxeDpAy74=;
 b=XyAEQbOi3frxZahQrI3Kdh4If3Zv/oBWWrLaWe6jM4gY5ofVsu2WA2ls5AQzW20uDW
 j65TXehiZTx+8IAUzo7GSynlrewh2viFAi3ltKGcg92YllcUXO3aSmKc8OtdH9/bbWRP
 LhScoLasQHvCBZP23Q02de4qvV2oI8XFufycPadnOOq9ZJ3CpZ/vya3kt4pKK2jT2cMx
 nzsgbAoC1BOGqa9qpTPvDfSP2aDkh3YNraXuUz6dJq40Dr+mLLWa42CClSmfL6m7s4rB
 pkjvhjVOrkM7cDDxTSFouZjA38GJ0192YmRXHQyjx2aW8tg1mivaAXK3+oTmvU3Uv4ME
 wTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732626980; x=1733231780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucDdwRNw1pepY0YQzDNULFb44Q37tueFbobxeDpAy74=;
 b=E2ZLnlKX5t3b76+0770SfjodTIq1W/kd9joQbzlnbAMb50AUx01Dm9C9SFSfu5aX7o
 PI8Qp/gtu9mR/gC59GsVKVHH8kyEJSGf5ca8zdLvP7ZPRpK5JsTFx5QjnnElK2sQc1Il
 3vSZmHalrzkfI+Qzknk+/kSciZfovscjz0AsH8bJb/aSu2d8Cg3EuWJBr09H0ycDor0b
 EZOiThF/NBU+y7KqV17lNKl10ANWF76orcior5U4lQVCtvC07oEuCoZT2vAt4Qp0Pk8W
 f5dEMFhqSxJUgFs8KQKu4LU1+hhX1NCfxaGl9Cy9zDOYLdnSjnsZyuwSd/skCNyyybzF
 /7TA==
X-Gm-Message-State: AOJu0YxAJJY6ExTY6z25azdE7CyZKrXQL4FKimfkIf4oos+eMl81YUs6
 ybQUCHg5J49bEhzTaJsp8mKorgzlJuWTDID7EJD7Tg7ZdWoVS/03sEEZKwkuiOKmx5w5VflwDT8
 m
X-Gm-Gg: ASbGncufnvrAaUc4bscTdULUDL7gpSAI4TaB98WqyLAzTQCkDDO4pQS8pM5n4dGsckB
 qBQ9/ZUmNl+t2Gqgr3AKzkPBDTJ6OoaHi+KTZut1VomdqQsoxBbFtdb1bGZ9tH5bsR3RcBvW9Th
 RAa4mzaLKSSz39nzKihGm+TjKTy70sW5xu0gAoPmGyAwTFRgQz5GKed0UMxYJPavG2LDGTjK5E5
 7woBziEEdG6vTsml7nPyprZAGylz4CG1PfEqjNMuN/J5xGJiTBMN9XmL7OERMxXi56kiMqO
X-Google-Smtp-Source: AGHT+IGd2SiVoYraXmqYRw+SyDf2x4155Y3w9Gyw5ld1/HXwscoDmYQkeVOXZlrrzf8x4x6y/Xpyyw==
X-Received: by 2002:a05:6000:796:b0:382:46d2:52b6 with SMTP id
 ffacd0b85a97d-385bf9a3f47mr2735341f8f.0.1732626979772; 
 Tue, 26 Nov 2024 05:16:19 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafedbcsm13472427f8f.41.2024.11.26.05.16.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 05/13] target/mips: Rename gen_base_offset_addr() ->
 gen_base_offset_addr_tl()
Date: Tue, 26 Nov 2024 14:15:37 +0100
Message-ID: <20241126131546.66145-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

MIPS gen_base_offset_addr() takes a target-specific TCGv argument.
Rename it as gen_base_offset_addr_tl() to clarify, like other TCG
core helpers.

Mechanical change doing:

  $ sed -i -e 's/gen_base_offset_addr/gen_base_offset_addr_tl/' \
     $(git grep -l gen_base_offset_addr)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.h               |  2 +-
 target/mips/tcg/msa_translate.c           |  2 +-
 target/mips/tcg/translate.c               | 54 +++++++++++------------
 target/mips/tcg/tx79_translate.c          |  4 +-
 target/mips/tcg/micromips_translate.c.inc |  4 +-
 target/mips/tcg/mips16e_translate.c.inc   |  8 ++--
 target/mips/tcg/nanomips_translate.c.inc  | 12 ++---
 7 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 90b8ac0e5b1..94dd30216f5 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -152,7 +152,7 @@ void check_cp1_64bitmode(DisasContext *ctx);
 void check_cp1_registers(DisasContext *ctx, int regs);
 void check_cop1x(DisasContext *ctx);
 
-void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset);
+void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset);
 void gen_move_low32_tl(TCGv ret, TCGv_i64 arg);
 void gen_move_high32_tl(TCGv ret, TCGv_i64 arg);
 void gen_load_gpr_tl(TCGv t, int reg);
diff --git a/target/mips/tcg/msa_translate.c b/target/mips/tcg/msa_translate.c
index 25939da4b3e..b515ee52f53 100644
--- a/target/mips/tcg/msa_translate.c
+++ b/target/mips/tcg/msa_translate.c
@@ -769,7 +769,7 @@ static bool trans_msa_ldst(DisasContext *ctx, arg_msa_i *a,
 
     taddr = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, taddr, a->ws, a->sa << a->df);
+    gen_base_offset_addr_tl(ctx, taddr, a->ws, a->sa << a->df);
     gen_msa_ldst(tcg_env, tcg_constant_i32(a->wd), taddr);
 
     return true;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 31907c75a62..667b20bccb8 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1944,7 +1944,7 @@ OP_LD_ATOMIC(lld, mo_endian(ctx) | MO_UQ);
 #endif
 #undef OP_LD_ATOMIC
 
-void gen_base_offset_addr(DisasContext *ctx, TCGv addr, int base, int offset)
+void gen_base_offset_addr_tl(DisasContext *ctx, TCGv addr, int base, int offset)
 {
     if (base == 0) {
         tcg_gen_movi_tl(addr, offset);
@@ -2042,7 +2042,7 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     }
 
     t0 = tcg_temp_new();
-    gen_base_offset_addr(ctx, t0, base, offset);
+    gen_base_offset_addr_tl(ctx, t0, base, offset);
 
     switch (opc) {
 #if defined(TARGET_MIPS64)
@@ -2163,7 +2163,7 @@ static void gen_st(DisasContext *ctx, uint32_t opc, int rt,
     TCGv t1 = tcg_temp_new();
     int mem_idx = ctx->mem_idx;
 
-    gen_base_offset_addr(ctx, t0, base, offset);
+    gen_base_offset_addr_tl(ctx, t0, base, offset);
     gen_load_gpr_tl(t1, rt);
     switch (opc) {
 #if defined(TARGET_MIPS64)
@@ -2225,7 +2225,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
     t0 = tcg_temp_new();
     addr = tcg_temp_new();
     /* compare the address against that of the preceding LL */
-    gen_base_offset_addr(ctx, addr, base, offset);
+    gen_base_offset_addr_tl(ctx, addr, base, offset);
     tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
     gen_store_gpr_tl(tcg_constant_tl(0), rt);
     tcg_gen_br(done);
@@ -2303,7 +2303,7 @@ static void gen_cop1_ldst(DisasContext *ctx, uint32_t op, int rt,
             check_insn(ctx, ISA_MIPS2);
             /* Fallthrough */
         default:
-            gen_base_offset_addr(ctx, t0, rs, imm);
+            gen_base_offset_addr_tl(ctx, t0, rs, imm);
             gen_flt_ldst(ctx, op, rt, t0);
         }
     } else {
@@ -3942,10 +3942,10 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
 #if defined(TARGET_MIPS64)
     case OPC_GSLQ:
         t1 = tcg_temp_new();
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset + 8);
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_gpr_tl(t1, rt);
@@ -3954,10 +3954,10 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
     case OPC_GSLQC1:
         check_cp1_enabled(ctx);
         t1 = tcg_temp_new();
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset);
         tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset + 8);
         tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
         gen_store_fpr64(ctx, t1, rt);
@@ -3965,11 +3965,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         break;
     case OPC_GSSQ:
         t1 = tcg_temp_new();
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset);
         gen_load_gpr_tl(t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset + 8);
         gen_load_gpr_tl(t1, lsq_rt1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
@@ -3977,11 +3977,11 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
     case OPC_GSSQC1:
         check_cp1_enabled(ctx);
         t1 = tcg_temp_new();
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset);
         gen_load_fpr64(ctx, t1, rt);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
-        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_base_offset_addr_tl(ctx, t0, rs, lsq_offset + 8);
         gen_load_fpr64(ctx, t1, lsq_rt1);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ |
                            ctx->default_tcg_memop_mask);
@@ -3991,7 +3991,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         switch (MASK_LOONGSON_GSSHFLS(ctx->opcode)) {
         case OPC_GSLWLC1:
             check_cp1_enabled(ctx);
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, rt);
             t1 = tcg_temp_new();
@@ -4002,7 +4002,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             break;
         case OPC_GSLWRC1:
             check_cp1_enabled(ctx);
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, rt);
             t1 = tcg_temp_new();
@@ -4014,7 +4014,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
 #if defined(TARGET_MIPS64)
         case OPC_GSLDLC1:
             check_cp1_enabled(ctx);
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             t1 = tcg_temp_new();
             gen_load_fpr64(ctx, t1, rt);
             gen_lxl(ctx, t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
@@ -4022,7 +4022,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
             break;
         case OPC_GSLDRC1:
             check_cp1_enabled(ctx);
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             t1 = tcg_temp_new();
             gen_load_fpr64(ctx, t1, rt);
             gen_lxr(ctx, t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UQ);
@@ -4040,7 +4040,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         case OPC_GSSWLC1:
             check_cp1_enabled(ctx);
             t1 = tcg_temp_new();
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, rt);
             tcg_gen_ext_i32_tl(t1, fp0);
@@ -4049,7 +4049,7 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         case OPC_GSSWRC1:
             check_cp1_enabled(ctx);
             t1 = tcg_temp_new();
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             fp0 = tcg_temp_new_i32();
             gen_load_fpr32(ctx, fp0, rt);
             tcg_gen_ext_i32_tl(t1, fp0);
@@ -4059,14 +4059,14 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         case OPC_GSSDLC1:
             check_cp1_enabled(ctx);
             t1 = tcg_temp_new();
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             gen_load_fpr64(ctx, t1, rt);
             gen_helper_0e2i(sdl, t1, t0, ctx->mem_idx);
             break;
         case OPC_GSSDRC1:
             check_cp1_enabled(ctx);
             t1 = tcg_temp_new();
-            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_base_offset_addr_tl(ctx, t0, rs, shf_offset);
             gen_load_fpr64(ctx, t1, rt);
             gen_helper_0e2i(sdr, t1, t0, ctx->mem_idx);
             break;
@@ -4134,7 +4134,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
 
     t0 = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, t0, rs, offset);
+    gen_base_offset_addr_tl(ctx, t0, rs, offset);
     gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
 
     switch (opc) {
@@ -4148,7 +4148,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         gen_store_gpr_tl(t0, rt);
         break;
     case OPC_GSLWX:
-        gen_base_offset_addr(ctx, t0, rs, offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
@@ -4158,7 +4158,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSLDX:
-        gen_base_offset_addr(ctx, t0, rs, offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
@@ -4168,7 +4168,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         break;
 #endif
     case OPC_GSLWXC1:
-        gen_base_offset_addr(ctx, t0, rs, offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
@@ -4179,7 +4179,7 @@ static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
         break;
 #if defined(TARGET_MIPS64)
     case OPC_GSLDXC1:
-        gen_base_offset_addr(ctx, t0, rs, offset);
+        gen_base_offset_addr_tl(ctx, t0, rs, offset);
         if (rd) {
             gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
         }
@@ -11229,7 +11229,7 @@ static void gen_cache_operation(DisasContext *ctx, uint32_t op, int base,
 {
     TCGv_i32 t0 = tcg_constant_i32(op);
     TCGv t1 = tcg_temp_new();
-    gen_base_offset_addr(ctx, t1, base, offset);
+    gen_base_offset_addr_tl(ctx, t1, base, offset);
     gen_helper_cache(tcg_env, t1, t0);
 }
 
diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index 90d63e5dfc4..2694f41a318 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -332,7 +332,7 @@ static bool trans_LQ(DisasContext *ctx, arg_i *a)
     t0 = tcg_temp_new_i64();
     addr = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, addr, a->base, a->offset);
+    gen_base_offset_addr_tl(ctx, addr, a->base, a->offset);
     /*
      * Clear least-significant four bits of the effective
      * address, effectively creating an aligned address.
@@ -355,7 +355,7 @@ static bool trans_SQ(DisasContext *ctx, arg_i *a)
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv addr = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, addr, a->base, a->offset);
+    gen_base_offset_addr_tl(ctx, addr, a->base, a->offset);
     /*
      * Clear least-significant four bits of the effective
      * address, effectively creating an aligned address.
diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index cb3dbd264a0..69289bc13bb 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -702,7 +702,7 @@ static void gen_ldst_multiple(DisasContext *ctx, uint32_t opc, int reglist,
 
     t0 = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, t0, base, offset);
+    gen_base_offset_addr_tl(ctx, t0, base, offset);
 
     t1 = tcg_constant_tl(reglist);
     t2 = tcg_constant_i32(ctx->mem_idx);
@@ -969,7 +969,7 @@ static void gen_ldst_pair(DisasContext *ctx, uint32_t opc, int rd,
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, t0, base, offset);
+    gen_base_offset_addr_tl(ctx, t0, base, offset);
 
     switch (opc) {
     case LWP:
diff --git a/target/mips/tcg/mips16e_translate.c.inc b/target/mips/tcg/mips16e_translate.c.inc
index ceb41be0c26..754a5f7be4c 100644
--- a/target/mips/tcg/mips16e_translate.c.inc
+++ b/target/mips/tcg/mips16e_translate.c.inc
@@ -179,25 +179,25 @@ static void gen_mips16_save(DisasContext *ctx,
 
     switch (args) {
     case 4:
-        gen_base_offset_addr(ctx, t0, 29, 12);
+        gen_base_offset_addr_tl(ctx, t0, 29, 12);
         gen_load_gpr_tl(t1, 7);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 3:
-        gen_base_offset_addr(ctx, t0, 29, 8);
+        gen_base_offset_addr_tl(ctx, t0, 29, 8);
         gen_load_gpr_tl(t1, 6);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 2:
-        gen_base_offset_addr(ctx, t0, 29, 4);
+        gen_base_offset_addr_tl(ctx, t0, 29, 4);
         gen_load_gpr_tl(t1, 5);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
         /* Fall through */
     case 1:
-        gen_base_offset_addr(ctx, t0, 29, 0);
+        gen_base_offset_addr_tl(ctx, t0, 29, 0);
         gen_load_gpr_tl(t1, 4);
         tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, mo_endian(ctx) | MO_UL |
                            ctx->default_tcg_memop_mask);
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index b78381bcf54..950a4c23e70 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -997,7 +997,7 @@ static void gen_llwp(DisasContext *ctx, uint32_t base, int16_t offset,
     TCGv tmp1 = tcg_temp_new();
     TCGv tmp2 = tcg_temp_new();
 
-    gen_base_offset_addr(ctx, taddr, base, offset);
+    gen_base_offset_addr_tl(ctx, taddr, base, offset);
     tcg_gen_qemu_ld_i64(tval, taddr, ctx->mem_idx,
                         mo_endian(ctx) | MO_UQ | MO_ALIGN);
     if (disas_is_bigendian(ctx)) {
@@ -1024,7 +1024,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
     TCGLabel *lab_fail = gen_new_label();
     TCGLabel *lab_done = gen_new_label();
 
-    gen_base_offset_addr(ctx, taddr, base, offset);
+    gen_base_offset_addr_tl(ctx, taddr, base, offset);
 
     tcg_gen_ld_tl(lladdr, tcg_env, offsetof(CPUMIPSState, lladdr));
     tcg_gen_brcond_tl(TCG_COND_NE, taddr, lladdr, lab_fail);
@@ -1072,7 +1072,7 @@ static void gen_save(DisasContext *ctx, uint8_t rt, uint8_t count,
         bool use_gp = gp && (counter == count - 1);
         int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
         int this_offset = -((counter + 1) << 2);
-        gen_base_offset_addr(ctx, va, 29, this_offset);
+        gen_base_offset_addr_tl(ctx, va, 29, this_offset);
         gen_load_gpr_tl(t0, this_rt);
         tcg_gen_qemu_st_tl(t0, va, ctx->mem_idx,
                           mo_endian(ctx) | MO_UL | ctx->default_tcg_memop_mask);
@@ -1094,7 +1094,7 @@ static void gen_restore(DisasContext *ctx, uint8_t rt, uint8_t count,
         bool use_gp = gp && (counter == count - 1);
         int this_rt = use_gp ? 28 : (rt & 0x10) | ((rt + counter) & 0x1f);
         int this_offset = u - ((counter + 1) << 2);
-        gen_base_offset_addr(ctx, va, 29, this_offset);
+        gen_base_offset_addr_tl(ctx, va, 29, this_offset);
         tcg_gen_qemu_ld_tl(t0, va, ctx->mem_idx,
                           mo_endian(ctx) | MO_SL | ctx->default_tcg_memop_mask);
         tcg_gen_ext32s_tl(t0, t0);
@@ -4100,7 +4100,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         TCGv t0 = tcg_temp_new();
                         TCGv t1 = tcg_temp_new();
 
-                        gen_base_offset_addr(ctx, t0, rs, s);
+                        gen_base_offset_addr_tl(ctx, t0, rs, s);
 
                         switch (extract32(ctx->opcode, 11, 4)) {
                         case NM_UALH:
@@ -4286,7 +4286,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         int this_rt = ((rt + counter) & 0x1f) | (rt & 0x10);
                         int this_offset = offset + (counter << 2);
 
-                        gen_base_offset_addr(ctx, va, rs, this_offset);
+                        gen_base_offset_addr_tl(ctx, va, rs, this_offset);
 
                         switch (extract32(ctx->opcode, 11, 1)) {
                         case NM_LWM:
-- 
2.45.2


