Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED46DC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTT-00061X-00; Fri, 14 Feb 2025 09:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTP-0005s0-Qq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:19 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTN-0004gn-MO
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:19 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtUUl022105;
 Fri, 14 Feb 2025 14:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=pslagFP9E8mIaHHpFR0W5yIEnzrG0ZmdbkLwbbFkA/o=; b=
 RhSsYrmCwjVzSQTaafNzfbYby+c78F7gruF00znXyhU1p3cOt4FFhgncXwR/kTup
 FGmy6dWCYqycdKJ5pLrNpxHRfPHT1lHPnz7HXB1AvI1jff1bR0I0coP3GbHBqsO5
 yxrGU5qxhPU7oXKNviOUqkOqNx04/sDDToNEMeH0qdQGrblkW6Z4jTy2EoCk6bZY
 WQMoi5r5+GM8yASGBzDhtj7WYtFNtwhnTZFijFnxn+u5AvW5vbT/QDCc1kckHCkQ
 15NrhfHZBUiSCb16wwlJKBSlLLSsXaz6A+AIILhHtk41SlmfgqszLCHQ4EFIS6+e
 LVpbMbZHjwklD4NG4tmFAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0s43q74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:04 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ECxUWI025134; Fri, 14 Feb 2025 14:15:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgnd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQ3006920;
 Fri, 14 Feb 2025 14:15:02 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-26; Fri, 14 Feb 2025 14:15:02 +0000
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
Subject: [PATCH V2 25/45] vfio-pci: preserve INTx
Date: Fri, 14 Feb 2025 06:14:07 -0800
Message-Id: <1739542467-226739-26-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502140104
X-Proofpoint-GUID: zrY8DdCpGzgWzpNBGd2vAD5V97oQ69sr
X-Proofpoint-ORIG-GUID: zrY8DdCpGzgWzpNBGd2vAD5V97oQ69sr
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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
 hw/vfio/pci.c | 28 +++++++++++++++++++++++++---
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 96eb10a..a2400ca 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -140,12 +140,36 @@ static int vfio_cpr_pci_post_load(void *opaque, int version_id)
         vfio_cpr_claim_vectors(vdev, nr_vectors, false);
 
     } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
-        g_assert_not_reached();      /* completed in a subsequent patch */
+        Error *err = NULL;
+        if (!vfio_intx_enable(vdev, &err)) {
+            error_report_err(err);
+            return -1;
+        }
     }
 
     return 0;
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
@@ -156,6 +180,7 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
+        VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 465ca6b..c5470d0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -158,12 +158,17 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
+    if (vdev->vbasedev.cpr.reused) {
+        goto skip_state;
+    }
+
     /* Get to a known interrupt state */
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_mask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
 
+skip_state:
     /* Get an eventfd for resample/unmask */
     if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
         goto fail;
@@ -177,6 +182,10 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
         goto fail_irqfd;
     }
 
+    if (vdev->vbasedev.cpr.reused) {
+        goto skip_irq;
+    }
+
     if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_UNMASK,
                                 event_notifier_get_fd(&vdev->intx.unmask),
@@ -187,6 +196,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     /* Let'em rip */
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 
+skip_irq:
     vdev->intx.kvm_accel = true;
 
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
@@ -302,7 +312,13 @@ bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return true;
     }
 
-    vfio_disable_interrupts(vdev);
+    /*
+     * Do not alter interrupt state during vfio_realize and cpr load.  The
+     * reused flag is cleared thereafter.
+     */
+    if (!vdev->vbasedev.cpr.reused) {
+        vfio_disable_interrupts(vdev);
+    }
 
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
     pci_config_set_interrupt_pin(vdev->pdev.config, pin);
@@ -325,7 +341,8 @@ bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
     qemu_set_fd_handler(fd, vfio_intx_interrupt, NULL, vdev);
 
-    if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
+    if (!vdev->vbasedev.cpr.reused &&
+        !vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, errp)) {
         qemu_set_fd_handler(fd, NULL, NULL, vdev);
         vfio_notifier_cleanup(vdev, &vdev->intx.interrupt, "intx-interrupt", 0);
@@ -3241,7 +3258,12 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
-        if (!vfio_intx_enable(vdev, errp)) {
+        /*
+         * During CPR, do not call vfio_intx_enable at this time.  Instead,
+         * call it from vfio_pci_post_load after the intx routing data has
+         * been loaded from vmstate.
+         */
+        if (!vdev->vbasedev.cpr.reused && !vfio_intx_enable(vdev, errp)) {
             goto out_deregister;
         }
     }
-- 
1.8.3.1


