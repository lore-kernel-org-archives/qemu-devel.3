Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86816606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=snuJnjPa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLDL-0001XP-6V; Mon, 26 Oct 2026 09:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCk-0008SE-8P; Mon, 26 Oct 2026 09:57:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCi-0000PA-99; Mon, 26 Oct 2026 09:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022944; bh=S8MchKme6ACfiZPjpjtgfSmhc4QYmn4cc/eofjzqWhI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=snuJnjPa+YpTzZriCMlsRjG0k8THGDnVGmwX0c31JhTs3MU1Zh8JHvbDBtbhwR3+t
 8IrR6EplQmVw1wAE84qceXTo8aaA6+rSqZyrDtE7M4w+qw427U8lg/PFjoap3VykXu
 A3M8s4IXUdJBdrL/LTmbLNlY/dPZc2tqx5nYTMae6rMN1iOfB8OuWHsBKBCofcu899
 0n3/g18YhIFPRIy6RkdEF7uZEX1EOh5AuM65COdbAxfl/P4WaVFKeHHNtEUJevsGd6
 am8rYiPYkehX9dt4hghWBkQ0F9loMkVmbLe0OZ2vceIQFPBIFyTVEHeeQ9m5SLqBSU
 6+rgl+7phBukQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 079F51E129E;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0582944B8EF;
 Mon, 26 Oct 2026 16:55:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id E8799934C3; Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 81/98] migration/block-dirty-bitmap: fix postcopy
 abort with bitmaps on several nodes
Date: Mon, 26 Oct 2026 16:55:08 +0300
Message-ID: <20261026135529.1019772-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

With dirty bitmaps on more than one node, the source switches nodes
during the postcopy bulk phase and sends the node name again. The
destination reads those chunks in the postcopy listen thread, which does
not hold the BQL, and resolves the name through bdrv_lookup_bs():

  qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
  `qemu_in_main_thread()' failed.

The bdrv_find_dirty_bitmap() call right after it needs the BQL or the
dirty bitmap lock as well. Taking the BQL there would deadlock: the
listen thread holds s->lock, and dirty_bitmap_mig_before_vm_start()
takes s->lock with the BQL held.

Every node and bitmap that a non-START chunk refers to was set up by a
START chunk, and those are loaded under the BQL during setup. Record the
node alias there, and resolve all other chunks against s->bitmaps
instead of the block graph.

Bitmaps on a single node never resend the node name after setup, which
is why migrate-bitmaps-postcopy-test does not catch this.

Fixes: f791bf7f93f2 ("assertions for block global state API")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-stable@nongnu.org
Message-ID: <20261006170738.453977-3-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 4d11088a088d0915196e38b3e69df12d4f06fdb5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1386f436355..35623379eb6 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -140,6 +140,7 @@ typedef struct LoadBitmapState {
     BdrvDirtyBitmap *bitmap;
     bool migrated;
     bool enabled;
+    char node_alias[QEMU_COUNTED_STRING_SIZE];
 } LoadBitmapState;
 
 /* State of the dirty bitmap migration (DBM) during load process */
@@ -859,6 +860,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
     }
 
     b = g_new(LoadBitmapState, 1);
+    g_strlcpy(b->node_alias, s->node_alias, sizeof(b->node_alias));
     b->bs = s->bs;
     b->bitmap = s->bitmap;
     b->migrated = false;
@@ -1056,6 +1058,53 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
     return 0;
 }
 
+/*
+ * Only START chunks are guaranteed to be loaded under the BQL; the rest may
+ * come from the postcopy listen thread and must not touch the block graph.
+ */
+static BlockDriverState *dirty_bitmap_load_find_bs(DBMLoadState *s,
+                                                   const char *device,
+                                                   const char *node_name,
+                                                   Error **errp)
+{
+    GSList *item;
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        return bdrv_lookup_bs(device, node_name, errp);
+    }
+
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
+        LoadBitmapState *b = item->data;
+
+        if (!strcmp(b->node_alias, s->node_alias)) {
+            return b->bs;
+        }
+    }
+
+    error_setg(errp, "no migrated bitmaps on node alias '%s'", s->node_alias);
+    return NULL;
+}
+
+static BdrvDirtyBitmap *dirty_bitmap_load_find_bitmap(DBMLoadState *s)
+{
+    GSList *item;
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        return bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+    }
+
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
+        LoadBitmapState *b = item->data;
+
+        if (b->bs == s->bs &&
+            !strcmp(bdrv_dirty_bitmap_name(b->bitmap), s->bitmap_name)) {
+            return b->bitmap;
+        }
+    }
+
+    return NULL;
+}
+
 static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
                                     GHashTable *alias_map)
 {
@@ -1084,11 +1133,12 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
                     s->bs = NULL;
                 } else {
                     bitmap_alias_map = amin->subtree;
-                    s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
+                    s->bs = dirty_bitmap_load_find_bs(s, NULL, amin->string,
+                                                      &local_err);
                 }
             } else {
-                s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias,
-                                       &local_err);
+                s->bs = dirty_bitmap_load_find_bs(s, s->node_alias,
+                                                  s->node_alias, &local_err);
             }
             if (!s->bs) {
                 error_report_err(local_err);
@@ -1139,7 +1189,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
 
         if (!s->cancelled) {
             g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
-            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+            s->bitmap = dirty_bitmap_load_find_bitmap(s);
 
             /*
              * bitmap may be NULL here, it wouldn't be an error if it is the
-- 
2.47.3


