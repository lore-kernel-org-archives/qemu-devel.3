Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B119CEBF78
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4Ck-00058e-Cu; Fri, 27 Sep 2024 02:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4Cg-0004sa-ME; Fri, 27 Sep 2024 02:11:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4Ce-0003Gx-SE; Fri, 27 Sep 2024 02:11:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 971D592D1A;
 Fri, 27 Sep 2024 09:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1290714670C;
 Fri, 27 Sep 2024 09:11:22 +0300 (MSK)
Received: (nullmailer pid 573365 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 09/27] qemu-img: commit: refresh options/--help
Date: Fri, 27 Sep 2024 09:11:03 +0300
Message-Id: <20240927061121.573271-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240927061121.573271-1-mjt@tls.msk.ru>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Add missing long options and --help output.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9157a6b45d..7a111bce72 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1048,24 +1048,50 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 't'},
+            {"drop", no_argument, 0, 'd'},
+            {"base", required_argument, 0, 'b'},
+            {"progress", no_argument, 0, 'p'},
+            {"rate", required_argument, 0, 'r'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:ht:b:dpqr:",
+        c = getopt_long(argc, argv, "f:ht:b:dpqr:",
                         long_options, NULL);
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
+"[-f FMT | --image-opts] [-t CACHE_MODE] [-b BASE_IMG] [-d]\n"
+"        [-r RATE] [--object OBJDEF] FILENAME\n"
+,
+"  -q, --quiet\n"
+"     quiet operations\n"
+"  -p, --progress\n"
+"     show operation progress\n"
+"  -f, --format FMT\n"
+"     specify FILENAME image format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAME is a complete image specification\n"
+"     instead of a file name (incompatible with --format)\n"
+"  -t, --cache CACHE_MODE image cache mode (" BDRV_DEFAULT_CACHE ")\n"
+"  -d, --drop\n"
+"     skip emptying FILENAME on completion\n"
+"  -b, --base BASE_IMG\n"
+"     image in the backing chain to which to commit changes\n"
+"     instead of the previous one (implies --drop)\n"
+"  -r, --rate RATE\n"
+"     I/O rate limit\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  FILENAME\n"
+"     name of the image file to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -1099,6 +1125,8 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


