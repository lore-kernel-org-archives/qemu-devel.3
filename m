Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AAB5E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9x4-0008J6-AS; Thu, 05 Dec 2024 06:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x1-0008Hi-PT; Thu, 05 Dec 2024 06:23:19 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x0-0005JU-1a; Thu, 05 Dec 2024 06:23:19 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-3001e7d41c5so6374921fa.2; 
 Thu, 05 Dec 2024 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733397796; x=1734002596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qAcbYEnRS7o9rC9jvNDK3zjAtJ9uEReZ4ErtbZMdWc=;
 b=I0a5VoFOaMYxmmz6MuoU4JS6tAvDWu2PFZugbda4JXhQeC3mka0itwNg1EIpeSV39m
 wL+2mVGrXIFuyq90VoTEYavpPc63Fqd3VWJL/+9T2ekmoJWJTWeCptRP+gCm9rxI4a/A
 ZnDWoTXXRVkDysoRzsxQt23NeSrbsCaLGyzrmuQqC5araRT/v3me/ASCsiVPEshxhbFA
 C/sLYu13nL4Cwr8HLlB9WvM4YaQTC6h5xDQhztBGtBAk5VUpgYyNjtb2k08A01hnz7SM
 SNpSAD9nkdWzfNg6gRG6YyQiZhq96Lj4M7X4m/39zH4xKQ1Uv3UC2I+Qbd6OI7bF1D7Z
 cXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733397796; x=1734002596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qAcbYEnRS7o9rC9jvNDK3zjAtJ9uEReZ4ErtbZMdWc=;
 b=nvaFWH+kzskoESDWlt2xxb9z1aRfTp9SZySDgGMBGFiOA+axFCFXjrMyLc1eR1TjsY
 gG/9uAHLjd6rrRFzd8R4s/yNdjKKqIGjKp4keGaKO4WuOCfVTNCvarMGFVZENe5vzO/B
 7iRPEb+GdVDMLnuiG0UBmx/Koaw9CoYDFntlc3eQ4mY73Ml9hJQXIlscuYXKvjOd7/e6
 YVEn9rjAISeZk6z486etG0wPCGX8W5diBTn5bB7Mo8ATFvMj1n49yxNGnzyjPsLd50B2
 p8NevJP5vJD7tem9ue3HOwerqwLHRXu7lBaaLXKlwSSq4Bw4IqvyiejHMCxJ64WnblzD
 Ei8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdVu4WSTSj9h8h3C27ZNoBLMV3FvLBeZtWdpem5GiNDo+9cYtWY5BUtwwh0S3nH2XUmnegVqJew1RMg==@nongnu.org,
 AJvYcCXZwZd6ILpxGiub+8k48zhAr0nk115fdudjpXT/n6G/yUtwCwwWkXHJSCqvKInDKrx9jbNyu1MI9m1j@nongnu.org
X-Gm-Message-State: AOJu0YynNIHOn/5XE4tiq2Lo9q91cw1O1KLHZDpmKYH133chLDdNCful
 64wdYWSSIL9lGcY0QNkWzs6SNY+2rU/ocwuoWuYRKbRwGAZ/YXT+
X-Gm-Gg: ASbGncueybfPagdlbYxns0Ws6ULb95tu5hR9Nasrkas4YhqyEUZwG6mHD/RpRStP6n5
 FgFWWFNSCMw4H+AT5Gjxgne3FvGFJ6ofdW0gO7xUov4ZeWKHNbXePhGf0YVUe9fsg5o6hW/YLPn
 dfuUvlct4FwrF2+Y9zexJFbV/1gJoLqciLHIddKX5m4Mk4eGt7430Xi7wD2gX9zuzsBSBjzvnwo
 uOx8WnEyHRu4qtXsV2jdtpFfdWFSwHOqcVIE45r+r5MjtI/1agXAEk=
X-Google-Smtp-Source: AGHT+IGMz1O8/H3fYlkqNWcQw1+xLHH4qFMw5z+olc/Mb+yaDkpzoE6ehin8wzWntZKaRfku7sVGJw==
X-Received: by 2002:a05:6512:3b12:b0:53d:f095:ffee with SMTP id
 2adb3069b0e04-53e129f2a18mr5848034e87.17.1733397795601; 
 Thu, 05 Dec 2024 03:23:15 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229744efsm209942e87.102.2024.12.05.03.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:23:14 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 5/7] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Thu,  5 Dec 2024 14:23:02 +0300
Message-Id: <20241205112304.593204-6-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205112304.593204-1-baturo.alexey@gmail.com>
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x232.google.com
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


