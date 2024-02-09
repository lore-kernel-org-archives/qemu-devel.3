Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0881C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYKl-0006bg-2m; Fri, 09 Feb 2024 16:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKj-0006ap-AX; Fri, 09 Feb 2024 16:22:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rYYKg-00005r-PR; Fri, 09 Feb 2024 16:22:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A69C4BF59;
 Sat, 10 Feb 2024 00:24:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4605577ED3;
 Sat, 10 Feb 2024 00:22:47 +0300 (MSK)
Received: (nullmailer pid 1123142 invoked by uid 1000);
 Fri, 09 Feb 2024 21:22:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 01/23] qemu-img: pass current cmd info into command handlers
Date: Sat, 10 Feb 2024 00:22:22 +0300
Message-Id: <8127d97c2403720d23d241f5bffa8de8ebc3e04d.1707513011.git.mjt@tls.msk.ru>
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

In order to be able to give correct --help output, pass current cmd
information (img_cmd_t structure) to command handlers and to common
error reporting functions. After the change, in case of command-line
error, qemu-img will now print:

 Try 'qemu-img create --help' for more information.

Current cmd info will be useful in --help output as well.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 150 ++++++++++++++++++++++++++---------------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769..05f80b6e5b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -60,7 +60,7 @@
 
 typedef struct img_cmd_t {
     const char *name;
-    int (*handler)(int argc, char **argv);
+    int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
 } img_cmd_t;
 
 enum {
@@ -101,8 +101,8 @@ static void format_print(void *opaque, const char *name)
     printf(" %s", name);
 }
 
-static G_NORETURN G_GNUC_PRINTF(1, 2)
-void error_exit(const char *fmt, ...)
+static G_NORETURN G_GNUC_PRINTF(2, 3)
+void error_exit(const img_cmd_t *ccmd, const char *fmt, ...)
 {
     va_list ap;
 
@@ -110,20 +110,20 @@ void error_exit(const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 
-    error_printf("Try 'qemu-img --help' for more information\n");
+    error_printf("Try 'qemu-img %s --help' for more information\n", ccmd ? ccmd->name : "");
     exit(EXIT_FAILURE);
 }
 
 static G_NORETURN
-void missing_argument(const char *option)
+void missing_argument(const img_cmd_t *ccmd, const char *option)
 {
-    error_exit("missing argument for option '%s'", option);
+    error_exit(ccmd, "missing argument for option '%s'", option);
 }
 
 static G_NORETURN
-void unrecognized_option(const char *option)
+void unrecognized_option(const img_cmd_t *ccmd, const char *option)
 {
-    error_exit("unrecognized option '%s'", option);
+    error_exit(ccmd, "unrecognized option '%s'", option);
 }
 
 /* Please keep in synch with docs/tools/qemu-img.rst */
@@ -508,7 +508,7 @@ static int64_t cvtnum(const char *name, const char *value)
     return cvtnum_full(name, value, 0, INT64_MAX);
 }
 
-static int img_create(int argc, char **argv)
+static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     uint64_t img_size = -1;
@@ -534,10 +534,10 @@ static int img_create(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -576,7 +576,7 @@ static int img_create(int argc, char **argv)
     }
 
     if (optind >= argc) {
-        error_exit("Expecting image file name");
+        error_exit(ccmd, "Expecting image file name");
     }
     optind++;
 
@@ -591,7 +591,7 @@ static int img_create(int argc, char **argv)
         img_size = (uint64_t)sval;
     }
     if (optind != argc) {
-        error_exit("Unexpected argument: %s", argv[optind]);
+        error_exit(ccmd, "Unexpected argument: %s", argv[optind]);
     }
 
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
@@ -716,7 +716,7 @@ static int collect_image_check(BlockDriverState *bs,
  *  3 - Check completed, image has leaked clusters, but is good otherwise
  * 63 - Checks are not supported by the image format
  */
-static int img_check(int argc, char **argv)
+static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -754,10 +754,10 @@ static int img_check(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -773,7 +773,7 @@ static int img_check(int argc, char **argv)
             } else if (!strcmp(optarg, "all")) {
                 fix = BDRV_FIX_LEAKS | BDRV_FIX_ERRORS;
             } else {
-                error_exit("Unknown option value for -r "
+                error_exit(ccmd, "Unknown option value for -r "
                            "(expecting 'leaks' or 'all'): %s", optarg);
             }
             break;
@@ -798,7 +798,7 @@ static int img_check(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -948,7 +948,7 @@ static void run_block_job(BlockJob *job, Error **errp)
     }
 }
 
-static int img_commit(int argc, char **argv)
+static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret, flags;
     const char *filename, *fmt, *cache, *base;
@@ -979,10 +979,10 @@ static int img_commit(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -1028,7 +1028,7 @@ static int img_commit(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -1355,7 +1355,7 @@ static int check_empty_sectors(BlockBackend *blk, int64_t offset,
  * 1 - Images differ
  * >1 - Error occurred
  */
-static int img_compare(int argc, char **argv)
+static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
 {
     const char *fmt1 = NULL, *fmt2 = NULL, *cache, *filename1, *filename2;
     BlockBackend *blk1, *blk2;
@@ -1392,10 +1392,10 @@ static int img_compare(int argc, char **argv)
         }
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -1449,7 +1449,7 @@ static int img_compare(int argc, char **argv)
 
 
     if (optind != argc - 2) {
-        error_exit("Expecting two image file names");
+        error_exit(ccmd, "Expecting two image file names");
     }
     filename1 = argv[optind++];
     filename2 = argv[optind++];
@@ -2231,7 +2231,7 @@ static void set_rate_limit(BlockBackend *blk, int64_t rate_limit)
     blk_set_io_limits(blk, &cfg);
 }
 
-static int img_convert(int argc, char **argv)
+static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = BDRV_O_NO_SHARE;
     const char *fmt = NULL, *out_fmt = NULL, *cache = "unsafe",
@@ -2284,10 +2284,10 @@ static int img_convert(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -2999,7 +2999,7 @@ err:
     return NULL;
 }
 
-static int img_info(int argc, char **argv)
+static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3030,10 +3030,10 @@ static int img_info(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3059,7 +3059,7 @@ static int img_info(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -3224,7 +3224,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     return true;
 }
 
-static int img_map(int argc, char **argv)
+static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3261,10 +3261,10 @@ static int img_map(int argc, char **argv)
         }
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3299,7 +3299,7 @@ static int img_map(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     filename = argv[optind];
 
@@ -3373,7 +3373,7 @@ out:
 #define SNAPSHOT_APPLY  3
 #define SNAPSHOT_DELETE 4
 
-static int img_snapshot(int argc, char **argv)
+static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -3404,17 +3404,17 @@ static int img_snapshot(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
             return 0;
         case 'l':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(ccmd, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_LIST;
@@ -3422,7 +3422,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'a':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(ccmd, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_APPLY;
@@ -3430,7 +3430,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'c':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(ccmd, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_CREATE;
@@ -3438,7 +3438,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'd':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(ccmd, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_DELETE;
@@ -3460,7 +3460,7 @@ static int img_snapshot(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -3531,7 +3531,7 @@ static int img_snapshot(int argc, char **argv)
     return 0;
 }
 
-static int img_rebase(int argc, char **argv)
+static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
 {
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
@@ -3575,10 +3575,10 @@ static int img_rebase(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3627,10 +3627,10 @@ static int img_rebase(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     if (!unsafe && !out_baseimg) {
-        error_exit("Must specify backing file (-b) or use unsafe mode (-u)");
+        error_exit(ccmd, "Must specify backing file (-b) or use unsafe mode (-u)");
     }
     filename = argv[optind++];
 
@@ -4024,7 +4024,7 @@ out:
     return 0;
 }
 
-static int img_resize(int argc, char **argv)
+static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret, relative;
@@ -4054,7 +4054,7 @@ static int img_resize(int argc, char **argv)
     /* Remove size from argv manually so that negative numbers are not treated
      * as options by getopt. */
     if (argc < 3) {
-        error_exit("Not enough arguments");
+        error_exit(ccmd, "Not enough arguments");
         return 1;
     }
 
@@ -4078,10 +4078,10 @@ static int img_resize(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -4112,7 +4112,7 @@ static int img_resize(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting image file name and size");
+        error_exit(ccmd, "Expecting image file name and size");
     }
     filename = argv[optind++];
 
@@ -4237,7 +4237,7 @@ static int print_amend_option_help(const char *format)
     return 0;
 }
 
-static int img_amend(int argc, char **argv)
+static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 0;
@@ -4270,10 +4270,10 @@ static int img_amend(int argc, char **argv)
 
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -4309,7 +4309,7 @@ static int img_amend(int argc, char **argv)
     }
 
     if (!options) {
-        error_exit("Must specify options (-o)");
+        error_exit(ccmd, "Must specify options (-o)");
     }
 
     if (quiet) {
@@ -4501,7 +4501,7 @@ static void bench_cb(void *opaque, int ret)
     }
 }
 
-static int img_bench(int argc, char **argv)
+static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret = 0;
     const char *fmt = NULL, *filename;
@@ -4544,10 +4544,10 @@ static int img_bench(int argc, char **argv)
 
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -4671,7 +4671,7 @@ static int img_bench(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(ccmd, "Expecting one image file name");
     }
     filename = argv[argc - 1];
 
@@ -4771,7 +4771,7 @@ typedef struct ImgBitmapAction {
     QSIMPLEQ_ENTRY(ImgBitmapAction) next;
 } ImgBitmapAction;
 
-static int img_bitmap(int argc, char **argv)
+static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 1;
@@ -4813,10 +4813,10 @@ static int img_bitmap(int argc, char **argv)
 
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -5071,7 +5071,7 @@ static int img_dd_skip(const char *arg,
     return 0;
 }
 
-static int img_dd(int argc, char **argv)
+static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int ret = 0;
     char *arg = NULL;
@@ -5133,10 +5133,10 @@ static int img_dd(int argc, char **argv)
             fmt = optarg;
             break;
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(ccmd, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(ccmd, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -5339,7 +5339,7 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
     g_string_free(str, true);
 }
 
-static int img_measure(int argc, char **argv)
+static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 {
     static const struct option long_options[] = {
         {"help", no_argument, 0, 'h'},
@@ -5567,7 +5567,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
     bdrv_init();
     if (argc < 2) {
-        error_exit("Not enough arguments");
+        error_exit(NULL, "Not enough arguments");
     }
 
     qemu_add_opts(&qemu_source_opts);
@@ -5576,10 +5576,10 @@ int main(int argc, char **argv)
     while ((c = getopt_long(argc, argv, "+:hVT:", long_options, NULL)) != -1) {
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(NULL, argv[optind - 1]);
             return 0;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(NULL, argv[optind - 1]);
             return 0;
         case 'h':
             help();
@@ -5612,10 +5612,10 @@ int main(int argc, char **argv)
     /* find the command */
     for (cmd = img_cmds; cmd->name != NULL; cmd++) {
         if (!strcmp(cmdname, cmd->name)) {
-            return cmd->handler(argc, argv);
+            return cmd->handler(cmd, argc, argv);
         }
     }
 
     /* not found */
-    error_exit("Command not found: %s", cmdname);
+    error_exit(NULL, "Command not found: %s", cmdname);
 }
-- 
2.39.2


