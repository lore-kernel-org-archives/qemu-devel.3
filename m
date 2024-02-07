Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9501DC4829E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmBs-0003VD-3P; Wed, 07 Feb 2024 12:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBm-0003P2-AV; Wed, 07 Feb 2024 12:58:26 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBk-0003zf-Nm; Wed, 07 Feb 2024 12:58:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5E52E4B3D1;
 Wed,  7 Feb 2024 20:59:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8D9DA763A1;
 Wed,  7 Feb 2024 20:58:20 +0300 (MSK)
Received: (nullmailer pid 296922 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 2/8] qemu-img: refresh options/--help for "create" subcommand
Date: Wed,  7 Feb 2024 20:58:11 +0300
Message-Id: <d2812e24544576dafb2aeffad1401981da3d2fa6.1707328606.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1707328606.git.mjt@tls.msk.ru>
References: <cover.1707328606.git.mjt@tls.msk.ru>
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
help text, and use it to print --help for create.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index a634747701..b94622fadb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -126,6 +126,16 @@ void unrecognized_option(const char *cmdname, const char *option)
     error_exit(cmdname, "unrecognized option '%s'", option);
 }
 
+static G_NORETURN
+void cmd_help(const char *cmdname, const char *syntax,
+              const char *description, const char *arguments)
+{
+    printf("qemu-img %s %s\n%s.\n"
+           " -h|--help - print this help and exit\n%s",
+           cmdname, syntax, description, arguments);
+    exit(EXIT_SUCCESS);
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -524,7 +534,13 @@ static int img_create(const char *cmdname, int argc, char **argv)
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
@@ -540,7 +556,22 @@ static int img_create(const char *cmdname, int argc, char **argv)
             unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
-            help();
+            cmd_help(cmdname, "[OPTIONS] FILE [SIZE[bkKMGTPE]]",
+                     "Creates and initializes a new image",
+" -q|--quiet - quiet operations\n"
+" -f|--format FMT - specifies format of the new image, default is raw\n"
+" -o|--options FMT_OPTS - format-specific options ('-o list' for list)\n"
+" -b|--backing BACKING_IMG - stack new image on top of BACKING_IMG\n"
+"  (for formats which support stacking)\n"
+" -F|--backing-format BACKING_FMT - specify format of BACKING_IMG\n"
+" -u|--backing-unsafe - do not fail if BACKING_FMT can not be read\n"
+" --object OBJDEF - QEMU user-creatable object (eg encryption key)\n"
+" FILE - image file to create. FILE will be overriden if exists\n"
+" SIZE - image size with optional suffix: 'b' (byte, default),\n"
+"  'k' or 'K' (kilobyte, *1024), 'M' (megabyte, *1024K), 'G' (gigabyte, *1024M),\n"
+"  'T' (terabyte, *1024G), 'P' (petabyte, *1024T), or 'E' (exabyte, *1024P)\n"
+"  SIZE is required unless BACKING_IMG is specified, in which case\n"
+"  it will be the same as size of BACKING_IMG\n");
             break;
         case 'F':
             base_fmt = optarg;
-- 
2.39.2


