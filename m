Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DBBCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXme-0000pB-D3; Mon, 08 Jun 2026 07:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wWXmY-0000n7-GW; Mon, 08 Jun 2026 07:04:39 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wWXmU-0006uw-VK; Mon, 08 Jun 2026 07:04:38 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 5A6F91520F65;
 Mon, 08 Jun 2026 13:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1780916669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gSIJbMghTr9Bgu4o/y7W2q9KZXCsTPkVKrbUvq4OkU=;
 b=Y9zuXxepJbIhpR5CX7/c+1x8xKToB+btjMw8P4AS3tB7kgJUd7xZRVuET89IlPCNxzKMLw
 zurp8V91S945EvHTmtQaMM05YxGXILVOrqGhdr2u/L82zgCWDdE+kfBw9rf5FQbugoKNBy
 waWL9VWwANQOrdQc+RboJAGc8K/zrw6n8x8JSGZr9updvfVjXtNbfZLyPWq1OTk/szGjv1
 CUH6MM/39b/3gWFb5lJQQ67DbLnzbvRmTieZpzuEERK9aAvqOMNutGkaP+Zdx0bk4ydEL4
 a4IT+ZdD+Xun1MQA/ND+3dQe3Q2L+GnS8ak3nCkUM/lIpUWWerXviIqumM55Pg==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 2/3] block: support measure for commit
Date: Mon,  8 Jun 2026 13:03:45 +0200
Message-ID: <20260608110346.3231998-3-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608110346.3231998-1-jean-louis@dupond.be>
References: <20260608110346.3231998-1-jean-louis@dupond.be>
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
 block/qcow2.c                    | 90 ++++++++++++++++++++++++++++----
 qemu-img-cmds.hx                 |  4 +-
 qemu-img.c                       | 37 +++++++++++--
 tests/qemu-iotests/178.out.qcow2 |  6 +--
 tests/qemu-iotests/178.out.raw   |  6 +--
 5 files changed, 121 insertions(+), 22 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 81fd299b4c..3e3578e831 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5231,6 +5231,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     bool has_backing_file;
     bool has_luks;
     bool extended_l2;
+    BlockDriverState *base_bs = NULL;
+    bool base_discard_no_unref = false;
     size_t l2e_size;
 
     /* Parse image creation options */
@@ -5311,6 +5313,21 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
             goto err;
         }
 
+        base_bs = bdrv_find_base(in_bs);
+        /*
+         * bdrv_find_base() returns in_bs itself when the image has no backing
+         * chain. Then this can stay NULL.
+         */
+        if (base_bs == in_bs) {
+            base_bs = NULL;
+        }
+        if (base_bs && base_bs->drv &&
+            !strcmp(base_bs->drv->format_name, "qcow2")) {
+            BDRVQcow2State *base_s = base_bs->opaque;
+
+            base_discard_no_unref = base_s->discard_no_unref;
+        }
+
         virtual_size = ROUND_UP(ssize, cluster_size);
 
         if (has_backing_file) {
@@ -5326,8 +5343,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
 
             for (offset = 0; offset < ssize; offset += pnum) {
                 int ret;
+                int retp = 0;
+                bool count = false;
 
-                ret = bdrv_block_status_above(in_bs, NULL, offset,
+                ret = bdrv_block_status_above(in_bs, base_bs, offset,
                                               ssize - offset, &pnum, NULL,
                                               NULL);
                 if (ret < 0) {
@@ -5336,15 +5355,68 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                     goto err;
                 }
 
-                if (ret & BDRV_BLOCK_ZERO) {
+                if (ret & BDRV_BLOCK_ZERO && !base_bs &&
+                    !base_discard_no_unref) {
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
+                        retp = bdrv_block_status_above(base_bs, NULL, offset,
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
+                        count = retp & BDRV_BLOCK_OFFSET_VALID;
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
index c42dd4e995..0aa53d7ef8 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -5653,6 +5653,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     BlockBackend *in_blk = NULL;
     BlockDriver *drv;
     const char *filename = NULL;
+    const char *base_filename = NULL;
     const char *fmt = NULL;
     const char *out_fmt = "raw";
     char *options = NULL;
@@ -5676,6 +5677,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
         {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS}, /* img_convert */
         {"snapshot", required_argument, 0, 'l'},
+        {"base", required_argument, 0, 'b'},
         {"target-format", required_argument, 0, 'O'},
         {"target-format-options", required_argument, 0, 'o'}, /* img_convert */
         {"options", required_argument, 0, 'o'},
@@ -5686,11 +5688,11 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5701,6 +5703,8 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
 "     instead of a file name (incompatible with --format)\n"
 "  -l, --snapshot SNAPSHOT\n"
 "     use this snapshot in FILE as source\n"
+"  -b, --base BASE\n"
+"     open FILE backing chain up to BASE (inclusive)\n"
 "  -O, --target-format TARGET_FMT\n"
 "     desired target/output image format (default: raw)\n"
 "  -o TARGET_FMT_OPTS\n"
@@ -5738,6 +5742,9 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
                 snapshot_name = optarg;
             }
             break;
+        case 'b':
+            base_filename = optarg;
+            break;
         case 'O':
             out_fmt = optarg;
             break;
@@ -5773,8 +5780,10 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
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
@@ -5787,12 +5796,30 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
     }
 
     if (filename) {
-        in_blk = img_open(image_opts, filename, fmt, 0,
+        int src_flags = 0;
+
+        /*
+         * When measuring with --base, avoid opening the full backing chain.
+         * We selectively open only up to the requested base afterwards.
+         */
+        if (base_filename) {
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
+        }
+
         if (sn_opts) {
             bdrv_snapshot_load_tmp(blk_bs(in_blk),
                     qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
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
2.54.0


