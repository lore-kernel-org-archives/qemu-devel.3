Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE44E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA4O-0002t7-8H; Mon, 16 Dec 2024 07:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4L-0002rU-2M; Mon, 16 Dec 2024 07:19:26 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4I-00008v-I6; Mon, 16 Dec 2024 07:19:24 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-54025432becso4095119e87.1; 
 Mon, 16 Dec 2024 04:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351560; x=1734956360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qAcbYEnRS7o9rC9jvNDK3zjAtJ9uEReZ4ErtbZMdWc=;
 b=hcoKt3rTdAHUQuCJrLv4qn3TIIAKTRfKk9ZKA1gZUG6YrCMWSoR0RBZ2ND+pMkVYuP
 KrCmT9/+NEx0MQKCDjGioRWFsM++V/W1KBqOgfGk3aTAJgiUvWwoLyTnDlV3zYE33vQ5
 K5v7gqUPzs4zHRy5AIxN/9BBC9U/xp7xOF9ka2yogWSM08MjoVEmD8poS6fqecA7kqw2
 zZTufAYQl6OHh6WQ0hZaGUZt9N7pzlsc+YgI+tzVEn10zEfCBWcrvmMAE8k8ctli3u67
 o56bO3mltSu9Xg3BQbkBNoDa/c3EhOo/tck76fjntA8EgtNzIq3K53E1sFreq3Rs7Gnw
 fF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351560; x=1734956360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qAcbYEnRS7o9rC9jvNDK3zjAtJ9uEReZ4ErtbZMdWc=;
 b=wI1iBCKS5I04edf9fkL2IW4Z01LqxHBExcCwPTwHgQUO/fJ7gEiMR5qqGp94AhCyWS
 aDFwOYANGILGDUXkPL1n/UpHsShYRVYz+zl3nXTX9zFkKaIDUR56i+vq0x2dfeawiUai
 QOfJNEJqUn8QM+weIngyp+d13NZo138n0hE6GTZkmsNFLCgP9xq1vZl2oo76mRiDqCNn
 6aWX3uoY9k/CP/MIQ5A+ezINdzcTGNkuAE6LvYtnZTPRwu7xW3/H0RogpS2F9iBE/0ia
 s+daG61GLyG2T0e5XHpOaFj7tzi+vrIT6E/4Tw7xo234dQPXFeLPH6CkSEf7JRFHqAve
 Jg7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZzJ8ZhK4XMWZYxItpW3plNMzZMqqdhkuCGTpvg+FM067WhGzF3BbjieKBRKuWzbCmPKOqHSkFwwUo@nongnu.org,
 AJvYcCXJgTE82zjCnsy7nAREGADmTIe9m4ogjeba9cT4379SLDj8Mtgci+u/Ny0zhJgwHpB2UHpE5oWhulo+ug==@nongnu.org
X-Gm-Message-State: AOJu0YzAingb3/limODUvaBxXb5mwbpydWl6POt/+knAZovk3QZTfnYA
 uMdOxeD672f3iqv9yFM9fLvYNuwgZn9oNzIBTGdspZnV2Y55jRGK
X-Gm-Gg: ASbGncsD44MVBhqeIEU36Cfb9WImNAlVS1eOhsnl8YCs0L1iwVa6EdH9P7aqvcgk0Cv
 z9j9GJ5BPb2DlXLXv4bSPPGuJIXMsrznBO1z95d4k7Tluy9Fn/EhVKX6mwz2VHmatKJSlJzNAWg
 +M/BbgnuMyIDAdHAwyex0ubR2eNzFjctj7mfQ9qembeTCN9vteLDCiT22ViBN+FAtJlkSQOAUHL
 5F0SM9g5i+pgljwzfgQDdmBCdfB7MRS6CwqVV3k5mTs+6Shlb4SeFBATXcwfg==
X-Google-Smtp-Source: AGHT+IEAxm5b1ZaYBPnruX7H+WqO8nDWEhzQFX1uHW2AyZBfkUoSRR1G+josWXm36f7nfBeuvmESNA==
X-Received: by 2002:a05:6512:138f:b0:53f:8c46:42bd with SMTP id
 2adb3069b0e04-5409054d767mr3493846e87.15.1734351559864; 
 Mon, 16 Dec 2024 04:19:19 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13d0esm827143e87.192.2024.12.16.04.19.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 04:19:18 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 5/7] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Mon, 16 Dec 2024 15:19:05 +0300
Message-Id: <20241216121907.660504-6-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216121907.660504-1-baturo.alexey@gmail.com>
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Alexey Baturo <baturo.alexey@gmail.com>

Signed-off-by: Alexey Baturo <baturo.alexey@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c     | 22 ++++++++++++++++------
 target/riscv/vector_helper.c | 16 ++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bb92f36ba1..32df295123 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -588,8 +588,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_addi_tl(addr, src1, imm);
-    if (get_address_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
 
     return addr;
@@ -602,8 +604,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
 
     tcg_gen_add_tl(addr, src1, offs);
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32u_tl(addr, addr);
+    if (ctx->addr_signed) {
+        tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
+    } else {
+        tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
 
     return addr;
@@ -1233,8 +1237,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
-    ctx->addr_xl = 0;
-    ctx->addr_signed = false;
+    if (get_xl(ctx) == MXL_RV32) {
+        ctx->addr_xl = 32;
+        ctx->addr_signed = false;
+    } else {
+        int pm_pmm = FIELD_EX32(tb_flags, TB_FLAGS, PM_PMM);
+        ctx->addr_xl = 64 - riscv_pm_get_pmlen(pm_pmm);
+        ctx->addr_signed = FIELD_EX32(tb_flags, TB_FLAGS, PM_SIGNEXTEND);
+    }
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3589e3ef28..37c6c198a5 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -107,6 +107,22 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
 static inline target_ulong adjust_addr(CPURISCVState *env, target_ulong addr)
 {
+    if (riscv_cpu_mxl(env) == MXL_RV32) {
+        return addr;
+    }
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
2.39.5


