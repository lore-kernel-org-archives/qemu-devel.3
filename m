Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97241C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMx-0007vJ-Bw; Mon, 21 Jul 2025 12:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtK5-0000mX-U8
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtK3-0001sd-Nj
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MerIZeYs/yxx3RFuXDtsAm61y3WcL99CR/oPk6azoZ4=;
 b=AtNCRArk/T8dS0+nWpJnMsZPr6VkCjvXsCNACwctEejyt5QHx87sFEd3ll+d9ZXgUXFALE
 hyJPwr6qlutujlUa+T+SeIgy5fgJa2UJaOK2WV1L/ysEnBGW2hKbo+xIF21rDMJm7Q6eG1
 VyDt+qGSFhD2l1DWZtkdxLsyXpFHzRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-jvx65dfHMFqZpJgYhg-YYA-1; Mon,
 21 Jul 2025 12:24:59 -0400
X-MC-Unique: jvx65dfHMFqZpJgYhg-YYA-1
X-Mimecast-MFC-AGG-ID: jvx65dfHMFqZpJgYhg-YYA_1753115098
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B0A81800298; Mon, 21 Jul 2025 16:24:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47215195608D; Mon, 21 Jul 2025 16:24:56 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 50/50] ppc/xive2: Enable lower level contexts on VP push
Date: Mon, 21 Jul 2025 18:22:33 +0200
Message-ID: <20250721162233.686837-51-clg@redhat.com>
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

When pushing a context, the lower-level context becomes valid if it
had V=1, and so on. Iterate lower level contexts and send them
pending interrupts if they become enabled.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-51-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index c3c6871e91b3..ee5fa2617849 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -995,6 +995,12 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     bool v;
     bool do_restore;
 
+    if (xive_ring_valid(tctx, ring)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Attempt to push VP to enabled"
+                                       " ring 0x%02x\n", ring);
+        return;
+    }
+
     /* First update the thead context */
     switch (size) {
     case 1:
@@ -1021,19 +1027,32 @@ static void xive2_tm_push_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     /* Check the interrupt pending bits */
     if (v) {
         Xive2Router *xrtr = XIVE2_ROUTER(xptr);
-        uint8_t *sig_regs = xive_tctx_signal_regs(tctx, ring);
-        uint8_t nsr = sig_regs[TM_NSR];
+        uint8_t cur_ring;
 
         xive2_tctx_restore_nvp(xrtr, tctx, ring,
                                nvp_blk, nvp_idx, do_restore);
 
-        if (xive_nsr_indicates_group_exception(ring, nsr)) {
-            /* redistribute precluded active grp interrupt */
-            g_assert(ring == TM_QW2_HV_POOL); /* PHYS ring has the interrupt */
-            xive2_redistribute(xrtr, tctx, xive_nsr_exception_ring(ring, nsr));
+        for (cur_ring = TM_QW1_OS; cur_ring <= ring;
+             cur_ring += XIVE_TM_RING_SIZE) {
+            uint8_t *sig_regs = xive_tctx_signal_regs(tctx, cur_ring);
+            uint8_t nsr = sig_regs[TM_NSR];
+
+            if (!xive_ring_valid(tctx, cur_ring)) {
+                continue;
+            }
+
+            if (cur_ring == TM_QW2_HV_POOL) {
+                if (xive_nsr_indicates_exception(cur_ring, nsr)) {
+                    g_assert(xive_nsr_exception_ring(cur_ring, nsr) ==
+                                                               TM_QW3_HV_PHYS);
+                    xive2_redistribute(xrtr, tctx,
+                                       xive_nsr_exception_ring(ring, nsr));
+                }
+                xive2_tctx_process_pending(tctx, TM_QW3_HV_PHYS);
+                break;
+            }
+            xive2_tctx_process_pending(tctx, cur_ring);
         }
-        xive2_tctx_process_pending(tctx, ring == TM_QW2_HV_POOL ?
-                                                 TM_QW3_HV_PHYS : ring);
     }
 }
 
@@ -1159,6 +1178,7 @@ static void xive2_tctx_process_pending(XiveTCTX *tctx, uint8_t sig_ring)
     int rc;
 
     g_assert(sig_ring == TM_QW3_HV_PHYS || sig_ring == TM_QW1_OS);
+    g_assert(sig_regs[TM_WORD2] & 0x80);
     g_assert(!xive_nsr_indicates_group_exception(sig_ring, sig_regs[TM_NSR]));
 
     /*
-- 
2.50.1


