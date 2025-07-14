Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E53C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLL6-0006SG-Iy; Mon, 14 Jul 2025 11:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKAH-0007Rr-Pm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:28:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKAC-0002V8-L7
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 10:28:21 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z6CJ001413;
 Mon, 14 Jul 2025 14:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=MrNWIE3/jdiQwfxMbXqrKaokDMyo3PA3vP/8rnxdwWQ=; b=
 EXXWClcegqe8NSQVS8y0VcJU5uxLVvZ3U3V800ywSdl6CuOJ88XfEk538T54KZ02
 rD7nj8tvy+73qe3YlTolBHbV26rH8KZsmFAkPNTzkUDVjlN9PwPLWpYei3ykVTrN
 6Dxu30texgWgi1OsHsufmqizghLctp+slKNLiuCW5sZKEbtLV4wRSsVaQp8xqIR8
 Qj0AzfXcAOD1342nK/rRpVeI+VnBPI3VgZLCWaT5OA99GdjCDxpIE9QYjhAiadlm
 o7Fr196Ww3AZObYB0v/t0FSecyvj7miF3OYPvB8FGkPagra20f0Znsf5vViPRFhT
 uY+/pFVqmeA5oojvG9RsFg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8fv839-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EDtL5g011575; Mon, 14 Jul 2025 14:27:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58kggg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:05 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EER3Mx039980;
 Mon, 14 Jul 2025 14:27:05 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58kgf3-3; Mon, 14 Jul 2025 14:27:05 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/2] vfio/pci: preserve pending interrupts
Date: Mon, 14 Jul 2025 07:27:02 -0700
Message-Id: <1752503222-222669-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
References: <1752503222-222669-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-ORIG-GUID: DB5NME521Ka5mrRa732dgXMtZT4vkuaB
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687513bb b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=dn5GK5m0wEVzo6Wfy8cA:9 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: DB5NME521Ka5mrRa732dgXMtZT4vkuaB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfX4rIob8ieavFR
 LxVll7Xr5owM0w2tmb1uThcva5pFz7mKZmT5wT3bBoMvv7ScfdoX71XVrC86fgSGo728k+cIr0A
 WSEgd6wD6Djq3XzpWvqUVImtHEB4T7Nk7OUGLjo64CXnP8dYsZINcUe5GgPDSYIA+Y/0S5C31xq
 mKYqePi9G/v1WzagTUu+/e5c1vAbUH4QN7/Z0uamY1LW6TIvV3lGioMgEJjGL5+J2ajkZhpskbj
 Repb2ON/6IYXnHmjOexgY56lqDEC18H+vPyj9FKl6haJRLh0ADRMJ8juml76UFH6Bq9NqBn2+UJ
 O8gILS6JW8psw9G6hBhLeV3xp4MP/+2tFi5LVAG402jv6FAkq71e7NTwblFSF5EBOraPX9/HjhG
 PAzRFJqZ0avjqG+O8L8dxS/s///vWvyPLJ2NgKjWH+nLjcurK1n/y87TK5yMAEu1Y+0gmjv7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

cpr-transfer may lose a VFIO interrupt because the KVM instance is
destroyed and recreated.  If an interrupt arrives in the middle, it is
dropped.  To fix, disable pended interrupts during cpr save, and pick
up the pieces.  In more detail:

Stop the VCPUs. Call kvm_irqchip_remove_irqfd_notifier_gsi --> KVM_IRQFD to
deassign the irqfd gsi that routes interrupts directly to the VCPU and KVM.
After this call, interrupts fall back to the kernel vfio_msihandler, which
writes to QEMU's kvm_interrupt eventfd.  CPR already preserves that
eventfd.  When the route is re-established in new QEMU, the kernel tests
the eventfd and pends an interrupt to KVM if necessary.

Deassign INTx in a similar manner.  For both MSI and INTx, remove the
eventfd handler so old QEMU does not consume an event.

If an interrupt was already pended to KVM prior to the completion of
kvm_irqchip_remove_irqfd_notifier_gsi, it will be recovered by the
subsequent call to cpu_synchronize_all_states, which pulls KVM interrupt
state to userland prior to saving it in vmstate.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr.c              | 90 ++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c              |  2 +
 hw/vfio/pci.h              |  1 +
 include/hw/vfio/vfio-cpr.h |  6 +++
 4 files changed, 99 insertions(+)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 2a244fc4b6..ae2a6b7acd 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -198,3 +198,93 @@ void vfio_cpr_add_kvm_notifier(void)
                                     MIG_MODE_CPR_TRANSFER);
     }
 }
+
+static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
+                                  EventNotifier *rn, int virq, bool enable)
+{
+    if (enable) {
+        return kvm_irqchip_add_irqfd_notifier_gsi(s, n, rn, virq);
+    } else {
+        return kvm_irqchip_remove_irqfd_notifier_gsi(s, n, virq);
+    }
+}
+
+static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool enable)
+{
+    const char *op = (enable ? "enable" : "disable");
+    PCIDevice *pdev = &vdev->pdev;
+    int i, nr_vectors, ret = 0;
+
+    if (msix_enabled(pdev)) {
+        nr_vectors = vdev->msix->entries;
+
+    } else if (msi_enabled(pdev)) {
+        nr_vectors = msi_nr_vectors_allocated(pdev);
+
+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
+        ret = set_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
+                                     &vdev->intx.unmask, vdev->intx.route.irq,
+                                     enable);
+        if (ret) {
+            error_setg(errp, "failed to %s INTx irq %d: error %d",
+                       op, vdev->intx.route.irq, ret);
+        } else {
+            vfio_pci_intx_set_handler(vdev, enable);
+        }
+        return ret;
+
+    } else {
+        nr_vectors = 0;
+    }
+
+    for (i = 0; i < nr_vectors; i++) {
+        VFIOMSIVector *vector = &vdev->msi_vectors[i];
+        if (vector->use) {
+            ret = set_irqfd_notifier_gsi(kvm_state, &vector->kvm_interrupt,
+                                         NULL, vector->virq, enable);
+            if (ret) {
+                error_setg(errp, "failed to %s msi vector %d virq %d: error %d",
+                           op, i, vector->virq, ret);
+            } else {
+                vfio_pci_msi_set_handler(vdev, i, enable);
+            }
+        }
+    }
+
+    return ret;
+}
+
+/*
+ * When CPR starts, detach IRQs from the VFIO device so future interrupts
+ * are posted to kvm_interrupt, which is preserved in new QEMU.  Interrupts
+ * that were already posted to the old KVM instance, but not delivered to the
+ * VCPU, are recovered via KVM_GET_LAPIC and pushed to the new KVM instance
+ * in new QEMU.
+ *
+ * If CPR fails, reattach the IRQs.
+ */
+static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
+                                 MigrationEvent *e, Error **errp)
+{
+    VFIOPCIDevice *vdev =
+        container_of(notifier, VFIOPCIDevice, cpr.transfer_notifier);
+
+    if (e->type == MIG_EVENT_PRECOPY_SETUP) {
+        return vfio_cpr_set_msi_virq(vdev, errp, false);
+    } else if (e->type == MIG_EVENT_PRECOPY_FAILED) {
+        return vfio_cpr_set_msi_virq(vdev, errp, true);
+    }
+    return 0;
+}
+
+void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
+{
+    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
+                                vfio_cpr_pci_notifier,
+                                MIG_MODE_CPR_TRANSFER);
+}
+
+void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)
+{
+    migration_remove_notifier(&vdev->cpr.transfer_notifier);
+}
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8b471c054a..22a4125131 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2993,6 +2993,7 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
+    vfio_cpr_pci_unregister_device(vdev);
     g_free(vdev->emulated_config_bits);
     g_free(vdev->rom);
     /*
@@ -3442,6 +3443,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
     vfio_pci_register_err_notifier(vdev);
     vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
+    vfio_cpr_pci_register_device(vdev);
 
     return;
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 80c8fcfa07..7989b94eb3 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -194,6 +194,7 @@ struct VFIOPCIDevice {
     bool skip_vsc_check;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
+    VFIOPCICPR cpr;
 };
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 80ad20d216..d37daffbc5 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -38,6 +38,10 @@ typedef struct VFIODeviceCPR {
     uint32_t ioas_id;
 } VFIODeviceCPR;
 
+typedef struct VFIOPCICPR {
+    NotifierWithReturn transfer_notifier;
+} VFIOPCICPR;
+
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
 void vfio_legacy_cpr_unregister_container(struct VFIOContainer *container);
@@ -77,5 +81,7 @@ extern const VMStateDescription vfio_cpr_pci_vmstate;
 extern const VMStateDescription vmstate_cpr_vfio_devices;
 
 void vfio_cpr_add_kvm_notifier(void);
+void vfio_cpr_pci_register_device(struct VFIOPCIDevice *vdev);
+void vfio_cpr_pci_unregister_device(struct VFIOPCIDevice *vdev);
 
 #endif /* HW_VFIO_VFIO_CPR_H */
-- 
2.39.3


