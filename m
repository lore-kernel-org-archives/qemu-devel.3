Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5599CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 17:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umFUH-0003wO-2l; Wed, 13 Aug 2025 13:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUE-0003ue-EB; Wed, 13 Aug 2025 13:42:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1umFUB-0006Zw-El; Wed, 13 Aug 2025 13:42:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCQfRv031309;
 Wed, 13 Aug 2025 17:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=B5ta6HOMcmrLv2Sy+
 6xx72FcquoyT7XUv0NzntvhIq4=; b=e+XOm7oEdsTvEBSUfBVNbzrVN2fg/zZS7
 Xza5Od6ees/bFP/RVFde0FpUNi3wMVkti4WHvEBf9aJkz9A+mKwT1Js2rYBsI6mX
 nncgKTtVYqXpO50lXBVjyt4Ud5TWgr69hDmyAuHQzWZSeFxUvzZa/Rx2LW+P1gaO
 WW27Z93s7RnY/Z6ddnCXLTP66o7oBbtmWm2+cydqyRwAn+aI4OWq4q39/4myl+1d
 V//ZpF6NELNaygi9RLsOv0+Mafvk/c5/o5fmdxbU+e4zwK8quFItwxKVyKz6Zpj4
 03gqvVDTTNXenjEBooaupvCCFQuVB9cOcXRI32QaN5juaCWcPo6NA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp5pfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFca9e020703;
 Wed, 13 Aug 2025 17:41:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48ehnq0df1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 Aug 2025 17:41:57 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57DHfucq32375068
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Aug 2025 17:41:56 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDC5D5805A;
 Wed, 13 Aug 2025 17:41:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5795758051;
 Wed, 13 Aug 2025 17:41:55 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.61])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 Aug 2025 17:41:55 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, alifm@linux.ibm.com
Subject: [PATCH v1 4/4] s390x/pci: Reset a device in error state
Date: Wed, 13 Aug 2025 10:41:51 -0700
Message-ID: <20250813174152.1238-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813174152.1238-1-alifm@linux.ibm.com>
References: <20250813174152.1238-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIxOSBTYWx0ZWRfX2suELHV1OudE
 JajGInCfYF8KdfoK5hSoANjEiJk/HwVo8/ijRePcEs8EhbYcH90lDy6M1HdFB0Lno9nRGim0a6G
 AECyV6ww+aTRU1Uhfm1AueWiMQdf2h0cyJ1QP1Y/bGJuPDiWTvH0TG8vH5+V69XEle5GY5m5gTH
 TimIE7XeRs5OBuLuDZwg4/9U2gjoxuKNPVTzSo5JvGNcEVBVAXrGFNk/xV3tNKlcPdbcoU9Cn2o
 9fvLQs+TDiocvquKx5a8hGkDdSGvQfXLqPXP7TO+gN1C/kgcoACxfcgwb51Ba2sa1uUAzIf4MQs
 CUChUYlgOlKxb72Kjc4McLB31trjgA75N+g7IpuufOdD+EX+XiKsQY3/+//EfNRf8ECF3Pth/nV
 cUEsCpdG
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689cce66 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=A6rq8h5Md1LYvE6mRIYA:9
X-Proofpoint-GUID: U4gCi9SuUZ7UcgxBlh-F-3QaTeA01sQn
X-Proofpoint-ORIG-GUID: U4gCi9SuUZ7UcgxBlh-F-3QaTeA01sQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120219
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

For passthrough devices in error state, for a guest driven
reset of the device we can attempt a hot reset to recover the
device. A hot reset of the device will trigger a CLP
disable/enable cycle on the host to bring the device into
a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 7 +++++++
 hw/s390x/s390-pci-vfio.c         | 6 ++++++
 include/hw/s390x/s390-pci-vfio.h | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index af42eb9938..c9c2d775f0 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1493,6 +1493,8 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        break;
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
@@ -1505,6 +1507,11 @@ static void s390_pci_device_reset(DeviceState *dev)
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
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index ceee342f4a..4ec5e2cd95 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -168,6 +168,12 @@ static void s390_pci_err_handler(VFIOPCIDevice *vfio_pci)
     return;
 }
 
+void s390_pci_reset(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET);
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index 66b274293c..c28dafeed8 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -23,6 +23,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
 void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev);
+void s390_pci_reset(S390PCIBusDevice *pbdev);
 #else
 static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
 {
@@ -41,6 +42,7 @@ static inline bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
 }
 static inline void s390_pci_get_clp_info(S390PCIBusDevice *pbdev) { }
 static inline void s390_pci_setup_err_handler(S390PCIBusDevice *pbdev) { }
+void s390_pci_reset(S390PCIBusDevice *pbdev) { }
 #endif
 
 #endif
-- 
2.43.0


