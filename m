Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A4BCA0EC8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 23:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjofI-0003zJ-S0; Thu, 29 Aug 2024 19:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjofG-0003sq-P5
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjof8-0003Aw-Oy
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3d7a1e45fso949111a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974485; x=1725579285;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1JkZkb4XyBKvgGCOavcZvESZvEBcV0RjqVon5JxlI0=;
 b=JeROT4zMrGioGJcJqhEFViKIFEO7FV5UuTbOLuAURigSpD4zo6PeloC4Ug5KiXwuIe
 MQMlscxHak7I0sqCDVTs+4+HiPJu6wpPalkEQu5vqub6PcjyKlAR2UZfWE+L0+6Od6al
 JghyKc1mtIxSiKdSk7f0KgM8fbfcXJguC8jxvkqVWSywIQCr2dkMK+7phRJprAN+dUjL
 hfFEPwgK7rDXkmujUj11qhk5+35CBsr+eJNJKF9t3tZJkh27C/nrcZTZfIqSn4ZLJjg+
 JpjJ6HcT9zssb/Lu6hlYFO0WTEyn03jsz5IeY0J5DKjgyG/BfAUTaFCs5/f5BOpYveMh
 h3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974485; x=1725579285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1JkZkb4XyBKvgGCOavcZvESZvEBcV0RjqVon5JxlI0=;
 b=JMO2GWfaQgBPbSRGmP9+pR0kud2JFqLqz7REucWU5DdzfXtm5+n3mS5tGSGpgDyPwc
 CoL2C6k9jwDnHvNfmC0Enqs0i9sNKezBL02b5KJFiZ12G9RjBTVpmC5XcUOq3Hrid+bq
 k4yoOFwdmc8eP5g9PqG9//M+yrC9Hyu/3O3t9V+a9REk1qmOQElCw8WbrO2av5LPPyst
 lfvYEHbyBSBz3CRWTlje2DRl8NmIiL3xn/8H/AEaP2XwcLMGBtHLyPKDxdqd3Icy5yjl
 JVp+qt7+bzQJRZzH6xN2io03azOo/NsLhEQDceydgbZPAVoJd4kDDcPfvwuPoaWXGYpM
 ysHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaVTGqzG/QlvU7ralzQ2ssg53+Av/Pt14cK0oiSYEPpVywFAi1uagEMsQvgafwJ9W11NeOJC7k7RBj@nongnu.org
X-Gm-Message-State: AOJu0YwQ9T5DB3AGyklSxzQcxz1yI2yfEdYS2TEDQokNrqnHYkARijzZ
 LaKKlBhZXbZRtS8vm8p9FGnSWmLQVHWM7owVUvd1tt965YUJJv9neKC9JYIFVt8=
X-Google-Smtp-Source: AGHT+IGrZ9hrru+fguW2BSAU60HC2cgGeJw9HW8SBmpfSgFaA1NJSaPS9n40usCpQrvVp+gbKgjoyQ==
X-Received: by 2002:a17:90b:17d2:b0:2d6:197e:5c46 with SMTP id
 98e67ed59e1d1-2d8561c63admr4550878a91.20.1724974485263; 
 Thu, 29 Aug 2024 16:34:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:44 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v12 12/20] target/riscv: tb flag for shadow stack instructions
Date: Thu, 29 Aug 2024 16:34:16 -0700
Message-ID: <20240829233425.1005029-13-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240829233425.1005029-1-debug@rivosinc.com>
References: <20240829233425.1005029-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 4ace54a2eb..e758f4497e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -612,6 +612,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index f7e97eabfa..be4ac3d54e 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -169,6 +169,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
2.44.0


