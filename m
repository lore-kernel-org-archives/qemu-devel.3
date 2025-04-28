Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA379C3ABA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UoJ-00058x-OR; Mon, 28 Apr 2025 16:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoG-00057w-FI
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9UoD-0000c5-VA
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:10:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so4555123b3a.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871032; x=1746475832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKPsJ6ZVAGJ0+GPlTFL3NdqK+t0dmAFv9HFtSqvjns0=;
 b=uoVWWgogb+h/IyMOmggk9+2uP8/ENnZt8DXg3hChhJZOUD1I9YzI7L50t8OiKJoBTJ
 YivWsq4SHEb204qy76yQ5j19OAAB3fQL8n4rAbZevMVAympvT8/SaihratgEmve+6nSn
 I7KX0ZfVvL04glMJUg6AjBcj6ISR4XeIcFiDbafRSX2Rc7lJqSqpw0068lIOrvSkBcYn
 OBrUM4cPDRh2qejyp3U5VJ4577P1JScowb3+aGs1QYfEsjp60ckDf3hldKsyyPDSN7go
 PYcaQveoiujzjA4yTbR/RLv+XJAVSx3IdGGeQt7RG+rKA07wnvLENrnl3bLiX3RrhMAu
 aGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871032; x=1746475832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKPsJ6ZVAGJ0+GPlTFL3NdqK+t0dmAFv9HFtSqvjns0=;
 b=ByLWNLSMrDN6sdf9WfaG9Fj4NAML4joKsxL3Xg8CDT786uXM3M+QHc6qoo52KBjlPU
 eUlyPzQ5vXAqQtFoKLxgCc/pwr9ADsYfXzKb7iLKJZO/L4m7P6eufpQWzOCqqWU009i4
 MsKRpbH+eiQbUyVS1vKmJVXltAVckQUXCpigJKFxdF7N62DKZ0Dk9LQq8X0RhgONyN0J
 VpKhf1RiGZmtArOaW2fAZa6bwSRrFe8xRMfmH/O48/pI4oCvknJdE0ruvD0Vs+JAhsEV
 djWG/mIp51h/jgXuFv6hwMAOtNrNs0QweiwqJDurRmWLGLbGEfQymzI5gr83dErNJQDJ
 94/g==
X-Gm-Message-State: AOJu0YxZH/g4CpNdGV2U9ZY6nigpz/vZ2kIpPuCRHObhoKoZuw7G4Lj6
 SzWWYQpHJcWQjI0gPIgiE8mK4JQZF29GKEZ0EBx/Pr/t+qX9iA8PLeZDQ2sODTVxJBYBURcoNGa
 F
X-Gm-Gg: ASbGnctWWPbp8RTEfmDxkjtW3ySbieauQSjm2oNB3uTDlYUF6UwMsov2I8OYE5bwyBg
 3xIoRgVVg7Lx9w6cJOiXlLc4vhPv+cNNQeZvXTtUyIPb8G+SFmWPEx+7kQCK1ZLFV8DG8KU7620
 kbtLIDy/ljFlY0jd8EicfMnQ+C3CdPkq338kg3YGU4qkSwgYxHQgMTfEsUaLxrhIIwEJOl9gaLl
 gO33ylsa+O2jEjjN21jL27P76rY+L3bCChI392frqc+ydwuoeOmsV6r5aROS54uFi1b+yUAtYav
 kiu5iQwtW1tlaRhDEmD9IKFpYPh4knUqZ9DXMMgr44FsMNuqFzHUcxERikbPZ/bic76NrrPLK34
 ytQKP1A38Iw==
X-Google-Smtp-Source: AGHT+IHHuvzMm58ilZ3anBiZRcwXRzARoFElFXq/gGMZMIVJSWlEUYrbLg0RTFbFgdwahsUE5zN50w==
X-Received: by 2002:a05:6a00:39a0:b0:736:2a73:675b with SMTP id
 d2e1a72fcca58-740271e1d3amr1605147b3a.19.1745871031974; 
 Mon, 28 Apr 2025 13:10:31 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25912fb9sm8469976b3a.34.2025.04.28.13.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 13:10:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 03/10] accel/tcg: Introduce TCGCPUOps.cpu_exec_reset
Date: Mon, 28 Apr 2025 13:10:21 -0700
Message-ID: <20250428201028.1699157-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428201028.1699157-1-richard.henderson@linaro.org>
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
index cb3f382dc6..9dc1c7242b 100644
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
index e149a46250..9e74d7bc07 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2688,6 +2688,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .tlb_fill_align = arm_cpu_tlb_fill_align,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = arm_cpu_do_interrupt,
     .do_transaction_failed = arm_cpu_do_transaction_failed,
     .do_unaligned_access = arm_cpu_do_unaligned_access,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index f71560aa43..57ed3f3a06 100644
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
index 86e53ef9f6..e50ebfd8f8 100644
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
index 6acbf3de27..300c6b809f 100644
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
index d441c0752e..63ddf87aa8 100644
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
index 1fb6633581..3cb7aa6039 100644
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
index 99adc5eb91..c8c1dbeac9 100644
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
index 658d3cb3d7..6b14377819 100644
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
index 26f4f038cd..9f6441d7af 100644
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
index d3c366dd86..ffdc011a44 100644
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
index fde7d71fc6..5981f607d2 100644
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
index 916fd6fb43..e3e7fea66a 100644
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
index 0a7a2b55b5..c9615f0655 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -217,6 +217,7 @@ static const TCGCPUOps rx_tcg_ops = {
 
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
     .do_interrupt = rx_cpu_do_interrupt,
 };
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e3623ad32a..f4289f9857 100644
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
index 0a04f149d7..2cafb56a23 100644
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
index c864217175..5a1f5b7915 100644
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
index bdbcaf0dfc..36c82888e8 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -182,6 +182,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
+    .cpu_exec_reset = cpu_reset,
 };
 
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 971e67ad97..a13f1f950a 100644
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


