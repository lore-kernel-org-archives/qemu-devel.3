Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F0ED10F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 01:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCqO8-000189-LY; Sun, 17 Nov 2024 20:17:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqO4-00015X-6Y
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:08 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1tCqNz-0006Ry-PV
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 20:17:07 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e5130832aso952746b3a.0
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 17:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731892622; x=1732497422;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YwWO3LkqyibBtoGrM2uA0XmGS2zmaeowHD5KNwu4so8=;
 b=dP/Nm4qDXBRKo8CRm3BLYprktOQhEV8YyD/CEml8C4TR1cbC/BbCL9DPLNVvaWt7rZ
 O+dA4pdVQUgMuZnhNrrG7O9p8ZhOdLcqZMES4515A/a5Tdyf/T15D9h+6xzjxsrURAwr
 Ijd4I/T6uahAm7nyHy2CaGXN8bGk7pUha6Lv+o3LpKf4fX/UiFaASr7C4S6Q6PyyQR49
 LJ7R5a9KJqfyXHsY4W2RPkRN5AArFMg0GB8odiVQvH2nefqQOMgetV3j+aQGeaAFPoKS
 Dysc15AlXaiF4513aqB6lXV753BIRe63P8PwRsY2HqpRRfNzHZ5kcUPWDdbO4QR4OIdj
 lbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731892622; x=1732497422;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwWO3LkqyibBtoGrM2uA0XmGS2zmaeowHD5KNwu4so8=;
 b=flNrUViy9jssbZRMrB2wWxyIlMEPNgnZk32V8uwP2ZQvz/mT5/OiXjR6creWv7SD/g
 NaBInWH7+pbSNA+/nXJJSlSQ25ssLCS8TapzoloC57XOWpcD+lsz62uvIrPiqsEXZoZh
 Iy0iHYIU+aLh7yINRIsc+UcaCd6S0C6zW/djTT9T5uQOuQDO51kM/jbrH2rATdxK2J2A
 gL1wnQ8XsPE9x32XY5RxVrC3UNpnU3KMYxBUSgRYCGfzuXnxBZGeM3iII4HnTD90pAMu
 dZPsPdqiW/wyZhIJ8sztJYjqECzrB55q9KR7kyhlhqnfEXKivFLuDv3uwTbOFWEAu2Fn
 d4RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgGR8zFxpbjqk3E66HEhQdMcO/ITrLPgB3626czCf1ZHPNDrZ+ACojX4Jb2AOKlrjZupkV6Ok4nuJS@nongnu.org
X-Gm-Message-State: AOJu0YyY7ecO6Lrqeu7wRqqJAYbZOdq1ocGSwocBHHUNn7KLBxrUT/MU
 yYtNvylVsjxSx11xsoAhDw5p0v7k0lTf68X7CymaWo4DsIoTYCufKLeF5IUuBuCs4E0gYmEc6oW
 R
X-Google-Smtp-Source: AGHT+IFbGTjlmlL16tMAhD7lYdL7z+zfhYpbO8d3QJI91jQft+GJQt2Fye88FhdHm9peXKdbXUTIRg==
X-Received: by 2002:a05:6a00:194d:b0:71e:4ba:f389 with SMTP id
 d2e1a72fcca58-72476b98496mr14475210b3a.10.1731892622010; 
 Sun, 17 Nov 2024 17:17:02 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e8b75sm5134024b3a.147.2024.11.17.17.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 17:17:01 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Sun, 17 Nov 2024 17:15:56 -0800
Subject: [PATCH v3 08/11] target/riscv: Add counter
 delegation/configuration support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241117-counter_delegation-v3-8-476d6f36e3c8@rivosinc.com>
References: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
In-Reply-To: <20241117-counter_delegation-v3-0-476d6f36e3c8@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: kaiwenxue1@gmail.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com, 
 Kaiwen Xue <kaiwenx@rivosinc.com>
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Kaiwen Xue <kaiwenx@rivosinc.com>

The Smcdeleg/Ssccfg adds the support for counter delegation via
S*indcsr and Ssccfg.

It also adds a new shadow CSR scountinhibit and menvcfg enable bit (CDE)
to enable this extension and scountovf virtualization.

Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
Co-developed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 300 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 289 insertions(+), 11 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 97cc8059ad37..31ea8b8ec20d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -385,6 +385,21 @@ static RISCVException aia_smode32(CPURISCVState *env, int csrno)
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
@@ -1222,10 +1237,9 @@ done:
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
 
@@ -1250,10 +1264,9 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
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
@@ -1275,6 +1288,20 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
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
@@ -1340,6 +1367,167 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
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
@@ -1349,6 +1537,14 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
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
@@ -2292,11 +2488,70 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
                         target_ulong isel, target_ulong *val,
                         target_ulong new_val, target_ulong wr_mask)
 {
-    if (!riscv_cpu_cfg(env)->ext_smcdeleg) {
+    int ret = -EINVAL;
+    int ctr_index = isel - ISELECT_CD_FIRST;
+    int isel_hpm_start = ISELECT_CD_FIRST + 3;
+
+    if (!riscv_cpu_cfg(env)->ext_smcdeleg || !riscv_cpu_cfg(env)->ext_ssccfg) {
         return RISCV_EXCP_ILLEGAL_INST;
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
+        return RISCV_EXCP_ILLEGAL_INST;
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
@@ -2578,6 +2833,21 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
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
@@ -2680,11 +2950,13 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
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
@@ -2713,7 +2985,8 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
                     (cfg->ext_sstc ? MENVCFG_STCE : 0) |
-                    (cfg->ext_svadu ? MENVCFG_ADUE : 0);
+                    (cfg->ext_svadu ? MENVCFG_ADUE : 0) |
+                    (cfg->ext_smcdeleg ? MENVCFG_CDE : 0);
     uint64_t valh = (uint64_t)val << 32;
 
     env->menvcfg = (env->menvcfg & ~mask) | (valh & mask);
@@ -5498,6 +5771,11 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
                         write_sstateen_1_3,
                         .min_priv_ver = PRIV_VERSION_1_12_0 },
 
+    /* Supervisor Counter Delegation */
+    [CSR_SCOUNTINHIBIT] = {"scountinhibit", scountinhibit_pred,
+                            read_scountinhibit, write_scountinhibit,
+                           .min_priv_ver = PRIV_VERSION_1_12_0 },
+
     /* Supervisor Trap Setup */
     [CSR_SSTATUS]    = { "sstatus",    smode, read_sstatus,    write_sstatus,
                          NULL,                read_sstatus_i128              },

-- 
2.34.1


