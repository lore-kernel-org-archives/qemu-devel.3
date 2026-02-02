Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF454E7FDDA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn143-0003uo-DK; Mon, 02 Feb 2026 16:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn13P-0002HN-FM; Mon, 02 Feb 2026 16:01:51 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn13M-0004VQ-T2; Mon, 02 Feb 2026 16:01:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 494721851AE;
 Mon, 02 Feb 2026 23:57:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0F62435B325;
 Mon, 02 Feb 2026 23:58:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Fabian Vogt <fvogt@suse.de>, Chinmay Rath <rathc@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.4 34/74] target/ppc: Fix env->quiesced migration
Date: Mon,  2 Feb 2026 23:57:45 +0300
Message-ID: <20260202205833.941615-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
References: <qemu-stable-10.1.4-20260202173333@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

The commit referenced (from QEMU 10.0) has changed the way the pseries
machine marks a cpu as quiesced. Previously, the cpu->halted value
from QEMU common cpu code was (incorrectly) used. With the fix, the
env->quiesced variable starts being used, which improves on the
original situation, but also causes a side effect after migration:

The env->quiesced is set at reset and never migrated, which causes the
destination QEMU to stop delivering interrupts and hang the machine.

To fix the issue from this point on, start migrating the env->quiesced
value.

For QEMU versions < 10.0, sending the new element on the stream would
cause migration to be aborted, so add the appropriate compatibility
property to omit the new subsection.

Independently of this patch, all migrations from QEMU versions < 10.0
would result in a hang since the older QEMU never migrates
env->quiesced. This is bad because it leaves machines already running
on the old QEMU without a migration path into newer versions.

As a workaround, use a few heuristics to infer the new value of
env->quiesced based on cpu->halted, LPCR and PSSCR bits that are
usually set/cleared along with quiesced.

Note that this was tested with -cpu power9 and -machine ic-mode=xive
due to another bug affecting migration of XICS guests. Tested both
forward and backward migration and savevm/loadvm from 9.2 and 10.0.

Also tested loadvm of a savevm image that contains a mix of cpus both
halted and not halted.

Reported-by: Fabian Vogt <fvogt@suse.de>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3079
Fixes: fb802acdc8b ("ppc/spapr: Fix RTAS stopped state")
Acked-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20260109123519.28703-2-farosas@suse.de
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
(cherry picked from commit 628bda1ab7596a7cceb1c5356d23a92001c7a8c5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9e63671ece..1700457524 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4779,8 +4779,14 @@ DEFINE_SPAPR_MACHINE_AS_LATEST(10, 1);
  */
 static void spapr_machine_10_0_class_options(MachineClass *mc)
 {
+    static GlobalProperty spapr_compat_10_0[] = {
+        { TYPE_POWERPC_CPU, "rtas-stopped-state", "false" },
+    };
+
     spapr_machine_10_1_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    compat_props_add(mc->compat_props, spapr_compat_10_0,
+                     G_N_ELEMENTS(spapr_compat_10_0));
 }
 
 DEFINE_SPAPR_MACHINE(10, 0);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0e26e4343d..1c4af15cb5 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1470,6 +1470,7 @@ struct ArchCPU {
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+    bool rtas_stopped_state;
 
     /* Those resources are used only during code translation */
     /* opcode handlers */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index a0e77f2673..4380c6eb14 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -55,6 +55,11 @@
 /* #define PPC_DEBUG_SPR */
 /* #define USE_APPLE_GDB */
 
+static const Property powerpc_cpu_properties[] = {
+    DEFINE_PROP_BOOL("rtas-stopped-state", PowerPCCPU,
+                      rtas_stopped_state, true),
+};
+
 static inline void vscr_init(CPUPPCState *env, uint32_t val)
 {
     /* Altivec always uses round-to-nearest */
@@ -7525,6 +7530,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, const void *data)
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
 
+    device_class_set_props(dc, powerpc_cpu_properties);
+
     resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, NULL,
                                        &pcc->parent_phases);
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d72e5ecb94..49cfdc6d67 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -257,6 +257,45 @@ static int cpu_post_load(void *opaque, int version_id)
         ppc_store_sdr1(env, env->spr[SPR_SDR1]);
     }
 
+    if (!cpu->rtas_stopped_state) {
+        /*
+         * The source QEMU doesn't have fb802acdc8 and still uses halt +
+         * PM bits in LPCR to implement RTAS stopped state. The new (this)
+         * QEMU will have put the secondary vcpus in stopped state,
+         * waiting for the start-cpu RTAS call. That call will never come
+         * if the source cpus were already running. Try to infer the cpus
+         * state and set env->quiesced accordingly.
+         *
+         * env->quiesced = true  ==> the cpu is waiting to start
+         * env->quiesced = false ==> the cpu is running (unless halted)
+         */
+
+        /*
+         * Halted _could_ mean quiesced, but it could also be cede,
+         * confer_self, power management, etc.
+         */
+        if (CPU(cpu)->halted) {
+            PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+            /*
+             * Both the PSSCR_EC bit and LPCR PM bits set at cpu reset
+             * and rtas_stop and cleared at rtas_start, it's a good
+             * heuristic.
+             */
+            if ((env->spr[SPR_PSSCR] & PSSCR_EC) &&
+                (env->spr[SPR_LPCR] & pcc->lpcr_pm)) {
+                env->quiesced = true;
+            } else {
+                env->quiesced = false;
+            }
+        } else {
+            /*
+             * Old QEMU sets halted during rtas_stop_self. Not halted,
+             * therefore definitely not quiesced.
+             */
+            env->quiesced = false;
+        }
+    }
+
     post_load_update_msr(env);
 
     if (tcg_enabled()) {
@@ -649,6 +688,28 @@ static const VMStateDescription vmstate_reservation = {
     }
 };
 
+static bool rtas_stopped_needed(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    return cpu->rtas_stopped_state;
+}
+
+static const VMStateDescription vmstate_rtas_stopped = {
+    .name = "cpu/rtas_stopped",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = rtas_stopped_needed,
+    .fields = (const VMStateField[]) {
+        /*
+         * "RTAS stopped" state, independent of halted state. For QEMU
+         * < 10.0, this is taken from cpu->halted at cpu_post_load()
+         */
+        VMSTATE_BOOL(env.quiesced, PowerPCCPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 #ifdef TARGET_PPC64
 static bool bhrb_needed(void *opaque)
 {
@@ -715,6 +776,7 @@ const VMStateDescription vmstate_ppc_cpu = {
         &vmstate_tlbmas,
         &vmstate_compat,
         &vmstate_reservation,
+        &vmstate_rtas_stopped,
         NULL
     }
 };
-- 
2.47.3


