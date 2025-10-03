Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B19CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTp-0007SZ-Hl; Thu, 02 Oct 2025 23:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTl-0007Rw-Rw
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:09 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTe-0001Qd-D4
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:09 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-33274fcf5c1so1848118a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462138; x=1760066938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ik1JHVLc+Pu/i5FRVMv/NQaG1gi/dWuXVteURjPkC2o=;
 b=IPLGQAaVkT8GVaby1kGvy5h9PpOjEYVoyr1OTlMGCUU31ECKt9SWZU1dESzoH9xHJW
 vEvjNA2G+A7sBGyeai1toBat0puA2iCUCphVT7sdpU9W8b/OaZM6Wj+mQ/Uc+kJyCnxe
 9ivH8Ut9ZnmnFJTXkX3Zxcn41iCbAvYyEOlJuprEzeJYNDrcS78pOOfivwyeT0I/XyU+
 GOYqS2RZKr14v5AROsPl6o35qYUOIvHarYc3orctAFhEHupVKYFf5pk6yKAYRz3ekogC
 s9o70B+0wXIbWXjAoAkKEUQWzeBDl8PMvqNLlyAz/TS4bNB4jxgmscMRX48e6uIsu4Be
 sfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462138; x=1760066938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ik1JHVLc+Pu/i5FRVMv/NQaG1gi/dWuXVteURjPkC2o=;
 b=IN9rbd4Bhal9JKaapHrUsGyCk9fEVnDD5PKq4dBL5arT6MhQK2p4h2YODY0tecGUvr
 8F0IuIeSfAC4CsOnhvg/DEyM4r4WUo7eQRZ7d4fQUTPcrMaH2aOejzqGWSZFpianve/8
 GOq6ItvYPL+rw33hndXTd4RwvYAlNsqnOD3/czI6JyBPacyLzy1b0jV6azUOJTHJ/mlI
 ot/3zPDAaZIbNvFW8fX+g6IjTt0D/2rNUwzoV3Kz5V1QA5NOooYftAIl4fEqNvw1LGwy
 IfSnSVvwepnvLGQzzwY/9+YY5r4M2+vXegeDFWAQEmRTfdkrgNhNo/ZQ06lUXhEJSNy3
 WZog==
X-Gm-Message-State: AOJu0YzkvYbRU7e1xJmEIeMV9RqtQWYIbeGKub5HLw76YtGBcSLsTo0V
 /Qg1Mpm/i1zUiPScciXjChg8W2bmRVRE0FXNyt1qn6MNPMi0/A1TPat+J9x4mg==
X-Gm-Gg: ASbGncsBLFOhI3ue8PjhUptIylUPn/ffv9iFNUZJT4Q0HbYBTxZSJKvbkg9hNLzQ43n
 IgFGEbW3R077bjr5+DkYLp4MTgDsuDoASL/fUCe5NHazmPRLWq8KRYtERqDL0cBYY+lflpk9qNv
 GQylpfVwbaJa+7WiIjdTNYozUNNpAhPa16sDdVh4puSiauPwpca8XSeTmVuNJi4Q5arigblvRXF
 IdPAJhsziknIiXOCyliWZT8AV4QxqXl8zewb9FrGB92JDCajSpBMWZw+HXI/9am8oEXZevMtFoE
 Jd4Yr3er75bMM2n/awqKvnq+RRO0WLnienRQ7iXZBt+iLTyHEal9u1Wa3cZ5C1P9MZIwsrOJG/l
 LNX7Yvws4Tjfbg2Gt/V+BLKeOxRuX5sX8eyurQCKXh+6l7s/r5SMZQ8kMDk+wxeERpEwGp1eLVg
 wWlwcmIzOIkK6ufM5SXtH/gA2TcvbnBFMdP3t6wXH/vjDtKw2etN9Sw7CoMzAjNgU=
X-Google-Smtp-Source: AGHT+IG7wVRiMbW1WM09nZNhYK5L4IOqVNVO7AohMlZdBTJMJhV8zwKyYgK49xKAiCtbXSi9JIbdTQ==
X-Received: by 2002:a17:90b:1811:b0:329:f630:6c3 with SMTP id
 98e67ed59e1d1-339c278a004mr2062931a91.20.1759462137573; 
 Thu, 02 Oct 2025 20:28:57 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:56 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>,
 qemu-stable@nongnu.org, Sebastien Boeuf <seb@rivosinc.com>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>,
 Nutty Liu <liujingqi@lanxincomputing.com>,
 Chen Pei <cp0613@linux.alibaba.com>,
 =?UTF-8?q?Fangyu=20Yu=C2=A0?= <fangyu.yu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/26] hw/riscv/riscv-iommu: Fixup PDT Nested Walk
Date: Fri,  3 Oct 2025 13:27:16 +1000
Message-ID: <20251003032718.1324734-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

Current implementation is wrong when iohgatp != bare. The RISC-V
IOMMU specification has defined that the PDT is based on GPA, not
SPA. So this patch fixes the problem, making PDT walk correctly
when the G-stage table walk is enabled.

Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
Cc: qemu-stable@nongnu.org
Cc: Sebastien Boeuf <seb@rivosinc.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>
Reviewed-by: Weiwei Li <liwei1518@gmail.com>
Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>
Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Message-ID: <20250913041233.972870-1-guoren@kernel.org>
[ Changes by AF:
 - Add braces to if statements
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 143 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 141 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 155190d032..b33c7fe325 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -869,6 +869,145 @@ static bool riscv_iommu_validate_process_ctx(RISCVIOMMUState *s,
     return true;
 }
 
+/**
+ * pdt_memory_read: PDT wrapper of dma_memory_read.
+ *
+ * @s: IOMMU Device State
+ * @ctx: Device Translation Context with devid and pasid set
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ * @attrs: memory transaction attributes
+ */
+static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
+                                   RISCVIOMMUContext *ctx,
+                                   dma_addr_t addr,
+                                   void *buf, dma_addr_t len,
+                                   MemTxAttrs attrs)
+{
+    uint64_t gatp_mode, pte;
+    struct {
+        unsigned char step;
+        unsigned char levels;
+        unsigned char ptidxbits;
+        unsigned char ptesize;
+    } sc;
+    MemTxResult ret;
+    dma_addr_t base = addr;
+
+    /* G stages translation mode */
+    gatp_mode = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
+    if (gatp_mode == RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {
+        goto out;
+    }
+
+    /* G stages translation tables root pointer */
+    base = PPN_PHYS(get_field(ctx->gatp, RISCV_IOMMU_ATP_PPN_FIELD));
+
+    /* Start at step 0 */
+    sc.step = 0;
+
+    if (s->fctl & RISCV_IOMMU_FCTL_GXL) {
+        /* 32bit mode for GXL == 1 */
+        switch (gatp_mode) {
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV32X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV32X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 2;
+            sc.ptidxbits = 10;
+            sc.ptesize   = 4;
+            break;
+        default:
+            return MEMTX_ACCESS_ERROR;
+        }
+    } else {
+        /* 64bit mode for GXL == 0 */
+        switch (gatp_mode) {
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV39X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 3;
+            sc.ptidxbits = 9;
+            sc.ptesize   = 8;
+            break;
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV48X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 4;
+            sc.ptidxbits = 9;
+            sc.ptesize   = 8;
+            break;
+        case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+            if (!(s->cap & RISCV_IOMMU_CAP_SV57X4)) {
+                return MEMTX_ACCESS_ERROR;
+            }
+            sc.levels    = 5;
+            sc.ptidxbits = 9;
+            sc.ptesize   = 8;
+            break;
+        default:
+            return MEMTX_ACCESS_ERROR;
+        }
+    }
+
+    do {
+        const unsigned va_bits = (sc.step ? 0 : 2) + sc.ptidxbits;
+        const unsigned va_skip = TARGET_PAGE_BITS + sc.ptidxbits *
+                                 (sc.levels - 1 - sc.step);
+        const unsigned idx = (addr >> va_skip) & ((1 << va_bits) - 1);
+        const dma_addr_t pte_addr = base + idx * sc.ptesize;
+
+        /* Address range check before first level lookup */
+        if (!sc.step) {
+            const uint64_t va_mask = (1ULL << (va_skip + va_bits)) - 1;
+            if ((addr & va_mask) != addr) {
+                return MEMTX_ACCESS_ERROR;
+            }
+        }
+
+        /* Read page table entry */
+        if (sc.ptesize == 4) {
+            uint32_t pte32 = 0;
+            ret = ldl_le_dma(s->target_as, pte_addr, &pte32, attrs);
+            pte = pte32;
+        } else {
+            ret = ldq_le_dma(s->target_as, pte_addr, &pte, attrs);
+        }
+        if (ret != MEMTX_OK) {
+            return ret;
+        }
+
+        sc.step++;
+        hwaddr ppn = pte >> PTE_PPN_SHIFT;
+
+        if (!(pte & PTE_V)) {
+            return MEMTX_ACCESS_ERROR; /* Invalid PTE */
+        } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
+            base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W */
+        } else if ((pte & (PTE_R | PTE_W | PTE_X)) == (PTE_W | PTE_X)) {
+            return MEMTX_ACCESS_ERROR; /* Reserved leaf PTE flags: PTE_W + PTE_X */
+        } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
+            return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
+        } else {
+            /* Leaf PTE, translation completed. */
+            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
+            break;
+        }
+
+        if (sc.step == sc.levels) {
+            return MEMTX_ACCESS_ERROR; /* Can't find leaf PTE */
+        }
+    } while (1);
+
+out:
+    return dma_memory_read(s->target_as, base, buf, len, attrs);
+}
+
 /*
  * RISC-V IOMMU Device Context Loopkup - Device Directory Tree Walk
  *
@@ -1041,7 +1180,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
          */
         const int split = depth * 9 + 8;
         addr |= ((ctx->process_id >> split) << 3) & ~TARGET_PAGE_MASK;
-        if (dma_memory_read(s->target_as, addr, &de, sizeof(de),
+        if (pdt_memory_read(s, ctx, addr, &de, sizeof(de),
                             MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
             return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
         }
@@ -1056,7 +1195,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
 
     /* Leaf entry in PDT */
     addr |= (ctx->process_id << 4) & ~TARGET_PAGE_MASK;
-    if (dma_memory_read(s->target_as, addr, &dc.ta, sizeof(uint64_t) * 2,
+    if (pdt_memory_read(s, ctx, addr, &dc.ta, sizeof(uint64_t) * 2,
                         MEMTXATTRS_UNSPECIFIED) != MEMTX_OK) {
         return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
     }
-- 
2.51.0


