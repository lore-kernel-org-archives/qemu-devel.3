Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32206C79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 16:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Fsd-0002yw-1c; Sun, 06 Sep 2026 12:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsZ-0002wg-PY; Sun, 06 Sep 2026 12:38:03 -0400
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1x3FsP-00033j-2o; Sun, 06 Sep 2026 12:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1788712655; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=waY5yx8GQpkd/QlH6r0keWNmP1y1xKVsntWQ9/jG6as=;
 b=CgPkvcHX6pdst/M0w3knMcTukODSoV6Gv/+IV2WQW4B9uEo9e1FRml0kq2gWNW6lk0CyhhMmSwze6lRaB68TqTv28oXdYsPjernw2tveGqu0Q44QFfa6W+eJoY5MhmLD1YdfBIgXrXn4UuRGIlIdB7k+JLN7TaE4n2e0N6K6XIk=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R961e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0XANKIJ7_1788712653; 
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XANKIJ7_1788712653 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 07 Sep 2026 00:37:34 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Mon, 07 Sep 2026 00:37:22 +0800
Subject: [PATCH 06/14] target/riscv: Fix RV32 accesses to delegated PMU
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-riscv-pmu-correctness-v1-6-5f1f41458989@linux.alibaba.com>
References: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
In-Reply-To: <20260907-riscv-pmu-correctness-v1-0-5f1f41458989@linux.alibaba.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788712649; l=20779;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=OdgJvva4rE/W6mRjxi/71pHc3YXppF1NxJk3kd8P5Mw=;
 b=YXTIZhHrIvKll3MB0C8MkB7I+UB9J6FvcTXOMRazhvjQ/L3jd5FsC+jVWwDYxe2RaDVbas7sM
 aiV3ItZRLgBBobMu2tDys/6N4AT/mmC4MhdY/3K/LNWPJVMI92iu/94
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 target/riscv/tcg/csr.c                    |  43 +++---
 target/riscv/tcg/pmu.c                    |   6 +-
 target/riscv/tcg/pmu.h                    |   3 +-
 tests/tcg/riscv32/Makefile.softmmu-target |   8 ++
 tests/tcg/riscv32/smcdeleg-counter-rv32.S |  84 ++++++++++++
 tests/tcg/riscv32/smcdeleg-event-rv32.S   |  69 ++++++++++
 tests/tcg/riscv64/Makefile.softmmu-target |  25 ++++
 tests/tcg/riscv64/smcdeleg-sxl32.S        | 219 ++++++++++++++++++++++++++++++
 8 files changed, 434 insertions(+), 23 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index f9f43a9c12e1afdbdf6c7202c167988389963c10..d72368ccb5a1bd5f26a20b8e4a3c214b842afba6 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1357,10 +1357,10 @@ static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
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
 
@@ -1418,7 +1418,7 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
 {
     int ctr_idx = csrno - CSR_MCYCLE;
 
-    return riscv_pmu_write_ctr(env, val, ctr_idx);
+    return riscv_pmu_write_ctr(env, val, ctr_idx, riscv_cpu_mxl(env));
 }
 
 static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
@@ -1430,10 +1430,11 @@ static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
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
@@ -1482,7 +1483,7 @@ static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
-    return riscv_pmu_read_ctr(env, val, false, ctr_index);
+    return riscv_pmu_read_ctr(env, val, false, ctr_index, riscv_cpu_mxl(env));
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
@@ -1498,21 +1499,23 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
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
@@ -1524,12 +1527,14 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
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
-        riscv_pmu_read_ctr(env, val, true, ctr_idx);
+        riscv_pmu_read_ctr(env, val, true, ctr_idx, env->xl);
     } else if (wr_mask) {
         riscv_pmu_write_ctrh(env, new_val, ctr_idx);
     } else {
@@ -1544,8 +1549,9 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int ctr_idx,
                             uint64_t wr_mask)
 {
     uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
+    uint64_t xlen_mask = env->xl == MXL_RV32 ? UINT32_MAX : UINT64_MAX;
 
-    if (wr_mask != 0 && wr_mask != -1) {
+    if (wr_mask != 0 && wr_mask != xlen_mask) {
         return -EINVAL;
     }
 
@@ -1572,8 +1578,9 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int ctr_idx,
 {
     uint64_t mhpmevt_val = env->mhpmevent_val[ctr_idx];
     uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
+    uint64_t xlen_mask = env->xl == MXL_RV32 ? UINT32_MAX : UINT64_MAX;
 
-    if (wr_mask != 0 && wr_mask != -1) {
+    if (wr_mask != 0 && wr_mask != xlen_mask) {
         return -EINVAL;
     }
 
@@ -1630,10 +1637,6 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 {
     uint64_t cfgh;
 
-    if (riscv_cpu_mxl(env) != MXL_RV32) {
-        return RISCV_EXCP_ILLEGAL_INST;
-    }
-
     switch (cfg_index) {
     case 0:         /* CYCLECFGH */
         cfgh = extract64(env->mcyclecfg, 32, 32);
@@ -2809,9 +2812,9 @@ static int rmw_xireg_cd(CPURISCVState *env, int csrno,
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
diff --git a/tests/tcg/riscv32/Makefile.softmmu-target b/tests/tcg/riscv32/Makefile.softmmu-target
index 43c162fd337f7b0d5d3e4dedb3f5b06b2821fd88..1316eadc033f15af819eae4416c0d37494fb3184 100644
--- a/tests/tcg/riscv32/Makefile.softmmu-target
+++ b/tests/tcg/riscv32/Makefile.softmmu-target
@@ -24,3 +24,11 @@ run-smcdeleg-minh-rv32: smcdeleg-minh-rv32
 TESTS += pmu-minstretcfg-rv32
 run-pmu-minstretcfg-rv32: pmu-minstretcfg-rv32
 	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+
+TESTS += smcdeleg-event-rv32
+run-smcdeleg-event-rv32: smcdeleg-event-rv32
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+
+TESTS += smcdeleg-counter-rv32
+run-smcdeleg-counter-rv32: smcdeleg-counter-rv32
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
diff --git a/tests/tcg/riscv32/smcdeleg-counter-rv32.S b/tests/tcg/riscv32/smcdeleg-counter-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..1f130f316e95dcbbb9aeee06001553a7fe8ae46d
--- /dev/null
+++ b/tests/tcg/riscv32/smcdeleg-counter-rv32.S
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* RV32 delegated counter accesses must also work in the RV64 emulator. */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/* Unexpected exceptions report the current check number. */
+	li	t4, 1
+	lla	t0, fail
+	csrw	mtvec, t0
+	li	t0, 8			/* Stop HPM3 so reads are exact. */
+	csrw	mcountinhibit, t0
+	csrw	mcounteren, t0
+	li	t0, 1 << 28		/* menvcfgh.CDE */
+	csrw	0x31a, t0
+	li	t0, 0x43		/* siselect: counter 3 */
+	csrw	0x150, t0
+	li	t0, 0x12345678
+	csrw	0xb83, t0		/* mhpmcounter3h */
+	li	t0, 1			/* HW_CPU_CYCLES */
+	csrw	0x323, t0
+	li	t0, 0xc0000000		/* OF | MINH */
+	csrw	0x723, t0
+
+	/* sireg writes the low half without changing the high half. */
+	li	t0, 0x2468ace0
+	csrw	0x151, t0
+	csrr	t1, 0x151
+	bne	t0, t1, fail
+	csrr	t1, 0xb03
+	bne	t0, t1, fail
+	li	t0, 0x12345678
+	csrr	t1, 0xb83
+	bne	t0, t1, fail
+
+	/* sireg4 writes the high half without changing the low half. */
+	li	t4, 2
+	li	t0, 0xfedcba98
+	csrw	0x155, t0
+	csrr	t1, 0x155
+	bne	t0, t1, fail
+	csrr	t1, 0xb83
+	bne	t0, t1, fail
+	li	t0, 0x2468ace0
+	csrr	t1, 0xb03
+	bne	t0, t1, fail
+
+	/* sireg5 clears OF and sets SINH, but cannot change machine MINH. */
+	li	t4, 3
+	li	t0, 0x20000000		/* SINH */
+	csrw	0x156, t0
+	csrr	t1, 0x156
+	bne	t0, t1, fail
+	li	t0, 0x60000000		/* MINH | SINH */
+	csrr	t1, 0x723
+	bne	t0, t1, fail
+	li	t0, 1
+	csrr	t1, 0x323
+	bne	t0, t1, fail
+
+	/* sireg2 changes the event without changing those high-half bits. */
+	li	t4, 4
+	li	t0, 2			/* HW_INSTRUCTIONS */
+	csrw	0x152, t0
+	csrr	t1, 0x323
+	bne	t0, t1, fail
+	li	t0, 0x60000000
+	csrr	t1, 0x723
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
diff --git a/tests/tcg/riscv32/smcdeleg-event-rv32.S b/tests/tcg/riscv32/smcdeleg-event-rv32.S
new file mode 100644
index 0000000000000000000000000000000000000000..ee3063a7f5486e7fac53e6035f63fe2d9826611c
--- /dev/null
+++ b/tests/tcg/riscv32/smcdeleg-event-rv32.S
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* RV32 sireg2 writes replace only the low half of a delegated selector. */
+
+	.option	norvc
+	.option	norelax
+
+	.text
+	.global _start
+_start:
+	/* Any unexpected exception fails with the current check number. */
+	li	t4, 1
+	lla	t0, exit
+	csrw	mtvec, t0
+	li	t0, 8			/* mcountinhibit.HPM3 */
+	csrs	mcountinhibit, t0
+	li	t0, 0xe0000000		/* OF | MINH | SINH */
+	csrw	0x723, t0		/* mhpmevent3h */
+	li	t0, 1			/* HW_CPU_CYCLES */
+	csrw	0x323, t0		/* mhpmevent3 */
+
+	li	t0, 1 << 28		/* menvcfgh.CDE */
+	csrw	0x31a, t0
+	li	t0, 8			/* Delegate counter 3. */
+	csrw	mcounteren, t0
+	li	t0, 0x43
+	csrw	0x150, t0		/* siselect: counter 3 */
+
+	/* Replace the event without changing OF or the privilege filters. */
+	li	t0, 2			/* HW_INSTRUCTIONS */
+	csrw	0x152, t0		/* sireg2: hpmevent3 */
+	li	t4, 2
+	csrr	t1, 0x323
+	bne	t0, t1, exit
+	li	t4, 3
+	li	t0, 0xe0000000
+	csrr	t1, 0x723
+	bne	t0, t1, exit
+
+	/* Selecting event zero must also leave the high half unchanged. */
+	li	t4, 4
+	csrw	0x152, zero
+	li	t4, 5
+	csrr	t1, 0x323
+	bnez	t1, exit
+	li	t4, 6
+	csrr	t1, 0x723
+	bne	t0, t1, exit
+	li	t4, 0
+
+	.balign	4
+exit:
+	lla	a1, semiargs
+	li	t0, 0x20026		/* ADP_Stopped_ApplicationExit */
+	sw	t0, 0(a1)
+	sw	t4, 4(a1)
+	li	a0, 0x20		/* TARGET_SYS_EXIT_EXTENDED */
+
+	/* Semihosting call sequence. */
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	16
+semiargs:
+	.space	8
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index af6bc1aad8893726a3b26392da89f34319dd78a8..9f61da861a44881875457506c44bfc383560d1a9 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -40,6 +40,31 @@ run-test-mcycle-rv32: test-mcycle-rv32
 	$(call run-test, $<, \
 	  $(QEMU) -cpu rv32 -icount shift=1 $(QEMU_OPTS)$<)
 
+smcdeleg-counter-rv32: $(SRC_PATH)/tests/tcg/riscv32/smcdeleg-counter-rv32.S $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) $(RV32_CFLAGS) $< -Wa,--noexecstack -c -o $@.o
+	$(LD) -m elf32lriscv $(LDFLAGS) $@.o -o $@
+
+TESTS += smcdeleg-counter-rv32
+run-smcdeleg-counter-rv32: smcdeleg-counter-rv32
+	$(call run-test, $<, \
+	  $(QEMU) -cpu rv32$(COMMA)smcdeleg=true$(COMMA)ssccfg=true$(COMMA)sscofpmf=true $(QEMU_OPTS)$<)
+
+TESTS += smcdeleg-sxl32 smcdeleg-sxl32-high smcdeleg-sxl32-cfg
+smcdeleg-sxl32-high: smcdeleg-sxl32.S $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) -DTEST_HIGH_HALF $< -Wa,--noexecstack -c -o $@.o
+	$(LD) $(LDFLAGS) $@.o -o $@
+
+smcdeleg-sxl32-cfg: smcdeleg-sxl32.S $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) -DTEST_CONFIG $< -Wa,--noexecstack -c -o $@.o
+	$(LD) $(LDFLAGS) $@.o -o $@
+
+run-smcdeleg-sxl32: smcdeleg-sxl32
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+run-smcdeleg-sxl32-high: smcdeleg-sxl32-high
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+run-smcdeleg-sxl32-cfg: smcdeleg-sxl32-cfg
+	$(call run-test, $<, $(QEMU) -cpu max $(QEMU_OPTS)$<)
+
 TESTS += sscofpmf-overflow
 run-sscofpmf-overflow: sscofpmf-overflow
 	$(call run-test, $<, $(QEMU) -cpu max -icount shift=0 $(QEMU_OPTS)$<)
diff --git a/tests/tcg/riscv64/smcdeleg-sxl32.S b/tests/tcg/riscv64/smcdeleg-sxl32.S
new file mode 100644
index 0000000000000000000000000000000000000000..45762ad662099a48a51591bc8a6eade7b08928ef
--- /dev/null
+++ b/tests/tcg/riscv64/smcdeleg-sxl32.S
@@ -0,0 +1,219 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
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
+	csrw	0x151, t0		/* sireg */
+	csrr	t1, \csr
+	bne	t0, t1, fail
+	csrr	t1, 0x151
+	bne	t0, t1, fail
+
+	/* High-half aliases must still trap when the current XLEN is 64. */
+	li	a0, 0
+	li	a5, 2			/* Expect illegal instruction. */
+	li	s9, 0
+	csrr	t0, 0x155		/* sireg4 */
+	csrr	t0, 0x156		/* sireg5 */
+	li	t0, 2
+	bne	s9, t0, fail		/* Both accesses must have trapped. */
+	.endm
+
+	.macro	check_counter index, csr
+	li	s10, \index + 1		/* Counter-specific failure code. */
+	li	t0, 0x40 + \index
+	csrw	0x150, t0		/* siselect */
+	check_m64_alias \csr
+	enter_s32 .Ls_counter\@
+.Ls_counter\@:
+#ifdef TEST_HIGH_HALF
+	csrr	t0, 0x155		/* sireg4: original high half */
+	load32 t1, 0x12345678
+	bne	t0, t1, .Ls_fail\@
+	load32 t0, 0x07654321
+	csrw	0x155, t0
+	csrr	t1, 0x155
+	bne	t0, t1, .Ls_fail\@
+	/* A high-half write must preserve the low half. */
+	csrr	t0, 0x151
+	load32 t1, 0x11223344
+#else
+	csrr	t0, 0x151		/* sireg: original low half */
+	load32 t1, 0x11223344
+	bne	t0, t1, .Ls_fail\@
+	load32 t0, 0x55667788
+	csrw	0x151, t0
+	csrr	t1, 0x151
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
+	csrw	0x150, t0
+	li	t0, 0x6000000000000000 | \old_low /* MINH | SINH */
+	csrw	\csr, t0
+	enter_s32 .Ls_config\@
+.Ls_config\@:
+	csrr	t0, 0x152		/* sireg2: config/selector low half */
+	li	t1, \old_low
+	bne	t0, t1, .Lcfg_fail\@
+	li	t0, \new_low
+	csrw	0x152, t0
+	csrr	t1, 0x152
+	bne	t0, t1, .Lcfg_fail\@
+
+	/* Low-half writes preserve the high half; MINH reads as zero. */
+	csrr	t0, 0x156		/* sireg5 */
+	li	t1, 0x20000000		/* SINH, without MINH */
+	bne	t0, t1, .Lcfg_fail\@
+	li	t0, 0x10000000		/* Replace SINH with UINH. */
+	csrw	0x156, t0
+	csrr	t1, 0x156
+	bne	t0, t1, .Lcfg_fail\@
+	csrr	t0, 0x152
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
+	csrw	menvcfg, t0		/* CDE */
+	csrw	0x30c, t0		/* mstateen0: allow indirect CSRs. */
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
+	check_config 0, 0x321, 0, 0	/* mcyclecfg */
+	check_config 2, 0x322, 0, 0	/* minstretcfg */
+	check_config 3, 0x323, 1, 2	/* mhpmevent3: cycles -> instructions */
+#else
+	li	t0, 1
+	csrw	0x323, t0		/* HPM3 counts cycles. */
+	li	t0, 2
+	csrw	0x324, t0		/* HPM4 counts instructions. */
+	csrw	0x325, zero		/* HPM5 has no selected event. */
+	check_counter 0, mcycle
+	check_counter 2, minstret
+	check_counter 3, 0xb03
+	check_counter 4, 0xb04
+	check_counter 5, 0xb05
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

-- 
2.43.0


