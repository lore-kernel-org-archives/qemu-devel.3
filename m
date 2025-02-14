Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C72DC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 14:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiwTI-0005S5-RO; Fri, 14 Feb 2025 09:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTE-0005Ml-IM
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tiwTB-0004gU-TV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 09:15:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ECtVob006567;
 Fri, 14 Feb 2025 14:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=a6jTTQQvcIqWlxivx37CfEI0ZQo9AgdOEAsw38ZaQF0=; b=
 m8nojxMV+9vRQQ0Q+iQAiJay3GB0MtQnI7gn9aCvoXhAfYgEz4G3ZmBveOdQ3Z1K
 5sm5/6e0isA/YhDWKQwHQYpw2X3Fz0ULK3RoiAc9QcXnbiOw2fixHRtVk12zOGFn
 EHcUKkgRARrwQjzvxF379KUsD25YyuI4nbS57JkXt5bYbqYAaY+SzVSuRVbUJgl9
 armyfbygRXXWW2qV/5n7gCGKloQnE2/VNwhXcOiNdJ5dwQOi7FyDcLdxHabrWZv6
 tuF/hqrznVhFrrlChFOVLONaVt4bAEY+rxNVIAbKYFWqMCuxQbyQEkqKSoyXB4aP
 4oEKMA9RbYYlCwWFhYj2fQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qaknw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51ED5ZWc025287; Fri, 14 Feb 2025 14:15:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44nwqksgm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Feb 2025 14:15:02 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51EEETQ1006920;
 Fri, 14 Feb 2025 14:15:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 44nwqksg2h-25; Fri, 14 Feb 2025 14:15:01 +0000
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
Subject: [PATCH V2 24/45] vfio-pci: preserve MSI
Date: Fri, 14 Feb 2025 06:14:06 -0800
Message-Id: <1739542467-226739-25-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: hajmOIlDGtoDDLBH8xTQkpvRSHkFM6wv
X-Proofpoint-ORIG-GUID: hajmOIlDGtoDDLBH8xTQkpvRSHkFM6wv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Save the MSI message area as part of vfio-pci vmstate, and preserve the
interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
then the vfio-pci post_load handler finds the eventfds in CPR state,
rebuilds vector data structures, and attaches the interrupts to the new
KVM instance.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr.c              | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c              | 40 ++++++++++++++++++--
 include/hw/vfio/vfio-cpr.h |  8 ++++
 3 files changed, 136 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 8268c0c..96eb10a 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -9,6 +9,8 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "hw/vfio/pci.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/msi.h"
 #include "migration/cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
@@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
 
+#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
+    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
+
+void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
+                             int fd)
+{
+    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
+    cpr_resave_fd(fdname, nr, fd);
+}
+
+int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
+{
+    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
+    return cpr_find_fd(fdname, nr);
+}
+
+void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
+{
+    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
+    cpr_delete_fd(fdname, nr);
+}
+
+static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
+                                   bool msix)
+{
+    int i, fd;
+    bool pending = false;
+    PCIDevice *pdev = &vdev->pdev;
+
+    vdev->nr_vectors = nr_vectors;
+    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
+    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
+
+    vfio_prepare_kvm_msi_virq_batch(vdev);
+
+    for (i = 0; i < nr_vectors; i++) {
+        VFIOMSIVector *vector = &vdev->msi_vectors[i];
+
+        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
+        if (fd >= 0) {
+            vfio_vector_init(vdev, i);
+            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
+        }
+
+        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
+            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
+        } else {
+            vdev->msi_vectors[i].virq = -1;
+        }
+
+        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
+            set_bit(i, vdev->msix->pending);
+            pending = true;
+        }
+    }
+
+    vfio_commit_kvm_msi_virq_batch(vdev);
+
+    if (msix) {
+        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
+    }
+}
+
 /*
  * The kernel may change non-emulated config bits.  Exclude them from the
  * changed-bits check in get_pci_config_device.
@@ -58,13 +123,39 @@ static int vfio_cpr_pci_pre_load(void *opaque)
     return 0;
 }
 
+static int vfio_cpr_pci_post_load(void *opaque, int version_id)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int nr_vectors;
+
+    if (msix_enabled(pdev)) {
+        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
+                                   vfio_msix_vector_release, NULL);
+        nr_vectors = vdev->msix->entries;
+        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
+
+    } else if (msi_enabled(pdev)) {
+        nr_vectors = msi_nr_vectors_allocated(pdev);
+        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
+
+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
+        g_assert_not_reached();      /* completed in a subsequent patch */
+    }
+
+    return 0;
+}
+
 const VMStateDescription vfio_cpr_pci_vmstate = {
     .name = "vfio-cpr-pci",
     .version_id = 0,
     .minimum_version_id = 0,
     .pre_load = vfio_cpr_pci_pre_load,
+    .post_load = vfio_cpr_pci_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 29a5b3d..465ca6b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "migration/vmstate.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
@@ -54,13 +55,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+/* Create new or reuse existing eventfd */
 static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
                                const char *name, int nr, Error **errp)
 {
-    int ret = event_notifier_init(e, 0);
+    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);
+    int ret = 0;
 
-    if (ret) {
-        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+    if (fd >= 0) {
+        event_notifier_init_fd(e, fd);
+    } else {
+        ret = event_notifier_init(e, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+        } else {
+            fd = event_notifier_get_fd(e);
+            if (fd >= 0) {
+                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
+            }
+        }
     }
     return !ret;
 }
@@ -68,6 +81,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
 static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
                                   const char *name, int nr)
 {
+    vfio_cpr_delete_vector_fd(vdev, name, nr);
     event_notifier_cleanup(e);
 }
 
@@ -554,6 +568,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
+    /*
+     * Ignore the callback from msix_set_vector_notifiers during resume.
+     * The necessary subset of these actions is called from
+     * vfio_cpr_claim_vectors during post load.
+     */
+    if (vdev->vbasedev.cpr.reused) {
+        return 0;
+    }
+
     trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
 
     vector = &vdev->msi_vectors[nr];
@@ -2894,6 +2917,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (vdev->vbasedev.cpr.reused) {
+        return;
+    }
+
     if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -2960,6 +2988,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (vdev->vbasedev.cpr.reused) {
+        vdev->req_enabled = true;
+        return;
+    }
+
     if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index f5480de..a9f2fbe 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -27,6 +27,7 @@ typedef struct VFIODeviceCPR {
 struct VFIOContainer;
 struct VFIOGroup;
 struct VFIOContainerBase;
+struct VFIOPCIDevice;
 
 int vfio_cpr_reboot_notifier(NotifierWithReturn *notifier, MigrationEvent *e,
                              Error **errp);
@@ -44,5 +45,12 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
 bool vfio_cpr_register_ram_discard_listener(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                             int nr, int fd);
+int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                            int nr);
+void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                               int nr);
+
 extern const VMStateDescription vfio_cpr_pci_vmstate;
 #endif
-- 
1.8.3.1


