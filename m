Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F4FE7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoxF-0008BZ-Ot; Wed, 04 Dec 2024 07:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIows-000808-EQ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:52 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIowo-0008Ag-Aw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:44 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434aa222d96so82331165e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317061; x=1733921861;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFBSeg/00KOb1P9GKLTrphr5EfKkf3HOkFUqzsFQb00=;
 b=MGpaBX/829Nc2mS19SM2XuDXXxf+hwoCv6kN93+YzDnrMZV4On/xYIJU/jPT2HzjVO
 CJandalG+dx7bgEVkHvzQcRX7pP/64qQozvpw/9eE1UanQoXjdGkpuBDZ0q+mFkfQY09
 c8rFVHMMhgqwy4L46RdG/mx97hvyrMTai+Wr7RI4QlVDOwOYxtcuBfvnLzc3XVd+k4kS
 NRCBiJdpIf1SPEsO8BxIaiGEom0tLAi5x/IdbgLz9fCMuKFBdEkXKk16bsRKTq7Woonk
 oeBB+MOKLIkXz5Y1vwtRlOVYkw6iLZ3VPLRX/IXSD2pH5GUCpxzYAG86sv6zaz+QY6sD
 kWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317061; x=1733921861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HFBSeg/00KOb1P9GKLTrphr5EfKkf3HOkFUqzsFQb00=;
 b=Vb082YL+PRIXnbOan9BAtB5cg/YendoM4Eud6t6/V0z2Li8L1Zf/czHny23ryN+aoL
 bRCmfNfue07ld3QFAPP2/+SHtfyiSh1zCsrTImKgLOzkHOrhTnrWK1CKBnZVxDr/05bN
 zKs7iKu+w19fe4H6ussJLJHoG+5H5IY9evrrhbgy9fgU8ZgUnY+9RQfS0BvmBgjQm2fQ
 gyz9KfTiKl/gWwViCey440gJutOLUcKKdAtQJ7SMi7Q3I1j/JVGGOOjjmYzzQ2xybKeQ
 SnKfRKvFVFZgPNp0SGTzP/h0tyfsm5s8PN6oDmOf7A91jbrtudgOQDbUhBSYkptCvbjQ
 iPLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPl9qoer82n40T9gCfzaxuV/lQtlYkAwPmfx/lfGesSkuuH3USHJPokTgB6ZR+CFshGHZyVA/OAojK@nongnu.org
X-Gm-Message-State: AOJu0Ywrs+xI1oXAAayjkLqjvNQ+tfQToNd+dqM/8xHKhm4mnvHIkbKH
 LssJ8QcCIo4haLpZw9SdTQQWUOuf4Z0DIgjN+/6I0kZ/M5XYG2kSf4G1xhjLx8A=
X-Gm-Gg: ASbGncs++05RKGPubW4+dhtq2lTFKavwDZO8I/9f1Rj/mLy9v6L/HkC9JnVRY57N3CG
 FzqG9gD+V0jbroiP99yTjniuq490NUh3R8eFcrW/bpSleerNcrPtqpe5gIFEe8KzC24ooclU7Ww
 Ha3+S1JcZvncwV5jAChbI0jwMeJuSWPMNHJWadRamAOCgOK+/alr9IvMchPLI2ND8QxOYQJMgYH
 fH5J3O7lTRAyr8EZqheMSrgZFqVJlnJlxMqgVHChJoWCTp8EeK0mmau4OgA5h5jCdfsmAmQ9O0C
 m8uV+g==
X-Google-Smtp-Source: AGHT+IGtCkJHHKwuxrbOYd7h8pASExTS/9+yJbRakiBxDEaDD4p2tXg9Tfoxh/YnuHegzdJ+ns/kbw==
X-Received: by 2002:a05:600c:3ca7:b0:434:a923:9321 with SMTP id
 5b1f17b1804b1-434d09b2e5emr61006995e9.5.1733317060605; 
 Wed, 04 Dec 2024 04:57:40 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:40 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 3/7] target/riscv: Add support for Control Transfer Records
 extension CSRs.
Date: Wed,  4 Dec 2024 17:56:41 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-3-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x330.google.com
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

This commit adds support for [m|s|vs]ctrcontrol, sctrstatus and
sctrdepth CSRs handling.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h     |   5 ++
 target/riscv/cpu_cfg.h |   2 +
 target/riscv/csr.c     | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 903268626374474306f0e0259f37128326b354d4..da14ac2f874b81d3f01bc31b0064d020f2dbdf61 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -305,6 +305,11 @@ struct CPUArchState {
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
index ae2b019703fe4849eb7f264b4d90743d4c013b86..e365a368d71a695b1b99c3b6ae330347143d3422 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -130,6 +130,8 @@ struct RISCVCPUConfig {
     bool ext_zvfhmin;
     bool ext_smaia;
     bool ext_ssaia;
+    bool ext_smctr;
+    bool ext_ssctr;
     bool ext_sscofpmf;
     bool ext_smepmp;
     bool rvv_ta_all_1s;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 31ea8b8ec20db5a5af23e829757cccaafc02e2da..7e03065d3dcd8713e2cadae3017ed355c9f9bf10 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -651,6 +651,48 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
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
@@ -3160,6 +3202,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3199,6 +3245,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -3253,6 +3303,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3292,6 +3346,10 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -4005,6 +4063,86 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
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
@@ -5984,6 +6122,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase,
                          write_spmbase                                      },
 
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
2.34.1


