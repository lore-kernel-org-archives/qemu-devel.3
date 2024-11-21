Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00103D75BBF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0RN-0004X9-Gj; Thu, 21 Nov 2024 01:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RG-0004VR-KE; Thu, 21 Nov 2024 01:13:14 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RE-0006KO-Sb; Thu, 21 Nov 2024 01:13:14 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso506484e87.3; 
 Wed, 20 Nov 2024 22:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169590; x=1732774390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d9Yx+m45Z3IA5MQqTq1nye6R+DqtOBMOd+bbwpRHyqM=;
 b=X+twPG5kFQsKwdlWcr0qAZyh4FTQSwTgb/S0Wrz+COnahDCbe3etqanCV45Sg4I5/e
 awNNvHRfu23lKUzMTmcOEpSyaopJ2UniknjqN/j3oysAEbLm7dngP6W7O/hbW7ZH1txl
 73rt2EWWyl05lOU6FXz/it6qnfHHv8mpu4+6HeImD6UWG/EBwcmzYHhJ/4Ii9rzdzBPb
 M3vtX267El44Ps/O42OtqY8H2xqo7VB03zmCzuGG4khkUiW/GySWnVI8mO9GuaSYPwoO
 QyxpJ1zOh8fQNT4pa9jqINuNbSU/iHuK3ruri4yaaHqn7LjN3tkUPJBVTgMKKwIwlI+Z
 AqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169590; x=1732774390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d9Yx+m45Z3IA5MQqTq1nye6R+DqtOBMOd+bbwpRHyqM=;
 b=pgBcoD+OEr5wtLsjmMUpHOI6hD8q7+yS2DEfHth/LSBZCpEKybFiUlzRUaApqrXDCC
 NlIRHoWVNzvREqrvYz1qXcB4dFJY1qcEtJYT27yRT3USIBQAr3QgFAjUDmxsGHXJgdHI
 TcvwidKVoJkpkL3EJNL+RkT8tlZqTW+7RWa37BI9vXxxxqoWHW59j0BpL8gW+siLbQ9t
 4SAE+cAjTk98Fiv0OueXWrc9KMKvbczkq4Q3Uhf1STaNae16u/FeG92GqPe2FuNtdTNB
 04jUxjFb4pLSQOiodiIePiQskZkNbPAaMJtOf4N3YMHN6XXWgypd8mKsDhezirGsw9Ih
 ROUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvNd2Cj0EuWFg9HE5LLN7Segxn6pIJJCFcNVjkQBzlm1oN1G+F7S3IQsa/mVNloBRWSjSFyrEgoWZt@nongnu.org,
 AJvYcCXPocTzASlMfsKnEkOMrfdsXzNo9mjxp8hQkz+tnv2TRcDMwAfUTV+CHfUaxqOHH8jPgvT6TKwLgnWD6g==@nongnu.org
X-Gm-Message-State: AOJu0YwJLkO4JrJ+EFBMmPXcPiwv3FdUkgdtUpmKA5nOjfi+fZkn0UPV
 hSSiWKy3Q5cZtA69f51ZMqAPPs41XojnQKPjurY+id1sJ4EJqVOJ
X-Gm-Gg: ASbGnctMudZE9Brg8TN+xGLIeqw5ZlkNNDZVK+0iwPlOMSSY8kYhAGuMdTP8UbH6iwM
 CK8AqzIB8NCUwpNPV7V+1BsLPANdw62osaZzFeawZEyFxIruHLGSmoWGPgFMsyazBSydA0VZO2v
 H4Z18ZbvAYDfIKvCRkvbmIiKOEK/nq5TFGrzEvAMEZGZuJRSNhpJvfflOUxOZdBSS506Nm8U/0j
 1yRwYjKhCVNChxzQk2VVrtdDbnCPDTnGD3VNd54JAdS7Z1m6Yc5KT4=
X-Google-Smtp-Source: AGHT+IGLq8XXL01oKHJQhFK0Fveunol4tNHf4LWp3y9sU6lSUXbfLcP+AHgLgXuYGylF2PmMFfMrug==
X-Received: by 2002:ac2:48ba:0:b0:53d:ab10:234a with SMTP id
 2adb3069b0e04-53dc1333888mr1786175e87.21.1732169590415; 
 Wed, 20 Nov 2024 22:13:10 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:09 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 5/7] target/riscv: Update address modify functions to take
 into account pointer masking
Date: Thu, 21 Nov 2024 09:12:57 +0300
Message-Id: <20241121061259.4043177-6-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12b.google.com
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


