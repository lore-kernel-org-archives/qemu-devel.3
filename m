Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E337ACA5FFC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 17:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDmin-0001ML-TE; Mon, 05 Oct 2026 13:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDmij-0001Kg-4V; Mon, 05 Oct 2026 13:43:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xDmig-0007Xy-FW; Mon, 05 Oct 2026 13:43:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZbcU1276504; Mon, 5 Oct 2026 17:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=TLje78fEW1eM4RRDP
 weAwBsLLVyoQQgZHJF8jJnZoN4=; b=dJSqvPR77VA7UOeX9LmjE2Q1jrb8FjMNI
 /jnz/QMhbgRFXlSB5W1HKmOsIzOI98g9mqkDgDZOD5aeEYznqa+GF6Qf4JNFFDm9
 5zyZA/47dnPxVGsGBHIVZboird1n9/VMZOCoeR7c4e04DfOwOx6W5bqKTBsgWlwP
 5PM/Fw+m/VDWLHb5BKc2Io6qKAxjVNLO6ie+ps/8iMuU2r1BvaFGvcCkj8NlFHVr
 0NxR77qZ3M22DZgT3JStgvJdcepN4xD2r7fKFGFse3Tc8t3F5ZHmEVUdFPHQVMhb
 A+obPwAytysdoZeVWljj4Aei8kVpsEexWRPnzZSlh08hA0lWGmDsA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbv2u9n-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 17:43:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HN2Ol3214862; Mon, 5 Oct 2026 17:43:18 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jpffu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 17:43:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695HhGsu59179362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 17:43:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B336558056;
 Mon,  5 Oct 2026 17:43:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 02CE35803F;
 Mon,  5 Oct 2026 17:43:16 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.223])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 17:43:15 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
Subject: [PATCH v7 1/2] s390x/pci: Add PCI error handling for vfio pci devices
Date: Mon,  5 Oct 2026 10:43:13 -0700
Message-ID: <20261005174314.871-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005174314.871-1-alifm@linux.ibm.com>
References: <20261005174314.871-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 70LhK2NTUUmgQ0xtAcPwjXykcZGhDRTN
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac3e1b6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Km_DOyaihBi-3fC5N0UA:9
X-Proofpoint-GUID: 70LhK2NTUUmgQ0xtAcPwjXykcZGhDRTN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX8l3SACSs2LLA
 kZkDYFv6bXbAnWE9QTItRNiojuvzIAiOHsgzKojwr6Pf5ZPbl5d33P9MOB0EdxuSfey3/kq4Md7
 E1f1h8pL+nMR7LA0xDsAaJEeXU8gcwq9Ht6m+LmJQ8DRsV8hHogzjRJrBX8nzy3qFMrCMWgmP1Q
 6wsMlFzTd99t61sc4ldXB8V9xIP/jwQHr8eU0a3ufjgz4kOo6izfdznawpiEdc6ZqnT5Fh6mB+H
 ZoHAyNymnvYxioAtRryjetomp/4nNOAPeDLF/Yh0ZQ63k9DLnG7BQlmZ6s3YtUY8VSVgxm3z3h2
 UHhVXCoPccZlmZCrZDzLLcFjJgjg2CcmHmQhu9pllmx731qX4x79g1NRWNqMAPKLGO/vosIyHQM
 rMq8pSangb8mZj7WvM+hJz/jxRxVjyChAuKKpEA6sNCim7II/Mc4vGKjJxRST+MxhhFj1EXG4qB
 E5K2CuSD3Mmn9hgougw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2OSBTYWx0ZWRfX6GDRgRyZBrIO
 5A0or3JXfNGfTYwzHZk6xtZmGaUek+zR5IvyLo3Fm4LaL1tM2bDGAxbXZ5LGju4Vp3Ti2Dl197P
 59e8vcNmPPNN8AUgPsLsEsgXC2DrOog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050069
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
 hw/s390x/s390-pci-vfio.c         | 123 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   1 +
 include/hw/s390x/s390-pci-vfio.h |   1 +
 5 files changed, 137 insertions(+)

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
index db6de00bd2..0153faae86 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -105,6 +106,80 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
     }
 }
 
+static int s390_pci_get_feature_err(VFIOPCIDevice *vfio_pci,
+                                    PciCcdfErr *ccdf,
+                                    uint32_t ccdf_err_length,
+                                    Error **errp)
+{
+    ERRP_GUARD();
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
+        if (ret == -ENOMSG) {
+            return 0;
+        }
+        error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
+                   " (rc=%d)", ret);
+        return ret;
+    }
+
+    memcpy(ccdf, buf, ccdf_err_length);
+
+    return 1;
+}
+
+static void s390_pci_err_handler(void *opaque)
+{
+    VFIOPCIDevice *vfio_pci;
+    S390PCIBusDevice *pbdev;
+    Error *local_err = NULL;
+    PciCcdfErr ccdf;
+    int ret = 0;
+
+    vfio_pci = opaque;
+    if (!event_notifier_test_and_clear(&vfio_pci->err_notifier)) {
+        return;
+    }
+
+    pbdev = s390_pci_find_dev_by_pci(s390_get_phb(), PCI_DEVICE(vfio_pci));
+
+    if (!pbdev) {
+        error_report("No matching zpci device found");
+        return;
+    }
+    pbdev->state = ZPCI_FS_ERROR;
+
+    do {
+        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
+                                       pbdev->ccdf_err_length, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            break;
+        }
+
+        if (ret > 0) {
+            s390_pci_generate_error_event(ccdf.pec, pbdev->fh, pbdev->fid,
+                                          ccdf.faddr, ccdf.e);
+        }
+    } while (ret > 0);
+
+    return;
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
@@ -134,6 +209,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     /* Store function type separately for type-specific behavior */
     pbdev->pft = cap->pft;
 
+    if (hdr->version >= 3) {
+        pbdev->ccdf_err_length = cap->ccdf_err_length;
+    }
+
     /*
      * If the device is a passthrough ISM device, disallow relaxed
      * translation.
@@ -371,3 +450,47 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
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
+    if (sizeof(PciCcdfErr) != pbdev->ccdf_err_length) {
+        error_setg(errp,
+                   "CCDF size mismatch expected size=%zu, provided size=%d",
+                   sizeof(PciCcdfErr), pbdev->ccdf_err_length);
+        return false;
+    }
+
+    if (!vfio_pci->pci_aer) {
+        error_setg(errp, "%s: VFIO error notifier not registered for device",
+                   vfio_pci->vbasedev.name);
+        return false;
+    }
+
+    fd = event_notifier_get_fd(&vfio_pci->err_notifier);
+    qemu_set_fd_handler(fd, s390_pci_err_handler, NULL, vfio_pci);
+
+    return true;
+}
diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
index f182bab246..63cf2b7222 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -365,6 +365,7 @@ struct S390PCIBusDevice {
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


