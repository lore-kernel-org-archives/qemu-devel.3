Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55CBC0218D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 09:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdngQ-0004Et-5u; Fri, 31 Jan 2025 04:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdngO-00048c-If
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdngN-0002oC-9K
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 04:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738317086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gy0Ro0AiLBW+IDrNU0PGthGke20CO9S9gyVmcl9+x2Q=;
 b=Va9HZl7MY2nBvGZDlTeOYsk6qlQIZQoL4bi/ruqNzFp3gpzFVaH3hJCLELMRUgUp5SEuU2
 BR73JEJ0OJRhm6BHR6WF3xxqEpf8x2suGIlhYcbW8dc5gczIAdtR8rosZq5LPytoWPNE1U
 yMqSBx2e0HnKR2CPfNhuPkr9gAoJjLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-Y7UIwp2ePN6knLhQ6mzAZQ-1; Fri,
 31 Jan 2025 04:51:23 -0500
X-MC-Unique: Y7UIwp2ePN6knLhQ6mzAZQ-1
X-Mimecast-MFC-AGG-ID: Y7UIwp2ePN6knLhQ6mzAZQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 356BC1801F0E; Fri, 31 Jan 2025 09:51:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0F221800975; Fri, 31 Jan 2025 09:51:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] nbd/server: Support inactive nodes
Date: Fri, 31 Jan 2025 10:50:48 +0100
Message-ID: <20250131095051.49708-3-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order to support running an NBD export on inactive nodes, we must
make sure to return errors for any operations that aren't allowed on
inactive nodes. Reads are the only operation we know we need for
inactive images, so to err on the side of caution, return errors for
everything else, even if some operations could possibly be okay.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index f64e47270c..2076fb2666 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2026,6 +2026,7 @@ static void nbd_export_delete(BlockExport *blk_exp)
 const BlockExportDriver blk_exp_nbd = {
     .type               = BLOCK_EXPORT_TYPE_NBD,
     .instance_size      = sizeof(NBDExport),
+    .supports_inactive  = true,
     .create             = nbd_export_create,
     .delete             = nbd_export_delete,
     .request_shutdown   = nbd_export_request_shutdown,
@@ -2920,6 +2921,22 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
     NBDExport *exp = client->exp;
     char *msg;
     size_t i;
+    bool inactive;
+
+    WITH_GRAPH_RDLOCK_GUARD() {
+        inactive = bdrv_is_inactive(blk_bs(exp->common.blk));
+        if (inactive) {
+            switch (request->type) {
+            case NBD_CMD_READ:
+                /* These commands are allowed on inactive nodes */
+                break;
+            default:
+                /* Return an error for the rest */
+                return nbd_send_generic_reply(client, request, -EPERM,
+                                              "export is inactive", errp);
+            }
+        }
+    }
 
     switch (request->type) {
     case NBD_CMD_CACHE:
-- 
2.48.1


