Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C37C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:06:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdyV-0005wS-51; Tue, 04 Mar 2025 20:55:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyL-0005Kc-Ia
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:58 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyJ-000099-9i
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:57 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22113560c57so118911405ad.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139694; x=1741744494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lub386ALtAm+GMJ0XC8M1yYYevXSKd2evXQR+VIuGA0=;
 b=nlusZ5nT76sz086bqH1+ltE5BVTmC7PZAC7IFQYlh6zYDQIUGvROZ115sRLE75nhH4
 sefj/lI4tw5dV6yHdBczeaNMoyGdr0AEMU01pRa5wLFoPMCwKAqrpFxmB7zI+0X7qcaQ
 /RhDf9dvjMPad2NZvhEW8uNuqBS3mC97CHB1H2Eo5ULE8FEI2ANgV9+b+425eLO1C+sz
 VrXpEr6Wc7QG4nbXLAfCLUVcsEYP21gtCBQ0pyXX4V18GXpex7Pe56/yyjSyaPkjj70r
 asip9X/J+4C+mjokq1SDa1GB3SGSV6OgDpwLgqWGbRS6AMjYXhNHL9M3M5Pyu1Szy3M/
 C0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139694; x=1741744494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lub386ALtAm+GMJ0XC8M1yYYevXSKd2evXQR+VIuGA0=;
 b=H+WiUmutfRf9f7veT5lltcW5IN2RfPy8Cw/KGPcbrR/hWT9ETxC/EhTcEsGyvsp2cI
 u/W2LBb1GXL79saPz7RHkxaXgGtm7HSTX+/3A5i416earfE21jtXQBuhka4rsFgQTFF3
 06YE6wPLqgqkcDBX/bzL9MouXus6DbPus38nV8+yzEpdCC98hNrV77c8+u35RLeWoT1d
 +AP6W0BISk0+onVrj0Pa+590Wq/0h57TeKaTndOeYqblNSa3cl+y4KsNjoGtP6kUoShn
 yCW9/uI078578/FfOfYQteFbwxF9pZSUVerJxcZsrwEvGchhMyQlORLBxP8MSmmB1sYu
 eqVg==
X-Gm-Message-State: AOJu0YxlUAtQ1sNsOwtqBQEneBkybWgWQ72veToVe8go0ZXBrVRZDdOa
 T+6xFSkIw0G0aIyApzGZb0kNHnVBtIpBIRv9QU6lKzEq8rnk0JD2N2MagPtAPSo=
X-Gm-Gg: ASbGncvQz+okdNModH0cQnuLXLsn5ul+N6oOsos28hVXO85VvArp+LfjwnWi2oGTl1M
 t9KK+NQAk/0IkQMxRgSD1nWeFTTBY2JG6633ZY+Rw3APN7EYVgdX7VMawgliq1mbHXt7MMGJf+c
 VCzSNX4SKBXJbo2CiccNpMvm+IVPhYhBaGQzULXit7RJqmy9oOxtupXWkkmv48HWMVWtf2WolH4
 dsvG/lj97JjjQAnR45RtLeIdXliGN7m0Mia2gIYL3sgQI28OhnsN5HgThxHTUaVRKB9ebbkXDT0
 5oLPYZ+g4+o+5r1SMZh2d2PYvroMfvwd998a2q7wLTtQRZecbSYmJUTSgAx93+kJE1rJFkERddO
 co9qxB9m2ZLlavpPUgAcAVvuzHQd5PGGFhmcGRpZz0mW34zGQ4E0=
X-Google-Smtp-Source: AGHT+IGWeNK8w8fx0B0BBhn0sYN5MD9krY/0t675CiZjElkDuNGXIvSIxHeAxE9y0RusU/4blGrebg==
X-Received: by 2002:a17:902:e5c4:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-223f1c9b4e0mr25342315ad.22.1741139693708; 
 Tue, 04 Mar 2025 17:54:53 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:53 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/59] target/riscv: Add support to access ctrsource, ctrtarget,
 ctrdata regs.
Date: Wed,  5 Mar 2025 11:52:42 +1000
Message-ID: <20250305015307.1463560-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62b.google.com
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
Message-ID: <20250212-b4-ctr_upstream_v6-v7-1-4e8159ea33bf@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         |  26 ++++++-
 target/riscv/csr.c         | 150 ++++++++++++++++++++++++++++++++++++-
 target/riscv/tcg/tcg-cpu.c |  11 +++
 3 files changed, 185 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3624ffb6d9..a4ee381a07 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -216,6 +216,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1592,6 +1594,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
+    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
@@ -2856,6 +2860,26 @@ static RISCVCPUImpliedExtsRule SSPM_IMPLIED = {
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
@@ -2874,7 +2898,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
-    &SUPM_IMPLIED, &SSPM_IMPLIED,
+    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
 };
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ab295d2ef3..0ebcca4597 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2427,6 +2427,13 @@ static bool xiselect_cd_range(target_ulong isel)
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
@@ -2472,6 +2479,124 @@ static int rmw_iprio(target_ulong xlen,
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
@@ -2624,6 +2749,27 @@ done:
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
@@ -2635,11 +2781,13 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
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
index 53c9998553..929ed5fd2c 100644
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
2.48.1


