Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5B8E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoxH-0008Db-0G; Wed, 04 Dec 2024 07:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIox4-00084c-Gp
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:59 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIox0-0000B5-Ag
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385ea29eee1so2870693f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317071; x=1733921871;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mRwquVuCbBdC2gMEt9pTfxsQTxkyyzI8HC99Y7f0E5E=;
 b=Hy/OTL8SAUsj40GRTmGYUN6kou0gXL6lUUUrx6JW3/AhuqxbuLDEYgtENrep+PaPr7
 nr+r5iO5R+1WefytNCxeBMgqoiC69rR2DjvyaVFz6UtjxXT3OLlTiIBXrxZVuD/LX+UX
 cDp7WpH96lY8/EWXrXPRV8s8KPhYIWZs1x8oLd8avk5eZVsBBMqxdp8HXBr3xj20w/8F
 OK/IFecdx1+gBusnka0fRrWRflQ6DJSwxZj8hZ+iyVpSobERFQIMwfFF9ok6aMjdGm5L
 lvH5uf5IJqdMgSu2l1ne/A4EGjX+PP3epjdzZRoVkI5bMgMtAJndzWMZ/wJhHVRV+Ial
 Aotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317071; x=1733921871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mRwquVuCbBdC2gMEt9pTfxsQTxkyyzI8HC99Y7f0E5E=;
 b=nWqErCkfcMMw9qIn1xjFNl5VlwQGzcEdEArMbFn7LBY1wM8HSUybEI1RWJTDZQSdEu
 Gk51CXq91BmGzJUXBGz42ijYHSvzfJ0Qp3yMHTjvl1Hwe5DIRAnAsM0dG+lO1d6VIDgi
 GqU4iWyEU6fxXjpMecqls7uz+gStrnjTb5R9uV1OU9GlST7aP8to/4Qmfn2ns9x7icNM
 vRqc0fEnXsFNJomrsWZ9VWsLcJIVokJjR9dINKzEkeqD7hDYXA+wHBNGTbZWIpx4IL+A
 lPQnuA5Lj5xAz7er9eLbfWTvBu31ryIrJ4xH/cMPIKGbuxK6oLxLBmZGkA40Q4IBbRFW
 IREw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHvIFklm9jJMtopubdZwM2g1kOstTV8B6M0RkeOmVZdu2JN6Je9B3UbIajzeTSrpQBLoCsSeB7yQGJ@nongnu.org
X-Gm-Message-State: AOJu0Yy+kcCJ+NO7M6CBaUSjCzq0OtC0xJGHISXbHY7eU69NrzwNNUGF
 aBhZvxm0yvsLNYae5p1q9HzrSR80f0rO8ayrEcwbXQgoqr+VZ49atmOnw93K/HI=
X-Gm-Gg: ASbGncvFgYcSS6SszlRrqd3r2bSB3f28cCl+uANkjWg+udafwXJj9Q3fRZcHwZMz/M5
 azgmTc32fCBKIMtT7xWrgyjXXLc4WkReUJjqOEzoyDedTG3HTnsDMZyNQI90G6kAiJqcnpXb0Di
 EUdAez66QhV7bfKXRwNKNa/sAuiKYz0yFZ1/X7TSpu8XhfbgtovSaRt7SBZYk2Oo/Qpv8FLb/dM
 OMt9vDR3jMjHVIvZBKlXHi1/cw63v9xxj3yvQw+zjNCYo7No4CFoLBCHPGFqZCLPqGIt+31XQVq
 xpNv+w==
X-Google-Smtp-Source: AGHT+IHA1xY60qXbvemAL7B9DAzydnTxEROtAIWBZfCHxpookzVuBilbA3rVqr/68l04uyHFpnaWzQ==
X-Received: by 2002:a05:6000:2a8:b0:385:fd31:ca34 with SMTP id
 ffacd0b85a97d-385fd54df23mr5406266f8f.54.1733317071103; 
 Wed, 04 Dec 2024 04:57:51 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:50 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 6/7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
Date: Wed,  4 Dec 2024 17:56:44 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-6-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x433.google.com
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
---
 target/riscv/cpu.c         |  26 +++++++-
 target/riscv/csr.c         | 150 ++++++++++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |  11 ++++
 3 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2a4f285a974ffc62e7f3e938691dbffe376a7e46..751029e924d4690aaa5de65456fd5a5ec25b916a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -199,6 +199,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1481,6 +1483,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
+    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
@@ -2656,6 +2660,26 @@ static RISCVCPUImpliedExtsRule SSCFG_IMPLIED = {
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
@@ -2674,7 +2698,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-    NULL
+    &SMCTR_IMPLIED, &SSCTR_IMPLIED, NULL
 };
 
 static Property riscv_cpu_properties[] = {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7e03065d3dcd8713e2cadae3017ed355c9f9bf10..d80684a708891e062393deebe880650fb4df44ab 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2401,6 +2401,13 @@ static bool xiselect_cd_range(target_ulong isel)
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
@@ -2446,6 +2453,124 @@ static int rmw_iprio(target_ulong xlen,
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
@@ -2596,6 +2721,27 @@ done:
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
@@ -2607,11 +2753,13 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
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
index 2b57aa4d1704b176f314dbe0b120cfcc943bf4f8..575b5692c7f68a5f6d37edbc17269e41f496f682 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -652,6 +652,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
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


