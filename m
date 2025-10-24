Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA106CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 12:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCGwo-00062Y-3N; Fri, 24 Oct 2025 08:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vCGwm-00061S-9t
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vCGwk-00068e-6R
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 08:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761309065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9B7wu+SfNVhC5TFZoBPOUdxmzu1rq3LIlO+WXANdseE=;
 b=erjNoRij4bXQcVxDuVqgMnW24urd/JaeKylLTXZY2IHq0heyEFED84oKh1kJ1BUnZwYyzy
 2OYVIKQPeHTCVZ2qTCZYheg4DMVmTMakasDspmpMdXs8dy3F5C1lrB082DnbaJMaibD+Sx
 hmw1kpqBftJvLzpv4VOOQtdgLg+uVF0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-19D1gkLjN_WfSr9uExVnPg-1; Fri,
 24 Oct 2025 08:31:01 -0400
X-MC-Unique: 19D1gkLjN_WfSr9uExVnPg-1
X-Mimecast-MFC-AGG-ID: 19D1gkLjN_WfSr9uExVnPg_1761309061
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 097D31800D8C; Fri, 24 Oct 2025 12:31:01 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.249])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1F2919540EB; Fri, 24 Oct 2025 12:30:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, hreitz@redhat.com
Subject: [PATCH v2 4/4] qemu-img info: Add cache mode option
Date: Fri, 24 Oct 2025 14:30:40 +0200
Message-ID: <20251024123041.51254-5-kwolf@redhat.com>
In-Reply-To: <20251024123041.51254-1-kwolf@redhat.com>
References: <20251024123041.51254-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When querying block limits, different cache modes (in particular
O_DIRECT or not) can result in different limits. Add an option to
'qemu-img info' that allows the user to specify a cache mode, so that
they can get the block limits for the cache mode they intend to use with
their VM.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst |  2 +-
 qemu-img.c              | 25 +++++++++++++++++++++----
 qemu-img-cmds.hx        |  4 ++--
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index fdc9ea9cf2..558b0eb84d 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -503,7 +503,7 @@ Command description:
 
   The size syntax is similar to :manpage:`dd(1)`'s size syntax.
 
-.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [--limits] [-U] FILENAME
+.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [--limits] [-t CACHE] [-U] FILENAME
 
   Give information about the disk image *FILENAME*. Use it in
   particular to know the size reserved on disk which can be different
diff --git a/qemu-img.c b/qemu-img.c
index 5cdbeda969..a7791896c1 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3003,6 +3003,7 @@ static gboolean str_equal_func(gconstpointer a, gconstpointer b)
 static BlockGraphInfoList *collect_image_info_list(bool image_opts,
                                                    const char *filename,
                                                    const char *fmt,
+                                                   const char *cache,
                                                    bool chain, bool limits,
                                                    bool force_share)
 {
@@ -3010,6 +3011,15 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
     BlockGraphInfoList **tail = &head;
     GHashTable *filenames;
     Error *err = NULL;
+    int cache_flags = 0;
+    bool writethrough = false;
+    int ret;
+
+    ret = bdrv_parse_cache_mode(cache, &cache_flags, &writethrough);
+    if (ret < 0) {
+        error_report("Invalid cache option: %s", cache);
+        return NULL;
+    }
 
     filenames = g_hash_table_new_full(g_str_hash, str_equal_func, NULL, NULL);
 
@@ -3026,8 +3036,8 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
         g_hash_table_insert(filenames, (gpointer)filename, NULL);
 
         blk = img_open(image_opts, filename, fmt,
-                       BDRV_O_NO_BACKING | BDRV_O_NO_IO, false, false,
-                       force_share);
+                       BDRV_O_NO_BACKING | BDRV_O_NO_IO | cache_flags,
+                       writethrough, false, force_share);
         if (!blk) {
             goto err;
         }
@@ -3087,6 +3097,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
     OutputFormat output_format = OFORMAT_HUMAN;
     bool chain = false;
     const char *filename, *fmt;
+    const char *cache = BDRV_DEFAULT_CACHE;
     BlockGraphInfoList *list;
     bool image_opts = false;
     bool force_share = false;
@@ -3099,13 +3110,14 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
+            {"cache", required_argument, 0, 't'},
             {"force-share", no_argument, 0, 'U'},
             {"limits", no_argument, 0, OPTION_LIMITS},
             {"output", required_argument, 0, OPTION_OUTPUT},
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:U", long_options, NULL);
+        c = getopt_long(argc, argv, "hf:t:U", long_options, NULL);
         if (c == -1) {
             break;
         }
@@ -3121,6 +3133,8 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
 "     (incompatible with -f|--format)\n"
 "  --backing-chain\n"
 "     display information about the backing chain for copy-on-write overlays\n"
+"  -t, --cache CACHE\n"
+"     cache mode for FILE (default: " BDRV_DEFAULT_CACHE ")\n"
 "  -U, --force-share\n"
 "     open image in shared mode for concurrent access\n"
 "  --limits\n"
@@ -3143,6 +3157,9 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_BACKING_CHAIN:
             chain = true;
             break;
+        case 't':
+            cache = optarg;
+            break;
         case 'U':
             force_share = true;
             break;
@@ -3164,7 +3181,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
     }
     filename = argv[optind++];
 
-    list = collect_image_info_list(image_opts, filename, fmt, chain,
+    list = collect_image_info_list(image_opts, filename, fmt, cache, chain,
                                    limits, force_share);
     if (!list) {
         return 1;
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 74b66f9d42..6bc8265cfb 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -66,9 +66,9 @@ SRST
 ERST
 
 DEF("info", img_info,
-    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [--limits] [-U] filename")
+    "info [--object objectdef] [--image-opts] [-f fmt] [--output=ofmt] [--backing-chain] [--limits] [-t CACHE] [-U] filename")
 SRST
-.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [--limits] [-U] FILENAME
+.. option:: info [--object OBJECTDEF] [--image-opts] [-f FMT] [--output=OFMT] [--backing-chain] [--limits] [-t CACHE] [-U] FILENAME
 ERST
 
 DEF("map", img_map,
-- 
2.51.0


