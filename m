Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 773EDC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4q15-0007hF-Jj; Thu, 10 Sep 2026 21:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQD-0001nw-Mi
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ3-0007F0-Mj
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso4491535e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083767; x=1789688567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kJQhdOKNjR/0ShebFeeadPAu9Q3JSbfvQxQRJTWAOqo=;
 b=sFmmZshpQgqMj/WnnA7ry6gQhaCpFkF2Q2ZhXm5uDo/EovCJaEONK4yuDCrIkIKzzB
 GxdQWTrFiYEdhVG/GK7JbdsFfkEZpA9FxpwX4ZMM4Nz9KjTTmjfjPeTnBR+OhuuZOpar
 vlr7QsqlgcrQ4QqdOdgLepUz8WzIWrWewZXZyYvQAOknLwYAQbURkbZ109IlPRb+/8ZC
 +IwtK4YdWJ4qRi18D84mTjuF1pIQvINPoyc7DQ+AO6O7MT6d7vLvZe+K3rG6aCcZ3ZdF
 Nmo0pY/VfjrIb/ie+RMRzldd9G3TwK7BvrQLaKF6UTJdOFJjMM4sB17n3vvmz6Q/QNqd
 r6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083767; x=1789688567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kJQhdOKNjR/0ShebFeeadPAu9Q3JSbfvQxQRJTWAOqo=;
 b=KLbrY1VjzqNPyJLy8nfL7uxz76B9o0OWgUKgGsouMg3s3ho2iOl0OKggZiaIq2cfVB
 rvdZspi7mSY3/TRRZRew/Y2Trp15UPasrVdXkz7tNHcEBw5Xp4EU7vBqd68o1hxBDYpf
 AvdFByk+gPoQsd0w2Do5qiqhJiIyYytay+KeT5nKDYwOfTEHSoPpbLMZWRnwT6Og/rEZ
 nUulVidM6aEuZ3HiB9RJ11qdRmCTBhUO5lG/0TyZHGB6vsCcLX6StVvvdPA4GmYVTPYu
 SYerZSL2EjloY5BSEab5Dkz+J+TPLbReNl6u6AOfmGW8uCE0BscHcmUX0aCMflk+K0ih
 IZPA==
X-Gm-Message-State: AFuF++leLJ2BbcDC6bgB5354j4aT49/hCPQWAk7WiQcCiq2h8M82rKaz
 SgYtImaJ3rGG74biq09Ia1b36Hm2ZeD2zGGtXGA762QWNflx3e3jGveq97AbdUdvfoc=
X-Gm-Gg: AYBFou3W4tHxXVN4zedD7UR3Uhvi53/FG4EjTCF36ZxSU4zPWQO/m2uYdw8QiMoAfsl
 cgd1P2035NHNMyViuVWnv2NXjdnRpuWxjj2x7vzLYCLy+0WpD1lNAjj60Fq+vWU2JDkcxeMVUBT
 4gqXRpsBnX0snJ4ira81lkGyUKvYoIh8IB+iWLjGJ34DamHm/Qp1q+eiBXo/jNN9I7bDYlXyQQ/
 NQGbKmLx4GiF5o+Y89SDzA82HDWDbZHkjheuWrXkgCqFWnUAJ5zum6WoESuHYGcqkpCXlhnHcQX
 y7T20p4yP2m652+ccLbktOdAzvAOSPPiWnSJ5wlt6W6o2w6bR0oqLJgum/4hmpwZC9tRNZJQeYa
 yF8SmfeIvDuiqTvneeYHXngDsEx+tBbMmejFcxaGSpalBhi6w6AgYQAoQm93q9XhmGCDD4EFM27
 y2Bn7s96xkIq/ykzP+iOdwO+ciy0Qm+itCR6Vx8LSKVhTYbwKqjKeFtyhsOvA3xjT6JLw4
X-Received: by 2002:a05:600c:5254:b0:49d:5ff:f404 with SMTP id
 5b1f17b1804b1-49e6197f57emr16034515e9.1.1789083767185; 
 Thu, 10 Sep 2026 16:42:47 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:42:46 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 17/29] parallels: Remove unnecessary data_end field
Date: Fri, 11 Sep 2026 01:42:10 +0200
Message-ID: <20260910234222.3039975-18-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

The two are not equivalent, which is why this comes before the Format
Extension is stored. data_end is the highest extent seen in the BAT,
while the helper derives the end of the payload from the image file. A
cluster which belongs to the image without being referenced by the BAT,
as the Format Extension and its bitmap data clusters are, stays
invisible to the field: parallels_allocate_host_clusters() appends at
data_end, so it would hand out an offset which is already occupied and
parallels_mark_used() would refuse it with -EBUSY, failing the guest
write.

seek_to_sector() validates a BAT entry against data_end, so it becomes
a user of the new helper, which suits that check better as well: a
cluster has to live inside the image file, while the field could grow
to whatever extent a corrupted BAT entry claimed.

The BAT scan in parallels_open() no longer tracks the maximum extent,
but it keeps rejecting entries below data_start or beyond the end of the
file, so need_check is still set when an entry is out of bounds. Nothing
is accumulated any more, so the scan stops at the first such entry.
high_off in parallels_check_outside_image() only fed the
image_end_offset which the helper now provides, so it goes away with
the field.

The bdrv_pwrite_zeroes() of the branch which reuses a hole goes as well.
It was guarded by data_end, and it is redundant: the space was already
fallocated when the image grew over it. The 'bytes' variable goes with
it, as the used bitmap grows by the preallocated size rather than the
requested one.

Based on the original work from Alexander Ivanov.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 57 +++++++++++++----------------------------------
 block/parallels.h |  1 -
 2 files changed, 15 insertions(+), 43 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 2be7c20338..ace79ad968 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -116,6 +116,13 @@ static uint32_t bat_entry_off(uint32_t idx)
     return sizeof(ParallelsHeader) + sizeof(uint32_t) * idx;
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
 {
     uint32_t index, offset;
@@ -130,7 +137,8 @@ static int64_t seek_to_sector(BDRVParallelsState *s, int64_t sector_num)
     }
 
     cluster_off = bat2sect(s, index);
-    if (cluster_off < s->data_start || cluster_off + s->tracks > s->data_end) {
+    if (cluster_off < s->data_start ||
+        cluster_off + s->tracks > parallels_data_end(s) >> BDRV_SECTOR_BITS) {
         /* Cluster is outside of the image file or overlaps the header. */
         return -1;
     }
@@ -284,15 +292,14 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t first_free, next_used, host_off, prealloc_clusters;
-    int64_t bytes, prealloc_bytes;
+    int64_t prealloc_bytes;
     uint32_t new_usedsize;
     int ret = 0;
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
-        bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
 
         /*
@@ -323,27 +330,9 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 
         /* Not enough continuous clusters in the middle, adjust the size */
         *clusters = MIN(*clusters, next_used - first_free);
-        bytes = *clusters * s->cluster_size;
 
         host_off = s->data_start * BDRV_SECTOR_SIZE;
         host_off += first_free * s->cluster_size;
-
-        /*
-         * No need to preallocate if we are using tail area from the above
-         * branch. In the other case we are likely re-using hole. Preallocate
-         * the space if required by the prealloc_mode.
-         */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
-            ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
-            if (ret < 0) {
-                return ret;
-            }
-        }
-    }
-
-    if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-        s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
     }
 
     ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
@@ -749,7 +738,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t i;
-    int64_t off, high_off, size, data_start_off;
+    int64_t off, size, data_start_off;
     bool fixed = false;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -759,7 +748,6 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     }
     data_start_off = s->data_start << BDRV_SECTOR_BITS;
 
-    high_off = 0;
     for (i = 0; i < s->bat_size; i++) {
         off = bat2sect(s, i) << BDRV_SECTOR_BITS;
         if (off == 0) {
@@ -774,10 +762,6 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
                 res->corruptions_fixed++;
                 fixed = true;
             }
-            continue;
-        }
-        if (high_off < off) {
-            high_off = off;
         }
     }
 
@@ -792,14 +776,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    if (high_off == 0) {
-        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
-    } else {
-        res->image_end_offset = high_off + s->cluster_size;
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-    }
-
-
+    res->image_end_offset = parallels_data_end(s);
     return 0;
 }
 
@@ -1466,8 +1443,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1530,10 +1506,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         if (sector < data_start || sector + s->tracks > file_nb_sectors) {
             /* Cluster is outside of the image file or overlaps the header. */
             need_check = true;
-            continue;
-        }
-        if (sector + s->tracks > s->data_end) {
-            s->data_end = sector + s->tracks;
+            break;
         }
     }
 
diff --git a/block/parallels.h b/block/parallels.h
index 493c89e976..eb90aeea81 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.53.0


