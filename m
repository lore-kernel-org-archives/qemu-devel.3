Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975E8C5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 17:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP27n-0002ug-6F; Tue, 10 Jun 2025 12:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15P-0004UD-QP
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uP15M-0006CX-Ss
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:40:26 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXeBS031158;
 Tue, 10 Jun 2025 15:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=r2pXbiXAAzoUKPSA8Yg7xFLJfunsyYuz2vp8+4/kJ9s=; b=
 oYUCJWy/gyz/TOlFZVKwncOMbeyrzyhZ1QXv2Bpt7IXqAss426G3GdH5u8tse6HR
 t6GyxSU03ZXFuJeRTZoothuD5Gr8ag5qnDzmEQObZVkMY5LXlzuUP6wcb/mHR0Hf
 gvqz6KybihHxeAVVYGFVHZZ1ACaop5B/4EqLNez4M1aS20oRjxBi5Rzv4ZZHn8Sj
 +I1/mihL94KO3LWKRjDO57nu/hDBvq2x0jVyvUsuVywqjAeC6Lnji6HoIGYWQ8Wo
 1/82sYdsaqQltxUDq3pa8wNgPgd5Mn9iqrDuT6XCXw2A/uUP1u+Q8Yuk4gCLx3EV
 tF8AYYgnPrpSqRTZ2M5JWQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywvgs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55AEn3Eb003965; Tue, 10 Jun 2025 15:40:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 474bv8wbau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Jun 2025 15:40:20 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55AFdrfh028825;
 Tue, 10 Jun 2025 15:40:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 474bv8wak1-19; Tue, 10 Jun 2025 15:40:20 +0000
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
Subject: [PATCH V5 18/38] vfio-pci: preserve MSI
Date: Tue, 10 Jun 2025 08:39:31 -0700
Message-Id: <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684851e6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=iXcB1Mdy36yPJsoaOdUA:9 cc=ntf
 awl=host:14714
X-Proofpoint-ORIG-GUID: AHI7FU0aW5Fv9MzhI1iEctP59HEtFL7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyNiBTYWx0ZWRfX7dZzrhm3RvND
 tNceQdcZ3y/+Xz7vphBEo8XJCmAt4uODfQDutvmD+Gb+81YRwhuusYZLDn/ewybkQhkwErOYl7o
 H93mHBf4hsXwwBzB78uzTLwpDevJSt1uiLuNhDFRHGzsS3HpUbrHlY+A71fehGpf9PUOaRwJ1At
 XB6ObiOERc7EDkae6ivRMy91TZSab+MLunNVVR/eSEl6Q6lYoYrBFV/02FZ1LqnNtmcmIpskQHo
 N8tPlnC19g0SA/AESs/K+H9ZGRom6ja4vslKmkE9gK61hDC+gDPZW757H1OZEA/UHboU7c5jAXU
 paj3ev7IjvpAcF6nu2vNk+Uckm0NGt9cYw5jtDdxySA5Vmd171KZ6FXPFjx/hDl79oJlY7n2YXb
 P7pO4c3rAihK0+3pzxDZmzxkPxTS+rDxyaeFlnbc/qfWK8Fk2qSFXqWUsLr5lcXO6aklqwNK
X-Proofpoint-GUID: AHI7FU0aW5Fv9MzhI1iEctP59HEtFL7B
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

Save the MSI message area as part of vfio-pci vmstate, and preserve the
interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
then the vfio-pci post_load handler finds the eventfds in CPR state,
rebuilds vector data structures, and attaches the interrupts to the new
KVM instance.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.h              |  2 +
 include/hw/vfio/vfio-cpr.h |  8 ++++
 hw/vfio/cpr.c              | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.c              | 54 ++++++++++++++++++++++++--
 4 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 6e4840d..4d1203c 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -217,6 +217,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 8bf85b9..25e74ee 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -15,6 +15,7 @@
 struct VFIOContainer;
 struct VFIOContainerBase;
 struct VFIOGroup;
+struct VFIOPCIDevice;
 
 typedef struct VFIOContainerCPR {
     Error *blocker;
@@ -52,6 +53,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
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
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index fdbb58e..e467373 100644
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
+    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
+
+    for (i = 0; i < nr_vectors; i++) {
+        VFIOMSIVector *vector = &vdev->msi_vectors[i];
+
+        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
+        if (fd >= 0) {
+            vfio_pci_vector_init(vdev, i);
+            vfio_pci_msi_set_handler(vdev, i);
+        }
+
+        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
+            vfio_pci_add_kvm_msi_virq(vdev, vector, i, msix);
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
+    vfio_pci_commit_kvm_msi_virq_batch(vdev);
+
+    if (msix) {
+        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
+    }
+}
+
 /*
  * The kernel may change non-emulated config bits.  Exclude them from the
  * changed-bits check in get_pci_config_device.
@@ -58,13 +123,45 @@ static int vfio_cpr_pci_pre_load(void *opaque)
     return 0;
 }
 
+static int vfio_cpr_pci_post_load(void *opaque, int version_id)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int nr_vectors;
+
+    if (msix_enabled(pdev)) {
+        vfio_pci_msix_set_notifiers(vdev);
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
+static bool pci_msix_present(void *opaque, int version_id)
+{
+    PCIDevice *pdev = opaque;
+
+    return msix_present(pdev);
+}
+
 const VMStateDescription vfio_cpr_pci_vmstate = {
     .name = "vfio-cpr-pci",
     .version_id = 0,
     .minimum_version_id = 0,
     .pre_load = vfio_cpr_pci_pre_load,
+    .post_load = vfio_cpr_pci_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4cda6dc..b3dbb84 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "hw/vfio/vfio-cpr.h"
 #include "migration/vmstate.h"
 #include "migration/cpr.h"
 #include "qobject/qdict.h"
@@ -57,13 +58,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
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
@@ -71,6 +84,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
 static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
                                   const char *name, int nr)
 {
+    vfio_cpr_delete_vector_fd(vdev, name, nr);
     event_notifier_cleanup(e);
 }
 
@@ -394,6 +408,14 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
 
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
+{
+    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
+    int fd = event_notifier_get_fd(&vector->interrupt);
+
+    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
+}
+
 /*
  * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
  * fd to kernel.
@@ -580,6 +602,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
+    /*
+     * Ignore the callback from msix_set_vector_notifiers during resume.
+     * The necessary subset of these actions is called from
+     * vfio_cpr_claim_vectors during post load.
+     */
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
     trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
 
     vector = &vdev->msi_vectors[nr];
@@ -686,6 +717,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
     }
 }
 
+void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
+{
+    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
+                              vfio_msix_vector_release, NULL);
+}
+
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 {
     assert(!vdev->defer_kvm_irq_routing);
@@ -2962,6 +2999,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -3029,6 +3071,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (cpr_is_incoming()) {
+        vdev->req_enabled = true;
+        return;
+    }
+
     if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
                                        VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
-- 
1.8.3.1


