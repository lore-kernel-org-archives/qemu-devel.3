Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E084CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9uw-00067w-QI; Fri, 29 Mar 2024 06:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rq9uu-00067g-Mh
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rq9us-0003be-Uh
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711709818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZYIAOBsQkX7kNMyCajWSK7qclNBeZ6tqd40Neilx0oU=;
 b=ep1NtgeXiI5TXo+wNeijEn8ovUlEU1BvRVCg6QVc5yARpZ3wlLjNu38sjKdYd8cRd027T0
 +ekYmoRSSw7TD96scuQuv9tThjUhJAk902eoJ7gIx9bZzBFJFixlN8kHK+tjGP68cwNqUD
 /bku0GcW8MfpKBbwTZacomNMd8Wqc+c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-2nYWGSnGNTaVy8UIT-N91A-1; Fri, 29 Mar 2024 06:56:55 -0400
X-MC-Unique: 2nYWGSnGNTaVy8UIT-N91A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BBB6800266;
 Fri, 29 Mar 2024 10:56:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CADC111E3F3;
 Fri, 29 Mar 2024 10:56:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH for-9.1] migration: Add Error** argument to
 add_bitmaps_to_list()
Date: Fri, 29 Mar 2024 11:56:27 +0100
Message-ID: <20240329105627.311227-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This allows to report more precise errors in the migration handler
dirty_bitmap_save_setup().

Suggested-by Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> 
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 To apply on top of : 
 https://lore.kernel.org/qemu-devel/20240320064911.545001-1-clg@redhat.com/
 
 migration/block-dirty-bitmap.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 542a8c297b329abc30d1b3a205d29340fa59a961..a7d55048c23505fde565ca784cec3c917dca37e5 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -481,13 +481,13 @@ static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
 
 /* Called with the BQL taken. */
 static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
-                               const char *bs_name, GHashTable *alias_map)
+                               const char *bs_name, GHashTable *alias_map,
+                               Error **errp)
 {
     BdrvDirtyBitmap *bitmap;
     SaveBitmapState *dbms;
     GHashTable *bitmap_aliases;
     const char *node_alias, *bitmap_name, *bitmap_alias;
-    Error *local_err = NULL;
 
     /* When an alias map is given, @bs_name must be @bs's node name */
     assert(!alias_map || !strcmp(bs_name, bdrv_get_node_name(bs)));
@@ -504,8 +504,8 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
     bitmap_name = bdrv_dirty_bitmap_name(bitmap);
 
     if (!bs_name || strcmp(bs_name, "") == 0) {
-        error_report("Bitmap '%s' in unnamed node can't be migrated",
-                     bitmap_name);
+        error_setg(errp, "Bitmap '%s' in unnamed node can't be migrated",
+                   bitmap_name);
         return -1;
     }
 
@@ -525,9 +525,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
     }
 
     if (node_alias[0] == '#') {
-        error_report("Bitmap '%s' in a node with auto-generated "
-                     "name '%s' can't be migrated",
-                     bitmap_name, node_alias);
+        error_setg(errp, "Bitmap '%s' in a node with auto-generated "
+                   "name '%s' can't be migrated",
+                   bitmap_name, node_alias);
         return -1;
     }
 
@@ -538,8 +538,7 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
             continue;
         }
 
-        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
-            error_report_err(local_err);
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, errp)) {
             return -1;
         }
 
@@ -558,9 +557,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
             }
         } else {
             if (strlen(bitmap_name) > UINT8_MAX) {
-                error_report("Cannot migrate bitmap '%s' on node '%s': "
-                             "Name is longer than %u bytes",
-                             bitmap_name, bs_name, UINT8_MAX);
+                error_setg(errp, "Cannot migrate bitmap '%s' on node '%s': "
+                           "Name is longer than %u bytes",
+                           bitmap_name, bs_name, UINT8_MAX);
                 return -1;
             }
             bitmap_alias = bitmap_name;
@@ -599,7 +598,7 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
 }
 
 /* Called with the BQL taken. */
-static int init_dirty_bitmap_migration(DBMSaveState *s)
+static int init_dirty_bitmap_migration(DBMSaveState *s, Error **errp)
 {
     BlockDriverState *bs;
     SaveBitmapState *dbms;
@@ -643,7 +642,7 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
             }
 
             if (bs && bs->drv && !bs->drv->is_filter) {
-                if (add_bitmaps_to_list(s, bs, name, NULL)) {
+                if (add_bitmaps_to_list(s, bs, name, NULL, errp)) {
                     goto fail;
                 }
                 g_hash_table_add(handled_by_blk, bs);
@@ -656,7 +655,8 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
             continue;
         }
 
-        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs), alias_map)) {
+        if (add_bitmaps_to_list(s, bs, bdrv_get_node_name(bs), alias_map,
+                                errp)) {
             goto fail;
         }
     }
@@ -1218,9 +1218,7 @@ static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
 
-    if (init_dirty_bitmap_migration(s) < 0) {
-        error_setg(errp,
-                   "Failed to initialize dirty tracking bitmap for blocks");
+    if (init_dirty_bitmap_migration(s, errp) < 0) {
         return -1;
     }
 
-- 
2.44.0


