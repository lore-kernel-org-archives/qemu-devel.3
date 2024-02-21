Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42348C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctyS-0003l0-TV; Wed, 21 Feb 2024 16:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctyQ-0003Wf-8o; Wed, 21 Feb 2024 16:17:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctyO-0000zP-71; Wed, 21 Feb 2024 16:17:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0A55A4F7FB;
 Thu, 22 Feb 2024 00:16:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AA8EA869B3;
 Thu, 22 Feb 2024 00:16:23 +0300 (MSK)
Received: (nullmailer pid 2335301 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 19/28] qemu-img: resize: do not always eat last argument
Date: Thu, 22 Feb 2024 00:16:00 +0300
Message-Id: <20240221211622.2335170-19-mjt@tls.msk.ru>
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

'qemu-img resize --help' does not work, since it wants more
arguments.  Also it -size is only recognized as a very last
argument, but it is common for tools to handle other options
after positional arguments too.

Tell getopt_long() to return non-options together with options,
and process filename and size in the loop, and check if there's
an argument right after filename which looks like -N (number),
and treat it as size (decrement).  This way we can handle --help,
and we can also have options after filename and size, and `--'
will be handled fine too.

The only case which is not handled right is when there's an option
between filename and size, and size is given as decrement, - in
this case -size will be treated as option, not as size.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2a4bff2872..c8b0b68d67 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4296,7 +4296,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret, relative;
-    const char *filename, *fmt, *size;
+    const char *filename = NULL, *fmt = NULL, *size = NULL;
     int64_t n, total_size, current_size;
     bool quiet = false;
     BlockBackend *blk = NULL;
@@ -4319,17 +4319,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
     bool image_opts = false;
     bool shrink = false;
 
-    /* Remove size from argv manually so that negative numbers are not treated
-     * as options by getopt. */
-    if (argc < 3) {
-        error_exit(argv[0], "Not enough arguments");
-        return 1;
-    }
-
-    size = argv[--argc];
-
     /* Parse getopt arguments */
-    fmt = NULL;
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
@@ -4339,7 +4329,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
             {"shrink", no_argument, 0, OPTION_SHRINK},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":f:hq",
+        c = getopt_long(argc, argv, "-:f:hq",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -4377,12 +4367,35 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
         case OPTION_SHRINK:
             shrink = true;
             break;
+        case 1: /* a non-optional argument */
+            if (!filename) {
+                filename = optarg;
+                /* see if we have -size (number) next to filename */
+                if (optind < argc) {
+                    size = argv[optind];
+                    if (size[0] == '-' && size[1] >= '0' && size[1] <= '9') {
+                        ++optind;
+                    } else {
+                        size = NULL;
+                    }
+                }
+            } else if (!size) {
+                size = optarg;
+            } else {
+                error_exit(argv[0], "Extra argument(s) in command line");
+            }
+            break;
         }
     }
-    if (optind != argc - 1) {
+    if (!filename && optind < argc) {
+        filename = argv[optind++];
+    }
+    if (!size && optind < argc) {
+        size = argv[optind++];
+    }
+    if (!filename || !size || optind < argc) {
         error_exit(argv[0], "Expecting image file name and size");
     }
-    filename = argv[optind++];
 
     /* Choose grow, shrink, or absolute resize mode */
     switch (size[0]) {
-- 
2.39.2


