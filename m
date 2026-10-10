Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F980CA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 06:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFQCs-0002hE-OK; Sat, 10 Oct 2026 02:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCl-0002do-SI; Sat, 10 Oct 2026 02:05:11 -0400
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xFQCf-00040l-Be; Sat, 10 Oct 2026 02:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1791612286; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=Svx8WkZ7B06T/s2y8MWscHkz4ilqyR4SNT2ORUjlDcw=;
 b=w72+Cnbm2zSXV8EpZisH6fZ3vmODvZD7p2Sx+wnOpg48Zf7gNz43SfoKaf4LnFT6g8ClwLS6G++6VbRdWxFrRxQhajNgPl/lM9Lh35hf8/rBnJpCjTCfhldCEFBaC7ZcqX8mk0/bHX8c2A64QM9uLvNDx/eBs6+TbaVlE4muSM8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XCVKGtF_1791612285; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XCVKGtF_1791612285 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 10 Oct 2026 14:04:45 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Sat, 10 Oct 2026 14:04:30 +0800
Subject: [PATCH v3 06/14] target/riscv: Fix RV32 accesses to delegated PMU
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-riscv-pmu-correctness-v3-6-712bf814a7be@linux.alibaba.com>
References: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
In-Reply-To: <20261010-riscv-pmu-correctness-v3-0-712bf814a7be@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791612280; l=19410;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=Z0GWFFF0V9zTvimWSjLi1fkQ1snBQgJl1Rf6EWHFNFA=;
 b=sy5EocG/ogyseEXCPvEucNcSYMXsqlFII2+TDZNXozcTswxppXyRERmpSEp3sa8X7XrsktgAt
 l0ILdaaC9T/CfK2Sc7AaoDqKE6Nmhm+67dRugjqW8XvZpPgm5OSsXKC
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Delegated PMU writes compare the full-write mask with -1 in its C type,
rejecting valid RV32 writes. Counter widths and high-half access checks
also use MXLEN, so RV32 S-mode on an RV64 CPU cannot access the high half
and low-half counter writes overwrite all 64 bits.

Use the current XLEN for delegated masks, counter widths and high-half
checks, as required by Smcsrind. Keep MXLEN for direct counter accesses
and retain the 64-bit selector merge mask to preserve the unwritten half.

Test RV32 CPUs in both system emulators and RV32 S-mode on an RV64 CPU,
including half preservation, machine MINH and RV64 M-mode alias accesses.

Fixes: 6247dc2ef70b ("target/riscv: Add counter delegation/configuration support")
Fixes: c9efdb7b63a4 ("target/riscv: Combine mhpmevent and mhpmeventh")
Link: https://docs.riscv.org/reference/isa/v20260120/priv/indirect-csr.html
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/csr.c               |  40 +++---
 target/riscv/tcg/pmu.c               |   6 +-
 target/riscv/tcg/pmu.h               |   3 +-
 tests/tcg/riscv32/smcdeleg-rv32.S    | 115 +++++++++++++++++
 tests/tcg/riscv32/system/meson.build |   7 ++
 tests/tcg/riscv64/smcdeleg-sxl32.S   | 233 +++++++++++++++++++++++++++++++++++
 tests/tcg/riscv64/system/meson.build |  31 +++++
 7 files changed, 412 insertions(+), 23 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 504e9e145bd7fbd85904e6d3a0b5279328ed4e19..e563a77a567fa3bbca0bc79375099cfab0e43ac7 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1360,10 +1360,10 @@ static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
 }
 
 static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
-                                          uint32_t ctr_idx)
+                                          uint32_t ctr_idx, RISCVMXL xl)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    bool rv32 = xl == MXL_RV32;
     int deposit_size = rv32 ? 32 : 64;
     uint64_t ctr;
 
@@ -1421,7 +1421,7 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
 {
     int ctr_idx = csrno - CSR_MCYCLE;
 
-    return riscv_pmu_write_ctr(env, val, ctr_idx);
+    return riscv_pmu_write_ctr(env, val, ctr_idx, riscv_cpu_mxl(env));
 }
 
 static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
@@ -1433,10 +1433,11 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                  bool upper_half, uint32_t ctr_idx)
+                                  bool upper_half, uint32_t ctr_idx,
+                                  RISCVMXL xl)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    bool rv32 = xl == MXL_RV32;
     int start = upper_half ? 32 : 0;
     int length = rv32 ? 32 : 64;
     uint64_t ctr_val;
@@ -1485,7 +1486,7 @@ static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-    return riscv_pmu_read_ctr(env, val, false, ctr_index);
+    return riscv_pmu_read_ctr(env, val, false, ctr_index, riscv_cpu_mxl(env));
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
@@ -1501,21 +1502,23 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-    return riscv_pmu_read_ctr(env, val, true, ctr_index);
+    return riscv_pmu_read_ctr(env, val, true, ctr_index, riscv_cpu_mxl(env));
 }
 
 static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
                               target_ulong *val, target_ulong new_val,
                               target_ulong wr_mask)
 {
-    if (wr_mask != 0 && wr_mask != -1) {
+    uint64_t xlen_mask = env->xl == MXL_RV32 ? UINT32_MAX : UINT64_MAX;
+
+    if (wr_mask != 0 && wr_mask != xlen_mask) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        riscv_pmu_read_ctr(env, val, false, ctr_idx);
+        riscv_pmu_read_ctr(env, val, false, ctr_idx, env->xl);
     } else if (wr_mask) {
-        riscv_pmu_write_ctr(env, new_val, ctr_idx);
+        riscv_pmu_write_ctr(env, new_val, ctr_idx, env->xl);
     } else {
         return -EINVAL;
     }
@@ -1527,12 +1530,12 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
                                target_ulong *val, target_ulong new_val,
                                target_ulong wr_mask)
 {
-    if (wr_mask != 0 && wr_mask != -1) {
+    if (wr_mask != 0 && wr_mask != UINT32_MAX) {
         return -EINVAL;
     }
 
     if (!wr_mask && val) {
-        riscv_pmu_read_ctr(env, val, true, ctr_idx);
+        riscv_pmu_read_ctr(env, val, true, ctr_idx, env->xl);
     } else if (wr_mask) {
         riscv_pmu_write_ctrh(env, new_val, ctr_idx);
     } else {
@@ -1547,8 +1550,9 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
                             uint64_t wr_mask)
 {
     uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
+    uint64_t xlen_mask = env->xl == MXL_RV32 ? UINT32_MAX : UINT64_MAX;
 
-    if (wr_mask != 0 && wr_mask != -1) {
+    if (wr_mask != 0 && wr_mask != xlen_mask) {
         return -EINVAL;
     }
 
@@ -1576,7 +1580,7 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
     uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
     uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
 
-    if (wr_mask != 0 && wr_mask != -1) {
+    if (wr_mask != 0 && wr_mask != UINT32_MAX) {
         return -EINVAL;
     }
 
@@ -1633,10 +1637,6 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 {
     uint64_t cfgh;
 
-    if (riscv_cpu_mxl(env) != MXL_RV32) {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-
     switch (cfg_index) {
     case 0:         /* CYCLECFGH */
         cfgh = extract64(env->mcyclecfg, 32, 32);
@@ -2812,9 +2812,9 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
         goto done;
     }
 
-    /* sireg4 and sireg5 provides access RV32 only CSRs */
+    /* Delegated high halves are accessible only when the current XLEN is 32. */
     if (((csrno == CSR_SIREG5) || (csrno == CSR_SIREG4)) &&
-        (riscv_cpu_mxl(env) != MXL_RV32)) {
+        env->xl != MXL_RV32) {
         ret = RISCV_EXCP_ILLEGAL_INST;
         goto done;
     }
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index ea0ffe41258d4dbef9dc952655e6301c14ba1d23..54fff2ba49c1034d5fa6db1c7b19ff59003cd1e1 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -372,10 +372,12 @@ static void pmu_timer_trigger_irq_counter(RISCVCPU *cpu, uint32_t ctr_idx)
         return;
     }
 
-    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
+    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx,
+                        riscv_cpu_mxl(env));
     ctr_val = counter->mhpmcounter_val;
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
+        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx,
+                            riscv_cpu_mxl(env));
         curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
     }
 
diff --git a/target/riscv/tcg/pmu.h b/target/riscv/tcg/pmu.h
index 339a4b3ac09c4a91cddd9250824284203b16b4fa..bf2e8373474d471d914f8801c55d2f6ffbb5cdd3 100644
--- a/target/riscv/tcg/pmu.h
+++ b/target/riscv/tcg/pmu.h
@@ -38,6 +38,7 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env, privilege_mode_t newpriv,
                                  bool new_virt);
 void riscv_pmu_decr_instret(CPURISCVState *env);
 RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
-                                  bool upper_half, uint32_t ctr_idx);
+                                  bool upper_half, uint32_t ctr_idx,
+                                  RISCVMXL xl);
 
 #endif /* RISCV_PMU_H */
diff --git a/tests/tcg/riscv32/smcdeleg-rv32.S b/tests/tcg/riscv32/smcdeleg-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..7b7c1db5bd3cbb59397a573adf0f7d685a1db3d8
--- /dev/null
+++ b/tests/tcg/riscv32/smcdeleg-rv32.S
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* RV32 delegated PMU registers, in both RV32 and RV64 emulators. */
+
+/* CSR numbers for older assemblers. */
+#define CSR_SISELECT         0x150
+#define CSR_SIREG            0x151
+#define CSR_SIREG2           0x152
+#define CSR_SIREG4           0x155
+#define CSR_SIREG5           0x156
+#define CSR_MENVCFGH         0x31a
+#define CSR_MHPMEVENT3H      0x723
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global	_start
+_start:
+	/* Unexpected exceptions report the current check number. */
+	li	t4, 1
+	lla	t0, fail
+	csrw	mtvec, t0
+	li	t0, 8			/* Stop HPM3 so reads are exact. */
+	csrw	mcountinhibit, t0
+	csrw	mcounteren, t0
+	li	t0, 1 << 28		/* menvcfgh.CDE */
+	csrw	CSR_MENVCFGH, t0
+	li	t0, 0x43		/* siselect: counter 3 */
+	csrw	CSR_SISELECT, t0
+	li	t0, 0x12345678
+	csrw	mhpmcounter3h, t0
+	li	t0, 1			/* HW_CPU_CYCLES */
+	csrw	mhpmevent3, t0
+	li	t0, 0xc0000000		/* OF | MINH */
+	csrw	CSR_MHPMEVENT3H, t0
+
+	/* sireg writes the low half without changing the high half. */
+	li	t0, 0x2468ace0
+	csrw	CSR_SIREG, t0
+	csrr	t1, CSR_SIREG
+	bne	t0, t1, fail
+	csrr	t1, mhpmcounter3
+	bne	t0, t1, fail
+	li	t0, 0x12345678
+	csrr	t1, mhpmcounter3h
+	bne	t0, t1, fail
+
+	/* sireg4 writes the high half without changing the low half. */
+	li	t4, 2
+	li	t0, 0xfedcba98
+	csrw	CSR_SIREG4, t0
+	csrr	t1, CSR_SIREG4
+	bne	t0, t1, fail
+	csrr	t1, mhpmcounter3h
+	bne	t0, t1, fail
+	li	t0, 0x2468ace0
+	csrr	t1, mhpmcounter3
+	bne	t0, t1, fail
+
+	/* sireg5 clears OF and sets SINH, but cannot change machine MINH. */
+	li	t4, 3
+	li	t0, 0x20000000		/* SINH */
+	csrw	CSR_SIREG5, t0
+	csrr	t1, CSR_SIREG5
+	bne	t0, t1, fail
+	li	t0, 0x60000000		/* MINH | SINH */
+	csrr	t1, CSR_MHPMEVENT3H
+	bne	t0, t1, fail
+	li	t0, 1
+	csrr	t1, mhpmevent3
+	bne	t0, t1, fail
+
+	/* sireg2 changes the event without changing those high-half bits. */
+	li	t4, 4
+	li	t0, 2			/* HW_INSTRUCTIONS */
+	csrw	CSR_SIREG2, t0
+	csrr	t1, mhpmevent3
+	bne	t0, t1, fail
+	li	t0, 0x60000000
+	csrr	t1, CSR_MHPMEVENT3H
+	bne	t0, t1, fail
+
+	/* Event replacement must also preserve OF when it is set. */
+	li	t4, 5
+	li	t0, 0xe0000000		/* OF | MINH | SINH */
+	csrw	CSR_MHPMEVENT3H, t0
+	li	t0, 1			/* HW_CPU_CYCLES */
+	csrw	mhpmevent3, t0
+	li	t0, 2			/* HW_INSTRUCTIONS */
+	csrw	CSR_SIREG2, t0
+	csrr	t1, mhpmevent3
+	bne	t0, t1, fail
+	li	t0, 0xe0000000
+	csrr	t1, CSR_MHPMEVENT3H
+	bne	t0, t1, fail
+
+	/* Selecting event zero must also leave the high half unchanged. */
+	li	t4, 6
+	csrw	CSR_SIREG2, zero
+	csrr	t1, mhpmevent3
+	bnez	t1, fail
+	csrr	t1, CSR_MHPMEVENT3H
+	bne	t0, t1, fail
+
+	li	t0, 0x5555		/* FINISHER_PASS */
+	j	finish
+fail:
+	slli	t0, t4, 16
+	li	t1, 0x3333		/* FINISHER_FAIL with check number */
+	or	t0, t0, t1
+finish:
+	li	t1, 0x100000		/* virt test device */
+	sw	t0, 0(t1)
+	j	.
diff --git a/tests/tcg/riscv32/system/meson.build b/tests/tcg/riscv32/system/meson.build
index d1916abaacd928dc708437b75ac974fb9cfdca85..f1506d06967d64ce3e908f35ee82c2442b2556fb 100644
--- a/tests/tcg/riscv32/system/meson.build
+++ b/tests/tcg/riscv32/system/meson.build
@@ -36,6 +36,13 @@ tests += {
   },
 }
 
+tests += {
+  'smcdeleg-rv32.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
 if 'qemu-system-riscv32' in emulators
   tcg_tests += {
     'riscv32-softmmu': {
diff --git a/tests/tcg/riscv64/smcdeleg-sxl32.S b/tests/tcg/riscv64/smcdeleg-sxl32.S
new file mode 100644
index 0000000000000000000000000000000000000000..3c5fc2b174c8f18988943f6b4bb9c07ca5dcd53d
--- /dev/null
+++ b/tests/tcg/riscv64/smcdeleg-sxl32.S
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* CSR numbers for older assemblers. */
+#define CSR_SISELECT         0x150
+#define CSR_SIREG            0x151
+#define CSR_SIREG2           0x152
+#define CSR_SIREG4           0x155
+#define CSR_SIREG5           0x156
+#define CSR_MENVCFG          0x30a
+#define CSR_MSTATEEN0        0x30c
+#define CSR_MCYCLECFG        0x321
+#define CSR_MINSTRETCFG      0x322
+
+/*
+ * Exercise delegated PMU registers with MXLEN=64 and SXLEN=32.
+ * Build separately for counter low halves, counter high halves and configs
+ * so a failure in one access path does not hide failures in the others.
+ */
+
+	.option	norvc
+	.option	norelax
+
+	/* RV64 'li' can emit ADDIW, which is illegal in the RV32 blocks. */
+	.macro	load32 reg, value
+	lui	\reg, %hi(\value)
+	addi	\reg, \reg, %lo(\value)
+	.endm
+
+	/* Enter RV32 S-mode; the ECALL trap below returns to M-mode. */
+	.macro	enter_s32 label
+	li	a0, 0
+	li	a5, 9			/* Expected exception: S-mode ECALL. */
+	li	t0, 3 << 11
+	csrc	mstatus, t0
+	li	t0, 1 << 11
+	csrs	mstatus, t0		/* MPP=S */
+	lla	t0, \label
+	csrw	mepc, t0
+	mret
+	.endm
+
+	/* Each alias must be 64-bit in M-mode, even while SXLEN is 32. */
+	.macro	check_m64_alias csr
+	li	t0, 0x1234567811223344
+	csrw	CSR_SIREG, t0
+	csrr	t1, \csr
+	bne	t0, t1, fail
+	csrr	t1, CSR_SIREG
+	bne	t0, t1, fail
+
+	/* High-half aliases must still trap when the current XLEN is 64. */
+	li	a0, 0
+	li	a5, 2			/* Expect illegal instruction. */
+	li	s9, 0
+	csrr	t0, CSR_SIREG4
+	csrr	t0, CSR_SIREG5
+	li	t0, 2
+	bne	s9, t0, fail		/* Both accesses must have trapped. */
+	.endm
+
+	.macro	check_counter index, csr
+	li	s10, \index + 1		/* Counter-specific failure code. */
+	li	t0, 0x40 + \index
+	csrw	CSR_SISELECT, t0
+	check_m64_alias \csr
+	enter_s32 .Ls_counter\@
+.Ls_counter\@:
+#ifdef TEST_HIGH_HALF
+	csrr	t0, CSR_SIREG4		/* sireg4: original high half */
+	load32 t1, 0x12345678
+	bne	t0, t1, .Ls_fail\@
+	load32 t0, 0x07654321
+	csrw	CSR_SIREG4, t0
+	csrr	t1, CSR_SIREG4
+	bne	t0, t1, .Ls_fail\@
+	/* A high-half write must preserve the low half. */
+	csrr	t0, CSR_SIREG
+	load32 t1, 0x11223344
+#else
+	csrr	t0, CSR_SIREG		/* sireg: original low half */
+	load32 t1, 0x11223344
+	bne	t0, t1, .Ls_fail\@
+	load32 t0, 0x55667788
+	csrw	CSR_SIREG, t0
+	csrr	t1, CSR_SIREG
+#endif
+	bne	t0, t1, .Ls_fail\@
+	li	a0, 0
+	j	.Ls_done\@
+.Ls_fail\@:
+	mv	a0, s10
+.Ls_done\@:
+	ecall
+
+	/* Read the complete machine counter to check the unwritten half. */
+	csrr	t0, \csr
+#ifdef TEST_HIGH_HALF
+	li	t1, 0x0765432111223344
+#else
+	li	t1, 0x1234567855667788
+#endif
+	bne	t0, t1, fail
+	.endm
+
+	.macro	check_config index, csr, old_low, new_low
+	li	s10, \index + 1
+	li	t0, 0x40 + \index
+	csrw	CSR_SISELECT, t0
+	li	t0, 0x6000000000000000 | \old_low /* MINH | SINH */
+	csrw	\csr, t0
+	enter_s32 .Ls_config\@
+.Ls_config\@:
+	csrr	t0, CSR_SIREG2		/* sireg2: config/selector low half */
+	li	t1, \old_low
+	bne	t0, t1, .Lcfg_fail\@
+	li	t0, \new_low
+	csrw	CSR_SIREG2, t0
+	csrr	t1, CSR_SIREG2
+	bne	t0, t1, .Lcfg_fail\@
+
+	/* Low-half writes preserve the high half; MINH reads as zero. */
+	csrr	t0, CSR_SIREG5
+	li	t1, 0x20000000		/* SINH, without MINH */
+	bne	t0, t1, .Lcfg_fail\@
+	li	t0, 0x10000000		/* Replace SINH with UINH. */
+	csrw	CSR_SIREG5, t0
+	csrr	t1, CSR_SIREG5
+	bne	t0, t1, .Lcfg_fail\@
+	csrr	t0, CSR_SIREG2
+	li	t1, \new_low
+	bne	t0, t1, .Lcfg_fail\@
+	li	a0, 0
+	j	.Lcfg_done\@
+.Lcfg_fail\@:
+	mv	a0, s10
+.Lcfg_done\@:
+	ecall
+
+	/* Both the low half and the machine-only MINH bit must be retained. */
+	csrr	t0, \csr
+	li	t1, 0x5000000000000000 | \new_low /* MINH | UINH */
+	bne	t0, t1, fail
+	.endm
+
+	.text
+	.global	_start
+_start:
+	li	s10, 31			/* Setup failure. */
+	lla	t0, trap
+	csrw	mtvec, t0
+	csrw	medeleg, zero
+	csrw	mie, zero
+	li	t0, -1
+	/* Freeze counters for exact comparisons. */
+	csrw	mcountinhibit, t0
+	csrw	mcounteren, t0
+	csrw	pmpaddr0, t0
+	li	t0, 0x1f		/* Allow S-mode access to RAM. */
+	csrw	pmpcfg0, t0
+	li	t0, 1 << 60
+	csrw	CSR_MENVCFG, t0		/* CDE */
+	/* mstateen0: allow indirect CSRs. */
+	csrw	CSR_MSTATEEN0, t0
+
+	/* Select RV32 for lower privilege modes; M-mode remains RV64. */
+	csrr	t0, mstatus
+	li	t1, (3 << 34) | (3 << 32)
+	not	t1, t1
+	and	t0, t0, t1
+	li	t1, (1 << 34) | (1 << 32)
+	or	t0, t0, t1
+	csrw	mstatus, t0
+	csrr	t0, mstatus
+	srli	t0, t0, 34
+	andi	t0, t0, 3
+	li	t1, 1
+	bne	t0, t1, fail
+
+#ifdef TEST_CONFIG
+	check_config 0, CSR_MCYCLECFG, 0, 0
+	check_config 2, CSR_MINSTRETCFG, 0, 0
+	/* mhpmevent3: cycles -> instructions */
+	check_config 3, mhpmevent3, 1, 2
+#else
+	li	t0, 1
+	csrw	mhpmevent3, t0		/* HPM3 counts cycles. */
+	li	t0, 2
+	csrw	mhpmevent4, t0		/* HPM4 counts instructions. */
+	/* HPM5 has no selected event. */
+	csrw	mhpmevent5, zero
+	check_counter 0, mcycle
+	check_counter 2, minstret
+	check_counter 3, mhpmcounter3
+	check_counter 4, mhpmcounter4
+	check_counter 5, mhpmcounter5
+#endif
+	li	a0, 0
+	j	exit
+
+	.balign	4
+trap:
+	csrr	t0, mcause
+	bne	t0, a5, fail
+	bnez	a0, exit
+	addi	s9, s9, 1
+	csrr	t0, mepc
+	/* Zero-extend the RV32 trap PC for physical addressing in M-mode. */
+	slli	t0, t0, 32
+	srli	t0, t0, 32
+	addi	t0, t0, 4
+	csrw	mepc, t0
+	li	t0, 3 << 11
+	csrs	mstatus, t0		/* Resume in M-mode. */
+	mret
+
+fail:
+	mv	a0, s10
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index 6af497a1a41debe58dfa329060510bd896c88ac7..679ccf414208b0c84b0de1e7beea7201cb4d6b70 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -61,6 +61,37 @@ tests += {
   }
 }
 
+# Exercise RV32 CSRs with the RV64 emulator's 64-bit target_ulong.
+tests += {
+  '../riscv32/smcdeleg-rv32.S': {
+    'cflags': cflags + ['-march=rv32im_zicsr', '-mabi=ilp32'],
+    'qemu_args': ['-cpu', 'rv32,smcdeleg=true,ssccfg=true,sscofpmf=true', qemu_args],
+  },
+}
+
+tests += {
+  'smcdeleg-sxl32.S': {
+    'cflags': cflags,
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
+tests += {
+  'smcdeleg-sxl32.S': {
+    'exe_name': 'smcdeleg-sxl32-high',
+    'cflags': cflags + ['-DTEST_HIGH_HALF'],
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
+tests += {
+  'smcdeleg-sxl32.S': {
+    'exe_name': 'smcdeleg-sxl32-cfg',
+    'cflags': cflags + ['-DTEST_CONFIG'],
+    'qemu_args': ['-cpu', 'max', qemu_args],
+  },
+}
+
 tests += {
   'sscofpmf-overflow.S': {
     'cflags': cflags,

-- 
2.43.0


