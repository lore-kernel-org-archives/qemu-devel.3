Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843F5E7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 13:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJByU-0002oO-6a; Thu, 05 Dec 2024 08:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwN-0001F7-Oh
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:49 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tJBwH-00054b-LJ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 08:30:45 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7f43259d220so612935a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1733405424; x=1734010224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nLDZF1r8Y8eOocnsvMVe0Uq7k5FNEXF0/EX2CYkOrM=;
 b=EgOwDc4cxLLbOZ/C2o9sP5Yi5OF56TrLnua0s6zp2VCh4kRY3wLplBqOPNhg+ZvTEl
 2TGB114p+38ieQtvj3UorDQ73PRyFFTqHD5afZLZcXray0ADvidguNxvzqxQDly5i/5/
 HcVSxRi+zhns14sPOYtbLWslOWM7BOlNqVfiv3DBzKondG/2MCG3vXuU3P0H1Q6DQL1+
 S6x85frsl1VOLfFi+xwCt6qnjyRIZ7z4uMopoJS3/C3k1uQrvv2EYQKJdNwf0zBLhOHY
 B5jj3ZN9dUJzKlOL4ASuIuTqFxtUH4OLjNBE1HkAsH/+6PfPZX3Zp6WL02kgKLX487DI
 sgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733405424; x=1734010224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nLDZF1r8Y8eOocnsvMVe0Uq7k5FNEXF0/EX2CYkOrM=;
 b=doFQzyEz2t//ZvOo4g02HFN53Z5eniYlQHJiXIQIbl84jO3h2/ZDplnXIjJlMrP/nf
 2MAj4lk4nHVoJdlu4te54R5PNTblAnBjPa/bLmibaoDsil20Ku0ZuQEkYm2vqivI+eTw
 CmWYI0CBrQ+dHzQ4Gh4z7Wh9icSio7tYQgfdx2KQv6sltN9uwl/Yi8DhDXl9uNgQxzkn
 P9+VOuTK8s7AGF7StvodJX5TzvmJxT72m0jQjGSRRTVcTdjzPXWx0+XrbCw6rSZzZ7Nq
 sIVBgkAj4ZT5CZB4MZtSyiIcJ5n5D7WClpAgSlj4xCwiDzmTwxaF0aM24i+t4XvzJ5tp
 /OSw==
X-Gm-Message-State: AOJu0YyMhEsunnviLTfo97shU4sm2WWVJxVnT3ZIA7fsb0LV1xScpIOn
 N4SLydCxVlLTOVjJdojd6GGXelFU3TedFTIINteZbSBHHrSd6uVRHk946zSnM35RYlEI/Gob9du
 J
X-Gm-Gg: ASbGncvEdpZq+4mnZ+pSFlDtOTfY5Yiu6z39SGpBouom0XeLSfK/2+xXQ+EdH/m1frq
 8/VzLzgbE8ypKq89GAafClLk0SUJKUaOZk1ESgzzIbjRP+h4wpdvk64QI4Y+rpAwZaH58oWwBBG
 GI2HjAxuLh4ui5JZprwqw2CLyS5lW3h9clnTeBROk67F/j5/EY+Gf1EDbeTcaB9ZG09u9JnzN86
 dSZpPSlKtxZiH85PakXhr62fX5d7I/NMc079rdzjLWM2DDqpO0aCxI8UMhiyds8L94hVj4K+wZD
X-Google-Smtp-Source: AGHT+IGwYdwMCYTAgbzaw2IC+ZTYL9NIRmy6g0Ss0kvp7yVO3ybQBpbmzquh3/cZ1NSV4ux29ni7NQ==
X-Received: by 2002:a05:6a20:6a28:b0:1e0:d0ac:133b with SMTP id
 adf61e73a8af0-1e1653f2f2fmr15056365637.33.1733405422377; 
 Thu, 05 Dec 2024 05:30:22 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.65.72])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725a2a8f512sm1250315b3a.126.2024.12.05.05.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 05:30:21 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Tomasz Jeznach <tjeznach@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-10.0 04/11] hw/riscv/riscv-iommu: add
 riscv_iommu_hpm_incr_ctr()
Date: Thu,  5 Dec 2024 10:29:56 -0300
Message-ID: <20241205133003.184581-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205133003.184581-1-dbarboza@ventanamicro.com>
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x533.google.com
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
index 01df25418c..5ce0d24359 100644
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
 /* Address translation cache entry */
 struct RISCVIOMMUEntry {
     uint64_t iova:44;           /* IOVA Page Number */
@@ -93,7 +79,7 @@ static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
     }
 }
 
-static void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
+void riscv_iommu_notify(RISCVIOMMUState *s, int vec_type)
 {
     uint32_t ipsr, icvec, vector;
 
@@ -415,6 +401,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
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
@@ -933,6 +926,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Device directory tree walk */
     for (; depth-- > 0; ) {
+        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_DD_WALK);
         /*
          * Select device id index bits based on device directory tree level
          * and device context format.
@@ -960,6 +954,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         addr = PPN_PHYS(get_field(de, RISCV_IOMMU_DDTE_PPN));
     }
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_DD_WALK);
+
     /* index into device context entry page */
     addr |= (ctx->devid * dc_len) & ~TARGET_PAGE_MASK;
 
@@ -1025,6 +1021,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     }
 
     for (depth = mode - RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8; depth-- > 0; ) {
+        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
+
         /*
          * Select process id index bits based on process directory tree
          * level. See IOMMU Specification, 2.2. Process-Directory-Table.
@@ -1042,6 +1040,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
     }
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);
+
     /* Leaf entry in PDT */
     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
     if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
@@ -1347,6 +1347,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     GHashTable *iot_cache;
     int fault;
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
+
     iot_cache = g_hash_table_ref(s->iot_cache);
     /*
      * TC[32] is reserved for custom extensions, used here to temporarily
@@ -1357,6 +1359,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
 
     /* Check for ATS request. */
     if (iotlb->perm == IOMMU_NONE) {
+        riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_ATS_RQ);
         /* Check if ATS is disabled. */
         if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_ATS)) {
             enable_pri = false;
@@ -1375,6 +1378,8 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         goto done;
     }
 
+    riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
+
     /* Translate using device directory / page table information. */
     fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
 
@@ -2274,6 +2279,10 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->trap_mr, OBJECT(dev), &riscv_iommu_trap_ops, s,
             "riscv-iommu-trap", ~0ULL);
     address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
+
+    if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        s->hpm_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
+    }
 }
 
 static void riscv_iommu_unrealize(DeviceState *dev)
@@ -2282,6 +2291,10 @@ static void riscv_iommu_unrealize(DeviceState *dev)
 
     g_hash_table_unref(s->iot_cache);
     g_hash_table_unref(s->ctx_cache);
+
+    if (s->cap & RISCV_IOMMU_CAP_HPM) {
+        g_hash_table_unref(s->hpm_event_ctr_map);
+    }
 }
 
 void riscv_iommu_reset(RISCVIOMMUState *s)
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 380f7e81d1..a21ab51491 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -90,12 +90,30 @@ struct RISCVIOMMUState {
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
2.47.1


