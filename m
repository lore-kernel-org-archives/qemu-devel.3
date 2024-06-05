Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF0FC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 09:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEmeP-0003NQ-74; Wed, 05 Jun 2024 05:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1sEmeM-0003KP-J3
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:09:42 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1sEmeJ-0007RT-Ur
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 05:09:42 -0400
Received: from localhost.localdomain (unknown
 [IPv6:2a02:a03f:eaf7:ff01:ba43:94d2:9111:d35b])
 by apollo.dupie.be (Postfix) with ESMTPSA id 6D6F61520BCB;
 Wed,  5 Jun 2024 11:09:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1717578573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xaRh2kDvJmOUpmn9eMQF8FZeFdT0cxw4cSRTquv3wgA=;
 b=jFWB+xnFc7gDtxWiA2iWww/QFzLjYcv3MmlRPhI0y5voncVdFYTLd6utLKm2IDPiPUeMZT
 AfFJ2smXwBoJFJfsIMsYc1W6cF/9xcXRJUPbZIRRcLt0BkEAEN/KUBR6PYcQvIPi8FKkV8
 uKZhjI0XCrF9Z1tYsXtRWzZaCQ1/+RQL/BU+R+GpaTsCGOTMebCX1m21tLm6oSP0CBUqEo
 yOvta9cFq+Vo1PhCg+WjwzYOfVkNU2/iAXDQnoJ4HaRgGjgxXdnIOD5DtClrXe05xQAZkQ
 UZlBF6hYQk8RTyPcsEzCP+a3vsBEauAtHXLtwOBjJ3u1UNdpRq2lrehk8OsR1w==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com
Cc: Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH 1/2] qcow2: handle discard-no-unref in measure
Date: Wed,  5 Jun 2024 11:06:39 +0200
Message-ID: <20240605090639.3402698-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When doing a measure on an image with a backing file and
discard-no-unref is enabled, the code should take this into account.

If for example you have a snapshot image with a base, and you do a
discard within the snapshot, it will be ZERO and ALLOCATED, but without
host offset.
Now if we commit this snapshot, and the clusters in the base image were
allocated, the clusters will only be set to ZERO, but the host offset
will not be cleared.
Therefor ZERO & ALLOCATED clusters in the top image need to check the
base to see if space will be freed or not, to have a correct measure
output.

Bug-Url: https://gitlab.com/qemu-project/qemu/-/issues/2369
Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 956128b409..1ce7ebbab4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5163,9 +5163,16 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
         } else {
             int64_t offset;
             int64_t pnum = 0;
+            BlockDriverState *parent = bdrv_filter_or_cow_bs(in_bs);
+            BDRVQcow2State *s = NULL;
+
+            if (parent) {
+                s = parent->opaque;
+            }
 
             for (offset = 0; offset < ssize; offset += pnum) {
                 int ret;
+                int retp = 0;
 
                 ret = bdrv_block_status_above(in_bs, NULL, offset,
                                               ssize - offset, &pnum, NULL,
@@ -5176,10 +5183,33 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
                     goto err;
                 }
 
-                if (ret & BDRV_BLOCK_ZERO) {
+                /* If we have a parent in the chain and the current block is zero but allocated,
+                 * then we want to check the allocation state of the parent block.
+                 * If it was allocated and now zero, we want
+                 * to include it into the calculation, cause it will not free space when
+                 * committing the top into base with discard-no-unref enabled.
+                 */
+                if (parent &&
+                    ((ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) ==
+                     (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) &&
+                     s->discard_no_unref) {
+                        int64_t pnum_parent = 0;
+                        retp = bdrv_block_status_above(parent, NULL, offset,
+                                              ssize - offset, &pnum_parent, NULL,
+                                              NULL);
+                        // Check if parent block has an offset
+                        if (retp & BDRV_BLOCK_OFFSET_VALID) {
+                            pnum = retp;
+                        }
+                }
+                if (ret & BDRV_BLOCK_ZERO && !retp) {
                     /* Skip zero regions (safe with no backing file) */
-                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
-                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
+                } else if (((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
+                            (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ||
+                           (((ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) ==
+                             (BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED)) &&
+                            s && s->discard_no_unref &&
+                            retp & BDRV_BLOCK_OFFSET_VALID)) {
                     /* Extend pnum to end of cluster for next iteration */
                     pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
 
-- 
2.45.2


