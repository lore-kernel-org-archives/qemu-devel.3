Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B5CCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:28:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENve-00026r-Dq; Wed, 07 Oct 2026 05:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENA0-0001jF-MW; Wed, 07 Oct 2026 04:38:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9v-0006WY-9H; Wed, 07 Oct 2026 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Ywat/n3Q1OxgOSL3wRVL8daY/8rCeo32eSZuAeU5L0g=; b=Cm7KaI75Gm/llY+
 5K1+R6z4Aww/cWli0QLWKRxPiOmfmchPqyXTqoJtn+MW8xghspQWLVyGS6HdSomv+I1xB0PJDqsNx
 JprLxVSZIJvR1+SKPkM6oHXpA4f5Cfj3ihaC+zflsjBp2X4Qw+Pzx1+0uKJVdjSiUk3LyQ/GxwWk0
 MI=;
Date: Wed, 07 Oct 2026 10:43:11 +0200
Subject: [PATCH v2 05/18] target/riscv: Widen CSR ops to 64-bit and compile
 once for system-mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-5-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=119712;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=20gmy+sutACum+YUYBmn2UzjemDBDksPJPUjVLxIXAg=;
 b=zE/M4iEGa044ePBgnMzQMezPIraEg+dfdXsfbLr+R5dwTYDDY4ozzLqwFWTn4h0z2aOgPpbrq
 5juoHZMRdHVDSOmMePC1qV3IqdcPA1wWkKhK4nwB3IU6XIYNq46PWuo
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mostly mechanical change of target_ulong to uint64_t, motivated by the
fact that csr.c compiled with a 64-bit target_ulong already can handle
rv32 CPUs just fine.  If there's any discrepancy between rv32 on
qemu-riscv32 and rv32 on qemu-riscv64 I've failed to take into account
please do let me know.

Aside from minor formatting fixes, masks are sometimes replaced with
~0ULL, such as for write_vsstatus()

-    uint64_t mask = (target_ulong)-1;
+    uint64_t mask = ~0ULL;

this assumes that the behaviour for rv32 on qemu-riscv64 is correct.

Functions in other files containing CSR relevant behaviour are
also updated.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/tcg/csr.h       |  35 +-
 target/riscv/tcg/debug.h     |  11 +-
 target/riscv/cpu.c           |  11 +-
 target/riscv/gdbstub.c       |   2 +-
 target/riscv/monitor.c       |   5 +-
 target/riscv/tcg/csr.c       | 736 +++++++++++++++++++++----------------------
 target/riscv/tcg/debug.c     |  10 +-
 target/riscv/tcg/mips_csr.c  |  12 +-
 target/riscv/tcg/op_helper.c |   6 +-
 target/riscv/tcg/pmp.c       |  14 +-
 target/riscv/tcg/pmu.c       |   4 +-
 target/riscv/tcg/th_csr.c    |   6 +-
 target/riscv/tcg/meson.build |  13 +-
 13 files changed, 434 insertions(+), 431 deletions(-)

diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
index 03f96cce04..c6af3ebe50 100644
--- a/target/riscv/tcg/csr.h
+++ b/target/riscv/tcg/csr.h
@@ -9,31 +9,28 @@
 #ifndef RISCV_CSR_H
 #define RISCV_CSR_H
 
-#include "exec/target_long.h"
-#include "cpu_bits.h"
-
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
-                          target_ulong *ret_value);
+                          uint64_t *ret_value);
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value, target_ulong new_value,
-                           target_ulong write_mask, uintptr_t ra);
+                           uint64_t *ret_value, uint64_t new_value,
+                           uint64_t write_mask, uintptr_t ra);
 RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
-                                 target_ulong *ret_value,
-                                 target_ulong new_value,
-                                 target_ulong write_mask);
+                                 uint64_t *ret_value,
+                                 uint64_t new_value,
+                                 uint64_t write_mask);
 
 typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
                                                  int csrno);
 typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrno,
-                                            target_ulong *ret_value);
+                                            uint64_t *ret_value);
 typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csrno,
-                                             target_ulong new_value,
+                                             uint64_t new_value,
                                              uintptr_t ra);
 typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
-                                          target_ulong *ret_value,
-                                          target_ulong new_value,
-                                          target_ulong write_mask);
+                                          uint64_t *ret_value,
+                                          uint64_t new_value,
+                                          uint64_t write_mask);
 
 RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
                                Int128 *ret_value);
@@ -89,18 +86,18 @@ extern const RISCVCSR mips_csr_list[];
 
 /* PMP CSRs, defined in pmp.c */
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
-                      target_ulong val);
-target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
+                      uint64_t val);
+uint64_t pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
 
 void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
 uint64_t mseccfg_csr_read(CPURISCVState *env);
 
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
-                       target_ulong val);
-target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
+                       uint64_t val);
+uint64_t pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
 
 /* Used in pmu.c */
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, uint64_t *val,
                                   bool upper_half, uint32_t ctr_idx);
 
 #endif /* RISCV_CSR_H */
diff --git a/target/riscv/tcg/debug.h b/target/riscv/tcg/debug.h
index fcd92b768c..5383905b01 100644
--- a/target/riscv/tcg/debug.h
+++ b/target/riscv/tcg/debug.h
@@ -23,7 +23,6 @@
 #define RISCV_DEBUG_H
 
 #include "exec/breakpoint.h"
-#include "exec/target_long.h"
 
 /* register index of tdata CSRs */
 enum {
@@ -139,13 +138,13 @@ enum {
 
 bool tdata_available(CPURISCVState *env, int tdata_index);
 
-target_ulong tselect_csr_read(CPURISCVState *env);
-void tselect_csr_write(CPURISCVState *env, target_ulong val);
+uint64_t tselect_csr_read(CPURISCVState *env);
+void tselect_csr_write(CPURISCVState *env, uint64_t val);
 
-target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index);
-void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val);
+uint64_t tdata_csr_read(CPURISCVState *env, int tdata_index);
+void tdata_csr_write(CPURISCVState *env, int tdata_index, uint64_t val);
 
-target_ulong tinfo_csr_read(CPURISCVState *env);
+uint64_t tinfo_csr_read(CPURISCVState *env);
 
 void riscv_cpu_debug_excp_handler(CPUState *cs);
 bool riscv_cpu_debug_check_breakpoint(CPUState *cs);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 3356ba61d2..8c8f08bb50 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -17,6 +17,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include "cpu_bits.h"
 #include "qemu/osdep.h"
 #include "qemu/qemu-print.h"
 #include "qemu/ctype.h"
@@ -617,16 +618,20 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
 static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
 {
 #ifdef CONFIG_TCG
-    target_ulong val = 0;
+    uint64_t val = 0;
+    bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
+    int width = rv32 ? 8 : 16;
+    uint64_t mask = rv32 ? UINT32_MAX : UINT64_MAX;
     RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
 
+
     /*
      * Rely on the smode, hmode, etc, predicates within csr.c
      * to do the filtering of the registers that are present.
      */
     if (res == RISCV_EXCP_NONE) {
-        qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
-                     csr_ops[csrno].name, val);
+        qemu_fprintf(f, " %-13s " "%0*" PRIx64 "\n",
+                     csr_ops[csrno].name, width, val & mask);
     }
 #endif
 }
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 9abbf5bcdf..6cb905de78 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -171,7 +171,7 @@ static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
     CPURISCVState *env = &cpu->env;
 
     if (n < CSR_TABLE_SIZE) {
-        target_ulong val = 0;
+        uint64_t val = 0;
         int result;
 
         result = riscv_csrrw_debug(env, n, &val, 0, 0);
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 7e61ae2a47..fc61638702 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
+#include "exec/target_long.h"
 #include "cpu.h"
 #include "target/riscv/tcg/csr.h"
 #include "cpu_bits.h"
@@ -250,7 +251,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
 
 #ifdef CONFIG_TCG
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
-                                 target_ulong *val, bool is_gprh)
+                                 uint64_t *val, bool is_gprh)
 {
     const char * const *reg_names;
     uint64_t *vals;
@@ -321,7 +322,7 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
 {
     RISCVCPU *hart = RISCV_CPU(cs);
     CPURISCVState *env = cpu_env(cs);
-    target_ulong val = 0;
+    uint64_t val = 0;
     uint64_t val64 = 0;
     int i;
 
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index bd4b6dc114..48b3d28734 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -20,21 +20,22 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
-#include "cpu.h"
+#include "qemu/target-info.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/internals.h"
+#include "target/riscv/time_helper.h"
 #include "target/riscv/tcg/csr.h"
-#include "tcg/tcg-cpu.h"
-#include "pmu.h"
-#include "time_helper.h"
+#include "target/riscv/tcg/tcg-cpu.h"
+#include "target/riscv/tcg/pmu.h"
+#if !defined(CONFIG_USER_ONLY)
+#include "target/riscv/tcg/debug.h"
+#endif
 #include "exec/cputlb.h"
 #include "exec/icount.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
 #include "qapi/error.h"
 #include "tcg/insn-start-words.h"
-#include "internals.h"
-#if !defined(CONFIG_USER_ONLY)
-#include "target/riscv/tcg/debug.h"
-#endif
 
 /* CSR function table public API */
 void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops)
@@ -114,7 +115,7 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = env_archcpu(env);
     int ctr_index;
-    target_ulong ctr_mask;
+    uint64_t ctr_mask;
     int base_csrno = CSR_CYCLE;
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
 
@@ -867,14 +868,14 @@ static RISCVException seed(CPURISCVState *env, int csrno)
 
 /* zicfiss CSR_SSP read and write */
 static RISCVException read_ssp(CPURISCVState *env, int csrno,
-                               target_ulong *val)
+                               uint64_t *val)
 {
     *val = env->ssp;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_ssp(CPURISCVState *env, int csrno,
-                                target_ulong val, uintptr_t ra)
+                                uint64_t val, uintptr_t ra)
 {
     env->ssp = val;
     return RISCV_EXCP_NONE;
@@ -882,14 +883,14 @@ static RISCVException write_ssp(CPURISCVState *env, int csrno,
 
 /* User Floating-Point CSRs */
 static RISCVException read_fflags(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = riscv_cpu_get_fflags(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_fflags(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVF)) {
@@ -901,14 +902,14 @@ static RISCVException write_fflags(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_frm(CPURISCVState *env, int csrno,
-                               target_ulong *val)
+                               uint64_t *val)
 {
     *val = env->frm;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_frm(CPURISCVState *env, int csrno,
-                                target_ulong val, uintptr_t ra)
+                                uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVF)) {
@@ -920,7 +921,7 @@ static RISCVException write_frm(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_fcsr(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     /*
      * This is an 8-bit operation, fflags make up the lower 5 bits and
@@ -932,7 +933,7 @@ static RISCVException read_fcsr(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_fcsr(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (riscv_has_ext(env, RVF)) {
@@ -945,7 +946,7 @@ static RISCVException write_fcsr(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vtype(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     uint64_t vill;
     int xl = env->xl;
@@ -967,33 +968,33 @@ static RISCVException read_vtype(CPURISCVState *env, int csrno,
     default:
         g_assert_not_reached();
     }
-    *val = (target_ulong)vill | env->vtype;
+    *val = (uint64_t)vill | env->vtype;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vl(CPURISCVState *env, int csrno,
-                              target_ulong *val)
+                              uint64_t *val)
 {
     *val = env->vl;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vlenb(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = riscv_cpu_cfg(env)->vlenb;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vxrm(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     *val = env->vxrm;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vxrm(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -1003,14 +1004,14 @@ static RISCVException write_vxrm(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vxsat(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->vxsat & BIT(0);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vxsat(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -1020,14 +1021,14 @@ static RISCVException write_vxsat(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vstart(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->vstart;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vstart(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -1041,14 +1042,14 @@ static RISCVException write_vstart(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vcsr(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     *val = (env->vxrm << VCSR_VXRM_SHIFT) | (env->vxsat << VCSR_VXSAT_SHIFT);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vcsr(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
 #if !defined(CONFIG_USER_ONLY)
     env->mstatus |= MSTATUS_VS;
@@ -1060,37 +1061,37 @@ static RISCVException write_vcsr(CPURISCVState *env, int csrno,
 
 #if defined(CONFIG_USER_ONLY)
 /* User Timers and Counters */
-static target_ulong get_ticks(bool shift)
+static uint64_t get_ticks(bool shift)
 {
     int64_t val = cpu_get_host_ticks();
-    target_ulong result = shift ? val >> 32 : val;
+    uint64_t result = shift ? val >> 32 : val;
 
     return result;
 }
 
 static RISCVException read_time(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     *val = cpu_get_host_ticks();
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_timeh(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = cpu_get_host_ticks() >> 32;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = get_ticks(false);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
-                                       target_ulong *val)
+                                       uint64_t *val)
 {
     *val = get_ticks(true);
     return RISCV_EXCP_NONE;
@@ -1099,7 +1100,7 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 #else /* CONFIG_USER_ONLY */
 
 static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
     *val = extract64(env->mcyclecfg, 0, rv32 ? 32 : 64);
@@ -1107,7 +1108,7 @@ static RISCVException read_mcyclecfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
 
@@ -1129,16 +1130,16 @@ static RISCVException write_mcyclecfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mcyclecfgh(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = extract64(env->mcyclecfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
-    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+    uint64_t inh_avail_mask = (uint64_t)(~MHPMEVENTH_FILTER_MASK |
                                                  MCYCLECFGH_BIT_MINH);
 
     /* Set xINH fields if priv mode supported */
@@ -1154,7 +1155,7 @@ static RISCVException write_mcyclecfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
-                                       target_ulong *val)
+                                       uint64_t *val)
 {
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
     *val = extract64(env->minstretcfg, 0, rv32 ? 32 : 64);
@@ -1162,7 +1163,7 @@ static RISCVException read_minstretcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
-                                        target_ulong val, uintptr_t ra)
+                                        uint64_t val, uintptr_t ra)
 {
     uint64_t inh_avail_mask;
 
@@ -1182,16 +1183,16 @@ static RISCVException write_minstretcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_minstretcfgh(CPURISCVState *env, int csrno,
-                                        target_ulong *val)
+                                        uint64_t *val)
 {
     *val = extract64(env->minstretcfg, 32, 32);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
-                                         target_ulong val, uintptr_t ra)
+                                         uint64_t val, uintptr_t ra)
 {
-    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+    uint64_t inh_avail_mask = (uint64_t)(~MHPMEVENTH_FILTER_MASK |
                                                  MINSTRETCFGH_BIT_MINH);
 
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MINSTRETCFGH_BIT_UINH : 0;
@@ -1207,7 +1208,7 @@ static RISCVException write_minstretcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
@@ -1218,7 +1219,7 @@ static RISCVException read_mhpmevent(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MCOUNTINHIBIT;
     uint64_t mhpmevt_val;
@@ -1244,7 +1245,7 @@ static RISCVException write_mhpmevent(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
 
@@ -1254,10 +1255,10 @@ static RISCVException read_mhpmeventh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mhpmeventh(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     int evt_index = csrno - CSR_MHPMEVENT3H + 3;
-    target_ulong inh_avail_mask = (target_ulong)(~MHPMEVENTH_FILTER_MASK |
+    uint64_t inh_avail_mask = (uint64_t)(~MHPMEVENTH_FILTER_MASK |
                                                   MHPMEVENTH_BIT_MINH);
 
     inh_avail_mask |= riscv_has_ext(env, RVU) ? MHPMEVENTH_BIT_UINH : 0;
@@ -1329,7 +1330,7 @@ static uint64_t riscv_pmu_ctr_get_fixed_counters_val(CPURISCVState *env,
     return curr_val;
 }
 
-static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
+static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, uint64_t val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -1359,7 +1360,7 @@ static RISCVException riscv_pmu_write_ctr(CPURISCVState *env, target_ulong val,
     return RISCV_EXCP_NONE;
 }
 
-static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
+static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, uint64_t val,
                                           uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -1385,7 +1386,7 @@ static RISCVException riscv_pmu_write_ctrh(CPURISCVState *env, target_ulong val,
 }
 
 static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
-                                        target_ulong val, uintptr_t ra)
+                                        uint64_t val, uintptr_t ra)
 {
     int ctr_idx = csrno - CSR_MCYCLE;
 
@@ -1393,14 +1394,14 @@ static RISCVException write_mhpmcounter(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mhpmcounterh(CPURISCVState *env, int csrno,
-                                         target_ulong val, uintptr_t ra)
+                                         uint64_t val, uintptr_t ra)
 {
     int ctr_idx = csrno - CSR_MCYCLEH;
 
     return riscv_pmu_write_ctrh(env, val, ctr_idx);
 }
 
-RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
+RISCVException riscv_pmu_read_ctr(CPURISCVState *env, uint64_t *val,
                                   bool upper_half, uint32_t ctr_idx)
 {
     PMUCTRState *counter = &env->pmu_ctrs[ctr_idx];
@@ -1441,7 +1442,7 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *env, target_ulong *val,
 }
 
 static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     uint16_t ctr_index;
 
@@ -1457,7 +1458,7 @@ static RISCVException read_hpmcounter(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
-                                       target_ulong *val)
+                                       uint64_t *val)
 {
     uint16_t ctr_index;
 
@@ -1473,8 +1474,8 @@ static RISCVException read_hpmcounterh(CPURISCVState *env, int csrno,
 }
 
 static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
-                              target_ulong *val, target_ulong new_val,
-                              target_ulong wr_mask)
+                              uint64_t *val, uint64_t new_val,
+                              uint64_t wr_mask)
 {
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
@@ -1492,8 +1493,8 @@ static int rmw_cd_mhpmcounter(CPURISCVState *env, int ctr_idx,
 }
 
 static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
-                               target_ulong *val, target_ulong new_val,
-                               target_ulong wr_mask)
+                               uint64_t *val, uint64_t new_val,
+                               uint64_t wr_mask)
 {
     if (wr_mask != 0 && wr_mask != -1) {
         return -EINVAL;
@@ -1511,7 +1512,7 @@ static int rmw_cd_mhpmcounterh(CPURISCVState *env, int ctr_idx,
 }
 
 static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
-                            target_ulong *val, target_ulong new_val,
+                            uint64_t *val, uint64_t new_val,
                             uint64_t wr_mask)
 {
     uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
@@ -1539,8 +1540,8 @@ static int rmw_cd_mhpmevent(CPURISCVState *env, int evt_index,
 }
 
 static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
-                             target_ulong *val, target_ulong new_val,
-                             target_ulong wr_mask)
+                             uint64_t *val, uint64_t new_val,
+                             uint64_t wr_mask)
 {
     uint64_t mhpmevt_val = env->mhpmevent_val[evt_index];
     uint32_t mhpmevth_val = extract64(mhpmevt_val, 32, 32);
@@ -1567,8 +1568,8 @@ static int rmw_cd_mhpmeventh(CPURISCVState *env, int evt_index,
     return 0;
 }
 
-static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
-                          target_ulong new_val, uint64_t wr_mask)
+static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, uint64_t *val,
+                          uint64_t new_val, uint64_t wr_mask)
 {
     /*
      * wr_mask is 64-bit so upper 32 bits of mcyclecfg and minstretcfg
@@ -1598,8 +1599,8 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
     return 0;
 }
 
-static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
-                           target_ulong new_val, target_ulong wr_mask)
+static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, uint64_t *val,
+                           uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t cfgh;
 
@@ -1636,7 +1637,7 @@ static int rmw_cd_ctr_cfgh(CPURISCVState *env, int cfg_index, target_ulong *val,
 
 
 static RISCVException read_scountovf(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     int mhpmevt_start = CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
     int i;
@@ -1673,7 +1674,7 @@ static RISCVException read_scountovf(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_time(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     uint64_t delta = env->virt_enabled ? env->htimedelta : 0;
 
@@ -1686,7 +1687,7 @@ static RISCVException read_time(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_timeh(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     uint64_t delta = env->virt_enabled ? env->htimedelta : 0;
 
@@ -1699,7 +1700,7 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vstimecmp(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     *val = env->vstimecmp;
 
@@ -1707,7 +1708,7 @@ static RISCVException read_vstimecmp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vstimecmph(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = env->vstimecmp >> 32;
 
@@ -1715,7 +1716,7 @@ static RISCVException read_vstimecmph(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstimecmp(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         env->vstimecmp = deposit64(env->vstimecmp, 0, 32, (uint64_t)val);
@@ -1730,7 +1731,7 @@ static RISCVException write_vstimecmp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_vstimecmph(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     env->vstimecmp = deposit64(env->vstimecmp, 32, 32, (uint64_t)val);
     riscv_timer_write_timecmp(env, env->vstimer, env->vstimecmp,
@@ -1740,7 +1741,7 @@ static RISCVException write_vstimecmph(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_stimecmp(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     if (env->virt_enabled) {
         *val = env->vstimecmp;
@@ -1752,7 +1753,7 @@ static RISCVException read_stimecmp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_stimecmph(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     if (env->virt_enabled) {
         *val = env->vstimecmp >> 32;
@@ -1764,7 +1765,7 @@ static RISCVException read_stimecmph(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_stimecmp(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
@@ -1785,7 +1786,7 @@ static RISCVException write_stimecmp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     if (env->virt_enabled) {
         if (env->hvictl & HVICTL_VTI) {
@@ -1836,7 +1837,7 @@ static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                          (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) | \
                          (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) | \
                          (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)))
-static const target_ulong vs_delegable_excps = DELEGABLE_EXCPS &
+static const uint64_t vs_delegable_excps = DELEGABLE_EXCPS &
     ~((1ULL << (RISCV_EXCP_S_ECALL)) |
       (1ULL << (RISCV_EXCP_VS_ECALL)) |
       (1ULL << (RISCV_EXCP_M_ECALL)) |
@@ -1844,7 +1845,7 @@ static const target_ulong vs_delegable_excps = DELEGABLE_EXCPS &
       (1ULL << (RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT)) |
       (1ULL << (RISCV_EXCP_VIRT_INSTRUCTION_FAULT)) |
       (1ULL << (RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT)));
-static const target_ulong sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
+static const uint64_t sstatus_v1_10_mask = SSTATUS_SIE | SSTATUS_SPIE |
     SSTATUS_UIE | SSTATUS_UPIE | SSTATUS_SPP | SSTATUS_FS | SSTATUS_XS |
     SSTATUS_SUM | SSTATUS_MXR | SSTATUS_VS;
 
@@ -1876,41 +1877,41 @@ static const uint64_t vsip_writable_mask = MIP_VSSIP | LOCAL_INTERRUPTS;
 
 /* Machine Information Registers */
 static RISCVException read_zero(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     *val = 0;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_ignore(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mvendorid(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     *val = riscv_cpu_cfg(env)->mvendorid;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_marchid(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = riscv_cpu_cfg(env)->marchid;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mimpid(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = riscv_cpu_cfg(env)->mimpid;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mhartid(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->mhartid;
     return RISCV_EXCP_NONE;
@@ -1939,13 +1940,13 @@ static uint64_t add_status_sd(RISCVMXL xl, uint64_t status)
 }
 
 static RISCVException read_mstatus(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = add_status_sd(riscv_cpu_mxl(env), env->mstatus);
     return RISCV_EXCP_NONE;
 }
 
-static bool validate_vm(CPURISCVState *env, target_ulong vm)
+static bool validate_vm(CPURISCVState *env, uint64_t vm)
 {
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32;
     RISCVCPU *cpu = env_archcpu(env);
@@ -1956,10 +1957,10 @@ static bool validate_vm(CPURISCVState *env, target_ulong vm)
     return vm <= satp_mode_supported_max && valid_vm[vm];
 }
 
-static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
-                                  target_ulong val)
+static uint64_t legalize_xatp(CPURISCVState *env, uint64_t old_xatp,
+                              uint64_t val)
 {
-    target_ulong mask;
+    uint64_t mask;
     bool vm;
     if (riscv_cpu_mxl(env) == MXL_RV32) {
         vm = validate_vm(env, get_field(val, SATP32_MODE));
@@ -1982,11 +1983,11 @@ static target_ulong legalize_xatp(CPURISCVState *env, target_ulong old_xatp,
     return old_xatp;
 }
 
-static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
-                                 target_ulong val)
+static uint64_t legalize_mpp(CPURISCVState *env, uint64_t old_mpp,
+                             uint64_t val)
 {
     bool valid = false;
-    target_ulong new_mpp = get_field(val, MSTATUS_MPP);
+    uint64_t new_mpp = get_field(val, MSTATUS_MPP);
 
     switch (new_mpp) {
     case PRV_M:
@@ -2023,7 +2024,7 @@ static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
 }
 
 static RISCVException write_mstatus(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     uint64_t mstatus = env->mstatus;
     uint64_t mask = 0;
@@ -2099,14 +2100,14 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mstatush(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->mstatus >> 32;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mstatush(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     uint64_t valh = (uint64_t)val << 32;
     uint64_t mask = 0;
@@ -2138,19 +2139,17 @@ static RISCVException read_misa_i128(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_misa(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
-    target_ulong misa;
+    uint64_t misa;
 
     switch (env->misa_mxl) {
     case MXL_RV32:
-        misa = (target_ulong)MXL_RV32 << 30;
+        misa = (uint64_t)MXL_RV32 << 30;
         break;
-#ifdef TARGET_RISCV64
     case MXL_RV64:
-        misa = (target_ulong)MXL_RV64 << 62;
+        misa = (uint64_t)MXL_RV64 << 62;
         break;
-#endif
     default:
         g_assert_not_reached();
     }
@@ -2159,7 +2158,7 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
+static uint64_t get_next_pc(CPURISCVState *env, uintptr_t ra)
 {
     uint64_t data[INSN_START_WORDS];
 
@@ -2173,7 +2172,7 @@ static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
 }
 
 static RISCVException write_misa(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
     uint32_t orig_misa_ext = env->misa_ext;
@@ -2229,14 +2228,14 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_medeleg(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->medeleg;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_medeleg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     env->medeleg = (env->medeleg & ~DELEGABLE_EXCPS) | (val & DELEGABLE_EXCPS);
     return RISCV_EXCP_NONE;
@@ -2262,8 +2261,8 @@ static RISCVException rmw_mideleg64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mideleg(CPURISCVState *env, int csrno,
-                                  target_ulong *ret_val,
-                                  target_ulong new_val, target_ulong wr_mask)
+                                  uint64_t *ret_val,
+                                  uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -2277,9 +2276,9 @@ static RISCVException rmw_mideleg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_midelegh(CPURISCVState *env, int csrno,
-                                   target_ulong *ret_val,
-                                   target_ulong new_val,
-                                   target_ulong wr_mask)
+                                   uint64_t *ret_val,
+                                   uint64_t new_val,
+                                   uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -2313,8 +2312,8 @@ static RISCVException rmw_mie64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mie(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -2328,8 +2327,8 @@ static RISCVException rmw_mie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mieh(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -2359,8 +2358,8 @@ static RISCVException rmw_mvien64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mvien(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -2374,8 +2373,8 @@ static RISCVException rmw_mvien(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mvienh(CPURISCVState *env, int csrno,
-                                target_ulong *ret_val,
-                                target_ulong new_val, target_ulong wr_mask)
+                                uint64_t *ret_val,
+                                uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -2390,7 +2389,7 @@ static RISCVException rmw_mvienh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mtopi(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     int irq;
     uint8_t iprio;
@@ -2452,8 +2451,8 @@ static int csrind_xlate_vs_csrno(CPURISCVState *env, int csrno)
 }
 
 static RISCVException rmw_xiselect(CPURISCVState *env, int csrno,
-                                   target_ulong *val, target_ulong new_val,
-                                   target_ulong wr_mask)
+                                   uint64_t *val, uint64_t new_val,
+                                   uint64_t wr_mask)
 {
     uint16_t *iselect;
     int ret;
@@ -2516,13 +2515,13 @@ static bool xiselect_ctr_range(int csrno, uint16_t isel)
            csrno < CSR_MIREG;
 }
 
-static int rmw_iprio(target_ulong xlen,
+static int rmw_iprio(uint64_t xlen,
                      uint16_t iselect, uint8_t *iprio,
-                     target_ulong *val, target_ulong new_val,
-                     target_ulong wr_mask, int ext_irq_no)
+                     uint64_t *val, uint64_t new_val,
+                     uint64_t wr_mask, int ext_irq_no)
 {
     int i, firq, nirqs;
-    target_ulong old_val;
+    uint64_t old_val;
 
     if (iselect < ISELECT_IPRIO0 || ISELECT_IPRIO15 < iselect) {
         return -EINVAL;
@@ -2536,7 +2535,7 @@ static int rmw_iprio(target_ulong xlen,
 
     old_val = 0;
     for (i = 0; i < nirqs; i++) {
-        old_val |= ((target_ulong)iprio[firq + i]) << (IPRIO_IRQ_BITS * i);
+        old_val |= ((uint64_t)iprio[firq + i]) << (IPRIO_IRQ_BITS * i);
     }
 
     if (val) {
@@ -2561,8 +2560,8 @@ static int rmw_iprio(target_ulong xlen,
     return 0;
 }
 
-static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, target_ulong *val,
-                          target_ulong new_val, target_ulong wr_mask)
+static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, uint64_t *val,
+                         uint64_t new_val, uint64_t wr_mask)
 {
     /*
      * CTR arrays are treated as circular buffers and TOS always points to next
@@ -2600,8 +2599,8 @@ static int rmw_ctrsource(CPURISCVState *env, uint16_t isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, target_ulong *val,
-                          target_ulong new_val, target_ulong wr_mask)
+static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, uint64_t *val,
+                          uint64_t new_val, uint64_t wr_mask)
 {
     /*
      * CTR arrays are treated as circular buffers and TOS always points to next
@@ -2639,8 +2638,8 @@ static int rmw_ctrtarget(CPURISCVState *env, uint16_t isel, target_ulong *val,
     return 0;
 }
 
-static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, target_ulong *val,
-                        target_ulong new_val, target_ulong wr_mask)
+static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, uint64_t *val,
+                       uint64_t new_val, uint64_t wr_mask)
 {
     /*
      * CTR arrays are treated as circular buffers and TOS always points to next
@@ -2680,8 +2679,8 @@ static int rmw_ctrdata(CPURISCVState *env, uint16_t isel, target_ulong *val,
 }
 
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
-                         uint16_t isel, target_ulong *val,
-                         target_ulong new_val, target_ulong wr_mask)
+                                    uint16_t isel, uint64_t *val,
+                                    uint64_t new_val, uint64_t wr_mask)
 {
     bool virt = false, isel_reserved = false;
     int ret = -EINVAL;
@@ -2765,8 +2764,8 @@ done:
 }
 
 static int rmw_xireg_cd(CPURISCVState *env, int csrno,
-                        uint16_t isel, target_ulong *val,
-                        target_ulong new_val, target_ulong wr_mask)
+                        uint16_t isel, uint64_t *val,
+                        uint64_t new_val, uint64_t wr_mask)
 {
     int ret = -EINVAL;
     uint16_t ctr_index = isel - ISELECT_CD_FIRST;
@@ -2837,8 +2836,8 @@ done:
 }
 
 static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
-                        uint16_t isel, target_ulong *val,
-                        target_ulong new_val, target_ulong wr_mask)
+                         uint16_t isel, uint64_t *val,
+                         uint64_t new_val, uint64_t wr_mask)
 {
     if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
         return -EINVAL;
@@ -2865,8 +2864,8 @@ static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
  * extension using csrind should be implemented here.
  */
 static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
-                              uint16_t isel, target_ulong *val,
-                              target_ulong new_val, target_ulong wr_mask)
+                            uint16_t isel, uint64_t *val,
+                            uint64_t new_val, uint64_t wr_mask)
 {
     bool virt = csrno == CSR_VSIREG ? true : false;
     int ret = -EINVAL;
@@ -2891,8 +2890,8 @@ static int rmw_xireg_csrind(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
-static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
-                      target_ulong new_val, target_ulong wr_mask)
+static int rmw_xiregi(CPURISCVState *env, int csrno, uint64_t *val,
+                      uint64_t new_val, uint64_t wr_mask)
 {
     int ret = -EINVAL;
     uint16_t isel;
@@ -2922,8 +2921,8 @@ static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
 }
 
 static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
-                                target_ulong *val, target_ulong new_val,
-                                target_ulong wr_mask)
+                                uint64_t *val, uint64_t new_val,
+                                uint64_t wr_mask)
 {
     int ret = -EINVAL;
     uint16_t isel;
@@ -2971,8 +2970,8 @@ done:
 }
 
 static RISCVException rmw_xtopei(CPURISCVState *env, int csrno,
-                                 target_ulong *val, target_ulong new_val,
-                                 target_ulong wr_mask)
+                                 uint64_t *val, uint64_t new_val,
+                                 uint64_t wr_mask)
 {
     bool virt;
     int ret = -EINVAL;
@@ -3034,14 +3033,14 @@ done:
 }
 
 static RISCVException read_mtvec(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->mtvec;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mtvec(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
     if ((val & 3) < 2) {
@@ -3053,20 +3052,20 @@ static RISCVException write_mtvec(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
-                                         target_ulong *val)
+                                         uint64_t *val)
 {
     *val = env->mcountinhibit;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
-                                          target_ulong val, uintptr_t ra)
+                                          uint64_t val, uintptr_t ra)
 {
     int cidx;
     PMUCTRState *counter;
     RISCVCPU *cpu = env_archcpu(env);
     uint32_t present_ctrs = cpu->pmu_avail_ctrs | COUNTEREN_CY | COUNTEREN_IR;
-    target_ulong updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
+    uint64_t updated_ctrs = (env->mcountinhibit ^ val) & present_ctrs;
     uint64_t mhpmctr_val, prev_count, curr_count;
 
     /* WARL register - disable unavailable counters; TM bit is always 0 */
@@ -3104,7 +3103,7 @@ static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
-                                         target_ulong *val)
+                                         uint64_t *val)
 {
     /* S-mode can only access the bits delegated by M-mode */
     *val = env->mcountinhibit & env->mcounteren;
@@ -3112,20 +3111,20 @@ static RISCVException read_scountinhibit(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_scountinhibit(CPURISCVState *env, int csrno,
-                                          target_ulong val, uintptr_t ra)
+                                          uint64_t val, uintptr_t ra)
 {
     return write_mcountinhibit(env, csrno, val & env->mcounteren, ra);
 }
 
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = env->mcounteren;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mcounteren(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -3152,56 +3151,56 @@ static RISCVException write_mscratch_i128(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mscratch(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->mscratch;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mscratch(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     env->mscratch = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mepc(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     *val = env->mepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mepc(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
     env->mepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mcause(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->mcause;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mcause(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     env->mcause = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mtval(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->mtval;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mtval(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->mtval = val;
     return RISCV_EXCP_NONE;
@@ -3209,16 +3208,16 @@ static RISCVException write_mtval(CPURISCVState *env, int csrno,
 
 /* Execution environment configuration setup */
 static RISCVException read_menvcfg(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->menvcfg;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra);
+                                    uint64_t val, uintptr_t ra);
 static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = MENVCFG_FIOM | MENVCFG_CBIE | MENVCFG_CBCFE |
@@ -3270,16 +3269,16 @@ static RISCVException write_menvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_menvcfgh(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->menvcfg >> 32;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra);
+                                     uint64_t val, uintptr_t ra);
 static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = (cfg->ext_svpbmt ? MENVCFG_PBMTE : 0) |
@@ -3309,7 +3308,7 @@ static RISCVException write_menvcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     RISCVException ret;
 
@@ -3323,7 +3322,7 @@ static RISCVException read_senvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     uint64_t mask = SENVCFG_FIOM | SENVCFG_CBIE | SENVCFG_CBCFE | SENVCFG_CBZE;
     RISCVException ret;
@@ -3359,7 +3358,7 @@ static RISCVException write_senvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     RISCVException ret;
 
@@ -3380,7 +3379,7 @@ static RISCVException read_henvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = HENVCFG_FIOM | HENVCFG_CBIE | HENVCFG_CBCFE | HENVCFG_CBZE;
@@ -3443,7 +3442,7 @@ static RISCVException write_henvcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     RISCVException ret;
 
@@ -3458,7 +3457,7 @@ static RISCVException read_henvcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     const RISCVCPUConfig *cfg = riscv_cpu_cfg(env);
     uint64_t mask = env->menvcfg & (HENVCFG_PBMTE | HENVCFG_STCE |
@@ -3490,7 +3489,7 @@ static RISCVException write_henvcfgh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mstateen(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->mstateen[csrno - CSR_MSTATEEN0];
 
@@ -3498,7 +3497,7 @@ static RISCVException read_mstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen(CPURISCVState *env, int csrno,
-                                     uint64_t wr_mask, target_ulong new_val)
+                                     uint64_t wr_mask, uint64_t new_val)
 {
     uint64_t *reg;
 
@@ -3509,7 +3508,7 @@ static RISCVException write_mstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
-                                      target_ulong new_val, uintptr_t ra)
+                                      uint64_t new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
     if (!riscv_has_ext(env, RVF)) {
@@ -3545,13 +3544,13 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen_1_3(CPURISCVState *env, int csrno,
-                                         target_ulong new_val, uintptr_t ra)
+                                         uint64_t new_val, uintptr_t ra)
 {
     return write_mstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
 
 static RISCVException read_mstateenh(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     *val = env->mstateen[csrno - CSR_MSTATEEN0H] >> 32;
 
@@ -3559,7 +3558,7 @@ static RISCVException read_mstateenh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateenh(CPURISCVState *env, int csrno,
-                                      uint64_t wr_mask, target_ulong new_val)
+                                      uint64_t wr_mask, uint64_t new_val)
 {
     uint64_t *reg, val;
 
@@ -3572,7 +3571,7 @@ static RISCVException write_mstateenh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
-                                       target_ulong new_val, uintptr_t ra)
+                                       uint64_t new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3602,13 +3601,13 @@ static RISCVException write_mstateen0h(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_mstateenh_1_3(CPURISCVState *env, int csrno,
-                                          target_ulong new_val, uintptr_t ra)
+                                          uint64_t new_val, uintptr_t ra)
 {
     return write_mstateenh(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
 
 static RISCVException read_hstateen(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     int index = csrno - CSR_HSTATEEN0;
 
@@ -3618,7 +3617,7 @@ static RISCVException read_hstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen(CPURISCVState *env, int csrno,
-                                     uint64_t mask, target_ulong new_val)
+                                     uint64_t mask, uint64_t new_val)
 {
     int index = csrno - CSR_HSTATEEN0;
     uint64_t *reg, wr_mask;
@@ -3631,7 +3630,7 @@ static RISCVException write_hstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
-                                      target_ulong new_val, uintptr_t ra)
+                                      uint64_t new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3664,13 +3663,13 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen_1_3(CPURISCVState *env, int csrno,
-                                         target_ulong new_val, uintptr_t ra)
+                                         uint64_t new_val, uintptr_t ra)
 {
     return write_hstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
 
 static RISCVException read_hstateenh(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     int index = csrno - CSR_HSTATEEN0H;
 
@@ -3680,7 +3679,7 @@ static RISCVException read_hstateenh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateenh(CPURISCVState *env, int csrno,
-                                      uint64_t mask, target_ulong new_val)
+                                      uint64_t mask, uint64_t new_val)
 {
     int index = csrno - CSR_HSTATEEN0H;
     uint64_t *reg, wr_mask, val;
@@ -3695,7 +3694,7 @@ static RISCVException write_hstateenh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
-                                       target_ulong new_val, uintptr_t ra)
+                                       uint64_t new_val, uintptr_t ra)
 {
     uint64_t wr_mask = SMSTATEEN_STATEEN | SMSTATEEN0_HSENVCFG;
 
@@ -3721,13 +3720,13 @@ static RISCVException write_hstateen0h(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstateenh_1_3(CPURISCVState *env, int csrno,
-                                          target_ulong new_val, uintptr_t ra)
+                                          uint64_t new_val, uintptr_t ra)
 {
     return write_hstateenh(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
 
 static RISCVException read_sstateen(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     bool virt = env->virt_enabled;
     int index = csrno - CSR_SSTATEEN0;
@@ -3741,7 +3740,7 @@ static RISCVException read_sstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstateen(CPURISCVState *env, int csrno,
-                                     uint64_t mask, target_ulong new_val)
+                                     uint64_t mask, uint64_t new_val)
 {
     bool virt = env->virt_enabled;
     int index = csrno - CSR_SSTATEEN0;
@@ -3760,7 +3759,7 @@ static RISCVException write_sstateen(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
-                                      target_ulong new_val, uintptr_t ra)
+                                      uint64_t new_val, uintptr_t ra)
 {
     uint64_t wr_mask = 0;
 
@@ -3772,7 +3771,7 @@ static RISCVException write_sstateen0(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstateen_1_3(CPURISCVState *env, int csrno,
-                                         target_ulong new_val, uintptr_t ra)
+                                         uint64_t new_val, uintptr_t ra)
 {
     return write_sstateen(env, csrno, SMSTATEEN_STATEEN, new_val);
 }
@@ -3830,8 +3829,8 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mip(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -3845,8 +3844,8 @@ static RISCVException rmw_mip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_miph(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -3872,11 +3871,11 @@ static RISCVException rmw_miph(CPURISCVState *env, int csrno,
  * mvien[i] are zero but mvip needs to be an alias of mip.
  */
 static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
-                                uint64_t *ret_val,
-                                uint64_t new_val, uint64_t wr_mask)
+                                 uint64_t *ret_val,
+                                 uint64_t new_val, uint64_t wr_mask)
 {
     RISCVCPU *cpu = env_archcpu(env);
-    target_ulong ret_mip = 0;
+    uint64_t ret_mip = 0;
     RISCVException ret;
     uint64_t old_mvip;
 
@@ -3967,8 +3966,8 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mvip(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -3982,8 +3981,8 @@ static RISCVException rmw_mvip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_mviph(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                                uint64_t *ret_val,
+                                uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4019,9 +4018,9 @@ static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_sstatus(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
-    target_ulong mask = (sstatus_v1_10_mask);
+    uint64_t mask = (sstatus_v1_10_mask);
     if (env->xl != MXL_RV32 || env->debugger) {
         mask |= SSTATUS64_UXL;
     }
@@ -4038,9 +4037,9 @@ static RISCVException read_sstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_sstatus(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
-    target_ulong mask = (sstatus_v1_10_mask);
+    uint64_t mask = (sstatus_v1_10_mask);
 
     if (env->xl != MXL_RV32 || env->debugger) {
         if ((val & SSTATUS64_UXL) != 0) {
@@ -4054,7 +4053,7 @@ static RISCVException write_sstatus(CPURISCVState *env, int csrno,
     if (riscv_cpu_cfg(env)->ext_ssdbltrp) {
         mask |= SSTATUS_SDT;
     }
-    target_ulong newval = (env->mstatus & ~mask) | (val & mask);
+    uint64_t newval = (env->mstatus & ~mask) | (val & mask);
     return write_mstatus(env, CSR_MSTATUS, newval, ra);
 }
 
@@ -4098,8 +4097,8 @@ static RISCVException rmw_vsie64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_vsie(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4113,8 +4112,8 @@ static RISCVException rmw_vsie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_vsieh(CPURISCVState *env, int csrno,
-                                target_ulong *ret_val,
-                                target_ulong new_val, target_ulong wr_mask)
+                                uint64_t *ret_val,
+                                uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4169,8 +4168,8 @@ static RISCVException rmw_sie64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_sie(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4184,8 +4183,8 @@ static RISCVException rmw_sie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_sieh(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4200,14 +4199,14 @@ static RISCVException rmw_sieh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_stvec(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->stvec;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_stvec(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
     if ((val & 3) < 2) {
@@ -4219,14 +4218,14 @@ static RISCVException write_stvec(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_scounteren(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = env->scounteren;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_scounteren(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -4253,56 +4252,56 @@ static RISCVException write_sscratch_i128(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_sscratch(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->sscratch;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_sscratch(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     env->sscratch = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_sepc(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     *val = env->sepc & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_sepc(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
     env->sepc = val & get_xepc_mask(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_scause(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->scause;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_scause(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     env->scause = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_stval(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->stval;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_stval(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->stval = val;
     return RISCV_EXCP_NONE;
@@ -4344,8 +4343,8 @@ static RISCVException rmw_vsip64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_vsip(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4359,8 +4358,8 @@ static RISCVException rmw_vsip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_vsiph(CPURISCVState *env, int csrno,
-                                target_ulong *ret_val,
-                                target_ulong new_val, target_ulong wr_mask)
+                                uint64_t *ret_val,
+                                uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4399,8 +4398,8 @@ static RISCVException rmw_sip64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_sip(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4414,8 +4413,8 @@ static RISCVException rmw_sip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_siph(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4431,7 +4430,7 @@ static RISCVException rmw_siph(CPURISCVState *env, int csrno,
 
 /* Supervisor Protection and Translation */
 static RISCVException read_satp(CPURISCVState *env, int csrno,
-                                target_ulong *val)
+                                uint64_t *val)
 {
     if (!riscv_cpu_cfg(env)->mmu) {
         *val = 0;
@@ -4442,7 +4441,7 @@ static RISCVException read_satp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_satp(CPURISCVState *env, int csrno,
-                                 target_ulong val, uintptr_t ra)
+                                 uint64_t val, uintptr_t ra)
 {
     if (!riscv_cpu_cfg(env)->mmu) {
         return RISCV_EXCP_NONE;
@@ -4453,8 +4452,8 @@ static RISCVException write_satp(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
-                                    target_ulong *ret_val,
-                                    target_ulong new_val, target_ulong wr_mask)
+                                    uint64_t *ret_val,
+                                    uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t mask = wr_mask & SCTRDEPTH_MASK;
 
@@ -4483,8 +4482,8 @@ static RISCVException rmw_sctrdepth(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
-                                     target_ulong *ret_val,
-                                     target_ulong new_val, target_ulong wr_mask)
+                                     uint64_t *ret_val,
+                                     uint64_t new_val, uint64_t wr_mask)
 {
     uint32_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
     uint32_t mask = wr_mask & SCTRSTATUS_MASK;
@@ -4502,8 +4501,8 @@ static RISCVException rmw_sctrstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
-                                    target_ulong *ret_val,
-                                    target_ulong new_val, target_ulong wr_mask)
+                                    uint64_t *ret_val,
+                                    uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t csr_mask, mask = wr_mask;
     uint64_t *ctl_ptr = &env->mctrctl;
@@ -4533,7 +4532,7 @@ static RISCVException rmw_xctrctl(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vstopi(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     int irq, ret;
     uint64_t topei = 0;
@@ -4623,7 +4622,7 @@ static RISCVException read_vstopi(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_stopi(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     int irq;
     uint8_t iprio;
@@ -4651,7 +4650,7 @@ static RISCVException read_stopi(CPURISCVState *env, int csrno,
 
 /* Hypervisor Extensions */
 static RISCVException read_hstatus(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->hstatus;
     if (riscv_cpu_mxl(env) != MXL_RV32) {
@@ -4664,9 +4663,9 @@ static RISCVException read_hstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hstatus(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
-    uint64_t mask = (target_ulong)-1;
+    uint64_t mask = ~0ULL;
     if (!env_archcpu(env)->cfg.ext_svukte) {
         mask &= ~HSTATUS_HUKTE;
     }
@@ -4689,21 +4688,21 @@ static RISCVException write_hstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_hedeleg(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->hedeleg;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_hedeleg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     env->hedeleg = val & vs_delegable_excps;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     RISCVException ret;
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
@@ -4717,7 +4716,7 @@ static RISCVException read_hedelegh(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hedelegh(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     RISCVException ret;
     ret = smstateen_acc_ok(env, 0, SMSTATEEN0_P1P13);
@@ -4745,8 +4744,8 @@ static RISCVException rmw_hvien64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hvien(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4760,8 +4759,8 @@ static RISCVException rmw_hvien(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hvienh(CPURISCVState *env, int csrno,
-                                   target_ulong *ret_val,
-                                   target_ulong new_val, target_ulong wr_mask)
+                                 uint64_t *ret_val,
+                                 uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4790,8 +4789,8 @@ static RISCVException rmw_hideleg64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hideleg(CPURISCVState *env, int csrno,
-                                  target_ulong *ret_val,
-                                  target_ulong new_val, target_ulong wr_mask)
+                                  uint64_t *ret_val,
+                                  uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4805,8 +4804,8 @@ static RISCVException rmw_hideleg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hidelegh(CPURISCVState *env, int csrno,
-                                   target_ulong *ret_val,
-                                   target_ulong new_val, target_ulong wr_mask)
+                                   uint64_t *ret_val,
+                                   uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4914,8 +4913,8 @@ static RISCVException rmw_hvip64(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hvip(CPURISCVState *env, int csrno,
-                               target_ulong *ret_val,
-                               target_ulong new_val, target_ulong wr_mask)
+                               uint64_t *ret_val,
+                               uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4929,8 +4928,8 @@ static RISCVException rmw_hvip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hviph(CPURISCVState *env, int csrno,
-                                target_ulong *ret_val,
-                                target_ulong new_val, target_ulong wr_mask)
+                                uint64_t *ret_val,
+                                uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4945,8 +4944,8 @@ static RISCVException rmw_hviph(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hip(CPURISCVState *env, int csrno,
-                              target_ulong *ret_value,
-                              target_ulong new_value, target_ulong write_mask)
+                              uint64_t *ret_value,
+                              uint64_t new_value, uint64_t write_mask)
 {
     int ret = rmw_mip(env, csrno, ret_value, new_value,
                       write_mask & hip_writable_mask);
@@ -4958,8 +4957,8 @@ static RISCVException rmw_hip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException rmw_hie(CPURISCVState *env, int csrno,
-                              target_ulong *ret_val,
-                              target_ulong new_val, target_ulong wr_mask)
+                              uint64_t *ret_val,
+                              uint64_t new_val, uint64_t wr_mask)
 {
     uint64_t rval;
     RISCVException ret;
@@ -4973,14 +4972,14 @@ static RISCVException rmw_hie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_hcounteren(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = env->hcounteren;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     RISCVCPU *cpu = env_archcpu(env);
 
@@ -4991,7 +4990,7 @@ static RISCVException write_hcounteren(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_hgeie(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     if (val) {
         *val = env->hgeie;
@@ -5000,7 +4999,7 @@ static RISCVException read_hgeie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_hgeie(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     /* Only GEILEN:1 bits implemented and BIT0 is never implemented */
     val &= ((1ULL << env->geilen) - 1) << 1;
@@ -5012,34 +5011,34 @@ static RISCVException write_hgeie(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_htval(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->htval;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_htval(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->htval = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_htinst(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->htinst;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_htinst(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hgeip(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     if (val) {
         *val = env->hgeip;
@@ -5048,21 +5047,21 @@ static RISCVException read_hgeip(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_hgatp(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->hgatp;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_hgatp(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->hgatp = legalize_xatp(env, env->hgatp, val);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_htimedelta(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     if (!env->rdtime_fn) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -5073,7 +5072,7 @@ static RISCVException read_htimedelta(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_htimedelta(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     if (!env->rdtime_fn) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -5094,7 +5093,7 @@ static RISCVException write_htimedelta(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_htimedeltah(CPURISCVState *env, int csrno,
-                                       target_ulong *val)
+                                       uint64_t *val)
 {
     if (!env->rdtime_fn) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -5105,7 +5104,7 @@ static RISCVException read_htimedeltah(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
-                                        target_ulong val, uintptr_t ra)
+                                        uint64_t val, uintptr_t ra)
 {
     if (!env->rdtime_fn) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -5122,21 +5121,21 @@ static RISCVException write_htimedeltah(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_hvictl(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->hvictl;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_hvictl(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     env->hvictl = val & HVICTL_VALID_MASK;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_hvipriox(CPURISCVState *env, int first_index,
-                         uint8_t *iprio, target_ulong *val)
+                                    uint8_t *iprio, uint64_t *val)
 {
     int i, irq, rdzero, num_irqs = 4 * (riscv_cpu_mxl_bits(env) / 32);
 
@@ -5155,14 +5154,14 @@ static RISCVException read_hvipriox(CPURISCVState *env, int first_index,
         if (rdzero) {
             continue;
         }
-        *val |= ((target_ulong)iprio[irq]) << (i * 8);
+        *val |= ((uint64_t)iprio[irq]) << (i * 8);
     }
 
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_hvipriox(CPURISCVState *env, int first_index,
-                          uint8_t *iprio, target_ulong val)
+                                     uint8_t *iprio, uint64_t val)
 {
     int i, irq, rdzero, num_irqs = 4 * (riscv_cpu_mxl_bits(env) / 32);
 
@@ -5188,65 +5187,65 @@ static RISCVException write_hvipriox(CPURISCVState *env, int first_index,
 }
 
 static RISCVException read_hviprio1(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     return read_hvipriox(env, 0, env->hviprio, val);
 }
 
 static RISCVException write_hviprio1(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     return write_hvipriox(env, 0, env->hviprio, val);
 }
 
 static RISCVException read_hviprio1h(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     return read_hvipriox(env, 4, env->hviprio, val);
 }
 
 static RISCVException write_hviprio1h(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     return write_hvipriox(env, 4, env->hviprio, val);
 }
 
 static RISCVException read_hviprio2(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     return read_hvipriox(env, 8, env->hviprio, val);
 }
 
 static RISCVException write_hviprio2(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     return write_hvipriox(env, 8, env->hviprio, val);
 }
 
 static RISCVException read_hviprio2h(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     return read_hvipriox(env, 12, env->hviprio, val);
 }
 
 static RISCVException write_hviprio2h(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     return write_hvipriox(env, 12, env->hviprio, val);
 }
 
 /* Virtual CSR Registers */
 static RISCVException read_vsstatus(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->vsstatus;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
-    uint64_t mask = (target_ulong)-1;
+    uint64_t mask = ~0ULL;
     if ((val & VSSTATUS64_UXL) == 0) {
         mask &= ~VSSTATUS64_UXL;
     } else {
@@ -5264,14 +5263,14 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vstvec(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->vstvec;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vstvec(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     /* bits [1:0] encode mode; 0 = direct, 1 = vectored, 2 >= reserved */
     if ((val & 3) < 2) {
@@ -5283,98 +5282,98 @@ static RISCVException write_vstvec(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_vsscratch(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     *val = env->vsscratch;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vsscratch(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     env->vsscratch = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vsepc(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->vsepc;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vsepc(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->vsepc = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vscause(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->vscause;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vscause(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     env->vscause = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vstval(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->vstval;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vstval(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     env->vstval = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_vsatp(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->vsatp;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_vsatp(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->vsatp = legalize_xatp(env, env->vsatp, val);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mtval2(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->mtval2;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mtval2(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     env->mtval2 = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mtinst(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     *val = env->mtinst;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mtinst(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     env->mtinst = val;
     return RISCV_EXCP_NONE;
@@ -5382,21 +5381,21 @@ static RISCVException write_mtinst(CPURISCVState *env, int csrno,
 
 /* Physical Memory Protection */
 static RISCVException read_mseccfg(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = mseccfg_csr_read(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mseccfg(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     mseccfg_csr_write(env, val);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_pmpcfg(CPURISCVState *env, int csrno,
-                                  target_ulong *val)
+                                  uint64_t *val)
 {
     uint32_t reg_index = csrno - CSR_PMPCFG0;
 
@@ -5405,7 +5404,7 @@ static RISCVException read_pmpcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_pmpcfg(CPURISCVState *env, int csrno,
-                                   target_ulong val, uintptr_t ra)
+                                   uint64_t val, uintptr_t ra)
 {
     uint32_t reg_index = csrno - CSR_PMPCFG0;
 
@@ -5414,7 +5413,7 @@ static RISCVException write_pmpcfg(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = pmpaddr_csr_read(env, csrno - CSR_PMPADDR0);
 
@@ -5422,44 +5421,38 @@ static RISCVException read_pmpaddr(CPURISCVState *env, int csrno,
      * For RV64, bits 54-63 of the address registers
      * PMPAADDR(0-63) is a WARL zero field (priv spec,
      * section "Physical Memory Protection CSRs").
-     *
-     * We'll have to add an annoying TARGET_RISCV64 gate
-     * here to avoid complaints about masking bits 0-53
-     * of a potential 32 bit target_ulong '*var'.
      */
-#ifdef TARGET_RISCV64
     if (env->misa_mxl == MXL_RV64
         && csrno >= CSR_PMPADDR0 && csrno <= CSR_PMPADDR63) {
-        target_ulong read_mask = MAKE_64BIT_MASK(0, 54);
+        uint64_t read_mask = MAKE_64BIT_MASK(0, 54);
         *val &= read_mask;
     }
-#endif
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_pmpaddr(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     pmpaddr_csr_write(env, csrno - CSR_PMPADDR0, val);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_tselect(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = tselect_csr_read(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_tselect(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     tselect_csr_write(env, val);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_tdata(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     /* return 0 in tdata1 to end the trigger enumeration */
     if (env->trigger_cur >= env->num_triggers && csrno == CSR_TDATA1) {
@@ -5476,7 +5469,7 @@ static RISCVException read_tdata(CPURISCVState *env, int csrno,
 }
 
 static RISCVException write_tdata(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     if (!tdata_available(env, csrno - CSR_TDATA1)) {
         return RISCV_EXCP_ILLEGAL_INST;
@@ -5487,21 +5480,21 @@ static RISCVException write_tdata(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_tinfo(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = tinfo_csr_read(env);
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mcontext(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->mcontext;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mcontext(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     bool rv32 = riscv_cpu_mxl(env) == MXL_RV32 ? true : false;
     int32_t mask;
@@ -5519,58 +5512,58 @@ static RISCVException write_mcontext(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_mnscratch(CPURISCVState *env, int csrno,
-                                     target_ulong *val)
+                                     uint64_t *val)
 {
     *val = env->mnscratch;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mnscratch(CPURISCVState *env, int csrno,
-                                      target_ulong val, uintptr_t ra)
+                                      uint64_t val, uintptr_t ra)
 {
     env->mnscratch = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mnepc(CPURISCVState *env, int csrno,
-                                 target_ulong *val)
+                                 uint64_t *val)
 {
     *val = env->mnepc;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mnepc(CPURISCVState *env, int csrno,
-                                  target_ulong val, uintptr_t ra)
+                                  uint64_t val, uintptr_t ra)
 {
     env->mnepc = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mncause(CPURISCVState *env, int csrno,
-                                   target_ulong *val)
+                                   uint64_t *val)
 {
     *val = env->mncause;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mncause(CPURISCVState *env, int csrno,
-                                    target_ulong val, uintptr_t ra)
+                                    uint64_t val, uintptr_t ra)
 {
     env->mncause = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mnstatus(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = env->mnstatus;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
-    target_ulong mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
+    uint64_t mask = (MNSTATUS_NMIE | MNSTATUS_MNPP);
 
     if (riscv_has_ext(env, RVH)) {
         /* Flush tlb on mnstatus fields that affect VM. */
@@ -5590,11 +5583,11 @@ static RISCVException write_mnstatus(CPURISCVState *env, int csrno,
 
 /* Crypto Extension */
 static RISCVException rmw_seed(CPURISCVState *env, int csrno,
-                               target_ulong *ret_value,
-                               target_ulong new_value,
-                               target_ulong write_mask)
+                               uint64_t *ret_value,
+                               uint64_t new_value,
+                               uint64_t write_mask)
 {
-    target_ulong rval;
+    uint64_t rval;
 
     rval = riscv_new_csr_seed(new_value, write_mask);
 
@@ -5678,13 +5671,13 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
 }
 
 static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
-                                       target_ulong *ret_value,
-                                       target_ulong new_value,
-                                       target_ulong write_mask,
+                                       uint64_t *ret_value,
+                                       uint64_t new_value,
+                                       uint64_t write_mask,
                                        uintptr_t ra)
 {
     RISCVException ret;
-    target_ulong old_value = 0;
+    uint64_t old_value = 0;
 
     /* execute combined read/write operation if it exists */
     if (csr_ops[csrno].op) {
@@ -5727,7 +5720,7 @@ static RISCVException riscv_csrrw_do64(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_csrr(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value)
+                           uint64_t *ret_value)
 {
     RISCVException ret = riscv_csrrw_check(env, csrno, false);
     if (ret != RISCV_EXCP_NONE) {
@@ -5738,8 +5731,8 @@ RISCVException riscv_csrr(CPURISCVState *env, int csrno,
 }
 
 RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
-                           target_ulong *ret_value, target_ulong new_value,
-                           target_ulong write_mask, uintptr_t ra)
+                           uint64_t *ret_value, uint64_t new_value,
+                           uint64_t write_mask, uintptr_t ra)
 {
     RISCVException ret = riscv_csrrw_check(env, csrno, true);
     if (ret != RISCV_EXCP_NONE) {
@@ -5751,14 +5744,13 @@ RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
 
 RISCVException riscv_csr_write_i64(CPURISCVState *env, int csrno, uint64_t val)
 {
-    return riscv_csrrw(env, csrno, NULL, val,
-                       MAKE_64BIT_MASK(0, TARGET_LONG_BITS), 0);
+    return riscv_csrrw(env, csrno, NULL, val, ~0ULL, 0);
 }
 
 RISCVException riscv_csr_read_i64(CPURISCVState *env, int csrno, uint64_t *res)
 {
     RISCVException ret;
-    target_ulong val = 0;
+    uint64_t val = 0;
     ret = riscv_csrr(env, csrno, &val);
     *res = val;
     return ret;
@@ -5826,7 +5818,7 @@ RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
      * significant), for those, this fallback is correctly handling the
      * accesses
      */
-    target_ulong old_value;
+    uint64_t old_value;
     ret = riscv_csrrw_do64(env, csrno, &old_value, 0, 0, 0);
     if (ret == RISCV_EXCP_NONE && ret_value) {
         *ret_value = int128_make64(old_value);
@@ -5857,7 +5849,7 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
      * significant), for those, this fallback is correctly handling the
      * accesses
      */
-    target_ulong old_value;
+    uint64_t old_value;
     ret = riscv_csrrw_do64(env, csrno, &old_value,
                            int128_getlo(new_value),
                            int128_getlo(write_mask), ra);
@@ -5872,9 +5864,9 @@ RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
  * riscv_csrrw call and clear it after the call.
  */
 RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
-                                 target_ulong *ret_value,
-                                 target_ulong new_value,
-                                 target_ulong write_mask)
+                                 uint64_t *ret_value,
+                                 uint64_t new_value,
+                                 uint64_t write_mask)
 {
     RISCVException ret;
 #if !defined(CONFIG_USER_ONLY)
@@ -5892,14 +5884,14 @@ RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_jvt(CPURISCVState *env, int csrno,
-                               target_ulong *val)
+                               uint64_t *val)
 {
     *val = env->jvt;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_jvt(CPURISCVState *env, int csrno,
-                                target_ulong val, uintptr_t ra)
+                                uint64_t val, uintptr_t ra)
 {
     env->jvt = val;
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 90172298ce..142d912b5e 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -171,12 +171,12 @@ bool tdata_available(CPURISCVState *env, int tdata_index)
     return tdata_mapping[trigger_type][tdata_index];
 }
 
-target_ulong tselect_csr_read(CPURISCVState *env)
+uint64_t tselect_csr_read(CPURISCVState *env)
 {
     return env->trigger_cur;
 }
 
-void tselect_csr_write(CPURISCVState *env, target_ulong val)
+void tselect_csr_write(CPURISCVState *env, uint64_t val)
 {
     if (val < env->num_triggers) {
         env->trigger_cur = val;
@@ -898,7 +898,7 @@ static int itrigger_get_adjust_count(CPURISCVState *env)
     return count;
 }
 
-target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
+uint64_t tdata_csr_read(CPURISCVState *env, int tdata_index)
 {
     int trigger_type;
     switch (tdata_index) {
@@ -919,7 +919,7 @@ target_ulong tdata_csr_read(CPURISCVState *env, int tdata_index)
     }
 }
 
-void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
+void tdata_csr_write(CPURISCVState *env, int tdata_index, uint64_t val)
 {
     int trigger_type;
 
@@ -956,7 +956,7 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
     }
 }
 
-target_ulong tinfo_csr_read(CPURISCVState *env)
+uint64_t tinfo_csr_read(CPURISCVState *env)
 {
     target_ulong val = BIT(TRIGGER_TYPE_AD_MATCH) |
                        BIT(TRIGGER_TYPE_AD_MATCH6);
diff --git a/target/riscv/tcg/mips_csr.c b/target/riscv/tcg/mips_csr.c
index 884030e91d..c239eceddc 100644
--- a/target/riscv/tcg/mips_csr.c
+++ b/target/riscv/tcg/mips_csr.c
@@ -56,42 +56,42 @@ static RISCVException any(CPURISCVState *env, int csrno)
 }
 
 static RISCVException read_mipstvec(CPURISCVState *env, int csrno,
-                                    target_ulong *val)
+                                    uint64_t *val)
 {
     *val = mips_csr_state.tvec;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mipstvec(CPURISCVState *env, int csrno,
-                                     target_ulong val, uintptr_t ra)
+                                     uint64_t val, uintptr_t ra)
 {
     mips_csr_state.tvec = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mipsconfig(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = mips_csr_state.config[csrno - CSR_MIPSCONFIG0];
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mipsconfig(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     mips_csr_state.config[csrno - CSR_MIPSCONFIG0] = val;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_mipspmacfg(CPURISCVState *env, int csrno,
-                                      target_ulong *val)
+                                      uint64_t *val)
 {
     *val = mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0];
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException write_mipspmacfg(CPURISCVState *env, int csrno,
-                                       target_ulong val, uintptr_t ra)
+                                       uint64_t val, uintptr_t ra)
 {
     mips_csr_state.pmacfg[csrno - CSR_MIPSPMACFG0] = val;
     return RISCV_EXCP_NONE;
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index 3e94005d2b..3f6731202a 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -67,7 +67,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
     }
 
-    target_ulong val = 0;
+    uint64_t val = 0;
     RISCVException ret = riscv_csrr(env, csr, &val);
 
     if (ret != RISCV_EXCP_NONE) {
@@ -78,7 +78,7 @@ target_ulong helper_csrr(CPURISCVState *env, int csr)
 
 void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
 {
-    target_ulong mask = env->xl == MXL_RV32 ? UINT32_MAX : (target_ulong)-1;
+    uint64_t mask = env->xl == MXL_RV32 ? UINT32_MAX : (target_ulong)-1;
     RISCVException ret = riscv_csrrw(env, csr, NULL, src, mask, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
@@ -89,7 +89,7 @@ void helper_csrw(CPURISCVState *env, int csr, target_ulong src)
 target_ulong helper_csrrw(CPURISCVState *env, int csr,
                           target_ulong src, target_ulong write_mask)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     RISCVException ret = riscv_csrrw(env, csr, &val, src, write_mask, GETPC());
 
     if (ret != RISCV_EXCP_NONE) {
diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 41b55519a8..99345d63dc 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -535,7 +535,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
  * Handle a write to a pmpcfg CSR
  */
 void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
-                      target_ulong val)
+                      uint64_t val)
 {
     int i;
     uint8_t cfg_val;
@@ -560,11 +560,11 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
 /*
  * Handle a read from a pmpcfg CSR
  */
-target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
+uint64_t pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
 {
     int i;
-    target_ulong cfg_val = 0;
-    target_ulong val = 0;
+    uint64_t cfg_val = 0;
+    uint64_t val = 0;
     int pmpcfg_nums = 2 << riscv_cpu_mxl(env);
 
     for (i = 0; i < pmpcfg_nums; i++) {
@@ -581,7 +581,7 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
  * Handle a write to a pmpaddr CSR
  */
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
-                       target_ulong val)
+                       uint64_t val)
 {
     trace_pmpaddr_csr_write(env->mhartid, addr_index, val);
     bool is_next_cfg_tor = false;
@@ -630,9 +630,9 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
  * Handle a read from a pmpaddr CSR
  * Change A field of pmpcfg affects the read value of pmpaddr
  */
-target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
+uint64_t pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
 {
-    target_ulong val = 0;
+    uint64_t val = 0;
     uint8_t pmp_regions = riscv_cpu_cfg(env)->pmp_regions;
 
     if (addr_index < pmp_regions) {
diff --git a/target/riscv/tcg/pmu.c b/target/riscv/tcg/pmu.c
index c8acb85df4..48beb569b2 100644
--- a/target/riscv/tcg/pmu.c
+++ b/target/riscv/tcg/pmu.c
@@ -384,10 +384,10 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
         return;
     }
 
-    riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctr_val, false, ctr_idx);
+    riscv_pmu_read_ctr(env, &curr_ctr_val, false, ctr_idx);
     ctr_val = counter->mhpmcounter_val;
     if (riscv_cpu_mxl(env) == MXL_RV32) {
-        riscv_pmu_read_ctr(env, (target_ulong *)&curr_ctrh_val, true, ctr_idx);
+        riscv_pmu_read_ctr(env, &curr_ctrh_val, true, ctr_idx);
         curr_ctr_val = curr_ctr_val | (curr_ctrh_val << 32);
     }
 
diff --git a/target/riscv/tcg/th_csr.c b/target/riscv/tcg/th_csr.c
index e6f642991c..e7cd24ac6d 100644
--- a/target/riscv/tcg/th_csr.c
+++ b/target/riscv/tcg/th_csr.c
@@ -122,7 +122,7 @@ static bool test_thead_mvendorid(RISCVCPU *cpu)
 }
 
 static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
-                                       target_ulong *val)
+                                       uint64_t *val)
 {
     /* We don't set MAEE here, because QEMU does not implement MAEE. */
     *val = TH_MXSTATUS_UCME | TH_MXSTATUS_THEADISAEE;
@@ -130,14 +130,14 @@ static RISCVException read_th_mxstatus(CPURISCVState *env, int csrno,
 }
 
 static RISCVException read_unimp_th_csr(CPURISCVState *env, int csrno,
-                                        target_ulong *val)
+                                        uint64_t *val)
 {
     *val = 0;
     return RISCV_EXCP_NONE;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
-                                       target_ulong *val)
+                                       uint64_t *val)
 {
     /* We don't set MAEE here, because QEMU does not implement MAEE. */
     *val = TH_SXSTATUS_UCME | TH_SXSTATUS_THEADISAEE;
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 954dfc10e0..8f95c8f400 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -5,7 +5,6 @@ endif
 riscv_ss.add(files(
   'bitmanip_helper.c',
  'cpu_helper.c',
-  'csr.c',
   'crypto_helper.c',
   'fpu_helper.c',
   'm128_helper.c',
@@ -20,8 +19,18 @@ riscv_ss.add(files(
 
 riscv_system_ss.add(files(
   'debug.c',
-  'mips_csr.c',
   'pmp.c',
+))
+
+
+riscv_user_ss.add(files(
+  'csr.c',
+))
+
+
+riscv_common_system_ss.add(files(
+  'csr.c',
+  'mips_csr.c',
   'pmu.c',
   'th_csr.c',
 ))

-- 
2.52.0


