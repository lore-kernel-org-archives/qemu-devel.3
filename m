Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A767EC3271E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOmw-0002Vw-Ve; Thu, 04 Jul 2024 11:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOmv-0002KL-5P; Thu, 04 Jul 2024 11:54:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPOmt-0002Ar-0k; Thu, 04 Jul 2024 11:54:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 862AE774A0;
 Thu,  4 Jul 2024 18:52:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4ACB7FEAEB;
 Thu,  4 Jul 2024 18:52:52 +0300 (MSK)
Received: (nullmailer pid 1481724 invoked by uid 1000);
 Thu, 04 Jul 2024 15:52:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.6 18/18] block: Parse filenames only when explicitly
 requested
Date: Thu,  4 Jul 2024 18:52:49 +0300
Message-Id: <20240704155251.1481617-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
References: <qemu-stable-8.2.6-20240704154854@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Kevin Wolf <kwolf@redhat.com>

When handling image filenames from legacy options such as -drive or from
tools, these filenames are parsed for protocol prefixes, including for
the json:{} pseudo-protocol.

This behaviour is intended for filenames that come directly from the
command line and for backing files, which may come from the image file
itself. Higher level management tools generally take care to verify that
untrusted images don't contain a bad (or any) backing file reference;
'qemu-img info' is a suitable tool for this.

However, for other files that can be referenced in images, such as
qcow2 data files or VMDK extents, the string from the image file is
usually not verified by management tools - and 'qemu-img info' wouldn't
be suitable because in contrast to backing files, it already opens these
other referenced files. So here the string should be interpreted as a
literal local filename. More complex configurations need to be specified
explicitly on the command line or in QMP.

This patch changes bdrv_open_inherit() so that it only parses filenames
if a new parameter parse_filename is true. It is set for the top level
in bdrv_open(), for the file child and for the backing file child. All
other callers pass false and disable filename parsing this way.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
(cherry picked from commit 7ead946998610657d38d1a505d5f25300d4ca613)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: backport patch to 8.2, without:
  v8.2.0-132-g6bc30f194985 "graph-lock: remove AioContext locking"
  v8.2.0-133-gb49f4755c7fa "block: remove AioContext locking")

diff --git a/block.c b/block.c
index bfb0861ec6..f89bc98e0e 100644
--- a/block.c
+++ b/block.c
@@ -86,6 +86,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            BlockDriverState *parent,
                                            const BdrvChildClass *child_class,
                                            BdrvChildRole child_role,
+                                           bool parse_filename,
                                            Error **errp);
 
 static bool bdrv_recurse_has_child(BlockDriverState *bs,
@@ -2047,7 +2048,8 @@ static void parse_json_protocol(QDict *options, const char **pfilename,
  * block driver has been specified explicitly.
  */
 static int bdrv_fill_options(QDict **options, const char *filename,
-                             int *flags, Error **errp)
+                             int *flags, bool allow_parse_filename,
+                             Error **errp)
 {
     const char *drvname;
     bool protocol = *flags & BDRV_O_PROTOCOL;
@@ -2089,7 +2091,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     if (protocol && filename) {
         if (!qdict_haskey(*options, "filename")) {
             qdict_put_str(*options, "filename", filename);
-            parse_filename = true;
+            parse_filename = allow_parse_filename;
         } else {
             error_setg(errp, "Can't specify 'file' and 'filename' options at "
                              "the same time");
@@ -3675,7 +3677,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
 
     backing_hd = bdrv_open_inherit(backing_filename, reference, options, 0, bs,
-                                   &child_of_bds, bdrv_backing_role(bs), errp);
+                                   &child_of_bds, bdrv_backing_role(bs), true,
+                                   errp);
     if (!backing_hd) {
         bs->open_flags |= BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -3712,7 +3715,8 @@ free_exit:
 static BlockDriverState *
 bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
                    BlockDriverState *parent, const BdrvChildClass *child_class,
-                   BdrvChildRole child_role, bool allow_none, Error **errp)
+                   BdrvChildRole child_role, bool allow_none,
+                   bool parse_filename, Error **errp)
 {
     BlockDriverState *bs = NULL;
     QDict *image_options;
@@ -3743,7 +3747,8 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
     }
 
     bs = bdrv_open_inherit(filename, reference, image_options, 0,
-                           parent, child_class, child_role, errp);
+                           parent, child_class, child_role, parse_filename,
+                           errp);
     if (!bs) {
         goto done;
     }
@@ -3753,6 +3758,37 @@ done:
     return bs;
 }
 
+static BdrvChild *bdrv_open_child_common(const char *filename,
+                                         QDict *options, const char *bdref_key,
+                                         BlockDriverState *parent,
+                                         const BdrvChildClass *child_class,
+                                         BdrvChildRole child_role,
+                                         bool allow_none, bool parse_filename,
+                                         Error **errp)
+{
+    BlockDriverState *bs;
+    BdrvChild *child;
+    AioContext *ctx;
+
+    GLOBAL_STATE_CODE();
+
+    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_class,
+                            child_role, allow_none, parse_filename, errp);
+    if (bs == NULL) {
+        return NULL;
+    }
+
+    bdrv_graph_wrlock(NULL);
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+    child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
+                              errp);
+    aio_context_release(ctx);
+    bdrv_graph_wrunlock(NULL);
+
+    return child;
+}
+
 /*
  * Opens a disk image whose options are given as BlockdevRef in another block
  * device's options.
@@ -3778,31 +3814,15 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BdrvChildRole child_role,
                            bool allow_none, Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvChild *child;
-    AioContext *ctx;
-
-    GLOBAL_STATE_CODE();
-
-    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_class,
-                            child_role, allow_none, errp);
-    if (bs == NULL) {
-        return NULL;
-    }
-
-    bdrv_graph_wrlock(NULL);
-    ctx = bdrv_get_aio_context(bs);
-    aio_context_acquire(ctx);
-    child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
-                              errp);
-    aio_context_release(ctx);
-    bdrv_graph_wrunlock(NULL);
-
-    return child;
+    return bdrv_open_child_common(filename, options, bdref_key, parent,
+                                  child_class, child_role, allow_none, false,
+                                  errp);
 }
 
 /*
- * Wrapper on bdrv_open_child() for most popular case: open primary child of bs.
+ * This does mostly the same as bdrv_open_child(), but for opening the primary
+ * child of a node. A notable difference from bdrv_open_child() is that it
+ * enables filename parsing for protocol names (including json:).
  *
  * The caller must hold the lock of the main AioContext and no other AioContext.
  * @parent can move to a different AioContext in this function. Callers must
@@ -3819,8 +3839,8 @@ int bdrv_open_file_child(const char *filename,
     role = parent->drv->is_filter ?
         (BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY) : BDRV_CHILD_IMAGE;
 
-    if (!bdrv_open_child(filename, options, bdref_key, parent,
-                         &child_of_bds, role, false, errp))
+    if (!bdrv_open_child_common(filename, options, bdref_key, parent,
+                                &child_of_bds, role, false, true, errp))
     {
         return -EINVAL;
     }
@@ -3865,7 +3885,8 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 
     }
 
-    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, errp);
+    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, false,
+                           errp);
     obj = NULL;
     qobject_unref(obj);
     visit_free(v);
@@ -3962,7 +3983,7 @@ static BlockDriverState * no_coroutine_fn
 bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
                   int flags, BlockDriverState *parent,
                   const BdrvChildClass *child_class, BdrvChildRole child_role,
-                  Error **errp)
+                  bool parse_filename, Error **errp)
 {
     int ret;
     BlockBackend *file = NULL;
@@ -4011,9 +4032,11 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     }
 
     /* json: syntax counts as explicit options, as if in the QDict */
-    parse_json_protocol(options, &filename, &local_err);
-    if (local_err) {
-        goto fail;
+    if (parse_filename) {
+        parse_json_protocol(options, &filename, &local_err);
+        if (local_err) {
+            goto fail;
+        }
     }
 
     bs->explicit_options = qdict_clone_shallow(options);
@@ -4038,7 +4061,8 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
                                      parent->open_flags, parent->options);
     }
 
-    ret = bdrv_fill_options(&options, filename, &flags, &local_err);
+    ret = bdrv_fill_options(&options, filename, &flags, parse_filename,
+                            &local_err);
     if (ret < 0) {
         goto fail;
     }
@@ -4107,7 +4131,7 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
 
         file_bs = bdrv_open_child_bs(filename, options, "file", bs,
                                      &child_of_bds, BDRV_CHILD_IMAGE,
-                                     true, &local_err);
+                                     true, true, &local_err);
         if (local_err) {
             goto fail;
         }
@@ -4270,7 +4294,7 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
     GLOBAL_STATE_CODE();
 
     return bdrv_open_inherit(filename, reference, options, flags, NULL,
-                             NULL, 0, errp);
+                             NULL, 0, true, errp);
 }
 
 /* Return true if the NULL-terminated @list contains @str */
-- 
2.39.2


