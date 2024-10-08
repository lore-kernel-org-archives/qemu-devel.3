Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833DACF042B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 22:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ2U-0000NJ-VI; Tue, 08 Oct 2024 18:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2Q-0000Kn-Aw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ2E-0003yS-V2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:33 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c593d6b1cso10339695ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427830; x=1729032630;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgQKcewfbnTfEcrsbPUbZIBiPMivs9PSGeqvWwo32SM=;
 b=KqALfXp2P1UPdcif8CQ8kH6tbIEmZ8lrmXMoPMyA5chRr5n3VWZ6YOzNH6Az/B0dP0
 UPRAMgnVjg7XoHgBiSB7wUoH4xFj6X3ybE9D9Icj77oHCxB2e8rF3bX/B+YA5K4DjFy2
 0npa//XCE+vJVweCx5dOklr6BDMebIz3YJtFdSgoAwlG+JUikRI0X7IjT964mcC5D3MV
 xfBeUYgeJ81pDFcy4ljLi8ozXXz3tW1OWS43gnXG/ISODXY7nH8U3woO7BU2XlZAhYlf
 h1Q7MsBWj9dL2GjicpyV33LbIDopAXr3jWZQssjrIYhbsOLN60DhU8ptnhfoQJsXlzi9
 uFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427830; x=1729032630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgQKcewfbnTfEcrsbPUbZIBiPMivs9PSGeqvWwo32SM=;
 b=oOojRIAgScc4OG80v/nsvIeJe6c/tyvsLU4CxxQfNIWPZYOPOFSK4thcV4V5U0OBQM
 35Ia9F16kH6jo1y5gmZnbwMcl4R56sMHuu4Udix4k8ILOKf1HU+lE2hcIdor9dKvzW2J
 ng8L44yQZU95IwH4CPjvnCNglWzy0K2JoUpepnZzgaVoGGjv3hkMfAiIrn6elwwAFYZ2
 YvwCJO1WxJLneAhse4Uomd4bU/OLD/J9Cqda/5xYI31rUmx5iVJIKZHEJc9LuFIRzneC
 CRzIo8rc+HuDToerTm9qdZsXdOKCCX2X8NjRbOOZql8bzzazEXWWwOtGLB1rVKAGrllz
 0BPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRGDNVTB4TU+zeEwPtpAExVNmIyU+0kVyrH9kaUifRTtMtFfKS4tFq3alXsyDvCTQBG+lU9ZoEvpur@nongnu.org
X-Gm-Message-State: AOJu0Yyr3k9W24WQK9qvwa+T1akwcq2pdKOd5DAzbH5PnE7heKISMSfA
 rqcMO34CKYBJV1aQtovQCyijqVSWQ94Biy9r1aeYwPM+FNDz4/1gVSCUXsiAQDo=
X-Google-Smtp-Source: AGHT+IHF4JcVI+3YqTE/WR2ZW4Fa9HnmDxRxIDFISYcNUJYOQBqSJPpSbbddlXaUV1z4nx29B45Naw==
X-Received: by 2002:a17:902:f78d:b0:20b:71dc:48ab with SMTP id
 d9443c01a7336-20c6377dbc6mr8085965ad.40.1728427829773; 
 Tue, 08 Oct 2024 15:50:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>, Andy Chiu <andy.chiu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v16 12/20] target/riscv: tb flag for shadow stack instructions
Date: Tue,  8 Oct 2024 15:50:02 -0700
Message-ID: <20241008225010.1861630-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241008225010.1861630-1-debug@rivosinc.com>
References: <20241008225010.1861630-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Shadow stack instructions can be decoded as zimop / zcmop or shadow stack
instructions depending on whether shadow stack are enabled at current
privilege. This requires a TB flag so that correct TB generation and correct
TB lookup happens. `DisasContext` gets a field indicating whether bcfi is
enabled or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 4 ++++
 target/riscv/translate.c  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 997b579526..d39650636c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -628,6 +628,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 934bbff579..93d199748e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -171,6 +171,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
         flags = FIELD_DP32(flags, TB_FLAGS, FCFI_ENABLED, 1);
     }
 
+    if (cpu_get_bcfien(env)) {
+        flags = FIELD_DP32(flags, TB_FLAGS, BCFI_ENABLED, 1);
+    }
+
 #ifdef CONFIG_USER_ONLY
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index b5c0511b4b..afa2ed4e3a 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -119,6 +119,8 @@ typedef struct DisasContext {
     /* zicfilp extension. fcfi_enabled, lp expected or not */
     bool fcfi_enabled;
     bool fcfi_lp_expected;
+    /* zicfiss extension, if shadow stack was enabled during TB gen */
+    bool bcfi_enabled;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1241,6 +1243,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->bcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
-- 
2.45.0


