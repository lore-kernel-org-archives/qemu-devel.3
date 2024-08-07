Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C429C49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 00:11:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbUDM-00042I-3j; Tue, 06 Aug 2024 20:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUD2-0002x8-Mc
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:21 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbUCy-0001Cw-1p
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 20:07:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc587361b6so10654775ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722989235; x=1723594035;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Q+e5e5fBDJV914/KCkP7ZJFamC0/3Y1XQsZmCHaCJE=;
 b=K4Bhc0Ih+gKtLcV/rIHJyItIRsnMSB7kpvJ92Np0iMrM4V/z37JmgdPRSLNxtJIXe6
 Ohci29+SqsXwTBSjV2K/hTp3phKqJmaL2rTNu4BfhPYGWPzHttr2Ymtvv5jO7a8aZEB6
 Gb20v9GiMJ9UmI7dcM/dj3nh5sQ+03LniGXhyHBlDPt6hHs2oIk8PWcuOrpR4CCTnG3i
 lB6ynsmLCzQdtQMPV7fZDgqeKqAsBsWX/Wq6rA9OQj1B/tsjl/rKoTJOMlvhUWVY9zfp
 eRE0lrpgAsdOWN7JOvcT0ZM8SmtWSet3tQm35/PM8fbky9lRMaPlu40HtvR/v77nBuXM
 7fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722989235; x=1723594035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Q+e5e5fBDJV914/KCkP7ZJFamC0/3Y1XQsZmCHaCJE=;
 b=sWr5uVBAYXwaD0ppSILj1Mb3dDck51jzKi6nZidYS28IGG6yMFeFPIihIJRn/sEGdw
 UbAa27ZqObOmwSWXciEGRmlGRsyNLgFKRCOpU3XwHXnkfl8WWrPnUVSeQH1wfuy/XUab
 TQF0nqYpjN6owRhy03jf8Ya1Nz5fu4kHRFk9pfMcQEKRRyR8oXtjTNxnLXC050omfGQF
 jO3ivOimHtiwe0+tP8a0BIjazj+MLshLPziBYoKn0E43bJyTNIGgGsFlSM/x2AMDEV23
 BixXh7ojPY1bnPFtpoUFLzROP/8O4mvdzBzuzuTY0GnHuwb5cXbzODswQH6yFVHXy/du
 0uWQ==
X-Gm-Message-State: AOJu0YyOaVLgzYfRrcjLmbZg4a3+qYHNMEXI1I9mLFC4md3Q59t4LEkA
 ABkynxsXoszePAaxoFIpl6zD0ulBowXSRbIoSoleDZKTooaeF5rxGeN55Dm9BRrdlAIL6qtD0rV
 H
X-Google-Smtp-Source: AGHT+IFRd8OltSTsy2aueK7GbTjTAPRffdUhv4pGgFr3kaR5EPeAb8JJEo+md/7WyoGQ3w1tHVZuWw==
X-Received: by 2002:a17:902:c951:b0:1fd:9c2d:2f27 with SMTP id
 d9443c01a7336-1ff572cdd8fmr169693405ad.24.1722989234436; 
 Tue, 06 Aug 2024 17:07:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f59cc2sm93381845ad.92.2024.08.06.17.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 17:07:14 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, palmer@dabbelt.com,
 Alistair.Francis@wdc.com, laurent@vivier.eu, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v3 15/20] target/riscv: shadow stack mmu index for shadow
 stack instructions
Date: Tue,  6 Aug 2024 17:06:46 -0700
Message-ID: <20240807000652.1417776-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240807000652.1417776-1-debug@rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x629.google.com
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

Shadow stack instructions shadow stack mmu index for load/stores.
`MMU_IDX_SS_ACCESS` at bit positon 3 is used as shadow stack index.
Shadow stack mmu index depend on privilege and SUM bit. If shadow stack
accesses happening in user mode, shadow stack mmu index = 0b1000. If
shaodw stack access happening in supervisor mode mmu index = 0b1001. If
shadow stack access happening in supervisor mode with SUM=1 then mmu
index = 0b1010

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu.h                            | 13 ++++++++++
 target/riscv/cpu_helper.c                     |  3 +++
 target/riscv/insn_trans/trans_rva.c.inc       |  8 ++++++
 target/riscv/insn_trans/trans_rvzicfiss.c.inc |  6 +++++
 target/riscv/internals.h                      |  1 +
 target/riscv/translate.c                      | 25 +++++++++++++++++++
 6 files changed, 56 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6da94c417c..3ad220a9fe 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -615,6 +615,19 @@ FIELD(TB_FLAGS, FCFI_ENABLED, 28, 1)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 29, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
 FIELD(TB_FLAGS, BCFI_ENABLED, 30, 1)
+/*
+ * zicfiss shadow stack is special memory on which regular stores aren't
+ * allowed but shadow stack stores are allowed. Shadow stack stores can
+ * happen as `sspush` or `ssamoswap` instructions. `sspush` implicitly
+ * takes shadow stack address from CSR_SSP. But `ssamoswap` takes address
+ * from encoded input register and it will be used by supervisor software
+ * to access (read/write) user shadow stack for setting up rt_frame during
+ * signal delivery. Supervisor software will do so by setting SUM=1. Thus
+ * a TB flag is needed if SUM was 1 during TB generation to correctly
+ * reflect memory permissions to access shadow stack user memory from
+ * supervisor mode.
+ */
+FIELD(TB_FLAGS, SUM, 31, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 5d5da8dce1..ad40b10e74 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -181,6 +181,9 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     fs = EXT_STATUS_DIRTY;
     vs = EXT_STATUS_DIRTY;
 #else
+   flags = FIELD_DP32(flags, TB_FLAGS, SUM,
+                    ((env->mstatus & MSTATUS_SUM) == MSTATUS_SUM));
+
     flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);
 
     flags |= riscv_env_mmu_index(env, 0);
diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index db6c03f6a8..68b71339a3 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -132,6 +132,10 @@ static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
 
     decode_save_opc(ctx);
     src1 = get_address(ctx, a->rs1, 0);
+#ifndef CONFIG_USER_ONLY
+    /* Shadow stack access and thus index is SS TLB index */
+    ss_mmu_idx = get_ss_index(ctx);
+#endif
 
     tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESL));
     gen_set_gpr(ctx, a->rd, dest);
@@ -224,6 +228,10 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
 
     decode_save_opc(ctx);
     src1 = get_address(ctx, a->rs1, 0);
+#ifndef CONFIG_USER_ONLY
+    /* Shadow stack access and thus index is SS TLB index */
+    ss_mmu_idx = get_ss_index(ctx);
+#endif
 
     tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESQ));
     gen_set_gpr(ctx, a->rd, dest);
diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
index c538b7ad99..4e741c061d 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -70,6 +70,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
     TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
     TCGv data = tcg_temp_new();
     gen_helper_csrr(addr, tcg_env, ssp_csr);
+#ifndef CONFIG_USER_ONLY
+    ss_mmu_idx = get_ss_index(ctx);
+#endif
 
     tcg_gen_qemu_ld_tl(data, addr, ss_mmu_idx,
                        mxl_memop(ctx) | MO_ALIGN);
@@ -118,6 +121,9 @@ static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
     TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
     TCGv data = get_gpr(ctx, a->rs2, EXT_NONE);
     gen_helper_csrr(addr, tcg_env, ssp_csr);
+#ifndef CONFIG_USER_ONLY
+    ss_mmu_idx = get_ss_index(ctx);
+#endif
 
     tcg_gen_addi_tl(addr, addr, tmp);
 
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index dad0657c80..5147d6bf90 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -32,6 +32,7 @@
  *  - S+SUM+2STAGE      0b110
  *  - Shadow stack+U   0b1000
  *  - Shadow stack+S   0b1001
+ *  - Shadow stack+SUM 0b1010
  */
 #define MMUIdx_U            0
 #define MMUIdx_S            1
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index de375c32a1..4772191bd8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -122,6 +122,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* SUM was on during tb translation? */
+    bool sum;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1127,6 +1129,29 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     return translator_ldl(env, &ctx->base, pc);
 }
 
+#ifndef CONFIG_USER_ONLY
+static unsigned int get_ss_index(DisasContext *ctx)
+{
+    int ss_mmu_idx = MMU_IDX_SS_ACCESS;
+
+    /*
+     * If priv mode is S then a separate index for supervisor
+     * shadow stack accesses
+     */
+    if (ctx->priv == PRV_S) {
+        ss_mmu_idx |= MMUIdx_S;
+    }
+
+    /* If SUM was set, SS index should have S cleared */
+    if (ctx->sum) {
+        ss_mmu_idx &= ~(MMUIdx_S);
+        ss_mmu_idx |= MMUIdx_S_SUM;
+    }
+
+    return ss_mmu_idx;
+}
+#endif
+
 /* Include insn module translation function */
 #include "insn_trans/trans_rvi.c.inc"
 #include "insn_trans/trans_rvm.c.inc"
-- 
2.44.0


