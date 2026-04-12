Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97894F3ED6B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 02:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBkSC-0004IR-6f; Sat, 11 Apr 2026 22:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkSA-0004Fy-Eu
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:38 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wBkS8-0000Qg-Ab
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 22:21:38 -0400
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50d876329bbso36328551cf.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 19:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775960495; x=1776565295; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X6AvJKjpsy8kWzemg/IhyQYebO4GZU+JLooE65CkwM8=;
 b=ra14ZT42Avw/kw9BEusIxunRjZPfj3CvwLMvpF2bweEUYxukLs43AmLbYNXq8jWG9L
 bWJqxnaLhVjsklK+y5bXklZZ3VYCcQCHgVZQStt725br0nn98f92sZyiIT/Mu+W90wNx
 PK8jjsobZVDgqZcg6RfiegTp9UxYrqQxvBIDlDY5i0KdFg3jq8IlsRS11ShzRGJWi2G7
 8FdzsNOKPUz5GH8hdIq4pXlYRhPJe5t1vKMqQvDnSPXfeVkXQWeqjHgZetU7XX2lR28y
 uzlrNs6+D5QERFnOWsIHgDtVPo6V3WCuu+9xqht80zWifi9kTrx5lLyVho1txooPvW6j
 pFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775960495; x=1776565295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X6AvJKjpsy8kWzemg/IhyQYebO4GZU+JLooE65CkwM8=;
 b=Bijhhqd620h7Z2wsZT2RzFkKfA1v8V9eJLvIBID1bkiasNgefqGxtNiQf2krWILFII
 lmjY/z7ngd++fx/edv1hAiPFA7AaJlGNMJ4aIRXnhD7AWfhUybbhFPDdxZg1rIibz8dk
 Bsjsme3urDiSM+ATKynm3SkEzSxuBypmmoMzCX2osD7y/poAMkD5X+Eg9UrxWqf+4Ak4
 vskMYde5ujY9gik2gzKrwv7ylcsL4ag4r170Ghq3rpkhwmUXjGv3E7WCtkBO989Hv0bp
 J+5DlPJ49vfPtyv0CswWsvbSR0ZuxgXxJHVjIZXjry6hZjQ87HxHDnnu/uzWUN3RegOQ
 TK6Q==
X-Gm-Message-State: AOJu0YwrHQjF10alTRP3sa6O5/lJuM0DDHoNsRC0it13nZUtNvJy7gsX
 /bofpyqK2TP8NGybniTOdDU1rhy0uf8k5lkjRuSslRsItdcavaPmdXwU
X-Gm-Gg: AeBDietHOPN4UfFMSm3DqX4a3gyOvS85MiOEDBzZXmnOQZrGj/nexDlHF6lR5LbuhdR
 MXoldCxN3GI5xsxxCm2sHD7a+rvwFVojz96NR7v1sBWpHlRDlnnhg3aPKA2pHopLBpy1bZ2xv3o
 de9kRQbSY2Q0Rrx5RYR66b9+JwClyhiMqzgJ9QHztssVu3R5HR4I0en5mrb7Sv+n4DfWjLEiLMF
 l8PRMqSaAdtaG9XaRAYl2mRC21ClHiuSt0/1wie55GyZvS/kFMeC+sO8HHFgkmLeVffqj1NPrI3
 2/m4T7O5q/l76CvTpC21b/E/bHcsHQ/SJWdV84G/41+jA3No3OgfoNHYC3FMdcrA20J4oGpWGG6
 UrAEr8bzbhP7BV5sfi9nghgEYxgMuhRr1Xd6CaRD7hWX/Y3fYFqJUCmJ1RSwu/sXpFA3/qVZruj
 0FZhwHFrrRra6UTFrEIko80pig6vYNxZGxjtuFUq8Xckfx1v4vmh6nrJFw6kFy8VbCPlrC2sxpc
 Odzfa4=
X-Received: by 2002:a05:622a:1920:b0:50d:6ee0:3822 with SMTP id
 d75a77b69052e-50dd5a976b6mr132703411cf.4.1775960495198; 
 Sat, 11 Apr 2026 19:21:35 -0700 (PDT)
Received: from ZEVORN-PC.bbrouter ([162.244.208.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8aca05592ecsm15455576d6.29.2026.04.11.19.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 19:21:34 -0700 (PDT)
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v6 6/7] target/riscv: add sdext single-step support
Date: Sun, 12 Apr 2026 10:20:23 +0800
Message-ID: <cca288cd6fbd75ee1b84b6af8c3dad87a96c7357.1775959096.git.chao.liu.zevorn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::842;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-qt1-x842.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

RISC-V Debug Specification:
https://github.com/riscv/riscv-debug-spec/releases/tag/1.0

Use a TB flag when dcsr.step is set (and we are not in Debug Mode).
When the flag is on, build 1-insn TBs and do not chain to the next TB.
Add a TB-exit helper that enters Debug Mode with cause=step and sets
dpc to the next pc, then stops with EXCP_DEBUG.

If dcsr.stepie is 0, do not take interrupts while stepping. Treat WFI
as a nop so the hart does not sleep during a step.

PS: This patch references Max Chou's handling of ext_tb_flags.
https://lore.kernel.org/qemu-devel/20260108132631.9429-6-max.chou@sifive.com/

Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 include/exec/translation-block.h |  4 ++--
 target/riscv/cpu.h               |  2 ++
 target/riscv/cpu_helper.c        |  6 ++++++
 target/riscv/helper.h            |  1 +
 target/riscv/op_helper.c         | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c       |  5 +++++
 target/riscv/translate.c         | 15 +++++++++++++--
 7 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 40cc699031..ee15608c89 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -64,8 +64,8 @@ struct TranslationBlock {
      * x86: the original user, the Code Segment virtual base,
      * arm: an extension of tb->flags,
      * s390x: instruction data for EXECUTE,
-     * sparc: the next pc of the instruction queue (for delay slots).
-     * riscv: an extension of tb->flags,
+     * sparc: the next pc of the instruction queue (for delay slots),
+     * riscv: an extension of tb->flags.
      */
     uint64_t cs_base;
 
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 62732957a4..0d6b70c9f0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -712,6 +712,8 @@ FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 FIELD(EXT_TB_FLAGS, MISA_EXT, 0, 32)
 FIELD(EXT_TB_FLAGS, ALTFMT, 32, 1)
+/* sdext single-step needs a TB flag to build 1-insn TBs */
+FIELD(EXT_TB_FLAGS, SDEXT_STEP, 33, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0ff11a45de..cefab2b131 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -635,6 +635,12 @@ bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     if (interrupt_request & mask) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         CPURISCVState *env = &cpu->env;
+
+        if (cpu->cfg.ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP) && !(env->dcsr & DCSR_STEPIE)) {
+            return false;
+        }
+
         int interruptno = riscv_cpu_local_irq_pending(env);
         if (interruptno >= 0) {
             cs->exception_index = RISCV_EXCP_INT_FLAG | interruptno;
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 9538e816f0..68e9796289 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -143,6 +143,7 @@ DEF_HELPER_1(tlb_flush_all, void, env)
 DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
+DEF_HELPER_1(sdext_step, void, env)
 DEF_HELPER_2(sdext_ebreak, void, env, tl)
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 58d47b88c1..0165e98d16 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -456,6 +456,22 @@ target_ulong helper_dret(CPURISCVState *env)
 #endif
 }
 
+void helper_sdext_step(CPURISCVState *env)
+{
+#ifndef CONFIG_USER_ONLY
+    CPUState *cs = env_cpu(env);
+
+    if (!riscv_cpu_cfg(env)->ext_sdext || env->debug_mode ||
+        !(env->dcsr & DCSR_STEP)) {
+        return;
+    }
+
+    riscv_cpu_enter_debug_mode(env, env->pc, DCSR_CAUSE_STEP);
+    cs->exception_index = EXCP_DEBUG;
+    cpu_loop_exit_restore(cs, GETPC());
+#endif
+}
+
 void helper_sdext_ebreak(CPURISCVState *env, target_ulong pc)
 {
     CPUState *cs = env_cpu(env);
@@ -588,6 +604,10 @@ void helper_wfi(CPURISCVState *env)
                (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
         riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
     } else {
+        if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
+            (env->dcsr & DCSR_STEP)) {
+            return;
+        }
         cs->halted = 1;
         cs->exception_index = EXCP_HLT;
         cpu_loop_exit(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4b17fbb611..cb464c13cd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -193,6 +193,11 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
     flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, MISA_EXT, env->misa_ext);
+#ifndef CONFIG_USER_ONLY
+    if (cpu->cfg.ext_sdext && !env->debug_mode && (env->dcsr & DCSR_STEP)) {
+        ext_flags = FIELD_DP64(ext_flags, EXT_TB_FLAGS, SDEXT_STEP, 1);
+    }
+#endif
 
     return (TCGTBCPUState){
         .pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 81087e0a5d..d850aaee89 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -111,6 +111,8 @@ typedef struct DisasContext {
     bool ztso;
     /* Use icount trigger for native debug */
     bool itrigger;
+    /* Enter Debug Mode after next instruction (sdext single-step). */
+    bool sdext_step;
     /* FRM is known to contain a valid value. */
     bool frm_valid;
     bool insn_start_updated;
@@ -293,6 +295,9 @@ static void lookup_and_goto_ptr(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_lookup_and_goto_ptr();
 }
@@ -303,6 +308,9 @@ static void exit_tb(DisasContext *ctx)
     if (ctx->itrigger) {
         gen_helper_itrigger_match(tcg_env);
     }
+    if (ctx->sdext_step) {
+        gen_helper_sdext_step(tcg_env);
+    }
 #endif
     tcg_gen_exit_tb(NULL, 0);
 }
@@ -316,7 +324,8 @@ static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_idx,
       * Under itrigger, instruction executes one by one like singlestep,
       * direct block chain benefits will be small.
       */
-    if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
+    if (translator_use_goto_tb(&ctx->base, dest) &&
+        !ctx->itrigger && !ctx->sdext_step) {
         /*
          * For pcrel, the pc must always be up-to-date on entry to
          * the linked TB, so that it can use simple additions for all
@@ -1357,6 +1366,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
+    ctx->sdext_step = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, SDEXT_STEP);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
@@ -1407,7 +1417,8 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-        if (ctx->itrigger || !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
+        if (ctx->itrigger || ctx->sdext_step ||
+            !translator_is_same_page(&ctx->base, ctx->base.pc_next)) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         } else {
             unsigned page_ofs = ctx->base.pc_next & ~TARGET_PAGE_MASK;
-- 
2.53.0


