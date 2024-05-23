Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41B8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sACRY-00015W-4p; Thu, 23 May 2024 13:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQm-0000fL-Fp
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sACQk-0001aZ-7S
 for qemu-devel@nongnu.org; Thu, 23 May 2024 13:40:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f338ebe621so9078365ad.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1716486038; x=1717090838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3v9hr4DSfBYrEcwkZvyk5t7Ar8Q2ZfJT93p6JQw1Xps=;
 b=Voh6XabfOleJYShbH40vPGHhQ2kS9ht96PoUAEqBv56lx1rw6l2pj39DYO18kt6hVx
 MQM9AG68JPzu3dlg3tpSkaMGyH3+m0pLgUrTfj52DIy9/Baogt1RxR+pao7MOoc3tRbI
 YcFr83Q6TUrROiS1lqcqRcTInktq8oXvTyf0+ZB52DK9u3P2v24GI2NuPo9IWui1P8H8
 PPS30LXN774QwIbhdrbZXZh52473ue+X6hds8AOUzHL1qZ813vz/+HwTuQIm0YnhKFjy
 y196lRdJgCWHRkoqEeRFD9QelT8xDW5Y/mc9Cy0Jr7c5VqSiyxH3ccud8M+OI0Cjux+r
 aVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716486038; x=1717090838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3v9hr4DSfBYrEcwkZvyk5t7Ar8Q2ZfJT93p6JQw1Xps=;
 b=e2/SfiivJGx6iKyAWBWcGA159KeiKnndWB078KWk0M2HYTB7vwas5ayQDVQ5efsvCE
 e98XfDjMpxhQNL0w2s2Qnkmb4uaH3F7yDeM9oyGCoTsjC9tBtlBoySqoirZeM27QyMI4
 auC31s261kHMkdx5e52sezrEE8snteDxowNwUJ+yAp4yUkuHwXhJqjqyBkiJnIRwlUv6
 txfGNY68yfVAZzt2e79jAIpGGfwMzFUCoBLtFlKg5Y6qAKuv1oazSp7fah03pGLCEdmg
 uqV649nSbg21shFHS4zH8Jw7EHlpdl3sIM0FmVpzgxdumaic5od5CgTH7/vAva+EHNBm
 VE9g==
X-Gm-Message-State: AOJu0Yykejl0iwltdum9MTu5c0wZTnbgS5cn5Df7kpbm6uNUhD5l7iEa
 bC2ywZyWkp7AXwhF1VAW7Mf2R8kekjhCdmH+KmaErcfRl89sNh3gJ8Vmx6wjKk4talxdQI6mcjQ
 +
X-Google-Smtp-Source: AGHT+IFJj5NojPZBAmBKJZgqmu6bntzTiyn/p+woog8hFQnLvAshOkKrzPSYnVYSpsCTn5gsQzTXNg==
X-Received: by 2002:a17:902:ce08:b0:1f3:325a:8236 with SMTP id
 d9443c01a7336-1f44814bfa2mr1748795ad.12.1716486038450; 
 Thu, 23 May 2024 10:40:38 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.42.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f2fb4ca0ebsm81246535ad.119.2024.05.23.10.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 10:40:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 08/13] hw/riscv/riscv-iommu: add Address Translation Cache
 (IOATC)
Date: Thu, 23 May 2024 14:39:49 -0300
Message-ID: <20240523173955.1940072-9-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Tomasz Jeznach <tjeznach@rivosinc.com>

The RISC-V IOMMU spec predicts that the IOMMU can use translation caches
to hold entries from the DDT. This includes implementation for all cache
commands that are marked as 'not implemented'.

There are some artifacts included in the cache that predicts s-stage and
g-stage elements, although we don't support it yet. We'll introduce them
next.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 hw/riscv/riscv-iommu.c | 189 ++++++++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h |   2 +
 2 files changed, 187 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 39b4ff1405..abf6ae7726 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -63,6 +63,16 @@ struct RISCVIOMMUContext {
     uint64_t msiptp;            /* MSI redirection page table pointer */
 };
 
+/* Address translation cache entry */
+struct RISCVIOMMUEntry {
+    uint64_t iova:44;           /* IOVA Page Number */
+    uint64_t pscid:20;          /* Process Soft-Context identifier */
+    uint64_t phys:44;           /* Physical Page Number */
+    uint64_t gscid:16;          /* Guest Soft-Context identifier */
+    uint64_t perm:2;            /* IOMMU_RW flags */
+    uint64_t __rfu:2;
+};
+
 /* IOMMU index for transactions without PASID specified. */
 #define RISCV_IOMMU_NOPASID 0
 
@@ -751,13 +761,125 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
     return &as->iova_as;
 }
 
+/* Translation Object cache support */
+static gboolean __iot_equal(gconstpointer v1, gconstpointer v2)
+{
+    RISCVIOMMUEntry *t1 = (RISCVIOMMUEntry *) v1;
+    RISCVIOMMUEntry *t2 = (RISCVIOMMUEntry *) v2;
+    return t1->gscid == t2->gscid && t1->pscid == t2->pscid &&
+           t1->iova == t2->iova;
+}
+
+static guint __iot_hash(gconstpointer v)
+{
+    RISCVIOMMUEntry *t = (RISCVIOMMUEntry *) v;
+    return (guint)t->iova;
+}
+
+/* GV: 1 PSCV: 1 AV: 1 */
+static void __iot_inval_pscid_iova(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid &&
+        iot->iova == arg->iova) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 PSCV: 1 AV: 0 */
+static void __iot_inval_pscid(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid &&
+        iot->pscid == arg->pscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 GVMA: 1 */
+static void __iot_inval_gscid_gpa(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        /* simplified cache, no GPA matching */
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 1 GVMA: 0 */
+static void __iot_inval_gscid(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    RISCVIOMMUEntry *arg = (RISCVIOMMUEntry *) data;
+    if (iot->gscid == arg->gscid) {
+        iot->perm = IOMMU_NONE;
+    }
+}
+
+/* GV: 0 */
+static void __iot_inval_all(gpointer key, gpointer value, gpointer data)
+{
+    RISCVIOMMUEntry *iot = (RISCVIOMMUEntry *) value;
+    iot->perm = IOMMU_NONE;
+}
+
+/* caller should keep ref-count for iot_cache object */
+static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
+    GHashTable *iot_cache, hwaddr iova)
+{
+    RISCVIOMMUEntry key = {
+        .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
+        .iova  = PPN_DOWN(iova),
+    };
+    return g_hash_table_lookup(iot_cache, &key);
+}
+
+/* caller should keep ref-count for iot_cache object */
+static void riscv_iommu_iot_update(RISCVIOMMUState *s,
+    GHashTable *iot_cache, RISCVIOMMUEntry *iot)
+{
+    if (!s->iot_limit) {
+        return;
+    }
+
+    if (g_hash_table_size(s->iot_cache) >= s->iot_limit) {
+        iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
+                                          g_free, NULL);
+        g_hash_table_unref(qatomic_xchg(&s->iot_cache, iot_cache));
+    }
+    g_hash_table_add(iot_cache, iot);
+}
+
+static void riscv_iommu_iot_inval(RISCVIOMMUState *s, GHFunc func,
+    uint32_t gscid, uint32_t pscid, hwaddr iova)
+{
+    GHashTable *iot_cache;
+    RISCVIOMMUEntry key = {
+        .gscid = gscid,
+        .pscid = pscid,
+        .iova  = PPN_DOWN(iova),
+    };
+
+    iot_cache = g_hash_table_ref(s->iot_cache);
+    g_hash_table_foreach(iot_cache, func, &key);
+    g_hash_table_unref(iot_cache);
+}
+
 static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
-    IOMMUTLBEntry *iotlb)
+    IOMMUTLBEntry *iotlb, bool enable_cache)
 {
+    RISCVIOMMUEntry *iot;
+    IOMMUAccessFlags perm;
     bool enable_pasid;
     bool enable_pri;
+    GHashTable *iot_cache;
     int fault;
 
+    iot_cache = g_hash_table_ref(s->iot_cache);
     /*
      * TC[32] is reserved for custom extensions, used here to temporarily
      * enable automatic page-request generation for ATS queries.
@@ -765,9 +887,36 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     enable_pri = (iotlb->perm == IOMMU_NONE) && (ctx->tc & BIT_ULL(32));
     enable_pasid = (ctx->tc & RISCV_IOMMU_DC_TC_PDTV);
 
+    iot = riscv_iommu_iot_lookup(ctx, iot_cache, iotlb->iova);
+    perm = iot ? iot->perm : IOMMU_NONE;
+    if (perm != IOMMU_NONE) {
+        iotlb->translated_addr = PPN_PHYS(iot->phys);
+        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        iotlb->perm = perm;
+        fault = 0;
+        goto done;
+    }
+
     /* Translate using device directory / page table information. */
     fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
 
+    if (!fault && iotlb->target_as == &s->trap_as) {
+        /* Do not cache trapped MSI translations */
+        goto done;
+    }
+
+    if (!fault && iotlb->translated_addr != iotlb->iova && enable_cache) {
+        iot = g_new0(RISCVIOMMUEntry, 1);
+        iot->iova = PPN_DOWN(iotlb->iova);
+        iot->phys = PPN_DOWN(iotlb->translated_addr);
+        iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
+        iot->perm = iotlb->perm;
+        riscv_iommu_iot_update(s, iot_cache, iot);
+    }
+
+done:
+    g_hash_table_unref(iot_cache);
+
     if (enable_pri && fault) {
         struct riscv_iommu_pq_record pr = {0};
         if (enable_pasid) {
@@ -907,13 +1056,40 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMUState *s)
             if (cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV) {
                 /* illegal command arguments IOTINVAL.GVMA & PSCV == 1 */
                 goto cmd_ill;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings */
+                func = __iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID */
+                func = __iot_inval_gscid;
+            } else {
+                /* invalidate cache matching GSCID and ADDR (GPA) */
+                func = __iot_inval_gscid_gpa;
             }
-            /* translation cache not implemented yet */
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID), 0,
+                cmd.dword1 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA,
                              RISCV_IOMMU_CMD_IOTINVAL_OPCODE):
-            /* translation cache not implemented yet */
+            if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_GV)) {
+                /* invalidate all cache mappings, simplified model */
+                func = __iot_inval_all;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_PSCV)) {
+                /* invalidate cache matching GSCID, simplified model */
+                func = __iot_inval_gscid;
+            } else if (!(cmd.dword0 & RISCV_IOMMU_CMD_IOTINVAL_AV)) {
+                /* invalidate cache matching GSCID and PSCID */
+                func = __iot_inval_pscid;
+            } else {
+                /* invalidate cache matching GSCID and PSCID and ADDR (IOVA) */
+                func = __iot_inval_pscid_iova;
+            }
+            riscv_iommu_iot_inval(s, func,
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_GSCID),
+                get_field(cmd.dword0, RISCV_IOMMU_CMD_IOTINVAL_PSCID),
+                cmd.dword1 & TARGET_PAGE_MASK);
             break;
 
         case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IODIR_FUNC_INVAL_DDT,
@@ -1410,6 +1586,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     /* Device translation context cache */
     s->ctx_cache = g_hash_table_new_full(__ctx_hash, __ctx_equal,
                                          g_free, NULL);
+    s->iot_cache = g_hash_table_new_full(__iot_hash, __iot_equal,
+                                         g_free, NULL);
 
     s->iommus.le_next = NULL;
     s->iommus.le_prev = NULL;
@@ -1423,6 +1601,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
     RISCVIOMMUState *s = RISCV_IOMMU(dev);
 
     qemu_mutex_destroy(&s->core_lock);
+    g_hash_table_unref(s->iot_cache);
     g_hash_table_unref(s->ctx_cache);
 }
 
@@ -1430,6 +1609,8 @@ static Property riscv_iommu_properties[] = {
     DEFINE_PROP_UINT32("version", RISCVIOMMUState, version,
         RISCV_IOMMU_SPEC_DOT_VER),
     DEFINE_PROP_UINT32("bus", RISCVIOMMUState, bus, 0x0),
+    DEFINE_PROP_UINT32("ioatc-limit", RISCVIOMMUState, iot_limit,
+        LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
     DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
@@ -1482,7 +1663,7 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
         /* Translation disabled or invalid. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
-    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb)) {
+    } else if (riscv_iommu_translate(as->iommu, ctx, &iotlb, true)) {
         /* Translation disabled or fault reported. */
         iotlb.addr_mask = 0;
         iotlb.perm = IOMMU_NONE;
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 31d3907d33..3afee9f3e8 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -68,6 +68,8 @@ struct RISCVIOMMUState {
     MemoryRegion trap_mr;
 
     GHashTable *ctx_cache;          /* Device translation Context Cache */
+    GHashTable *iot_cache;          /* IO Translated Address Cache */
+    unsigned iot_limit;             /* IO Translation Cache size limit */
 
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
-- 
2.44.0


