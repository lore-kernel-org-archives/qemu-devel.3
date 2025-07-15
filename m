Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C53DC83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublUb-0001hq-V0; Tue, 15 Jul 2025 15:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxU-0004OC-QC
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxR-0001Sg-RP
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MF94GLS9hbxCifMMuMwtaL2X4rcz7DYsJClkdEjiWBA=;
 b=YfKwTzjIIV8ypGuASeRZJUW0o/Ea3F4SxqzyBvV3Ad4OE61M37PeNKnORZz4xemtTf3EX0
 9LWNoG3haCaQAQxe+0ARDKmaZCOPB3JwrWPAOzjFqJ7VqlfD7eevv+JEmUvbPqNm/D9rLw
 00+9wMrbO2NY0eghRSXLUZbshpFHIHM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-Zmb7VfpUPX6IgBV0WPZL0g-1; Tue,
 15 Jul 2025 15:04:50 -0400
X-MC-Unique: Zmb7VfpUPX6IgBV0WPZL0g-1
X-Mimecast-MFC-AGG-ID: Zmb7VfpUPX6IgBV0WPZL0g_1752606289
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DB1A19560B3; Tue, 15 Jul 2025 19:04:49 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D134C197702B; Tue, 15 Jul 2025 19:04:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 34/57] qemu-img: pass current cmd info into command handlers
Date: Tue, 15 Jul 2025 21:03:07 +0200
Message-ID: <20250715190330.378764-35-kwolf@redhat.com>
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

This info will be used to generate --help output.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250531171609.197078-5-mjt@tls.msk.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2b46c952bd..a414837355 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -60,7 +60,7 @@
 
 typedef struct img_cmd_t {
     const char *name;
-    int (*handler)(int argc, char **argv);
+    int (*handler)(const struct img_cmd_t *ccmd, int argc, char **argv);
 } img_cmd_t;
 
 enum {
@@ -514,7 +514,7 @@ static int64_t cvtnum(const char *name, const char *value)
     return cvtnum_full(name, value, 0, INT64_MAX);
 }
 
-static int img_create(int argc, char **argv)
+static int img_create(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     int64_t img_size = -1;
@@ -719,7 +719,7 @@ static int collect_image_check(BlockDriverState *bs,
  *  3 - Check completed, image has leaked clusters, but is good otherwise
  * 63 - Checks are not supported by the image format
  */
-static int img_check(int argc, char **argv)
+static int img_check(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -951,7 +951,7 @@ static void run_block_job(BlockJob *job, Error **errp)
     }
 }
 
-static int img_commit(int argc, char **argv)
+static int img_commit(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret, flags;
     const char *filename, *fmt, *cache, *base;
@@ -1358,7 +1358,7 @@ static int check_empty_sectors(BlockBackend *blk, int64_t offset,
  * 1 - Images differ
  * >1 - Error occurred
  */
-static int img_compare(int argc, char **argv)
+static int img_compare(const img_cmd_t *ccmd, int argc, char **argv)
 {
     const char *fmt1 = NULL, *fmt2 = NULL, *cache, *filename1, *filename2;
     BlockBackend *blk1, *blk2;
@@ -2234,7 +2234,7 @@ static void set_rate_limit(BlockBackend *blk, int64_t rate_limit)
     blk_set_io_limits(blk, &cfg);
 }
 
-static int img_convert(int argc, char **argv)
+static int img_convert(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, bs_i, flags, src_flags = BDRV_O_NO_SHARE;
     const char *fmt = NULL, *out_fmt = NULL, *cache = "unsafe",
@@ -3002,7 +3002,7 @@ err:
     return NULL;
 }
 
-static int img_info(int argc, char **argv)
+static int img_info(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3227,7 +3227,7 @@ static inline bool entry_mergeable(const MapEntry *curr, const MapEntry *next)
     return true;
 }
 
-static int img_map(int argc, char **argv)
+static int img_map(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c;
     OutputFormat output_format = OFORMAT_HUMAN;
@@ -3376,7 +3376,7 @@ out:
 #define SNAPSHOT_APPLY  3
 #define SNAPSHOT_DELETE 4
 
-static int img_snapshot(int argc, char **argv)
+static int img_snapshot(const img_cmd_t *ccmd, int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
@@ -3536,7 +3536,7 @@ static int img_snapshot(int argc, char **argv)
     return 0;
 }
 
-static int img_rebase(int argc, char **argv)
+static int img_rebase(const img_cmd_t *ccmd, int argc, char **argv)
 {
     BlockBackend *blk = NULL, *blk_old_backing = NULL, *blk_new_backing = NULL;
     uint8_t *buf_old = NULL;
@@ -4030,7 +4030,7 @@ out:
     return 0;
 }
 
-static int img_resize(int argc, char **argv)
+static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret, relative;
@@ -4243,7 +4243,7 @@ static int print_amend_option_help(const char *format)
     return 0;
 }
 
-static int img_amend(int argc, char **argv)
+static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 0;
@@ -4511,7 +4511,7 @@ static void bench_cb(void *opaque, int ret)
     }
 }
 
-static int img_bench(int argc, char **argv)
+static int img_bench(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int c, ret = 0;
     const char *fmt = NULL, *filename;
@@ -4781,7 +4781,7 @@ typedef struct ImgBitmapAction {
     QSIMPLEQ_ENTRY(ImgBitmapAction) next;
 } ImgBitmapAction;
 
-static int img_bitmap(int argc, char **argv)
+static int img_bitmap(const img_cmd_t *ccmd, int argc, char **argv)
 {
     Error *err = NULL;
     int c, ret = 1;
@@ -5081,7 +5081,7 @@ static int img_dd_skip(const char *arg,
     return 0;
 }
 
-static int img_dd(int argc, char **argv)
+static int img_dd(const img_cmd_t *ccmd, int argc, char **argv)
 {
     int ret = 0;
     char *arg = NULL;
@@ -5349,7 +5349,7 @@ static void dump_json_block_measure_info(BlockMeasureInfo *info)
     g_string_free(str, true);
 }
 
-static int img_measure(int argc, char **argv)
+static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 {
     static const struct option long_options[] = {
         {"help", no_argument, 0, 'h'},
@@ -5616,7 +5616,7 @@ int main(int argc, char **argv)
             argc -= optind;
             qemu_reset_optind();
             argv[0] = argv0;
-            return cmd->handler(argc, argv);
+            return cmd->handler(cmd, argc, argv);
         }
     }
 
-- 
2.50.1


