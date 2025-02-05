Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97481C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 11:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfdRV-0004UQ-DR; Wed, 05 Feb 2025 06:19:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRS-0004Sw-LE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:38 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tfdRO-0003zE-Qd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 06:19:38 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361c705434so49185785e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 03:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738754373; x=1739359173;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P94eG0VOuEPk8R4fjGcXAJQJgEEmsouLFxymCXAgKiA=;
 b=lcTeDQa4JzTHEwWWxtcKbDyL1bjnhjN7ikKBtjBHM2TVpsY9OCN0MRhHpGCsTBmUbq
 bVVjA9odVil43QKleyynfOC7OfQn7laXohT/c8Fh6dB7ynAwYk+qpIXPeVOuj90wCI64
 xcBynmF3OXf+zPi7nS4EpCxFXcEeTVr4QUU6ziwuGl9OyOVxJtPXW3+8bBruHvPu1QM7
 Y4rTaVsB/qowM6iNJ8Y79EtAWpa6TiDXZULB5jAMdO7zsICOAzyeULQvLIxvNR88zcZa
 WLh8ojGXfM5FthmbQyxKIiJxbUKTFYCDbaOr83Rr/j0j8HyKgkPbUKp0ZFug++XujSQc
 FcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738754373; x=1739359173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P94eG0VOuEPk8R4fjGcXAJQJgEEmsouLFxymCXAgKiA=;
 b=Wjv4SqtkB0wdtkLd2B2eSMnFjEpM5aP0HMbL79/tnU5n++QDJoRU4FpWuxReXNx+tn
 zcR4BmdER4/r1befwfWxI/4vTiOuUvPCuwBj7831xgDcew74FQIoQbFjo6GaHDe/h0aI
 RbKePuDdjZaCKMQNIsVOmS5wvSthTJ833YAoh0jQyyW2H7JXSIRKk8LAqlPIQOFBUNhk
 mrw86YozmxkIJCDJb3qE9sWpjwf5wFtk9PHLVTsiAU8+q936e+D/eDld2woFZYFo0bT6
 cajydxSa35NaoCtVT+ZelQ1FIIuaTvTcVT/bvkFEx/azoUjPNnrC1KU5dvs1j2mQUXWy
 itnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwRHIgrO5bDAnQF21EtYjH7AdyQN/1SheVvZCgJdytOdewbspDi3xpMVS6VxiDpgh2Mb4QM3Ek+znR@nongnu.org
X-Gm-Message-State: AOJu0YxgI6Qg9sfSPrsKK6S64fWX1TLrNAN5zgCnXkzRvwS0l2rxuQ6P
 lErJe5yXSNwTRBogpVLFLrU4nGtTTIXmtZSglHYdSgIGEpJ9JBcwKF286Gn1vkbWC2UO+0J6txa
 i
X-Gm-Gg: ASbGncsJvWwRzMCHPc9PHOD7qHTg4ZyR9WJSlRxwV62eTgwtSSrs1DbWF4OMifCd9vE
 mnI1Y+OlEWOuttpMzfgFXbu2E8IecawJ0xclv2VUGcba84jHvkdKH6zFb2H627YHofCTQ1B4YOY
 k1dT4CArFM5Y0tOShIEXP+35yqulniPfbTKRKD0AELXzp0DHlKiZBO5vltMHUBNqp4tr1sxJweq
 UrNG9dow8EMu/uMrutUPE+5/5z52iiQZ/e+0tNKNXuQY5aFa/0mqkJZajjMob2OqwBXKB8NjpqI
 ZLCzjp3guJwxpu1Iv1bMTPFddgo=
X-Google-Smtp-Source: AGHT+IHChnHaIDS2LRdgOzwuDm1BRVo1OONl+v7zCQ0cLmnnZBXN4oT20z79gfp3DgVLzRgjUGmIuQ==
X-Received: by 2002:a05:600c:3c8e:b0:436:f3f6:9582 with SMTP id
 5b1f17b1804b1-4390d433bbamr15770985e9.8.1738754373219; 
 Wed, 05 Feb 2025 03:19:33 -0800 (PST)
Received: from localhost.localdomain ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d93382dsm18256575e9.4.2025.02.05.03.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 03:19:32 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v6 7/7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
Date: Wed,  5 Feb 2025 11:18:51 +0000
Message-Id: <20250205-b4-ctr_upstream_v6-v6-7-439d8e06c8ef@rivosinc.com>
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

CTR entries are accessed using ctrsource, ctrtarget and ctrdata
registers using smcsrind/sscsrind extension. This commits extends
the csrind extension to support CTR registers.

ctrsource is accessible through xireg CSR, ctrtarget is accessible
through xireg1 and ctrdata is accessible through xireg2 CSR.

CTR supports maximum depth of 256 entries which are accessed using
xiselect range 0x200 to 0x2ff.

This commits also adds properties to enable CTR extension. CTR can be
enabled using smctr=true and ssctr=true now.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  26 +++++++-
 target/riscv/csr.c         | 150 ++++++++++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |  11 ++++
 3 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3d4bd157d2cc56ca67eac10a7b62089ea8252b7d..b37769567e88b0221733ef180d9559119c1ecba4 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -215,6 +215,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1598,6 +1600,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
+    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
@@ -2803,6 +2807,26 @@ static RISCVCPUImpliedExtsRule SSPM_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule SMCTR_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_smctr),
+    .implied_misa_exts = RVS,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_sscsrind),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
+static RISCVCPUImpliedExtsRule SSCTR_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_ssctr),
+    .implied_misa_exts = RVS,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_sscsrind),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
     &RVM_IMPLIED, &RVV_IMPLIED, NULL
@@ -2821,7 +2845,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-    &SUPM_IMPLIED, &SSPM_IMPLIED,
+    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
 };
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 07a591fc90a8a516888dd465292f4e4b4178524d..e2754ac7778a28dc38307da7bb6726ea3025cb4d 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2431,6 +2431,13 @@ static bool xiselect_cd_range(target_ulong isel)
     return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
 }
 
+static bool xiselect_ctr_range(int csrno, target_ulong isel)
+{
+    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
+    return CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST &&
+           csrno < CSR_MIREG;
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2476,6 +2483,124 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
+static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
+                          target_ulong new_val, target_ulong wr_mask)
+{
+    /*
+     * CTR arrays are treated as circular buffers and TOS always points to next
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
+     * 0 is always the latest one, traversal is a bit different here. See the
+     * below example.
+     *
+     * Depth = 16.
+     *
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+     * TOS                                 H
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
+     */
+    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
+    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint64_t idx;
+
+    /* Entry greater than depth-1 is read-only zero */
+    if (entry >= depth) {
+        if (val) {
+            *val = 0;
+        }
+        return 0;
+    }
+
+    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+    idx = (idx - entry - 1) & (depth - 1);
+
+    if (val) {
+        *val = env->ctr_src[idx];
+    }
+
+    env->ctr_src[idx] = (env->ctr_src[idx] & ~wr_mask) | (new_val & wr_mask);
+
+    return 0;
+}
+
+static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
+                          target_ulong new_val, target_ulong wr_mask)
+{
+    /*
+     * CTR arrays are treated as circular buffers and TOS always points to next
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
+     * 0 is always the latest one, traversal is a bit different here. See the
+     * below example.
+     *
+     * Depth = 16.
+     *
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+     * head                                H
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
+     */
+    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
+    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint64_t idx;
+
+    /* Entry greater than depth-1 is read-only zero */
+    if (entry >= depth) {
+        if (val) {
+            *val = 0;
+        }
+        return 0;
+    }
+
+    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+    idx = (idx - entry - 1) & (depth - 1);
+
+    if (val) {
+        *val = env->ctr_dst[idx];
+    }
+
+    env->ctr_dst[idx] = (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr_mask);
+
+    return 0;
+}
+
+static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    /*
+     * CTR arrays are treated as circular buffers and TOS always points to next
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
+     * 0 is always the latest one, traversal is a bit different here. See the
+     * below example.
+     *
+     * Depth = 16.
+     *
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+     * head                                H
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
+     */
+    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
+    const uint64_t mask = wr_mask & CTRDATA_MASK;
+    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    uint64_t idx;
+
+    /* Entry greater than depth-1 is read-only zero */
+    if (entry >= depth) {
+        if (val) {
+            *val = 0;
+        }
+        return 0;
+    }
+
+    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+    idx = (idx - entry - 1) & (depth - 1);
+
+    if (val) {
+        *val = env->ctr_data[idx];
+    }
+
+    env->ctr_data[idx] = (env->ctr_data[idx] & ~mask) | (new_val & mask);
+
+    return 0;
+}
+
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
                          target_ulong isel, target_ulong *val,
                          target_ulong new_val, target_ulong wr_mask)
@@ -2628,6 +2753,27 @@ done:
     return ret;
 }
 
+static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
+        return -EINVAL;
+    }
+
+    if (csrno == CSR_SIREG || csrno == CSR_VSIREG) {
+        return rmw_ctrsource(env, isel, val, new_val, wr_mask);
+    } else if (csrno == CSR_SIREG2 || csrno == CSR_VSIREG2) {
+        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);
+    } else if (csrno == CSR_SIREG3 || csrno == CSR_VSIREG3) {
+        return rmw_ctrdata(env, isel, val, new_val, wr_mask);
+    } else if (val) {
+        *val = 0;
+    }
+
+    return 0;
+}
+
 /*
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2639,11 +2785,13 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    int ret = -EINVAL;
     bool virt = csrno == CSR_VSIREG ? true : false;
+    int ret = -EINVAL;
 
     if (xiselect_cd_range(isel)) {
         ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else if (xiselect_ctr_range(csrno, isel)) {
+        ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
     } else {
         /*
          * As per the specification, access to unimplented region is undefined
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 0a137281de15f030678aae034c24ca2382ca6e3a..96b586fe3c0b573076f1af061911dcafe06f129f 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -681,6 +681,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
+        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_smctr)) ||
+            cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ssctr))) {
+            error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrind");
+            return;
+        }
+        cpu->cfg.ext_smctr = false;
+        cpu->cfg.ext_ssctr = false;
+    }
+
     /*
      * Disable isa extensions based on priv spec after we
      * validated and set everything we need.

-- 
2.34.1


