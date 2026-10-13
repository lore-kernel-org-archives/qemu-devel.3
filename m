Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B65CCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9Q-0000vV-Mq; Tue, 13 Oct 2026 04:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4d-0001nB-NS
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4b-0008J9-BH
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so16623885e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880883; x=1792485683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mT31UjfoQOsSWM6/4XaazdVD7Jw1EvSOBOVSSh0qErU=;
 b=fpfQM/yXsYXMmNGsU0czs1VyIJ5ODb1DSF/Fr7LB7br2NlvAODOSGdBQELbaX2iXsj
 GLaoRQEROnRz6fdjNj+idtOi0LMdsISlAfna+w/QhFonx/aWdqq3H+1VL24/V04CWIrD
 oMO/EgJESM3fmDgw76QHkSTxNEBFlkNt74GDxjITEP5B7dKX3I/wApwsYfYYzEI7DADz
 8edskGTiKwP/rHFoAF7ZbbtJTPZ8kH/hxLDwpGuLEObbDIuSiIbqLTJkruh3ak6bxCB6
 XsC4y9/KT/KA9ed6LAh5UaXM54/ApNdABLQqUBNk1FtFAGa/YKVV6EW3JWQAJNyqJ5Yu
 xcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880883; x=1792485683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mT31UjfoQOsSWM6/4XaazdVD7Jw1EvSOBOVSSh0qErU=;
 b=TkDkHlzAU+cGoyEPjiPTXn6jpFZcE+jD6emqlOZeYbi3xNdu8o4PZjaMiUe6X8OQIK
 0AEal6d+QGSPwvhVVtqPyJCcLZVu2tqcnBctehvTNUJ2qXbFNXnZM0EF9JJg1FVAx8dM
 DyE17RUvMof7GJYW+yQ4HQjo0jLdal4g+U0oppN0PhAyF4nv4Xp0rcvAJXpsqFzvIOY3
 ad+GmKFWwodYI1N2qe38kCpVpomdGJCMh+T+SXxabQ3vWQzZXA44n455gEzFQ9Rt+lv2
 mylrN1zLZSb6uITaNS01JyQwOhTsMgylFgm7tZ7UoXvHTOpTxAVahaG9q6zBaLt0K9jW
 az1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBysr32oC8+KYB+zf5Md73CgSaA7LQ9Fbd75A3cThj37PB/13PQT+8z4OQOc92XmzT7RgfzrNPEHX6zO@nongnu.org
X-Gm-Message-State: AFq9FYK/sy2dbyl26xJrJGV2QU1TCcXZFIOXB8eA/4LdInNnzsHPXa4d
 zYR8PKOyPjg4vv49S2x8lF+gLDmfrIzY/lzaZ4GWWstg6yljdDllf8L2uw1JtkAbGwk=
X-Gm-Gg: AYBFou0EO1VAIYPSertfQ6F+Ja4IUXFMxFsayqzkRMuEm3dEJUx9ATOcYCeq+2Q6isf
 gMqMzdOnusPiXCWl4npqNcMLEyZU+xft3Dq6nI6I3S17t3Jdc2cDjZ5l8ITUWFDg/SKdQ3G0iwX
 xWEligHM1o2H3DhfqKa0+VYxbL65OV+6BCm5OnzQwO0Pu3Tkbb9IAxSjlRmn4xoS6wp8vbuXbVE
 rOKh5SkqWAJ405cvcN6Rd5QSsYer3XiQIZWFbF82HX2/9OF7soC+MUI/HT4TN9wfZaR0q/+3FQV
 5eUNInNlCsaVueeyT9lXFpidLHVaXwQf3uKL195xKC3M65ER04FLREeNaAc78jR6g3Z3FX2AHEx
 ufC7iBZzOUvzI/CSp6M/PFc+UHXeuWxYlCsUhpSPIMAzttV+PcUx5OT/EMWD+rMM7AY143CPUlK
 YK7cNS5hF8TfgbVQutLxnifG2+gfrd/bcR2B28mMAY4y8ScOR9Jy4SKBI6O+Yu1CaLs+O+/H1Bm
 U1S8H1XcSSeW8AMSmMCC3JPwe0mwNxBKBcuAwItu42uZdVLcLlBSYss8tVocniXpZ62t36+sko7
 LlA=
X-Received: by 2002:a05:600c:a010:b0:4a0:2500:2cd0 with SMTP id
 5b1f17b1804b1-4a18e4b4646mr206929765e9.18.1791880882736; 
 Tue, 13 Oct 2026 01:41:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 83/86] hw/intc/arm_gicv5: Implement saving virtual interrupt
 state to guest memory
Date: Tue, 13 Oct 2026 09:39:30 +0100
Message-ID: <20261013083933.1024405-84-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The IRS_SAVE_VMR register allows software to force the IRS to write
out any cached virtual interrupt state and configuration to the guest
memory data structures.  (A hypervisor will use this as part of
saving the configuration of a VM for migration.)

When software writes the S bit to 1, we need to write out cached
information in our hash tables for the vLPI and vSPI for the VM.  As
usual for QEMU, this operation is instantaneous from the guest's
point of view.

IRS_SAVE_VMR also has functionality for software to check that the
state of the VM didn't change during the save procedure.  Because we
will have only one IRS, we take advantage of I_DSRQY's suggestion
that we make writing {0,1} to {S,Q} be a no-op.  This means handling
of the reporting of the Quiesced state can be done entirely in the
implementation of IRS_SAVE_VM_STATUSR, which will be done in the
following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c                | 104 +++++++++++++++++++++++++++++
 hw/intc/arm_gicv5_common.c         |   1 +
 hw/intc/trace-events               |   1 +
 include/hw/intc/arm_gicv5_common.h |   1 +
 4 files changed, 107 insertions(+)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 4572e5a4017..e1796ec17a6 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -2450,6 +2450,75 @@ static void irs_vpe_dbr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 }
 
+/* Data we need to pass to sync_l2_iste() */
+typedef struct SyncL2ISTEUserData {
+    GICv5Common *cs;
+    GICv5ISTConfig *cfg;
+} SyncL2ISTEUserData;
+
+static void sync_l2_iste(gpointer key, gpointer value, gpointer user_data)
+{
+    uint64_t id = GPOINTER_TO_INT(key);
+    uint64_t l2_iste = *(uint32_t *)value;
+    SyncL2ISTEUserData *ud = user_data;
+    hwaddr l2_iste_addr;
+
+    if (get_l2_iste_addr(ud->cs, ud->cfg, id, &l2_iste_addr)) {
+        write_l2_iste_mem(ud->cs, ud->cfg, l2_iste_addr, l2_iste);
+    }
+}
+
+static void irs_sync_ist_to_memory(GICv5Common *cs, GICv5ISTConfig *cfg)
+{
+    /*
+     * Push any information in the IST hash table out to guest memory
+     * (but don't drop the hash table entries).  Writeback errors are
+     * ignored. Compare put_l2_iste()'s code for writing out data whon
+     * it removes L2_ISTE entries from the hash table.
+     */
+    SyncL2ISTEUserData ud;
+
+    if (!cfg->valid) {
+        return;
+    }
+
+    ud.cs = cs;
+    ud.cfg = cfg;
+
+    g_hash_table_foreach(cfg->lpi_cache, sync_l2_iste, &ud);
+}
+
+static void irs_save_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
+{
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+    GICv5VMTConfig *cfg = &s->vmt_config[domain];
+    uint32_t vmid;
+    VMTE *vmte;
+
+    cs->irs_save_vmr[domain] = value;
+
+    if (!FIELD_EX64(cs->irs_save_vmr[domain], IRS_SAVE_VMR, S)) {
+        return;
+    }
+
+    /* Write out vLPI and vSPI config to guest memory */
+    vmid = FIELD_EX64(cs->irs_save_vmr[domain], IRS_SAVE_VMR, VM_ID);
+
+    if (!cfg->valid || vmid >= (1 << cfg->vm_id_bits)) {
+        return;
+    }
+
+    vmte = g_hash_table_lookup(cfg->vm_cache, GINT_TO_POINTER(vmid));
+    if (!vmte) {
+        return;
+    }
+
+    trace_gicv5_irs_save_vmr_write(domain_name[domain], vmid);
+
+    irs_sync_ist_to_memory(cs, &vmte->lpi_ist);
+    irs_sync_ist_to_memory(cs, &vmte->spi_ist);
+}
+
 static void spi_sample(GICv5SPIState *spi)
 {
     /*
@@ -2717,6 +2786,22 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_SAVE_VMR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(cs->irs_save_vmr[domain], 0, 32);
+        } else {
+            /* RAZ if no virt */
+            *data = 0;
+        }
+        return true;
+    case A_IRS_SAVE_VMR + 4:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = extract64(cs->irs_save_vmr[domain], 32, 32);
+        } else {
+            /* RAZ if no virt */
+            *data = 0;
+        }
+        return true;
     case A_IRS_VPE_CR0:
         /* RES0 when VIRT_ONE_N is not implemented */
         *data = 0;
@@ -2913,6 +2998,14 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
         irs_vpe_dbr_write(s, domain,
                           deposit64(cs->irs_vpe_dbr[domain], 32, 32, data));
         return true;
+    case A_IRS_SAVE_VMR:
+        irs_save_vmr_write(s, domain,
+                           deposit64(cs->irs_save_vmr[domain], 0, 32, data));
+        return true;
+    case A_IRS_SAVE_VMR + 4:
+        irs_save_vmr_write(s, domain,
+                           deposit64(cs->irs_save_vmr[domain], 32, 32, data));
+        return true;
     case A_IRS_VPE_CR0:
         /* RES0 when VIRT_ONE_N is not implemented */
         return true;
@@ -3072,6 +3165,14 @@ static bool config_readll(GICv5 *s, GICv5Domain domain, hwaddr offset,
             *data = 0;
         }
         return true;
+    case A_IRS_SAVE_VMR:
+        if (gicv5_domain_has_virt(cs, domain)) {
+            *data = cs->irs_save_vmr[domain];
+        } else {
+            /* RAZ/WI if no virt */
+            *data = 0;
+        }
+        return true;
     }
 
     return false;
@@ -3108,6 +3209,9 @@ static bool config_writell(GICv5 *s, GICv5Domain domain, hwaddr offset,
     case A_IRS_VPE_DBR:
         irs_vpe_dbr_write(s, domain, data);
         return true;
+    case A_IRS_SAVE_VMR:
+        irs_save_vmr_write(s, domain, data);
+        return true;
     }
 
     return false;
diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
index 50365c4dfe6..667f4501ef1 100644
--- a/hw/intc/arm_gicv5_common.c
+++ b/hw/intc/arm_gicv5_common.c
@@ -116,6 +116,7 @@ static void gicv5_common_reset_hold(Object *obj, ResetType type)
         memset(cs->irs_vmap_vper, 0, sizeof(cs->irs_vmap_vper));
         memset(cs->irs_vpe_selr, 0, sizeof(cs->irs_vpe_selr));
         memset(cs->irs_vpe_dbr, 0, sizeof(cs->irs_vpe_dbr));
+        memset(cs->irs_save_vmr, 0, sizeof(cs->irs_vpe_dbr));
 
         for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
             cs->irs_vpe_statusr[i] = R_IRS_VPE_STATUSR_IDLE_MASK;
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index ddb7ab06207..9902cb97b8f 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -261,6 +261,7 @@ gicv5_irs_vpe_dbr_write_nv(const char *domain, uint32_t vmid, uint32_t vpeid) "G
 gicv5_set_resident(const char *domain, uint32_t vmid, uint32_t vpeid, uint32_t cpuidx) "GICv5 IRS %s VM ID %u VPE %u set_resident phys CPU idx %u: now resident"
 gicv5_set_non_resident(const char *domain, uint32_t cpuidx, bool db, uint8_t dbpm) "GICv5 IRS %s set_resident phys CPU idx %u: now no resident VPE; db_req %d dbpm %u"
 gicv5_irs_ring_doorbell(const char *domain, uint32_t vmid, uint32_t db_intid) "GICv5 IRS %s VM ID %u: ringing doorbell LPI %u"
+gicv5_irs_save_vmr_write(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u saving IST data to memory"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
index d82cc23d10c..7bd6f557058 100644
--- a/include/hw/intc/arm_gicv5_common.h
+++ b/include/hw/intc/arm_gicv5_common.h
@@ -99,6 +99,7 @@ struct GICv5Common {
     uint64_t irs_vpe_selr[NUM_GICV5_DOMAINS];
     uint32_t irs_vpe_statusr[NUM_GICV5_DOMAINS];
     uint64_t irs_vpe_dbr[NUM_GICV5_DOMAINS];
+    uint64_t irs_save_vmr[NUM_GICV5_DOMAINS];
 
     /*
      * Pointer to an array of state information for the SPIs.  Array
-- 
2.43.0


