Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3567C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMP-0005vg-C1; Mon, 21 Jul 2025 12:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ5-00062k-Eb
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ0-0001bz-Fl
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kkRFCiBMKL4MHUQ7Zugvdw1BQnwkezmc+oEfEDLl7GU=;
 b=HEM9nEyOnrmnez8gWWbyTd7pc6hW7RBO5OyJCmv8oR50xDh8DoITbiKpKL3BxN0Fr+BKFL
 ZqaNIQRUyaDuyQABayexYIxWeoP0lYYSax9tBQ09xf25nnpaGYH3jnC6sNfTIrj0z0J2cl
 j3NBQ0BmIjzI+obHMytRyKUG/xJMWPU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Ruov8_hNPCqFfL4sVBzZ_A-1; Mon,
 21 Jul 2025 12:23:56 -0400
X-MC-Unique: Ruov8_hNPCqFfL4sVBzZ_A-1
X-Mimecast-MFC-AGG-ID: Ruov8_hNPCqFfL4sVBzZ_A_1753115035
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 389BA18002A7; Mon, 21 Jul 2025 16:23:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0533C195608D; Mon, 21 Jul 2025 16:23:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/50] ppc/xive2: redistribute irqs for pool and phys ctx pull
Date: Mon, 21 Jul 2025 18:22:10 +0200
Message-ID: <20250721162233.686837-28-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When disabling (pulling) an xive interrupt context, we need
to redistribute any active group interrupts to other threads
that can handle the interrupt if possible.  This support had
already been added for the OS context but had not yet been
added to the pool or physical context.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-28-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2.h      |  4 ++
 include/hw/ppc/xive2_regs.h |  4 +-
 hw/intc/xive.c              | 12 ++---
 hw/intc/xive2.c             | 94 ++++++++++++++++++++++++++-----------
 4 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index ff02ce254984..a91b99057c2a 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -140,6 +140,10 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size);
+uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index e22203814312..f82054661bda 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -209,9 +209,9 @@ static inline uint32_t xive2_nvp_idx(uint32_t cam_line)
     return cam_line & ((1 << XIVE2_NVP_SHIFT) - 1);
 }
 
-static inline uint32_t xive2_nvp_blk(uint32_t cam_line)
+static inline uint8_t xive2_nvp_blk(uint32_t cam_line)
 {
-    return (cam_line >> XIVE2_NVP_SHIFT) & 0xf;
+    return (uint8_t)((cam_line >> XIVE2_NVP_SHIFT) & 0xf);
 }
 
 void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8b705727ae2d..2f72d6ecd5a5 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -693,7 +693,7 @@ static const XiveTmOp xive2_tm_operations[] = {
 
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
-                                                     xive_tm_ack_os_reg },
+                                                   xive_tm_ack_os_reg },
     { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, xive_tm_set_os_pending,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, NULL,
@@ -705,17 +705,17 @@ static const XiveTmOp xive2_tm_operations[] = {
     { XIVE_TM_HV_PAGE, TM_SPC_ACK_HV_REG,         2, NULL,
                                                      xive_tm_ack_hv_reg },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX_G2,   4, NULL,
-                                                     xive_tm_pull_pool_ctx },
+                                                     xive2_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      4, NULL,
-                                                     xive_tm_pull_pool_ctx },
+                                                     xive2_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_POOL_CTX,      8, NULL,
-                                                     xive_tm_pull_pool_ctx },
+                                                     xive2_tm_pull_pool_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_OL,     1, xive2_tm_pull_os_ctx_ol,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_G2,   4, NULL,
-                                                     xive_tm_pull_phys_ctx },
+                                                     xive2_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX,      1, NULL,
-                                                     xive_tm_pull_phys_ctx },
+                                                     xive2_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
                                                      NULL },
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 624620e5b44b..2791985cf29b 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -23,6 +23,9 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
                                     uint32_t end_idx, uint32_t end_data,
                                     bool redistribute);
 
+static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
+                                      uint8_t *nvp_blk, uint32_t *nvp_idx);
+
 uint32_t xive2_router_get_config(Xive2Router *xrtr)
 {
     Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
@@ -604,8 +607,10 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
 static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs = &tctx->regs[ring];
-    uint8_t nsr = regs[TM_NSR];
-    uint8_t pipr = regs[TM_PIPR];
+    uint8_t *alt_regs = (ring == TM_QW2_HV_POOL) ? &tctx->regs[TM_QW3_HV_PHYS] :
+                                                   regs;
+    uint8_t nsr = alt_regs[TM_NSR];
+    uint8_t pipr = alt_regs[TM_PIPR];
     uint8_t crowd = NVx_CROWD_LVL(nsr);
     uint8_t group = NVx_GROUP_LVL(nsr);
     uint8_t nvgc_blk, end_blk, nvp_blk;
@@ -614,10 +619,6 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     uint8_t prio_limit;
     uint32_t cfg;
     uint8_t alt_ring;
-    uint32_t target_ringw2;
-    uint32_t cam;
-    bool valid;
-    bool hw;
 
     /* redistribution is only for group/crowd interrupts */
     if (!xive_nsr_indicates_group_exception(ring, nsr)) {
@@ -625,11 +626,9 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     }
 
     alt_ring = xive_nsr_exception_ring(ring, nsr);
-    target_ringw2 = xive_tctx_word2(&tctx->regs[alt_ring]);
-    cam = be32_to_cpu(target_ringw2);
 
-    /* extract nvp block and index from targeted ring's cam */
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
+    /* Don't check return code since ring is expected to be invalidated */
+    xive2_tctx_get_nvp_indexes(tctx, alt_ring, &nvp_blk, &nvp_idx);
 
     trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
 
@@ -676,11 +675,23 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
 
     /* clear interrupt indication for the context */
-    regs[TM_NSR] = 0;
-    regs[TM_PIPR] = regs[TM_CPPR];
+    alt_regs[TM_NSR] = 0;
+    alt_regs[TM_PIPR] = alt_regs[TM_CPPR];
     xive_tctx_reset_signal(tctx, ring);
 }
 
+static uint8_t xive2_hv_irq_ring(uint8_t nsr)
+{
+    switch (nsr >> 6) {
+    case TM_QW3_NSR_HE_POOL:
+        return TM_QW2_HV_POOL;
+    case TM_QW3_NSR_HE_PHYS:
+        return TM_QW3_HV_PHYS;
+    default:
+        return -1;
+    }
+}
+
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -696,7 +707,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
-    if (!valid) {
+    if (xive2_tctx_get_nvp_indexes(tctx, ring, &nvp_blk, &nvp_idx)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: pulling invalid NVP %x/%x !?\n",
                       nvp_blk, nvp_idx);
     }
@@ -706,13 +717,25 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
          cur_ring += XIVE_TM_RING_SIZE) {
         uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
         uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
+        bool is_valid = !!(xive_get_field32(TM2_QW1W2_VO, ringw2));
+        uint8_t alt_ring;
         memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
-    }
 
-    /* Active group/crowd interrupts need to be redistributed */
-    nsr = tctx->regs[ring + TM_NSR];
-    if (xive_nsr_indicates_group_exception(ring, nsr)) {
-        xive2_redistribute(xrtr, tctx, ring);
+        /* Skip the rest for USER or invalid contexts */
+        if ((cur_ring == TM_QW0_USER) || !is_valid) {
+            continue;
+        }
+
+        /* Active group/crowd interrupts need to be redistributed */
+        alt_ring = (cur_ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : cur_ring;
+        nsr = tctx->regs[alt_ring + TM_NSR];
+        if (xive_nsr_indicates_group_exception(alt_ring, nsr)) {
+            /* For HV rings, only redistribute if cur_ring matches NSR */
+            if ((cur_ring == TM_QW1_OS) ||
+                (cur_ring == xive2_hv_irq_ring(nsr))) {
+                xive2_redistribute(xrtr, tctx, cur_ring);
+            }
+        }
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
@@ -736,6 +759,18 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW1_OS);
 }
 
+uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW2_HV_POOL);
+}
+
+uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                                hwaddr offset, unsigned size)
+{
+    return xive2_tm_pull_ctx(xptr, tctx, offset, size, TM_QW3_HV_PHYS);
+}
+
 #define REPORT_LINE_GEN1_SIZE       16
 
 static void xive2_tm_report_line_gen1(XiveTCTX *tctx, uint8_t *data,
@@ -993,37 +1028,40 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+/* returns -1 if ring is invalid, but still populates block and index */
 static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
-                                      uint32_t *nvp_blk, uint32_t *nvp_idx)
+                                      uint8_t *nvp_blk, uint32_t *nvp_idx)
 {
-    uint32_t w2, cam;
+    uint32_t w2;
+    uint32_t cam = 0;
+    int rc = 0;
 
     w2 = xive_tctx_word2(&tctx->regs[ring]);
     switch (ring) {
     case TM_QW1_OS:
         if (!(be32_to_cpu(w2) & TM2_QW1W2_VO)) {
-            return -1;
+            rc = -1;
         }
         cam = xive_get_field32(TM2_QW1W2_OS_CAM, w2);
         break;
     case TM_QW2_HV_POOL:
         if (!(be32_to_cpu(w2) & TM2_QW2W2_VP)) {
-            return -1;
+            rc = -1;
         }
         cam = xive_get_field32(TM2_QW2W2_POOL_CAM, w2);
         break;
     case TM_QW3_HV_PHYS:
         if (!(be32_to_cpu(w2) & TM2_QW3W2_VT)) {
-            return -1;
+            rc = -1;
         }
         cam = xive2_tctx_hw_cam_line(tctx->xptr, tctx);
         break;
     default:
-        return -1;
+        rc = -1;
     }
     *nvp_blk = xive2_nvp_blk(cam);
     *nvp_idx = xive2_nvp_idx(cam);
-    return 0;
+    return rc;
 }
 
 static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
@@ -1031,7 +1069,8 @@ static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
 {
     uint64_t rd;
     Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-    uint32_t nvp_blk, nvp_idx, xive2_cfg;
+    uint32_t nvp_idx, xive2_cfg;
+    uint8_t nvp_blk;
     Xive2Nvp nvp;
     uint64_t phys_addr;
     uint8_t OGen = 0;
@@ -1084,7 +1123,8 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     uint8_t old_cppr, backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
     bool group_enabled;
-    uint32_t nvp_blk, nvp_idx;
+    uint8_t nvp_blk;
+    uint32_t nvp_idx;
     Xive2Nvp nvp;
     int rc;
     uint8_t nsr = regs[TM_NSR];
-- 
2.50.1


