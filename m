Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70873C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxz-0002uy-Rr; Wed, 21 Feb 2024 16:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxy-0002uH-6O; Wed, 21 Feb 2024 16:17:22 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxu-0000qR-EL; Wed, 21 Feb 2024 16:17:21 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A13E24F7F4;
 Thu, 22 Feb 2024 00:16:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 597F9869AD;
 Thu, 22 Feb 2024 00:16:23 +0300 (MSK)
Received: (nullmailer pid 2335283 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 13/28] qemu-img: info: refresh options/--help
Date: Thu, 22 Feb 2024 00:15:54 +0300
Message-Id: <20240221211622.2335170-13-mjt@tls.msk.ru>
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
Also add -b short option for --backing-chain, and remove
now-unused OPTION_BACKING_CHAIN.

While at it, remove unused option_index variable.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 911cdc159c..cc51da31cf 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -65,7 +65,6 @@ typedef struct img_cmd_t {
 
 enum {
     OPTION_OUTPUT = 256,
-    OPTION_BACKING_CHAIN = 257,
     OPTION_OBJECT = 258,
     OPTION_IMAGE_OPTS = 259,
     OPTION_PATTERN = 260,
@@ -3219,31 +3218,44 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
 
     fmt = NULL;
     for(;;) {
-        int option_index = 0;
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
             {"format", required_argument, 0, 'f'},
             {"output", required_argument, 0, OPTION_OUTPUT},
-            {"backing-chain", no_argument, 0, OPTION_BACKING_CHAIN},
+            {"backing-chain", no_argument, 0, 'b'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hU",
-                        long_options, &option_index);
+        c = getopt_long(argc, argv, "f:hbU",
+                        long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-b] [-U] [--object OBJDEF]\n"
+"        [--output human|json] FILENAME\n"
+,
+"  -f, --format FMT\n"
+"     specify FILENAME image format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -b, --backing-chain\n"
+"     display information about backing chaing\n"
+"  (in case the image is stacked\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  --output human|json\n"
+"     specify output format name (default human)\n"
+"  FILENAME\n"
+"     image file name (or specification with --image-opts)\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -3254,7 +3266,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
-        case OPTION_BACKING_CHAIN:
+        case 'b':
             chain = true;
             break;
         case OPTION_OBJECT:
@@ -3263,6 +3275,8 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
     if (optind != argc - 1) {
-- 
2.39.2


