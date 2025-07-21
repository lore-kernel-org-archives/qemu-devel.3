Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CE1C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKh-0002qW-AQ; Mon, 21 Jul 2025 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJT-0006sm-01
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJR-0001iu-1S
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aM5Ia520DaYoYHJUWxL34hd3Pcd0ra2BcSTJ2TP3Xo=;
 b=EbXglD3O34HVwQsDJaBieX9aNWQjSR6/SYnewxzZP97AQJ7DBZZiZB9eUKNIO8LFFbkDhR
 b534tf7KlrybJOOwed+p7TO+HcyozWsdgSvuQi2qWbs/QM6KixufvQ1CPooOIfaJq/FgWb
 g2ymib6nwS9WD0xTp+Ps+IVVZ3KPY6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-jAS_oAbbNnOeiF_v1JYO_Q-1; Mon,
 21 Jul 2025 12:24:18 -0400
X-MC-Unique: jAS_oAbbNnOeiF_v1JYO_Q-1
X-Mimecast-MFC-AGG-ID: jAS_oAbbNnOeiF_v1JYO_Q_1753115057
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A44A119560B4; Mon, 21 Jul 2025 16:24:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A0BA8195608D; Mon, 21 Jul 2025 16:24:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 35/50] ppc/xive: Add xive_tctx_pipr_set() helper function
Date: Mon, 21 Jul 2025 18:22:18 +0200
Message-ID: <20250721162233.686837-36-clg@redhat.com>
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

Have xive_tctx_notify() also set the new PIPR value and rename it to
xive_tctx_pipr_set(). This can replace the last xive_tctx_pipr_update()
caller because it does not need to update IPB (it already sets it).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-36-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h |  5 ++---
 hw/intc/xive.c        | 39 +++++++++++----------------------------
 hw/intc/xive2.c       | 16 +++++++---------
 3 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a3c2f50ecef7..2372d1014bd2 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -584,12 +584,11 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf);
 Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
-void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
-                           uint8_t group_level);
+void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                        uint8_t group_level);
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
-void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
 uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
 
 /*
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index db26dae7dbf4..6ad84f93c77a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -125,12 +125,16 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
     return ((uint64_t)nsr << 8) | sig_regs[TM_CPPR];
 }
 
-void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
+/* Change PIPR and calculate NSR and irq based on PIPR, CPPR, group */
+void xive_tctx_pipr_set(XiveTCTX *tctx, uint8_t ring, uint8_t pipr,
+                        uint8_t group_level)
 {
     uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
 
-    if (sig_regs[TM_PIPR] < sig_regs[TM_CPPR]) {
+    sig_regs[TM_PIPR] = pipr;
+
+    if (pipr < sig_regs[TM_CPPR]) {
         switch (ring) {
         case TM_QW1_OS:
             sig_regs[TM_NSR] = TM_QW1_NSR_EO | (group_level & 0x3F);
@@ -145,7 +149,7 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
             g_assert_not_reached();
         }
         trace_xive_tctx_notify(tctx->cs->cpu_index, ring,
-                               regs[TM_IPB], sig_regs[TM_PIPR],
+                               regs[TM_IPB], pipr,
                                sig_regs[TM_CPPR], sig_regs[TM_NSR]);
         qemu_irq_raise(xive_tctx_output(tctx, ring));
     } else {
@@ -213,29 +217,10 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         }
     }
 
-    sig_regs[TM_PIPR] = pipr_min;
-
-    /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring_min, 0);
+    /* CPPR has changed, this may present or preclude a pending exception */
+    xive_tctx_pipr_set(tctx, ring_min, pipr_min, 0);
 }
 
-void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
-                           uint8_t group_level)
-{
-    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
-    uint8_t *regs = &tctx->regs[ring];
-
-    if (group_level == 0) {
-        /* VP-specific */
-        regs[TM_IPB] |= xive_priority_to_ipb(priority);
-        sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
-    } else {
-        /* VP-group */
-        sig_regs[TM_PIPR] = xive_priority_to_pipr(priority);
-    }
-    xive_tctx_notify(tctx, ring, group_level);
- }
-
 static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
@@ -244,8 +229,7 @@ static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
     /* Does not support a presented group interrupt */
     g_assert(!xive_nsr_indicates_group_exception(ring, sig_regs[TM_NSR]));
 
-    sig_regs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
-    xive_tctx_notify(tctx, ring, 0);
+    xive_tctx_pipr_set(tctx, ring, xive_ipb_to_pipr(regs[TM_IPB]), 0);
 }
 
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
@@ -264,8 +248,7 @@ void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
     }
     g_assert(pipr <= xive_ipb_to_pipr(regs[TM_IPB]));
     g_assert(pipr < sig_regs[TM_PIPR]);
-    sig_regs[TM_PIPR] = pipr;
-    xive_tctx_notify(tctx, ring, group_level);
+    xive_tctx_pipr_set(tctx, ring, pipr, group_level);
 }
 
 /*
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 71b40f702a6f..0ee50a6bca48 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -966,10 +966,10 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
 
     /*
-     * Compute the PIPR based on the restored state.
+     * Set the PIPR/NSR based on the restored state.
      * It will raise the External interrupt signal if needed.
      */
-    xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);
+    xive_tctx_pipr_set(tctx, TM_QW1_OS, backlog_prio, backlog_level);
 }
 
 /*
@@ -1144,8 +1144,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
             }
 
             /* interrupt is VP directed, pending in IPB */
-            sig_regs[TM_PIPR] = cppr;
-            xive_tctx_notify(tctx, ring, 0); /* Ensure interrupt is cleared */
+            xive_tctx_pipr_set(tctx, ring, cppr, 0);
             return;
         } else {
             /* CPPR was lowered, but still above PIPR. No action needed. */
@@ -1255,11 +1254,10 @@ again:
         pipr_min = backlog_prio;
     }
 
-    /* PIPR should not be set to a value greater than CPPR */
-    sig_regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
-
-    /* CPPR has changed, check if we need to raise a pending exception */
-    xive_tctx_notify(tctx, ring_min, group_level);
+    if (pipr_min > cppr) {
+        pipr_min = cppr;
+    }
+    xive_tctx_pipr_set(tctx, ring_min, pipr_min, group_level);
 }
 
 void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.50.1


