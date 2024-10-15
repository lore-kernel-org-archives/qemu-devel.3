Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1768D1F9D4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 21:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0orr-00044Z-4n; Tue, 15 Oct 2024 17:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0orp-0003ze-3U; Tue, 15 Oct 2024 17:14:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1t0orn-0000PK-4O; Tue, 15 Oct 2024 17:14:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJtgqj002181;
 Tue, 15 Oct 2024 21:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=RzXVEDirVaxmnxXJA
 ZR52SyQUWdT7m/exs9Afe1nJo0=; b=ZtLFtkerr2XwvmHw49Qegc5rKlZtRjNd3
 /XLjzz5f9Vta6Z6wn+TU9iZRMdYFtldVEeDdaP3APYw8S2L38wRtl4SSQfp0a7ME
 dqUK5YaNElQuXHRAFrUpqJ3oZUC29ejv8kRRsPF69MXbGLPxNhzCRa8V/94mtacj
 +AwJXnD92tqanrmg7OR8dcWd9VuW5yMdl2Ov3nKMsefWfl7AUoEwViBqz0QkfCH0
 rB8Y3EffwiJnjRw8SXxmmw1i3wGAh85AB5fW/mQ0ZE7E1fDs9NHKByfw21lXb5qg
 E5coW/agRsZGmvG0BZMUPqTT0S/lNWIDsa0WZYDJNxI30mx8x0OKQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429xywr8y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:51 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FLAZ08022977;
 Tue, 15 Oct 2024 21:13:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429xywr8y1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FI2owi006789;
 Tue, 15 Oct 2024 21:13:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk5v92-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 21:13:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FLDlbE56951074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 21:13:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 076272004B;
 Tue, 15 Oct 2024 21:13:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E140C20043;
 Tue, 15 Oct 2024 21:13:44 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 21:13:44 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com, danielhb413@gmail.com,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: [PATCH 04/14] ppc/xive2: Add undelivered group interrupt to backlog
Date: Tue, 15 Oct 2024 16:13:19 -0500
Message-Id: <20241015211329.21113-5-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015211329.21113-1-kowal@linux.ibm.com>
References: <20241015211329.21113-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 82zj6GnM1Fa_i4ug4zVJUXxeTziD7YJm
X-Proofpoint-GUID: xgTIi3jhYLlKIqx_L2oddmJUa8f84NAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/ppc/pnv.c           |  18 +++++++
 5 files changed, 156 insertions(+), 15 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a177b75723..7660578b20 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -444,6 +444,9 @@ struct XivePresenterClass {
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
     uint32_t (*get_config)(XivePresenter *xptr);
+    int (*broadcast)(XivePresenter *xptr,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     uint8_t priority);
 };
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
@@ -474,6 +477,8 @@ struct XiveFabricClass {
                      uint8_t nvt_blk, uint32_t nvt_idx,
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
+    int (*broadcast)(XiveFabric *xfb, uint8_t nvt_blk, uint32_t nvt_idx,
+                     uint8_t priority);
 };
 
 /*
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 17c31fcb4b..d88db05687 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -122,6 +122,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
+void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 3fb466bb2c..0482193fd7 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -706,6 +706,47 @@ static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
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
@@ -2446,6 +2487,7 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
 
     xpc->match_nvt  = pnv_xive2_match_nvt;
     xpc->get_config = pnv_xive2_presenter_get_config;
+    xpc->broadcast  = pnv_xive2_broadcast;
 };
 
 static const TypeInfo pnv_xive2_info = {
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 2cb03c758e..a6dc6d553f 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -63,6 +63,30 @@ static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
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
index 3526852685..9b42f47326 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2610,6 +2610,23 @@ static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
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
@@ -2743,6 +2760,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
+    xfc->broadcast = pnv10_xive_broadcast;
 
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
 }
-- 
2.43.0


