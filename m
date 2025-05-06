Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B98C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJ0c-0006hY-0s; Tue, 06 May 2025 10:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1uCJ0Z-0006gv-Eo; Tue, 06 May 2025 10:10:55 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1uCJ0X-000573-Gw; Tue, 06 May 2025 10:10:55 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 24CD42339D;
 Tue,  6 May 2025 17:10:46 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-block@nongnu.org,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu-devel@nongnu.org,
	sdl.qemu@linuxtesting.org
Subject: [PATCH] qcow2: add check for correctness of refcounts
Date: Tue,  6 May 2025 17:10:04 +0300
Message-ID: <20250506141042.99917-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Denis Rastyogin <gerben@altlinux.org>

This error was discovered by fuzzing qemu-img.

Refcounts in an image may point beyond the end of the file.
In this case, we cannot resize such images. Otherwise,
we will at least catch it in qcow2_refcount_area() with
assert(s->get_refcount(refblock_data, j) == 0).

This check ensures that refcounts do not point beyond the end of the file.

Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 block/qcow2.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7774e7f090..b053a313f2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4452,6 +4452,7 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
         int64_t allocation_start, host_offset, guest_offset;
         int64_t clusters_allocated;
         int64_t old_file_size, last_cluster, new_file_size;
+        int64_t old_size, last_used_cluster;
         uint64_t nb_new_data_clusters, nb_new_l2_tables;
         bool subclusters_need_allocation = false;
 
@@ -4480,6 +4481,27 @@ qcow2_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
             old_file_size = ROUND_UP(old_file_size, s->cluster_size);
         }
 
+        /* Ensure that refcount does not point past the end of the actual file size.
+         * If refcount refers to regions beyond the file size, we can't properly call
+         * qcow2_refcount_area. */
+        old_size = bdrv_co_getlength(bs);
+        if (old_size < 0) {
+            error_setg_errno(errp, -old_size,
+                             "Failed to inquire current length");
+            ret = old_size;
+            goto fail;
+        }
+
+        last_used_cluster = qcow2_get_last_cluster(bs, old_size);
+        if (last_used_cluster >= old_file_size / s->cluster_size) {
+            error_setg(errp,
+                "Can't resize: last used cluster (%" PRId64
+                ") exceeds file size (%" PRIu64 " clusters)",
+                last_used_cluster, old_file_size / s->cluster_size);
+                ret = -ERANGE;
+                goto fail;
+        }
+
         nb_new_data_clusters = (ROUND_UP(offset, s->cluster_size) -
             start_of_cluster(s, old_length)) >> s->cluster_bits;
 
-- 
2.42.2


