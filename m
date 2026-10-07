Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851F0CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEPku-00068b-FC; Wed, 07 Oct 2026 07:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xEPkr-000683-2N; Wed, 07 Oct 2026 07:24:13 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xEPkn-0004bZ-0f; Wed, 07 Oct 2026 07:24:12 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-05 (Coremail) with SMTP id zQCowADHND+0K8Zqm8iMCg--.24585S2;
 Wed, 07 Oct 2026 19:23:55 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH] hw/riscv/riscv-iommu: reclaim invalidated IOATC entries
Date: Wed,  7 Oct 2026 19:23:30 +0800
Message-ID: <20261007112330.298720-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADHND+0K8Zqm8iMCg--.24585S2
X-Coremail-Antispam: 1UD129KBjvAXoW3tw4kCryfKF1fCw18JrW5KFg_yoW8Gw4fJo
 W8ZrWrZa1UWry7A348WrnFkF4xG3yqk3ySvrZ0qF4vk3ZrA3WrG34IvrnxWF9Yqa13CF98
 A3WkX39rJF1UJw1fn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUYS7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
 x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
 JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
 648v4I1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
 v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
 1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
 AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
 42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
 VjvjDU0xZFpf9x0JUQvtAUUUUU=
X-Originating-IP: [159.226.43.8]
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.25;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

IOTINVAL currently walks the IOATC hash table and invalidates matching
entries by setting iot->perm to IOMMU_NONE. The invalidated entries remain
in the hash table afterwards.

Under workloads with frequent DMA map/unmap activity, invalid entries can
accumulate while only a smaller number of entries remain valid. Subsequent
IOTINVAL operations continue to scan these entries. They are also included
in g_hash_table_size(), causing the IOATC to reach iot_limit earlier and
the entire cache to be flushed more frequently.

Remove matching entries during invalidation instead of leaving them in the
hash table with IOMMU_NONE.

Removing an entry also frees it, so a concurrent lookup must not retain a
pointer to an entry being removed. Accesses that modify the IOATC hash table
must also be serialized. Add iot_lock to protect IOATC lookup, update,
invalidation, and reset operations, keeping both the hash table state and
cached entry lifetime valid while they are accessed.

The measurements use a Linux 7.3-rc5 guest based on linux-iommu/next
commit cec2dc7663e7 with v6 of the "iommu/riscv: Enable MSI remapping,
IOMMU_DMA and VFIO" series applied. The QEMU behavior is not specific to
this guest kernel; this configuration makes it easier to exercise through
normal DMA map/unmap activity.

In a high-churn NVMe workload with frequent DMA map/unmap activity, runtime
drops from 168 seconds to 35 seconds, a 4.8x speedup.

A short fio workload with a small working set remains within measurement
noise, showing no measurable regression from the added locking. Across
three runs for each version of a 300-second fio workload with a 4 GiB
working set, median throughput improves from 68.6 MiB/s to 75.0 MiB/s, an
increase of 9.3%.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu.c | 160 ++++++++++++++++++++---------------------
 hw/riscv/riscv-iommu.h |   1 +
 2 files changed, 79 insertions(+), 82 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a..85121f6468 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1582,107 +1582,96 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
 /* GV: 0 AV: 0 PSCV: 0 GVMA: 0 */
 /* GV: 0 AV: 0 GVMA: 1 */
 static
-void riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
+gboolean riscv_iommu_iot_inval_all(gpointer key, gpointer value, gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag;
 }
 
 /* GV: 0 AV: 0 PSCV: 1 GVMA: 0 */
 static
-void riscv_iommu_iot_inval_pscid(gpointer key, gpointer value, gpointer data)
+gboolean riscv_iommu_iot_inval_pscid(gpointer key, gpointer value,
+                                     gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->pscid == arg->pscid) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->pscid == arg->pscid;
 }
 
 /* GV: 0 AV: 1 PSCV: 0 GVMA: 0 */
 static
-void riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
+gboolean riscv_iommu_iot_inval_iova(gpointer key, gpointer value, gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->iova == arg->iova;
 }
 
 /* GV: 0 AV: 1 PSCV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_pscid_iova(gpointer key, gpointer value,
-                                             gpointer data)
+static gboolean riscv_iommu_iot_inval_pscid_iova(gpointer key,
+                                                 gpointer value,
+                                                 gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->pscid == arg->pscid &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->pscid == arg->pscid &&
+           iot->iova == arg->iova;
 }
 
 /* GV: 1 AV: 0 PSCV: 0 GVMA: 0 */
 /* GV: 1 AV: 0 GVMA: 1 */
-static
-void riscv_iommu_iot_inval_gscid(gpointer key, gpointer value, gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid(gpointer key, gpointer value,
+                                            gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid;
 }
 
 /* GV: 1 AV: 0 PSCV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_gscid_pscid(gpointer key, gpointer value,
-                                              gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid_pscid(gpointer key,
+                                                  gpointer value,
+                                                  gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid &&
-        iot->pscid == arg->pscid) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid &&
+           iot->pscid == arg->pscid;
 }
 
 /* GV: 1 AV: 1 PSCV: 0 GVMA: 0 */
 /* GV: 1 AV: 1 GVMA: 1 */
-static void riscv_iommu_iot_inval_gscid_iova(gpointer key, gpointer value,
-                                             gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid_iova(gpointer key,
+                                                 gpointer value,
+                                                 gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid &&
+           iot->iova == arg->iova;
 }
 
 /* GV: 1 AV: 1 PSCV: 1 GVMA: 0 */
-static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
-                                                   gpointer data)
+static gboolean riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key,
+                                                       gpointer value,
+                                                       gpointer data)
 {
     RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
     RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
-    if (iot->tag == arg->tag &&
-        iot->gscid == arg->gscid &&
-        iot->pscid == arg->pscid &&
-        iot->iova == arg->iova) {
-        iot->perm = IOMMU_NONE;
-    }
+    return iot->tag == arg->tag &&
+           iot->gscid == arg->gscid &&
+           iot->pscid == arg->pscid &&
+           iot->iova == arg->iova;
 }
 
-/* caller should keep ref-count for iot_cache object */
+/* caller must hold s->iot_lock */
 static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
@@ -1695,27 +1684,26 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     return g_hash_table_lookup(iot_cache, &key);
 }
 
-/* caller should keep ref-count for iot_cache object */
-static void riscv_iommu_iot_update(RISCVIOMMUState *s,
-    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
+/* caller must hold s->iot_lock */
+static void riscv_iommu_iot_update(RISCVIOMMUState *s, RISCVIOMMUEntry *iot)
 {
     if (!s->iot_limit) {
         return;
     }
 
     if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
-        iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+        GHashTable *old_cache = s->iot_cache;
+        s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
                                           riscv_iommu_iot_equal,
                                           g_free, NULL);
-        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+        g_hash_table_unref(old_cache);
     }
-    g_hash_table_add(iot_cache, iot);
+    g_hash_table_add(s->iot_cache, iot);
 }
 
-static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
+static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHRFunc func,
     uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
-    GHashTable *iot_cache;
     RISCVIOMMUEntry key = {
         .tag = transtag,
         .gscid = gscid,
@@ -1723,9 +1711,9 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
         .iova  = PPN_DOWN(iova),
     };
 
-    iot_cache = g_hash_table_ref(s->iot_cache);
-    g_hash_table_foreach(iot_cache, func, &key);
-    g_hash_table_unref(iot_cache);
+    qemu_mutex_lock(&s->iot_lock);
+    g_hash_table_foreach_remove(s->iot_cache, func, &key);
+    qemu_mutex_unlock(&s->iot_lock);
 }
 
 static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ctx)
@@ -1750,12 +1738,10 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUAccessFlags perm;
     bool enable_pid;
     bool enable_pri;
-    GHashTable *iot_cache;
     int fault;
 
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
-    iot_cache = g_hash_table_ref(s->iot_cache);
     enable_pri = (iotlb->perm == IOMMU_NONE) &&
                  (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
@@ -1771,15 +1757,18 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     }
 
-    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
+    qemu_mutex_lock(&s->iot_lock);
+    iot = riscv_iommu_iot_lookup(ctx, s->iot_cache, iotlb->iova, transtag);
     perm = iot ? iot->perm : IOMMU_NONE;
     if (perm != IOMMU_NONE) {
         iotlb->translated_addr = PPN_PHYS(iot->phys);
         iotlb->addr_mask = ~TARGET_PAGE_MASK;
         iotlb->perm = perm;
         fault = 0;
+        qemu_mutex_unlock(&s->iot_lock);
         goto done;
     }
+    qemu_mutex_unlock(&s->iot_lock);
 
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
 
@@ -1805,12 +1794,12 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
         iot->perm = iotlb->perm;
         iot->tag = transtag;
-        riscv_iommu_iot_update(s, iot_cache, iot);
+        qemu_mutex_lock(&s->iot_lock);
+        riscv_iommu_iot_update(s, iot);
+        qemu_mutex_unlock(&s->iot_lock);
     }
 
 done:
-    g_hash_table_unref(iot_cache);
-
     if (enable_pri && fault) {
         struct riscv_iommu_pq_record pr = {0};
         if (enable_pid) {
@@ -1969,7 +1958,8 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
     dma_addr_t addr;
     uint32_t tail, head, ctrl;
     uint64_t cmd_opcode;
-    GHFunc func;
+    GHRFunc iot_func;
+    GHFunc ctx_func;
 
     ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
     tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
@@ -2032,18 +2022,18 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                 goto cmd_ill;
             }
 
-            func = riscv_iommu_iot_inval_all;
+            iot_func = riscv_iommu_iot_inval_all;
 
             if (gv) {
-                func = (av) ? riscv_iommu_iot_inval_gscid_iova :
+                iot_func = (av) ? riscv_iommu_iot_inval_gscid_iova :
                               riscv_iommu_iot_inval_gscid;
             }
 
             riscv_iommu_iot_inval(
-                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
+                s, iot_func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VG);
 
             riscv_iommu_iot_inval(
-                s, func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
+                s, iot_func, gscid, pscid, iova, RISCV_IOMMU_TRANS_TAG_VN);
             break;
         }
 
@@ -2063,24 +2053,24 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             if (gv) {
                 transtag = RISCV_IOMMU_TRANS_TAG_VN;
                 if (pscv) {
-                    func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_gscid_pscid_iova :
                                   riscv_iommu_iot_inval_gscid_pscid;
                 } else {
-                    func = (av) ? riscv_iommu_iot_inval_gscid_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_gscid_iova :
                                   riscv_iommu_iot_inval_gscid;
                 }
             } else {
                 transtag = RISCV_IOMMU_TRANS_TAG_SS;
                 if (pscv) {
-                    func = (av) ? riscv_iommu_iot_inval_pscid_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_pscid_iova :
                                   riscv_iommu_iot_inval_pscid;
                 } else {
-                    func = (av) ? riscv_iommu_iot_inval_iova :
+                    iot_func = (av) ? riscv_iommu_iot_inval_iova :
                                   riscv_iommu_iot_inval_all;
                 }
             }
 
-            riscv_iommu_iot_inval(s, func, gscid, pscid, iova, transtag);
+            riscv_iommu_iot_inval(s, iot_func, gscid, pscid, iova, transtag);
             break;
         }
 
@@ -2088,12 +2078,12 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                              RISCV_IOMMU_CMD_IODIR_OPCODE):
             if (!(cmd.dword0 & RISCV_IOMMU_CMD_IODIR_DV)) {
                 /* invalidate all device context cache mappings */
-                func = riscv_iommu_ctx_inval_all;
+                ctx_func = riscv_iommu_ctx_inval_all;
             } else {
                 /* invalidate all device context matching DID */
-                func = riscv_iommu_ctx_inval_devid;
+                ctx_func = riscv_iommu_ctx_inval_devid;
             }
-            riscv_iommu_ctx_inval(s, func,
+            riscv_iommu_ctx_inval(s, ctx_func,
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID), 0);
             break;
 
@@ -2103,9 +2093,9 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
                 /* illegal command arguments IODIR_PDT & DV == 0 */
                 goto cmd_ill;
             } else {
-                func = riscv_iommu_ctx_inval_devid_procid;
+                ctx_func = riscv_iommu_ctx_inval_devid_procid;
             }
-            riscv_iommu_ctx_inval(s, func,
+            riscv_iommu_ctx_inval(s, ctx_func,
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_DID),
                 get_field(cmd.dword0, RISCV_IOMMU_CMD_IODIR_PID));
             break;
@@ -2671,6 +2661,7 @@ static void riscv_iommu_instance_init(Object *obj)
                                          riscv_iommu_ctx_equal,
                                          g_free, NULL);
 
+    qemu_mutex_init(&s->iot_lock);
     s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
                                          riscv_iommu_iot_equal,
                                          g_free, NULL);
@@ -2690,6 +2681,8 @@ static void riscv_iommu_instance_finalize(Object *obj)
 
     g_hash_table_unref(s->ctx_cache);
     g_hash_table_unref(s->iot_cache);
+
+    qemu_mutex_destroy(&s->iot_lock);
 }
 
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
@@ -2850,7 +2843,10 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
     riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_IPSR, 0);
 
     g_hash_table_remove_all(s->ctx_cache);
+
+    qemu_mutex_lock(&s->iot_lock);
     g_hash_table_remove_all(s->iot_cache);
+    qemu_mutex_unlock(&s->iot_lock);
 }
 
 static const Property riscv_iommu_properties[] = {
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index da70e8bfa8..16d257a106 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -73,6 +73,7 @@ struct RISCVIOMMUState {
 
     GHashTable *iot_cache;          /* IO Translated Address Cache */
     unsigned iot_limit;             /* IO Translation Cache size limit */
+    QemuMutex iot_lock;
 
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
-- 
2.53.0


