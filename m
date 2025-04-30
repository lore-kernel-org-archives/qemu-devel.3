Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E21C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAcc-0005OV-9m; Wed, 30 Apr 2025 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcH-0004w2-Jx
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:01 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAAcF-0001tb-At
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:49:01 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b074d908e56so35518a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746031738; x=1746636538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFC0lIwrLvv96xyWA8HMukwFYVh25GBIzBMcz0FbVPQ=;
 b=qPBg558VM4SJ9LFPs8Z9Kt4Yfi5H9maFDTyuwCnbZZJKAKfUwSPAjdS7ezOjuWq9tP
 AoxYljYJbTpozNDRuo+4+UOIeesa2Wg5FN7gtMSRcBIpAwdBo/7lXERX35Nw55Ksxal5
 AZ6u3HNq4z5z0Xq8XvIgETYll/D+L7L6VI1r3tLqDfrY4D/ewoT0dLdQmbmNTP5KXvdq
 IXNUkAdy0Cn3SR/38qhh/FAy5naFSmq17goghUhW3Jr8y/9MiLy7ZZWjiV8UI7xiq/f4
 zJ8HV8LZR1DiMnk+FylH1JrKEwWoLCvOvy2qlP1U/GUgotkLT+D8KH7NZgp40c5s7TpJ
 mRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746031738; x=1746636538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFC0lIwrLvv96xyWA8HMukwFYVh25GBIzBMcz0FbVPQ=;
 b=CMZOHA1DCKguO9Z48yErQuy0QufP56ixCjY1sjO2u/lGo39AlbzR8k+DizVWIEeuZe
 jkgpHKmK1CJpGkF7wuvKFZ2O6QJIam7H4kP10j7eiaJrBhCKEsqyXFPqwj492qAuWuir
 h5yCULR54Zd7LlZ/hgRUYXsLwx0yb2GGEVhewzd/1xgTegw3fUDEGA4wqYIVnJCuI5oF
 Qyu9EZhcefsePbS/zFimOw0GmJ/4M2jMVwk9wE4cQG5c2e+aKVzlnRS2kx9rz7vMjW9j
 hi4qVFO1CBju9XZDUJ8i5U/IPB1v05XoXAqkKySJCDFyu+zJBG91423V5TrGzvC+Q7l/
 69qw==
X-Gm-Message-State: AOJu0YyJRQytMwtpuLC9v62pFrnNHB4kfbaeOFWuPCYXLNX4uY/0ItiA
 ASZ0w1SKU1bDe1AGWx48ZNJcjsjH67SAhdX0OzVs9krplrrV2BMzpqLaS0wszBt4vFpLH8rvV6R
 i
X-Gm-Gg: ASbGncuhLmJmkeTuMA39ikQ09Nq4LnvSC7w3s5M35VM9+dj6L4aiCmzHTxiZNvJ+IrT
 P7FnPPgjHiS2SBMYXzALqzV0or1Ie5JjRYj7V8YnikKQjimGM0r6HlQkhC7OqvSa5JrJw46vD3N
 WWmO/L8DvIRyN/7Ty37aVrLK8YzngmvdYCEXuW2cf/7/f2JGxjzVjLnpiLGhBEJ8ZlzY8ntgZBo
 aR66XlFe7iYBNRSCvoxLFFqdQVmWpQJp1UgfAh3VG2Row4as2LUQWMMrMrz1RxF3DXB3EWEM0ys
 6tLPWW9lICZbehS+mLygopeIpXhyi24dwsmYulCFqTFhHdk3MPBDnBT8hoKJ/B8nW+APnGTadpk
 =
X-Google-Smtp-Source: AGHT+IFFinpGj1wGxjE8r8RoqfOaW9QluKm1I6UkFA3nCEa0OU5TMuPIzibStmQcPELhl26MrLfFoQ==
X-Received: by 2002:a05:6a21:8dcc:b0:1f5:8f65:a6e6 with SMTP id
 adf61e73a8af0-20aa4182f25mr5356154637.27.1746031737873; 
 Wed, 30 Apr 2025 09:48:57 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f76f580asm9129704a12.2.2025.04.30.09.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:48:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 03/16] accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
Date: Wed, 30 Apr 2025 09:48:41 -0700
Message-ID: <20250430164854.2233995-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430164854.2233995-1-richard.henderson@linaro.org>
References: <20250430164854.2233995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Initialize all instances with cpu_reset(), so that there
is no functional change.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 2 ++
 accel/tcg/cpu-exec.c        | 3 ++-
 target/alpha/cpu.c          | 1 +
 target/arm/cpu.c            | 1 +
 target/arm/tcg/cpu-v7m.c    | 1 +
 target/avr/cpu.c            | 1 +
 target/hppa/cpu.c           | 1 +
 target/i386/tcg/tcg-cpu.c   | 1 +
 target/loongarch/cpu.c      | 1 +
 target/m68k/cpu.c           | 1 +
 target/microblaze/cpu.c     | 1 +
 target/mips/cpu.c           | 1 +
 target/openrisc/cpu.c       | 1 +
 target/ppc/cpu_init.c       | 1 +
 target/riscv/tcg/tcg-cpu.c  | 1 +
 target/rx/cpu.c             | 1 +
 target/s390x/cpu.c          | 1 +
 target/sh4/cpu.c            | 1 +
 target/sparc/cpu.c          | 1 +
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 1 +
 21 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 60b5e97205..3ff72b8d9d 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -155,6 +155,8 @@ struct TCGCPUOps {
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
     bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
+    /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
+    void (*cpu_exec_reset)(CPUState *cpu);
     /**
      * @cpu_exec_halt: Callback for handling halt in cpu_exec.
      *
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ff979a2c57..010f38edaa 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -834,7 +834,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
 #else
         else if (interrupt_request & CPU_INTERRUPT_RESET) {
             replay_interrupt();
-            cpu_reset(cpu);
+            cpu->cc->tcg_ops->cpu_exec_reset(cpu);
             bql_unlock();
             return true;
         }
@@ -1070,6 +1070,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 #ifndef CONFIG_USER_ONLY
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
+        assert(tcg_ops->cpu_exec_reset);
 #endif /* !CONFIG_USER_ONLY */
         assert(tcg_ops->translate_code);
         assert(tcg_ops->mmu_index);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 68414af8d3..d4e66aa432 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -251,6 +251,7 @@ static const TCGCPUOps alpha_tcg_ops = {
     .tlb_fill = alpha_cpu_tlb_fill,
     .cpu_exec_interrupt = alpha_cpu_exec_interrupt,
     .cpu_exec_halt = alpha_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = alpha_cpu_do_interrupt,
     .do_transaction_failed = alpha_cpu_do_transaction_failed,
     .do_unaligned_access = alpha_cpu_do_unaligned_access,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7b801eb3aa..3dde70b04a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2705,6 +2705,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index b34b657857..5c8c374885 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -250,6 +250,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_v7m_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 69fface7e9..50b835e1ae 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -232,6 +232,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .mmu_index = avr_cpu_mmu_index,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
     .cpu_exec_halt = avr_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b083693b57..60b618a22b 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -271,6 +271,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
     .cpu_exec_halt = hppa_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = hppa_cpu_do_interrupt,
     .do_unaligned_access = hppa_cpu_do_unaligned_access,
     .do_transaction_failed = hppa_cpu_do_transaction_failed,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 192812656c..5d1c758ae3 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -147,6 +147,7 @@ const TCGCPUOps x86_tcg_ops = {
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
+    .cpu_exec_reset = cpu_reset,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
     .debug_excp_handler = breakpoint_handler,
     .debug_check_breakpoint = x86_debug_check_breakpoint,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index c083ad4fd9..c64cba72dd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -877,6 +877,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
     .cpu_exec_halt = loongarch_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = loongarch_cpu_do_interrupt,
     .do_transaction_failed = loongarch_cpu_do_transaction_failed,
 #endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 6f33b86c7d..f446c6c8f7 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -602,6 +602,7 @@ static const TCGCPUOps m68k_tcg_ops = {
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
     .cpu_exec_halt = m68k_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = m68k_cpu_do_interrupt,
     .do_transaction_failed = m68k_cpu_transaction_failed,
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 2720e5c1d2..f305ed04f6 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -440,6 +440,7 @@ static const TCGCPUOps mb_tcg_ops = {
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
     .cpu_exec_halt = mb_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = mb_cpu_do_interrupt,
     .do_transaction_failed = mb_cpu_transaction_failed,
     .do_unaligned_access = mb_cpu_do_unaligned_access,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 96fe4da255..09ed330027 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -563,6 +563,7 @@ static const TCGCPUOps mips_tcg_ops = {
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
     .cpu_exec_halt = mips_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = mips_cpu_do_interrupt,
     .do_transaction_failed = mips_cpu_do_transaction_failed,
     .do_unaligned_access = mips_cpu_do_unaligned_access,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 8c8165d666..94776e0ad8 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -255,6 +255,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
     .cpu_exec_halt = openrisc_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = openrisc_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b0973b6df9..3a01731402 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7492,6 +7492,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .tlb_fill = ppc_cpu_tlb_fill,
   .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
   .cpu_exec_halt = ppc_cpu_has_work,
+  .cpu_exec_reset = cpu_reset,
   .do_interrupt = ppc_cpu_do_interrupt,
   .cpu_exec_enter = ppc_cpu_exec_enter,
   .cpu_exec_exit = ppc_cpu_exec_exit,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2f757c2a5e..50782e0f0e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -153,6 +153,7 @@ const TCGCPUOps riscv_tcg_ops = {
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
     .cpu_exec_halt = riscv_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = riscv_cpu_do_interrupt,
     .do_transaction_failed = riscv_cpu_do_transaction_failed,
     .do_unaligned_access = riscv_cpu_do_unaligned_access,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index a51b543028..de2e6a22ff 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -217,6 +217,7 @@ static const TCGCPUOps rx_tcg_ops = {
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = rx_cpu_do_interrupt,
 };
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 99ff58affc..71338aae77 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -365,6 +365,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .tlb_fill = s390_cpu_tlb_fill,
     .cpu_exec_interrupt = s390_cpu_exec_interrupt,
     .cpu_exec_halt = s390_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = s390_cpu_do_interrupt,
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 1885e7d5b2..681237c511 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -275,6 +275,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
     .cpu_exec_halt = superh_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = superh_cpu_do_interrupt,
     .do_unaligned_access = superh_cpu_do_unaligned_access,
     .io_recompile_replay_branch = superh_io_recompile_replay_branch,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 690e74f109..bbdea8556a 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1034,6 +1034,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
     .cpu_exec_halt = sparc_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = sparc_cpu_do_interrupt,
     .do_transaction_failed = sparc_cpu_do_transaction_failed,
     .do_unaligned_access = sparc_cpu_do_unaligned_access,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 9f19e903bc..0fcac697f6 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -182,6 +182,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
 };
 
 static void tricore_cpu_class_init(ObjectClass *c, const void *data)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 27d6e40195..9dcb883208 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -246,6 +246,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
     .cpu_exec_halt = xtensa_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = xtensa_cpu_do_interrupt,
     .do_transaction_failed = xtensa_cpu_do_transaction_failed,
     .do_unaligned_access = xtensa_cpu_do_unaligned_access,
-- 
2.43.0


