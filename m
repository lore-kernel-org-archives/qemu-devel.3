Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC790CCD1BF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuVH-00075o-Mc; Thu, 23 Oct 2025 08:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiaji1@huawei.com>)
 id 1vBuJP-00047A-Qs; Thu, 23 Oct 2025 08:21:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjiaji1@huawei.com>)
 id 1vBuJK-0006tf-FQ; Thu, 23 Oct 2025 08:20:58 -0400
Received: from mail.maildlp.com (unknown [172.19.88.214])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cslPq41PCz24jKn;
 Thu, 23 Oct 2025 20:16:31 +0800 (CST)
Received: from kwepemj100010.china.huawei.com (unknown [7.202.194.4])
 by mail.maildlp.com (Postfix) with ESMTPS id A47911A016C;
 Thu, 23 Oct 2025 20:20:42 +0800 (CST)
Received: from huawei.com (10.246.99.10) by kwepemj100010.china.huawei.com
 (7.202.194.4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 23 Oct
 2025 20:20:41 +0800
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <zhuyangyang14@h-partners.com>, <eric.fangyi@huawei.com>,
 <suxiaodong1@huawei.com>, <wangjian161@huawei.com>, <wangyan122@huawei.com>,
 <liuxiangdong5@huawei.com>, <zhangjiaji1@huawei.com>,
 <wangqinxiao@huawei.com>, <luolongmin@huawei.com>
Subject: [RFC 2/2] block/qcow2: Improve I/O performance in write-through cache
 mode for qcow2 driver
Date: Thu, 23 Oct 2025 20:24:57 +0800
Message-ID: <20251023122457.2610426-3-zhangjiaji1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251023122457.2610426-1-zhangjiaji1@huawei.com>
References: <20251023122457.2610426-1-zhangjiaji1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.10]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100010.china.huawei.com (7.202.194.4)
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhangjiaji1@huawei.com; helo=szxga05-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Oct 2025 08:24:36 -0400
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

Optimize IO performance in writethrough cache mode by immediately performing
write cache after updating the L2 entry and only flushing the portions that
have actually changed.

Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
---
 block/qcow2-cache.c   |  7 +++++++
 block/qcow2-cluster.c | 15 +++++++++++++++
 block/qcow2.h         |  3 ++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
index b5378d003d..3491cea7fb 100644
--- a/block/qcow2-cache.c
+++ b/block/qcow2-cache.c
@@ -463,6 +463,13 @@ void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table)
     c->entries[i].dirty = true;
 }
 
+bool qcow2_cache_is_dirty(Qcow2Cache *c, void *table)
+{
+    int i = qcow2_cache_get_table_idx(c, table);
+    assert(c->entries[i].offset != 0);
+    return c->entries[i].dirty;
+}
+
 void *qcow2_cache_is_table_offset(Qcow2Cache *c, uint64_t offset)
 {
     int i;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index ce8c0076b3..95b0e44c6e 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1032,6 +1032,10 @@ int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs,
     int i, j = 0, l2_index, ret;
     uint64_t *old_cluster, *l2_slice;
     uint64_t cluster_offset = m->alloc_offset;
+    bool part_flush = false;
+    /* I haven't figured out yet how to perceive this IO
+     * as a writethrough cache mode. */
+    bool writethrough = true;
 
     trace_qcow2_cluster_link_l2(qemu_coroutine_self(), m->nb_clusters);
     assert(m->nb_clusters > 0);
@@ -1061,6 +1065,13 @@ int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs,
     if (ret < 0) {
         goto err;
     }
+
+    /* If the cache is clean before qcow2_cache_entry_mark_dirty(),
+     * we can flush only the modified L2 entries..
+     */
+    if (writethrough && !qcow2_cache_is_dirty(s->l2_table_cache, l2_slice)) {
+        part_flush = true;
+    }
     qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
 
     assert(l2_index + m->nb_clusters <= s->l2_slice_size);
@@ -1102,6 +1113,10 @@ int coroutine_fn qcow2_alloc_cluster_link_l2(BlockDriverState *bs,
      }
 
 
+     if (part_flush) {
+        qcow2_write_l2_entry(bs, s->l2_table_cache, l2_slice, l2_index,
+                             m->nb_clusters);
+     }
     qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
 
     /*
diff --git a/block/qcow2.h b/block/qcow2.h
index b0ba2e1996..8fb59c4e87 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -1000,9 +1000,10 @@ qcow2_cache_create(BlockDriverState *bs, int num_tables, unsigned table_size);
 
 int qcow2_cache_destroy(Qcow2Cache *c);
 
+bool qcow2_cache_is_dirty(Qcow2Cache *c, void *table);
 void qcow2_cache_entry_mark_dirty(Qcow2Cache *c, void *table);
 int qcow2_write_l2_entry(BlockDriverState *bs, Qcow2Cache *c, void *l2_tabel,
-                         int l2_index, int nb_clusters)
+                         int l2_index, int nb_clusters);
 int GRAPH_RDLOCK qcow2_cache_flush(BlockDriverState *bs, Qcow2Cache *c);
 int GRAPH_RDLOCK qcow2_cache_write(BlockDriverState *bs, Qcow2Cache *c);
 int GRAPH_RDLOCK qcow2_cache_set_dependency(BlockDriverState *bs, Qcow2Cache *c,
-- 
2.33.0


