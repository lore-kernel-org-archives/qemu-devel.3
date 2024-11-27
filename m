Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED21D6ACC6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGzF-0004n3-1j; Wed, 27 Nov 2024 07:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyy-0004dD-Sx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:31 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGyu-0008LI-P7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43497839b80so30875775e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709837; x=1733314637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UUGCjRn4dTEY6SyGbCBusbLfPJq+6yezwKl0LVNO1Q0=;
 b=Kxb06jA2SkCzxurnJxtOY0g89flyX1ulqoP2MkOQDueaKo5dqngtIrGyzaqi9RlDM6
 sOFBan9axx5eZAXCIDCIBU6zltJwkavAG/yCoAjxK7BSm9/2frZW375VzMj4H3vWXe5Z
 1LfKwRhy8YbkGgUrHfGphHPEetiQ7BmQDbSBSIAXHHbr2+ghLu+P1itLHYjV1qGNbw2g
 1g09D8ulsQVbKrjwNgAszOAQAiw9fwYUJSaq6sKwfTYC9RBJVy1EmDnpQRcQ751H5ycD
 w1XeQzXvhuB1Z8I2VQEjMMYH3BUM82AQ7q/RSCRlxvCL+uR4Ctn7looJu04h5nndB+0L
 IBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709837; x=1733314637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUGCjRn4dTEY6SyGbCBusbLfPJq+6yezwKl0LVNO1Q0=;
 b=QFJwcz0KLfLeJxR2Ys+AvqBQ3im4T5L1kvkTzk7Sg9NtZJUpGP/HNxcTlxQckt9Co3
 zjg+D4Zxc4FltmtiJKFj7s5L5sap1068JrBIuSTa7tT1bY4oZb9eexOm5141zv2HR348
 S+/2PK8IbmDRo1t/+r70bDdMgSKjMCwe6keE+nfyVPXctNsACfai9D8bzD0OHEcqyQ7G
 5ni3Cu8GN0+TtAtdg3TH44YeENnKjwsQ4Jn0Jt1zis1uuJA5fe2ZESMiTa2I50vzhtKn
 unoqVeNJkMNeNfBrrNf42LdOeiZpT+P3itetFVhSOji7pCqR6H0DQwUCLPBFyYAqtr08
 m+kQ==
X-Gm-Message-State: AOJu0Ywp1AUIbTJUjTgvlYrUD7f6rMUbFgKj4sHWXABQPJulr8x7tczj
 UXdXLeBp8UxyWMOovlgO9CV9jLlEvvdDk3323SNtphVNcrcuNpGPVEUTRUy8KXRzIv0tSuXaE/V
 u
X-Gm-Gg: ASbGncuDczm/JRqawRGwMr03Xc9jpRTY87Wdcs4k8SPWeXMpdil6QbxJzN+yimBbJWt
 lwqhPHd0NZQHG6xYM0mq+SmYKcXEtQIWy7fsRDgRlJJHc1HYodyFHw1xr65fH69QdnHKOg7r3aJ
 ZBkjNDqlPsmaOjqt6ur66l9eBQkI0p/sWBJ8vPIj9ithzEuR7a+wn+rPoavqFVbDhVWQ2Uz2il/
 03bL1N9VnwarWRHqSET/DNgY0GQWkGn8N/ZjJ67w1UFno+xW1rPBb6VzXy3DtlPkRg3b82piMAF
 iJOvm6oJopBRNzw1TP9FfBc003kXrfm8gldSjfKkrjQ=
X-Google-Smtp-Source: AGHT+IG7B23T06pCYe7jfDLgjVtafECDOvLd2y6D2sG9pKYg63yaaZs/ZqyQ0VVz6PQWR0tmYdNWKg==
X-Received: by 2002:a05:600c:5101:b0:434:942c:1466 with SMTP id
 5b1f17b1804b1-434a9df6d91mr23523965e9.29.1732709836811; 
 Wed, 27 Nov 2024 04:17:16 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fafe158sm16170000f8f.27.2024.11.27.04.17.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 3/6] accel/tcg: Rename TCGCPUOps::initialize() as
 initialize_once()
Date: Wed, 27 Nov 2024 13:16:55 +0100
Message-ID: <20241127121658.88966-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127121658.88966-1-philmd@linaro.org>
References: <20241127121658.88966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

While this handler can be called multiple times, it will
only be run once. Clarify by renaming the handler name.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
We could "optimize" TGC frontends memory use by passing
a CPUClass argument, and each initialize() call would
initialize TCG registers required for a particular CPUClass
which are not yet initialized by previous calls. Not
a priority / worth it.
---
 include/hw/core/tcg-cpu-ops.h | 6 +++---
 accel/tcg/cpu-exec.c          | 2 +-
 target/alpha/cpu.c            | 2 +-
 target/arm/cpu.c              | 2 +-
 target/arm/tcg/cpu-v7m.c      | 2 +-
 target/avr/cpu.c              | 2 +-
 target/hexagon/cpu.c          | 2 +-
 target/hppa/cpu.c             | 2 +-
 target/i386/tcg/tcg-cpu.c     | 2 +-
 target/loongarch/cpu.c        | 2 +-
 target/m68k/cpu.c             | 2 +-
 target/microblaze/cpu.c       | 2 +-
 target/mips/cpu.c             | 2 +-
 target/openrisc/cpu.c         | 2 +-
 target/ppc/cpu_init.c         | 2 +-
 target/riscv/tcg/tcg-cpu.c    | 2 +-
 target/rx/cpu.c               | 2 +-
 target/s390x/cpu.c            | 2 +-
 target/sh4/cpu.c              | 2 +-
 target/sparc/cpu.c            | 2 +-
 target/tricore/cpu.c          | 2 +-
 target/xtensa/cpu.c           | 2 +-
 22 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 663efb9133c..9a01eb87bfb 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -19,11 +19,11 @@
 
 struct TCGCPUOps {
     /**
-     * @initialize: Initialize TCG state
+     * @initialize_once: Initialize TCG state
      *
-     * Called when the first CPU is realized.
+     * Called once when the first CPU is realized.
      */
-    void (*initialize)(void);
+    void (*initialize_once)(void);
     /**
      * @synchronize_from_tb: Synchronize state from a TCG #TranslationBlock
      *
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 18d9cf0ea58..ab77740c954 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1078,7 +1078,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
-        tcg_ops->initialize();
+        tcg_ops->initialize_once();
         tcg_target_initialized = true;
     }
 
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 5d75c941f7a..4a20b0c5d16 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -220,7 +220,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
-    .initialize = alpha_translate_init,
+    .initialize_once = alpha_translate_init,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6938161b954..f5b0c33a6dc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,7 +2671,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
-    .initialize = arm_translate_init,
+    .initialize_once = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 58e54578d67..7a887a29b75 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -233,7 +233,7 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
-    .initialize = arm_translate_init,
+    .initialize_once = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
     .restore_state_to_opc = arm_restore_state_to_opc,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 3132842d565..e69b5a6af9b 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -206,7 +206,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
-    .initialize = avr_cpu_tcg_init,
+    .initialize_once = avr_cpu_tcg_init,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
     .cpu_exec_interrupt = avr_cpu_exec_interrupt,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 020038fc490..6f7777c607e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -322,7 +322,7 @@ static void hexagon_cpu_init(Object *obj)
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
-    .initialize = hexagon_translate_init,
+    .initialize_once = hexagon_translate_init,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
 };
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index c38439c1800..e654f133636 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -221,7 +221,7 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
-    .initialize = hppa_translate_init,
+    .initialize_once = hppa_translate_init,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
 
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e8..b44d2f370d1 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -107,7 +107,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
-    .initialize = tcg_x86_init,
+    .initialize_once = tcg_x86_init,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
     .cpu_exec_enter = x86_cpu_exec_enter,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 57cc4f314bf..32aa5468ceb 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -793,7 +793,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
-    .initialize = loongarch_translate_init,
+    .initialize_once = loongarch_translate_init,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 5fe335558aa..230057b7375 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -546,7 +546,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
-    .initialize = m68k_tcg_init,
+    .initialize_once = m68k_tcg_init,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 710eb1146c1..f75e1cf5ab1 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -420,7 +420,7 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
-    .initialize = mb_tcg_init,
+    .initialize_once = mb_tcg_init,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index d0a43b6d5c7..4f7d9c03599 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -551,7 +551,7 @@ static Property mips_cpu_properties[] = {
  * mips hardware (see hw/mips/jazz.c).
  */
 static const TCGCPUOps mips_tcg_ops = {
-    .initialize = mips_tcg_init,
+    .initialize_once = mips_tcg_init,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index b96561d1f26..24125eea1e7 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -232,7 +232,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
-    .initialize = openrisc_translate_init,
+    .initialize_once = openrisc_translate_init,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index daf7f8a93bd..9f90de7f6bd 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7416,7 +7416,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
-    .initialize = ppc_translate_init,
+    .initialize_once = ppc_translate_init,
     .restore_state_to_opc = ppc_restore_state_to_opc,
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = ppc_cpu_record_sigsegv,
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c62c2216961..2be43b90908 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -133,7 +133,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
-    .initialize = riscv_translate_init,
+    .initialize_once = riscv_translate_init,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
 
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65a74ce720f..7c338b584e8 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,7 +192,7 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
-    .initialize = rx_translate_init,
+    .initialize_once = rx_translate_init,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
     .tlb_fill = rx_cpu_tlb_fill,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 514c70f3010..a5ab2a083b5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -357,7 +357,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
-    .initialize = s390x_translate_init,
+    .initialize_once = s390x_translate_init,
     .restore_state_to_opc = s390x_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 8f07261dcfd..75d6504293f 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -247,7 +247,7 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
-    .initialize = sh4_translate_init,
+    .initialize_once = sh4_translate_init,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index dd7af86de73..d803c329650 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -927,7 +927,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
-    .initialize = sparc_tcg_init,
+    .initialize_once = sparc_tcg_init,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 1a261715907..19c583ed326 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -170,7 +170,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
-    .initialize = tricore_tcg_init,
+    .initialize_once = tricore_tcg_init,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
     .tlb_fill = tricore_cpu_tlb_fill,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 6f9039abaee..71c0a10ef0c 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -227,7 +227,7 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
-    .initialize = xtensa_translate_init,
+    .initialize_once = xtensa_translate_init,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
 
-- 
2.45.2


