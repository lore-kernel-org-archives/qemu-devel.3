Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDD2CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIw1B-0001P4-EF; Tue, 11 Nov 2025 16:35:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw0P-0000UL-Cz
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw0N-0002Hf-2e
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDFRarAf5ZaB6K/52baQUM68FuJ2NxkUnuHxok7x0jE=;
 b=AS3uQXj1ATntRpw3C620Sw4X1dfS9+ReTiCVVD1dheVYNMoAJMEjj6liGaHAqxoAnlWI80
 Cx9yCDsPH4SsAsQcz90mEy96W8AMBcKJOUeKpLt99ylwUDd8qrc4oZoUgJRX7DlsXhx+dH
 D+BT8XsNGE46snJZbrH3FgXW0D9lie4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-oFAL9tGqNcyq_oNHDb19-Q-1; Tue,
 11 Nov 2025 16:34:01 -0500
X-MC-Unique: oFAL9tGqNcyq_oNHDb19-Q-1
X-Mimecast-MFC-AGG-ID: oFAL9tGqNcyq_oNHDb19-Q_1762896839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B59C195608F; Tue, 11 Nov 2025 21:33:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7CF4830044E0; Tue, 11 Nov 2025 21:33:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 26/28] block: Allow drivers to control protocol prefix at
 creation
Date: Tue, 11 Nov 2025 22:32:36 +0100
Message-ID: <20251111213238.181992-27-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Blake <eblake@redhat.com>

This patch is pure refactoring: instead of hard-coding permission to
use a protocol prefix when creating an image, the drivers can now pass
in a parameter, comparable to what they could already do for opening a
pre-existing image.  This patch is purely mechanical (all drivers pass
in true for now), but it will enable the next patch to cater to
drivers that want to differ in behavior for the primary image vs. any
secondary images that are opened at the same time as creating the
primary image.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250915213919.3121401-5-eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 3 ++-
 block.c                            | 4 ++--
 block/crypto.c                     | 2 +-
 block/parallels.c                  | 2 +-
 block/qcow.c                       | 2 +-
 block/qcow2.c                      | 4 ++--
 block/qed.c                        | 2 +-
 block/raw-format.c                 | 2 +-
 block/vdi.c                        | 2 +-
 block/vhdx.c                       | 2 +-
 block/vmdk.c                       | 2 +-
 block/vpc.c                        | 2 +-
 12 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 62da83c616..479ca2858e 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -65,7 +65,8 @@ int co_wrapper bdrv_create(BlockDriver *drv, const char *filename,
                            QemuOpts *opts, Error **errp);
 
 int coroutine_fn GRAPH_UNLOCKED
-bdrv_co_create_file(const char *filename, QemuOpts *opts, Error **errp);
+bdrv_co_create_file(const char *filename, QemuOpts *opts,
+                    bool allow_protocol_prefix, Error **errp);
 
 BlockDriverState *bdrv_new(void);
 int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
diff --git a/block.c b/block.c
index 0fe0152a7c..4f1581cedf 100644
--- a/block.c
+++ b/block.c
@@ -693,7 +693,7 @@ out:
 }
 
 int coroutine_fn bdrv_co_create_file(const char *filename, QemuOpts *opts,
-                                     Error **errp)
+                                     bool allow_protocol_prefix, Error **errp)
 {
     QemuOpts *protocol_opts;
     BlockDriver *drv;
@@ -702,7 +702,7 @@ int coroutine_fn bdrv_co_create_file(const char *filename, QemuOpts *opts,
 
     GLOBAL_STATE_CODE();
 
-    drv = bdrv_find_protocol(filename, true, errp);
+    drv = bdrv_find_protocol(filename, allow_protocol_prefix, errp);
     if (drv == NULL) {
         return -ENOENT;
     }
diff --git a/block/crypto.c b/block/crypto.c
index 7c37b23e36..b97d027444 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -835,7 +835,7 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     }
 
     /* Create protocol layer */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/parallels.c b/block/parallels.c
index 3a375e2a8a..7a90fb5220 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1117,7 +1117,7 @@ parallels_co_create_opts(BlockDriver *drv, const char *filename,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto done;
     }
diff --git a/block/qcow.c b/block/qcow.c
index b442bfe835..3d37d26ee8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -978,7 +978,7 @@ qcow_co_create_opts(BlockDriver *drv, const char *filename,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 4aa9f9e068..ec72e27214 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3956,7 +3956,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto finish;
     }
@@ -3971,7 +3971,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     /* Create and open an external data file (protocol layer) */
     val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
     if (val) {
-        ret = bdrv_co_create_file(val, opts, errp);
+        ret = bdrv_co_create_file(val, opts, true, errp);
         if (ret < 0) {
             goto finish;
         }
diff --git a/block/qed.c b/block/qed.c
index 4a36fb3929..da23a83d62 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -788,7 +788,7 @@ bdrv_qed_co_create_opts(BlockDriver *drv, const char *filename,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index df16ac1ea2..a57c2922d5 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -463,7 +463,7 @@ static int coroutine_fn GRAPH_UNLOCKED
 raw_co_create_opts(BlockDriver *drv, const char *filename,
                    QemuOpts *opts, Error **errp)
 {
-    return bdrv_co_create_file(filename, opts, errp);
+    return bdrv_co_create_file(filename, opts, true, errp);
 }
 
 static int raw_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/block/vdi.c b/block/vdi.c
index 3ddc62a569..87b874a7ef 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -938,7 +938,7 @@ vdi_co_create_opts(BlockDriver *drv, const char *filename,
     qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto done;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index b2a4b813a0..c16e4a00c8 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2096,7 +2096,7 @@ vhdx_co_create_opts(BlockDriver *drv, const char *filename,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 7b98debc2b..eb3c174eca 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2334,7 +2334,7 @@ vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
     int ret;
     BlockBackend *blk = NULL;
 
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/vpc.c b/block/vpc.c
index 801ff5793f..07e8ae0309 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1118,7 +1118,7 @@ vpc_co_create_opts(BlockDriver *drv, const char *filename,
     }
 
     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
-- 
2.51.1


