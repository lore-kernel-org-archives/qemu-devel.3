Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D19CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE50t-00067O-Bd; Wed, 29 Oct 2025 08:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xx-0003RM-OI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xR-000573-0V
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/R3cngSTl1RFIZ+auMj6lyWa7k0mkGS4J9oO8ESzdQ=;
 b=M9D60scoe2TEUlnWgzRpXTpZc8pW11nDbarwq3s3ccXPpcXluQNvchdWezPVhepuhZtkC5
 AFBQCOeg1bmQtxVn2kSHAwsXepYgct4DMWsRmc895fd5w7/J6wn10s80zrqW/2muLG4p1C
 9xlv/Apj6/q3JuIphKyqTa1Hs+VxBmc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-nU5EhVasPEaVZSaOo4wj3g-1; Wed,
 29 Oct 2025 08:07:10 -0400
X-MC-Unique: nU5EhVasPEaVZSaOo4wj3g-1
X-Mimecast-MFC-AGG-ID: nU5EhVasPEaVZSaOo4wj3g_1761739629
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 737DF195609D; Wed, 29 Oct 2025 12:07:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 32C8D180057C; Wed, 29 Oct 2025 12:07:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 17/18] qemu-img info: Optionally show block limits
Date: Wed, 29 Oct 2025 13:06:33 +0100
Message-ID: <20251029120634.288467-18-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Add a new --limits option to 'qemu-img info' that displays the block
limits for the image and all of its children, making the information
more accessible for human users than in QMP. This option is not enabled
by default because it can be a lot of output that isn't usually relevant
if you're not specifically trying to diagnose some I/O problem.

This makes the same information automatically also available in HMP
'info block -v'.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20251024123041.51254-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst |  6 +++++-
 include/block/qapi.h    |  2 +-
 block/qapi.c            | 34 ++++++++++++++++++++++++++++++++--
 qemu-img.c              | 15 ++++++++++++---
 qemu-img-cmds.hx        |  4 ++--
 5 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 5e7b85079d..fdc9ea9cf2 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -503,7 +503,7 @@ Command description:
 
   The size syntax is similar to :manpage:`dd(1)`'s size syntax.
 
-.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [-U] FILENAME
+.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [--limits] [-U] FILENAME
 
   Give information about the disk image *FILENAME*. Use it in
   particular to know the size reserved on disk which can be different
@@ -571,6 +571,10 @@ Command description:
     ``ImageInfoSpecific*`` QAPI object (e.g. ``ImageInfoSpecificQCow2``
     for qcow2 images).
 
+  *Block limits*
+    The block limits for I/O that QEMU detected for the image.
+    This information is only shown if the ``--limits`` option was specified.
+
 .. option:: map [--object OBJECTDEF] [--image-opts] [-f FMT] [--start-offset=OFFSET] [--max-length=LEN] [--output=OFMT] [-U] FILENAME
 
   Dump the metadata of image *FILENAME* and its backing file chain.
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 54c48de26a..be554e53dc 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -42,7 +42,7 @@ bdrv_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
                       bool skip_implicit_filters, Error **errp);
 void GRAPH_RDLOCK
 bdrv_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
-                            Error **errp);
+                            bool limits, Error **errp);
 
 void bdrv_snapshot_dump(QEMUSnapshotInfo *sn);
 void bdrv_image_info_specific_dump(ImageInfoSpecific *info_spec,
diff --git a/block/qapi.c b/block/qapi.c
index 54521d0a68..9f5771e019 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -417,6 +417,7 @@ fail:
  */
 void bdrv_query_block_graph_info(BlockDriverState *bs,
                                  BlockGraphInfo **p_info,
+                                 bool limits,
                                  Error **errp)
 {
     ERRP_GUARD();
@@ -425,7 +426,7 @@ void bdrv_query_block_graph_info(BlockDriverState *bs,
     BdrvChild *c;
 
     info = g_new0(BlockGraphInfo, 1);
-    bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), false, errp);
+    bdrv_do_query_node_info(bs, qapi_BlockGraphInfo_base(info), limits, errp);
     if (*errp) {
         goto fail;
     }
@@ -439,7 +440,7 @@ void bdrv_query_block_graph_info(BlockDriverState *bs,
         QAPI_LIST_APPEND(children_list_tail, c_info);
 
         c_info->name = g_strdup(c->name);
-        bdrv_query_block_graph_info(c->bs, &c_info->info, errp);
+        bdrv_query_block_graph_info(c->bs, &c_info->info, limits, errp);
         if (*errp) {
             goto fail;
         }
@@ -936,6 +937,29 @@ void bdrv_image_info_specific_dump(ImageInfoSpecific *info_spec,
     visit_free(v);
 }
 
+/**
+ * Dumps the given BlockLimitsInfo object in a human-readable form,
+ * prepending an optional prefix if the dump is not empty.
+ */
+static void bdrv_image_info_limits_dump(BlockLimitsInfo *limits,
+                                        const char *prefix,
+                                        int indentation)
+{
+    QObject *obj;
+    Visitor *v = qobject_output_visitor_new(&obj);
+
+    visit_type_BlockLimitsInfo(v, NULL, &limits, &error_abort);
+    visit_complete(v, &obj);
+    if (!qobject_is_empty_dump(obj)) {
+        if (prefix) {
+            qemu_printf("%*s%s", indentation * 4, "", prefix);
+        }
+        dump_qobject(indentation + 1, obj);
+    }
+    qobject_unref(obj);
+    visit_free(v);
+}
+
 /**
  * Print the given @info object in human-readable form.  Every field is indented
  * using the given @indentation (four spaces per indentation level).
@@ -1011,6 +1035,12 @@ void bdrv_node_info_dump(BlockNodeInfo *info, int indentation, bool protocol)
         }
     }
 
+    if (info->limits) {
+        bdrv_image_info_limits_dump(info->limits,
+                                    "Block limits:\n",
+                                    indentation);
+    }
+
     if (info->has_snapshots) {
         SnapshotInfoList *elem;
 
diff --git a/qemu-img.c b/qemu-img.c
index 7a162fdc08..5cdbeda969 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -86,6 +86,7 @@ enum {
     OPTION_BITMAPS = 275,
     OPTION_FORCE = 276,
     OPTION_SKIP_BROKEN = 277,
+    OPTION_LIMITS = 278,
 };
 
 typedef enum OutputFormat {
@@ -3002,7 +3003,8 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static BlockGraphInfoList *collect_image_info_list(bool image_opts,
                                                    const char *filename,
                                                    const char *fmt,
-                                                   bool chain, bool force_share)
+                                                   bool chain, bool limits,
+                                                   bool force_share)
 {
     BlockGraphInfoList *head = NULL;
     BlockGraphInfoList **tail = &head;
@@ -3039,7 +3041,7 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
          * the chain manually here.
          */
         bdrv_graph_rdlock_main_loop();
-        bdrv_query_block_graph_info(bs, &info, &err);
+        bdrv_query_block_graph_info(bs, &info, limits, &err);
         bdrv_graph_rdunlock_main_loop();
 
         if (err) {
@@ -3088,6 +3090,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
     BlockGraphInfoList *list;
     bool image_opts = false;
     bool force_share = false;
+    bool limits = false;
 
     fmt = NULL;
     for(;;) {
@@ -3097,6 +3100,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
             {"force-share", no_argument, 0, 'U'},
+            {"limits", no_argument, 0, OPTION_LIMITS},
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
@@ -3119,6 +3123,8 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
 "     display information about the backing chain for copy-on-write overlays\n"
 "  -U, --force-share\n"
 "     open image in shared mode for concurrent access\n"
+"  --limits\n"
+"     show detected block limits (may depend on options, e.g. cache mode)\n"
 "  --output human|json\n"
 "     specify output format (default: human)\n"
 "  --object OBJDEF\n"
@@ -3140,6 +3146,9 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case OPTION_LIMITS:
+            limits = true;
+            break;
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
@@ -3156,7 +3165,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
     filename = argv[optind++];
 
     list = collect_image_info_list(image_opts, filename, fmt, chain,
-                                   force_share);
+                                   limits, force_share);
     if (!list) {
         return 1;
     }
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 2c5a8a28f9..74b66f9d42 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -66,9 +66,9 @@ SRST
 ERST
 
 DEF("info", img_info,
-    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [-U] filename")
+    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [--limits] [-U] filename")
 SRST
-.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [-U] FILENAME
+.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [--limits] [-U] FILENAME
 ERST
 
 DEF("map", img_map,
-- 
2.51.0


