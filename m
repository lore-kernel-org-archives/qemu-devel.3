Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79BFD41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 09:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTd7d-00061a-4o; Thu, 11 Dec 2025 04:38:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vTd7b-00060w-Ui
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vTd7Z-0004mL-WD
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765445881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eG6YP1QAfk0Sb9nnxXReguVVGPf9gWmM44DHaE+Vvk4=;
 b=K2RJXdGyn836b+gieWum4wYYbkNrKmazrBTttRkhED2/6NBCSe5Rk9h9XfyMz9VibA2QY0
 RVfHZVQ8R9RBL4B5gxjeEYVq+4vKDzjwn9DR1V5Sd6KOxvKnYlYvLKWOqInrW4TGpZbGjk
 jXHN22JDsNY3hKqGwwYKQVB8xRYetVg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-JCTYJwtDNYeHrZGuAwhtkA-1; Thu,
 11 Dec 2025 04:37:58 -0500
X-MC-Unique: JCTYJwtDNYeHrZGuAwhtkA-1
X-Mimecast-MFC-AGG-ID: JCTYJwtDNYeHrZGuAwhtkA_1765445877
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E716195FCDD; Thu, 11 Dec 2025 09:37:57 +0000 (UTC)
Received: from speedmetal.openshiftapps.com (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE9591956056; Thu, 11 Dec 2025 09:37:54 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 arkus Armbruster <armbru@redhat.com>
Subject: [PATCH] block: Wire up 'flat' mode also for 'query-block'
Date: Thu, 11 Dec 2025 10:37:53 +0100
Message-ID: <38fa3ec064ed20282fb61f70ffed8e0abb3abbfa.1765445716.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Krempa <pkrempa@redhat.com>

Some time ago (commit facda5443f5a8) I've added 'flat' mode (which
omits 'backing-image' key in reply) to 'query-named-block-nodes' to
minimize the size of the returned JSON for deeper backing chains.

While 'query-block' behaved slightly better it turns out that in libvirt
we do call 'query-block' to figure out some information about the
block device (e.g. throttling info) but we don't look at the backing
chain itself.

Wire up 'flat' for 'query-block' so that libvirt can ask for an
abbreviated output. The implementation is much simpler as the internals
are shared with 'query-named-block-nodes'.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 4 ++--
 block/qapi.c                   | 9 +++++----
 qapi/block-core.json           | 4 ++++
 ui/cocoa.m                     | 2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 3640d1f3dc..d301f56a39 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -422,7 +422,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     /* Then try adding all block devices.  If one fails, close all and
      * exit.
      */
-    block_list = qmp_query_block(NULL);
+    block_list = qmp_query_block(false, false, NULL);

     for (info = block_list; info; info = info->next) {
         if (!info->value->inserted) {
@@ -741,7 +741,7 @@ void hmp_info_block(Monitor *mon, const QDict *qdict)

     /* Print BlockBackend information */
     if (!nodes) {
-        block_list = qmp_query_block(NULL);
+        block_list = qmp_query_block(false, false, NULL);
     } else {
         block_list = NULL;
     }
diff --git a/block/qapi.c b/block/qapi.c
index 9f5771e019..2fc38d67a0 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -456,7 +456,7 @@ fail:

 /* @p_info will be set only on success. */
 static void GRAPH_RDLOCK
-bdrv_query_info(BlockBackend *blk, BlockInfo **p_info, Error **errp)
+bdrv_query_info(BlockBackend *blk, bool flat, BlockInfo **p_info, Error **errp)
 {
     BlockInfo *info = g_malloc0(sizeof(*info));
     BlockDriverState *bs = blk_bs(blk);
@@ -488,7 +488,7 @@ bdrv_query_info(BlockBackend *blk, BlockInfo **p_info, Error **errp)
     }

     if (bs && bs->drv) {
-        info->inserted = bdrv_block_device_info(blk, bs, false, errp);
+        info->inserted = bdrv_block_device_info(blk, bs, flat, errp);
         if (info->inserted == NULL) {
             goto err;
         }
@@ -698,11 +698,12 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
     return s;
 }

-BlockInfoList *qmp_query_block(Error **errp)
+BlockInfoList *qmp_query_block(bool has_flat, bool flat, Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
     BlockBackend *blk;
     Error *local_err = NULL;
+    bool return_flat = has_flat && flat;

     GRAPH_RDLOCK_GUARD_MAINLOOP();

@@ -714,7 +715,7 @@ BlockInfoList *qmp_query_block(Error **errp)
         }

         info = g_malloc0(sizeof(*info));
-        bdrv_query_info(blk, &info->value, &local_err);
+        bdrv_query_info(blk, return_flat, &info->value, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             g_free(info);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b82af74256..e89d878544 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -855,6 +855,9 @@
 #
 # Get a list of `BlockInfo` for all virtual block devices.
 #
+# @flat: Omit the nested data about backing image ("backing-image"
+#     key) if true.  Default is false (Since 11.0)
+#
 # Returns: a list describing each virtual block device.  Filter nodes
 #     that were created implicitly are skipped over.
 #
@@ -945,6 +948,7 @@
 #        }
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
+  'data': { '*flat': 'bool' },
   'allow-preconfig': true }

 ##
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 23b7a736d7..5b21fe3aea 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1849,7 +1849,7 @@ static void addRemovableDevicesMenuItems(void)
     BlockInfoList *currentDevice, *pointerToFree;
     NSString *deviceName;

-    currentDevice = qmp_query_block(NULL);
+    currentDevice = qmp_query_block(false, false, NULL);
     pointerToFree = currentDevice;

     menu = [[[NSApp mainMenu] itemWithTitle:@"Machine"] submenu];
-- 
2.52.0


