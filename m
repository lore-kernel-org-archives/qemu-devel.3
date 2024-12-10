Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA66E7717D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 00:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKnmq-0006Ag-Lc; Mon, 09 Dec 2024 19:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlP-0004lM-Gt; Mon, 09 Dec 2024 19:06:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1tKnlM-0001rA-4i; Mon, 09 Dec 2024 19:06:05 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9EfpG6024724;
 Tue, 10 Dec 2024 00:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5ESxPR//RV9dNqwNO
 lS/X/S+4R9bnqxT7LDaWwAMsmI=; b=kC1jkjaCwzOJGO3JBN2sIITVKPxDLy3oM
 JGN8af5KVHFCWckdgW7m+TS6PioCaWJKRf2ztncswfO8B4cytG8lCeexRTeyo/kQ
 f5LyauJmQwzcpkrId+RaEU3imQGZp8w5STFZZykD0Q47fJlqdMH9tKOKss2mnPpJ
 4+IQ71XZ+ov3f99BZuAwtNHq5D8l7RngljS5YqP3gOeYtz086s15KVxpmat08kMw
 iZ3p8wVz0wAvHlmSGPtmCIfHk8uRMp4d3iztVU0E2Cfvqvbbj6oI75Pbn6BRuhUX
 ug2XN6eDVi/ztS4Zh6kjn5pXfZl4hnwcAPHPrfaOkDArvmbiGKD+w==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb5ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:57 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BA01Bb9024889;
 Tue, 10 Dec 2024 00:05:56 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xb5e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9JpLoh023047;
 Tue, 10 Dec 2024 00:05:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjrrnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Dec 2024 00:05:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4BA05qff52232632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Dec 2024 00:05:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97D182004B;
 Tue, 10 Dec 2024 00:05:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C686C20040;
 Tue, 10 Dec 2024 00:05:50 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Dec 2024 00:05:50 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH v2 05/14] ppc/xive2: Add undelivered group interrupt to backlog
Date: Mon,  9 Dec 2024 18:05:11 -0600
Message-Id: <20241210000527.9541-9-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210000527.9541-1-kowal@linux.ibm.com>
References: <20241210000527.9541-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jo1NcIo7saxPW-0bzNZ8Vrf49ZoxIxSU
X-Proofpoint-ORIG-GUID: KLj1_gekHLe4bzCVv8fCFaaDXv2pMWRP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

When a group interrupt cannot be delivered, we need to:
- increment the backlog counter for the group in the NVG table
  (if the END is configured to keep a backlog).
- start a broadcast operation to set the LSMFB field on matching CPUs
  which can't take the interrupt now because they're running at too
  high a priority.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h  |   5 ++
 include/hw/ppc/xive2.h |   1 +
 hw/intc/pnv_xive2.c    |  42 +++++++++++++++++
 hw/intc/xive2.c        | 105 +++++++++++++++++++++++++++++++++++------
 hw/ppc/pnv.c           |  22 ++++++++-
 5 files changed, 159 insertions(+), 16 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index ce4eb9726b..f443a39cf1 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -442,6 +442,9 @@ struct XivePresenterClass {
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
     uint32_t (*get_config)(XivePresenter *xptr);
+    int (*broadcast)(XivePresenter *xptr,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     uint8_t priority);
 };
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
@@ -472,6 +475,8 @@ struct XiveFabricClass {
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
+    int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
+                     uint8_t priority);
 };
 
 /*
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 65154f78d8..ebf301bb5b 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -120,6 +120,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
+void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 5cdd4fdcc9..41b727d1fb 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -705,6 +705,47 @@ static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
     return cfg;
 }
 
+static int pnv_xive2_broadcast(XivePresenter *xptr,
+                               uint8_t nvt_blk, uint32_t nvt_idx,
+                               uint8_t priority)
+{
+    PnvXive2 *xive = PNV_XIVE2(xptr);
+    PnvChip *chip = xive->chip;
+    int i, j;
+    bool gen1_tima_os =
+        xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+        CPUCore *cc = CPU_CORE(pc);
+
+        for (j = 0; j < cc->nr_threads; j++) {
+            PowerPCCPU *cpu = pc->threads[j];
+            XiveTCTX *tctx;
+            int ring;
+
+            if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
+                continue;
+            }
+
+            tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+
+            if (gen1_tima_os) {
+                ring = xive_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
+                                                 nvt_idx, true, 0);
+            } else {
+                ring = xive2_presenter_tctx_match(xptr, tctx, 0, nvt_blk,
+                                                  nvt_idx, true, 0);
+            }
+
+            if (ring != -1) {
+                xive2_tm_set_lsmfb(tctx, ring, priority);
+            }
+        }
+    }
+    return 0;
+}
+
 static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
 {
     return pnv_xive2_block_id(PNV_XIVE2(xrtr));
@@ -2445,6 +2486,7 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
 
     xpc->match_nvt  = pnv_xive2_match_nvt;
     xpc->get_config = pnv_xive2_presenter_get_config;
+    xpc->broadcast  = pnv_xive2_broadcast;
 };
 
 static const TypeInfo pnv_xive2_info = {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index cffcf3ff05..05cb17518d 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -62,6 +62,30 @@ static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
     return val;
 }
 
+static void xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
+                                   uint32_t val)
+{
+    uint8_t *ptr, i;
+    uint32_t shift;
+
+    if (priority > 7) {
+        return;
+    }
+
+    if (val > 0xFFFFFF) {
+        val = 0xFFFFFF;
+    }
+    /*
+     * The per-priority backlog counters are 24-bit and the structure
+     * is stored in big endian
+     */
+    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
+    for (i = 0; i < 3; i++, ptr++) {
+        shift = 8 * (2 - i);
+        *ptr = (val >> shift) & 0xFF;
+    }
+}
+
 void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
 {
     if (!xive2_eas_is_valid(eas)) {
@@ -830,6 +854,19 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
     return true;
 }
 
+void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    /*
+     * Called by the router during a VP-group notification when the
+     * thread matches but can't take the interrupt because it's
+     * already running at a more favored priority. It then stores the
+     * new interrupt priority in the LSMFB field.
+     */
+    regs[TM_LSMFB] = priority;
+}
+
 static void xive2_router_realize(DeviceState *dev, Error **errp)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(dev);
@@ -962,10 +999,9 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     /*
      * If no matching NVP is dispatched on a HW thread :
      * - specific VP: update the NVP structure if backlog is activated
-     * - logical server : forward request to IVPE (not supported)
+     * - VP-group: update the backlog counter for that priority in the NVG
      */
     if (xive2_end_is_backlog(&end)) {
-        uint8_t ipb;
 
         if (format == 1) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -974,19 +1010,58 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             return;
         }
 
-        /*
-         * Record the IPB in the associated NVP structure for later
-         * use. The presenter will resend the interrupt when the vCPU
-         * is dispatched again on a HW thread.
-         */
-        ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2) |
-            xive_priority_to_ipb(priority);
-        nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
-        xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
-
-        /*
-         * On HW, follows a "Broadcast Backlog" to IVPEs
-         */
+        if (!xive2_end_is_ignore(&end)) {
+            uint8_t ipb;
+            /*
+             * Record the IPB in the associated NVP structure for later
+             * use. The presenter will resend the interrupt when the vCPU
+             * is dispatched again on a HW thread.
+             */
+            ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2) |
+                xive_priority_to_ipb(priority);
+            nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
+            xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
+        } else {
+            Xive2Nvgc nvg;
+            uint32_t backlog;
+
+            /* For groups, the per-priority backlog counters are in the NVG */
+            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVG %x/%x\n",
+                              nvp_blk, nvp_idx);
+                return;
+            }
+
+            if (!xive2_nvgc_is_valid(&nvg)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is invalid\n",
+                              nvp_blk, nvp_idx);
+                return;
+            }
+
+            /*
+             * Increment the backlog counter for that priority.
+             * For the precluded case, we only call broadcast the
+             * first time the counter is incremented. broadcast will
+             * set the LSMFB field of the TIMA of relevant threads so
+             * that they know an interrupt is pending.
+             */
+            backlog = xive2_nvgc_get_backlog(&nvg, priority) + 1;
+            xive2_nvgc_set_backlog(&nvg, priority, backlog);
+            xive2_router_write_nvgc(xrtr, false, nvp_blk, nvp_idx, &nvg);
+
+            if (precluded && backlog == 1) {
+                XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
+                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx, priority);
+
+                if (!xive2_end_is_precluded_escalation(&end)) {
+                    /*
+                     * The interrupt will be picked up when the
+                     * matching thread lowers its priority level
+                     */
+                    return;
+                }
+            }
+        }
     }
 
 do_escalation:
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0f0d7567d..7c11143749 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1,7 +1,9 @@
 /*
  * QEMU PowerPC PowerNV machine model
  *
- * Copyright (c) 2016, IBM Corporation.
+ * Copyright (c) 2016-2024, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
@@ -2639,6 +2641,23 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
     return total_count;
 }
 
+static int pnv10_xive_broadcast(XiveFabric *xfb,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                uint8_t priority)
+{
+    PnvMachineState *pnv = PNV_MACHINE(xfb);
+    int i;
+
+    for (i = 0; i < pnv->num_chips; i++) {
+        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
+        XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
+        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+        xpc->broadcast(xptr, nvt_blk, nvt_idx, priority);
+    }
+    return 0;
+}
+
 static bool pnv_machine_get_big_core(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2772,6 +2791,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
+    xfc->broadcast = pnv10_xive_broadcast;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
-- 
2.43.0


