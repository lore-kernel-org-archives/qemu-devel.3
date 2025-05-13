Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7927C3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeYm-0002If-SP; Mon, 12 May 2025 21:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYi-0002F1-Cy; Mon, 12 May 2025 21:35:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYf-00021T-Vp; Mon, 12 May 2025 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=o76L16+85oXwxINpy+kttS3ujUGzFeqh/Z5rK6Yd30A=; b=sYq6qqZJtCIi
 mob/IlvSIwTcwVRxDbI2ZBcogj/VFPV27TEIVL2GpW/Ybg/MQlnE9Ax5z0j2VN46VokneLb9CKyAc
 oowjJ6K0Wxolize8ytDSwdaQBcHv6UeOAJ04jmD9y0up9yyzig0I2J2FR1uEeDRUm0ypk3YB0ehb6
 EoWpmjAEgC7+ZRiva5VJVTwqK8xp/rBrgPwPu4RG/mQmt0wQOOCbGIwtyZAjzK7L04qdsjKEZwPMV
 mbMYbajDft+Zmd4psP+DzcFw7Oau67H3zkgDJDmihiNEYgWWqw36+lDzrwHj/znYK/H41EetFVolQ
 MKeaLjmQhLfL+hU0zs/4Wg==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeUe-00DboQ-0k; Tue, 13 May 2025 03:35:36 +0200
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 1/4] hbitmap: drop meta bitmap leftovers
Date: Tue, 13 May 2025 03:32:35 +0200
Message-ID: <20250513013238.1213539-2-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
References: <20250513013238.1213539-1-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

API to manipulate meta bitmap was removed with commit 0c88f1970c76

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 util/hbitmap.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index d9a1dabc63..16674f33e4 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -84,9 +84,6 @@ struct HBitmap {
      */
     int granularity;
 
-    /* A meta dirty bitmap to track the dirtiness of bits in this HBitmap. */
-    HBitmap *meta;
-
     /* A number of progressively less coarse bitmaps (i.e. level 0 is the
      * coarsest).  Each bit in level N represents a word in level N+1 that
      * has a set bit, except the last level where each bit represents the
@@ -480,10 +477,7 @@ void hbitmap_set(HBitmap *hb, uint64_t start, uint64_t count)
     n = last - first + 1;
 
     hb->count += n - hb_count_between(hb, first, last);
-    if (hb_set_between(hb, HBITMAP_LEVELS - 1, first, last) &&
-        hb->meta) {
-        hbitmap_set(hb->meta, start, count);
-    }
+    hb_set_between(hb, HBITMAP_LEVELS - 1, first, last);
 }
 
 /* Resetting works the other way round: propagate up if the new
@@ -577,10 +571,7 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint64_t count)
     assert(last < hb->size);
 
     hb->count -= hb_count_between(hb, first, last);
-    if (hb_reset_between(hb, HBITMAP_LEVELS - 1, first, last) &&
-        hb->meta) {
-        hbitmap_set(hb->meta, start, count);
-    }
+    hb_reset_between(hb, HBITMAP_LEVELS - 1, first, last);
 }
 
 void hbitmap_reset_all(HBitmap *hb)
@@ -784,7 +775,6 @@ void hbitmap_deserialize_finish(HBitmap *bitmap)
 void hbitmap_free(HBitmap *hb)
 {
     unsigned i;
-    assert(!hb->meta);
     for (i = HBITMAP_LEVELS; i-- > 0; ) {
         g_free(hb->levels[i]);
     }
@@ -868,9 +858,6 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
                    (size - old) * sizeof(*hb->levels[i]));
         }
     }
-    if (hb->meta) {
-        hbitmap_truncate(hb->meta, hb->size << hb->granularity);
-    }
 }
 
 /**
-- 
2.43.0


