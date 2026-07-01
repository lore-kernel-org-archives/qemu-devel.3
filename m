Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8580C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes28-0001ml-TS; Wed, 01 Jul 2026 06:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes27-0001fN-3C
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:07 -0400
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wes25-0004kJ-2a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:19:06 -0400
Received: by mail-dl1-x1236.google.com with SMTP id
 a92af1059eb24-13b355fbb1aso1329719c88.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782901143; x=1783505943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhENzOUqR+TAhkBy5Ks34rrGWxP8C+BUaIDvOT5TctA=;
 b=Ghi1nJmm/1RuIy51aph8+QzOS8WjihXTsK8XZANMG7BfNtnG82E8UVCeEKSw0Rt/II
 S2T/Xs8UWEytqdu7z24VtpurzLWPJDlmRsbZ6+Vl7tzgp6Yj8e446WWT4YNnXRNFw2/g
 xyMVXVHw6fAPMJ1I4Mv/zWXZTTaPAg4aahKyU/CkpAFADrKMCxSXKs20Mt8khVavHGjS
 3DaRbJX3XohS27MIu0XhAmQbyvZT49BNSL0eGYsnmiAikkll+3arF97gGAWhsDO/cLjN
 svB204koDY4fNvOATTuZi25qJdBuDIUQpC2fvnMaKxXCdUIOdlmMGOuUBuAXZvyyCDuA
 JmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901143; x=1783505943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EhENzOUqR+TAhkBy5Ks34rrGWxP8C+BUaIDvOT5TctA=;
 b=lTDO/INmr/Tx81jRFTx6Un5gDVOjwbL0UY2W+vXYyBG8KNsAZvj+kk1lGXGlvJ5T0m
 L5ieZvEvZC/JoW+1rnNPzx9L3tEQcFURy3avL+b+O8nNaLrF7KKAJjRWdE4wqPgJ/Kw/
 Pc0MtpAfmd2ffhpUqD7L5zAn+jEzHdxoAcEmGsiWCI9yuZUEU4gwpaAdbHtyvYj7+M3x
 kz8s38oecIyQBfeNeiQhOIe1/sI6f/T91snBl/2itH+MG5I5xsLx1EMhIj5ohskxx5px
 a+N0aQaxrrGPSD42+eI76n0zU9VJ4+TJkWbRIBwSm4l280F9m+zyGin8rX2aCY60JekV
 l3aA==
X-Gm-Message-State: AOJu0YwLWKZEcqPRamjm5CK63nUfXegzHrIyef/HGgw7TKGV+lHt0NZq
 RfQfwIRFXtnhQFpxyirYdXcUT1/AfHL8Pi7lZItRKPYvkD3iivaQj+7VArptBw==
X-Gm-Gg: AfdE7cmiYt94XjOTVFy7Pufjt9SEuyrw4YuNGG/CEJLKtMvJJq+SPRm1D6qLzk7bSjU
 6KcssirvgOMV5mTGylAinS7LjJvrHQdZ3kJxEGoqpK8prUkZgocv60N4SHF6t5ZH+Ck46jE77eV
 vklkEenR+8Wrq/0SmlyXONba2aQ8x/Ytuc9s5q/Cud+ogjZRzLV7Bsqt3IpklyWcHDyM001xnm2
 xbCjQGwZ4MjdFh3LCTYjBv4f+RusOi8EdDZJwTQHsenSDyUJunpTn1aasLkkwCoHgOxfZyffapR
 fVK1Qa6q7zAqnSRjpId2nwqeT7CQ6zZQtlX1rzJE5RkgBYDFja99skmkfUpkWb44f6KptIcvHY2
 V+DZEcFXCEp1Jg6VCSYhrD2GwEBZFnvDU4UoCPxSgquxMm1NyougjsGZ2TZ2GoLpskyhD+tI6h7
 wMKIPd9f0/4wzfudKqtLHGNjIT2thMrKI=
X-Received: by 2002:a05:7022:f8e:b0:139:ed5d:3ac with SMTP id
 a92af1059eb24-13b3914c436mr195992c88.49.1782901143131; 
 Wed, 01 Jul 2026 03:19:03 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab2e0e3sm19355047c88.7.2026.07.01.03.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:19:02 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/39] hw/riscv/riscv-iommu: rename regs_rw to regs
Date: Wed,  1 Jul 2026 20:17:31 +1000
Message-ID: <20260701101752.2522962-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701101752.2522962-1-alistair.francis@wdc.com>
References: <20260701101752.2522962-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1236;
 envelope-from=alistair23@gmail.com; helo=mail-dl1-x1236.google.com
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

The existing nomenclature can be misleading: regs_rw can cosplay as
'read and write' mask, in particular because we have regs_ro which is a
read only mask.

regs_rw is the current reg value, and all bits that aren't on the
regs_ro mask is considered r/w bits.

Rename regs_rw to 'regs' to be on par with the nomenclature other
devices uses (e.g. cadence_gem).

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260625210833.3294437-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.h     | 26 +++++++++++++++-----------
 hw/riscv/riscv-iommu-hpm.c |  4 ++--
 hw/riscv/riscv-iommu.c     | 36 ++++++++++++++++++------------------
 3 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
index 2a9f6fccd5..a778e86fb7 100644
--- a/hw/riscv/riscv-iommu.h
+++ b/hw/riscv/riscv-iommu.h
@@ -76,9 +76,13 @@ struct RISCVIOMMUState {
 
     /* MMIO Hardware Interface */
     MemoryRegion regs_mr;
-    uint8_t *regs_rw;  /* register state (user write) */
+    uint8_t *regs;  /* current register state */
     uint8_t *regs_wc;  /* write-1-to-clear mask */
-    uint8_t *regs_ro;  /* read-only mask */
+    /*
+     * read-only mask. NOTE: bits not present in this RO
+     * mask are assumed to be read and write.
+     */
+    uint8_t *regs_ro;
 
     QLIST_ENTRY(RISCVIOMMUState) iommus;
     QLIST_HEAD(, RISCVIOMMUSpace) spaces;
@@ -120,39 +124,39 @@ struct RISCVIOMMUContext {
 static inline uint32_t riscv_iommu_reg_mod32(RISCVIOMMUState *s,
     unsigned idx, uint32_t set, uint32_t clr)
 {
-    uint32_t val = ldl_le_p(s->regs_rw + idx);
-    stl_le_p(s->regs_rw + idx, (val & ~clr) | set);
+    uint32_t val = ldl_le_p(s->regs + idx);
+    stl_le_p(s->regs + idx, (val & ~clr) | set);
     return val;
 }
 
 static inline void riscv_iommu_reg_set32(RISCVIOMMUState *s, unsigned idx,
                                          uint32_t set)
 {
-    stl_le_p(s->regs_rw + idx, set);
+    stl_le_p(s->regs + idx, set);
 }
 
 static inline uint32_t riscv_iommu_reg_get32(RISCVIOMMUState *s, unsigned idx)
 {
-    return ldl_le_p(s->regs_rw + idx);
+    return ldl_le_p(s->regs + idx);
 }
 
 static inline uint64_t riscv_iommu_reg_mod64(RISCVIOMMUState *s, unsigned idx,
                                              uint64_t set, uint64_t clr)
 {
-    uint64_t val = ldq_le_p(s->regs_rw + idx);
-    stq_le_p(s->regs_rw + idx, (val & ~clr) | set);
+    uint64_t val = ldq_le_p(s->regs + idx);
+    stq_le_p(s->regs + idx, (val & ~clr) | set);
     return val;
 }
 
 static inline void riscv_iommu_reg_set64(RISCVIOMMUState *s, unsigned idx,
                                          uint64_t set)
 {
-    stq_le_p(s->regs_rw + idx, set);
+    stq_le_p(s->regs + idx, set);
 }
 
 static inline uint64_t riscv_iommu_reg_get64(RISCVIOMMUState *s,
-    unsigned idx)
+                                             unsigned idx)
 {
-    return ldq_le_p(s->regs_rw + idx);
+    return ldq_le_p(s->regs + idx);
 }
 #endif
diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
index 5bf80a8db9..9bfef6db45 100644
--- a/hw/riscv/riscv-iommu-hpm.c
+++ b/hw/riscv/riscv-iommu-hpm.c
@@ -60,8 +60,8 @@ static void hpm_incr_ctr(RISCVIOMMUState *s, uint32_t ctr_idx)
     const uint32_t off = ctr_idx << 3;
     uint64_t cntr_val;
 
-    cntr_val = ldq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
+    cntr_val = ldq_le_p(&s->regs[RISCV_IOMMU_REG_IOHPMCTR_BASE + off]);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_IOHPMCTR_BASE + off], cntr_val + 1);
 
     trace_riscv_iommu_hpm_incr_ctr(cntr_val);
 
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index a500cb8440..30f16b999c 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2034,8 +2034,8 @@ static void riscv_iommu_process_cq_control(RISCVIOMMUState *s)
         s->cq_mask = (2ULL << get_field(base, RISCV_IOMMU_CQB_LOG2SZ)) - 1;
         s->cq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_CQB_PPN));
         stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQT], ~s->cq_mask);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQH], 0);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_CQT], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_CQH], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_CQT], 0);
         ctrl_set = RISCV_IOMMU_CQCSR_CQON;
         ctrl_clr = RISCV_IOMMU_CQCSR_BUSY | RISCV_IOMMU_CQCSR_CQMF |
                    RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_CMD_TO |
@@ -2075,8 +2075,8 @@ static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
         s->fq_mask = (2ULL << get_field(base, RISCV_IOMMU_FQB_LOG2SZ)) - 1;
         s->fq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_FQB_PPN));
         stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_FQH], ~s->fq_mask);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQH], 0);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_FQT], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_FQH], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_FQT], 0);
         ctrl_set = RISCV_IOMMU_FQCSR_FQON;
         ctrl_clr = RISCV_IOMMU_FQCSR_BUSY | RISCV_IOMMU_FQCSR_FQMF |
             RISCV_IOMMU_FQCSR_FQOF;
@@ -2105,8 +2105,8 @@ static void riscv_iommu_process_pq_control(RISCVIOMMUState *s)
         s->pq_mask = (2ULL << get_field(base, RISCV_IOMMU_PQB_LOG2SZ)) - 1;
         s->pq_addr = PPN_PHYS(get_field(base, RISCV_IOMMU_PQB_PPN));
         stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_PQH], ~s->pq_mask);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQH], 0);
-        stl_le_p(&s->regs_rw[RISCV_IOMMU_REG_PQT], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_PQH], 0);
+        stl_le_p(&s->regs[RISCV_IOMMU_REG_PQT], 0);
         ctrl_set = RISCV_IOMMU_PQCSR_PQON;
         ctrl_clr = RISCV_IOMMU_PQCSR_BUSY | RISCV_IOMMU_PQCSR_PQMF |
             RISCV_IOMMU_PQCSR_PQOF;
@@ -2276,9 +2276,9 @@ static void riscv_iommu_write_reg_val(RISCVIOMMUState *s,
 {
     uint64_t ro = ldn_le_p(&s->regs_ro[reg_addr], size);
     uint64_t wc = ldn_le_p(&s->regs_wc[reg_addr], size);
-    uint64_t rw = ldn_le_p(&s->regs_rw[reg_addr], size);
+    uint64_t curr_val = ldn_le_p(&s->regs[reg_addr], size);
 
-    stn_le_p(dest, size, ((rw & ro) | (data & ~ro)) & ~(data & wc));
+    stn_le_p(dest, size, ((curr_val & ro) | (data & ~ro)) & ~(data & wc));
 }
 
 static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
@@ -2378,12 +2378,12 @@ static MemTxResult riscv_iommu_mmio_write(void *opaque, hwaddr addr,
      * is set IOMMU behavior of additional writes to the register
      * is UNSPECIFIED.
      */
-    riscv_iommu_write_reg_val(s, &s->regs_rw[addr], addr, size, data);
+    riscv_iommu_write_reg_val(s, &s->regs[addr], addr, size, data);
 
     /* Busy flag update, MSB 4-byte register. */
     if (busy) {
-        uint32_t rw = ldl_le_p(&s->regs_rw[regb]);
-        stl_le_p(&s->regs_rw[regb], rw | busy);
+        uint32_t rw = ldl_le_p(&s->regs[regb]);
+        stl_le_p(&s->regs[regb], rw | busy);
     }
 
     /* Process HPM writes and update any internal state if needed. */
@@ -2428,13 +2428,13 @@ static MemTxResult riscv_iommu_mmio_read(void *opaque, hwaddr addr,
          * it's not dependent over the timer callback and is computed
          * from cycle overflow.
          */
-        val = ldq_le_p(&s->regs_rw[addr]);
+        val = ldq_le_p(&s->regs[addr]);
         val |= (riscv_iommu_hpmcycle_read(s) & RISCV_IOMMU_IOHPMCYCLES_OVF)
                    ? RISCV_IOMMU_IOCOUNTOVF_CY
                    : 0;
         ptr = (uint8_t *)&val + (addr & 3);
     } else {
-        ptr = &s->regs_rw[addr];
+        ptr = &s->regs[addr];
     }
 
     val = ldn_le_p(ptr, size);
@@ -2529,7 +2529,7 @@ static void riscv_iommu_instance_init(Object *obj)
     s->cap |= RISCV_IOMMU_CAP_PD8;
 
     /* register storage */
-    s->regs_rw = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
+    s->regs = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
     s->regs_ro = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
     s->regs_wc = g_new0(uint8_t, RISCV_IOMMU_REG_SIZE);
 
@@ -2554,7 +2554,7 @@ static void riscv_iommu_instance_finalize(Object *obj)
 {
     RISCVIOMMUState *s = RISCV_IOMMU(obj);
 
-    g_free(s->regs_rw);
+    g_free(s->regs);
     g_free(s->regs_ro);
     g_free(s->regs_wc);
 
@@ -2608,8 +2608,8 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         "riscv-iommu-regs", RISCV_IOMMU_REG_SIZE);
 
     /* Set power-on register state */
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_CAP], s->cap);
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_FCTL], 0);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_CAP], s->cap);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_FCTL], 0);
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
              ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
@@ -2634,7 +2634,7 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
         RISCV_IOMMU_PQCSR_BUSY);
     stl_le_p(&s->regs_wc[RISCV_IOMMU_REG_IPSR], ~0);
     stl_le_p(&s->regs_ro[RISCV_IOMMU_REG_ICVEC], 0);
-    stq_le_p(&s->regs_rw[RISCV_IOMMU_REG_DDTP], s->ddtp);
+    stq_le_p(&s->regs[RISCV_IOMMU_REG_DDTP], s->ddtp);
     /* If debug registers enabled. */
     if (s->cap & RISCV_IOMMU_CAP_DBG) {
         stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_TR_REQ_IOVA], 0);
-- 
2.54.0


