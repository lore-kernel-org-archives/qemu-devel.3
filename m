Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BC1C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgVZQ-0005BP-78; Sun, 05 Jul 2026 18:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgVZN-00053M-Gj; Sun, 05 Jul 2026 18:44:13 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1wgVZL-00029X-5W; Sun, 05 Jul 2026 18:44:13 -0400
Received: from smtp02.univ-lille.fr (smtp02.univ-lille.fr [194.254.129.96])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4gtjGJ2c3szBsVY;
 Mon,  6 Jul 2026 00:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1783291448;
 bh=YMmoU0jvgKSG+M2L3MmCP5eAIwuoW7CiBLxgNApfjXo=;
 h=From:To:Cc:Subject:Date:From;
 b=qgoTzMiycLdNT3P2Od9rhdT0UhJHNE2NvcPgh+FsY1pj3f3WBBESuJA6Vf3WkUv2V
 YmKKOVP8eOt3qTjJ7QQmWh7HVKJy+/KmpQr++bzhkkoUinh56gQv5TnyqmTA16WFPT
 +PkP5gY7vv9t3FUbXbC+x2urMKaDq24rPvLraLqWwGSk/nqPyw/5gZrGEFWHGWcJhU
 NbzuCI9wgsi4U7SQxBybKnjWwzzLX0P8yPG0Iwl/lKl49hZ/p8WFFcIPArYCBbbMlu
 b1tAttDGAoiATO5tXani2qRxnEzGo2CT/SoH3izcSHAgaWpb3EHwxiMNWWcq0pRf3I
 IqhRRqSNi4W3Q==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp02.univ-lille.fr (Postfix) with ESMTPSA id 4gtjGJ1T2hz6sT6;
 Mon,  6 Jul 2026 00:44:08 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Subject: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when attached
Date: Mon,  6 Jul 2026 00:44:07 +0200
Message-ID: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

While working on Raspberry Pi Pico/RP2040 support, I noticed that Pico SDK
programs deliberately execute BKPT from _exit(). On real hardware this is
useful when a debug probe is attached: returning from main() stops the
debugger at the program exit point.

Under QEMU this currently does not behave like the debug-probe case. For
M-profile guests, the BKPT instruction is routed through the architectural
guest debug exception path. Without halting debug, that path should remain a
guest-visible DebugMonitor exception when DebugMonitor is enabled, or escalate
towards HardFault otherwise. This patch deliberately leaves that no-debugger
architectural path unchanged.

The problem addressed here is the case where GDB is connected to QEMU's
gdbstub. In that situation, firmware that uses BKPT as a debugger stop point
should stop in the attached debugger. Instead, the M-profile guest currently
continues down the guest exception path and may end in HardFault/lockup rather
than reporting a clean trap to GDB.

This is not specific to the RP2040 machine model. It is a generic
Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger stop point
should be reported to the attached debugger, while keeping the guest
architectural exception path when no debugger is attached.

Expose a small gdbstub helper to test whether a CPU is visible to an attached
debugger. When an M-profile BKPT instruction is executed with such a debugger
attached, leave the translated block with EXCP_DEBUG so the existing gdbstub
stop path reports a trap to GDB.

Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 gdbstub/gdbstub.c      | 13 ++++++++++++-
 include/exec/gdbstub.h |  6 ++++++
 target/arm/tcg/debug.c |  9 +++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index c3c944e965..9f259fc005 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState *cpu)
     return gdb_get_process(gdb_get_cpu_pid(cpu));
 }
 
+bool gdb_cpu_is_attached(CPUState *cpu)
+{
+    GDBProcess *process;
+
+    if (!gdbserver_state.init || !cpu) {
+        return false;
+    }
+
+    process = gdb_get_cpu_process(cpu);
+    return process && process->attached;
+}
+
 static CPUState *find_cpu(uint32_t thread_id)
 {
     CPUState *cpu;
@@ -2520,4 +2532,3 @@ void gdb_create_default_process(GDBState *s)
     process->attached = false;
     process->target_xml = NULL;
 }
-
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 75eb4d9c36..6e5f75a1f3 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -59,6 +59,12 @@ void gdb_unregister_coprocessor_all(CPUState *cpu);
  */
 bool gdbserver_start(const char *port_or_device, Error **errp);
 
+/**
+ * gdb_cpu_is_attached() - return whether @cpu is visible to an attached GDB
+ * @cpu: The CPU to test.
+ */
+bool gdb_cpu_is_attached(CPUState *cpu);
+
 /**
  * gdb_feature_builder_init() - Initialize GDBFeatureBuilder.
  * @builder: The builder to be initialized.
diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index 07a52643e7..2c60f1c49f 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -12,7 +12,9 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "cpregs.h"
+#include "accel/tcg/cpu-loop.h"
 #include "exec/watchpoint.h"
+#include "exec/gdbstub.h"
 #include "system/tcg.h"
 
 /* Return the Exception Level targeted by debug exceptions. */
@@ -513,6 +515,7 @@ void arm_debug_excp_handler(CPUState *cs)
  */
 void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
 {
+    CPUState *cs = env_cpu(env);
     int debug_el = arm_debug_target_el(env);
     int cur_el = arm_current_el(env);
 
@@ -535,6 +538,12 @@ void HELPER(exception_bkpt_insn)(CPUARMState *env, uint32_t syndrome)
     if (debug_el < cur_el) {
         debug_el = cur_el;
     }
+
+    if (arm_feature(env, ARM_FEATURE_M) && gdb_cpu_is_attached(cs)) {
+        cs->exception_index = EXCP_DEBUG;
+        cpu_loop_exit(cs);
+    }
+
     raise_exception(env, EXCP_BKPT, syndrome, debug_el);
 }
 
-- 
2.55.0


