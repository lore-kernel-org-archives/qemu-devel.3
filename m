Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F4CC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYLY-0007Ei-17; Fri, 09 Feb 2024 16:23:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLW-0007EA-9v; Fri, 09 Feb 2024 16:23:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYLU-0000D9-PD; Fri, 09 Feb 2024 16:23:42 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B74F4BF68;
 Sat, 10 Feb 2024 00:24:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 287DC77EE2;
 Sat, 10 Feb 2024 00:22:48 +0300 (MSK)
Received: (nullmailer pid 1123187 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 16/23] qemu-img: refresh options/--help for "resize" command
Date: Sat, 10 Feb 2024 00:22:37 +0300
Message-Id: <4025c554219a66f0b539df7d15bdd1874317cacb.1707513011.git.mjt@tls.msk.ru>
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
 qemu-img.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 929a25a021..e552401074 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4283,7 +4283,9 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"preallocation", required_argument, 0, OPTION_PREALLOCATION},
             {"shrink", no_argument, 0, OPTION_SHRINK},
@@ -4302,8 +4304,21 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
             unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
-            help();
-            break;
+            cmd_help(ccmd,
+"[-f FMT | --image-opts] [--preallocation PREALLOC] [--shrink]\n"
+"	[--object OBJECTDEF] [-q] FILENAME [+|-]SIZE\n"
+,
+" -q|--quiet - quiet operation\n"
+" -f|--format FMT - specify FILENAME format explicitly\n"
+" --image-opts - indicates that FILENAME is a complete image specification\n"
+"  instead of a file name (incompatible with --format)\n"
+" --shrink - allow operation when new size is smaller than original\n"
+" --preallocation PREALLOC - specify preallocation type for the new areas\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME - image file (specification) to resize\n"
+" SIZE - new image size or amount by which to shrink/grow\n"
+);
+            return 0;
         case 'f':
             fmt = optarg;
             break;
-- 
2.39.2


