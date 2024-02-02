Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC92C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqZe-0001P9-Kx; Fri, 02 Feb 2024 05:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZc-0001O1-QU; Fri, 02 Feb 2024 05:15:04 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rVqZa-00044k-Vt; Fri, 02 Feb 2024 05:15:04 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so269569466b.1; 
 Fri, 02 Feb 2024 02:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706868900; x=1707473700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U+fUikV16GU51TdrlD9LY9tLGcCm2xkX5rzTX5cbHqI=;
 b=dmofxyxfWVNs18KpZkilT75AkJu2GHSNc0nAL8yJJouhnMxYBT/FfEUHyD++Vqg4eB
 pCvyX4O968dSPf230GeD4mlv94d6j1QNumt+UN7qcYV1ZybOrKu6XYG1JpHlFJDiYCdM
 pkAMHW++Nx8n0iaqoAx6jg5/xvE+qSjc5LPL8AAWCWnDqi1DMn+YW87KoPG4QCoUZ/sC
 IRjXs5TtJqUbf3cbr7f/2o5uRene08wJHhkSMEgQR4o2tFbHXBEZJqXhNSamISP/WcGZ
 iTETgsSWfpkuovGOiZv/+w89BCwvNWOARP8t23Gmd3j1vLgZ565ox6/UkOUdp9lqPfL2
 GjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868900; x=1707473700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U+fUikV16GU51TdrlD9LY9tLGcCm2xkX5rzTX5cbHqI=;
 b=NnJVPSsi4VYg3kCPPwZjdShj1z4ZSO6lfe9d8If1ho5fqFcGrfn+RDcecxNR7131PY
 /HhLZNWf6mW0XhpCtApD4IMp+k0ySpSQf3ZvuGP8pkk7aZAMHk7NuO40TNok2Qvx1xnq
 1FVN1dI5iFmb1RorOTevXV0d1VmFvG1TgYJu7cfIv3Hz6+3ZuWr+V9nIAM5TVGD3fcE+
 IbTcF3gl21ogay9FaZ9gstJSk16eyt9F4jw/WE/2GNhXSd7zPdHL50EiQf2Ehmeu7g3a
 pFZTCwvhaEAtcR/5GBFJUKANs8bOgEidYwsdCRE6Q7vdKJCR7gMW9bATgX1w2enNcO1J
 pVJg==
X-Gm-Message-State: AOJu0YyRyiJQaRv7BimoyiTGoYmGw9fQJsAoCx6DkJakwBkQ4bIpsgf7
 bk+6G+5VWsOA6Y/bBNnN+sJDkpasFBU6TFHiI8tKW0Y4h6VmtEki
X-Google-Smtp-Source: AGHT+IEQloBLfAxzzyG6PpzgnCRuYDsCScCHZxEOEbdSOyzwnsMZDyJQv/lR0rQyyF1Si5iD1Ig4QQ==
X-Received: by 2002:a17:906:53cd:b0:a35:ad04:af7f with SMTP id
 p13-20020a17090653cd00b00a35ad04af7fmr1278470ejo.0.1706868899840; 
 Fri, 02 Feb 2024 02:14:59 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVHxMY1rRU0vp2huK2VCT5kLALeEVI2DEtLqp3pGdO95GNE9RH3jw1gluo2oo0RLKcweI/Mtv1gBRLwZP6SnqbyVuAQUcsM7tWSnmt2cTOKUaSx7mqQwl7Q2P9WOv4rG2W66J20FjB3TnOq0gYNEI0kolbHl7Iqd9zabPVMp7Vto+9P/5YUWl6o8riCRNT/S0mH1SWATeeKB5wkUEsRa9pfrFUmp+VG6OilNrmXk6aVlInOVOUZnVHElfXkQKHaipmtUu0PByn79bLhhwIP1BmHsWrpbrOqeBwD6tIDZ90sduWUnineoMEmGawAIJ5LGB8rhFZhJOVuMNDJ80eTOp/6ZwrJszXkQpbIidzzXsPKByUObRPqg/o6o4g=
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 ll5-20020a170907190500b00a36fe6fe976sm579722ejc.190.2024.02.02.02.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:14:59 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v7 4/6] target/riscv: Add pointer masking tb flags
Date: Fri,  2 Feb 2024 10:14:37 +0000
Message-Id: <20240202101439.3714106-5-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101439.3714106-1-me@deliversmonkey.space>
References: <20240202101439.3714106-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/riscv/cpu.h        | 3 +++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/translate.c  | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 23a166a91f..798d16ef2e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -565,6 +565,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
 FIELD(TB_FLAGS, PRIV, 22, 2)
 FIELD(TB_FLAGS, AXL, 24, 2)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 26, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index bef7917668..29622b649c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -68,6 +68,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
@@ -138,6 +139,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 1d5dbf3259..6bc338bd1f 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -103,6 +103,9 @@ typedef struct DisasContext {
     bool vl_eq_vlmax;
     CPUState *cs;
     TCGv zero;
+    /* actual address width */
+    uint8_t addr_width;
+    bool addr_signed;
     /* Use icount trigger for native debug */
     bool itrigger;
     /* FRM is known to contain a valid value. */
@@ -1177,6 +1180,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
+    ctx->addr_width = 0;
+    ctx->addr_signed = false;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
-- 
2.34.1


