Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3498C71132
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP2Ah-0001JB-NT; Tue, 10 Jun 2025 12:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15R-0004Un-Qf
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15O-0006D0-MY
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXeN1031142;
 Tue, 10 Jun 2025 15:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=rjcBzt9GtYLUD97vLNEESxroG7+MwYcBu07u518gFkE=; b=
 KGsJT/mVkerkjhC+oteNqgdKR0Ud8BZ7NGkzuPlV/YoL+vWiE+R/YMy9/hnZavAL
 vRDVpDra4LIwbW6dLY8sDGp/qLYD1iyCeL95R87pU1oB8UoIsDHKwaWKyKLeHCny
 LWGs3PcdePyI0tF9ZG3sVZgcoiBrmyRdgU46h0ftZnUsKIluVYLCx6M4Y0sp1vvn
 RKeqxP6HHZps+i5DF8MocD3d2tXjtMTIprgN0PvTwvW4ql+enIZZVk8PbIHroFAg
 U/H5aRm2QxBIPtb4OVmvV9xVtpyzHnc6WygfKGYJJLZhzIGnMosWbYrKJGO0gVJH
 At0x/UlgfpvRa34iumb4dQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywvgsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEbn3x004100; Tue, 10 Jun 2025 15:40:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:22 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfj028825;
 Tue, 10 Jun 2025 15:40:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-20; Tue, 10 Jun 2025 15:40:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 19/38] vfio-pci: preserve INTx
Date: Tue, 10 Jun 2025 08:39:32 -0700
Message-Id: <1749569991-25171-20-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100125
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684851e7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=aHyXveKDkG1ssMKnveQA:9 cc=ntf
 awl=host:14714
X-Proofpoint-ORIG-GUID: 2qYp4ko4etI_UBxVuROK0J_YkcNWkzjS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX06CrjEf0PLyp
 D6JWdiGpVCOOwIO+R3RC95Q5WHFlP1nsjuauNC68sWMvTfdmf/M9yyXRLOqndAS20Z99UtcvN87
 +aWAYBsbK1jYe1xvj0IlaTKVlT2VQtlehtgR2tDemxh1oUt42KlVbDGYrvYavuRKm+kqHnJsIeJ
 Nn9y6FDJTp1epZ1L8Ze3Hnl9DHHolq1zBlREOvF/Sv+iTl3bTkbwArtVb8hWk39ZhjMr8Z3N/ZY
 5BeVvKs9FogE80gE93nDiHLaqmPetYFPLMzfJJC0E71LLMgpQtAOiCCq+5HQfsDLLozcKduKgqt
 1qdP9oubPii6bm9RunhpBk+FpMAxQToBPxztY2IIBnYSy4n97z1DcOAh0ws7tiQzRveTCRDIVag
 ewIMPBI0yRe0dUKCjuIHlIDkry3n8n36A3Nu1uOkZk+W/1bm9qSYsozYhyWcx0hhqc1Qt/pW
X-Proofpoint-GUID: 2qYp4ko4etI_UBxVuROK0J_YkcNWkzjS
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Preserve vfio INTx state across cpr-transfer.  Preserve VFIOINTx fields as
follows:
  pin : Recover this from the vfio config in kernel space
  interrupt : Preserve its eventfd descriptor across exec.
  unmask : Ditto
  route.irq : This could perhaps be recovered in vfio_pci_post_load by
    calling pci_device_route_intx_to_irq(pin), whose implementation reads
    config space for a bridge device such as ich9.  However, there is no
    guarantee that the bridge vmstate is read before vfio vmstate.  Rather
    than fiddling with MigrationPriority for vmstate handlers, explicitly
    save route.irq in vfio vmstate.
  pending : save in vfio vmstate.
  mmap_timeout, mmap_timer : Re-initialize
  bool kvm_accel : Re-initialize

In vfio_realize, defer calling vfio_intx_enable until the vmstate
is available, in vfio_pci_post_load.  Modify vfio_intx_enable and
vfio_intx_kvm_enable to skip vfio initialization, but still perform
kvm initialization.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr.c | 27 ++++++++++++++++++++++++++-
 hw/vfio/pci.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index e467373..f5555ca 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -139,7 +139,11 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
         vfio_cpr_claim_vectors(vdev, nr_vectors, false);
 
     } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
-        g_assert_not_reached();      /* completed in a subsequent patch */
+        Error *local_err = NULL;
+        if (!vfio_pci_intx_enable(vdev, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
     }
 
     return 0;
@@ -152,6 +156,26 @@ static bool pci_msix_present(void *opaque, int version_id)
     return msix_present(pdev);
 }
 
+static const VMStateDescription vfio_intx_vmstate = {
+    .name = "vfio-cpr-intx",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(pending, VFIOINTx),
+        VMSTATE_UINT32(route.mode, VFIOINTx),
+        VMSTATE_INT32(route.irq, VFIOINTx),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define VMSTATE_VFIO_INTX(_field, _state) {                         \
+    .name       = (stringify(_field)),                              \
+    .size       = sizeof(VFIOINTx),                                 \
+    .vmsd       = &vfio_intx_vmstate,                               \
+    .flags      = VMS_STRUCT,                                       \
+    .offset     = vmstate_offset_value(_state, _field, VFIOINTx),   \
+}
+
 const VMStateDescription vfio_cpr_pci_vmstate = {
     .name = "vfio-cpr-pci",
     .version_id = 0,
@@ -162,6 +186,7 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
+        VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b3dbb84..b52c488 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -161,12 +161,17 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (cpr_is_incoming()) {
+        goto skip_state;
+    }
+
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
 
+skip_state:
     /* Get an eventfd for resample/unmask */
     if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         goto fail;
@@ -180,6 +185,10 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         goto fail_irqfd;
     }
 
+    if (cpr_is_incoming()) {
+        goto skip_irq;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_UNMASK,
                                        event_notifier_get_fd(&vdev->intx.unmask),
@@ -190,6 +199,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     /* Let'em rip */
     vfio_device_irq_unmask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
+skip_irq:
     vdev->intx.kvm_accel = true;
 
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
@@ -305,7 +315,13 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
-    vfio_disable_interrupts(vdev);
+    /*
+     * Do not alter interrupt state during vfio_realize and cpr load.
+     * The incoming state is cleared thereafter.
+     */
+    if (!cpr_is_incoming()) {
+        vfio_disable_interrupts(vdev);
+    }
 
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(vdev->pdev.config, pin);
@@ -328,8 +344,10 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
-    if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                                VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
+    if (!cpr_is_incoming() &&
+        !vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,
+                                       0, VFIO_IRQ_SET_ACTION_TRIGGER, fd,
+                                       errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
         return false;
@@ -3234,7 +3252,13 @@ static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        if (!vfio_intx_enable(vdev, errp)) {
+
+        /*
+         * During CPR, do not call vfio_intx_enable at this time.  Instead,
+         * call it from vfio_pci_post_load after the intx routing data has
+         * been loaded from vmstate.
+         */
+        if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
             timer_free(vdev->intx.mmap_timer);
             pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
             kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
-- 
1.8.3.1


