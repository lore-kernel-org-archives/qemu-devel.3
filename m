Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF423C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKI-0001R7-E0; Mon, 21 Jul 2025 12:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ5-00062l-Gl
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ2-0001cO-1L
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E4IHHFsRnHNOOaMjSVNzNwIUDK3mKklHBP4ufzDwJW8=;
 b=i9XSVpR2YtI/twh8S5gBL7q3JLuhOUjKN1vYEp3LHg1Bnql9CU+LpwbeySxdebNZfy57Zg
 iOFKlERNC39IEb1LyVMSLJS1hFAuSt40AEWNWknhRjyzGarC6P9uoi6SeCjxZnJC/NkneG
 5rWn/OL79abbQXM4tdhAt1269vl8jKI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-wHOHOwz-OMCBPNNi7dNDFA-1; Mon,
 21 Jul 2025 12:23:53 -0400
X-MC-Unique: wHOHOwz-OMCBPNNi7dNDFA-1
X-Mimecast-MFC-AGG-ID: wHOHOwz-OMCBPNNi7dNDFA_1753115032
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86CDE195608C; Mon, 21 Jul 2025 16:23:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52E90195608D; Mon, 21 Jul 2025 16:23:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/50] ppc/xive2: Redistribute group interrupt precluded by
 CPPR update
Date: Mon, 21 Jul 2025 18:22:09 +0200
Message-ID: <20250721162233.686837-27-clg@redhat.com>
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

Add support for redistributing a presented group interrupt if it
is precluded as a result of changing the CPPR value. Without this,
group interrupts can be lost.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-27-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 82 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 60 insertions(+), 22 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index e7e364c13e7d..624620e5b44b 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -601,20 +601,37 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
-static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
-                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_t ring)
+static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 {
-    uint8_t nsr = tctx->regs[ring + TM_NSR];
+    uint8_t *regs = &tctx->regs[ring];
+    uint8_t nsr = regs[TM_NSR];
+    uint8_t pipr = regs[TM_PIPR];
     uint8_t crowd = NVx_CROWD_LVL(nsr);
     uint8_t group = NVx_GROUP_LVL(nsr);
-    uint8_t nvgc_blk;
-    uint8_t nvgc_idx;
-    uint8_t end_blk;
-    uint32_t end_idx;
-    uint8_t pipr = tctx->regs[ring + TM_PIPR];
+    uint8_t nvgc_blk, end_blk, nvp_blk;
+    uint32_t nvgc_idx, end_idx, nvp_idx;
     Xive2Nvgc nvgc;
     uint8_t prio_limit;
     uint32_t cfg;
+    uint8_t alt_ring;
+    uint32_t target_ringw2;
+    uint32_t cam;
+    bool valid;
+    bool hw;
+
+    /* redistribution is only for group/crowd interrupts */
+    if (!xive_nsr_indicates_group_exception(ring, nsr)) {
+        return;
+    }
+
+    alt_ring = xive_nsr_exception_ring(ring, nsr);
+    target_ringw2 = xive_tctx_word2(&tctx->regs[alt_ring]);
+    cam = be32_to_cpu(target_ringw2);
+
+    /* extract nvp block and index from targeted ring's cam */
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &hw);
+
+    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
 
     trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
@@ -659,8 +676,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
 
     /* clear interrupt indication for the context */
-    tctx->regs[ring + TM_NSR] = 0;
-    tctx->regs[ring + TM_PIPR] = tctx->regs[ring + TM_CPPR];
+    regs[TM_NSR] = 0;
+    regs[TM_PIPR] = regs[TM_CPPR];
     xive_tctx_reset_signal(tctx, ring);
 }
 
@@ -695,7 +712,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     /* Active group/crowd interrupts need to be redistributed */
     nsr = tctx->regs[ring + TM_NSR];
     if (xive_nsr_indicates_group_exception(ring, nsr)) {
-        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
+        xive2_redistribute(xrtr, tctx, ring);
     }
 
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
@@ -1059,6 +1076,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
 }
 
+/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
 static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
@@ -1069,10 +1087,11 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     uint32_t nvp_blk, nvp_idx;
     Xive2Nvp nvp;
     int rc;
+    uint8_t nsr = regs[TM_NSR];
 
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
                              regs[TM_IPB], regs[TM_PIPR],
-                             cppr, regs[TM_NSR]);
+                             cppr, nsr);
 
     if (cppr > XIVE_PRIORITY_MAX) {
         cppr = 0xff;
@@ -1081,6 +1100,35 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     old_cppr = regs[TM_CPPR];
     regs[TM_CPPR] = cppr;
 
+    /* Handle increased CPPR priority (lower value) */
+    if (cppr < old_cppr) {
+        if (cppr <= regs[TM_PIPR]) {
+            /* CPPR lowered below PIPR, must un-present interrupt */
+            if (xive_nsr_indicates_exception(ring, nsr)) {
+                if (xive_nsr_indicates_group_exception(ring, nsr)) {
+                    /* redistribute precluded active grp interrupt */
+                    xive2_redistribute(xrtr, tctx, ring);
+                    return;
+                }
+            }
+
+            /* interrupt is VP directed, pending in IPB */
+            regs[TM_PIPR] = cppr;
+            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
+            return;
+        } else {
+            /* CPPR was lowered, but still above PIPR. No action needed. */
+            return;
+        }
+    }
+
+    /* CPPR didn't change, nothing needs to be done */
+    if (cppr == old_cppr) {
+        return;
+    }
+
+    /* CPPR priority decreased (higher value) */
+
     /*
      * Recompute the PIPR based on local pending interrupts. It will
      * be adjusted below if needed in case of pending group interrupts.
@@ -1129,16 +1177,6 @@ again:
         return;
     }
 
-    if (cppr < old_cppr) {
-        /*
-         * FIXME: check if there's a group interrupt being presented
-         * and if the new cppr prevents it. If so, then the group
-         * interrupt needs to be re-added to the backlog and
-         * re-triggered (see re-trigger END info in the NVGC
-         * structure)
-         */
-    }
-
     if (group_enabled &&
         lsmfb_min < cppr &&
         lsmfb_min < pipr_min) {
-- 
2.50.1


