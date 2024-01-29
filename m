Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45EBC48285
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXDU-0005rs-Dj; Mon, 29 Jan 2024 14:22:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDJ-0005kT-J5; Mon, 29 Jan 2024 14:22:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1rUXDG-0002eQ-QN; Mon, 29 Jan 2024 14:22:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e5afc18f5so36139325e9.3; 
 Mon, 29 Jan 2024 11:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706556153; x=1707160953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJNXAbxh5J4Ei6H86PyidDozdFrMhcx4WIs/J6XrOAs=;
 b=Bi2GUebO2r4Zhsde9pV0zSsb/gZloOhHpxOJWEppb2C/PDC5znpA2sgdAkD056Gai6
 4PIBqQMV1Fd0DmEnN89b247GFNsaX+VaiSlcfDVaK5Ftpj3bWYkSds1tadtDrmyxjeGj
 N4/yHI2Jne9DFO+Wd6/l4Toxz/bXye+D3TnJ49qtZCuiUKlm7Y1Kc03w4ADOBdLcDa7f
 zNGRp9imkj5cLZSGps7G5CmdndYfKQHyTp96ZXPu0csmApUe5M1rJ9qGbCx357S6UBK9
 EiPew0xNQ5sBwwICLCE2xPdb7SPNOP+32xba8A8bZ1TcrJVBT/ZK5WpEJ0+YksuwVev5
 NZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556153; x=1707160953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VJNXAbxh5J4Ei6H86PyidDozdFrMhcx4WIs/J6XrOAs=;
 b=Dg4KTB+uB6A0fheeO0mgF6EBRLpXC/7tp/F9DHFKBwg2yollr5YeTGUKN+8b/nwYJr
 PADuEY7X+hPNjyDMb/Wa6LxhbxaUbgiFzen2giYyvH4FnB6cqZBdynCtoy6yaI4GkvZq
 2EwiNDMFf/M8K3brudTXPBww+YxtAFN6WP5peOV2XsRZQAGRZ7lO8TVMRtFsGIxqxAuv
 i4CQEqWBigvSmzmR9C2tqW/j95MxnXa1nLPAuCyesBvbga+tdtffQjoGBDnRF21gYe4l
 fWMd7gJicOYoCmkwQyn2Rr7J5G5fxrGs+WXFBqCK3YPlK1YnOjm6iRY8RK59F+Z3JYQV
 gG9g==
X-Gm-Message-State: AOJu0YwLzZRj3n2Ba9I0p4Sp4iI1OQ6eG4iQCtEhomnmlgF4xbG/0pLZ
 8Gr992VNgm+7VYuKYhGTxdt0XYMcluLzy2FnzXYfNhtntk7Svms0
X-Google-Smtp-Source: AGHT+IGxuB62qroUeNlwchOrWD4MWwf8zESQy6+5hkXe5W2F4Tg/4m9+wKTXWum8C/7h8moCHMVPhQ==
X-Received: by 2002:a5d:510f:0:b0:33a:e7de:aa8b with SMTP id
 s15-20020a5d510f000000b0033ae7deaa8bmr3156503wrt.26.1706556152879; 
 Mon, 29 Jan 2024 11:22:32 -0800 (PST)
Received: from freya.midgard (broadband-188-255-126-251.ip.moscow.rt.ru.
 [188.255.126.251]) by smtp.gmail.com with ESMTPSA id
 co28-20020a0560000a1c00b0033af0cb2a35sm2577206wrb.108.2024.01.29.11.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:22:32 -0800 (PST)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <me@deliversmonkey.space>
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 4/6] target/riscv: Add pointer masking tb flags
Date: Mon, 29 Jan 2024 19:22:05 +0000
Message-Id: <20240129192207.2946870-5-me@deliversmonkey.space>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192207.2946870-1-me@deliversmonkey.space>
References: <20240129192207.2946870-1-me@deliversmonkey.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-wm1-x32b.google.com
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
index 1c8979c1c8..0284ea418f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -545,6 +545,9 @@ FIELD(TB_FLAGS, ITRIGGER, 20, 1)
 FIELD(TB_FLAGS, VIRT_ENABLED, 21, 1)
 FIELD(TB_FLAGS, PRIV, 22, 2)
 FIELD(TB_FLAGS, AXL, 24, 2)
+/* If pointer masking should be applied and address sign extended */
+FIELD(TB_FLAGS, PM_PMM, 26, 2)
+FIELD(TB_FLAGS, PM_SIGNEXTEND, 28, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9640e4c2c5..67bc51e510 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -68,6 +68,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     RISCVCPU *cpu = env_archcpu(env);
     RISCVExtStatus fs, vs;
     uint32_t flags = 0;
+    bool pm_signext = riscv_cpu_virt_mem_enabled(env);
 
     *pc = env->xl == MXL_RV32 ? env->pc & UINT32_MAX : env->pc;
     *cs_base = 0;
@@ -135,6 +136,8 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
     flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_PMM, riscv_pm_get_pmm(env));
+    flags = FIELD_DP32(flags, TB_FLAGS, PM_SIGNEXTEND, pm_signext);
 
     *pflags = flags;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6b4b9a671c..2c89d749c0 100644
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
@@ -1176,6 +1179,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
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


