Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA49DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 03:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuLgU-0006UR-C7; Wed, 12 Aug 2026 23:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wuLgQ-0006Tj-1h
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:00:43 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wuLgN-0006vS-QR
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 23:00:41 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so1483109a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 20:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786590038; x=1787194838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d7NOAZI8mLApIqFq6Dw77XfNTAXuOVppR/l3j5UBrtc=;
 b=bfb8HciYvA9s/jVjbP3qUWPE5HSrO5nmZQ7NOxGP19t2IAXfMXUqkrKioNt5ddsjHp
 eS3xqvyvykxRNvGG920mP/lopMkyIyGZg2CvLsBuifaTZKdbZybxnQ/vCmXb7G5OrEVR
 cR97gE7sw7a92NO7cnP2qc9cvxpqB5K0B6+73B6aQokptYJSXxtXDGgiezHKAWevp/ZZ
 UtnuBttqQQXOOdCP6+oGYhJ48OspbvyL95jEy/hOdNsXA9uWLimkUPTBy2+SThRjtEYr
 3VFb+rFRPG5RznXU1/aXjhJdwGiqnkSo7Wg4UtzgNzcCMKQHTF6aKqRVW0RUeljW0ECr
 DbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786590038; x=1787194838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d7NOAZI8mLApIqFq6Dw77XfNTAXuOVppR/l3j5UBrtc=;
 b=GVGyR6FIqgsSujCKpAbrblkzLzd8cahCzl9Dl1+XEI039WMUd+kDsDDNSEAvj6t3pb
 SbunMCVQu1ZCJx8EoqmPamKY2TuFFUXeonBaTxknyfUbXZbmEc8b+2lO/AcaOOXTlsTm
 FuZiVQYK/AkSJxm8qaVecm3BeO25LiBwmHw55LQHIYiu9vcK8Oeh22NpSaQLU+nlFn0t
 SDqgd6GYGXxShQRsUhrtM7wcdM8HcH4K/cZ1/QUaIR4LsR6e2fB5tyRne1JD8AyrYkU5
 HgaNEjU9cOp3KaLpnSN/pQXwBYQQ9Cssfp8TWAUrp3ZllJEW6x6JkDj+gg0cwvkD9Dbw
 MFUQ==
X-Gm-Message-State: AOJu0YwR7gJkth6Rt03eyosYK8/pLE6ZkZ4mQPdP73g+pCBLmsGsvLUy
 Y4D2VCSdu+YNz+rWSq7U4Ufc6A6ADZWPm+KZYSRC33EVPXMYQ+7IXjrz8tdL4EWUum8=
X-Gm-Gg: AR+sD13fQLlRJ+6HO7c1Au3idrub53z7yIKns+ikRomkevodPtTJThuTvGid23hm9QQ
 mnmkeMsLw3AajLo9FFa9KdNXCDsOjL2AWavqIzn15Gyt2z0cVg8k5jvgpydaqw9ofSo/Smg/PyS
 BAgduzcPzFP5eiFstux2ex4Q/AgGoLIQUFnzrYt+ZGH8VFzIpGdcFk3BO1ShY+ceWg3RKdKOWFU
 0yzzGGXSSxfxtuDdIxDfD5djhYGE2DLEfoMuFCVdq7OqXs73UssXOzvA6bd/mI4L/kXZ0/hkjYy
 AJFkP4yqtCPNFBa358iLblwmyDsKhCbIUGqOAhVWJCnOP3CWpkSQEMwMX5nN8RIsNBhsBDJTW3O
 QPM/pfbXjBzPcoxRzhmQGaeEds87XrKGitQdJtyW5RF6h476egsHvill21fJu/dXyFrqvyHc0aH
 DqHuUdCi8ho4FUZfBDP0WoZfKsxApCgBjPaao/w0FLe0S4+qk513Uh9UxcNDrdEGpaTRdeOeu87
 4saCKE9HtpSMq50pfiDAgHxSYo=
X-Received: by 2002:a17:90b:4a10:b0:38e:488f:7068 with SMTP id
 98e67ed59e1d1-3931dfdd3e6mr2907184a91.2.1786590037653; 
 Wed, 12 Aug 2026 20:00:37 -0700 (PDT)
Received: from Dell-WorkStation.localdomain ([149.118.62.92])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412d961bf7sm3250865c88.10.2026.08.12.20.00.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 20:00:36 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 max.chou@sifive.com, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v4] target/riscv: preserve vl on element-zero fault
Date: Thu, 13 Aug 2026 10:59:58 +0800
Message-ID: <20260813025959.583-1-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-pj2-x01.google.com
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

A unit-stride fault-only-first load must leave vl unchanged when element
zero raises a synchronous exception.

The current implementation updates vl after probing the accesses but
before performing the actual loads. For unassigned MMIO, the probe can
succeed even though the subsequent device transaction raises an
exception. If this happens for element zero, the trap handler observes
a prematurely shortened vl.

Keep the shortened value in a local bound until all loads complete, and
only then update the architectural vl.

Add a bare-metal RVV regression test using an unassigned MMIO address
and check that vl remains unchanged in the trap handler.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3544
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
Changes in v4:
- Clarify that the test uses unassigned MMIO, not an unmapped address.
- Explain why the MMIO transaction fault is needed to reproduce the bug.

Changes in v3:
- Rebase onto current master.
- Regenerate the patch to fix the malformed v2 submission.

Changes in v2:
- Fix commit message formatting.
- Enable vector state in the bare-metal test.
- Use an aligned unassigned MMIO address and compare against the vsetvli
  result.
- Express the mstatus.VS setting as a field shift.

 target/riscv/tcg/vector_helper.c          | 23 +++++----
 tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
 tests/tcg/riscv64/test-vle32ff.S          | 58 +++++++++++++++++++++++
 3 files changed, 77 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vle32ff.S

diff --git a/target/riscv/tcg/vector_helper.c b/target/riscv/tcg/vector_helper.c
index e321ca2616..5a310822b7 100644
--- a/target/riscv/tcg/vector_helper.c
+++ b/target/riscv/tcg/vector_helper.c
@@ -686,7 +686,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
           uint32_t desc, vext_ldst_elem_fn_tlb *ldst_tlb,
           vext_ldst_elem_fn_host *ldst_host, uint32_t log2_esz, uintptr_t ra)
 {
-    uint32_t i, k, vl = 0;
+    uint32_t i, k, vl = 0, load_vl;
     uint32_t nf = vext_nf(desc);
     uint32_t vm = vext_vm(desc);
     uint32_t max_elems = vext_max_elems(desc, log2_esz);
@@ -752,22 +752,24 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPURISCVState *env,
         }
     }
 ProbeSuccess:
-    /* load bytes from guest memory */
-    if (vl != 0) {
-        env->vl = vl;
-    }
+    /*
+     * Keep a shortened vl local until all loads complete. In particular,
+     * an exception from element zero must leave the architectural vl alone.
+     */
+    load_vl = vl ? vl : env->vl;
 
-    if (env->vstart < env->vl) {
+    if (env->vstart < load_vl) {
         if (vm) {
             /* Load/store elements in the first page */
             if (likely(elems)) {
+                elems = MIN(elems, load_vl - env->vstart);
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
                                   log2_esz, true, mmu_index, ldst_tlb,
                                   ldst_host, ra);
             }
 
             /* Load/store elements in the second page */
-            if (unlikely(env->vstart < env->vl)) {
+            if (unlikely(env->vstart < load_vl)) {
                 /* Cross page element */
                 if (unlikely(page_split % msize)) {
                     for (k = 0; k < nf; k++) {
@@ -780,7 +782,7 @@ ProbeSuccess:
 
                 addr = base + ((env->vstart * nf) << log2_esz);
                 /* Get number of elements of second page */
-                elems = env->vl - env->vstart;
+                elems = load_vl - env->vstart;
 
                 /* Load/store elements in the second page */
                 vext_page_ldst_us(env, vd, addr, elems, nf, max_elems,
@@ -788,7 +790,7 @@ ProbeSuccess:
                                   ldst_host, ra);
             }
         } else {
-            for (i = env->vstart; i < env->vl; i++) {
+            for (i = env->vstart; i < load_vl; i++) {
                 k = 0;
                 while (k < nf) {
                     if (!vext_elem_mask(v0, i)) {
@@ -806,6 +808,9 @@ ProbeSuccess:
             }
         }
     }
+    if (vl != 0) {
+        env->vl = vl;
+    }
     env->vstart = 0;
 
     vext_set_tail_elems_1s(env->vl, vd, desc, nf, esz, max_elems);
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 82be8a2c91..7ae225bd73 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -41,5 +41,10 @@ comma:= ,
 run-test-crc32: test-crc32
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)xlrbr=true $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-test-vle32ff
+run-test-vle32ff: test-vle32ff
+	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)v=true $(QEMU_OPTS)$<)
+test-vle32ff: CFLAGS += -march=rv64gcv
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-vle32ff.S b/tests/tcg/riscv64/test-vle32ff.S
new file mode 100644
index 0000000000..2cffe8659c
--- /dev/null
+++ b/tests/tcg/riscv64/test-vle32ff.S
@@ -0,0 +1,58 @@
+/*
+ * Verify that a fault-only-first load keeps vl unchanged when element zero
+ * raises a synchronous exception.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+	.option norvc
+
+	.text
+	.globl _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	li	t0, (1 << 9)	/* Set mstatus.VS to Initial. */
+	csrs	mstatus, t0
+	li	t1, 4
+	vsetvli	t2, t1, e32, m1, ta, ma
+	/* Unassigned MMIO: probe succeeds, load faults. */
+	li	t0, 0x18000000
+	vle32ff.v	v1, (t0)
+
+	/* Element zero did not trap. */
+	li	a0, 1
+	j	_exit
+
+trap:
+	csrr	t0, mcause
+	li	t1, 5		/* Load access fault. */
+	bne	t0, t1, trap_fail
+
+	csrr	t0, vl
+	bne	t0, t2, trap_fail
+
+	li	a0, 0
+	j	_exit
+
+trap_fail:
+	li	a0, 1
+
+_exit:
+	lla	a1, semiargs
+	li	t0, 0x20026	/* ADP_Stopped_ApplicationExit */
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	/* TARGET_SYS_EXIT_EXTENDED */
+
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+	.data
+	.balign	8
+semiargs:
+	.space	16
-- 
2.43.0

