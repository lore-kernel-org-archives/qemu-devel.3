Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A4BC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2Vb-0001a1-A7; Mon, 17 Aug 2026 14:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VZ-0001ZF-Ba
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VW-00065h-Rd
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVWxg306887; Mon, 17 Aug 2026 18:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Bp2qvYO3b23uAJ8WP
 BiJ8zfiQmiGUzSwoL89BNG/WrI=; b=XaVSGnpQIT2EV9o08lGjQJsLWm/Ef98mI
 mO2iz02y8nXSwMAkWG6diBiauzrKTp/xRD5PHe6PiArKFwh/MN4Q28UggTrEvomb
 ycYFc7IpnLVqgAEpXxjx38LC+mNFb8JVmXNHhs6I4wi/Xri1cJO6UCVYVuDOLapr
 eB6U7sh6dSPnXku/X+2JQknlv4pw5ci8r24uTh58+UONCPTtZ0VVMeGvi3bZbIU2
 OuCgYX4+He5OvPebBVfwazpVMNsMj1YM8NuGJTsNrVqrck69Nm61PscQJmeA528e
 VkAInFDvaZ40ixjnWHimiwwgLp3A1GNF3c/Lzck0bwJVJHYEvqoHw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqkukk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfZCf030109;
 Mon, 17 Aug 2026 18:56:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvyd8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIuEpP30081514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:56:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3A4520040;
 Mon, 17 Aug 2026 18:56:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BCBA2004B;
 Mon, 17 Aug 2026 18:56:11 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:56:10 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 09/10] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Tue, 18 Aug 2026 00:25:39 +0530
Message-ID: <20260817185539.376740-10-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX9fqxmSx95F40
 Q/SOBhGNqhBz8THLK1ujzP40CqUWHJ7I4/PwW8p2+TSEi/5Wlee8bokh4mZJpyiSS0xhxdjiIg8
 xdKV8p9konLbIbtY2tuFdcIgqwItVx038lv/E//eaeQ1/b4B6TLm3sJsEfZHv8WWl4FgOe7dfS0
 hjvlPHEY/6JFEapch4FvJKzYySlnYPobhjMjJDtOWMRA/1Qs0Bw0MrDv//ZwUNYv7lW85AieB29
 3YRt0jgoDUiLPDzktWYuEgHHoVqquZRsJNz7qkMmRPnv3pcJjH6LG6kwIcFlBU+89qikX8nlR/M
 mFcqDyUmXCLePjvFJZxo78hnBzt0+ErSTcvGDQtTvo7RRmA9Tjim9r70d5Qix1MjVTdjW8DWYp5
 7qBAn12WdYUok0gDwEjFbinoC1iNgsxjRMnvDfY2TRTqh6nuc6AIADKHQUfof/5k+Sr+3R57/8i
 TOButJP9VFnl7MLpAPg==
X-Proofpoint-ORIG-GUID: J5tuDzUqGC9vPDwAi_Fr5REnIn5TQoQX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX/JCyYanwaQb2
 2LfxVUjWRR61/9ZGtl1hXCv3tsTUeI6dNRpc6nf0j1v2DcTQt2gNpCyxZR3idBa5+mQV2Y4sAhH
 ves4S9FkdDGhuEvnVdtpef4MGgbcTzs=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a835953 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=tR4rV30ZD3m4PndClJ0A:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-GUID: ESqTyNxlImq_Llnkwe-VSsA93h9hUDDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170142
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Devices where the MSI-X addresses are shared with other MMIO on BAR0
can not use msi_enable because it unmaps and remaps BAR0, which
interferes with device MMIO mappings. xhci-nec is one such device we
would like to test with msix.

Use the BAR iomap tracking structure introduced in the previous change
to have qpci_misx_enable() use existing iomaps if msix bars are
already mapped.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.c | 40 ++++++++++++++++++++++++++++++++++------
 tests/qtest/libqos/pci.h |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 3d953d23..19fd991c 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -274,15 +274,21 @@ void qpci_msix_enable(QPCIDevice *dev)
 
     table = qpci_config_readl(dev, addr + PCI_MSIX_TABLE);
     bir_table = table & PCI_MSIX_FLAGS_BIRMASK;
-    dev->msix_table_bar = qpci_iomap(dev, bir_table, NULL);
+    if (dev->bars_mapped[bir_table]) {
+        dev->msix_table_bar = dev->bars[bir_table];
+    } else {
+        dev->msix_table_bar_iomap = true;
+        dev->msix_table_bar = qpci_iomap(dev, bir_table, NULL);
+    }
     dev->msix_table_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
     table = qpci_config_readl(dev, addr + PCI_MSIX_PBA);
     bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
-    if (bir_pba != bir_table) {
-        dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
+    if (dev->bars_mapped[bir_pba]) {
+        dev->msix_pba_bar = dev->bars[bir_pba];
     } else {
-        dev->msix_pba_bar = dev->msix_table_bar;
+        dev->msix_pba_bar_iomap = true;
+        dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
     }
     dev->msix_pba_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
@@ -293,6 +299,7 @@ void qpci_msix_disable(QPCIDevice *dev)
 {
     uint8_t addr;
     uint16_t val;
+    uint32_t table;
 
     g_assert(dev->msix_enabled);
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
@@ -301,10 +308,31 @@ void qpci_msix_disable(QPCIDevice *dev)
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
                                                 val & ~PCI_MSIX_FLAGS_ENABLE);
 
-    if (dev->msix_pba_bar.addr != dev->msix_table_bar.addr) {
+    if (dev->msix_pba_bar_iomap) {
+        dev->msix_pba_bar_iomap = false;
         qpci_iounmap(dev, dev->msix_pba_bar);
+    } else {
+        /*
+         * If we had reused an existing iomap, ensure it is still mapped
+         * otherwise it would be a bug if it were unmapped before msix is
+         * disabled. A refcounting iomap implementation could avoid this
+         * issue entirely, but let's wait until that's needed.
+         */
+        uint8_t bir_pba;
+        table = qpci_config_readl(dev, addr + PCI_MSIX_PBA);
+        bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
+        g_assert(dev->bars_mapped[bir_pba]);
+    }
+
+    if (dev->msix_table_bar_iomap) {
+        dev->msix_table_bar_iomap = false;
+        qpci_iounmap(dev, dev->msix_table_bar);
+    } else {
+        uint8_t bir_table;
+        table = qpci_config_readl(dev, addr + PCI_MSIX_TABLE);
+        bir_table = table & PCI_MSIX_FLAGS_BIRMASK;
+        g_assert(dev->bars_mapped[bir_table]);
     }
-    qpci_iounmap(dev, dev->msix_table_bar);
 
     dev->msix_enabled = 0;
     dev->msix_table_off = 0;
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 73739afe..3f256241 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -75,6 +75,7 @@ struct QPCIDevice
     bool bars_mapped[QPCI_NUM_REGIONS];
     QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
+    bool msix_table_bar_iomap, msix_pba_bar_iomap;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
 };
-- 
2.55.0


