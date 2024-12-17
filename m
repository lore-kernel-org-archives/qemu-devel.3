Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A3FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNR1M-00034R-A2; Tue, 17 Dec 2024 01:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR1A-0002zH-Qk
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:16 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR13-00053K-W5
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:16 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-725dbdf380aso3860017b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416707; x=1735021507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GxSpYyjxaKzA9Tf0vwncvn7U3uu9NWfwmI2ts/PzYy8=;
 b=YhNCTzc96hKa94vWL6tetunn16Bu6ANDmOSREGcKeDyikXPCKBorqPJoMqqO+vOifw
 rgVnkGzsq8lnZCdNiggr4P/EWzzqeWdFV5GL9rkCtBY71MnnFbi6WuYTwPgcT4aIy2n4
 WXKPasFHBlkiM+1riTtThFBj3JN7nj/TPAvHe8r55scEVH5/A6b5AtRzqLA5oSUKJ91E
 PFWlktrmRQw2mZ0zu07k++iVwk5CSwQfGOX25YNTaCqG+/cgx3bUMKEVC7Hbf96z2Dkz
 TbddizTtavSwWvUPI15mSo/FiaDEmD38nz6cVzGXidg9/Cx9v/xIhaNYV8ro/zvfiYzZ
 qhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416707; x=1735021507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GxSpYyjxaKzA9Tf0vwncvn7U3uu9NWfwmI2ts/PzYy8=;
 b=hQ+Lw2LWqH3RFoA3W9+LYBKZnoYrkj2iIxi1GLxFH+Q0oXBUT/V0g4OwGAbhTRbNXn
 5g6nqGQAREgA5hh4w8xzYpPqFWJiFZK9JhnKBC0wTn/wCyFqQYf4bRSEHNyMKRiznbsW
 qjfqZX2qcc3pOz2Z0jjYrJpItVD2cmew0IEcFrb00uKUln++kef8OdhnmvcXcz3dVa9c
 BBWAap/zuRQGL+ASjGAAf5Dc5J8MKsjXCG8fNIulklgS8t0+HTdlMYu+hMOq0tJkWNMi
 nnyl/phgcP9Hvc0p8P5w/mNL+CIq/74sIS8wSpwXY35W5Q7JuGCwOh/VBvKBS3CvHn+x
 25uA==
X-Gm-Message-State: AOJu0YxTGfCFVBJTXdxVxj3uCQz1Ii9h9mQm5OxIhQzFCR+DwwmE7z7r
 gMQ9/FOOH9w8pSbpkhilaq30xu47emGywmsRumaj2rrH2sV4xOnMiGbScdSteoS4Ui8vQ5D6xv+
 bQSgoFK93550fcwNFgcjwek6NzIAJz0VK3iRr+ORYqEqOT+TQBIxVPJc1t2CCzA+egRQaYVuGfV
 jiN+GuaeaTW6MoGykZhR9QIQdBW7O4t6EMIIEC+TuOhw==
X-Gm-Gg: ASbGncvLGbFRkntWSObk+RveqRmfFaXbfvHzrMC+lAuug/pjTu76QfS7sSCDXyRUnZ2
 HCF3teoCRQIgpX6QLy9qej0EoKRaHU4ulNA5+FCPJxUdz/ruBrPohHuuc7JVeTiARRNvq+tugNI
 2sh3WNR3dxoB1JURgY5u60u4dKsYovoMxX0f4QM3aRyXDijv7CUhaWRp3xPTpGiDMTNtfIoXsRK
 plviI3t/cbJxrwd8tN475GwdOnSPLpm0yGDM8CPtM9JvOU8flcFnpQQ9M9oRTEC61Ahb4HQIp1M
 DU3ehmbX6f0=
X-Google-Smtp-Source: AGHT+IGrLhIe2sqtyJErG/yy1ccoToATmMhB2liie8YXhp31e8nyggegPi3SLTYmh/Z5XS/j5LAuxA==
X-Received: by 2002:a05:6a00:9090:b0:725:df1a:273 with SMTP id
 d2e1a72fcca58-7290c28faf2mr23243690b3a.26.1734416706523; 
 Mon, 16 Dec 2024 22:25:06 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72925e6e8b1sm4354301b3a.139.2024.12.16.22.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:25:06 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 2/7] target/riscv: Add Smrnmi CSRs
Date: Tue, 17 Dec 2024 14:24:35 +0800
Message-Id: <20241217062440.884261-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217062440.884261-1-frank.chang@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Tommy Wu <tommy.wu@sifive.com>

The Smrnmi extension adds the 'mnscratch', 'mnepc', 'mncause',
'mnstatus' CSRs.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c      |  5 +++
 target/riscv/cpu.h      |  7 ++++
 target/riscv/cpu_bits.h | 11 ++++++
 target/riscv/csr.c      | 82 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 105 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6748185206..ade9e6e190 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1134,6 +1134,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
         riscv_trigger_reset_hold(env);
     }
 
+    if (cpu->cfg.ext_smrnmi) {
+        env->rnmip = 0;
+        env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, false);
+    }
+
     if (kvm_enabled()) {
         kvm_riscv_reset_vcpu(cpu);
     }
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 284b112821..a2cb471b3c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -486,6 +486,13 @@ struct CPUArchState {
     uint64_t kvm_timer_state;
     uint64_t kvm_timer_frequency;
 #endif /* CONFIG_KVM */
+
+    /* RNMI */
+    target_ulong mnscratch;
+    target_ulong mnepc;
+    target_ulong mncause; /* mncause without bit XLEN-1 set to 1 */
+    target_ulong mnstatus;
+    target_ulong rnmip;
 };
 
 /*
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fe4e34c64a..9e9637263d 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -353,6 +353,12 @@
 #define CSR_PMPADDR14       0x3be
 #define CSR_PMPADDR15       0x3bf
 
+/* RNMI */
+#define CSR_MNSCRATCH       0x740
+#define CSR_MNEPC           0x741
+#define CSR_MNCAUSE         0x742
+#define CSR_MNSTATUS        0x744
+
 /* Debug/Trace Registers (shared with Debug Mode) */
 #define CSR_TSELECT         0x7a0
 #define CSR_TDATA1          0x7a1
@@ -634,6 +640,11 @@ typedef enum {
 #define SATP64_ASID         0x0FFFF00000000000ULL
 #define SATP64_PPN          0x00000FFFFFFFFFFFULL
 
+/* RNMI mnstatus CSR mask */
+#define MNSTATUS_NMIE       0x00000008
+#define MNSTATUS_MNPV       0x00000080
+#define MNSTATUS_MNPP       0x00001800
+
 /* VM modes (satp.mode) privileged ISA 1.10 */
 #define VM_1_10_MBARE       0
 #define VM_1_10_SV32        1
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b6fa8ae53f..65daf6d138 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -597,6 +597,17 @@ static RISCVException debug(CPURISCVState *env, int csrno)
 
     return RISCV_EXCP_ILLEGAL_INST;
 }
+
+static RISCVException rnmi(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (cpu->cfg.ext_smrnmi) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
 #endif
 
 static RISCVException seed(CPURISCVState *env, int csrno)
@@ -4654,6 +4665,67 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
+                                     target_ulong *val)
+{
+    *val = env->mnscratch;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnscratch(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mnscratch = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mnepc(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnepc;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnepc(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mnepc = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mncause(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mncause;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mncause(CPURISCVState *env, int csrno, target_ulong val)
+{
+    env->mncause = val;
+    return RISCV_EXCP_NONE;
+}
+
+static int read_mnstatus(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    *val = env->mnstatus;
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mnstatus(CPURISCVState *env, int csrno, target_ulong val)
+{
+    target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
+
+    if (riscv_has_ext(env, RVH)) {
+        /* Flush tlb on mnstatus fields that affect VM. */
+        if ((val ^ env->mnstatus) & MNSTATUS_MNPV) {
+            tlb_flush(env_cpu(env));
+        }
+
+        mask |= MNSTATUS_MNPV;
+    }
+
+    /* mnstatus.mnie can only be cleared by hardware. */
+    env->mnstatus = (env->mnstatus & MNSTATUS_NMIE) | (val & mask);
+    return RISCV_EXCP_NONE;
+}
+
 #endif
 
 /* Crypto Extension */
@@ -5161,6 +5233,16 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                         write_sstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* RNMI */
+    [CSR_MNSCRATCH] = { "mnscratch", rnmi, read_mnscratch, write_mnscratch,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNEPC]     = { "mnepc",     rnmi, read_mnepc,     write_mnepc,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNCAUSE]   = { "mncause",   rnmi, read_mncause,   write_mncause,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+    [CSR_MNSTATUS]  = { "mnstatus",  rnmi, read_mnstatus,  write_mnstatus,
+                        .min_priv_ver = PRIV_VERSION_1_12_0               },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },
-- 
2.34.1


