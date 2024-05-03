Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EC4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nEI-0001Yl-Ow; Fri, 03 May 2024 03:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nE9-0001Rz-UK
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nE8-0001Ou-5n
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa83so60090355e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720862; x=1715325662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBtqCI5zdcZgATynvjUhC/8nsk7GHPhWu+QqfEEwrBQ=;
 b=ZTVi/nuG600iqJGGTJGx6pH7KTyfhJoaChGG0ujIoNH9+99vBm+XS1kckTYrAABXRS
 SrVrI7zg84KxnGafRBYhncqkyDpuW52yon0z8fKNFXYyy+dIq9yLvf7+ilw5X4Ff4nWC
 4gWC7n+gkuzACsxtQPFjld+lo41FGMaEBFhJgOWYsCPjafbOw4haYhnxmrgOg1Qhhu8D
 /KzNarkZe48m9br9vg3woRvGXm0/aEWCRHPYkCPE6JiJkJJcnXOmdg1mcBoHwqG2xWUY
 oHDtGJBq5jUAEgZqVgQWBDG6nbBupE8KKWfa6U/tN2//eW236HwkexCeJOlUZCWiS8/8
 qg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720862; x=1715325662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iBtqCI5zdcZgATynvjUhC/8nsk7GHPhWu+QqfEEwrBQ=;
 b=ErrSCvzrgFbb4Kqu43Oa/ox1EqkEvhdJGqSGBzilXQx+eTX+PBrVTYUi4N6TdpDg8m
 ODOzUnHswRSW0BgcCiZVm3ziKqjbSgcHt8qCwgeNRlbl2DCBX8nF9VH/V5Bt8jbzZAcV
 kLPF7QdWXlJn+CIDlZFcdVvNVUfbDDU9JkgYL1NB8Cz0lzj9tfWDaaHdCFOsTT4BmpQt
 FPveeKnshK9fFWNysM4TyXyOuASKgZdjAeJQCI/on7LSbCSwQmxhuX97QTZp0Yq8BX0M
 hnbJBeVDFXYVd5jcGhHnGWRXN1iRM1V8nATRpTWExloLjwrCCWDVVL/acOyRE4+gDJFp
 IB/A==
X-Gm-Message-State: AOJu0YwzXmanfwuIbVdfZfQLTemBSiFg4qbbaiY1bvmTusSWxOUsC1rw
 oK/3oSf/6/wguWSvTONZ2Tnq9ms1/IYN0C7yL9IRkT4Y96dJKzZ9xj/SQ9/Q+iGI76xxr8+hyYT
 J
X-Google-Smtp-Source: AGHT+IGVWUZtMGiepNAcBTuGndRf87Ag6+KWHnN3F8WW9rnsRMGx8d/lAyMQC/gnS6jPH446LvF78Q==
X-Received: by 2002:a05:600c:354a:b0:418:f991:8ad4 with SMTP id
 i10-20020a05600c354a00b00418f9918ad4mr1435766wmq.6.1714720861871; 
 Fri, 03 May 2024 00:21:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 b20-20020a05600c4e1400b0041892857924sm4635480wmq.36.2024.05.03.00.21.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:21:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] target/alpha: Split out gen_pc_disp
Date: Fri,  3 May 2024 09:20:12 +0200
Message-ID: <20240503072014.24751-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Prepare for pcrel by not modifying cpu_pc before use,
in the case of JSR.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.41.0


