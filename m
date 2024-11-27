Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A277FD609A1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 05:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGAiF-000696-0i; Wed, 27 Nov 2024 00:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiE-000687-2P; Wed, 27 Nov 2024 00:35:42 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tGAiC-0000nG-Fk; Wed, 27 Nov 2024 00:35:41 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53dd668c5easo454886e87.1; 
 Tue, 26 Nov 2024 21:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732685738; x=1733290538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtetWPUXuiGOAxsEyYlH4y/0U5eV9raqH4y25gKOwX0=;
 b=IW5qupLUqZAk2MYMM+X5K+66oggTFgj3G2vnBuiEZZvCUtSDD2fZh0f2xUMFEquFgl
 dYKJn1CuyvAo15+OdH4B3IJBcZi+xsrPd0pnatIOEFd9T2Nu/afanDd+Tz/PTbDj6e2t
 gLVIanEmeXwRVY8dBeVu7aIg7kq1O6RdL66SYXg/spuwd+XqyUE6ttZZwLJcwMcU9j64
 XBHkNqNeJmsCtyRD/C4sCb4yUyAM5zmtBUH5NgzqAA0JQFI2NXVLXy6ggf5PecPtEjic
 LX17D6o5JevzRTwImod69C/kJsBeFVjo94EKLv/yGVE606ntVt5hUNl14kXPBX57lSdL
 JaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732685738; x=1733290538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtetWPUXuiGOAxsEyYlH4y/0U5eV9raqH4y25gKOwX0=;
 b=eGQN7UWYlsSForQ5SPQzvEICWkNE3hZbV8AI1WuayAD2QALJLH+d5QYwQ3amvc9sBu
 I6jVEAxKrYOBRAbeNY5WrCJ79CCJvTgU632QmI0qVHT2NBf4jquGOkPZ0vUzO/ZkymRH
 NAgwK1YMsmMZLY3I5I4mNdt+uulELAzHzxS2ThHpgWrWxsdRxRoAm0pVjq+DlEZcxQGV
 YtGSvnTNtUdunja6LBSNGV92WJePcjtcoBwfjxV5peohHzKOkVl6Exn0zrf424zH07lh
 DLR0mAGZeCo074/P+rmKk5MFLjSgdumWcDDIV/luxMfUAZE0m+WcPpQtPsrdTdc+q/Vu
 GMXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpWYoGJzw6M5/fR2m41dj7FsSwP42RuEgqSDDkihW535UwD+I/6epqD3AZ6o4NxaTO7GDh6/4kwbJetg==@nongnu.org,
 AJvYcCWV54Tkzq8bODh9upvl1XvRwAGN9Y4J4pQ/LN61qZ2/S7svIJPOfI5VCFEqX4MmQwiKzEMLuxjdnz0y@nongnu.org
X-Gm-Message-State: AOJu0YznkUCRJVLcEsWXmLol6jpc3Ta2dhOMquL2YlCNjqoRBBAADIUt
 nvrT/OZCxUfbI9zMIIUbAJwZnuejolx8Iu7q9TdqMVFO8omHoaRj
X-Gm-Gg: ASbGncuHiDd6WOxs7pEUP9maHKM40rb/qx9JCssGFy8K9568eaKk85fkfM+BOL3Qlso
 ydykUWyWy5AiPJWeKPJy4wEzj0HRQC8GViqMCb7fCDei5OElsMOGFBkI8BsSGJy55xFEMMhReo0
 3iY1q8cVPoSjqJ9b8IIOjbo28BP0tjRGuF3lkmOKGv8qxAaFg9J5o2+Dq/QMJPlKAline6fPT/W
 CaatX+f7WKRCvVZCMEyhS5MmLA3FxlOJbO2uOujLrMHwy23Im7vO3E=
X-Google-Smtp-Source: AGHT+IGYtU/yB4GcWysjrPs5ZiLcOsNxG+KhKekxZqbBEH/irz+8qgEHaIo2ETuQYSOFRs2hlJXmrQ==
X-Received: by 2002:ac2:4888:0:b0:53d:f059:c148 with SMTP id
 2adb3069b0e04-53df059c2a5mr310543e87.26.1732685738202; 
 Tue, 26 Nov 2024 21:35:38 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53de0c3ce8bsm1211799e87.116.2024.11.26.21.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 21:35:37 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v11 4/7] target/riscv: Add pointer masking tb flags
Date: Wed, 27 Nov 2024 08:35:20 +0300
Message-Id: <20241127053523.397378-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127053523.397378-1-baturo.alexey@gmail.com>
References: <20241127053523.397378-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12a.google.com
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
index da2a10384a..78b461a5cf 100644
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


