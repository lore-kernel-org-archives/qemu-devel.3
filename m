Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68F2E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnlg-0004mp-7c; Mon, 09 Dec 2024 19:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlJ-0004jO-KZ; Mon, 09 Dec 2024 19:06:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlF-0001pK-2Q; Mon, 09 Dec 2024 19:06:00 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9F3LLi014817;
 Tue, 10 Dec 2024 00:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7+/UgsdPg1jIT9vtO
 cDkXs2w6qq0NpPlXgAuaEAO2+E=; b=KTQDFnJomnsL+z8+/OzFnMF79ywJh3Jxs
 EBmYxScid47TyDLGsLPjjfr+dB8ewAd1Bi6YuhHn97B67vK+NMvekHwPcYblad8B
 2nl+Udi+I8+qnc7qL6G8AIYx+Hhsm0sKPGfxHik3/SOl7A5zJ3mTzLKtEaCSJzXl
 i536npQ5deHdiHKhLyidReGJKFw8KHGLmCQHMpjU12HK7nMVWxkhEPzVBzIvCGZZ
 mCax81+Atg6jZ/7UZQVrWgSoIfa+p6idtq07AsnUIpBKrGlY4rz+sDIaJiGsgxiz
 OzhxC6zYDZ+SwMgxXWS8O91JhUD8xI0VAu0kOlTf9O7JxnYjL8DJg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjb9wp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA05mU4012211;
 Tue, 10 Dec 2024 00:05:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjb9wf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9N5MtS032589;
 Tue, 10 Dec 2024 00:05:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pn1126-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05iX356820158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A2722004B;
 Tue, 10 Dec 2024 00:05:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 763B320040;
 Tue, 10 Dec 2024 00:05:42 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:42 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 03/14] ppc/xive2: Add grouping level to notification
Date: Mon,  9 Dec 2024 18:05:07 -0600
Message-Id: <20241210000527.9541-5-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LyJg91khB4MxUVYcAkivAsnihwC8YA__
X-Proofpoint-ORIG-GUID: auxIkrg0lt8YUnBPXB6Qh_xPF6BRSTRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

The NSR has a (so far unused) grouping level field. When a interrupt
is presented, that field tells the hypervisor or OS if the interrupt
is for an individual VP or for a VP-group/crowd. This patch reworks
the presentation API to allow to set/unset the level when
raising/accepting an interrupt.

It also renames xive_tctx_ipb_update() to xive_tctx_pipr_update() as
the IPB is only used for VP-specific target, whereas the PIPR always
needs to be updated.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h      |  9 +++-
 include/hw/ppc/xive_regs.h | 25 ++++++++---
 hw/intc/xive.c             | 88 ++++++++++++++++++++++----------------
 hw/intc/xive2.c            | 19 ++++----
 hw/intc/trace-events       |  2 +-
 5 files changed, 90 insertions(+), 53 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 41a4263a9d..4d1ce376f1 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -508,6 +508,11 @@ static inline uint8_t xive_priority_to_ipb(uint8_t priority)
         0 : 1 << (XIVE_PRIORITY_MAX - priority);
 }
 
+static inline uint8_t xive_priority_to_pipr(uint8_t priority)
+{
+    return priority > XIVE_PRIORITY_MAX ? 0xFF : priority;
+}
+
 /*
  * Convert an Interrupt Pending Buffer (IPB) register to a Pending
  * Interrupt Priority Register (PIPR), which contains the priority of
@@ -540,8 +545,10 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf);
 Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
-void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
+void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                           uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
+void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
 
 /*
  * KVM XIVE device helpers
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 326327fc79..54bc6c53b4 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -7,10 +7,9 @@
  * access to the different fields.
  *
  *
- * Copyright (c) 2016-2018, IBM Corporation.
+ * Copyright (c) 2016-2024, IBM Corporation.
  *
- * This code is licensed under the GPL version 2 or later. See the
- * COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef PPC_XIVE_REGS_H
@@ -146,7 +145,14 @@
 #define TM_SPC_PULL_PHYS_CTX_OL 0xc38   /* Pull phys ctx to odd cache line    */
 /* XXX more... */
 
-/* NSR fields for the various QW ack types */
+/*
+ * NSR fields for the various QW ack types
+ *
+ * P10 has an extra bit in QW3 for the group level instead of the
+ * reserved 'i' bit. Since it is not used and we don't support group
+ * interrupts on P9, we use the P10 definition for the group level so
+ * that we can have common macros for the NSR
+ */
 #define TM_QW0_NSR_EB           PPC_BIT8(0)
 #define TM_QW1_NSR_EO           PPC_BIT8(0)
 #define TM_QW3_NSR_HE           PPC_BITMASK8(0, 1)
@@ -154,8 +160,15 @@
 #define  TM_QW3_NSR_HE_POOL     1
 #define  TM_QW3_NSR_HE_PHYS     2
 #define  TM_QW3_NSR_HE_LSI      3
-#define TM_QW3_NSR_I            PPC_BIT8(2)
-#define TM_QW3_NSR_GRP_LVL      PPC_BIT8(3, 7)
+#define TM_NSR_GRP_LVL          PPC_BITMASK8(2, 7)
+/*
+ * On P10, the format of the 6-bit group level is: 2 bits for the
+ * crowd size and 4 bits for the group size. Since group/crowd size is
+ * always a power of 2, we encode the log. For example, group_level=4
+ * means crowd size = 0 and group size = 16 (2^4)
+ * Same encoding is used in the NVP and NVGC structures for
+ * PGoFirst and PGoNext fields
+ */
 
 /*
  * EAS (Event Assignment Structure)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7b06a48139..d2690a7d10 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -26,19 +26,6 @@
  * XIVE Thread Interrupt Management context
  */
 
-
-static uint8_t exception_mask(uint8_t ring)
-{
-    switch (ring) {
-    case TM_QW1_OS:
-        return TM_QW1_NSR_EO;
-    case TM_QW3_HV_PHYS:
-        return TM_QW3_NSR_HE;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
 {
         switch (ring) {
@@ -58,11 +45,10 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs = &tctx->regs[ring];
     uint8_t nsr = regs[TM_NSR];
-    uint8_t mask = exception_mask(ring);
 
     qemu_irq_lower(xive_tctx_output(tctx, ring));
 
-    if (regs[TM_NSR] & mask) {
+    if (regs[TM_NSR] != 0) {
         uint8_t cppr = regs[TM_PIPR];
         uint8_t alt_ring;
         uint8_t *alt_regs;
@@ -77,11 +63,18 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
         regs[TM_CPPR] = cppr;
 
-        /* Reset the pending buffer bit */
-        alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        /*
+         * If the interrupt was for a specific VP, reset the pending
+         * buffer bit, otherwise clear the logical server indicator
+         */
+        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
+            regs[TM_NSR] &= ~TM_NSR_GRP_LVL;
+        } else {
+            alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        }
 
-        /* Drop Exception bit */
-        regs[TM_NSR] &= ~mask;
+        /* Drop the exception bit and any group/crowd */
+        regs[TM_NSR] = 0;
 
         trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
                                alt_regs[TM_IPB], regs[TM_PIPR],
@@ -91,7 +84,7 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
     return ((uint64_t)nsr << 8) | regs[TM_CPPR];
 }
 
-static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
+void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
 {
     /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
     uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
@@ -101,13 +94,13 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
     if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
-            regs[TM_NSR] |= TM_QW1_NSR_EO;
+            regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
             break;
         case TM_QW2_HV_POOL:
-            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6);
+            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
             break;
         case TM_QW3_HV_PHYS:
-            regs[TM_NSR] |= (TM_QW3_NSR_HE_PHYS << 6);
+            regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
             break;
         default:
             g_assert_not_reached();
@@ -175,17 +168,27 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     regs[TM_PIPR] = pipr_min;
 
     /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring_min);
+    xive_tctx_notify(tctx, ring_min, 0);
 }
 
-void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
-{
+void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                           uint8_t group_level)
+ {
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *alt_regs = &tctx->regs[alt_ring];
     uint8_t *regs = &tctx->regs[ring];
 
-    regs[TM_IPB] |= ipb;
-    regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
-    xive_tctx_notify(tctx, ring);
-}
+    if (group_level == 0) {
+        /* VP-specific */
+        regs[TM_IPB] |= xive_priority_to_ipb(priority);
+        alt_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+    } else {
+        /* VP-group */
+        alt_regs[TM_PIPR] = xive_priority_to_pipr(priority);
+    }
+    xive_tctx_notify(tctx, ring, group_level);
+ }
 
 /*
  * XIVE Thread Interrupt Management Area (TIMA)
@@ -401,13 +404,13 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
 }
 
 /*
- * Adjust the IPB to allow a CPU to process event queues of other
+ * Adjust the PIPR to allow a CPU to process event queues of other
  * priorities during one physical interrupt cycle.
  */
 static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
                                    hwaddr offset, uint64_t value, unsigned size)
 {
-    xive_tctx_ipb_update(tctx, TM_QW1_OS, xive_priority_to_ipb(value & 0xff));
+    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
 }
 
 static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
@@ -485,16 +488,20 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
         /* Reset the NVT value */
         nvt.w4 = xive_set_field32(NVT_W4_IPB, nvt.w4, 0);
         xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
+
+        uint8_t *regs = &tctx->regs[TM_QW1_OS];
+        regs[TM_IPB] |= ipb;
     }
+
     /*
-     * Always call xive_tctx_ipb_update(). Even if there were no
+     * Always call xive_tctx_pipr_update(). Even if there were no
      * escalation triggered, there could be a pending interrupt which
      * was saved when the context was pulled and that we need to take
      * into account by recalculating the PIPR (which is not
      * saved/restored).
      * It will also raise the External interrupt signal if needed.
      */
-    xive_tctx_ipb_update(tctx, TM_QW1_OS, ipb);
+    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
 }
 
 /*
@@ -1650,6 +1657,12 @@ static uint32_t xive_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
 }
 
+static uint8_t xive_get_group_level(uint32_t nvp_index)
+{
+    /* FIXME add crowd encoding */
+    return ctz32(~nvp_index) + 1;
+}
+
 /*
  * The thread context register words are in big-endian format.
  */
@@ -1735,6 +1748,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
 {
     XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xfb);
     XiveTCTXMatch match = { .tctx = NULL, .ring = 0 };
+    uint8_t group_level;
     int count;
 
     /*
@@ -1748,9 +1762,9 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
 
     /* handle CPU exception delivery */
     if (count) {
-        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring);
-        xive_tctx_ipb_update(match.tctx, match.ring,
-                             xive_priority_to_ipb(priority));
+        group_level = cam_ignore ? xive_get_group_level(nvt_idx) : 0;
+        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_level);
+        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
     }
 
     return !!count;
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 24e504fce1..54e4f784fc 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -563,8 +563,11 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    Xive2Nvp nvp;
     uint8_t ipb;
+    uint8_t backlog_level;
+    uint8_t backlog_prio;
+    uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    Xive2Nvp nvp;
 
     /*
      * Grab the associated thread interrupt context registers in the
@@ -593,15 +596,15 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
         nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
         xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
     }
+    regs[TM_IPB] = ipb;
+    backlog_prio = xive_ipb_to_pipr(ipb);
+    backlog_level = 0;
+
     /*
-     * Always call xive_tctx_ipb_update(). Even if there were no
-     * escalation triggered, there could be a pending interrupt which
-     * was saved when the context was pulled and that we need to take
-     * into account by recalculating the PIPR (which is not
-     * saved/restored).
-     * It will also raise the External interrupt signal if needed.
+     * Compute the PIPR based on the restored state.
+     * It will raise the External interrupt signal if needed.
      */
-    xive_tctx_ipb_update(tctx, TM_QW1_OS, ipb);
+    xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);
 }
 
 /*
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 3dcf147198..7435728c51 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -282,7 +282,7 @@ xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "EN
 xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
 xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
 xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
-xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring) "found NVT 0x%x/0x%x ring=0x%x"
+xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring, uint8_t group_level) "found NVT 0x%x/0x%x ring=0x%x group_level=%d"
 xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x/0x%x @0x%"PRIx64
 
 # pnv_xive.c
-- 
2.43.0


