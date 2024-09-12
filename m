Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D96EEE272
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 23:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sotdC-0005Hi-6t; Thu, 12 Sep 2024 19:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotdA-00058j-1r
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sotd8-0008B1-E9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 19:53:43 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so1409209b3a.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 16:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726185221; x=1726790021;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgQKcewfbnTfEcrsbPUbZIBiPMivs9PSGeqvWwo32SM=;
 b=qvK8WKEwsB5jhTpoPoAWgCdD4yIHYbViwLwWGqAYcxY135chOGzrDygtMg60GJiq5f
 RmLGh+Eh1sfTsw0m/wBdDWe7wxJuYn58k+aHJsXvIK7hBoVLOMIwTCvkOMaA4kE9ki0v
 ATPltwT6p7D5Ypil8mvT1ouR1aBNAnxtPgNWdP5/GaAbmQaLaq6JMxPI0Pc2CG9rG4EJ
 meGo37eW46B0bMlyjxEUGKswWzr2AZ7K/jJqQGjGB3Gnue48tVGU5jY+c9U+ghZGvKP+
 +4KjsYcHTLLWyXxWfjjHORZSO9DJyT/2zylRyA9sQxp9hzctbsHRt3oq9ge1wI3tw+A1
 DZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726185221; x=1726790021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgQKcewfbnTfEcrsbPUbZIBiPMivs9PSGeqvWwo32SM=;
 b=aEDdrJC57dSJPX99TDFywdhdkYqKebgZ/brR9C1gTbKj2WZUMz4OLzM6hzv8/s6gOp
 MRGahLhe+PIC5nsN074msAE3Z7K6Ha90i3PrOR1lo0oHOMnWGrNF+jCkYewJzW1XYi0h
 wD84peO1FyGvq1ADo7ni9eK6RsL9mPWSJyvGSD+MHrZl9VNrQ/4Hg4fBLGt+c7zqcFCk
 sEa0AvTa3B+EmiIyR/Y7r7e5/+ia9Bn3VyoIfVy36Zg8iRVn91qvl7n98uQnyN/8dQkz
 bjiAhCiIR1oTbm/ETx4lmVm99/HcQYt9iBWu84nlfeXPirKut3mgAtmMhxs+0yMIyutK
 iArw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT1iRDZxMxT0MNITFAsLtCwoZzjf84uxzK2kEzMyuw+GAeJ7DAalq98tqk0nIT9GHsik//uw9/xRM/@nongnu.org
X-Gm-Message-State: AOJu0YxujjL1WJQS71yaKdJTkZaPdpwrNA0n6cjiZRgY9G38hymBzT6d
 Kms/IYEWkSTHW+Dgf1iOGf+GblbpQRwTO52u6g1wd96EIHoEQAGlG7pQ7+jTO5M=
X-Google-Smtp-Source: AGHT+IGWWohQrkoIlXk+defS75cNWlR8Vmu4UbrvXT8+FQReFr9r2zQbX9kCrHzIC4orOmSEqQm6jA==
X-Received: by 2002:a05:6a00:3e15:b0:714:2533:1b82 with SMTP id
 d2e1a72fcca58-71926205fa6mr7701065b3a.23.1726185220917; 
 Thu, 12 Sep 2024 16:53:40 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe22e6sm5102229b3a.66.2024.09.12.16.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 16:53:40 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v14 12/20] target/riscv: tb flag for shadow stack instructions
Date: Thu, 12 Sep 2024 16:53:12 -0700
Message-ID: <20240912235320.3768582-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912235320.3768582-1-debug@rivosinc.com>
References: <20240912235320.3768582-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


