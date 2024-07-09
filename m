Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBB5C3DA45
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 21:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRHvn-00068l-9Y; Tue, 09 Jul 2024 16:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvl-00061B-C6
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sRHvV-0005Wr-Oi
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 16:59:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469KtqIa005249;
 Tue, 9 Jul 2024 20:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references; s=
 corp-2023-11-20; bh=4e0y9DLDxOxZNHEqrsO3p0WeiOFJaqMeEs/XFitVQ8Y=; b=
 e5ZsXFvQ9b6jhP4f3GDIMKijQynfqe+beavZpO18lIo+IouCnDHR28pnX9ZkNkjd
 krNnlnn/DLgMUiDWz6noLLyRvQ9SCtT9PrpfuENK2EfnbKAAfaPDAq4/t/t3WQJM
 t0jHFYHY2BTnRysQIBQr2/uXbovx9X95qBpQDARbAZVoKUWnnoF2hjVaXr8aRC+F
 Od6S22FjnRkVF+6R/a3IwyJKxx+KqB/aG98SjCIkqS3S4649iKvsVdorraq+nJeD
 tUdz0nxZhDlppNvth7FIJYuehOpB3C71LZNS3cOHoTUoYSMSfIMiLXRjVqhJKIjz
 HIU43DsQzcDz27vrGwVnOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknnym0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469KBpsL008641; Tue, 9 Jul 2024 20:59:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tve98se-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 20:59:02 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 469KwwD1012128;
 Tue, 9 Jul 2024 20:59:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 407tve98qa-6; Tue, 09 Jul 2024 20:59:01 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 5/8] vfio-pci: cpr part 2 (msi)
Date: Tue,  9 Jul 2024 13:58:54 -0700
Message-Id: <1720558737-451106-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
References: <1720558737-451106-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_09,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090143
X-Proofpoint-GUID: LCqB40SSsphv8mk3KEocqWa8mn0dmMMl
X-Proofpoint-ORIG-GUID: LCqB40SSsphv8mk3KEocqWa8mn0dmMMl
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Finish CPR for vfio-pci MSI/MSI-X devices by preserving eventfd's and
vector state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/pci.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2485236..f0213e0 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -56,11 +56,37 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
 
+#define EVENT_FD_NAME(vdev, name)   \
+    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
+
+static void save_event_fd(VFIOPCIDevice *vdev, const char *name, int nr,
+                          EventNotifier *ev)
+{
+    int fd = event_notifier_get_fd(ev);
+
+    if (fd >= 0) {
+        g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
+        cpr_resave_fd(fdname, nr, fd);
+    }
+}
+
+static int load_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
+{
+    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
+    return cpr_find_fd(fdname, nr);
+}
+
+static void delete_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
+{
+    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
+    cpr_delete_fd(fdname, nr);
+}
+
 /* Create new or reuse existing eventfd */
 static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
                               const char *name, int nr)
 {
-    int fd = -1;   /* placeholder until a subsequent patch */
+    int fd = load_event_fd(vdev, name, nr);
     int ret = 0;
 
     if (fd >= 0) {
@@ -71,6 +97,8 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
             Error *err = NULL;
             error_setg_errno(&err, -ret, "vfio_notifier_init %s failed", name);
             error_report_err(err);
+        } else {
+            save_event_fd(vdev, name, nr, e);
         }
     }
     return ret;
@@ -79,6 +107,7 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
 static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
                                   const char *name, int nr)
 {
+    delete_event_fd(vdev, name, nr);
     event_notifier_cleanup(e);
 }
 
@@ -561,6 +590,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     int ret;
     bool resizing = !!(vdev->nr_vectors < nr + 1);
 
+    /*
+     * Ignore the callback from msix_set_vector_notifiers during resume.
+     * The necessary subset of these actions is called from vfio_claim_vectors
+     * during post load.
+     */
+    if (vdev->vbasedev.reused) {
+        return 0;
+    }
+
     trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
 
     vector = &vdev->msi_vectors[nr];
@@ -2897,6 +2935,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->err_notifier);
     qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (vdev->vbasedev.reused) {
+        return;
+    }
+
     if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -2961,6 +3004,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
     fd = event_notifier_get_fd(&vdev->req_notifier);
     qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
 
+    /* Do not alter irq_signaling during vfio_realize for cpr */
+    if (vdev->vbasedev.reused) {
+        vdev->req_enabled = true;
+        return;
+    }
+
     if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
                                 VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
         error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
@@ -3454,6 +3503,46 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
 }
 #endif
 
+static void vfio_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors, bool msix)
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
+        fd = load_event_fd(vdev, "interrupt", i);
+        if (fd >= 0) {
+            vfio_vector_init(vdev, i);
+            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
+        }
+
+        if (load_event_fd(vdev, "kvm_interrupt", i) >= 0) {
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
@@ -3472,14 +3561,40 @@ static int vfio_pci_pre_load(void *opaque)
     return 0;
 }
 
+static int vfio_pci_post_load(void *opaque, int version_id)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int nr_vectors;
+
+    if (msix_enabled(pdev)) {
+        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
+                                   vfio_msix_vector_release, NULL);
+        nr_vectors = vdev->msix->entries;
+        vfio_claim_vectors(vdev, nr_vectors, true);
+
+    } else if (msi_enabled(pdev)) {
+        nr_vectors = msi_nr_vectors_allocated(pdev);
+        vfio_claim_vectors(vdev, nr_vectors, false);
+
+    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
+        g_assert_not_reached();      /* completed in a subsequent patch */
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vfio_pci_vmstate = {
     .name = "vfio-pci",
     .version_id = 0,
     .minimum_version_id = 0,
     .priority = MIG_PRI_VFIO_PCI,       /* must load before container */
     .pre_load = vfio_pci_pre_load,
+    .post_load = vfio_pci_post_load,
     .needed = cpr_needed_for_reuse,
     .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
1.8.3.1


