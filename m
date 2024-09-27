Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E30ECEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4Ci-0004yP-6H; Fri, 27 Sep 2024 02:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4Cb-0004Yi-Uq; Fri, 27 Sep 2024 02:11:42 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4Ca-0003GD-4h; Fri, 27 Sep 2024 02:11:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 725D292D17;
 Fri, 27 Sep 2024 09:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E0B29146709;
 Fri, 27 Sep 2024 09:11:21 +0300 (MSK)
Received: (nullmailer pid 573356 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 06/27] qemu-img: factor out parse_output_format() and use it
 in the code
Date: Fri, 27 Sep 2024 09:11:00 +0300
Message-Id: <20240927061121.573271-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927061121.573271-1-mjt@tls.msk.ru>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use common code and simplify error message

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qemu-img.c | 63 ++++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7ed5e6d1a8..08536553c7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -158,6 +158,17 @@ void cmd_help(const img_cmd_t *ccmd,
     exit(EXIT_SUCCESS);
 }
 
+static OutputFormat parse_output_format(const char *argv0, const char *arg)
+{
+    if (!strcmp(arg, "json")) {
+        return OFORMAT_JSON;
+    } else if (!strcmp(arg, "human")) {
+        return OFORMAT_HUMAN;
+    } else {
+        error_exit(argv0, "--output expects 'human' or 'json' not '%s'", arg);
+    }
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -776,7 +787,7 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
-    const char *filename, *fmt, *output, *cache;
+    const char *filename, *fmt, *cache;
     BlockBackend *blk;
     BlockDriverState *bs;
     int fix = 0;
@@ -788,7 +799,6 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     cache = BDRV_DEFAULT_CACHE;
 
     for(;;) {
@@ -834,7 +844,7 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
             }
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case 'T':
             cache = optarg;
@@ -858,15 +868,6 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3060,13 +3061,12 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3101,7 +3101,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case OPTION_BACKING_CHAIN:
             chain = true;
@@ -3119,15 +3119,6 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3286,7 +3277,7 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
     BlockDriverState *bs;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     int64_t length;
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
@@ -3296,7 +3287,6 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     int64_t max_length = -1;
 
     fmt = NULL;
-    output = NULL;
     for (;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3332,7 +3322,7 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3359,15 +3349,6 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5468,15 +5449,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
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
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case OPTION_SIZE:
             img_size = cvtnum("image size", optarg);
-- 
2.39.5


