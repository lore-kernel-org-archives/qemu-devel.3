Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AE6C5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPry-0005AR-Li; Sat, 31 May 2025 13:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqU-0002Z7-L6; Sat, 31 May 2025 13:18:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPqQ-0001Cc-Ep; Sat, 31 May 2025 13:18:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C0F6C126B49;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8E9BC21BA4C;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 25/27] qemu-img: measure: refresh options/--help
Date: Sat, 31 May 2025 20:16:07 +0300
Message-Id: <20250531171609.197078-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531171609.197078-1-mjt@tls.msk.ru>
References: <20250531171609.197078-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Add missing long options and --help output,
reorder options for consistency.

Also add -s short option for --size (and remove OPTION_SIZE).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 89 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 27 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 3220c95e3c..44212de3f6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -71,7 +71,6 @@ enum {
     OPTION_FLUSH_INTERVAL = 261,
     OPTION_NO_DRAIN = 262,
     OPTION_TARGET_IMAGE_OPTS = 263,
-    OPTION_SIZE = 264,
     OPTION_PREALLOCATION = 265,
     OPTION_SHRINK = 266,
     OPTION_SALVAGE = 267,
@@ -5781,15 +5780,6 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
 
 static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 {
-    static const struct option long_options[] = {
-        {"help", no_argument, 0, 'h'},
-        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-        {"object", required_argument, 0, OPTION_OBJECT},
-        {"output", required_argument, 0, OPTION_OUTPUT},
-        {"size", required_argument, 0, OPTION_SIZE},
-        {"force-share", no_argument, 0, 'U'},
-        {0, 0, 0, 0}
-    };
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *in_blk = NULL;
     BlockDriver *drv;
@@ -5810,23 +5800,61 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     int ret = 1;
     int c;
 
-    while ((c = getopt_long(argc, argv, "hf:O:o:l:U",
+    static const struct option long_options[] = {
+        {"help", no_argument, 0, 'h'},
+        {"source-format", required_argument, 0, 'f'}, /* img_convert */
+        {"format", required_argument, 0, 'f'},
+        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS}, /* img_convert */
+        {"snapshot", required_argument, 0, 'l'},
+        {"target-format", required_argument, 0, 'O'},
+        {"target-format-options", required_argument, 0, 'o'}, /* img_convert */
+        {"options", required_argument, 0, 'o'},
+        {"force-share", no_argument, 0, 'U'},
+        {"output", required_argument, 0, OPTION_OUTPUT},
+        {"object", required_argument, 0, OPTION_OBJECT},
+        {"size", required_argument, 0, 's'},
+        {0, 0, 0, 0}
+    };
+
+    while ((c = getopt_long(argc, argv, "hf:l:O:o:Us:",
                             long_options, NULL)) != -1) {
         switch (c) {
-        case '?':
         case 'h':
-            help();
+            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT_PARAM]\n"
+"       [-O TARGET_FMT] [-o TARGET_FMT_OPTS] [--output human|json]\n"
+"       [--object OBJDEF] (--size SIZE | FILE)\n"
+,
+"  -f, --format\n"
+"     specify format of FILE explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     indicates that FILE is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -l, --snapshot SNAPSHOT\n"
+"     use this snapshot in FILE as source\n"
+"  -O, --target-format TARGET_FMT\n"
+"     desired target/output image format (default: raw)\n"
+"  -o TARGET_FMT_OPTS\n"
+"     options specific to TARGET_FMT\n"
+"  --output human|json\n"
+"     output format (default: human)\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  -s, --size SIZE[bKMGTPE]\n"
+"     measure file size for given image size,\n"
+"     with optional multiplier suffix (powers of 1024)\n"
+"  FILE\n"
+"     measure file size required to convert from FILE (either a file name\n"
+"     or an option string (key=value,..) with --image-options)\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
-        case 'O':
-            out_fmt = optarg;
-            break;
-        case 'o':
-            if (accumulate_options(&options, optarg) < 0) {
-                goto out;
-            }
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
@@ -5841,24 +5869,31 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
                 snapshot_name = optarg;
             }
             break;
-        case 'U':
-            force_share = true;
+        case 'O':
+            out_fmt = optarg;
             break;
-        case OPTION_OBJECT:
-            user_creatable_process_cmdline(optarg);
+        case 'o':
+            if (accumulate_options(&options, optarg) < 0) {
+                goto out;
+            }
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
+        case 'U':
+            force_share = true;
             break;
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
-        case OPTION_SIZE:
+        case OPTION_OBJECT:
+            user_creatable_process_cmdline(optarg);
+            break;
+        case 's':
             img_size = cvtnum("image size", optarg);
             if (img_size < 0) {
                 goto out;
             }
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


