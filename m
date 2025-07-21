Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0ABC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtMp-0007VD-NC; Mon, 21 Jul 2025 12:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJv-0008Sj-8E
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJs-0001oD-Tx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UrJGQXX5MFfKsbXmSUtHx7gCvIlhY9yVcEfDM+YXcRQ=;
 b=E48iuL1R5384jMVXk+z8zb9UbaRouxQmGVgZROaTBFK5K/8zqjskc7hi7N6k3FDLw6HrIQ
 vwZBCHBEx+2Gv5aFRQY9nihq0iBkYr3od0TVjiN1YKWYq19cMj/Vy4QmDHCl6FA+UquXnk
 KrqIPfn8hg/6eKmMTwiIeDu1BqI5Was=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Rxf2t915MFaR6vDyy0Z8ig-1; Mon,
 21 Jul 2025 12:24:48 -0400
X-MC-Unique: Rxf2t915MFaR6vDyy0Z8ig-1
X-Mimecast-MFC-AGG-ID: Rxf2t915MFaR6vDyy0Z8ig_1753115087
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91BDA1800C32; Mon, 21 Jul 2025 16:24:47 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CA12195608D; Mon, 21 Jul 2025 16:24:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 46/50] ppc/xive2: Implement set_os_pending TIMA op
Date: Mon, 21 Jul 2025 18:22:29 +0200
Message-ID: <20250721162233.686837-47-clg@redhat.com>
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

xive2 must take into account redistribution of group interrupts if
the VP directed priority exceeds the group interrupt priority after
this operation. The xive1 code is not group aware so implement this
for xive2.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-47-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2.h |  2 ++
 hw/intc/xive.c         |  2 ++
 hw/intc/xive2.c        | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index c1ab06a55adf..45266c2a8b9e 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -130,6 +130,8 @@ void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
                            uint64_t value, unsigned size);
 uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e7f77be2f711..25cb3877cb15 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -747,6 +747,8 @@ static const XiveTmOp xive2_tm_operations[] = {
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, true, false,
       NULL, xive_tm_ack_os_reg },
+    { XIVE_TM_OS_PAGE, TM_SPC_SET_OS_PENDING,     1, true, false,
+      xive2_tm_set_os_pending, NULL },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX_G2,     4, true, false,
       NULL, xive2_tm_pull_os_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_OS_CTX,        4, true, false,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 23eb85bb8669..f9eaea119289 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1323,6 +1323,34 @@ void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
     xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
 }
 
+/*
+ * Adjust the IPB to allow a CPU to process event queues of other
+ * priorities during one physical interrupt cycle.
+ */
+void xive2_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
+                             hwaddr offset, uint64_t value, unsigned size)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint8_t ring = TM_QW1_OS;
+    uint8_t *regs = &tctx->regs[ring];
+    uint8_t priority = value & 0xff;
+
+    /*
+     * XXX: should this simply set a bit in IPB and wait for it to be picked
+     * up next cycle, or is it supposed to present it now? We implement the
+     * latter here.
+     */
+    regs[TM_IPB] |= xive_priority_to_ipb(priority);
+    if (xive_ipb_to_pipr(regs[TM_IPB]) >= regs[TM_PIPR]) {
+        return;
+    }
+    if (xive_nsr_indicates_group_exception(ring, regs[TM_NSR])) {
+        xive2_redistribute(xrtr, tctx, ring);
+    }
+
+    xive_tctx_pipr_present(tctx, ring, priority, 0);
+}
+
 static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
 {
     uint8_t *regs = &tctx->regs[ring];
-- 
2.50.1


