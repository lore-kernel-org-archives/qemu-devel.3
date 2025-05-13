Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC847C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 01:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEeYl-0002Gy-AZ; Mon, 12 May 2025 21:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYi-0002FB-Fi; Mon, 12 May 2025 21:35:52 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeYg-00021W-2P; Mon, 12 May 2025 21:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=M37sAYz/UezG1DeFTg2QB3ntIIKeW+/F83Bp66GbxIc=; b=jUFHjnULNk8S
 m+RbMFS0hpJriwh63ow/z2GI7mKAswBT8JrAwQG7ga9KJz3B2ov0E43SPC+UrIHXyToeY0s2UKDDN
 hn1UALkDcu1FXifNGx+ji+uD+IzNc4EaxczW4zW9lrWtIxHOhs/1DJUYXl+O7K7H9CtEIU/SN97x3
 F5AUoH1gCaTZ6ZGnb5plP2z1ivgfAsuKAUhmqkbI7ptxqb9SAHNerf9puxdpQV2VPEeFNfq3yNe8M
 ECi1l1vNu2wx6/ty7QLMB8peIQCjTeWogr+P9+EQe7/pnNq3Vsk/C+be21gtHBM51tNYp9K7kJD7D
 l1GYVgsamdT4Vku9T0FHNw==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1uEeUe-00DboQ-3A; Tue, 13 May 2025 03:35:37 +0200
From: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
To: qemu-block@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Cc: jsnow@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 3/4] block/copy-before-write: reverse access bitmap
Date: Tue, 13 May 2025 03:32:37 +0200
Message-ID: <20250513013238.1213539-4-andrey.zhadchenko@virtuozzo.com>
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

HBitmaps allow us to search set bits pretty fast. On the contrary,
when searching zeroes, we may be forced to fully traverse the lower
level.
When we run blockdev-backup with mode=full on top of snapshot filter
+ cbw filter, the job fills copy bitmap by calling block_status()
with range (X, virtual_size). The problem is that we check for zeroes
in this whole range. We also hit the worst case here, as access
bitmap is fully set and we need to scan the entire lowest level.
After scanning the full bitmap we actually ask the block status of
original image, which may return significantly lower amount of empty
clusters.
Beacuse of this, the backup job 'hangs' on block copy initializaiton
for a long time with 100% CPU.

Example copy bitmap buildup time for image with clu_size=65536 and
preallocated metadata
size                 10T   11T
blockdev-backup      52s   57s
cbw + snap           325s  413s
cbw + snap + patch   55s   61s

To fix it, reverse the access bitmap in cbw filter: rather set it
when the user is not allowed to read the cluster.

Update qemu-iotest 257: now access bitmap have count 0 instead of
the image size 67108864

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block/copy-before-write.c  | 17 ++++++++++-------
 tests/qemu-iotests/257.out | 28 ++++++++++++++--------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index fd470f5f92..5f5b3e7515 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -53,7 +53,7 @@ typedef struct BDRVCopyBeforeWriteState {
     CoMutex lock;
 
     /*
-     * @access_bitmap: represents areas allowed for reading by fleecing user.
+     * @access_bitmap: represents areas disallowed for reading by fleecing user.
      * Reading from non-dirty areas leads to -EACCES.
      */
     BdrvDirtyBitmap *access_bitmap;
@@ -220,7 +220,7 @@ cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return NULL;
     }
 
-    if (bdrv_dirty_bitmap_next_zero(s->access_bitmap, offset, bytes) != -1) {
+    if (bdrv_dirty_bitmap_next_dirty(s->access_bitmap, offset, bytes) != -1) {
         g_free(req);
         return NULL;
     }
@@ -338,8 +338,8 @@ cbw_co_pdiscard_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes)
     aligned_bytes = aligned_end - aligned_offset;
 
     WITH_QEMU_LOCK_GUARD(&s->lock) {
-        bdrv_reset_dirty_bitmap(s->access_bitmap, aligned_offset,
-                                aligned_bytes);
+        bdrv_set_dirty_bitmap(s->access_bitmap, aligned_offset,
+                              aligned_bytes);
     }
 
     block_copy_reset(s->bcs, aligned_offset, aligned_bytes);
@@ -501,9 +501,12 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
     bdrv_disable_dirty_bitmap(s->access_bitmap);
-    bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
-                                     block_copy_dirty_bitmap(s->bcs), NULL,
-                                     true);
+    if (bitmap) {
+        bdrv_dirty_bitmap_merge_internal(s->access_bitmap,
+                                         block_copy_dirty_bitmap(s->bcs), NULL,
+                                         true);
+        bdrv_dirty_bitmap_reverse(s->access_bitmap);
+    }
 
     qemu_co_mutex_init(&s->lock);
     QLIST_INIT(&s->frozen_read_reqs);
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c33dd7f3a9..55efb418e6 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -109,7 +109,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -585,7 +585,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -854,7 +854,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -1330,7 +1330,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -1599,7 +1599,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -2075,7 +2075,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -2344,7 +2344,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -2820,7 +2820,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -3089,7 +3089,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -3565,7 +3565,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -3834,7 +3834,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -4310,7 +4310,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -4579,7 +4579,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
@@ -5055,7 +5055,7 @@ write -P0x67 0x3fe0000 0x20000
     "backup-top": [
       {
         "busy": false,
-        "count": 67108864,
+        "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-- 
2.43.0


