Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7197C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublPq-0000Rz-Tm; Tue, 15 Jul 2025 15:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxz-0004X5-Mb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxp-0001ie-K4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8YilhHk/UupSHNVVc6qLt52jWenjz4rlqCmqsdLRsaA=;
 b=RgFIVkh0nQ893hzKBPbQC73z9VvukWoHPzFSk/6FcysFydmTp/HszjVENvbQLFV8zaJ//q
 bJIAEb9leshyfILKrrfG0iLaI/qxlEQO5VhSUL7jeSjxlOZSjvkRWt2L9Fm0/21VYoB3lb
 DazLdKaYckv9aEQOhGAZXhdzqbj/oxg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-Bnmzms4UMJWY-IaFOVf78A-1; Tue,
 15 Jul 2025 15:05:15 -0400
X-MC-Unique: Bnmzms4UMJWY-IaFOVf78A-1
X-Mimecast-MFC-AGG-ID: Bnmzms4UMJWY-IaFOVf78A_1752606314
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78529195608E; Tue, 15 Jul 2025 19:05:14 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC480197702B; Tue, 15 Jul 2025 19:05:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 46/57] qemu-img: snapshot: make -l (list) the default,
 simplify option handling
Date: Tue, 15 Jul 2025 21:03:19 +0200
Message-ID: <20250715190330.378764-47-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

When no -l/-a/-c/-d specified, assume -l (list).

Use the same values for SNAPSHOT_LIST/etc constants as the
option chars (lacd), this makes it possible to simplify
option handling a lot, combining cases for 4 options into
one.

Also remove bdrv_oflags handling (only list can use RO mode).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250531171609.197078-17-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 52 ++++++++++++++---------------------------
 2 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 935f28bbc5..a346988292 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -256,7 +256,7 @@ Parameters to snapshot subcommand:
 
 .. option:: -l
 
-  Lists all snapshots in the given image
+  Lists all snapshots in the given image (default action)
 
 Command description:
 
diff --git a/qemu-img.c b/qemu-img.c
index 49c61c8b54..f117efe687 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3587,10 +3587,11 @@ out:
     return ret < 0;
 }
 
-#define SNAPSHOT_LIST   1
-#define SNAPSHOT_CREATE 2
-#define SNAPSHOT_APPLY  3
-#define SNAPSHOT_DELETE 4
+/* the same as options */
+#define SNAPSHOT_LIST   'l'
+#define SNAPSHOT_CREATE 'c'
+#define SNAPSHOT_APPLY  'a'
+#define SNAPSHOT_DELETE 'd'
 
 static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
 {
@@ -3598,7 +3599,7 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     BlockDriverState *bs;
     QEMUSnapshotInfo sn;
     char *filename, *fmt = NULL, *snapshot_name = NULL;
-    int c, ret = 0, bdrv_oflags;
+    int c, ret = 0;
     int action = 0;
     bool quiet = false;
     Error *err = NULL;
@@ -3606,7 +3607,6 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
     int64_t rt;
 
-    bdrv_oflags = BDRV_O_RDWR;
     /* Parse commandline parameters */
     for(;;) {
         static const struct option long_options[] = {
@@ -3634,36 +3634,15 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
-        case 'l':
-            if (action) {
-                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
-                return 0;
-            }
-            action = SNAPSHOT_LIST;
-            bdrv_oflags &= ~BDRV_O_RDWR; /* no need for RW */
-            break;
-        case 'a':
+        case SNAPSHOT_LIST:
+        case SNAPSHOT_APPLY:
+        case SNAPSHOT_CREATE:
+        case SNAPSHOT_DELETE:
             if (action) {
                 error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
-            action = SNAPSHOT_APPLY;
-            snapshot_name = optarg;
-            break;
-        case 'c':
-            if (action) {
-                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
-                return 0;
-            }
-            action = SNAPSHOT_CREATE;
-            snapshot_name = optarg;
-            break;
-        case 'd':
-            if (action) {
-                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
-                return 0;
-            }
-            action = SNAPSHOT_DELETE;
+            action = c;
             snapshot_name = optarg;
             break;
         case 'q':
@@ -3686,9 +3665,14 @@ static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
     }
     filename = argv[optind++];
 
+    if (!action) {
+        action = SNAPSHOT_LIST;
+    }
+
     /* Open the image */
-    blk = img_open(image_opts, filename, fmt, bdrv_oflags, false, quiet,
-                   force_share);
+    blk = img_open(image_opts, filename, fmt,
+                   action == SNAPSHOT_LIST ? 0 : BDRV_O_RDWR,
+                   false, quiet, force_share);
     if (!blk) {
         return 1;
     }
-- 
2.50.1


