Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B5CA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnwT-0003Cv-Hc; Thu, 08 Oct 2026 09:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnw2-0002qq-Ch
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvy-0002Sb-Dp
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaZR0awm3Sd2PBkaZeT8OfUu61ZBTvBrXHEP0ij1Nyk=;
 b=YpM3/qeXlzZt4SZ2iIr/mvENM08cgCXcYRMDk+MrNVSQw1/ex+T8ToVeDoxO1kjrjeWMSA
 fbKrITVMTFPsz7AL2DRkXEfKvZtBEI1KqhLS15koeyenprr/+UszMepS01IQ6tmB5d8Wd6
 RqaXKgp+Rb+QcdfAye2WHAwDnsNeuq4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-_fgnTygXPy-yl2MCY99IZA-1; Thu,
 08 Oct 2026 09:13:09 -0400
X-MC-Unique: _fgnTygXPy-yl2MCY99IZA-1
X-Mimecast-MFC-AGG-ID: _fgnTygXPy-yl2MCY99IZA_1791465188
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DB1919772E6; Thu,  8 Oct 2026 13:13:08 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D80730000E8; Thu,  8 Oct 2026 13:13:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org (open list:Dirty Bitmaps)
Subject: [PULL 10/15] migration/block-dirty-bitmap: fix postcopy abort with
 bitmaps on several nodes
Date: Thu,  8 Oct 2026 08:11:49 -0500
Message-ID: <20261008131216.2437896-27-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 migration/block-dirty-bitmap.c | 58 +++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

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
2.56.0


