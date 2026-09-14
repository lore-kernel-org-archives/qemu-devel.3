Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4E2C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6AjK-0000ju-2f; Mon, 14 Sep 2026 13:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6AjG-0000ga-J6; Mon, 14 Sep 2026 13:44:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x6AjE-0007MV-9l; Mon, 14 Sep 2026 13:44:30 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EFvlFj2515010; Mon, 14 Sep 2026 17:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=VoiFPzGTXoQsb1RI2
 K4FeGGvbE+8UosSUEzV93xPnQY=; b=Tlxg9Xs303KqErIvboR7tioCJl0z/2d2I
 PdMFXxnlAZgs8zkM1O9qt8etc8ua2X/ohQpFLFLS1Gvwi/xHf8QIRgDAvwhsfMq4
 KucFrRLK7/iRrpAXGmUjogm4Bwa8l9foCKtIx7+Nm19it6rfzrsZs7Kp0UGOkMQG
 knP+beQaoPV7F3GEe4/iSxVDDUbiI1E2PhuqrUEvOFh2DF/zgwZaJHKPKvRBEBMw
 LMryqxDhkUawNzsoExkIm/QJMDz8frnP+JYAicgT6eAnrU6yuTe6hhMJL8UWEFrP
 FQAPSbFEfz8/Rc6GtmPVwJVuymvQA8/fVXD2ni4ING6hHZSWytuDQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcutu17-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:44:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EGYbOw2386827; Mon, 14 Sep 2026 17:44:24 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j76wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 17:44:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EHiNEM33686074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 17:44:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C55158055;
 Mon, 14 Sep 2026 17:44:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE6B58043;
 Mon, 14 Sep 2026 17:44:22 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.224])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 17:44:22 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v5 2/3] s390x/pci: Add PCI error handling for vfio pci devices
Date: Mon, 14 Sep 2026 10:44:19 -0700
Message-ID: <20260914174420.12309-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914174420.12309-1-alifm@linux.ibm.com>
References: <20260914174420.12309-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfX/lF/gJSWj7oD
 PPOBvLEGf3LFfCdYkX0rSO4VgZhLFjvk23WZC8wzud3umTBbO396E+GeT3509EHqFfM5+PDfush
 SL7ah3nqWQ4enHwtHOS8uLH6iykUNZI=
X-Proofpoint-ORIG-GUID: ysFkv3wZQrEl63ujeiG8DtGJIRA9hlJT
X-Proofpoint-GUID: ysFkv3wZQrEl63ujeiG8DtGJIRA9hlJT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0OCBTYWx0ZWRfXz7Sv5cBUAGjc
 egFegX9W9/km2UicfHr/0fpp0xOoOenCR06n6Gt6Onxlb4I2xacZGbgnNIBZ4xuvjViDZCMnLot
 sAOdJx+Wv+vuXy1zHbiP18F9zXYDTK9xRgHKRUPo4VdArNT+4tXr335W4JHzmQXK51iReD4vCEJ
 CplR1KIWOZAQusSnqbW6rdalLeTTF+CbZEiiQHP0JJh7Z3H2I6XBCPz74zTI47vcYuhzl78Tsga
 7UbcNnGHP3/JhO6+urjPKy42rEcCAfcZ14v6ftNM1HjbE7sz7OjHztEmbBzNfzSf0KaoG/Z9HQl
 Dlemz9vf2T/ft8YJrlDyLimQe5lOxhjj71TmaerLib6p0uBXbX4afm1A4iQOtAIFRUlGpVPXSCW
 I705h3rOZlHEw3kpaLi248Tvv98UPcLodE6CK3BIsAN09Cf4Zu19VIJG+YdcgFtymDehX+XphVu
 B1f5qrNY5/Me7ZyN5Yg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa83279 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Km_DOyaihBi-3fC5N0UA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140248
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

Add an s390x specific handler for vfio error notifier. For s390x pci devices,
we have platform specific error information. We need to retrieve this error
information for passthrough devices. This is done via a VFIO_DEVICE_FEATURE
ioctl which exposes that information.

Once this error information is retrieved we can then inject an error into
the guest, and let the guest drive the recovery.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |   6 ++
 hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
 hw/s390x/s390-pci-vfio.c         | 115 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   1 +
 include/hw/s390x/s390-pci-vfio.h |   1 +
 5 files changed, 129 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2eb4e8cec4..b2967dacba 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1085,6 +1085,7 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
     S390pciState *s = S390_PCI_HOST_BRIDGE(hotplug_dev);
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
+    Error *local_err = NULL;
     int rc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -1175,6 +1176,11 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
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
index db6de00bd2..6c072005fd 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -105,6 +106,85 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
     }
 }
 
+static bool s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
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
+        return false;
+    }
+
+    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
+
+    return true;
+}
+
+static void s390_pci_err_handler(void *opaque)
+{
+    VFIOPCIDevice *vfio_pci;
+    S390PCIBusDevice *pbdev;
+    Error *errp = NULL;
+    PciCcdfErr ccdf;
+    bool ret = true;
+
+    vfio_pci = opaque;
+    if (!event_notifier_test_and_clear(&vfio_pci->err_notifier)) {
+        return;
+    }
+
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
+                                        DEVICE(&vfio_pci->parent_obj)->id);
+
+    if (!pbdev) {
+        error_report("No matching zpci device found");
+        return;
+    }
+    pbdev->state = ZPCI_FS_ERROR;
+
+    if (sizeof(ccdf) != pbdev->ccdf_err_length) {
+        error_report(
+                   "CCDF size mismatch expected size=%zu, provided size=%d",
+                   sizeof(ccdf), pbdev->ccdf_err_length);
+        return;
+    }
+
+    while (ret) {
+        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
+                                       pbdev->ccdf_err_length, &errp);
+        if (!ret) {
+            if (errp) {
+                error_report_err(errp);
+            }
+            break;
+        }
+        s390_pci_generate_error_event(ccdf.pec, pbdev->fh, pbdev->fid,
+                                      ccdf.faddr, ccdf.e);
+    }
+
+    return;
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
@@ -134,6 +214,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     /* Store function type separately for type-specific behavior */
     pbdev->pft = cap->pft;
 
+    if (hdr->version >= 3) {
+        pbdev->ccdf_err_length = cap->ccdf_err_length;
+    }
+
     /*
      * If the device is a passthrough ISM device, disallow relaxed
      * translation.
@@ -371,3 +455,34 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
     s390_pci_read_util(pbdev, info);
     s390_pci_read_pfip(pbdev, info);
 }
+
+bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
+{
+    int ret;
+    int32_t fd;
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
+    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
+    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);
+
+    return true;
+}
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index 9228523ce8..c2348ede86 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -364,6 +364,7 @@ struct S390PCIBusDevice {
     bool forwarding_assist;
     bool aif;
     bool rtr_avail;
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


