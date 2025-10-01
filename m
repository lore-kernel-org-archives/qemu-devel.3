Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5643DCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rJu-00060V-Tn; Wed, 01 Oct 2025 03:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJi-0005vk-Ak
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:05 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v3rJB-0003cT-9J
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=8ge31vtK7cTCSzhIiDlBR/koRSzu2Kf4CuOaCCFjsn4=; b=vcRBYIzaKBHQOdk
 OUz8uyZ2jC8ctFFOt7e1c6CnyxbQzG/nqE4ScxYALfkwDNC7i55QcpghjVExkBPdW4tTR3xV0ilfo
 t1HuYKs0CHaXXUVd83uhZrZrOueXrPVp5yODlb6TtvuYMCiaMMcj7E68xGh3FPFOAxqnFyPPF1/PC
 Vk=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org,
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Subject: [PATCH v2 31/33] target/riscv: Move CSR declarations to separate
 csr.h header
Date: Wed,  1 Oct 2025 09:33:04 +0200
Message-ID: <20251001073306.28573-32-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-1-anjo@rev.ng>
References: <20251001073306.28573-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Most of these definitions save riscv_csrr, riscv_csrrw, riscv_csr_read,
riscv_csr_write are only used in target/.  Move declarations to a
separate headers which will soon be made internal to target/.

csr.h is temporarily included from cpu.h to not break includes from
outside target/, this include will be removed in the following commit.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.h         | 82 +--------------------------------
 target/riscv/csr.h         | 94 ++++++++++++++++++++++++++++++++++++++
 target/riscv/cpu.c         |  1 +
 target/riscv/csr.c         |  1 +
 target/riscv/gdbstub.c     |  1 +
 target/riscv/kvm/kvm-cpu.c |  1 +
 target/riscv/op_helper.c   |  1 +
 target/riscv/th_csr.c      |  1 +
 8 files changed, 101 insertions(+), 81 deletions(-)
 create mode 100644 target/riscv/csr.h

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 70e0f3718c..61319575b0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -849,75 +849,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
 RISCVPmPmm riscv_pm_get_virt_pmm(CPURISCVState *env);
 uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
 
-RISCVException riscv_csrr(CPURISCVState *env, int csrno,
-                          target_ulong *ret_value);
-
-RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value, target_ulong new_value,
-                           target_ulong write_mask, uintptr_t ra);
-RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
-                                 target_ulong *ret_value,
-                                 target_ulong new_value,
-                                 target_ulong write_mask);
-
-static inline void riscv_csr_write(CPURISCVState *env, int csrno,
-                                   target_ulong val)
-{
-    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
-}
-
-static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
-{
-    target_ulong val = 0;
-    riscv_csrrw(env, csrno, &val, 0, 0, 0);
-    return val;
-}
-
-typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
-                                                 int csrno);
-typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
-                                            target_ulong *ret_value);
-typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
-                                             target_ulong new_value,
-                                             uintptr_t ra);
-typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
-                                          target_ulong *ret_value,
-                                          target_ulong new_value,
-                                          target_ulong write_mask);
-
-RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
-                               Int128 *ret_value);
-RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
-                                Int128 *ret_value, Int128 new_value,
-                                Int128 write_mask, uintptr_t ra);
-
-typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int csrno,
-                                               Int128 *ret_value);
-typedef RISCVException (*riscv_csr_write128_fn)(CPURISCVState *env, int csrno,
-                                             Int128 new_value);
-
-typedef struct {
-    const char *name;
-    riscv_csr_predicate_fn predicate;
-    riscv_csr_read_fn read;
-    riscv_csr_write_fn write;
-    riscv_csr_op_fn op;
-    riscv_csr_read128_fn read128;
-    riscv_csr_write128_fn write128;
-    /* The default priv spec version should be PRIV_VERSION_1_10_0 (i.e 0) */
-    uint32_t min_priv_ver;
-} riscv_csr_operations;
-
-struct RISCVCSR {
-    int csrno;
-    bool (*insertion_test)(RISCVCPU *cpu);
-    riscv_csr_operations csr_ops;
-};
-
-/* CSR function table constants */
-enum {
-    CSR_TABLE_SIZE = 0x1000
-};
+#include "csr.h"
 
 /*
  * The event id are encoded based on the encoding specified in the
@@ -961,23 +893,11 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
 void riscv_add_satp_mode_properties(Object *obj);
 bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
 
-/* CSR function table */
-extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
-
 extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
 
-void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
-void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
-
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
 
-target_ulong riscv_new_csr_seed(target_ulong new_value,
-                                target_ulong write_mask);
-
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
 
-/* In th_csr.c */
-extern const RISCVCSR th_csr_list[];
-
 const char *priv_spec_to_str(int priv_version);
 #endif /* RISCV_CPU_H */
diff --git a/target/riscv/csr.h b/target/riscv/csr.h
new file mode 100644
index 0000000000..fab53992bb
--- /dev/null
+++ b/target/riscv/csr.h
@@ -0,0 +1,94 @@
+/*
+ * QEMU RISC-V CSRs
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_CSR_H
+#define RISCV_CSR_H
+
+target_ulong riscv_new_csr_seed(target_ulong new_value,
+                                target_ulong write_mask);
+
+RISCVException riscv_csrr(CPURISCVState *env, int csrno,
+                          target_ulong *ret_value);
+
+RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
+                           target_ulong *ret_value, target_ulong new_value,
+                           target_ulong write_mask, uintptr_t ra);
+RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
+                                 target_ulong *ret_value,
+                                 target_ulong new_value,
+                                 target_ulong write_mask);
+
+static inline void riscv_csr_write(CPURISCVState *env, int csrno,
+                                   target_ulong val)
+{
+    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+}
+
+static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
+{
+    target_ulong val = 0;
+    riscv_csrrw(env, csrno, &val, 0, 0, 0);
+    return val;
+}
+
+typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
+                                                 int csrno);
+typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
+                                            target_ulong *ret_value);
+typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
+                                             target_ulong new_value,
+                                             uintptr_t ra);
+typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
+                                          target_ulong *ret_value,
+                                          target_ulong new_value,
+                                          target_ulong write_mask);
+
+RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
+                               Int128 *ret_value);
+RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
+                                Int128 *ret_value, Int128 new_value,
+                                Int128 write_mask, uintptr_t ra);
+
+typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int csrno,
+                                               Int128 *ret_value);
+typedef RISCVException (*riscv_csr_write128_fn)(CPURISCVState *env, int csrno,
+                                             Int128 new_value);
+
+typedef struct {
+    const char *name;
+    riscv_csr_predicate_fn predicate;
+    riscv_csr_read_fn read;
+    riscv_csr_write_fn write;
+    riscv_csr_op_fn op;
+    riscv_csr_read128_fn read128;
+    riscv_csr_write128_fn write128;
+    /* The default priv spec version should be PRIV_VERSION_1_10_0 (i.e 0) */
+    uint32_t min_priv_ver;
+} riscv_csr_operations;
+
+struct RISCVCSR {
+    int csrno;
+    bool (*insertion_test)(RISCVCPU *cpu);
+    riscv_csr_operations csr_ops;
+};
+
+/* CSR function table constants */
+enum {
+    CSR_TABLE_SIZE = 0x1000
+};
+
+/* CSR function table */
+extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
+
+void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
+void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
+
+/* In th_csr.c */
+extern const RISCVCSR th_csr_list[];
+
+#endif /* RISCV_CSR_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 246ec81beb..d8d06f92bc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "csr.h"
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0e7236098b..3ebfd19b07 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -22,6 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
+#include "csr.h"
 #include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1934f919c0..f8d3bc0df1 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -20,6 +20,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "cpu.h"
+#include "csr.h"
 
 struct TypeSize {
     const char *gdb_type;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5c19062c19..ad58e84158 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -31,6 +31,7 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "cpu.h"
+#include "csr.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 110292e84d..d2d9f2a47a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "csr.h"
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 49eb7bbab5..bf6f8d62a3 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "csr.h"
 
 #define CSR_TH_SXSTATUS 0x5c0
 
-- 
2.51.0


