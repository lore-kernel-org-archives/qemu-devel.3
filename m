Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C19C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 07:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4x2O-0007Uh-2B; Wed, 16 Apr 2025 03:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2J-0007S3-Hd; Wed, 16 Apr 2025 03:18:21 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1u4x2D-0001od-Lf; Wed, 16 Apr 2025 03:18:17 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eafe:6901:38ac:f342:2515:2d3c])
 by apollo.dupie.be (Postfix) with ESMTPSA id C4CD61520F9C;
 Wed, 16 Apr 2025 09:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1744787883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMhXkyKs9C1vd0QyPMuiY7jcH+grkGMWCQRu0SAGVDw=;
 b=Lc8ZRlFQTNQ3jHcy93D8LLM52P0DAcU+VBYSQBhqIJ/35BIV5psl2a8w9F/fSI1uZN9+GW
 Rc3q97jDBML1qwra5fUsq+BBtA2YhuR8E8bV3nOXA8/Mt5aSgL1oQgMkF0+R4lAZBAGLNE
 Z3EiVSU+ryZS9SG5v4O01TP9OK5U4zd+BA49RzAtZYmUhCo6q05vTk6fZPufv6Qz37Mnb0
 wnlBiCNbxcJo0cTbUMyB0Vw27A1LqA2K7nF6jAiVqHGh77uWHtl65pTWSa8pkmg9WOrfeG
 CG5GPMsfUZ4gYJFOgDGt70sYFVBqrqv8lx/ANQqTCEUqmyhltwY9Hin7LMAhbw==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 2/3] qcow2: make measure for_commit aware
Date: Wed, 16 Apr 2025 09:16:53 +0200
Message-ID: <20250416071654.978264-3-jean-louis@dupond.be>
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

Sometimes (for example when using block storage for qcow2 images), we
want to be able to calculate the size the commit target image will have.

This patch implements this functionality in the qemu-img command when
the 'for_commit' option is passed.

When calculating for_commit, we check the blocks of the top and base
image, and if new blocks are needed, we increment the next_cluster_index
until everything is allocated for all blocks in the top image.
Then we have a new cluster_index, from where we can calculate the size
of the target image after commit.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 6 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 19028e051c..f86d4f1673 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5086,6 +5086,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
     bool has_backing_file;
     bool has_luks;
     bool extended_l2;
+    bool for_commit;
     size_t l2e_size;
 
     /* Parse image creation options */
@@ -5157,6 +5158,9 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
         goto err;
     }
 
+    /* Check if this measure is for commit size calculation */
+    for_commit = qemu_opt_get_bool_del(opts, BLOCK_OPT_FOR_COMMIT, false);
+
     /* Account for input image */
     if (in_bs) {
         int64_t ssize = bdrv_getlength(in_bs);
@@ -5178,6 +5182,28 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
         } else {
             int64_t offset;
             int64_t pnum = 0;
+            BlockDriverState *parent = NULL;
+            BDRVQcow2State *sp = NULL;
+            int64_t next_cluster_index = 0;
+            int64_t last_cluster_index = 0;
+            int64_t max_allocated_clusters = 0;
+            int64_t freed_clusters = 0;
+
+            if (for_commit) {
+                int64_t psize;
+
+                parent = bdrv_filter_or_cow_bs(in_bs);
+                if (parent) {
+                    sp = parent->opaque;
+                } else {
+                    error_setg(&local_err,
+                        "No parent found, cannot measure for commit");
+                    goto err;
+                }
+                psize = bdrv_getlength(parent);
+                last_cluster_index = qcow2_get_last_cluster(parent, psize);
+                max_allocated_clusters = last_cluster_index;
+            }
 
             for (offset = 0; offset < ssize; offset += pnum) {
                 int ret;
@@ -5191,17 +5217,100 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                     goto err;
                 }
 
-                if (ret & BDRV_BLOCK_ZERO) {
-                    /* Skip zero regions (safe with no backing file) */
-                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
-                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
+                /*
+                 * If this is a measure for_commit then we have a parent
+                 * We check the allocation status of the parent blocks to see
+                 * if we need to allocate new blocks or not.
+                 * We also keep track of the number of freed clusters.
+                 */
+                if (for_commit) {
+                    int retp;
+                    int64_t pnum_parent = 0;
+
+                    /* Check if the parent block is allocated */
+                    retp = bdrv_block_status_above(parent, NULL, offset,
+                                            ssize - offset, &pnum_parent, NULL,
+                                            NULL);
+
+                    if (retp < 0) {
+                        error_setg_errno(&local_err, -ret,
+                                            "Unable to get block status for parent");
+                        goto err;
+                    }
+                    /*
+                     * If the parent continuous block is smaller, use that pnum,
+                     * so the next iteration starts with the smallest offset.
+                     */
+                    if (pnum_parent < pnum) {
+                        pnum = pnum_parent;
+                    }
+
                     /* Extend pnum to end of cluster for next iteration */
                     pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
 
-                    /* Count clusters we've seen */
-                    required += offset % cluster_size + pnum;
+                    uint64_t nb_clusters = size_to_clusters(sp, pnum);
+
+                    /*
+                     * When the block has no offset and the new
+                     * block is non-zero, we will need to
+                     * allocate a new cluster for the commit.
+                     */
+                    if (~retp & BDRV_BLOCK_OFFSET_VALID &&
+                        ~ret & BDRV_BLOCK_ZERO) {
+                        uint64_t i, refcount = 0;
+
+                    retry:
+                        for (i = 0; i < nb_clusters; i++) {
+                            int retr;
+                            next_cluster_index++;
+
+                            retr = qcow2_get_refcount(parent,
+                                next_cluster_index, &refcount);
+                            if (retr < 0) {
+                                error_setg_errno(&local_err, -retr,
+                                    "Unable to get refcount");
+                                goto err;
+                            }
+                            /* No free block found, retry */
+                            if (refcount != 0) {
+                                goto retry;
+                            }
+                        }
+                        /* Check if we have a new maximum cluster index */
+                        if ((next_cluster_index - freed_clusters) >
+                            last_cluster_index &&
+                            (next_cluster_index - freed_clusters) >
+                            max_allocated_clusters) {
+                            max_allocated_clusters =
+                                next_cluster_index - freed_clusters;
+                        }
+                    } else if (!sp->discard_no_unref &&
+                               (ret & BDRV_BLOCK_ZERO) &&
+                               (retp & BDRV_BLOCK_DATA)) {
+                        /*
+                         * Parent block is allocated but new block is zero
+                         * we can free. Except if the parent block is zero.
+                         */
+                        freed_clusters += nb_clusters;
+                    }
+                } else {
+                    if (ret & BDRV_BLOCK_ZERO) {
+                        /* Skip zero regions (safe with no backing file) */
+                    } else if (((ret &
+                                 (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
+                                (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED))) {
+                        /* Extend pnum to end of cluster for next iteration */
+                        pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
+
+                        /* Count clusters we've seen */
+                        required += offset % cluster_size + pnum;
+                    }
                 }
             }
+            if (for_commit) {
+                /* Then the required size is just until the last cluster */
+                required = max_allocated_clusters << sp->cluster_bits;
+            }
         }
     }
 
-- 
2.49.0


