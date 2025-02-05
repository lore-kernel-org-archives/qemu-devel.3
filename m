Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3E8C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 11:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfdRa-0004Zc-Hk; Wed, 05 Feb 2025 06:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRO-0004Qi-TN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRM-0003yA-01
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:34 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso46194985e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738754370; x=1739359170;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C/aTpSzWv4DLIdTtUZeXDZ5Nks7CoEIGi+GP/50G3Mk=;
 b=cBZT2FJgcYgEPKbC4/MnCtzfXg9ssjuu/jf1tMBqc+yiyM4Bk2+N+82AHxJy7DvER7
 MFgv9w6L/h/5hiHaUCbNCmFCq0wrYpZkFUVuoRNnKAh5PxuGQcir4WvUFSZ66ggqVzsZ
 GqvcAQxCEDBJT/WjQHW8+oNv8D2vvtLBY25bcRCVAbRjTrYy2NsDqVlALSsYnYuCMkg1
 NHwaqoIyZ3GQYbXaUXUr5uhnND8cn4sKd23GqXliP7JFMhbqLYOuNYHbFbUa4ZMFeTK2
 2e++PM0XttfWOuvydBCZUGyarWm3EKZohuW6JTUfyFNA8mBDSoCslWO/X+Xf+PBtkoPM
 ofBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738754370; x=1739359170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C/aTpSzWv4DLIdTtUZeXDZ5Nks7CoEIGi+GP/50G3Mk=;
 b=hkIAQfDXCWVA6Lnn5OF/4OELlwNWXYU1ZhV76Fj4LGP3Alxs2a0pmWqWuu6pmE+Ogg
 607ZSVnGAQ3SPqC13K1ibVXnoUIIuXAjVuL2eznSfi7Fq44K5tfx2FYnRZ+g4nZfJf5e
 8rNDLyn0SLkeA/3x5yc1wlXPzt+tRjUhAVmrfm4gr1QV0P+P9XO+dli13da8A9UBcfFq
 HM5R/eTFQD/KP6hMBEPrC598NAr4bSYiEOIwGgqSSCsB2jrJOvueulxOFrksYEcIogUX
 TzvvgZgg9Y0aM8hVwqmf51ODbiYxVXo4sQs8P781TDOMvXYsFuBmfuDSDWxpq/8sr/i/
 4cNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf/mU06VphPlMVZdyunm7WwOgfoqH1wUR69Q1Jcg7BT4nNi9VZqz0Pcc7oFAHU/QWr6ygbNvlGtJUs@nongnu.org
X-Gm-Message-State: AOJu0YzPkRywzOj/hdMqOb45/fR8AJQepfjM6nT48B1PHJoz30OgyRFg
 /Wj0Wd5X4KLsIKqctaLQgWbOzrFitfJy+skS5HAtNaZr4kAafJzDXg3+HtH64PA=
X-Gm-Gg: ASbGnctqryhmi9/kfKfnnfkShFpWDLXcoMM/LG48N7xM2CB61/cg6KazyitiTCETeF7
 jyjY3IaYOvqVSTKQpHx8n/MhUqr/FdeCfYxPXBqO01cQvV5qkpSXX8hH5ACdgHpTrVA/tRumnq+
 aWT6Z5D1aK58V6J2YrGkI18O9rzU9V4Y19/rIr8YK1gbBqsUGtJp4EbDDQjPRCDsSFDH+1RxuO9
 UJ1ppLxVzSdRB0GiypGWd74V4pGMoxJP7sgjE2md2Q7xkhCmVTY8fO/Ii/h+cU22U55fwnGGsrx
 P+MW4JtuP7Be2tEkqyQGSY7f9E8=
X-Google-Smtp-Source: AGHT+IFjUbg8Wh6lCrLKX0xZK2kIMHfmXgBk5XjWziSyqO9FJDV0pBYaFqt4VLY8rm1nOPpyVvaQlg==
X-Received: by 2002:a05:600c:5127:b0:438:da66:fdf9 with SMTP id
 5b1f17b1804b1-4390d43f779mr18152275e9.18.1738754369869; 
 Wed, 05 Feb 2025 03:19:29 -0800 (PST)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93382dsm18256575e9.4.2025.02.05.03.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 03:19:29 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v6 3/7] target/riscv: Add support for Control Transfer Records
 extension CSRs.
Date: Wed,  5 Feb 2025 11:18:47 +0000
Message-Id: <20250205-b4-ctr_upstream_v6-v6-3-439d8e06c8ef@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
References: <20250205-b4-ctr_upstream_v6-v6-0-439d8e06c8ef@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x332.google.com
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     |   5 ++
 target/riscv/cpu_cfg.h |   2 +
 target/riscv/csr.c     | 144 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 97713681cbea79745ec1fabc625ebc707fee7eff..e51a4bc4a535276d1b348f9ed50443be898d538f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -312,6 +312,11 @@ struct CPUArchState {
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
index b410b1e603839dcb4091c8167a93473fba4191c1..3f3c1118c08ff66fb9cf1bf77575a4d7257819bf 100644
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
index afb7544f0780be4f1e9c94f26dc10e2be1060c85..07a591fc90a8a516888dd465292f4e4b4178524d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -639,6 +639,48 @@ static RISCVException hgatp(CPURISCVState *env, int csrno)
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
@@ -3234,6 +3276,10 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3273,6 +3319,10 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
         wr_mask |= SMSTATEEN0_P1P13;
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_mstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -3327,6 +3377,10 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
         wr_mask |= (SMSTATEEN0_AIA | SMSTATEEN0_IMSIC);
     }
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateen(env, csrno, wr_mask, new_val);
 }
 
@@ -3366,6 +3420,10 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
+    if (riscv_cpu_cfg(env)->ext_ssctr) {
+        wr_mask |= SMSTATEEN0_CTR;
+    }
+
     return write_hstateenh(env, csrno, wr_mask, new_val);
 }
 
@@ -4086,6 +4144,86 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
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
@@ -5839,6 +5977,12 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
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
2.34.1


