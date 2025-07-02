Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFACC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U0-0003PR-CE; Wed, 02 Jul 2025 17:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tw-0003ND-QV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tu-0003eR-4e
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQkRp027776;
 Wed, 2 Jul 2025 21:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=t7rscO2SyX2v9N7ovAAkGEabOF7CN4OlpG3+1xbyBiM=; b=
 ny+DvWGlzYJUCcD50eSKyvNx/kFe5+/ZOLggp7aXdpSQCDzjlU7bAkO4HfkYPDlE
 0tYE6d1yIB5WYW1J1zUCKTRFaOEuRpMtElg1EmyElXgU1vznMLGrjCnhFCGejwCO
 OkMtaiYvT5Wrr5EcJqTpG6WCTFY6IA7TYccEElFRDnyVxOQBu4Tpk0W9h8Hhteyv
 1Y5OJcnzXuTCE99dw/6yV1er9diopsM2ZXI7tcWoUXYinry1g189R0p6ftRTc3BI
 +9NJU77j1AqSrORFGECTDl4Yjf9cGNNJ4Y8n6p5kYfkFQyrO1McwsHDLQ8laRi6i
 lcP3vPsVE/K8ysduraqiBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j80w7vr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:02 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LiPdW033611; Wed, 2 Jul 2025 21:59:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtd01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxfw020012;
 Wed, 2 Jul 2025 21:59:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-3; Wed, 02 Jul 2025 21:59:01 +0000
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
Subject: [PATCH V6 02/21] vfio-pci: preserve INTx
Date: Wed,  2 Jul 2025 14:58:39 -0700
Message-Id: <1751493538-202042-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_04,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507020182
X-Proofpoint-GUID: 6nglvnFuk4XdOAqgIGKyFrDJw_9mT_xl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX70PFbkQc7PKK
 SQgbcpHx3QOobSBzA90jsXTmnpS2GRrY2b5xnPVrrTDVgthnhPvMI5znInFdi/0bJgf4KlkCfwG
 VhV6t0OZphTIN1PdX3RayrUtqJadq3QbY1DE2/579580EdJCvEC7uhyx1mA20SdhLh5Js2BdIKc
 UX/BM3C5VlVEUWqVqHm6O1zH3xVcIQe825bHoO9olWv+3obCCHYKHosSNve8tUagCpjUXTqEPLg
 0LltoNySaYN63sxTOcgVUDGj/o1O95tAO+FI1za5NWkfzYDgej+WHDj0FnvwSlgO28tFcAjh3VS
 qIJMVgUrkC640rsNXk5zQJ+aDZmBi/z99DBu14veYKfeYscmfa3kNeUAt4lvRJe9VnXfpNYDwqi
 /z1UwbpnjsGzbAkRyumil4LHVwxa4bc01ARlVuU15mW1BNTsiYEWFO4rW97f6USxLp6+HnkF
X-Authority-Analysis: v=2.4 cv=D6hHKuRj c=1 sm=1 tr=0 ts=6865aba6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=aHyXveKDkG1ssMKnveQA:9
X-Proofpoint-ORIG-GUID: 6nglvnFuk4XdOAqgIGKyFrDJw_9mT_xl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
 hw/vfio/pci.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

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
index 5f9f264..dd0b2a0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -210,6 +210,36 @@ fail:
 #endif
 }
 
+static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
+{
+#ifdef CONFIG_KVM
+    if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
+        vdev->intx.route.mode != PCI_INTX_ENABLED ||
+        !kvm_resamplefds_enabled()) {
+        return true;
+    }
+
+    if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
+        return false;
+    }
+
+    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &vdev->intx.interrupt,
+                                           &vdev->intx.unmask,
+                                           vdev->intx.route.irq)) {
+        error_setg_errno(errp, errno, "failed to setup resample irqfd");
+        vfio_notifier_cleanup(vdev, &vdev->intx.unmask, "intx-unmask", 0);
+        return false;
+    }
+
+    vdev->intx.kvm_accel = true;
+    trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
+    return true;
+#else
+    return true;
+#endif
+}
+
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
@@ -305,7 +335,13 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
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
@@ -328,6 +364,14 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
+
+    if (cpr_is_incoming()) {
+        if (!vfio_cpr_intx_enable_kvm(vdev, &err)) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        }
+        goto skip_signaling;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
@@ -339,6 +383,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
     }
 
+skip_signaling:
     vdev->interrupt = VFIO_INT_INTx;
 
     trace_vfio_intx_enable(vdev->vbasedev.name);
@@ -3237,7 +3282,13 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
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


