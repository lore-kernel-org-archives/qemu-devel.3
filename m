Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83BDFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzvB-0003Mv-Tq; Tue, 10 Mar 2026 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzuv-0003E3-Um
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzzuu-0000pm-F5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEhyHYVkrtozPczJJn4tjxRJRMbKxsS3I+NZXoKZ698=;
 b=R6ASNA2Sammod5B139FL0dxKLQY6N/lSuMdzIaV0lxaJavEgeFPG0ZpppomsCbHYFzLfYf
 CwZrUtElDO9gP4cpsi1NydWQ6lBm8cK21Y/lvPMSmW7W2HnGyZn5c+AGzIYUgtPhplm/dP
 JCXbj6FYlHGOE4X2YPMd+lhxU9t5048=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-7NyNzwkbPq6E-fB2Wsg1HQ-1; Tue,
 10 Mar 2026 12:26:39 -0400
X-MC-Unique: 7NyNzwkbPq6E-fB2Wsg1HQ-1
X-Mimecast-MFC-AGG-ID: 7NyNzwkbPq6E-fB2Wsg1HQ_1773159998
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE7F11955E70; Tue, 10 Mar 2026 16:26:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A79419560A6; Tue, 10 Mar 2026 16:26:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/28] fuse: Change setup_... to mount_fuse_export()
Date: Tue, 10 Mar 2026 17:25:59 +0100
Message-ID: <20260310162622.333137-6-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Hanna Czenczek <hreitz@redhat.com>

There is no clear separation between what should go into
setup_fuse_export() and what should stay in fuse_export_create().

Make it clear that setup_fuse_export() is for mounting only.  Rename it,
and move everything that has nothing to do with mounting up into
fuse_export_create().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20260309150856.26800-6-hreitz@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/fuse.c | 49 ++++++++++++++++++++-------------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index a56f645c05d..00bb2ffee40 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -72,8 +72,7 @@ static void fuse_export_delete(BlockExport *exp);
 
 static void init_exports_table(void);
 
-static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
-                             bool allow_other, Error **errp);
+static int mount_fuse_export(FuseExport *exp, Error **errp);
 static void read_from_fuse_export(void *opaque);
 
 static bool is_regular_file(const char *path, Error **errp);
@@ -193,23 +192,32 @@ static int fuse_export_create(BlockExport *blk_exp,
     exp->st_gid = getgid();
 
     if (args->allow_other == FUSE_EXPORT_ALLOW_OTHER_AUTO) {
-        /* Ignore errors on our first attempt */
-        ret = setup_fuse_export(exp, args->mountpoint, true, NULL);
-        exp->allow_other = ret == 0;
+        /* Try allow_other == true first, ignore errors */
+        exp->allow_other = true;
+        ret = mount_fuse_export(exp, NULL);
         if (ret < 0) {
-            ret = setup_fuse_export(exp, args->mountpoint, false, errp);
+            exp->allow_other = false;
+            ret = mount_fuse_export(exp, errp);
         }
     } else {
         exp->allow_other = args->allow_other == FUSE_EXPORT_ALLOW_OTHER_ON;
-        ret = setup_fuse_export(exp, args->mountpoint, exp->allow_other, errp);
+        ret = mount_fuse_export(exp, errp);
     }
     if (ret < 0) {
         goto fail;
     }
 
+    g_hash_table_insert(exports, g_strdup(exp->mountpoint), NULL);
+
+    aio_set_fd_handler(exp->common.ctx,
+                       fuse_session_fd(exp->fuse_session),
+                       read_from_fuse_export, NULL, NULL, NULL, exp);
+    exp->fd_handler_set_up = true;
+
     return 0;
 
 fail:
+    fuse_export_shutdown(blk_exp);
     fuse_export_delete(blk_exp);
     return ret;
 }
@@ -227,10 +235,10 @@ static void init_exports_table(void)
 }
 
 /**
- * Create exp->fuse_session and mount it.
+ * Create exp->fuse_session and mount it.  Expects exp->mountpoint,
+ * exp->writable, and exp->allow_other to be set as intended for the mount.
  */
-static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
-                             bool allow_other, Error **errp)
+static int mount_fuse_export(FuseExport *exp, Error **errp)
 {
     const char *fuse_argv[4];
     char *mount_opts;
@@ -243,7 +251,7 @@ static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
      */
     mount_opts = g_strdup_printf("max_read=%zu,default_permissions%s",
                                  FUSE_MAX_BOUNCE_BYTES,
-                                 allow_other ? ",allow_other" : "");
+                                 exp->allow_other ? ",allow_other" : "");
 
     fuse_argv[0] = ""; /* Dummy program name */
     fuse_argv[1] = "-o";
@@ -256,30 +264,17 @@ static int setup_fuse_export(FuseExport *exp, const char *mountpoint,
     g_free(mount_opts);
     if (!exp->fuse_session) {
         error_setg(errp, "Failed to set up FUSE session");
-        ret = -EIO;
-        goto fail;
+        return -EIO;
     }
 
-    ret = fuse_session_mount(exp->fuse_session, mountpoint);
+    ret = fuse_session_mount(exp->fuse_session, exp->mountpoint);
     if (ret < 0) {
         error_setg(errp, "Failed to mount FUSE session to export");
-        ret = -EIO;
-        goto fail;
+        return -EIO;
     }
     exp->mounted = true;
 
-    g_hash_table_insert(exports, g_strdup(mountpoint), NULL);
-
-    aio_set_fd_handler(exp->common.ctx,
-                       fuse_session_fd(exp->fuse_session),
-                       read_from_fuse_export, NULL, NULL, NULL, exp);
-    exp->fd_handler_set_up = true;
-
     return 0;
-
-fail:
-    fuse_export_shutdown(&exp->common);
-    return ret;
 }
 
 /**
-- 
2.53.0


