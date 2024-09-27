Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ECBCEBF76
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4Ch-0004wP-SA; Fri, 27 Sep 2024 02:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4CW-0004U6-7w; Fri, 27 Sep 2024 02:11:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1su4CU-0003FU-0M; Fri, 27 Sep 2024 02:11:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4015492D14;
 Fri, 27 Sep 2024 09:10:51 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AE919146706;
 Fri, 27 Sep 2024 09:11:21 +0300 (MSK)
Received: (nullmailer pid 573347 invoked by uid 1000);
 Fri, 27 Sep 2024 06:11:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 03/27] qemu-img: global option processing and error printing
Date: Fri, 27 Sep 2024 09:10:57 +0300
Message-Id: <20240927061121.573271-4-mjt@tls.msk.ru>
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

In order to correctly print executable name in various
error messages, pass argv[0] to error_exit() function.
This way, error messages will refer to actual executable
name, which may be different from 'qemu-img'.

For subcommands, pass original command name from the
qemu-img argv[0], plus the subcommand name, as its own
argv[0] element, so error messages can be more useful.
Also don't require at least 3 options on the command
line: it makes no sense with options before subcommand.

Introduce tryhelp() function which just prints

 try 'command-name --help' for more info

and exits.  When tryhelp() is called from within a subcommand
handler, the message will look like:

 try 'command-name subcommand --help' for more info

qemu-img uses getopt_long() with ':' as the first char in
optstring parameter, which means it doesn't print error
messages but return ':' or '?' instead, and qemu-img uses
unrecognized_option() or missing_argument() function to
print error messages.  But it doesn't quite work:

 $ ./qemu-img -xx
 qemu-img: unrecognized option './qemu-img'

so the aim is to let getopt_long() to print regular error
messages instead (removing ':' prefix from optstring) and
remove handling of '?' and ':' "options" entirely.  With
concatenated argv[0] and the subcommand, it all finally
does the right thing in all cases.  This will be done in
subsequent changes command by command, with main() done
last.

unrecognized_option() and missing_argument() functions
prototypes aren't changed by this patch, since they're
called from many places and will be removed a few patches
later.  Only artifical "qemu-img" argv0 is provided in
there for now.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 80 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index fe22986931..130188e287 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -101,8 +101,15 @@ static void format_print(void *opaque, const char *name)
     printf(" %s", name);
 }
 
-static G_NORETURN G_GNUC_PRINTF(1, 2)
-void error_exit(const char *fmt, ...)
+static G_NORETURN
+void tryhelp(const char *argv0)
+{
+    error_printf("Try '%s --help' for more info\n", argv0);
+    exit(EXIT_FAILURE);
+}
+
+static G_NORETURN G_GNUC_PRINTF(2, 3)
+void error_exit(const char *argv0, const char *fmt, ...)
 {
     va_list ap;
 
@@ -110,20 +117,19 @@ void error_exit(const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 
-    error_printf("Try 'qemu-img --help' for more information\n");
-    exit(EXIT_FAILURE);
+    tryhelp(argv0);
 }
 
 static G_NORETURN
 void missing_argument(const char *option)
 {
-    error_exit("missing argument for option '%s'", option);
+    error_exit("qemu-img", "missing argument for option '%s'", option);
 }
 
 static G_NORETURN
 void unrecognized_option(const char *option)
 {
-    error_exit("unrecognized option '%s'", option);
+    error_exit("qemu-img", "unrecognized option '%s'", option);
 }
 
 /* Please keep in synch with docs/tools/qemu-img.rst */
@@ -576,7 +582,7 @@ static int img_create(int argc, char **argv)
     }
 
     if (optind >= argc) {
-        error_exit("Expecting image file name");
+        error_exit(argv[0], "Expecting image file name");
     }
     optind++;
 
@@ -588,7 +594,7 @@ static int img_create(int argc, char **argv)
         }
     }
     if (optind != argc) {
-        error_exit("Unexpected argument: %s", argv[optind]);
+        error_exit(argv[0], "Unexpected argument: %s", argv[optind]);
     }
 
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
@@ -770,7 +776,7 @@ static int img_check(int argc, char **argv)
             } else if (!strcmp(optarg, "all")) {
                 fix = BDRV_FIX_LEAKS | BDRV_FIX_ERRORS;
             } else {
-                error_exit("Unknown option value for -r "
+                error_exit(argv[0], "Unknown option value for -r "
                            "(expecting 'leaks' or 'all'): %s", optarg);
             }
             break;
@@ -795,7 +801,7 @@ static int img_check(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -1025,7 +1031,7 @@ static int img_commit(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -1446,7 +1452,7 @@ static int img_compare(int argc, char **argv)
 
 
     if (optind != argc - 2) {
-        error_exit("Expecting two image file names");
+        error_exit(argv[0], "Expecting two image file names");
     }
     filename1 = argv[optind++];
     filename2 = argv[optind++];
@@ -3056,7 +3062,7 @@ static int img_info(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -3296,7 +3302,7 @@ static int img_map(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     filename = argv[optind];
 
@@ -3411,7 +3417,7 @@ static int img_snapshot(int argc, char **argv)
             return 0;
         case 'l':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_LIST;
@@ -3419,7 +3425,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'a':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_APPLY;
@@ -3427,7 +3433,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'c':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_CREATE;
@@ -3435,7 +3441,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'd':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(argv[0], "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_DELETE;
@@ -3457,7 +3463,7 @@ static int img_snapshot(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -3624,10 +3630,11 @@ static int img_rebase(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     if (!unsafe && !out_baseimg) {
-        error_exit("Must specify backing file (-b) or use unsafe mode (-u)");
+        error_exit(argv[0],
+                   "Must specify backing file (-b) or use unsafe mode (-u)");
     }
     filename = argv[optind++];
 
@@ -4051,7 +4058,7 @@ static int img_resize(int argc, char **argv)
     /* Remove size from argv manually so that negative numbers are not treated
      * as options by getopt. */
     if (argc < 3) {
-        error_exit("Not enough arguments");
+        error_exit(argv[0], "Not enough arguments");
         return 1;
     }
 
@@ -4109,7 +4116,7 @@ static int img_resize(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting image file name and size");
+        error_exit(argv[0], "Expecting image file name and size");
     }
     filename = argv[optind++];
 
@@ -4306,7 +4313,7 @@ static int img_amend(int argc, char **argv)
     }
 
     if (!options) {
-        error_exit("Must specify options (-o)");
+        error_exit(argv[0], "Must specify options (-o)");
     }
 
     if (quiet) {
@@ -4668,7 +4675,7 @@ static int img_bench(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(argv[0], "Expecting one image file name");
     }
     filename = argv[argc - 1];
 
@@ -5558,9 +5565,6 @@ int main(int argc, char **argv)
 
     module_call_init(MODULE_INIT_QOM);
     bdrv_init();
-    if (argc < 2) {
-        error_exit("Not enough arguments");
-    }
 
     qemu_add_opts(&qemu_source_opts);
     qemu_add_opts(&qemu_trace_opts);
@@ -5585,15 +5589,11 @@ int main(int argc, char **argv)
         }
     }
 
-    cmdname = argv[optind];
-
-    /* reset getopt_long scanning */
-    argc -= optind;
-    if (argc < 1) {
-        return 0;
+    if (optind >= argc) {
+        error_exit(argv[0], "Not enough arguments");
     }
-    argv += optind;
-    qemu_reset_optind();
+
+    cmdname = argv[optind];
 
     if (!trace_init_backends()) {
         exit(1);
@@ -5604,10 +5604,16 @@ int main(int argc, char **argv)
     /* find the command */
     for (cmd = img_cmds; cmd->name != NULL; cmd++) {
         if (!strcmp(cmdname, cmd->name)) {
+            g_autofree char *argv0 = g_strdup_printf("%s %s", argv[0], cmdname);
+            /* reset options and getopt processing (incl return order) */
+            argv += optind;
+            argc -= optind;
+            qemu_reset_optind();
+            argv[0] = argv0;
             return cmd->handler(argc, argv);
         }
     }
 
     /* not found */
-    error_exit("Command not found: %s", cmdname);
+    error_exit(argv[0], "Command not found: %s", cmdname);
 }
-- 
2.39.5


