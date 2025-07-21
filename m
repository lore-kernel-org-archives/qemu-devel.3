Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994C0C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKd-0002mk-IC; Mon, 21 Jul 2025 12:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJA-0006Bp-SW
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJ8-0001eS-Rk
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yDXV9JEqd2YGulb9ZztH7aN7aI/DnHYJgwb9sf9N20o=;
 b=CuYwLsScJCNQhE5VmoFzE/WDEJbO4Ngf6DrHSlSUEpyPw7Nt6yaUoVHSAvOOjbhBjTIqSh
 q1cyPj1R4mMqwt1mE2Z+SKjA+MiUJNA+szho6gsCNdRGEdDkPwJ+3ScK6LbrNY1zxrzvBs
 8su1WCRwXlrhD1nlQX542Hzuq2O9jhc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-zhr1gl49MV-68yB-N4hrTw-1; Mon,
 21 Jul 2025 12:24:02 -0400
X-MC-Unique: zhr1gl49MV-68yB-N4hrTw-1
X-Mimecast-MFC-AGG-ID: zhr1gl49MV-68yB-N4hrTw_1753115040
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA9C51800D86; Mon, 21 Jul 2025 16:24:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96F051955F4A; Mon, 21 Jul 2025 16:23:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 29/50] ppc/xive2: Redistribute group interrupt preempted by
 higher priority interrupt
Date: Mon, 21 Jul 2025 18:22:12 +0200
Message-ID: <20250721162233.686837-30-clg@redhat.com>
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

A group interrupt that gets preempted by a higher priority interrupt
delivery must be redistributed otherwise it would get lost.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-30-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive2.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 602b23d06d80..f51fd38a13eb 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1638,11 +1638,21 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
                              crowd, cam_ignore, priority,
                              xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
                              &match)) {
+        XiveTCTX *tctx = match.tctx;
+        uint8_t ring = match.ring;
+        uint8_t alt_ring = (ring == TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS : ring;
+        uint8_t *aregs = &tctx->regs[alt_ring];
+        uint8_t nsr = aregs[TM_NSR];
         uint8_t group_level;
 
+        if (priority < aregs[TM_PIPR] &&
+            xive_nsr_indicates_group_exception(alt_ring, nsr)) {
+            xive2_redistribute(xrtr, tctx, alt_ring);
+        }
+
         group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
-        trace_xive_presenter_notify(nvx_blk, nvx_idx, match.ring, group_level);
-        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_level);
+        trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
+        xive_tctx_pipr_update(tctx, ring, priority, group_level);
         return;
     }
 
-- 
2.50.1


