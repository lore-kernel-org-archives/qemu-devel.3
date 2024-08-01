Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E09EC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRx-0004Yr-7V; Thu, 01 Aug 2024 16:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRp-000458-Sx; Thu, 01 Aug 2024 16:30:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRn-0007WK-DH; Thu, 01 Aug 2024 16:30:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471JwQKO003734;
 Thu, 1 Aug 2024 20:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=y1kVsShngc6Dx
 roKCCsBIShS3kFwoG5KVOHk++1Pvl4=; b=YavCr5vEs8C9u8H8I7uyPaPynDSq6
 E5OU59MntSVp8KtfBPWqVqG2C/yiHMbiI2zb6ms4QYzEldLg3z/IQorV5u0GCL08
 dGfVoYquJlBfbZ9LfQGs759Xw9PDpMaM12pTmz6vucO+ypk3HMxpCQnIlwkhvezL
 Q2FZAZUGtpze71VoABcOr+mykTCSBaGYxLM3o9YdkbaoVR2fUPzLCEVwg8zji2Lf
 ISAMJRWSgt2jhC7D0uwfPtfB+vN5QS7rCXRLm7175MJYg4rz+V7/+IHh/oPpxZHD
 Q1k5khhMyQc5Jd36nVQGue3SAqvjrfFHsf4YAtM5gqn2jBhHl2hhz3DOg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh02r222-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUe5m024056;
 Thu, 1 Aug 2024 20:30:40 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rh02r21x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471IlK7P018928; Thu, 1 Aug 2024 20:30:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q3rfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUXvk50528576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98FAA20040;
 Thu,  1 Aug 2024 20:30:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F56E2004E;
 Thu,  1 Aug 2024 20:30:32 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:32 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 10/13] pnv/xive: Add special handling for pool targets
Date: Thu,  1 Aug 2024 15:30:05 -0500
Message-Id: <20240801203008.11224-11-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PCYZ-joJHRihGI6RY_o_3rIAFZkgw6PC
X-Proofpoint-GUID: zGrqMBPcP9c9Mp2WpqhR2E0Qn2Uzu2zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
index 9d85da0999..5c4ca7f6e0 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -67,25 +67,35 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
 static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs = &tctx->regs[ring];
-    uint8_t nsr = regs[TM_NSR];
+    uint64_t nsr = regs[TM_NSR];
     uint8_t mask = exception_mask(ring);
 
     qemu_irq_lower(xive_tctx_output(tctx, ring));
 
     if (regs[TM_NSR] & mask) {
         uint8_t cppr = regs[TM_PIPR];
+        uint8_t alt_ring;
+        uint8_t *aregs;
+
+        /* POOL interrupt uses IPB in QW2, POOL ring */
+        if ((ring == TM_QW3_HV_PHYS) && (nsr & (TM_QW3_NSR_HE_POOL << 6))) {
+            alt_ring = TM_QW2_HV_POOL;
+        } else {
+            alt_ring = ring;
+        }
+        aregs = &tctx->regs[alt_ring];
 
         regs[TM_CPPR] = cppr;
 
         /* Reset the pending buffer bit */
-        regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
-        regs[TM_PIPR] = ipb_to_pipr(regs[TM_IPB]);
+        aregs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        regs[TM_PIPR] = ipb_to_pipr(aregs[TM_IPB]);
 
         /* Drop Exception bit */
         regs[TM_NSR] &= ~mask;
 
-        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], regs[TM_PIPR],
+        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
+                               aregs[TM_IPB], regs[TM_PIPR],
                                regs[TM_CPPR], regs[TM_NSR]);
     }
 
@@ -94,13 +104,19 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
 static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
 {
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *aregs = &tctx->regs[alt_ring];
     uint8_t *regs = &tctx->regs[ring];
 
-    if (regs[TM_PIPR] < regs[TM_CPPR]) {
+    if (aregs[TM_PIPR] < aregs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
             regs[TM_NSR] |= TM_QW1_NSR_EO;
             break;
+        case TM_QW2_HV_POOL:
+            aregs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6);
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
+                               regs[TM_IPB], aregs[TM_PIPR],
+                               aregs[TM_CPPR], aregs[TM_NSR]);
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


