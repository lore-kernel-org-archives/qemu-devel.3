Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A4FC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublOj-0005tk-PZ; Tue, 15 Jul 2025 15:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxX-0004Ol-HC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxU-0001TN-GN
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rijoJi/Ykv0GahCauUjFN1CRQ9kyD3BH1g9TE573ntg=;
 b=VCIzxXPhHkxStvlTjNVo6lsAecPWFInavJl32DKolIYFIi8te1RSHqRpRSK2ELI7JDJlzY
 tyzmSTqJxYuaQwVkQOk9hWg4TRjvTsFsMDfTzXEuosQWwb5Q7JAdVFW9ybfX0X+xOUInrH
 xLRrEWsygYlWsQ5IhGL+QsX72qQvs/s=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-Z7B_Cy8BMuq2JVut03FOuw-1; Tue,
 15 Jul 2025 15:04:54 -0400
X-MC-Unique: Z7B_Cy8BMuq2JVut03FOuw-1
X-Mimecast-MFC-AGG-ID: Z7B_Cy8BMuq2JVut03FOuw_1752606293
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 74B3419560B5; Tue, 15 Jul 2025 19:04:53 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E81B8197702B; Tue, 15 Jul 2025 19:04:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 36/57] qemu-img: factor out parse_output_format() and use it in
 the code
Date: Tue, 15 Jul 2025 21:03:09 +0200
Message-ID: <20250715190330.378764-37-kwolf@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use common code and simplify error message

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250531171609.197078-7-mjt@tls.msk.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                       | 63 +++++++++-----------------------
 tests/qemu-iotests/178           |  2 +-
 tests/qemu-iotests/178.out.qcow2 |  3 +-
 tests/qemu-iotests/178.out.raw   |  3 +-
 tests/qemu-iotests/common.filter |  6 +++
 5 files changed, 29 insertions(+), 48 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 6569efd310..b60b4d38df 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -158,6 +158,17 @@ void cmd_help(const img_cmd_t *ccmd,
     exit(EXIT_SUCCESS);
 }
 
+static OutputFormat parse_output_format(const char *argv0, const char *arg)
+{
+    if (!strcmp(arg, "json")) {
+        return OFORMAT_JSON;
+    } else if (!strcmp(arg, "human")) {
+        return OFORMAT_HUMAN;
+    } else {
+        error_exit(argv0, "--output expects 'human' or 'json', not '%s'", arg);
+    }
+}
+
 /* Please keep in synch with docs/tools/qemu-img.rst */
 static G_NORETURN
 void help(void)
@@ -775,7 +786,7 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
-    const char *filename, *fmt, *output, *cache;
+    const char *filename, *fmt, *cache;
     BlockBackend *blk;
     BlockDriverState *bs;
     int fix = 0;
@@ -787,7 +798,6 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     cache = BDRV_DEFAULT_CACHE;
 
     for(;;) {
@@ -833,7 +843,7 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
             }
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case 'T':
             cache = optarg;
@@ -857,15 +867,6 @@ static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
     }
     filename = argv[optind++];
 
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
     ret = bdrv_parse_cache_mode(cache, &flags, &writethrough);
     if (ret < 0) {
         error_report("Invalid source cache option: %s", cache);
@@ -3059,13 +3060,12 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
     bool chain = false;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     BlockGraphInfoList *list;
     bool image_opts = false;
     bool force_share = false;
 
     fmt = NULL;
-    output = NULL;
     for(;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3100,7 +3100,7 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case OPTION_BACKING_CHAIN:
             chain = true;
@@ -3118,15 +3118,6 @@ static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
     }
     filename = argv[optind++];
 
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
     list = collect_image_info_list(image_opts, filename, fmt, chain,
                                    force_share);
     if (!list) {
@@ -3285,7 +3276,7 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     OutputFormat output_format = OFORMAT_HUMAN;
     BlockBackend *blk;
     BlockDriverState *bs;
-    const char *filename, *fmt, *output;
+    const char *filename, *fmt;
     int64_t length;
     MapEntry curr = { .length = 0 }, next;
     int ret = 0;
@@ -3295,7 +3286,6 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     int64_t max_length = -1;
 
     fmt = NULL;
-    output = NULL;
     for (;;) {
         int option_index = 0;
         static const struct option long_options[] = {
@@ -3331,7 +3321,7 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
             force_share = true;
             break;
         case OPTION_OUTPUT:
-            output = optarg;
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case 's':
             start_offset = cvtnum("start offset", optarg);
@@ -3358,15 +3348,6 @@ static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
     }
     filename = argv[optind];
 
-    if (output && !strcmp(output, "json")) {
-        output_format = OFORMAT_JSON;
-    } else if (output && !strcmp(output, "human")) {
-        output_format = OFORMAT_HUMAN;
-    } else if (output) {
-        error_report("--output must be used with human or json as argument.");
-        return 1;
-    }
-
     blk = img_open(image_opts, filename, fmt, 0, false, false, force_share);
     if (!blk) {
         return 1;
@@ -5473,15 +5454,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
             image_opts = true;
             break;
         case OPTION_OUTPUT:
-            if (!strcmp(optarg, "json")) {
-                output_format = OFORMAT_JSON;
-            } else if (!strcmp(optarg, "human")) {
-                output_format = OFORMAT_HUMAN;
-            } else {
-                error_report("--output must be used with human or json "
-                             "as argument.");
-                goto out;
-            }
+            output_format = parse_output_format(argv[0], optarg);
             break;
         case OPTION_SIZE:
             img_size = cvtnum("image size", optarg);
diff --git a/tests/qemu-iotests/178 b/tests/qemu-iotests/178
index 8df241ead8..463c59a77f 100755
--- a/tests/qemu-iotests/178
+++ b/tests/qemu-iotests/178
@@ -58,7 +58,7 @@ $QEMU_IMG measure -f qcow2 # missing filename
 $QEMU_IMG measure -l snap1 # missing filename
 $QEMU_IMG measure -o , # invalid option list
 $QEMU_IMG measure -l snapshot.foo=bar # invalid snapshot option
-$QEMU_IMG measure --output foo # invalid output format
+$QEMU_IMG measure --output foo 2>&1 | _filter_qemu_img # invalid output format
 $QEMU_IMG measure --size -1 # invalid image size
 $QEMU_IMG measure -O foo "$TEST_IMG" # unknown image file format
 
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index fe193fd5f4..61506b519f 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -12,7 +12,8 @@ qemu-img: --image-opts, -f, and -l require a filename argument.
 qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
-qemu-img: --output must be used with human or json as argument.
+qemu-img: --output expects 'human' or 'json', not 'foo'
+Try 'qemu-img measure --help' for more information
 qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
 qemu-img: Unknown file format 'foo'
 
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
index 445e460fad..6d994a433a 100644
--- a/tests/qemu-iotests/178.out.raw
+++ b/tests/qemu-iotests/178.out.raw
@@ -12,7 +12,8 @@ qemu-img: --image-opts, -f, and -l require a filename argument.
 qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
-qemu-img: --output must be used with human or json as argument.
+qemu-img: --output expects 'human' or 'json', not 'foo'
+Try 'qemu-img measure --help' for more information
 qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
 qemu-img: Unknown file format 'foo'
 
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index fc3c64bcb8..67f819d866 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -86,6 +86,12 @@ _filter_qemu()
         -e $'s#\r##' # QEMU monitor uses \r\n line endings
 }
 
+# replace occurrences of QEMU_IMG_PROG with "qemu-img"
+_filter_qemu_img()
+{
+    sed -e "s#$QEMU_IMG_PROG#qemu-img#g"
+}
+
 # replace problematic QMP output like timestamps
 _filter_qmp()
 {
-- 
2.50.1


