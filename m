Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCE3CF9C71
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 10:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2Od-0002JU-F8; Tue, 24 Sep 2024 06:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OX-0002B3-6M
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1st2OV-00030l-6A
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 06:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727172222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FY88gXh1RbFEf9cGcY0sUMTUfer2XlsP0k1Kqrf1CHw=;
 b=ad3pMRo0p2NLuQJ4iTjqqFKiWIsNjGKAbTPjUw0UcLq3PBsIegilvW8X8Uv5ORFSe601xq
 VB1P00ANGG+iqzVyJkD4JhBp6lLzV5QfdDfn+qXiuh8QM2TyopMv5WYpSa3hRSTaOz20Dl
 aKiJ1t2nGWigFEU+KpRLxPszFamlENM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-bhCWzbWwOW2-zszgPaphCQ-1; Tue,
 24 Sep 2024 06:03:41 -0400
X-MC-Unique: bhCWzbWwOW2-zszgPaphCQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CE4818FFACD; Tue, 24 Sep 2024 10:03:40 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.16.106])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 353D21956048; Tue, 24 Sep 2024 10:03:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 2/6] reset: Use ResetType for qemu_devices_reset() and
 MachineClass::reset()
Date: Tue, 24 Sep 2024 12:03:25 +0200
Message-ID: <20240924100329.248738-3-david@redhat.com>
In-Reply-To: <20240924100329.248738-1-david@redhat.com>
References: <20240924100329.248738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Currently, both qemu_devices_reset() and MachineClass::reset() use
ShutdownCause for the reason of the reset. However, the Resettable
interface uses ResetState, so ShutdownCause needs to be translated to
ResetType somewhere. Translating it qemu_devices_reset() makes adding
new reset types harder, as they cannot always be matched to a single
ShutdownCause here, and devices may need to check the ResetType to
determine what to reset and if to reset at all.

This patch moves this translation up in the call stack to
qemu_system_reset() and updates all MachineClass children to use the
ResetType instead.

Message-ID: <20240904103722.946194-2-jmarcin@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/arm/aspeed.c            |  4 ++--
 hw/arm/mps2-tz.c           |  4 ++--
 hw/core/reset.c            |  5 +----
 hw/hppa/machine.c          |  4 ++--
 hw/i386/microvm.c          |  4 ++--
 hw/i386/pc.c               |  6 +++---
 hw/ppc/pegasos2.c          |  4 ++--
 hw/ppc/pnv.c               |  4 ++--
 hw/ppc/spapr.c             |  6 +++---
 hw/s390x/s390-virtio-ccw.c |  4 ++--
 include/hw/boards.h        |  3 ++-
 include/sysemu/reset.h     |  5 +++--
 system/runstate.c          | 13 +++++++++++--
 13 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3d13b16768..cf0c6c580b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1529,12 +1529,12 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-static void fby35_reset(MachineState *state, ShutdownCause reason)
+static void fby35_reset(MachineState *state, ResetType type)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(state);
     AspeedGPIOState *gpio = &bmc->soc->gpio;
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 
     /* Board ID: 7 (Class-1, 4 slots) */
     object_property_set_bool(OBJECT(gpio), "gpioV4", true, &error_fatal);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index aec57c0d68..8edf57a66d 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1254,7 +1254,7 @@ static void mps2_set_remap(Object *obj, const char *value, Error **errp)
     }
 }
 
-static void mps2_machine_reset(MachineState *machine, ShutdownCause reason)
+static void mps2_machine_reset(MachineState *machine, ResetType type)
 {
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
 
@@ -1264,7 +1264,7 @@ static void mps2_machine_reset(MachineState *machine, ShutdownCause reason)
      * reset see the correct mapping.
      */
     remap_memory(mms, mms->remap);
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 }
 
 static void mps2tz_class_init(ObjectClass *oc, void *data)
diff --git a/hw/core/reset.c b/hw/core/reset.c
index 58dfc8db3d..14a2639fbf 100644
--- a/hw/core/reset.c
+++ b/hw/core/reset.c
@@ -170,11 +170,8 @@ void qemu_unregister_resettable(Object *obj)
     resettable_container_remove(get_root_reset_container(), obj);
 }
 
-void qemu_devices_reset(ShutdownCause reason)
+void qemu_devices_reset(ResetType type)
 {
-    ResetType type = (reason == SHUTDOWN_CAUSE_SNAPSHOT_LOAD) ?
-        RESET_TYPE_SNAPSHOT_LOAD : RESET_TYPE_COLD;
-
     /* Reset the simulation */
     resettable_reset(OBJECT(get_root_reset_container()), type);
 }
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5d0a8739de..8259fe2e38 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -642,12 +642,12 @@ static void machine_HP_C3700_init(MachineState *machine)
     machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
-static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
+static void hppa_machine_reset(MachineState *ms, ResetType type)
 {
     unsigned int smp_cpus = ms->smp.cpus;
     int i;
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 
     /* Start all CPUs at the firmware entry point.
      *  Monarch CPU will initialize firmware, secondary CPUs
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 40edcee7af..8ae4dff7f2 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -462,7 +462,7 @@ static void microvm_machine_state_init(MachineState *machine)
     microvm_devices_init(mms);
 }
 
-static void microvm_machine_reset(MachineState *machine, ShutdownCause reason)
+static void microvm_machine_reset(MachineState *machine, ResetType type)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     CPUState *cs;
@@ -475,7 +475,7 @@ static void microvm_machine_reset(MachineState *machine, ShutdownCause reason)
         mms->kernel_cmdline_fixed = true;
     }
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 
     CPU_FOREACH(cs) {
         cpu = X86_CPU(cs);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8d84c22458..79a626a3eb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1712,12 +1712,12 @@ static void pc_machine_initfn(Object *obj)
     qemu_add_machine_init_done_notifier(&pcms->machine_done);
 }
 
-static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
+static void pc_machine_reset(MachineState *machine, ResetType type)
 {
     CPUState *cs;
     X86CPU *cpu;
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 
     /* Reset APIC after devices have been reset to cancel
      * any changes that qemu_devices_reset() might have done.
@@ -1732,7 +1732,7 @@ static void pc_machine_reset(MachineState *machine, ShutdownCause reason)
 static void pc_machine_wakeup(MachineState *machine)
 {
     cpu_synchronize_all_states();
-    pc_machine_reset(machine, SHUTDOWN_CAUSE_NONE);
+    pc_machine_reset(machine, RESET_TYPE_COLD);
     cpu_synchronize_all_post_reset();
 }
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 9b0a6b70ab..8ff4a00c34 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -291,14 +291,14 @@ static void pegasos2_superio_write(uint8_t addr, uint8_t val)
     cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
 }
 
-static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
+static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
     void *fdt;
     uint64_t d[2];
     int sz;
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
     if (!pm->vof) {
         return; /* Firmware should set up machine so nothing to do */
     }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3526852685..988fd55d88 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -709,13 +709,13 @@ static void pnv_powerdown_notify(Notifier *n, void *opaque)
     }
 }
 
-static void pnv_reset(MachineState *machine, ShutdownCause reason)
+static void pnv_reset(MachineState *machine, ResetType type)
 {
     PnvMachineState *pnv = PNV_MACHINE(machine);
     IPMIBmc *bmc;
     void *fdt;
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 
     /*
      * The machine should provide by default an internal BMC simulator.
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 8aa3ce7449..2c10a70a48 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1725,7 +1725,7 @@ void spapr_check_mmu_mode(bool guest_radix)
     }
 }
 
-static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
+static void spapr_machine_reset(MachineState *machine, ResetType type)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(machine);
     PowerPCCPU *first_ppc_cpu;
@@ -1733,7 +1733,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
     void *fdt;
     int rc;
 
-    if (reason != SHUTDOWN_CAUSE_SNAPSHOT_LOAD) {
+    if (type != RESET_TYPE_SNAPSHOT_LOAD) {
         /*
          * Record-replay snapshot load must not consume random, this was
          * already replayed from initial machine reset.
@@ -1762,7 +1762,7 @@ static void spapr_machine_reset(MachineState *machine, ShutdownCause reason)
         spapr_setup_hpt(spapr);
     }
 
-    qemu_devices_reset(reason);
+    qemu_devices_reset(type);
 
     spapr_ovec_cleanup(spapr->ov5_cas);
     spapr->ov5_cas = spapr_ovec_new();
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 18240a0fd8..5aa8d207a3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -440,7 +440,7 @@ static void s390_pv_prepare_reset(S390CcwMachineState *ms)
     s390_pv_prep_reset();
 }
 
-static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
+static void s390_machine_reset(MachineState *machine, ResetType type)
 {
     S390CcwMachineState *ms = S390_CCW_MACHINE(machine);
     enum s390_reset reset_type;
@@ -472,7 +472,7 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
          * Device reset includes CPU clear resets so this has to be
          * done AFTER the unprotect call above.
          */
-        qemu_devices_reset(reason);
+        qemu_devices_reset(type);
         s390_crypto_reset();
 
         /* configure and start the ipl CPU only */
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ff25c53671..5966069baa 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -10,6 +10,7 @@
 #include "qemu/module.h"
 #include "qom/object.h"
 #include "hw/core/cpu.h"
+#include "hw/resettable.h"
 
 #define TYPE_MACHINE_SUFFIX "-machine"
 
@@ -257,7 +258,7 @@ struct MachineClass {
     const char *deprecation_reason;
 
     void (*init)(MachineState *state);
-    void (*reset)(MachineState *state, ShutdownCause reason);
+    void (*reset)(MachineState *state, ResetType type);
     void (*wakeup)(MachineState *state);
     int (*kvm_type)(MachineState *machine, const char *arg);
     int (*hvf_get_physical_address_range)(MachineState *machine);
diff --git a/include/sysemu/reset.h b/include/sysemu/reset.h
index ae436044a9..0e297c0e02 100644
--- a/include/sysemu/reset.h
+++ b/include/sysemu/reset.h
@@ -27,6 +27,7 @@
 #ifndef QEMU_SYSEMU_RESET_H
 #define QEMU_SYSEMU_RESET_H
 
+#include "hw/resettable.h"
 #include "qapi/qapi-events-run-state.h"
 
 typedef void QEMUResetHandler(void *opaque);
@@ -110,7 +111,7 @@ void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
 
 /**
  * qemu_devices_reset: Perform a complete system reset
- * @reason: reason for the reset
+ * @reason: type of the reset
  *
  * This function performs the low-level work needed to do a complete reset
  * of the system (calling all the callbacks registered with
@@ -121,6 +122,6 @@ void qemu_unregister_reset(QEMUResetHandler *func, void *opaque);
  * If you want to trigger a system reset from, for instance, a device
  * model, don't use this function. Use qemu_system_reset_request().
  */
-void qemu_devices_reset(ShutdownCause reason);
+void qemu_devices_reset(ResetType type);
 
 #endif
diff --git a/system/runstate.c b/system/runstate.c
index a0e2a5fd22..c2c9afa905 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -32,6 +32,7 @@
 #include "exec/cpu-common.h"
 #include "gdbstub/syscalls.h"
 #include "hw/boards.h"
+#include "hw/resettable.h"
 #include "migration/misc.h"
 #include "migration/postcopy-ram.h"
 #include "monitor/monitor.h"
@@ -507,15 +508,23 @@ static int qemu_debug_requested(void)
 void qemu_system_reset(ShutdownCause reason)
 {
     MachineClass *mc;
+    ResetType type;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
 
     cpu_synchronize_all_states();
 
+    switch (reason) {
+    case SHUTDOWN_CAUSE_SNAPSHOT_LOAD:
+        type = RESET_TYPE_SNAPSHOT_LOAD;
+        break;
+    default:
+        type = RESET_TYPE_COLD;
+    }
     if (mc && mc->reset) {
-        mc->reset(current_machine, reason);
+        mc->reset(current_machine, type);
     } else {
-        qemu_devices_reset(reason);
+        qemu_devices_reset(type);
     }
     switch (reason) {
     case SHUTDOWN_CAUSE_NONE:
-- 
2.46.1


