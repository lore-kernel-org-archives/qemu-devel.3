Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6A8C982C3
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Tmg-0000zj-E1; Tue, 15 Sep 2026 10:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6Tmd-0000vi-9u; Tue, 15 Sep 2026 10:05:15 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1x6TmX-0002lq-EP; Tue, 15 Sep 2026 10:05:14 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 7EA601520F9B;
 Tue, 15 Sep 2026 16:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1789481102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyV0LovrdmQQTgOnUJPVUN5lqDJnTHymsLg64Thdd8A=;
 b=O5eNxxjhZ6F5eYaJqppzkTuncMDfiXddijEv06yF+r47LTfhKsueAA7Niqktve1G7WWEBU
 iywBH+XXETH/UMmCw+UfRFoOXVEI7EAnMbvAJsfLo0NPJucOtIUoy1c0g9qDBcjKSwH1Ue
 1BuXNWwPp2NoncKojYuNI/ej6uaej+4gCsVUTVRk/mVAYKOeVSi3/5i6yv5OBg7YFZtHbz
 3S7Tu5t9BvT8MxXSxR7s+43143qNSekFNLvEDSNmpVxVB8IHJWT24AKZNxjO98whAQQpWk
 t4Yj7ykEK9Hho5sJuhFJOBnwF0jZgimOJCKgar8OEQOwhpfpk0oIZA7ogK3sUQ==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 2/3] block: support measure for commit
Date: Tue, 15 Sep 2026 16:04:42 +0200
Message-ID: <20260915140444.1223798-3-jean-louis@dupond.be>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915140444.1223798-1-jean-louis@dupond.be>
References: <20260915140444.1223798-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a new option to qemu-img measure to specify the base node you want
to merge the image into.
This will open all the images between top and base, and calculate the
size required for merging this layer into the base image.

Also modify the calculation so it takes into account the
discard-no-unref setting of the base image.
If discard-no-unref is enabled on the base, discarded blocks in the
layers above the base will not free clusters in the base image, but will
only mark them ZERO.

[1]: https://gitlab.com/qemu-project/qemu/-/issues/2369

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block.c                          |  5 +-
 block/crypto.c                   |  1 +
 block/qcow2.c                    | 82 ++++++++++++++++++++++++++++----
 block/raw-format.c               |  2 +-
 docs/tools/qemu-img.rst          |  9 +++-
 include/block/block-io.h         |  3 +-
 include/block/block_int-common.h |  2 +-
 qemu-img-cmds.hx                 |  4 +-
 qemu-img.c                       | 45 +++++++++++++++---
 tests/qemu-iotests/178.out.qcow2 |  6 +--
 tests/qemu-iotests/178.out.raw   |  6 +--
 11 files changed, 135 insertions(+), 30 deletions(-)

diff --git a/block.c b/block.c
index 9763137d8c..acc77777ed 100644
--- a/block.c
+++ b/block.c
@@ -6091,7 +6091,8 @@ int64_t coroutine_fn bdrv_co_get_allocated_file_size(BlockDriverState *bs)
  * If an error occurs the @errp pointer is set.
  */
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
-                               BlockDriverState *in_bs, Error **errp)
+                               BlockDriverState *in_bs,
+                               BlockDriverState *base_bs, Error **errp)
 {
     IO_CODE();
     if (!drv->bdrv_measure) {
@@ -6100,7 +6101,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
         return NULL;
     }
 
-    return drv->bdrv_measure(opts, in_bs, errp);
+    return drv->bdrv_measure(opts, in_bs, base_bs, errp);
 }
 
 /**
diff --git a/block/crypto.c b/block/crypto.c
index 36abb7af46..e0236b3382 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -634,6 +634,7 @@ block_crypto_co_getlength(BlockDriverState *bs)
 
 static BlockMeasureInfo *block_crypto_measure(QemuOpts *opts,
                                               BlockDriverState *in_bs,
+                                              BlockDriverState *base_bs,
                                               Error **errp)
 {
     g_autoptr(QCryptoBlockCreateOptions) create_opts = NULL;
diff --git a/block/qcow2.c b/block/qcow2.c
index 7292dd036c..ee9c815830 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5225,7 +5225,7 @@ static coroutine_fn GRAPH_RDLOCK int qcow2_co_flush_to_os(BlockDriverState *bs)
 }
 
 static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
-                                       Error **errp)
+                                       BlockDriverState *base_bs, Error **errp)
 {
     Error *local_err = NULL;
     BlockMeasureInfo *info;
@@ -5241,6 +5241,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     bool has_backing_file;
     bool has_luks;
     bool extended_l2;
+    bool base_discard_no_unref = false;
     size_t l2e_size;
 
     /* Parse image creation options */
@@ -5321,6 +5322,13 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
             goto err;
         }
 
+        if (base_bs && base_bs->drv &&
+            !strcmp(base_bs->drv->format_name, "qcow2")) {
+            BDRVQcow2State *base_s = base_bs->opaque;
+
+            base_discard_no_unref = base_s->discard_no_unref;
+        }
+
         virtual_size = ROUND_UP(ssize, cluster_size);
 
         if (has_backing_file) {
@@ -5336,8 +5344,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
 
             for (offset = 0; offset < ssize; offset += pnum) {
                 int ret;
+                int retp = 0;
+                bool count = false;
 
-                ret = bdrv_block_status_above(in_bs, NULL, offset,
+                ret = bdrv_block_status_above(in_bs, base_bs, offset,
                                               ssize - offset, &pnum, NULL,
                                               NULL);
                 if (ret < 0) {
@@ -5346,15 +5356,67 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                     goto err;
                 }
 
-                if (ret & BDRV_BLOCK_ZERO) {
+                if (ret & BDRV_BLOCK_ZERO && !base_bs) {
                     /* Skip zero regions (safe with no backing file) */
-                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
-                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
-                    /* Extend pnum to end of cluster for next iteration */
-                    pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
-
-                    /* Count clusters we've seen */
-                    required += offset % cluster_size + pnum;
+                } else {
+                    /*
+                     * If there is a base image in the chain, query its
+                     * allocation status for this region so we can decide
+                     * whether the cluster survives a commit into the base.
+                     */
+                    if (base_bs) {
+                        int64_t pnum_base = 0;
+                        retp = bdrv_block_status(base_bs, offset,
+                                            ssize - offset, &pnum_base, NULL,
+                                            NULL);
+                        if (retp < 0) {
+                            error_setg_errno(&local_err, -retp,
+                                    "Unable to get block status of the base");
+                            goto err;
+                        }
+                        /*
+                         * If the base contiguous block is smaller,
+                         * use that pnum, so the next iteration starts with
+                         * the smallest offset.
+                         */
+                        if (pnum_base > 0 && pnum_base < pnum) {
+                            pnum = pnum_base;
+                        }
+                    }
+
+                    if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
+                        (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
+                        /* The overlay has its own data here; it is written. */
+                        count = true;
+                    } else if (base_discard_no_unref) {
+                        /*
+                         * With discard-no-unref enabled on the base, clusters
+                         * allocated in the base keep their reference when the
+                         * overlay is committed (discarded clusters are only
+                         * marked zero), so count any cluster that has a valid
+                         * offset in the base.
+                         */
+                        count = (retp & BDRV_BLOCK_OFFSET_VALID) != 0;
+                    } else {
+                        /*
+                         * Without discard-no-unref, committing the overlay
+                         * frees the base clusters that the overlay discards
+                         * (the overlay marks them zero). Every other cluster
+                         * that is allocated in the base is retained, so count
+                         * it unless the overlay zeroes it out.
+                         */
+                        count = (retp & BDRV_BLOCK_ALLOCATED) &&
+                                !((ret & BDRV_BLOCK_ALLOCATED) &&
+                                  (ret & BDRV_BLOCK_ZERO));
+                    }
+
+                    if (count) {
+                        /* Extend pnum to end of cluster for next iteration */
+                        pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
+
+                        /* Count clusters we've seen */
+                        required += offset % cluster_size + pnum;
+                    }
                 }
             }
         }
diff --git a/block/raw-format.c b/block/raw-format.c
index a57c2922d5..8efa86c8b0 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -369,7 +369,7 @@ raw_co_getlength(BlockDriverState *bs)
 }
 
 static BlockMeasureInfo *raw_measure(QemuOpts *opts, BlockDriverState *in_bs,
-                                     Error **errp)
+                                     BlockDriverState *base_bs, Error **errp)
 {
     BlockMeasureInfo *info;
     int64_t required;
diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index b0c798b77a..3d9052c4bb 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -632,7 +632,7 @@ Command description:
   For more information, consult ``include/block/block.h`` in QEMU's
   source code.
 
-.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
+.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [-b BASE] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
 
   Calculate the file size required for a new image.  This information
   can be used to size logical volumes or SAN LUNs appropriately for
@@ -649,6 +649,13 @@ Command description:
 
   A snapshot in an existing image can be specified using *SNAPSHOT_PARAM*.
 
+  If *BASE* is given, open the backing chain of *FILENAME* up to and
+  including the image *BASE*, and calculate the file size that *BASE*
+  will occupy after *FILENAME* is committed into it (i.e. the size of
+  the merged image).  This is different from the default behaviour,
+  which calculates the size of a standalone copy of *FILENAME*.
+  *BASE* has to be part of the backing chain of *FILENAME*.
+
   The following fields are reported:
 
   ::
diff --git a/include/block/block-io.h b/include/block/block-io.h
index d34d846bb2..c0abd646d0 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -92,7 +92,8 @@ int64_t co_wrapper_bdrv_rdlock
 bdrv_get_allocated_file_size(BlockDriverState *bs);
 
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
-                               BlockDriverState *in_bs, Error **errp);
+                               BlockDriverState *in_bs,
+                               BlockDriverState *base_bs, Error **errp);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_delete_file(BlockDriverState *bs, Error **errp);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 147c08155f..b99b1a7d7d 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -731,7 +731,7 @@ struct BlockDriver {
         BlockDriverState *bs);
 
     BlockMeasureInfo *(*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
-                                      Error **errp);
+                                      BlockDriverState *base_bs, Error **errp);
 
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_pwritev_compressed)(
         BlockDriverState *bs, int64_t offset, int64_t bytes,
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 6bc8265cfb..f3f5c63773 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -78,9 +78,9 @@ SRST
 ERST
 
 DEF("measure", img_measure,
-"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
+"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] [-b base] filename]")
 SRST
-.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
+.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] [-b BASE] FILENAME]
 ERST
 
 DEF("snapshot", img_snapshot,
diff --git a/qemu-img.c b/qemu-img.c
index 2f63d31141..0567067ec2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5694,6 +5694,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     BlockBackend *in_blk = NULL;
     BlockDriver *drv;
     const char *filename = NULL;
+    const char *base_filename = NULL;
     const char *fmt = NULL;
     const char *out_fmt = "raw";
     char *options = NULL;
@@ -5705,6 +5706,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     QemuOptsList *create_opts = NULL;
     bool image_opts = false;
     int64_t img_size = -1;
+    BlockDriverState *base_bs = NULL;
     BlockMeasureInfo *info = NULL;
     Error *local_err = NULL;
     int ret = 1;
@@ -5717,6 +5719,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS}, /* img_convert */
         {"snapshot", required_argument, 0, 'l'},
+        {"base", required_argument, 0, 'b'},
         {"target-format", required_argument, 0, 'O'},
         {"target-format-options", required_argument, 0, 'o'}, /* img_convert */
         {"options", required_argument, 0, 'o'},
@@ -5727,11 +5730,11 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         {0, 0, 0, 0}
     };
 
-    while ((c = getopt_long(argc, argv, "hf:l:O:o:Us:",
+    while ((c = getopt_long(argc, argv, "hf:l:b:O:o:Us:",
                             long_options, NULL)) != -1) {
         switch (c) {
         case 'h':
-            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT]\n"
+            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT] [-b BASE]\n"
 "       [-O TARGET_FMT] [-o TARGET_FMT_OPTS] [--output human|json]\n"
 "       [--object OBJDEF] (--size SIZE | FILE)\n"
 ,
@@ -5742,6 +5745,8 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 "     instead of a file name (incompatible with --format)\n"
 "  -l, --snapshot SNAPSHOT\n"
 "     use this snapshot in FILE as source\n"
+"  -b, --base BASE\n"
+"     open FILE backing chain up to BASE (inclusive)\n"
 "  -O, --target-format TARGET_FMT\n"
 "     desired target/output image format (default: raw)\n"
 "  -o TARGET_FMT_OPTS\n"
@@ -5779,6 +5784,9 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
                 snapshot_name = optarg;
             }
             break;
+        case 'b':
+            base_filename = optarg;
+            break;
         case 'O':
             out_fmt = optarg;
             break;
@@ -5814,8 +5822,10 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         filename = argv[optind];
     }
 
-    if (!filename && (image_opts || fmt || snapshot_name || sn_opts)) {
-        error_report("--image-opts, -f, and -l require a filename argument.");
+    if (!filename && (image_opts || fmt || snapshot_name || sn_opts ||
+                      base_filename)) {
+        error_report("--image-opts, -f, -l, and -b require a filename "
+                     "argument.");
         goto out;
     }
     if (filename && img_size != -1) {
@@ -5828,12 +5838,34 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     }
 
     if (filename) {
-        in_blk = img_open(image_opts, filename, fmt, 0,
+        int src_flags = 0;
+
+        /*
+         * When measuring with --base, avoid opening the full backing chain.
+         * We selectively open only up to the requested base afterwards.
+         * An explicit image specification (--image-opts or a json: filename)
+         * defines the backing chain itself, so it has to be opened normally.
+         */
+        if (base_filename && !image_opts &&
+            !g_str_has_prefix(filename, "json:")) {
+            src_flags |= BDRV_O_NO_BACKING;
+        }
+
+        in_blk = img_open(image_opts, filename, fmt, src_flags,
                           false, false, force_share);
         if (!in_blk) {
             goto out;
         }
 
+        if (base_filename) {
+            if (bdrv_open_backing_chain_until(blk_bs(in_blk), base_filename,
+                                              &local_err) < 0) {
+                error_report_err(local_err);
+                goto out;
+            }
+            base_bs = bdrv_find_backing_image(blk_bs(in_blk), base_filename);
+        }
+
         if (sn_opts) {
             bdrv_snapshot_load_tmp(blk_bs(in_blk),
                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
@@ -5874,7 +5906,8 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         qemu_opt_set_number(opts, BLOCK_OPT_SIZE, img_size, &error_abort);
     }
 
-    info = bdrv_measure(drv, opts, in_blk ? blk_bs(in_blk) : NULL, &local_err);
+    info = bdrv_measure(drv, opts, in_blk ? blk_bs(in_blk) : NULL, base_bs,
+                        &local_err);
     if (local_err) {
         error_report_err(local_err);
         goto out;
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index 61506b519f..0984a74a50 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -6,9 +6,9 @@ qemu-img: Either --size N or one filename must be specified.
 qemu-img: --size N cannot be used together with a filename.
 qemu-img: At most one filename argument is allowed.
 qemu-img: Either --size N or one filename must be specified.
-qemu-img: --image-opts, -f, and -l require a filename argument.
-qemu-img: --image-opts, -f, and -l require a filename argument.
-qemu-img: --image-opts, -f, and -l require a filename argument.
+qemu-img: --image-opts, -f, -l, and -b require a filename argument.
+qemu-img: --image-opts, -f, -l, and -b require a filename argument.
+qemu-img: --image-opts, -f, -l, and -b require a filename argument.
 qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
index 6d994a433a..81249e718b 100644
--- a/tests/qemu-iotests/178.out.raw
+++ b/tests/qemu-iotests/178.out.raw
@@ -6,9 +6,9 @@ qemu-img: Either --size N or one filename must be specified.
 qemu-img: --size N cannot be used together with a filename.
 qemu-img: At most one filename argument is allowed.
 qemu-img: Either --size N or one filename must be specified.
-qemu-img: --image-opts, -f, and -l require a filename argument.
-qemu-img: --image-opts, -f, and -l require a filename argument.
-qemu-img: --image-opts, -f, and -l require a filename argument.
+qemu-img: --image-opts, -f, -l, and -b require a filename argument.
+qemu-img: --image-opts, -f, -l, and -b require a filename argument.
+qemu-img: --image-opts, -f, -l, and -b require a filename argument.
 qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
-- 
2.55.0


