Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF00C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:32:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMk-0007B5-Sm; Mon, 21 Jul 2025 12:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJu-0008Kk-Ac
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJn-0001mq-7S
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hW0qyVo7jA8jnnYQBeOKqk6U8QRqNlohALcXAO+SKzI=;
 b=Msr9ohR69yQtoSmCx0Krb+Z4Kvwy2zs/46KOHVO7wb1npaY8KdG2X/QezEfqiIzCIC+8nb
 4YzQ/4LXFyjk6DuXoAVNMlklcbJ8307cWfNiRAp2uTQIyaC3eUNythBzTjhQXKk13v8lyX
 d4+t07RKYIG/4gS5F+ThRrHXOG9KBh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-5pJYRcK_PjyLT6FWtE5XvQ-1; Mon,
 21 Jul 2025 12:24:43 -0400
X-MC-Unique: 5pJYRcK_PjyLT6FWtE5XvQ-1
X-Mimecast-MFC-AGG-ID: 5pJYRcK_PjyLT6FWtE5XvQ_1753115082
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 377F7180048E; Mon, 21 Jul 2025 16:24:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03110195608D; Mon, 21 Jul 2025 16:24:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 44/50] ppc/xive2: Implement pool context push TIMA op
Date: Mon, 21 Jul 2025 18:22:27 +0200
Message-ID: <20250721162233.686837-45-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

From: Nicholas Piggin <npiggin@gmail.com>

Implement pool context push TIMA op.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-45-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2.h |  2 ++
 hw/intc/xive.c         |  4 ++++
 hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++--------------
 3 files changed, 39 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index a91b99057c2a..c1ab06a55adf 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -140,6 +140,8 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_lsmfb(XiveTCTX *tctx, int ring, uint8_t priority);
 void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                 hwaddr offset, unsigned size);
 uint64_t xive2_tm_pull_phys_ctx(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 6589c0a523c9..e7f77be2f711 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -733,6 +733,10 @@ static const XiveTmOp xive2_tm_operations[] = {
       xive2_tm_push_os_ctx, NULL },
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, true, true,
       xive_tm_set_os_lgs, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 4, true, true,
+      xive2_tm_push_pool_ctx, NULL },
+    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 8, true, true,
+      xive2_tm_push_pool_ctx, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
       xive2_tm_set_hv_cppr, NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index e3f9ff384a1a..4244e1d02b61 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -583,6 +583,7 @@ static void xive2_tctx_save_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 1);
 }
 
+/* POOL cam is the same as OS cam encoding */
 static void xive2_cam_decode(uint32_t cam, uint8_t *nvp_blk,
                              uint32_t *nvp_idx, bool *valid, bool *hw)
 {
@@ -940,10 +941,11 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
 }
 
 static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
+                                   uint8_t ring,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t *regs = &tctx->regs[ring];
     uint8_t ipb;
     Xive2Nvp nvp;
 
@@ -965,7 +967,7 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
 
     /* Automatically restore thread context registers */
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_restore) {
-        xive2_tctx_restore_ctx(xrtr, tctx, TM_QW1_OS, nvp_blk, nvp_idx, &nvp);
+        xive2_tctx_restore_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx, &nvp);
     }
 
     ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2);
@@ -976,48 +978,62 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
 
-    xive2_tctx_process_pending(tctx, TM_QW1_OS);
+    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
+                                         TM_QW3_HV_PHYS : ring);
 }
 
 /*
- * Updating the OS CAM line can trigger a resend of interrupt
+ * Updating the ring CAM line can trigger a resend of interrupt
  */
-void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
-                          hwaddr offset, uint64_t value, unsigned size)
+static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                              hwaddr offset, uint64_t value, unsigned size,
+                              uint8_t ring)
 {
     uint32_t cam;
-    uint32_t qw1w2;
-    uint64_t qw1dw1;
+    uint32_t w2;
+    uint64_t dw1;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
-    bool vo;
+    bool v;
     bool do_restore;
 
     /* First update the thead context */
     switch (size) {
     case 4:
         cam = value;
-        qw1w2 = cpu_to_be32(cam);
-        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+        w2 = cpu_to_be32(cam);
+        memcpy(&tctx->regs[ring + TM_WORD2], &w2, 4);
         break;
     case 8:
         cam = value >> 32;
-        qw1dw1 = cpu_to_be64(value);
-        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1dw1, 8);
+        dw1 = cpu_to_be64(value);
+        memcpy(&tctx->regs[ring + TM_WORD2], &dw1, 8);
         break;
     default:
         g_assert_not_reached();
     }
 
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &v, &do_restore);
 
     /* Check the interrupt pending bits */
-    if (vo) {
-        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, nvp_blk, nvp_idx,
-                               do_restore);
+    if (v) {
+        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
+                               nvp_blk, nvp_idx, do_restore);
     }
 }
 
+void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                          hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW1_OS);
+}
+
+void xive2_tm_push_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tm_push_ctx(xptr, tctx, offset, value, size, TM_QW2_HV_POOL);
+}
+
 /* returns -1 if ring is invalid, but still populates block and index */
 static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
                                       uint8_t *nvp_blk, uint32_t *nvp_idx)
-- 
2.50.1


