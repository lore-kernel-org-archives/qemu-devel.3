Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD84C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 08:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh38P-0005nZ-Mn; Thu, 22 Aug 2024 04:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38J-0005N6-K0
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sh38E-0005zs-5x
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 04:25:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-202146e93f6so5183665ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724315121; x=1724919921;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XfpDUlicfMa/w7Dap5Ged0zMOz5gW8WXfevhHdhAvZk=;
 b=RnnYyr2zA+D+ZF5NtFI8hRgySPQJsMmakx4en8hQexljNzZLB6DctEA2C264q86SWO
 TSDaOKznyXUWYJv0FoVY2n46ZoRwB15mROEXzkmtrAfdOOpUtIjyjGxcMDrpifGtuIkw
 nVaHxZfKWHO31y5qFqGlJIEsk8lqu19uLRcuPIGwH74ciA0+/Gy6cDMJd48/IH+Vmmjz
 pfkLpvso/mAHO/8kOho7gz1THPhn34i8M3sAOWvTn6/oU4ZTnnZbtGs6irLIq4Jr/j+I
 yMmcEdZlAdFg7DXNYTiUeVMqDMnDx7HBzLbe9h6CeiHFCGoMrnWULkqIRmtPexB5ENpf
 J2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724315121; x=1724919921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfpDUlicfMa/w7Dap5Ged0zMOz5gW8WXfevhHdhAvZk=;
 b=dcOhdHayoZ7+Dt0ihhuA7Q1IbQwIDhrJ4GRtpmwvGraKWi5nC2xIXjydvQ20JuvTBc
 fkhnQLAcP2stbE+BbV2Kmw5q0XYy4dSrv4ymp8uzBSpFa6+3fOo0cw1vXg0pkHnHxRPH
 /Uj/m1CX9SktlE1Dg0+Gxn4G8EQEr9v5Ts6BJUnu2ZkUXYL1sCgWeh5MyBhZ+Hi66vLP
 mtm+CGmCwzz2ohcb/d3326w5zWgQxrOZG7LgtGskkP6KJf0s61wb0UnO4nIdxLUIfFj3
 3bwsjvbwqHCljRDbAeh9+Br/hMsIeQFKvbQ+eQ8pW0wbffLvZxQRZHUUN9/wTQ2dsM9w
 mEOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR4dbcAd6GdbPP3WlG9nail10UDgXHXs7PDB5qasN8ssxb/tJhHGz6dtMMg4vkegjslYOpXYXxpZjn@nongnu.org
X-Gm-Message-State: AOJu0YwrlHVylYBoVB62wi/vrVmmiN3rqkYZExgVimHi7YIto4THhr93
 xWP5DSyDxNaD1usw+6brUcfh59tIheRqgwIm9BbtAyITOBB8ZfPKKBQjpmRwx8U=
X-Google-Smtp-Source: AGHT+IFjnHJRqZyWQN5wk2HH1FUkvYIweTGDa60xQlV2Yl7WUn1dG5aLflf6yDv0BgK0snHgU1blfg==
X-Received: by 2002:a17:903:2349:b0:1fb:57a6:2ae7 with SMTP id
 d9443c01a7336-2036820c22cmr65813665ad.59.1724315120610; 
 Thu, 22 Aug 2024 01:25:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385589225sm7641295ad.115.2024.08.22.01.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 01:25:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 12/17] target/riscv: AMO operations always raise store/AMO
 fault
Date: Thu, 22 Aug 2024 01:24:58 -0700
Message-ID: <20240822082504.3979610-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240822082504.3979610-1-debug@rivosinc.com>
References: <20240822082504.3979610-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62b.google.com
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
 target/riscv/cpu_helper.c  | 20 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c |  1 +
 target/riscv/translate.c   |  2 +-
 4 files changed, 30 insertions(+), 2 deletions(-)

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
index 95ef7b0bd1..0f32bede39 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1740,6 +1740,22 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
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
@@ -1751,6 +1767,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
+    bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
 
     /*
@@ -1784,6 +1801,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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
index b1d251e893..16fff70dac 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1265,7 +1265,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
         pc_next &= ~TARGET_PAGE_MASK;
     }
 
-    tcg_gen_insn_start(pc_next, 0);
+    tcg_gen_insn_start(pc_next, 0, 0);
     ctx->insn_start_updated = false;
 }
 
-- 
2.44.0


