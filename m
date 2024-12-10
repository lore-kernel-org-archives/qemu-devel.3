Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87039E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnnn-0007SE-3V; Mon, 09 Dec 2024 19:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlX-0004mC-8Y; Mon, 09 Dec 2024 19:06:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlU-0001sS-JT; Mon, 09 Dec 2024 19:06:14 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9M1OBt015519;
 Tue, 10 Dec 2024 00:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=zj1qexOSZEWjBo7UV
 v+NqHPSILh/U6lPkabYZ+Xajl8=; b=VryMP51FVUWxVDEl6UpOjGL/OuFQWtqhL
 //6uNmVB+L2sxnWNqQZ90SWMTsMJm/iIhUd/Fcqp+Q2SpAGcXSsqibZp/5id8CFi
 xV1juim3yW057dLwWN7sgIj1UI2Ie2YPvpmqOTo+F1fcNdepOm5lRbgyvJnWpdVB
 ptuAz4dsw23h/MPRQNJ/bgfQhcaTv8JhBeXe9T/ffVRjiW83tIMd8gqYNhUjE/f1
 SIZeVHBrl77NgCatMZo2CS9ur/Ine6r0VEbqKZjN5o0/A3S0TXFSdnrsEUW2DHRC
 6D2jw0R6TNWjOwl4LNusRVLA+J96QWREhX23QX82DbiRmAPC596YQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq3gh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA065PH029950;
 Tue, 10 Dec 2024 00:06:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq3gh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9MWFNX016930;
 Tue, 10 Dec 2024 00:06:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12y16us-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:06:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA0612g47972806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:06:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6AF620043;
 Tue, 10 Dec 2024 00:06:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2144D20040;
 Tue, 10 Dec 2024 00:05:59 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:58 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 07/14] ppc/xive2: Process group backlog when updating the
 CPPR
Date: Mon,  9 Dec 2024 18:05:15 -0600
Message-Id: <20241210000527.9541-13-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vsx7ZPKvg0BHAwvtjSAeLRXGGudPYu72
X-Proofpoint-GUID: usxwXRogDEwl8gPm84eEeIkbjLR_pbtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090187
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

When the hypervisor or OS pushes a new value to the CPPR, if the LSMFB
value is lower than the new CPPR value, there could be a pending group
interrupt in the backlog, so it needs to be scanned.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive2.h |   4 +
 hw/intc/xive.c         |   4 +-
 hw/intc/xive2.c        | 173 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 177 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index ebf301bb5b..fc7422fea7 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -113,6 +113,10 @@ typedef struct Xive2EndSource {
  * XIVE2 Thread Interrupt Management Area (POWER10)
  */
 
+void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 412bb94b91..308de5aefc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -589,7 +589,7 @@ static const XiveTmOp xive2_tm_operations[] = {
      * MMIOs below 2K : raw values and special operations without side
      * effects
      */
-    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr,
+    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive2_tm_set_os_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
@@ -597,7 +597,7 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
                                                      NULL },
-    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive2_tm_set_hv_cppr,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
                                                      NULL },
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index bb18a56e8f..47f7a099de 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -17,6 +17,7 @@
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
 #include "hw/ppc/xive2_regs.h"
+#include "trace.h"
 
 uint32_t xive2_router_get_config(Xive2Router *xrtr)
 {
@@ -767,6 +768,172 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
+                                      uint32_t *nvp_blk, uint32_t *nvp_idx)
+{
+    uint32_t w2, cam;
+
+    w2 = xive_tctx_word2(&tctx->regs[ring]);
+    switch (ring) {
+    case TM_QW1_OS:
+        if (!(be32_to_cpu(w2) & TM2_QW1W2_VO)) {
+            return -1;
+        }
+        cam = xive_get_field32(TM2_QW1W2_OS_CAM, w2);
+        break;
+    case TM_QW2_HV_POOL:
+        if (!(be32_to_cpu(w2) & TM2_QW2W2_VP)) {
+            return -1;
+        }
+        cam = xive_get_field32(TM2_QW2W2_POOL_CAM, w2);
+        break;
+    case TM_QW3_HV_PHYS:
+        if (!(be32_to_cpu(w2) & TM2_QW3W2_VT)) {
+            return -1;
+        }
+        cam = xive2_tctx_hw_cam_line(tctx->xptr, tctx);
+        break;
+    default:
+        return -1;
+    }
+    *nvp_blk = xive2_nvp_blk(cam);
+    *nvp_idx = xive2_nvp_idx(cam);
+    return 0;
+}
+
+static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
+{
+    uint8_t *regs = &tctx->regs[ring];
+    Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
+    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
+    uint8_t pipr_min, lsmfb_min, ring_min;
+    bool group_enabled;
+    uint32_t nvp_blk, nvp_idx;
+    Xive2Nvp nvp;
+    int rc;
+
+    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
+                             regs[TM_IPB], regs[TM_PIPR],
+                             cppr, regs[TM_NSR]);
+
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr = 0xff;
+    }
+
+    old_cppr = regs[TM_CPPR];
+    regs[TM_CPPR] = cppr;
+
+    /*
+     * Recompute the PIPR based on local pending interrupts. It will
+     * be adjusted below if needed in case of pending group interrupts.
+     */
+    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
+    group_enabled = !!regs[TM_LGS];
+    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
+    ring_min = ring;
+
+    /* PHYS updates also depend on POOL values */
+    if (ring == TM_QW3_HV_PHYS) {
+        uint8_t *pregs = &tctx->regs[TM_QW2_HV_POOL];
+
+        /* POOL values only matter if POOL ctx is valid */
+        if (pregs[TM_WORD2] & 0x80) {
+
+            uint8_t pool_pipr = xive_ipb_to_pipr(pregs[TM_IPB]);
+            uint8_t pool_lsmfb = pregs[TM_LSMFB];
+
+            /*
+             * Determine highest priority interrupt and
+             * remember which ring has it.
+             */
+            if (pool_pipr < pipr_min) {
+                pipr_min = pool_pipr;
+                if (pool_pipr < lsmfb_min) {
+                    ring_min = TM_QW2_HV_POOL;
+                }
+            }
+
+            /* Values needed for group priority calculation */
+            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
+                group_enabled = true;
+                lsmfb_min = pool_lsmfb;
+                if (lsmfb_min < pipr_min) {
+                    ring_min = TM_QW2_HV_POOL;
+                }
+            }
+        }
+    }
+    regs[TM_PIPR] = pipr_min;
+
+    rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
+    if (rc) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
+        return;
+    }
+
+    if (cppr < old_cppr) {
+        /*
+         * FIXME: check if there's a group interrupt being presented
+         * and if the new cppr prevents it. If so, then the group
+         * interrupt needs to be re-added to the backlog and
+         * re-triggered (see re-trigger END info in the NVGC
+         * structure)
+         */
+    }
+
+    if (group_enabled &&
+        lsmfb_min < cppr &&
+        lsmfb_min < regs[TM_PIPR]) {
+        /*
+         * Thread has seen a group interrupt with a higher priority
+         * than the new cppr or pending local interrupt. Check the
+         * backlog
+         */
+        if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
+                          nvp_blk, nvp_idx);
+            return;
+        }
+
+        if (!xive2_nvp_is_valid(&nvp)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                          nvp_blk, nvp_idx);
+            return;
+        }
+
+        first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
+        if (!first_group) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                          nvp_blk, nvp_idx);
+            return;
+        }
+
+        backlog_prio = xive2_presenter_backlog_scan(tctx->xptr,
+                                                    nvp_blk, nvp_idx,
+                                                    first_group, &group_level);
+        tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
+        if (backlog_prio != 0xFF) {
+            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
+                                         backlog_prio, group_level);
+            regs[TM_PIPR] = backlog_prio;
+        }
+    }
+    /* CPPR has changed, check if we need to raise a pending exception */
+    xive_tctx_notify(tctx, ring_min, group_level);
+}
+
+void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_cppr(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
+void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
+}
+
 static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
 {
     uint8_t *regs = &tctx->regs[ring];
@@ -937,7 +1104,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
 {
-    uint8_t *regs = &tctx->regs[ring];
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *alt_regs = &tctx->regs[alt_ring];
 
     /*
      * The xive2_presenter_tctx_match() above tells if there's a match
@@ -945,7 +1114,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
      * priority to know if the thread can take the interrupt now or if
      * it is precluded.
      */
-    if (priority < regs[TM_CPPR]) {
+    if (priority < alt_regs[TM_CPPR]) {
         return false;
     }
     return true;
-- 
2.43.0


