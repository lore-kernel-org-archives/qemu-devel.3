Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E0EC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Tmc-0000uw-RN; Tue, 15 Sep 2026 10:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TmZ-0000on-7O; Tue, 15 Sep 2026 10:05:11 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TmV-0002f3-Sd; Tue, 15 Sep 2026 10:05:10 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 779F21520F9A;
 Tue, 15 Sep 2026 16:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1789481102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eqA6zRixsUWQNtOaQ6ZRpJ+k8+YdVsVTAlOJK0RFx68=;
 b=BOe5858j8Ygr0vuHvG9Eu3CDu7EEVeW7Vwc/CBeJ0+e2ezxhUQgX/KYZpShY38j/AmI19U
 CR6l6bhrNJAGSZqzYXj61QfueEi9hvE9/ETQYbXLj4b7S94ikhnksQ8IPJrL3+TLkAwoOJ
 dJwrZMCWnIN9/AHEMyCx6JFqO/cuGYLTaKqgsgUwRP8l2dfBsYl9wbND4szhpMoig7q72R
 E3XScO2l+oXmRKtwUsZBtRzQ7pSahdFfFqmeTTP6rpG6R8hid+59W8nKcOROEh6bIFnzMJ
 NkJOrG4yCKcdSgmzmvUrJiKwIqhdJtEESWQPDk1HJfNc3R4GrVRxOQzmqA4jiA==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 1/3] block: add bdrv_open_backing_chain_until
Date: Tue, 15 Sep 2026 16:04:41 +0200
Message-ID: <20260915140444.1223798-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915140444.1223798-1-jean-louis@dupond.be>
References: <20260915140444.1223798-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new function called bdrv_open_backing_chain_until.
This is used to open a block up until a specified backing chain.

Modified bdrv_open_inherit to accept a new arg
'open_backing_recursively' to force to not open the next backing.
Adjusting all references to keep the existing behaviour.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block.c                            | 72 +++++++++++++++++++++++++-----
 block/mirror.c                     |  2 +-
 include/block/block-global-state.h |  7 ++-
 3 files changed, 69 insertions(+), 12 deletions(-)

diff --git a/block.c b/block.c
index f0a6042e61..9763137d8c 100644
--- a/block.c
+++ b/block.c
@@ -83,6 +83,7 @@ static QLIST_HEAD(, BlockDriver) bdrv_drivers =
 static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            const char *reference,
                                            QDict *options, int flags,
+                                           bool open_backing_recursively,
                                            BlockDriverState *parent,
                                            const BdrvChildClass *child_class,
                                            BdrvChildRole child_role,
@@ -3617,6 +3618,7 @@ out:
  * TODO Can this be unified with bdrv_open_image()?
  */
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
+                           bool open_backing_recursively,
                            const char *bdref_key, Error **errp)
 {
     ERRP_GUARD();
@@ -3695,9 +3697,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         qdict_put_str(options, "driver", bs->backing_format);
     }
 
-    backing_hd = bdrv_open_inherit(backing_filename, reference, options, 0, bs,
-                                   &child_of_bds, bdrv_backing_role(bs), true,
-                                   errp);
+    backing_hd = bdrv_open_inherit(backing_filename, reference, options, 0,
+                                   open_backing_recursively, bs, &child_of_bds,
+                                   bdrv_backing_role(bs), true, errp);
     if (!backing_hd) {
         bs->open_flags |= BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -3733,6 +3735,54 @@ free_exit:
     return ret;
 }
 
+int
+bdrv_open_backing_chain_until(BlockDriverState *top_bs,
+                              const char *base_filename,
+                              Error **errp)
+{
+    BlockDriverState *curr = top_bs;
+    int ret;
+
+    GLOBAL_STATE_CODE();
+
+    if (!base_filename) {
+        return 0;
+    }
+
+    if (bdrv_find_backing_image(top_bs, base_filename)) {
+        return 0;
+    }
+
+    while (true) {
+        QDict *options = qdict_clone_shallow(curr->options);
+
+        ret = bdrv_open_backing_file(curr, options, false, "backing", errp);
+        qobject_unref(options);
+        if (ret < 0) {
+            return ret;
+        }
+
+        bdrv_graph_rdlock_main_loop();
+        if (!curr->backing) {
+            bdrv_graph_rdunlock_main_loop();
+            error_setg(errp,
+                       "Did not find '%s' in the backing chain of '%s'",
+                       base_filename, top_bs->filename);
+            return -ENOENT;
+        }
+        bdrv_graph_rdunlock_main_loop();
+
+        if (bdrv_find_backing_image(curr, base_filename)) {
+            return 0;
+        }
+
+        /* Switch to the next layer */
+        bdrv_graph_rdlock_main_loop();
+        curr = curr->backing->bs;
+        bdrv_graph_rdunlock_main_loop();
+    }
+}
+
 static BlockDriverState *
 bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
                    BlockDriverState *parent, const BdrvChildClass *child_class,
@@ -3767,7 +3817,7 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
         goto done;
     }
 
-    bs = bdrv_open_inherit(filename, reference, image_options, 0,
+    bs = bdrv_open_inherit(filename, reference, image_options, 0, true,
                            parent, child_class, child_role, parse_filename,
                            errp);
     if (!bs) {
@@ -3897,8 +3947,8 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 
     }
 
-    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, false,
-                           errp);
+    bs = bdrv_open_inherit(NULL, reference, qdict, 0, true, NULL, NULL, 0,
+                           false, errp);
     obj = NULL;
     qobject_unref(obj);
     visit_free(v);
@@ -3986,7 +4036,8 @@ out:
  */
 static BlockDriverState * no_coroutine_fn
 bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
-                  int flags, BlockDriverState *parent,
+                  int flags, bool open_backing_recursively,
+                  BlockDriverState *parent,
                   const BdrvChildClass *child_class, BdrvChildRole child_role,
                   bool parse_filename, Error **errp)
 {
@@ -4199,8 +4250,9 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     }
 
     /* If there is a backing file, use it */
-    if ((flags & BDRV_O_NO_BACKING) == 0) {
-        ret = bdrv_open_backing_file(bs, options, "backing", &local_err);
+    if ((flags & BDRV_O_NO_BACKING) == 0 && open_backing_recursively) {
+        ret = bdrv_open_backing_file(bs, options, open_backing_recursively,
+                                     "backing", &local_err);
         if (ret < 0) {
             goto close_and_fail;
         }
@@ -4283,7 +4335,7 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
 {
     GLOBAL_STATE_CODE();
 
-    return bdrv_open_inherit(filename, reference, options, flags, NULL,
+    return bdrv_open_inherit(filename, reference, options, flags, true, NULL,
                              NULL, 0, true, errp);
 }
 
diff --git a/block/mirror.c b/block/mirror.c
index 089856f4a8..a4dde5d36d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -785,7 +785,7 @@ static int mirror_exit_common(Job *job)
         bdrv_graph_rdlock_main_loop();
         assert(!bdrv_backing_chain_next(target_bs));
         ret = bdrv_open_backing_file(bdrv_skip_filters(target_bs), NULL,
-                                     "backing", &local_err);
+                                     true, "backing", &local_err);
         bdrv_graph_rdunlock_main_loop();
         if (ret < 0) {
             error_report_err(local_err);
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index ed89999f0f..e842bed45a 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -110,7 +110,12 @@ bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                     Error **errp);
 
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
-                           const char *bdref_key, Error **errp);
+                           bool open_backing_recursively, const char *bdref_key,
+                           Error **errp);
+
+int bdrv_open_backing_chain_until(BlockDriverState *top_bs,
+                                  const char *base_filename,
+                                  Error **errp);
 
 BlockDriverState * no_coroutine_fn
 bdrv_open(const char *filename, const char *reference, QDict *options,
-- 
2.55.0


