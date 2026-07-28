Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D288C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wojta-0003hd-BM; Tue, 28 Jul 2026 11:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtV-0003Xz-58
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wojtT-0002ho-3A
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:39:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so36631425e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785253137; x=1785857937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aVkbd/prjb9WYwlM7SXvDF45HVgnD6g6uz+iwnib8ps=;
 b=kFGZwmchcNNCaQcsBA5JhavjEeLo9AsGy+RqZLT+NjL5tXkHKaZ0RLU/mr5C78FoyW
 qQ63a59uWuraHsuVTnXLhKN8pw9TmRgNmIbzHONs0+NHmr0zLenjXFFs4EeA83Xl8D9X
 W0h/KqUo7xXuPvmBfrhnQkyBmKEGyUI+kC54zaRmA4cA8UUQtsac5uAEP7JC+nKWiCB0
 OGmeg4NjDfg1AD7rKfQtBqeMRYeJZxE7MYP/9NZS/DkgEJ/CBtvQfQHamXSueMKXE9U6
 lwjfl+PuM0aEIJr9+zn9vGwXVkqw0Bf+O8WcplDgAXmblxlSsEh2cERJLnddE/LmuXPM
 Z29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253137; x=1785857937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aVkbd/prjb9WYwlM7SXvDF45HVgnD6g6uz+iwnib8ps=;
 b=KvDESAh2gJlW4FLCK8gCuixyGJY1lrPPLBJnT5QLmC1kuPNZQHHFUvKcK6h/AdrdJh
 SE5EaeDPXLTRXOeiFjsRkdgeb52OznXdGJsvRfSWaRvQhsUanOB4m99mx2yGbnd8Egwb
 kPuYQZMwR2ea8x4z01CwEDXWqcfzxfJbE3pdfp7C1pj/5M8E9pma1VsJ8eE8H0h0WC7/
 RcO/7ILkOSn8jaygSNHGljJISn3gGTwIZ8VS51S+RBjBnwE6xGpd5LM6KS2i9e0H7iIl
 ZXgnDb7ws/zVOBV7/2LWqdONFLkk4FJod+W4FE9Vl3S4DpVrPuJPZr0fUszyb98rGwX9
 suDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHiunQIlfIeTkuSaCKk67xgcLE7BNZjbKfBXHHGYIYWfDzSpnDL8KkwarK2rrpDMVtCmN5KF+f+pJn@nongnu.org
X-Gm-Message-State: AOJu0YyFW99hDRo9VhWeK12O2GrPTD/CAo37IcPU22ujufBd9jReNd+m
 iScipCiKTiM2t7++Dt6jPwXWmWU23yPNs76lepyTkYzVhJ8reuZGZBiFeTvILjv8ceU=
X-Gm-Gg: AR+sD11y1esMMDBCSAxMDsHc0Az6f1eHtadqG3RkVe4bUVCEz0/oO6RFDwzY0Fg0pwJ
 R5h2aszJARZLeXzIXxtCU0Bs7UDzCD5PkcMChBB+4xcfB8enZS2txL4QTsZEVJKJfNCHQFwjMJr
 +dzjk5uzxzXtsYRv5k0u6KuCtGMK/yAIC9zZTDh9+DmL7dsnmczn7kJddoV2Q5YTZYl2O5IQh8J
 ff2MI/cYQ84gjrzN1y3GqHAIWRIvZII6P4urQAYutm/QD1IWcWt/KSk8bHawuLS9AUNEmz8vXsW
 lrvJN0I7Q3dJi8woaxBlcoW6ziCpMtCXGVacd7wFttAjGCUynFkro0fIfx2SDR2tMu4vUkQV0c8
 z90bAO17eJtcah8QPlEDsFRH/mbTm8tTBuYU5WpBZy7sgU3gdBvpOB4ZJYk0DeMRhB+2l9r6fmg
 ==
X-Received: by 2002:a05:600c:4694:b0:493:f528:58ac with SMTP id
 5b1f17b1804b1-496c657a89dmr37477855e9.21.1785253137479; 
 Tue, 28 Jul 2026 08:38:57 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f939c1465sm44190499f8f.26.2026.07.28.08.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:38:56 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 5/9] parallels: validate bitmap L1 table size before
 allocating it
Date: Tue, 28 Jul 2026 17:38:45 +0200
Message-ID: <20260728153849.601939-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728153849.601939-1-den@openvz.org>
References: <20260728153849.601939-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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

parallels_load_bitmap() allocated the L1 table sized directly from
the untrusted l1_size field, only cross-checking it against the
bitmap's actual size after the allocation and the L1 table copy had
already happened.

Compute the expected size and reject a mismatch before touching the
allocator, instead of after.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/parallels-ext.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 3410daa620..97744c9696 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -70,20 +70,11 @@ parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
     uint64_t offset, limit;
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
     uint8_t *buf = NULL;
-    uint64_t i, tab_size =
-        DIV_ROUND_UP(bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size),
-                     s->cluster_size);
-
-    if (tab_size != l1_size) {
-        error_setg(errp, "Bitmap table size %" PRIu32 " does not correspond "
-                   "to bitmap size and cluster size. Expected %" PRIu64,
-                   l1_size, tab_size);
-        return -EINVAL;
-    }
+    uint64_t i;
 
     buf = qemu_blockalign(bs, s->cluster_size);
     limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
-    for (i = 0, offset = 0; i < tab_size; ++i, offset += limit) {
+    for (i = 0, offset = 0; i < l1_size; ++i, offset += limit) {
         uint64_t count = MIN(bm_size - offset, limit);
         uint64_t entry = l1_table[i];
 
@@ -124,12 +115,14 @@ static BdrvDirtyBitmap * GRAPH_RDLOCK
 parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
                       Error **errp)
 {
+    BDRVParallelsState *s = bs->opaque;
     int ret;
     ParallelsDirtyBitmapFeature bf;
     g_autofree uint64_t *l1_table = NULL;
     BdrvDirtyBitmap *bitmap;
     QemuUUID uuid;
     char uuidstr[UUID_STR_LEN];
+    uint64_t bm_size, tab_size;
     int i;
 
     if (data_size < sizeof(bf)) {
@@ -164,6 +157,17 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
         return NULL;
     }
 
+    bm_size = bdrv_dirty_bitmap_size(bitmap);
+    tab_size = DIV_ROUND_UP(
+        bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size),
+        s->cluster_size);
+    if (tab_size != bf.l1_size) {
+        error_setg(errp, "Bitmap table size %" PRIu32 " does not correspond "
+                   "to bitmap size and cluster size. Expected %" PRIu64,
+                   bf.l1_size, tab_size);
+        goto fail;
+    }
+
     l1_table = g_new(uint64_t, bf.l1_size);
     for (i = 0; i < bf.l1_size; i++, data += sizeof(uint64_t)) {
         l1_table[i] = ldq_le_p(data);
@@ -171,8 +175,7 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
 
     ret = parallels_load_bitmap_data(bs, l1_table, bf.l1_size, bitmap, errp);
     if (ret < 0) {
-        bdrv_release_dirty_bitmap(bitmap);
-        return NULL;
+        goto fail;
     }
 
     /* We support format extension only for RO parallels images. */
@@ -180,6 +183,10 @@ parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
     bdrv_dirty_bitmap_set_readonly(bitmap, true);
 
     return bitmap;
+
+fail:
+    bdrv_release_dirty_bitmap(bitmap);
+    return NULL;
 }
 
 static int GRAPH_RDLOCK
-- 
2.53.0


