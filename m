Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E094ECE58A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlfT-00024R-1j; Mon, 09 Sep 2024 17:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlfM-0001bj-Rl; Mon, 09 Sep 2024 17:11:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlfL-00029D-89; Mon, 09 Sep 2024 17:11:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489AwxQ2012431;
 Mon, 9 Sep 2024 21:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=+blF6B1cKfi5z
 4fI90QzkCrCDtxnSNjpzrGDY5pD8us=; b=XXcnWihuB+/OnhIKAlESVjTGVIA+Q
 g0ogaMf8uhFAU/CyiUt0f9UkfMcy9CyQgCFApYGVH17rL/o5RhUuKUT0wdT8uiEB
 7JlGeH8iIZJOlZKLwA6TcGS0K4XxcHjtgbFTmRwtGwFmg6v/hw//vMwyeRsFqNpn
 0XQqwSTh8S7D04ZDklABwGfhZo2elzn3PHZmY8OYrQYsclU8owda6jQV/NSrMRSM
 Z8GeHNrFGumZNLQ/ZJi0I5NzYWfyhS09zQz+6JSKoPX+mo/qFnmfOPj3VPRC0qmM
 qndzAvA7Y5cVJv5o1Ilv2yRlKpMb5XHbnFpecGicU/7CxzxnVbb+SVaBg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejac1wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489LB9oh009048;
 Mon, 9 Sep 2024 21:11:09 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejac1wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489Kwr0X027333;
 Mon, 9 Sep 2024 21:11:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3v2yyap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489LB4O721430696
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 21:11:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C7E620040;
 Mon,  9 Sep 2024 21:11:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5022C20049;
 Mon,  9 Sep 2024 21:11:03 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 21:11:03 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 12/14] pnv/xive: Update PIPR when updating CPPR
Date: Mon,  9 Sep 2024 16:10:36 -0500
Message-Id: <20240909211038.27440-13-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909211038.27440-1-kowal@linux.ibm.com>
References: <20240909211038.27440-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hL0sZ_T0hjaBliPlA_f6XDIIYq-yJGaH
X-Proofpoint-GUID: oyzNoMjKzKdAX8MeCCQTKf2xzbwEjOc6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=835 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409090166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Glenn Miles <milesg@linux.ibm.com>

Current code was updating the PIPR inside the xive_tctx_accept() function
instead of the xive_tctx_set_cppr function, which is where the HW would
have it updated.

Moved the update to the xive_tctx_set_cppr function which required
additional support for pool interrupts.

Fixes: cdd4de68edb6 ("ppc/xive: notify the CPU when the interrupt priority is more privileged")
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/xive.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5c5c3a2dd6..738eaf624d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -89,7 +89,6 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
         /* Reset the pending buffer bit */
         alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
-        regs[TM_PIPR] = ipb_to_pipr(alt_regs[TM_IPB]);
 
         /* Drop Exception bit */
         regs[TM_NSR] &= ~mask;
@@ -143,6 +142,8 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
+    uint8_t pipr_min;
+    uint8_t ring_min;
 
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
                              regs[TM_IPB], regs[TM_PIPR],
@@ -154,8 +155,37 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
     tctx->regs[ring + TM_CPPR] = cppr;
 
+    /*
+     * Recompute the PIPR based on local pending interrupts.  The PHYS
+     * ring must take the minimum of both the PHYS and POOL PIPR values.
+     */
+    pipr_min = ipb_to_pipr(regs[TM_IPB]);
+    ring_min = ring;
+
+    /* PHYS updates also depend on POOL values */
+    if (ring == TM_QW3_HV_PHYS) {
+        uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
+
+        /* POOL values only matter if POOL ctx is valid */
+        if (pool_regs[TM_WORD2] & 0x80) {
+
+            uint8_t pool_pipr = ipb_to_pipr(pool_regs[TM_IPB]);
+
+            /*
+             * Determine highest priority interrupt and
+             * remember which ring has it.
+             */
+            if (pool_pipr < pipr_min) {
+                pipr_min = pool_pipr;
+                ring_min = TM_QW2_HV_POOL;
+            }
+        }
+    }
+
+    regs[TM_PIPR] = pipr_min;
+
     /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring);
+    xive_tctx_notify(tctx, ring_min);
 }
 
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
-- 
2.43.0


