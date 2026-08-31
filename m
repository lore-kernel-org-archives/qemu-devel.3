Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EA1C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16nk-0001fE-Po; Mon, 31 Aug 2026 14:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16nc-0001co-2u; Mon, 31 Aug 2026 14:32:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x16na-0001wY-7F; Mon, 31 Aug 2026 14:32:03 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIVgHN1235283; Mon, 31 Aug 2026 18:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=HEHqM8dCGEsXOGRJf
 9BpeteJyeLkyWlz1mj++G40d3o=; b=Xx3ccHr9IDe5Owlf2zjBWGSvWxR1YDMLa
 haXqeN3VYFz3jpY0G5lCoZ2s7YgRxPy+tRRX2yJYfJYiA+KKNrGOCX1+x6hYM3GT
 TE1bO5yEIyzmKCmZRYTBC2QJEX2eDpEhJog3XTZppOC0WNHiaozloSTrryfngbQ1
 331vvPTmmn1McRkQrNesp4qm+GF1PcjHywTrXFwbJYmqJMMBWm1NnNgaCMegTXHu
 BaJG7wBvL8S8GPXWK60cKbFmPwxc6J/5X2YY9TfBBXdlIt7Q5Cd4YVpndciNRWH3
 fBHjozCGmCA0exy471nDQyNXJVRvY6ZB5YwVwi4h+jD/z4xB0ejAg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r34d3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:32:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VIBI1s013146;
 Mon, 31 Aug 2026 18:31:59 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg79cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 18:31:59 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VIVwWN17105428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 18:31:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F15D15805F;
 Mon, 31 Aug 2026 18:31:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F30CA5805C;
 Mon, 31 Aug 2026 18:31:56 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.20])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 18:31:56 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com, armbru@redhat.com
Subject: [PATCH v4 4/4] s390x/pci: Reset a device in error state
Date: Mon, 31 Aug 2026 11:31:51 -0700
Message-ID: <20260831183151.12626-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831183151.12626-1-alifm@linux.ibm.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a95c8a0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LJhZezRDHHgF91vl2EQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfX9pJ0EjvxbIUX
 /xiPqiPPwRxpdmKMxCGeCd/0tLLNXAVDkHmxuaBngf0rX1mveRNZSMiDYEdwvojIefWrQSBpf/r
 PzxdU4TQisvzQ7pADXYgAGSx1V8unVOIDGjBGmBXvmJhiMvz/AGxu2M4zbyi1+nwJ5skwE+sC3d
 G6YzPIMvpwnXYwLAGzdUlMRN8s6Ftm0rKv208iPpcpns8cKjpPH1SGSPhjkzWMNufzI6XaaV4ji
 MKjNmFz92mESVWMRd6p4JTyI8dDKKHyWxI/xiDW2fKAkBPEZJ7eubTa8dmsBmdIlVNZCVQcr8LR
 Cgi+TVOEP5Fr9aWGQ9mYA03TP454cEYh/ZoCa1HB5Q1rE32L+xSHTZItCUVyOmeH+yitaxFkd2s
 qpECWjbTEeH2iYtZin7TmPfEiUaWuSQRUGsOn7JAkTvtr36Byi8aFk1HmFYI+loB3vcjOH6H2LJ
 XBi7+XYsO4GaJC2zOBg==
X-Proofpoint-GUID: S5EG3oVIpgupypnlY7P_ZE-423yQ21zB
X-Proofpoint-ORIG-GUID: S5EG3oVIpgupypnlY7P_ZE-423yQ21zB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE2MCBTYWx0ZWRfXw4+OxgV3zwuI
 u7hnwu81oU2jqvFDmOFD7jDjjlwLy5OVFwxIkB8PH3sP9oczW8tFHjRRvd8Y0ucGOqi86WPVSTP
 a8KTI+ZLT7Minj8pNsbIc5AuIPLNth8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310160
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

For passthrough devices in error state, for a guest driven reset of the
device we can attempt a reset to recover the device. A reset of the device
will trigger a CLP disable/enable cycle on the host to bring the device
into a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          |  7 +++++++
 hw/s390x/s390-pci-vfio-stubs.c   |  4 ++++
 hw/s390x/s390-pci-vfio.c         | 10 ++++++++++
 include/hw/s390x/s390-pci-vfio.h |  1 +
 4 files changed, 22 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b2db7f3df4..283b5b62b0 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1546,6 +1546,8 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        break;
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
@@ -1558,6 +1560,11 @@ static void s390_pci_device_reset(DeviceState *dev)
     } else if (pbdev->summary_ind) {
         pci_dereg_irqs(pbdev);
     }
+
+    if (pbdev->state == ZPCI_FS_ERROR) {
+        s390_pci_reset(pbdev);
+    }
+
     if (pbdev->iommu->enabled) {
         pci_dereg_ioat(pbdev->iommu);
     }
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
index 9fc84ca135..c68c612038 100644
--- a/hw/s390x/s390-pci-vfio-stubs.c
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -36,3 +36,7 @@ bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp)
     error_setg(errp, "VFIO not available, cannot setup error handler");
     return false;
 }
+
+void s390_pci_reset(S390PCIBusDevice *pbdev)
+{
+}
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 9a63040e22..64eb28104b 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -172,6 +173,15 @@ static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
     return success;
 }
 
+void s390_pci_reset(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_DEVICE(pbdev->pdev);
+    if (ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET)) {
+        error_report("Failed to reset PCI device %s : %s ",
+                      vfio_pci->vbasedev.name, strerror(errno));
+    }
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index c7886b63ea..38ccf445ea 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -21,5 +21,6 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
 bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
+void s390_pci_reset(S390PCIBusDevice *pbdev);
 
 #endif
-- 
2.43.0


