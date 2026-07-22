Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE95EC44532
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 17:06:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmaOB-0005Db-W9; Wed, 22 Jul 2026 13:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO4-0005Bq-Ai
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wmaO2-0001Zg-HP
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 13:05:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4956869750eso14250125e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784739937; x=1785344737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aVkbd/prjb9WYwlM7SXvDF45HVgnD6g6uz+iwnib8ps=;
 b=q+9p02/Hq4w6iGEWAPJlr24s1GZpw3aSO9kWULSP7uIWs6rXqTl9wCGMc45I5IlJ3i
 4eAMd0g5O2U4vYEPqf07ZU3WVzlngAlbIqEwk8XACEAHEuqegKf5YsvlN56PpBu/PtMU
 2D/LWO0it4FgEiGWt3JRFZD5syeg45HxKteyObsvBMA/I1g9a0ZfmuMtsA1HYGiSsMuh
 REZp/G64bn1P2n/Hz825yyJH2xV9W1SwiuY2plfnzX7OuMusV8KuoZsITx5YZ08EoG5U
 tw1G1P4Ih7WlgH7Ye6PhN1OZUVW/O2//KF4PEEBHvcSplUIuA23FAPtX+9hDaL40kPRh
 LS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784739937; x=1785344737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aVkbd/prjb9WYwlM7SXvDF45HVgnD6g6uz+iwnib8ps=;
 b=VDOsoZBQv+yI+7W/URK9fy9oQRXZGyzSgDjS1jF4ZD9mVjgXOMXh8QyZtG96wlWHXM
 uc4tlsw17TCiSH0rb1DMvb21+Suvx1fEEgWYo5R+yabh1ib40vaaEmrRrMsYZwFQN17W
 ZrRrFhAM8Kgh/TFp80yGI5TTP6UYQF9Q7pYAbtIVx3faMY5u5nz87xB8G0sCvvGmKA/t
 sW51V2lm4dyQli51xRjxAbwAYT8+q0xV59p7IMhBq42DBxN+ZJXBdhJZ/hWZo1EmKzV4
 +3BTnP5nXFYPKj31UsHKh+bacNvtxQdD5cxssISvj+YXb8ZeJCggfEz3lZj5pEALRiWQ
 +X9w==
X-Gm-Message-State: AOJu0Yw9JzWDF+P9fPARZ5K+QFPO67+mAIRl1k+VfO4nlTY4PoK5n3yx
 Yckl0KCokeWxtF2HabUcezMXgjwpwyqczDjrKdZuzKLPeYREfmBl43uRJAwG3ktpkQVJx6+HAb6
 u3eJR
X-Gm-Gg: AR+sD11H9/CLVz97ef2N1m1pDRTJ04Dz4B293iV9Q4veLKLqcxQrlg5NZum5fhvyRbt
 Wpim/acZ7stBSE+0UzP+LLUy8plP1H9xGZRm3/hkiYtO22Pv8ZmJPy8KDe1IoxMbw13+K/WqUVp
 VU6gBqVjGO7L5KqeVNZp+sJ1wecHJWccbI+h9voe1Di3QfG725YFr1Bp+jWrPHJvOb4OO/bhWx3
 eMzPDlqQSACbUYwQe9UR9r52AuD4FxflICwHovcLtcgSKLrDNWEqXlyV+sYYWlGbIXT2LsfRgfc
 LAexYbw9e9y5zMTK5PmFSmQ0CoV19y6IkKdgbpK2ChDSyWEYZX6lzslkcOdEhIv5HMiksSi9hsm
 1ZlRhjBahCsQTSInbcUg/+Q2myD7V3RyAcyGI7o6TEf7kIbgrSJzDRG9TkjAxyMDP+7oYt17DAC
 w=
X-Received: by 2002:a05:600c:4fc2:b0:495:5b02:23b0 with SMTP id
 5b1f17b1804b1-4955b0224c7mr214038955e9.26.1784739936740; 
 Wed, 22 Jul 2026 10:05:36 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9c54:c407:8170:580d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b7483f0sm63993215e9.3.2026.07.22.10.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 10:05:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 5/9] parallels: validate bitmap L1 table size before
 allocating it
Date: Wed, 22 Jul 2026 19:05:23 +0200
Message-ID: <20260722170527.2593225-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722170527.2593225-1-den@openvz.org>
References: <20260722170527.2593225-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=den@openvz.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


