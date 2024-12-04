Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47FAE77177
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoxE-0008BA-DG; Wed, 04 Dec 2024 07:58:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIox0-00081T-I2
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:57 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIoww-0000Af-K3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:54 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e87b25f0so533606f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317067; x=1733921867;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0BdiPoCW2sPd1Y1VSCMikmuF5uV1Ceplm251HQmWDI=;
 b=X0CEa57X2xpecqbGTsiFlb6KGu44LQyFrwGL8gmop2j7nF8IZrN4U5LltqXUvFIINa
 SqmncoerpvmG3ZNSfzdPNISvPDmYLT9whcuYzQv3VcOT+v83v/gj6t2rVNmD7XwEjGW3
 h0uwl79VO/GzPVW2/JaRo/3Ae2fePAylqdTutHHOykQSk6Nn5PCyMwuteLHEwYeJYrPa
 XNm9OQVV8v/JXwX9HSmtOWisxkKMhQBbxotBu8lk/DAd1F8rXZiubxFadxMMgCy28TA2
 g7I3iXl5MgQtUbjbIRRSd3OVjwTepQ/+D0IFsw0dfxa2qcBPwbZgQihQeATPI9ThZbdV
 VfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317067; x=1733921867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k0BdiPoCW2sPd1Y1VSCMikmuF5uV1Ceplm251HQmWDI=;
 b=Bu9uMXAhX87uPW2JmyXBnfPqnbKSCHMsVFWR3HtX3Swpb7jp9U0gv6ceLggfebC0E1
 dExcuvzZB0RaU8bjQuLtEqKywKuyO3hnkto7ijI7bSR4lYkxHRmElmUJJ9ZcLBmCZwiI
 RGBAtM2gkzOopD0WYNd735l37ILf/QfEeFBS+/Yw1KMISWZ7St7LkBsYKaX/DQpZN+95
 kw/lJY/gDqJBu+P9Ve9p9SP+GPKsGo1cMtdR4IfbYCADKLHPnbB9AgmdXPUygSp6EHZg
 JMLaqfnDY5QivZxzlCbGb/HO6q1T+yQJrGroF2hpEDbn5jzKyleSSjfzYvOA5JuF/7b2
 Lapg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmvkxvQHrIJRcwm6aswXG5VaA823/wCD4i3LEvA6bTfTBC1EiT0eTW9gGhkZ91LtlmrQ4QLotrMg+u@nongnu.org
X-Gm-Message-State: AOJu0Yx28wLuZnjtK3WwA4vkFssTD97gsRpCxfeBl0A+qogbaAhqlqRh
 dZYkdwzeABpxxX40ThN+8O9k2PqnWkPDxXNhvpozI4V4ZQnDJpr27FhHw0IgkHc=
X-Gm-Gg: ASbGnctquzsPulibpQbuvp03VrB0sbGnYqPJlQ5qTZ4g+1iRr53ml/ICZXe/A33lLpE
 7y/y9iADWHrtOXw+/g6uY2qjcokNlt4cOnPbUaC1YNx2QuQauYVijhaRMyfsiheKp6llXzCCTBx
 W2TPVFbdVZLTwEH0b7mQrLPMK2iHqZSztxojPGhaJesH9M5FqlHCO8mP8ioZ7PS9nSMAyWCqDLT
 NVlM8zE22FP4YDeh99w95vEkbXHE1ASca5DbFWmpORq6x+MiW8LgxGHZPZY0q42Qr2NiaB3y6Ea
 Hzm9sw==
X-Google-Smtp-Source: AGHT+IGiLay281z8PTNaBbazh+tyFb0W1NTtFnXmNW2Yil1btTT5tmrmXaW11Jss3r5JIZxo08lBDw==
X-Received: by 2002:a05:6000:156b:b0:385:faf5:ebb8 with SMTP id
 ffacd0b85a97d-385fd97725emr5363344f8f.7.1733317067402; 
 Wed, 04 Dec 2024 04:57:47 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:47 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 5/7] target/riscv: Add CTR sctrclr instruction.
Date: Wed,  4 Dec 2024 17:56:43 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-5-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x434.google.com
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

CTR extension adds a new instruction sctrclr to quickly
clear the recorded entries buffer.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h                             |  1 +
 target/riscv/cpu_helper.c                      |  7 +++++++
 target/riscv/helper.h                          |  1 +
 target/riscv/insn32.decode                     |  1 +
 target/riscv/insn_trans/trans_privileged.c.inc | 11 ++++++++++
 target/riscv/op_helper.c                       | 29 ++++++++++++++++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index f39ca48d37332c4e5907ca87040de420f78df2e4..85ca2bfe435d0c9d245f2690fe3bde3e076d3b2f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -613,6 +613,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
 void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
     enum CTRType type, target_ulong prev_priv, bool prev_virt);
+void riscv_ctr_clear(CPURISCVState *env);
 
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index dbdad4e29d7de0713f7530c46e9fab03d3c459a4..b1130180710b0e01e8ebe33f0974edd8d5abe56d 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -783,6 +783,13 @@ static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
     }
 }
 
+void riscv_ctr_clear(CPURISCVState *env)
+{
+    memset(env->ctr_src, 0x0, sizeof(env->ctr_src));
+    memset(env->ctr_dst, 0x0, sizeof(env->ctr_dst));
+    memset(env->ctr_data, 0x0, sizeof(env->ctr_data));
+}
+
 static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
 {
     switch (priv) {
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 065d82d3997b1df46a0ed1b96d33bee13c049fad..79899b9cebd6a6731370097e56cea3f5e3ee6a5e 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_2(sret, tl, env, tl)
 DEF_HELPER_2(mret, tl, env, tl)
+DEF_HELPER_1(ctr_clear, void, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index a2b4c0ddd47ad9464b4b180fb19e6a3b64dbe4e5..8188113bcc90482733f676227858829bac5c5462 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -114,6 +114,7 @@
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
+sctrclr     000100000100     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index a5c2410cfa0779b1a928e7b89bd2ee5bb24216e4..1d7a17373e06a9f3226c1c14a54beb1a56e17b83 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -69,6 +69,17 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     return true;
 }
 
+static bool trans_sctrclr(DisasContext *ctx, arg_sctrclr *a)
+{
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_helper_ctr_clear(tcg_env);
+        return true;
+    }
+#endif
+    return false;
+}
+
 static bool trans_uret(DisasContext *ctx, arg_uret *a)
 {
     return false;
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index b55b7f3ac3d209d39b16075e79c2342b89bdf805..d22609347ee63be183ab253e7a0158a19ff0bf52 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -389,6 +389,35 @@ void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
                             env->priv, env->virt_enabled);
 }
 
+void helper_ctr_clear(CPURISCVState *env)
+{
+    /*
+     * It's safe to call smstateen_acc_ok() for umode access regardless of the
+     * state of bit 54 (CTR bit in case of m/hstateen) of sstateen. If the bit
+     * is zero, smstateen_acc_ok() will return the correct exception code and
+     * if it's one, smstateen_acc_ok() will return RISCV_EXCP_NONE. In that
+     * scenario the U-mode check below will handle that case.
+     */
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    if (ret != RISCV_EXCP_NONE) {
+        riscv_raise_exception(env, ret, GETPC());
+    }
+
+    if (env->priv == PRV_U) {
+        /*
+         * One corner case is when sctrclr is executed from VU-mode and
+         * mstateen.CTR = 0, in which case we are supposed to raise
+         * RISCV_EXCP_ILLEGAL_INST. This case is already handled in
+         * smstateen_acc_ok().
+         */
+        uint32_t excep = env->virt_enabled ? RISCV_EXCP_VIRT_INSTRUCTION_FAULT :
+            RISCV_EXCP_ILLEGAL_INST;
+        riscv_raise_exception(env, excep, GETPC());
+    }
+
+    riscv_ctr_clear(env);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);

-- 
2.34.1


