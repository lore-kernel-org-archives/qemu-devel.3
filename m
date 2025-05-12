Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F1BC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEVB2-0006OD-OV; Mon, 12 May 2025 11:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9l-0004cs-KH
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uEV9h-0006gr-5O
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:33:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CCA0Du018779;
 Mon, 12 May 2025 15:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=ccHwAqnLp+K7mtdNTHTIuz8FDWsTd9qXX6B+6K6uvQ0=; b=
 qGrDcCFQ+mcQwQ/tanUf4VZtWMm1ev90XlecBUWXTH1n1fOQJdqSUMV0Kyq4w/6k
 /6Nk4eOWqAAvhQOZiN1JQcWMZAJ72YJt5DCefjWuE2+YZuSP0UmzfKNwihMqA3ZH
 8cytHJQXQUjrx3yGvKIeuGhZInAVhlNAtpkeDzNBFOl2imozHohYYv1mTEY45J53
 9uIW90awje0vb24Jvjy0goWEOGEdmAAOCY1vDMeu6/iUnXiDbv2GakVQ9GNiGpwo
 Zj1GU4rCCSl5Q6ixdYGsjL4yhOGEoOu/9MspjhZrQWMNPnDa0iNBYX7vuv3zPPHd
 s/SZcNP5KiXEPNQ7+WbRtQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j13r2se1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE214m002394; Mon, 12 May 2025 15:33:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx366k2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:33:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54CFWk5M030605;
 Mon, 12 May 2025 15:33:11 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 46jwx36627-23; Mon, 12 May 2025 15:33:11 +0000
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
Subject: [PATCH V3 22/42] vfio-pci: preserve MSI
Date: Mon, 12 May 2025 08:32:33 -0700
Message-Id: <1747063973-124548-23-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120161
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX3LqMwPYot8Qi
 8ky6x0/IkmsJExIM3/ZlXLPGDyxHulluFFnb0Uo8A/PwlvK5hV3FUiWmjLYdbOlaVOg69o2PFVt
 Zgd3eeZH7+qNkl9q638dPkKdsEEb3S1BVOZBf/96keB/48dSjSCeA/r7sLCtMuCrfPi+lUpvfCt
 hcaYhxfnFBwmKCV3Jwr8RA36zE0OcmdM8g8TVLQ8TSiIXJhij3vqGH5Bn1caFnF1D7kXRpN3D9Z
 VtOeg/86/1FlQ0n0NJ8OMFlQvDmjCqvpYASO4Lvx6jhbCBsD+FzQhpFDcMfis7X0lxWSie5ccoL
 CMFUFpzE9N3EIOeRSufchGXbr4gR4bxAYbOZJoe2Zi8jOTJA4u7/CU9l/AGIguydAmLPu9zC+JT
 1IIwyu65FOD1kASxZHvj+/rLlKQKHbw0fVbsv5yJxM3lNDfQXc8bDmFGpZHER9k5l4r9yDG5
X-Proofpoint-GUID: K8qL-N5R6DvPTeyW6c6dsL_Ald-xt7tg
X-Proofpoint-ORIG-GUID: K8qL-N5R6DvPTeyW6c6dsL_Ald-xt7tg
X-Authority-Analysis: v=2.4 cv=M6hNKzws c=1 sm=1 tr=0 ts=682214b8 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=ACR0-UKafiCMSv5bU5kA:9
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 6ea8e9f..be132fa 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -9,6 +9,8 @@
 #include "hw/vfio/vfio-device.h"
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
+    cpr_save_fd(fdname, nr, fd);
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
index 1bca415..bfa72bc 100644
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
@@ -56,13 +57,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
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
@@ -70,6 +83,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
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
@@ -2937,6 +2960,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (vdev->vbasedev.cpr.reused) {
+        return;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -3004,6 +3032,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (vdev->vbasedev.cpr.reused) {
+        vdev->req_enabled = true;
+        return;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index e93600f..765e334 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -28,6 +28,7 @@ typedef struct VFIODeviceCPR {
 struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
+struct VFIOPCIDevice;
 
 bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
                                         Error **errp);
@@ -49,6 +50,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
 bool vfio_cpr_ram_discard_register_listener(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                             int nr, int fd);
+int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                            int nr);
+void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
+                               int nr);
+
 extern const VMStateDescription vfio_cpr_pci_vmstate;
 
 #endif /* HW_VFIO_VFIO_CPR_H */
-- 
1.8.3.1


