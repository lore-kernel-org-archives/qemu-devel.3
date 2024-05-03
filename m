Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2360AC25B4F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nEP-0001pM-BU; Fri, 03 May 2024 03:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nEI-0001bk-2w
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nED-0001SZ-A3
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:21:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41b4ff362a8so82478865e9.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714720867; x=1715325667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQCp32MhwULxErW3cF6VE6b6u1RptQVLJu9xOLH0dkQ=;
 b=d4r9X6kQgI4R2xBTP+/PmHJsYtqBysVg3CINwa+RFLY6Us8a8zKtvjQN83cXXb2mkv
 l+r0k7AYIIuedO7G/B1Z0AaVYnd9H3nLvFowxxcs1184yljpidgdJpSOGJ0fCtxvEZcm
 UZWDIGwmGna6vNCMzgTJC88KVdRyW3M5XNy/x+BB2sIS558TwK6T1FR4BfPcf3xnmAc/
 yYB7kyDZTgWI6RNK+nhPGRy8ECjP6NVz/iI67aV21aOis1TUAufFzUMEN8Y+Vf86jHim
 SoeiJ3iraNVIDjOiF2S8XGL95YWJFYip5riJg9UUAuH2waopQQCLepcm7LPdjdiENghe
 CJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714720867; x=1715325667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EQCp32MhwULxErW3cF6VE6b6u1RptQVLJu9xOLH0dkQ=;
 b=r/k18m/kTmZyPnkxripa47ZgfPpXQmBvBsom4wM20MC6/SQNOH0OWP/4RpUYij8Vpb
 /f1dfoq4cuW+woVRodokL931YJPSmyEoBH7+fc7lh1+NLiBPh/jHGfCmitQPTuDSrId9
 fP7ttKgw1Q/i6PvtjSxrgZQMLZUFfBoBtIkIRpiZmH3Z6zeWP9u+w+zzF1rLTYb1jCuy
 PPU1UfJI0uReRHfVQP7l2eg5cczPTnG3TDveHJsLJ8Azh4fosS1UUSj7GV5O+iRvhDV0
 PW4GBULGv2DINrzHzdMYmFMTCDBcpsQL5jA8TtrX1AUizoWEv+bfuc5qMvF5lPiom3yT
 C/hQ==
X-Gm-Message-State: AOJu0Ywwz0x8scebyroi/1PijWGfdcT2Myvm+GrukM5qqmE/qga4hf/c
 WXSo33h/Xfw2Vuet/wlIHpeL2P3P85rru+QQz0x9bH05lOcon6rjsydHmH8JBtpaQmN2NuGu4wZ
 U
X-Google-Smtp-Source: AGHT+IGcTYuRhNBmXuyECvQjIuS5ZxV/+xzmf9Epgr/QCz2LwXu+dSjjTx7DkV37+YqN742j2vKFQg==
X-Received: by 2002:adf:e4c3:0:b0:34d:8fac:9540 with SMTP id
 v3-20020adfe4c3000000b0034d8fac9540mr1565830wrm.59.1714720867450; 
 Fri, 03 May 2024 00:21:07 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 r2-20020adfce82000000b0034dd7984d7fsm3011625wrn.94.2024.05.03.00.21.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 00:21:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 9/9] target/alpha: Implement CF_PCREL
Date: Fri,  3 May 2024 09:20:13 +0200
Message-ID: <20240503072014.24751-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503072014.24751-1-philmd@linaro.org>
References: <20240503072014.24751-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/cpu.c       | 23 ++++++++++++++++++++++-
 target/alpha/translate.c | 29 +++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index f98d022671..0e2fbcb397 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -38,12 +38,27 @@ static vaddr alpha_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
+static void alpha_cpu_synchronize_from_tb(CPUState *cs,
+                                          const TranslationBlock *tb)
+{
+    /* The program counter is always up to date with CF_PCREL. */
+    if (!(tb_cflags(tb) & CF_PCREL)) {
+        CPUAlphaState *env = cpu_env(cs);
+        env->pc = tb->pc;
+    }
+}
+
 static void alpha_restore_state_to_opc(CPUState *cs,
                                        const TranslationBlock *tb,
                                        const uint64_t *data)
 {
     CPUAlphaState *env = cpu_env(cs);
-    env->pc = data[0];
+
+    if (tb_cflags(tb) & CF_PCREL) {
+        env->pc = (env->pc & TARGET_PAGE_MASK) | data[0];
+    } else {
+        env->pc = data[0];
+    }
 }
 
 static bool alpha_cpu_has_work(CPUState *cs)
@@ -78,6 +93,11 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+#ifndef CONFIG_USER_ONLY
+    /* Use pc-relative instructions in system-mode */
+    cs->tcg_cflags |= CF_PCREL;
+#endif
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
@@ -190,6 +210,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 
 static const TCGCPUOps alpha_tcg_ops = {
     .initialize = alpha_translate_init,
+    .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 86402d96d5..db847e7a23 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -54,6 +54,9 @@ struct DisasContext {
     uint32_t tbflags;
     int mem_idx;
 
+    /* True if generating pc-relative code.  */
+    bool pcrel;
+
     /* implver and amask values for this CPU.  */
     int implver;
     int amask;
@@ -254,7 +257,12 @@ static void st_flag_byte(TCGv val, unsigned shift)
 
 static void gen_pc_disp(DisasContext *ctx, TCGv dest, int32_t disp)
 {
-    tcg_gen_movi_i64(dest, ctx->base.pc_next + disp);
+    uint64_t addr = ctx->base.pc_next + disp;
+    if (ctx->pcrel) {
+        tcg_gen_addi_i64(dest, cpu_pc, addr - ctx->base.pc_first);
+    } else {
+        tcg_gen_movi_i64(dest, addr);
+    }
 }
 
 static void gen_excp_1(int exception, int error_code)
@@ -433,8 +441,14 @@ static DisasJumpType gen_store_conditional(DisasContext *ctx, int ra, int rb,
 static void gen_goto_tb(DisasContext *ctx, int idx, int32_t disp)
 {
     if (translator_use_goto_tb(&ctx->base, ctx->base.pc_next + disp)) {
-        tcg_gen_goto_tb(idx);
-        gen_pc_disp(ctx, cpu_pc, disp);
+        /* With PCREL, PC must always be up-to-date. */
+        if (ctx->pcrel) {
+            gen_pc_disp(ctx, cpu_pc, disp);
+            tcg_gen_goto_tb(idx);
+        } else {
+            tcg_gen_goto_tb(idx);
+            gen_pc_disp(ctx, cpu_pc, disp);
+        }
         tcg_gen_exit_tb(ctx->base.tb, idx);
     } else {
         gen_pc_disp(ctx, cpu_pc, disp);
@@ -2852,6 +2866,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 
     ctx->tbflags = ctx->base.tb->flags;
     ctx->mem_idx = alpha_env_mmu_index(env);
+    ctx->pcrel = ctx->base.tb->cflags & CF_PCREL;
     ctx->implver = env->implver;
     ctx->amask = env->amask;
 
@@ -2887,7 +2902,13 @@ static void alpha_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 
 static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
-    tcg_gen_insn_start(dcbase->pc_next);
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    if (ctx->pcrel) {
+        tcg_gen_insn_start(dcbase->pc_next & ~TARGET_PAGE_MASK);
+    } else {
+        tcg_gen_insn_start(dcbase->pc_next);
+    }
 }
 
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.41.0


