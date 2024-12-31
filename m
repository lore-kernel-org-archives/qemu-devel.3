Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0002EE7718F
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 03:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSSuW-0008KD-Hd; Mon, 30 Dec 2024 22:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuU-0008Hc-A9
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:10 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tSSuS-0006C4-CA
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 22:27:10 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21661be2c2dso116721355ad.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 19:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1735615626; x=1736220426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWz/BYHeT/N1oaTsaU4qO+pXd+fptwdn8OypYre4AY4=;
 b=Ek7ebYTvJvs8+hJffp5/okyzMyi98rzt8dkG7jhVPCTGsnW4QgJ9orzuBAT+N+plts
 0OLBqWDcb5hNvMWINwM6IqiXiZeziY6f8BXHTZDesZEo53v0ZwX89S1wQzevDsroktfY
 G4xhyZN2SNcnxEVcl06a+iM1hiJdP/TYW6iM2IvksF/9JPz8d/DX+Iy8W+CBWB2VolOP
 Ck8N2BN+yfjM+NYvdnYo2uiBOI0+Tr3r64bQajX9lB+ufj/giZYotDgE3AuZDxN+oulB
 KNb+y59OQUPC/eHw4TXyRqO53yAYGuqQlHDJlSseCW2NbxUtn2D9/JfD5PjvTOa0IYSs
 xmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735615626; x=1736220426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWz/BYHeT/N1oaTsaU4qO+pXd+fptwdn8OypYre4AY4=;
 b=Eql8TEdyiAa9raagEOU7fiYcTE88e+2jHSeAR5hs325jLIFJJ8UX415RZhwGM2AakO
 eOasTA8OjKZzVRgfa/H/E8yTH/543LxNYMFJ3HwyXQQvHjHA3F63KiLAwxKF2UIIyfUs
 HiCDlxgK9xFB+cyqWPyftWsS/aGGivk4ZaQ8MVTC16LzfgfuCosUB6mhF1aDyyrr7k8U
 3GNQ6tBHQcK5D+vwmiOymvggbWQ2KWGG6DL/ZZGtElBU1cesFpdYH4UPn/WWzZbxidn2
 lx0txruafMjOL/sZ+MY/Z4ZUf3rIFNFuVzEZcadLozdagpbXZb+0Lk3fINCzyfPR9LSb
 hlJQ==
X-Gm-Message-State: AOJu0YwBAsYk5UEqhv3+/WM+e4NhD6GONM7aAsbkOedYiUrRYZ/Jl/uV
 9GsxXL7NH+HJEO1aJyfhgQmGpXQ1PiCtqCtR5Vw3EKkqsLK2saA0SLVVjUG51mB7LxIpaRb7MpR
 EWmWxtYRHVRs6mxynG5L3ZqxWyhr2KMmadK1eJoqUOT/VmCt58wNQhS243ZtihTA7IhCnGS4oO9
 zV9P0nptFJmT+BK//JMGYfaoM77VWQ5vDzmodKVQ7MMl5n
X-Gm-Gg: ASbGnctvGJfOLpca9bXSUHR5WyzkyjhRr7ObxD5oxCTxzm4hmHXqrXTeiXxoN7PHvkf
 fQDM9Umo7AkrzU/jdxQDODorlehRZKofbKQQDrQXGqYbBMoMc+I1wUhTs1+aPbRsuisXw2JRLez
 payQAD1TSZnsNzC2IxKAC7F9FL3glS1PmzW8eiY6Rhkq1csK1Jd2ip1E2ikMemmZHFYznJ4fLDv
 yElyqpnUTPsM9+7aCzWTYvBDwZyUqNX1hGJDfqQ613+XpwVOrbsUDoOEIHFyUKZgGQXO1gSBjW0
 vFl+KBYkM5xylOZPwr2u
X-Google-Smtp-Source: AGHT+IH7iVFsnXeeBfjAHyxRA+oqaRR2aki3FqljhHdGXBbEui7dFo5uZf0zB9JwgbzV8/J9Iy6nsQ==
X-Received: by 2002:a05:6a21:328a:b0:1db:e464:7b69 with SMTP id
 adf61e73a8af0-1e5e048ae02mr64843212637.20.1735615625883; 
 Mon, 30 Dec 2024 19:27:05 -0800 (PST)
Received: from fchang-1826.. (1-169-235-48.dynamic-ip.hinet.net.
 [1.169.235.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-92587c62eacsm291797a12.21.2024.12.30.19.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 19:27:05 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v11 2/6] target/riscv: Add Smrnmi CSRs
Date: Tue, 31 Dec 2024 11:26:50 +0800
Message-Id: <20241231032654.133039-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231032654.133039-1-frank.chang@sifive.com>
References: <20241231032654.133039-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 58bb5196a8..c5d5c2f7df 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1127,6 +1127,11 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
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


