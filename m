Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8778FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 04:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVkMq-0004PF-I6; Mon, 22 Jul 2024 00:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMh-0003e6-0J; Mon, 22 Jul 2024 00:09:35 -0400
Received: from esa11.hc1455-7.c3s2.iphmx.com ([207.54.90.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yaoxt.fnst@fujitsu.com>)
 id 1sVkMe-0001vH-NN; Mon, 22 Jul 2024 00:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721621373; x=1753157373;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0cOZ6dmCMUB1Ol69mJi10wVRsPCmuhLIXW65Q+KR5LE=;
 b=Ng2u27FFZIdOx5lo8+GWqdNp7yCb/MJYP59HlbjfMVJ0Eak9LRLfxctS
 H6JFvAsYf2k8ORfE9cOjGKeKB7ORSDQU1wkMHrLPq97F9WlvyNDGY+Rv+
 olXhuE6SRNoO8bB6F5QKSBEPxSnswfUH9Zgtc3HFRfcq7DmmAtZf9uBHk
 nE2uIUPI1Qpgd4gmGXpCZbWiWu5jNTlYe58CAWfvPScPIVqZCGZL8lS/1
 j1BiyefBw/y8S3Ip7mXS8S32/s6OFXvvFLjQjQW5hGQMLl58Gahq1tUJb
 iKiFsnOs16BuKgI15pK/WZvn8mEj7yVzFR5biHcbibFI3EnOeb/DUeDzj g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="147511123"
X-IronPort-AV: E=Sophos;i="6.09,227,1716217200"; d="scan'208";a="147511123"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 13:09:30 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com
 [192.168.83.67])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id AFE35DB3C7;
 Mon, 22 Jul 2024 13:09:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id EFD66D3F05;
 Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 710A020076D0F;
 Mon, 22 Jul 2024 13:09:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 23FF31A000A;
 Mon, 22 Jul 2024 12:09:26 +0800 (CST)
To: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	qemu-block@nongnu.org
Subject: [PATCH 13/13] block/qcow2-cluster: make range overlap check more
 readable
Date: Mon, 22 Jul 2024 00:07:42 -0400
Message-ID: <20240722040742.11513-14-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28544.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28544.005
X-TMASE-Result: 10-7.902800-10.000000
X-TMASE-MatchedRID: JWe69+O0c4hrFdvBEmTnvE7nLUqYrlslFIuBIWrdOePfUZT83lbkEMcs
 3d4syBEpsd2TAMah+1Oc9VtzZ7deqLiv2sGf+QjZ8bgAAlufLFeGiafRvCBWaVc5Utg/MIXwo8W
 MkQWv6iXBcIE78YqRWo6HM5rqDwqtq07ChqDSzUR/AUnRd27tEbV8V3fsPbIehXxY2kjWQ9HjPV
 4ZEr2BS29hgKLNrGQOazqzMNfnhu3d6fL/EodwzMLaGOV0GygEftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=207.54.90.137;
 envelope-from=yaoxt.fnst@fujitsu.com; helo=esa11.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
Reply-to:  Yao Xingtao <yaoxt.fnst@fujitsu.com>
From:  Yao Xingtao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

use range_overlaps_range() instead of open-coding the overlap check to
improve the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 block/qcow2-cluster.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ce8c0076b3b5..88d65c4b99e6 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -30,6 +30,7 @@
 #include "qcow2.h"
 #include "qemu/bswap.h"
 #include "qemu/memalign.h"
+#include "qemu/range.h"
 #include "trace.h"
 
 int coroutine_fn qcow2_shrink_l1_table(BlockDriverState *bs,
@@ -1408,23 +1409,25 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
     BDRVQcow2State *s = bs->opaque;
     QCowL2Meta *old_alloc;
     uint64_t bytes = *cur_bytes;
+    Range range1, range2, range3;
 
+    range_init_nofail(&range1, guest_offset, bytes);
     QLIST_FOREACH(old_alloc, &s->cluster_allocs, next_in_flight) {
 
-        uint64_t start = guest_offset;
-        uint64_t end = start + bytes;
-        uint64_t old_start = start_of_cluster(s, l2meta_cow_start(old_alloc));
-        uint64_t old_end = ROUND_UP(l2meta_cow_end(old_alloc), s->cluster_size);
+        uint64_t cow_start = l2meta_cow_start(old_alloc);
+        uint64_t cow_end = l2meta_cow_end(old_alloc);
+        uint64_t start = start_of_cluster(s, cow_start);
+        uint64_t end = ROUND_UP(cow_end, s->cluster_size);
 
-        if (end <= old_start || start >= old_end) {
+        range_init_nofail(&range2, start, end - start);
+        if (!range_overlaps_range(&range1, &range2)) {
             /* No intersection */
             continue;
         }
 
+        range_init_nofail(&range3, cow_start, cow_end - cow_start);
         if (old_alloc->keep_old_clusters &&
-            (end <= l2meta_cow_start(old_alloc) ||
-             start >= l2meta_cow_end(old_alloc)))
-        {
+            !range_overlaps_range(&range1, &range3)) {
             /*
              * Clusters intersect but COW areas don't. And cluster itself is
              * already allocated. So, there is no actual conflict.
@@ -1434,9 +1437,9 @@ static int coroutine_fn handle_dependencies(BlockDriverState *bs,
 
         /* Conflict */
 
-        if (start < old_start) {
+        if (guest_offset < start) {
             /* Stop at the start of a running allocation */
-            bytes = old_start - start;
+            bytes = start - guest_offset;
         } else {
             bytes = 0;
         }
-- 
2.41.0


