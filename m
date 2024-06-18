Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98973C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLd-0006ul-P6; Tue, 18 Jun 2024 12:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLa-0006dg-6M
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:14 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLT-0007jt-6m
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:13 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a6f13dddf7eso685223666b.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726762; x=1719331562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfUqxR+YdQnuO0BjXJLFGV/JOzU+pFYUWIcFFlx9+/c=;
 b=iJb5s+QxUeDA2DwWjA4Ck4CC8JRS2s6ej5sKpc4tsxa5Os8hm0fnJShkTVa6BGp/Mx
 xtSQmxKOXfCzP5X1M/Y2c8pmwseveIxFwg6DYeIbPyFac2Ytgka32oRK0ZG0fMZxnorf
 zH8DE488ph9rq+zazJv7TlDqlftleJqpAxjhCw009QOpUH+UPNPgVegVBd4D5ktkGsUJ
 WFuBn+ahvMVeRx1PcnKuBBgofuLn+er67ZE9PpdjlbFApNN3SS849FRN/haxUX9e1yax
 eVmy6EzFd/cIZ84DJJB3I6KAboRmUYdvoqwXFOtZRqqOtcZuPbt7knzMlfPJR0NhRRxx
 HG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726762; x=1719331562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bfUqxR+YdQnuO0BjXJLFGV/JOzU+pFYUWIcFFlx9+/c=;
 b=MiG+qso4bd3wXprWNiJmQPu08CrOSHAB9anj79EcAcAo+Oy8y5hROxKzd08wfspFV7
 wkswsMmV1OQVp85o/WG2bZD2FDX4oxEE6AQ9UCfhVB22BGwV4QmMEyN3ne16dDWYQ1Nb
 QNW//cuKgDMdlgwDO05sbdsxVZDxYrNbymS1MZ/luTjOV3mPB5etHBukt70o9OxZI2ED
 H1P2hUpdLrk+5zz7RZWqmpDKGk4R5gsCSqZPqikU5g9eKQSIywHGuw5XGvmxaeoO8pcL
 5dRMmzWAeE6L+yKn0ERAzV/j/xpB/VN2OI7O7VP8ST5hOrTzpMVM3uWdLAcdAypwxBPP
 SPNQ==
X-Gm-Message-State: AOJu0YzkvnRnEdCj4EuqcYZpa962DmZ93Kh0zZ4kPtgBuGCm8nSqsrK9
 Ac67i59anW7GxsxmFv7fAZEqXUpJaWk6Ii+x84BRomWKCawTdAndqEGmoq2AvpZvpgOxtcNXUKO
 A
X-Google-Smtp-Source: AGHT+IHUbYKJ3lc7VAaUL5AYyiK0YAFcKgitQd418/qzP22sltqu1TOgwzAC5AUYbopY+T+dYU2YBQ==
X-Received: by 2002:a17:906:5919:b0:a6f:1378:1329 with SMTP id
 a640c23a62f3a-a6f60cf1dc0mr934319466b.4.1718726762119; 
 Tue, 18 Jun 2024 09:06:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-362c19d798bsm650072f8f.40.2024.06.18.09.06.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 55/76] target: Set TCGCPUOps::cpu_exec_halt to target's
 has_work implementation
Date: Tue, 18 Jun 2024 18:00:17 +0200
Message-ID: <20240618160039.36108-56-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240603160933.1141717-3-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 8239ae83cc..0ac17bc5ad 100644
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
index 0e2fbcb397..9db1dffc03 100644
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
index f53e1192b1..3132842d56 100644
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
index 535ec39c73..ff31ca7fbc 100644
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
index f0507874ce..7cf2e2f266 100644
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
index 270f711f11..69f9ad7711 100644
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
index efd6bbded8..1d49f4cb23 100644
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
index 41ad47d04c..135947ee80 100644
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
index bbe01d07dd..89655b1900 100644
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
index fdaaa09fc8..6ec54ad7a6 100644
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
index 01e358a4a5..cdada7987d 100644
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
index 69a08e8c2c..a849a0ffcb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -903,7 +903,7 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
     return env->pc;
 }
 
-static bool riscv_cpu_has_work(CPUState *cs)
+bool riscv_cpu_has_work(CPUState *cs)
 {
 #ifndef CONFIG_USER_ONLY
     RISCVCPU *cpu = RISCV_CPU(cs);
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 683f604d9f..4fe6d2f09d 100644
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
index 8a584f0a11..36d2a6f189 100644
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
index 2bbeaca36e..0fbfcd35d8 100644
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
index 618aa7154e..8f07261dcf 100644
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
index 9bacfb68cb..54cb269e0a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -926,6 +926,7 @@ static const TCGCPUOps sparc_tcg_ops = {
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
+    .cpu_exec_halt = sparc_cpu_has_work,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index de907cfeb1..a08c7a0b1f 100644
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
2.41.0


