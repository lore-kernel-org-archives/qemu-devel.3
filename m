Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682FDC021BC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdpW-0005oV-8C; Mon, 24 Feb 2025 14:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdox-0005fI-V8
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:56 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tmdos-0004oQ-70
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:08:51 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220f4dd756eso99445885ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1740424124; x=1741028924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYchZo+9Zfqk3JonMm8w+m2V870HZdVGqg6ShWsJhJU=;
 b=d652Pa7U9P4EkpheSontKOiGIwpUjAZ4Ug4UiDSwS//8q/4WpnB+sfTnder+xL4zmc
 Um3iWAWVv6dFzggYWI5HYaro7Sf6SrxCMiceEZ28Vcr7KEHhxOgSzyuS7kKiG1UiCR/Q
 Nrgph7lMXmy/qgcVZoVTBLBizmDeC7Lberp+h0YHHve+3Agk0w1bcpeP3wkSBCYbS5Ea
 0+WQGBeWnKQOYyUt57BSWY0AHwJgNu0/BW+s2w0CBVnlwf09flMoA65lbPN22H6AxvPh
 KbwQK4jIYtEe/WcMGTl5B83cMdXY7PnK2ZQk1LGmTkSV/3j1A07QHRAZMid66L4zwE33
 nZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740424124; x=1741028924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JYchZo+9Zfqk3JonMm8w+m2V870HZdVGqg6ShWsJhJU=;
 b=qvcHhi5K9MJkl7IOEgLGDGpWAAGmUQpj4v3ETKOFqpeS6NXz2re/WtU0KiZxIMiYaJ
 Fi4MUngbddokqWjZcw0dM2FTNWbBlfGHeps+3md455KW9VoodpXIk08/0Cs85iD3PWLG
 i0mmSb9EPw7tbmiyDMuyr8F0zcL4AcLkjiZCcpMg/GwkwRGcotGPli6QM+SalIWRxWq4
 8qUhitYbCmW+eVUMSam+ZeR2+wjWh1OrMrtGf+NiRcpFNQu+mV5z/7+37d/j89E1JkOB
 iFUai97celc/EzJkeeRzZkvJrYoFAzpJQ9mbJttQ4fP1cyJyMaQ0jk9ZXqJalWr9mKLc
 tpsQ==
X-Gm-Message-State: AOJu0Yxdb+QdtDuVAZCiivNVie9J8Dc6XQtkWbQ2P/qmFUbaigDNEW/j
 /qpbsnAUNvoBKAIjwa5sHIurn/egi1d5FBze2Jpy6O62BvboDnWuHjG4snjmQvA0w+Ijb3zb4cN
 4
X-Gm-Gg: ASbGnctor+rALcO9G4XZXwT6zWISpAaaC3iL6dkTdVJIeMNtSck97VZjDXCSe7nvc3w
 YbfCONLN+SdeVmahnVp2kJZ3Ui1BkmU7mBq/Z9KcceyIP0ANAeh1AXYfGdoFXjIG9efCNsj+Rk3
 T1+zLd5PzXiQ7z812gUKmbuod/QBrWWWLqDKNHAaGVLOVxF7r6Z5JG6WnXVHHeenktPIqRiEY+N
 kgVl2QoyDLRJuQo7G4OgSQcZkjeoc78Cglnpcfvp3bI3LosZ4ndSUBPr5vTwQoathKYh9OCu8PH
 YAKoqgS4sD7Ttg6cQ7OZEl5sooarlQ==
X-Google-Smtp-Source: AGHT+IEVlIMoanCBBkichfHkavrPwyrHunPZy4KaMU1TNXh4zsvbzOg8KXxPSzA0d+FvQzOyML5GBg==
X-Received: by 2002:a17:903:19ec:b0:21f:658b:8ed5 with SMTP id
 d9443c01a7336-22307b4556emr5265175ad.6.1740424124169; 
 Mon, 24 Feb 2025 11:08:44 -0800 (PST)
Received: from grind.. ([2804:7f0:bcc0:6edb:f473:a9df:d551:443b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545df28sm183583155ad.153.2025.02.24.11.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:08:43 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 04/11] hw/riscv/riscv-iommu: add riscv_iommu_hpm_incr_ctr()
Date: Mon, 24 Feb 2025 16:08:19 -0300
Message-ID: <20250224190826.1858473-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
References: <20250224190826.1858473-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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

This function will increment a specific counter, generating an interrupt
when an overflow occurs.

Some extra changes in riscv-iommu.c  were required to add this new
helper in riscv-iommu-hpm.c:

- RISCVIOMMUContext was moved to riscv-iommu.h, making it visible in
  riscv-iommu-hpm.c;

- riscv_iommu_notify() is now public.

No behavior change is made since HPM support is not being advertised
yet.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu-hpm.c | 114 +++++++++++++++++++++++++++++++++++++
 hw/riscv/riscv-iommu-hpm.h |   2 +
 hw/riscv/riscv-iommu.c     |  43 +++++++++-----
 hw/riscv/riscv-iommu.h     |  18 ++++++
 4 files changed, 162 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 5833ab8956..8eca5ee17e 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -52,3 +52,117 @@ uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s)
     return (ctr_val + get_cycles() - ctr_prev) |
         (cycle & RISCV_IOMMU_IOHPMCYCLES_OVF);
 }
+
+static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t ctr_idx)
+{
+    const uint32_t off = ctr_idx << 3;
+    uint64_t cntr_val;
+
+    cntr_val = ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
+    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
+
+    /* Handle the overflow scenario. */
+    if (cntr_val == UINT64_MAX) {
+        /*
+         * Generate interrupt only if OF bit is clear. +1 to offset the cycle
+         * register OF bit.
+         */
+        const uint32_t ovf =
+            riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IOCOUNTOVF,
+                                  BIT(ctr_idx + 1), 0);
+        if (!get_field(ovf, BIT(ctr_idx + 1))) {
+            riscv_iommu_reg_mod64(s,
+                                  RISCV_IOMMU_REG_IOHPMEVT_BASE + off,
+                                  RISCV_IOMMU_IOHPMEVT_OF,
+                                  0);
+            riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
+        }
+    }
+}
+
+void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
+                              unsigned event_id)
+{
+    const uint32_t inhibit = riscv_iommu_reg_get32(
+        s, RISCV_IOMMU_REG_IOCOUNTINH);
+    uint32_t did_gscid;
+    uint32_t pid_pscid;
+    uint32_t ctr_idx;
+    gpointer value;
+    uint32_t ctrs;
+    uint64_t evt;
+
+    if (!(s->cap & RISCV_IOMMU_CAP_HPM)) {
+        return;
+    }
+
+    value = g_hash_table_lookup(s->hpm_event_ctr_map,
+                                GUINT_TO_POINTER(event_id));
+    if (value == NULL) {
+        return;
+    }
+
+    for (ctrs = GPOINTER_TO_UINT(value); ctrs != 0; ctrs &= ctrs - 1) {
+        ctr_idx = ctz32(ctrs);
+        if (get_field(inhibit, BIT(ctr_idx + 1))) {
+            continue;
+        }
+
+        evt = riscv_iommu_reg_get64(s,
+            RISCV_IOMMU_REG_IOHPMEVT_BASE + (ctr_idx << 3));
+
+        /*
+         * It's quite possible that event ID has been changed in counter
+         * but hashtable hasn't been updated yet. We don't want to increment
+         * counter for the old event ID.
+         */
+        if (event_id != get_field(evt, RISCV_IOMMU_IOHPMEVT_EVENT_ID)) {
+            continue;
+        }
+
+        if (get_field(evt, RISCV_IOMMU_IOHPMEVT_IDT)) {
+            did_gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
+            pid_pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
+        } else {
+            did_gscid = ctx->devid;
+            pid_pscid = ctx->process_id;
+        }
+
+        if (get_field(evt, RISCV_IOMMU_IOHPMEVT_PV_PSCV)) {
+            /*
+             * If the transaction does not have a valid process_id, counter
+             * increments if device_id matches DID_GSCID. If the transaction
+             * has a valid process_id, counter increments if device_id
+             * matches DID_GSCID and process_id matches PID_PSCID. See
+             * IOMMU Specification, Chapter 5.23. Performance-monitoring
+             * event selector.
+             */
+            if (ctx->process_id &&
+                get_field(evt, RISCV_IOMMU_IOHPMEVT_PID_PSCID) != pid_pscid) {
+                continue;
+            }
+        }
+
+        if (get_field(evt, RISCV_IOMMU_IOHPMEVT_DV_GSCV)) {
+            uint32_t mask = ~0;
+
+            if (get_field(evt, RISCV_IOMMU_IOHPMEVT_DMASK)) {
+                /*
+                 * 1001 1011   mask = GSCID
+                 * 0000 0111   mask = mask ^ (mask + 1)
+                 * 1111 1000   mask = ~mask;
+                 */
+                mask = get_field(evt, RISCV_IOMMU_IOHPMEVT_DID_GSCID);
+                mask = mask ^ (mask + 1);
+                mask = ~mask;
+            }
+
+            if ((get_field(evt, RISCV_IOMMU_IOHPMEVT_DID_GSCID) & mask) !=
+                (did_gscid & mask)) {
+                continue;
+            }
+        }
+
+        hpm_incr_ctr(s, ctr_idx);
+    }
+}
diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
index 231c110ff2..411d869dce 100644
--- a/hw/riscv/riscv-iommu-hpm.h
+++ b/hw/riscv/riscv-iommu-hpm.h
@@ -23,5 +23,7 @@
 #include "hw/riscv/riscv-iommu.h"
 
 uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
+void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
+                              unsigned event_id);
 
 #endif
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 0fbd50bb52..0b15acf4e6 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -39,7 +39,6 @@
 #define PPN_PHYS(ppn)                 ((ppn) << TARGET_PAGE_BITS)
 #define PPN_DOWN(phy)                 ((phy) >> TARGET_PAGE_BITS)
 
-typedef struct RISCVIOMMUContext RISCVIOMMUContext;
 typedef struct RISCVIOMMUEntry RISCVIOMMUEntry;
 
 /* Device assigned I/O address space */
@@ -52,19 +51,6 @@ struct RISCVIOMMUSpace {
     QLIST_ENTRY(RISCVIOMMUSpace) list;
 };
 
-/* Device translation context state. */
-struct RISCVIOMMUContext {
-    uint64_t devid:24;          /* Requester Id, AKA device_id */
-    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
-    uint64_t tc;                /* Translation Control */
-    uint64_t ta;                /* Translation Attributes */
-    uint64_t satp;              /* S-Stage address translation and protection */
-    uint64_t gatp;              /* G-Stage address translation and protection */
-    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
-    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
-    uint64_t msiptp;            /* MSI redirection page table pointer */
-};
-
 typedef enum RISCVIOMMUTransTag {
     RISCV_IOMMU_TRANS_TAG_BY,  /* Bypass */
     RISCV_IOMMU_TRANS_TAG_SS,  /* Single Stage */
@@ -101,7 +87,7 @@ static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
     }
 }
 
-static void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
+void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
 {
     uint32_t ipsr, icvec, vector;
 
@@ -423,6 +409,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             }
         }
 
+
+        if (pass == S_STAGE) {
+            riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_S_VS_WALKS);
+        } else {
+            riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_G_WALKS);
+        }
+
         /* Read page table entry */
         if (sc[pass].ptesize == 4) {
             uint32_t pte32 = 0;
@@ -941,6 +934,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Device directory tree walk */
     for (; depth-- > 0; ) {
+        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_DD_WALK);
         /*
          * Select device id index bits based on device directory tree level
          * and device context format.
@@ -968,6 +962,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         addr = PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
     }
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_DD_WALK);
+
     /* index into device context entry page */
     addr |= (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
 
@@ -1033,6 +1029,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     }
 
     for (depth = mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0; ) {
+        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
+
         /*
          * Select process id index bits based on process directory tree
          * level. See IOMMU Specification, 2.2. Process-Directory-Table.
@@ -1050,6 +1048,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
     }
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
+
     /* Leaf entry in PDT */
     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
     if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
@@ -1419,6 +1419,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     GHashTable *iot_cache;
     int fault;
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
+
     iot_cache = g_hash_table_ref(s->iot_cache);
     /*
      * TC[32] is reserved for custom extensions, used here to temporarily
@@ -1429,6 +1431,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 
     /* Check for ATS request. */
     if (iotlb->perm == IOMMU_NONE) {
+        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_ATS_RQ);
         /* Check if ATS is disabled. */
         if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
             enable_pri = false;
@@ -1447,6 +1450,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         goto done;
     }
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
+
     /* Translate using device directory / page table information. */
     fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
 
@@ -2375,6 +2380,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
             "riscv-iommu-trap", ~0ULL);
     address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
+
+    if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        s->hpm_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
+    }
 }
 
 static void riscv_iommu_unrealize(DeviceState *dev)
@@ -2383,6 +2392,10 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 
     g_hash_table_unref(s->iot_cache);
     g_hash_table_unref(s->ctx_cache);
+
+    if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        g_hash_table_unref(s->hpm_event_ctr_map);
+    }
 }
 
 void riscv_iommu_reset(RISCVIOMMUState *s)
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 59db3fd02a..4384f39515 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -85,12 +85,30 @@ struct RISCVIOMMUState {
     /* HPM cycle counter */
     uint64_t hpmcycle_val;      /* Current value of cycle register */
     uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clock */
+
+    /* HPM event counters */
+    GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
 };
 
 void riscv_iommu_pci_setup_iommu(RISCVIOMMUState *iommu, PCIBus *bus,
          Error **errp);
 void riscv_iommu_set_cap_igs(RISCVIOMMUState *s, riscv_iommu_igs_mode mode);
 void riscv_iommu_reset(RISCVIOMMUState *s);
+void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type);
+
+typedef struct RISCVIOMMUContext RISCVIOMMUContext;
+/* Device translation context state. */
+struct RISCVIOMMUContext {
+    uint64_t devid:24;          /* Requester Id, AKA device_id */
+    uint64_t process_id:20;     /* Process ID. PASID for PCIe */
+    uint64_t tc;                /* Translation Control */
+    uint64_t ta;                /* Translation Attributes */
+    uint64_t satp;              /* S-Stage address translation and protection */
+    uint64_t gatp;              /* G-Stage address translation and protection */
+    uint64_t msi_addr_mask;     /* MSI filtering - address mask */
+    uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
+    uint64_t msiptp;            /* MSI redirection page table pointer */
+};
 
 /* private helpers */
 
-- 
2.48.1


