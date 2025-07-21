Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AD7C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtK4-0000Wf-2d; Mon, 21 Jul 2025 12:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJO-0006Ss-M4
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJL-0001ha-1V
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CED5NJWqTOR25PdPo9U9RAFERqjNgZ7RNQmU3hpk4mI=;
 b=X0Jgg7E3LM1DusJYO22elm3VjvSWcE/0zeiV86+7p4TdoAIoZ9eYvwRs9/JMvcmOXKiZgX
 4ASuSYic/65bMv078+vN9WUzHnbvIb3mylWLOu02sixcJKRgJnDEfull1DhDAPEh6Sbq4w
 JmW24H3+oZxyG7usSfRblHfidbbXLvY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-IMkCYTX-P5mOaPz1h1_iLQ-1; Mon,
 21 Jul 2025 12:24:13 -0400
X-MC-Unique: IMkCYTX-P5mOaPz1h1_iLQ-1
X-Mimecast-MFC-AGG-ID: IMkCYTX-P5mOaPz1h1_iLQ_1753115051
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5E8E19560A3; Mon, 21 Jul 2025 16:24:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 815A3195608D; Mon, 21 Jul 2025 16:24:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 33/50] ppc/xive: tctx signaling registers rework
Date: Mon, 21 Jul 2025 18:22:16 +0200
Message-ID: <20250721162233.686837-34-clg@redhat.com>
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

From: Nicholas Piggin <npiggin@gmail.com>

The tctx "signaling" registers (PIPR, CPPR, NSR) raise an interrupt on
the target CPU thread. The POOL and PHYS rings both raise hypervisor
interrupts, so they both share one set of signaling registers in the
PHYS ring. The PHYS NSR register contains a field that indicates which
ring has presented the interrupt being signaled to the CPU.

This sharing results in all the "alt_regs" throughout the code. alt_regs
is not very descriptive, and worse is that the name is used for
conversions in both directions, i.e., to find the presenting ring from
the signaling ring, and the signaling ring from the presenting ring.

Instead of alt_regs, use the names sig_regs and sig_ring, and regs and
ring for the presenting ring being worked on. Add a helper function to
get the sign_regs, and add some asserts to ensure the POOL regs are
never used to signal interrupts.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-34-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h |  26 +++++++++-
 hw/intc/xive.c        | 112 ++++++++++++++++++++++--------------------
 hw/intc/xive2.c       |  94 ++++++++++++++++-------------------
 3 files changed, 126 insertions(+), 106 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 0d6b11e818c1..a3c2f50ecef7 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -539,7 +539,7 @@ static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
 }
 
 /*
- * XIVE Thread Interrupt Management Aera (TIMA)
+ * XIVE Thread Interrupt Management Area (TIMA)
  *
  * This region gives access to the registers of the thread interrupt
  * management context. It is four page wide, each page providing a
@@ -551,6 +551,30 @@ static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
 #define XIVE_TM_OS_PAGE         0x2
 #define XIVE_TM_USER_PAGE       0x3
 
+/*
+ * The TCTX (TIMA) has 4 rings (phys, pool, os, user), but only signals
+ * (raises an interrupt on) the CPU from 3 of them. Phys and pool both
+ * cause a hypervisor privileged interrupt so interrupts presented on
+ * those rings signal using the phys ring. This helper returns the signal
+ * regs from the given ring.
+ */
+static inline uint8_t *xive_tctx_signal_regs(XiveTCTX *tctx, uint8_t ring)
+{
+    /*
+     * This is a good point to add invariants to ensure nothing has tried to
+     * signal using the POOL ring.
+     */
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    if (ring == TM_QW2_HV_POOL) {
+        /* POOL and PHYS rings share the signal regs (PIPR, NSR, CPPR) */
+        ring = TM_QW3_HV_PHYS;
+    }
+    return &tctx->regs[ring];
+}
+
 void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                         uint64_t value, unsigned size);
 uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5deb2f478fcb..119a178f2e23 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -80,69 +80,77 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
         }
 }
 
-uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
+/*
+ * interrupt is accepted on the presentation ring, for PHYS ring the NSR
+ * directs it to the PHYS or POOL rings.
+ */
+uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
 {
-    uint8_t *regs = &tctx->regs[ring];
-    uint8_t nsr = regs[TM_NSR];
+    uint8_t *sig_regs = &tctx->regs[sig_ring];
+    uint8_t nsr = sig_regs[TM_NSR];
 
-    qemu_irq_lower(xive_tctx_output(tctx, ring));
+    g_assert(sig_ring == TM_QW1_OS || sig_ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
 
-    if (xive_nsr_indicates_exception(ring, nsr)) {
-        uint8_t cppr = regs[TM_PIPR];
-        uint8_t alt_ring;
-        uint8_t *alt_regs;
+    if (xive_nsr_indicates_exception(sig_ring, nsr)) {
+        uint8_t cppr = sig_regs[TM_PIPR];
+        uint8_t ring;
+        uint8_t *regs;
 
-        alt_ring = xive_nsr_exception_ring(ring, nsr);
-        alt_regs = &tctx->regs[alt_ring];
+        ring = xive_nsr_exception_ring(sig_ring, nsr);
+        regs = &tctx->regs[ring];
 
-        regs[TM_CPPR] = cppr;
+        sig_regs[TM_CPPR] = cppr;
 
         /*
          * If the interrupt was for a specific VP, reset the pending
          * buffer bit, otherwise clear the logical server indicator
          */
-        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
-            alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
+        if (!xive_nsr_indicates_group_exception(sig_ring, nsr)) {
+            regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
         }
 
         /* Clear the exception from NSR */
-        regs[TM_NSR] = 0;
+        sig_regs[TM_NSR] = 0;
 
-        trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
-                               alt_regs[TM_IPB], regs[TM_PIPR],
-                               regs[TM_CPPR], regs[TM_NSR]);
+        trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
+                               regs[TM_IPB], sig_regs[TM_PIPR],
+                               sig_regs[TM_CPPR], sig_regs[TM_NSR]);
     }
 
-    return ((uint64_t)nsr << 8) | regs[TM_CPPR];
+    return ((uint64_t)nsr << 8) | sig_regs[TM_CPPR];
 }
 
 void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *alt_regs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
-    if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
+    if (sig_regs[TM_PIPR] < sig_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
-            regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
+            sig_regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
             break;
         case TM_QW2_HV_POOL:
-            alt_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
+            sig_regs[TM_NSR] = (TM_QW3_NSR_HE_POOL << 6) | (group_level & 0x3F);
             break;
         case TM_QW3_HV_PHYS:
-            regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
+            sig_regs[TM_NSR] = (TM_QW3_NSR_HE_PHYS << 6) | (group_level & 0x3F);
             break;
         default:
             g_assert_not_reached();
         }
         trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], alt_regs[TM_PIPR],
-                               alt_regs[TM_CPPR], alt_regs[TM_NSR]);
+                               regs[TM_IPB], sig_regs[TM_PIPR],
+                               sig_regs[TM_CPPR], sig_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
     } else {
-        alt_regs[TM_NSR] = 0;
+        sig_regs[TM_NSR] = 0;
         qemu_irq_lower(xive_tctx_output(tctx, ring));
     }
 }
@@ -159,25 +167,32 @@ void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring)
 
 static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
-    uint8_t *regs = &tctx->regs[ring];
+    uint8_t *sig_regs = &tctx->regs[ring];
     uint8_t pipr_min;
     uint8_t ring_min;
 
+    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    /* XXX: should show pool IPB for PHYS ring */
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
-                             regs[TM_IPB], regs[TM_PIPR],
-                             cppr, regs[TM_NSR]);
+                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
+                             cppr, sig_regs[TM_NSR]);
 
     if (cppr > XIVE_PRIORITY_MAX) {
         cppr = 0xff;
     }
 
-    tctx->regs[ring + TM_CPPR] = cppr;
+    sig_regs[TM_CPPR] = cppr;
 
     /*
      * Recompute the PIPR based on local pending interrupts.  The PHYS
      * ring must take the minimum of both the PHYS and POOL PIPR values.
      */
-    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
+    pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
     ring_min = ring;
 
     /* PHYS updates also depend on POOL values */
@@ -186,7 +201,6 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
         /* POOL values only matter if POOL ctx is valid */
         if (pool_regs[TM_WORD2] & 0x80) {
-
             uint8_t pool_pipr = xive_ipb_to_pipr(pool_regs[TM_IPB]);
 
             /*
@@ -200,7 +214,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         }
     }
 
-    regs[TM_PIPR] = pipr_min;
+    sig_regs[TM_PIPR] = pipr_min;
 
     /* CPPR has changed, check if we need to raise a pending exception */
     xive_tctx_notify(tctx, ring_min, 0);
@@ -208,56 +222,50 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
 void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                            uint8_t group_level)
- {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *alt_regs = &tctx->regs[alt_ring];
+{
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
     if (group_level == 0) {
         /* VP-specific */
         regs[TM_IPB] |= xive_priority_to_ipb(priority);
-        alt_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+        sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
     } else {
         /* VP-group */
-        alt_regs[TM_PIPR] = xive_priority_to_pipr(priority);
+        sig_regs[TM_PIPR] = xive_priority_to_pipr(priority);
     }
     xive_tctx_notify(tctx, ring, group_level);
  }
 
 static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
     /* Does not support a presented group interrupt */
-    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR]));
+    g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
 
-    aregs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+    sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
     xive_tctx_notify(tctx, ring, 0);
 }
 
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
     uint8_t pipr = xive_priority_to_pipr(priority);
 
     if (group_level == 0) {
         regs[TM_IPB] |= xive_priority_to_ipb(priority);
-        if (pipr >= aregs[TM_PIPR]) {
+        if (pipr >= sig_regs[TM_PIPR]) {
             /* VP interrupts can come here with lower priority than PIPR */
             return;
         }
     }
     g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
-    g_assert(pipr < aregs[TM_PIPR]);
-    aregs[TM_PIPR] = pipr;
+    g_assert(pipr < sig_regs[TM_PIPR]);
+    sig_regs[TM_PIPR] = pipr;
     xive_tctx_notify(tctx, ring, group_level);
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index fe40f7f07bdd..71b40f702a6f 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -606,11 +606,9 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
 
 static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
 {
-    uint8_t *regs = &tctx->regs[ring];
-    uint8_t *alt_regs = (ring == TM_QW2_HV_POOL) ? &tctx->regs[TM_QW3_HV_PHYS] :
-                                                   regs;
-    uint8_t nsr = alt_regs[TM_NSR];
-    uint8_t pipr = alt_regs[TM_PIPR];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+    uint8_t nsr = sig_regs[TM_NSR];
+    uint8_t pipr = sig_regs[TM_PIPR];
     uint8_t crowd = NVx_CROWD_LVL(nsr);
     uint8_t group = NVx_GROUP_LVL(nsr);
     uint8_t nvgc_blk, end_blk, nvp_blk;
@@ -618,19 +616,16 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     Xive2Nvgc nvgc;
     uint8_t prio_limit;
     uint32_t cfg;
-    uint8_t alt_ring;
 
     /* redistribution is only for group/crowd interrupts */
     if (!xive_nsr_indicates_group_exception(ring, nsr)) {
         return;
     }
 
-    alt_ring = xive_nsr_exception_ring(ring, nsr);
-
     /* Don't check return code since ring is expected to be invalidated */
-    xive2_tctx_get_nvp_indexes(tctx, alt_ring, &nvp_blk, &nvp_idx);
+    xive2_tctx_get_nvp_indexes(tctx, ring, &nvp_blk, &nvp_idx);
 
-    trace_xive_redistribute(tctx->cs->cpu_index, alt_ring, nvp_blk, nvp_idx);
+    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
 
     trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
@@ -675,23 +670,11 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
 
     /* clear interrupt indication for the context */
-    alt_regs[TM_NSR] = 0;
-    alt_regs[TM_PIPR] = alt_regs[TM_CPPR];
+    sig_regs[TM_NSR] = 0;
+    sig_regs[TM_PIPR] = sig_regs[TM_CPPR];
     xive_tctx_reset_signal(tctx, ring);
 }
 
-static uint8_t xive2_hv_irq_ring(uint8_t nsr)
-{
-    switch (nsr >> 6) {
-    case TM_QW3_NSR_HE_POOL:
-        return TM_QW2_HV_POOL;
-    case TM_QW3_NSR_HE_PHYS:
-        return TM_QW3_HV_PHYS;
-    default:
-        return -1;
-    }
-}
-
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -718,7 +701,8 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         uint32_t ringw2 = xive_tctx_word2(&tctx->regs[cur_ring]);
         uint32_t ringw2_new = xive_set_field32(TM2_QW1W2_VO, ringw2, 0);
         bool is_valid = !!(xive_get_field32(TM2_QW1W2_VO, ringw2));
-        uint8_t alt_ring;
+        uint8_t *sig_regs;
+
         memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
 
         /* Skip the rest for USER or invalid contexts */
@@ -727,12 +711,11 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         }
 
         /* Active group/crowd interrupts need to be redistributed */
-        alt_ring = (cur_ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : cur_ring;
-        nsr = tctx->regs[alt_ring + TM_NSR];
-        if (xive_nsr_indicates_group_exception(alt_ring, nsr)) {
-            /* For HV rings, only redistribute if cur_ring matches NSR */
-            if ((cur_ring == TM_QW1_OS) ||
-                (cur_ring == xive2_hv_irq_ring(nsr))) {
+        sig_regs = xive_tctx_signal_regs(tctx, ring);
+        nsr = sig_regs[TM_NSR];
+        if (xive_nsr_indicates_group_exception(cur_ring, nsr)) {
+            /* Ensure ring matches NSR (for HV NSR POOL vs PHYS rings) */
+            if (cur_ring == xive_nsr_exception_ring(cur_ring, nsr)) {
                 xive2_redistribute(xrtr, tctx, cur_ring);
             }
         }
@@ -1118,7 +1101,7 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
 /* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
 static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
-    uint8_t *regs = &tctx->regs[ring];
+    uint8_t *sig_regs = &tctx->regs[ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
     uint8_t old_cppr, backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
@@ -1127,33 +1110,41 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
     uint32_t nvp_idx;
     Xive2Nvp nvp;
     int rc;
-    uint8_t nsr = regs[TM_NSR];
+    uint8_t nsr = sig_regs[TM_NSR];
+
+    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
 
+    /* XXX: should show pool IPB for PHYS ring */
     trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
-                             regs[TM_IPB], regs[TM_PIPR],
+                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
                              cppr, nsr);
 
     if (cppr > XIVE_PRIORITY_MAX) {
         cppr = 0xff;
     }
 
-    old_cppr = regs[TM_CPPR];
-    regs[TM_CPPR] = cppr;
+    old_cppr = sig_regs[TM_CPPR];
+    sig_regs[TM_CPPR] = cppr;
 
     /* Handle increased CPPR priority (lower value) */
     if (cppr < old_cppr) {
-        if (cppr <= regs[TM_PIPR]) {
+        if (cppr <= sig_regs[TM_PIPR]) {
             /* CPPR lowered below PIPR, must un-present interrupt */
             if (xive_nsr_indicates_exception(ring, nsr)) {
                 if (xive_nsr_indicates_group_exception(ring, nsr)) {
                     /* redistribute precluded active grp interrupt */
-                    xive2_redistribute(xrtr, tctx, ring);
+                    xive2_redistribute(xrtr, tctx,
+                                       xive_nsr_exception_ring(ring, nsr));
                     return;
                 }
             }
 
             /* interrupt is VP directed, pending in IPB */
-            regs[TM_PIPR] = cppr;
+            sig_regs[TM_PIPR] = cppr;
             xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
             return;
         } else {
@@ -1174,9 +1165,9 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
      * be adjusted below if needed in case of pending group interrupts.
      */
 again:
-    pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
-    group_enabled = !!regs[TM_LGS];
-    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
+    pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
+    group_enabled = !!sig_regs[TM_LGS];
+    lsmfb_min = group_enabled ? sig_regs[TM_LSMFB] : 0xff;
     ring_min = ring;
     group_level = 0;
 
@@ -1265,7 +1256,7 @@ again:
     }
 
     /* PIPR should not be set to a value greater than CPPR */
-    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
+    sig_regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
 
     /* CPPR has changed, check if we need to raise a pending exception */
     xive_tctx_notify(tctx, ring_min, group_level);
@@ -1490,9 +1481,7 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
 
 bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
 {
-    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
-    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-    uint8_t *alt_regs = &tctx->regs[alt_ring];
+    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
 
     /*
      * The xive2_presenter_tctx_match() above tells if there's a match
@@ -1500,7 +1489,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
      * priority to know if the thread can take the interrupt now or if
      * it is precluded.
      */
-    if (priority < alt_regs[TM_PIPR]) {
+    if (priority < sig_regs[TM_PIPR]) {
         return false;
     }
     return true;
@@ -1640,14 +1629,13 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
                              &match)) {
         XiveTCTX *tctx = match.tctx;
         uint8_t ring = match.ring;
-        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
-        uint8_t *aregs = &tctx->regs[alt_ring];
-        uint8_t nsr = aregs[TM_NSR];
+        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+        uint8_t nsr = sig_regs[TM_NSR];
         uint8_t group_level;
 
-        if (priority < aregs[TM_PIPR] &&
-            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
-            xive2_redistribute(xrtr, tctx, alt_ring);
+        if (priority < sig_regs[TM_PIPR] &&
+            xive_nsr_indicates_group_exception(ring, nsr)) {
+            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
         }
 
         group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
-- 
2.50.1


