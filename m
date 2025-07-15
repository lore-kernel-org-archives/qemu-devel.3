Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C309AC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublVL-0006Ea-EN; Tue, 15 Jul 2025 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyE-0004hB-1N
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyB-0001nL-4M
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KvYy9gFRkmSNIVMesqdYxwUoz2shtD4R42Xm+y1sjj4=;
 b=hADy/NE7XpKAXSrpYXoHmCJYS7hMfycek+QpWnCNwQAdCFRfcatYXwp+seLypXXyX+eaOg
 f0gmr1feVDMTkX3rJqF7cX84AhXM46VzbkLIoUn3aGRbuBNzdJbg4ZCZHu1qXK8frKkBI+
 btXDFyK2S7tDXNcaVWCQA5aQd64Hlrc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-PN7smnLmNsCdHub9Z2_Tug-1; Tue,
 15 Jul 2025 15:05:36 -0400
X-MC-Unique: PN7smnLmNsCdHub9Z2_Tug-1
X-Mimecast-MFC-AGG-ID: PN7smnLmNsCdHub9Z2_Tug_1752606335
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EF3219560BA; Tue, 15 Jul 2025 19:05:35 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B443197702B; Tue, 15 Jul 2025 19:05:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 56/57] qemu-img: implement short --help,
 remove global help() function
Date: Tue, 15 Jul 2025 21:03:29 +0200
Message-ID: <20250715190330.378764-57-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Michael Tokarev <mjt@tls.msk.ru>

now once all individual subcommands has --help support, remove
the large unreadable help() thing and replace it with small
global --help, which refers to individual command --help for
more info.

While at it, also line-wrap list of formats after 75 chars.

Since missing_argument() and unrecognized_option() are now unused,
remove them.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250531171609.197078-27-mjt@tls.msk.ru>
[kwolf: Fixed up style and formatting]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 214 ++++++++++++++++++-----------------------------------
 1 file changed, 73 insertions(+), 141 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a7d9d50250..b34b1390bb 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -61,6 +61,7 @@
 typedef struct img_cmd_t {
     const char *name;
     int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
+    const char *description;
 } img_cmd_t;
 
 enum {
@@ -95,11 +96,6 @@ typedef enum OutputFormat {
 /* Default to cache=writeback as data integrity is not important for qemu-img */
 #define BDRV_DEFAULT_CACHE "writeback"
 
-static void format_print(void *opaque, const char *name)
-{
-    printf(" %s", name);
-}
-
 static G_NORETURN
 void tryhelp(const char *argv0)
 {
@@ -119,18 +115,6 @@ void error_exit(const char *argv0, const char *fmt, ...)
     tryhelp(argv0);
 }
 
-static G_NORETURN
-void missing_argument(const char *option)
-{
-    error_exit("qemu-img", "missing argument for option '%s'", option);
-}
-
-static G_NORETURN
-void unrecognized_option(const char *option)
-{
-    error_exit("qemu-img", "unrecognized option '%s'", option);
-}
-
 /*
  * Print --help output for a command and exit.
  * @syntax and @description are multi-line with trailing EOL
@@ -145,15 +129,14 @@ void cmd_help(const img_cmd_t *ccmd,
 {
     printf(
 "Usage:\n"
-"\n"
-"  %s %s %s"
+"  %s %s %s\n"
+"%s.\n"
 "\n"
 "Arguments:\n"
 "  -h, --help\n"
 "     print this help and exit\n"
 "%s\n",
-           "qemu-img", ccmd->name,
-           syntax, arguments);
+           "qemu-img", ccmd->name, syntax, ccmd->description, arguments);
     exit(EXIT_SUCCESS);
 }
 
@@ -168,114 +151,6 @@ static OutputFormat parse_output_format(const char *argv0, const char *arg)
     }
 }
 
-/* Please keep in synch with docs/tools/qemu-img.rst */
-static G_NORETURN
-void help(void)
-{
-    const char *help_msg =
-           QEMU_IMG_VERSION
-           "usage: qemu-img [standard options] command [command options]\n"
-           "QEMU disk image utility\n"
-           "\n"
-           "    '-h', '--help'       display this help and exit\n"
-           "    '-V', '--version'    output version information and exit\n"
-           "    '-T', '--trace'      [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
-           "                         specify tracing options\n"
-           "\n"
-           "Command syntax:\n"
-#define DEF(option, callback, arg_string)        \
-           "  " arg_string "\n"
-#include "qemu-img-cmds.h"
-#undef DEF
-           "\n"
-           "Command parameters:\n"
-           "  'filename' is a disk image filename\n"
-           "  'objectdef' is a QEMU user creatable object definition. See the qemu(1)\n"
-           "    manual page for a description of the object properties. The most common\n"
-           "    object type is a 'secret', which is used to supply passwords and/or\n"
-           "    encryption keys.\n"
-           "  'fmt' is the disk image format. It is guessed automatically in most cases\n"
-           "  'cache' is the cache mode used to write the output disk image, the valid\n"
-           "    options are: 'none', 'writeback' (default, except for convert), 'writethrough',\n"
-           "    'directsync' and 'unsafe' (default for convert)\n"
-           "  'src_cache' is the cache mode used to read input disk images, the valid\n"
-           "    options are the same as for the 'cache' option\n"
-           "  'size' is the disk image size in bytes. Optional suffixes\n"
-           "    'k' or 'K' (kilobyte, 1024), 'M' (megabyte, 1024k), 'G' (gigabyte, 1024M),\n"
-           "    'T' (terabyte, 1024G), 'P' (petabyte, 1024T) and 'E' (exabyte, 1024P)  are\n"
-           "    supported. 'b' is ignored.\n"
-           "  'output_filename' is the destination disk image filename\n"
-           "  'output_fmt' is the destination format\n"
-           "  'options' is a comma separated list of format specific options in a\n"
-           "    name=value format. Use -o help for an overview of the options supported by\n"
-           "    the used format\n"
-           "  'snapshot_param' is param used for internal snapshot, format\n"
-           "    is 'snapshot.id=[ID],snapshot.name=[NAME]', or\n"
-           "    '[ID_OR_NAME]'\n"
-           "  '-c' indicates that target image must be compressed (qcow format only)\n"
-           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and\n"
-           "       new backing file match exactly. The image doesn't need a working\n"
-           "       backing file before rebasing in this case (useful for renaming the\n"
-           "       backing file). For image creation, allow creating without attempting\n"
-           "       to open the backing file.\n"
-           "  '-h' with or without a command shows this help and lists the supported formats\n"
-           "  '-p' show progress of command (only certain commands)\n"
-           "  '-q' use Quiet mode - do not print any output (except errors)\n"
-           "  '-S' indicates the consecutive number of bytes (defaults to 4k) that must\n"
-           "       contain only zeros for qemu-img to create a sparse image during\n"
-           "       conversion. If the number of bytes is 0, the source will not be scanned for\n"
-           "       unallocated or zero sectors, and the destination image will always be\n"
-           "       fully allocated\n"
-           "  '--output' takes the format in which the output must be done (human or json)\n"
-           "  '-n' skips the target volume creation (useful if the volume is created\n"
-           "       prior to running qemu-img)\n"
-           "\n"
-           "Parameters to bitmap subcommand:\n"
-           "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
-           "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
-           "       or '--merge source'\n"
-           "  '-g granularity' sets the granularity for '--add' actions\n"
-           "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
-           "       bitmaps from an alternative file\n"
-           "\n"
-           "Parameters to check subcommand:\n"
-           "  '-r' tries to repair any inconsistencies that are found during the check.\n"
-           "       '-r leaks' repairs only cluster leaks, whereas '-r all' fixes all\n"
-           "       kinds of errors, with a higher risk of choosing the wrong fix or\n"
-           "       hiding corruption that has already occurred.\n"
-           "\n"
-           "Parameters to convert subcommand:\n"
-           "  '--bitmaps' copies all top-level persistent bitmaps to destination\n"
-           "  '-m' specifies how many coroutines work in parallel during the convert\n"
-           "       process (defaults to 8)\n"
-           "  '-W' allow to write to the target out of order rather than sequential\n"
-           "\n"
-           "Parameters to snapshot subcommand:\n"
-           "  'snapshot' is the name of the snapshot to create, apply or delete\n"
-           "  '-a' applies a snapshot (revert disk to saved state)\n"
-           "  '-c' creates a snapshot\n"
-           "  '-d' deletes a snapshot\n"
-           "  '-l' lists all snapshots in the given image\n"
-           "\n"
-           "Parameters to compare subcommand:\n"
-           "  '-f' first image format\n"
-           "  '-F' second image format\n"
-           "  '-s' run in Strict mode - fail on different image size or sector allocation\n"
-           "\n"
-           "Parameters to dd subcommand:\n"
-           "  'bs=BYTES' read and write up to BYTES bytes at a time "
-           "(default: 512)\n"
-           "  'count=N' copy only N input blocks\n"
-           "  'if=FILE' read from FILE\n"
-           "  'of=FILE' write to FILE\n"
-           "  'skip=N' skip N bs-sized blocks at the start of input\n";
-
-    printf("%s\nSupported formats:", help_msg);
-    bdrv_iterate_format(format_print, NULL, false);
-    printf("\n\n" QEMU_HELP_BOTTOM "\n");
-    exit(EXIT_SUCCESS);
-}
-
 /*
  * Is @list safe for accumulate_options()?
  * It is when multiple of them can be joined together separated by ','.
@@ -5999,13 +5874,49 @@ out:
 }
 
 static const img_cmd_t img_cmds[] = {
-#define DEF(option, callback, arg_string)        \
-    { option, callback },
-#include "qemu-img-cmds.h"
-#undef DEF
+    { "amend", img_amend,
+      "Update format-specific options of the image" },
+    { "bench", img_bench,
+      "Run a simple image benchmark" },
+    { "bitmap", img_bitmap,
+      "Perform modifications of the persistent bitmap in the image" },
+    { "check", img_check,
+      "Check basic image integrity" },
+    { "commit", img_commit,
+      "Commit image to its backing file" },
+    { "compare", img_compare,
+      "Check if two images have the same contents" },
+    { "convert", img_convert,
+      "Copy one or more images to another with optional format conversion" },
+    { "create", img_create,
+      "Create and format a new image file" },
+    { "dd", img_dd,
+      "Copy input to output with optional format conversion" },
+    { "info", img_info,
+      "Display information about the image" },
+    { "map", img_map,
+      "Dump image metadata" },
+    { "measure", img_measure,
+      "Calculate the file size required for a new image" },
+    { "rebase", img_rebase,
+      "Change the backing file of the image" },
+    { "resize", img_resize,
+      "Resize the image" },
+    { "snapshot", img_snapshot,
+      "List or manipulate snapshots in the image" },
     { NULL, NULL, },
 };
 
+static void format_print(void *opaque, const char *name)
+{
+    int *np = opaque;
+    if (*np + strlen(name) > 75) {
+        printf("\n ");
+        *np = 1;
+    }
+    *np += printf(" %s", name);
+}
+
 int main(int argc, char **argv)
 {
     const img_cmd_t *cmd;
@@ -6037,16 +5948,35 @@ int main(int argc, char **argv)
     qemu_add_opts(&qemu_source_opts);
     qemu_add_opts(&qemu_trace_opts);
 
-    while ((c = getopt_long(argc, argv, "+:hVT:", long_options, NULL)) != -1) {
+    while ((c = getopt_long(argc, argv, "+hVT:", long_options, NULL)) != -1) {
         switch (c) {
-        case ':':
-            missing_argument(argv[optind - 1]);
-            return 0;
-        case '?':
-            unrecognized_option(argv[optind - 1]);
-            return 0;
         case 'h':
-            help();
+            printf(
+QEMU_IMG_VERSION
+"QEMU disk image utility.  Usage:\n"
+"\n"
+"  qemu-img [standard options] COMMAND [--help | command options]\n"
+"\n"
+"Standard options:\n"
+"  -h, --help\n"
+"     display this help and exit\n"
+"  -V, --version\n"
+"     display version info and exit\n"
+"  -T,--trace TRACE\n"
+"     specify tracing options:\n"
+"        [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
+"\n"
+"Recognized commands (run qemu-img COMMAND --help for command-specific help):\n\n");
+            for (cmd = img_cmds; cmd->name != NULL; cmd++) {
+                printf("  %s - %s\n", cmd->name, cmd->description);
+            }
+            printf("\nSupported image formats:\n");
+            c = 99; /* force a newline */
+            bdrv_iterate_format(format_print, &c, false);
+            if (c) {
+                printf("\n");
+            }
+            printf("\n" QEMU_HELP_BOTTOM "\n");
             return 0;
         case 'V':
             printf(QEMU_IMG_VERSION);
@@ -6054,6 +5984,8 @@ int main(int argc, char **argv)
         case 'T':
             trace_opt_parse(optarg);
             break;
+        default:
+            tryhelp(argv[0]);
         }
     }
 
-- 
2.50.1


