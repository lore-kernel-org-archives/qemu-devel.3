Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D01C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 18:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmC8-0003cX-49; Wed, 07 Feb 2024 12:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBq-0003Rq-FG; Wed, 07 Feb 2024 12:58:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBn-000402-Gf; Wed, 07 Feb 2024 12:58:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 433104B3D2;
 Wed,  7 Feb 2024 20:59:33 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3FC36763A2;
 Wed,  7 Feb 2024 20:58:21 +0300 (MSK)
Received: (nullmailer pid 296925 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 3/8] qemu-img: factor out parse_output_format() and use it in
 the code
Date: Wed,  7 Feb 2024 20:58:12 +0300
Message-Id: <0ac80579cb2fb3138beaf88fb3261e05a6b81800.1707328606.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
References: <cover.1707328606.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use common code and simplify error message

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 63 ++++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b94622fadb..f851b290cc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -136,6 +136,17 @@ void cmd_help(const char *cmdname, const char *syntax,
     exit(EXIT_SUCCESS);
 }
 
+static OutputFormat parse_output_format(const char *cmdname, const char *arg)
+{
+    if (!strcmp(arg, "json")) {
+        return OFORMAT_JSON;
+    } else if (!strcmp(arg, "human")) {
+        return OFORMAT_HUMAN;
+    } else {
+        error_exit(cmdname, "--output expects 'human' or 'json' not '%s'", arg);
+    }
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -751,7 +762,7 @@ static int img_check(const char *cmdname, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
-    const char *filename, *fmt, *output, *cache;
+    const char *filename, *fmt, *cache;
     BlockBackend *blk;
     BlockDriverState *bs;
     int fix = 0;
@@ -763,7 +774,6 @@ static int img_check(const char *cmdname, int argc, char **argv)
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     cache = BDRV_DEFAULT_CACHE;
 
     for(;;) {
@@ -809,7 +819,7 @@ static int img_check(const char *cmdname, int argc, char **argv)
             }
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(cmdname, optarg);
             break;
         case 'T':
             cache = optarg;
@@ -833,15 +843,6 @@ static int img_check(const char *cmdname, int argc, char **argv)
     }
     filename = argv[optind++];
 
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
     ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);
     if (ret < 0) {
         error_report("Invalid source cache option: %s", cache);
@@ -3035,13 +3036,12 @@ static int img_info(const char *cmdname, int argc, char **argv)
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
     bool chain = false;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     BlockGraphInfoList *list;
     bool image_opts = false;
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     for(;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3076,7 +3076,7 @@ static int img_info(const char *cmdname, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(cmdname, optarg);
             break;
         case OPTION_BACKING_CHAIN:
             chain = true;
@@ -3094,15 +3094,6 @@ static int img_info(const char *cmdname, int argc, char **argv)
     }
     filename = argv[optind++];
 
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
     list = collect_image_info_list(image_opts, filename, fmt, chain,
                                    force_share);
     if (!list) {
@@ -3261,7 +3252,7 @@ static int img_map(const char *cmdname, int argc, char **argv)
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
     BlockDriverState *bs;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     int64_t length;
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
@@ -3271,7 +3262,6 @@ static int img_map(const char *cmdname, int argc, char **argv)
     int64_t max_length = -1;
 
     fmt = NULL;
-    output = NULL;
     for (;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3307,7 +3297,7 @@ static int img_map(const char *cmdname, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(cmdname, optarg);
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3334,15 +3324,6 @@ static int img_map(const char *cmdname, int argc, char **argv)
     }
     filename = argv[optind];
 
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
     blk = img_open(image_opts, filename, fmt, 0, false, false, force_share);
     if (!blk) {
         return 1;
@@ -5445,15 +5426,7 @@ static int img_measure(const char *cmdname, int argc, char **argv)
             image_opts = true;
             break;
         case OPTION_OUTPUT:
-            if (!strcmp(optarg, "json")) {
-                output_format = OFORMAT_JSON;
-            } else if (!strcmp(optarg, "human")) {
-                output_format = OFORMAT_HUMAN;
-            } else {
-                error_report("--output must be used with human or json "
-                             "as argument.");
-                goto out;
-            }
+            output_format = parse_output_format(cmdname, optarg);
             break;
         case OPTION_SIZE:
         {
-- 
2.39.2


