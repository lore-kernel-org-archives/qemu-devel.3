Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70868C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 05:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBpek-0002qh-91; Tue, 28 May 2024 01:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1sBpeZ-0002oX-Lt
 for qemu-devel@nongnu.org; Tue, 28 May 2024 01:45:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexghiti@rivosinc.com>)
 id 1sBpeV-0007mJ-Ab
 for qemu-devel@nongnu.org; Tue, 28 May 2024 01:45:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-354de3c5d00so216343f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 22:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716875137; x=1717479937;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z5ipMF3X7qoEAePKSjTiYn08e2+j1gj41DJw8JcXE2A=;
 b=NLwRvYyPOg9PVKd7qLKeoiH605c7lBOqExkSVab1uniUSkcsl9KFAZTnubJf66tD91
 E+cXb+YZYtO8x0EqX24T+BDoJkuUnjhj0XF0PbjRq9SQBIDcJHcu1WER7S6NpWH0ddxc
 jiqlPEKncR7aKJSX9rmg5d87YcUB6idYihOWvETd/8LsTd3mMhE9TkKhEP8YLnchXgW9
 XHmtSCYj05HuxPlxrakhlD0zro9bNSJkirekjFON7HbNeyG3GVyb0yN9SIbEfTC4SXdt
 gdGvNxMOw3MOiaf3eyCEXmHMF4mPoV+ZSiRlTS8TcJwAxbAEIN6YmTApbWdaFQKc6tvI
 efhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716875137; x=1717479937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5ipMF3X7qoEAePKSjTiYn08e2+j1gj41DJw8JcXE2A=;
 b=N+rDtfYlkSmgy94o+hSoOitlyjQK4OaCbimod7CRFveOwMi+8iFch4VVjDV/Do9eVW
 /WxGoaIITC7L/sNDIVH80+le9bBVXr7zjPSag7DkiZLK845utcWydN8c5+qHlSeXoyos
 c5r3wR2OFYXGnyhLenIYwFa6LIjqZ5F/gN1X+f3Jf6OgAxBgDj2aY7W8t3XxQRAKrao9
 1/hDkjqyuMCuyUJHrDgecNzEuCRIWnonllbSbWSPE/m05eSC2RF5ZMqQZ46Jxqpsbr8w
 1cz+yjlh0eXT+gHQs5FQGpGDYSNkX22RfugKeP4/FIZv16B2GwRHTWohv+rtWPHGs63z
 s02Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsgrTr4pbIC5tthUSq55Qj5q6sRr7pwGrUr+1+kS8/HrcK2eKikZZpXBA7qRi3TssSX72N7T0Lmq4g19R7ruBlbnvStBg=
X-Gm-Message-State: AOJu0YxuV1ncV2NkXVUmL7BlJJRrNJnI16YHihbvdumhABBzFxxCRvcq
 d7IdBQwrvW5YowYoKnC392f4Ri9E638Ty/cWuZgIyxfyxuisLSuGVWv9iWji2rU=
X-Google-Smtp-Source: AGHT+IFnKOn28kZ2YQoIXVaGusRdTs06hXxfs8V45fndQS9Tb06u69uT17UnPeIUHvLOJVtV9Q8EXQ==
X-Received: by 2002:a5d:584e:0:b0:355:95bd:9d01 with SMTP id
 ffacd0b85a97d-35595bd9db3mr12342363f8f.1.1716875136803; 
 Mon, 27 May 2024 22:45:36 -0700 (PDT)
Received: from alex-rivos.home
 (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf06c4sm10657582f8f.104.2024.05.27.22.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 22:45:36 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Gianluca Guida <gianluca@rivosinc.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] targer/riscv: Implement Zabha extension
Date: Tue, 28 May 2024 07:45:35 +0200
Message-Id: <20240528054535.290953-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alexghiti@rivosinc.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Gianluca Guida <gianluca@rivosinc.com>

Add Zabha implementation.

Signed-off-by: Gianluca Guida <gianluca@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 target/riscv/cpu.c                          |   2 +
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/insn32.decode                  |  22 +++
 target/riscv/insn_trans/trans_rvzabha.c.inc | 149 ++++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                  |   5 +
 target/riscv/translate.c                    |   1 +
 6 files changed, 180 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 70d1a527a1..b01f82002b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -116,6 +116,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
+    ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_12_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
     ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
@@ -1464,6 +1465,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
     MULTI_EXT_CFG_BOOL("zihintpause", ext_zihintpause, true),
+    MULTI_EXT_CFG_BOOL("zabha", ext_zabha, false),
     MULTI_EXT_CFG_BOOL("zacas", ext_zacas, false),
     MULTI_EXT_CFG_BOOL("zaamo", ext_zaamo, false),
     MULTI_EXT_CFG_BOOL("zalrsc", ext_zalrsc, false),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index d36c416ef0..7f614da4e2 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -81,6 +81,7 @@ struct RISCVCPUConfig {
     bool ext_svvptc;
     bool ext_zdinx;
     bool ext_zaamo;
+    bool ext_zabha;
     bool ext_zacas;
     bool ext_zalrsc;
     bool ext_zawrs;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..6d7726120f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1010,3 +1010,25 @@ amocas_w    00101 . . ..... ..... 010 ..... 0101111 @atom_st
 amocas_d    00101 . . ..... ..... 011 ..... 0101111 @atom_st
 # *** RV64 Zacas Standard Extension ***
 amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
+
+# *** Zabha Standard Extension ***
+amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
+amoadd_b   00000 . . ..... ..... 000 ..... 0101111 @atom_st
+amoxor_b   00100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoand_b   01100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoor_b    01000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomin_b   10000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomax_b   10100 . . ..... ..... 000 ..... 0101111 @atom_st
+amominu_b  11000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomaxu_b  11100 . . ..... ..... 000 ..... 0101111 @atom_st
+amocas_b   00101 . . ..... ..... 000 ..... 0101111 @atom_st
+amoswap_h  00001 . . ..... ..... 001 ..... 0101111 @atom_st
+amoadd_h   00000 . . ..... ..... 001 ..... 0101111 @atom_st
+amoxor_h   00100 . . ..... ..... 001 ..... 0101111 @atom_st
+amoand_h   01100 . . ..... ..... 001 ..... 0101111 @atom_st
+amoor_h    01000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
+amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
+amocas_h   00101 . . ..... ..... 001 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
new file mode 100644
index 0000000000..74f43bb95a
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -0,0 +1,149 @@
+/*
+ * RISC-V translation routines for the Zabha Standard Extension.
+ *
+ * Copyright (c) 2023 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define REQUIRE_ZABHA(ctx) do {                 \
+        if (!ctx->cfg_ptr->ext_zabha) {         \
+            return false;                       \
+        }                                       \
+    } while (0)
+
+#define REQUIRE_ZABHA_AND_ZACAS(ctx) do {                               \
+        if (!ctx->cfg_ptr->ext_zabha || !ctx->cfg_ptr->ext_zacas) {     \
+            return false;                                               \
+        }                                                               \
+    } while (0)
+
+static bool trans_amoswap_b(DisasContext *ctx, arg_amoswap_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SB);
+}
+
+static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amoadd_b(DisasContext *ctx, arg_amoadd_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SB);
+}
+
+static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amoxor_b(DisasContext *ctx, arg_amoxor_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SB);
+}
+
+static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amoand_b(DisasContext *ctx, arg_amoand_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SB);
+}
+
+static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amoor_b(DisasContext *ctx, arg_amoor_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SB);
+}
+
+static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amomin_b(DisasContext *ctx, arg_amomin_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SB);
+}
+
+static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amomax_b(DisasContext *ctx, arg_amomax_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SB);
+}
+
+static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amominu_b(DisasContext *ctx, arg_amominu_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SB);
+}
+
+static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SB);
+}
+
+static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, (MO_ALIGN | MO_TESW));
+}
+
+static bool trans_amocas_b(DisasContext *ctx, arg_amocas_b *a)
+{
+    REQUIRE_ZABHA_AND_ZACAS(ctx);
+    return gen_cmpxchg(ctx, a, MO_SB);
+}
+
+static bool trans_amocas_h(DisasContext *ctx, arg_amocas_h *a)
+{
+    REQUIRE_ZABHA_AND_ZACAS(ctx);
+    return gen_cmpxchg(ctx, a, (MO_ALIGN | MO_TESW));
+}
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b5b95e052d..25a57bac0f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -456,6 +456,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if ((cpu->cfg.ext_zabha) && !riscv_has_ext(env, RVA)) {
+        error_setg(errp, "Zabha extension requires A extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zawrs) && !riscv_has_ext(env, RVA)) {
         error_setg(errp, "Zawrs extension requires A extension");
         return;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 9ff09ebdb6..1e128711db 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1097,6 +1097,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvb.c.inc"
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzacas.c.inc"
+#include "insn_trans/trans_rvzabha.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzfa.c.inc"
-- 
2.39.2


