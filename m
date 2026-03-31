Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6FCFF60C6
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SLh-0003iR-6y; Tue, 31 Mar 2026 02:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w7SLb-0003gP-AA
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:13:07 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guobin@linux.alibaba.com>)
 id 1w7SLX-00032T-2r
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1774937569; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 bh=k/Pw/7AwyXnbAwlCyIMzZnhcQ+HaOc0N3Dc1HQuWsgo=;
 b=i2yoM02uJSQKXvXuxDQUSGbaV4U1/j2rjjLTlSkILYXWK2qkxEyjJ7gqkCKRf9Z6FcZIH/l7R8MOBpEJN7tplaFQMsy9R2GTurpNZkugosdkrimzzADBBWCQWKEdkwaVwqxTNmANKA39d0RfFB4uYGNRa7Nuu5HbEPn1KLmUBk8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam011083073210;
 MF=guobin@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0X03E62i_1774937251; 
Received: from localhost(mailfrom:guobin@linux.alibaba.com
 fp:SMTPD_---0X03E62i_1774937251 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 31 Mar 2026 14:07:40 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [PATCH] memory: Optimize flatview_simplify() to eliminate redundant
 memmove calls
Date: Tue, 31 Mar 2026 14:07:31 +0800
Message-ID: <20260331060731.82641-1-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=guobin@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
X-Spam_score_int: -154
X-Spam_score: -15.5
X-Spam_bar: ---------------
X-Spam_report: (-15.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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

The original flatview_simplify() implementation uses memmove() to shift
array elements after each merge operation, resulting in O(n²) time
complexity in the worst case. This is inefficient for VMs with large
memory topologies containing hundreds of MemoryRegions.

Replace the memmove-based approach with a two-pointer in-place compression
algorithm that achieves O(n) time complexity. The new algorithm uses a
write pointer i and a read pointer j, where i ≤ j is always maintained.
This invariant ensures we never overwrite unprocessed data, making memmove
unnecessary.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 system/memory.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index 56f3225b21..0ff066c348 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -336,24 +336,25 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
 /* Attempt to simplify a view by merging adjacent ranges */
 static void flatview_simplify(FlatView *view)
 {
-    unsigned i, j, k;
+    unsigned i, j;
+
+    if (view->nr <= 1) {
+        return;
+    }
 
     i = 0;
-    while (i < view->nr) {
-        j = i + 1;
-        while (j < view->nr
-               && can_merge(&view->ranges[j-1], &view->ranges[j])) {
+    for (j = 1; j < view->nr; j++) {
+        if (can_merge(&view->ranges[i], &view->ranges[j])) {
             int128_addto(&view->ranges[i].addr.size, view->ranges[j].addr.size);
-            ++j;
-        }
-        ++i;
-        for (k = i; k < j; k++) {
-            memory_region_unref(view->ranges[k].mr);
+            memory_region_unref(view->ranges[j].mr);
+        } else {
+            i++;
+            if (i != j) {
+                view->ranges[i] = view->ranges[j];
+            }
         }
-        memmove(&view->ranges[i], &view->ranges[j],
-                (view->nr - j) * sizeof(view->ranges[j]));
-        view->nr -= j - i;
     }
+    view->nr = i + 1;
 }
 
 static void adjust_endianness(MemoryRegion *mr, uint64_t *data, MemOp op)
-- 
2.50.1 (Apple Git-155)


