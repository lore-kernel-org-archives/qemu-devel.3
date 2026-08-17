Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90ABC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VV-0001XY-SY; Mon, 17 Aug 2026 14:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VU-0001XP-UA
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VT-00065R-3e
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:24 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVvvM1065742; Mon, 17 Aug 2026 18:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XNa/3EYTrLLIYA9Ey
 FHIAKHxxdpMpQIYW/cgukLez4w=; b=dGDSr6pHJUUs1ZdjFVtEgbF73Oem7GqFN
 dV+hgMU0BoFLmwsGq/8lmCI9RUoyRV+k0YVm7EctBzEl7O5WRzUtRsFe/FYrLe5h
 bHq6TpoGUXkLD3AHAh8czYPaqNEqLNikgdbfJr6xpMtudM7pHGZ+cWdaRsots3n+
 gMekZFWoCooTkoZ1Sz4I2RxU+b3GpxYBwIxHq1m0f4bLSR0nDZmcv447fMCHB7ST
 poRH9u3XT0dfNJEPWE+H7WWcFv/U/W7YwsJ3tbjfGxWiJLRqnIK6yO7fL0J8kUd/
 qa49rb2CdDTMQQdTVU2QT5PwPZVmT68dwC8nlXPWL/KB74NKaX8lA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe3kqw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfRGZ030031;
 Mon, 17 Aug 2026 18:56:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvyd8t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIuAXR45351216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:56:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 90A4D2004B;
 Mon, 17 Aug 2026 18:56:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D516020040;
 Mon, 17 Aug 2026 18:56:07 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:56:07 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 08/10] qtest/libqos/pci: Enforce balanced iomap/unmap
Date: Tue, 18 Aug 2026 00:25:38 +0530
Message-ID: <20260817185539.376740-9-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfXxlvlYuSUUhBT
 j5kdzg5M/9zbyG1chMZmReZbttYKXOScmu+bsxVRBXc+OLb+tnNWet1li0FSlBafp5aAH0vCTH4
 hinrTbZVTsEuJDxLFTz01BejxV3qqIb7PG9jTCTB/9XfGw/d6iubZ3oWuSBSbaQZlcovnOH/ZwV
 TdC37dvduOpSHRungQLL/K+ANjgC8I38VgIyX8dX6NIyQpAiisajrxcTVyDTEsnpqmJkwLwb10+
 jP9emBRQws7HE2h94kLuc0IILiRIXHQ4LlIJTxWcWeves+2dAaE7N2cDiRBZZjd2TMh2KBXO3eY
 2VTTZDYGtZB5gAdbvxZEM5wLsUGLpRIRQIMxvIztB0rVR8lPjzRAyKVTPpQeZpR7asRPo7BGlis
 p7P/xe+QT7WdDj6+nOTr4Iv6M9DunK5QtGABFvXYq/sfITvHJfGlQv2MFr7mUD9D7Uz9FBFghNF
 iqC6bZzL1HhEzbphYUA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a83594f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=CdWUOAN9w-nrnKmLSdEA:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-ORIG-GUID: qn-pPYd4oRd0Mp6p5cysZfINqL7wVt9x
X-Proofpoint-GUID: i9FoWrDctXsTytjg06448MCZfHcOqxPN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX5DHqrfaIQHvW
 G8iAkYEjyhw0hhz/8EEyblw0ySV4CeBZYK8toft9DSX28aat4eHV8hxSGoqJyOnsKOWvjTyYG9g
 FnPhTqE/Vrjpj2fmjizmAlIE97WqV2Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
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

Add assertions to ensure a BAR is not mapped twice, and that only
previously mapped BARs are unmapped. This can help catch bugs and
fragile coding.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.c | 75 ++++++++++++++++++++++++++++++++--------
 tests/qtest/libqos/pci.h | 10 ++++++
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index cda3c56c..3d953d23 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -79,12 +79,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
 {
     uint16_t vendor_id, device_id;
+    int i;
 
     qpci_device_set(dev, bus, addr->devfn);
     vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
     device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
     g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
     g_assert(!addr->device_id || device_id == addr->device_id);
+
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        g_assert(!dev->bars_mapped[i]);
+    }
 }
 
 static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
@@ -338,21 +343,21 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
 }
 
 /**
- * qpci_msix_test_interrupt - test whether msix interrupt has been raised
+ * qpci_msix_test_interrupt - test whether MSI-X interrupt has been raised
  * @dev: PCI device
- * @msix_entry: msix entry to test
- * @msix_addr: address of msix message
- * @msix_data: expected msix message payload
+ * @msix_entry: MSI-X entry to test
+ * @msix_addr: address of MSI-X message
+ * @msix_data: expected MSI-X message payload
  *
- * This tests whether the msix source has raised an interrupt. If the msix
+ * This tests whether the MSI-X source has raised an interrupt. If the MSI-X
  * entry is masked, it tests the pending bit array for a pending message
  * and @msix_addr and @msix_data need not be supplied. If the entry is not
  * masked, it tests the address for corresponding data to see if the interrupt
  * fired.
  *
  * Note that this does not lower the interrupt, however it does clear the
- * msix message address to 0 if it is found set. This must be called with
- * the msix address memory containing either 0 or the value of data, otherwise
+ * MSI-X message address to 0 if it is found set. This must be called with
+ * the MSI-X address memory containing either 0 or the value of data, otherwise
  * it will assert on incorrect message.
  */
 bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
@@ -376,8 +381,8 @@ bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
     g_assert_cmpint(msix_addr, !=, 0);
     g_assert_cmpint(msix_data, !=, 0);
 
-    /* msix payload is written in little-endian format */
-    qtest_memread(dev->bus->qts, msix_addr, &data, 4);
+    /* MSI-X payload is written in little-endian format */
+    qtest_memread(dev->bus->qts, msix_addr, &data, sizeof(data));
     data = le32_to_cpu(data);
     if (data == 0) {
         return false;
@@ -385,7 +390,7 @@ bool qpci_msix_test_interrupt(QPCIDevice *dev, uint32_t msix_entry,
 
     /* got a message, ensure it matches expected value then clear it. */
     g_assert_cmphex(data, ==, msix_data);
-    qtest_memset(dev->bus->qts, msix_addr, 0, 4);
+    qtest_memset(dev->bus->qts, msix_addr, 0, sizeof(data));
 
     return true;
 }
@@ -554,21 +559,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar token, uint64_t off,
     dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
 }
 
-QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
+static uint8_t qpci_bar_reg(int barno)
 {
-    QPCIBus *bus = dev->bus;
     static const int bar_reg_map[] = {
         PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
         PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
     };
+
+    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
+
+    return bar_reg_map[barno];
+}
+
+QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
+{
+    QPCIBus *bus = dev->bus;
     QPCIBar bar;
     int bar_reg;
     uint32_t addr, size;
     uint32_t io_type;
     uint64_t loc;
 
-    g_assert(barno >= 0 && barno <= 5);
-    bar_reg = bar_reg_map[barno];
+    g_assert(barno >= 0 && barno < QPCI_NUM_REGIONS);
+    g_assert(!dev->bars_mapped[barno]);
+
+    bar_reg = qpci_bar_reg(barno);
 
     qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
     addr = qpci_config_readl(dev, bar_reg);
@@ -611,12 +626,38 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     }
 
     bar.addr = loc;
+    bar.mapped = true;
+
+    dev->bars_mapped[barno] = true;
+    dev->bars[barno] = bar;
+
     return bar;
 }
 
 void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
 {
-    /* FIXME */
+    int bar_reg;
+    int i;
+
+    if (!bar.mapped) {
+        return; /* bar was never mapped; no-op */
+    }
+
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        if (!dev->bars_mapped[i]) {
+            continue;
+        }
+        if (dev->bars[i].addr == bar.addr) {
+            dev->bars_mapped[i] = false;
+            dev->bars[i].mapped = false;
+            bar_reg = qpci_bar_reg(i);
+            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
+            /* FIXME: the address space is leaked */
+            return;
+        }
+    }
+    /* bar was not iomap()ed; treat as no-op for callers that may
+     * call iounmap unconditionally during cleanup paths. */
 }
 
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
@@ -627,6 +668,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
 
 void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
 {
+    memcpy(to->bars_mapped, from->bars_mapped, sizeof(from->bars_mapped));
+    memset(from->bars_mapped, 0, sizeof(from->bars_mapped));
+    memcpy(to->bars, from->bars, sizeof(from->bars));
+    memset(from->bars, 0, sizeof(from->bars));
 }
 
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 19f1dd13..73739afe 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -58,12 +58,22 @@ struct QPCIBus {
 struct QPCIBar {
     uint64_t addr;
     bool is_io;
+    bool mapped;
 };
 
+/*
+ * hw/pci permits 7 (PCI_NUM_REGIONS) regions, the last for PCI_ROM_SLOT.
+ * libqos does not implement PCI_ROM_SLOT at the moment, and as such it
+ * permits 6.
+ */
+#define QPCI_NUM_REGIONS 6
+
 struct QPCIDevice
 {
     QPCIBus *bus;
     int devfn;
+    bool bars_mapped[QPCI_NUM_REGIONS];
+    QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
-- 
2.55.0


