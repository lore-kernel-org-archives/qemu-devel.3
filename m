Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBBFC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 06:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6PEN-00077p-A2; Mon, 13 May 2024 02:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEL-00075K-6t; Mon, 13 May 2024 02:32:13 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1s6PEI-0003wc-KH; Mon, 13 May 2024 02:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=3Lsg3g/T/JlEU8eVLXTpK52A6kh8sanvnvIut/yMsmU=; b=jAwPseqyInF/
 +9s5tJdadL8K3aTiZc8HsFkUt86gYLmqm0Ge2y2rfspi5tAwxV6WIFYdm5pbeDiteOL0SQdRB5e0I
 O2e/SIEuq1JTJ3SGPIaXtO31O6XHw6Rst2HYbhLG1juAGhgMfhUvVRwB0ULJjwUxARG9HqzVWy6mo
 idvVk7Ccp6EVgRCFLw54L+AMen6Rf1/wk+4kw8q618pHOp6JlH3dyZcyP5NYYH8KdSRTykEduqeAK
 IIQ5uWwMjYnISFOy7V+SstLbpwkDCbniDfN9AIgvoWTxJMEDVjtEsh7Si4v7loN9JDyly0BHoKFlE
 Loqe8subvE0Nkc+iU4WBEA==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1s6PAR-000qpR-21;
 Mon, 13 May 2024 08:31:56 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 02/11] qcow2: simplify L2 entries accounting for
 discard-no-unref
Date: Mon, 13 May 2024 09:31:54 +0300
Message-Id: <20240513063203.113911-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Commits 42a2890a and b2b10904 introduce handling of discard-no-unref
option in discard_in_l2_slice() and zero_in_l2_slice().  They add even
more if's when chosing the right l2 entry.  What we really need for this
option is the new entry simply to contain the same host cluster offset,
no matter whether we unmap or zeroize the cluster.  For that OR'ing with
the old entry is enough.

This patch doesn't change the logic and is pure refactoring.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2-cluster.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ce8c0076b3..5f057ba2fd 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1946,25 +1946,21 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
             new_l2_entry = new_l2_bitmap = 0;
         } else if (bs->backing || qcow2_cluster_is_allocated(cluster_type)) {
             if (has_subclusters(s)) {
-                if (keep_reference) {
-                    new_l2_entry = old_l2_entry;
-                } else {
-                    new_l2_entry = 0;
-                }
+                new_l2_entry = 0;
                 new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
             } else {
-                if (s->qcow_version >= 3) {
-                    if (keep_reference) {
-                        new_l2_entry |= QCOW_OFLAG_ZERO;
-                    } else {
-                        new_l2_entry = QCOW_OFLAG_ZERO;
-                    }
-                } else {
-                    new_l2_entry = 0;
-                }
+                new_l2_entry = s->qcow_version >= 3 ? QCOW_OFLAG_ZERO : 0;
             }
         }
 
+        /*
+         * No need to check for the QCOW version since discard-no-unref is
+         * only allowed since version 3.
+         */
+        if (keep_reference) {
+            new_l2_entry |= old_l2_entry;
+        }
+
         if (old_l2_entry == new_l2_entry && old_l2_bitmap == new_l2_bitmap) {
             continue;
         }
@@ -2064,19 +2060,19 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
             ((flags & BDRV_REQ_MAY_UNMAP) && qcow2_cluster_is_allocated(type));
         bool keep_reference =
             (s->discard_no_unref && type != QCOW2_CLUSTER_COMPRESSED);
-        uint64_t new_l2_entry = old_l2_entry;
+        uint64_t new_l2_entry = unmap ? 0 : old_l2_entry;
         uint64_t new_l2_bitmap = old_l2_bitmap;
 
-        if (unmap && !keep_reference) {
-            new_l2_entry = 0;
-        }
-
         if (has_subclusters(s)) {
             new_l2_bitmap = QCOW_L2_BITMAP_ALL_ZEROES;
         } else {
             new_l2_entry |= QCOW_OFLAG_ZERO;
         }
 
+        if (keep_reference) {
+            new_l2_entry |= old_l2_entry;
+        }
+
         if (old_l2_entry == new_l2_entry && old_l2_bitmap == new_l2_bitmap) {
             continue;
         }
-- 
2.39.3


