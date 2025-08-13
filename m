Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A52C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umFUJ-0003wf-1c; Wed, 13 Aug 2025 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUE-0003uf-Fv; Wed, 13 Aug 2025 13:42:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUB-0006Zx-Jx; Wed, 13 Aug 2025 13:42:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBZ5Uj025676;
 Wed, 13 Aug 2025 17:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=QZla6X8ncR2XNnKnb
 A92sFJoa3p4OKGXOP85ivV1B8Y=; b=sSE4C2E98vSP3PwubjLkd63YMs1Q8bDrG
 DRvfvd8SN93gvleUxpv+eFfbfZMVNXKp9ZBCRWS1+58MtjrragP7WrjBoDGxT29x
 MmufuhqaMEr/H2p+CIYKZXBIEjB8syPmMmqZ4GjempvMWjTaXKDLrdE2UcALdEif
 FuWLlMbRKz7F4CJLIHinJD+CYhlVXDd8IXY6L00xzGKTv8GM1QtoKbRKCUOg/9N5
 NJzXL5sn6H28VPsxYkiUw6G3n/fk/zOCm9T4YLuAxD4Szh17s2ztdcPbqlOySu6g
 PZAElBfO0bQFwAwSBj1KTs4VO4ot+kkwQDmkDWmNEzrPDqgFkaaYQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaaa59x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DGNZDh025628;
 Wed, 13 Aug 2025 17:41:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmg77p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57DHftKh35324370
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 17:41:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BA6C5805E;
 Wed, 13 Aug 2025 17:41:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC9335805A;
 Wed, 13 Aug 2025 17:41:54 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.61])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Aug 2025 17:41:54 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, alifm@linux.ibm.com
Subject: [PATCH v1 3/4] s390x/pci: Add PCI error handling for vfio pci devices
Date: Wed, 13 Aug 2025 10:41:50 -0700
Message-ID: <20250813174152.1238-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813174152.1238-1-alifm@linux.ibm.com>
References: <20250813174152.1238-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689cce66 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=jSCLr9NRB7a5bD1T82IA:9
X-Proofpoint-ORIG-GUID: hMhGZDT-KMItolRM8y46Pynv_wI8VIxW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX2pAl4eqD6vRd
 0fYtqVYto4CfCbx8Ggh6kdpVcfpKbUiVOAsOjq+aoViWYwzFzNLu6v8CYfzcoOy3M5mdTmdPMqi
 5bWrPtqmCLTZTIpRgMCofgg91M4z44fOiMgdNtWepADgrLUwwYF/chlIiR6Bnr8qVojdJMusd6y
 on2zoIXCkR0MnRje+MoXJm7mwfWMvLMTn2vQx+z1NDSzWfKRjaUW3MHNAHKP5oLfndanvCorCtY
 pttrwMF51SMIvajAx1R1EW7EMzpMz/13VJavi8tbVAcrkEF9N/B97PVicKO91lcktni2PozQQ1F
 2Kb+ahr4CApa9QlMAHb0Cy8te7B2qedj2PC91goX1SXo7wp143KvqtKO3pWFJnspqPnDkJOmCvD
 L3H+lnU4
X-Proofpoint-GUID: hMhGZDT-KMItolRM8y46Pynv_wI8VIxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an s390x specific callback for vfio error handling.
For s390x pci devices, we have platform specific error
information. We need to retrieve this error information
for passthrough devices. This is done via a memory region
which exposes that information.

Once this error information is retrieved we can then
inject an error into the guest, and let the guest drive
the recovery.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |  5 ++
 hw/s390x/s390-pci-vfio.c         | 82 ++++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |  1 +
 include/hw/s390x/s390-pci-vfio.h |  2 +
 4 files changed, 90 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f87d2748b6..af42eb9938 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -158,6 +158,8 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
 {
     HotplugHandler *hotplug_ctrl;
 
+    qemu_mutex_destroy(&pbdev->err_handler_lock);
+
     if (pbdev->pft == ZPCI_PFT_ISM) {
         notifier_remove(&pbdev->shutdown_notifier);
     }
@@ -1140,6 +1142,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
         set_pbdev_info(pbdev);
+        qemu_mutex_init(&pbdev->err_handler_lock);
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             /*
@@ -1164,6 +1167,8 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
+            /* Setup error handler for error recovery */
+            s390_pci_setup_err_handler(pbdev);
             if (!pbdev->interp) {
                 /* Do vfio passthrough but intercept for I/O */
                 pbdev->fh |= FH_SHM_VFIO;
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index aaf91319b4..ceee342f4a 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -103,6 +104,70 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
     }
 }
 
+static int s390_pci_read_error_region(VFIOPCIDevice *vfio_pci,
+                                      struct vfio_device_zpci_err_region *err)
+{
+    struct vfio_region_info *region = NULL;
+    g_autofree void *buf;
+    int ret;
+
+    ret = vfio_device_get_region_info_type(&vfio_pci->vbasedev,
+                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_IBM,
+                    VFIO_REGION_SUBTYPE_IBM_ZPCI_ERROR_REGION, &region);
+
+    if (ret) {
+        error_report("Failed to get the region info for passthrough device"
+                    " (rc=%d)", ret);
+        return ret;
+    }
+
+    buf = g_malloc0(region->size);
+
+    if (!buf) {
+        error_report("Failed to allocate memory for error region");
+        return -ENOMEM;
+    }
+
+    ret = pread(vfio_pci->vbasedev.fd, buf, region->size, region->offset);
+    if (ret != region->size) {
+        error_report("Failed to read vfio zpci error region");
+        return -EINVAL;
+    }
+
+    memcpy(err, (struct vfio_device_zpci_err_region *) buf,
+            sizeof(struct vfio_device_zpci_err_region));
+    return 0;
+}
+
+static void s390_pci_err_handler(VFIOPCIDevice *vfio_pci)
+{
+    S390PCIBusDevice *pbdev;
+    struct vfio_device_zpci_err_region err;
+    int ret;
+
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
+                                        DEVICE(&vfio_pci->pdev)->id);
+
+    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
+
+    ret = s390_pci_read_error_region(vfio_pci, &err);
+    if (ret) {
+        return;
+    }
+
+    pbdev->state = ZPCI_FS_ERROR;
+    s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 0);
+
+    while (err.pending_errors) {
+        ret = s390_pci_read_error_region(vfio_pci, &err);
+        if (ret) {
+            return;
+        }
+        s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 0);
+    }
+    return;
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
@@ -369,3 +434,20 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
     s390_pci_read_util(pbdev, info);
     s390_pci_read_pfip(pbdev, info);
 }
+
+void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev)
+{
+    int ret;
+    struct vfio_region_info *region = NULL;
+    VFIOPCIDevice *vdev =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+
+    ret = vfio_device_get_region_info_type(&vdev->vbasedev,
+                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_IBM,
+                    VFIO_REGION_SUBTYPE_IBM_ZPCI_ERROR_REGION, &region);
+
+    if (ret) {
+        info_report("Automated error recovery not available for passthrough device");
+        return;
+    }
+    vdev->arch_err_handler = s390_pci_err_handler;
+}
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 04944d4fed..3795e0bbfc 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -364,6 +364,7 @@ struct S390PCIBusDevice {
     bool forwarding_assist;
     bool aif;
     bool rtr_avail;
+    QemuMutex err_handler_lock;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index ae1b126ff7..66b274293c 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -22,6 +22,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
+void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev);
 #else
 static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
 {
@@ -39,6 +40,7 @@ static inline bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
     return false;
 }
 static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
+static inline void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev) { }
 #endif
 
 #endif
-- 
2.43.0


