Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB183C87FCA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtLM-0004CZ-7T; Mon, 21 Jul 2025 12:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJW-0007I8-Sq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJT-0001jF-Kz
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51nGWzogTVcmJa/tKMAynV/Y5esDhRuxUtEpzYN+gsc=;
 b=in0PmlvkOhfSCN/yUESzADnlXy1zhJzecf3kwXjfX4ECCZ6zBssaTBDrYxAeY+gytn2mVh
 UTn3IEgndqmzexPnCD6ItDdQ0riruSDOrstmTiFX8GNmz8/Z0YLvxV4MI5WlTZNUP25UcH
 sEtgrQLDs9NG8+1nuhC8XVe4s3IrgoA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-9LMg1I0cO-ainuxnE6RB2g-1; Mon,
 21 Jul 2025 12:24:21 -0400
X-MC-Unique: 9LMg1I0cO-ainuxnE6RB2g-1
X-Mimecast-MFC-AGG-ID: 9LMg1I0cO-ainuxnE6RB2g_1753115060
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85D711956089; Mon, 21 Jul 2025 16:24:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 234B2195608D; Mon, 21 Jul 2025 16:24:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 36/50] ppc/xive2: split tctx presentation processing from set
 CPPR
Date: Mon, 21 Jul 2025 18:22:19 +0200
Message-ID: <20250721162233.686837-37-clg@redhat.com>
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

The second part of the set CPPR operation is to process (or re-present)
any pending interrupts after CPPR is adjusted.

Split this presentation processing out into a standalone function that
can be used in other places.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-37-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 137 +++++++++++++++++++++++++++---------------------
 1 file changed, 76 insertions(+), 61 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 0ee50a6bca48..c7356c5b2fd8 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1098,66 +1098,19 @@ void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
 }
 
-/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
-static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
+/* Re-calculate and present pending interrupts */
+static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
 {
-    uint8_t *sig_regs = &tctx->regs[ring];
+    uint8_t *sig_regs = &tctx->regs[sig_ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
-    uint8_t old_cppr, backlog_prio, first_group, group_level;
+    uint8_t backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
+    uint8_t cppr = sig_regs[TM_CPPR];
     bool group_enabled;
-    uint8_t nvp_blk;
-    uint32_t nvp_idx;
     Xive2Nvp nvp;
     int rc;
-    uint8_t nsr = sig_regs[TM_NSR];
-
-    g_assert(ring == TM_QW1_OS || ring == TM_QW3_HV_PHYS);
-
-    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
-    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
-    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
-
-    /* XXX: should show pool IPB for PHYS ring */
-    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
-                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
-                             cppr, nsr);
-
-    if (cppr > XIVE_PRIORITY_MAX) {
-        cppr = 0xff;
-    }
-
-    old_cppr = sig_regs[TM_CPPR];
-    sig_regs[TM_CPPR] = cppr;
-
-    /* Handle increased CPPR priority (lower value) */
-    if (cppr < old_cppr) {
-        if (cppr <= sig_regs[TM_PIPR]) {
-            /* CPPR lowered below PIPR, must un-present interrupt */
-            if (xive_nsr_indicates_exception(ring, nsr)) {
-                if (xive_nsr_indicates_group_exception(ring, nsr)) {
-                    /* redistribute precluded active grp interrupt */
-                    xive2_redistribute(xrtr, tctx,
-                                       xive_nsr_exception_ring(ring, nsr));
-                    return;
-                }
-            }
 
-            /* interrupt is VP directed, pending in IPB */
-            xive_tctx_pipr_set(tctx, ring, cppr, 0);
-            return;
-        } else {
-            /* CPPR was lowered, but still above PIPR. No action needed. */
-            return;
-        }
-    }
-
-    /* CPPR didn't change, nothing needs to be done */
-    if (cppr == old_cppr) {
-        return;
-    }
-
-    /* CPPR priority decreased (higher value) */
+    g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
 
     /*
      * Recompute the PIPR based on local pending interrupts. It will
@@ -1167,11 +1120,11 @@ again:
     pipr_min = xive_ipb_to_pipr(sig_regs[TM_IPB]);
     group_enabled = !!sig_regs[TM_LGS];
     lsmfb_min = group_enabled ? sig_regs[TM_LSMFB] : 0xff;
-    ring_min = ring;
+    ring_min = sig_ring;
     group_level = 0;
 
     /* PHYS updates also depend on POOL values */
-    if (ring == TM_QW3_HV_PHYS) {
+    if (sig_ring == TM_QW3_HV_PHYS) {
         uint8_t *pool_regs = &tctx->regs[TM_QW2_HV_POOL];
 
         /* POOL values only matter if POOL ctx is valid */
@@ -1201,20 +1154,25 @@ again:
         }
     }
 
-    rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
-    if (rc) {
-        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
-        return;
-    }
-
     if (group_enabled &&
         lsmfb_min < cppr &&
         lsmfb_min < pipr_min) {
+
+        uint8_t nvp_blk;
+        uint32_t nvp_idx;
+
         /*
          * Thread has seen a group interrupt with a higher priority
          * than the new cppr or pending local interrupt. Check the
          * backlog
          */
+        rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
+        if (rc) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid "
+                                           "context\n");
+            return;
+        }
+
         if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
                           nvp_blk, nvp_idx);
@@ -1260,6 +1218,63 @@ again:
     xive_tctx_pipr_set(tctx, ring_min, pipr_min, group_level);
 }
 
+/* NOTE: CPPR only exists for TM_QW1_OS and TM_QW3_HV_PHYS */
+static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t sig_ring, uint8_t cppr)
+{
+    uint8_t *sig_regs = &tctx->regs[sig_ring];
+    Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
+    uint8_t old_cppr;
+    uint8_t nsr = sig_regs[TM_NSR];
+
+    g_assert(sig_ring == TM_QW1_OS || sig_ring == TM_QW3_HV_PHYS);
+
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_NSR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
+    g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
+
+    /* XXX: should show pool IPB for PHYS ring */
+    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, sig_ring,
+                             sig_regs[TM_IPB], sig_regs[TM_PIPR],
+                             cppr, nsr);
+
+    if (cppr > XIVE_PRIORITY_MAX) {
+        cppr = 0xff;
+    }
+
+    old_cppr = sig_regs[TM_CPPR];
+    sig_regs[TM_CPPR] = cppr;
+
+    /* Handle increased CPPR priority (lower value) */
+    if (cppr < old_cppr) {
+        if (cppr <= sig_regs[TM_PIPR]) {
+            /* CPPR lowered below PIPR, must un-present interrupt */
+            if (xive_nsr_indicates_exception(sig_ring, nsr)) {
+                if (xive_nsr_indicates_group_exception(sig_ring, nsr)) {
+                    /* redistribute precluded active grp interrupt */
+                    xive2_redistribute(xrtr, tctx,
+                                       xive_nsr_exception_ring(sig_ring, nsr));
+                    return;
+                }
+            }
+
+            /* interrupt is VP directed, pending in IPB */
+            xive_tctx_pipr_set(tctx, sig_ring, cppr, 0);
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
+    xive2_tctx_process_pending(tctx, sig_ring);
+}
+
 void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size)
 {
-- 
2.50.1


