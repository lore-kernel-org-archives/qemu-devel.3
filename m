Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEB8CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1q66-00047Q-0X; Thu, 25 Sep 2025 13:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5i-0003vI-57; Thu, 25 Sep 2025 13:49:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5a-0008LN-4J; Thu, 25 Sep 2025 13:49:13 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCaS88010177;
 Thu, 25 Sep 2025 17:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NTte2WvaMIGjBsVte
 czkP++aZriznHgVIWSU6Q4J+wA=; b=Lq4vTkehTHaGGjyzO2VvKgg/UDiOAHduq
 zWk9jocbN5KaAkPgMVYzrrRCO8Naox5nH9Td1jYKBcCxDVfH0/c/4gwRZ+Q2PFuc
 x7ZvlnEUI8KtzvdrqImi461v0ou+h5aJABN50duOUNFCrJ2V9O4CpxMl6uEes7/V
 v1duNJz+x76FEB9mmh03i+gg/bxO6vQAyfWDzhOY4wwZ3HiXx8vv8gTU72XUmkSA
 ky9pbD6O4H7bGPMpsce5xgG/pWe5QVLLZD/BIB8E0nuPYU6djS2Vk6iAHbInMoZP
 1Q5m1+nBWwpfs6/NrEPSD2fIlNsVj+dhgBv9otVLdqvj/r6JZZndw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksc7jag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:49:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHUBCA030345;
 Thu, 25 Sep 2025 17:48:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1f28p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHmk2Y53543366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:48:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01B4958059;
 Thu, 25 Sep 2025 17:48:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64D0A5805D;
 Thu, 25 Sep 2025 17:48:56 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.202])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:48:56 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v3 4/5] s390x/pci: Add PCI error handling for vfio pci devices
Date: Thu, 25 Sep 2025 10:48:51 -0700
Message-ID: <20250925174852.1302-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925174852.1302-1-alifm@linux.ibm.com>
References: <20250925174852.1302-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 86BdgjFMZNxAmKWqnI_ufGKA55tXkRyt
X-Proofpoint-GUID: 86BdgjFMZNxAmKWqnI_ufGKA55tXkRyt
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d5808c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=Q7jWXzcZPd0Yemqux3YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfX4HHUCuHFJ/D/
 1jjaM0I7+2oFfX9T7GTn5gXsYUBGEf/1FGbKQkQCer4HcMqXraY5/cyn1os/kT3qsaU8ECTvz8P
 +WTYge10G2uRuRpZZCC3sKhIEZgyhM/1EdlqbCztHjd6W8xJ/umvRqV8/d478SFyzV8dDzgibgw
 TVC+/ccDpAMFK3QqcX3z0Wzg6RO8wlagRMrYh4VoeUuUCSVxbqJ68xmdm6qUL0UpokdoYXnbf36
 vOOyKQ9cbOMfZuf/1pNd30Nw3peU1F7IM7XM7CsH7P1OQAVs9rQ/Djf59tmpO5XRgfBIKBEs/dx
 QmMPkTQFoETA+/wgSeYEfB+IhFVJdi2b48ws5DTFK7BCvk9dL8/RMP3S7tolVKjpDfQ1W4az4W6
 qDwBGN9z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add an s390x specific callback for vfio error handling. For s390x pci devices,
we have platform specific error information. We need to retrieve this error
information for passthrough devices. This is done via a memory region which
exposes that information.

Once this error information is retrieved we can then inject an error into
the guest, and let the guest drive the recovery.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |  9 ++++
 hw/s390x/s390-pci-vfio.c         | 81 ++++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |  1 +
 include/hw/s390x/s390-pci-vfio.h |  6 +++
 4 files changed, 97 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index f87d2748b6..9f7b17e807 100644
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
@@ -1074,6 +1076,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
+    Error *local_err = NULL;
     int rc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -1140,6 +1143,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
         set_pbdev_info(pbdev);
+        qemu_mutex_init(&pbdev->err_handler_lock);
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             /*
@@ -1164,6 +1168,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             pbdev->iommu->dma_limit = s390_pci_start_dma_count(s, pbdev);
             /* Fill in CLP information passed via the vfio region */
             s390_pci_get_clp_info(pbdev);
+            /* Setup error handler for error recovery */
+            if (!s390_pci_setup_err_handler(pbdev, &local_err)) {
+                warn_report_err(local_err);
+            }
+
             if (!pbdev->interp) {
                 /* Do vfio passthrough but intercept for I/O */
                 pbdev->fh |= FH_SHM_VFIO;
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 938a551171..1697a84de7 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -103,6 +103,58 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
     }
 }
 
+static bool s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
+                                    struct vfio_device_feature_zpci_err *err,
+                                    Error **errp)
+{
+    int ret;
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature) +
+                              sizeof(struct vfio_device_feature_zpci_err),
+                              sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+
+    feature->argsz = sizeof(buf);
+    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
+    ret = vfio_device_feature(&vfio_pci->vbasedev, feature);
+
+    if (ret) {
+        error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
+                    " (rc=%d)", ret);
+        return false;
+    }
+
+    memcpy(err, (struct vfio_device_feature_zpci_err *) feature->data,
+           sizeof(struct vfio_device_feature_zpci_err));
+
+    return true;
+}
+
+static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
+{
+    S390PCIBusDevice *pbdev;
+    struct vfio_device_feature_zpci_err err;
+
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
+                                        DEVICE(&vfio_pci->parent_obj)->id);
+
+    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
+
+    if (!s390_pci_get_feature_err(vfio_pci, &err, errp)) {
+        return false;
+    }
+
+    pbdev->state = ZPCI_FS_ERROR;
+    s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 0);
+
+    while (err.pending_errors) {
+        if (!s390_pci_get_feature_err(vfio_pci, &err, errp)) {
+            return false;
+        }
+        s390_pci_generate_error_event(err.pec, pbdev->fh, pbdev->fid, 0, 0);
+    }
+    return true;
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
@@ -369,3 +421,32 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
     s390_pci_read_util(pbdev, info);
     s390_pci_read_pfip(pbdev, info);
 }
+
+bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
+{
+    int ret;
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
+                              sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+
+    feature->argsz = sizeof(buf);
+    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
+
+    ret = vfio_device_feature(&vfio_pci->vbasedev, feature);
+
+    if (ret != 0) {
+        if (ret == -ENOTTY) {
+            error_setg(errp, "Automated error recovery unavailable for device");
+        } else {
+            error_setg(errp,
+                       "Failed to probe for VFIO_DEVICE_FEATURE_ZPCI_ERROR (ret=%d)",
+                       ret);
+        }
+        return false;
+    }
+
+    vfio_pci->err_handler = s390_pci_err_handler;
+
+    return true;
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
index ae1b126ff7..b45ffa5044 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -22,6 +22,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
+bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
 #else
 static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
 {
@@ -39,6 +40,11 @@ static inline bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
     return false;
 }
 static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
+static inline bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
+{
+    error_setg(errp, "VFIO not available, cannot setup error handler\n");
+    return false;
+}
 #endif
 
 #endif
-- 
2.43.0


