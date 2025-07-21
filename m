Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7DDCC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtJW-00079R-J5; Mon, 21 Jul 2025 12:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIn-0004kF-3Z
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIe-0001Uf-Np
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aoGnDApgNu0EkgdF9KtXDN8OWeByCAqj+mmqYM6gKEA=;
 b=dunV1qNaJf78GWsF8vRqu74Ma3mxuHT5epI7qkAucpUMVtUGYZbUkAIharlEYEe7rtMll2
 Y9SkOzKDt9rGyB68Y1bYrzKJRXNk562i0HE33zhXAmRSeaxnxO4+B2XfdJhwIET9Zxw3za
 qHoCvhPFoYgCQdrHGArqJIGoLnUzl5M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-mrY21r5vPuC9SIJsS3Q6dg-1; Mon,
 21 Jul 2025 12:23:23 -0400
X-MC-Unique: mrY21r5vPuC9SIJsS3Q6dg-1
X-Mimecast-MFC-AGG-ID: mrY21r5vPuC9SIJsS3Q6dg_1753115001
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73B1E1977307; Mon, 21 Jul 2025 16:23:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E21D8195608D; Mon, 21 Jul 2025 16:23:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/50] ppc/xive: Move NSR decoding into helper functions
Date: Mon, 21 Jul 2025 18:21:58 +0200
Message-ID: <20250721162233.686837-16-clg@redhat.com>
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

Rather than functions to return masks to test NSR bits, have functions
to test those bits directly. This should be no functional change, it
just makes the code more readable.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-16-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h |  4 ++++
 hw/intc/xive.c        | 51 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 538f43868172..28f0f1b79ad7 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -365,6 +365,10 @@ static inline uint32_t xive_tctx_word2(uint8_t *ring)
     return *((uint32_t *) &ring[TM_WORD2]);
 }
 
+bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr);
+bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr);
+uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr);
+
 /*
  * XIVE Router
  */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b35d2ec1793e..8537cad27b2a 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -25,6 +25,45 @@
 /*
  * XIVE Thread Interrupt Management context
  */
+bool xive_nsr_indicates_exception(uint8_t ring, uint8_t nsr)
+{
+    switch (ring) {
+    case TM_QW1_OS:
+        return !!(nsr & TM_QW1_NSR_EO);
+    case TM_QW2_HV_POOL:
+    case TM_QW3_HV_PHYS:
+        return !!(nsr & TM_QW3_NSR_HE);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+bool xive_nsr_indicates_group_exception(uint8_t ring, uint8_t nsr)
+{
+    if ((nsr & TM_NSR_GRP_LVL) > 0) {
+        g_assert(xive_nsr_indicates_exception(ring, nsr));
+        return true;
+    }
+    return false;
+}
+
+uint8_t xive_nsr_exception_ring(uint8_t ring, uint8_t nsr)
+{
+    /* NSR determines if pool/phys ring is for phys or pool interrupt */
+    if ((ring == TM_QW3_HV_PHYS) || (ring == TM_QW2_HV_POOL)) {
+        uint8_t he = (nsr & TM_QW3_NSR_HE) >> 6;
+
+        if (he == TM_QW3_NSR_HE_PHYS) {
+            return TM_QW3_HV_PHYS;
+        } else if (he == TM_QW3_NSR_HE_POOL) {
+            return TM_QW2_HV_POOL;
+        } else {
+            /* Don't support LSI mode */
+            g_assert_not_reached();
+        }
+    }
+    return ring;
+}
 
 static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
 {
@@ -48,18 +87,12 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 
     qemu_irq_lower(xive_tctx_output(tctx, ring));
 
-    if (regs[TM_NSR] != 0) {
+    if (xive_nsr_indicates_exception(ring, nsr)) {
         uint8_t cppr = regs[TM_PIPR];
         uint8_t alt_ring;
         uint8_t *alt_regs;
 
-        /* POOL interrupt uses IPB in QW2, POOL ring */
-        if ((ring == TM_QW3_HV_PHYS) &&
-            ((nsr & TM_QW3_NSR_HE) == (TM_QW3_NSR_HE_POOL << 6))) {
-            alt_ring = TM_QW2_HV_POOL;
-        } else {
-            alt_ring = ring;
-        }
+        alt_ring = xive_nsr_exception_ring(ring, nsr);
         alt_regs = &tctx->regs[alt_ring];
 
         regs[TM_CPPR] = cppr;
@@ -68,7 +101,7 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
          * If the interrupt was for a specific VP, reset the pending
          * buffer bit, otherwise clear the logical server indicator
          */
-        if (!(regs[TM_NSR] & TM_NSR_GRP_LVL)) {
+        if (!xive_nsr_indicates_group_exception(ring, nsr)) {
             alt_regs[TM_IPB] &= ~xive_priority_to_ipb(cppr);
         }
 
-- 
2.50.1


