Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A742C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWO9-0006qY-RK; Mon, 10 Feb 2025 11:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNg-0006dj-Li
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNe-000161-G0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y2rstgk/q1Pv133kAA8q30hwY0mEHW1TCyz18CyLczk=;
 b=UYrwsuUvaYRXsbBOtoHR6QI57Yed0cNf5sIfioh1e3dWrvr4wPe0eWKuwff5e9I36rDZeU
 ZjtoJZuKxljLtIt+7JiV6Nej+21huhptkVGDhgflUWKawCikDm7xNcBcE9710hS26x+7zx
 xXStS3qhZtJ26nZxwGvJiSKzEFFSL5g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-UP6GGtVEMti-cfVAOZcKUw-1; Mon,
 10 Feb 2025 11:11:28 -0500
X-MC-Unique: UP6GGtVEMti-cfVAOZcKUw-1
X-Mimecast-MFC-AGG-ID: UP6GGtVEMti-cfVAOZcKUw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD2E81955DDD; Mon, 10 Feb 2025 16:11:27 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 883411956054; Mon, 10 Feb 2025 16:11:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 20/25] block/export: Add option to allow export of inactive
 nodes
Date: Mon, 10 Feb 2025 17:10:29 +0100
Message-ID: <20250210161034.76494-21-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add an option in BlockExportOptions to allow creating an export on an
inactive node without activating the node. This mode needs to be
explicitly supported by the export type (so that it doesn't perform any
operations that are forbidden for inactive nodes), so this patch alone
doesn't allow this option to be successfully used yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250204211407.381505-13-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-export.json | 10 +++++++++-
 include/block/export.h |  3 +++
 block/export/export.c  | 31 +++++++++++++++++++++----------
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/qapi/block-export.json b/qapi/block-export.json
index ce33fe378d..117b05d13c 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -372,6 +372,13 @@
 #     cannot be moved to the iothread.  The default is false.
 #     (since: 5.2)
 #
+# @allow-inactive: If true, the export allows the exported node to be inactive.
+#     If it is created for an inactive block node, the node remains inactive. If
+#     the export type doesn't support running on an inactive node, an error is
+#     returned. If false, inactive block nodes are automatically activated before
+#     creating the export and trying to inactivate them later fails.
+#     (since: 10.0; default: false)
+#
 # Since: 4.2
 ##
 { 'union': 'BlockExportOptions',
@@ -381,7 +388,8 @@
             '*iothread': 'str',
             'node-name': 'str',
             '*writable': 'bool',
-            '*writethrough': 'bool' },
+            '*writethrough': 'bool',
+            '*allow-inactive': 'bool' },
   'discriminator': 'type',
   'data': {
       'nbd': 'BlockExportOptionsNbd',
diff --git a/include/block/export.h b/include/block/export.h
index f2fe0f8078..4bd9531d4d 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -29,6 +29,9 @@ typedef struct BlockExportDriver {
      */
     size_t instance_size;
 
+    /* True if the export type supports running on an inactive node */
+    bool supports_inactive;
+
     /* Creates and starts a new block export */
     int (*create)(BlockExport *, BlockExportOptions *, Error **);
 
diff --git a/block/export/export.c b/block/export/export.c
index bac42b8608..f3bbf11070 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -75,6 +75,7 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
 BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     bool fixed_iothread = export->has_fixed_iothread && export->fixed_iothread;
+    bool allow_inactive = export->has_allow_inactive && export->allow_inactive;
     const BlockExportDriver *drv;
     BlockExport *exp = NULL;
     BlockDriverState *bs;
@@ -138,17 +139,24 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         }
     }
 
-    /*
-     * Block exports are used for non-shared storage migration. Make sure
-     * that BDRV_O_INACTIVE is cleared and the image is ready for write
-     * access since the export could be available before migration handover.
-     * ctx was acquired in the caller.
-     */
     bdrv_graph_rdlock_main_loop();
-    ret = bdrv_activate(bs, errp);
-    if (ret < 0) {
-        bdrv_graph_rdunlock_main_loop();
-        goto fail;
+    if (allow_inactive) {
+        if (!drv->supports_inactive) {
+            error_setg(errp, "Export type does not support inactive exports");
+            bdrv_graph_rdunlock_main_loop();
+            goto fail;
+        }
+    } else {
+        /*
+         * Block exports are used for non-shared storage migration. Make sure
+         * that BDRV_O_INACTIVE is cleared and the image is ready for write
+         * access since the export could be available before migration handover.
+         */
+        ret = bdrv_activate(bs, errp);
+        if (ret < 0) {
+            bdrv_graph_rdunlock_main_loop();
+            goto fail;
+        }
     }
     bdrv_graph_rdunlock_main_loop();
 
@@ -162,6 +170,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     if (!fixed_iothread) {
         blk_set_allow_aio_context_change(blk, true);
     }
+    if (allow_inactive) {
+        blk_set_force_allow_inactivate(blk);
+    }
 
     ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-- 
2.48.1


