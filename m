Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0B6C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 21:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnOXn-0000JV-FF; Wed, 26 Feb 2025 16:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOXk-0000ES-6f; Wed, 26 Feb 2025 16:02:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1tnOXi-00035H-4q; Wed, 26 Feb 2025 16:02:11 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QG7FEM020718;
 Wed, 26 Feb 2025 21:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SR2iXPYNuYqGCyBu6
 XhoyZ+m6dQSVNS7RmhG5V5d7Us=; b=UG3tJY8S5Ya1pX+eA6ho7A/RbuI7E7r+P
 smSz2b7/UPFZaJKbXx2f+/f0IRv/23o97qyni7Cgwy4n44rpeNHZkaxUUeBPysUv
 ZA0/xuWwQupoAUw+5+rwiKmOK4KiAG6jBi8+aGKZTx9lei5trm5IN+7E353+JuSM
 ksMYvXfVAUcK52bbb9WOeVO7AUBsS4ukU+K/3KN0m75/OLYRzQ3vHf2ZEUCJHmSt
 xU3Jlq0xMi+ASan7yNB7Vt22Wao430YnKn/1Rw3NtOHN1gdGCl7E08MRNNppQBDe
 Mqy/m97GDZBXOMRTwX6M7iE5GFLXQXEVKpxYoibg8y254Bl3lTVNg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451vs84efv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:02:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QJ0KWI026990;
 Wed, 26 Feb 2025 21:02:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkmtx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 21:02:06 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51QL24c733161840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 21:02:05 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B1AA158059;
 Wed, 26 Feb 2025 21:02:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90A8C58043;
 Wed, 26 Feb 2025 21:02:03 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.46.135]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2025 21:02:03 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, clg@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 1/2] s390x/pci: fix cleanup of failed hotplug
Date: Wed, 26 Feb 2025 16:02:00 -0500
Message-ID: <20250226210201.238489-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226210201.238489-1-mjrosato@linux.ibm.com>
References: <20250226210201.238489-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AB88-EsnPtMVVlFSewWmlB0-kVgtDfsL
X-Proofpoint-GUID: AB88-EsnPtMVVlFSewWmlB0-kVgtDfsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_06,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 mlxlogscore=776 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260163
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

In the unlikely event that we must fail hotplug of a PCI passthrough
device, ensure appropriate clean up of the associated zPCI device is
performed.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 913d72cc74..6cc0e7538a 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1119,7 +1119,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     if (rc) {
                         error_setg(errp, "Plug failed for zPCI device in "
                                    "interpretation mode: %d", rc);
-                        return;
+                        goto pbdev_cleanup;
                     }
                 } else {
                     trace_s390_pcihost("zPCI interpretation missing");
@@ -1150,7 +1150,7 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         if (s390_pci_msix_init(pbdev) && !pbdev->interp) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
-            return;
+            goto pbdev_cleanup;
         }
 
         if (dev->hotplugged) {
@@ -1168,6 +1168,23 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else {
         g_assert_not_reached();
     }
+
+    return;
+
+ pbdev_cleanup:
+    DeviceState *bdev = DEVICE(pbdev);
+
+    if (pbdev->shutdown_notifier.notify) {
+        notifier_remove(&pbdev->shutdown_notifier);
+    }
+    if (pbdev->iommu->dma_limit) {
+        s390_pci_end_dma_count(s, pbdev->iommu->dma_limit);
+    }
+    s390_pci_iommu_free(s, pci_get_bus(pbdev->pdev), pbdev->pdev->devfn);
+    QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
+    g_hash_table_remove(s->zpci_table, &pbdev->idx);
+    object_unparent(OBJECT(bdev));
+    qdev_unrealize(bdev);
 }
 
 static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
-- 
2.48.1


