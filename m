Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKKlV-00036E-TQ; Fri, 23 Oct 2026 15:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlP-00033N-3S; Fri, 23 Oct 2026 15:17:15 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlM-00025P-LR; Fri, 23 Oct 2026 15:17:14 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1xKKlF-00000007BFY-2heh; Fri, 23 Oct 2026 21:17:05 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 07/13] runstate: Start/stop interrupt controllers
 before/after ordinary devices
Date: Fri, 23 Oct 2026 21:16:18 +0200
Message-ID: <eeedb2ec3c595fb060884d24733a0a4379322178.1792758436.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792758435.git.maciej.szmigiero@oracle.com>
References: <cover.1792758435.git.maciej.szmigiero@oracle.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The VFIO spec allows VFIO devices to generate interrupts already after
their first state transition at VM start (done at VM_CHANGE_STATE_PRI_HIGH)
until the second (last) state transition at VM stop (done at
VM_CHANGE_STATE_PRI_NORMAL).
In principle, the same may also apply to other/emulated devices.

That means in order to avoid potentially lost interrupts any interrupt
controllers with VM state change handlers need to be started before
VFIO devices at VM_CHANGE_STATE_PRI_HIGH on VM start and stopped only
after VFIO devices at VM_CHANGE_STATE_PRI_NORMAL.

To implement that ordering and to make sure that it is not lost in a future
code refactor, introduce an explicit VMChangeStateHandlerDepth - much like
migration has explicit MigrationPriority values.

Since normal qdev tree depths are non-negative these earlier-on-start /
later-on-stop depths need to be increasingly negative.

Preserve the old ITS vs GIC ordering.
This happens to also match the MigrationPriority of these controllers.

In terms of implementation, the kvm-tpr-opt VAPIC VM state change handler
is already NOP on VM stop, while ITS and GIC handlers are NOPs on VM start.
So for these devices the change amounts to trivial adjustment of their
handlers priorities and/or depths.

For the remaining sPAPR XIVE interrupt controller make use of the
start/stop split of its VM state change handler introduced by the previous
commit.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/i386/vapic.c             |  5 +++--
 hw/intc/arm_gicv3_its_kvm.c |  4 +++-
 hw/intc/arm_gicv3_kvm.c     |  4 +++-
 hw/intc/spapr_xive_kvm.c    | 26 ++++++++++----------------
 include/hw/ppc/spapr_xive.h |  3 ++-
 include/system/runstate.h   | 11 +++++++++++
 system/runstate.c           |  2 +-
 7 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 5c3911cf9c83..3d8f7a64b9cb 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -822,8 +822,9 @@ static int vapic_post_load(void *opaque, int version_id)
     }
 
     if (!s->vmsentry) {
-        s->vmsentry =
-            qemu_add_vm_change_state_handler(vapic_vm_state_change, s);
+        s->vmsentry = qemu_add_vm_change_state_handler_prio_full(
+            vapic_vm_state_change, NULL, s, VM_CHANGE_STATE_PRI_HIGH,
+            VM_CHANGE_STATE_DEPTH_APIC);
     }
     return 0;
 }
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index a8d6d4fb540a..ea3681b8d62f 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -119,7 +119,9 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
             return;
         }
     } else {
-        qemu_add_vm_change_state_handler(vm_change_state_handler, s);
+        qemu_add_vm_change_state_handler_prio_full(
+            vm_change_state_handler, NULL, s, VM_CHANGE_STATE_PRI_NORMAL,
+            VM_CHANGE_STATE_DEPTH_GICV3_ITS);
     }
 
     kvm_msi_use_devid = true;
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index fddeefa26f30..fd4a4527c46f 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -925,7 +925,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     }
     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                               KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
-        qemu_add_vm_change_state_handler(vm_change_state_handler, s);
+        qemu_add_vm_change_state_handler_prio_full(
+            vm_change_state_handler, NULL, s, VM_CHANGE_STATE_PRI_NORMAL,
+            VM_CHANGE_STATE_DEPTH_GICV3);
         migration_add_notifier_mode(&s->cpr_notifier,
                                     kvm_arm_gicv3_notifier,
                                     MIG_MODE_CPR_TRANSFER);
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index e1a4f0b640cb..483f9ffcb607 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -585,16 +585,6 @@ static void kvmppc_xive_change_state_stop(void *opaque, bool running,
     }
 }
 
-static void kvmppc_xive_change_state_handler(void *opaque, bool running,
-                                             RunState state)
-{
-    if (running) {
-        kvmppc_xive_change_state_start(opaque, running, state);
-    } else {
-        kvmppc_xive_change_state_stop(opaque, running, state);
-    }
-}
-
 void kvmppc_xive_synchronize_state(SpaprXive *xive, Error **errp)
 {
     assert(xive->fd != -1);
@@ -813,8 +803,12 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
     memory_region_add_subregion_overlap(&xive->tm_mmio, 0,
                                         &xive->tm_mmio_kvm, 1);
 
-    xive->change = qemu_add_vm_change_state_handler(
-        kvmppc_xive_change_state_handler, xive);
+    xive->change_start = qemu_add_vm_change_state_handler_prio_full(
+        kvmppc_xive_change_state_start, NULL, xive,
+        VM_CHANGE_STATE_PRI_HIGH, VM_CHANGE_STATE_DEPTH_XIVE);
+    xive->change_stop = qemu_add_vm_change_state_handler_prio_full(
+        kvmppc_xive_change_state_stop, NULL, xive,
+        VM_CHANGE_STATE_PRI_NORMAL, VM_CHANGE_STATE_DEPTH_XIVE);
 
     /* Connect the presenters to the initial VCPUs of the machine */
     CPU_FOREACH(cs) {
@@ -884,8 +878,8 @@ void kvmppc_xive_disconnect(SpaprInterruptController *intc)
     kvm_cpu_disable_all();
 
     /* VM Change state handler is not needed anymore */
-    if (xive->change) {
-        qemu_del_vm_change_state_handler(xive->change);
-        xive->change = NULL;
-    }
+    qemu_del_vm_change_state_handler(xive->change_start);
+    xive->change_start = NULL;
+    qemu_del_vm_change_state_handler(xive->change_stop);
+    xive->change_stop = NULL;
 }
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index b282960ad90d..4fe9af8c6c7a 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -48,7 +48,8 @@ typedef struct SpaprXive {
     int           fd;
     void          *tm_mmap;
     MemoryRegion  tm_mmio_kvm;
-    VMChangeStateEntry *change;
+    VMChangeStateEntry *change_start;
+    VMChangeStateEntry *change_stop;
 
     uint8_t       hv_prio;
 } SpaprXive;
diff --git a/include/system/runstate.h b/include/system/runstate.h
index c10d9dc8b751..523d267ea2fc 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -21,6 +21,17 @@ typedef enum VMChangeStateHandlerPri {
     VM_CHANGE_STATE_PRI_MAX,
 } VMChangeStateHandlerPri;
 
+typedef enum VMChangeStateHandlerDepth {
+    VM_CHANGE_STATE_DEPTH_GICV3 = -3,
+    VM_CHANGE_STATE_DEPTH_GICV3_ITS = -2,
+
+    VM_CHANGE_STATE_DEPTH_APIC = -1,
+    VM_CHANGE_STATE_DEPTH_XIVE = -1,
+
+    /* qdev tree depths start here */
+    VM_CHANGE_STATE_DEPTH_DEFAULT = 0,
+} VMChangeStateHandlerDepth;
+
 /**
  * qemu_add_vm_change_state_handler:
  * @cb: the callback to invoke
diff --git a/system/runstate.c b/system/runstate.c
index 6039bb81ecfd..45469f997fdf 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -326,7 +326,7 @@ VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
     VMChangeStateHandlerPri priority)
 {
     return qemu_add_vm_change_state_handler_prio_full(
-        cb, NULL, opaque, priority, 0);
+        cb, NULL, opaque, priority, VM_CHANGE_STATE_DEPTH_DEFAULT);
 }
 
 VMChangeStateEntry *

