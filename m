Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7255C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmJA-000182-NY; Wed, 24 Apr 2024 19:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIe-00013I-HR
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:45:22 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmIS-0002AS-R3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:45:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e411e339b8so3245605ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714002303; x=1714607103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JlF9yvG1tLc13jMw+Ez3fV/BsqlR5r0EuFKx522bnZo=;
 b=Xf4Jx93BGQgaFgNC/2KdpdvncCH8K2VWWRnLThuKSUsp8jrijtqb5abO6g0FWdUecn
 yn1PG5HdMI+9IGZxOrz3883zXh7tUN0rlfAYzyZxxWWXRWbgeBQ6NIEOeOK6yWzU8cWs
 E4d2l3g7pC5DkTMXTRbmntayJ+StbHhE9oq1/RrvzuQmNAg5FA5l4vohbNIZ5MyilgDM
 SUipHFXPI0GfAyJ67D+qYtfDhMLEehQt5xODcPQtAD52/nzP69eA1yuFsY1V3ooY+kda
 qiz8yoFfbU/nxdbrM3/3Hw8xLQ501Ql94ZHynI5upp7NwmhcQqv9kcenPcevNxabxxEp
 q+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714002303; x=1714607103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlF9yvG1tLc13jMw+Ez3fV/BsqlR5r0EuFKx522bnZo=;
 b=AL3tsF2NhyTQYuP5EOe4W+DSkNVR7uPkx+L0ITLR+SapMDD/CoZ8RA84iz+r1AjtA8
 UBxt1LeKnuWKX2Xe3KtbAY++eKken/hVkC75SdhoqlX1CSOeZxDkCR55haFd4KMdGErg
 tmD1TKf/J2JxddizPA+BbCKS33yrlBEEQ8FO4X09rZYLPZRQpz6wF4Tl0XKgj2Jzdkpc
 o1WF7RCkublggV8ISbtOYWOs7K/oXE+QwibxceKUhK0u6251SVrS+8yKcA+zvVvGAWln
 wzNY4DHrWrrU4pNzrgz9mOg9k40Ss1ZXyVpvnYo/2nzxfPVRtxaeCyyypkz9zg6wOjlJ
 DAhQ==
X-Gm-Message-State: AOJu0YzAvPoEr8wOALjPyEj/gBfYih9ggxe6YqubrtaIkbDU7PyYdENh
 02IZgOm9ibS+temZjrvyd3kdldS0poVntn9zYpcZ8FNEEdkTjZOnZ5sNunhFicFp6IeC6b8DBky
 d
X-Google-Smtp-Source: AGHT+IFCvRXg8dHDLiD1M+vNfxcUv15yZDg6K9YTTm84+xR8pv7OsZzhnrvTmZcJb4TyhlXDxowtGw==
X-Received: by 2002:a17:903:22ca:b0:1e7:b6f4:2d75 with SMTP id
 y10-20020a17090322ca00b001e7b6f42d75mr5699216plg.6.1714002302734; 
 Wed, 24 Apr 2024 16:45:02 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 h17-20020a170902f55100b001e49428f327sm12531642plf.176.2024.04.24.16.44.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:45:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] target/alpha: Split out gen_pc_disp
Date: Wed, 24 Apr 2024 16:44:35 -0700
Message-Id: <20240424234436.995410-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424234436.995410-1-richard.henderson@linaro.org>
References: <20240424234436.995410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Prepare for pcrel by not modifying cpu_pc before use,
in the case of JSR.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 41 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index c1a55e5153..86402d96d5 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -252,6 +252,11 @@ static void st_flag_byte(TCGv val, unsigned shift)
     tcg_gen_st8_i64(val, tcg_env, get_flag_ofs(shift));
 }
 
+static void gen_pc_disp(DisasContext *ctx, TCGv dest, int32_t disp)
+{
+    tcg_gen_movi_i64(dest, ctx->base.pc_next + disp);
+}
+
 static void gen_excp_1(int exception, int error_code)
 {
     TCGv_i32 tmp1, tmp2;
@@ -263,7 +268,7 @@ static void gen_excp_1(int exception, int error_code)
 
 static DisasJumpType gen_excp(DisasContext *ctx, int exception, int error_code)
 {
-    tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+    gen_pc_disp(ctx, cpu_pc, 0);
     gen_excp_1(exception, error_code);
     return DISAS_NORETURN;
 }
@@ -427,14 +432,12 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
 
 static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
-    uint64_t dest = ctx->base.pc_next + disp;
-
-    if (translator_use_goto_tb(&ctx->base, dest)) {
+    if (translator_use_goto_tb(&ctx->base, ctx->base.pc_next + disp)) {
         tcg_gen_goto_tb(idx);
-        tcg_gen_movi_i64(cpu_pc, dest);
+        gen_pc_disp(ctx, cpu_pc, disp);
         tcg_gen_exit_tb(ctx->base.tb, idx);
     } else {
-        tcg_gen_movi_i64(cpu_pc, dest);
+        gen_pc_disp(ctx, cpu_pc, disp);
         tcg_gen_lookup_and_goto_ptr();
     }
 }
@@ -442,7 +445,7 @@ static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 static DisasJumpType gen_bdirect(DisasContext *ctx, int ra, int32_t disp)
 {
     if (ra != 31) {
-        tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
+        gen_pc_disp(ctx, ctx->ir[ra], 0);
     }
 
     /* Notice branch-to-next; used to initialize RA with the PC.  */
@@ -1091,7 +1094,7 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
             }
 
             /* Allow interrupts to be recognized right away.  */
-            tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+            gen_pc_disp(ctx, cpu_pc, 0);
             return DISAS_PC_UPDATED_NOCHAIN;
 
         case 0x36:
@@ -1138,19 +1141,17 @@ static DisasJumpType gen_call_pal(DisasContext *ctx, int palcode)
 #else
     {
         TCGv tmp = tcg_temp_new();
-        uint64_t exc_addr = ctx->base.pc_next;
-        uint64_t entry = ctx->palbr;
+        uint64_t entry;
 
+        gen_pc_disp(ctx, tmp, 0);
         if (ctx->tbflags & ENV_FLAG_PAL_MODE) {
-            exc_addr |= 1;
+            tcg_gen_ori_i64(tmp, tmp, 1);
         } else {
-            tcg_gen_movi_i64(tmp, 1);
-            st_flag_byte(tmp, ENV_FLAG_PAL_SHIFT);
+            st_flag_byte(tcg_constant_i64(1), ENV_FLAG_PAL_SHIFT);
         }
-
-        tcg_gen_movi_i64(tmp, exc_addr);
         tcg_gen_st_i64(tmp, tcg_env, offsetof(CPUAlphaState, exc_addr));
 
+        entry = ctx->palbr;
         entry += (palcode & 0x80
                   ? 0x2000 + (palcode - 0x80) * 64
                   : 0x1000 + palcode * 64);
@@ -2344,9 +2345,13 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         /* JMP, JSR, RET, JSR_COROUTINE.  These only differ by the branch
            prediction stack action, which of course we don't implement.  */
         vb = load_gpr(ctx, rb);
-        tcg_gen_andi_i64(cpu_pc, vb, ~3);
         if (ra != 31) {
-            tcg_gen_movi_i64(ctx->ir[ra], ctx->base.pc_next);
+            tmp = tcg_temp_new();
+            tcg_gen_andi_i64(tmp, vb, ~3);
+            gen_pc_disp(ctx, ctx->ir[ra], 0);
+            tcg_gen_mov_i64(cpu_pc, tmp);
+        } else {
+            tcg_gen_andi_i64(cpu_pc, vb, ~3);
         }
         ret = DISAS_PC_UPDATED;
         break;
@@ -2908,7 +2913,7 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         gen_goto_tb(ctx, 0, 0);
         break;
     case DISAS_PC_STALE:
-        tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
+        gen_pc_disp(ctx, cpu_pc, 0);
         /* FALLTHRU */
     case DISAS_PC_UPDATED:
         tcg_gen_lookup_and_goto_ptr();
-- 
2.34.1


