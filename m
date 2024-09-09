Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFB1ECE58A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlfS-00021I-Ax; Mon, 09 Sep 2024 17:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlfK-0001Tg-Py; Mon, 09 Sep 2024 17:11:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlfI-00028n-AF; Mon, 09 Sep 2024 17:11:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489ChANq017360;
 Mon, 9 Sep 2024 21:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=8sunMnr9m1sKX
 NjLTlVR7hkWEfwjq1cxf/pyLya9XF0=; b=IENy3xHEvHCAOPl+7VrQKnRsUe9I3
 Hmwav6hFbUsxkBq7M3PKnWHQfM1owOO9IA8je4uE5SU65yphJjNrXSXQREiDaPoa
 RjeIHX2QOVIj0SIVMYOn4zJHpeSVbm7zjZGd4KQytR77vEV/YrHwk5ZyH72T58T5
 Gi5nFNVD2mUgL+8C6GcirmpC9VL9REeCJAcV1d8d0FxvUxFrHsQfLBVydhhNcSKh
 0vrXesXNISQBFsh8WJ3PShcbmAEfVM3/Q6+QY5FbwuYvvSSOAkTGMJI/6yKw7c0a
 i85/SOcS0oJDNI1833gvYCtG3iiV0hqwkQFRHCosmlkISF0fQcsHtYi+g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefybxtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489L9Had009752;
 Mon, 9 Sep 2024 21:11:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefybxtp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489J1RCo032611;
 Mon, 9 Sep 2024 21:11:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0gdqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:06 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489LB36Y50594126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 21:11:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B0542004B;
 Mon,  9 Sep 2024 21:11:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D2CD620040;
 Mon,  9 Sep 2024 21:11:01 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 21:11:01 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 11/14] pnv/xive: Add special handling for pool targets
Date: Mon,  9 Sep 2024 16:10:35 -0500
Message-Id: <20240909211038.27440-12-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909211038.27440-1-kowal@linux.ibm.com>
References: <20240909211038.27440-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7ovlGf2vkoyhGm6C4eYNtj8bJVY_BB-h
X-Proofpoint-ORIG-GUID: a-TomNj05E4j0dvyDhIBWkoP9h2nbsEN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

Hypervisor "pool" targets do not get their own interrupt line and instead
must share an interrupt line with the hypervisor "physical" targets.
This also means that the pool ring must use some of the registers from the
physical ring in the TIMA.  Specifically, the NSR, PIPR and CPPR registers:

  NSR = Notification Source Register
  PIPR = Post Interrupt Priority Register
  CPPR = Current Processor Priority Register

The NSR specifies that there is an active interrupt.  The CPPR
specifies the priority of the context and the PIPR specifies the
priority of the interrupt.  For an interrupt to be presented to
a context, the priority of the interrupt must be higher than the
priority of the context it is interrupting (value must be lower).

The existing code was not aware of the sharing of these registers.
This commit adds that support.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/xive.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9d85da0999..5c5c3a2dd6 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -74,33 +74,49 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
     if (regs[TM_NSR] & mask) {
         uint8_t cppr = regs[TM_PIPR];
+        uint8_t alt_ring;
+        uint8_t *alt_regs;
+
+        /* POOL interrupt uses IPB in QW2, POOL ring */
+        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
+            alt_ring = TM_QW2_HV_POOL;
+        } else {
+            alt_ring = ring;
+        }
+        alt_regs = &tctx->regs[alt_ring];
 
         regs[TM_CPPR] = cppr;
 
         /* Reset the pending buffer bit */
-        regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
-        regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
+        alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        regs[TM_PIPR] = ipb_to_pipr(alt_regs[TM_IPB]);
 
         /* Drop Exception bit */
         regs[TM_NSR] &= ~mask;
 
-        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], regs[TM_PIPR],
+        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
+                               alt_regs[TM_IPB], regs[TM_PIPR],
                                regs[TM_CPPR], regs[TM_NSR]);
     }
 
-    return (nsr << 8) | regs[TM_CPPR];
+    return ((uint64_t)nsr << 8) | regs[TM_CPPR];
 }
 
 static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
 {
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *alt_regs = &tctx->regs[alt_ring];
     uint8_t *regs = &tctx->regs[ring];
 
-    if (regs[TM_PIPR] < regs[TM_CPPR]) {
+    if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
             regs[TM_NSR] |= TM_QW1_NSR_EO;
             break;
+        case TM_QW2_HV_POOL:
+            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6);
+            break;
         case TM_QW3_HV_PHYS:
             regs[TM_NSR] |= (TM_QW3_NSR_HE_PHYS << 6);
             break;
@@ -108,8 +124,8 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
             g_assert_not_reached();
         }
         trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], regs[TM_PIPR],
-                               regs[TM_CPPR], regs[TM_NSR]);
+                               regs[TM_IPB], alt_regs[TM_PIPR],
+                               alt_regs[TM_CPPR], alt_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
     }
 }
@@ -217,14 +233,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
 static const uint8_t xive_tm_hw_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
     3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
-    0, 0, 3, 3,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
+    0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
 };
 
 static const uint8_t xive_tm_hv_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
     3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
-    0, 0, 3, 3,   0, 0, 0, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
+    0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
 };
 
-- 
2.43.0


