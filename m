Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22543C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXm6H-00028f-Hp; Wed, 07 Feb 2024 12:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXm6F-00027K-GV; Wed, 07 Feb 2024 12:52:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXm6D-0003Iy-Kq; Wed, 07 Feb 2024 12:52:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 349C44B3CA;
 Wed,  7 Feb 2024 20:53:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E60E77639A;
 Wed,  7 Feb 2024 20:52:35 +0300 (MSK)
Received: (nullmailer pid 296722 invoked by uid 1000);
 Wed, 07 Feb 2024 17:52:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PATCH trivial] qemu-img: factor out parse_output_format() and use it
 in the code
Date: Wed,  7 Feb 2024 20:52:28 +0300
Message-Id: <20240207175228.296704-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
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
index 7668f86769..eb6017d339 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -126,6 +126,17 @@ void unrecognized_option(const char *option)
     error_exit("unrecognized option '%s'", option);
 }
 
+static OutputFormat parse_output_format(const char *arg)
+{
+    if (!strcmp(arg, "json")) {
+        return OFORMAT_JSON;
+    } else if (!strcmp(arg, "human")) {
+        return OFORMAT_HUMAN;
+    } else {
+        error_exit("--output expects 'human' or 'json' not '%s'", arg);
+    }
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -720,7 +731,7 @@ static int img_check(int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
-    const char *filename, *fmt, *output, *cache;
+    const char *filename, *fmt, *cache;
     BlockBackend *blk;
     BlockDriverState *bs;
     int fix = 0;
@@ -732,7 +743,6 @@ static int img_check(int argc, char **argv)
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     cache = BDRV_DEFAULT_CACHE;
 
     for(;;) {
@@ -778,7 +788,7 @@ static int img_check(int argc, char **argv)
             }
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(optarg);
             break;
         case 'T':
             cache = optarg;
@@ -802,15 +812,6 @@ static int img_check(int argc, char **argv)
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
@@ -3004,13 +3005,12 @@ static int img_info(int argc, char **argv)
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
@@ -3045,7 +3045,7 @@ static int img_info(int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(optarg);
             break;
         case OPTION_BACKING_CHAIN:
             chain = true;
@@ -3063,15 +3063,6 @@ static int img_info(int argc, char **argv)
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
@@ -3230,7 +3221,7 @@ static int img_map(int argc, char **argv)
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
     BlockDriverState *bs;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     int64_t length;
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
@@ -3240,7 +3231,6 @@ static int img_map(int argc, char **argv)
     int64_t max_length = -1;
 
     fmt = NULL;
-    output = NULL;
     for (;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3276,7 +3266,7 @@ static int img_map(int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(optarg);
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3303,15 +3293,6 @@ static int img_map(int argc, char **argv)
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
@@ -5411,15 +5392,7 @@ static int img_measure(int argc, char **argv)
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
+            output_format = parse_output_format(optarg);
             break;
         case OPTION_SIZE:
         {
-- 
2.39.2


