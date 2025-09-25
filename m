Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E71CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 17:50:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1q61-000460-Tz; Thu, 25 Sep 2025 13:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5i-0003vQ-HI; Thu, 25 Sep 2025 13:49:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1v1q5b-0008LO-HD; Thu, 25 Sep 2025 13:49:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAQwI2007389;
 Thu, 25 Sep 2025 17:49:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=jq2i/gelLXmT8TSyq
 6Z2M6/hJosHLf7AlJNL1I5JmIU=; b=pBJfkYRDEd01GhDyJwiAocw4jLsbPKags
 jdGQEAwhM1xmTgvX/DZKxWBhomESi94bCiLx7EWfbt12R0n6gf7gst/LxGz+Wvf3
 Epr6+Y5ZMnsg4ef3znLZaVr02ew/scIr/+YyRAkRVXyMAHTOSCU6ZBhamDIYCCu7
 +PUsPkbPaxV0D7pMZlT6WUAIuFGB6634+HdcX3yPH2eitLtxSBzVXAnMMC6wpjpP
 LOGq9Ghum+qAqlZ99BNahpwCXTMNHOWjJYNL6c9b/Gn880QTAuNWzqV218N4QaN3
 27t06w52PxVA8ONwXE3rxIflQRTuS0RSvW+08GlaPLxIbXjXlJzkA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jyam4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:49:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PHSr6n030336;
 Thu, 25 Sep 2025 17:48:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a1f28s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 17:48:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PHmlMd60686604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 17:48:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFC1258059;
 Thu, 25 Sep 2025 17:48:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 20DD55805D;
 Thu, 25 Sep 2025 17:48:57 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.251.202])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 17:48:57 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v3 5/5] s390x/pci: Reset a device in error state
Date: Thu, 25 Sep 2025 10:48:52 -0700
Message-ID: <20250925174852.1302-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925174852.1302-1-alifm@linux.ibm.com>
References: <20250925174852.1302-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX5P1ZqBbEbbEh
 g7wfUS6gRMsJZ8O1PRXoH/fr3MP1JrHzBqBtMWpVvFSwh1ad9ie58RWUhhhzg5CBYbRPPhtV9iQ
 SsCmX0LdUg6LWkZbQoswaG22J4i6DDZ+vuZoBZfM9FuTJ33TrTA3mtwjqOiwCuc1SUEIpSzEYzY
 SKwotB0HQ1dwmeVh4wFRrUZfDZCOk7nS73i5veYTaY8OV7TqI+2UmiA00gTNt7ZBlp2k7ygd1W7
 I2dMkmbWWUvqB25IobW1XlNLP5yxqTpDvUEX3fAL0em+81TEfKt/QE5qi+LHb70ooPRQCFErgD8
 nvpKZpufZJbTsw80U6A8patjdgWa+b02uabeTQCeTHJev6So+HfPHJMrGK/t8cMmJDI4ecAaoTn
 NCGk1v8X
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d5808c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=A6rq8h5Md1LYvE6mRIYA:9
X-Proofpoint-ORIG-GUID: E6A9tcWviRvGZN3pffGc4obFdVn9pHjp
X-Proofpoint-GUID: E6A9tcWviRvGZN3pffGc4obFdVn9pHjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033
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

For passthrough devices in error state, for a guest driven reset of the
device we can attempt a reset to recover the device. A reset of the device
will trigger a CLP disable/enable cycle on the host to bring the device
into a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 7 +++++++
 hw/s390x/s390-pci-vfio.c         | 6 ++++++
 include/hw/s390x/s390-pci-vfio.h | 2 ++
 3 files changed, 15 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 9f7b17e807..c0216d4a82 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1497,6 +1497,8 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        break;
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
@@ -1509,6 +1511,11 @@ static void s390_pci_device_reset(DeviceState *dev)
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
index 1697a84de7..27e300f95d 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -155,6 +155,12 @@ static bool s390_pci_err_handler(VFIOPCIDevice *vfio_pci, Error **errp)
     return true;
 }
 
+void s390_pci_reset(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
+    ioctl(vfio_pci->vbasedev.fd, VFIO_DEVICE_RESET);
+}
+
 static void s390_pci_read_base(S390PCIBusDevice *pbdev,
                                struct vfio_device_info *info)
 {
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index b45ffa5044..5d7f21023f 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -23,6 +23,7 @@ void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
 bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh);
 void s390_pci_get_clp_info(S390PCIBusDevice *pbdev);
 bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **errp);
+void s390_pci_reset(S390PCIBusDevice *pbdev);
 #else
 static inline bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
 {
@@ -45,6 +46,7 @@ static inline bool s390_pci_setup_err_handler(S390PCIBusDevice *pbdev, Error **e
     error_setg(errp, "VFIO not available, cannot setup error handler\n");
     return false;
 }
+static inline void s390_pci_reset(S390PCIBusDevice *pbdev) { }
 #endif
 
 #endif
-- 
2.43.0


