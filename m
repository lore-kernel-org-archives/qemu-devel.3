Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E91C624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 09:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2mhY-0003VU-Tm; Sat, 05 Sep 2026 05:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x2mhW-0003Uy-Rc
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 05:28:42 -0400
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1x2mhU-0001Bd-P3
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 05:28:42 -0400
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so1008949a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 02:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788600518; x=1789205318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X1nANIyuagdrZRb9Ehhzh9IW135m80P2Hck8xm6ZCRQ=;
 b=LI7EI3lwwCbE62FxwF8/RDHiAxznD1aRez/JMPZ+cAnZK1+1h8fSoU3Q3wUXX4QfDH
 WklDWtWtZaIIpGl5MAti2p7CEmhgbAVfeS6K1IQqAuuSXut7NleyHiOAKDkZi+hBPgYl
 dk2+YpQR9JSzzijWO1rvGiLXQu0qbcfdBHqPrUw4QJvo5av3L71GQhSAvc3EAIqnnVOK
 l8O4VOS0h2VbT4L8n4Z2PavJPKP5giSr3/mgmQw45TTMZMDkqIlQyOrPzvYyIvzIxwUs
 wDMUJP9YbhCv1MnpnhsOs9BVOFRHYVP8fbe97P83TTTuz/xj2JG5XB3WcezV1K9+8Fba
 1qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788600518; x=1789205318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X1nANIyuagdrZRb9Ehhzh9IW135m80P2Hck8xm6ZCRQ=;
 b=VqWDAwk562msYslpziCVtaiiV3Q0174LC12YZ0ClkUWI6acS9TVr7gTlLyZbPn7q8W
 Vxg2WkSH3vz7zvtYExjcrTOuRJXXeIh948f3yn899kRw9cJvjrPFEmhZjJ1yoJtyqrVZ
 EM16oj72bZrSXs12gkr3V0yTGbe9IWmQrOKWNdlPHeElC76yjl09mIy9+2QqYNfVoQX9
 o671ufeGPoPkbpYkTFqVAd9379cWnYl1QSN+0tnvzR7WVk/BXcsweUKXdhHdySfC2se7
 4Ieg5HcqmRFIjbwXCSB2NXfahHgPMOGKU2hMXGC2tvoR/esv/pMgkC/RSLZrmTczRM8t
 PqaQ==
X-Gm-Message-State: AFuF++lUq7W+mmmpOV+LvOmh92CSzfFDKXGOnzrMxbklPOS+J+U/CQaq
 tnlzPQrcFFkzIiulqKdFZ4Iqo3igVaX8paQnDcfYP5DLsCR7m2gw0+4pHHnpUTb4
X-Gm-Gg: AYBFou3JntaoUEmH7YZdtIpcR4nphCFI5R3L0wDvTWSciFqFaxm9iPCQlQF8GiQGvI1
 K+5M/28P86OYXsoV7dAhgQfRKYXjLfY5eGl2wQUgzLI8hhcnbUj7PFLoBCPCnoxOMYO5ddjPRXS
 L3tG1gH+2ovNlUkylLfLgJuX6mvlstg9Ko5/6vpzsDJECbeOu357QItrR9qK2C3heXiUSwrYxNp
 2iPp2B5Y+ETvfRmTEEj1dNfKZKeZ72pemqILSMqdoQEQ9wevr047XoMK1HjEgL9EAauQr1yGWWn
 dKFzMZu3cm5WEKa/WQ4RXFAxDfAt5FyXA645KuAF9ye3Oak50OhiZDEMroUSirRsV8LcHh41WDE
 BmlQB5OA9+lF/ywoR/2fDiz4mjP/FMrTkKc2D4syb/fDB/ddR2SyjT+KBnht0ISVYWbQQwmnTYv
 znmOhdkstPryUgtaT9E5gAui0xQje3olVq3Nkb4Iap54f4NR5KuB2iJPxeyVKtLC/cOAyQjh67o
 M4pOuRGIZRJ7pEI01lMvZMkWp0=
X-Received: by 2002:a17:90b:57d0:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-39b260d28eamr16252166a91.1.1788600518144; 
 Sat, 05 Sep 2026 02:28:38 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([149.118.62.92])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b25f8d2c5sm9309502a91.2.2026.09.05.02.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:28:37 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH] target/riscv: fix RV32 fixed counter accesses
Date: Sat,  5 Sep 2026 17:28:10 +0800
Message-ID: <20260905092810.660-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::b;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commit cfc96df65e01, riscv_pmu_ctr_get_fixed_counters_val()
returns the complete 64-bit fixed-counter value. The RV32 counter
access paths, however, still perform parts of the offset calculation
on separately extracted 32-bit halves.

In particular, riscv_pmu_write_ctrh() deposits the low 32 bits of the
complete fixed-counter value into the high half of mhpmcounter_prev.
riscv_pmu_read_ctr() also subtracts a 32-bit half of the previous value
from the complete 64-bit fixed-counter value. Consequently, writes to
mcycleh can be lost and carries between the low and high halves are not
handled correctly.

Keep the fixed-counter offset calculation entirely in 64 bits. Before
a running counter is partially written, materialize its current
architectural value and reset the fixed-counter baseline. On reads,
calculate the complete 64-bit counter value before extracting the half
requested by RV32.

Add an RV32 system TCG test for high-half writes, low-to-high carry, and
preserving the carried high half across a subsequent low-half write.

Fixes: cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr_get_fixed_counters_val")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4219
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/tcg/csr.c                    | 32 ++++++++--------
 tests/tcg/riscv64/Makefile.softmmu-target | 12 ++++++
 tests/tcg/riscv64/test-mcycle-rv32.S      | 45 +++++++++++++++++++++++
 3 files changed, 74 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-mcycle-rv32.S

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 002f7e69c1..ffdd5c4aa6 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -1337,23 +1337,23 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
     int deposit_size = rv32 ? 32 : 64;
     uint64_t ctr;
 
-    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                         0, deposit_size, val);
-
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
         ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              0, deposit_size, ctr);
+        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             0, deposit_size, val);
+        counter->mhpmcounter_prev = ctr;
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
      } else {
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             0, deposit_size, val);
         /* Other counters can keep incrementing from the given value */
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               0, deposit_size, val);
-
     }
 
     return RISCV_EXCP_NONE;
@@ -1363,20 +1363,22 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
-    uint64_t ctrh;
+    uint64_t ctr;
 
-    counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
-                                         32, 32, val);
     if (!get_field(env->mcountinhibit, BIT(ctr_idx)) &&
         (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
          riscv_pmu_ctr_monitor_instructions(env, ctr_idx))) {
-        ctrh = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
-        counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
-                                              32, 32, ctrh);
+        ctr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx);
+        counter->mhpmcounter_val += ctr - counter->mhpmcounter_prev;
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             32, 32, val);
+        counter->mhpmcounter_prev = ctr;
         if (ctr_idx > 2) {
             riscv_pmu_setup_timer(env, counter->mhpmcounter_val, ctr_idx);
         }
     } else {
+        counter->mhpmcounter_val = deposit64(counter->mhpmcounter_val,
+                                             32, 32, val);
         counter->mhpmcounter_prev = deposit64(counter->mhpmcounter_prev,
                                               32, 32, val);
     }
@@ -1407,12 +1409,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
     int start = upper_half ? 32 : 0;
     int length = rv32 ? 32 : 64;
-    uint64_t ctr_prev, ctr_val;
+    uint64_t ctr_val;
 
     /* Ensure upper_half is only set for XLEN == 32 */
     g_assert(rv32 || !upper_half);
 
-    ctr_prev = extract64(counter->mhpmcounter_prev, start, length);
     ctr_val  = extract64(counter->mhpmcounter_val, start, length);
 
     if (get_field(env->mcountinhibit, BIT(ctr_idx))) {
@@ -1431,7 +1432,8 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
     if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
         riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
         uint64_t cntr = riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
-                                                             ctr_prev + ctr_val;
+                        counter->mhpmcounter_prev +
+                        counter->mhpmcounter_val;
         *val = extract64(cntr, start, length);
     } else {
         *val = ctr_val;
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 6a219c306c..15c7371acd 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -28,6 +28,18 @@ EXTRA_RUNS += run-test-minstret-ecall
 run-test-minstret-ecall: test-minstret-ecall
 	$(call run-test, $<, $(QEMU) -icount shift=1 $(QEMU_OPTS)$<)
 
+RV32_CFLAGS = -march=rv32im_zicsr -mabi=ilp32
+CLEANFILES += test-mcycle-rv32
+
+test-mcycle-rv32: test-mcycle-rv32.S $(LINK_SCRIPT)
+	$(CC) $(CFLAGS) $(RV32_CFLAGS) $< -Wa,--noexecstack -c -o $@.o
+	$(LD) -m elf32lriscv $(LDFLAGS) $@.o -o $@
+
+EXTRA_RUNS += run-test-mcycle-rv32
+run-test-mcycle-rv32: test-mcycle-rv32
+	$(call run-test, $<, \
+	  $(QEMU) -cpu rv32 -icount shift=1 $(QEMU_OPTS)$<)
+
 EXTRA_RUNS += run-plugin-doubletrap
 run-plugin-doubletrap: doubletrap
 	$(call run-test, $<, \
diff --git a/tests/tcg/riscv64/test-mcycle-rv32.S b/tests/tcg/riscv64/test-mcycle-rv32.S
new file mode 100644
index 0000000000..189d1e13a2
--- /dev/null
+++ b/tests/tcg/riscv64/test-mcycle-rv32.S
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+	.option	norvc
+
+	.text
+	.global	_start
+_start:
+	/* Exercise writes while mcycle is running. */
+	csrw	mcountinhibit, zero
+	csrw	mcycle, zero
+
+	/* A write to the high half must be immediately observable. */
+	li	s0, 0x1234ffff
+	csrw	mcycleh, s0
+	csrr	t0, mcycleh
+	bne	t0, s0, fail
+
+	/* Check carry from the low half into the high half. */
+	li	s0, 0x12345678
+	csrw	mcycleh, s0
+	li	t0, 0xfffffff0
+	csrw	mcycle, t0
+	.rept	32
+	nop
+	.endr
+	csrr	t0, mcycleh
+	addi	s0, s0, 1
+	bne	t0, s0, fail
+
+	/* A low-half write must preserve the carried high half. */
+	li	t0, 0x22222222
+	csrw	mcycle, t0
+	csrr	t0, mcycleh
+	bne	t0, s0, fail
+
+	li	t0, 0x100000
+	li	t1, 0x5555	/* FINISHER_PASS */
+	sw	t1, 0(t0)
+	j	.
+
+fail:
+	li	t0, 0x100000
+	li	t1, 0x13333	/* status = FINISHER_FAIL, code = 1 */
+	sw	t1, 0(t0)
+	j	.
-- 
2.43.0


