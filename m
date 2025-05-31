Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875E8C5B552
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPrJ-0004RN-Ag; Sat, 31 May 2025 13:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpz-00023O-H5; Sat, 31 May 2025 13:17:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPpw-00017p-Om; Sat, 31 May 2025 13:17:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 83897126B44;
 Sat, 31 May 2025 20:16:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5CC6921BA47;
 Sat, 31 May 2025 20:16:10 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 20/27] qemu-img: resize: refresh options/--help
Date: Sat, 31 May 2025 20:16:02 +0300
Message-Id: <20250531171609.197078-21-mjt@tls.msk.ru>
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
 qemu-img.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index f655c301af..3dbfce527b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4324,36 +4324,48 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
-            {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"preallocation", required_argument, 0, OPTION_PREALLOCATION},
             {"shrink", no_argument, 0, OPTION_SHRINK},
+            {"quiet", no_argument, 0, 'q'},
+            {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "-:f:hq",
+        c = getopt_long(argc, argv, "-hf:q",
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
-            break;
+            cmd_help(ccmd, "[-f FMT | --image-opts] [--preallocation PREALLOC] [--shrink]\n"
+"        [-q] [--object OBJDEF] FILE [+-]SIZE[bkKMGTPE]\n"
+,
+"  -f, --format FMT\n"
+"     specify FILE format explicitly (default: probing is used)\n"
+"  --image-opts\n"
+"     treat FILE as an option string (key=value,...), not a file name\n"
+"     (incompatible with -f|--format)\n"
+"  --shrink\n"
+"     allow operation when the new size is smaller than the original\n"
+"  --preallocation PREALLOC\n"
+"     specify FMT-specific preallocation type for the new areas\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file, or option string (key=value,..)\n"
+"     with --image-opts, to operate on\n"
+"  [+-]SIZE[bkKMGTPE]\n"
+"     new image size or amount by which to shrink (-)/grow (+),\n"
+"     with optional multiplier suffix (powers of 1024, default is bytes)\n"
+);
+            return 0;
         case 'f':
             fmt = optarg;
             break;
-        case 'q':
-            quiet = true;
-            break;
-        case OPTION_OBJECT:
-            user_creatable_process_cmdline(optarg);
-            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4368,6 +4380,12 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_SHRINK:
             shrink = true;
             break;
+        case 'q':
+            quiet = true;
+            break;
+        case OPTION_OBJECT:
+            user_creatable_process_cmdline(optarg);
+            break;
         case 1: /* a non-optional argument */
             if (!filename) {
                 filename = optarg;
@@ -4386,6 +4404,8 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
                 error_exit(argv[0], "Extra argument(s) in command line");
             }
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
     if (!filename && optind < argc) {
-- 
2.39.5


