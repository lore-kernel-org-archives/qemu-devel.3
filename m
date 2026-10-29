Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6E606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 05:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMJ0D-0007Am-5P; Thu, 29 Oct 2026 01:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzk-00072X-DC; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gong.shuai@sanechips.com.cn>)
 id 1xMIzh-0000db-3P; Thu, 29 Oct 2026 01:48:12 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4jFYDF6wSMz5B15K;
 Thu, 29 Oct 2026 13:47:57 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
 by mse-fl1.zte.com.cn with SMTP id 69T5lrP4079237;
 Thu, 29 Oct 2026 13:47:53 +0800 (+08)
 (envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
 by smtp (Zmail) with SMTP; Thu, 29 Oct 2026 13:47:55 +0800
X-Zmail-TransId: 3e816ae2de0b027-e6360
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
 Qingye Zhao <zhao.qingye@sanechips.com.cn>,
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 05/14] hw/riscv/riscv-iommu: Split device context fetch
 from cache lookup
Date: Thu, 29 Oct 2026 13:47:42 +0800
Message-ID: <20261029054751.563493-6-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
References: <20261029054751.563493-1-gong.shuai@sanechips.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 69T5lrP4079237
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 13:47:57 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2DE0D.001/4jFYDF6wSMz5B15K
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=gong.shuai@sanechips.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 986921dd5e..10f81f8bdf 100644
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
@@ -2260,7 +2261,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUState *s)
         return;
     }
 
-    ctx = riscv_iommu_ctx(s, devid, pid, perm, iova, &ref);
+    ctx = riscv_iommu_ctx_lookup(s, devid, pid, perm, iova, &ref);
     if (ctx == NULL) {
         riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE,
                                  RISCV_IOMMU_TR_RESPONSE_FAULT |
@@ -2619,7 +2620,7 @@ static MemTxResult riscv_iommu_trap_write(void *opaque, hwaddr addr,
     /* FIXME: PCIe bus remapping for attached endpoints. */
     devid |= s->bus << 8;
 
-    ctx = riscv_iommu_ctx(s, devid, 0, IOMMU_RW, addr, &ref);
+    ctx = riscv_iommu_ctx_lookup(s, devid, 0, IOMMU_RW, addr, &ref);
     if (ctx == NULL) {
         res = MEMTX_ACCESS_ERROR;
     } else {
@@ -2927,7 +2928,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
     };
     uint32_t devid = riscv_iommu_space_devid(as);
 
-    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, flag, addr, &ref);
+    ctx = riscv_iommu_ctx_lookup(as->iommu, devid, iommu_idx, flag, addr, &ref);
     if (ctx == NULL) {
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 099faa9480..3e10647975 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -142,6 +142,11 @@ struct RISCVIOMMUContext {
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


