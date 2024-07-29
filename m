Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DB8C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZT-0006am-Pa; Mon, 29 Jul 2024 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZK-0005iH-3R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZF-0000MX-GN
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70d2b27c115so2804627b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275631; x=1722880431;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0j0hUcpmAEL4SMuZB0D+6b4sLvIuahvRYG7mAVrPJM=;
 b=DJf/Kt7XZ5T5V9NzNePKFJKAqIqC7Bu9c3pzsr6oGDh5NL3hnlExvpLo2vbJ/xjgVm
 DOO7GCgyooAVk43BWV4Zk8oPsYAh7tied3JJAT0Q/nTGYWB2M0eY6zmVxI1+tuoRAXFS
 S+8nZ714xRVx2BBdrsyeYAK9Or6X0sUQpESIWpbUi2be7hRa7/uYxU6VuLzkDb+p1d4I
 NDrx/WcdODSFbs3Nt1bsGcmQY2N7deQaKuaRMRcOV9jsFZSyh8CNy5ILSxUAn9ikN8pQ
 P3TP/9bqBErSfTcp9/8cH8UpvIgm4fLli6SHmnzlDGyiaX5oh+lrKgjZXEeTJQDTWZbd
 +adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275631; x=1722880431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0j0hUcpmAEL4SMuZB0D+6b4sLvIuahvRYG7mAVrPJM=;
 b=qpUHaDv3watn/5VUvEQpwwusJWFqirgVbYfFAxa7UwtY9ypHT5pG0lgFF3N09hciqB
 T0JlR9YlSO5xUoiLBZRb+BP/iNssXz2s3h+VPTtlx6j5yw7ht+WCH78C34c+O2Sk4lpH
 Lh7fpAQp6yQqGHYVLiONcqpcN6vr+kyEg7KJrpvMYWveqLoo/vrMXDKkEDI5jM+SYNpr
 PPDrm9M/mEk/aatfgpbyCZi2vWdMMo+E+ZD1W1Dh/+LbDFqQ09fIa8SBcSogwSniPdGP
 G2StKQtXGRIbDdodN0RMUTp1kjFoyNN5AIx9Jy6ZS7OH9i5VirhBSUDpJWlBImZTr3yb
 Hi4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMJHNXCYtaaIB0ZmQdeETMo/SkTe0JpTWh12tkKk0jZ/r0uOEC2Z/UU2Ye+YT3Kdls8d/OdjL0oMIheo1+U5QBuUoerlw=
X-Gm-Message-State: AOJu0Yw/+fo8e20VKq0fXyWK+efYFJw5iyM0LjcrUyD0a5vHjywjDzql
 Spa4TN966eF7r7iqXSyTN7x6N04pYbmt+5CMOctnJhKnIJnologyW3IZHt4Psb4=
X-Google-Smtp-Source: AGHT+IEvGc8T9JROztJKuD9M/RaY8RkvfyNt0AAn7xgRCX7XbKebDySXoG1psOd7clCUbATozjjuAQ==
X-Received: by 2002:a05:6a20:a110:b0:1c4:5361:b72e with SMTP id
 adf61e73a8af0-1c4a13a37b7mr10504788637.35.1722275630744; 
 Mon, 29 Jul 2024 10:53:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:50 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 16/24] target/riscv: shadow stack mmu index for shadow
 stack instructions
Date: Mon, 29 Jul 2024 10:53:18 -0700
Message-ID: <20240729175327.73705-17-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42e.google.com
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
index 0e0a9d2be1..82475490ab 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -614,6 +614,19 @@ FIELD(TB_FLAGS, AXL, 26, 2)
 FIELD(TB_FLAGS, FCFI_LP_EXPECTED, 28, 1)
 /* zicfiss needs a TB flag so that correct TB is located based on tb flags */
 FIELD(TB_FLAGS, BCFI_ENABLED, 29, 1)
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
+FIELD(TB_FLAGS, SUM, 30, 1)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7942587a56..b2bb1e4293 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -180,6 +180,9 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
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
index bac65d4166..9c3c872f59 100644
--- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
+++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
@@ -69,6 +69,9 @@ static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
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
index 9152a963ee..ad0f841807 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -123,6 +123,8 @@ typedef struct DisasContext {
     bool fcfi_lp_expected;
     /* zicfiss extension, if shadow stack was enabled during TB gen */
     bool bcfi_enabled;
+    /* SUM was on during tb translation? */
+    bool sum;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1128,6 +1130,29 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
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


