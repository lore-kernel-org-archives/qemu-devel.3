Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65D9FC6167
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp9Kr-0006EL-TH; Fri, 13 Sep 2024 12:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Kn-00064M-T6; Fri, 13 Sep 2024 12:39:51 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sp9Km-0000q8-6E; Fri, 13 Sep 2024 12:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=OeSkIH7knxZGHTt1LuTnXJidyr81oxLIC/BUMuLQL9k=; b=WQ76q1awnvy0
 hJXg5JvCJkLTIfgdT/YLPuixz5rxT2HL5fpeQUyHLGUCQoZtxruReFqs9SezuuRklVoHbyjyfk7ep
 eDhyrtIFGffNvQWgPDA/jKwPojI9lySKt8qf9qPM5T7xq8VuUcrdG61CiGqlR0UOCByYhizaqWtka
 /7a3foqqZYGRtvLO9B/z1rQSl4InCmC29edVDqODKAy+CMSpZo3FbqVG62qmURO9OoCLq9X7/BPoX
 dYWkqX6f40AekujhQbbLuuXGJVDk18xSQmv+pRSUOlXqAHOEaGdnvgrOe2Yg5lIClFpLBDK/1TDq9
 qU1+q7nvmEME3DvAuTjnpg==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1sp9Hy-002OPf-2c;
 Fri, 13 Sep 2024 18:39:39 +0200
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, stefanha@redhat.com, berto@igalia.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 02/12] qcow2: simplify L2 entries accounting for
 discard-no-unref
Date: Fri, 13 Sep 2024 19:39:32 +0300
Message-Id: <20240913163942.423050-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
References: <20240913163942.423050-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
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


