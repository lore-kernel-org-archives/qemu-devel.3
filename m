Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D846C624D1
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16nh-0001dh-3O; Mon, 31 Aug 2026 14:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nb-0001cG-0z; Mon, 31 Aug 2026 14:32:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nY-0001wH-K4; Mon, 31 Aug 2026 14:32:02 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVxs81980108; Mon, 31 Aug 2026 18:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=a9Arze5iRwo+C5SL9
 9cTLockKmhjtLYgL/RESUvGOCQ=; b=AuAmD+fHJgwmlqf6Jn4stglbYABw64sUP
 vvChzDtc9uqyeMQ8eXieEuzNzBQHkj4A9Y62HvejFi5dcyEF1GQ3f4swwZM7GuVn
 ii+HzQa1V12s3idTavMb5NlYb6rYxWNNcEZx2NaNKtSYmnPcIXVg8h88/jVxdJ6O
 S3jdqIZVNIBefj5kscUYm3aPQlCEfOPi7d2jC3xV2CY2RwNh/eQfwmVtSHbClahv
 kpSrdSWAz7i0H18YEUnD7xaaMwpBRnpsGEsB6ztKuCnRk5c1aLYoi+lFkbRQuRMb
 +9z3/tMA8fa5ERdBoIdjioyQiJ7uYXrcuKudZZlNDuMAbSKAPDDlg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudk4da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIUAWG022182;
 Mon, 31 Aug 2026 18:31:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h7cpq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VIVuwT10158802
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 18:31:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7E065805D;
 Mon, 31 Aug 2026 18:31:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2B1758054;
 Mon, 31 Aug 2026 18:31:55 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.20])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 18:31:55 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v4 3/4] s390x/pci: Add PCI error handling for vfio pci devices
Date: Mon, 31 Aug 2026 11:31:50 -0700
Message-ID: <20260831183151.12626-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831183151.12626-1-alifm@linux.ibm.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: knLriJ0mGNvlEvGK9QPWkBKZhjHyzYnq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX8Ub2SMU6Fiai
 LokgkLbmw+GyfmfRKWE8+5AeRanBqDFD9Tov4pzNXT+2vlx6m6RIYQuMkyHN4vh9ihB7IZY1fPU
 c8VazKkNN6ZbzlskV1t5Z5WyGLSp2555x/fY5QYUcAQVPDYBBCGHUU8x8tzc/oJy+KKidCir4eB
 w1uOX9AhcDjLVec2JMEURMkhhvEWnleRXcNkLen8hm2wb2mM19rnossoQ/J8BEkdxPy1Y2va0kr
 i6DVzpRkpYpccctH+OAoxYwzzSR9tAfN9shsTsjrNL1YScQDFiobkZmxtmCgRmpr1Seye4N3i3N
 hxiN5SoCVhRPqcWluTiSIJZG/riJq0R6MDBY2bMqgDshAZ8au5QyVQt259KBzFQpqd8PI0iLs5g
 ctL0szh4VfvGU/39huvKgonLGEua42p403s5sHvxHR0BEuMEeotIMr//vzuozcO1nUUCiZMYpmJ
 +46kEGtS/Tsx1BO3tPg==
X-Proofpoint-ORIG-GUID: knLriJ0mGNvlEvGK9QPWkBKZhjHyzYnq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX7N3W5jNwrbwG
 WIO6hBXgdbDHS7WJOA+Lh/9IxiIOO+K9woAVUTpTtdbFlMNqrxXdTLO27TxtYOan/rDiQ6HR1GK
 G5ZCN5syfVJlhcKJ0hmcamPO1kMOVrU=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a95c89f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Q7jWXzcZPd0Yemqux3YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
information for passthrough devices. This is done via a VFIO_DEVICE_FEATURE
ioctl which exposes that information.

Once this error information is retrieved we can then inject an error into
the guest, and let the guest drive the recovery.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |   9 +++
 hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
 hw/s390x/s390-pci-vfio.c         | 100 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   2 +
 include/hw/s390x/s390-pci-vfio.h |   1 +
 5 files changed, 118 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 9ecf3c30ad..b2db7f3df4 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -160,6 +160,8 @@ static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
 {
     HotplugHandler *hotplug_ctrl;
 
+    qemu_mutex_destroy(&pbdev->err_handler_lock);
+
     if (pbdev->pft == ZPCI_PFT_ISM) {
         notifier_remove(&pbdev->shutdown_notifier);
     }
@@ -1123,6 +1125,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
+    Error *local_err = NULL;
     int rc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -1189,6 +1192,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
         set_pbdev_info(pbdev);
+        qemu_mutex_init(&pbdev->err_handler_lock);
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             /*
@@ -1213,6 +1217,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
index d9882b7aad..9fc84ca135 100644
--- a/hw/s390x/s390-pci-vfio-stubs.c
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -30,3 +30,9 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
 {
 }
+
+bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
+{
+    error_setg(errp, "VFIO not available, cannot setup error handler");
+    return false;
+}
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index db6de00bd2..9a63040e22 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -105,6 +105,73 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
     }
 }
 
+static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
+                                    PciCcdfErr *ccdf,
+                                    uint32_t ccdf_err_length,
+                                    Error **errp)
+{
+    int ret;
+    size_t total_size;
+    struct vfio_device_feature_zpci_err *err;
+    g_autofree void *buf = NULL;
+    g_autofree struct vfio_device_feature *feature = NULL;
+
+    total_size = sizeof(*feature) + sizeof(*err);
+    feature = g_malloc(total_size);
+    feature->argsz = total_size;
+    feature->flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
+
+    buf = g_malloc(ccdf_err_length);
+    err = (void *)feature->data;
+    err->data = (uint64_t)buf;
+    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
+
+    if (ret) {
+        if (ret != -ENOMSG) {
+            error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
+                              " (rc=%d)", ret);
+        }
+        return ret;
+    }
+
+    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
+
+    return 0;
+}
+
+static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
+{
+    S390PCIBusDevice *pbdev;
+    PciCcdfErr ccdf;
+    bool success = false;
+    int ret = 0;
+
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
+                                        DEVICE(&vfio_pci->parent_obj)->id);
+
+    QEMU_LOCK_GUARD(&pbdev->err_handler_lock);
+    pbdev->state = ZPCI_FS_ERROR;
+
+    if (sizeof(ccdf) != pbdev->ccdf_err_length) {
+        error_setg(errp,
+                   "CCDF size mismatch expected size=%zu, provided size=%d",
+                   sizeof(ccdf), pbdev->ccdf_err_length);
+        return false;
+    }
+
+    while (ret == 0) {
+        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
+                                       pbdev->ccdf_err_length, errp);
+        if (ret) {
+            success = ret == -ENOMSG ? true : false;
+            break;
+        }
+        s390_pci_generate_error_event(ccdf.pec, pbdev->fh, pbdev->fid, 0, 0);
+    }
+
+    return success;
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
@@ -134,6 +201,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     /* Store function type separately for type-specific behavior */
     pbdev->pft = cap->pft;
 
+    if (hdr->version >= 3) {
+        pbdev->ccdf_err_length = cap->ccdf_err_length;
+    }
+
     /*
      * If the device is a passthrough ISM device, disallow relaxed
      * translation.
@@ -371,3 +442,32 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
     s390_pci_read_util(pbdev, info);
     s390_pci_read_pfip(pbdev, info);
 }
+
+bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
+{
+    int ret;
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
+    uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
+                              sizeof(uint64_t))] = {};
+    struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
+
+    feature->argsz = sizeof(buf);
+    feature->flags = VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_ZPCI_ERROR;
+
+    ret = vfio_device_get_feature(&vfio_pci->vbasedev, feature);
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
index 9228523ce8..bc67f7e065 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -364,6 +364,8 @@ struct S390PCIBusDevice {
     bool forwarding_assist;
     bool aif;
     bool rtr_avail;
+    QemuMutex err_handler_lock;
+    uint32_t ccdf_err_length;
     QTAILQ_ENTRY(S390PCIBusDevice) link;
 };
 
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index f7d6149daf..c7886b63ea 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -20,5 +20,6 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
+bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
 
 #endif
-- 
2.43.0


