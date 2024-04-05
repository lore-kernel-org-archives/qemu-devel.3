Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D0BC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglJ-00065J-Mq; Fri, 05 Apr 2024 06:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsglD-00060t-5B
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:27 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl9-0004l2-Rw
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:26 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so1667565a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312722; x=1712917522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xNyC/7w5lA4PawgdSfIi4uhxiZqg6pbt9Zx3p79WqLc=;
 b=XxfhnjyMDKXSk5QWzWuyPdmEdqGtLv0FpIRnBwjXp8AJtij6Bn8iKSIxHmdyJUAmCw
 /hUUoSy4rt6uvnsn+Y62qCjaZZZhIsP2RvUFrK988bvhSK8DSwK4aMO1a2yje/3FtONc
 m3HcJucXvklkjNEA/Dfyl9UtgnJ9IbNK+yVMQ26glFni8KobK9x7QxFga0YVMXErS2yf
 sZAiKbO+BtNCU1FPs/eZOccBas6W2aDr0gaO50R58MFll//WGwIVIy6n3JlK7pB5OsKu
 YjbZ97SM4aadOcbbf32znZurlxrhw45OfJ9XCGyJkSaC3sO68X8bcGz6o3HT4jvZ9Hjz
 0QVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312722; x=1712917522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xNyC/7w5lA4PawgdSfIi4uhxiZqg6pbt9Zx3p79WqLc=;
 b=WlYgnVSg6bMOJqj6jOmUdGA+v00+EnOZKwcXC9KBexEnNLgARqLKD6UtgOmmPX9Tx2
 KsgW5MRIDvHikYcvN8bKhmVQnvW8f+/hlFuhs6IaWKBVB8EXZQLzNynOB96SbdXrGmg6
 SPLA0uSDEjpaszBVfISk1uBfDtlruMs03CIco59kTiGAgOEXmCLWt9qbRl13jq75KB/D
 amw97ZxdLKZKC0K8VfZXsvt3QOunykn6/uJCXI1ertuCCdPiRCE5teC53TTW680bvmAy
 krWcovspPw1sfQcvQiEk6h8TPE/EMEn6TJwCa4/JKtF3hIayc4+UPf8IHPd3Zq0egCZZ
 P9WQ==
X-Gm-Message-State: AOJu0YwIzoV7mEfnkgIQuvJXINc7Tq5/zBSdXH60eLmvCzQ/0+nkS569
 9r7ewjwMKG8CVN74t4MxVsKn5U10rNJuQ/JJOxDKDDyCvunWJ8iCda2HIht544U61nk1Raa89lo
 R
X-Google-Smtp-Source: AGHT+IE6+DS/cIjjt/9Sv2f14GRyj5b3tUB8S4XIp30+HMne7Fjfq+Bv2SnnqM+bb+BFDuS00723IA==
X-Received: by 2002:a05:6a20:3951:b0:1a7:3b7c:3126 with SMTP id
 r17-20020a056a20395100b001a73b7c3126mr1089795pzg.5.1712312722230; 
 Fri, 05 Apr 2024 03:25:22 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/32] accel/tcg: Provide default implementation of disas_log
Date: Fri,  5 Apr 2024 00:24:43 -1000
Message-Id: <20240405102459.462551-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Almost all of the disas_log implementations are identical.
Unify them within translator_loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c           |  9 ++++++++-
 target/alpha/translate.c         |  9 ---------
 target/arm/tcg/translate-a64.c   | 11 -----------
 target/arm/tcg/translate.c       | 12 ------------
 target/avr/translate.c           |  8 --------
 target/cris/translate.c          | 11 -----------
 target/hexagon/translate.c       |  9 ---------
 target/hppa/translate.c          |  6 ++++--
 target/i386/tcg/translate.c      | 11 -----------
 target/loongarch/tcg/translate.c |  8 --------
 target/m68k/translate.c          |  9 ---------
 target/microblaze/translate.c    |  9 ---------
 target/mips/tcg/translate.c      |  9 ---------
 target/nios2/translate.c         |  9 ---------
 target/openrisc/translate.c      | 11 -----------
 target/ppc/translate.c           |  9 ---------
 target/riscv/translate.c         | 18 ------------------
 target/rx/translate.c            |  8 --------
 target/sh4/translate.c           |  9 ---------
 target/sparc/translate.c         |  9 ---------
 target/tricore/translate.c       |  9 ---------
 target/xtensa/translate.c        |  9 ---------
 22 files changed, 12 insertions(+), 200 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 46483414d2..2a69916b9a 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -16,6 +16,7 @@
 #include "exec/cpu_ldst.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
+#include "disas/disas.h"
 
 static void set_can_do_io(DisasContextBase *db, bool val)
 {
@@ -222,7 +223,13 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
             fprintf(logfile, "----------------\n");
-            ops->disas_log(db, cpu, logfile);
+
+            if (ops->disas_log) {
+                ops->disas_log(db, cpu, logfile);
+            } else {
+                fprintf(logfile, "IN: %s\n", lookup_symbol(db->pc_first));
+                target_disas(logfile, cpu, db->pc_first, db->tb->size);
+            }
             fprintf(logfile, "\n");
             qemu_log_unlock(logfile);
         }
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index a97cd54f0c..9669334da8 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "sysemu/cpus.h"
-#include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
@@ -2940,20 +2939,12 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void alpha_tr_disas_log(const DisasContextBase *dcbase,
-                               CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps alpha_tr_ops = {
     .init_disas_context = alpha_tr_init_disas_context,
     .tb_start           = alpha_tr_tb_start,
     .insn_start         = alpha_tr_insn_start,
     .translate_insn     = alpha_tr_translate_insn,
     .tb_stop            = alpha_tr_tb_stop,
-    .disas_log          = alpha_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 340265beb0..1b627c9660 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -22,7 +22,6 @@
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
-#include "disas/disas.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
@@ -14363,20 +14362,10 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void aarch64_tr_disas_log(const DisasContextBase *dcbase,
-                                 CPUState *cpu, FILE *logfile)
-{
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dc->base.pc_first));
-    target_disas(logfile, cpu, dc->base.pc_first, dc->base.tb->size);
-}
-
 const TranslatorOps aarch64_translator_ops = {
     .init_disas_context = aarch64_tr_init_disas_context,
     .tb_start           = aarch64_tr_tb_start,
     .insn_start         = aarch64_tr_insn_start,
     .translate_insn     = aarch64_tr_translate_insn,
     .tb_stop            = aarch64_tr_tb_stop,
-    .disas_log          = aarch64_tr_disas_log,
 };
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 69585e6003..c8e1827b07 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -23,7 +23,6 @@
 #include "translate.h"
 #include "translate-a32.h"
 #include "qemu/log.h"
-#include "disas/disas.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
@@ -9663,22 +9662,12 @@ static void arm_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void arm_tr_disas_log(const DisasContextBase *dcbase,
-                             CPUState *cpu, FILE *logfile)
-{
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dc->base.pc_first));
-    target_disas(logfile, cpu, dc->base.pc_first, dc->base.tb->size);
-}
-
 static const TranslatorOps arm_translator_ops = {
     .init_disas_context = arm_tr_init_disas_context,
     .tb_start           = arm_tr_tb_start,
     .insn_start         = arm_tr_insn_start,
     .translate_insn     = arm_tr_translate_insn,
     .tb_stop            = arm_tr_tb_stop,
-    .disas_log          = arm_tr_disas_log,
 };
 
 static const TranslatorOps thumb_translator_ops = {
@@ -9687,7 +9676,6 @@ static const TranslatorOps thumb_translator_ops = {
     .insn_start         = arm_tr_insn_start,
     .translate_insn     = thumb_tr_translate_insn,
     .tb_stop            = arm_tr_tb_stop,
-    .disas_log          = arm_tr_disas_log,
 };
 
 /* generate intermediate code for basic block 'tb'.  */
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 87e2bd5ef1..6df93d4c77 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2787,20 +2787,12 @@ static void avr_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void avr_tr_disas_log(const DisasContextBase *dcbase,
-                             CPUState *cs, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cs, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps avr_tr_ops = {
     .init_disas_context = avr_tr_init_disas_context,
     .tb_start           = avr_tr_tb_start,
     .insn_start         = avr_tr_insn_start,
     .translate_insn     = avr_tr_translate_insn,
     .tb_stop            = avr_tr_tb_stop,
-    .disas_log          = avr_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3a4d61d0a..b5410189d4 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
@@ -3148,22 +3147,12 @@ static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void cris_tr_disas_log(const DisasContextBase *dcbase,
-                              CPUState *cpu, FILE *logfile)
-{
-    if (!DISAS_CRIS) {
-        fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-        target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-    }
-}
-
 static const TranslatorOps cris_tr_ops = {
     .init_disas_context = cris_tr_init_disas_context,
     .tb_start           = cris_tr_tb_start,
     .insn_start         = cris_tr_insn_start,
     .translate_insn     = cris_tr_translate_insn,
     .tb_stop            = cris_tr_tb_stop,
-    .disas_log          = cris_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index c9bf0e7508..1344a3e4ab 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1138,21 +1138,12 @@ static void hexagon_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void hexagon_tr_disas_log(const DisasContextBase *dcbase,
-                                 CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
-
 static const TranslatorOps hexagon_tr_ops = {
     .init_disas_context = hexagon_tr_init_disas_context,
     .tb_start           = hexagon_tr_tb_start,
     .insn_start         = hexagon_tr_insn_start,
     .translate_insn     = hexagon_tr_translate_packet,
     .tb_stop            = hexagon_tr_tb_stop,
-    .disas_log          = hexagon_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8a1a8bc3aa..7470795578 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4815,12 +4815,12 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
+#ifdef CONFIG_USER_ONLY
 static void hppa_tr_disas_log(const DisasContextBase *dcbase,
                               CPUState *cs, FILE *logfile)
 {
     target_ulong pc = dcbase->pc_first;
 
-#ifdef CONFIG_USER_ONLY
     switch (pc) {
     case 0x00:
         fprintf(logfile, "IN:\n0x00000000:  (null)\n");
@@ -4835,11 +4835,11 @@ static void hppa_tr_disas_log(const DisasContextBase *dcbase,
         fprintf(logfile, "IN:\n0x00000100:  syscall\n");
         return;
     }
-#endif
 
     fprintf(logfile, "IN: %s\n", lookup_symbol(pc));
     target_disas(logfile, cs, pc, dcbase->tb->size);
 }
+#endif
 
 static const TranslatorOps hppa_tr_ops = {
     .init_disas_context = hppa_tr_init_disas_context,
@@ -4847,7 +4847,9 @@ static const TranslatorOps hppa_tr_ops = {
     .insn_start         = hppa_tr_insn_start,
     .translate_insn     = hppa_tr_translate_insn,
     .tb_stop            = hppa_tr_tb_stop,
+#ifdef CONFIG_USER_ONLY
     .disas_log          = hppa_tr_disas_log,
+#endif
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 07f642dc9e..796180f085 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/host-utils.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
@@ -7069,22 +7068,12 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void i386_tr_disas_log(const DisasContextBase *dcbase,
-                              CPUState *cpu, FILE *logfile)
-{
-    DisasContext *dc = container_of(dcbase, DisasContext, base);
-
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dc->base.pc_first));
-    target_disas(logfile, cpu, dc->base.pc_first, dc->base.tb->size);
-}
-
 static const TranslatorOps i386_tr_ops = {
     .init_disas_context = i386_tr_init_disas_context,
     .tb_start           = i386_tr_tb_start,
     .insn_start         = i386_tr_insn_start,
     .translate_insn     = i386_tr_translate_insn,
     .tb_stop            = i386_tr_tb_stop,
-    .disas_log          = i386_tr_disas_log,
 };
 
 /* generate intermediate code for basic block 'tb'.  */
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 7567712655..1fca4afc73 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -325,20 +325,12 @@ static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void loongarch_tr_disas_log(const DisasContextBase *dcbase,
-                                   CPUState *cpu, FILE *logfile)
-{
-    qemu_log("IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps loongarch_tr_ops = {
     .init_disas_context = loongarch_tr_init_disas_context,
     .tb_start           = loongarch_tr_tb_start,
     .insn_start         = loongarch_tr_insn_start,
     .translate_insn     = loongarch_tr_translate_insn,
     .tb_stop            = loongarch_tr_tb_stop,
-    .disas_log          = loongarch_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 6ae3df43bc..8af3e6bac0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
@@ -6063,20 +6062,12 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void m68k_tr_disas_log(const DisasContextBase *dcbase,
-                              CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps m68k_tr_ops = {
     .init_disas_context = m68k_tr_init_disas_context,
     .tb_start           = m68k_tr_tb_start,
     .insn_start         = m68k_tr_insn_start,
     .translate_insn     = m68k_tr_translate_insn,
     .tb_stop            = m68k_tr_tb_stop,
-    .disas_log          = m68k_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 916afd4dec..be3ff76f78 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
@@ -1775,20 +1774,12 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
     }
 }
 
-static void mb_tr_disas_log(const DisasContextBase *dcb,
-                            CPUState *cs, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcb->pc_first));
-    target_disas(logfile, cs, dcb->pc_first, dcb->tb->size);
-}
-
 static const TranslatorOps mb_tr_ops = {
     .init_disas_context = mb_tr_init_disas_context,
     .tb_start           = mb_tr_tb_start,
     .insn_start         = mb_tr_insn_start,
     .translate_insn     = mb_tr_translate_insn,
     .tb_stop            = mb_tr_tb_stop,
-    .disas_log          = mb_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 06c108cc9c..333469b268 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -29,7 +29,6 @@
 #include "exec/translation-block.h"
 #include "semihosting/semihost.h"
 #include "trace.h"
-#include "disas/disas.h"
 #include "fpu_helper.h"
 
 #define HELPER_H "helper.h"
@@ -15475,20 +15474,12 @@ static void mips_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void mips_tr_disas_log(const DisasContextBase *dcbase,
-                              CPUState *cs, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cs, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps mips_tr_ops = {
     .init_disas_context = mips_tr_init_disas_context,
     .tb_start           = mips_tr_tb_start,
     .insn_start         = mips_tr_insn_start,
     .translate_insn     = mips_tr_translate_insn,
     .tb_stop            = mips_tr_tb_stop,
-    .disas_log          = mips_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 9c3958a0ba..07a9f83c6a 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -25,7 +25,6 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
-#include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
 #include "exec/log.h"
@@ -1019,20 +1018,12 @@ static void nios2_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void nios2_tr_disas_log(const DisasContextBase *dcbase,
-                               CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps nios2_tr_ops = {
     .init_disas_context = nios2_tr_init_disas_context,
     .tb_start           = nios2_tr_tb_start,
     .insn_start         = nios2_tr_insn_start,
     .translate_insn     = nios2_tr_translate_insn,
     .tb_stop            = nios2_tr_tb_stop,
-    .disas_log          = nios2_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 23fff46084..ca566847cb 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "disas/disas.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
@@ -1638,22 +1637,12 @@ static void openrisc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void openrisc_tr_disas_log(const DisasContextBase *dcbase,
-                                  CPUState *cs, FILE *logfile)
-{
-    DisasContext *s = container_of(dcbase, DisasContext, base);
-
-    fprintf(logfile, "IN: %s\n", lookup_symbol(s->base.pc_first));
-    target_disas(logfile, cs, s->base.pc_first, s->base.tb->size);
-}
-
 static const TranslatorOps openrisc_tr_ops = {
     .init_disas_context = openrisc_tr_init_disas_context,
     .tb_start           = openrisc_tr_tb_start,
     .insn_start         = openrisc_tr_insn_start,
     .translate_insn     = openrisc_tr_translate_insn,
     .tb_stop            = openrisc_tr_tb_stop,
-    .disas_log          = openrisc_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 93ffec787c..49dee6cab0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "internal.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
@@ -7405,20 +7404,12 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void ppc_tr_disas_log(const DisasContextBase *dcbase,
-                             CPUState *cs, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cs, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps ppc_tr_ops = {
     .init_disas_context = ppc_tr_init_disas_context,
     .tb_start           = ppc_tr_tb_start,
     .insn_start         = ppc_tr_insn_start,
     .translate_insn     = ppc_tr_translate_insn,
     .tb_stop            = ppc_tr_tb_stop,
-    .disas_log          = ppc_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9d57089fcc..9fd1ac1d60 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -20,7 +20,6 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "tcg/tcg-op.h"
-#include "disas/disas.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
@@ -1271,29 +1270,12 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void riscv_tr_disas_log(const DisasContextBase *dcbase,
-                               CPUState *cpu, FILE *logfile)
-{
-#ifndef CONFIG_USER_ONLY
-    RISCVCPU *rvcpu = RISCV_CPU(cpu);
-    CPURISCVState *env = &rvcpu->env;
-#endif
-
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-#ifndef CONFIG_USER_ONLY
-    fprintf(logfile, "Priv: "TARGET_FMT_ld"; Virt: %d\n",
-            env->priv, env->virt_enabled);
-#endif
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps riscv_tr_ops = {
     .init_disas_context = riscv_tr_init_disas_context,
     .tb_start           = riscv_tr_tb_start,
     .insn_start         = riscv_tr_insn_start,
     .translate_insn     = riscv_tr_translate_insn,
     .tb_stop            = riscv_tr_tb_stop,
-    .disas_log          = riscv_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/rx/translate.c b/target/rx/translate.c
index f6e9e0ec90..92fb2b43ad 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2247,20 +2247,12 @@ static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void rx_tr_disas_log(const DisasContextBase *dcbase,
-                            CPUState *cs, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cs, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps rx_tr_ops = {
     .init_disas_context = rx_tr_init_disas_context,
     .tb_start           = rx_tr_tb_start,
     .insn_start         = rx_tr_insn_start,
     .translate_insn     = rx_tr_translate_insn,
     .tb_stop            = rx_tr_tb_stop,
-    .disas_log          = rx_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index a9b1bc7524..b062d1b1d6 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -19,7 +19,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/helper-proto.h"
@@ -2298,20 +2297,12 @@ static void sh4_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void sh4_tr_disas_log(const DisasContextBase *dcbase,
-                             CPUState *cs, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cs, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps sh4_tr_ops = {
     .init_disas_context = sh4_tr_init_disas_context,
     .tb_start           = sh4_tr_tb_start,
     .insn_start         = sh4_tr_insn_start,
     .translate_insn     = sh4_tr_translate_insn,
     .tb_stop            = sh4_tr_tb_stop,
-    .disas_log          = sh4_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 319934d9bd..b128cc366f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
@@ -4998,20 +4997,12 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
     }
 }
 
-static void sparc_tr_disas_log(const DisasContextBase *dcbase,
-                               CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps sparc_tr_ops = {
     .init_disas_context = sparc_tr_init_disas_context,
     .tb_start           = sparc_tr_tb_start,
     .insn_start         = sparc_tr_insn_start,
     .translate_insn     = sparc_tr_translate_insn,
     .tb_stop            = sparc_tr_tb_stop,
-    .disas_log          = sparc_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index c45e1d992e..a46a03e1fd 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg/tcg-op.h"
 #include "exec/cpu_ldst.h"
@@ -8453,20 +8452,12 @@ static void tricore_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void tricore_tr_disas_log(const DisasContextBase *dcbase,
-                                 CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps tricore_tr_ops = {
     .init_disas_context = tricore_tr_init_disas_context,
     .tb_start           = tricore_tr_tb_start,
     .insn_start         = tricore_tr_insn_start,
     .translate_insn     = tricore_tr_translate_insn,
     .tb_stop            = tricore_tr_tb_stop,
-    .disas_log          = tricore_tr_disas_log,
 };
 
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index b206d57fc4..42109d33ad 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -32,7 +32,6 @@
 
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "disas/disas.h"
 #include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "qemu/qemu-print.h"
@@ -1221,20 +1220,12 @@ static void xtensa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     }
 }
 
-static void xtensa_tr_disas_log(const DisasContextBase *dcbase,
-                                CPUState *cpu, FILE *logfile)
-{
-    fprintf(logfile, "IN: %s\n", lookup_symbol(dcbase->pc_first));
-    target_disas(logfile, cpu, dcbase->pc_first, dcbase->tb->size);
-}
-
 static const TranslatorOps xtensa_translator_ops = {
     .init_disas_context = xtensa_tr_init_disas_context,
     .tb_start           = xtensa_tr_tb_start,
     .insn_start         = xtensa_tr_insn_start,
     .translate_insn     = xtensa_tr_translate_insn,
     .tb_stop            = xtensa_tr_tb_stop,
-    .disas_log          = xtensa_tr_disas_log,
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-- 
2.34.1


