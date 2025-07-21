Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18842C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtLR-0004YI-QR; Mon, 21 Jul 2025 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJl-00082m-4T
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJi-0001ly-Qt
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4MofCW4WrhSQMxEwKn+6DDYjv8FRn8QpBov5/RmA4x8=;
 b=W+EquccD639dZdHt9bExA8G7RD1BQbC+SOGrbri1HixpIQrh8D94POhhOcxIHyHXiMcNOy
 GBoZ2DQLRy2WoHcu3+ZNzA4XvpTlizIHRWha35QAPYhYze9F/rkWKAw1m+tm3fp4I0bzSg
 ZQHz0p7dlnnnGwUFehQW8PdVI8EXbgg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8--p9Pk16LM0qIZmw-i9arGg-1; Mon,
 21 Jul 2025 12:24:38 -0400
X-MC-Unique: -p9Pk16LM0qIZmw-i9arGg-1
X-Mimecast-MFC-AGG-ID: -p9Pk16LM0qIZmw-i9arGg_1753115076
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3079195FD1B; Mon, 21 Jul 2025 16:24:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70E5E19560AD; Mon, 21 Jul 2025 16:24:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 42/50] ppc/xive: Redistribute phys after pulling of pool context
Date: Mon, 21 Jul 2025 18:22:25 +0200
Message-ID: <20250721162233.686837-43-clg@redhat.com>
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

After pulling the pool context, if a pool irq had been presented and
was cleared in the process, there could be a pending irq in phys that
should be presented. Process the phys irq ring after pulling pool ring
to catch this case and avoid losing irqs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-43-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c  |  3 +++
 hw/intc/xive2.c | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d609d552e89e..50a38bbf2ef9 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -320,6 +320,9 @@ static uint64_t xive_tm_pull_pool_ctx(XivePresenter *xptr, XiveTCTX *tctx,
 
     xive_tctx_reset_signal(tctx, TM_QW1_OS);
     xive_tctx_reset_signal(tctx, TM_QW2_HV_POOL);
+    /* Re-check phys for interrupts if pool was disabled */
+    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW3_HV_PHYS);
+
     return qw2w2;
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 112397459afe..e3f9ff384a1a 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -683,6 +683,8 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx, uint8_t ring)
     xive_tctx_reset_signal(tctx, ring);
 }
 
+static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
+
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -739,6 +741,18 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         }
     }
 
+    if (ring == TM_QW2_HV_POOL) {
+        /* Re-check phys for interrupts if pool was disabled */
+        nsr = tctx->regs[TM_QW3_HV_PHYS + TM_NSR];
+        if (xive_nsr_indicates_exception(TM_QW3_HV_PHYS, nsr)) {
+            /* Ring must be PHYS because POOL would have been redistributed */
+            g_assert(xive_nsr_exception_ring(TM_QW3_HV_PHYS, nsr) ==
+                                                           TM_QW3_HV_PHYS);
+        } else {
+            xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
+        }
+    }
+
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
         xive2_tctx_save_ctx(xrtr, tctx, ring, nvp_blk, nvp_idx);
     }
@@ -925,8 +939,6 @@ static uint8_t xive2_tctx_restore_ctx(Xive2Router *xrtr, XiveTCTX *tctx,
     return cppr;
 }
 
-static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring);
-
 static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
-- 
2.50.1


