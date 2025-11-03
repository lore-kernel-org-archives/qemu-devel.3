Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE07CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:12:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFy4F-0000bs-TL; Mon, 03 Nov 2025 12:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy45-0000b1-W6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:58 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vFy3n-0000tn-RL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ceCGNi73dSxmTd0X5VbD2VSE4aTpxz1746XxjDQRM3g=; b=rCzjcR9hSkdA4GH
 V4Y8Y7x3mlNGefh8QyPRmyDpEwSGsN+p7UCM4b3Y9lbFVO3y1m8R9lFmWHJWOW50l2mXWgkjAOZqN
 dU0Prb778KhrBZsbknaYXIAiaIwDqPfty+TJO8Jbi/Ok5T89GfXIXmViirNA45tRnp1zq2tI6AO/y
 Oo=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v5 23/25] target/riscv: Move CSR declarations to separate
 csr.h header
Date: Mon,  3 Nov 2025 18:12:06 +0100
Message-ID: <20251103171208.24355-24-anjo@rev.ng>
In-Reply-To: <20251103171208.24355-1-anjo@rev.ng>
References: <20251103171208.24355-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h            | 82 +-----------------------------
 target/riscv/csr.h            | 94 +++++++++++++++++++++++++++++++++++
 target/riscv/cpu.c            |  1 +
 target/riscv/csr.c            |  1 +
 target/riscv/gdbstub.c        |  1 +
 target/riscv/kvm/kvm-cpu.c    |  1 +
 target/riscv/op_helper.c      |  1 +
 target/riscv/riscv-qmp-cmds.c |  1 +
 target/riscv/th_csr.c         |  1 +
 9 files changed, 102 insertions(+), 81 deletions(-)
 create mode 100644 target/riscv/csr.h

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index d1a8384646..e751ceb24a 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -859,75 +859,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
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
-    riscv_csrr(env, csrno, &val);
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
+#include "target/riscv/csr.h"
 
 /*
  * The event id are encoded based on the encoding specified in the
@@ -971,23 +903,11 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
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
index 0000000000..5b92f6fecc
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
+    riscv_csrr(env, csrno, &val);
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
index 2084b0d0bf..7a8b8d736e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "target/riscv/csr.h"
 #include "internals.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index e60741def2..0f2ed881d5 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/timer.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "tcg/tcg-cpu.h"
 #include "pmu.h"
 #include "time_helper.h"
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 1934f919c0..d54ba179e6 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -20,6 +20,7 @@
 #include "exec/gdbstub.h"
 #include "gdbstub/helpers.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 
 struct TypeSize {
     const char *gdb_type;
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 000e44b2b7..b985c08b17 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -31,6 +31,7 @@
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "trace.h"
 #include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 6ccc127c30..9767febb5a 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 #include "internals.h"
 #include "exec/cputlb.h"
 #include "accel/tcg/cpu-ldst.h"
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index 93488450bd..fdc6ba8c83 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -39,6 +39,7 @@
 #include "system/tcg.h"
 #include "cpu-qom.h"
 #include "cpu.h"
+#include "target/riscv/csr.h"
 
 static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
 {
diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 49eb7bbab5..a4ea4ce391 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "cpu_vendorid.h"
+#include "target/riscv/csr.h"
 
 #define CSR_TH_SXSTATUS 0x5c0
 
-- 
2.51.0


