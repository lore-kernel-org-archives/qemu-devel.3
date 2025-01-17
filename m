Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36BFC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 06:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYfLq-0005St-R8; Fri, 17 Jan 2025 00:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLm-0005AN-Mb
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:59 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tYfLl-0005yv-34
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 00:56:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21670dce0a7so38079645ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 21:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737093415; x=1737698215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rlctYIk/mvlPiPF/dMu7kcmKZQMDZqIRsBA8kdT49/o=;
 b=KN8uouLnLjvgTOp+sdXUFxjrpz1OfI00eiiQARDIRlfihZOBcY4XafIcG61bXVizQ7
 9KS+rXuUqYFDpEQHjNVJvD6p3Z/C9xGQny3ds5B/B2QaJwtlD8kgNaSicKRdd/R5C2Wg
 IozXd9hb9q4nN1hg24wx68IQI3FPhgFj2CsH+mHTlG4X98CWXVrkM/8/hZVZwSHOBI0u
 1h2t+dSDAHBPdt/SKJqLVniB9PbUxmCu0lWwUpBixf6GFXLu6/sqwCX6fJsYYlie+EqG
 52wpvo7pmllmHk5jjEz29nJCNDTyT/bPRYBaSP7997s2h+zZywjbad2AD+xLjznoPBHe
 KBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737093415; x=1737698215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rlctYIk/mvlPiPF/dMu7kcmKZQMDZqIRsBA8kdT49/o=;
 b=nKAwv9VR05OSSk6AkSqDfa9qKc/5gZ9e04rTZi1ftHYRpsyHTW9j8WLEMh45vooUmw
 TAwLpsjrw8f/9PIVUre20Dl6r9OohPdjLru1KVqvNQMigFD5gesAEV+gBwrBlmXkf9R0
 bJAGu3yLGMmLJYm8E3cNKdCkF0np53qe6V6zNhZMtFounQUN2saIjGs+WhdxQJFUEW2/
 ML7bnUtvV5FdZ8zxtNH1LBL33zCNr0qPMwMAxReU5Kj/ovUa3uQlopY62NgGuqp+0u9B
 QT5jPhLY4YmBBTFsVOLYi+ajgg8aAsaOUVq7ZpdKcna4Fp915LLnJqyRn8Kz9Vr1zdvp
 J9zA==
X-Gm-Message-State: AOJu0YxeEdprCjDGk295mhyNruN/GDxqlK6UVSgaeTbA0nmgdEbs+Tl0
 KxzcoMcNcpzw6AwnKPZvggapCQlf1b1v5V+/R7DjtBUG3FHh24ALRm68kg==
X-Gm-Gg: ASbGncv/x4f/IwCCI04iBgsqsuiv49cvAAsBhZ8M1zMxl/TAW812Y2BiEOeTiqvlG4K
 lXOe/Pk3q7zPvGyFaJjTWAwmxYzxs4iDL2gE/4VEUhMIIYmfVvhc9qeGHq2usd6bs5mb6qROGpg
 QtgAfO9++FS4W+mR5cH/j05dtU8jsRpij5wJGvFREccx6RYDObJvuNmKfpqyZju8svqNMQzV4Ec
 fm6DLLy0kaaJuzLGpJujXYkSW0DufRhak9VY2GG42PrrTzdnROYXmQnrFn6qR5I4XltbV9vakif
 7tNbcZ/5y/IPdeOmfAKDBtrDPlEsXoZAhMkRCmCnqGExtAvKSpVBXdFarM2Z
X-Google-Smtp-Source: AGHT+IHOPEIJ5J4xiPAYMyrRc19t4jMVfB+LEhbRatZCAc49G8oELR4PRCWAfUq7bB71AjYyTkHutw==
X-Received: by 2002:a17:903:1744:b0:216:1357:8df8 with SMTP id
 d9443c01a7336-21c355ee6d0mr20308505ad.43.1737093415199; 
 Thu, 16 Jan 2025 21:56:55 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3d6fbbsm8563595ad.168.2025.01.16.21.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 21:56:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 16/50] target/riscv: Add pointer masking tb flags
Date: Fri, 17 Jan 2025 15:55:18 +1000
Message-ID: <20250117055552.108376-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117055552.108376-1-alistair.francis@wdc.com>
References: <20250117055552.108376-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Message-ID: <20250106102346.1100149-5-baturo.alexey@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 3 +++
 target/riscv/cpu_helper.c | 3 +++
 target/riscv/translate.c  | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5c85e8b28d..f22e43c662 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -635,6 +635,9 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 26, 1)
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
index 7406a43b9f..26350b2826 100644
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
2.47.1


