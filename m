Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB49C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 16:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEAFt-00025n-QA; Mon, 03 Jun 2024 12:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFj-00020k-Ue
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:45 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEAFe-0000ZB-RT
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 12:09:41 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dc36b107fso3488284f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430976; x=1718035776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZBdzLZZL/nRHExmbsGOFpgP9JHwy15yfEoxuNTlxcfY=;
 b=Xwfue4J4xH1fe0q7thdxHIDzGL3WnNxX2sRi1LHyafVCYneaczVDANL++w2djChePh
 xyuEnOMgJn7Tx21OedfB1qcQ7wNqpNeAlJfZLY8Mgllws9d5swDOhJJVsPnfMBBKcRDl
 pv9DRPJlhRr5FzNV4tv0eZh4B8MBp96FN+GW3w2oEuf30qclFnrXvl9TWPZ521UEl4Zx
 fxGoxKsnF3N8YnYIyliPn0+nbWBqArm6LkDn9tGLoYi8xgfow6vhx703g9xaUCe3IwKG
 Uo/OAlbYYODYWDDu3STX8nb/ZMuqxEYocVF/4fpIPEBDKcLTDPryCXgRr0Mq6swcVzSB
 5cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430976; x=1718035776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBdzLZZL/nRHExmbsGOFpgP9JHwy15yfEoxuNTlxcfY=;
 b=iPzdHxmG50WV96vQ9Oo3LxmEzjFfY2d8q0duiuyxsrZA68Pqk41Pjf+VrlUPqRCJ9v
 j3GkZKaAF/FG+9lhJlKusPyDfDCrbSTupmJe+2chf0ItGEJ3PTlYggwztGLl3NqF4+lY
 9mrldrq+nZxdEMHqVIeI41dlTZ5OiiFPpFxI/jNF3Cu11dJFKd5PyeCqigYrVv/zSC1Q
 bJnQITmqZDx2jolHt+8yLOPipgr04l2/QWrvoImorlsiHxIkOUu1JoRykdHwfNrz360t
 TMnFck32xIZWEckYZDaE52lqZ3a4yBZs1nmccAG+o7ksPHjMBswkU0fxxg+FG0/RQuR0
 2QnQ==
X-Gm-Message-State: AOJu0YwW11RuwEaQBqlyCgw/kVvuOthYeHhg4r0m/Q3boynWfNT4IRgl
 iTuLw0BbWRWkwaBDh5QEofmi+6YUrsvCxdVhmkD5OwCtkO5BqQsWmzLAyuwrP8c3d38AzOKMYsu
 V
X-Google-Smtp-Source: AGHT+IGr7PFyNJbVQYID1zYUbne+qCaVhI4/8MvGuvsUhD5+UfshJpby7+5t271WNICfOqORL2jIHw==
X-Received: by 2002:adf:efca:0:b0:354:dde0:97a5 with SMTP id
 ffacd0b85a97d-35e0f27420emr6187169f8f.19.1717430975885; 
 Mon, 03 Jun 2024 09:09:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0649fb5sm8975858f8f.94.2024.06.03.09.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 09:09:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 2/3] target: Set TCGCPUOps::cpu_exec_halt to target's has_work
 implementation
Date: Mon,  3 Jun 2024 17:09:32 +0100
Message-Id: <20240603160933.1141717-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603160933.1141717-1-peter.maydell@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently the TCGCPUOps::cpu_exec_halt method is optional, and if it
is not set then the default is to call the CPUClass::has_work
method (which has an identical function signature).

We would like to make the cpu_exec_halt method mandatory so we can
remove the runtime check and fallback handling.  In preparation for
that, make all the targets which don't need special handling in their
cpu_exec_halt set it to their cpu_has_work implementation instead of
leaving it unset.  (This is every target except for arm and i386.)

In the riscv case this requires us to make the function not
be local to the source file it's defined in.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/riscv/internals.h   | 3 +++
 target/alpha/cpu.c         | 1 +
 target/avr/cpu.c           | 1 +
 target/cris/cpu.c          | 2 ++
 target/hppa/cpu.c          | 1 +
 target/loongarch/cpu.c     | 1 +
 target/m68k/cpu.c          | 1 +
 target/microblaze/cpu.c    | 1 +
 target/mips/cpu.c          | 1 +
 target/openrisc/cpu.c      | 1 +
 target/ppc/cpu_init.c      | 2 ++
 target/riscv/cpu.c         | 2 +-
 target/riscv/tcg/tcg-cpu.c | 2 ++
 target/rx/cpu.c            | 1 +
 target/s390x/cpu.c         | 1 +
 target/sh4/cpu.c           | 1 +
 target/sparc/cpu.c         | 1 +
 target/xtensa/cpu.c        | 1 +
 18 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 8239ae83ccc..0ac17bc5adb 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -136,4 +136,7 @@ static inline float16 check_nanbox_h(CPURISCVState *env, uint64_t f)
     }
 }
 
+/* Our implementation of CPUClass::has_work */
+bool riscv_cpu_has_work(CPUState *cs);
+
 #endif
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 0e2fbcb397f..9db1dffc03e 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -219,6 +219,7 @@ static const TCGCPUOps alpha_tcg_ops = {
 #else
     .tlb_fill = alpha_cpu_tlb_fill,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
+    .cpu_exec_halt = alpha_cpu_has_work,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
     .do_unaligned_access = alpha_cpu_do_unaligned_access,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index f53e1192b15..3132842d565 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -210,6 +210,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
+    .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
 };
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 535ec39c730..ff31ca7fbc1 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -186,6 +186,7 @@ static const TCGCPUOps crisv10_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = cris_cpu_tlb_fill,
     .cpu_exec_interrupt = cris_cpu_exec_interrupt,
+    .cpu_exec_halt = cris_cpu_has_work,
     .do_interrupt = crisv10_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
@@ -197,6 +198,7 @@ static const TCGCPUOps crisv32_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = cris_cpu_tlb_fill,
     .cpu_exec_interrupt = cris_cpu_exec_interrupt,
+    .cpu_exec_halt = cris_cpu_has_work,
     .do_interrupt = cris_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index f0507874ce6..7cf2e2f266d 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -228,6 +228,7 @@ static const TCGCPUOps hppa_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = hppa_cpu_tlb_fill,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
+    .cpu_exec_halt = hppa_cpu_has_work,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
     .do_transaction_failed = hppa_cpu_do_transaction_failed,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b5c1ec94af5..70b41807c8d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -736,6 +736,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
+    .cpu_exec_halt = loongarch_cpu_has_work,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
 #endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index efd6bbded86..1d49f4cb238 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -536,6 +536,7 @@ static const TCGCPUOps m68k_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
+    .cpu_exec_halt = m68k_cpu_has_work,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 41ad47d04cb..135947ee800 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -413,6 +413,7 @@ static const TCGCPUOps mb_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
+    .cpu_exec_halt = mb_cpu_has_work,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
     .do_unaligned_access = mb_cpu_do_unaligned_access,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbe01d07dd8..89655b1900f 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -555,6 +555,7 @@ static const TCGCPUOps mips_tcg_ops = {
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
+    .cpu_exec_halt = mips_cpu_has_work,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
     .do_unaligned_access = mips_cpu_do_unaligned_access,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index fdaaa09fc87..6ec54ad7a6c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -233,6 +233,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
+    .cpu_exec_halt = openrisc_cpu_has_work,
     .do_interrupt = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 01e358a4a5a..cdada7987d8 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -1,3 +1,4 @@
+
 /*
  *  PowerPC CPU initialization for qemu.
  *
@@ -7481,6 +7482,7 @@ static const TCGCPUOps ppc_tcg_ops = {
 #else
   .tlb_fill = ppc_cpu_tlb_fill,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
+  .cpu_exec_halt = ppc_cpu_has_work,
   .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index eb1a2e7d6d9..54e12eed466 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -896,7 +896,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-static bool riscv_cpu_has_work(CPUState *cs)
+bool riscv_cpu_has_work(CPUState *cs)
 {
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 40054a391a6..643f9a224b8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -21,6 +21,7 @@
 #include "exec/exec-all.h"
 #include "tcg-cpu.h"
 #include "cpu.h"
+#include "internals.h"
 #include "pmu.h"
 #include "time_helper.h"
 #include "qapi/error.h"
@@ -137,6 +138,7 @@ static const TCGCPUOps riscv_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
+    .cpu_exec_halt = riscv_cpu_has_work,
     .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
     .do_unaligned_access = riscv_cpu_do_unaligned_access,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 8a584f0a111..36d2a6f1890 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,6 +192,7 @@ static const TCGCPUOps rx_tcg_ops = {
 
 #ifndef CONFIG_USER_ONLY
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
+    .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 2bbeaca36e4..0fbfcd35d83 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -370,6 +370,7 @@ static const TCGCPUOps s390_tcg_ops = {
 #else
     .tlb_fill = s390_cpu_tlb_fill,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
+    .cpu_exec_halt = s390_cpu_has_work,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 618aa7154ed..8f07261dcfd 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -254,6 +254,7 @@ static const TCGCPUOps superh_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
+    .cpu_exec_halt = superh_cpu_has_work,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
     .io_recompile_replay_branch = superh_io_recompile_replay_branch,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 5be1592e66a..87f0b4a6c05 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -914,6 +914,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
+    .cpu_exec_halt = sparc_cpu_has_work,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index de907cfeb1b..a08c7a0b1f2 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -234,6 +234,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
+    .cpu_exec_halt = xtensa_cpu_has_work,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
-- 
2.34.1


