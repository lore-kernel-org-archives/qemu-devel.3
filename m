Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535F4E77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJA82-0006cL-Sh; Thu, 05 Dec 2024 06:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJA7w-0006bb-7l
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:34:37 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tJA7t-0001U5-Jv
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:34:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so8142915e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733398472; x=1734003272;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpBDROYFz8JZ2MY3ZnkjJVSeL44Q6BM4U22xgtuG+Qs=;
 b=GWG1XBioqo+mgnhOwMScFHO9tzOzS5gJE3rKfP7oDfUxWWeAUWwXgrxDw9peg4h9ZI
 +NjPEnVcvoFMUVK6EMLMJmJ2tbznJLrBG1Ml/mS/+c78GmcQKq45xLkMe2HxuBhIngAc
 OJ5H78jLRExXQjJTpeXB81pYTf4dgYWQE5CwvpVaea3TcFWGtl6OH22KXhB32ZKqdiFE
 jEML0bmNZ0wtJ8K+/xfACEVRIqENm3no+4d3Hxe2lfxVLyzNzWn58zpxOZsyKOSYvmwD
 x3wMk1K5mYVJurCtEOxe23PRHup7FnWCRAK9ZucWOFXuJkeTpHcsPOMJRHGCCKUOcdCz
 ejXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733398472; x=1734003272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpBDROYFz8JZ2MY3ZnkjJVSeL44Q6BM4U22xgtuG+Qs=;
 b=OH7+efo/1anqtmNvia/BUWirSitKd7RIYLZ9hsvZb8cl6gAZ40oJKUGAYZZhQUa/UZ
 iAf+Qh2GTiMo9S8rk6yKy4bn9r/jFM5X9xdmuV9HK7lNRnzkeB1XraWYnmDNo1OFwU4L
 bGyUKxRQ9EartNJ8aFgvIL43O3/6WWV9Dw07mt51Xe2gsLK/ezjciYPLRK6JuK4Z+xAm
 dGM9jPWclqu5EMWZrp9G3gfpqzEOuRVEHC/6LmXXKzAOxv1MKLo6hXVV02ZBgl2TktSK
 Kd9Z1hooLpXZsXSppLC/9iAcK8U9kqqGaw4PSDSolawTWedEt5Z22B7cpYjmrHOEpqHa
 ItZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBjvPYJbbbA30JJvZNxuzzIP146Az4DdV2RGyEamr0sdD5Q2yGsK2bEPUNIM0kreKQfH9umBS/Smpz@nongnu.org
X-Gm-Message-State: AOJu0YyriY7nnlBof260j0pfBIiodlfRyPKIM9ztic3cdJNxl1JeN5Q9
 D/Bkwt5zKeBGZ708bRY+sYlZbVPoI3nAMHPWXAOuS7s+MDv/peIzj88+l/luUyc=
X-Gm-Gg: ASbGncvt4gbaueE+QTNXZQf4bv/dv5tScGarEGXs554JUg+C5AGbyl9+5LI6tPBK1nW
 riH0hPTHq7cAKJyyswm1KMN9GWWtjZgtjgyAzUb40ZS2PszDWKuNW58HB8Sf7G6gyPwoOmIUdVP
 0tdnQvu5wqJL1J6L48pyvZUYhzloiNDvTibpWXUB3P3HuxVJ4YSoLVoGzjmi/bncfF4udP6T1sR
 qA+AmU8NMxqhShbUU8RoBy4Le3F4tcm/4aS0J0BZ3HZYWLaZbFuf8RVfJtFLelmRl1hkNdS/GDp
 nVhX+Q==
X-Google-Smtp-Source: AGHT+IHVRIu/kf3M4n3AkkvBjSPlPZP9+/Gqd9e+YlLhRPIRHh8mIl7V+ogHpz73J7/5QLbL1dozsQ==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-434d0a07e76mr77573235e9.20.1733398471685; 
 Thu, 05 Dec 2024 03:34:31 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d527395csm57943255e9.17.2024.12.05.03.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 03:34:31 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org
Subject: [PATCH v5 3/7] target/riscv: Add support for Control Transfer Records
 extension CSRs.
Date: Thu,  5 Dec 2024 16:34:08 +0500
Message-Id: <20241205-b4-ctr_upstream_v3-v5-3-60b993aa567d@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
References: <20241205-b4-ctr_upstream_v3-v5-0-60b993aa567d@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x32d.google.com
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
index a77b6ed4c9f35fe25f0901c290cac8a666a48c27..a399d55740c7259cd1c1d893687541e23ea3ce52 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -649,6 +649,48 @@ static RISCVException pointer_masking(CPURISCVState *env, int csrno)
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
@@ -3157,6 +3199,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3196,6 +3242,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -3250,6 +3300,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3289,6 +3343,10 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -4002,6 +4060,86 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
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
@@ -5981,6 +6119,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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


