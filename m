Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088B1C5AE59
	for <qemu-devel@archiver.kernel.org>; Sat, 31 May 2025 17:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLPpI-0001H8-4m; Sat, 31 May 2025 13:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPoo-00018a-14; Sat, 31 May 2025 13:16:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uLPok-00012M-Bw; Sat, 31 May 2025 13:16:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF6C8126B35;
 Sat, 31 May 2025 20:16:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B730A21BA38;
 Sat, 31 May 2025 20:16:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 05/27] qemu-img: create: refresh options/--help (short option
 change)
Date: Sat, 31 May 2025 20:15:47 +0300
Message-Id: <20250531171609.197078-6-mjt@tls.msk.ru>
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

Create helper function cmd_help() to display command-specific
help text, and use it to print --help for 'create' subcommand.

Add missing long options (eg --format) in img_create().

Recognize -B option for --backing-format, keep -F for
backward compatibility,

Reorder options for consistency.

Remove usage of missing_argument()/unrecognized_option() in
img_create().

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 docs/tools/qemu-img.rst | 10 ++---
 qemu-img.c              | 84 +++++++++++++++++++++++++++++++++--------
 2 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 3653adb963..a21e439082 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -467,11 +467,11 @@ Command description:
   ``--skip-broken-bitmaps`` is also specified to copy only the
   consistent bitmaps.
 
-.. option:: create [--object OBJECTDEF] [-q] [-f FMT] [-b BACKING_FILE [-F BACKING_FMT]] [-u] [-o OPTIONS] FILENAME [SIZE]
+.. option:: create [-f FMT] [-o FMT_OPTS] [-b BACKING_FILE [-B BACKING_FMT]] [-u] [-q] [--object OBJDEF] FILE [SIZE]
 
-  Create the new disk image *FILENAME* of size *SIZE* and format
-  *FMT*. Depending on the file format, you can add one or more *OPTIONS*
-  that enable additional features of this format.
+  Create the new disk image *FILE* of size *SIZE* and format
+  *FMT*. Depending on the file format, you can add one or more *FMT_OPTS*
+  options that enable additional features of this format.
 
   If the option *BACKING_FILE* is specified, then the image will record
   only the differences from *BACKING_FILE*. No size needs to be specified in
@@ -479,7 +479,7 @@ Command description:
   ``commit`` monitor command (or ``qemu-img commit``).
 
   If a relative path name is given, the backing file is looked up relative to
-  the directory containing *FILENAME*.
+  the directory containing *FILE*.
 
   Note that a given backing file will be opened to check that it is valid. Use
   the ``-u`` option to enable unsafe backing file mode, which means that the
diff --git a/qemu-img.c b/qemu-img.c
index 7e3350bb38..cfc69e2503 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -132,6 +132,32 @@ void unrecognized_option(const char *option)
     error_exit("qemu-img", "unrecognized option '%s'", option);
 }
 
+/*
+ * Print --help output for a command and exit.
+ * @syntax and @description are multi-line with trailing EOL
+ * (to allow easy extending of the text)
+ * @syntax has each subsequent line indented by 8 chars.
+ * @description is indented by 2 chars for argument on each own line,
+ * and with 5 chars for argument description (like -h arg below).
+ */
+static G_NORETURN
+void cmd_help(const img_cmd_t *ccmd,
+              const char *syntax, const char *arguments)
+{
+    printf(
+"Usage:\n"
+"\n"
+"  %s %s %s"
+"\n"
+"Arguments:\n"
+"  -h, --help\n"
+"     print this help and exit\n"
+"%s\n",
+           "qemu-img", ccmd->name,
+           syntax, arguments);
+    exit(EXIT_SUCCESS);
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -530,29 +556,46 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"format", required_argument, 0, 'f'},
+            {"options", required_argument, 0, 'o'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'B'}, /* was -F in 10.0 */
+            {"backing-unsafe", no_argument, 0, 'u'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":F:b:f:ho:qu",
+        c = getopt_long(argc, argv, "hf:o:b:F:B:uq",
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
-        case 'F':
-            base_fmt = optarg;
-            break;
-        case 'b':
-            base_filename = optarg;
+            cmd_help(ccmd, "[-f FMT] [-o FMT_OPTS]\n"
+"        [-b BACKING_FILE [-B BACKING_FMT]] [-u]\n"
+"        [-q] [--object OBJDEF] FILE [SIZE]\n"
+,
+"  -f, --format FMT\n"
+"     specifies the format of the new image (default: raw)\n"
+"  -o, --options FMT_OPTS\n"
+"     format-specific options (specify '-o help' for help)\n"
+"  -b, --backing BACKING_FILE\n"
+"     create target image to be a CoW on top of BACKING_FILE\n"
+"  -B, --backing-format BACKING_FMT (was -F in <= 10.0)\n"
+"     specifies the format of BACKING_FILE (default: probing is used)\n"
+"  -u, --backing-unsafe\n"
+"     do not fail if BACKING_FILE can not be read\n"
+"  -q, --quiet\n"
+"     quiet mode (produce only error messages if any)\n"
+"  --object OBJDEF\n"
+"     defines QEMU user-creatable object\n"
+"  FILE\n"
+"     name of the image file to create (will be overritten if already exists)\n"
+"  SIZE[bKMGTPE]\n"
+"     image size with optional multiplier suffix (powers of 1024)\n"
+"     (required unless BACKING_FILE is specified)\n"
+);
             break;
         case 'f':
             fmt = optarg;
@@ -562,15 +605,24 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
                 goto fail;
             }
             break;
-        case 'q':
-            quiet = true;
+        case 'b':
+            base_filename = optarg;
+            break;
+        case 'F': /* <=10.0 */
+        case 'B':
+            base_fmt = optarg;
             break;
         case 'u':
             flags |= BDRV_O_NO_BACKING;
             break;
+        case 'q':
+            quiet = true;
+            break;
         case OPTION_OBJECT:
             user_creatable_process_cmdline(optarg);
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.39.5


