Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF59CC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYMH-0000la-0x; Fri, 09 Feb 2024 16:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLy-0000Ek-Fm; Fri, 09 Feb 2024 16:24:11 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLx-0000Eu-0c; Fri, 09 Feb 2024 16:24:10 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 70AD94BF6C;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5D86777EE6;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123199 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 20/23] qemu-img: refresh options/--help for "dd" command
Date: Sat, 10 Feb 2024 00:22:41 +0300
Message-Id: <6a731eabb363cc93289ace19eed055f5e06c71cd.1707513011.git.mjt@tls.msk.ru>
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
---
 qemu-img.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9a0cd05d42..db1f80e15d 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5417,6 +5417,8 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
         { "object", required_argument, 0, OPTION_OBJECT},
+        { "format", required_argument, 0, 'f'},
+        { "output-format", required_argument, 0, 'O'},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { "force-share", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
@@ -5427,12 +5429,6 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
             break;
         }
         switch (c) {
-        case 'O':
-            out_fmt = optarg;
-            break;
-        case 'f':
-            fmt = optarg;
-            break;
         case ':':
             missing_argument(ccmd, argv[optind - 1]);
             break;
@@ -5440,7 +5436,26 @@ static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
             unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT|--image-opts] [-O OUTPUT_FMT] [-U]\n"
+" [bs=BLOCK_SIZE] [count=BLOCKS] if=INPUT of=OUTPUT\n"
+,
+" -f|--format FMT - specify format for INPUT explicitly\n"
+" --image-opts - indicates that INPUT is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" -O|--output-format OUTPUT_FMT - format of the OUTPUT (default raw)\n"
+" -U|--force-share - open images in shared mode for concurrent access\n"
+" bs=BLOCK_SIZE - size of I/O block (default 512)\n"
+" count=COUNT - number of blocks to convert (default whole INPUT)\n"
+" if=INPUT - input file name or image specification (with --image-opts)\n"
+" of=OUTPUT - output file name to create\n"
+);
+            break;
+        case 'O':
+            out_fmt = optarg;
+            break;
+        case 'f':
+            fmt = optarg;
             break;
         case 'U':
             force_share = true;
-- 
2.39.2


