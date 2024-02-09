Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C99C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYML-0001Iq-Aj; Fri, 09 Feb 2024 16:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYMI-00016T-Vl; Fri, 09 Feb 2024 16:24:31 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYMH-0000F2-C5; Fri, 09 Feb 2024 16:24:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E0D54BF6D;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6AF3277EE7;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123203 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 21/23] qemu-img: refresh options/--help for "measure" command
Date: Sat, 10 Feb 2024 00:22:42 +0300
Message-Id: <a7b00c6b50d7b48ecc07c0a9b485814a5503f67f.1707513012.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707513011.git.mjt@tls.msk.ru>
References: <cover.1707513011.git.mjt@tls.msk.ru>
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
---
 qemu-img.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index db1f80e15d..e2c8855ff5 100644
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
@@ -5657,15 +5656,6 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
 
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
@@ -5686,12 +5676,41 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
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
         case '?':
+            unrecognized_option(ccmd, argv[optind - 1]);
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT|--image-opts] [-o OPTIONS] [-O OUTPUT_FMT]\n"
+"	[--output OFMT] [--object OBJDEF] [-l SNAPSHOT_PARAM]\n"
+"	(--size SIZE | FILENAME)\n"
+,
+" -O|--target-format FMT - desired target/output image format (default raw)\n"
+" -s|--size SIZE - measure file size for given image size\n"
+" FILENAME - measure file size required to convert from FILENAME\n"
+" -f|--format - specify format of FILENAME explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -l|--snapshot SNAPSHOT - use this snapshot in FILENAME as source\n"
+" --output human|json - output format\n"
+" -U|--force-share - open images in shared mode for concurrent access\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -5729,7 +5748,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OUTPUT:
             output_format = parse_output_format(ccmd, optarg);
             break;
-        case OPTION_SIZE:
+        case 's':
         {
             int64_t sval;
 
-- 
2.39.2


