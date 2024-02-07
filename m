Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F82C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 17:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXmBr-0003Q1-HY; Wed, 07 Feb 2024 12:58:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBl-0003OC-JH; Wed, 07 Feb 2024 12:58:25 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rXmBi-0003z7-M0; Wed, 07 Feb 2024 12:58:25 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 977A04B3D0;
 Wed,  7 Feb 2024 20:59:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 90633763A0;
 Wed,  7 Feb 2024 20:58:19 +0300 (MSK)
Received: (nullmailer pid 296918 invoked by uid 1000);
 Wed, 07 Feb 2024 17:58:19 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 1/8] qemu-img: pass current cmdname into command handlers
Date: Wed,  7 Feb 2024 20:58:10 +0300
Message-Id: <d3da8e9dd7ca61e21f5d4d0225cabf45d398148a.1707328606.git.mjt@tls.msk.ru>
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

In order to be able to give correct --help output, pass current cmdname
to command handlers and to common error reporting functions. After the
change, in case of command-line error, qemu-img will now print:

 Try 'qemu-img create --help' for more information.

Current cmdname will be useful in --help output as well.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 150 ++++++++++++++++++++++++++---------------------------
 1 file changed, 75 insertions(+), 75 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index bcbf51402d..a634747701 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -60,7 +60,7 @@
 
 typedef struct img_cmd_t {
     const char *name;
-    int (*handler)(int argc, char **argv);
+    int (*handler)(const char *cmdname, int argc, char **argv);
 } img_cmd_t;
 
 enum {
@@ -101,8 +101,8 @@ static void format_print(void *opaque, const char *name)
     printf(" %s", name);
 }
 
-static G_NORETURN G_GNUC_PRINTF(1, 2)
-void error_exit(const char *fmt, ...)
+static G_NORETURN G_GNUC_PRINTF(2, 3)
+void error_exit(const char *cmdname, const char *fmt, ...)
 {
     va_list ap;
 
@@ -110,20 +110,20 @@ void error_exit(const char *fmt, ...)
     error_vreport(fmt, ap);
     va_end(ap);
 
-    error_printf("Try 'qemu-img --help' for more information\n");
+    error_printf("Try 'qemu-img %s --help' for more information\n", cmdname ? cmdname : "");
     exit(EXIT_FAILURE);
 }
 
 static G_NORETURN
-void missing_argument(const char *option)
+void missing_argument(const char *cmdname, const char *option)
 {
-    error_exit("missing argument for option '%s'", option);
+    error_exit(cmdname, "missing argument for option '%s'", option);
 }
 
 static G_NORETURN
-void unrecognized_option(const char *option)
+void unrecognized_option(const char *cmdname, const char *option)
 {
-    error_exit("unrecognized option '%s'", option);
+    error_exit(cmdname, "unrecognized option '%s'", option);
 }
 
 /* Please keep in synch with docs/tools/qemu-img.rst */
@@ -508,7 +508,7 @@ static int64_t cvtnum(const char *name, const char *value)
     return cvtnum_full(name, value, 0, INT64_MAX);
 }
 
-static int img_create(int argc, char **argv)
+static int img_create(const char *cmdname, int argc, char **argv)
 {
     int c;
     uint64_t img_size = -1;
@@ -534,10 +534,10 @@ static int img_create(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -576,7 +576,7 @@ static int img_create(int argc, char **argv)
     }
 
     if (optind >= argc) {
-        error_exit("Expecting image file name");
+        error_exit(cmdname, "Expecting image file name");
     }
     optind++;
 
@@ -591,7 +591,7 @@ static int img_create(int argc, char **argv)
         img_size = (uint64_t)sval;
     }
     if (optind != argc) {
-        error_exit("Unexpected argument: %s", argv[optind]);
+        error_exit(cmdname, "Unexpected argument: %s", argv[optind]);
     }
 
     bdrv_img_create(filename, fmt, base_filename, base_fmt,
@@ -716,7 +716,7 @@ static int collect_image_check(BlockDriverState *bs,
  *  3 - Check completed, image has leaked clusters, but is good otherwise
  * 63 - Checks are not supported by the image format
  */
-static int img_check(int argc, char **argv)
+static int img_check(const char *cmdname, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -754,10 +754,10 @@ static int img_check(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -773,7 +773,7 @@ static int img_check(int argc, char **argv)
             } else if (!strcmp(optarg, "all")) {
                 fix = BDRV_FIX_LEAKS | BDRV_FIX_ERRORS;
             } else {
-                error_exit("Unknown option value for -r "
+                error_exit(cmdname, "Unknown option value for -r "
                            "(expecting 'leaks' or 'all'): %s", optarg);
             }
             break;
@@ -798,7 +798,7 @@ static int img_check(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -948,7 +948,7 @@ static void run_block_job(BlockJob *job, Error **errp)
     }
 }
 
-static int img_commit(int argc, char **argv)
+static int img_commit(const char *cmdname, int argc, char **argv)
 {
     int c, ret, flags;
     const char *filename, *fmt, *cache, *base;
@@ -979,10 +979,10 @@ static int img_commit(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -1028,7 +1028,7 @@ static int img_commit(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -1355,7 +1355,7 @@ static int check_empty_sectors(BlockBackend *blk, int64_t offset,
  * 1 - Images differ
  * >1 - Error occurred
  */
-static int img_compare(int argc, char **argv)
+static int img_compare(const char *cmdname, int argc, char **argv)
 {
     const char *fmt1 = NULL, *fmt2 = NULL, *cache, *filename1, *filename2;
     BlockBackend *blk1, *blk2;
@@ -1392,10 +1392,10 @@ static int img_compare(int argc, char **argv)
         }
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -1449,7 +1449,7 @@ static int img_compare(int argc, char **argv)
 
 
     if (optind != argc - 2) {
-        error_exit("Expecting two image file names");
+        error_exit(cmdname, "Expecting two image file names");
     }
     filename1 = argv[optind++];
     filename2 = argv[optind++];
@@ -2231,7 +2231,7 @@ static void set_rate_limit(BlockBackend *blk, int64_t rate_limit)
     blk_set_io_limits(blk, &cfg);
 }
 
-static int img_convert(int argc, char **argv)
+static int img_convert(const char *cmdname, int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = BDRV_O_NO_SHARE;
     const char *fmt = NULL, *out_fmt = NULL, *cache = "unsafe",
@@ -2284,10 +2284,10 @@ static int img_convert(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -2999,7 +2999,7 @@ err:
     return NULL;
 }
 
-static int img_info(int argc, char **argv)
+static int img_info(const char *cmdname, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3030,10 +3030,10 @@ static int img_info(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3059,7 +3059,7 @@ static int img_info(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -3224,7 +3224,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     return true;
 }
 
-static int img_map(int argc, char **argv)
+static int img_map(const char *cmdname, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3261,10 +3261,10 @@ static int img_map(int argc, char **argv)
         }
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3299,7 +3299,7 @@ static int img_map(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     filename = argv[optind];
 
@@ -3373,7 +3373,7 @@ out:
 #define SNAPSHOT_APPLY  3
 #define SNAPSHOT_DELETE 4
 
-static int img_snapshot(int argc, char **argv)
+static int img_snapshot(const char *cmdname, int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -3404,10 +3404,10 @@ static int img_snapshot(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3417,7 +3417,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'l':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(cmdname, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_LIST;
@@ -3425,7 +3425,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'a':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(cmdname, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_APPLY;
@@ -3433,7 +3433,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'c':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(cmdname, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_CREATE;
@@ -3441,7 +3441,7 @@ static int img_snapshot(int argc, char **argv)
             break;
         case 'd':
             if (action) {
-                error_exit("Cannot mix '-l', '-a', '-c', '-d'");
+                error_exit(cmdname, "Cannot mix '-l', '-a', '-c', '-d'");
                 return 0;
             }
             action = SNAPSHOT_DELETE;
@@ -3463,7 +3463,7 @@ static int img_snapshot(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     filename = argv[optind++];
 
@@ -3534,7 +3534,7 @@ static int img_snapshot(int argc, char **argv)
     return 0;
 }
 
-static int img_rebase(int argc, char **argv)
+static int img_rebase(const char *cmdname, int argc, char **argv)
 {
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
@@ -3578,10 +3578,10 @@ static int img_rebase(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -3630,10 +3630,10 @@ static int img_rebase(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     if (!unsafe && !out_baseimg) {
-        error_exit("Must specify backing file (-b) or use unsafe mode (-u)");
+        error_exit(cmdname, "Must specify backing file (-b) or use unsafe mode (-u)");
     }
     filename = argv[optind++];
 
@@ -4027,7 +4027,7 @@ out:
     return 0;
 }
 
-static int img_resize(int argc, char **argv)
+static int img_resize(const char *cmdname, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret, relative;
@@ -4057,7 +4057,7 @@ static int img_resize(int argc, char **argv)
     /* Remove size from argv manually so that negative numbers are not treated
      * as options by getopt. */
     if (argc < 3) {
-        error_exit("Not enough arguments");
+        error_exit(cmdname, "Not enough arguments");
         return 1;
     }
 
@@ -4081,10 +4081,10 @@ static int img_resize(int argc, char **argv)
         }
         switch(c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -4115,7 +4115,7 @@ static int img_resize(int argc, char **argv)
         }
     }
     if (optind != argc - 1) {
-        error_exit("Expecting image file name and size");
+        error_exit(cmdname, "Expecting image file name and size");
     }
     filename = argv[optind++];
 
@@ -4240,7 +4240,7 @@ static int print_amend_option_help(const char *format)
     return 0;
 }
 
-static int img_amend(int argc, char **argv)
+static int img_amend(const char *cmdname, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 0;
@@ -4273,10 +4273,10 @@ static int img_amend(int argc, char **argv)
 
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -4312,7 +4312,7 @@ static int img_amend(int argc, char **argv)
     }
 
     if (!options) {
-        error_exit("Must specify options (-o)");
+        error_exit(cmdname, "Must specify options (-o)");
     }
 
     if (quiet) {
@@ -4504,7 +4504,7 @@ static void bench_cb(void *opaque, int ret)
     }
 }
 
-static int img_bench(int argc, char **argv)
+static int img_bench(const char *cmdname, int argc, char **argv)
 {
     int c, ret = 0;
     const char *fmt = NULL, *filename;
@@ -4547,10 +4547,10 @@ static int img_bench(int argc, char **argv)
 
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -4674,7 +4674,7 @@ static int img_bench(int argc, char **argv)
     }
 
     if (optind != argc - 1) {
-        error_exit("Expecting one image file name");
+        error_exit(cmdname, "Expecting one image file name");
     }
     filename = argv[argc - 1];
 
@@ -4774,7 +4774,7 @@ typedef struct ImgBitmapAction {
     QSIMPLEQ_ENTRY(ImgBitmapAction) next;
 } ImgBitmapAction;
 
-static int img_bitmap(int argc, char **argv)
+static int img_bitmap(const char *cmdname, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 1;
@@ -4816,10 +4816,10 @@ static int img_bitmap(int argc, char **argv)
 
         switch (c) {
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -5074,7 +5074,7 @@ static int img_dd_skip(const char *arg,
     return 0;
 }
 
-static int img_dd(int argc, char **argv)
+static int img_dd(const char *cmdname, int argc, char **argv)
 {
     int ret = 0;
     char *arg = NULL;
@@ -5136,10 +5136,10 @@ static int img_dd(int argc, char **argv)
             fmt = optarg;
             break;
         case ':':
-            missing_argument(argv[optind - 1]);
+            missing_argument(cmdname, argv[optind - 1]);
             break;
         case '?':
-            unrecognized_option(argv[optind - 1]);
+            unrecognized_option(cmdname, argv[optind - 1]);
             break;
         case 'h':
             help();
@@ -5342,7 +5342,7 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
     g_string_free(str, true);
 }
 
-static int img_measure(int argc, char **argv)
+static int img_measure(const char *cmdname, int argc, char **argv)
 {
     static const struct option long_options[] = {
         {"help", no_argument, 0, 'h'},
@@ -5570,7 +5570,7 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
     bdrv_init();
     if (argc < 2) {
-        error_exit("Not enough arguments");
+        error_exit(NULL, "Not enough arguments");
     }
 
     qemu_add_opts(&qemu_source_opts);
@@ -5579,10 +5579,10 @@ int main(int argc, char **argv)
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
@@ -5615,10 +5615,10 @@ int main(int argc, char **argv)
     /* find the command */
     for (cmd = img_cmds; cmd->name != NULL; cmd++) {
         if (!strcmp(cmdname, cmd->name)) {
-            return cmd->handler(argc, argv);
+            return cmd->handler(cmdname, argc, argv);
         }
     }
 
     /* not found */
-    error_exit("Command not found: %s", cmdname);
+    error_exit(NULL, "Command not found: %s", cmdname);
 }
-- 
2.39.2


