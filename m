Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D80C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 07:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4x2M-0007TN-M9; Wed, 16 Apr 2025 03:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2H-0007Ri-S6; Wed, 16 Apr 2025 03:18:17 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2D-0001oc-M6; Wed, 16 Apr 2025 03:18:17 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id 797561520DC8;
 Wed, 16 Apr 2025 09:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1744787883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gl/B/pqU2gp9qrU7yqQXA2XkLT0NnoQn430/60d+yMc=;
 b=BQsRbQ37vNSZglUtAgqzqbE6nFM0HEtpytZEhEE1/HZeprkfFICeIunNaZDk/29hCGm5qE
 ZXQ9DaH9NoIQyzMVqelHEctSgFQTV3a/ZpTG2a4/Dw/VP74PYM3mpR4cDS8bsJvQzmDw99
 LvF8+aDnAZudoSyZtEne/c0sZkalPBlmJrhyxazIWL34kcZXYmvFmza69kEFxd6/h1vqz1
 JaYjngns9J/AKAiyx0TyfPcHlHvAdmIMSsdCv7icPUFlC89Hb/ET810CjHtRZiVGFKlzmH
 lmzjK66w0PT1Ak/2UCWIGTPDuQUYSkSen/UOp5ywNnCCK0RqAf0M9oBhmLSKgA==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 1/3] block: add for_commit option to measure
Date: Wed, 16 Apr 2025 09:16:52 +0200
Message-ID: <20250416071654.978264-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416071654.978264-1-jean-louis@dupond.be>
References: <20250416071654.978264-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To specify we use measure call for commit size calculations, we add a
new 'for_commit' option to the measure call.
This will be used in following commit to do a different measurement.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2.c                    | 16 +++++++++++++
 include/block/block_int-common.h |  4 ++++
 qapi/block-core.json             | 28 ++++++++++++++++++++++
 qemu-img.c                       | 40 ++++++++++++++++++++++++++++----
 4 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7774e7f090..19028e051c 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3945,6 +3945,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
         { BLOCK_OPT_COMPAT_LEVEL,       "version" },
         { BLOCK_OPT_DATA_FILE_RAW,      "data-file-raw" },
         { BLOCK_OPT_COMPRESSION_TYPE,   "compression-type" },
+        { BLOCK_OPT_FOR_COMMIT,         "for-commit" },
         { NULL, NULL },
     };
 
@@ -6066,6 +6067,20 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
         .def_value_str = "16"                                       \
     }
 
+static QemuOptsList qcow2_measure_opts = {
+    .name = "qcow2-measure-opts",
+    .head = QTAILQ_HEAD_INITIALIZER(qcow2_measure_opts.head),
+    .desc = {
+        {                                                       \
+            .name = BLOCK_OPT_FOR_COMMIT,                       \
+            .type = QEMU_OPT_BOOL,                              \
+            .help = "Use measure for commit",                   \
+            .def_value_str = "off"                              \
+        },                                                      \
+        { /* end of list */ }
+    }
+};
+
 static QemuOptsList qcow2_create_opts = {
     .name = "qcow2-create-opts",
     .head = QTAILQ_HEAD_INITIALIZER(qcow2_create_opts.head),
@@ -6190,6 +6205,7 @@ BlockDriver bdrv_qcow2 = {
 
     .create_opts                        = &qcow2_create_opts,
     .amend_opts                         = &qcow2_amend_opts,
+    .measure_opts                       = &qcow2_measure_opts,
     .strong_runtime_opts                = qcow2_strong_runtime_opts,
     .mutable_opts                       = mutable_opts,
     .bdrv_co_check                      = qcow2_co_check,
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ebb4e56a50..26d521459d 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -57,6 +57,7 @@
 #define BLOCK_OPT_DATA_FILE_RAW     "data_file_raw"
 #define BLOCK_OPT_COMPRESSION_TYPE  "compression_type"
 #define BLOCK_OPT_EXTL2             "extended_l2"
+#define BLOCK_OPT_FOR_COMMIT        "for_commit"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
@@ -177,6 +178,9 @@ struct BlockDriver {
     /* List of options for image amend */
     QemuOptsList *amend_opts;
 
+    /* List of options for image measure */
+    QemuOptsList *measure_opts;
+
     /*
      * If this driver supports reopening images this contains a
      * NULL-terminated list of the runtime options that can be
diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e1..ab897be404 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5557,6 +5557,34 @@
   'features': [ 'unstable' ],
   'allow-preconfig': true }
 
+  ##
+  # @BlockdevMeasureOptionsQcow2:
+  #
+  # Driver specific image measure options for qcow2.
+  #
+  # @for-commit: Use the measure command to calculate commit image size
+  #
+  # Since: 10.0
+  ##
+  { 'struct': 'BlockdevMeasureOptionsQcow2',
+    'data': { '*for-commit': 'bool' } }
+
+  ##
+  # @BlockdevMeasureOptions:
+  #
+  # Options for measuring an image format
+  #
+  # @driver: Block driver of the node to measure.
+  #
+  # Since: 10.0
+  ##
+  { 'union': 'BlockdevMeasureOptions',
+    'base': {
+        'driver':         'BlockdevDriver' },
+    'discriminator': 'driver',
+    'data': {
+        'qcow2':           'BlockdevMeasureOptionsQcow2' } }
+
 ##
 # @BlockErrorAction:
 #
diff --git a/qemu-img.c b/qemu-img.c
index 2044c22a4c..a4673c3f32 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5327,6 +5327,31 @@ out:
     return 0;
 }
 
+static int print_measure_option_help(const char *format)
+{
+    BlockDriver *drv;
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    /* Find driver and parse its options */
+    drv = bdrv_find_format(format);
+    if (!drv) {
+        error_report("Unknown file format '%s'", format);
+        return 1;
+    }
+
+    if (!drv->measure_opts) {
+        error_report("Format driver '%s' does not support measure options",
+            format);
+        return 1;
+    }
+
+    printf("Measure options for '%s':\n", format);
+    qemu_opts_print_help(drv->measure_opts, false);
+
+    return 0;
+}
+
 static void dump_json_block_measure_info(BlockMeasureInfo *info)
 {
     GString *str;
@@ -5366,7 +5391,7 @@ static int img_measure(int argc, char **argv)
     QemuOpts *opts = NULL;
     QemuOpts *object_opts = NULL;
     QemuOpts *sn_opts = NULL;
-    QemuOptsList *create_opts = NULL;
+    QemuOptsList *all_opts = NULL;
     bool image_opts = false;
     uint64_t img_size = UINT64_MAX;
     BlockMeasureInfo *info = NULL;
@@ -5491,10 +5516,15 @@ static int img_measure(int argc, char **argv)
                      drv->format_name);
         goto out;
     }
+    if (options && has_help_option(options)) {
+        ret = print_measure_option_help(drv->format_name);
+        goto out;
+    }
 
-    create_opts = qemu_opts_append(create_opts, drv->create_opts);
-    create_opts = qemu_opts_append(create_opts, bdrv_file.create_opts);
-    opts = qemu_opts_create(create_opts, NULL, 0, &error_abort);
+    all_opts = qemu_opts_append(all_opts, drv->create_opts);
+    all_opts = qemu_opts_append(all_opts, bdrv_file.create_opts);
+    all_opts = qemu_opts_append(all_opts, drv->measure_opts);
+    opts = qemu_opts_create(all_opts, NULL, 0, &error_abort);
     if (options) {
         if (!qemu_opts_do_parse(opts, options, NULL, &local_err)) {
             error_report_err(local_err);
@@ -5529,7 +5559,7 @@ out:
     qemu_opts_del(object_opts);
     qemu_opts_del(opts);
     qemu_opts_del(sn_opts);
-    qemu_opts_free(create_opts);
+    qemu_opts_free(all_opts);
     g_free(options);
     blk_unref(in_blk);
     return ret;
-- 
2.49.0


