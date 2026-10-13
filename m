Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71150CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY5j-0002w6-At; Tue, 13 Oct 2026 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY46-0000In-S3
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:57 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY44-00084r-0N
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so1159814f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880850; x=1792485650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Sw6qKX4jnZDlIg+Q6bC4x/Bq9Cid04bGlCnmLqCpsaM=;
 b=WDfkel6Oj462W8rk/BzrAK5FKtOxOLWYIP1JfZkiWzCFCDH6iQauxHPa0iKnOeFp5D
 U88x8ZMVLjMlzGW8xPnUUP377i2v7gdX3QV1abRZiPEBE90wVSV8Smt3CahFiWXo2cXW
 eUk3qtzVIRz2BiQiBeyCujlGko49xgvOgPHrI0aLrRt1JsjGVNoJMmhEx815LIbamtsZ
 R3VWDFA02RjeEm8yoF6Y0ZrviZcWNV/HSgX81UCmofoTkqJagKH43JEWubeSXzq37MQv
 eVAoTshljLmp67J7FsY6+eHgS5K9joMrW5IEGr1uXSHtFnDAMr6cS4Ma8V79c1LccrH/
 Q8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880850; x=1792485650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sw6qKX4jnZDlIg+Q6bC4x/Bq9Cid04bGlCnmLqCpsaM=;
 b=NPyNp5BavPuwFjeQYo0rDUKi12+8wRY/LVXE1KPLCXureSszJHBCCDCrS1tXV04FTw
 2OgsQG7urELWlZITgA/cx622UOCOXikNvD6PGbK56yP4z/Swm3+dPKM6gV8b/ei1pFIB
 rp5ucrvYtYzvkKQTMhMxH/5OJyeCVdrnUtDbqKUSTTwyRMuRyMGPF4hGpH19f/7ysUNE
 KrPimG+rnbKHdGuy9faU+6xdc3gZ5NkCyxhwXzLKescAS7tx1pSvkVAAiYfffgC9hNqR
 lTxrpCC546+qyHYJNusIK7aryQpRiV8wCX9ItRErcBDN4F0vNJiEsXUzgGOhuPrkeI2u
 Jjcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyOBDlYUGEerQijzBg6g1QO3oyZocDZM3vlYUY0oNUlV2AfaxCiYiYI3IdjeJs9MkM9ENhb5ORSM5c@nongnu.org
X-Gm-Message-State: AFq9FYK80Fpn5OcDU9vAsDuenykYLAeEn+IwO4ETgg0dqVyAFrlDFjK+
 6tq1QmuhXCn0DGErreRoDEZsph24J+VcE4cLw6uUNQSrP2lCpBE5FMzh+8CyHjLlHvA=
X-Gm-Gg: AYBFou3wmP4rei/oJVUiBio6X3QpYzJkzVVFnVIfrTmIT3+y25RaKONuReJu2JfpPDe
 7/8Wy5RQPdnY8XOV1uDy1Owg0/FwT2LnC3B7XWhsJzLpQ2GYAW1o7O0lHE5yOfC9k8E/6/p/eHd
 KdJZ91x1rY/oHBRTZKllA4Yj1HhvYyGQWx3kcqwoG1SG6jIOgbVGgQ0YHm+wEC1yQS3p5bveAoo
 mvso1S7KjEaaepiGg+HRHkbUKgpvthj2yn3n6GVAIQ2O2AokwtwXnvLepewgRoTZHv06mcgihn8
 X/XtWAAQv4C+9+a59N95Y3z4kPhvf6jOgnNiXiJbwnKHmojGSRGnOXMKpgswNxz58hJAz2n5IHU
 M2pmcgKg87haLeBod5py2NX5TfFWzB8CcFRFS9P10VmrEtG9IPHKm3BVCUvLKAxZcT4MQ9wOOk4
 etPGSf6GOSqiFYKhJ3bUdrWJ3hOEx/x44tgX3k8OfDd8ETjzJpFviXVEM+dadNRGCNVCZH+4lFr
 ze2x0Xn5QB/k4nIz8kJrmglttU167MQjlCdMWjVVA3aetV5lzedTdnwwcZjj4Vokx2ZShJQgAQC
 WI0=
X-Received: by 2002:a05:600c:871b:b0:4a1:a2f3:e6f7 with SMTP id
 5b1f17b1804b1-4a1a2f3e8a9mr85732845e9.29.1791880849735; 
 Tue, 13 Oct 2026 01:40:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 56/86] hw/intc/arm_gicv5: Implement IRS_VMAP_VMR
Date: Tue, 13 Oct 2026 09:39:03 +0100
Message-ID: <20261013083933.1024405-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

The IRS_VMAP_VMR register lets the guest mark a VM as valid.  This is
a 64-bit register similar in operation to IRS_VMAP_L2_VMTR.

We are eventually going to want to cache the information in a VM
table entry, but for the moment implement the "make valid" operation
as simply writing 1 to the VALID bit in the L2 VMTE.

Note that unlike many of the other address fields in GICv5 data
structures, we don't need to clear any of the low bits in
L1_VMTE.L2_ADDR beyond masking with R_L1_VMTE_L2_ADDR_MASK.  This is
because a level 2 VMT is always 4KB and so the alignment is fixed;
the mask clears the low 12 bits, enforcing 4KB alignment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 94 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |  1 +
 hw/intc/trace-events               |  1 +
 include/hw/intc/arm_gicv5_common.h |  1 +
 include/hw/intc/arm_gicv5_regs.h   | 21 +++++++
 5 files changed, 118 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index a81f7803ca5..f03b790cf41 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1309,6 +1309,65 @@ static void irs_vmap_l2_vmtr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
         goto txfail;
     }
 
+    trace_gicv5_vmap_l2_vmtr(domain_name[domain], vmid);
+
+    return;
+
+txfail:
+    /* Reportable with EC=0x0 if sw error reporting implemented */
+    qemu_log_mask(LOG_GUEST_ERROR, "L1 VMTE update failed for VMID 0x%x at "
+                  "physical address 0x" HWADDR_FMT_plx "\n", vmid, l1_addr);
+}
+
+static void irs_vmap_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5VMTConfig *cfg = &s->vmt_config[domain];
+    uint32_t vmid = FIELD_EX64(value, IRS_VMAP_VMR, VM_ID);
+    bool m = FIELD_EX64(value,  IRS_VMAP_VMR, M);
+    bool u = FIELD_EX64(value,  IRS_VMAP_VMR, U);
+    hwaddr l1_addr, l2_addr;
+    uint64_t l1_vmte, l2_vmte_0;
+    MemTxResult res;
+
+    if (!gicv5_domain_has_virt(cs, domain) || !cfg->valid) {
+        /* Whole register RAZ/WI if no virt or no VM table */
+        return;
+    }
+
+    /* M bit is WO/UNKNOWN; write the other fields */
+    cs->irs_vmap_vmr[domain] = value & ~R_IRS_VMAP_VMR_M_MASK;
+
+    if (!m || vmid >= (1 << cfg->vm_id_bits)) {
+        return;
+    }
+
+    /* Find the L1 VMTE */
+    l1_addr = l1_vmte_addr(cs, cfg, vmid);
+    l1_vmte = address_space_ldq_le(&cs->dma_as, l1_addr, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
+    if (FIELD_EX64(l1_vmte, L1_VMTE, VALID) == 0) {
+        /* No effect if L2 VM table is not valid */
+        return;
+    }
+
+    l2_addr = l1_vmte & R_L1_VMTE_L2_ADDR_MASK;
+
+    l2_vmte_0 = address_space_ldq_le(&cs->dma_as, l2_addr, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
+    l2_vmte_0 = FIELD_DP64(l2_vmte_0, L2_VMTE_0, VALID, !u);
+
+    address_space_stq_le(&cs->dma_as, l2_addr, l2_vmte_0, cfg->txattrs, &res);
+    if (res != MEMTX_OK) {
+        goto txfail;
+    }
+
     return;
 
 txfail:
@@ -1472,6 +1531,22 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VMAP_VMR:
+        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
+            *data = extract64(cs->irs_vmap_vmr[domain], 0, 32);
+        } else {
+            /* RAZ/WI if no virt or no VM table */
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VMAP_VMR + 4:
+        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
+            *data = extract64(cs->irs_vmap_vmr[domain], 32, 32);
+        } else {
+            /* RAZ/WI if no virt or no VM table */
+            *data = 0;
+        }
+        return true;
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1604,6 +1679,14 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
                                deposit64(cs->irs_vmap_l2_vmtr[domain],
                                          32, 32, data));
         return true;
+    case A_IRS_VMAP_VMR:
+        irs_vmap_vmr_write(s, domain,
+                           deposit64(cs->irs_vmap_vmr[domain], 0, 32, data));
+        return true;
+    case A_IRS_VMAP_VMR + 4:
+        irs_vmap_vmr_write(s, domain,
+                           deposit64(cs->irs_vmap_vmr[domain], 32, 32, data));
+        return true;
     case A_IRS_SPI_SELR:
         cs->irs_spi_selr[domain] = data;
         return true;
@@ -1704,6 +1787,14 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VMAP_VMR:
+        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
+            *data = cs->irs_vmap_l2_vmtr[domain];
+        } else {
+            /* RAZ/WI if no virt or no VM table */
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
@@ -1722,6 +1813,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_VMAP_L2_VMTR:
         irs_vmap_l2_vmtr_write(s, domain, data);
         return true;
+    case A_IRS_VMAP_VMR:
+        irs_vmap_vmr_write(s, domain, data);
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 945257fef2c..19338ad5b9c 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -109,6 +109,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
         memset(cs->irs_vmt_baser, 0, sizeof(cs->irs_vmt_baser));
         memset(cs->irs_vmt_cfgr, 0, sizeof(cs->irs_vmt_cfgr));
         memset(cs->irs_vmap_l2_vmtr, 0, sizeof(cs->irs_vmap_l2_vmtr));
+        memset(cs->irs_vmap_vmr, 0, sizeof(cs->irs_vmap_vmr));
     }
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 30e2fc42471..4b47b98e66c 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -248,6 +248,7 @@ gicv5_irs_recalc_hppi_fail(const char *domain, uint32_t iaffid, const char *reas
 gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t prio) "GICv5 IRS %s IAFFID %u: new HPPI ID 0x%x prio %u"
 gicv5_vmt_valid(const char *domain, uint64_t base, uint8_t vm_id_bits, bool structure) "GICv5 IRS %s VM table now valid: base 0x%" PRIx64 " vm_id_bits %u 2-level %d"
 gicv5_vmt_invalid(const char *domain) "GICv5 IRS %s VM table no longer valid"
+gicv5_vmap_l2_vmtr(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u now valid"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 19700c7d5e3..5707111b98a 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -92,6 +92,7 @@ struct GICv5Common {
     uint64_t irs_vmt_baser[NUM_GICV5_DOMAINS];
     uint32_t irs_vmt_cfgr[NUM_GICV5_DOMAINS];
     uint64_t irs_vmap_l2_vmtr[NUM_GICV5_DOMAINS];
+    uint64_t irs_vmap_vmr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
diff --git a/include/hw/intc/arm_gicv5_regs.h b/include/hw/intc/arm_gicv5_regs.h
index d675a10c37f..edc66887ac4 100644
--- a/include/hw/intc/arm_gicv5_regs.h
+++ b/include/hw/intc/arm_gicv5_regs.h
@@ -273,6 +273,27 @@ FIELD(L2_ISTE, IAFFID, 16, 16)
 FIELD(L1_VMTE, VALID, 0, 1)
 FIELD(L1_VMTE, L2_ADDR, 12, 44)
 
+/* The L2 VMTE is 32 bytes, four 64-bit words */
+FIELD(L2_VMTE_0, VALID, 0, 1)
+FIELD(L2_VMTE_0, VMD_ADDR, 3, 53)
+
+FIELD(L2_VMTE_1, VPET_ADDR, 3, 53)
+FIELD(L2_VMTE_1, VPE_ID_BITS, 59, 5)
+
+FIELD(L2_VMTE_2, LPI_IST_VALID, 0, 1)
+FIELD(L2_VMTE_2, LPI_IST_L2SZ, 1, 2)
+FIELD(L2_VMTE_2, LPI_IST_ADDR, 6, 50)
+FIELD(L2_VMTE_2, LPI_ISTSZ, 56, 2)
+FIELD(L2_VMTE_2, LPI_IST_STRUCTURE, 58, 1)
+FIELD(L2_VMTE_2, LPI_ID_BITS, 59, 5)
+
+FIELD(L2_VMTE_3, SPI_IST_VALID, 0, 1)
+FIELD(L2_VMTE_3, SPI_IST_L2SZ, 1, 2)
+FIELD(L2_VMTE_3, SPI_IST_ADDR, 6, 50)
+FIELD(L2_VMTE_3, SPI_ISTSZ, 56, 2)
+FIELD(L2_VMTE_3, SPI_IST_STRUCTURE, 58, 1)
+FIELD(L2_VMTE_3, SPI_ID_BITS, 59, 5)
+
 /*
  * L2 VMTEs are always 32 bytes, and the L2 table is always 4KB,
  * so the lower 7 bits in a VM ID index the L2 table.
-- 
2.43.0


