Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 08:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTOT-00068Z-3U; Tue, 17 Dec 2024 03:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOQ-00067h-RK; Tue, 17 Dec 2024 03:57:27 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNTOO-000074-Hc; Tue, 17 Dec 2024 03:57:26 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5401b7f7141so4649293e87.1; 
 Tue, 17 Dec 2024 00:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734425842; x=1735030642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Su6GkChZRgDFySRYZjWCmQY8S9UE66ip1JKN5pDWI0=;
 b=PTN/3VP7RJtyBrMwUw0U0HAP+SqSugUenhRSTqYwXVzqfPZpubXlzlVwS+g+31UXyv
 1s1QJZ36h1PiXXbJyTR8Tg45u1Uh5aJdSdIpezUB0CGY4l2qB3K0lKz8REfqrZPkSDkl
 VMO7z/EMsx/DTPk/sb5mctCIOlZYmAwVYQURe+priwTE0GZMI2XC3xVp+J5e3D1E/Fdv
 iX/18NAwldDcky9XqHp4j2hRQZfTwsM3IK76uy0uSiJ1FZhfPrNfzRGfweBT4iLw3v6n
 19oO9+5F2nDkoaQIqijxngiy25cSFy52jlhEBOHaWU5C5QSQsotKfjdYfExRdVoBWiiI
 2rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734425842; x=1735030642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Su6GkChZRgDFySRYZjWCmQY8S9UE66ip1JKN5pDWI0=;
 b=dADZi3yfDoVE2ikc/AZWKVALhTjLlCXZ42VWsT1SgMaBcKF5puroq53J0oLswV2JiG
 I6W/SluVSwLe+50Fv2dKgiY+gPkWXdZkBmZytdrapnYsyN3ZNkk+z/j8pkBLceqaTEHq
 BU4ZSxHd/Lyyja1NIIiJJ6PyXGs3MUmtypg0piBofM7qBfRTw6ii2DXRPDSVO+/JU58f
 NKgJacNzVLy+Ux/5/bI9yHmdM4zjrCjW6fBKknkpR7Acf9NxOZSEfYkwjfxLWLGSUST2
 bqxlyQig6GCg1ALfjNynxVcoNaiHoogTf0YFg/a0O7Dg3TPE6X359KukD9gcVw9WMs/R
 pcPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDpZkXWqbSQHIp8BSPRvqF+lPa5lnbRM1Br29Y91POclt2s3FOyPmHnOwJwesGxdVOJm+84dlKtsvo@nongnu.org,
 AJvYcCVgciCessgo/yFfexL+nqXnC27LM3WZ+R7Hea5BTxY3asSlRnJKuCJQLFEb+ZijiPYGgBaaf+w7ytyadQ==@nongnu.org
X-Gm-Message-State: AOJu0YzcPXPNsHi8UXuNSTlbyLAD2SqgDwMDAOoL5xRyNuDINK0LLKFf
 Z8OXerrt8Cv29ubfhO5Hc5ybyM025PdwS3v8KUw/wLyPED5SChLa
X-Gm-Gg: ASbGncv+BiKMEEWnHiJeOf6HIdqSWl7QMJv2P5G3l9Cco5pvC6FnujPcVfDt1lPp6nv
 4kHoNNrRWu/riQgws/JGj2dT0Nhh17+vQxAf4tY5rKii2Xj3/iDIQ97HejivMBsGTXOMDVDo8VY
 K//JiHbVoWOAPGLu/relLZr0NqC+Z76y/h7VqM+7Ynl6AlPGutk15FH0yPatMmJ/a1uEGo1Z/rt
 Z2v0/XulgtYBDcKmeBX4UEuNYJLa3iAjtQj61SXjm2fe2SMkihJXgI5wkMC
X-Google-Smtp-Source: AGHT+IGdWoTh4WIUT8P4Imk2Iv8svtjRMiUwMz02uLjnYkxe60LgxJH3qCjy7TDq99RC3LTn9SiHFg==
X-Received: by 2002:a05:6512:1599:b0:540:1d58:da75 with SMTP id
 2adb3069b0e04-54131050e1dmr787834e87.14.1734425842358; 
 Tue, 17 Dec 2024 00:57:22 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13c24sm1092499e87.197.2024.12.17.00.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 00:57:20 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 5/7] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Tue, 17 Dec 2024 11:57:07 +0300
Message-Id: <20241217085709.679823-6-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241217085709.679823-1-baturo.alexey@gmail.com>
References: <20241217085709.679823-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12f.google.com
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


