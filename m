Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC099D6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGzE-0004jv-AY; Wed, 27 Nov 2024 07:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGz6-0004do-Ts
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:35 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGz3-0008Oy-Nm
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:32 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-382378f359dso4874001f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709847; x=1733314647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vns9bqBuR5cnqvo3EIuMottCnMJCI/I9HZl614iUdF8=;
 b=sBKESlkEUoyGrWo3pXae3o0PUG+BZA0Bs/RaW18JeNN5awEXffSiBJ0Neg2s7SGALn
 KueOa1Ch4pjY4Sl/QdMDOMajiMaIxqt3jjABvWqYzchWYSaL7KIQI5mloFKG1Fhv9Qye
 TAMiKusp0+I3R1zG+uC23CAUlLLIb3J7Zx989qwYTbCTkdwvm/gCoZb4RlNKQ3yKKRlM
 91XcBwlfLUXKqcdFJqI0aDPVYhtgsC80DLKrMQqAbY5v+ZzMF1xtNMqdeS3VF97xSpOm
 oZu078UJsJaUGGWF8IdrkRCc7F2ijTAx3gm1xq1G5OJmAHTe4bNCglMHFbUWblxSAP44
 mR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709847; x=1733314647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vns9bqBuR5cnqvo3EIuMottCnMJCI/I9HZl614iUdF8=;
 b=S8G6Ma+0GihSYayNhIbWQf7pE5v8ZmZVEQp+EHkrJyJdyByX6iraIlXBkHHwWbJhC0
 PpLwGkiiW4DSULh5bAlYUfBQfYobjbMN9DnwlpsY1OOh3c7PhLHroByHlmn+/g+Da9Rx
 c1ebhap2WUtNvlY51SILkjdmE3vbgsH7ixuaoSe7ZvwY0qtiII5sBSuE4nKNFF301XTX
 hPaIwVyweaJuGorzXLSH8tJRRT/Yjl3FznhWYSYVNgYG2l3oq8uF1jMEHV+lGgkG699x
 BcBMgrZOlclAZoXSDHXF1rbSQR8V6kMV74Phv605y7qebAYC0p4d0PFwHiIzYUxmLaaV
 pqyw==
X-Gm-Message-State: AOJu0Yzkq47lO4+og6mIR67jKITrbISsEIOGjOf/8JX5Eyv91SAbPCli
 Oj/sUprh5GthDEw5JelB35Me1x/bRKbX8j7nMdn69ptUrbPQpu/9nUoWN8qc+MASLTUuCMAuixz
 N
X-Gm-Gg: ASbGncvgDmw2KE6k/DiGHLECVTMO9rrq5dBG6dbdL5BLWiWha+IRAgRbr/mKZMIZEZa
 WJhDbefDcVwqQEJKVHWvwByOAM5XdQ85CoS2R16PJtCiQja1trYAmkOwgDQWfwQBUp3jAwEu0OS
 9xgXJBC6Ca8XeaVZ18dRUSkfqH1g/sLRG6fwhd9AH5KqBtM7PHJkRtK7H0MNpWs7gjyH5Tzqy0C
 7ijkSlgOcE+3vLOla2+KXhgfDV93XvrVJjxoxJDdYtSitB5meIYaPiDGLZKH32GBee59aJymCZ+
 BEIBJ4B6NJtcgf+M3K2FxS3qcTb5FZwwsva233As2o4=
X-Google-Smtp-Source: AGHT+IG5tiJenNQw0m27Qs/4K0McssL84TMGSF3gCDnWRmBvScqyJWE8Ed0lOGL4TDEXr5UIrsjIzQ==
X-Received: by 2002:adf:e185:0:b0:382:3894:346c with SMTP id
 ffacd0b85a97d-385c6eba8b3mr2230726f8f.27.1732709847507; 
 Wed, 27 Nov 2024 04:17:27 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedfccsm16080714f8f.101.2024.11.27.04.17.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 5/6] accel/tcg: Add TCGCPUOps::arch_id field
Date: Wed, 27 Nov 2024 13:16:57 +0100
Message-ID: <20241127121658.88966-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127121658.88966-1-philmd@linaro.org>
References: <20241127121658.88966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

When using multiple TCG frontends concurrently, we need to
be able to discriminate by target architecture. While we
can infer that from the CPUClass, it can be quicker to get
it from a direct field in TCGCPUOps.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/tcg-cpu-ops.h | 3 +++
 target/alpha/cpu.c            | 1 +
 target/arm/cpu.c              | 1 +
 target/arm/tcg/cpu-v7m.c      | 1 +
 target/avr/cpu.c              | 1 +
 target/hexagon/cpu.c          | 1 +
 target/hppa/cpu.c             | 1 +
 target/i386/tcg/tcg-cpu.c     | 1 +
 target/loongarch/cpu.c        | 1 +
 target/m68k/cpu.c             | 1 +
 target/microblaze/cpu.c       | 1 +
 target/mips/cpu.c             | 1 +
 target/openrisc/cpu.c         | 1 +
 target/ppc/cpu_init.c         | 1 +
 target/riscv/tcg/tcg-cpu.c    | 1 +
 target/rx/cpu.c               | 1 +
 target/s390x/cpu.c            | 1 +
 target/sh4/cpu.c              | 1 +
 target/sparc/cpu.c            | 1 +
 target/tricore/cpu.c          | 1 +
 target/xtensa/cpu.c           | 1 +
 21 files changed, 23 insertions(+)

diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index 9a01eb87bfb..ec3d2b50a9e 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -10,6 +10,7 @@
 #ifndef TCG_CPU_OPS_H
 #define TCG_CPU_OPS_H
 
+#include "qemu/arch_id.h"
 #include "exec/breakpoint.h"
 #include "exec/hwaddr.h"
 #include "exec/memattrs.h"
@@ -18,6 +19,8 @@
 #include "exec/vaddr.h"
 
 struct TCGCPUOps {
+    QemuArch arch_id;
+
     /**
      * @initialize_once: Initialize TCG state
      *
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 4a20b0c5d16..e020b4ce173 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -220,6 +220,7 @@ static const struct SysemuCPUOps alpha_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps alpha_tcg_ops = {
+    .arch_id = QEMU_ARCH_ALPHA,
     .initialize_once = alpha_translate_init,
     .synchronize_from_tb = alpha_cpu_synchronize_from_tb,
     .restore_state_to_opc = alpha_restore_state_to_opc,
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f5b0c33a6dc..9b088c893bf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2671,6 +2671,7 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 
 #ifdef CONFIG_TCG
 static const TCGCPUOps arm_tcg_ops = {
+    .arch_id = QEMU_ARCH_ARM,
     .initialize_once = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 7a887a29b75..7a316561acc 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -233,6 +233,7 @@ static void cortex_m55_initfn(Object *obj)
 }
 
 static const TCGCPUOps arm_v7m_tcg_ops = {
+    .arch_id = QEMU_ARCH_ARM,
     .initialize_once = arm_translate_init,
     .synchronize_from_tb = arm_cpu_synchronize_from_tb,
     .debug_excp_handler = arm_debug_excp_handler,
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index e69b5a6af9b..a9cce351755 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -206,6 +206,7 @@ static const struct SysemuCPUOps avr_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps avr_tcg_ops = {
+    .arch_id = QEMU_ARCH_AVR,
     .initialize_once = avr_cpu_tcg_init,
     .synchronize_from_tb = avr_cpu_synchronize_from_tb,
     .restore_state_to_opc = avr_restore_state_to_opc,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 6f7777c607e..2a3b2e5fb4f 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -322,6 +322,7 @@ static void hexagon_cpu_init(Object *obj)
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps hexagon_tcg_ops = {
+    .arch_id = QEMU_ARCH_HEXAGON,
     .initialize_once = hexagon_translate_init,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index e654f133636..9bee8ef24f6 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -221,6 +221,7 @@ static const struct SysemuCPUOps hppa_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps hppa_tcg_ops = {
+    .arch_id = QEMU_ARCH_HPPA,
     .initialize_once = hppa_translate_init,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b44d2f370d1..0577d6237a9 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -107,6 +107,7 @@ static bool x86_debug_check_breakpoint(CPUState *cs)
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps x86_tcg_ops = {
+    .arch_id = QEMU_ARCH_I386,
     .initialize_once = tcg_x86_init,
     .synchronize_from_tb = x86_cpu_synchronize_from_tb,
     .restore_state_to_opc = x86_restore_state_to_opc,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 32aa5468ceb..96ae8c4ef05 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -793,6 +793,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps loongarch_tcg_ops = {
+    .arch_id = QEMU_ARCH_LOONGARCH,
     .initialize_once = loongarch_translate_init,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 230057b7375..8a45fbe9d2f 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -546,6 +546,7 @@ static const struct SysemuCPUOps m68k_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps m68k_tcg_ops = {
+    .arch_id = QEMU_ARCH_M68K,
     .initialize_once = m68k_tcg_init,
     .restore_state_to_opc = m68k_restore_state_to_opc,
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f75e1cf5ab1..e2cfbbbbefd 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -420,6 +420,7 @@ static const struct SysemuCPUOps mb_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps mb_tcg_ops = {
+    .arch_id = QEMU_ARCH_MICROBLAZE,
     .initialize_once = mb_tcg_init,
     .synchronize_from_tb = mb_cpu_synchronize_from_tb,
     .restore_state_to_opc = mb_restore_state_to_opc,
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 4f7d9c03599..769f25551c7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -551,6 +551,7 @@ static Property mips_cpu_properties[] = {
  * mips hardware (see hw/mips/jazz.c).
  */
 static const TCGCPUOps mips_tcg_ops = {
+    .arch_id = QEMU_ARCH_MIPS,
     .initialize_once = mips_tcg_init,
     .synchronize_from_tb = mips_cpu_synchronize_from_tb,
     .restore_state_to_opc = mips_restore_state_to_opc,
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 24125eea1e7..ac041b4427b 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -232,6 +232,7 @@ static const struct SysemuCPUOps openrisc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps openrisc_tcg_ops = {
+    .arch_id = QEMU_ARCH_OPENRISC,
     .initialize_once = openrisc_translate_init,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 9f90de7f6bd..13295b9dfcb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7416,6 +7416,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
+    .arch_id = QEMU_ARCH_PPC,
     .initialize_once = ppc_translate_init,
     .restore_state_to_opc = ppc_restore_state_to_opc,
 #ifdef CONFIG_USER_ONLY
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2be43b90908..ad00183a830 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -133,6 +133,7 @@ static void riscv_restore_state_to_opc(CPUState *cs,
 }
 
 static const TCGCPUOps riscv_tcg_ops = {
+    .arch_id = QEMU_ARCH_RISCV,
     .initialize_once = riscv_translate_init,
     .synchronize_from_tb = riscv_cpu_synchronize_from_tb,
     .restore_state_to_opc = riscv_restore_state_to_opc,
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 7c338b584e8..12ed4a4101f 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -192,6 +192,7 @@ static const struct SysemuCPUOps rx_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps rx_tcg_ops = {
+    .arch_id = QEMU_ARCH_RX,
     .initialize_once = rx_translate_init,
     .synchronize_from_tb = rx_cpu_synchronize_from_tb,
     .restore_state_to_opc = rx_restore_state_to_opc,
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a5ab2a083b5..984cacce2d4 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -357,6 +357,7 @@ void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
 }
 
 static const TCGCPUOps s390_tcg_ops = {
+    .arch_id = QEMU_ARCH_S390X,
     .initialize_once = s390x_translate_init,
     .restore_state_to_opc = s390x_restore_state_to_opc,
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 75d6504293f..cd7336bd7f2 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -247,6 +247,7 @@ static const struct SysemuCPUOps sh4_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps superh_tcg_ops = {
+    .arch_id = QEMU_ARCH_SH4,
     .initialize_once = sh4_translate_init,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d803c329650..7e89c4033b2 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -927,6 +927,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps sparc_tcg_ops = {
+    .arch_id = QEMU_ARCH_SPARC,
     .initialize_once = sparc_tcg_init,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 19c583ed326..a8864955201 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -170,6 +170,7 @@ static const struct SysemuCPUOps tricore_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps tricore_tcg_ops = {
+    .arch_id = QEMU_ARCH_TRICORE,
     .initialize_once = tricore_tcg_init,
     .synchronize_from_tb = tricore_cpu_synchronize_from_tb,
     .restore_state_to_opc = tricore_restore_state_to_opc,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 71c0a10ef0c..5d115328ffb 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -227,6 +227,7 @@ static const struct SysemuCPUOps xtensa_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps xtensa_tcg_ops = {
+    .arch_id = QEMU_ARCH_XTENSA,
     .initialize_once = xtensa_translate_init,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
-- 
2.45.2


