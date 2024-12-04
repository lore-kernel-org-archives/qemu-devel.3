Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F56E7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 12:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIoxI-0008EN-VR; Wed, 04 Dec 2024 07:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIoww-00080c-Rw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:52 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1tIows-0008Tr-5k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 07:57:48 -0500
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-385dece873cso2773283f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 04:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733317064; x=1733921864;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WnDf7QI/RLhzrBa9OwVRAWfNBRyfJIuIUVfxmyQq/YM=;
 b=OvWgPRLThaw76imqANQUMSn473O52td9OSejPc1OygLd73UvTanktVShGy7TgQGB+e
 FqOk6+n4072m4lletq9FKq1NRppNh5zC6QM0x757CJe3tKMQaNBCI0tCUWT/Xw9J01X6
 oO/BDafR/UxUJ3QMX+RMtYdtimD5j0+ZFBoWkIasFakC8iUCvfVChnbLT3H2n/lEqOjh
 DPunCaaksNpYvV7AUqR5coXPica5O6cYKOW3omhZLJzXvS6P0c9cXmil34ZMGwax6vHZ
 3o4rXQB39hysexDhUq8Pcvnf2f/kZNHbitxHW47WVztydJ8oxzL0fZKDG0dF40XLTgSN
 e8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733317064; x=1733921864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnDf7QI/RLhzrBa9OwVRAWfNBRyfJIuIUVfxmyQq/YM=;
 b=tRi0df79BOBGFghRPthFBtCUAYPbcGiDwn5Jm3pokF+DywNAQnw8rix+glMzt/fbGf
 76aesCnMBlC18M9GM/wdQbo76wlGsyAaLQCS0J9ZrebrWfO7KRwLG/sc0GCkWyl8ao5k
 cpSauiLln7D3xOedQ4hNLyVhMH5dr/joWDflOmTDjddFm3k9NQpSFNMn4swC1Ki8iJsy
 RXjnx3o+W7ykru8TFk7H3mHRYN4yZMXdMEZBgx4HTi9JGiMUekvgpPf7zcd6V6/1UbZ1
 VqZBBUX8WMyfUgCt0cu1ehdpd4KSo2lFFcQsl2eIhZ0VSWvHGPM1+AsHUgAVHbZ3bH+P
 L8ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXTYcVd2iHzfUj2wZo58xNRMMKbBiIwupC8xjravP5m9e0/2nbTl96WnMSPbE8siA1vCqgZ5UTmfTU@nongnu.org
X-Gm-Message-State: AOJu0YyR0VC5SHEhgGJNNJ8aIYb0v/QfEdnxDVuKwbi2cKjcLnQ5QwCJ
 1EkKWG29K3bzFlQtM5dUEVRXAVhhkyWgXqAcCchEGfl8NCh6OrPHFxvmw2Yaxro=
X-Gm-Gg: ASbGncuS94J+Hwe2Luqg90oR6HSARkWnlSro9G/9vwHXcWEboOaSGqsdf5za0+GDT/B
 +mTZnM/w5fKqrGNgxxIgJ/w5sxMa98RlP1lgE5eL8XVZcwTVspxiIl5fJHXyyx3NJjPv16KRGUT
 QFg3Htcq4QlQkKSXeS0O4TriP4aVtlSFCN8nLs/xppPSBDFbE5Lo7H/Jr8zwNWuQQbLpwMitX2M
 4xHjti48Ptskqkvhr8FM1m5li+ADygQ/GPI58+yiF8SMwaQJKEh86/JborOsSdmHQvEp6alZqTl
 bYmMKA==
X-Google-Smtp-Source: AGHT+IF3skSmAkZWjpjbIkPQj48IAZvP6vXMwY8KQ3NYz59yG5qvkSEH94LVOM7f1Cl0QKHtv6Qu0g==
X-Received: by 2002:a05:6000:1acc:b0:385:e30a:e0f7 with SMTP id
 ffacd0b85a97d-38607ace5f0mr3553121f8f.22.1733317063834; 
 Wed, 04 Dec 2024 04:57:43 -0800 (PST)
Received: from rkanwal-XPS-15-9520.ba.rivosinc.com ([137.59.223.84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385deeb6acdsm15826428f8f.81.2024.12.04.04.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 04:57:43 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org, jason.chien@sifive.com,
 frank.chang@sifive.com, richard.henderson@linaro.org
Subject: [PATCH v4 4/7] target/riscv: Add support to record CTR entries.
Date: Wed,  4 Dec 2024 17:56:42 +0500
Message-Id: <20241204-b4-ctr_upstream_v3-v4-4-d3ce6bef9432@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
References: <20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x444.google.com
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

This commit adds logic to records CTR entries of different types
and adds required hooks in TCG and interrupt/Exception logic to
record events.

This commit also adds support to invoke freeze CTR logic for breakpoint
exceptions and counter overflow interrupts.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.h                             |   7 +
 target/riscv/cpu_helper.c                      | 259 +++++++++++++++++++++++++
 target/riscv/helper.h                          |   5 +-
 target/riscv/insn_trans/trans_privileged.c.inc |   6 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |  70 +++++++
 target/riscv/insn_trans/trans_rvzce.c.inc      |  22 +++
 target/riscv/op_helper.c                       |  23 ++-
 target/riscv/translate.c                       |  44 +++++
 8 files changed, 430 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index da14ac2f874b81d3f01bc31b0064d020f2dbdf61..f39ca48d37332c4e5907ca87040de420f78df2e4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -310,6 +310,10 @@ struct CPUArchState {
     uint32_t sctrstatus;
     uint64_t vsctrctl;
 
+    uint64_t ctr_src[16 << SCTRDEPTH_MAX];
+    uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
+    uint64_t ctr_data[16 << SCTRDEPTH_MAX];
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
@@ -607,6 +611,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
+void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
+    enum CTRType type, target_ulong prev_priv, bool prev_virt);
+
 void riscv_translate_init(void);
 G_NORETURN void riscv_raise_exception(CPURISCVState *env,
                                       uint32_t exception, uintptr_t pc);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 0a3ead69eabaf0e395fc7c78868640a4216573ee..dbdad4e29d7de0713f7530c46e9fab03d3c459a4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -771,6 +771,247 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
     }
 }
 
+static void riscv_ctr_freeze(CPURISCVState *env, uint64_t freeze_mask,
+                             bool virt)
+{
+    uint64_t ctl = virt ? env->vsctrctl : env->mctrctl;
+
+    assert((freeze_mask & (~(XCTRCTL_BPFRZ | XCTRCTL_LCOFIFRZ))) == 0);
+
+    if (ctl & freeze_mask) {
+        env->sctrstatus |= SCTRSTATUS_FROZEN;
+    }
+}
+
+static uint64_t riscv_ctr_priv_to_mask(target_ulong priv, bool virt)
+{
+    switch (priv) {
+    case PRV_M:
+        return MCTRCTL_M;
+    case PRV_S:
+        if (virt) {
+            return XCTRCTL_S;
+        }
+        return XCTRCTL_S;
+    case PRV_U:
+        if (virt) {
+            return XCTRCTL_U;
+        }
+        return XCTRCTL_U;
+    }
+
+    g_assert_not_reached();
+}
+
+static uint64_t riscv_ctr_get_control(CPURISCVState *env, target_long priv,
+                                      bool virt)
+{
+    switch (priv) {
+    case PRV_M:
+        return env->mctrctl;
+    case PRV_S:
+    case PRV_U:
+        if (virt) {
+            return env->vsctrctl;
+        }
+        return env->mctrctl;
+    }
+
+    g_assert_not_reached();
+}
+
+/*
+ * This function assumes that src privilege and target privilege are not same
+ * and src privilege is less than target privilege. This includes the virtual
+ * state as well.
+ */
+static bool riscv_ctr_check_xte(CPURISCVState *env, target_long src_prv,
+                                bool src_virt)
+{
+    target_long tgt_prv = env->priv;
+    bool res = true;
+
+    /*
+     * VS and U mode are same in terms of xTE bits required to record an
+     * external trap. See 6.1.2. External Traps, table 8 External Trap Enable
+     * Requirements. This changes VS to U to simplify the logic a bit.
+     */
+    if (src_virt && src_prv == PRV_S) {
+        src_prv = PRV_U;
+    } else if (env->virt_enabled && tgt_prv == PRV_S) {
+        tgt_prv = PRV_U;
+    }
+
+    /* VU mode is an outlier here. */
+    if (src_virt && src_prv == PRV_U) {
+        res &= !!(env->vsctrctl & XCTRCTL_STE);
+    }
+
+    switch (src_prv) {
+    case PRV_U:
+        if (tgt_prv == PRV_U) {
+            break;
+        }
+        res &= !!(env->mctrctl & XCTRCTL_STE);
+        /* fall-through */
+    case PRV_S:
+        if (tgt_prv == PRV_S) {
+            break;
+        }
+        res &= !!(env->mctrctl & MCTRCTL_MTE);
+        /* fall-through */
+    case PRV_M:
+        break;
+    }
+
+    return res;
+}
+
+/*
+ * Special cases for traps and trap returns:
+ *
+ * 1- Traps, and trap returns, between enabled modes are recorded as normal.
+ * 2- Traps from an inhibited mode to an enabled mode, and trap returns from an
+ * enabled mode back to an inhibited mode, are partially recorded.  In such
+ * cases, the PC from the inhibited mode (source PC for traps, and target PC
+ * for trap returns) is 0.
+ *
+ * 3- Trap returns from an inhibited mode to an enabled mode are not recorded.
+ * Traps from an enabled mode to an inhibited mode, known as external traps,
+ * receive special handling.
+ * By default external traps are not recorded, but a handshake mechanism exists
+ * to allow partial recording.  Software running in the target mode of the trap
+ * can opt-in to allowing CTR to record traps into that mode even when the mode
+ * is inhibited.  The MTE, STE, and VSTE bits allow M-mode, S-mode, and VS-mode,
+ * respectively, to opt-in. When an External Trap occurs, and xTE=1, such that
+ * x is the target privilege mode of the trap, will CTR record the trap. In such
+ * cases, the target PC is 0.
+ */
+/*
+ * CTR arrays are implemented as circular buffers and new entry is stored at
+ * sctrstatus.WRPTR, but they are presented to software as moving circular
+ * buffers. Which means, software get's the illusion that whenever a new entry
+ * is added the whole buffer is moved by one place and the new entry is added at
+ * the start keeping new entry at idx 0 and older ones follow.
+ *
+ * Depth = 16.
+ *
+ * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+ * WRPTR                                   W
+ * entry   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8
+ *
+ * When a new entry is added:
+ * buffer [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
+ * WRPTR                                       W
+ * entry   8   7   6   5   4   3   2   1   0   F   E   D   C   B   A   9
+ *
+ * entry here denotes the logical entry number that software can access
+ * using ctrsource, ctrtarget and ctrdata registers. So xiselect 0x200
+ * will return entry 0 i-e buffer[8] and 0x201 will return entry 1 i-e
+ * buffer[7]. Here is how we convert entry to buffer idx.
+ *
+ *    entry = isel - CTR_ENTRIES_FIRST;
+ *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
+ */
+void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
+    enum CTRType type, target_ulong src_priv, bool src_virt)
+{
+    bool tgt_virt = env->virt_enabled;
+    uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);
+    uint64_t tgt_mask = riscv_ctr_priv_to_mask(env->priv, tgt_virt);
+    uint64_t src_ctrl = riscv_ctr_get_control(env, src_priv, src_virt);
+    uint64_t tgt_ctrl = riscv_ctr_get_control(env, env->priv, tgt_virt);
+    uint64_t depth, head;
+    bool ext_trap = false;
+
+    /*
+     * Return immediately if both target and src recording is disabled or if
+     * CTR is in frozen state.
+     */
+    if ((!(src_ctrl & src_mask) && !(tgt_ctrl & tgt_mask)) ||
+        env->sctrstatus & SCTRSTATUS_FROZEN) {
+        return;
+    }
+
+    /*
+     * With RAS Emul enabled, only allow Indirect, direct calls, Function
+     * returns and Co-routine swap types.
+     */
+    if (tgt_ctrl & XCTRCTL_RASEMU &&
+        type != CTRDATA_TYPE_INDIRECT_CALL &&
+        type != CTRDATA_TYPE_DIRECT_CALL &&
+        type != CTRDATA_TYPE_RETURN &&
+        type != CTRDATA_TYPE_CO_ROUTINE_SWAP) {
+        return;
+    }
+
+    if (type == CTRDATA_TYPE_EXCEPTION || type == CTRDATA_TYPE_INTERRUPT) {
+        /* Case 2 for traps. */
+        if (!(src_ctrl & src_mask)) {
+            src = 0;
+        } else if (!(tgt_ctrl & tgt_mask)) {
+            /* Check if target priv-mode has allowed external trap recording. */
+            if (!riscv_ctr_check_xte(env, src_priv, src_virt)) {
+                return;
+            }
+
+            ext_trap = true;
+            dst = 0;
+        }
+    } else if (type == CTRDATA_TYPE_EXCEP_INT_RET) {
+        /*
+         * Case 3 for trap returns.  Trap returns from inhibited mode are not
+         * recorded.
+         */
+        if (!(src_ctrl & src_mask)) {
+            return;
+        }
+
+        /* Case 2 for trap returns. */
+        if (!(tgt_ctrl & tgt_mask)) {
+            dst = 0;
+        }
+    }
+
+    /* Ignore filters in case of RASEMU mode or External trap. */
+    if (!(tgt_ctrl & XCTRCTL_RASEMU) && !ext_trap) {
+        /*
+         * Check if the specific type is inhibited. Not taken branch filter is
+         * an enable bit and needs to be checked separatly.
+         */
+        bool check = tgt_ctrl & BIT_ULL(type + XCTRCTL_INH_START);
+        if ((type == CTRDATA_TYPE_NONTAKEN_BRANCH && !check) ||
+            (type != CTRDATA_TYPE_NONTAKEN_BRANCH && check)) {
+            return;
+        }
+    }
+
+    head = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
+
+    depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
+    if (tgt_ctrl & XCTRCTL_RASEMU && type == CTRDATA_TYPE_RETURN) {
+        head = (head - 1) & (depth - 1);
+
+        env->ctr_src[head] &= ~CTRSOURCE_VALID;
+        env->sctrstatus =
+            set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
+        return;
+    }
+
+    /* In case of Co-routine SWAP we overwrite latest entry. */
+    if (tgt_ctrl & XCTRCTL_RASEMU && type == CTRDATA_TYPE_CO_ROUTINE_SWAP) {
+        head = (head - 1) & (depth - 1);
+    }
+
+    env->ctr_src[head] = src | CTRSOURCE_VALID;
+    env->ctr_dst[head] = dst & ~CTRTARGET_MISP;
+    env->ctr_data[head] = set_field(0, CTRDATA_TYPE_MASK, type);
+
+    head = (head + 1) & (depth - 1);
+
+    env->sctrstatus = set_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK, head);
+}
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en)
 {
     g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);
@@ -1806,10 +2047,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1 << cause));
     bool vs_injected = env->hvip & (1 << cause) & env->hvien &&
         !(env->mip & (1 << cause));
+    const bool prev_virt = env->virt_enabled;
+    const target_ulong prev_priv = env->priv;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
+    target_ulong src;
     int sxlen = 0;
     int mxlen = 0;
 
@@ -1960,6 +2204,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->pc = (env->stvec >> 2 << 2) +
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S, virt);
+
+        src = env->sepc;
     } else {
         /* handle the trap in M-mode */
         /* save elp status */
@@ -1997,6 +2243,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->pc = (env->mtvec >> 2 << 2) +
                   ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_M, virt);
+        src = env->mepc;
+    }
+
+    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) {
+        if (async && cause == IRQ_PMU_OVF) {
+            riscv_ctr_freeze(env, XCTRCTL_LCOFIFRZ, virt);
+        } else if (!async && cause == RISCV_EXCP_BREAKPOINT) {
+            riscv_ctr_freeze(env, XCTRCTL_BPFRZ, virt);
+        }
+
+        riscv_ctr_add_entry(env, src, env->pc,
+                        async ? CTRDATA_TYPE_INTERRUPT : CTRDATA_TYPE_EXCEPTION,
+                        prev_priv, prev_virt);
     }
 
     /*
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 451261ce5a4f6138a06afb1e4abc0c838acb283e..065d82d3997b1df46a0ed1b96d33bee13c049fad 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -129,12 +129,13 @@ DEF_HELPER_2(csrr_i128, tl, env, int)
 DEF_HELPER_4(csrw_i128, void, env, int, tl, tl)
 DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
-DEF_HELPER_1(sret, tl, env)
-DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_2(sret, tl, env, tl)
+DEF_HELPER_2(mret, tl, env, tl)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
+DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
 #endif
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 0bdfa9a0ed3313223ce9032fb24484c3887cddf9..a5c2410cfa0779b1a928e7b89bd2ee5bb24216e4 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -78,9 +78,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        TCGv src = tcg_constant_tl(ctx->base.pc_next);
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
-        gen_helper_sret(cpu_pc, tcg_env);
+        gen_helper_sret(cpu_pc, tcg_env, src);
         exit_tb(ctx); /* no chaining */
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
@@ -95,9 +96,10 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
-    gen_helper_mret(cpu_pc, tcg_env);
+    gen_helper_mret(cpu_pc, tcg_env, src);
     exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 96c218a9d7875c6419287ac3aa9746251be3f442..fc182e7b18a289e13ad212f10a3233aca25fae41 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -93,6 +93,50 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
     return true;
 }
 
+#ifndef CONFIG_USER_ONLY
+/*
+ * Indirect calls
+ * - jalr x1, rs where rs != x5;
+ * - jalr x5, rs where rs != x1;
+ * - c.jalr rs1 where rs1 != x5;
+ *
+ * Indirect jumps
+ * - jalr x0, rs where rs != x1 and rs != x5;
+ * - c.jr rs1 where rs1 != x1 and rs1 != x5.
+ *
+ * Returns
+ * - jalr rd, rs where (rs == x1 or rs == x5) and rd != x1 and rd != x5;
+ * - c.jr rs1 where rs1 == x1 or rs1 == x5.
+ *
+ * Co-routine swap
+ * - jalr x1, x5;
+ * - jalr x5, x1;
+ * - c.jalr x5.
+ *
+ * Other indirect jumps
+ * - jalr rd, rs where rs != x1, rs != x5, rd != x0, rd != x1 and rd != x5.
+ */
+static void helper_ctr_jalr(DisasContext *ctx, arg_jalr *a)
+{
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
+    TCGv type;
+
+    if ((a->rd == 1 && a->rs1 != 5) || (a->rd == 5 && a->rs1 != 1)) {
+        type = tcg_constant_tl(CTRDATA_TYPE_INDIRECT_CALL);
+    } else if (a->rd == 0 && a->rs1 != 1 && a->rs1 != 5) {
+        type = tcg_constant_tl(CTRDATA_TYPE_INDIRECT_JUMP);
+    } else if ((a->rs1 == 1 || a->rs1 == 5) && (a->rd != 1 && a->rd != 5)) {
+        type = tcg_constant_tl(CTRDATA_TYPE_RETURN);
+    } else if ((a->rs1 == 1 && a->rd == 5) || (a->rs1 == 5 && a->rd == 1)) {
+        type = tcg_constant_tl(CTRDATA_TYPE_CO_ROUTINE_SWAP);
+    } else {
+        type = tcg_constant_tl(CTRDATA_TYPE_OTHER_INDIRECT_JUMP);
+    }
+
+    gen_helper_ctr_add_entry(tcg_env, src, cpu_pc, type);
+}
+#endif
+
 static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
     TCGLabel *misaligned = NULL;
@@ -130,6 +174,12 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        helper_ctr_jalr(ctx, a);
+    }
+#endif
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
@@ -219,6 +269,9 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_SIGN);
     target_ulong orig_pc_save = ctx->pc_save;
+#ifndef CONFIG_USER_ONLY
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
+#endif
 
     if (get_xl(ctx) == MXL_RV128) {
         TCGv src1h = get_gprh(ctx, a->rs1);
@@ -231,6 +284,15 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     } else {
         tcg_gen_brcond_tl(cond, src1, src2, l);
     }
+
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        TCGv type = tcg_constant_tl(CTRDATA_TYPE_NONTAKEN_BRANCH);
+        TCGv dest = tcg_constant_tl(ctx->base.pc_next + ctx->cur_insn_len);
+        gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+    }
+#endif
+
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
@@ -243,6 +305,14 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
         gen_pc_plus_diff(target_pc, ctx, a->imm);
         gen_exception_inst_addr_mis(ctx, target_pc);
     } else {
+#ifndef CONFIG_USER_ONLY
+        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_TAKEN_BRANCH);
+            TCGv dest = tcg_constant_tl(ctx->base.pc_next + a->imm);
+
+            gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+        }
+#endif
         gen_goto_tb(ctx, 0, a->imm);
     }
     ctx->pc_save = -1;
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index cd234ad960724c936b92afb6fd1f3c7c2a37cb80..07b51d9f4d847c4411165b422a843fea65c86d45 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -204,6 +204,13 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
     if (ret) {
         TCGv ret_addr = get_gpr(ctx, xRA, EXT_SIGN);
         tcg_gen_mov_tl(cpu_pc, ret_addr);
+#ifndef CONFIG_USER_ONLY
+        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+            TCGv src = tcg_constant_tl(ctx->base.pc_next);
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_RETURN);
+            gen_helper_ctr_add_entry(tcg_env, src, cpu_pc, type);
+        }
+#endif
         tcg_gen_lookup_and_goto_ptr();
         ctx->base.is_jmp = DISAS_NORETURN;
     }
@@ -309,6 +316,21 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
         gen_set_gpr(ctx, xRA, succ_pc);
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        TCGv src = tcg_constant_tl(ctx->base.pc_next);
+
+        if (a->index >= 32) {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_DIRECT_CALL);
+            gen_helper_ctr_add_entry(tcg_env, src, addr, type);
+        } else {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_DIRECT_JUMP);
+            gen_helper_ctr_add_entry(tcg_env, src, addr, type);
+        }
+    }
+#endif
+
+
     tcg_gen_mov_tl(cpu_pc, addr);
 
     tcg_gen_lookup_and_goto_ptr();
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index eddedacf4b4f191127b6378d4c2dbfd747123f9e..b55b7f3ac3d209d39b16075e79c2342b89bdf805 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -259,10 +259,12 @@ void helper_cbo_inval(CPURISCVState *env, target_ulong address)
 
 #ifndef CONFIG_USER_ONLY
 
-target_ulong helper_sret(CPURISCVState *env)
+target_ulong helper_sret(CPURISCVState *env, target_ulong curr_pc)
 {
     uint64_t mstatus;
     target_ulong prev_priv, prev_virt = env->virt_enabled;
+    const target_ulong src_priv = env->priv;
+    const bool src_virt = env->virt_enabled;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -318,10 +320,15 @@ target_ulong helper_sret(CPURISCVState *env)
     }
     env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
 
+    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) {
+        riscv_ctr_add_entry(env, curr_pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
+                            src_priv, src_virt);
+    }
+
     return retpc;
 }
 
-target_ulong helper_mret(CPURISCVState *env)
+target_ulong helper_mret(CPURISCVState *env, target_ulong curr_pc)
 {
     if (!(env->priv >= PRV_M)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -367,9 +374,21 @@ target_ulong helper_mret(CPURISCVState *env)
     }
     env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
 
+    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) {
+        riscv_ctr_add_entry(env, curr_pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
+                            PRV_M, false);
+    }
+
     return retpc;
 }
 
+void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
+                          target_ulong dest, target_ulong type)
+{
+    riscv_ctr_add_entry(env, src, dest, (enum CTRType)type,
+                            env->priv, env->virt_enabled);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bccaf8e89a650fdc08e866f2edc4f22910e6c328..7c7eb591c1608a2e5a5cba2911998e5d7261f381 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -563,6 +563,44 @@ static void gen_set_fpr_d(DisasContext *ctx, int reg_num, TCGv_i64 t)
     }
 }
 
+#ifndef CONFIG_USER_ONLY
+/*
+ * Direct calls
+ * - jal x1;
+ * - jal x5;
+ * - c.jal.
+ * - cm.jalt.
+ *
+ * Direct jumps
+ * - jal x0;
+ * - c.j;
+ * - cm.jt.
+ *
+ * Other direct jumps
+ * - jal rd where rd != x1 and rd != x5 and rd != x0;
+ */
+static void helper_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
+{
+    TCGv dest = tcg_constant_tl(ctx->base.pc_next + imm);
+    TCGv src = tcg_constant_tl(ctx->base.pc_next);
+    TCGv type;
+
+    /*
+     * If rd is x1 or x5 link registers, treat this as direct call otherwise
+     * its a direct jump.
+     */
+    if (rd == 1 || rd == 5) {
+        type = tcg_constant_tl(CTRDATA_TYPE_DIRECT_CALL);
+    } else if (rd == 0) {
+        type = tcg_constant_tl(CTRDATA_TYPE_DIRECT_JUMP);
+    } else {
+        type = tcg_constant_tl(CTRDATA_TYPE_OTHER_DIRECT_JUMP);
+    }
+
+    gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+}
+#endif
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
@@ -577,6 +615,12 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
         }
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        helper_ctr_jal(ctx, rd, imm);
+    }
+#endif
+
     gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
     gen_set_gpr(ctx, rd, succ_pc);
 

-- 
2.34.1


