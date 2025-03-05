Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF84C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxy-0004Rg-Ft; Tue, 04 Mar 2025 20:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxx-0004Kr-C3
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:33 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxu-0008Vi-9u
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:54:33 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2234e4b079cso115238675ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139668; x=1741744468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yaVLl1IdU9mypyfQFc9dhTenrt+4xr8flFFi7g1i378=;
 b=aYEXwz2jiDvyOgqmegUQ9gGUx3lLe8/EGC2Nn2Sd5Qny0uS/ZywDYBTFqRcAXuWPcK
 U7zmzHW2tuWvaMMN8L10EM9PauFLSPe1MPE3IV7PIMWRCWTlJt2mvL3gs1QKBjjIzEVY
 SXliWMDdLzGbQjxpjYxWwFjN1OnvXICC8JvzRx5EH9XVNSrOAOFpN/aqcvxysSLDWjl3
 5c4Qu17ht3AWI2VK56UAmAIIQntTQWOpltoUaNlOhPkBSsozIkn3xEcsFOqm0UcVpQmM
 r4SaO0BwqTdHkiqZ8bIhRkd3VnHuK0cLmROGi7vBXYistbeKrt1IqZY4tTjhBAWm5O/s
 Kk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139668; x=1741744468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaVLl1IdU9mypyfQFc9dhTenrt+4xr8flFFi7g1i378=;
 b=iT0ZybNjkqLTsJeBv4Y4A4RkDHtTUcP9bd2v+eVWQDppSxH77Kgl+leYejvEN0Be6g
 FGa1njFebVo5z6uq7B/kZM4QxG2toGoUix7mGDVriOCo0YJHtFWO9/99k7vvvFsJDmqJ
 yYC+ST7N3RMZU4I0FrZxRnqHe4tJHKb7IwBq3yUbI+XQ7Ap+H/ZZ0LtEs0wE+h4Iae8N
 9juIJiKgQc5L2idx+faopqAxE4sy1cx4EfAd2f4zW3VsLybVwbLitXoysVWPSUFap9KA
 M89lEePmv82ncEo/+gG1MCGrzXXgXTXyJa+ZrQpum8las3G3CTugPyFWgNR1pG4WXure
 KUEA==
X-Gm-Message-State: AOJu0Yxfi1DxWvJl5kd+G3eTjZKmMLmTDdjsBzGDhfaNhx9bgt9TPkZM
 3Lz17aWBO1EMKHFjJPwmBasWE5DUG9oMzugA3eGgK2C0i5dMc5x8OROGo1H1rJE=
X-Gm-Gg: ASbGncsGw2nEMp2sArkUj81zh/6e4CsDKChKymmJJZBJhErSCTHSV6qzkYVCSaAYAMl
 gABweib8QWD47b48uVBoYntzjrlbRkRiTo/ikxzd5Zf4cWYLZ5vVTMP+muY4KI3razw9mAokmeO
 LlLAUeUqUxQ2NMxOt/osylZZ6TUud76ZwYwsCScZeL8BZ60CtqhkixDT4yyFq7SKIxhX4nGlqC+
 q3TcePv1F76enAm2KEvaSOVCkGZUdzKdD2oLlAd15m4+GQUOkuDMjljFIg28GjKJQduHsiqNWBz
 B8tumGJ+a1NJ6Y5q9b00d/wVybvF/Qvr2jA+h5v9uZZQx7cDvmS313/8vdolfDos8ls0PN5k/B3
 nnnD12qYM53VyCwWxHNF5BCIckHcvrmKwomajAN7ti60b+iORcuA=
X-Google-Smtp-Source: AGHT+IEnEQg8aT6sLz/13E1zb2cec+0gCQO/IchvdF3FRnp8Fy4/OIoaJavGGeGOx67FOrD7E7AMww==
X-Received: by 2002:a17:902:ea05:b0:223:67ac:8929 with SMTP id
 d9443c01a7336-223f1b857f4mr18145805ad.0.1741139668149; 
 Tue, 04 Mar 2025 17:54:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:54:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/59] target/riscv: Add support to record CTR entries.
Date: Wed,  5 Mar 2025 11:52:33 +1000
Message-ID: <20250305015307.1463560-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

This commit adds logic to records CTR entries of different types
and adds required hooks in TCG and interrupt/Exception logic to
record events.

This commit also adds support to invoke freeze CTR logic for breakpoint
exceptions and counter overflow interrupts.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250205-b4-ctr_upstream_v6-v6-4-439d8e06c8ef@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                            |   7 +
 target/riscv/helper.h                         |   1 +
 target/riscv/cpu_helper.c                     | 259 ++++++++++++++++++
 target/riscv/op_helper.c                      |  19 ++
 target/riscv/translate.c                      |  46 ++++
 .../riscv/insn_trans/trans_privileged.c.inc   |   2 +
 target/riscv/insn_trans/trans_rvi.c.inc       |  75 +++++
 target/riscv/insn_trans/trans_rvzce.c.inc     |  21 ++
 8 files changed, 430 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ae355248f3..9e92144b61 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -318,6 +318,10 @@ struct CPUArchState {
     uint32_t sctrstatus;
     uint64_t vsctrctl;
 
+    uint64_t ctr_src[16 << SCTRDEPTH_MAX];
+    uint64_t ctr_dst[16 << SCTRDEPTH_MAX];
+    uint64_t ctr_data[16 << SCTRDEPTH_MAX];
+
     /* Machine and Supervisor interrupt priorities */
     uint8_t miprio[64];
     uint8_t siprio[64];
@@ -613,6 +617,9 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
 
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv, bool virt_en);
 
+void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
+    enum CTRType type, target_ulong prev_priv, bool prev_virt);
+
 void riscv_translate_init(void);
 void riscv_translate_code(CPUState *cs, TranslationBlock *tb,
                           int *max_insns, vaddr pc, void *host_pc);
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 16ea240d26..163121ade5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -136,6 +136,7 @@ DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(wrs_nto, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
+DEF_HELPER_4(ctr_add_entry, void, env, tl, tl, tl)
 /* Native Debug */
 DEF_HELPER_1(itrigger_match, void, env)
 #endif
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 29dc721c5d..7dbdb34b17 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -875,6 +875,247 @@ void riscv_cpu_set_aia_ireg_rmw_fn(CPURISCVState *env, uint32_t priv,
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
@@ -1993,10 +2234,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         !(env->mip & (1ULL << cause));
     bool smode_double_trap = false;
     uint64_t hdeleg = async ? env->hideleg : env->hedeleg;
+    const bool prev_virt = env->virt_enabled;
+    const target_ulong prev_priv = env->priv;
     target_ulong tval = 0;
     target_ulong tinst = 0;
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
+    target_ulong src;
     int sxlen = 0;
     int mxlen = 16 << riscv_cpu_mxl(env);
     bool nnmi_excep = false;
@@ -2182,6 +2426,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
         env->pc = (env->stvec >> 2 << 2) +
                   ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
         riscv_cpu_set_mode(env, PRV_S, virt);
+
+        src = env->sepc;
     } else {
         /*
          * If the hart encounters an exception while executing in M-mode
@@ -2266,6 +2512,19 @@ void riscv_cpu_do_interrupt(CPUState *cs)
                       ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
         }
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
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index ce1256f439..5a99c47b12 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -270,6 +270,8 @@ target_ulong helper_sret(CPURISCVState *env)
 {
     uint64_t mstatus;
     target_ulong prev_priv, prev_virt = env->virt_enabled;
+    const target_ulong src_priv = env->priv;
+    const bool src_virt = env->virt_enabled;
 
     if (!(env->priv >= PRV_S)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
@@ -339,6 +341,11 @@ target_ulong helper_sret(CPURISCVState *env)
     }
     env->mstatus = set_field(env->mstatus, MSTATUS_SPELP, 0);
 
+    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) {
+        riscv_ctr_add_entry(env, env->pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
+                            src_priv, src_virt);
+    }
+
     return retpc;
 }
 
@@ -416,6 +423,11 @@ target_ulong helper_mret(CPURISCVState *env)
     }
     env->mstatus = set_field(env->mstatus, MSTATUS_MPELP, 0);
 
+    if (riscv_cpu_cfg(env)->ext_smctr || riscv_cpu_cfg(env)->ext_ssctr) {
+        riscv_ctr_add_entry(env, env->pc, retpc, CTRDATA_TYPE_EXCEP_INT_RET,
+                            PRV_M, false);
+    }
+
     return retpc;
 }
 
@@ -466,6 +478,13 @@ target_ulong helper_mnret(CPURISCVState *env)
     return retpc;
 }
 
+void helper_ctr_add_entry(CPURISCVState *env, target_ulong src,
+                          target_ulong dest, target_ulong type)
+{
+    riscv_ctr_add_entry(env, src, dest, (enum CTRType)type,
+                        env->priv, env->virt_enabled);
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 698b74f7a8..eaa5d86eae 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -561,6 +561,46 @@ static void gen_set_fpr_d(DisasContext *ctx, int reg_num, TCGv_i64 t)
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
+static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
+{
+    TCGv dest = tcg_temp_new();
+    TCGv src = tcg_temp_new();
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
+    gen_pc_plus_diff(dest, ctx, imm);
+    gen_pc_plus_diff(src, ctx, 0);
+    gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+}
+#endif
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
@@ -575,6 +615,12 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
         }
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_ctr_jal(ctx, rd, imm);
+    }
+#endif
+
     gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
     gen_set_gpr(ctx, rd, succ_pc);
 
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 27d5558d63..ca52405d7d 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -86,6 +86,7 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
     if (has_ext(ctx, RVS)) {
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
+        gen_update_pc(ctx, 0);
         gen_helper_sret(cpu_pc, tcg_env);
         exit_tb(ctx); /* no chaining */
         ctx->base.is_jmp = DISAS_NORETURN;
@@ -103,6 +104,7 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
+    gen_update_pc(ctx, 0);
     gen_helper_mret(cpu_pc, tcg_env);
     exit_tb(ctx); /* no chaining */
     ctx->base.is_jmp = DISAS_NORETURN;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 96c218a9d7..b55f56a5eb 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -93,6 +93,51 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
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
+static void gen_ctr_jalr(DisasContext *ctx, arg_jalr *a, TCGv dest)
+{
+    TCGv src = tcg_temp_new();
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
+    gen_pc_plus_diff(src, ctx, 0);
+    gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+}
+#endif
+
 static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
     TCGLabel *misaligned = NULL;
@@ -117,6 +162,12 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
     gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
     gen_set_gpr(ctx, a->rd, succ_pc);
 
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        gen_ctr_jalr(ctx, a, target_pc);
+    }
+#endif
+
     tcg_gen_mov_tl(cpu_pc, target_pc);
     if (ctx->fcfi_enabled) {
         /*
@@ -231,6 +282,19 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     } else {
         tcg_gen_brcond_tl(cond, src1, src2, l);
     }
+
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        TCGv type = tcg_constant_tl(CTRDATA_TYPE_NONTAKEN_BRANCH);
+        TCGv dest = tcg_temp_new();
+        TCGv src = tcg_temp_new();
+
+        gen_pc_plus_diff(src, ctx, 0);
+        gen_pc_plus_diff(dest, ctx, ctx->cur_insn_len);
+        gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+    }
+#endif
+
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
     ctx->pc_save = orig_pc_save;
 
@@ -243,6 +307,17 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
         gen_pc_plus_diff(target_pc, ctx, a->imm);
         gen_exception_inst_addr_mis(ctx, target_pc);
     } else {
+#ifndef CONFIG_USER_ONLY
+        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_TAKEN_BRANCH);
+            TCGv dest = tcg_temp_new();
+            TCGv src = tcg_temp_new();
+
+            gen_pc_plus_diff(src, ctx, 0);
+            gen_pc_plus_diff(dest, ctx, a->imm);
+            gen_helper_ctr_add_entry(tcg_env, src, dest, type);
+        }
+#endif
         gen_goto_tb(ctx, 0, a->imm);
     }
     ctx->pc_save = -1;
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index cd234ad960..c77c2b927b 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -203,6 +203,14 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
 
     if (ret) {
         TCGv ret_addr = get_gpr(ctx, xRA, EXT_SIGN);
+#ifndef CONFIG_USER_ONLY
+        if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_RETURN);
+            TCGv src = tcg_temp_new();
+            gen_pc_plus_diff(src, ctx, 0);
+            gen_helper_ctr_add_entry(tcg_env, src, ret_addr, type);
+        }
+#endif
         tcg_gen_mov_tl(cpu_pc, ret_addr);
         tcg_gen_lookup_and_goto_ptr();
         ctx->base.is_jmp = DISAS_NORETURN;
@@ -309,6 +317,19 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
         gen_set_gpr(ctx, xRA, succ_pc);
     }
 
+#ifndef CONFIG_USER_ONLY
+    if (ctx->cfg_ptr->ext_smctr || ctx->cfg_ptr->ext_ssctr) {
+        if (a->index >= 32) {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_DIRECT_CALL);
+            gen_helper_ctr_add_entry(tcg_env, cpu_pc, addr, type);
+        } else {
+            TCGv type = tcg_constant_tl(CTRDATA_TYPE_DIRECT_JUMP);
+            gen_helper_ctr_add_entry(tcg_env, cpu_pc, addr, type);
+        }
+    }
+#endif
+
+
     tcg_gen_mov_tl(cpu_pc, addr);
 
     tcg_gen_lookup_and_goto_ptr();
-- 
2.48.1


