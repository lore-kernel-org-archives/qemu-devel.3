Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44287C5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:20:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPpK-0001J3-5W; Sat, 31 May 2025 13:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPor-00019M-MV; Sat, 31 May 2025 13:16:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPop-000138-Ei; Sat, 31 May 2025 13:16:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F0932126B37;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C935721BA3A;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 07/27] qemu-img: check: refresh options/--help
Date: Sat, 31 May 2025 20:15:49 +0300
Message-Id: <20250531171609.197078-8-mjt@tls.msk.ru>
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 60 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a26498a4e8..2129158c13 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -805,31 +805,57 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
             {"format", required_argument, 0, 'f'},
+            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
+            {"cache", required_argument, 0, 'T'},
             {"repair", required_argument, 0, 'r'},
+            {"force-share", no_argument, 0, 'U'},
             {"output", required_argument, 0, OPTION_OUTPUT},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
-            {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
-            {"force-share", no_argument, 0, 'U'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:r:T:qU",
+        c = getopt_long(argc, argv, "hf:T:r:Uq",
                         long_options, &option_index);
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
+            cmd_help(ccmd, "[-f FMT | --image-opts] [-T CACHE_MODE] [-r leaks|all]\n"
+"        [-U] [--output human|json] [-q] [--object OBJDEF] FILE\n"
+,
+"  -f, --format FMT\n"
+"     specifies the format of the image explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,..), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  -T, --cache CACHE_MODE\n" /* why not -t ? */
+"     cache mode (default: " BDRV_DEFAULT_CACHE ")\n"
+"  -r, --repair leaks|all\n"
+"     repair errors of the given category in the image (image will be\n"
+"     opened in read-write mode, incompatible with -U|--force-share)\n"
+"  -U, --force-share\n"
+"     open image in shared mode for concurrent access\n"
+"  --output human|json\n"
+"     output format (default: human)\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or an option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+);
             break;
         case 'f':
             fmt = optarg;
             break;
+        case OPTION_IMAGE_OPTS:
+            image_opts = true;
+            break;
+        case 'T':
+            cache = optarg;
+            break;
         case 'r':
             flags |= BDRV_O_RDWR;
 
@@ -842,24 +868,20 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
                            "(expecting 'leaks' or 'all'): %s", optarg);
             }
             break;
+        case 'U':
+            force_share = true;
+            break;
         case OPTION_OUTPUT:
             output_format = parse_output_format(argv[0], optarg);
             break;
-        case 'T':
-            cache = optarg;
-            break;
         case 'q':
             quiet = true;
             break;
-        case 'U':
-            force_share = true;
-            break;
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
-        case OPTION_IMAGE_OPTS:
-            image_opts = true;
-            break;
+        default:
+            tryhelp(argv[0]);
         }
     }
     if (optind != argc - 1) {
-- 
2.39.5


