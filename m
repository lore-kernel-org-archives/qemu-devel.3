Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72518C02187
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJtq-0000Lf-B1; Sat, 18 Jan 2025 20:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtm-0008VC-KT
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:46 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJtj-0003Om-R9
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:14:46 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so4507385a91.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249282; x=1737854082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbQ2GKWxA4aqDx/5bcHhQQIo5ehgVzih+lXxpGtXsbQ=;
 b=mWdShhD4S7nEh1RnBfDiUzSFBmGh0+lhCzAaG52k/tarNhXv/qfFytQ6gMDopvpX0v
 9FfJpssvB3bX2hl+5KCOd6RdGuoGeRRxLa6hW6K2zsdDBEnVtfR239YvF85W1nf6kP76
 +dUeaT6i1MtEh6xKMr4arLwSzTWmX6WaVmfhVy7AV3BGNnMLGK0t+2QhwXsvT8jxC3RX
 hnarqOhuv68MIg52UKlSkj37HBYZYeiR3Bdd2GVaQZD452BbtdYpCld4LtdHDFMej7mw
 UEAzu+hztOrQ+huzgbyHoCzb0R23ntAFG0UzP40rJeAqMzGflbN/63e8rwVo73iuZGcn
 MuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249282; x=1737854082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YbQ2GKWxA4aqDx/5bcHhQQIo5ehgVzih+lXxpGtXsbQ=;
 b=V8SOoRStqByLygwrCmNTbykw234w8pUNkrsxtc3Kk6rltMQOrAQ3sG8Go6qoRuOhne
 TtuksQkNlXSSTuFxlEoenPX9SO1uJ4rToQv6IiRJW/kyNTc70DhuHj4VSSMKPL16vDxM
 +T8NPROSfkFfVQRb83PcA1eHaVkCqg3fGZZJiR6vRFUz+TQvFpG9A0H0YQNVQ2NjZ/f0
 d9wjz78BZ8QkJZ/dsJ1djED1LRx71obAeaZl0YFk6YigCHg239i4KuShJSZiPQfjDm2a
 lLL9OcCegT1W2dnukvNcVIuUHFR1HiVkkhNejW3LlzuJJzpmxHaojeRrbJO1TCwk/J9Z
 4SKg==
X-Gm-Message-State: AOJu0YxkiJuD49ixiemOhhBA+pCz7H0GMe+lagjmugHWArZTn2jMY4po
 jZaePxB2GNLdEKUSchLvzxGPuA/fxHHWUx4UGIk+tYV/M/unNj48VNyVgVQr
X-Gm-Gg: ASbGncs9XMKUy1cOKHSDKSfovkEve3QjEQxCm35A+5VEZMn6lQSp87TC2tlLa+gQ/NK
 vydS4M9P4zTNbrLj+O3CqhngfmlAUM7okn2xZwwOq+dc0OaXq3mJ7+83Mo+2exRvv4sIf/Cw6w/
 eSaOYc7noz9Ikc5+xqLhIesJULKCNq96UX7vOk+LrXsgGC4wG9DMVJftA1+w780mWFnvC091Vhy
 OqeEjGmG+hddYeUmvm5e+feD8GAaiIxSJE4ORvkbFPQqTs3/OI9zLHLwP4WxGscNkjVuX8Qgh44
 O2M/RF8cY4Lt0VFMvMyF/nGnuqKyRFYjdxoIdMifVUWzQnWDaUTDgvueSo8cONvONSdd2I9i6A=
 =
X-Google-Smtp-Source: AGHT+IFj9B3qnqoP3SkXOvdc9ETqBeXe8UrSL1VnvX8k/zEBv9q9dO41pq52zYcwN/4qzji3al4KZw==
X-Received: by 2002:a17:90a:c888:b0:2ee:f687:6ad5 with SMTP id
 98e67ed59e1d1-2f782c5174emr12530066a91.2.1737249282054; 
 Sat, 18 Jan 2025 17:14:42 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:14:41 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Kaiwen Xue <kaiwenx@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 35/50] target/riscv: Add counter delegation/configuration
 support
Date: Sun, 19 Jan 2025 11:12:10 +1000
Message-ID: <20250119011225.11452-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

The Smcdeleg/Ssccfg adds the support for counter delegation via
S*indcsr and Ssccfg.

It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
to enable this extension and scountovf virtualization.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Co-developed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
Message-ID: <20250110-counter_delegation-v5-8-e83d797ae294@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 304 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 292 insertions(+), 12 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index df748dffa3..eddcf5a5d0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -383,6 +383,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
     return smode32(env, csrno);
 }
 
+static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_ssccfg || !cpu->cfg.ext_smcdeleg) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    if (env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
+    return smode(env, csrno);
+}
+
 static bool csrind_extensions_present(CPURISCVState *env)
 {
     return riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind;
@@ -1224,10 +1239,9 @@ done:
     return result;
 }
 
-static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
-                                        target_ulong val)
+static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
+                                          uint32_t ctr_idx)
 {
-    int ctr_idx = csrno - CSR_MCYCLE;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = val;
 
@@ -1252,10 +1266,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
-                                         target_ulong val)
+static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
+                                          uint32_t ctr_idx)
 {
-    int ctr_idx = csrno - CSR_MCYCLEH;
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
     uint64_t mhpmctr_val = counter->mhpmcounter_val;
     uint64_t mhpmctrh_val = val;
@@ -1277,6 +1290,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_idx = csrno - CSR_MCYCLE;
+
+    return riscv_pmu_write_ctr(env, val, ctr_idx);
+}
+
+static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_idx = csrno - CSR_MCYCLEH;
+
+    return riscv_pmu_write_ctrh(env, val, ctr_idx);
+}
+
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
                                          bool upper_half, uint32_t ctr_idx)
 {
@@ -1342,6 +1369,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
     return riscv_pmu_read_ctr(env, val, true, ctr_index);
 }
 
+static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
+                              target_ulong *val, target_ulong new_val,
+                              target_ulong wr_mask)
+{
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        riscv_pmu_read_ctr(env, val, false, ctr_idx);
+    } else if (wr_mask) {
+        riscv_pmu_write_ctr(env, new_val, ctr_idx);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
+                               target_ulong *val, target_ulong new_val,
+                               target_ulong wr_mask)
+{
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        riscv_pmu_read_ctr(env, val, true, ctr_idx);
+    } else if (wr_mask) {
+        riscv_pmu_write_ctrh(env, new_val, ctr_idx);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
+                            target_ulong *val, target_ulong new_val,
+                            target_ulong wr_mask)
+{
+    uint64_t mhpmevt_val = new_val;
+
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        *val = env->mhpmevent_val[evt_index];
+        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
+            *val &= ~MHPMEVENT_BIT_MINH;
+        }
+    } else if (wr_mask) {
+        wr_mask &= ~MHPMEVENT_BIT_MINH;
+        mhpmevt_val = (new_val & wr_mask) |
+                      (env->mhpmevent_val[evt_index] & ~wr_mask);
+        if (riscv_cpu_mxl(env) == MXL_RV32) {
+            mhpmevt_val = mhpmevt_val |
+                          ((uint64_t)env->mhpmeventh_val[evt_index] << 32);
+        }
+        env->mhpmevent_val[evt_index] = mhpmevt_val;
+        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
+                             target_ulong *val, target_ulong new_val,
+                             target_ulong wr_mask)
+{
+    uint64_t mhpmevth_val;
+    uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
+
+    if (wr_mask != 0 && wr_mask != -1) {
+        return -EINVAL;
+    }
+
+    if (!wr_mask && val) {
+        *val = env->mhpmeventh_val[evt_index];
+        if (riscv_cpu_cfg(env)->ext_sscofpmf) {
+            *val &= ~MHPMEVENTH_BIT_MINH;
+        }
+    } else if (wr_mask) {
+        wr_mask &= ~MHPMEVENTH_BIT_MINH;
+        env->mhpmeventh_val[evt_index] =
+            (new_val & wr_mask) | (env->mhpmeventh_val[evt_index] & ~wr_mask);
+        mhpmevth_val = env->mhpmeventh_val[evt_index];
+        mhpmevt_val = mhpmevt_val | (mhpmevth_val << 32);
+        riscv_pmu_update_event_map(env, mhpmevt_val, evt_index);
+    } else {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
+                            target_ulong new_val, target_ulong wr_mask)
+{
+    switch (cfg_index) {
+    case 0:             /* CYCLECFG */
+        if (wr_mask) {
+            wr_mask &= ~MCYCLECFG_BIT_MINH;
+            env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
+        } else {
+            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
+        }
+        break;
+    case 2:             /* INSTRETCFG */
+        if (wr_mask) {
+            wr_mask &= ~MINSTRETCFG_BIT_MINH;
+            env->minstretcfg = (new_val & wr_mask) |
+                               (env->minstretcfg & ~wr_mask);
+        } else {
+            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
+                            target_ulong new_val, target_ulong wr_mask)
+{
+
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    switch (cfg_index) {
+    case 0:         /* CYCLECFGH */
+        if (wr_mask) {
+            wr_mask &= ~MCYCLECFGH_BIT_MINH;
+            env->mcyclecfgh = (new_val & wr_mask) |
+                              (env->mcyclecfgh & ~wr_mask);
+        } else {
+            *val = env->mcyclecfgh;
+        }
+        break;
+    case 2:          /* INSTRETCFGH */
+        if (wr_mask) {
+            wr_mask &= ~MINSTRETCFGH_BIT_MINH;
+            env->minstretcfgh = (new_val & wr_mask) |
+                                (env->minstretcfgh & ~wr_mask);
+        } else {
+            *val = env->minstretcfgh;
+        }
+        break;
+    default:
+        return -EINVAL;
+    }
+    return 0;
+}
+
+
 static RISCVException read_scountovf(CPURISCVState *env, int csrno,
                                      target_ulong *val)
 {
@@ -1351,6 +1539,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
     target_ulong *mhpm_evt_val;
     uint64_t of_bit_mask;
 
+    /* Virtualize scountovf for counter delegation */
+    if (riscv_cpu_cfg(env)->ext_sscofpmf &&
+        riscv_cpu_cfg(env)->ext_ssccfg &&
+        get_field(env->menvcfg, MENVCFG_CDE) &&
+        env->virt_enabled) {
+        return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
+    }
+
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         mhpm_evt_val = env->mhpmeventh_val;
         of_bit_mask = MHPMEVENTH_BIT_OF;
@@ -2293,11 +2489,72 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
                         target_ulong isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
-    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
-        return RISCV_EXCP_ILLEGAL_INST;
+    int ret = -EINVAL;
+    int ctr_index = isel - ISELECT_CD_FIRST;
+    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
+        ret = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
     }
-    /* TODO: Implement the functionality later */
-    return RISCV_EXCP_NONE;
+
+    /* Invalid siselect value for reserved */
+    if (ctr_index == 1) {
+        goto done;
+    }
+
+    /* sireg4 and sireg5 provides access RV32 only CSRs */
+    if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
+        (riscv_cpu_mxl(env) != MXL_RV32)) {
+        ret = RISCV_EXCP_ILLEGAL_INST;
+        goto done;
+    }
+
+    /* Check Sscofpmf dependancy */
+    if (!riscv_cpu_cfg(env)->ext_sscofpmf && csrno == CSR_SIREG5 &&
+        (isel_hpm_start <= isel && isel <= ISELECT_CD_LAST)) {
+        goto done;
+    }
+
+    /* Check smcntrpmf dependancy */
+    if (!riscv_cpu_cfg(env)->ext_smcntrpmf &&
+        (csrno == CSR_SIREG2 || csrno == CSR_SIREG5) &&
+        (ISELECT_CD_FIRST <= isel && isel < isel_hpm_start)) {
+        goto done;
+    }
+
+    if (!get_field(env->mcounteren, BIT(ctr_index)) ||
+        !get_field(env->menvcfg, MENVCFG_CDE)) {
+        goto done;
+    }
+
+    switch (csrno) {
+    case CSR_SIREG:
+        ret = rmw_cd_mhpmcounter(env, ctr_index, val, new_val, wr_mask);
+        break;
+    case CSR_SIREG4:
+        ret = rmw_cd_mhpmcounterh(env, ctr_index, val, new_val, wr_mask);
+        break;
+    case CSR_SIREG2:
+        if (ctr_index <= 2) {
+            ret = rmw_cd_ctr_cfg(env, ctr_index, val, new_val, wr_mask);
+        } else {
+            ret = rmw_cd_mhpmevent(env, ctr_index, val, new_val, wr_mask);
+        }
+        break;
+    case CSR_SIREG5:
+        if (ctr_index <= 2) {
+            ret = rmw_cd_ctr_cfgh(env, ctr_index, val, new_val, wr_mask);
+        } else {
+            ret = rmw_cd_mhpmeventh(env, ctr_index, val, new_val, wr_mask);
+        }
+        break;
+    default:
+        goto done;
+    }
+
+done:
+    return ret;
 }
 
 /*
@@ -2576,6 +2833,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
+                                         target_ulong *val)
+{
+    /* S-mode can only access the bits delegated by M-mode */
+    *val = env->mcountinhibit & env->mcounteren;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
+                                          target_ulong val)
+{
+    write_mcountinhibit(env, csrno, val & env->mcounteren);
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
@@ -2678,11 +2950,13 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
                                     target_ulong val)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
-    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE | MENVCFG_CBZE;
+    uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
+                    MENVCFG_CBZE | MENVCFG_CDE;
 
     if (riscv_cpu_mxl(env) == MXL_RV64) {
         mask |= (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                 (cfg->ext_sstc ? MENVCFG_STCE : 0) |
+                (cfg->ext_smcdeleg ? MENVCFG_CDE : 0) |
                 (cfg->ext_svadu ? MENVCFG_ADUE : 0);
 
         if (env_archcpu(env)->cfg.ext_zicfilp) {
@@ -2717,7 +2991,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -5304,6 +5579,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MNSTATUS]  = { "mnstatus",  rnmi, read_mnstatus,  write_mnstatus,
                         .min_priv_ver = PRIV_VERSION_1_12_0               },
 
+    /* Supervisor Counter Delegation */
+    [CSR_SCOUNTINHIBIT] = {"scountinhibit", scountinhibit_pred,
+                            read_scountinhibit, write_scountinhibit,
+                           .min_priv_ver = PRIV_VERSION_1_12_0 },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },
-- 
2.48.1


