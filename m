Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17851C30658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLq9x-0004UK-2U; Mon, 24 Jun 2024 16:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9v-0004Pz-N1
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:27 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sLq9s-0003ib-1Y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 16:19:27 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7067108f2cdso1633712b3a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719260362; x=1719865162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=goMFcsO6kJvqes+jn7KXqI7J+RMvfUOw9/lXncLcXyU=;
 b=nMpWCd5g1KhBHnr0lDp0u2iWlhy9T2zyRE5PignGoq6hEffQpBlbdtNeTC0VjQUP12
 rGW2MO96as4qiw8wKYD8BxA5rSCdLac1sFRQVk68cB/XwZ1xqHD29MIgT8EM8PIXjITF
 wmH+adctcI5msax2O5FI3kag8XHktnuJmnl6TP2ROIjiqmUk4hNar1zOzb/92aBmPzB9
 Ow/dq9SeN4rKSCHiFRzeaWOgFmd8jqyhBHJ2U/26X1yPHChrVNwkHW0iJq8aKay0/34O
 GZj/FXLsxp+5ubsnZxYoLjSDDuUV/ru+8doTiFdNGSeO2HBb6UgITewTtv8O5quqaq0d
 ldvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719260362; x=1719865162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=goMFcsO6kJvqes+jn7KXqI7J+RMvfUOw9/lXncLcXyU=;
 b=MN4myG2kjEGVnz2O1QR1B3PdH1HYLKaHUhNNm99MikQ4Lm5ka3N+A2OvTAQDA+0C0Y
 BmNbT/cwkJZsmRSZdUxiKm9xdMe0D0oMuHYuVxpemdnoY30oTVGvo/i8/f2b6s8M3N8N
 rrosJ8blMt0MY9F2B1f26mGaF0gqFLOgsKqbffDBz4BrzWZbyVhXXocQToklH8ySiz4c
 o2S5DT/AHTYIqQCNl6Za93itnmF9NLo3f0/gtHBgWt/dLZoU5uo+JrIc9k6JNCnY6T+/
 3+xhCzL7/bV6lReBKnld0UQspOM4rl5Yf5qo+A46DdZjvicHAqx3hwmocmk8hVXCKErX
 N+ng==
X-Gm-Message-State: AOJu0YwNssvZdfLiE0YTX2ZESaxlZ7oH58Xc5vY68a/xEJKr4wb+VJq7
 HyjHOCWLZCIlMvnOnTPWgLkY/0pmrAzjjLd9gvb0DarrPhAzVZ/ffgEbUXxOSoMJ1YQ6q0+Su71
 8
X-Google-Smtp-Source: AGHT+IE/6rx4XGIxwVqsYjKjgZ2bQEIH88r8SI/P0IGIQbaq+bJCild0NE/PW2TgsWbDwhgtRnNZNQ==
X-Received: by 2002:a05:6a20:2da5:b0:1b6:d83e:a8df with SMTP id
 adf61e73a8af0-1bcf44d87b1mr6389515637.29.1719260361680; 
 Mon, 24 Jun 2024 13:19:21 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:1aea:63a7:288e:eb77:fe54])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70688f2d76bsm1927091b3a.41.2024.06.24.13.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 13:19:21 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com, frank.chang@sifive.com,
 jason.chien@sifive.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 09/14] hw/riscv/riscv-iommu: add s-stage and g-stage support
Date: Mon, 24 Jun 2024 17:18:19 -0300
Message-ID: <20240624201825.1054980-10-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
References: <20240624201825.1054980-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x434.google.com
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

Add support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage
(sv32x4, sv39x4, sv48x4, sv57x4 caps). Most of the work is done in the
riscv_iommu_spa_fetch() function that now has to consider how many
translation stages we need to walk the page table.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu-bits.h |  12 ++
 hw/riscv/riscv-iommu.c      | 377 +++++++++++++++++++++++++++++++++++-
 hw/riscv/riscv-iommu.h      |   2 +
 3 files changed, 381 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
index 8a1af73685..75b431fed0 100644
--- a/hw/riscv/riscv-iommu-bits.h
+++ b/hw/riscv/riscv-iommu-bits.h
@@ -71,6 +71,14 @@ struct riscv_iommu_pq_record {
 /* 5.3 IOMMU Capabilities (64bits) */
 #define RISCV_IOMMU_REG_CAP             0x0000
 #define RISCV_IOMMU_CAP_VERSION         GENMASK_ULL(7, 0)
+#define RISCV_IOMMU_CAP_SV32            BIT_ULL(8)
+#define RISCV_IOMMU_CAP_SV39            BIT_ULL(9)
+#define RISCV_IOMMU_CAP_SV48            BIT_ULL(10)
+#define RISCV_IOMMU_CAP_SV57            BIT_ULL(11)
+#define RISCV_IOMMU_CAP_SV32X4          BIT_ULL(16)
+#define RISCV_IOMMU_CAP_SV39X4          BIT_ULL(17)
+#define RISCV_IOMMU_CAP_SV48X4          BIT_ULL(18)
+#define RISCV_IOMMU_CAP_SV57X4          BIT_ULL(19)
 #define RISCV_IOMMU_CAP_MSI_FLAT        BIT_ULL(22)
 #define RISCV_IOMMU_CAP_MSI_MRIF        BIT_ULL(23)
 #define RISCV_IOMMU_CAP_T2GPA           BIT_ULL(26)
@@ -84,6 +92,7 @@ struct riscv_iommu_pq_record {
 #define RISCV_IOMMU_REG_FCTL            0x0008
 #define RISCV_IOMMU_FCTL_BE             BIT(0)
 #define RISCV_IOMMU_FCTL_WSI            BIT(1)
+#define RISCV_IOMMU_FCTL_GXL            BIT(2)
 
 /* 5.5 Device-directory-table pointer (64bits) */
 #define RISCV_IOMMU_REG_DDTP            0x0010
@@ -206,6 +215,8 @@ struct riscv_iommu_dc {
 #define RISCV_IOMMU_DC_TC_DTF           BIT_ULL(4)
 #define RISCV_IOMMU_DC_TC_PDTV          BIT_ULL(5)
 #define RISCV_IOMMU_DC_TC_PRPR          BIT_ULL(6)
+#define RISCV_IOMMU_DC_TC_GADE          BIT_ULL(7)
+#define RISCV_IOMMU_DC_TC_SADE          BIT_ULL(8)
 #define RISCV_IOMMU_DC_TC_DPE           BIT_ULL(9)
 #define RISCV_IOMMU_DC_TC_SBE           BIT_ULL(10)
 #define RISCV_IOMMU_DC_TC_SXL           BIT_ULL(11)
@@ -316,6 +327,7 @@ enum riscv_iommu_fq_causes {
 
 /* First stage context fields */
 #define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
+#define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
 
 enum riscv_iommu_fq_ttypes {
     RISCV_IOMMU_FQ_TTYPE_NONE = 0,
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 7bf085cee6..fd5b5ab50d 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -58,6 +58,8 @@ struct RISCVIOMMUContext {
     uint64_t __rfu:20;          /* reserved */
     uint64_t tc;                /* Translation Control */
     uint64_t ta;                /* Translation Attributes */
+    uint64_t satp;              /* S-Stage address translation and protection */
+    uint64_t gatp;              /* G-Stage address translation and protection */
     uint64_t msi_addr_mask;     /* MSI filtering - address mask */
     uint64_t msi_addr_pattern;  /* MSI filtering - address pattern */
     uint64_t msiptp;            /* MSI redirection page table pointer */
@@ -201,12 +203,45 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     return true;
 }
 
-/* RISCV IOMMU Address Translation Lookup - Page Table Walk */
+/*
+ * RISCV IOMMU Address Translation Lookup - Page Table Walk
+ *
+ * Note: Code is based on get_physical_address() from target/riscv/cpu_helper.c
+ * Both implementation can be merged into single helper function in future.
+ * Keeping them separate for now, as error reporting and flow specifics are
+ * sufficiently different for separate implementation.
+ *
+ * @s        : IOMMU Device State
+ * @ctx      : Translation context for device id and process address space id.
+ * @iotlb    : translation data: physical address and access mode.
+ * @return   : success or fault cause code.
+ */
 static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     IOMMUTLBEntry *iotlb)
 {
+    dma_addr_t addr, base;
+    uint64_t satp, gatp, pte;
+    bool en_s, en_g;
+    struct {
+        unsigned char step;
+        unsigned char levels;
+        unsigned char ptidxbits;
+        unsigned char ptesize;
+    } sc[2];
+    /* Translation stage phase */
+    enum {
+        S_STAGE = 0,
+        G_STAGE = 1,
+    } pass;
+
+    satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
+    gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
+
+    en_s = satp != RISCV_IOMMU_DC_FSC_MODE_BARE;
+    en_g = gatp != RISCV_IOMMU_DC_IOHGATP_MODE_BARE;
+
     /* Early check for MSI address match when IOVA == GPA */
-    if (iotlb->perm & IOMMU_WO &&
+    if ((iotlb->perm & IOMMU_WO) &&
         riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
         iotlb->target_as = &s->trap_as;
         iotlb->translated_addr = iotlb->iova;
@@ -215,11 +250,196 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
     }
 
     /* Exit early for pass-through mode. */
-    iotlb->translated_addr = iotlb->iova;
-    iotlb->addr_mask = ~TARGET_PAGE_MASK;
-    /* Allow R/W in pass-through mode */
-    iotlb->perm = IOMMU_RW;
-    return 0;
+    if (!(en_s || en_g)) {
+        iotlb->translated_addr = iotlb->iova;
+        iotlb->addr_mask = ~TARGET_PAGE_MASK;
+        /* Allow R/W in pass-through mode */
+        iotlb->perm = IOMMU_RW;
+        return 0;
+    }
+
+    /* S/G translation parameters. */
+    for (pass = 0; pass < 2; pass++) {
+        uint32_t sv_mode;
+
+        sc[pass].step = 0;
+        if (pass ? (s->fctl & RISCV_IOMMU_FCTL_GXL) :
+            (ctx->tc & RISCV_IOMMU_DC_TC_SXL)) {
+            /* 32bit mode for GXL/SXL == 1 */
+            switch (pass ? gatp : satp) {
+            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
+                sc[pass].levels    = 0;
+                sc[pass].ptidxbits = 0;
+                sc[pass].ptesize   = 0;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV32X4 : RISCV_IOMMU_CAP_SV32;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 2;
+                sc[pass].ptidxbits = 10;
+                sc[pass].ptesize   = 4;
+                break;
+            default:
+                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+            }
+        } else {
+            /* 64bit mode for GXL/SXL == 0 */
+            switch (pass ? gatp : satp) {
+            case RISCV_IOMMU_DC_IOHGATP_MODE_BARE:
+                sc[pass].levels    = 0;
+                sc[pass].ptidxbits = 0;
+                sc[pass].ptesize   = 0;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV39X4 : RISCV_IOMMU_CAP_SV39;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 3;
+                sc[pass].ptidxbits = 9;
+                sc[pass].ptesize   = 8;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV48X4 : RISCV_IOMMU_CAP_SV48;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 4;
+                sc[pass].ptidxbits = 9;
+                sc[pass].ptesize   = 8;
+                break;
+            case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+                sv_mode = pass ? RISCV_IOMMU_CAP_SV57X4 : RISCV_IOMMU_CAP_SV57;
+                if (!(s->cap & sv_mode)) {
+                    return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+                }
+                sc[pass].levels    = 5;
+                sc[pass].ptidxbits = 9;
+                sc[pass].ptesize   = 8;
+                break;
+            default:
+                return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
+            }
+        }
+    };
+
+    /* S/G stages translation tables root pointers */
+    gatp = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
+    satp = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_ATP_PPN_FIELD));
+    addr = (en_s && en_g) ? satp : iotlb->iova;
+    base = en_g ? gatp : satp;
+    pass = en_g ? G_STAGE : S_STAGE;
+
+    do {
+        const unsigned widened = (pass && !sc[pass].step) ? 2 : 0;
+        const unsigned va_bits = widened + sc[pass].ptidxbits;
+        const unsigned va_skip = TARGET_PAGE_BITS + sc[pass].ptidxbits *
+                                 (sc[pass].levels - 1 - sc[pass].step);
+        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
+        const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
+        const bool ade =
+            ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
+
+        /* Address range check before first level lookup */
+        if (!sc[pass].step) {
+            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
+            if ((addr & va_mask) != addr) {
+                return RISCV_IOMMU_FQ_CAUSE_DMA_DISABLED;
+            }
+        }
+
+        /* Read page table entry */
+        if (dma_memory_read(s->target_as, pte_addr, &pte,
+                sc[pass].ptesize, MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
+            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
+                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
+        }
+
+        if (sc[pass].ptesize == 4) {
+            pte = (uint64_t) le32_to_cpu(*((uint32_t *)&pte));
+        } else {
+            pte = le64_to_cpu(pte);
+        }
+
+        sc[pass].step++;
+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
+
+        if (!(pte & PTE_V)) {
+            break;                /* Invalid PTE */
+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
+            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
+            break;                /* Reserved leaf PTE flags: PTE_W */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
+            break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
+        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
+            break;                /* Misaligned PPN */
+        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
+            break;                /* Read access check failed */
+        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
+            break;                /* Write access check failed */
+        } else if ((iotlb->perm & IOMMU_RO) && !ade && !(pte & PTE_A)) {
+            break;                /* Access bit not set */
+        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
+            break;                /* Dirty bit not set */
+        } else {
+            /* Leaf PTE, translation completed. */
+            sc[pass].step = sc[pass].levels;
+            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            /* Update address mask based on smallest translation granularity */
+            iotlb->addr_mask &= (1ULL << va_skip) - 1;
+            /* Continue with S-Stage translation? */
+            if (pass && sc[0].step != sc[0].levels) {
+                pass = S_STAGE;
+                addr = iotlb->iova;
+                continue;
+            }
+            /* Translation phase completed (GPA or SPA) */
+            iotlb->translated_addr = base;
+            iotlb->perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
+                                                         : IOMMU_RO;
+
+            /* Check MSI GPA address match */
+            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
+                riscv_iommu_msi_check(s, ctx, base)) {
+                /* Trap MSI writes and return GPA address. */
+                iotlb->target_as = &s->trap_as;
+                iotlb->addr_mask = ~TARGET_PAGE_MASK;
+                return 0;
+            }
+
+            /* Continue with G-Stage translation? */
+            if (!pass && en_g) {
+                pass = G_STAGE;
+                addr = base;
+                base = gatp;
+                sc[pass].step = 0;
+                continue;
+            }
+
+            return 0;
+        }
+
+        if (sc[pass].step == sc[pass].levels) {
+            break; /* Can't find leaf PTE */
+        }
+
+        /* Continue with G-Stage translation? */
+        if (!pass && en_g) {
+            pass = G_STAGE;
+            addr = base;
+            base = gatp;
+            sc[pass].step = 0;
+        }
+    } while (1);
+
+    return (iotlb->perm & IOMMU_WO) ?
+                (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
+                        RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
+                (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :
+                        RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S);
 }
 
 static void riscv_iommu_report_fault(RISCVIOMMUState *s,
@@ -420,7 +640,7 @@ err:
 static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
                                             RISCVIOMMUContext *ctx)
 {
-    uint32_t msi_mode;
+    uint32_t fsc_mode, msi_mode;
 
     if (!(ctx->tc & RISCV_IOMMU_DC_TC_EN_PRI) &&
         ctx->tc & RISCV_IOMMU_DC_TC_PRPR) {
@@ -441,6 +661,58 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
         }
     }
 
+    fsc_mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
+
+    if (ctx->tc & RISCV_IOMMU_DC_TC_PDTV) {
+        switch (fsc_mode) {
+        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD8:
+            if (!(s->cap & RISCV_IOMMU_CAP_PD8)) {
+                return false;
+            }
+            break;
+        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD17:
+            if (!(s->cap & RISCV_IOMMU_CAP_PD17)) {
+                return false;
+            }
+            break;
+        case RISCV_IOMMU_DC_FSC_PDTP_MODE_PD20:
+            if (!(s->cap & RISCV_IOMMU_CAP_PD20)) {
+                return false;
+            }
+            break;
+        }
+    } else {
+        /* DC.tc.PDTV is 0 */
+        if (ctx->tc & RISCV_IOMMU_DC_TC_DPE) {
+            return false;
+        }
+
+        if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
+            if (fsc_mode == RISCV_IOMMU_CAP_SV32 &&
+                !(s->cap & RISCV_IOMMU_CAP_SV32)) {
+                return false;
+            }
+        } else {
+            switch (fsc_mode) {
+            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+                if (!(s->cap & RISCV_IOMMU_CAP_SV39)) {
+                    return false;
+                }
+                break;
+            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+                if (!(s->cap & RISCV_IOMMU_CAP_SV48)) {
+                    return false;
+                }
+            break;
+            case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+                if (!(s->cap & RISCV_IOMMU_CAP_SV57)) {
+                    return false;
+                }
+                break;
+            }
+        }
+    }
+
     /*
      * CAP_END is always zero (only one endianess). FCTL_BE is
      * always zero (little-endian accesses). Thus TC_SBE must
@@ -460,11 +732,53 @@ static bool riscv_iommu_validate_device_ctx(RISCVIOMMUState *s,
 static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
                                              RISCVIOMMUContext *ctx)
 {
+    uint32_t mode;
+
     if (get_field(ctx->ta, RISCV_IOMMU_PC_TA_RESERVED)) {
         return false;
     }
 
-    /* FSC and svNN checks to be added when adding s/g-stage support */
+    if (get_field(ctx->satp, RISCV_IOMMU_PC_FSC_RESERVED)) {
+        return false;
+    }
+
+    mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
+    switch (mode) {
+    case RISCV_IOMMU_DC_FSC_MODE_BARE:
+    /* sv39 and sv32 modes have the same value (8) */
+    case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+    case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+    case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+        break;
+    default:
+        return false;
+    }
+
+    if (ctx->tc & RISCV_IOMMU_DC_TC_SXL) {
+        if (mode == RISCV_IOMMU_CAP_SV32 &&
+            !(s->cap & RISCV_IOMMU_CAP_SV32)) {
+                return false;
+        }
+    } else {
+        switch (mode) {
+        case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV39)) {
+                return false;
+            }
+            break;
+        case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV48)) {
+                return false;
+            }
+            break;
+        case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV57)) {
+                return false;
+            }
+            break;
+        }
+    }
+
     return true;
 }
 
@@ -493,6 +807,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     case RISCV_IOMMU_DDTP_MODE_BARE:
         /* mock up pass-through translation context */
+        ctx->gatp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
+            RISCV_IOMMU_DC_IOHGATP_MODE_BARE);
+        ctx->satp = set_field(0, RISCV_IOMMU_ATP_MODE_FIELD,
+            RISCV_IOMMU_DC_FSC_MODE_BARE);
         ctx->tc = RISCV_IOMMU_DC_TC_V;
         ctx->ta = 0;
         ctx->msiptp = 0;
@@ -566,6 +884,8 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Set translation context. */
     ctx->tc = le64_to_cpu(dc.tc);
+    ctx->gatp = le64_to_cpu(dc.iohgatp);
+    ctx->satp = le64_to_cpu(dc.fsc);
     ctx->ta = le64_to_cpu(dc.ta);
     ctx->msiptp = le64_to_cpu(dc.msiptp);
     ctx->msi_addr_mask = le64_to_cpu(dc.msi_addr_mask);
@@ -579,11 +899,35 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         return RISCV_IOMMU_FQ_CAUSE_DDT_MISCONFIGURED;
     }
 
+    /* FSC field checks */
+    mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
+    addr = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_DC_FSC_PPN));
+
     if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
         if (ctx->process_id != RISCV_IOMMU_NOPROCID) {
             /* PASID is disabled */
             return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
         }
+        if (mode > RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57) {
+            /* Invalid translation mode */
+            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
+        }
+        return 0;
+    }
+
+    if (ctx->process_id == RISCV_IOMMU_NOPROCID) {
+        if (!(ctx->tc & RISCV_IOMMU_DC_TC_DPE)) {
+            /* No default process_id enabled, set BARE mode */
+            ctx->satp = 0ULL;
+            return 0;
+        } else {
+            /* Use default process_id #0 */
+            ctx->process_id = 0;
+        }
+    }
+
+    if (mode == RISCV_IOMMU_DC_FSC_MODE_BARE) {
+        /* No S-Stage translation, done. */
         return 0;
     }
 
@@ -618,8 +962,9 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
     }
 
-    /* Use TA from process directory entry. */
+    /* Use FSC and TA from process directory entry. */
     ctx->ta = le64_to_cpu(dc.ta);
+    ctx->satp = le64_to_cpu(dc.fsc);
 
     if (!(ctx->ta & RISCV_IOMMU_PC_TA_V)) {
         return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
@@ -868,6 +1213,7 @@ static RISCVIOMMUEntry *riscv_iommu_iot_lookup(RISCVIOMMUContext *ctx,
     GHashTable *iot_cache, hwaddr iova)
 {
     RISCVIOMMUEntry key = {
+        .gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID),
         .pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID),
         .iova  = PPN_DOWN(iova),
     };
@@ -951,6 +1297,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
         iot = g_new0(RISCVIOMMUEntry, 1);
         iot->iova = PPN_DOWN(iotlb->iova);
         iot->phys = PPN_DOWN(iotlb->translated_addr);
+        iot->gscid = get_field(ctx->gatp, RISCV_IOMMU_DC_IOHGATP_GSCID);
         iot->pscid = get_field(ctx->ta, RISCV_IOMMU_DC_TA_PSCID);
         iot->perm = iotlb->perm;
         riscv_iommu_iot_update(s, iot_cache, iot);
@@ -1555,6 +1902,14 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
     if (s->enable_msi) {
         s->cap |= RISCV_IOMMU_CAP_MSI_FLAT | RISCV_IOMMU_CAP_MSI_MRIF;
     }
+    if (s->enable_s_stage) {
+        s->cap |= RISCV_IOMMU_CAP_SV32 | RISCV_IOMMU_CAP_SV39 |
+                  RISCV_IOMMU_CAP_SV48 | RISCV_IOMMU_CAP_SV57;
+    }
+    if (s->enable_g_stage) {
+        s->cap |= RISCV_IOMMU_CAP_SV32X4 | RISCV_IOMMU_CAP_SV39X4 |
+                  RISCV_IOMMU_CAP_SV48X4 | RISCV_IOMMU_CAP_SV57X4;
+    }
     /* Report QEMU target physical address space limits */
     s->cap = set_field(s->cap, RISCV_IOMMU_CAP_PAS,
                        TARGET_PHYS_ADDR_SPACE_BITS);
@@ -1660,6 +2015,8 @@ static Property riscv_iommu_properties[] = {
         LIMIT_CACHE_IOT),
     DEFINE_PROP_BOOL("intremap", RISCVIOMMUState, enable_msi, TRUE),
     DEFINE_PROP_BOOL("off", RISCVIOMMUState, enable_off, TRUE),
+    DEFINE_PROP_BOOL("s-stage", RISCVIOMMUState, enable_s_stage, TRUE),
+    DEFINE_PROP_BOOL("g-stage", RISCVIOMMUState, enable_g_stage, TRUE),
     DEFINE_PROP_LINK("downstream-mr", RISCVIOMMUState, target_mr,
         TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 767e52c3d2..82ba549268 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -38,6 +38,8 @@ struct RISCVIOMMUState {
 
     bool enable_off;      /* Enable out-of-reset OFF mode (DMA disabled) */
     bool enable_msi;      /* Enable MSI remapping */
+    bool enable_s_stage;  /* Enable S/VS-Stage translation */
+    bool enable_g_stage;  /* Enable G-Stage translation */
 
     /* IOMMU Internal State */
     uint64_t ddtp;        /* Validated Device Directory Tree Root Pointer */
-- 
2.45.2


