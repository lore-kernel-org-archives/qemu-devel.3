Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0523C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgYI-0005rd-CY; Tue, 02 Jul 2024 12:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYE-0005ok-OC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sOgYC-0008Rh-By
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719938415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWVX6cfWRQvvKI/3LXmG+yhgq8BUqI5XgdFlDNcxlOk=;
 b=OwWLm3N0VIUyKqGVakhOeDKHHb/wyX2t8Ja6xicVfdNrGnViKUp6phDWBnNahw8U6wUIlj
 oXQZuDf7Fu8WOn834XJSddK4RixtwfoKB02T3uPK6ACMyeZ5oJUDkBBsMAxnpvHtoF2TVk
 82LqJMVvwdAgIl47RXxjflS+o3CtcCc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-DayalJDOOaek8AoOjWF7GA-1; Tue,
 02 Jul 2024 12:40:12 -0400
X-MC-Unique: DayalJDOOaek8AoOjWF7GA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34275196CE1C; Tue,  2 Jul 2024 16:40:11 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.206])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24F5819560AD; Tue,  2 Jul 2024 16:40:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, richard.henderson@linaro.org, hreitz@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PULL 4/4] block: Parse filenames only when explicitly requested
Date: Tue,  2 Jul 2024 18:39:43 +0200
Message-ID: <20240702163943.276618-5-kwolf@redhat.com>
In-Reply-To: <20240702163943.276618-1-kwolf@redhat.com>
References: <20240702163943.276618-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 block.c | 90 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 57 insertions(+), 33 deletions(-)

diff --git a/block.c b/block.c
index c1cc313d21..c317de9eaa 100644
--- a/block.c
+++ b/block.c
@@ -86,6 +86,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
                                            BlockDriverState *parent,
                                            const BdrvChildClass *child_class,
                                            BdrvChildRole child_role,
+                                           bool parse_filename,
                                            Error **errp);
 
 static bool bdrv_recurse_has_child(BlockDriverState *bs,
@@ -2055,7 +2056,8 @@ static void parse_json_protocol(QDict *options, const char **pfilename,
  * block driver has been specified explicitly.
  */
 static int bdrv_fill_options(QDict **options, const char *filename,
-                             int *flags, Error **errp)
+                             int *flags, bool allow_parse_filename,
+                             Error **errp)
 {
     const char *drvname;
     bool protocol = *flags & BDRV_O_PROTOCOL;
@@ -2097,7 +2099,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     if (protocol && filename) {
         if (!qdict_haskey(*options, "filename")) {
             qdict_put_str(*options, "filename", filename);
-            parse_filename = true;
+            parse_filename = allow_parse_filename;
         } else {
             error_setg(errp, "Can't specify 'file' and 'filename' options at "
                              "the same time");
@@ -3660,7 +3662,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
 
     backing_hd = bdrv_open_inherit(backing_filename, reference, options, 0, bs,
-                                   &child_of_bds, bdrv_backing_role(bs), errp);
+                                   &child_of_bds, bdrv_backing_role(bs), true,
+                                   errp);
     if (!backing_hd) {
         bs->open_flags |= BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -3694,7 +3697,8 @@ free_exit:
 static BlockDriverState *
 bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
                    BlockDriverState *parent, const BdrvChildClass *child_class,
-                   BdrvChildRole child_role, bool allow_none, Error **errp)
+                   BdrvChildRole child_role, bool allow_none,
+                   bool parse_filename, Error **errp)
 {
     BlockDriverState *bs = NULL;
     QDict *image_options;
@@ -3725,7 +3729,8 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
     }
 
     bs = bdrv_open_inherit(filename, reference, image_options, 0,
-                           parent, child_class, child_role, errp);
+                           parent, child_class, child_role, parse_filename,
+                           errp);
     if (!bs) {
         goto done;
     }
@@ -3735,6 +3740,33 @@ done:
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
+
+    GLOBAL_STATE_CODE();
+
+    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_class,
+                            child_role, allow_none, parse_filename, errp);
+    if (bs == NULL) {
+        return NULL;
+    }
+
+    bdrv_graph_wrlock();
+    child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
+                              errp);
+    bdrv_graph_wrunlock();
+
+    return child;
+}
+
 /*
  * Opens a disk image whose options are given as BlockdevRef in another block
  * device's options.
@@ -3758,27 +3790,15 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BdrvChildRole child_role,
                            bool allow_none, Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvChild *child;
-
-    GLOBAL_STATE_CODE();
-
-    bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_class,
-                            child_role, allow_none, errp);
-    if (bs == NULL) {
-        return NULL;
-    }
-
-    bdrv_graph_wrlock();
-    child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
-                              errp);
-    bdrv_graph_wrunlock();
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
  * @parent can move to a different AioContext in this function.
  */
@@ -3793,8 +3813,8 @@ int bdrv_open_file_child(const char *filename,
     role = parent->drv->is_filter ?
         (BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY) : BDRV_CHILD_IMAGE;
 
-    if (!bdrv_open_child(filename, options, bdref_key, parent,
-                         &child_of_bds, role, false, errp))
+    if (!bdrv_open_child_common(filename, options, bdref_key, parent,
+                                &child_of_bds, role, false, true, errp))
     {
         return -EINVAL;
     }
@@ -3839,7 +3859,8 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 
     }
 
-    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, errp);
+    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, false,
+                           errp);
     obj = NULL;
     qobject_unref(obj);
     visit_free(v);
@@ -3929,7 +3950,7 @@ static BlockDriverState * no_coroutine_fn
 bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
                   int flags, BlockDriverState *parent,
                   const BdrvChildClass *child_class, BdrvChildRole child_role,
-                  Error **errp)
+                  bool parse_filename, Error **errp)
 {
     int ret;
     BlockBackend *file = NULL;
@@ -3977,9 +3998,11 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
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
@@ -4004,7 +4027,8 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
                                      parent->open_flags, parent->options);
     }
 
-    ret = bdrv_fill_options(&options, filename, &flags, &local_err);
+    ret = bdrv_fill_options(&options, filename, &flags, parse_filename,
+                            &local_err);
     if (ret < 0) {
         goto fail;
     }
@@ -4073,7 +4097,7 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
 
         file_bs = bdrv_open_child_bs(filename, options, "file", bs,
                                      &child_of_bds, BDRV_CHILD_IMAGE,
-                                     true, &local_err);
+                                     true, true, &local_err);
         if (local_err) {
             goto fail;
         }
@@ -4222,7 +4246,7 @@ BlockDriverState *bdrv_open(const char *filename, const char *reference,
     GLOBAL_STATE_CODE();
 
     return bdrv_open_inherit(filename, reference, options, flags, NULL,
-                             NULL, 0, errp);
+                             NULL, 0, true, errp);
 }
 
 /* Return true if the NULL-terminated @list contains @str */
-- 
2.45.2


