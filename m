Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA3FC54743
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 23:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj5TV-0004LJ-Ln; Tue, 27 Aug 2024 19:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TK-0003ar-D0
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:34 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sj5TH-0000ug-2d
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 19:19:34 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2023dd9b86aso48558975ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 16:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724800770; x=1725405570;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPEmPHl2xgwIfEQ7uy7cB8ioUnOYYkMxclwoAyAzOsU=;
 b=2GuPyW4R3kBzH6dBChnq8d2H06/RybQ2VhIm3rZAQCd7IkLCFhelAn5eE+SBwIbNdW
 ECzPUfuz4MX+E5ZmjGwFqDB2ZUtyLvJL82x2gAsTr+K9vx1HkTkSlRptDUQrnh7KGKfF
 dF33HK4PXDJLL4V+Cfu/rRSZevs0uXEkFYhGV8o9IP2XCDYs5WH+E7EiaGKQpIaptMOu
 ymWCGLxlzsvwZK2gJTkfiUrFIrN4GZC2hdiNilOHzlSmg8NWrfu8CreqUx98Kt0Bk8me
 f8BoZrNn+WiO7BGoFNK0St9CQG7jFiII79T8FmZqBWomdnyVlUqaDdN8TwskFHBlRKqC
 QgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800770; x=1725405570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CPEmPHl2xgwIfEQ7uy7cB8ioUnOYYkMxclwoAyAzOsU=;
 b=N7gkO2RyEWOtJuX7pDDYjP5lB96WZm1FGCyjaeH9JyxpkHF68bS2nNlcko7WHInNMQ
 31C35EnzwxSx44pcwSvkWseQhJSBjP/EWKn9Dpowcm8k4A3paGlNZE7jmqQaZzX3vrMt
 B7OBByrfTk4RRVpwW3UH1Pdo1J1fkQ3TgBDIw9mKlG6QjlJu+DoVFB5w5DWYIkyovSo3
 J0/lIgSr7gxvETL4GAaJR28gqiY9vZ4ftTP+9wbJlVAAtxdaez1hPJzRac7Uke0Xtl9T
 Vii6dKQEbn0BjnKkqvsVSvgEVcLx4qW9H+cfZMljrXh6iZSEClTU4ktyHlDXQVEnn0iq
 dIqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqtEobmFAbtMJCTaVeqHt5QEKst4xeR2fqKkNe+WPbMc+PYKrh+pu02d2JQoFWvjizCy1CNq3k9l/h@nongnu.org
X-Gm-Message-State: AOJu0YzQ9+uQTNr7Mtei58eACJnnHuMtl6Q7H+49SGJ6GgmfT2k/Api4
 KrsQAYBZWiZHU122JamoR4FanVqTGNrrtxSkHhaAyq1xHdU9xWmTS++tTfmb0F8=
X-Google-Smtp-Source: AGHT+IFTy9uzfajm/Vdt3jmSRiOqnHAp/6ELhPnLFs4Ob/ZKK3uV2xBVQXmFLV9b06tnOt1gIqxorg==
X-Received: by 2002:a17:903:22c7:b0:201:feb8:3444 with SMTP id
 d9443c01a7336-2039e44f06amr209802105ad.2.1724800769605; 
 Tue, 27 Aug 2024 16:19:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0ee6179sm57785155ad.92.2024.08.27.16.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:19:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v10 15/21] target/riscv: AMO operations always raise store/AMO
 fault
Date: Tue, 27 Aug 2024 16:18:59 -0700
Message-ID: <20240827231906.553327-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240827231906.553327-1-debug@rivosinc.com>
References: <20240827231906.553327-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 39544cade6..8294279b01 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1741,6 +1741,22 @@ static target_ulong riscv_transformed_insn(CPURISCVState *env,
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
@@ -1752,6 +1768,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     bool write_gva = false;
+    bool always_storeamo = (env->excp_uw2 & RISCV_UW2_ALWAYS_STORE_AMO);
     uint64_t s;
 
     /*
@@ -1785,6 +1802,9 @@ void riscv_cpu_do_interrupt(CPUState *cs)
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


