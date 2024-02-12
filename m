Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A55C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 04:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZNid-0002vX-3S; Sun, 11 Feb 2024 23:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZNia-0002ul-Ok; Sun, 11 Feb 2024 23:14:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rZNiY-0008Rk-KZ; Sun, 11 Feb 2024 23:14:56 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C0UcFO011195; Mon, 12 Feb 2024 04:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Hq7sSZY4Qn6GgXF7kFY+HuKgqf2AQa2dn6o/1qkKKSM=;
 b=LiUAZ5kVdvP1k1uTAIxBNkrqeBchGBYdklzhz1gAqcddwB/KkqBrJzOBqNIFKQoN+av8
 coL4U/reYwLYccSrt9AIRmhxdAXUZ2MrqvK86eobgg3osm5Cz/P66OyWlNkefRORtgol
 PWFCCC+bkdEac/pP3O/zDC4EZv6HI2U23qABWzZjWLjWphdHN7jIzZRFULkktgLFrJ7j
 JUBP1mqLigy4/bf71frUFZsZZvcTCOONYQi0YOLuXXcWbacxu8NjrbkSqaw4kxotz429
 06cR6m98CoOsXvXtsB/7KoFBlVn8StVZm0cMWV4MvzUoY5Id0gVDTe/TrVYNKlx23vU3 Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w68v91paa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:40 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41C4DtNS020238;
 Mon, 12 Feb 2024 04:14:40 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w68v91pa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:40 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 41C0ntWH010083; Mon, 12 Feb 2024 04:14:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npke19a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Feb 2024 04:14:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 41C4EZHW18481878
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Feb 2024 04:14:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CE9F20043;
 Mon, 12 Feb 2024 04:14:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B660420040;
 Mon, 12 Feb 2024 04:14:33 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.179.18.54]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Feb 2024 04:14:33 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: kowsjois@linux.ibm.com, clg@kaod.org, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] ppc/spapr: Introduce SPAPR_IRQ_NR_IPIS to refer IRQ
 range for CPU IPIs.
Date: Mon, 12 Feb 2024 09:44:22 +0530
Message-Id: <20240212041423.293085-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212041423.293085-1-harshpb@linux.ibm.com>
References: <20240212041423.293085-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v_x3_J7oQ42lG8C2zPVByKSGrJgcY9_h
X-Proofpoint-ORIG-GUID: 4FzIWagxaK27YZtIRXY0Wzj9dWOP3LHr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_02,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120031
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
the range of CPU IPIs during initialization of nr-irqs property.
It is more appropriate to have its own define which can be further
reused as appropriate for correct interpretation.

Suggested-by: Cedric Le Goater <clg@kaod.org>
Tested-by: Kowshik Jois <kowsjois@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr_irq.h | 14 +++++++++++++-
 hw/ppc/spapr_irq.c         |  6 ++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..4fd2d5853d 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -14,9 +14,21 @@
 #include "qom/object.h"
 
 /*
- * IRQ range offsets per device type
+ * The XIVE IRQ backend uses the same layout as the XICS backend but
+ * covers the full range of the IRQ number space. The IRQ numbers for
+ * the CPU IPIs are allocated at the bottom of this space, below 4K,
+ * to preserve compatibility with XICS which does not use that range.
+ */
+
+/*
+ * CPU IPI range (XIVE only)
  */
 #define SPAPR_IRQ_IPI        0x0
+#define SPAPR_IRQ_NR_IPIS    0x1000
+
+/*
+ * IRQ range offsets per device type
+ */
 
 #define SPAPR_XIRQ_BASE      XICS_IRQ_BASE /* 0x1000 */
 #define SPAPR_IRQ_EPOW       (SPAPR_XIRQ_BASE + 0x0000)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a0d1e1298e..97b2fc42ab 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -23,6 +23,8 @@
 
 #include "trace.h"
 
+QEMU_BUILD_BUG_ON(SPAPR_IRQ_NR_IPIS > SPAPR_XIRQ_BASE);
+
 static const TypeInfo spapr_intc_info = {
     .name = TYPE_SPAPR_INTC,
     .parent = TYPE_INTERFACE,
@@ -329,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
+        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -356,7 +358,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
+                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
-- 
2.39.3


