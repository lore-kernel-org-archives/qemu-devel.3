Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3509C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsf-0001vn-Ai; Sat, 18 Jan 2025 20:13:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJse-0001px-3U
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:36 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsc-0003E9-Cr
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:35 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso4378823a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249212; x=1737854012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3q5R8HpwKzyoZ5vWfbutGZ04bOMbm+fyoTOVTzEgWlQ=;
 b=aV5sPb4ZFLmpaGf5Ev8yIwViGQCuhtZ7nM9m6h0UHCuWp08zJjjmmUiJKUhPA/g8BH
 gdelALdQUvgGKx7oMiTN5z3Ajtmx7uvabayvHJQDuuLU+lN1IrteLPLNwsTyCXN92OD+
 Ux2SAw4rcE5k0XhtSQBEaXdRNrQiarvgPV8PyZJmgqW6hJTPv7T3sPpQYHN143BxFeK+
 NO4vt+vrqqatlQF4vs1CwN2HZgMzBG53vhbxwuMeH3eS5sHJ4JwSjGIBeyRpsbg15hP2
 z1ukk2pJybD51eJHYN02FXHfLLqZ4eV4cdmqsyi1kD0AmPUuYs2IiWca7HWYdoUKWeQu
 gTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249212; x=1737854012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3q5R8HpwKzyoZ5vWfbutGZ04bOMbm+fyoTOVTzEgWlQ=;
 b=OXDtrwwrUuarLMo3sQKuJAIEGyaAA0EElpdihJC24hl5HxS3dXz/7/cOITWEpuH+JC
 yIV/Az6R9CmyGMkS/74uxAJ99iNCTISCDJkilMtF9G+l8c2lGhcJWQuEFv17JvEbCIKI
 0xHe5eNIj828TIbuUMzmQhUbwPj23Ipxe5mADCVterwHKk0xiI3arRpcNvf5fWc6g/N2
 knZ7fyqMJeWcbBnoBAarlUjmJZIZuixPvrBMhWOBJT/vVeLkQd1KzY5eoh8tgZJB52ef
 RDXZHHbFwCvYAPcZpgRpyjYfkSoX1DdGVuN5Rfsk72B3cMR/yVZu+m6oeZzfEuC3UN/c
 lQdA==
X-Gm-Message-State: AOJu0YwHo9WbHCxGy6M3PGL95O5F75a6YNtGMOpBfLWooSYmbsOPuPf1
 1w0FBzUzhwGb1Tm5Ad7cv5AX1Oo4HUkeplZtXPC+Ibk6jOWK/x2PDV79QF35
X-Gm-Gg: ASbGnctEezy/W38cyq1th6pdVwcjhZIp84UVKg4bU/48xrnSquCbGE8tNRP8YRwaU0r
 Hg2L9VbmDrOS1pSU2CtWwpwq6DEP9oT4Q6GEYeqzPmJrDaxfQWvk7IdP+aORjwZ2I0htOeFZDca
 OUJ4I4XLqAvTo3VCVp2+H2ibj42AwLO8CdRnI16Eui2cCcUtzZrSeDY9MrUOjcSI7UVLnQFIciD
 HzMkh+Yqr1qB9theGKd0VLs36d6reTo+5iwchVY/QcNdNgPAcpUXgMfgIV/lPybvXszJiTV3doO
 i7PloaNDt8BueLg833OcELzqunFRszEZ2OEir//nAX4I0D5nmrE3G1sFhrqjsIfI7r4Hn9DMgA=
 =
X-Google-Smtp-Source: AGHT+IHtp5+VyoWoQlcn46HVcOj9ljIIxmcJn41aOT5UrkRUgiSgkKorCNnFTdT/q0seUp0wUgqwwA==
X-Received: by 2002:a17:90b:2b8e:b0:2f6:f107:faf8 with SMTP id
 98e67ed59e1d1-2f782d2e546mr12373222a91.24.1737249212544; 
 Sat, 18 Jan 2025 17:13:32 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alexey Baturo <baturo.alexey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL v2 16/50] target/riscv: Add pointer masking tb flags
Date: Sun, 19 Jan 2025 11:11:51 +1000
Message-ID: <20250119011225.11452-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
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
2.48.1


