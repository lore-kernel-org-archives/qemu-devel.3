Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B06EC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCKh-00029H-5g; Mon, 19 Aug 2024 20:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCKS-00012D-9a
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:30 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sgCK1-0001Dk-84
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:02:08 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2020b730049so25627835ad.3
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724112108; x=1724716908;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XKR28zkZ+PgGQiLkDEUcwad7NwAkh7dvGt5OrxJGO1A=;
 b=OpJze2+VSWjOoFWsAGZPqxcYNy4woMxu96iav6hXHy690HU7iAe5t9f2KjdpXxkP0c
 7RbG5mp+BXw1sBQgNPXuLlAGfH9af9dQGGPLJPofUsMIRX81BYSNf9PgS5aNzRjMwnBd
 X7HuHmjUKnJg6ZyasqQeFBcPqoF3qeoAhZV4dbbivByKG9qLiuU6pOsW2TgIQG8Uqz4f
 1Lb1qcWvtA57rkxxz/uyHYsY+l/Oh6VqoJ9KuGb10BMTXKELbomVnCAQRpWNYqyjbR6e
 2y6hvVCjZKnH0xk0nQ5iskbAyMsZOS7c3tY6/Luy1I5DgWlZGnTkxJgtnKP+EO0NDdgW
 m6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724112108; x=1724716908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XKR28zkZ+PgGQiLkDEUcwad7NwAkh7dvGt5OrxJGO1A=;
 b=tRN+3mm0vOCYt2DK8RVCZuxZibSkUXAxSEMGs3m1lXZVlNNayoUpq3Degx+uhIy+Vz
 Tz2wBV2p32HNUhq4SPT4Yb9MrT6z0KfVTt7Nb3+nBfK7ZrPr/gSohTZERJxjFMfxA6HF
 4STEL4aniqciHYws1NBiNJYnA67UouGOyFewfA+LCkGU5Gd+AXG9wdcFhk6ohZYIXuNn
 Bul7WqjLfrQbQk67dH2INyjQDIXQkU5LdRJbmzDe6S1Djc/ggoZ0UAXQWbZGNL1uFHgr
 KoyrJ4WFZCbYuMrg6DXfm6mB1ESJ0s0u0E09MHZv192tsCXF0cCOwsrucTgqCMcoYwRf
 avCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOxnxpR9Zco7wFP4d8nrEuRwT5XF4nbUPqYny0Y5gLk5sw+7Z6h5Fl8/XhpTzMp4hag8vs35WLo+ktX8PtnBuV9OOwhHE=
X-Gm-Message-State: AOJu0Yxz5JEVNmIzPUkF/u6QN9JnDHnYUfjKBL2JWMs80oW8GuJz4RmE
 vxOvH016J+4WzGJVJVvDDMe6PKiIhZI7doNd7Kl558aVZdZDhCHYpheTElftMAM=
X-Google-Smtp-Source: AGHT+IFdHnopQ6MPPHUBcBeMF3jtzknxsPQhVMqzyywNUUc0FBv8ewgYvbYN3aKCXcXSjsRNoVEnYA==
X-Received: by 2002:a17:903:360e:b0:1ff:4b1:dfe1 with SMTP id
 d9443c01a7336-20203e6f031mr127756425ad.7.1724112107741; 
 Mon, 19 Aug 2024 17:01:47 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a779sm67477445ad.188.2024.08.19.17.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:01:47 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 10/15] target/riscv: tb flag for shadow stack instructions
Date: Mon, 19 Aug 2024 17:01:24 -0700
Message-ID: <20240820000129.3522346-11-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240820000129.3522346-1-debug@rivosinc.com>
References: <20240820000129.3522346-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x62a.google.com
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
---
 target/riscv/cpu.h        | 2 ++
 target/riscv/cpu_helper.c | 4 ++++
 target/riscv/translate.c  | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5a57099d59..dcc3bc9d93 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -613,6 +613,8 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 /* zicfilp needs a TB flag to track indirect branches */
 FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
+/* zicfiss needs a TB flag so that correct TB is located based on tb flags */
+FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 96571177ef..d3115da28d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -170,6 +170,10 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
index 6c1c868a4a..42dc8d3600 100644
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
@@ -1241,6 +1243,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
     ctx->ztso = cpu->cfg.ext_ztso;
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
+    ctx->bcfi_enabled = cpu_get_bcfien(env) &&
+                        FIELD_EX32(tb_flags, TB_FLAGS, BCFI_ENABLED);
     ctx->fcfi_lp_expected = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_LP_EXPECTED);
     ctx->fcfi_enabled = FIELD_EX32(tb_flags, TB_FLAGS, FCFI_ENABLED);
     ctx->zero = tcg_constant_tl(0);
-- 
2.44.0


