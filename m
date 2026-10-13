Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2383CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8H-0006q3-Ac; Tue, 13 Oct 2026 04:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4B-0000Lr-AR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY48-00086S-Fz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so20441265e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880855; x=1792485655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cp3KantnVGijsCKr6brtTMcQWEyeFUMvGoR0UlMwu5w=;
 b=vs7+73FQhqUYiA3CeY25xps7e1jQCmcXz/8L+rUpPsDC66wLde6Y3Ga+/OBOfGl9wp
 Hv4SnUSbTQzwgD6MwtsxmV6wkxS/AwXUbB6tdtZT3n8xFFkqJaJFQ4CNvnQshm1bvg7h
 kdk/IjCCBSR5xR/EooBJ/AIcB++slyDsZRTpFj0j3ZuyzSm5PisJKNHWYBFRwQKCNF3Z
 VVYdEm7asxruD7RZS+F+nThmvHHJYPkmO/TVDVynmMay8tz920RLmCEni6SbHZXGaxMD
 8ft9jsngdxYRGphwR7VSrgGnKa5iHZUERppRLtEa5u276EdGt8WtiD795QqkwMpBnwwx
 9wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880855; x=1792485655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cp3KantnVGijsCKr6brtTMcQWEyeFUMvGoR0UlMwu5w=;
 b=XGsYIINVAJstWCXQFNqoTVV9FJ0Oh18GMPepbFPh9LEtO6R+emK46XwJi3tj2bv7hD
 CUqeWz/EhVf+ITEvr32jizFNU+MB0i+p9UqNKgHuRegCITbbyE3gCYw2nVnO5O8nTY4q
 Rwa/HFo7UP+ChpJ5srtFmVMDER1UI9SD2VQD3w1WqOmYmvxYtRLhaGWwIXeKaC8m3C+K
 FjWRjE9tA/0Ai2zBp9jXSmNiLo3iWWVKcpRfMAgbO6ONLENoonln4QuiLgGwtU5I+Yvo
 jJCGqO/shwoXmA6OzwS8d7WCWo7+/OgJRxolmjCUUm/KG+RR6dlq0w3j3v5Cqh0kUEio
 d+jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8GRpprVJMatQuUEb4cPHwfEkZ/tPEDOCZQWde98RFQ+BBIKPGUDiJFIvSICxxZNRMMUyZKHuOP5R7@nongnu.org
X-Gm-Message-State: AFq9FYKTAO9sfIY7KeZjuZW7pmAjpuC/ULkgvHyDHtYf2AO1hv84W8oh
 Ys42eWfsuOewkDj845LPgM+Hy9yndhH1r3CAkP0Zrbh+yOdE3uJBK50+mBB5lDaibHVFQPqCLXe
 bDiLBkLQ=
X-Gm-Gg: AYBFou0YrAHrOC/iSxOfgfi16JM+OJ53Rb0+CtWaPPpi+y6cyMhAPAGYUxGDmo07BwZ
 Hmja8YQ26gvbrp82fUa93lUfqOTPGDw8eWkwfPMs9L3sLi3gdw3LpPG2ONj0AhOclRshAtck5Rw
 vh+TCrRy9A9G5tD+6iqdUDRjCJeugUnevJtIyJcBUD8DXhY+m3BcpM0IOq3xzGJYOYSRsgcOdmv
 8QZjE+KaxjkCL9cgm+Bc3xRInsdmfi0V3ljJ1TsXGqkD6VllGAnDekDV6p5zz7h8nLxL3If0l7m
 9K5G11szwil+eiS41nJEOi6Gd/S7RMiqJ7dQKV3rZnQKPQTknCq6GDwmg/2VBytitP4+oxQRXp6
 pHZwxp4CyLG9eHpifbl8O6m1Lv98dz+5EtYrSiYLDVsWAcv3I9bHrgLBLwp/VNGOzvN6sWfYqCP
 J0vwL70qFzamZW86BPSkkBfBai1csLE4mjxwu3cU6aee6jvlglIxSqVGvwEKJwP/5uM1pBkaoZN
 b1TbsqJFNQeHfaSYchuvmvJVV0PvsCf1zIeDjjX0xAfluBGyNDwltNuOmRCfjJZith7vIerDNn9
 ERs=
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a18e4d6636mr236952995e9.29.1791880854830; 
 Tue, 13 Oct 2026 01:40:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 60/86] hw/intc/arm_gicv5: Implement IRS_VMAP_VISTR
Date: Tue, 13 Oct 2026 09:39:07 +0100
Message-ID: <20261013083933.1024405-61-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

A VM in the VM table does not have to specify the LPI and
SPI ISTs up-front. Instead, it can leave the VMTE LPI_IST_VALID
or SPI_IST_VALID bits 0, and set up the IST later using
IRS_VMAP_VISTR. The sequence here is:
 * software writes to the L2 VM table entry to set the
   configuration fields associated with the IST
 * software writes to IRS_VMAP_VISTR
 * the IRS reads the info from the L2 VM table entry,
   sets up the IST, and writes to the VALID bit in the
   L2 VM table entry

Software can also use IRS_VMAP_VISTR to change an IST from
valid to invalid.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 154 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |   1 +
 hw/intc/trace-events               |   1 +
 include/hw/intc/arm_gicv5_common.h |   1 +
 4 files changed, 157 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 3e8b20b6e9a..1d6f2767d02 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1438,6 +1438,29 @@ static void irs_clean_vm_cache(GICv5Common *cs, GICv5VMTConfig *cfg)
     g_hash_table_foreach_remove(cfg->vm_cache, irs_clean_vm_cache_entry, &ud);
 }
 
+static void invalidate_vlpi_ist_config(GICv5Common *cs, GICv5Domain domain,
+                                       VMTE *vmte)
+{
+    /*
+     * Make the VLPI IST invalid. The caller must also update the
+     * VALID bit in the L2 VMTE in guest memory.
+     * We must write any cached VLPI IST info back to guest memory,
+     */
+    irs_clean_lpi_cache(cs, &vmte->lpi_ist);
+    vmte->lpi_ist.valid = false;
+}
+
+static void invalidate_vspi_ist_config(GICv5Common *cs, GICv5Domain domain,
+                                       VMTE *vmte)
+{
+    /*
+     * Make the VSPI IST invalid. The caller must also update the
+     * VALID bit in the L2 VMTE in guest memory.
+     */
+    irs_clean_lpi_cache(cs, &vmte->spi_ist);
+    vmte->spi_ist.valid = false;
+}
+
 static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -1668,6 +1691,101 @@ txfail:
                   "physical address 0x" HWADDR_FMT_plx "\n", vmid, l1_addr);
 }
 
+static void irs_vmap_vistr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5VMTConfig *cfg = &s->vmt_config[domain];
+    uint32_t vmid = FIELD_EX64(value, IRS_VMAP_VISTR, VM_ID);
+    bool m = FIELD_EX64(value,  IRS_VMAP_VISTR, M);
+    /* U = 0 for "make invalid", 1 for "make valid" */
+    bool valid = !FIELD_EX64(value,  IRS_VMAP_VISTR, U);
+    GICv5IntType type = FIELD_EX64(value, IRS_VMAP_VISTR, TYPE);
+    uint64_t l2_vmte[L2_VMTE_WORDS];
+    MemTxResult res;
+    VMTE *vmte;
+    bool was_valid;
+
+    if (!gicv5_domain_has_virt(cs, domain) || !cfg->valid) {
+        /* Whole register RAZ/WI if no virt or no VM table */
+        return;
+    }
+
+    /* M bit is WO/UNKNOWN; write the other fields */
+    cs->irs_vmap_vistr[domain] = value & ~R_IRS_VMAP_VISTR_M_MASK;
+
+    /*
+     * M = 0 and bad VMID must be ignored; invalid TYPE is
+     * UNPREDICTABLE, and we choose to ignore
+     */
+    if (!m || vmid >= (1 << cfg->vm_id_bits) ||
+        (type != GICV5_LPI && type != GICV5_SPI)) {
+        return;
+    }
+
+    trace_gicv5_irs_vmap_vistr_write(domain_name[domain], vmid,
+                                     inttype_name(type),
+                                     valid ? "valid" : "invalid");
+
+    vmte = g_hash_table_lookup(cfg->vm_cache, GINT_TO_POINTER(vmid));
+    if (!vmte) {
+        /* VM is not valid */
+        return;
+    }
+
+    was_valid = type == GICV5_LPI ? vmte->lpi_ist.valid : vmte->spi_ist.valid;
+    /* Ignore request to make IST valid/invalid when it already is so */
+    if (valid == was_valid) {
+        return;
+    }
+
+    if (!read_first_vmte_word(cs, cfg, vmte->vmte_addr, l2_vmte) ||
+        !read_other_vmte_words(cs, cfg, vmte->vmte_addr, l2_vmte)) {
+        goto txfail;
+    }
+
+    switch (type) {
+    case GICV5_LPI:
+        l2_vmte[2] = FIELD_DP64(l2_vmte[2], L2_VMTE_2, LPI_IST_VALID, valid);
+        address_space_stq_le(&cs->dma_as,
+                             vmte->vmte_addr + sizeof(uint64_t) * 2,
+                             l2_vmte[2], cfg->txattrs, &res);
+        if (res != MEMTX_OK) {
+            goto txfail;
+        }
+
+        if (valid) {
+            initialize_vlpi_ist_config(cs, domain, vmte, l2_vmte);
+        } else {
+            invalidate_vlpi_ist_config(cs, domain, vmte);
+        }
+        break;
+    case GICV5_SPI:
+        l2_vmte[3] = FIELD_DP64(l2_vmte[3], L2_VMTE_3, SPI_IST_VALID, valid);
+        address_space_stq_le(&cs->dma_as,
+                             vmte->vmte_addr + sizeof(uint64_t) * 3,
+                             l2_vmte[3], cfg->txattrs, &res);
+        if (res != MEMTX_OK) {
+            goto txfail;
+        }
+
+        if (valid) {
+            initialize_vspi_ist_config(cs, domain, vmte, l2_vmte);
+        } else {
+            invalidate_vspi_ist_config(cs, domain, vmte);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return;
+
+txfail:
+    /* Reportable with EC=0x0 if sw error reporting implemented */
+    qemu_log_mask(LOG_GUEST_ERROR, "L2 VMTE update failed for VMID 0x%x at "
+                  "physical address 0x" HWADDR_FMT_plx "\n",
+                  vmid, vmte->vmte_addr);
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -1839,6 +1957,22 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VMAP_VISTR:
+        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
+            *data = extract64(cs->irs_vmap_vistr[domain], 0, 32);
+        } else {
+            /* RAZ/WI if no virt or no VM table */
+            *data = 0;
+        }
+        return true;
+    case A_IRS_VMAP_VISTR + 4:
+        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
+            *data = extract64(cs->irs_vmap_vistr[domain], 32, 32);
+        } else {
+            /* RAZ/WI if no virt or no VM table */
+            *data = 0;
+        }
+        return true;
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1979,6 +2113,15 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
         irs_vmap_vmr_write(s, domain,
                            deposit64(cs->irs_vmap_vmr[domain], 32, 32, data));
         return true;
+    case A_IRS_VMAP_VISTR:
+        irs_vmap_vistr_write(s, domain,
+                             deposit64(cs->irs_vmap_vistr[domain], 0, 32, data));
+        return true;
+    case A_IRS_VMAP_VISTR + 4:
+        irs_vmap_vistr_write(s, domain,
+                             deposit64(cs->irs_vmap_vistr[domain],
+                                       32, 32, data));
+        return true;
     case A_IRS_SPI_SELR:
         cs->irs_spi_selr[domain] = data;
         return true;
@@ -2087,6 +2230,14 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_VMAP_VISTR:
+        if (gicv5_domain_has_virt(cs, domain) && s->vmt_config[domain].valid) {
+            *data = cs->irs_vmap_vistr[domain];
+        } else {
+            /* RAZ/WI if no virt or no VM table */
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
@@ -2108,6 +2259,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_VMAP_VMR:
         irs_vmap_vmr_write(s, domain, data);
         return true;
+    case A_IRS_VMAP_VISTR:
+        irs_vmap_vistr_write(s, domain, data);
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 19338ad5b9c..181171e000b 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -110,6 +110,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
         memset(cs->irs_vmt_cfgr, 0, sizeof(cs->irs_vmt_cfgr));
         memset(cs->irs_vmap_l2_vmtr, 0, sizeof(cs->irs_vmap_l2_vmtr));
         memset(cs->irs_vmap_vmr, 0, sizeof(cs->irs_vmap_vmr));
+        memset(cs->irs_vmap_vistr, 0, sizeof(cs->irs_vmap_vistr));
     }
 }
 
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index cb3568fa80c..a086b14c825 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -250,6 +250,7 @@ gicv5_vmt_valid(const char *domain, uint64_t base, uint8_t vm_id_bits, bool stru
 gicv5_vmt_invalid(const char *domain) "GICv5 IRS %s VM table no longer valid"
 gicv5_vmap_l2_vmtr(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u now valid"
 gicv5_cache_vmte(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u valid and cached"
+gicv5_irs_vmap_vistr_write(const char *domain, uint32_t vmid, const char *type, const char *what) "GICv5 IRS %s VM ID %u %s IST now %s"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index 5707111b98a..19e13693de9 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -93,6 +93,7 @@ struct GICv5Common {
     uint32_t irs_vmt_cfgr[NUM_GICV5_DOMAINS];
     uint64_t irs_vmap_l2_vmtr[NUM_GICV5_DOMAINS];
     uint64_t irs_vmap_vmr[NUM_GICV5_DOMAINS];
+    uint64_t irs_vmap_vistr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


