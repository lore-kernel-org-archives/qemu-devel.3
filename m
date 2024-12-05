Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98151E77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ9x1-0008Hb-Dy; Thu, 05 Dec 2024 06:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9x0-0008Gf-0p; Thu, 05 Dec 2024 06:23:18 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tJ9wy-0005J8-62; Thu, 05 Dec 2024 06:23:17 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-53e1f673ca8so919494e87.3; 
 Thu, 05 Dec 2024 03:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733397794; x=1734002594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tbTJYxklDAqq9Y2xWT7MmbzmhWEgrNx262KNeoyxuTk=;
 b=WA2DoZjHQisIrS6UD5LbzWZpL6hbAET/2J8zAyAB34n4nbH4h4yqdDw/O676THz+Hv
 yUqWsBJ7FSLqEvq/+hSdy5aj9+4mF+WQkBWFFurufmaJ0PM6esT0I9C4P6GN44Yq2mjf
 P3pkETTUwT/GGXZ+L5s6GBLe7pBHrn5shIUG7W3TqT0Q4sP6FQ/x6tCDz4wUkoUJAISL
 tmpVndwuuc4+3BAaRWzyXiDW8e4S0xOrdxeC7IlN9hG9n8bPVXkPMpzIzE/IQMYrwf3E
 7C+r4se8jdOOV5uOiah/KsLyqxbLKJzDOC9NiXH6Pnc0nel0lVN5KcpexjSAzfqDng1f
 wPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733397794; x=1734002594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbTJYxklDAqq9Y2xWT7MmbzmhWEgrNx262KNeoyxuTk=;
 b=mN9VlzEByQBTSlggWI1HT31yMZTh6O4jNGYWEZLmp1eGTO1LpMTx+8EL8cxcNyefF5
 n7gvCoNJ1oSknKo0Mg8+oaDCe5jDz5p28e22RVggUJfB7rw7AYn2xB8mNuxeu7APmfxM
 XeNY1ll0aUVIT5Pt+YEt7wsw/GSRntw+mQibBBVpd0lpkhajghspEbJkRTv+9nbopqGK
 PHKPgGH1eK7WLP8jm88uDAIxmbEd55cMuiebGWBfQlsF09FSjMAYzjK+ho7nF+7M8Tv/
 vAoeETnkd0yuxuFoKoiJczZgusup7gcv41MbssYvKJyaHj6VcAgX4xuyoPpk/SkBgI8z
 RFfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSwJMtttGY+mrn1Uz2+xaW+8SssnfUBmks1NJ8uvO1nVeLGrcWKqKWreEV3LsBdRpFUt9W1egepids2w==@nongnu.org,
 AJvYcCXbMioAQIoMVwGC5hHQ3WobzRq/LNO+KI2fKE712d5erQdOovyCsVePIfGxwQQ1HKFE21tuiUpaKC9F@nongnu.org
X-Gm-Message-State: AOJu0YxMPDczN8VbtC57W48qyvOVzxOjX/9oiXolg+ipNoKeH/xT9UTK
 3wdxoQaK6kFErD+9BKX+tSYEDvhZuhKOcX6oWD/T3EQD3VygY/1n
X-Gm-Gg: ASbGncuH/4USe+tdynBflcpzYR561peImBkH0DI6kf8/StQOQ43E4Ad7FOhsQrPF6RP
 CM69OLtYew1vOMOcrpaDQDahOxmZUQAPAMZ7vNok4fPfpLHIZpXd+V9eA+P7OnvY9wtDtGns9TE
 x07kGlcgKrCTA9+an72Nbnew4/baxyZYCnp2zPZ8AE9Q96G11CANfaxa8EtEcUKRQ7WCI3a6Mp1
 qqf+ZwICV8gkhmoQ1ibpTa6gpigvmgFgZSbLiUT40suLVq42q9B1JQ=
X-Google-Smtp-Source: AGHT+IEjaHTlclq4cx9BswYMhsFYxLdVHvW/CWjp1bapnCPgjdP/ve961YKDeDbM1cOXviGqD+XYXg==
X-Received: by 2002:a05:6512:224b:b0:53e:1ead:e33a with SMTP id
 2adb3069b0e04-53e1eade521mr2019617e87.49.1733397793929; 
 Thu, 05 Dec 2024 03:23:13 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53e229744efsm209942e87.102.2024.12.05.03.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:23:12 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 4/7] target/riscv: Add pointer masking tb flags
Date: Thu,  5 Dec 2024 14:23:01 +0300
Message-Id: <20241205112304.593204-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241205112304.593204-1-baturo.alexey@gmail.com>
References: <20241205112304.593204-1-baturo.alexey@gmail.com>
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
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.h        | 3 +++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/translate.c  | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 74d7076f5a..11e3a6d647 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -631,6 +631,9 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 26, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 27, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
 FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 29, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2558f869f2..ea342fde18 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -126,6 +126,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
@@ -210,6 +211,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 018be5504f..bb92f36ba1 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -102,6 +102,9 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
+    /* actual address width */
+    uint8_t addr_xl;
+    bool addr_signed;
     /* Ztso */
     bool ztso;
     /* Use icount trigger for native debug */
@@ -1230,6 +1233,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
+    ctx->addr_xl = 0;
+    ctx->addr_signed = false;
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
-- 
2.39.5


