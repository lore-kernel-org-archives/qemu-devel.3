Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C4BD5E13F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 06:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9I3r-0003oB-Qb; Fri, 08 Nov 2024 01:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3p-0003mg-SQ; Fri, 08 Nov 2024 01:01:34 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1t9I3n-00083R-Ps; Fri, 08 Nov 2024 01:01:33 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so1853165e87.0; 
 Thu, 07 Nov 2024 22:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731045690; x=1731650490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjQFE0vWqMf/ZtDxRzOt57Rq4yMHkB5JeBgxsCZwEu4=;
 b=Ww8jrT6yd5KrLyImd1hVItklLoWi5k3GOZqAw1bnM1rXVZDK3pxDl2GWQdIyN+2v9o
 m6PmkHY502jISpQbuTkwd4FkwEosGJKWHeL6JYPrxq1F9CVGVltFOUXdkFBUhQtJrZB6
 Od1XFl1k5/XSZ38r0ACBhRzMJuNYpR+yIGqJ7LHIfmBqNa5MNrZrO1fEdaflERT9JbQ7
 GjaoD8cKdxTuAykIfLt7JeZZJoj5somMKhT0Dg2hIHQstj59IemN6JOJX7+vPSvzmCZk
 1RlghLq5grMsGr8/5D8U0NvupI4gPT7XSw2kSyoyXjAcNmWeI3dj33KTX69TbvSaQKVn
 EqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731045690; x=1731650490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjQFE0vWqMf/ZtDxRzOt57Rq4yMHkB5JeBgxsCZwEu4=;
 b=d65sRtw+vhywMerWSoPv0NzoLlpwu0hF7F8l3jw1aHOx1J9+I+tDMwHiaZ/gysQ9kE
 bwLophru22iV97ybYuu61eicqqEMJkm179Ej/qj70saqdeGVjkcuoCUVuds/kdhnC12H
 TzgUvD1utYmj8pxsVm59FIb++MN53YqBRiYzrhysxIP8iPcPikQax3c0OnenQTmLt6kP
 Hkjo20ADCZNrZYwsI+yQkgpPiX1Wr6qzO0m7Ygz9wNIpMT5TNhu9kSpEtYGFo8VbXK0m
 PYXeL9GMUeoiux0lMLF6fWohrBkggxg4CNnAWM560oNtNqA2SHCyvAX+2/S+JpCyHBgN
 Gp4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU38ApY5q+zUZHmDs8oOjaoII/5GEhDdhv+jOZPc3AmADSK/SUcQGPXQmpeHfLTpHf+qRXCHF+sCCLlpQ==@nongnu.org,
 AJvYcCWJqvrMBLiXUrHFPHbzW06543CXqWjOctxs4ZOEd6DcWRMUw2INroqjjz5KsxxJCasmsVI4l5aXnqaH@nongnu.org
X-Gm-Message-State: AOJu0YzkxbvMWZwRUZfp7NSTVv4V6dPRiD+rofqbRldWzWPypg3QP2pi
 ARF7nAzqyFVm2RrSgijXAL1VXTZiSxxmO/1VOKFlLCOj5iTKCTpRPa5HGBxW
X-Google-Smtp-Source: AGHT+IFn9lHHJAVM8fCcauwNSsZE7K0fYnU9whhzFpEnUS2QhJhBTv6JSwDneDKLW6CJRHsMCYshnQ==
X-Received: by 2002:a2e:bc84:0:b0:2fb:5138:a615 with SMTP id
 38308e7fff4ca-2ff2005c69cmr7800631fa.0.1731045689481; 
 Thu, 07 Nov 2024 22:01:29 -0800 (PST)
Received: from hades.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178ee325sm5159001fa.27.2024.11.07.22.01.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Nov 2024 22:01:28 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 4/7] target/riscv: Add pointer masking tb flags
Date: Fri,  8 Nov 2024 09:01:13 +0300
Message-Id: <20241108060116.37397-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108060116.37397-1-baturo.alexey@gmail.com>
References: <20241108060116.37397-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x12e.google.com
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


