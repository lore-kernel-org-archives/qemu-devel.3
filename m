Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C69DC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VH-0001Tk-Ss; Mon, 17 Aug 2026 14:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VF-0001T2-Ne
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VD-00063G-Fz
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVvvL1065742; Mon, 17 Aug 2026 18:55:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Kx0uKV
 PztBvGaYBUn3RYImdVbZQ9JKpEItciszu1I7M=; b=Wfjxv3AdmqFoE1PwVMXbv1
 bPiS6/5UiZisWRiLHd9TRNqB+eaa+OsFqjPLPgSSMf9rBviewzjJ8P5eQmg/jkEc
 bNAus0o069lwCJ4dwA9CYoco0/h8JawXzekQ6VLOsvBMSVZCk9Gof30ZHIISiBK3
 MDHzaJp+wON57RUR0OJJWyNb9lNQZp3TbojI4tStoPws3dtDaiEp2+ksfMZdUCfp
 ujoPN+xhK7AKWj4ADASxca8TvsU69pxEq35xwkVqQpZ+ojg86+BZRveqDcFX48sL
 0qVPz2elzI/XlHSCu1W0MfdA/A0JK0zrnl0CwKvO9e8aa2QGdGUHjcSESuaUSsWA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe3kpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfPUM002798;
 Mon, 17 Aug 2026 18:55:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng73fp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:55:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HItsrq50135368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:55:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FF7A20043;
 Mon, 17 Aug 2026 18:55:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FDD520040;
 Mon, 17 Aug 2026 18:55:51 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:55:51 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 03/10] tests/qtest: Add libqos function for testing msix
 interrupt status
Date: Tue, 18 Aug 2026 00:25:33 +0530
Message-ID: <20260817185539.376740-4-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX9axzqQbfwYyh
 pO5aha4gFTLjwlYfSTYfZCRbY2XE+q76+Cx/I8a+3wCFKfso5ActfMlg3BoQm+Z+QZd8GVXDroQ
 fWWOzgeLfrd2ot6EbRZ/fFuJbDv8Jwj52cfsY3eipRZdcKzwvvjzgfxV3ILbDLyyuBHqwoMb7aA
 oVNvJDnMtPnp2GxjLMKITa/ZnD8vhMNBZFPeH+k5ni+AagAi/m8b5n3KBe2SAY36AEE/i1WKA/j
 TFrhTgvwJT76OK6q0FK4lkHYbrXQf9f8I7ZqLawPn7uLR/DmrFHII5009gzIRrbh2kzihOiEPE5
 opbNW7Z0NpaPZpCDsqsNQJPmE38OLW3DX7SI/268x6JxVi6L28iZ6TcBUKTg8ntxxa6Ml/uRY+7
 fjCLRH9XU+xAKgW4JxLnWBCCemBZu0toT1DswzlLqxdjPg+TX8xMddEg2RB/p4BYufsmCupbfD7
 Ib0bKLYd26ZDoQwErIg==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a83593f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=EB_6SxfGDJvBgIolNOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 4YzEeaz-F0WrfUfmmrVFz13o6OKPJNBu
X-Proofpoint-GUID: TEDJOHmvlYb5g-mCzHvT_TQvLgDo8qBH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfXy0S4XeNtqag7
 iy8RefyeSMAvXQf+LqORIhnokc2+mVrZKuSaBb/FpBx/BHW6PuTqcTpjX8UfhBczjPWYdHId2LZ
 vm715SK1bWA68DXp9rX/L/5MgnjLl6o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170142
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

This function is duplicated 3 times, with more potential future users.
Factor it into libqos, using qtest_memset instead of qtest_writel to
clear the message just because that looks nicer with the qtest_memread
used to read it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.c               | 53 ++++++++++++++++++++++++++
 tests/qtest/libqos/pci.h               |  2 +
 tests/qtest/libqos/virtio-pci-modern.c | 31 +++------------
 tests/qtest/libqos/virtio-pci.c        | 40 ++++---------------
 4 files changed, 67 insertions(+), 59 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a59197b9..986ce31d 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -351,6 +351,59 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     }
 }
 
+/**
+ * qpci_msix_test_interrupt - test whether msix interrupt has been raised
+ * @dev: PCI device
+ * @msix_entry: msix entry to test
+ * @msix_addr: address of msix message
+ * @msix_data: expected msix message payload
+ *
+ * This tests whether the msix source has raised an interrupt. If the msix
+ * entry is masked, it tests the pending bit array for a pending message
+ * and @msix_addr and @msix_data need not be supplied. If the entry is not
+ * masked, it tests the address for corresponding data to see if the interrupt
+ * fired.
+ *
+ * Note that this does not lower the interrupt, however it does clear the
+ * msix message address to 0 if it is found set. This must be called with
+ * the msix address memory containing either 0 or the value of data, otherwise
+ * it will assert on incorrect message.
+ */
+bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
+                              uint64_t msix_addr, uint32_t msix_data)
+{
+    uint32_t data;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(msix_entry, !=, -1);
+
+    if (qpci_msix_masked(dev, msix_entry)) {
+        /* No ISR checking should be done if masked, but read anyway */
+        return qpci_msix_pending(dev, msix_entry);
+    }
+
+    /*
+     * 0 is used as the "not fired" sentinel — callers must program a
+     * non-zero MSI-X data value so the pre-zeroed target memory can be
+     * polled reliably.
+     */
+    g_assert_cmpint(msix_addr, !=, 0);
+    g_assert_cmpint(msix_data, !=, 0);
+
+    /* msix payload is written in little-endian format */
+    qtest_memread(dev->bus->qts, msix_addr, &data, 4);
+    data = le32_to_cpu(data);
+    if (data == 0) {
+        return false;
+    }
+
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_memset(dev->bus->qts, msix_addr, 0, 4);
+
+    return true;
+}
+
 uint16_t qpci_msix_table_size(QPCIDevice *dev)
 {
     uint8_t addr;
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 83896145..9f8f154c 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -92,6 +92,8 @@ void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
+                              uint64_t msix_addr, uint32_t msix_data);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
 
 uint8_t qpci_config_readb(QPCIDevice *dev, uint8_t offset);
diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 5dae41e6..0d7d89bb 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -126,28 +126,6 @@ static void set_status(QVirtioDevice *d, uint8_t status)
                           status);
 }
 
-static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
-                            uint32_t msix_addr, uint32_t msix_data)
-{
-    uint32_t data;
-
-    g_assert_cmpint(msix_entry, !=, -1);
-    if (qpci_msix_masked(dev->pdev, msix_entry)) {
-        /* No ISR checking should be done if masked, but read anyway */
-        return qpci_msix_pending(dev->pdev, msix_entry);
-    }
-
-    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
-    data = le32_to_cpu(data);
-    if (data == 0) {
-        return false;
-    }
-    /* got a message, ensure it matches expected value then clear it. */
-    g_assert_cmphex(data, ==, msix_data);
-    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-    return true;
-}
-
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
@@ -155,8 +133,8 @@ static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
     if (dev->pdev->msix_enabled) {
         QVirtQueuePCI *vqpci = container_of(vq, QVirtQueuePCI, vq);
 
-        return get_msix_status(dev, vqpci->msix_entry, vqpci->msix_addr,
-                               vqpci->msix_data);
+        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
+                                        vqpci->msix_addr, vqpci->msix_data);
     }
 
     return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 1;
@@ -167,8 +145,9 @@ static bool get_config_isr_status(QVirtioDevice *d)
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
 
     if (dev->pdev->msix_enabled) {
-        return get_msix_status(dev, dev->config_msix_entry,
-                               dev->config_msix_addr, dev->config_msix_data);
+        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
+                                        dev->config_msix_addr,
+                                        dev->config_msix_data);
     }
 
     return qpci_io_readb(dev->pdev, dev->bar, dev->isr_cfg_offset) & 2;
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 76ea1f45..ea8114e2 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -122,25 +122,12 @@ static void qvirtio_pci_set_status(QVirtioDevice *d, uint8_t status)
 static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
-    QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
-    uint32_t data;
 
     if (dev->pdev->msix_enabled) {
-        g_assert_cmpint(vqpci->msix_entry, !=, -1);
-        if (qpci_msix_masked(dev->pdev, vqpci->msix_entry)) {
-            /* No ISR checking should be done if masked, but read anyway */
-            return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
-        } else {
-            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
-            data = le32_to_cpu(data);
-            if (data == 0) {
-                return false;
-            }
-            /* got a message, ensure it matches expected value then clear it. */
-            g_assert_cmphex(data, ==, vqpci->msix_data);
-            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-            return true;
-        }
+        QVirtQueuePCI *vqpci = (QVirtQueuePCI *)vq;
+
+        return qpci_msix_test_interrupt(dev->pdev, vqpci->msix_entry,
+                                        vqpci->msix_addr, vqpci->msix_data);
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
     }
@@ -149,24 +136,11 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
 static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
 {
     QVirtioPCIDevice *dev = container_of(d, QVirtioPCIDevice, vdev);
-    uint32_t data;
 
     if (dev->pdev->msix_enabled) {
-        g_assert_cmpint(dev->config_msix_entry, !=, -1);
-        if (qpci_msix_masked(dev->pdev, dev->config_msix_entry)) {
-            /* No ISR checking should be done if masked, but read anyway */
-            return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
-        } else {
-            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr, &data, 4);
-            data = le32_to_cpu(data);
-            if (data == 0) {
-                return false;
-            }
-            /* got a message, ensure it matches expected value then clear it. */
-            g_assert_cmphex(data, ==, dev->config_msix_data);
-            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-            return true;
-        }
+        return qpci_msix_test_interrupt(dev->pdev, dev->config_msix_entry,
+                                        dev->config_msix_addr,
+                                        dev->config_msix_data);
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
     }
-- 
2.55.0


