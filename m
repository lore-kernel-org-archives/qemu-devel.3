Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F22C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtLd-00055k-Tq; Mon, 21 Jul 2025 12:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtK3-0000UJ-0C
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtK0-0001rc-TE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2Ytn8gCoH4cLDg3wEy7JfoNBafewUw23FBIc8zPuso=;
 b=Hbqys87ujBoYUmFBVLAaK8Su8LKXfHo+bndcfrU6GTgQiC8MACUp/ox0s1jnLPHsEuEEtY
 YYkxSLrcFieP+tbpLG6Z8E62FhgPKZGnlBzJnIsCxZREG7HsfHl4W9oo5OO1UCJ1VewPM4
 Rdp13jGygZ52jTZ7M5YB9fL9M4uFv9o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-JJ9-8hoiMAuQyMlU0a8-Uw-1; Mon,
 21 Jul 2025 12:24:57 -0400
X-MC-Unique: JJ9-8hoiMAuQyMlU0a8-Uw-1
X-Mimecast-MFC-AGG-ID: JJ9-8hoiMAuQyMlU0a8-Uw_1753115095
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C80C5180028E; Mon, 21 Jul 2025 16:24:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94E5C195608D; Mon, 21 Jul 2025 16:24:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 49/50] ppc/xive: Split need_resend into restore_nvp
Date: Mon, 21 Jul 2025 18:22:32 +0200
Message-ID: <20250721162233.686837-50-clg@redhat.com>
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

This is needed by the next patch which will re-send on all lower
rings when pushing a context.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-50-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c  | 24 ++++++++++++------------
 hw/intc/xive2.c | 28 ++++++++++++++++------------
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8b7182fbb86c..e0ffcf89ebff 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -606,7 +606,7 @@ static uint64_t xive_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     return qw1w2;
 }
 
-static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
+static void xive_tctx_restore_nvp(XiveRouter *xrtr, XiveTCTX *tctx,
                                   uint8_t nvt_blk, uint32_t nvt_idx)
 {
     XiveNVT nvt;
@@ -632,16 +632,6 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
         uint8_t *regs = &tctx->regs[TM_QW1_OS];
         regs[TM_IPB] |= ipb;
     }
-
-    /*
-     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
-     * escalation triggered, there could be a pending interrupt which
-     * was saved when the context was pulled and that we need to take
-     * into account by recalculating the PIPR (which is not
-     * saved/restored).
-     * It will also raise the External interrupt signal if needed.
-     */
-    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
 }
 
 /*
@@ -663,7 +653,17 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     /* Check the interrupt pending bits */
     if (vo) {
-        xive_tctx_need_resend(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx);
+        xive_tctx_restore_nvp(XIVE_ROUTER(xptr), tctx, nvt_blk, nvt_idx);
+
+        /*
+         * Always call xive_tctx_recompute_from_ipb(). Even if there were no
+         * escalation triggered, there could be a pending interrupt which
+         * was saved when the context was pulled and that we need to take
+         * into account by recalculating the PIPR (which is not
+         * saved/restored).
+         * It will also raise the External interrupt signal if needed.
+         */
+        xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
     }
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 1b005687961a..c3c6871e91b3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -940,14 +940,14 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     return cppr;
 }
 
-static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
+/* Restore TIMA VP context from NVP backlog */
+static void xive2_tctx_restore_nvp(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t ring,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
-    uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
     uint8_t *regs = &tctx->regs[ring];
-    uint8_t ipb, nsr = sig_regs[TM_NSR];
+    uint8_t ipb;
     Xive2Nvp nvp;
 
     /*
@@ -978,14 +978,6 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     }
     /* IPB bits in the backlog are merged with the TIMA IPB bits */
     regs[TM_IPB] |= ipb;
-
-    if (xive_nsr_indicates_group_exception(ring, nsr)) {
-        /* redistribute precluded active grp interrupt */
-        g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the grp interrupt */
-        xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
-    }
-    xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
-                                         TM_QW3_HV_PHYS : ring);
 }
 
 /*
@@ -1028,8 +1020,20 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     /* Check the interrupt pending bits */
     if (v) {
-        xive2_tctx_need_resend(XIVE2_ROUTER(xptr), tctx, ring,
+        Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
+        uint8_t nsr = sig_regs[TM_NSR];
+
+        xive2_tctx_restore_nvp(xrtr, tctx, ring,
                                nvp_blk, nvp_idx, do_restore);
+
+        if (xive_nsr_indicates_group_exception(ring, nsr)) {
+            /* redistribute precluded active grp interrupt */
+            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
+            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
+        }
+        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
+                                                 TM_QW3_HV_PHYS : ring);
     }
 }
 
-- 
2.50.1


