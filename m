Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5680CC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtIK-0003hq-JG; Mon, 21 Jul 2025 12:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHw-00039j-0s
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtHs-0001M6-HZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753114966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5VCJItz73tYeT0KX7Z2+/ORjgJwylt6FqVpui1hOIZY=;
 b=Tq3sszpOJSzOSq7ICf/wt+zLgRQzgaC5E2kZkR5kJHw5xBuLD8Qgv5gOmoCknsSTp9+K6Y
 XiXxbcc1gA0f59uABSjYXLhx4jyCdPQ8Z1eMRUAMsJx9w408kH1ZoDMkH1dDVYiiGNj/nW
 L1bhtBY5p1uKFPcu3XEhTK5DCYWUieI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-meKwutT7ORyP2dzbSEmQYA-1; Mon,
 21 Jul 2025 12:22:44 -0400
X-MC-Unique: meKwutT7ORyP2dzbSEmQYA-1
X-Mimecast-MFC-AGG-ID: meKwutT7ORyP2dzbSEmQYA_1753114963
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FFAC195FE1C; Mon, 21 Jul 2025 16:22:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A449019560AD; Mon, 21 Jul 2025 16:22:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/50] ppc/xive: Report access size in XIVE TM operation error
 logs
Date: Mon, 21 Jul 2025 18:21:45 +0200
Message-ID: <20250721162233.686837-3-clg@redhat.com>
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

Report access size in XIVE TM operation error logs.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-3-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 27b473e4d762..120376fb6b6d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -326,7 +326,7 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
      */
     if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA @%"
-                      HWADDR_PRIx"\n", offset);
+                      HWADDR_PRIx" size %d\n", offset, size);
         return;
     }
 
@@ -357,7 +357,7 @@ static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
      */
     if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access at TIMA @%"
-                      HWADDR_PRIx"\n", offset);
+                      HWADDR_PRIx" size %d\n", offset, size);
         return -1;
     }
 
@@ -688,7 +688,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
         xto = xive_tm_find_op(tctx->xptr, offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
-                          "@%"HWADDR_PRIx"\n", offset);
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
         } else {
             xto->write_handler(xptr, tctx, offset, value, size);
         }
@@ -727,7 +727,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
         xto = xive_tm_find_op(tctx->xptr, offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
-                          "@%"HWADDR_PRIx"\n", offset);
+                          "@%"HWADDR_PRIx" size %d\n", offset, size);
             return -1;
         }
         ret = xto->read_handler(xptr, tctx, offset, size);
-- 
2.50.1


