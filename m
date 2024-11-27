Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75800D609A0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAiH-0006Ap-2G; Wed, 27 Nov 2024 00:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiF-00069b-SB; Wed, 27 Nov 2024 00:35:43 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiE-0000pQ-AC; Wed, 27 Nov 2024 00:35:43 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53de101525eso453472e87.0; 
 Tue, 26 Nov 2024 21:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685740; x=1733290540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qAcbYEnRS7o9rC9jvNDK3zjAtJ9uEReZ4ErtbZMdWc=;
 b=DR6lSp5dWN9C6lAbj71SvQMw2UU6+uf/QBUJmUrooE2CCblgfbOntAbLM6R7j1ao0H
 uuqk+AEpo0xz8PmC4SfC2/MYouC3Dx7pa2ND6jrEBYkX3hdwI/fskfF+mZbZbOxby4Cz
 Yg8DdHccYSmuHfj8P2kMyW09bt3H7bQJosTzwVf+95Tuk3HwI+Govni/FC/zPyhqOoBq
 Xei1w4Y+bfF1c/VrWk/+iUivzuMqWsSXSYRMj2RG5xX8xTyeACBZs/VsM6dSsRo2ZVm0
 5dGBZ35l3ANrzwiuWnYcO4kt24hYj48EP7hI+6DlHHDKs9K7ZJSGaOAO7Qp/RPccPY1z
 5+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685740; x=1733290540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9qAcbYEnRS7o9rC9jvNDK3zjAtJ9uEReZ4ErtbZMdWc=;
 b=CwzgDR5/8LV389V2ETWqGHrRAKaQYfHsaxPXOB1bzzJxYHvc8GFnxB+k8feZcad/CH
 RpiisFWzYYx+ouaP//fzL61OfJ3vWuIT4Vl0C83ZzW/wtJVcsaiI2aAWJ02OaGuzDCbM
 4K+tqgdxubmHDFt1rWw5q3baEMZ+/6VKdaYxyHBHdp7ikRQ/JPYv5HeYulpVWdDd2iAb
 /QIwNKgBbLGYzvTeGLz4Q0OJBrwYCKzngD+sP2VuxET2CD/t1huvMQdUGJY7KFNyhqED
 Xsp0nYguJ71Z9SbWonXUsMF3IVF7OLHCpyqI9C6t8fxTRCyfIGrEFaBYyMec+KhrqK4y
 KPTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmb40pAleEi1VtiMRM+fxUtxuFaUIjLFgYSACcgo9/yem5Tcig9IU5CqMJ3J199DV0AThIjA0NX4p3zw==@nongnu.org,
 AJvYcCXRwkAYOzpCunXfjfjLWA4uk3qB5xfca1a9fvz3evCWY3QY1BwzMUU0WH4O8n7HjgzdChkTZnIbyO9v@nongnu.org
X-Gm-Message-State: AOJu0YyHGmCksivCmVhMEmN419P1aKaDbanFE8PBJLt/wCxo6XfgutZU
 jtUZzBy82M5UVlrpeOB/xbjqUUg6iPWcuKxr3CUIXKsacZcVhsnd
X-Gm-Gg: ASbGncsmnMXS1NcFM64Rggh+25WIXC6qAM6MAqvfWZzv0zbeMsJkb9aVUjBXig5XkZ3
 Qvt6vfma6wWNbqDNtrdlbHM1/rvaAHnoL5DS3Uv7ABfIX3nOH/At1DtMSFDczzt375YgzoQk1O3
 qHZVYNHivAxPyeRA/a7Y9YL/csbgzt3vG/50g6yudRieuQGSPccSwXPSV+dmerHSIpaV61sXwpX
 2uizzEjEQrQ5XzQMagt7P2OaW4hzlMeKDBuAt+trxjIu65YqkWdT+g=
X-Google-Smtp-Source: AGHT+IEDQNbd4H/0reHADVW+JVVYoW1oEPo8IVCC+hAjA5Vcba5vdW9tbcg4xmWdyF6LJ1kOPQnFGw==
X-Received: by 2002:a05:6512:3e22:b0:53d:c741:7d05 with SMTP id
 2adb3069b0e04-53de884b5f4mr1985780e87.22.1732685740069; 
 Tue, 26 Nov 2024 21:35:40 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53de0c3ce8bsm1211799e87.116.2024.11.26.21.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 21:35:38 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 5/7] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Wed, 27 Nov 2024 08:35:21 +0300
Message-Id: <20241127053523.397378-6-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127053523.397378-1-baturo.alexey@gmail.com>
References: <20241127053523.397378-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x129.google.com
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


