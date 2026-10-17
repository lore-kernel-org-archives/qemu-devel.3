Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912B7CCF2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5fq-0003dN-Jy; Sat, 17 Oct 2026 10:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xI5fR-0003cD-QW; Sat, 17 Oct 2026 10:45:59 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xI5fP-0006Bb-EV; Sat, 17 Oct 2026 10:45:49 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-05 (Coremail) with SMTP id zQCowABHsTsPitNqkeSwCw--.43652S2;
 Sat, 17 Oct 2026 22:45:40 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v2 1/2] hw/riscv/riscv-iommu: serialize IOATC accesses
Date: Sat, 17 Oct 2026 22:45:32 +0800
Message-ID: <20261017144533.15610-1-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
References: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABHsTsPitNqkeSwCw--.43652S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr4fKr1kur4rJr4rXFWDurg_yoWxGr1Dpr
 W3WrZIvr1rXF17XF43Jwn7CF1vg3Wvgay3X34akanakF4jqrWUXFnxJa4jvrZ8tFWxua42
 yw40g3Z8AF40yF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
 YxC7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
 s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
 0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmiifUUUUU=
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

The IOATC currently keeps references to the hash table while cached
entries are being used. The following change will remove matching
entries during invalidation, which requires cached entry lifetime to be
protected explicitly.

Add an iot_lock to serialize IOATC lookup, update, invalidation, and
reset operations. Copy the fields needed by the translation path while
holding the lock, then release it before updating the IOMMUTLBEntry.

Keep the page-table walk outside the critical section so the lock is not
held across potentially expensive memory accesses.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu.c | 53 ++++++++++++++++++++++++------------------
 hw/riscv/riscv-iommu.h |  1 +
 2 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 323a041b4a..bd34c72868 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1682,7 +1682,7 @@ static void riscv_iommu_iot_inval_gscid_pscid_iova(gpointer key, gpointer value,
     }
 }
 
-/* caller should keep ref-count for iot_cache object */
+/* caller must hold iot_lock */
 static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     GHashTable *iot_cache, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
@@ -1695,27 +1695,26 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     return g_hash_table_lookup(iot_cache, &key);
 }
 
-/* caller should keep ref-count for iot_cache object */
-static void riscv_iommu_iot_update(RISCVIOMMUState *s,
-    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
+/* caller must hold iot_lock */
+static void riscv_iommu_iot_update(RISCVIOMMUState *s, RISCVIOMMUEntry *iot)
 {
     if (!s->iot_limit) {
         return;
     }
 
     if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
-        iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
-                                          riscv_iommu_iot_equal,
-                                          g_free, NULL);
-        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+        GHashTable *old_cache = s->iot_cache;
+        s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
+                                             riscv_iommu_iot_equal,
+                                             g_free, NULL);
+        g_hash_table_unref(old_cache);
     }
-    g_hash_table_add(iot_cache, iot);
+    g_hash_table_add(s->iot_cache, iot);
 }
 
 static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
     uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
-    GHashTable *iot_cache;
     RISCVIOMMUEntry key = {
         .tag = transtag,
         .gscid = gscid,
@@ -1723,9 +1722,9 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
         .iova  = PPN_DOWN(iova),
     };
 
-    iot_cache = g_hash_table_ref(s->iot_cache);
-    g_hash_table_foreach(iot_cache, func, &key);
-    g_hash_table_unref(iot_cache);
+    qemu_mutex_lock(&s->iot_lock);
+    g_hash_table_foreach(s->iot_cache, func, &key);
+    qemu_mutex_unlock(&s->iot_lock);
 }
 
 static RISCVIOMMUTransTag riscv_iommu_get_transtag(RISCVIOMMUContext *ctx)
@@ -1747,15 +1746,14 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 {
     RISCVIOMMUTransTag transtag = riscv_iommu_get_transtag(ctx);
     RISCVIOMMUEntry *iot;
-    IOMMUAccessFlags perm;
+    IOMMUAccessFlags perm = IOMMU_NONE;
     bool enable_pid;
     bool enable_pri;
-    GHashTable *iot_cache;
+    hwaddr phys = 0;
     int fault;
 
     riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
 
-    iot_cache = g_hash_table_ref(s->iot_cache);
     enable_pri = (iotlb->perm == IOMMU_NONE) &&
                  (ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI);
     enable_pid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
@@ -1771,10 +1769,15 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         }
     }
 
-    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova, transtag);
-    perm = iot ? iot->perm : IOMMU_NONE;
+    qemu_mutex_lock(&s->iot_lock);
+    iot = riscv_iommu_iot_lookup(ctx, s->iot_cache, iotlb->iova, transtag);
+    if (iot) {
+        perm = iot->perm;
+        phys = iot->phys;
+    }
+    qemu_mutex_unlock(&s->iot_lock);
     if (perm != IOMMU_NONE) {
-        iotlb->translated_addr = PPN_PHYS(iot->phys);
+        iotlb->translated_addr = PPN_PHYS(phys);
         iotlb->addr_mask = ~TARGET_PAGE_MASK;
         iotlb->perm = perm;
         fault = 0;
@@ -1805,12 +1808,12 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
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
@@ -2674,6 +2677,7 @@ static void riscv_iommu_instance_init(Object *obj)
     s->iot_cache = g_hash_table_new_full(riscv_iommu_iot_hash,
                                          riscv_iommu_iot_equal,
                                          g_free, NULL);
+    qemu_mutex_init(&s->iot_lock);
 
     s->iommus.le_next = NULL;
     s->iommus.le_prev = NULL;
@@ -2690,6 +2694,8 @@ static void riscv_iommu_instance_finalize(Object *obj)
 
     g_hash_table_unref(s->ctx_cache);
     g_hash_table_unref(s->iot_cache);
+
+    qemu_mutex_destroy(&s->iot_lock);
 }
 
 static void riscv_iommu_realize(DeviceState *dev, Error **errp)
@@ -2850,7 +2856,10 @@ void riscv_iommu_reset(RISCVIOMMUState *s)
     riscv_iommu_reg_set32(s, RISCV_IOMMU_REG_IPSR, 0);
 
     g_hash_table_remove_all(s->ctx_cache);
+
+    qemu_mutex_lock(&s->iot_lock);
     g_hash_table_remove_all(s->iot_cache);
+    qemu_mutex_unlock(&s->iot_lock);
 }
 
 static const Property riscv_iommu_properties[] = {
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 7c470ba084..403d10b321 100644
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


