Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C90C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww2VP-0001V0-LY; Mon, 17 Aug 2026 14:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VO-0001Uq-IS
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1ww2VM-00064m-Us
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 14:56:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVUqg306822; Mon, 17 Aug 2026 18:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=8hLa4kZvHPMsfW5xH
 6dq0gO3OotG60epaINauyKjIFY=; b=kvuWTm2z4gpZ+x5E1EeD2nxfGZD+qPSXL
 VNYDNRw9+e2+FaTcXDgSrQj3WhuWndMzKUTJAHtS8gAYL+JQidw1TR50DWE3biHe
 XoZ1YYjQVK/28P4hqsnFsPLVQzBcjUtW2vNfrdfeyQh3aBDNQzvZFVd6QVCMjJ1a
 pCuDYyCXdMXyk9RTxVyk6SF4lP+2o7dqxUmMU53bNAS78AT7nK+HcRKnsOZe6E+8
 gb5zp8almSygVJm/1QJluluATj5uUdgSNTCDm4q/g3xHXpv+A+SXsxtH4bcLzx1F
 kilqi4hNqkSm5wLbXxpfNvzCi9gm7sVkF1fbjWCSzZQ25VItjfu5A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqkujf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIfH3f029014;
 Mon, 17 Aug 2026 18:56:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y719x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 18:56:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HIu0T135586368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 18:56:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AABB20043;
 Mon, 17 Aug 2026 18:56:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE46620040;
 Mon, 17 Aug 2026 18:55:57 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com.com (unknown
 [9.124.209.12]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 18:55:57 +0000 (GMT)
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, philmd@linaro.org, farosas@suse.de,
 akihiko.odaki@daynix.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 david@gibson.dropbear.id.au, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v6 05/10] tests/qtest/ahci: unmap pci bar before reusing device
Date: Tue, 18 Aug 2026 00:25:35 +0530
Message-ID: <20260817185539.376740-6-jishnuvw@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
References: <20260817185539.376740-1-jishnuvw@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX4wIyfOASIMkQ
 ntVzsZx19YWYJdXhtW2WyQYLvnWho4r0bTwE/xrXHP6W9fzIajxN3L9pHk7KHKJxu11KGNV+5x2
 rqoKEd48CSBf7XbcTAkhi7kMmoeVKbLwCGbz07WXNkUhAvuTeRPtgPuRlryVRcPUG++Vf4TZvUH
 lVmAaBBRbzZEhhy4CsQ5w7FPHCSl9jDOQjjJP6OOwEUW8nTuBCQWYk3GRMTQKYCdoCNM0Oiq0HH
 oH+YFiBgzoWX9jXnoeKpTPsaqXHBvhN1GWyibCy8iaRXTMtdHXXZAt+FhQoqz7u17nilgLQYxTo
 gpVp+a900yVym92UxJFEbrsaOzrDM4RJ4lIoBKSWgakoWC2c+UgqfyupsVv0yp0/0HlBsSDpwj0
 CsYqIeB4bsZjHOy9MXA2QV0ebUzwFGq6F+DdlraM6dYOIrdFQHA/ahErMcicOrdpPkrTDjYiglD
 nS5NIohdHF4Oholqw2Q==
X-Proofpoint-ORIG-GUID: 50x28ilvKsnAZCt5CMJyglt1Cqgu-hOD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0MiBTYWx0ZWRfX5/EHb6NT8WNI
 6HvOW5nPmnuPd/+OsCXKs+SWurZWQ73VXkT/QaKsvFqNCvh/UzNATR5IrYclhDVA8PFagWqTynF
 ca6zR60bl9QJh3c9nGSvcr/4Tm7SJHs=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a835945 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=Ci0EKXxUD1kjS9cOYUUA:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-GUID: wwoPC8i6tgLlF4TVLZmGyQSSvL0htiu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1011 bulkscore=0
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

ahci-test double-maps the hba bar in the pending_callback test.
Unmap it first, to keep iomaps balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/ahci-test.c   |  4 ++++
 tests/qtest/libqos/ahci.c | 11 +++++++++++
 tests/qtest/libqos/ahci.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 44799eea..64bbdd49 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -198,6 +198,7 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
+    ahci_pci_disable(ahci);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -1418,6 +1419,7 @@ static void test_reset(void)
                                CMD_READ_DMA_EXT,
                                CMD_WRITE_DMA_EXT);
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
+        stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
     }
 
@@ -1484,6 +1486,7 @@ static void test_reset_pending_callback(void)
     sleep(1);
 
     /* Start again. */
+    stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
     ahci_pci_enable(ahci);
     ahci_hba_enable(ahci);
@@ -1502,6 +1505,7 @@ static void test_reset_pending_callback(void)
     ahci_free(ahci, ptr1);
     ahci_free(ahci, ptr2);
 
+    stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
 
     ahci_shutdown(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 0621a6c4..f5859c6e 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -205,6 +205,11 @@ void ahci_pci_enable(AHCIQState *ahci)
 
 }
 
+void ahci_pci_disable(AHCIQState *ahci)
+{
+    stop_ahci_device(ahci);
+}
+
 /**
  * Map BAR5/ABAR, and engage the PCI device.
  */
@@ -217,6 +222,12 @@ void start_ahci_device(AHCIQState *ahci)
     qpci_device_enable(ahci->dev);
 }
 
+void stop_ahci_device(AHCIQState *ahci)
+{
+    /* Unmap AHCI's ABAR */
+    qpci_iounmap(ahci->dev, ahci->hba_bar);
+}
+
 /**
  * Test and initialize the AHCI's HBA memory areas.
  * Initialize and start any ports with devices attached.
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a15..f610bd32 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -574,7 +574,9 @@ void ahci_clean_mem(AHCIQState *ahci);
 QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
+void ahci_pci_disable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
+void stop_ahci_device(AHCIQState *ahci);
 void ahci_hba_enable(AHCIQState *ahci);
 
 /* Port Management */
-- 
2.55.0


