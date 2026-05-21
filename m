Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D725FCD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPzZ3-000706-OU; Thu, 21 May 2026 05:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wPzZ1-0006zP-TX; Thu, 21 May 2026 05:19:35 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wPzYz-00080m-Kr; Thu, 21 May 2026 05:19:35 -0400
Received: from lt-jeanlouis (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id C27DF1520E41;
 Thu, 21 May 2026 11:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1779355169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/UZueQwEKSVCC9z0Ta2yndbxsEVnuw3VEoY91/2Rqek=;
 b=S/fxK9zR6LSJ3JDbjqU9JaUoiJP6gjGJE3eS90UHkWrG88eeksTFFn4QTvjrbnvHfbArk8
 6rVQEk5g46q/LcrwEkoTTglVfDFtW5enzKWwTpgv0roxZaG8eExg/L/aJP/R9crz0ZC9J/
 BV5h8fo2lqvtyUyFJHwomx9REU60wi/m7An9AJiHs7YRzG/4oxHiP+lQarVGtb0p++7gwc
 rbQPw8shBhoeq6ERrrmtw7x8GsiiUg+WW8HCL3kdh649uWtV0eDmjh4yjwKwNByCtNtt1A
 fu5IU/F96T4IagIYoo3hyVcrDRwh7dUsa2RUdihi5TvSshkW9WSIcC2UiEqtCg==
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jean-Louis Dupond <jean-louis@dupond.be>
Subject: [PATCH v2 1/2] qcow2: move qcow2_check_bitmaps_refcounts func
Date: Thu, 21 May 2026 11:19:17 +0200
Message-ID: <20260521091918.2366140-2-jean-louis@dupond.be>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521091918.2366140-1-jean-louis@dupond.be>
References: <20260521091918.2366140-1-jean-louis@dupond.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Move the qcow2_check_bitmaps_refcounts function in order to be able to
call update_ext_header_and_dir from this function in the following patch.

Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
---
 block/qcow2-bitmap.c | 154 +++++++++++++++++++++----------------------
 1 file changed, 77 insertions(+), 77 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 256ec99878..b87940bb43 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -652,83 +652,6 @@ fail:
     return NULL;
 }
 
-int coroutine_fn
-qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
-                              void **refcount_table,
-                              int64_t *refcount_table_size)
-{
-    int ret;
-    BDRVQcow2State *s = bs->opaque;
-    Qcow2BitmapList *bm_list;
-    Qcow2Bitmap *bm;
-
-    if (s->nb_bitmaps == 0) {
-        return 0;
-    }
-
-    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
-                                   s->bitmap_directory_offset,
-                                   s->bitmap_directory_size);
-    if (ret < 0) {
-        return ret;
-    }
-
-    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
-                               s->bitmap_directory_size, NULL);
-    if (bm_list == NULL) {
-        res->corruptions++;
-        return -EINVAL;
-    }
-
-    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        uint64_t *bitmap_table = NULL;
-        int i;
-
-        ret = qcow2_inc_refcounts_imrt(bs, res,
-                                       refcount_table, refcount_table_size,
-                                       bm->table.offset,
-                                       bm->table.size * BME_TABLE_ENTRY_SIZE);
-        if (ret < 0) {
-            goto out;
-        }
-
-        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
-        if (ret < 0) {
-            res->corruptions++;
-            goto out;
-        }
-
-        for (i = 0; i < bm->table.size; ++i) {
-            uint64_t entry = bitmap_table[i];
-            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
-
-            if (check_table_entry(entry, s->cluster_size) < 0) {
-                res->corruptions++;
-                continue;
-            }
-
-            if (offset == 0) {
-                continue;
-            }
-
-            ret = qcow2_inc_refcounts_imrt(bs, res,
-                                           refcount_table, refcount_table_size,
-                                           offset, s->cluster_size);
-            if (ret < 0) {
-                g_free(bitmap_table);
-                goto out;
-            }
-        }
-
-        g_free(bitmap_table);
-    }
-
-out:
-    bitmap_list_free(bm_list);
-
-    return ret;
-}
-
 /* bitmap_list_store
  * Store bitmap list to qcow2 image as a bitmap directory.
  * Everything is checked.
@@ -1807,3 +1730,80 @@ uint64_t qcow2_get_persistent_dirty_bitmap_size(BlockDriverState *in_bs,
 
     return bitmaps_size;
 }
+
+int coroutine_fn
+qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
+                              void **refcount_table,
+                              int64_t *refcount_table_size)
+{
+    int ret;
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2BitmapList *bm_list;
+    Qcow2Bitmap *bm;
+
+    if (s->nb_bitmaps == 0) {
+        return 0;
+    }
+
+    ret = qcow2_inc_refcounts_imrt(bs, res, refcount_table, refcount_table_size,
+                                   s->bitmap_directory_offset,
+                                   s->bitmap_directory_size);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
+                               s->bitmap_directory_size, NULL);
+    if (bm_list == NULL) {
+        res->corruptions++;
+        return -EINVAL;
+    }
+
+    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
+        uint64_t *bitmap_table = NULL;
+        int i;
+
+        ret = qcow2_inc_refcounts_imrt(bs, res,
+                                       refcount_table, refcount_table_size,
+                                       bm->table.offset,
+                                       bm->table.size * BME_TABLE_ENTRY_SIZE);
+        if (ret < 0) {
+            goto out;
+        }
+
+        ret = bitmap_table_load(bs, &bm->table, &bitmap_table);
+        if (ret < 0) {
+            res->corruptions++;
+            goto out;
+        }
+
+        for (i = 0; i < bm->table.size; ++i) {
+            uint64_t entry = bitmap_table[i];
+            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
+
+            if (check_table_entry(entry, s->cluster_size) < 0) {
+                res->corruptions++;
+                continue;
+            }
+
+            if (offset == 0) {
+                continue;
+            }
+
+            ret = qcow2_inc_refcounts_imrt(bs, res,
+                                           refcount_table, refcount_table_size,
+                                           offset, s->cluster_size);
+            if (ret < 0) {
+                g_free(bitmap_table);
+                goto out;
+            }
+        }
+
+        g_free(bitmap_table);
+    }
+
+out:
+    bitmap_list_free(bm_list);
+
+    return ret;
+}
-- 
2.54.0


