Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F27C10F16
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYMo-0007Pv-PP; Wed, 24 Apr 2024 04:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYMg-0006Oa-UI; Wed, 24 Apr 2024 04:52:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rzYMe-00048H-PP; Wed, 24 Apr 2024 04:52:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1B9FC6153F;
 Wed, 24 Apr 2024 11:50:44 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 45B2BBE0EF;
 Wed, 24 Apr 2024 11:50:37 +0300 (MSK)
Received: (nullmailer pid 1179645 invoked by uid 1000);
 Wed, 24 Apr 2024 08:50:36 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Subject: [PATCH 22/27] qemu-img: bitmap: refresh options/--help
Date: Wed, 24 Apr 2024 11:50:30 +0300
Message-Id: <3edd9d860c53930eb94dac298c6ac67278092f69.1713948448.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1713948448.git.mjt@tls.msk.ru>
References: <cover.1713948448.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Add missing long options and --help output.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index fff537df26..7c20a5772d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5170,20 +5170,42 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             {"source-format", required_argument, 0, 'F'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":b:f:F:g:h", long_options, NULL);
+        c = getopt_long(argc, argv, "b:f:F:g:h",
+                        long_options, NULL);
         if (c == -1) {
             break;
         }
 
         switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            break;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"( --merge SOURCE | --add | --remove | --clear |\n"
+"                --enable | --disable ).. [-f FMT | --image-opts]\n"
+"        [ -b SRC_FILENAME [-F SOURCE_FMT]] [-g SIZE[KMGTPE]] [--object OBJDEF]\n"
+"        FILENAME BITMAP\n"
+,
+"  -f, --format FMT\n"
+"     specify FILENAME format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  --add\n"
+"     creates BITMAP, enables to record future edits\n"
+"   -g, --granularity SIZE[KMGTPE]\n"
+"     sets non-default bitmap granularity for --add to this size\n"
+"  --remove\n"
+"     removes BITMAP\n"
+"  --clear\n"
+"     clears BITMAP\n"
+"  --enable, --disable\n"
+"     starts and stops recording future edits to BITMAP\n"
+"  --merge SRC_FILENAME\n"
+"     merges contents of SRC_FILENAME bitmap into BITMAP\n"
+"   -b, --source-file SRC_FILENAME\n"
+"     select alternative source file for --merge\n"
+"   -F, --source-format SRC_FMT\n"
+"     specify format for SRC_FILENAME explicitly\n"
+);
             break;
         case 'b':
             src_filename = optarg;
@@ -5239,6 +5261,8 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


