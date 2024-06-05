Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A8FC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydn-0001om-Vg; Wed, 05 Jun 2024 17:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydm-0001oD-7C
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:54 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydk-0003se-1O
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:53 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7025cb09553so226020b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624671; x=1718229471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRuvGrqklc35nzRDLd0HrPdmqm1+emdl+BYV+uq1dAc=;
 b=HzLxhWhZQVXxxgu7JJr9R0XVwvssL2uzFRqRdC2PU5FhBG8JmeDekwzcJCy/YmriqG
 WV4lWc7f0Kr54XtbaGhx68zH7kreMOv6y1XvqiWi8xr0QX96kORPVuj6WpSnNNWOig6c
 jWyK5HTZmbLQNS6e08/n3CU7vHAMX+26IdbtvIk/TEBpB8GJnUksFBBQSUINDAf21zEO
 E2THfZn4o5iJ4WOO7a5ba4uD0qU1VAzPD2PB2f1s2cyWFJEp299QxKGNXzj9zdonwqnj
 pCZPeztCZWRnPuvnm3n8vOiFIBaOelWh04QhEEBryRskfJArnT2vBpWjJ+R4G/3R4V4I
 4kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624671; x=1718229471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRuvGrqklc35nzRDLd0HrPdmqm1+emdl+BYV+uq1dAc=;
 b=DS5BoZSOLt4r9p7k1H46bWS010hquY/ZAb3zzrvzS+0rYtU7aDxoJ1tXqTIN9DWK2n
 aIAqhweIqW2je6p7gJ/oZ9mcQXK3h9k8cFLnWf1wsxW+O2LAKmQDCmv/Pc1X5gNafQ/A
 RUXpQTFi98CMJFn4qtKMR94nC2a7DV1/xKlkT0Aw+ioad8IJCI0zxvyJrondpcehJr0z
 3BLaseO+cm6S4fV9y4gzX26U5Fz/B4qFOfzpMPnBTmO4PKWZp9hqZngXgbFFxmyRzpx/
 BTb92ZjvC6lpjX0LZwD0i+PuTHFvjxAWyIY3DTXvNIOl4NztTIZirmAFXoHoepEKDYKe
 lO/Q==
X-Gm-Message-State: AOJu0YzFZaxwBmKW5GNNPogr53aldzLxDksGbNKT4ajcrk259NMgTbP+
 596jlFi89vFGivcWcc1Ca/IJeXW8n5jCHciw6lgvNyUQAmJcrDbgR84XPd+G7liA7jV0YXW7QjJ
 B
X-Google-Smtp-Source: AGHT+IGAvJtLaEroWLFRohRF83/+MUK+sNOWMrs1nDO/I1qhfyzNlcOR+JqLhLUIwq0uiN6VMNz8Tw==
X-Received: by 2002:a05:6a20:430f:b0:1af:dae8:5ea2 with SMTP id
 adf61e73a8af0-1b2b710b40fmr4629477637.48.1717624670756; 
 Wed, 05 Jun 2024 14:57:50 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PATCH v2 10/10] target/s390x: Enable CF_PCREL
Date: Wed,  5 Jun 2024 14:57:39 -0700
Message-Id: <20240605215739.4758-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/cpu.c           | 17 +++++++++
 target/s390x/tcg/translate.c | 71 +++++++++++++++++++++++-------------
 2 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index c786767bd1..9f03190c35 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -39,6 +39,7 @@
 #include "sysemu/reset.h"
 #endif
 #include "hw/s390x/cpu-topology.h"
+#include "exec/translation-block.h"
 
 #define CR0_RESET       0xE0UL
 #define CR14_RESET      0xC2000000UL;
@@ -111,6 +112,16 @@ uint64_t s390_cpu_get_psw_mask(CPUS390XState *env)
     return r;
 }
 
+static void s390_cpu_synchronize_from_tb(CPUState *cs,
+                                         const TranslationBlock *tb)
+{
+    /* The program counter is always up to date with CF_PCREL. */
+    if (!(tb_cflags(tb) & CF_PCREL)) {
+        CPUS390XState *env = cpu_env(cs);
+        env->psw.addr = tb->pc;
+    }
+}
+
 static void s390_cpu_set_pc(CPUState *cs, vaddr value)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -246,6 +257,11 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     S390CPUClass *scc = S390_CPU_GET_CLASS(dev);
     Error *err = NULL;
 
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
+    /* Use pc-relative instructions in system-mode */
+    cs->tcg_cflags |= CF_PCREL;
+#endif
+
     /* the model has to be realized before qemu_init_vcpu() due to kvm */
     s390_realize_cpu_model(cs, &err);
     if (err) {
@@ -368,6 +384,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 
 static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
+    .synchronize_from_tb = s390_cpu_synchronize_from_tb,
     .restore_state_to_opc = s390x_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0ee14484d0..6961ad7c67 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -139,6 +139,7 @@ struct DisasFields {
 struct DisasContext {
     DisasContextBase base;
     const DisasInsn *insn;
+    target_ulong pc_save;
     DisasFields fields;
     uint64_t ex_value;
     uint32_t ilen;
@@ -161,28 +162,6 @@ static uint64_t inline_branch_hit[CC_OP_MAX];
 static uint64_t inline_branch_miss[CC_OP_MAX];
 #endif
 
-static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
-{
-    tcg_gen_movi_i64(dest, s->base.pc_next + disp);
-}
-
-static void pc_to_link_info(TCGv_i64 out, DisasContext *s)
-{
-    TCGv_i64 tmp;
-
-    if (s->base.tb->flags & FLAG_MASK_64) {
-        gen_psw_addr_disp(s, out, s->ilen);
-        return;
-    }
-
-    tmp = tcg_temp_new_i64();
-    gen_psw_addr_disp(s, tmp, s->ilen);
-    if (s->base.tb->flags & FLAG_MASK_32) {
-        tcg_gen_ori_i64(tmp, tmp, 0x80000000);
-    }
-    tcg_gen_deposit_i64(out, out, tmp, 0, 32);
-}
-
 static TCGv_i64 psw_addr;
 static TCGv_i64 psw_mask;
 static TCGv_i64 gbea;
@@ -338,6 +317,34 @@ static void store_freg32_i64(int reg, TCGv_i64 v)
     tcg_gen_st32_i64(v, tcg_env, freg32_offset(reg));
 }
 
+static void gen_psw_addr_disp(DisasContext *s, TCGv_i64 dest, int64_t disp)
+{
+    assert(s->pc_save != -1);
+    if (tb_cflags(s->base.tb) & CF_PCREL) {
+        disp += s->base.pc_next - s->pc_save;
+        tcg_gen_addi_i64(dest, psw_addr, disp);
+    } else {
+        tcg_gen_movi_i64(dest, s->base.pc_next + disp);
+    }
+}
+
+static void pc_to_link_info(TCGv_i64 out, DisasContext *s)
+{
+    TCGv_i64 tmp;
+
+    if (s->base.tb->flags & FLAG_MASK_64) {
+        gen_psw_addr_disp(s, out, s->ilen);
+        return;
+    }
+
+    tmp = tcg_temp_new_i64();
+    gen_psw_addr_disp(s, tmp, s->ilen);
+    if (s->base.tb->flags & FLAG_MASK_32) {
+        tcg_gen_ori_i64(tmp, tmp, 0x80000000);
+    }
+    tcg_gen_deposit_i64(out, out, tmp, 0, 32);
+}
+
 static void per_branch(DisasContext *s, TCGv_i64 dest)
 {
 #ifndef CONFIG_USER_ONLY
@@ -1081,13 +1088,13 @@ static DisasJumpType help_goto_direct(DisasContext *s, int64_t disp)
     if (disp == s->ilen) {
         return DISAS_NEXT;
     }
+    gen_psw_addr_disp(s, psw_addr, disp);
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(0);
-        gen_psw_addr_disp(s, psw_addr, disp);
         tcg_gen_exit_tb(s->base.tb, 0);
         return DISAS_NORETURN;
     } else {
-        gen_psw_addr_disp(s, psw_addr, disp);
+        s->pc_save = dest;
         return DISAS_PC_CC_UPDATED;
     }
 }
@@ -1097,6 +1104,7 @@ static DisasJumpType help_goto_indirect(DisasContext *s, TCGv_i64 dest)
     update_cc_op(s);
     per_breaking_event(s);
     tcg_gen_mov_i64(psw_addr, dest);
+    s->pc_save = -1;
     per_branch(s, psw_addr);
     return DISAS_PC_CC_UPDATED;
 }
@@ -1173,6 +1181,7 @@ static DisasJumpType help_branch(DisasContext *s, DisasCompare *c,
         tcg_gen_exit_tb(s->base.tb, 1);
         return DISAS_NORETURN;
     }
+    s->pc_save = s->base.pc_next + s->ilen;
     return DISAS_PC_CC_UPDATED;
 }
 
@@ -2351,6 +2360,7 @@ static DisasJumpType op_ex(DisasContext *s, DisasOps *o)
     }
 
     gen_psw_addr_disp(s, psw_addr, 0);
+    s->pc_save = s->base.pc_next;
     update_cc_op(s);
 
     if (r1 == 0) {
@@ -6411,6 +6421,7 @@ static void s390x_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     /* Note cpu_get_tb_cpu_state asserts PC is masked for the mode. */
 
+    dc->pc_save = dc->base.pc_first;
     dc->cc_op = CC_OP_DYNAMIC;
     dc->ex_value = dc->base.tb->cs_base;
     dc->exit_to_mainloop = dc->ex_value;
@@ -6423,9 +6434,13 @@ static void s390x_tr_tb_start(DisasContextBase *db, CPUState *cs)
 static void s390x_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
+    target_ulong pc_arg = dc->base.pc_next;
 
+    if (tb_cflags(dc->base.tb) & CF_PCREL) {
+        pc_arg &= ~TARGET_PAGE_MASK;
+    }
     /* Delay the set of ilen until we've read the insn. */
-    tcg_gen_insn_start(dc->base.pc_next, dc->cc_op, 0);
+    tcg_gen_insn_start(pc_arg, dc->cc_op, 0);
 }
 
 static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
@@ -6517,7 +6532,11 @@ void s390x_restore_state_to_opc(CPUState *cs,
     CPUS390XState *env = cpu_env(cs);
     int cc_op = data[1];
 
-    env->psw.addr = data[0];
+    if (tb_cflags(tb) & CF_PCREL) {
+        env->psw.addr = (env->psw.addr & TARGET_PAGE_MASK) | data[0];
+    } else {
+        env->psw.addr = data[0];
+    }
 
     /* Update the CC opcode if it is not already up-to-date.  */
     if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
-- 
2.34.1


