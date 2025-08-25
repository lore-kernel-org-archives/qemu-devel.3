Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3C1C8303F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 21:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqegf-00022e-Ko; Mon, 25 Aug 2025 17:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uqegZ-0001xW-0C; Mon, 25 Aug 2025 17:25:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uqegI-0001qz-No; Mon, 25 Aug 2025 17:25:02 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PH1WpE012568;
 Mon, 25 Aug 2025 21:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KPf82vw/8oEiIJA5+
 H5k6bSmA5+UulS3EUMUpwaiZeI=; b=cHRsnZ0Uei4Iwj6DnY03UQWLYCr55WxX5
 nV+jKZk0nEA6Os4QjK90T5hYj4zOrTpoXFn4tS2VSZmLou7/GOQlGdGAkjTDyP/0
 SpZv8FEoeuL67vErcZ5vxeylYfgD6+6zlqKJ8wjbYqoP0PF/Jw1XYY7fMdPfNW5/
 U3+ECvu/eX/jShlnVFzKnISwzXJcYsFI49trlDzrzupJljaVNAP6CijtRjEf+Mkh
 QaOwFG2xHdkq6KAOrSS3eZ8pav1tUv9dugWjkWs8O5GDnnrVK4HvXgBMD0PDRlsY
 +8a8/lHgH8K0c1dkPvnhEkF8yHf+fnYAUkiNOuqeNCutJnNZD5xmA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5hpu3ug-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 21:24:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57PLBgcj007458;
 Mon, 25 Aug 2025 21:24:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qqyu80gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Aug 2025 21:24:38 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57PLOce625100946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 21:24:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C89758043;
 Mon, 25 Aug 2025 21:24:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FF5358059;
 Mon, 25 Aug 2025 21:24:37 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.253])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Aug 2025 21:24:37 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, thuth@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com
Subject: [PATCH v2 4/4] s390x/pci: Reset a device in error state
Date: Mon, 25 Aug 2025 14:24:33 -0700
Message-ID: <20250825212434.2255-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825212434.2255-1-alifm@linux.ibm.com>
References: <20250825212434.2255-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX3yNmuHlS3tZd
 2wano0kaUJ1vMKsS5veCWPhb6sUajzV4qjUTHEbNzXh20Jo00+l8abGDzRKJXPw9JghGBEpN3sG
 YXwxuJWPtAgL3cduolQNpXg07b0ikPppe0WQKkJtHGA9Wf1TeAmpbgFLNsjMT/wLvJX9uHyTyp+
 TntLRNubG0k4Zvlq4NqHkp7Y4UCvA0WUkhq5UOawLrhg4h+o+IMBwjQi/3Uw0xxMQWbW8O/AxWP
 1ILMD/VrYZymMicBhgL0kn4MRFX3FMJcZ3nVVwuvZOr9J+IePk0GpdZtmftm2JyBkTdm4OYWtMM
 jSVlMQl+oOIdVY3ZJM1mVTWpBcsbTd+gIWR2XUA1AjsX27ZlJap5XVJ0hKSGYxdRpnXMZHmCF9w
 QJpP7HfS
X-Proofpoint-ORIG-GUID: 3b4i2HD6k8c-F_VsKhAZ6wM0Io-jbRZP
X-Proofpoint-GUID: 3b4i2HD6k8c-F_VsKhAZ6wM0Io-jbRZP
X-Authority-Analysis: v=2.4 cv=Ndbm13D4 c=1 sm=1 tr=0 ts=68acd497 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=A6rq8h5Md1LYvE6mRIYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
index 87ecd06a81..a11ec770a7 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -158,6 +158,12 @@ static void s390_pci_err_handler(VFIOPCIDevice *vfio_pci)
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


