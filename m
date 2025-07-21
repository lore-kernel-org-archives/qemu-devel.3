Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103F7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKY-0002Pv-1z; Mon, 21 Jul 2025 12:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJD-0006Jc-FZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJB-0001f9-DY
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRPLzTi4AJ7cGYGwB/7WBfR4QyoS/tNGoVdjmVxWpzk=;
 b=RqohfKuGFqPs6t8RqsYRxbleIAwSbyh08hpnYCV31NWAj1gskQN5k+0uJJSwbdOyErix8m
 utHkS9mDoKL1/PcuYY9+9UDNr0kEB0l6OSw+tFvVZRm7ZhJ5jdTcFxn6M9pxAZqCjfPMiS
 kWciMXpemvG4Dm4vm8U3iTc9rooR+a0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-QnCfZ6pyOY2Lm32Tr4vuyw-1; Mon,
 21 Jul 2025 12:24:04 -0400
X-MC-Unique: QnCfZ6pyOY2Lm32Tr4vuyw-1
X-Mimecast-MFC-AGG-ID: QnCfZ6pyOY2Lm32Tr4vuyw_1753115043
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA3261800C3D; Mon, 21 Jul 2025 16:24:03 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4851F195608D; Mon, 21 Jul 2025 16:24:01 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/50] ppc/xive: Add xive_tctx_pipr_present() to present new
 interrupt
Date: Mon, 21 Jul 2025 18:22:13 +0200
Message-ID: <20250721162233.686837-31-clg@redhat.com>
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

xive_tctx_pipr_update() is used for multiple things. In an effort
to make things simpler and less overloaded, split out the function
that is used to present a new interrupt to the tctx.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-31-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive.h | 2 ++
 hw/intc/xive.c        | 8 +++++++-
 hw/intc/xive2.c       | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 8152a9df3d39..0d6b11e818c1 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -562,6 +562,8 @@ void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                            uint8_t group_level);
+void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                            uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
 uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index c92e819053e8..038c35846d94 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -225,6 +225,12 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
     xive_tctx_notify(tctx, ring, group_level);
  }
 
+void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
+                            uint8_t group_level)
+{
+    xive_tctx_pipr_update(tctx, ring, priority, group_level);
+}
+
 /*
  * XIVE Thread Interrupt Management Area (TIMA)
  */
@@ -2040,7 +2046,7 @@ void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
                              xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.w7),
                              &match)) {
         trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
-        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
+        xive_tctx_pipr_present(match.tctx, match.ring, priority, 0);
         return;
     }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index f51fd38a13eb..fe40f7f07bdd 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1652,7 +1652,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
 
         group_level = xive_get_group_level(crowd, cam_ignore, nvx_blk, nvx_idx);
         trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_level);
-        xive_tctx_pipr_update(tctx, ring, priority, group_level);
+        xive_tctx_pipr_present(tctx, ring, priority, group_level);
         return;
     }
 
-- 
2.50.1


