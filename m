Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E282C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:25:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkHa-000765-LM; Mon, 06 Jan 2025 05:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHZ-00075n-3g; Mon, 06 Jan 2025 05:24:25 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHX-0008Qp-El; Mon, 06 Jan 2025 05:24:24 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5401c68b89eso17377482e87.0; 
 Mon, 06 Jan 2025 02:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159061; x=1736763861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gB2/6VZ/oyZ+w+6EkMHJfPQrIdMl7d8iz9pyowro3Q=;
 b=GbHGVHQsRFOKVmn2ww7AtySkGxnfjmTYwXL3Hg40lGM/Z41hCNgbYSUgIRaCpOmvV9
 MfKAJn7Min9c/Jo5pXcIKDp+AXyiS+FAEmAIw37iIkivkDf/cS1e/FtcFwCHd94Yv4/v
 wbk0KEQ9ACWhtsyoZMPcNYGJj8bbvhvCvghiItqh82VWHpVyR01XZ0Gp0s2oCtIsxvBs
 LrRfr1mgEdGiJ4Ud5apdO0uB/nTiIzJxr8XDZagsuS9toM4xAMgf/OuEBvoXolUIrKk9
 4zIvf9xE1G59f+1tc1+JGB4kh7bwjJA5UG7eCUsJhmo3YO3K/qxEe4/C+aSt8znRKHBR
 /dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159061; x=1736763861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gB2/6VZ/oyZ+w+6EkMHJfPQrIdMl7d8iz9pyowro3Q=;
 b=MTcnXVJW00d39AstXmU55dEjSoAr7RS2gIlbXALqbVwQobtmhbX5iqnvG58sOAnwLa
 XIR2MMKvbDYGCO0cQ5Ef83yC2+E2iz1SGCz9edwTOWmf9NakhQav3rfuDuE08/txGI5Y
 VFaNJ4kT64XfaqRGQYgO0CasKNssl5BCeAP+gG5c8rO7OFJA0vPC59x8r0f3JPKSqKqj
 dH9madWUtMH1xjtbmAHybdgboxiOSzzyrUlovjhKiOAoNWxFdh39wsS/QcyIlXetX66I
 p9d+U+efLHY0RvYrjuoiyEtfxc53To9K9ybGO1YmndCHHKHM6etL+NKQsMK5XIGTJEht
 z1mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXCIluXgyiPJzjBct/slJo5F59kZLNis3aiAVVOLAblI8NZwhPsUMYotJgxDoXVGAX9QzmoDWf1uB0@nongnu.org,
 AJvYcCXRSKfma10cHPAG+Hw3yy2OyeTwN0/Ml/G76uV6YfRlgZuMs9ro2ydKOCZCs34vVROGRR9POdoRbQVKjg==@nongnu.org
X-Gm-Message-State: AOJu0YxiRwZk4cJhdcgWoAShmIeitNPW7nmOBnOvIFc7oeJyOAsRj/d1
 z/z9aj+WNtdB065oAJCnm5CGJmMG48hs1a42px+vQhmoI+z+Dk9v
X-Gm-Gg: ASbGnctvZHgkykcV4XSZvzX8ffzAZBi1Vbki0ovka9vrrwvkUFJ3E02FKQ0gC2ZU8EK
 TlLicHtvCucKzGPbp5sxGPv7HW2JHBudYRoqa0xT+wRv2DPeVJ0sXaD77OdEFRn9Pc6t6qABEB6
 OMx2E8p7jCy5tO23YuVj01jKyuZjFDFmPagJEefa9OJ2BVgAihWoA7odTSPGQXCncVz7lLw4Tvw
 stBcQZa5+3LHcM3upbe+BhUbDGUxUK7zLwRM2l36tIGlqYYBE524UwWkwA6
X-Google-Smtp-Source: AGHT+IFmgZI6/24pxEIG2sFxEMZMcgDAXCg9om6bTowFT4LuXO1kXmJhICX3B+/5r498Y8ztos4I2w==
X-Received: by 2002:ac2:5681:0:b0:53e:2098:861d with SMTP id
 2adb3069b0e04-542212f0034mr21568933e87.15.1736159061028; 
 Mon, 06 Jan 2025 02:24:21 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-542235fed58sm4811190e87.65.2025.01.06.02.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 02:24:19 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 5/7] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Mon,  6 Jan 2025 13:23:44 +0300
Message-Id: <20250106102346.1100149-6-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106102346.1100149-1-baturo.alexey@gmail.com>
References: <20250106102346.1100149-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12d.google.com
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
index 2f89fe8c35..1f60f82aac 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -589,8 +589,10 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
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
@@ -603,8 +605,10 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
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
@@ -1234,8 +1238,14 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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
index cf5dd7f2e1..0eea124b66 100644
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


