Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D1EC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 21:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgtDz-0005vq-S9; Wed, 21 Aug 2024 17:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDx-0005nn-UT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgtDw-00088c-1A
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 17:50:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc47abc040so1542825ad.0
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724277035; x=1724881835;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ps8c4B4fW4dnHyPlCmJ+Qc7poF2BXGJ7omJUUEMCpA4=;
 b=g/nxe10Pxc9q09TeOYRW59425FpupOWXpks5siQXqs795vy+KmaD4oQSu4cEFlNQr+
 hS7BBNEJly5sgh0OYIN7NP4fVGEuQctzYJ5ufz9YljR5es+ZdUpOAuHrN5fig65vPfOb
 zf7hifMrkePQiNkAYYrxfc6t73+GyIADVBuWrVYTHFHAhconxUf5RtAUFS0RT8zgTSU2
 /uZaPQXiOHAD7ENXzR9Xly/HwnEukKv2vYyMKjH7H+qbMJnhdwGm+BZNWhALMxx5KIqX
 GALnNslD9J1NFl0dMEn5pu+h60gagNLv7qQvvbN1aor5XcuZZ/ikGXz8G5udmQ3kg3/1
 nNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724277035; x=1724881835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ps8c4B4fW4dnHyPlCmJ+Qc7poF2BXGJ7omJUUEMCpA4=;
 b=OfvGaekL/KvDZgre2iwYX2WOW5LNN709c6PbnGGeg08HYxapUFL3GmIb9jcDcmYuXX
 UGkt9TzfYGp625uyGBi78OemFrHoDDDNTjAUS8CLvekzSrrH/R+EKo7Bxu4pcMZhL2oC
 8isJc4Syj6J5oBBUgQaDF8Nw9MoU0PIvt6KQKK8ss9bYCY0ycg5S5LnoWw59KK1j7R6N
 pLXvij5fII6+9XFhmlx0st01/Nqfwrmhbk/Ma8+C3AwsYeBTz237dVDwB7euc1Td7dFw
 Au3IsVyRO8ARyRUOGGT18CswBYsooGGT599eN3Pa4eAL26SLR3laTj+dKHWaeObcguKg
 AHlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVERFq6HuH/zmvXQyEtGJOLvSI796o341sLMEEY/h1gIrRcjU32z64GrGgkddlcb87FsiZclk30aMLI@nongnu.org
X-Gm-Message-State: AOJu0Yy+QkA6ahYN/g3T54nOOCiMia/ane4NhbzB+dPg1GC0klTb6qBq
 bI9DsnJhzisA1h6w5+c0rifAA9Ug15NHV2U+QkdCzFmd9W+E/CbB1kT8m9jyd64=
X-Google-Smtp-Source: AGHT+IFzLEGEwsHWANnAJ/cIGYBBy6b35fr7aqBsbTFYswBSaDM/PC3g+AgDJCZu5oycAfcG2BmzOg==
X-Received: by 2002:a17:903:2450:b0:1fd:b604:58a6 with SMTP id
 d9443c01a7336-20367c089b2mr57818965ad.17.1724277034634; 
 Wed, 21 Aug 2024 14:50:34 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203859ef0fdsm586345ad.248.2024.08.21.14.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 14:50:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 12/16] target/riscv: AMO operations always raise store/AMO
 fault
Date: Wed, 21 Aug 2024 14:50:10 -0700
Message-ID: <20240821215014.3859190-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240821215014.3859190-1-debug@rivosinc.com>
References: <20240821215014.3859190-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds one more word for tcg compile which can be obtained during
unwind time to determine fault type for original operation (example AMO).
Depending on that, fault can be promoted to store/AMO fault.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h         |  9 ++++++++-
 target/riscv/cpu_helper.c  | 13 +++++++++++++
 target/riscv/tcg/tcg-cpu.c |  1 +
 target/riscv/translate.c   | 14 +++++++++++++-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index dcc3bc9d93..3143141863 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -46,8 +46,13 @@ typedef struct CPUArchState CPURISCVState;
 /*
  * RISC-V-specific extra insn start words:
  * 1: Original instruction opcode
+ * 2: more information about instruction
  */
-#define TARGET_INSN_START_EXTRA_WORDS 1
+#define TARGET_INSN_START_EXTRA_WORDS 2
+/*
+ * b0: Whether a instruction always raise a store AMO or not.
+ */
+#define RISCV_UW2_ALWAYS_STORE_AMO 1
 
 #define RV(x) ((target_ulong)1 << (x - 'A'))
 
@@ -226,6 +231,8 @@ struct CPUArchState {
     bool      elp;
     /* shadow stack register for zicfiss extension */
     target_ulong ssp;
+    /* env place holder for extra word 2 during unwind */
+    target_ulong excp_uw2;
     /* sw check code for sw check exception */
     target_ulong sw_check_code;
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 36dd67befc..a0fc10ddb5 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1753,6 +1753,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
+    bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
 
     /*
@@ -1779,13 +1780,25 @@ void riscv_cpu_do_interrupt(CPUState *cs)
             env->pc += 4;
             return;
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
+            if (always_storeamo) {
+                cause = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
+            }
+            goto load_store_fault;
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
         case RISCV_EXCP_STORE_AMO_ADDR_MIS:
         case RISCV_EXCP_LOAD_ACCESS_FAULT:
+            if (always_storeamo) {
+                cause = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+            }
+            goto load_store_fault;
         case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_PAGE_FAULT:
         case RISCV_EXCP_STORE_PAGE_FAULT:
+            if (always_storeamo) {
+                cause = RISCV_EXCP_STORE_PAGE_FAULT;
+            }
+        load_store_fault:
             write_gva = env->two_stage_lookup;
             tval = env->badaddr;
             if (env->two_stage_indirect_lookup) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4da26cb926..83771303a8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -129,6 +129,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
         env->pc = pc;
     }
     env->bins = data[1];
+    env->excp_uw2 = data[2];
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index d44103a273..8961dda244 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -121,6 +121,7 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    target_ulong excp_uw2;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -144,6 +145,9 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
 #define get_address_xl(ctx)    ((ctx)->address_xl)
 #endif
 
+#define SET_INSTR_ALWAYS_STORE_AMO(ctx) \
+    (ctx->excp_uw2 |= RISCV_UW2_ALWAYS_STORE_AMO)
+
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
 {
@@ -214,6 +218,12 @@ static void decode_save_opc(DisasContext *ctx)
     assert(!ctx->insn_start_updated);
     ctx->insn_start_updated = true;
     tcg_set_insn_start_param(ctx->base.insn_start, 1, ctx->opcode);
+
+    if (ctx->excp_uw2) {
+        tcg_set_insn_start_param(ctx->base.insn_start, 2,
+                                 ctx->excp_uw2);
+        ctx->excp_uw2 = 0;
+    }
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
@@ -1096,6 +1106,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
         mop |= MO_ALIGN;
     }
 
+    SET_INSTR_ALWAYS_STORE_AMO(ctx);
     decode_save_opc(ctx);
     src1 = get_address(ctx, a->rs1, 0);
     func(dest, src1, src2, ctx->mem_idx, mop);
@@ -1250,6 +1261,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
     ctx->decoders = cpu->decoders;
+    ctx->excp_uw2 = 0;
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
@@ -1265,7 +1277,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_next &= ~TARGET_PAGE_MASK;
     }
 
-    tcg_gen_insn_start(pc_next, 0);
+    tcg_gen_insn_start(pc_next, 0, 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.44.0


