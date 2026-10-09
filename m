Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710F3CA9EC1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:34:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFL7-0000iK-He; Fri, 09 Oct 2026 14:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKw-0000ZT-SZ; Fri, 09 Oct 2026 14:28:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xFFKv-0001ht-0F; Fri, 09 Oct 2026 14:28:54 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699Ha6713714773; Fri, 9 Oct 2026 18:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mkwH2saz8NPQ/D7fk
 r2AW/RWG2C8lvvyhfMKM9YrfFM=; b=isNxU5xMdUVvpOb+IcdsJ9Bavu9/S/+ug
 0JOoQiFm45hj8GT71OykfkCEMN9k9L6GxQC9skmORcZb27y/mxrFjeMdzE0NAPf9
 PQ99fOjbOkoCmH56idEdWnYgYuk2T3/LsmaW05kp6Kdmfc3ZomJMst9voiT0V7ms
 wcdsbPTmM2ykjZXw3bnug2+BK+m2+0BebImhL2Jpw4m8oxzxXf+nqj6x9ZEPkiYx
 REc+MYhES0I9pjPKC9cGswNKiSyWBwfc+NLhGZlf4XLDs/lVhE21pRIFh9ZJeKtG
 PtpRpcQSr+Tr2YyUpPZ5M/8yY39mOvpQiJYXAGdFVa49XUOejBN2w==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74ter88m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8Ee31142913; Fri, 9 Oct 2026 18:28:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd2ayt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:28:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699ISngL24052358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:28:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 088CD58054;
 Fri,  9 Oct 2026 18:28:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B51A5805A;
 Fri,  9 Oct 2026 18:28:48 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.5.156]) by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:28:48 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 18/19] s390x/pci: Add PCI error handling for vfio pci devices
Date: Fri,  9 Oct 2026 14:28:24 -0400
Message-ID: <20261009182825.148054-19-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009182825.148054-1-farman@linux.ibm.com>
References: <20261009182825.148054-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rzDFpYdWkSrC57FixGSmKY5L2R4UPRDE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfXyrBkcvQQ4Qob
 aobA3GcvrcFBZa19xnwJRhaXR6SEEEY1O/02JKXfiWDroVh8ys+jI+ax1I7nuXzyrtLXYLgHsAR
 Ee6Lq4dAVulxkPJGuWoCJQ0Ojs5Up4mQrYN3KktS1IkNVH1Jr3+HwSCiQqmgx02V3wXTzGXT5JA
 YnBYXpfsdJ7Mr/HbdF56F8h086FH4zItlJeQRBT5zDZuofP+z088THs0YNmALtzigqoKc9BIWyQ
 yliS3Rs/5b6fY0U0U7GzswrdSN1S2vTZC8BPpVeWrJh+GnSKXvWGc7hTFpCEqCvuy8Ytp3n+tLY
 RAcFbuvPk0434jzOKXwXa+xShMu6DGO3+H0jf7yMG6fLpk98OJhHDNh3LTXA9VHqNeUrzHREe5p
 FuFTEBFaRc+TlxB98n5Mt1e23XDPhD9uWNN7N1EvAhVGRzlgy3VrrvIvJ9xGuSAqSRflYqBI8jZ
 dbIB9x61twOxpbJuBLQ==
X-Proofpoint-GUID: rzDFpYdWkSrC57FixGSmKY5L2R4UPRDE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3MiBTYWx0ZWRfX1rXSHNolCg8h
 yqawBYRfVDIQlbKMapP9eQLmoUDYejZOnX56R+j8kYQZ5wHZYoO+YLF89/y+kQE9XLfcP6pbI/r
 CgpD5sBuxZ+yzuL7FGHQitnkbhlj8IQ=
X-Authority-Analysis: v=2.4 cv=Nf1zRGD4 c=1 sm=1 tr=0 ts=6ac93263 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kH9A0MViX-lNxfKOOeYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090072
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

From: Farhan Ali <alifm@linux.ibm.com>

Add an s390x specific handler for vfio error notifier. For s390x pci devices,
we have platform specific error information. We need to retrieve this error
information for passthrough devices. This is done via a VFIO_DEVICE_FEATURE
ioctl which exposes that information.

Once this error information is retrieved we can then inject an error into
the guest, and let the guest drive the recovery.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261005174314.871-2-alifm@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |   6 ++
 hw/s390x/s390-pci-vfio-stubs.c   |   6 ++
 hw/s390x/s390-pci-vfio.c         | 123 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   1 +
 include/hw/s390x/s390-pci-vfio.h |   1 +
 5 files changed, 137 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b8bb663113..53ed79d17a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1185,6 +1185,7 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
     PCIDevice *pdev = NULL;
     S390PCIBusDevice *pbdev = NULL;
     bool auto_pbdev = false;
+    Error *local_err = NULL;
     int rc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_BRIDGE)) {
@@ -1275,6 +1276,11 @@ static void s390_pcihost_plug(const HotplugHandler *hotplug_dev, DeviceState *de
             pbdev->dma_limit = s390_pci_start_dma_count(s, pbdev);
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
index a035ba5b2c..e65e2be473 100644
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
index 71f956700b..b9c9926910 100644
--- a/include/hw/s390x/s390-pci-bus.h
+++ b/include/hw/s390x/s390-pci-bus.h
@@ -374,6 +374,7 @@ struct S390PCIBusDevice {
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
2.56.0


