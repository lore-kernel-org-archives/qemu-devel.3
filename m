Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A509C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadO-0005xg-TU; Mon, 29 Jan 2024 18:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadI-0005v6-2o
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:40 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadF-0008Np-77
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:39 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6e1352dd653so559522a34.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569295; x=1707174095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+/x34hZ0Savjf5fK/vjCGUP8dkpzXoOGlANXKjp7EA=;
 b=WGZwP0KhITZQjdxgvoorOCSzITI3NAVMlCHVcigytIj07dWjToaA8YGxm31GugUpPU
 bV/DPGpYKLtkVudM8hYFBMzhqi0a3BZvLyxJ5rb2cp46w3bqc65oHXF/kx2oK0YUMC7u
 50bBxG3FJB35wETanamr7wImqBv2o2WqhWB06SE5CtBY0La/nsbp12JBbBuC2eyvN0ZJ
 HuOt00SnbLuf2dP1fc8BolPAoOl+/Hetr8OszQcQHKy9Vdb+R2Bq+L5pc0X+LgLOdoh3
 GM3D24LdDUtRjqpRDnJDekCwNmPO4iZ1wC5cOnAUN/8FWwCiViX1FsNsqA1yRo3GX2br
 Q9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569295; x=1707174095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9+/x34hZ0Savjf5fK/vjCGUP8dkpzXoOGlANXKjp7EA=;
 b=Ns098JYTd8HTDo0rG86o29mJ2eF0IOiWx5FcTjz8RgKiDmeR4svJ36en19ED2zg/3M
 DvtAcCZ5441aGkzhnnw+TTJ/RiheigZb7s9uJMw3CNvOCfvnIwNJLtTYwUQoGYjFGhMM
 +A2TZsT6PCCDk75X+IeIQjylw0dquwGjb6wUYwzjj4py/OTAGM9L4RIqocR7ArCf3SKi
 nQN8Ufpu9/yvfE6JBIWrJqPZxdSjuIgYWfzU9i1vZBmiP2gCrhBdaAUfqOrNhW/a7wTv
 RzKKrD4q3rFvkuKe2hz2xIjftbN3Fkv7OKulA2tQEqkWdyiWt0c29PJfVWIr0ROB2Emh
 lAjQ==
X-Gm-Message-State: AOJu0YwjNibAOTQL35BpcgwXOugq15MehgtUwSE5PwX5Xa4cdB3tfQVK
 tCERMLXkVdA7aL2EYGA0IKZJ3VqTjuThh1KtSJU9c/zcNoOCNXGSgNGAI12FDs0nlHYc32b41OF
 wIF0=
X-Google-Smtp-Source: AGHT+IEbVoIFYWjj/pfJz5yb8TNljovz/mgrADFgDRoipZg3gInQE+60cpKeFYFZsA9z4hV1gzi58Q==
X-Received: by 2002:a05:6358:63a5:b0:178:6d3d:4cc1 with SMTP id
 k37-20020a05635863a500b001786d3d4cc1mr3100664rwh.24.1706569295376; 
 Mon, 29 Jan 2024 15:01:35 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 04/31] target: Use vaddr in gen_intermediate_code
Date: Tue, 30 Jan 2024 09:00:54 +1000
Message-Id: <20240129230121.8091-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

From: Anton Johansson <anjo@rev.ng>

Makes gen_intermediate_code() signature target agnostic so the function
can be called from accel/tcg/translate-all.c without target specifics.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240119144024.14289-9-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h        | 2 +-
 target/alpha/translate.c         | 2 +-
 target/arm/tcg/translate.c       | 2 +-
 target/avr/translate.c           | 2 +-
 target/cris/translate.c          | 2 +-
 target/hexagon/translate.c       | 2 +-
 target/hppa/translate.c          | 2 +-
 target/i386/tcg/translate.c      | 2 +-
 target/loongarch/tcg/translate.c | 2 +-
 target/m68k/translate.c          | 2 +-
 target/microblaze/translate.c    | 2 +-
 target/mips/tcg/translate.c      | 2 +-
 target/nios2/translate.c         | 2 +-
 target/openrisc/translate.c      | 2 +-
 target/ppc/translate.c           | 2 +-
 target/riscv/translate.c         | 2 +-
 target/rx/translate.c            | 2 +-
 target/s390x/tcg/translate.c     | 2 +-
 target/sh4/translate.c           | 2 +-
 target/sparc/translate.c         | 2 +-
 target/tricore/translate.c       | 2 +-
 target/xtensa/translate.c        | 2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 6d3f59d095..b0412ea6b6 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -33,7 +33,7 @@
  * the target-specific DisasContext, and then invoke translator_loop.
  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc);
+                           vaddr pc, void *host_pc);
 
 /**
  * DisasJumpType:
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..134eb7225b 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2971,7 +2971,7 @@ static const TranslatorOps alpha_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &alpha_tr_ops, &dc.base);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b3660173d1..5fa8249723 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9691,7 +9691,7 @@ static const TranslatorOps thumb_translator_ops = {
 
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..e5dd057799 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2805,7 +2805,7 @@ static const TranslatorOps avr_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = { };
     translator_loop(cs, tb, max_insns, pc, host_pc, &avr_tr_ops, &dc.base);
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..ee1402a9a3 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3172,7 +3172,7 @@ static const TranslatorOps cris_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cs, tb, max_insns, pc, host_pc, &cris_tr_ops, &dc.base);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 95579ae243..a14211cf68 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1154,7 +1154,7 @@ static const TranslatorOps hexagon_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 3ef39b1bd7..08d09d50d7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4631,7 +4631,7 @@ static const TranslatorOps hppa_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc, &hppa_tr_ops, &ctx.base);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e193c74472..2808903661 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -7088,7 +7088,7 @@ static const TranslatorOps i386_tr_ops = {
 
 /* generate intermediate code for basic block 'tb'.  */
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 21f4db6fbd..235515c629 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -343,7 +343,7 @@ static const TranslatorOps loongarch_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4a0b0b2703..5ec88c5f0d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -6088,7 +6088,7 @@ static const TranslatorOps m68k_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &m68k_tr_ops, &dc.base);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 49bfb4a0ea..2e628647d1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1792,7 +1792,7 @@ static const TranslatorOps mb_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cpu, tb, max_insns, pc, host_pc, &mb_tr_ops, &dc.base);
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 13e43fa3b6..e10232738c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15554,7 +15554,7 @@ static const TranslatorOps mips_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index e806623594..3078372b36 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -1036,7 +1036,7 @@ static const TranslatorOps nios2_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
     translator_loop(cs, tb, max_insns, pc, host_pc, &nios2_tr_ops, &dc.base);
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ecff4412b7..d4cbc5eaea 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1658,7 +1658,7 @@ static const TranslatorOps openrisc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..049f636927 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7518,7 +7518,7 @@ static const TranslatorOps ppc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 071fbad7ef..ab18899122 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1287,7 +1287,7 @@ static const TranslatorOps riscv_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index c6ce717a95..2265bd14ac 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2266,7 +2266,7 @@ static const TranslatorOps rx_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 8df00b7df9..a5fd9cccaa 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6547,7 +6547,7 @@ static const TranslatorOps s390x_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc;
 
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 81f825f125..6a6d862b10 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2317,7 +2317,7 @@ static const TranslatorOps sh4_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9387299559..97184fa403 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5327,7 +5327,7 @@ static const TranslatorOps sparc_tr_ops = {
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
 
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 66553d1be0..f1156c39e7 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8472,7 +8472,7 @@ static const TranslatorOps tricore_tr_ops = {
 
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext ctx;
     translator_loop(cs, tb, max_insns, pc, host_pc,
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 87947236ca..e4772462b5 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1239,7 +1239,7 @@ static const TranslatorOps xtensa_translator_ops = {
 };
 
 void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int *max_insns,
-                           target_ulong pc, void *host_pc)
+                           vaddr pc, void *host_pc)
 {
     DisasContext dc = {};
     translator_loop(cpu, tb, max_insns, pc, host_pc,
-- 
2.34.1


