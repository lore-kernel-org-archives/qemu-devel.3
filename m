Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17224CFC27C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jn2-0002Jc-6C; Tue, 15 Oct 2024 11:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmb-0001ol-H4
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:25 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jmY-000167-Sy
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:48:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e52582d0bso2350674b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007301; x=1729612101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYwNktTZHv8KqjRIkaVDg1GGkNJdQJLxA26N0R0p2/A=;
 b=JGQJUPasqB4KFBuwc2WkUUgQSEA63aQTC6DHZ+TuZfuZ8H0lNv4+lfVj3OCtH7njaX
 Mc7UlYUmRL3TcNj7Rh4sDlQPRqWp9Hkv/b+fKbMq9cG2n3dPe5vHe03hL30LRh4wQx/p
 tz+oEXXacimMvKHGM2F0st72XSDpvphxfr4dM6g+4ConbjM4l2eBIg5lGojCAYhYeVEg
 HSA65B8CpRnxqBB/+3njZxeeYK0QoiQ6+yecB8KDzV5hNwIXPWz6SW5eqC0yeL1Zf+oS
 L3Cn0P3cmYlZOoWLshVWqZ7Ke5ao5zIa0n5kT71j8IpX6LrjwQtu8OdomddcHG7tDRFL
 ExlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007301; x=1729612101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYwNktTZHv8KqjRIkaVDg1GGkNJdQJLxA26N0R0p2/A=;
 b=hnPOEy3y7LlgOtxubgzyeBuRb7AXZd8AV0TO+VjPSYXV+wyz33JPL+4wDn/+ElhcnI
 NAxkA3eSqgoB919/B11JmPy3+pWzknFEOFbLxlojf6oga1O8obiJ4sepcEHL3NgFh4Eq
 HUn264f3ZlR+TsMbkNXqvnBCiJnsGjsBzwp83+p5xcd8a84T6M/TAykg7rSl2TKrodRP
 og9Ow0FknM8QPOe1fr4i+ipKbCxbq84zPLFD/qI9BajtR03Y80xwVnKmlGlP4wvqLwgk
 hJKebiHCk5ELzpObkKG7dLaPNSowGxg/B+H+yqyhsOxY8cIFYfH1BdtfXSsrrckufuzk
 wMGQ==
X-Gm-Message-State: AOJu0Yx0ng0yygoyHUClQ0nZopZ/mJ6Eaff1aYjBbxIGjYrnDmeb2+T0
 7iOZwPxo5WwaKgbhZv8kmPJrBXw2DFJztE7eTdX8qo1fY9ZaipT1Qzc7dC9EOTr4dVL7qqpCBjl
 2
X-Google-Smtp-Source: AGHT+IEDuif9gfwzdonR0c+XULx137TEUFxil7KRx4EKhzkrcOLYdEf4HvHh8IMiC1bQxLoljbUR6Q==
X-Received: by 2002:a05:6a20:9f47:b0:1d4:fc75:8d48 with SMTP id
 adf61e73a8af0-1d8c9576f8emr18859424637.3.1729007300934; 
 Tue, 15 Oct 2024 08:48:20 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e77371740sm1418859b3a.40.2024.10.15.08.48.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:48:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 30/33] target/mips: Use tcg_constant_tl() instead of
 tcg_gen_movi_tl()
Date: Tue, 15 Oct 2024 12:44:39 -0300
Message-ID: <20241015154443.71763-31-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42d.google.com
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

Directly use tcg_constant_tl() for constant integer, this
save a call to tcg_gen_movi_tl(), often saving a temp register.

Most of the places found using the following Coccinelle spatch script:

  @@
  identifier tmp;
  constant val;
  @@
  *    TCGv tmp = tcg_temp_new();
       ...
  *    tcg_gen_movi_tl(tmp, val);

  @@
  identifier tmp;
  int val;
  @@
  *    TCGv tmp = tcg_temp_new();
       ...
  *    tcg_gen_movi_i64(tmp, val);

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241004202621.4321-2-philmd@linaro.org>
---
 target/mips/tcg/translate.c              |  49 ++++------
 target/mips/tcg/nanomips_translate.c.inc | 111 +++++++++--------------
 2 files changed, 59 insertions(+), 101 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 53a0cbf92be..d92fc418edd 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2252,8 +2252,7 @@ static void gen_st_cond(DisasContext *ctx, int rt, int base, int offset,
     /* compare the address against that of the preceding LL */
     gen_base_offset_addr(ctx, addr, base, offset);
     tcg_gen_brcond_tl(TCG_COND_EQ, addr, cpu_lladdr, l1);
-    tcg_gen_movi_tl(t0, 0);
-    gen_store_gpr(t0, rt);
+    gen_store_gpr(tcg_constant_tl(0), rt);
     tcg_gen_br(done);
 
     gen_set_label(l1);
@@ -3059,8 +3058,7 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
@@ -3076,30 +3074,27 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
         break;
     case R6_OPC_DIVU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
             tcg_gen_ext32u_tl(t0, t0);
             tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_divu_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
         break;
     case R6_OPC_MODU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
             tcg_gen_ext32u_tl(t0, t0);
             tcg_gen_ext32u_tl(t1, t1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_remu_tl(cpu_gpr[rd], t0, t1);
             tcg_gen_ext32s_tl(cpu_gpr[rd], cpu_gpr[rd]);
         }
@@ -3154,8 +3149,7 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_gpr[rd], t0, t1);
         }
         break;
@@ -3168,24 +3162,21 @@ static void gen_r6_muldiv(DisasContext *ctx, int opc, int rd, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_rem_tl(cpu_gpr[rd], t0, t1);
         }
         break;
     case R6_OPC_DDIVU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_divu_i64(cpu_gpr[rd], t0, t1);
         }
         break;
     case R6_OPC_DMODU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_remu_i64(cpu_gpr[rd], t0, t1);
         }
         break;
@@ -3238,8 +3229,7 @@ static void gen_div1_tx79(DisasContext *ctx, uint32_t opc, int rs, int rt)
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_LO[1], t0, t1);
             tcg_gen_rem_tl(cpu_HI[1], t0, t1);
             tcg_gen_ext32s_tl(cpu_LO[1], cpu_LO[1]);
@@ -3294,8 +3284,7 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_LO[acc], t0, t1);
             tcg_gen_rem_tl(cpu_HI[acc], t0, t1);
             tcg_gen_ext32s_tl(cpu_LO[acc], cpu_LO[acc]);
@@ -3347,17 +3336,15 @@ static void gen_muldiv(DisasContext *ctx, uint32_t opc,
             tcg_gen_and_tl(t2, t2, t3);
             tcg_gen_setcondi_tl(TCG_COND_EQ, t3, t1, 0);
             tcg_gen_or_tl(t2, t2, t3);
-            tcg_gen_movi_tl(t3, 0);
-            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, t3, t2, t1);
+            tcg_gen_movcond_tl(TCG_COND_NE, t1, t2, tcg_constant_tl(0), t2, t1);
             tcg_gen_div_tl(cpu_LO[acc], t0, t1);
             tcg_gen_rem_tl(cpu_HI[acc], t0, t1);
         }
         break;
     case OPC_DDIVU:
         {
-            TCGv t2 = tcg_constant_tl(0);
-            TCGv t3 = tcg_constant_tl(1);
-            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1, t2, t3, t1);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t1,
+                               tcg_constant_tl(0), tcg_constant_tl(1), t1);
             tcg_gen_divu_i64(cpu_LO[acc], t0, t1);
             tcg_gen_remu_i64(cpu_HI[acc], t0, t1);
         }
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 8e05a36b545..1e274143bbd 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -1053,8 +1053,7 @@ static void gen_scwp(DisasContext *ctx, uint32_t base, int16_t offset,
         tcg_gen_movi_tl(cpu_gpr[reg1], 0);
     }
     gen_set_label(lab_done);
-    tcg_gen_movi_tl(lladdr, -1);
-    tcg_gen_st_tl(lladdr, tcg_env, offsetof(CPUMIPSState, lladdr));
+    tcg_gen_st_tl(tcg_constant_tl(-1), tcg_env, offsetof(CPUMIPSState, lladdr));
 }
 
 static void gen_adjust_sp(DisasContext *ctx, int u)
@@ -1544,7 +1543,6 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
 {
     int16_t imm;
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
     TCGv v0_t = tcg_temp_new();
 
     gen_load_gpr(v0_t, v1);
@@ -1571,12 +1569,10 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         check_dsp(ctx);
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_MTHLIP:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            gen_helper_mthlip(t0, v0_t, tcg_env);
+            gen_helper_mthlip(tcg_constant_tl(v2 >> 3), v0_t, tcg_env);
             break;
         case NM_SHILOV:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            gen_helper_shilo(t0, v0_t, tcg_env);
+            gen_helper_shilo(tcg_constant_tl(v2 >> 3), v0_t, tcg_env);
             break;
         default:
             gen_reserved_instruction(ctx);
@@ -1588,39 +1584,34 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         imm = extract32(ctx->opcode, 14, 7);
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_RDDSP:
-            tcg_gen_movi_tl(t0, imm);
-            gen_helper_rddsp(t0, t0, tcg_env);
+            gen_helper_rddsp(t0, tcg_constant_tl(imm), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_WRDSP:
             gen_load_gpr(t0, ret);
-            tcg_gen_movi_tl(t1, imm);
-            gen_helper_wrdsp(t0, t1, tcg_env);
+            gen_helper_wrdsp(t0, tcg_constant_tl(imm), tcg_env);
             break;
         case NM_EXTP:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            tcg_gen_movi_tl(t1, v1);
-            gen_helper_extp(t0, t0, t1, tcg_env);
+            gen_helper_extp(t0, tcg_constant_tl(v2 >> 3),
+                            tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTPDP:
-            tcg_gen_movi_tl(t0, v2 >> 3);
-            tcg_gen_movi_tl(t1, v1);
-            gen_helper_extpdp(t0, t0, t1, tcg_env);
+            gen_helper_extpdp(t0, tcg_constant_tl(v2 >> 3),
+                              tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
         break;
     case NM_POOL32AXF_1_4:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, v2 >> 2);
         switch (extract32(ctx->opcode, 12, 1)) {
         case NM_SHLL_QB:
-            gen_helper_shll_qb(t0, t0, v0_t, tcg_env);
+            gen_helper_shll_qb(t0, tcg_constant_tl(v2 >> 2), v0_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_SHRL_QB:
-            gen_helper_shrl_qb(t0, t0, v0_t);
+            gen_helper_shrl_qb(t0, tcg_constant_tl(v2 >> 2), v0_t);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1631,23 +1622,25 @@ static void gen_pool32axf_1_nanomips_insn(DisasContext *ctx, uint32_t opc,
         break;
     case NM_POOL32AXF_1_7:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, v2 >> 3);
-        tcg_gen_movi_tl(t1, v1);
         switch (extract32(ctx->opcode, 12, 2)) {
         case NM_EXTR_W:
-            gen_helper_extr_w(t0, t0, t1, tcg_env);
+            gen_helper_extr_w(t0, tcg_constant_tl(v2 >> 3),
+                              tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTR_R_W:
-            gen_helper_extr_r_w(t0, t0, t1, tcg_env);
+            gen_helper_extr_r_w(t0, tcg_constant_tl(v2 >> 3),
+                                tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTR_RS_W:
-            gen_helper_extr_rs_w(t0, t0, t1, tcg_env);
+            gen_helper_extr_rs_w(t0, tcg_constant_tl(v2 >> 3),
+                                 tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_EXTR_S_H:
-            gen_helper_extr_s_h(t0, t0, t1, tcg_env);
+            gen_helper_extr_s_h(t0, tcg_constant_tl(v2 >> 3),
+                                tcg_constant_tl(v1), tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1849,8 +1842,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
         case NM_EXTRV_W:
             check_dsp(ctx);
             gen_load_gpr(v1_t, rs);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_w(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1904,8 +1896,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_R_W:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_r_w(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_r_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         default:
@@ -1924,8 +1915,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTPV:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extp(t0, t0, v1_t, tcg_env);
+            gen_helper_extp(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_MSUB:
@@ -1948,8 +1938,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_RS_W:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_rs_w(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_rs_w(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -1965,8 +1954,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTPDPV:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extpdp(t0, t0, v1_t, tcg_env);
+            gen_helper_extpdp(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         case NM_MSUBU:
@@ -1991,8 +1979,7 @@ static void gen_pool32axf_2_nanomips_insn(DisasContext *ctx, uint32_t opc,
             break;
         case NM_EXTRV_S_H:
             check_dsp(ctx);
-            tcg_gen_movi_tl(t0, rd >> 3);
-            gen_helper_extr_s_h(t0, t0, v1_t, tcg_env);
+            gen_helper_extr_s_h(t0, tcg_constant_tl(rd >> 3), v1_t, tcg_env);
             gen_store_gpr(t0, ret);
             break;
         }
@@ -2150,24 +2137,22 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
     switch (opc) {
     case NM_SHRA_R_QB:
         check_dsp_r2(ctx);
-        tcg_gen_movi_tl(t0, rd >> 2);
         switch (extract32(ctx->opcode, 12, 1)) {
         case 0:
             /* NM_SHRA_QB */
-            gen_helper_shra_qb(t0, t0, rs_t);
+            gen_helper_shra_qb(t0, tcg_constant_tl(rd >> 2), rs_t);
             gen_store_gpr(t0, rt);
             break;
         case 1:
             /* NM_SHRA_R_QB */
-            gen_helper_shra_r_qb(t0, t0, rs_t);
+            gen_helper_shra_r_qb(t0, tcg_constant_tl(rd >> 2), rs_t);
             gen_store_gpr(t0, rt);
             break;
         }
         break;
     case NM_SHRL_PH:
         check_dsp_r2(ctx);
-        tcg_gen_movi_tl(t0, rd >> 1);
-        gen_helper_shrl_ph(t0, t0, rs_t);
+        gen_helper_shrl_ph(t0, tcg_constant_tl(rd >> 1), rs_t);
         gen_store_gpr(t0, rt);
         break;
     case NM_REPL_QB:
@@ -2181,8 +2166,7 @@ static void gen_pool32axf_7_nanomips_insn(DisasContext *ctx, uint32_t opc,
                      (uint32_t)imm << 8  |
                      (uint32_t)imm;
             result = (int32_t)result;
-            tcg_gen_movi_tl(t0, result);
-            gen_store_gpr(t0, rt);
+            gen_store_gpr(tcg_constant_tl(result), rt);
         }
         break;
     default:
@@ -2303,10 +2287,9 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
 {
     TCGCond cond = TCG_COND_ALWAYS;
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
+    TCGv timm = tcg_constant_tl(imm);
 
     gen_load_gpr(t0, rt);
-    tcg_gen_movi_tl(t1, imm);
     ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
 
     /* Load needed operands and calculate btarget */
@@ -2335,7 +2318,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         } else {
             tcg_gen_shri_tl(t0, t0, imm);
             tcg_gen_andi_tl(t0, t0, 1);
-            tcg_gen_movi_tl(t1, 0);
+            timm = tcg_constant_tl(0);
             if (opc == NM_BBEQZC) {
                 cond = TCG_COND_EQ;
             } else {
@@ -2390,7 +2373,7 @@ static void gen_compute_imm_branch(DisasContext *ctx, uint32_t opc,
         /* Conditional compact branch */
         TCGLabel *fs = gen_new_label();
 
-        tcg_gen_brcond_tl(tcg_invert_cond(cond), t0, t1, fs);
+        tcg_gen_brcond_tl(tcg_invert_cond(cond), t0, timm, fs);
 
         gen_goto_tb(ctx, 1, ctx->btarget);
         gen_set_label(fs);
@@ -2404,7 +2387,6 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
                                                 int rt)
 {
     TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
 
     /* load rs */
     gen_load_gpr(t0, rs);
@@ -2416,8 +2398,7 @@ static void gen_compute_nanomips_pbalrsc_branch(DisasContext *ctx, int rs,
 
     /* calculate btarget */
     tcg_gen_shli_tl(t0, t0, 1);
-    tcg_gen_movi_tl(t1, ctx->base.pc_next + 4);
-    gen_op_addr_add(ctx, btarget, t1, t0);
+    gen_op_addr_add(ctx, btarget, tcg_constant_tl(ctx->base.pc_next + 4), t0);
 
     /* branch completion */
     clear_branch_hflags(ctx);
@@ -3444,13 +3425,10 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
     case NM_SHILO:
         check_dsp(ctx);
         {
-            TCGv tv0 = tcg_temp_new();
-            TCGv tv1 = tcg_temp_new();
             int16_t imm = extract32(ctx->opcode, 16, 7);
 
-            tcg_gen_movi_tl(tv0, rd >> 3);
-            tcg_gen_movi_tl(tv1, imm);
-            gen_helper_shilo(tv0, tv1, tcg_env);
+            gen_helper_shilo(tcg_constant_tl(rd >> 3),
+                             tcg_constant_tl(imm), tcg_env);
         }
         break;
     case NM_MULEQ_S_W_PHL:
@@ -3505,8 +3483,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         break;
     case NM_SHRA_R_W:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, rd);
-        gen_helper_shra_r_w(v1_t, t0, v1_t);
+        gen_helper_shra_r_w(v1_t, tcg_constant_tl(rd), v1_t);
         gen_store_gpr(v1_t, rt);
         break;
     case NM_SHRA_R_PH:
@@ -3546,8 +3523,7 @@ static void gen_pool32a5_nanomips_insn(DisasContext *ctx, int opc,
         break;
     case NM_SHLL_S_W:
         check_dsp(ctx);
-        tcg_gen_movi_tl(t0, rd);
-        gen_helper_shll_s_w(v1_t, t0, v1_t, tcg_env);
+        gen_helper_shll_s_w(v1_t, tcg_constant_tl(rd), v1_t, tcg_env);
         gen_store_gpr(v1_t, rt);
         break;
     case NM_REPL_PH:
@@ -3728,14 +3704,11 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_LWPC48:
                 check_nms(ctx);
                 if (rt != 0) {
-                    TCGv t0;
-                    t0 = tcg_temp_new();
-
                     target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
                                                 addr_off);
 
-                    tcg_gen_movi_tl(t0, addr);
-                    tcg_gen_qemu_ld_tl(cpu_gpr[rt], t0, ctx->mem_idx,
+                    tcg_gen_qemu_ld_tl(cpu_gpr[rt], tcg_constant_tl(addr),
+                                       ctx->mem_idx,
                                        mo_endian(ctx) | MO_SL
                                             | ctx->default_tcg_memop_mask);
                 }
@@ -3743,17 +3716,15 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             case NM_SWPC48:
                 check_nms(ctx);
                 {
-                    TCGv t0, t1;
-                    t0 = tcg_temp_new();
+                    TCGv t1;
                     t1 = tcg_temp_new();
 
                     target_long addr = addr_add(ctx, ctx->base.pc_next + 6,
                                                 addr_off);
 
-                    tcg_gen_movi_tl(t0, addr);
                     gen_load_gpr(t1, rt);
 
-                    tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx,
+                    tcg_gen_qemu_st_tl(t1, tcg_constant_tl(addr), ctx->mem_idx,
                                        mo_endian(ctx) | MO_UL
                                             | ctx->default_tcg_memop_mask);
                 }
-- 
2.45.2


