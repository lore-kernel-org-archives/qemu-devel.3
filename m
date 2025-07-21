Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEDBC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtJu-0008FV-7Q; Mon, 21 Jul 2025 12:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIw-0004yU-76
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtIs-0001Yf-JZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae03GpkOra3utBvabjI+lTPzw6ZwaHjahEszLORnpAU=;
 b=PZL876FLlNbixlGQBi8bQ2Q9AwNjouYBG0Gv6etoLjwDIRJ5SwIpn9a4PHwTiIDCcCgJA3
 yUUwEZUhGbSBuud/pUMib+9XzNRB3sB6oyTEhRw6kDlVt8qGS5BMhg1zj9vh44YDa3z3OF
 WOQgO+YH4u640Fnsp0mLMVbc0UUp00I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-WYm42aLINumeuWb6aU6jsA-1; Mon,
 21 Jul 2025 12:23:45 -0400
X-MC-Unique: WYm42aLINumeuWb6aU6jsA-1
X-Mimecast-MFC-AGG-ID: WYm42aLINumeuWb6aU6jsA_1753115024
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49652180029D; Mon, 21 Jul 2025 16:23:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15D92195608D; Mon, 21 Jul 2025 16:23:41 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/50] ppc/xive: Add more interrupt notification tracing
Date: Mon, 21 Jul 2025 18:22:06 +0200
Message-ID: <20250721162233.686837-24-clg@redhat.com>
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

From: Glenn Miles <milesg@linux.ibm.com>

Add more tracing around notification, redistribution, and escalation.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-24-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c       |  3 +++
 hw/intc/xive2.c      | 13 ++++++++-----
 hw/intc/trace-events |  6 ++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5483a815ef07..d65394651650 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1276,6 +1276,7 @@ static uint64_t xive_source_esb_read(void *opaque, hwaddr addr, unsigned size)
 
         /* Forward the source event notification for routing */
         if (ret) {
+            trace_xive_source_notify(srcno);
             xive_source_notify(xsrc, srcno);
         }
         break;
@@ -1371,6 +1372,8 @@ out:
     /* Forward the source event notification for routing */
     if (notify) {
         xive_source_notify(xsrc, srcno);
+    } else {
+        trace_xive_source_blocked(srcno);
     }
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 9ef372b6d1d9..f810e716dee3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -616,6 +616,7 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
     uint8_t prio_limit;
     uint32_t cfg;
 
+    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
     if (group > 0) {
         nvgc_idx = (nvp_idx & (0xffffffff << group)) |
@@ -1455,6 +1456,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     if (!redistribute && xive2_end_is_enqueue(&end)) {
+        trace_xive_end_enqueue(end_blk, end_idx, end_data);
         xive2_end_enqueue(&end, end_data);
         /* Enqueuing event data modifies the EQ toggle and index */
         xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
@@ -1631,11 +1633,11 @@ do_escalation:
          * Perform END Adaptive escalation processing
          * The END trigger becomes an Escalation trigger
          */
-        xive2_router_end_notify(xrtr,
-                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
-                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5),
-                               false);
+        uint8_t esc_blk = xive_get_field32(END2_W4_END_BLOCK, end.w4);
+        uint32_t esc_idx = xive_get_field32(END2_W4_ESC_END_INDEX, end.w4);
+        uint32_t esc_data = xive_get_field32(END2_W5_ESC_END_DATA, end.w5);
+        trace_xive_escalate_end(end_blk, end_idx, esc_blk, esc_idx, esc_data);
+        xive2_router_end_notify(xrtr, esc_blk, esc_idx, esc_data, false);
     } /* end END adaptive escalation */
 
     else {
@@ -1652,6 +1654,7 @@ do_escalation:
         lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
                         xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
 
+        trace_xive_escalate_esb(end_blk, end_idx, lisn);
         xive2_notify(xrtr, lisn, true /* pq_checked */);
     }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 9ed2616e58fe..018c609ca5eb 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -279,6 +279,8 @@ xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_
 xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
 xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
+xive_source_notify(uint32_t srcno) "Processing notification for queued IRQ 0x%x"
+xive_source_blocked(uint32_t srcno) "No action needed for IRQ 0x%x currently"
 xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
 xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
 xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
@@ -289,6 +291,10 @@ xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x
 # xive2.c
 xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint8_t rc) "NVP 0x%x/0x%x operation=%d priority=%d rc=%d"
 xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint32_t rc) "NVGC crowd=%d 0x%x/0x%x operation=%d priority=%d rc=%d"
+xive_redistribute(uint32_t index, uint8_t ring, uint8_t end_blk, uint32_t end_idx) "Redistribute from target=%d ring=0x%x NVP 0x%x/0x%x"
+xive_end_enqueue(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "Queue event for END 0x%x/0x%x data=0x%x"
+xive_escalate_end(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t esc_data) "Escalate from END 0x%x/0x%x to END 0x%x/0x%x data=0x%x"
+xive_escalate_esb(uint8_t end_blk, uint32_t end_idx, uint32_t lisn) "Escalate from END 0x%x/0x%x to LISN=0x%x"
 
 # pnv_xive.c
 pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=0x%"PRIx64
-- 
2.50.1


