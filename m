Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA166C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublQA-0001Vf-6N; Tue, 15 Jul 2025 15:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyG-0004hn-JT
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkyE-0001oA-ET
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Qy9Tix5Uw1YpHnQdQLk8iYBh0aW/alhW9midwgBcck=;
 b=hTnm7LfV9mRREsMYC6fIM79amOjh57Npk8a41dnShkaTsNK1SgS8I4dSjkM7+SfBSdgm23
 XUHMG7PlY92ifWLT/SqUCvsWrrMZICCIKsfMej8Dj46d5b2qMha4Evl5gvxxQNoZ37ufy3
 ESzDxGKbl6PAwts3cchzU1+GHKndxMw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-ANPtvm_0OeiCn8WOrYHOEQ-1; Tue,
 15 Jul 2025 15:05:38 -0400
X-MC-Unique: ANPtvm_0OeiCn8WOrYHOEQ-1
X-Mimecast-MFC-AGG-ID: ANPtvm_0OeiCn8WOrYHOEQ_1752606337
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 775F31800BCB; Tue, 15 Jul 2025 19:05:37 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D47FB197702B; Tue, 15 Jul 2025 19:05:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 57/57] qemu-img: extend cvtnum() and use it in more places
Date: Tue, 15 Jul 2025 21:03:30 +0200
Message-ID: <20250715190330.378764-58-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

cvtnum() expects input string to specify some sort of size
(optionally with KMG... suffix).  However, there are a lot
of other number conversions in there (using qemu_strtol &Co),
also, not all conversions which use cvtnum, actually expects
size, - like dd count=nn.

Add bool is_size argument to cvtnum() to specify if it should
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

While at it, remove allowed size suffixes from the error message
as it makes no sense most of the time (should be in help instead).

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250531171609.197078-28-mjt@tls.msk.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 111 +++++++++++++------------------------
 tests/qemu-iotests/049.out |   9 +--
 2 files changed, 40 insertions(+), 80 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b34b1390bb..7a162fdc08 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -398,18 +398,16 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     return 0;
 }
 
-static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
-                           int64_t max)
+static int64_t cvtnum_full(const char *name, const char *value,
+                           bool is_size, int64_t min, int64_t max)
 {
     int err;
     uint64_t res;
 
-    err = qemu_strtosz(value, NULL, &res);
+    err = is_size ? qemu_strtosz(value, NULL, &res) :
+                    qemu_strtou64(value, NULL, 0, &res);
     if (err < 0 && err != -ERANGE) {
-        error_report("Invalid %s specified. You may use "
-                     "k, M, G, T, P or E suffixes for", name);
-        error_report("kilobytes, megabytes, gigabytes, terabytes, "
-                     "petabytes and exabytes.");
+        error_report("Invalid %s specified: '%s'", name, value);
         return err;
     }
     if (err == -ERANGE || res > max || res < min) {
@@ -420,9 +418,9 @@ static int64_t cvtnum_full(const char *name, const char *value, int64_t min,
     return res;
 }
 
-static int64_t cvtnum(const char *name, const char *value)
+static int64_t cvtnum(const char *name, const char *value, bool is_size)
 {
-    return cvtnum_full(name, value, 0, INT64_MAX);
+    return cvtnum_full(name, value, is_size, 0, INT64_MAX);
 }
 
 static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
@@ -525,7 +523,7 @@ static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
 
     /* Get image size, if specified */
     if (optind < argc) {
-        img_size = cvtnum("image size", argv[optind++]);
+        img_size = cvtnum("image size", argv[optind++], true);
         if (img_size < 0) {
             goto fail;
         }
@@ -984,7 +982,7 @@ static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
             drop = true;
             break;
         case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
+            rate_limit = cvtnum("rate limit", optarg, true);
             if (rate_limit < 0) {
                 return 1;
             }
@@ -2428,7 +2426,7 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
         {
             int64_t sval;
 
-            sval = cvtnum("buffer size for sparse output", optarg);
+            sval = cvtnum("buffer size for sparse output", optarg, true);
             if (sval < 0) {
                 goto fail_getopt;
             } else if (!QEMU_IS_ALIGNED(sval, BDRV_SECTOR_SIZE) ||
@@ -2462,16 +2460,15 @@ static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case 'r':
-            rate_limit = cvtnum("rate limit", optarg);
+            rate_limit = cvtnum("rate limit", optarg, true);
             if (rate_limit < 0) {
                 goto fail_getopt;
             }
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
@@ -3376,13 +3373,13 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
             image_opts = true;
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
@@ -4720,9 +4717,9 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -4827,27 +4824,17 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
             }
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
-            if (qemu_strtoul(optarg, NULL, 0, &res) <= 0 || res > INT_MAX) {
-                error_report("Invalid queue depth specified");
+            depth = cvtnum_full("queue depth", optarg, false, 1, INT_MAX);
+            if (depth < 0) {
                 return 1;
             }
-            depth = res;
             break;
-        }
         case 'n':
             flags |= BDRV_O_NATIVE_AIO;
             break;
@@ -4860,64 +4847,40 @@ static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
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
         case 'w':
             flags |= BDRV_O_RDWR;
             is_write = true;
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
@@ -5129,7 +5092,7 @@ static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
             add = true;
             break;
         case 'g':
-            granularity = cvtnum("granularity", optarg);
+            granularity = cvtnum("granularity", optarg, true);
             if (granularity < 0) {
                 return 1;
             }
@@ -5314,7 +5277,7 @@ static int img_dd_bs(const char *arg,
 {
     int64_t res;
 
-    res = cvtnum_full("bs", arg, 1, INT_MAX);
+    res = cvtnum_full("bs", arg, true, 1, INT_MAX);
 
     if (res < 0) {
         return 1;
@@ -5328,7 +5291,7 @@ static int img_dd_count(const char *arg,
                         struct DdIo *in, struct DdIo *out,
                         struct DdInfo *dd)
 {
-    dd->count = cvtnum("count", arg);
+    dd->count = cvtnum("count", arg, true);
 
     if (dd->count < 0) {
         return 1;
@@ -5359,7 +5322,7 @@ static int img_dd_skip(const char *arg,
                        struct DdIo *in, struct DdIo *out,
                        struct DdInfo *dd)
 {
-    in->offset = cvtnum("skip", arg);
+    in->offset = cvtnum("skip", arg, true);
 
     if (in->offset < 0) {
         return 1;
@@ -5767,7 +5730,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
             user_creatable_process_cmdline(optarg);
             break;
         case 's':
-            img_size = cvtnum("image size", optarg);
+            img_size = cvtnum("image size", optarg, true);
             if (img_size < 0) {
                 goto out;
             }
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 34e1b452e6..70c627538b 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -98,8 +98,7 @@ qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified: '-1k'
 
 qemu-img create -f qcow2 -o size=-1k TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
@@ -107,8 +106,7 @@ Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified: '1kilobyte'
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
@@ -116,8 +114,7 @@ Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
 and exabytes, respectively.
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified: 'foobar'
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
 qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
-- 
2.50.1


