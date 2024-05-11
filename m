Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D0C25B75
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 10:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5jhI-0005VF-N7; Sat, 11 May 2024 06:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhF-0005TS-M3; Sat, 11 May 2024 06:11:17 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1s5jhA-0002AQ-5o; Sat, 11 May 2024 06:11:15 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a5a157a1cd1so703841866b.0; 
 Sat, 11 May 2024 03:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715422270; x=1716027070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NChut3Wu3U+/heFB1RR2XoMpJXwZZWmP15KDXMsEMrE=;
 b=Az+Q8f/FFKbNJerkTHZVCPp/xWfayPHyR+maaU0AcyRaARB1GSRspppiXjsvNm4HNP
 0Zot4mHDc9jzhiKWRIIbTF04VP0KDjl6pscY913F2yz2E1e1K0+VeA3CKvwISwPZsE1I
 rE6un5wCvRf1exu0boRDl0EzE/e4KTwfkqE36fbFOUWd9LTiR8KD/d6iJ0wCG1pDUUJD
 JGZBCcgcn4sP6OwGeU9l5BE7Y9O88Q0kIzm70XoHaPlhFVsont+6cRVRJulitVnjdetH
 GL+i9PNVUHIudb/DheeC5aGiKpnAxnhJ3squHlHobLOTOhDIK6O2QxzXdvXjrsSIT6/H
 bCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715422270; x=1716027070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NChut3Wu3U+/heFB1RR2XoMpJXwZZWmP15KDXMsEMrE=;
 b=nc/1Oth/2wvvLL1B9zWBabv/QV7dDydgYwUYuiKlJfhf58AdWni52H6It0FCAikVI4
 zldVs8HFwLLudB9ygx5yKBrbWzutjwy7DLqL+kDf64Rib3dfxwp084QHIgJF14L80v3b
 ZUk+EvzV53z6nwhlsa93S2ZCJx74kFewzHo4iWUEeiacUigL9vHs0M+scnygcxloHVxa
 /nQoZmJvQQe+wcsCrr9xQBvBItAQ01p+zCiUzzuTSvphws/Jtdue2jO+HePD9pu8Ccgb
 5y6YwBbEj38qoobxzWKOJv5XJunqM3iyRtqEG9vDpKLqiP2Gg8ZxpMXEsdGspv5wKo4E
 xX3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkJS6qSowkK9ITXnsyTnc5FptYZdj/cgVRpSEDprMdBHy9JhElC41dwbVmMl5g8UMxKo2hZVYTeyegpLuZOwxdWHhKds60lJQh6rwa8P8q0Zguy0O9Tc2HmC9FzA==
X-Gm-Message-State: AOJu0YxML0AonAOSqil3MCL7HY9CQUFEB9nIsIfs7ZguRzvSvM03MQ58
 HwlrB1Oj4jaAI2rJrxeJ0jyyZqF5NOGM2osAku6dzPjPfXdthJ6B
X-Google-Smtp-Source: AGHT+IEl+4bjH/eB2wdq7558gezfPyTy7IojHcKilEbUxFydJuMZsDJQbS5H3MCz/68tLY+lt2lZrw==
X-Received: by 2002:a17:906:70c:b0:a59:c28a:7eb4 with SMTP id
 a640c23a62f3a-a5a2d5d3d2dmr296692166b.44.1715422270505; 
 Sat, 11 May 2024 03:11:10 -0700 (PDT)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d27bsm301687166b.21.2024.05.11.03.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 03:11:09 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 space.monkey.delivers@gmail.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v9 5/6] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Sat, 11 May 2024 13:10:52 +0300
Message-Id: <20240511101053.1875596-6-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511101053.1875596-1-me@deliversmonkey.space>
References: <20240511101053.1875596-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x635.google.com
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
 target/riscv/vector_helper.c | 13 +++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 3f578d6dd8..da46e636f8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -580,8 +580,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
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
@@ -594,8 +596,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
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
@@ -1188,8 +1192,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 39ba2a09dd..28861cc509 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -104,6 +104,19 @@ static inline uint32_t vext_max_elems(uint32_t desc, uint32_t log2_esz)
 
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


