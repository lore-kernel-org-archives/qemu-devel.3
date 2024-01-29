Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA03EC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXDS-0005q4-VZ; Mon, 29 Jan 2024 14:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDK-0005l3-D8; Mon, 29 Jan 2024 14:22:39 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDI-0002ep-LR; Mon, 29 Jan 2024 14:22:38 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33934567777so2600764f8f.1; 
 Mon, 29 Jan 2024 11:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706556154; x=1707160954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0GE1uw0zcZ/RbheH52pZpq6ApriTvoaSXwZy9TyWAI=;
 b=i78QyUkTJAmdZWKpbIzoO5EHiIUbBne58scZHfroRuej0vQ43pe8KxXe5Dp6zVe7wH
 DShIW/g/ACzs/dMKjGWwZZiSCXTpisldCYLoiILPLpUxTNwvLKEVysY411GBvV0ORdfL
 ngetIaFPHIpnIs6Oq9OK5WqOmbW26GxmDXCxs/2n85q1awkYVHiQEGFmeGY6FMwqZrGc
 KdbRFEp/40pWcwio5+EGbkDghXHL8QUltvy9LV9NwFhs14aO4EwH6SvNmQ41Kx4FXFK3
 iIZnaBUiU8zdHTQJF/EFjit8cLOUUw8V/f9m5uEDwobuVMPRPDsJOhLY3SfPcyfkJtDa
 IBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556154; x=1707160954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0GE1uw0zcZ/RbheH52pZpq6ApriTvoaSXwZy9TyWAI=;
 b=rKlTTMY2R3uqUczc0qJgw0t1VjKkJ+MyjovzqXWutRBO7nxxNDL/xe3Gq1U8Y6FPTm
 IDFxlMEF/TlxMgiJsRnunQ0/fOYbA3HBU+U28DKsEIrJJ8MV8PMxpfNDe3QgBrDvHvQ4
 3o1N5FYBGCOucm0pISEaxkqUjUVHSpji/4GNNGhV8XowizmNAsEdJ3A/rdNYF413c9Ct
 qDkgXUhh5ITT8zc1/+c5SkYgt/k+qqOz30equ+2KIEOrABK5HxeZfb925WP9+WuIa5oh
 II6D1vSXMeH6zIDt6+bEzjCyXgtt1ZLDhE7EaBkPJ3oAIKpD+pp3qVrMOjAaXCRdYUAZ
 1kNQ==
X-Gm-Message-State: AOJu0YyAEcCS94ewaFME3ijOUMTxCAkAtQbt8imN9CwcPYRz4Gj6otnJ
 wirsRFn6Qy+FFQ2osJHfDtccPFnmpAyDlB3Fv4jV9U9KzI4Lz3Y6
X-Google-Smtp-Source: AGHT+IG/eBTLXleX9J8YCrx1wwwBdptzrnBa5nRSR8J5phi6oVnmb2bfZNR+39wGNqUfODrEkIaj0A==
X-Received: by 2002:adf:f707:0:b0:337:c50f:386b with SMTP id
 r7-20020adff707000000b00337c50f386bmr4868145wrp.24.1706556154578; 
 Mon, 29 Jan 2024 11:22:34 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 co28-20020a0560000a1c00b0033af0cb2a35sm2577206wrb.108.2024.01.29.11.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:22:33 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 5/6] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Mon, 29 Jan 2024 19:22:06 +0000
Message-Id: <20240129192207.2946870-6-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192207.2946870-1-me@deliversmonkey.space>
References: <20240129192207.2946870-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_POST=0.62, TVD_PH_BODY_META_ALL=2.564,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 13 +++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2c89d749c0..457de381c7 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -579,8 +579,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (get_address_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
     }
 
     return addr;
@@ -593,8 +595,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_width);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_width);
     }
     return addr;
 }
@@ -1179,8 +1183,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->addr_width = 0;
-    ctx->addr_signed = false;
+    if (get_xl(ctx) == MXL_RV32) {
+        ctx->addr_width = 32;
+        ctx->addr_signed = false;
+    } else {
+        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
+        ctx->addr_width = 64 - riscv_pm_get_pmlen(pm_pmm);
+        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
+    }
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8e7a8e80a0..ff1178723c 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -94,6 +94,19 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
+    RISCVPmPmm pmm = riscv_pm_get_pmm(env);
+    if (pmm == PMM_FIELD_DISABLED) {
+        return addr;
+    }
+    int pmlen = riscv_pm_get_pmlen(pmm);
+    bool signext = riscv_cpu_virt_mem_enabled(env);
+    addr = addr << pmlen;
+    /* sign/zero extend masked address by N-1 bit */
+    if (signext) {
+        addr = (target_long)addr >> pmlen;
+    } else {
+        addr = addr >> pmlen;
+    }
     return addr;
 }
 
-- 
2.34.1


