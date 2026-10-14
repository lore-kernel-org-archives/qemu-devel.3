Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E23C3CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGyWH-0006uu-5S; Wed, 14 Oct 2026 08:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu5y-0006Hu-28; Wed, 14 Oct 2026 04:12:18 -0400
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xGu5w-0000vi-1V; Wed, 14 Oct 2026 04:12:17 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4j4P7d5zZjz8Xrrs;
 Wed, 14 Oct 2026 16:12:13 +0800 (CST)
Received: (from root@localhost) by mse-fl2.zte.com.cn id 69E8CBKY099349;
 Wed, 14 Oct 2026 16:12:11 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Message-Id: <202610140812.69E8CBKY099349@mse-fl2.zte.com.cn>
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl2.zte.com.cn with SMTP id 69E80J1n079399;
 Wed, 14 Oct 2026 16:00:19 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Wed, 14 Oct 2026 16:00:22 +0800
X-Zmail-TransId: 3e816acf3695024-0e255
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Wu Fei <wu.fei9@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 05/14] hw/riscv/riscv-iommu: Split device context fetch
 from cache lookup
Date: Wed, 14 Oct 2026 15:59:56 +0800
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
References: <20261014080005.548066-1-gong.shuai@sanechips.com.cn>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl2.zte.com.cn 69E8CBKY099349
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 14 Oct 2026 16:12:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6ACF395D.001/4j4P7d5zZjz8Xrrs
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Oct 2026 08:54:58 -0400
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

The device context lookup mixes parsing the DC from guest memory with
cache management and FQ fault reporting, which does not fit the command
path. Export riscv_iommu_ctx_fetch() to parse a DC straight from guest
memory without cache or fault side effects, and rename riscv_iommu_ctx()
to riscv_iommu_ctx_lookup() to reflect its translation-path role.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 hw/riscv/riscv-iommu.c | 31 ++++++++++++++++---------------
 hw/riscv/riscv-iommu.h |  5 +++++
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 1b408a19ea..19d4cfa503 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1154,13 +1154,13 @@ out:
 }
 
 /*
- * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
+ * RISC-V IOMMU Device Context Fetch - Device Directory Tree Walk
  *
- * @s         : IOMMU Device State
- * @ctx       : Device Translation Context with devid and process_id set.
- * @return    : success or fault code.
+ * Parse the device context for (devid, process_id) from guest memory
+ * into @ctx. Returns 0 on success or a fault code.
  */
-static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
+int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, unsigned devid,
+                          unsigned process_id, RISCVIOMMUContext *ctx)
 {
     const uint64_t ddtp = s->ddtp;
     unsigned mode = get_field(ddtp, RISCV_IOMMU_DDTP_MODE);
@@ -1172,6 +1172,9 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     int depth;
     uint64_t de;
 
+    ctx->devid = devid;
+    ctx->process_id = process_id;
+
     switch (mode) {
     case RISCV_IOMMU_DDTP_MODE_OFF:
         return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
@@ -1425,10 +1428,10 @@ static void riscv_iommu_ctx_inval(RISCVIOMMUState *s, GHFunc func,
 }
 
 /* Find or allocate translation context for a given {device_id, process_id} */
-static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
-                                          unsigned devid, unsigned process_id,
-                                          IOMMUAccessFlags perm, uint64_t iova,
-                                          void **ref)
+static RISCVIOMMUContext *riscv_iommu_ctx_lookup(RISCVIOMMUState *s,
+                                                 unsigned devid, unsigned process_id,
+                                                 IOMMUAccessFlags perm, uint64_t iova,
+                                                 void **ref)
 {
     GHashTable *ctx_cache;
     RISCVIOMMUContext *ctx;
@@ -1452,10 +1455,8 @@ static RISCVIOMMUContext *riscv_iommu_ctx(RISCVIOMMUState *s,
     }
 
     ctx = g_new0(RISCVIOMMUContext, 1);
-    ctx->devid = devid;
-    ctx->process_id = process_id;
 
-    int fault = riscv_iommu_ctx_fetch(s, ctx);
+    int fault = riscv_iommu_ctx_fetch(s, devid, process_id, ctx);
     if (!fault) {
         if (mode != RISCV_IOMMU_DDTP_MODE_BARE) {
             if (g_hash_table_size(ctx_cache) >= LIMIT_CACHE_CTX) {
@@ -2267,7 +2268,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
         return;
     }
 
-    ctx = riscv_iommu_ctx(s, devid, pid, perm, iova, &ref);
+    ctx = riscv_iommu_ctx_lookup(s, devid, pid, perm, iova, &ref);
     if (ctx == NULL) {
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
                                  RISCV_IOMMU_TR_RESPONSE_FAULT |
@@ -2614,7 +2615,7 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     /* FIXME: PCIe bus remapping for attached endpoints. */
     devid |= s->bus << 8;
 
-    ctx = riscv_iommu_ctx(s, devid, 0, IOMMU_RW, addr, &ref);
+    ctx = riscv_iommu_ctx_lookup(s, devid, 0, IOMMU_RW, addr, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
     } else {
@@ -2916,7 +2917,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     };
     uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, flag, addr, &ref);
+    ctx = riscv_iommu_ctx_lookup(as->iommu, devid, iommu_idx, flag, addr, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index ed8d1ee199..84437d8771 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -141,6 +141,11 @@ struct RISCVIOMMUContext {
     uint64_t msiptp;            /* MSI redirection page table pointer */
 };
 
+/* Resolve {devid, process_id} straight from guest memory. Returns 0 or a
+ * RISCV_IOMMU_FQ_CAUSE_* code. */
+int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, unsigned devid,
+                          unsigned process_id, RISCVIOMMUContext *ctx);
+
 /* private helpers */
 
 /* Register helper functions */
-- 
2.53.0


