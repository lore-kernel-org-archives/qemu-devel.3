Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0CBC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x948S-0001V2-2h; Tue, 22 Sep 2026 13:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x9487-0001RA-AZ; Tue, 22 Sep 2026 13:18:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x9484-00054L-60; Tue, 22 Sep 2026 13:18:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5Np7751691; Tue, 22 Sep 2026 17:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KUafIWsBLa/Q0R4HX
 512B8ApoSvQuE/LhlO8vJkZOtM=; b=T2FRjxeKERdWdQG+KErrpHW4mHHT3xv9I
 JI2hDLAYOnNYJXXzJXztC20A7E2apPfrYY/xXpSzAUx8c1tEPFvVC47Ugb2y3EfB
 x8l0z9l1IZbCQngWwc+J7jDH50vRinp21MMEOe35piKneLWxjGYAJfXabpEAdEDW
 2wvW2uxsT2FKZYL0uqVTOSk98wJjP51JZEePixZHEcPGRxAx4tVKT/rKzsCIIdFm
 laJEUWqIHRAlLMAwqeSxH4Lj1fIi9EC8C6kSQ+J/ojfoXeftGhrxv+OG8/i4iPi1
 wOQw011rGxCkLuMEylqil32vvmdVB88vwfVuXBKbeL1JKf5uNYu3Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2f53k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:18:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MEm3gL1738240; Tue, 22 Sep 2026 17:18:00 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkdbe4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:18:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MHHxn625494062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 17:17:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B9AD58043;
 Tue, 22 Sep 2026 17:17:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE8A258059;
 Tue, 22 Sep 2026 17:17:58 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 17:17:58 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
Subject: [PATCH v6 1/2] s390x/pci: Add PCI error handling for vfio pci devices
Date: Tue, 22 Sep 2026 10:17:55 -0700
Message-ID: <20260922171756.920-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922171756.920-1-alifm@linux.ibm.com>
References: <20260922171756.920-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BLwQh0dZR_gq-7CFbA-z4axf-hAo5knc
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab2b848 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Km_DOyaihBi-3fC5N0UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX7r12UbuctMuI
 b8wc/5cqIi7tKqGtHoFm88/o1fpm5iN4E0vv1oj4Bz9L6+HziIF2sBJK+SfjwvRv4+l4G/IEMtf
 pUbvp1AeLMRbIgC8ciJMU0NFL4J2H6bazZ86PI2gD+3VtoS+ZiD7oAaaBChH8CBZO9fKoFw2ETE
 yA1WJr52DfIYFpeXJRHW798xq1yhFU5yPzbgqBDiyas8Q/IKWfmTr2ohj6yvVHSE6uV/8KgUX5w
 CS1QzAO+p4BRfGbLuAJCYNFJu4llzls99Y7Qdf56wjftmezLDKYAuR9zzD1qHmsRysnDDqr0+Bm
 QkK6IKrn8HzzWKxUS/2Nx5BaYYt3N3MYh8HL5xjwSlvaJH0jDID++pNOoIwFVcQzAun5BwHQWDD
 KLnfc4t0zCM7Nb45F0xwd9kLR/W74nHi0fnvvt53GYLF80W6GaPsN3r1NgzGYRrVE8MHtLwEqeZ
 KEDALjnb9lkbGmiboqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX0XEOddQM+Jfa
 GcuMxoBOiMtDGX++1C7pIgiHsQzsNRVWCeC4BW+32FzxGx7Gs5YjRlIApSbBG/K6GvxxFQa1CqU
 /492OGPrZa36HWFyU3o+orl289F/G1A=
X-Proofpoint-GUID: BLwQh0dZR_gq-7CFbA-z4axf-hAo5knc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220250
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 hw/s390x/s390-pci-vfio.c         | 121 +++++++++++++++++++++++++++++++
 include/hw/s390x/s390-pci-bus.h  |   1 +
 include/hw/s390x/s390-pci-vfio.h |   1 +
 5 files changed, 135 insertions(+)

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
index db6de00bd2..6b7c554fe5 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -105,6 +106,84 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt)
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
+        error_setg(errp, "Failed feature get VFIO_DEVICE_FEATURE_ZPCI_ERROR"
+                   " (rc=%d)", ret);
+        return ret;
+    }
+
+    memcpy(ccdf, (PciCcdfErr *) err->data, ccdf_err_length);
+
+    return 0;
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
+    pbdev = s390_pci_find_dev_by_target(s390_get_phb(),
+                                        DEVICE(&vfio_pci->parent_obj)->id);
+
+    if (!pbdev) {
+        error_report("No matching zpci device found");
+        return;
+    }
+    pbdev->state = ZPCI_FS_ERROR;
+
+    while (ret == 0) {
+        ret = s390_pci_get_feature_err(vfio_pci, &ccdf,
+                                       pbdev->ccdf_err_length, &local_err);
+        if (ret) {
+            /*
+             * This is an expected errno indicating there are no pending
+             * PCI errors to handle for the device.
+             */
+            if (ret == -ENOMSG) {
+                error_free(local_err);
+                local_err = NULL;
+            } else {
+                error_report_err(local_err);
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
@@ -134,6 +213,10 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
     /* Store function type separately for type-specific behavior */
     pbdev->pft = cap->pft;
 
+    if (hdr->version >= 3) {
+        pbdev->ccdf_err_length = cap->ccdf_err_length;
+    }
+
     /*
      * If the device is a passthrough ISM device, disallow relaxed
      * translation.
@@ -371,3 +454,41 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
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


