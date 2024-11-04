Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A4DD1CA01
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8511-0007z3-OD; Mon, 04 Nov 2024 16:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t850z-0007xZ-KZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:37 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1t850x-00011v-Ie
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:53:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43161e7bb25so36529365e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730757214; x=1731362014;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8z6Ab+BZTXvK83/PrI7caQyTTgNBxBb4DeqJpSZpkaU=;
 b=cdVuO35M/sOpU7FXkcXJx+qwFO/lZpgLa7Y5pb5ppjNZhvqPVa7/VUVksKwjw5wy92
 9Ax+2rkt4gzMWrhzPKmdi53XwyOmQyTzhspI1i1JlZgY+OlweZ73kOzWfWeGkMtpVq4P
 j2wOAhzvfzLNI7wH/zoTK26R2RdwcbvWNOmALm6i7R5LyD0dMxuPwZjSJlECFkHQxCNe
 DjLItmdSqdfEHyyEEuIEcPUQkocBUZ/gE2YubVIMl2ZsYlgwTcvgtf8lGxAo1XIvR9Ah
 3Cc2gc0N6C69vB8Xlg1lVLixH1U9W3nIEMgEbd9jL/OUW+p9BwFt2XoLpB9sWH1Vo7pX
 JAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730757214; x=1731362014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8z6Ab+BZTXvK83/PrI7caQyTTgNBxBb4DeqJpSZpkaU=;
 b=CTU1Dr1Rp3e9hELVzZZfQJ7FeKu4VZponno0dbdYDob+rVHEt1hUEwMKbDHNJJNjbW
 c2oqO9lVg/5cIcxBr8/JvwioxSf4Ql/wst7ELEllY+Wpvlo2NcQ57kOvt7mj4vGNUeSv
 M6hv1vR8Ggu4x8UKRmYVmqVE593MgSDP4tjg03CmWXm176iUgg04bKsrqHOQVDESluCg
 lqurWoSjON9rt+0t3rOF0FmzbAPOrJW3V7pBpiUVDSGuGpYtIougQetHRY0dcpj7IZob
 X8LiOB04gHP1lnAcUQzwIGoP8olhOv65EaGATCKXvn+gYPG0DpHz5ZyrAIDPJFSKokus
 XUJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnDMhw/oKgpDXcEnWeJcyjq3rcLVR39QL9lmLP3GK9JsssVsdUZ0/EL6MNTvL8wYmU7HCVCwmaLXGa@nongnu.org
X-Gm-Message-State: AOJu0Yz1zUtm2DzLvQ2rhlYDSsOVofuEBDovJMHe/kYSFnSP512k/8o7
 ACptIzXx2SoX68YLjYNdI5jb+zqlK6eIDDGGNTL4NKEL4I7EdPo6ksdwOG7E35Q=
X-Google-Smtp-Source: AGHT+IFtjSqQP8/WY2Dp92GVLIBTG22Di6wD9FbUn+UgVoH3c8uhVE/yvPwVepEWVx3sglPkYrKQ7w==
X-Received: by 2002:a05:600c:4215:b0:431:55af:a230 with SMTP id
 5b1f17b1804b1-431bb9e6031mr183295245e9.33.1730757214135; 
 Mon, 04 Nov 2024 13:53:34 -0800 (PST)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:8a3a:7719:aa26:21cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a26a6da1sm1537595e9.0.2024.11.04.13.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:53:33 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com
Subject: [PATCH v3 3/6] target/riscv: Add support for Control Transfer Records
 extension CSRs.
Date: Mon,  4 Nov 2024 21:51:07 +0000
Message-Id: <20241104-b4-ctr_upstream_v3-v3-3-32fd3c48205f@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
References: <20241104-b4-ctr_upstream_v3-v3-0-32fd3c48205f@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x331.google.com
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
index d775866344f5cc3dda5c4050660a4b87d7444756..0ffe0d5a74aa699fc34453e072bed27001819a5e 100644
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
index b2be3d47c7a35b177b4d6517af9257973bd5d3b0..91625d6a6bea425446f0ce2bd271c951b104136b 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -127,6 +127,8 @@ struct RISCVCPUConfig {
     bool ext_zvfhmin;
     bool ext_smaia;
     bool ext_ssaia;
+    bool ext_smctr;
+    bool ext_ssctr;
     bool ext_sscofpmf;
     bool ext_smepmp;
     bool rvv_ta_all_1s;
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 2369a746a28511c6d7d1214ebabe5af61f4c1a90..0805b8afc05bd8fcd75ed1c1ad669efbb180800d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -632,6 +632,48 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
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
@@ -3096,6 +3138,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3135,6 +3181,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -3189,6 +3239,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3228,6 +3282,10 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -3927,6 +3985,86 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
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
@@ -5903,6 +6041,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


