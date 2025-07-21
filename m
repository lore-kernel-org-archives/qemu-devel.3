Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F466C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMg-0006vz-4x; Mon, 21 Jul 2025 12:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJH-0006KS-S7
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJF-0001gL-ON
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bMh+LdQrAb64bov6H42Yd32t7AMR09/gX5XqffGEYdg=;
 b=bKgtcl+Q3sxikBWPNFdzdSJp5v27g/P0oVu5Ee8bfrgHe+68WO4AJD4UuWG91mMBlu9Tiw
 is5tpWC7rimJOxrACV5qu4DLkT1g4SLv33xCe+0EpMHjyDTBcNemfuWlWgtIw8AgpCqwA/
 GwXEoTLZV0nOqohxL2T7SL+1i2l3gXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-uYMmAyBROFy33agyJskrSA-1; Mon,
 21 Jul 2025 12:24:11 -0400
X-MC-Unique: uYMmAyBROFy33agyJskrSA-1
X-Mimecast-MFC-AGG-ID: uYMmAyBROFy33agyJskrSA_1753115049
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DE2C1944CEE; Mon, 21 Jul 2025 16:24:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF052195608D; Mon, 21 Jul 2025 16:24:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 32/50] ppc/xive: Split xive recompute from IPB function
Date: Mon, 21 Jul 2025 18:22:15 +0200
Message-ID: <20250721162233.686837-33-clg@redhat.com>
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

Further split xive_tctx_pipr_update() by splitting out a new function
that is used to re-compute the PIPR from IPB. This is generally only
used with XIVE1, because group interrputs require more logic.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-33-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7110cf45d74f..5deb2f478fcb 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -225,6 +225,20 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
     xive_tctx_notify(tctx, ring, group_level);
  }
 
+static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t ring)
+{
+    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
+    uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+    uint8_t *aregs = &tctx->regs[alt_ring];
+    uint8_t *regs = &tctx->regs[ring];
+
+    /* Does not support a presented group interrupt */
+    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR]));
+
+    aregs[TM_PIPR] = xive_ipb_to_pipr(regs[TM_IPB]);
+    xive_tctx_notify(tctx, ring, 0);
+}
+
 void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                             uint8_t group_level)
 {
@@ -517,7 +531,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
 static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
                                    hwaddr offset, uint64_t value, unsigned size)
 {
-    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
+    uint8_t ring = TM_QW1_OS;
+    uint8_t *regs = &tctx->regs[ring];
+
+    /* XXX: how should this work exactly? */
+    regs[TM_IPB] |= xive_priority_to_ipb(value & 0xff);
+    xive_tctx_pipr_recompute_from_ipb(tctx, ring);
 }
 
 static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
@@ -601,14 +620,14 @@ static void xive_tctx_need_resend(XiveRouter *xrtr, XiveTCTX *tctx,
     }
 
     /*
-     * Always call xive_tctx_pipr_update(). Even if there were no
+     * Always call xive_tctx_recompute_from_ipb(). Even if there were no
      * escalation triggered, there could be a pending interrupt which
      * was saved when the context was pulled and that we need to take
      * into account by recalculating the PIPR (which is not
      * saved/restored).
      * It will also raise the External interrupt signal if needed.
      */
-    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
+    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
 }
 
 /*
-- 
2.50.1


