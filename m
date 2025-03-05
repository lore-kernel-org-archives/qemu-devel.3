Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20E1C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxv-0004AP-Kv; Tue, 04 Mar 2025 20:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxt-00042E-Aw
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxr-0008VF-6U
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22113560c57so118906575ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139665; x=1741744465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPNBvqAZY4L0d4BaHaKOca7aSnEydv0p7oAxkA5Q0VM=;
 b=d+GOcha9fsHNb5+uauvCXrKktDl2clVDT88qnmUePfL32bPkxAMjXwf7sByuhCCB20
 9z2YoBaU/XW5+KhaKqBMQTQyqMogLQEOShjTvdJLLagKSeZ8okBvLGiI7lKkEe7wGgNm
 1rXnRXILt5AtC1Scev1Cf2TI4BttRI9k+l3A4tIPsVqp8dx2ny6SuRYPjKn7Qp31mDiI
 dC118CGn9OXzCuQpiVA+Z8vdmOKzwa4xVpoRb7K9EVaOJWWEiRK9MP5Q6xCpI8OsQf3V
 2vS54RvjlTOtF3jHshXYpF2PXxCJyWqCty/oiAa0vGASwjO10n2jShNb0MGxvzHzB/Hl
 LrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139665; x=1741744465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPNBvqAZY4L0d4BaHaKOca7aSnEydv0p7oAxkA5Q0VM=;
 b=NS44S553RDljX9IFcypmU6/YZPnGo/GN5SbuPnBE1oyk1w3p0iTZweBDlS0oy6Tljo
 fQxg9H0s37UIcAZXh6ZBb0kbHl4tprlZxZ2Z+aZu6uAzqUHvqF9SwfNozFe9ZsD9egbL
 XHPZvSxwefxS74XexbJ/iHMGtveJ9pIAZLl8vHi4YiIktgDL1LypLehxAA2ny6A2bhWw
 HYrxUW/hHfafFQNgNfsgz7yvgZB3XHb4jkii4NMLrZA/yu3PdF97KoI+FenGhojfKXJb
 lTl4AVobCej57Jj2Ur5hcYLtEBG5vbRD9GCvtXHB0RrSH+Xp1V+5wNts9/ju/Ny6SDHB
 hFkg==
X-Gm-Message-State: AOJu0YyD/d/r6LFNPDUvkuukvlkw91KiJFNksIGJd3G0NagclqYMNxL+
 it8Chkq5xUpeCv42l7Gb8wSOHBYXygVHapRxWbJ1nFT001ErxqUv3dJobDQEQ0s=
X-Gm-Gg: ASbGncvfPGghHTCR8NqQQsC9M2SOKJAorQ7wvUwUJ5KxBxoH5oeGcuoqI9cbx4PJllr
 PiHPPsBd9RKFF02SfJigspxJATkLOTVBWtSkwPdHI2lrjmMPoNfI8z9okuIhIT/Ct6pD9BSMnY3
 BiablzoO/ykZeyGzw+FhwZH95Q1gKmpttwLiL5+GWtAoi2QT+jSa2eBg2ZlNOm1S6LCkDrM/KHr
 E+RiB/t+ntf7wFGN3BcGTh3jgsXpJ8z804YHAqkvrIbOibvHpne2a4FC+ETRVx3RyuM0fzqlVWj
 g/0anB5DXIkgvE+rUTEs3LU8j3KJ0HN5ofJmBfuF25EevxszFo4AWHwnVlHQO2hZD0eadu+5D2U
 BSeOc/kvWGIjG0M3y+LTtCDFJ6/gCrZIfWe2S7o53kqhk/gkIkog=
X-Google-Smtp-Source: AGHT+IHKOCPKu3s041A13bEtoncDmp2WixZ17L2Nt+HwI/r2G+VqGJUcSTODB+X04KR8v+1XfO/+cg==
X-Received: by 2002:a17:902:db03:b0:223:4998:a75e with SMTP id
 d9443c01a7336-223f1c804f7mr19682095ad.3.1741139665323; 
 Tue, 04 Mar 2025 17:54:25 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:24 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/59] target/riscv: Add support for Control Transfer Records
 extension CSRs.
Date: Wed,  5 Mar 2025 11:52:32 +1000
Message-ID: <20250305015307.1463560-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
sctrdepth CSRs handling.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250205-b4-ctr_upstream_v6-v6-3-439d8e06c8ef@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |   5 ++
 target/riscv/cpu_cfg.h |   2 +
 target/riscv/csr.c     | 144 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 986131a191..ae355248f3 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -313,6 +313,11 @@ struct CPUArchState {
     target_ulong mcause;
     target_ulong mtval;  /* since: priv-1.10.0 */
 
+    uint64_t mctrctl;
+    uint32_t sctrdepth;
+    uint32_t sctrstatus;
+    uint64_t vsctrctl;
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index b410b1e603..3f3c1118c0 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -133,6 +133,8 @@ struct RISCVCPUConfig {
     bool ext_zvfhmin;
     bool ext_smaia;
     bool ext_ssaia;
+    bool ext_smctr;
+    bool ext_ssctr;
     bool ext_sscofpmf;
     bool ext_smepmp;
     bool ext_smrnmi;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index dc0a88a0f0..ab295d2ef3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -635,6 +635,48 @@ static RISCVException hgatp(CPURISCVState *env, int csrno)
     return hmode(env, csrno);
 }
 
+/*
+ * M-mode:
+ * Without ext_smctr raise illegal inst excep.
+ * Otherwise everything is accessible to m-mode.
+ *
+ * S-mode:
+ * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
+ * Otherwise everything other than mctrctl is accessible.
+ *
+ * VS-mode:
+ * Without ext_ssctr or mstateen.ctr raise illegal inst excep.
+ * Without hstateen.ctr raise virtual illegal inst excep.
+ * Otherwise allow sctrctl (vsctrctl), sctrstatus, 0x200-0x2ff entry range.
+ * Always raise illegal instruction exception for sctrdepth.
+ */
+static RISCVException ctr_mmode(CPURISCVState *env, int csrno)
+{
+    /* Check if smctr-ext is present */
+    if (riscv_cpu_cfg(env)->ext_smctr) {
+        return RISCV_EXCP_NONE;
+    }
+
+    return RISCV_EXCP_ILLEGAL_INST;
+}
+
+static RISCVException ctr_smode(CPURISCVState *env, int csrno)
+{
+    const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
+
+    if (!cfg->ext_smctr && !cfg->ext_ssctr) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    RISCVException ret = smstateen_acc_ok(env, 0, SMSTATEEN0_CTR);
+    if (ret == RISCV_EXCP_NONE && csrno == CSR_SCTRDEPTH &&
+        env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
+    return ret;
+}
+
 static RISCVException aia_hmode(CPURISCVState *env, int csrno)
 {
     int ret;
@@ -3216,6 +3258,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3255,6 +3301,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -3309,6 +3359,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3348,6 +3402,10 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -4068,6 +4126,86 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t mask = wr_mask & SCTRDEPTH_MASK;
+
+    if (ret_val) {
+        *ret_val = env->sctrdepth;
+    }
+
+    env->sctrdepth = (env->sctrdepth & ~mask) | (new_val & mask);
+
+    /* Correct depth. */
+    if (mask) {
+        uint64_t depth = get_field(env->sctrdepth, SCTRDEPTH_MASK);
+
+        if (depth > SCTRDEPTH_MAX) {
+            depth = SCTRDEPTH_MAX;
+            env->sctrdepth = set_field(env->sctrdepth, SCTRDEPTH_MASK, depth);
+        }
+
+        /* Update sctrstatus.WRPTR with a legal value */
+        depth = 16 << depth;
+        env->sctrstatus =
+            env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
+    }
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
+                                     target_ulong *ret_val,
+                                     target_ulong new_val, target_ulong wr_mask)
+{
+    uint32_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint32_t mask = wr_mask & SCTRSTATUS_MASK;
+
+    if (ret_val) {
+        *ret_val = env->sctrstatus;
+    }
+
+    env->sctrstatus = (env->sctrstatus & ~mask) | (new_val & mask);
+
+    /* Update sctrstatus.WRPTR with a legal value */
+    env->sctrstatus = env->sctrstatus & (~SCTRSTATUS_WRPTR_MASK | (depth - 1));
+
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
+                                    target_ulong *ret_val,
+                                    target_ulong new_val, target_ulong wr_mask)
+{
+    uint64_t csr_mask, mask = wr_mask;
+    uint64_t *ctl_ptr = &env->mctrctl;
+
+    if (csrno == CSR_MCTRCTL) {
+        csr_mask = MCTRCTL_MASK;
+    } else if (csrno == CSR_SCTRCTL && !env->virt_enabled) {
+        csr_mask = SCTRCTL_MASK;
+    } else {
+        /*
+         * This is for csrno == CSR_SCTRCTL and env->virt_enabled == true
+         * or csrno == CSR_VSCTRCTL.
+         */
+        csr_mask = VSCTRCTL_MASK;
+        ctl_ptr = &env->vsctrctl;
+    }
+
+    mask &= csr_mask;
+
+    if (ret_val) {
+        *ret_val = *ctl_ptr & csr_mask;
+    }
+
+    *ctl_ptr = (*ctl_ptr & ~mask) | (new_val & mask);
+
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_vstopi(CPURISCVState *env, int csrno,
                                   target_ulong *val)
 {
@@ -5821,6 +5959,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_TINFO]     =  { "tinfo",    debug, read_tinfo,    write_ignore   },
     [CSR_MCONTEXT]  =  { "mcontext", debug, read_mcontext, write_mcontext },
 
+    [CSR_MCTRCTL]    = { "mctrctl",    ctr_mmode,  NULL, NULL, rmw_xctrctl    },
+    [CSR_SCTRCTL]    = { "sctrctl",    ctr_smode,  NULL, NULL, rmw_xctrctl    },
+    [CSR_VSCTRCTL]   = { "vsctrctl",   ctr_smode,  NULL, NULL, rmw_xctrctl    },
+    [CSR_SCTRDEPTH]  = { "sctrdepth",  ctr_smode,  NULL, NULL, rmw_sctrdepth  },
+    [CSR_SCTRSTATUS] = { "sctrstatus", ctr_smode,  NULL, NULL, rmw_sctrstatus },
+
     /* Performance Counters */
     [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
     [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },
-- 
2.48.1


