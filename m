Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D51AC5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctz5-0007oc-As; Wed, 21 Feb 2024 16:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctyy-0007Gd-O5; Wed, 21 Feb 2024 16:18:24 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctyv-00017j-Ke; Wed, 21 Feb 2024 16:18:24 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 650364F801;
 Thu, 22 Feb 2024 00:16:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1063D869B9;
 Thu, 22 Feb 2024 00:16:24 +0300 (MSK)
Received: (nullmailer pid 2335319 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 25/28] qemu-img: measure: refresh options/--help
Date: Thu, 22 Feb 2024 00:16:06 +0300
Message-Id: <20240221211622.2335170-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708544927.git.mjt@tls.msk.ru>
References: <cover.1708544927.git.mjt@tls.msk.ru>
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

Add missing long options and --help output.

Also add -s short option for --size (and remove OPTION_SIZE).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 53 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index af7841573c..d72e1f565b 100644
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
@@ -5744,15 +5743,6 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
 
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
@@ -5773,12 +5763,47 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     int ret = 1;
     int c;
 
+    static const struct option long_options[] = {
+        {"help", no_argument, 0, 'h'},
+        {"target-format", required_argument, 0, 'O'},
+        {"format", required_argument, 0, 'f'},
+        {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+        {"options", required_argument, 0, 'o'},
+        {"snapshot", required_argument, 0, 'l'},
+        {"object", required_argument, 0, OPTION_OBJECT},
+        {"output", required_argument, 0, OPTION_OUTPUT},
+        {"size", required_argument, 0, 's'},
+        {"force-share", no_argument, 0, 'U'},
+        {0, 0, 0, 0}
+    };
+
     while ((c = getopt_long(argc, argv, "hf:O:o:l:U",
                             long_options, NULL)) != -1) {
         switch (c) {
-        case '?':
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT|--image-opts] [-o OPTIONS] [-O OUTPUT_FMT]\n"
+"       [--output OFMT] [--object OBJDEF] [-l SNAPSHOT_PARAM]\n"
+"       (--size SIZE | FILENAME)\n"
+,
+"  -O, --target-format FMT\n"
+"     desired target/output image format (default raw)\n"
+"  -s, --size SIZE\n"
+"     measure file size for given image size\n"
+"  FILENAME\n"
+"     measure file size required to convert from FILENAME\n"
+"  -f, --format\n"
+"     specify format of FILENAME explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -l, --snapshot SNAPSHOT\n"
+"     use this snapshot in FILENAME as source\n"
+"  --output human|json\n"
+"     output format\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -5816,12 +5841,14 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
-        case OPTION_SIZE:
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
2.39.2


