Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB7CC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYKn-0006cW-8H; Fri, 09 Feb 2024 16:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKl-0006cJ-K8; Fri, 09 Feb 2024 16:22:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKk-00006Y-07; Fri, 09 Feb 2024 16:22:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 676644BF5A;
 Sat, 10 Feb 2024 00:24:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 549BB77ED4;
 Sat, 10 Feb 2024 00:22:47 +0300 (MSK)
Received: (nullmailer pid 1123145 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 02/23] qemu-img: refresh options/--help for "create" subcommand
Date: Sat, 10 Feb 2024 00:22:23 +0300
Message-Id: <43c69e56b65b39da7c9bd878fd9c6fad4f788c1a.1707513011.git.mjt@tls.msk.ru>
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

Add missing long options (eg --format).

Create helper function cmd_help() to display command-specific
help text, and use it to print --help for 'create' subcommand.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 05f80b6e5b..7edfc56572 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -126,6 +126,25 @@ void unrecognized_option(const img_cmd_t *ccmd, const char *option)
     error_exit(ccmd, "unrecognized option '%s'", option);
 }
 
+/*
+ * Print --help output for a command and exit.
+ * syntax and description are multi-line with trailing EOL
+ * (to allow easy extending of the text)
+ * syntax has each subsequent line starting with \t
+ * desrciption is indented by one char
+ */
+static G_NORETURN
+void cmd_help(const img_cmd_t *ccmd,
+              const char *syntax, const char *arguments)
+{
+    printf("qemu-img %s %s"
+           "Arguments:\n"
+           " -h|--help - print this help and exit\n"
+           "%s",
+           ccmd->name, syntax, arguments);
+    exit(EXIT_SUCCESS);
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -524,7 +543,13 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
     for(;;) {
         static const struct option long_options[] = {
             {"help", no_argument, 0, 'h'},
+            {"quiet", no_argument, 0, 'q'},
             {"object", required_argument, 0, OPTION_OBJECT},
+            {"format", required_argument, 0, 'f'},
+            {"backing", required_argument, 0, 'b'},
+            {"backing-format", required_argument, 0, 'F'},
+            {"backing-unsafe", no_argument, 0, 'u'},
+            {"options", required_argument, 0, 'o'},
             {0, 0, 0, 0}
         };
         c = getopt_long(argc, argv, ":F:b:f:ho:qu",
@@ -540,7 +565,25 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
             unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(ccmd,
+"[-f FMT] [-o FMT_OPTS] [-b BACKING_FILENAME [-F BACKING_FMT]]\n"
+"	[--object OBJDEF] [-u] FILENAME [SIZE[bkKMGTPE]]\n"
+,
+" -q|--quiet - quiet operations\n"
+" -f|--format FMT - specifies format of the new image, default is raw\n"
+" -o|--options FMT_OPTS - format-specific options ('-o list' for list)\n"
+" -b|--backing BACKING_FILENAME - stack new image on top of BACKING_FILENAME\n"
+"  (for formats which support stacking)\n"
+" -F|--backing-format BACKING_FMT - specify format of BACKING_FILENAME\n"
+" -u|--backing-unsafe - do not fail if BACKING_FMT can not be read\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILENAME - image file to create.  It will be overriden if exists\n"
+" SIZE - image size with optional suffix: 'b' (byte, default), 'k' or\n"
+"  'K' (kilobyte, 1024b), 'M' (megabyte, 1024K), 'G' (gigabyte, 1024M),\n"
+"  'T' (terabyte, 1024G), 'P' (petabyte, 1024T), or 'E' (exabyte, 1024P)\n"
+"  SIZE is required unless BACKING_IMG is specified, in which case\n"
+"  it will be the same as size of BACKING_IMG\n"
+);
             break;
         case 'F':
             base_fmt = optarg;
-- 
2.39.2


