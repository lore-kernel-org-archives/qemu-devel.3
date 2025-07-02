Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51B5C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 22:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX5U2-0003R8-GJ; Wed, 02 Jul 2025 17:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tz-0003Oh-Gv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uX5Tt-0003dm-U0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:59:11 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562LQdeW014113;
 Wed, 2 Jul 2025 21:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=JPHCbxHydtgJ2VLb7jtXe+LiVmTDIuYkU/OCsnBZUVk=; b=
 bFGnlZJzFGJ/CK9VR5GQHiVtRO0iITXia7pYpQEV9XLop5GKvM/eKfMO+wt54iW9
 NgBMGhTItX/7dVSYfD8rAZ9gOKYsmSmGA/7edaCQIV9ssJPg+4QnenFvixMFXMYj
 0+znRhD5HdkTH/6zO4KhBdEW0miSkeuz6Uxk8ZPS5z5MbDqs2vBMjxd9nzY/8Zu+
 Cc8WrmvFFyKbKrHZ5IHPT4ic6Qy2Bla46UksMx1i3Ovew6aRabbt3veg8Os9VCzV
 u2KJA0iNwztDpgK6kXEdtSYCRVgj3NoBjd/JhiXbUUXF/F8aJgHModRp9mKTy0XT
 oR56U/4UyLqp7JeBeG3frw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704fxkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:01 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 562LoTdw033766; Wed, 2 Jul 2025 21:59:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47j6ubtcyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Jul 2025 21:59:01 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 562Lwxfu020012;
 Wed, 2 Jul 2025 21:59:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47j6ubtcxb-2; Wed, 02 Jul 2025 21:59:00 +0000
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
Subject: [PATCH V6 01/21] vfio-pci: preserve MSI
Date: Wed,  2 Jul 2025 14:58:38 -0700
Message-Id: <1751493538-202042-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDE4MiBTYWx0ZWRfX3P+qMoh4w4qc
 +CtBagxVFVl9N/zhevENA14L3ySg1U8sQquTutISJBrBQ3yDZuI8Nyg5rZWvJezSRWjFIXhTGXZ
 z+TZKZQcxUkNv9ApdGxm6wmpQK/kuIxQTMfBPRypQNoEKgKiUgsb3Vp8RJbWDv523pQaar+Ssxj
 8JP14YUoes0Q9FULt/7Od1Jnc8PDaXHpXpDqXydi+ATpw1VZnbMXJ1AOk5Um7exazNbOsgEw+wp
 c1B5OXb2XT06XQJSciKKjx5cF+fq8v9h931v4tMbhrTcjyfzJhGoolAJXxsNv038qlYgISEi8/V
 fQeuY+hLLu/UHcnPEltgqUaNtLQVRPuQQqxEhwIdy/sJ8uMloJ05jBTR3xarR1C7YLz/8NtVI6J
 AFIumrGydGWXh6MmDdaEAE8Vb/4Nq4CYXZn9rhAkkE21gr+PYbEruIGBRSMXmiu7g4Xa3eDY
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6865aba5 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=iXcB1Mdy36yPJsoaOdUA:9
X-Proofpoint-GUID: wJQzYpTDVPTlQgfp5XSyMYy7Uf4Ymc3p
X-Proofpoint-ORIG-GUID: wJQzYpTDVPTlQgfp5XSyMYy7Uf4Ymc3p
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 hw/vfio/pci.c              | 52 ++++++++++++++++++++++++-
 4 files changed, 157 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ba7330..495fae7 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
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
index fa25bde..5f9f264 100644
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
@@ -57,20 +58,33 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+/* Create new or reuse existing eventfd */
 static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
                                const char *name, int nr, Error **errp)
 {
-    int ret = event_notifier_init(e, 0);
+    int fd, ret;
 
+    fd = vfio_cpr_load_vector_fd(vdev, name, nr);
+    if (fd >= 0) {
+        event_notifier_init_fd(e, fd);
+        return true;
+    }
+
+    ret = event_notifier_init(e, 0);
     if (ret) {
         error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
+        return false;
     }
-    return !ret;
+
+    fd = event_notifier_get_fd(e);
+    vfio_cpr_save_vector_fd(vdev, name, nr, fd);
+    return true;
 }
 
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
@@ -656,6 +678,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
 static int vfio_msix_vector_use(PCIDevice *pdev,
                                 unsigned int nr, MSIMessage msg)
 {
+    /*
+     * Ignore the callback from msix_set_vector_notifiers during resume.
+     * The necessary subset of these actions is called from
+     * vfio_cpr_claim_vectors during post load.
+     */
+    if (cpr_is_incoming()) {
+        return 0;
+    }
+
     return vfio_msix_vector_do_use(pdev, nr, &msg, vfio_msi_interrupt);
 }
 
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
@@ -2965,6 +3002,11 @@ void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
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
@@ -3032,6 +3074,12 @@ void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
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


