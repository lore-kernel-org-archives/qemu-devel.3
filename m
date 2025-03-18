Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24226C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tub83-0001J6-Bl; Tue, 18 Mar 2025 13:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tub7j-0000mu-8m; Tue, 18 Mar 2025 13:53:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1tub7g-0002jF-Fc; Tue, 18 Mar 2025 13:53:06 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IA0HXB002930;
 Tue, 18 Mar 2025 17:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=wItEEi84KMkGoT+vB8YHYceoCvnh
 fqkCoy8CSpCk8vE=; b=mo6PWgpI1geRUKMcs6XqC2CE7xMoMcfBM4DqUWmo7gfm
 WI8cHdqZVfZbkH7qRZKMqnoxdUPfp7v5h1U2bGS582gJAsDQSGCNuy5P8PPccL3+
 aLTQv/Igj+M4Ac+BnzINv0O46LwBEvCbcmPfMdWWZZp5GPT90fv9YLkcCKBkLqIR
 9JwOjVsit3UF3GV0FTx6iJ3b+mXGvALHMR86RCyr10sXNMxIr3p3JOFMiv6X0P2l
 vW236NaRuVC7vYxHwcyaBwJeMkqRT7e8qshMg0BaJ0SDCSFmuM1EnvCS4WMflzz5
 eub/Ro2jhf1XeICAIBtESwuRMwfHKjaFEo5XMkr16Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0nd3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 17:53:00 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IHqf5g013554;
 Tue, 18 Mar 2025 17:53:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0nd3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 17:53:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52IGdhYG005659;
 Tue, 18 Mar 2025 17:52:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm8ywc0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Mar 2025 17:52:59 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52IHqtWY34210384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Mar 2025 17:52:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBFC720049;
 Tue, 18 Mar 2025 17:52:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B61A20040;
 Tue, 18 Mar 2025 17:52:54 +0000 (GMT)
Received: from [172.17.0.2] (unknown [9.3.101.137])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Mar 2025 17:52:54 +0000 (GMT)
Subject: [PATCH v2] vfio: pci: Check INTx availability before enabling them
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: alex.williamson@redhat.com, clg@redhat.com
Cc: qemu-devel@nongnu.org, sbhat@linux.ibm.com, harshpb@linux.ibm.com,
 vaibhav@linux.ibm.com, npiggin@gmail.com, qemu-ppc@nongnu.org
Date: Tue, 18 Mar 2025 17:52:53 +0000
Message-ID: <174232032506.3739.465958546360660842.stgit@linux.ibm.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ob_24bIfuqc0cbGj888KG0SlDY-_r50Y
X-Proofpoint-ORIG-GUID: asZtxcqNJRbVGDPwYEz9N24geVOgNeTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, the PCI_INTERRUPT_PIN alone is checked before enabling
the INTx. It is also necessary to have the IRQ Lines assigned for
the INTx to work.

The problem was observed on Power10 systems which primarily use
MSI-X, and LSI lines are not connected on all devices under a
PCIe switch. In this configuration where the PIN is non-zero
but the LINE was 0xff, the VFIO_DEVICE_SET_IRQS was failing as
it was trying to map the irqfd for the LSI of the device.

So the patch queries the INTx availability with
VFIO_DEVICE_GET_IRQ_INFO ioctl, and enables only if available.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
Changelog:
v1: https://lore.kernel.org/qemu-devel/173834353589.1880.3587671276264097972.stgit@linux.ibm.com/
- Split the fix into two parts as suggested. Kernel part posted here [1]
- Changed to use the irq_info for checking the intx availability.

[1]: https://lore.kernel.org/all/174231895238.2295.12586708771396482526.stgit@linux.ibm.com/

 hw/vfio/pci.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7f1532fbed..54de6e72f8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -261,6 +261,25 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
     vfio_intx_update(vdev, &vdev->intx.route);
 }

+static bool vfio_check_intx_available(VFIOPCIDevice *vdev)
+{
+    uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
+    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
+                                      .index = VFIO_PCI_INTX_IRQ_INDEX};
+
+    if (!pin) {
+        return false;
+    }
+
+    if (ioctl(vdev->vbasedev.fd,
+              VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0) {
+        warn_report("VFIO_DEVICE_GET_IRQ_INFO failed to query INTx");
+        return false;
+    }
+
+    return (irq_info.count != 0);
+}
+
 static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
     uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
@@ -268,8 +287,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     int32_t fd;
     int ret;

-
-    if (!pin) {
+    if (!vfio_check_intx_available(vdev)) {
         return true;
     }

@@ -3151,7 +3169,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                vdev->msi_cap_size);
     }

-    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
+    if (vfio_check_intx_available(vdev)) {
         vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                   vfio_intx_mmap_enable, vdev);
         pci_device_set_intx_routing_notifier(&vdev->pdev,



