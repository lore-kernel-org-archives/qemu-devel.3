Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407E7D75BBE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 06:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE0RR-0004Y7-Kj; Thu, 21 Nov 2024 01:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RE-0004Uc-QG; Thu, 21 Nov 2024 01:13:12 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1tE0RD-0006Jn-4E; Thu, 21 Nov 2024 01:13:12 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ff589728e4so18555371fa.1; 
 Wed, 20 Nov 2024 22:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732169589; x=1732774389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjQFE0vWqMf/ZtDxRzOt57Rq4yMHkB5JeBgxsCZwEu4=;
 b=auvcku7jo9YVhJcxBW+BcZNLFhr0mvLvu/kZxovjKVIkrn04Bcz1kUIKbre2L3BQMg
 qyQVlhR2MBp2FMPHJpub13y9fZ1Ubm1YQXDpzXY4NqV3xvLfD31V/lH+N/mZFLH7ihTP
 mw/hkl7vkjJxdvIW+IvO65fy2/ThAFBlfOHbHgUn5FE25Ovf8brGpgsjj18w4JWyILt7
 KRsG8dqOBufCQnpnSjxo1dtOvAnlqzcRolMNNmDxOLSEPbYktZOez6+Lm4f/Yx6RZ07+
 AVGHUTYPq+0wV4M8FyBUL4fV1R/g78cVPUfHSUspfuPUKDyKM4Z/1/gyA90it3V6cNy6
 iEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732169589; x=1732774389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjQFE0vWqMf/ZtDxRzOt57Rq4yMHkB5JeBgxsCZwEu4=;
 b=q6iGs4lsqoCTcn6AwvGfe2yDVu7bvxkAbUfRnOGR3oQetc6dPoRayDt1YDHrHL2bK5
 7VLl2FISi3sjTz4jzetXmdwdOWc/jrH1qJdpVf2zYbQXAF5hZJrZEU/FaIcxbSEMiq5w
 IJDKEjZX8CirDoWsGRmdrIBlOy7uv88eO9VDH5gKOoRZxzmV3UGWB/33lO2lW9xtJXf+
 u3VNQS1nPfqt0G7DSTSbGD9GSuabGAb4nRa8tylw8oNatyq71T9vt/fBtE2I55OrSBtk
 eZacUmtTBg23QqSIqVT/Miquapl25LfaFNEd7dTd4FNXGni93mpM0qTcZ8Pfaln0Y37Z
 jnaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK7vkfNY9jNgFFmEI75GJ9zeE9MTINxWBGJx9FiUdJjUha5zq+TIXlHNWZQroUrZRoNsT3WY+dxzx2Lw==@nongnu.org,
 AJvYcCXy7mZtnQ2J4vtekhFdEW/19GvCu4ck5SFNJCeoC1zzCJmaQz06HrwjfV2xhlOksDNCl5ZRclXrWaRh@nongnu.org
X-Gm-Message-State: AOJu0YyPR2ScKzEa56E2+w1dredoRbrc3danG1GRRuazYsSPYO5X6KZ6
 Fsj/rPbsQjNCXw4W1ZZuqxTOR1g50DQJGJKBeBMI8AEuuqND9FGB
X-Google-Smtp-Source: AGHT+IHRRDdyIMHZc6j5rPLh3Y7rB0X+J+RZYWAvF0v0yiBsC7zIYlG1moH17ATU8MsAeMv93FOpbA==
X-Received: by 2002:a05:6512:3599:b0:53d:c646:f7ed with SMTP id
 2adb3069b0e04-53dc646f7fbmr469461e87.24.1732169588937; 
 Wed, 20 Nov 2024 22:13:08 -0800 (PST)
Received: from vmdev.asgard ([81.200.11.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dbd4726c3sm840443e87.205.2024.11.20.22.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 22:13:07 -0800 (PST)
From: baturo.alexey@gmail.com
To: 
Cc: baturo.alexey@gmail.com, richard.henderson@linaro.org,
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com,
 liwei1518@gmail.com, alistair23@gmail.com, frank.chang@sifive.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 4/7] target/riscv: Add pointer masking tb flags
Date: Thu, 21 Nov 2024 09:12:56 +0300
Message-Id: <20241121061259.4043177-5-baturo.alexey@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241121061259.4043177-1-baturo.alexey@gmail.com>
References: <20241121061259.4043177-1-baturo.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lj1-x22b.google.com
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


