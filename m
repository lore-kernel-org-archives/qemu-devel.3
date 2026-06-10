Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5104CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 02:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX8lO-0000tT-4B; Tue, 09 Jun 2026 22:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.barry@usp.br>)
 id 1wX8lL-0000tC-PH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 22:33:51 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christian.barry@usp.br>)
 id 1wX8lI-0000rS-C9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 22:33:51 -0400
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-963b8b4382dso4271032241.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 19:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781058824; x=1781663624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hdEHEvm4FqvPuP5UPU/JxavhY1NOmOXfeETJraAaVK4=;
 b=BBGBo2BSYdR6fmOzU9oNkJpeqn15NsgComSjgjG8UqYUfLUeVxE409+Ozdg+0INUtI
 HCmqSL9zPkR0vQC4cKW0hZu8GK7MsBUeDoLrv/mAN5AjaBKuLAERbiouz7aAn45Ld1h4
 zQC2Ltn7ZJ4VS2S5gKZcXBaATUKoDH9DD+WHe8Pt3H5NacsQ09ImjzQpQcxuXInDCbqD
 vkve5HGyU3c7XNQ+xzxXdJO9scSxlDugGwr2kXaxiCfCufq31mboDnUnlmBkqFvcP19+
 LZub8Nc9Q0WU4m/RI4OOktK9yJJZlqFuP9HRMKOnQYpOgzcjMdNj5QcRFJ8i7XxPcWpf
 a9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781058824; x=1781663624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdEHEvm4FqvPuP5UPU/JxavhY1NOmOXfeETJraAaVK4=;
 b=P9TXXgVFbsbaD79B9CVSZDuZy5FUyI/NfAaWA7ZORn6vNqlWTUoSnqa3e/Xs+5je+z
 LzJDMWXYbrZJSzwgFxfGBsrpvIaufFup7mv3TGbGsf/sdJvSVZLKxYW1H3VVah86pYyf
 7mjjEUai3BsnvtQZDv2hZYq9QpW+dt0j+4Szqq1e//WcoTnvONsSf/VvjnyhoQ3/CZNc
 WdAnRGvZ5O5BaZYDgClBVb8wp1ASqEfagsir5NzlnuVS3VaatCjGSPZ8Pj/x7svprfNh
 prBXOJfvvrclhuutRiRYgGCMPgkiTAepFlIkWrhg6RklEuKyKGKJhTtW7c+BG+P1E0iq
 dwwA==
X-Gm-Message-State: AOJu0YxxVNlE28iAhNSVaKhmB4t3b0UEIwEsfpZ29yg73N/45+hZhST5
 clximIEt6+4VyMWHmtNMa7/Q72u+yt5vGz/N3lNU8k0Wo3eXcwGIGcJGlz1ZqZuBzCMgbLkRIRG
 Z/C95
X-Gm-Gg: Acq92OErC7DIkZQApDZODJAUPRmwkQ85ZkSTjnQJMsOMa2Y/4qtBj+jcS788pgj5s4E
 sdmXx3/kVL8P+ip5AihqMtjUsnQTTWHX+N8NwSeC4jlwRjDoQb+Qsq3BTBHb2E2FPLIPhOhRee9
 GGFc+SpAp5js3S3p4tVTaQyey6Yda+PioZ24jhcN6cOj3AkgWWWAbw9znbCNPuJICnD/z5OteLN
 fK9LZH5gzQDw5BkCdZ1OTUB3jNxbzzjJ8zRSdyT27h0R/g3WqmVKPnbXB8qi3xr5iqbjgTiKtD9
 VJsnFq29Wu0rKwXBKV7Oz3kIy23PHg8DdaIXYH1S8fViroOUMht+0eOQeKTt2mbtrqLvzZcxFbG
 bCk0KDxm5SJeMCtK3i/HYTjbGBG0vukAvOo2JO/3jlPljqQDUZokzxXho2+qXEy+tV+AQdDTeVz
 d+cIsKr06s61IjPIjkD/Yo
X-Received: by 2002:a05:6102:5986:b0:6ce:7e04:ddae with SMTP id
 ada2fe7eead31-6ff068c6c84mr13460359137.18.1781058823979; 
 Tue, 09 Jun 2026 19:33:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:46:2ef8:2bcd:30b:7b8a:f4ad])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb66965b8bsm19138596137.12.2026.06.09.19.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 19:33:43 -0700 (PDT)
From: Christian Barry <christian.barry@usp.br>
X-Google-Original-From: Christian Barry
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 David de Barros Tadokoro <davidbtadokoro@usp.br>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Barry <christian.barry@usp.br>,
 Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
Subject: [PATCH] block: qcow2-bitmap: fix persistent bitmap corruption on
 ENOSPC
Date: Tue,  9 Jun 2026 23:33:37 -0300
Message-ID: <20260610023337.165474-1-christian.barry@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=christian.barry@usp.br; helo=mail-ua1-x931.google.com
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

From: Christian Barry <christian.barry@usp.br>

Changed qcow2_co_remove_persistent_dirty_bitmap() to treat free_bitmap_clusters()
failure as fatal and roll back the header update through a new helper
function rollback_ext_header_and_dir_helper(), which was also applied
to update_ext_header_and_dir(), which had internal rollback logic.
Changed bitmap_list_store() to zero the cluster tail after write,
guaranteeing that qemu-img won't parse into stale bytes.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3516

Signed-off-by: Christian Barry <christian.barry@usp.br>
Co-developed by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
Signed-off-by: Eduardo Augusto Cavalcanti <eduardoaugustoabc@ime.usp.br>
---
 block/qcow2-bitmap.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 256ec99878..5796298157 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -737,10 +737,12 @@ static int GRAPH_RDLOCK
 bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
                   uint64_t *offset, uint64_t *size, bool in_place)
 {
+    BDRVQcow2State *s = bs->opaque;
     int ret;
     uint8_t *dir;
     int64_t dir_offset = 0;
     uint64_t dir_size = 0;
+    uint64_t tail_size;
     Qcow2Bitmap *bm;
     Qcow2BitmapDirEntry *e;
 
@@ -810,6 +812,14 @@ bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm_list,
         goto fail;
     }
 
+    tail_size = ROUND_UP(dir_size, s->cluster_size) - dir_size;
+    if (tail_size > 0) {
+        ret = bdrv_pwrite_zeroes(bs->file, dir_offset + dir_size, tail_size, 0);
+        if (ret < 0) {
+            goto fail;
+        }
+    }
+
     g_free(dir);
 
     if (!in_place) {
@@ -882,6 +892,19 @@ update_ext_header_and_dir_in_place(BlockDriverState *bs,
      */
 }
 
+static void rollback_ext_header_and_dir_helper(BlockDriverState *bs,
+					       uint64_t old_offset,
+					       uint64_t old_size,
+					       uint32_t old_nb_bitmaps,
+					       uint64_t old_autocl)
+{
+    BDRVQcow2State *s = bs->opaque;
+    s->bitmap_directory_offset = old_offset;
+    s->bitmap_directory_size = old_size;
+    s->nb_bitmaps = old_nb_bitmaps;
+    s->autoclear_features = old_autocl;
+}
+
 static int GRAPH_RDLOCK
 update_ext_header_and_dir(BlockDriverState *bs, Qcow2BitmapList *bm_list)
 {
@@ -937,10 +960,7 @@ fail:
         qcow2_free_clusters(bs, new_offset, new_size, QCOW2_DISCARD_OTHER);
     }
 
-    s->bitmap_directory_offset = old_offset;
-    s->bitmap_directory_size = old_size;
-    s->nb_bitmaps = old_nb_bitmaps;
-    s->autoclear_features = old_autocl;
+    rollback_ext_header_and_dir_helper(bs, old_offset, old_size, old_nb_bitmaps, old_autocl);
 
     return ret;
 }
@@ -1460,6 +1480,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 {
     int ret;
     BDRVQcow2State *s = bs->opaque;
+    uint64_t old_offset = s->bitmap_directory_offset;
+    uint64_t old_size = s->bitmap_directory_size;
+    uint32_t old_nb_bitmaps = s->nb_bitmaps;
+    uint64_t old_autocl = s->autoclear_features;
     Qcow2Bitmap *bm = NULL;
     Qcow2BitmapList *bm_list;
 
@@ -1495,7 +1519,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
         goto out;
     }
 
-    free_bitmap_clusters(bs, &bm->table);
+    ret = free_bitmap_clusters(bs, &bm->table);
+    if (ret < 0){
+	rollback_ext_header_and_dir_helper(bs, old_offset, old_size, old_nb_bitmaps, old_autocl);
+    }
 
 out:
     qemu_co_mutex_unlock(&s->lock);
-- 
2.43.0


