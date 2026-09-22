Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE3C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:18:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9487-0001RB-CC; Tue, 22 Sep 2026 13:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x9485-0001Q9-NZ; Tue, 22 Sep 2026 13:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1x9484-00054P-01; Tue, 22 Sep 2026 13:18:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MF5mSC3071798; Tue, 22 Sep 2026 17:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IrPOWvRwUSTmwxcX2
 mMRr3nhoBwSd8GibwtObiGW0xs=; b=nxzwu+W3x+RpTHQi6klifENxCDWnfnZwi
 gps7DDRHtIVCM2w0c6mDXBiLcrz6TLHwSasQvO2jeVQnGDKxqNO04r5S4/rYJJS2
 M7N5aZpmje1EGtbInaJZpELmeontOm3CzZBgzT3mXBvm4X0TSeNCHSA3ekOoY27o
 iCycVcc/iZ+umIDA2GbAt00Eig6gfRoizjzBq9SkUXj1LvTRo/IN+QRUlIs7IO9V
 ABbNnyAO+rOn2ZQ/7ce+845Kc6LlhBSHKJLPKiyMeXE1JMIq/5xUxECQl3GmHCOS
 83iXftC+oAoERbWLD0rJTdQgwdtFjNIFt21oh+B83TwMmsd/VEzIg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1q40w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:18:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MElas23007837; Tue, 22 Sep 2026 17:18:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt67gtq4d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 17:18:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MHI0wB32834248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 17:18:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0242658043;
 Tue, 22 Sep 2026 17:18:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6756958059;
 Tue, 22 Sep 2026 17:17:59 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.245.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 17:17:59 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
Subject: [PATCH v6 2/2] s390x/pci: Reset a device in error state
Date: Tue, 22 Sep 2026 10:17:56 -0700
Message-ID: <20260922171756.920-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922171756.920-1-alifm@linux.ibm.com>
References: <20260922171756.920-1-alifm@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bsslzSA6ELaR708WX4mt95vpYOfkQplD
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab2b84a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=A6rq8h5Md1LYvE6mRIYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfX6O1FESgD9VZ5
 6GrzymolJCMhmdiJBQLYyYkFgrqztMuJv8UzN8wwYXDyfFbcnDNBmCKzSRtoUkDBD+++TO00C+l
 PTXG5eMKPzr+Gb30l1Iva4GSdED0udo=
X-Proofpoint-GUID: bsslzSA6ELaR708WX4mt95vpYOfkQplD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI1MCBTYWx0ZWRfXxTwf0dyeVYB+
 zvElWQf3ll8a7PfXNqiRYzhHeohhSXOK0vjtlZ4PQb6KS5Yxb+yqR0GTnmXENgKeG19ODURSjXk
 2z73dXTIDC20uS+rJ/jaV1Y6KVqjCpVZ7JC22d1cP8lVF5XPOXT0VZ/2GA2++tLTj2tyxG8fb63
 JRZqIHYBAAbGKBJ2IiMEwSApQJlmq03ey0OQhEhv1ziTtu3Fa+qXFiOtytaXkZRHnIwklFvhtav
 iI9OEEQpWsa6AAKnwnLqmibnAXjBNQIhQARva8QwCh0P2BGKJnWIlrxO09irlZlECRy/9aHZKB0
 9LXzh2QFmiRfWg8rsdvFuZVQ5QtT9EWWyno9FMrugJMbQr38XbuC+Qxq3djTDEi7SzvMh9wnhoy
 MMr/LV1Lf3A8yxnXqmmpXpfxUHs2hZoOBM9/mAbBffu1ggFlZPFmAOjTCw9HbEVr5WdW8Xwwf1q
 QFpVzdryeO2MPpcUwcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
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

For passthrough devices in error state, for a guest driven reset of the
device we can attempt a reset to recover the device. A reset of the device
will trigger a CLP disable/enable cycle on the host to bring the device
into a recovered state.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c          | 7 +++++++
 hw/s390x/s390-pci-vfio-stubs.c   | 4 ++++
 hw/s390x/s390-pci-vfio.c         | 9 +++++++++
 include/hw/s390x/s390-pci-vfio.h | 1 +
 4 files changed, 21 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b2967dacba..8418da9372 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1505,6 +1505,8 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
+    case ZPCI_FS_ERROR:
+        break;
     default:
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
@@ -1517,6 +1519,11 @@ static void s390_pci_device_reset(DeviceState *dev)
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
index 6b7c554fe5..da708ceb47 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -184,6 +184,15 @@ static void s390_pci_err_handler(void *opaque)
     return;
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


