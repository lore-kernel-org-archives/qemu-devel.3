Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E2BC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKY-0002Nz-0U; Mon, 21 Jul 2025 12:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJW-0007HZ-Pt
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJU-0001jO-HG
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n9PU1TINKvwzlVlW2Mxn7amCQ1BCtiAX2cpzPNc5w4s=;
 b=eY9ruN1BSyTNkZUfF0D71XLe6SU70PP9mqcgmobXnuatmpGXnAE3puz0QlWBw0C7AJeAzZ
 xRecV+/SEBDQPLlwe9vv3zc3PeKRjrkH/zyFK0ciU4z1ojtdFtjrr1tNlsPEFrqkY1YFrB
 fHjVrLBPDe3emovQhNPDGUaQUI776Go=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-GVsQnynHM7SKXFlrri1u9Q-1; Mon,
 21 Jul 2025 12:24:24 -0400
X-MC-Unique: GVsQnynHM7SKXFlrri1u9Q-1
X-Mimecast-MFC-AGG-ID: GVsQnynHM7SKXFlrri1u9Q_1753115063
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E0E1800292; Mon, 21 Jul 2025 16:24:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04E0D195608D; Mon, 21 Jul 2025 16:24:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 37/50] ppc/xive2: Consolidate presentation processing in
 context push
Date: Mon, 21 Jul 2025 18:22:20 +0200
Message-ID: <20250721162233.686837-38-clg@redhat.com>
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

OS-push operation must re-present pending interrupts. Use the
newly created xive2_tctx_process_pending() function instead of
duplicating the logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-38-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c7356c5b2fd8..be945bef1c53 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -903,18 +903,14 @@ static uint8_t xive2_tctx_restore_os_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     return cppr;
 }
 
+static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
+
 static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    XivePresenter *xptr = XIVE_PRESENTER(xrtr);
-    uint8_t ipb;
-    uint8_t backlog_level;
-    uint8_t group_level;
-    uint8_t first_group;
-    uint8_t backlog_prio;
-    uint8_t group_prio;
     uint8_t *regs = &tctx->regs[TM_QW1_OS];
+    uint8_t ipb;
     Xive2Nvp nvp;
 
     /*
@@ -946,30 +942,8 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
-    backlog_prio = xive_ipb_to_pipr(regs[TM_IPB]);
-    backlog_level = 0;
-
-    first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
-    if (first_group && regs[TM_LSMFB] < backlog_prio) {
-        group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
-                                                  first_group, &group_level);
-        regs[TM_LSMFB] = group_prio;
-        if (regs[TM_LGS] && group_prio < backlog_prio &&
-            group_prio < regs[TM_CPPR]) {
-
-            /* VP can take a group interrupt */
-            xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
-                                         group_prio, group_level);
-            backlog_prio = group_prio;
-            backlog_level = group_level;
-        }
-    }
 
-    /*
-     * Set the PIPR/NSR based on the restored state.
-     * It will raise the External interrupt signal if needed.
-     */
-    xive_tctx_pipr_set(tctx, TM_QW1_OS, backlog_prio, backlog_level);
+    xive2_tctx_process_pending(tctx, TM_QW1_OS);
 }
 
 /*
@@ -1103,8 +1077,12 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
 {
     uint8_t *sig_regs = &tctx->regs[sig_ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
-    uint8_t backlog_prio, first_group, group_level;
-    uint8_t pipr_min, lsmfb_min, ring_min;
+    uint8_t backlog_prio;
+    uint8_t first_group;
+    uint8_t group_level;
+    uint8_t pipr_min;
+    uint8_t lsmfb_min;
+    uint8_t ring_min;
     uint8_t cppr = sig_regs[TM_CPPR];
     bool group_enabled;
     Xive2Nvp nvp;
-- 
2.50.1


