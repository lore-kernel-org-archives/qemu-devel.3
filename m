Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8826CCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 14:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI5fo-0003dJ-DF; Sat, 17 Oct 2026 10:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xI5fS-0003cF-6k; Sat, 17 Oct 2026 10:45:59 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xI5fP-0006Bd-Ob; Sat, 17 Oct 2026 10:45:49 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-05 (Coremail) with SMTP id zQCowAC3JUAWitNq++SwCw--.2946S2;
 Sat, 17 Oct 2026 22:45:43 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, qemu-riscv@nongnu.org,
 Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH v2 2/2] hw/riscv/riscv-iommu: reclaim invalidated IOATC entries
Date: Sat, 17 Oct 2026 22:45:33 +0800
Message-ID: <20261017144533.15610-2-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
References: <20261017143943.15521-1-tanchi25@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAC3JUAWitNq++SwCw--.2946S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWrtw1rAFy8JrW5tw43Jrb_yoWDJw4Upr
 4Sgr4akryUJF17tr4rt3Z7CF40g397WFZ8W3s8G3ykA3ZFkrWIqFs8Ja4rZ398CFyxZ34j
 yw4Yqa1jyr1UtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

The measurements use a Linux 7.3-rc5 guest based on linux-iommu/next
commit cec2dc7663e7 with v6 of the "iommu/riscv: Enable MSI remapping,
IOMMU_DMA and VFIO" series applied. The QEMU behavior is not specific to
this guest kernel; this configuration makes it easier to exercise through
normal DMA map/unmap activity.

In a high-churn NVMe workload with frequent DMA map/unmap activity, runtime
drops from 168 seconds to 35 seconds, a 4.8x speedup.

A short fio workload with a small working set remains within measurement
noise. Across three runs for each version of a 300-second fio workload with
a 4 GiB working set, median throughput improves from 68.6 MiB/s to
75.0 MiB/s, an increase of 9.3%.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/riscv-iommu.c | 122 +++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 66 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index bd34c72868..c217a428de 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1582,104 +1582,93 @@ static guint riscv_iommu_iot_hash(gconstpointer v)
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
 
 /* caller must hold iot_lock */
@@ -1712,7 +1701,7 @@ static void riscv_iommu_iot_update(RISCVIOMMUState *s, RISCVIOMMUEntry *iot)
     g_hash_table_add(s->iot_cache, iot);
 }
 
-static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
+static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHRFunc func,
     uint32_t gscid, uint32_t pscid, hwaddr iova, RISCVIOMMUTransTag transtag)
 {
     RISCVIOMMUEntry key = {
@@ -1723,7 +1712,7 @@ static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
     };
 
     qemu_mutex_lock(&s->iot_lock);
-    g_hash_table_foreach(s->iot_cache, func, &key);
+    g_hash_table_foreach_remove(s->iot_cache, func, &key);
     qemu_mutex_unlock(&s->iot_lock);
 }
 
@@ -1972,7 +1961,8 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
     dma_addr_t addr;
     uint32_t tail, head, ctrl;
     uint64_t cmd_opcode;
-    GHFunc func;
+    GHRFunc iot_func;
+    GHFunc ctx_func;
 
     ctrl = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
     tail = riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQT) & s->cq_mask;
@@ -2035,18 +2025,18 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
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
 
@@ -2066,24 +2056,24 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
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
 
@@ -2091,12 +2081,12 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
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
 
@@ -2106,9 +2096,9 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
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
-- 
2.53.0


