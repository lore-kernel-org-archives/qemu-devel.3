Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84668CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuTH-00038v-HZ; Thu, 23 Oct 2025 08:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiaji1@huawei.com>)
 id 1vBuJN-00044U-U7; Thu, 23 Oct 2025 08:20:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiaji1@huawei.com>)
 id 1vBuJJ-0006tc-RA; Thu, 23 Oct 2025 08:20:57 -0400
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cslX617sXz11WtH;
 Thu, 23 Oct 2025 20:21:58 +0800 (CST)
Received: from kwepemj100010.china.huawei.com (unknown [7.202.194.4])
 by mail.maildlp.com (Postfix) with ESMTPS id E12851401E9;
 Thu, 23 Oct 2025 20:20:41 +0800 (CST)
Received: from huawei.com (10.246.99.10) by kwepemj100010.china.huawei.com
 (7.202.194.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 20:20:39 +0800
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <zhuyangyang14@h-partners.com>, <eric.fangyi@huawei.com>,
 <suxiaodong1@huawei.com>, <wangjian161@huawei.com>, <wangyan122@huawei.com>,
 <liuxiangdong5@huawei.com>, <zhangjiaji1@huawei.com>,
 <wangqinxiao@huawei.com>, <luolongmin@huawei.com>
Subject: [RFC 1/2] block/qcow2-cache: Introduce qcow2_write_l2_entry()
Date: Thu, 23 Oct 2025 20:24:56 +0800
Message-ID: <20251023122457.2610426-2-zhangjiaji1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251023122457.2610426-1-zhangjiaji1@huawei.com>
References: <20251023122457.2610426-1-zhangjiaji1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.10]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100010.china.huawei.com (7.202.194.4)
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=zhangjiaji1@huawei.com; helo=szxga06-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 08:24:37 -0400
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
Reply-to:  zhangjiaji <zhangjiaji1@huawei.com>
From:  zhangjiaji via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zhu Yangyang <zhuyangyang14@huawei.com>

This function will be used in the next optimization patch to flush
only the actually changed portion of the qcow2 L2 Table cache,
instead of flushing the entire L2 Table cache.

Signed-off-by: Zhu Yangyang <zhuyangyang14@h-partners.com>
---
 block/qcow2-cache.c | 33 ++++++++++++++++++++++++++++++---
 block/qcow2.h       |  2 ++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index 23d9588b08..b5378d003d 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -180,7 +180,8 @@ qcow2_cache_flush_dependency(BlockDriverState *bs, Qcow2Cache *c)
 }
 
 static int GRAPH_RDLOCK
-qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
+qcow2_cache_entry_flush_part(BlockDriverState *bs, Qcow2Cache *c, int i,
+                             int l2_index, int nb_clusters)
 {
     BDRVQcow2State *s = bs->opaque;
     int ret = 0;
@@ -226,8 +227,21 @@ qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
         BLKDBG_EVENT(bs->file, BLKDBG_L2_UPDATE);
     }
 
-    ret = bdrv_pwrite(bs->file, c->entries[i].offset, c->table_size,
-                      qcow2_cache_get_table_addr(c, i), 0);
+    if (l2_index < 0) {
+        ret = bdrv_pwrite(bs->file, c->entries[i].offset, c->table_size,
+                          qcow2_cache_get_table_addr(c, i), 0);
+    } else {
+        /* Only flush the actual dirty portions. */
+        int64_t l2_offset = l2_index * l2_entry_size(s);
+        int64_t l2_bytes = nb_clusters * l2_entry_size(s);
+
+        int64_t aligned_offset = QEMU_ALIGN_DOWN(l2_offset, BDRV_SECTOR_SIZE);
+        int64_t aligned_end = QEMU_ALIGN_UP(l2_offset + l2_bytes, BDRV_SECTOR_SIZE);
+        ret = bdrv_pwrite(bs->file, c->entries[i].offset + aligned_offset,
+                          aligned_end - aligned_offset,
+                          qcow2_cache_get_table_addr(c, i) + aligned_offset, 0);
+    }
+
     if (ret < 0) {
         return ret;
     }
@@ -237,6 +251,19 @@ qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
     return 0;
 }
 
+static int GRAPH_RDLOCK
+qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i)
+{
+    return qcow2_cache_entry_flush_part(bs, c, i, -1, 0);
+}
+
+int qcow2_write_l2_entry(BlockDriverState *bs, Qcow2Cache *c, void *l2_tabel,
+                         int l2_index, int nb_clusters)
+{
+    int l2 = qcow2_cache_get_table_idx(c, l2_tabel);
+    return qcow2_cache_entry_flush_part(bs, c, l2, l2_index, nb_clusters);
+}
+
 int qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c)
 {
     BDRVQcow2State *s = bs->opaque;
diff --git a/block/qcow2.h b/block/qcow2.h
index a9e3481c6e..b0ba2e1996 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -1001,6 +1001,8 @@ qcow2_cache_create(BlockDriverState *bs, int num_tables, unsigned table_size);
 int qcow2_cache_destroy(Qcow2Cache *c);
 
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
+int qcow2_write_l2_entry(BlockDriverState *bs, Qcow2Cache *c, void *l2_tabel,
+                         int l2_index, int nb_clusters)
 int GRAPH_RDLOCK qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
 int GRAPH_RDLOCK qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
 int GRAPH_RDLOCK qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
-- 
2.33.0


