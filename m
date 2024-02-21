Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3763FC5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcty0-0002vV-E5; Wed, 21 Feb 2024 16:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxi-0002eb-RR; Wed, 21 Feb 2024 16:17:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctxU-0000oM-3N; Wed, 21 Feb 2024 16:17:06 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 862D84F7F2;
 Thu, 22 Feb 2024 00:16:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3E9BD869AB;
 Thu, 22 Feb 2024 00:16:23 +0300 (MSK)
Received: (nullmailer pid 2335277 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 11/28] qemu-img: compare: refresh options/--help
Date: Thu, 22 Feb 2024 00:15:52 +0300
Message-Id: <20240221211622.2335170-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708544927.git.mjt@tls.msk.ru>
References: <cover.1708544927.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 1271217272..fd61b25ea7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1487,25 +1487,52 @@ static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
     for (;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"cache", required_argument, 0, 'T'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"a-format", required_argument, 0, 'f'},
+            {"left-format", required_argument, 0, 'f'},
+            {"b-format", required_argument, 0, 'F'},
+            {"right-format", required_argument, 0, 'F'},
             {"force-share", no_argument, 0, 'U'},
+            {"strict", no_argument, 0, 's'},
+            {"progress", no_argument, 0, 'p'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:T:pqsU",
+        c = getopt_long(argc, argv, "hf:F:T:pqsU",
                         long_options, NULL);
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
+"[--image-opts | [-f FMT] [-F FMT]] [-s]\n"
+"        [-T CACHE] [-U] [--object OBJDEF] FILENAME1 FILENAME2\n"
+,
+"  -q, --quiet\n"
+"     quiet operation\n"
+"  -p, --progress\n"
+"     show operation progress\n"
+"  -f, --a-format FMT\n"
+"     specify FILENAME1 image format explicitly\n"
+"  -F, --b-format FMT\n"
+"     specify FILENAME2 image format explicitly\n"
+"  --image-opts\n"
+"     indicates that FILENAMEs are complete image specifications\n"
+"     instead of file names (incompatible with --a-format and --b-format)\n"
+"  -s, --strict\n"
+"     strict mode, also check if sizes are equal\n"
+"  -T, --cache CACHE_MODE\n"
+"     images caching mode (" BDRV_DEFAULT_CACHE ")\n"
+"  -U, --force-share\n"
+"     open images in shared mode for concurrent access\n"
+"  --object OBJDEF\n"
+"     QEMU user-creatable object (eg encryption key)\n"
+"  FILENAME1, FILENAME2\n"
+"     image files (or specifications) to compare\n"
+);
             break;
         case 'f':
             fmt1 = optarg;
@@ -1546,6 +1573,8 @@ static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.2


