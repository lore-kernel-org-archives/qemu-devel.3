Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1716FC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYLR-00075H-U0; Fri, 09 Feb 2024 16:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLQ-0006zM-Fr; Fri, 09 Feb 2024 16:23:36 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLO-0000Cg-SV; Fri, 09 Feb 2024 16:23:36 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2147A4BF66;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0E23677EE0;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123181 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 14/23] qemu-img: refresh options/--help for "rebase" command
Date: Sat, 10 Feb 2024 00:22:35 +0300
Message-Id: <e6aa5783e7eb9ddff1860006c835aa77a4ed4bf3.1707513011.git.mjt@tls.msk.ru>
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

Options added:
 --format, --cache - for the image in question
 --backing, --backing-format, --backing-cache, --backing-unsafe -
   for the new backing file
(was eg CACHE vs SRC_CACHE, which is unclear).

Probably should rename local variables.
---
 qemu-img.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 67e6a7797d..69d41e0a92 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3752,10 +3752,18 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
+            {"progress", no_argument, 0, 'p'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
+            {"format", required_argument, 0, 'f'},
+            {"cache", required_argument, 0, 't'},
             {"compress", no_argument, 0, 'c'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'F'},
+            {"backing-cache", required_argument, 0, 'T'},
+            {"backing-unsafe", no_argument, 0, 'u'},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":hf:F:b:upt:T:qUc",
@@ -3771,7 +3779,27 @@ static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
             unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [-t CACHE] [-q] [-U] [-p]\n"
+"	[-b BACKING_FILENAME [-F BACKING_FMT] [-T BACKING_CACHE]] [-u]\n"
+"	[--object OBJDEF] [-c] FILENAME\n"
+"Rebases FILENAME on top of BACKING_FILENAME or no backing file\n"
+,
+" -q|--quiet - quiet operation\n"
+" -p|--progress - show progress indicator\n"
+" -f|--format FMT - specify FILENAME format explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -t|--cache CACHE - cache mode for FILENAME (" BDRV_DEFAULT_CACHE ")\n"
+" -b|--backing BACKING_FILENAME|\"\" - rebase onto this file (or no backing file)\n"
+" -F|--backing-format BACKING_FMT - specify format for BACKING_FILENAME\n"
+" -T|--backing-cache CACHE - cache mode for BACKING_FILENAME (" BDRV_DEFAULT_CACHE ")\n"
+" -u|--backing-unsafe - do not fail if BACKING_FILENAME can not be read\n"
+" -c|--compress - compress image (when image supports this)\n"
+" -U|--force-share - open image in shared mode for concurrent access\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME - image file name (or specification with --image-opts)\n"
+);
             return 0;
         case 'f':
             fmt = optarg;
-- 
2.39.2


