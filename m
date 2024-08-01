Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EADAC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 20:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZcRv-0004Om-Mx; Thu, 01 Aug 2024 16:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRn-0003xQ-VX; Thu, 01 Aug 2024 16:30:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sZcRk-0007On-Tn; Thu, 01 Aug 2024 16:30:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471KSoEL015941;
 Thu, 1 Aug 2024 20:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=+3OatkDyf+UOS
 Z/GCGwdiTAaQA/Q29Dxuretz6Q+osM=; b=Ek015dhMwa6IWOn5Optqpe/q0rMF9
 Ohy+rJMRFIkCuOmYgEJqR9mbV7KNORN7/EFgc2k8zGrqlfUFKe/iHlWf3iKOcorI
 zK+kApe3s/MbRtn31D9QVY2HzXy9jtAd4EMMcnRxojl90aA33mFDkypqffmhZv2e
 yaRyFiMH4kUbSs5AnoCuc6J/nDIzQbOrUIGwLWQ0dfekVsZUlKqVtXHCkKljOFh7
 oPXVKv4yjFQPSn0AOKyxWwserNOnlAK1LLMJOcOTywXTCk7Q+6Anj6r+/kxCozj1
 gQWAaq21LRZpIk1Tlu2ao21CEnF2C79WoAOuuMpg8/4S8ryGz++NMAI6g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhe4g058-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 471KUcZF019644;
 Thu, 1 Aug 2024 20:30:38 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhe4g057-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 471IBx2c007457; Thu, 1 Aug 2024 20:30:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40nb7um0w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Aug 2024 20:30:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 471KUWa648431398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2024 20:30:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A62220043;
 Thu,  1 Aug 2024 20:30:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0134120063;
 Thu,  1 Aug 2024 20:30:31 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2024 20:30:30 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH 09/13] ppc/xive2: Support "Pull Thread Context to Odd Thread
 Reporting Line"
Date: Thu,  1 Aug 2024 15:30:04 -0500
Message-Id: <20240801203008.11224-10-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801203008.11224-1-kowal@linux.ibm.com>
References: <20240801203008.11224-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CnLbXooCjwBz0dTLgJgYLl42VcrJ8TQR
X-Proofpoint-GUID: bd664taowEgAt-nsm7Ic9ufHK32sa-g6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408010135
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

Adds support for single byte writes to offset 0xC38 of the TIMA address
space.  When this offset is written to, the hardware disables the thread
context and copies the current state information to the odd cache line of
the pair specified by the NVT structure indexed by the THREAD CAM entry.

Note that this operation is almost identical to what we are already doing
for the "Pull OS Context to Odd Thread Reporting Line" operation except
that it also invalidates the Pool and Thread Contexts.  In order to reuse
this code, this commit also changes those existing functions to be able
to handle any context/ring (OS, Pool, or Thread) that is passed in.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 include/hw/ppc/xive.h      |  2 +-
 include/hw/ppc/xive2.h     |  2 +
 include/hw/ppc/xive_regs.h |  1 +
 hw/intc/xive.c             | 15 +++----
 hw/intc/xive2.c            | 83 ++++++++++++++++++++++++++------------
 5 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 28c181faa2..31242f0406 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -533,7 +533,7 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
-void xive_tctx_reset_os_signal(XiveTCTX *tctx);
+void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 
 /*
  * KVM XIVE device helpers
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 36bd0e747f..5bccf41159 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -123,5 +123,7 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 558a5ae742..5b11463777 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -138,6 +138,7 @@
 #define TM_SPC_ACK_HV_POOL_EL   0xc20   /* Store8 ack HV evt pool to even     */
                                         /* line                               */
 #define TM_SPC_ACK_HV_EL        0xc30   /* Store8 ack HV irq to even line     */
+#define TM_SPC_PULL_PHYS_CTX_OL 0xc38   /* Pull phys ctx to odd cache line    */
 /* XXX more... */
 
 /* NSR fields for the various QW ack types */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5b66a3aec5..9d85da0999 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -114,15 +114,14 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
     }
 }
 
-void xive_tctx_reset_os_signal(XiveTCTX *tctx)
+void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 {
     /*
-     * Lower the External interrupt. Used when pulling an OS
-     * context. It is necessary to avoid catching it in the hypervisor
-     * context. It should be raised again when re-pushing the OS
-     * context.
+     * Lower the External interrupt. Used when pulling a context. It is
+     * necessary to avoid catching it in the higher privilege context. It
+     * should be raised again when re-pushing the lower privilege context.
      */
-    qemu_irq_lower(xive_tctx_output(tctx, TM_QW1_OS));
+    qemu_irq_lower(xive_tctx_output(tctx, ring));
 }
 
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
@@ -424,7 +423,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     qw1w2_new = xive_set_field32(TM_QW1W2_VO, qw1w2, 0);
     xive_tctx_set_os_cam(tctx, qw1w2_new);
 
-    xive_tctx_reset_os_signal(tctx);
+    xive_tctx_reset_signal(tctx, TM_QW1_OS);
     return qw1w2;
 }
 
@@ -581,6 +580,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
                                                      xive_tm_pull_phys_ctx },
+    { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
+                                                     NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index eed0cc9c3c..af9699ec88 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -295,13 +295,14 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
  *     the NVP by changing the H bit while the context is enabled
  */
 
-static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
-                                   uint8_t nvp_blk, uint32_t nvp_idx)
+static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
+                                uint8_t nvp_blk, uint32_t nvp_idx,
+                                uint8_t ring)
 {
     CPUPPCState *env = &POWERPC_CPU(tctx->cs)->env;
     uint32_t pir = env->spr_cb[SPR_PIR].default_value;
     Xive2Nvp nvp;
-    uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t *regs = &tctx->regs[ring];
 
     if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
@@ -346,13 +347,13 @@ static void xive2_tctx_save_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
 }
 
-static void xive2_os_cam_decode(uint32_t cam, uint8_t *nvp_blk,
-                                uint32_t *nvp_idx, bool *vo, bool *ho)
+static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
+                             uint32_t *nvp_idx, bool *valid, bool *hw)
 {
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    *vo = !!(cam & TM2_QW1W2_VO);
-    *ho = !!(cam & TM2_QW1W2_HO);
+    *valid = !!(cam & TM2_QW1W2_VO);
+    *hw = !!(cam & TM2_QW1W2_HO);
 }
 
 
@@ -376,35 +377,52 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
-uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-                              hwaddr offset, unsigned size)
+static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                           hwaddr offset, unsigned size, uint8_t ring)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t qw1w2 = xive_tctx_word2(&tctx->regs[TM_QW1_OS]);
-    uint32_t qw1w2_new;
-    uint32_t cam = be32_to_cpu(qw1w2);
+    uint32_t target_ringw2 = xive_tctx_word2(&tctx->regs[ring]);
+    uint32_t cam = be32_to_cpu(target_ringw2);
     uint8_t nvp_blk;
     uint32_t nvp_idx;
-    bool vo;
+    uint8_t cur_ring;
+    bool valid;
     bool do_save;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_save);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
-    if (!vo) {
+    if (!valid) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
                       nvp_blk, nvp_idx);
     }
 
-    /* Invalidate CAM line */
-    qw1w2_new = xive_set_field32(TM2_QW1W2_VO, qw1w2, 0);
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2_new, 4);
+    /* Invalidate CAM line of requested ring and all lower rings */
+    for (cur_ring = TM_QW0_USER; cur_ring <= ring;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
+        uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
+        memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
+    }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
-        xive2_tctx_save_os_ctx(xrtr, tctx, nvp_blk, nvp_idx);
+        xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
     }
 
-    xive_tctx_reset_os_signal(tctx);
-    return qw1w2;
+    /*
+     * Lower external interrupt line of requested ring and below except for
+     * USER, which doesn't exist.
+     */
+    for (cur_ring = TM_QW1_OS; cur_ring <= ring;
+         cur_ring += XIVE_TM_RING_SIZE) {
+        xive_tctx_reset_signal(tctx, cur_ring);
+    }
+    return target_ringw2;
+}
+
+uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                              hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
 }
 
 #define REPORT_LINE_GEN1_SIZE       16
@@ -449,8 +467,9 @@ static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
     }
 }
 
-void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
-                             hwaddr offset, uint64_t value, unsigned size)
+static void xive2_tm_pull_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value,
+                          unsigned size, uint8_t ring)
 {
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
     uint32_t hw_cam, nvp_idx, xive2_cfg, reserved;
@@ -488,8 +507,20 @@ void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
         cpu_physical_memory_write(phys_addr + 12, &reserved, 4);
     }
 
-    /* the rest is similar to pull OS context to registers */
-    xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
+    /* the rest is similar to pull context to registers */
+    xive2_tm_pull_ctx(xptr, tctx, offset, size, ring);
+}
+
+void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW1_OS);
+}
+
+void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
+                               hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_pull_ctx_ol(xptr, tctx, offset, value, size, TM_QW3_HV_PHYS);
 }
 
 static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
@@ -588,7 +619,7 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool vo;
     bool do_restore;
 
-    xive2_os_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
 
     /* First update the thead context */
     memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
-- 
2.43.0


