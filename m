Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2434C5478D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctzg-0002vn-H0; Wed, 21 Feb 2024 16:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctzQ-0001Vy-4F; Wed, 21 Feb 2024 16:18:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rctzN-0001FE-44; Wed, 21 Feb 2024 16:18:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D1CA4F804;
 Thu, 22 Feb 2024 00:16:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 43C22869BC;
 Thu, 22 Feb 2024 00:16:24 +0300 (MSK)
Received: (nullmailer pid 2335328 invoked by uid 1000);
 Wed, 21 Feb 2024 21:16:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 28/28] qemu-img: extend cvtnum() and use it in more places
Date: Thu, 22 Feb 2024 00:16:09 +0300
Message-Id: <20240221211622.2335170-28-mjt@tls.msk.ru>
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

cvtnum() expects input string to specify some sort of size
(optionally with KMG... suffix).  However, there are a lot
of other number conversions in there (using qemu_strtol &Co),
also, not all conversions which use cvtnum, actually expects
size, - like dd count=nn.

Add bool issize argument to cvtnum() to specify if it should
treat the argument as a size or something else, - this changes
conversion routine in use and error text.

Use the new cvtnum() in more places (like where strtol were used),
since it never return negative number in successful conversion.
When it makes sense, also specify upper or lower bounds at the
same time.  This simplifies option processing in multiple places,
removing the need of local temporary variables and longer error
reporting code.

While at it, fix errors, like depth in measure must be >= 1,
while the previous code allowed it to be 0.

In a few places, change unsigned variables (like of type size_t)
to be signed instead, - to avoid the need of temporary conversion
variable.  All these variables are okay to be signed, we never
assign <0 value to them except of the cases of conversion error,
where we return immediately.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qemu-img.c | 118 ++++++++++++++++++++---------------------------------
 1 file changed, 44 insertions(+), 74 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 299e34e470..a066c4cfc4 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -397,18 +397,23 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     return 0;
 }
 
-static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
-                           int64_t max)
+static int64_t cvtnum_full(const char *name, const char *value,
+                           bool issize, int64_t min, int64_t max)
 {
     int err;
     uint64_t res;
 
-    err = qemu_strtosz(value, NULL, &res);
+    err = issize ? qemu_strtosz(value, NULL, &res) :
+                   qemu_strtou64(value, NULL, 0, &res);
     if (err < 0 && err != -ERANGE) {
-        error_report("Invalid %s specified. You may use "
-                     "k, M, G, T, P or E suffixes for", name);
-        error_report("kilobytes, megabytes, gigabytes, terabytes, "
-                     "petabytes and exabytes.");
+        if (issize) {
+            error_report("Invalid %s specified. You may use "
+                         "k, M, G, T, P or E suffixes for", name);
+            error_report("kilobytes, megabytes, gigabytes, terabytes, "
+                         "petabytes and exabytes.");
+        } else {
+            error_report("Invalid %s specified.", name);
+        }
         return err;
     }
     if (err == -ERANGE || res > max || res < min) {
@@ -419,9 +424,9 @@ static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
     return res;
 }
 
-static int64_t cvtnum(const char *name, const char *value)
+static int64_t cvtnum(const char *name, const char *value, bool issize)
 {
-    return cvtnum_full(name, value, 0, INT64_MAX);
+    return cvtnum_full(name, value, issize, 0, INT64_MAX);
 }
 
 static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
@@ -525,7 +530,7 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
 
     /* Get image size, if specified */
     if (optind < argc) {
-        img_size = cvtnum("image size", argv[optind++]);
+        img_size = cvtnum("image size", argv[optind++], true);
         if (img_size < 0) {
             goto fail;
         }
@@ -987,7 +992,7 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
             quiet = true;
             break;
         case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
+            rate_limit = cvtnum("rate limit", optarg, true);
             if (rate_limit < 0) {
                 return 1;
             }
@@ -2412,7 +2417,7 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum("buffer size for sparse output", optarg);
+            sval = cvtnum("buffer size for sparse output", optarg, true);
             if (sval < 0) {
                 goto fail_getopt;
             } else if (!QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
@@ -2444,10 +2449,9 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
             skip_create = true;
             break;
         case 'm':
-            if (qemu_strtol(optarg, NULL, 0, &s.num_coroutines) ||
-                s.num_coroutines < 1 || s.num_coroutines > MAX_COROUTINES) {
-                error_report("Invalid number of coroutines. Allowed number of"
-                             " coroutines is between 1 and %d", MAX_COROUTINES);
+            s.num_coroutines = cvtnum_full("number of coroutines", optarg,
+                                           false, 1, MAX_COROUTINES);
+            if (s.num_coroutines < 0) {
                 goto fail_getopt;
             }
             break;
@@ -2458,7 +2462,7 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
+            rate_limit = cvtnum("rate limit", optarg, true);
             if (rate_limit < 0) {
                 goto fail_getopt;
             }
@@ -3377,13 +3381,13 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
             output_format = parse_output_format(argv[0], optarg);
             break;
         case 's':
-            start_offset = cvtnum("start offset", optarg);
+            start_offset = cvtnum("start offset", optarg, true);
             if (start_offset < 0) {
                 return 1;
             }
             break;
         case 'l':
-            max_length = cvtnum("max length", optarg);
+            max_length = cvtnum("max length", optarg, true);
             if (max_length < 0) {
                 return 1;
             }
@@ -4704,9 +4708,9 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
     int count = 75000;
     int depth = 64;
     int64_t offset = 0;
-    size_t bufsize = 4096;
+    ssize_t bufsize = 4096;
     int pattern = 0;
-    size_t step = 0;
+    ssize_t step = 0;
     int flush_interval = 0;
     bool drain_on_flush = true;
     int64_t image_size;
@@ -4788,27 +4792,17 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
 );
             break;
         case 'c':
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
-                error_report("Invalid request count specified");
+            count = cvtnum_full("request count", optarg, false, 1, INT_MAX);
+            if (count < 0) {
                 return 1;
             }
-            count = res;
             break;
-        }
         case 'd':
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
-                error_report("Invalid queue depth specified");
+            depth = cvtnum_full("queue depth", optarg, false, 1, INT_MAX);
+            if (depth < 0) {
                 return 1;
             }
-            depth = res;
             break;
-        }
         case 'f':
             fmt = optarg;
             break;
@@ -4824,41 +4818,26 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             }
             break;
         case 'o':
-        {
-            offset = cvtnum("offset", optarg);
+            offset = cvtnum("offset", optarg, true);
             if (offset < 0) {
                 return 1;
             }
             break;
-        }
-            break;
         case 'q':
             quiet = true;
             break;
         case 's':
-        {
-            int64_t sval;
-
-            sval = cvtnum_full("buffer size", optarg, 0, INT_MAX);
-            if (sval < 0) {
+            bufsize = cvtnum_full("buffer size", optarg, true, 1, INT_MAX);
+            if (bufsize < 0) {
                 return 1;
             }
-
-            bufsize = sval;
             break;
-        }
         case 'S':
-        {
-            int64_t sval;
-
-            sval = cvtnum_full("step_size", optarg, 0, INT_MAX);
-            if (sval < 0) {
+            step = cvtnum_full("step size", optarg, true, 0, INT_MAX);
+            if (step < 0) {
                 return 1;
             }
-
-            step = sval;
             break;
-        }
         case 't':
             ret = bdrv_parse_cache_mode(optarg, &flags, &writethrough);
             if (ret < 0) {
@@ -4875,27 +4854,18 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_PATTERN:
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > 0xff) {
-                error_report("Invalid pattern byte specified");
+            pattern = cvtnum_full("pattern byte", optarg, false, 0, 0xff);
+            if (pattern < 0) {
                 return 1;
             }
-            pattern = res;
             break;
-        }
         case OPTION_FLUSH_INTERVAL:
-        {
-            unsigned long res;
-
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
-                error_report("Invalid flush interval specified");
+            flush_interval = cvtnum_full("flush interval", optarg,
+                                         false, 0, INT_MAX);
+            if (flush_interval < 0) {
                 return 1;
             }
-            flush_interval = res;
             break;
-        }
         case OPTION_NO_DRAIN:
             drain_on_flush = false;
             break;
@@ -5090,7 +5060,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             src_fmt = optarg;
             break;
         case 'g':
-            granularity = cvtnum("granularity", optarg);
+            granularity = cvtnum("granularity", optarg, false);
             if (granularity < 0) {
                 return 1;
             }
@@ -5278,7 +5248,7 @@ static int img_dd_bs(const char *arg,
 {
     int64_t res;
 
-    res = cvtnum_full("bs", arg, 1, INT_MAX);
+    res = cvtnum_full("bs", arg, true, 1, INT_MAX);
 
     if (res < 0) {
         return 1;
@@ -5292,7 +5262,7 @@ static int img_dd_count(const char *arg,
                         struct DdIo *in, struct DdIo *out,
                         struct DdInfo *dd)
 {
-    dd->count = cvtnum("count", arg);
+    dd->count = cvtnum("count", arg, false);
 
     if (dd->count < 0) {
         return 1;
@@ -5323,7 +5293,7 @@ static int img_dd_skip(const char *arg,
                        struct DdIo *in, struct DdIo *out,
                        struct DdInfo *dd)
 {
-    in->offset = cvtnum("skip", arg);
+    in->offset = cvtnum("skip", arg, false);
 
     if (in->offset < 0) {
         return 1;
@@ -5718,7 +5688,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
             output_format = parse_output_format(argv[0], optarg);
             break;
         case 's':
-            img_size = cvtnum("image size", optarg);
+            img_size = cvtnum("image size", optarg, true);
             if (img_size < 0) {
                 goto out;
             }
-- 
2.39.2


