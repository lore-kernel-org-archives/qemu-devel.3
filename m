Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE74C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO3-0006mz-2L; Mon, 10 Feb 2025 11:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNs-0006fz-0S
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNq-000185-4W
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bb+kNxOUvZU5W6NOwCR13+8JSiVu8xg9TQlqIb8lfms=;
 b=QqwMRDssU6BfAyyzOqsHetu+WdnIffFJeWR9CnOM+i6JNhmygRiuQHQEKt7yYEH6zrxLhr
 W4yUEzxDYnqIGGEqI9DGnAr3zfqFfZ+vSTQLVzqYZmUpWrNoM41ZxIIKikeVYfuS5NUKDy
 KZKOpho1yRvmx3Wa1JgBPmy2S7gmEzk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-o31S1-iyOdaUDyX8DOASdA-1; Mon,
 10 Feb 2025 11:11:31 -0500
X-MC-Unique: o31S1-iyOdaUDyX8DOASdA-1
X-Mimecast-MFC-AGG-ID: o31S1-iyOdaUDyX8DOASdA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B55201956088; Mon, 10 Feb 2025 16:11:29 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FD4A195608D; Mon, 10 Feb 2025 16:11:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 21/25] nbd/server: Support inactive nodes
Date: Mon, 10 Feb 2025 17:10:30 +0100
Message-ID: <20250210161034.76494-22-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Acked-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20250204211407.381505-14-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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


