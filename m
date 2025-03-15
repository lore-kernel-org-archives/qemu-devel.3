Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E228FC28B28
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Mar 2025 06:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttKrJ-0003Bs-T9; Sat, 15 Mar 2025 02:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKr9-000340-Kd; Sat, 15 Mar 2025 02:18:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttKr3-0003Di-Se; Sat, 15 Mar 2025 02:18:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 78CC7FF9D1;
 Sat, 15 Mar 2025 09:17:07 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 502FA1CAC3A;
 Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 36E91558B9; Sat, 15 Mar 2025 09:18:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 05/51] target/arm: Make CP_ACCESS_TRAPs to AArch32 EL3
 be Monitor traps
Date: Sat, 15 Mar 2025 09:17:11 +0300
Message-Id: <20250315061801.622606-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250315091645@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

In system register access pseudocode the common pattern for
AArch32 registers with access traps to EL3 is:

at EL1 and EL2:
  if HaveEL(EL3) && !ELUsingAArch32(EL3) && (SCR_EL3.TERR == 1) then
     AArch64.AArch32SystemAccessTrap(EL3, 0x03);
  elsif HaveEL(EL3) && ELUsingAArch32(EL3) && (SCR.TERR == 1) then
     AArch32.TakeMonitorTrapException();
at EL3:
  if (PSTATE.M != M32_Monitor) && (SCR.TERR == 1) then
     AArch32.TakeMonitorTrapException();

(taking as an example the ERRIDR access pseudocode).

This implements the behaviour of (in this case) SCR.TERR that
"Accesses to the specified registers from modes other than Monitor
mode generate a Monitor Trap exception" and of SCR_EL3.TERR that
"Accesses of the specified Error Record registers at EL2 and EL1
are trapped to EL3, unless the instruction generates a higher
priority exception".

In QEMU we don't implement this pattern correctly in two ways:
 * in access_check_cp_reg() we turn the CP_ACCESS_TRAP_EL3 into
   an UNDEF, not a trap to Monitor mode
 * in the access functions, we check trap bits like SCR.TERR
   only when arm_current_el(env) < 3 -- this is correct for
   AArch64 EL3, but misses the "trap non-Monitor-mode execution
   at EL3 into Monitor mode" case for AArch32 EL3

In this commit we fix the first of these two issues, by
making access_check_cp_reg() handle CP_ACCESS_TRAP_EL3
as a Monitor trap. This is a kind of exception that we haven't
yet implemented(!), so we need a new EXCP_MON_TRAP for it.

This diverges from the pseudocode approach, where every access check
function explicitly checks for "if EL3 is AArch32" and takes a
monitor trap; if we wanted to be closer to the pseudocode we could
add a new CP_ACCESS_TRAP_MONITOR and make all the accessfns use it
when appropriate.  But because there are no non-standard cases in the
pseudocode (i.e.  where either it raises a Monitor trap that doesn't
correspond to an AArch64 SystemAccessTrap or where it raises a
SystemAccessTrap that doesn't correspond to a Monitor trap), handling
this all in one place seems less likely to result in future bugs
where we forgot again about this special case when writing an
accessor.

(The cc of stable here is because "hw/intc/arm_gicv3_cpuif: Don't
downgrade monitor traps for AArch32 EL3" which is also cc:stable
will implicitly use the new EXCP_MON_TRAP code path.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250130182309.717346-6-peter.maydell@linaro.org
(cherry picked from commit 4cf4948651615181c5bc3d0e4a9f5c46be576bb2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d86e641280..e3416cd435 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -62,6 +62,7 @@
 #define EXCP_NMI            26
 #define EXCP_VINMI          27
 #define EXCP_VFNMI          28
+#define EXCP_MON_TRAP       29   /* AArch32 trap to Monitor mode */
 /* NB: add new EXCP_ defines to the array in arm_log_exception() too */
 
 #define ARMV7M_EXCP_RESET   1
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0e386c9ae5..fe255ccb43 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10858,6 +10858,7 @@ void arm_log_exception(CPUState *cs)
             [EXCP_NMI] = "NMI",
             [EXCP_VINMI] = "Virtual IRQ NMI",
             [EXCP_VFNMI] = "Virtual FIQ NMI",
+            [EXCP_MON_TRAP] = "Monitor Trap",
         };
 
         if (idx >= 0 && idx < ARRAY_SIZE(excnames)) {
@@ -11424,6 +11425,16 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
         mask = CPSR_A | CPSR_I | CPSR_F;
         offset = 0;
         break;
+    case EXCP_MON_TRAP:
+        new_mode = ARM_CPU_MODE_MON;
+        addr = 0x04;
+        mask = CPSR_A | CPSR_I | CPSR_F;
+        if (env->thumb) {
+            offset = 2;
+        } else {
+            offset = 4;
+        }
+        break;
     default:
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
         return; /* Never happens.  Keep compiler happy.  */
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 1ecb465988..7cde2337ac 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -758,6 +758,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     const ARMCPRegInfo *ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     CPAccessResult res = CP_ACCESS_OK;
     int target_el;
+    uint32_t excp;
 
     assert(ri != NULL);
 
@@ -842,8 +843,18 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
     }
 
  fail:
+    excp = EXCP_UDEF;
     switch (res & ~CP_ACCESS_EL_MASK) {
     case CP_ACCESS_TRAP:
+        /*
+         * If EL3 is AArch32 then there's no syndrome register; the cases
+         * where we would raise a SystemAccessTrap to AArch64 EL3 all become
+         * raising a Monitor trap exception. (Because there's no visible
+         * syndrome it doesn't matter what we pass to raise_exception().)
+         */
+        if ((res & CP_ACCESS_EL_MASK) == 3 && !arm_el_is_aa64(env, 3)) {
+            excp = EXCP_MON_TRAP;
+        }
         break;
     case CP_ACCESS_TRAP_UNCATEGORIZED:
         /* Only CP_ACCESS_TRAP traps are direct to a specified EL */
@@ -879,7 +890,7 @@ const void *HELPER(access_check_cp_reg)(CPUARMState *env, uint32_t key,
         g_assert_not_reached();
     }
 
-    raise_exception(env, EXCP_UDEF, syndrome, target_el);
+    raise_exception(env, excp, syndrome, target_el);
 }
 
 const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)
-- 
2.39.5


