Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443ACE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNA4T-0002xI-Op; Mon, 16 Dec 2024 07:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4J-0002rI-FJ; Mon, 16 Dec 2024 07:19:26 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tNA4G-00008d-Tt; Mon, 16 Dec 2024 07:19:22 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53df19bf6a9so5798537e87.1; 
 Mon, 16 Dec 2024 04:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734351558; x=1734956358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D12R45e1c+Wg+SpB6Z/xX4CLtsQWs8Spi1peAHCRwdY=;
 b=RXozaBvmlcB+n1KPJnUc9VtVOlSo8Z4mahXh6w1fKVlWXiDT/yI9XTV4yh1hJrHpxj
 NR4pXTF+5EwjkrHRLM9yDGt94wS/4s2gykn3khKgmAr1bcVs1ZuRNU7xcvnk+RQLD4wJ
 02Kjf+SOFYD6B48EehfH9SFLyPI6cbT3AAoDkgbkhhrSuUrzQonY4/FeYlZbSFJ2EX0j
 Oz7N2ZUXlsyMLl2MbNEocN7tuz6Pu5j5fQMoTj9iO+i93e/UyiSMrFKMm7kiGGJ3dXmy
 mZ6qnSo55temCb1FhFJe1/uT90HIs8IH3nhQghguRYDpiwfG9LHrFxTmKmCUgwRJXzg+
 iu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734351558; x=1734956358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D12R45e1c+Wg+SpB6Z/xX4CLtsQWs8Spi1peAHCRwdY=;
 b=sisG/AfZPQ6YLMRx3cE0zDZOQH93UQcMLZ8cZHkWocT5jWW4xEhqIz3SysaupbvYxE
 cGdNn3sPq73Jd5JFuYHG0IHQqWoo0IWwH6sMN2AUSHE6ewD8aDQPjI/7186p120Hhi0P
 ts3wObGp04WNtvgvdn+wEiKdhKOanAJxu/D0gtXcbLNLxv7AKEJnwz1ua+OeGzQ7Tbrh
 /rh5PNK9wNPpi2O0533yWQ3VNBiLvRtjEJFC55KgJC2GSeHp5txMzt48DCR3vbbPsjts
 5eB4VUY9l/SF/FGVgECqnXJnBiOaL84uWXyxX/tguJhrLXUVwbJy1AnZqFgihbcVX/Y9
 8hbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+YbO4iU0Mc4cR/gXa/BVsUWyNgP6ub4ksPZkB7TTBmUG2tyReSQ6NiNfF+uwDYJr7QqfLywj1q3JY@nongnu.org,
 AJvYcCVa3t+CC3BJuaibjeVNqHeAyuMlLSK1Mr0PIlc1f3Gk/1+MnBGeyGFRJhKKnxRfj7idtoDtnYlP/+aOWg==@nongnu.org
X-Gm-Message-State: AOJu0Yzn566UuLFAaa5vcaLRt1gEivABhxTzTN2b5xegXpejt0+Sv5a+
 XGDComOm0gvLrwy7orBvziWi40OtQ6WKlHInRn7VgZB7FU5srT31
X-Gm-Gg: ASbGncvsPCDLkvGrVMdJB9MnmgQw5aF6rTcYrN23SMW7/PBFKfV8vdFOjmh3ckKgadf
 EMtCVYPCXmH9CWjywRnfq46m8A13fXNzPl4q/wYtKA70Or1BMR5R7owk1UMtNPxPwDlhX8v9bp4
 +WAqrbceHVK/ZjU75oodb2YmKdXUy+oik9F5nlYAZNB5o5PjTwPxq4yZD5Ml3OfRhq+MQy61Kpq
 b2Ve8Qh92yp1gFca7fdspjFYzrlZleDcvwvhqUGeWNj/xbrgGPD/ZOojb4W6Q==
X-Google-Smtp-Source: AGHT+IF6at+e6WpYMdToP5MssBvHpQMcPrDW4DlUTyrgIVW7Rzi2oKe6cI1ihc0Dz3hoxG2nPVdp6Q==
X-Received: by 2002:a05:6512:3da5:b0:53e:2f9d:6a80 with SMTP id
 2adb3069b0e04-5408fac7b1amr3924369e87.3.1734351558269; 
 Mon, 16 Dec 2024 04:19:18 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54120c13d0esm827143e87.192.2024.12.16.04.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 04:19:17 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v13 4/7] target/riscv: Add pointer masking tb flags
Date: Mon, 16 Dec 2024 15:19:04 +0300
Message-Id: <20241216121907.660504-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216121907.660504-1-baturo.alexey@gmail.com>
References: <20241216121907.660504-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x134.google.com
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
index e7f346ff6b..38231fe21e 100644
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
index ed0d275e84..480d2c2c8b 100644
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


