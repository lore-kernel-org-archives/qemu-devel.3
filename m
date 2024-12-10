Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6725E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnlN-0004l2-LJ; Mon, 09 Dec 2024 19:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlI-0004iu-IU; Mon, 09 Dec 2024 19:06:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlC-0001p4-OL; Mon, 09 Dec 2024 19:05:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9IlHAs015473;
 Tue, 10 Dec 2024 00:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7fiRmwjPWeVLDV5BT
 EW51cdtZvzKx5pQJdmGYeM+SLk=; b=eUuAS47bGtinVQsXeyD+4fQQcJG6w6dqS
 ci2o9tR/O7LScSFqxN4/3IKfyMR0w1AlGQq8StwU8QD2PHPmBNF1QdalZsZnqXoB
 iIZ6qv+bFPzfT2o6aJ75nyH6Kw2nfXFqN1j/17PyuRnIn5v38oIzei03f4Cz3x1n
 A70Z6XFwW6yij0w2W4laHzKvpPj68gUE+3UQE9yHFCMndo4RF3m0Jrj87Fu/96tg
 G4eXG1UlRd/tv5IM3fmyWuqdewnPCVe7SLdiCqKvYtRvvK7rPjgPM7FbMWxPhv4o
 xwuV7fxmDFTB93PXkbRVEa6Zpj8+M3ZXAZtaUDgqbfVIR7WvnEECQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjb9w6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:47 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA012kF001573;
 Tue, 10 Dec 2024 00:05:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjb9vx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9N03VV018618;
 Tue, 10 Dec 2024 00:05:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k8y6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05g1i60555562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33F7F20043;
 Tue, 10 Dec 2024 00:05:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6128820040;
 Tue, 10 Dec 2024 00:05:40 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:40 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 02/14] ppc/xive: Rename ipb_to_pipr() to xive_ipb_to_pipr()
Date: Mon,  9 Dec 2024 18:05:06 -0600
Message-Id: <20241210000527.9541-4-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TG7Bs4_r91cKNfv3-4rVJPBY-kGwybt5
X-Proofpoint-ORIG-GUID: xo22dq6_o3PJnW30dSJX7nPEFF2AQGjS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=614
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412090187
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Renamed function to follow the convention of the other function names.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h | 16 ++++++++++++----
 hw/intc/xive.c        | 22 ++++++----------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ebee982528..41a4263a9d 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -130,11 +130,9 @@
  *   TCTX   Thread interrupt Context
  *
  *
- * Copyright (c) 2017-2018, IBM Corporation.
- *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * Copyright (c) 2017-2024, IBM Corporation.
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE_H
@@ -510,6 +508,16 @@ static inline uint8_t xive_priority_to_ipb(uint8_t priority)
         0 : 1 << (XIVE_PRIORITY_MAX - priority);
 }
 
+/*
+ * Convert an Interrupt Pending Buffer (IPB) register to a Pending
+ * Interrupt Priority Register (PIPR), which contains the priority of
+ * the most favored pending notification.
+ */
+static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
+{
+    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
+}
+
 /*
  * XIVE Thread Interrupt Management Aera (TIMA)
  *
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 245e4d181a..7b06a48139 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -3,8 +3,7 @@
  *
  * Copyright (c) 2017-2018, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
@@ -27,15 +26,6 @@
  * XIVE Thread Interrupt Management context
  */
 
-/*
- * Convert an Interrupt Pending Buffer (IPB) register to a Pending
- * Interrupt Priority Register (PIPR), which contains the priority of
- * the most favored pending notification.
- */
-static uint8_t ipb_to_pipr(uint8_t ibp)
-{
-    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
-}
 
 static uint8_t exception_mask(uint8_t ring)
 {
@@ -159,7 +149,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
      * Recompute the PIPR based on local pending interrupts.  The PHYS
      * ring must take the minimum of both the PHYS and POOL PIPR values.
      */
-    pipr_min = ipb_to_pipr(regs[TM_IPB]);
+    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
     ring_min = ring;
 
     /* PHYS updates also depend on POOL values */
@@ -169,7 +159,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         /* POOL values only matter if POOL ctx is valid */
         if (pool_regs[TM_WORD2] & 0x80) {
 
-            uint8_t pool_pipr = ipb_to_pipr(pool_regs[TM_IPB]);
+            uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
 
             /*
              * Determine highest priority interrupt and
@@ -193,7 +183,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
     uint8_t *regs = &tctx->regs[ring];
 
     regs[TM_IPB] |= ipb;
-    regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
+    regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
     xive_tctx_notify(tctx, ring);
 }
 
@@ -841,9 +831,9 @@ void xive_tctx_reset(XiveTCTX *tctx)
      * CPPR is first set.
      */
     tctx->regs[TM_QW1_OS + TM_PIPR] =
-        ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
+        xive_ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
     tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =
-        ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
+        xive_ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
 }
 
 static void xive_tctx_realize(DeviceState *dev, Error **errp)
-- 
2.43.0


