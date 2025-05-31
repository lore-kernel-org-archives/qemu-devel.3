Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED313C5B549
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPpM-0001K2-B4; Sat, 31 May 2025 13:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPop-00018w-T8; Sat, 31 May 2025 13:16:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPom-00012l-AV; Sat, 31 May 2025 13:16:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E873C126B36;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C05A021BA39;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 06/27] qemu-img: factor out parse_output_format() and use it
 in the code
Date: Sat, 31 May 2025 20:15:48 +0300
Message-Id: <20250531171609.197078-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531171609.197078-1-mjt@tls.msk.ru>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 63 ++++++++++++++++--------------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index cfc69e2503..a26498a4e8 100644
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
+        error_exit(argv0, "--output expects 'human' or 'json', not '%s'", arg);
+    }
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -775,7 +786,7 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
-    const char *filename, *fmt, *output, *cache;
+    const char *filename, *fmt, *cache;
     BlockBackend *blk;
     BlockDriverState *bs;
     int fix = 0;
@@ -787,7 +798,6 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     cache = BDRV_DEFAULT_CACHE;
 
     for(;;) {
@@ -833,7 +843,7 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
             }
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case 'T':
             cache = optarg;
@@ -857,15 +867,6 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3059,13 +3060,12 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3100,7 +3100,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case OPTION_BACKING_CHAIN:
             chain = true;
@@ -3118,15 +3118,6 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -3285,7 +3276,7 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
     BlockDriverState *bs;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     int64_t length;
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
@@ -3295,7 +3286,6 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     int64_t max_length = -1;
 
     fmt = NULL;
-    output = NULL;
     for (;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3331,7 +3321,7 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3358,15 +3348,6 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5471,15 +5452,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
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


