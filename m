Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E668AC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtLO-0004Rp-G2; Mon, 21 Jul 2025 12:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIm-0004k1-NZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIW-0001Tl-2V
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6MQGkz4Wgu6/6GQyFnRG9Xy+yrPEm89A5MiJBkiVz4=;
 b=cXMHwIcjPrKZQ6sHrgqlFNR+ZfcRhMGHGdWtFOqDVLd2Sbv2ZVch/VU0M8Ly5fLp0bh6Lk
 0TGJe5RAdUtXZK7yavA9QS25QJ070bgLLt+nrdlaKcvSBvQq4uOrEQGiPLmXafU7BE4bLI
 GCWfCx96NlEXESK1lXOH86Wg3M7a/8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-72NvYdWjM12kdZ4wfhbMHA-1; Mon,
 21 Jul 2025 12:23:13 -0400
X-MC-Unique: 72NvYdWjM12kdZ4wfhbMHA-1
X-Mimecast-MFC-AGG-ID: 72NvYdWjM12kdZ4wfhbMHA_1753114992
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D57A1800292; Mon, 21 Jul 2025 16:23:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B30419560AD; Mon, 21 Jul 2025 16:23:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 12/50] ppc/xive2: Set CPPR delivery should account for group
 priority
Date: Mon, 21 Jul 2025 18:21:55 +0200
Message-ID: <20250721162233.686837-13-clg@redhat.com>
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

The group interrupt delivery flow selects the group backlog scan if
LSMFB < IPB, but that scan may find an interrupt with a priority >=
IPB. In that case, the VP-direct interrupt should be chosen. This
extends to selecting the lowest prio between POOL and PHYS rings.

Implement this just by re-starting the selection logic if the
backlog irq was not found or priority did not match LSMFB (LSMFB
is updated so next time around it would see the right value and
not loop infinitely).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-13-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 181d1ae5f940..cca121b5f13c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -939,7 +939,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
-    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
+    uint8_t old_cppr, backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
     bool group_enabled;
     uint32_t nvp_blk, nvp_idx;
@@ -961,10 +961,12 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
      * Recompute the PIPR based on local pending interrupts. It will
      * be adjusted below if needed in case of pending group interrupts.
      */
+again:
     pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
     group_enabled = !!regs[TM_LGS];
-    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
+    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
     ring_min = ring;
+    group_level = 0;
 
     /* PHYS updates also depend on POOL values */
     if (ring == TM_QW3_HV_PHYS) {
@@ -998,9 +1000,6 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         }
     }
 
-    /* PIPR should not be set to a value greater than CPPR */
-    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
-
     rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
     if (rc) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
@@ -1019,7 +1018,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
     if (group_enabled &&
         lsmfb_min < cppr &&
-        lsmfb_min < regs[TM_PIPR]) {
+        lsmfb_min < pipr_min) {
         /*
          * Thread has seen a group interrupt with a higher priority
          * than the new cppr or pending local interrupt. Check the
@@ -1048,12 +1047,25 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
                                                     nvp_blk, nvp_idx,
                                                     first_group, &group_level);
         tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
-        if (backlog_prio != 0xFF) {
-            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
-                                         backlog_prio, group_level);
-            regs[TM_PIPR] = backlog_prio;
+        if (backlog_prio != lsmfb_min) {
+            /*
+             * If the group backlog scan finds a less favored or no interrupt,
+             * then re-do the processing which may turn up a more favored
+             * interrupt from IPB or the other pool. Backlog should not
+             * find a priority < LSMFB.
+             */
+            g_assert(backlog_prio >= lsmfb_min);
+            goto again;
         }
+
+        xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
+                                     backlog_prio, group_level);
+        pipr_min = backlog_prio;
     }
+
+    /* PIPR should not be set to a value greater than CPPR */
+    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
+
     /* CPPR has changed, check if we need to raise a pending exception */
     xive_tctx_notify(tctx, ring_min, group_level);
 }
-- 
2.50.1


