Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DCCC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgup-00089Q-3x; Fri, 21 Mar 2025 14:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguh-00087J-Rx
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguf-0000JL-K5
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so20454845e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580967; x=1743185767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+P/qiSsaGl+lH3pYajCrL8gi0KanTXsuPLvggnpxkE=;
 b=JTxrG3HDfXM5nnBWb1VsdycoWuonvqeBs5bdCYM+qcOftmFg2DZ1iKC0y+6G1g8Mnx
 yG+Ar2R4QI6IJ/CASnjQBEHeWxnwJhzNXr9C611Fkhe6hDzQ22Op3/7hLGh4rkUC6cH9
 Aa45rAole/QbEZNWMQGqnrq96Joq69HYx9JJ+YtLtRvDh/W9NZWQWw7yoKagy5UPXwuZ
 qnRMB9oPfMx62iXnrweNEw0sIt6RT7ksVKrSbhI4DPcY1qZl0Yblg/JfROsWMlIuStMh
 Nm+PFU4xGkQuxU4xk4UuTHraqaVuBT08/YKnRfsdJQEsKShhADGQ1UpORJybXXjGAiDT
 D4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580967; x=1743185767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+P/qiSsaGl+lH3pYajCrL8gi0KanTXsuPLvggnpxkE=;
 b=YVjV/tHsKVDasS5SkmH0J8qmCKEdB7zXBiCVMyvjW+zirx9sZtl/s00V+v79Cs1F5I
 wJH5a0bvheMvbwLe0+XGNRezeaONiuQDJqNTOPwz9hDGVZ8JnJN7J5j23nDQJ9w6iORW
 aQEfq4j9+iytppRSLZIoA9ZVfcUBnDMUAy588GDQNk5bPP5ww8MC6k9I9CS8E6IFPUU0
 hH+dlOcru5q+b17jTXYP4hCAbCVpOkknFq2R04mN4+2mjdf7LHOBXibxhmmTgqMky/ls
 Ya2CPeTGaqKjxDMIedyeQUZasRu3h1aC9/fPmleS4exl4VQ9s3kF3jHNurI+dLAg/ISn
 thFQ==
X-Gm-Message-State: AOJu0YzQ2TQcKnvhWac5tjU6FdWaixCu4HJ5hiVSFXU7Uqagenx0gZAr
 NNvoPgwcL9Mm6EiXCYCaLJznfhKRQHY8cAocP1TAHnhUiWObTmZzKondhVclUcWXYgiicLqseYu
 n
X-Gm-Gg: ASbGncs35isqPQ+oiMIC94xzVVsyZ4vVIT++BqV0/yuTIA9Zfvm7zyGpoKyj6iVDS8y
 i0nRU08t2a2aEIFuld56E//d5Kz5gJwdh3StnPDBNHmjeiqfaDKJ7hhot69eQTfRlxn2VmUkULp
 OF0AhG+j9WuutgHIJ4oCyhHK53TSqmkhgfPOC/eHNQgFDEtSjBRI/qrWi9w6QlTw9XYfUQ4itSQ
 wR3qv6xM+KpuUKJ3JYekL6JXxsfxVBlkbHsTXSz4QZytbBUxLKMZcjS+VxeDVOo6ElUjr53Sgue
 ZDiv16e1aJSWrtPhN5DpvCcQGVcX3sToD0z4TwEmycOdrNpVoJ7LLbPNxq8Tx9oQMpCS8CHKvbT
 KwlkQa58FhRsMKNzo76o=
X-Google-Smtp-Source: AGHT+IGIpf6UGASi+Ylv1FcadaYCpwbb4xBSs6WsFzczXUxeP5XqqaAllv6KcRaC4poBq3yqZN7lCg==
X-Received: by 2002:a05:600c:510d:b0:43d:40cc:bdc1 with SMTP id
 5b1f17b1804b1-43d50a1d881mr32140485e9.19.1742580967171; 
 Fri, 21 Mar 2025 11:16:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b565bsm3044365f8f.58.2025.03.21.11.16.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:16:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 3/7] tcg: Define guest_default_memory_order in
 TCGCPUOps
Date: Fri, 21 Mar 2025 19:15:45 +0100
Message-ID: <20250321181549.3331-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Add the TCGCPUOps::guest_default_memory_order field and have
each target initialize it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/accel/tcg/cpu-ops.h | 8 ++++++++
 target/alpha/cpu.c          | 2 ++
 target/arm/cpu.c            | 2 ++
 target/arm/tcg/cpu-v7m.c    | 2 ++
 target/avr/cpu.c            | 1 +
 target/hexagon/cpu.c        | 1 +
 target/hppa/cpu.c           | 2 ++
 target/i386/tcg/tcg-cpu.c   | 2 ++
 target/loongarch/cpu.c      | 2 ++
 target/m68k/cpu.c           | 2 ++
 target/microblaze/cpu.c     | 2 ++
 target/mips/cpu.c           | 2 ++
 target/openrisc/cpu.c       | 2 ++
 target/ppc/cpu_init.c       | 2 ++
 target/riscv/tcg/tcg-cpu.c  | 2 ++
 target/rx/cpu.c             | 2 ++
 target/s390x/cpu.c          | 2 ++
 target/sh4/cpu.c            | 2 ++
 target/sparc/cpu.c          | 2 ++
 target/tricore/cpu.c        | 1 +
 target/xtensa/cpu.c         | 2 ++
 21 files changed, 45 insertions(+)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index f60e5303f21..5fd299cefb6 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -16,8 +16,16 @@
 #include "exec/memop.h"
 #include "exec/mmu-access-type.h"
 #include "exec/vaddr.h"
+#include "tcg/tcg-mo.h"
 
 struct TCGCPUOps {
+
+    /**
+     * @guest_default_memory_order: default barrier that is required
+     *                              for the guest memory ordering.
+     */
+    TCGBar guest_default_memory_order;
+
     /**
      * @initialize: Initialize TCG state
      *
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 584c2aa76bd..00905d48621 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -239,6 +239,8 @@ static const TCGCPUOps alpha_tcg_ops = {
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = alpha_cpu_record_sigsegv,
     .record_sigbus = alpha_cpu_record_sigbus,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 01786ac7879..9e858ae8c77 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2675,6 +2675,8 @@ static const TCGCPUOps arm_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index c4dd3092726..6f714324ffd 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -238,6 +238,8 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = arm_cpu_record_sigsegv,
     .record_sigbus = arm_cpu_record_sigbus,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 834c7082aa7..330e50f74e7 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -216,6 +216,7 @@ static const TCGCPUOps avr_tcg_ops = {
     .cpu_exec_halt = avr_cpu_has_work,
     .tlb_fill = avr_cpu_tlb_fill,
     .do_interrupt = avr_cpu_do_interrupt,
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
 };
 
 static void avr_cpu_class_init(ObjectClass *oc, void *data)
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 766b6786511..669f7440f52 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -324,6 +324,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 2a85495d02f..15cbcd2d957 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -257,6 +257,8 @@ static const TCGCPUOps hppa_tcg_ops = {
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
     .cpu_exec_interrupt = hppa_cpu_exec_interrupt,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b8aff825eec..de2fe8e04f4 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -128,6 +128,8 @@ static const TCGCPUOps x86_tcg_ops = {
     .debug_check_breakpoint = x86_debug_check_breakpoint,
     .need_replay_interrupt = x86_need_replay_interrupt,
 #endif /* !CONFIG_USER_ONLY */
+
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
 };
 
 static void x86_tcg_cpu_init_ops(AccelCPUClass *accel_cpu, CPUClass *cc)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e2705..5b9dd5048d4 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -869,6 +869,8 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
     .cpu_exec_interrupt = loongarch_cpu_exec_interrupt,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 0065e1c1ca5..dc742ddc2cb 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -593,6 +593,8 @@ static const TCGCPUOps m68k_tcg_ops = {
     .translate_code = m68k_translate_code,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = m68k_cpu_tlb_fill,
     .cpu_exec_interrupt = m68k_cpu_exec_interrupt,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f3bebea856e..32f9e32502c 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -432,6 +432,8 @@ static const TCGCPUOps mb_tcg_ops = {
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = mb_cpu_tlb_fill,
     .cpu_exec_interrupt = mb_cpu_exec_interrupt,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd79..207b7d3c8db 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -554,6 +554,8 @@ static const TCGCPUOps mips_tcg_ops = {
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #if !defined(CONFIG_USER_ONLY)
     .tlb_fill = mips_cpu_tlb_fill,
     .cpu_exec_interrupt = mips_cpu_exec_interrupt,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8abf1f8b5c..c6a1d603afb 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -248,6 +248,8 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
     .cpu_exec_interrupt = openrisc_cpu_exec_interrupt,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 8b590e7f17c..28f6f6bc2ba 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7490,6 +7490,8 @@ static const TCGCPUOps ppc_tcg_ops = {
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
 
+  .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5aef9eef366..0e5fa10784d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -139,6 +139,8 @@ static const TCGCPUOps riscv_tcg_ops = {
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = riscv_cpu_tlb_fill,
     .cpu_exec_interrupt = riscv_cpu_exec_interrupt,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0ba0d55ab5b..ae78c661079 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -212,6 +212,8 @@ static const TCGCPUOps rx_tcg_ops = {
     .cpu_exec_interrupt = rx_cpu_exec_interrupt,
     .cpu_exec_halt = rx_cpu_has_work,
     .do_interrupt = rx_cpu_do_interrupt,
+
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
 };
 
 static void rx_cpu_class_init(ObjectClass *klass, void *data)
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d73142600bf..975b8353026 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -360,6 +360,8 @@ static const TCGCPUOps s390_tcg_ops = {
     .debug_excp_handler = s390x_cpu_debug_excp_handler,
     .do_unaligned_access = s390x_cpu_do_unaligned_access,
 #endif /* !CONFIG_USER_ONLY */
+
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
 };
 #endif /* CONFIG_TCG */
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce84bdf539a..6d319dd01c7 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -267,6 +267,8 @@ static const TCGCPUOps superh_tcg_ops = {
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
     .cpu_exec_interrupt = superh_cpu_exec_interrupt,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 57161201173..961c7f92a84 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,8 @@ static const TCGCPUOps sparc_tcg_ops = {
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
     .cpu_exec_interrupt = sparc_cpu_exec_interrupt,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 16acc4ecb92..960e7093f1c 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -179,6 +179,7 @@ static const TCGCPUOps tricore_tcg_ops = {
     .tlb_fill = tricore_cpu_tlb_fill,
     .cpu_exec_interrupt = tricore_cpu_exec_interrupt,
     .cpu_exec_halt = tricore_cpu_has_work,
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
 };
 
 static void tricore_cpu_class_init(ObjectClass *c, void *data)
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 7663b62d01e..0a4068ad7bf 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -237,6 +237,8 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
+    .guest_default_memory_order = TCG_GUEST_DEFAULT_MO,
+
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
     .cpu_exec_interrupt = xtensa_cpu_exec_interrupt,
-- 
2.47.1


