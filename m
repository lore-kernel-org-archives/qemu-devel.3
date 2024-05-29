Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E17C27C44
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsm-00018u-Fl; Wed, 29 May 2024 12:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsk-00018B-Fp
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1sCLsI-0003NK-BV
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so719345e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716998999; x=1717603799;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8dhVgnvdfsSEiK3cdIQuIqMe5XSQpUI6COG5vQN5dTE=;
 b=AaSVMRaO3u6oDbYJjv9j07vKC79+KLZxPCNBem1rtoQEMggZU+pyB0w8jN2p2mp7fQ
 4bSNQ/E9ARB705nnXU2X+kND7Ce66uwm1qnE62vmewLLy0x7r/e8qUk16gKgxu5KAjxg
 fsVp2f0hf21MY0aufCUy4v1gTh7SfWftQVnqcdG7g6svwQodY6tB2zWLcC/skMGoJ9tV
 IYoVxdmgszj1ny022SwejEo8LSdeETWQ5yOgjnJVpGz457qRIl6zwfDKs5RPnelFM4ak
 0foWeFK46IckVWI5nIFNrvIO/JE/ZBWkJGKKDrMM7FIP3IMbkyfxzU+ZzFBMKA7Wn1kW
 L52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998999; x=1717603799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8dhVgnvdfsSEiK3cdIQuIqMe5XSQpUI6COG5vQN5dTE=;
 b=SGqoxvSviX2u6u7P6OEnVOZMdeTcg5j6JfBcMOfcg+T5dZA20PwLQepSSbPLKt3F3B
 l2J1dIhNNizjGQKE7je7o3oaKnTbzl3zIV1XTYS00Is3ti7NPKEju9XsAOSukUWGX6gg
 yHur/2IvQnY7mzxHBEmAnHCxtsBPXtciOa5YJdzRtCQyZZgdOeokuz2tsHGUan6uC+oH
 BD9pvNbkaje2VSGdMGtOXpxr0ZmuxydyKEw8mmbnKEiuePfkKihMffF/KrG5wRU3msB0
 yJQBOQ14C/keBLup1Eo17i4rvyHHFC2X3pf2POZ92S0Z6wjqWXVzsrkp35+XojnZvB+d
 SuFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN26dRXcHWigRtYRRmcs5jbv7aZ1YGdVVrTTwLY5wUqVM5w8sqz1nuIj5SyWRzYEMMeQTr8AJu+xolT71xwcHZBNrGyvI=
X-Gm-Message-State: AOJu0YwQmbQ1Aa1c0V/EVQbmuosvz+wiuich45VycS4h7qY/I3FVILeg
 PI7VcKATWuok9+xwmHrXwDqAkzcBF8inYIq3QyfwYizqbdvM1ChcTtYSy2Hzxkk=
X-Google-Smtp-Source: AGHT+IEzPb+Nvi0RwEK3w0dHknFO7/g6S7ljMR3QWhfsVPoCeYtFQTE1kNo5a+c35gQACukvYdVjBw==
X-Received: by 2002:a05:600c:468a:b0:41b:4caa:554c with SMTP id
 5b1f17b1804b1-42122adb0eamr26331835e9.2.1716998998743; 
 Wed, 29 May 2024 09:09:58 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home
 ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0740sm15228213f8f.107.2024.05.29.09.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:58 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, tech-control-transfer-records@lists.riscv.org
Subject: [PATCH 6/6] target/riscv: Add support to access ctrsource, ctrtarget,
 ctrdata regs.
Date: Wed, 29 May 2024 17:09:50 +0100
Message-Id: <20240529160950.132754-7-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529160950.132754-1-rkanwal@rivosinc.com>
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/riscv/cpu.c |   4 ++
 target/riscv/csr.c | 153 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 30bdfc22ae..a77b1d5caf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
@@ -1473,6 +1475,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
+    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
+    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
     MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 888084d8e5..15b953f268 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -2291,6 +2291,11 @@ static bool xiselect_cd_range(target_ulong isel)
     return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
 }
 
+static bool xiselect_ctr_range(target_ulong isel)
+{
+    return (CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST);
+}
+
 static int rmw_iprio(target_ulong xlen,
                      target_ulong iselect, uint8_t *iprio,
                      target_ulong *val, target_ulong new_val,
@@ -2336,6 +2341,118 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
+static int rmw_xctrsource(CPURISCVState *env, int isel, target_ulong *val,
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
+        *val = 0;
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
+static int rmw_xctrtarget(CPURISCVState *env, int isel, target_ulong *val,
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
+        *val = 0;
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
+static int rmw_xctrdata(CPURISCVState *env, int isel, target_ulong *val,
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
+        *val = 0;
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
@@ -2486,6 +2603,38 @@ done:
     return ret;
 }
 
+static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
+                        target_ulong isel, target_ulong *val,
+                        target_ulong new_val, target_ulong wr_mask)
+{
+    bool ext_sxctr = false;
+    int ret = -EINVAL;
+
+    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG3) {
+        ext_sxctr = riscv_cpu_cfg(env)->ext_smctr;
+    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG3) {
+        ext_sxctr = riscv_cpu_cfg(env)->ext_ssctr;
+    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG3) {
+        ext_sxctr = riscv_cpu_cfg(env)->ext_ssctr;
+    }
+
+    if (!ext_sxctr) {
+        return -EINVAL;
+    }
+
+    if (csrno == CSR_MIREG || csrno == CSR_SIREG || csrno == CSR_VSIREG) {
+        ret = rmw_xctrsource(env, isel, val, new_val, wr_mask);
+    } else if (csrno == CSR_MIREG2 || csrno == CSR_SIREG2 ||
+               csrno == CSR_VSIREG2) {
+        ret = rmw_xctrtarget(env, isel, val, new_val, wr_mask);
+    } else if (csrno == CSR_MIREG3 || csrno == CSR_SIREG3 ||
+               csrno == CSR_VSIREG3) {
+        ret = rmw_xctrdata(env, isel, val, new_val, wr_mask);
+    }
+
+    return ret;
+}
+
 /*
  * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
  *
@@ -2497,11 +2646,13 @@ static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
                               target_ulong isel, target_ulong *val,
                               target_ulong new_val, target_ulong wr_mask)
 {
-    int ret = -EINVAL;
     bool virt = csrno == CSR_VSIREG ? true : false;
+    int ret = -EINVAL;
 
     if (xiselect_cd_range(isel)) {
         ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
+    } else if (xiselect_ctr_range(isel)) {
+        ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
     } else {
         /*
          * As per the specification, access to unimplented region is undefined
-- 
2.34.1


