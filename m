Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18925CA0EDC
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4nc-0001pU-0R; Fri, 30 Aug 2024 12:48:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4na-0001iC-2r
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:34 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sk4nQ-00070Q-Qt
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:48:33 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2d3c99033d6so1553412a91.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725036503; x=1725641303;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Tjx4ohEIHhmLmeWGo8SKxvrwCaUXUYbopOiYOUR2ig=;
 b=RY0PVKtnXBxCzazuPjNkngdkDWOpL6R+u4yTgj+LanQG2ACqlIxqkiaMh30APqOMyF
 GzM2J9wG1LnUAhLyUYJotMYi1X8asIKwaHVLow0pEAufN+HoZPYXYGKFxn+gdwnrqn5a
 xy8TnKEdnLks163mPUm8f6Dx1NwksZ115giFTCfn4Q95PmCCcRqoI59iVnV66A8A3VC5
 FZYa8iMRsxHCsNzLyZ+u84Bp2kMAjE1oG1zPaVa6ayNBId69z5mTl/S9HOHLmg9P4RpC
 T0Gp0vLkIcrpGaplarefC4W05/EaNmV3H+pFO6DVYpWXzM8FybwPZR+EG0IEpkXWLkj9
 SNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725036503; x=1725641303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Tjx4ohEIHhmLmeWGo8SKxvrwCaUXUYbopOiYOUR2ig=;
 b=p1Sisuj4w2nSlmLt+UXpOoPzJkKCc3p737zcqtYbnvWwwkW+IcyJArgETvxg2GOyP3
 PMls2gyVc/EerpdoyCYdkjFev/R2Y7IURktPswCG93+Kmk1xR969is3ZNg+vJE4CZbvc
 EqAHRtJNUE8Wv6wsR9GgavhiCLKFlcvxCaUX520YyednFtn/pi9J6qMSSDdLOCD2HDZz
 nWX3ybpeUNoWMxHl0HrK4TDcWGYwui9aXm773//Mjtw6vuQbPklVKmS6CxQW1sV3o3k5
 ts3GCjLQjkaVmufLv39HOL5111YDOYFhRZbH7TCJ3dYri8F+FC0GE/C2t3WDPm32ktPf
 jmlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWowb8due1rvnI0waEs23Gv7rtyqgHQ/vUbYAZ4DN4erQ1jVR5EtVppl8lgAzumRuW3zrVWknsWXkT4@nongnu.org
X-Gm-Message-State: AOJu0Yzv5cwlaO4+xweMuf+g3uKPtpTjoeoElgGPje/rWfg59koRTOjT
 4Z68Pds+1Kgk3LvXoVEwJG5ocmVRvpbzx7IoOQjL0fLMSd7qZdvwDG9JKJlgG90=
X-Google-Smtp-Source: AGHT+IGERr4iGaKEj3uu5ZWOqJtemOHupn2sxbMDpDulDAyeVBlSl5XZN+b5ka2gG5kJw3ZOy//2xQ==
X-Received: by 2002:a17:90b:1c88:b0:2d2:453:12cb with SMTP id
 98e67ed59e1d1-2d85617dc47mr7007193a91.2.1725036503249; 
 Fri, 30 Aug 2024 09:48:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8445e813dsm6591257a91.17.2024.08.30.09.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 09:48:23 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 14/20] target/riscv: AMO operations always raise store/AMO
 fault
Date: Fri, 30 Aug 2024 09:47:50 -0700
Message-ID: <20240830164756.1154517-15-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240830164756.1154517-1-debug@rivosinc.com>
References: <20240830164756.1154517-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch adds one more word for tcg compile which can be obtained during
unwind time to determine fault type for original operation (example AMO).
Depending on that, fault can be promoted to store/AMO fault.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h         |  9 ++++++++-
 target/riscv/cpu_helper.c  | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c |  1 +
 target/riscv/translate.c   |  2 +-
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index e758f4497e..0a13604e37 100644
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
index 9d777ce1a2..a890825b02 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1750,6 +1750,22 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
     return xinsn;
 }
 
+static target_ulong promote_load_fault(target_ulong orig_cause)
+{
+    switch (orig_cause) {
+    case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
+        return RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
+
+    case RISCV_EXCP_LOAD_ACCESS_FAULT:
+        return RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+
+    case RISCV_EXCP_LOAD_PAGE_FAULT:
+        return RISCV_EXCP_STORE_PAGE_FAULT;
+    }
+
+    /* if no promotion, return original cause */
+    return orig_cause;
+}
 /*
  * Handle Traps
  *
@@ -1761,6 +1777,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
+    bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
 
     /*
@@ -1794,6 +1811,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         case RISCV_EXCP_STORE_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_PAGE_FAULT:
         case RISCV_EXCP_STORE_PAGE_FAULT:
+            if (always_storeamo) {
+                cause = promote_load_fault(cause);
+            }
             write_gva = env->two_stage_lookup;
             tval = env->badaddr;
             if (env->two_stage_indirect_lookup) {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ad1295ce41..d8ae666258 100644
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
index afa2ed4e3a..0322597bf6 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1264,7 +1264,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_next &= ~TARGET_PAGE_MASK;
     }
 
-    tcg_gen_insn_start(pc_next, 0);
+    tcg_gen_insn_start(pc_next, 0, 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.44.0


