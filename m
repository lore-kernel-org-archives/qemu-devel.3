Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241AC5DF7E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VG-0001TB-9m; Mon, 17 Aug 2026 14:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VE-0001Sl-Ug
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VD-00063E-1p
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:08 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVqqk2076394; Mon, 17 Aug 2026 18:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=MhM6Yz
 UtaAdbhXR3VF41rdgU0m0cISKyIplwTpJdKLE=; b=RUdDlxpelMQ/wHHmsb6ZP2
 vew1b0rNbGNqyOjUld4e+MZtAUTniLxA73rBG9JWWvf2T/ROevusywKqWTZSD+jj
 bIDquzvllTMtpmLletoLiGVx1ZyMF0o/hoZNliNDS/d9/F0AwYIxa3DOLaE7PEh0
 wPTy8aHc0jtRjW+doTQjyDnErSvOhG5Ana+2LdpXsrmlTm4vierJYnjFlcL26QXT
 kIJegeS69Nl7xTULZATvfPSJ8VZneXJ1Bqflv7+7a8B4VUZwpS2nSLiuWBuZh8oM
 Z3d1fHV5RhkIL4lEMAbjm8zNWl0qfaid1RTbYlZmSaKV/+X+pQQKBzkzDEp2Ueyw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkusgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfGiQ004507;
 Mon, 17 Aug 2026 18:55:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epyf62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HItlYC43123082
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:55:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD15B20043;
 Mon, 17 Aug 2026 18:55:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEF8120040;
 Mon, 17 Aug 2026 18:55:44 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:55:44 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 01/10] tests/qtest: Enforce zero for the "un-fired" msix
 message value
Date: Tue, 18 Aug 2026 00:25:31 +0530
Message-ID: <20260817185539.376740-2-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX3h6UlBCO21W8
 JBQ3qgI+idZ5Yq3BGAtE0b+/B+cPVNQr0oJ3a4+iRZnj7PcIm3jt92amlZkHeNLEoVLzOtPKbNI
 7bjCFQHS19ZeHktdt0qwJCHAsevs8ENSvwV0Uk8stL+8tH4FYVUrRcR9frG1oNFe9rCMdcv5DGa
 qvJ6OJuXMsR9SxkWdNM5GNswhjUbLcTD8Pa10YM64u59MYyZn650uiftTPoquJKZIBO8WxisBhu
 qco8i5Qad5oluOPKxfY7I3VV/PJS8QmrlpjyW5Z4gpbev2I04ifpQzvT8S3BjZx53RmJhK1FRmT
 p97rxtVDH5dFXwH2WU4evwj416HexUvLMsTBiQrryXUk6ZN4V8kIUuUEDcZdLX7hlI/aV7rHA9Z
 3vev0FKetgRer33zQDyHJaAKRuaicQPyY0d7M2siLkWwSE6udFdGu3KOMlU03wrx2pfq3kNN1b+
 SBN6rlIqtXLkmelTP5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX6t9Ftjr+hbRp
 wgU0lHsYjooz6Z4TSbXlDKG98bd4rSGnSqDR18rhtTdQO2l3D6HhBZj220yIzzsWzwSMyjYAqm2
 bZbmIT26AAX5fqujaMwYKxPrqCjKpJY=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a835939 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=cluJ50jZ9R0NNln75_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: syKFgFEoCXZy7YQ9DIhliLSMTg1JrdO1
X-Proofpoint-GUID: a4YIagjVY6Dhh0opu7dCA2CeP78oN_By
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

virtio-pci detects an unmasked msix interrupt has fired by looking
for the data payload value at the target address. If a value of zero
is enforced for the memory value when an interrupt has not fired,
then an assertion can be added to catch the case where something
changed the memory to an unexpected value.

This catches an endian conversion bug in the message value when
running these tests on a big endian target. Previously the test
just times out waiting for interrupt, after this it fails nicely.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/virtio-pci-modern.c |  9 +++++----
 tests/qtest/libqos/virtio-pci.c        | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 4e67fcbd..f31b3be6 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -137,12 +137,13 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
     }
 
     data = qtest_readl(dev->pdev->bus->qts, msix_addr);
-    if (data == msix_data) {
-        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-        return true;
-    } else {
+    if (data == 0) {
         return false;
     }
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
+    return true;
 }
 
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8..102e45b5 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -132,12 +132,13 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
-            if (data == vqpci->msix_data) {
-                qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, vqpci->msix_data);
+            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
@@ -156,12 +157,13 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
-            if (data == dev->config_msix_data) {
-                qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, dev->config_msix_data);
+            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
@@ -323,6 +325,7 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
     vqpci->msix_entry = entry;
 
     vqpci->msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
@@ -355,6 +358,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
 
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-- 
2.55.0


