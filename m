Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B26EE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 10:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUkHZ-00075v-NU; Mon, 06 Jan 2025 05:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHX-000743-BX; Mon, 06 Jan 2025 05:24:23 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tUkHV-0008QP-En; Mon, 06 Jan 2025 05:24:22 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-300392cc4caso160221371fa.3; 
 Mon, 06 Jan 2025 02:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736159059; x=1736763859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Hvwrk9vY5mluoLmmplj6mgQgBwHXYf3T8uKgM9kYvM=;
 b=WNMTkqeo/M9HRgBIpQFN9Hw+9jJ8QWmQp9MZU0R3YFDfueQw5uO9qShTZiop4kHGjx
 HC29lMVuPXl8Y/wiTWd6S9n9qCGRR6rNW0dIjjZBFbei6dnBRNFOcARzN7PDh/orDDGh
 nVxIkux0Dq6XmdvWj9IKa1gXfe9L8/CSEM67AznRVbAPkbIG6BoFX/ajxUiTeitjWbpb
 SjCMaRoMfWnAYGvItFAqzgOUeYqDMjJKCxQQmE7LrVKzQdO6opf69rveNDFWpp8GuZMg
 5JiI8t8F7uWdzqRu/bt0cj2pRSsX6jswr5FTWskXzHVrgifOLBDqUBx1PfdeI3gSBveA
 UEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736159059; x=1736763859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Hvwrk9vY5mluoLmmplj6mgQgBwHXYf3T8uKgM9kYvM=;
 b=l02WflU0k1cWjjoWh2mybOVXkmrM0wWLzqci9vTv4EsecVRb240JCdeQu1bRoK/rgA
 q+GBmoXlLelVXZWiXHWH8NAhsAM7SspegYOjGLlW2fXgMPZiu3kpO20UZ2b0TUqX7J3h
 uskS33otl8AIw5hTjxlncKdxeSCdbo/A+GWxkJJXuEXH/jPLtf9KrJPHzbhxz2ntGO9H
 iAGezPXA9Re493MbFmJJ09cuEZEPZDLr1wgd3fPcdxi1Trqk5F1g7UXqxcEMjIsAYjaV
 fKz/X8cwEhGUsJDCW1xasweeRJ0ZWPMmzOaFJH6NtZJrfabaSCgQKe5CWQPZxdrsp6Mq
 cHSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrkW4YTkA12z+QzSGqJRYPUPnrhUbJ/fFpWNwXnFomuLuWZYQOU0GUb3LnR6QBAbe2+IkC7jmZCx9a4A==@nongnu.org,
 AJvYcCVRPEcdrOZJD5hyd9l+H/wtG01eSINTJ8xTmEJOyXTj9KJFBAXt7smgKgm/pcOXapIgNVHfZIO/G4Qm@nongnu.org
X-Gm-Message-State: AOJu0Yxr1ErTEgcSEPIhvVl/Vyn2tdbT1uyZif62ArTpzG2AfurToR1b
 iNelQpVyml/zFxypHmqMyf6QZxhdXocVOfISpN5ukgdhEjAnmNU9
X-Gm-Gg: ASbGncvX8s654c9PnUthwbMqtl4AeSkwA3e54cQedqw7CT55Ijqiu6sM+LoAZYFJFMK
 qdjjJMRW0D2NblzQ5nRMuDk3ANYyAFMwkKDBjMgNP57O+skHiRDILTlU/jaOnAv4JQz+hz85UED
 /TJvEK3TjsSi1Rr4bVNjtVIlMHJ2rIO4ZjFzFCV8n4SBDsU8hWLDgl4Yxp/eQjJqETMmxsqtJ7B
 0RPmmuAUcZ/Yx5e+rpofX4YoB1HKXg3E2J4eBrrHoUZbSEBxV9DXHZsTUJZ
X-Google-Smtp-Source: AGHT+IFrhssGThMjhyM/McykndiF/IgOy6VMB9/P3Y+6tVlYIfFE8+nKwI/Pf51KZj+XrVfLwdxM6g==
X-Received: by 2002:a05:6512:3b9f:b0:53e:3ac2:9c01 with SMTP id
 2adb3069b0e04-54229533217mr18149143e87.16.1736159059073; 
 Mon, 06 Jan 2025 02:24:19 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-542235fed58sm4811190e87.65.2025.01.06.02.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 02:24:18 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, frank.chang@sifive.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v15 4/7] target/riscv: Add pointer masking tb flags
Date: Mon,  6 Jan 2025 13:23:43 +0300
Message-Id: <20250106102346.1100149-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106102346.1100149-1-baturo.alexey@gmail.com>
References: <20250106102346.1100149-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x22b.google.com
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
index 7c7feba54f..b7458c40d8 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -634,6 +634,9 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 26, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 27, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
 FIELD(TB_FLAGS, BCFI_ENABLED, 28, 1)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 29, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 31, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0e030d4ecb..8728541b99 100644
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
index 64c9a95b14..2f89fe8c35 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -103,6 +103,9 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
+    /* actual address width */
+    uint8_t addr_xl;
+    bool addr_signed;
     /* Ztso */
     bool ztso;
     /* Use icount trigger for native debug */
@@ -1231,6 +1234,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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


