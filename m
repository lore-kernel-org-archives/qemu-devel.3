Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D4CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8Z-0007TM-Pj; Tue, 13 Oct 2026 04:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4J-0000hj-UP
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4H-0008C1-H2
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so22528035e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880864; x=1792485664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eQNIdAvJC1ZfTaJFOVCOusHjVQCsOoyi8FgUc8+Bmwg=;
 b=Y/MOVzz55BlB3/QZht+ezX3th8qX83xVmnjQADy7ajPZQmxHspiyBEVZdhulGUlJUs
 w1m5SDlkd2q7MKyJDpIGRkl18ZM9Zg7fYQ/k6rRSonjMNX2fkAMgUpci++RASkMMcplQ
 Y7o34mcfzaDLVbMWGSKiVRNOocajvn5GG9YnLhGCGi5QTHxp54F8Ho3lJCECzCbbJnLe
 25hZ/H0qeocvJLhq8MehSIrz9UpXHKOZJ5ZBOG87FhvbVI61J3xCXR7bprHpOi4U0rUx
 oXKhdKKInIb8tTQSQ1IlniAjb9bFAuR4WV0VR4dTc5ebesfzr530Dt3OTlfN81EM7RXM
 ojGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880864; x=1792485664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eQNIdAvJC1ZfTaJFOVCOusHjVQCsOoyi8FgUc8+Bmwg=;
 b=Fc7+bNoTHCkmdm0DrqVrg8x2zyjuhYICGaymonLbohej4cIA6IQp86KBjX7AmdFN5Y
 0oSN3IRtbRtJEtYYlgMb9Sv5sa9/vQZSZpe7U0IONkuRvnSpMdt3pI0CT5J0iNRAd4U7
 ceAW/lquz6NSyO3k8LQ2Pr0o+zKQLZgYz520DLQUCBFaY/DKUa0PO9V3fq9xjrYQeZT4
 kuuD5EXblkqTpYx13FfzvnXUGcVkfXy5Xxil8P8cdieClNUBZXbIBlO+b9F14fpMv8rq
 91MGusxSyQWfvuIGc6qIoUvrwQXGjX7XjVJeqwnpuySa4SwUh1kZLLseHU0qvzlLVIb8
 YJrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqYgK+BxZwX5yn0aFePUmfmM7ePq/byCz3w5Xqx0ejxPDtMM8DSHxGjLTL9q3xZnSI7tdyS0gh5g4z@nongnu.org
X-Gm-Message-State: AFq9FYK6ozuoO1ZNjcJdPu7cTcHVDhJ0bUlxTVhKC26TXJHFsZ3don+/
 oFhvKcpfeU+L4rO3NVz12Wv03Gi4h8BAiSm8te8Vym2Z8upucSblWKjn93ZMgFOhUZJWuWndC3z
 lEDqkiBI=
X-Gm-Gg: AYBFou2ZBLDvymigJImAO0NrZmp8zFoX9xv5/R8to68zSDS9eEWSjHemoQ01WMbnPSS
 eOPy6SK66NLXqA7gcb8e8KkKcui9vdRk7OVYzph/mAdD6G9Z9EvPVI9P6ZLD+oPehifmGaG4mIk
 HcIi5KYaNsM4De18FJ+dy8I69l0QbtQBZrwbDGlxpLs1Sx4mw6Pt+4/+FOVBbb8Yf6tEB8dN29k
 SGmlAsnBP4XSpAjUe8rW/bTG2xF4hK6qMrAnmC4z2szo/90l7jPdO0ih/Gd4jcoyNJ6X61A6LPv
 vPCmDJMbZ8c1CJlM+h7HpoNiVkZI0H7lDNrLos4miq1aLhcRSlhNwTLe4b6VS+QpbZ7eUexJWvX
 7jN6x+81bIJOEVGwnf0+ZMj65JfQRYZGZqQo4S5Uqr8AwYNTw12PceRF22OZghodygmK4Ug49r1
 zQEdUxawCDS2U+7xei8/7DwOjWsyzoD8tBOAXVos4vB7mby7FfAEvmuFLdrAoALo4XmZqkOZUkq
 6GLGClmQ3ZkOWWt1fXT6njZL9p3NNpJJWFb7NPsvvjXGxPjrxz3ZWeFIKoK2pW3z06/vGwAKkRS
 r0w=
X-Received: by 2002:a05:600c:19cf:b0:4a0:168f:d962 with SMTP id
 5b1f17b1804b1-4a18e44363dmr226246925e9.3.1791880864055; 
 Tue, 13 Oct 2026 01:41:04 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 68/86] hw/intc/arm_gicv5: Implement gicv5_set_resident()
Date: Tue, 13 Oct 2026 09:39:15 +0100
Message-ID: <20261013083933.1024405-69-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

When the GICv5 CPU interface wants to make a VPE resident, it calls
gicv5_set_resident(). Currently that is a do-nothing placeholder;
implement the required behaviour of tracking on the IRS side that
the VPE is resident on this CPU, and remembering the information
about the doorbell interrupt.

For each CPU, we keep a note of the current VPE that is resident (if
any), so we have an easy way to get to that information given the CPU
index in functions like gicv5_set_priority().  Since the only way to
make a VPE invalid is to make the entire VM invalid, we only need to
set this info in gicv5_set_resident() and then clear it when a VM
becomes invalid or the whole VM table is made invalid.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c         | 115 +++++++++++++++++++++++++++++++++++-
 hw/intc/trace-events        |   2 +
 include/hw/intc/arm_gicv5.h |   5 ++
 3 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 18ca7034011..01ee303d393 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -29,11 +29,13 @@ typedef struct VMTE VMTE;
 typedef struct VPE {
     VMTE *vmte;
     hwaddr vped_addr;
+    uint32_t cpuidx; /* CPU we're currently resident on */
     uint32_t db_intid; /* doorbell interrupt ID */
     uint8_t dbpm; /* doorbell priority mask */
     bool valid; /* is the VPE valid? */
     bool db_valid; /* are doorbell settings valid? */
     bool db_req; /* is a doorbell requested? */
+    bool resident; /* is VPE resident on some CPU? */
 } VPE;
 
 /* In the GICv5VMTConfig::vm_cache this is how we store VMTE info */
@@ -1182,8 +1184,89 @@ bool gicv5_set_resident(GICv5Common *cs, GICv5Domain domain, bool valid,
                         uint32_t vpeid, bool db, uint8_t dbpm, uint32_t vmid,
                         uint32_t cpuidx)
 {
-    /* Until we implement virtualization, SetResident always fails */
-    return true;
+    VMTE *vmte;
+    VPE *vpe;
+    GICv5 *s = ARM_GICV5(cs);
+    GICv5VMTConfig *cfg = &s->vmt_config[domain];
+
+    assert(cpuidx < cs->num_cpus);
+
+    if (!gicv5_domain_has_virt(cs, domain) || !cfg->valid) {
+        return true;
+    }
+
+    /*
+     * R_PYWKM: if resident VPE is for wrong domain, then ignore
+     * attempts to set a resident VPE. Allow an attempt to clear the
+     * resident VPE, but treat DB as zero.
+     */
+    if (s->res_vpe[cpuidx] &&
+        s->res_vpe[cpuidx]->vmte->domain != domain) {
+        if (valid) {
+            return true;
+        }
+        db = 0;
+    }
+
+    if (valid) {
+        /* Trying to make a VPE resident */
+
+        vmte = g_hash_table_lookup(cfg->vm_cache, GINT_TO_POINTER(vmid));
+        vpe = vpe_for_vpeid(vmte, vpeid);
+        if (!vpe) {
+            return true;
+        }
+
+        if (vpe->resident) {
+            /*
+             * Trying to make a VPE resident when it's already
+             * resident somewhere else is CONSTRAINED UNPREDICTABLE
+             * per R_JJKJV. We choose to fail the request.
+             */
+            return true;
+        }
+
+        vpe->resident = true;
+        vpe->cpuidx = cpuidx;
+
+        s->res_vpe[cpuidx] = vpe;
+        trace_gicv5_set_resident(domain_name[domain], vmid, vpeid, cpuidx);
+    } else {
+        vpe = s->res_vpe[cpuidx];
+        if (!vpe) {
+            /* Making non-resident when already no VPE resident */
+            return true;
+        }
+
+        vmte = vpe->vmte;
+
+        vpe->resident = false;
+        vpe->cpuidx = UINT32_MAX;
+        vpe->db_req = db;
+        if (db) {
+            vpe->dbpm = dbpm;
+        }
+        s->res_vpe[cpuidx] = NULL;
+
+        trace_gicv5_set_non_resident(domain_name[domain], cpuidx, db, dbpm);
+
+        /*
+         * TODO: when we implement VPE doorbells, we should check whether
+         * we should immediately generate a doorbell for a VPE that has
+         * just been made non-resident.
+         */
+    }
+
+    /*
+     * Tell the cpuif that the vHPPI for its resident VPE has changed;
+     * it will then call gicv5_get_hppi() which will return either
+     * IRQ_NONE if this is make-non-resident or the vHPPI for the
+     * now-resident VPE if this is make-resident.
+     */
+    gicv5_forward_interrupt(cs->cpus[cpuidx], vmte->domain, true);
+
+    /* SetResident succeeded */
+    return false;
 }
 
 static bool read_first_vmte_word(GICv5Common *cs, GICv5VMTConfig *cfg,
@@ -1566,6 +1649,8 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
             return;
         }
         irs_clean_vm_cache(cs, &s->vmt_config[domain]);
+        /* No VPE is now resident on any CPU */
+        memset(s->res_vpe, 0, sizeof(VPE) * cs->num_cpus);
         cs->irs_vmt_baser[domain] = FIELD_DP64(cs->irs_vmt_baser[domain],
                                                IRS_VMT_BASER, VALID, valid);
         s->vmt_config[domain].valid = false;
@@ -1713,6 +1798,20 @@ txfail:
                   "physical address 0x" HWADDR_FMT_plx "\n", vmid, l1_addr);
 }
 
+static void remove_res_vpe_by_vmid(GICv5 *s, uint32_t vmid)
+{
+    /* Remove all res_vpe cached information for VPEs for this VMID */
+    GICv5Common *cs = ARM_GICV5_COMMON(s);
+
+    for (int i = 0; i < cs->num_cpus; i++) {
+        VPE *vpe = s->res_vpe[i];
+
+        if (vpe && vpe->vmte->vmid == vmid) {
+            s->res_vpe[i] = NULL;
+        }
+    }
+}
+
 static void irs_vmap_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -1762,6 +1861,7 @@ static void irs_vmap_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 
     if (u) {
+        remove_res_vpe_by_vmid(s, vmid);
         g_hash_table_remove(cfg->vm_cache, GINT_TO_POINTER(vmid));
     } else {
         if (!read_other_vmte_words(cs, cfg, l2_addr, l2_vmte)) {
@@ -2858,6 +2958,7 @@ static void gicv5_set_spi(void *opaque, int irq, int level)
 static void gicv5_reset_hold(Object *obj, ResetType type)
 {
     GICv5 *s = ARM_GICV5(obj);
+    GICv5Common *cs = ARM_GICV5_COMMON(obj);
     GICv5Class *c = ARM_GICV5_GET_CLASS(s);
 
     if (c->parent_phases.hold) {
@@ -2884,6 +2985,11 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
             g_hash_table_remove_all(s->vmt_config[i].vm_cache);
         }
     }
+
+    if (s->res_vpe) {
+        /* No VPE is now resident on any CPU */
+        memset(s->res_vpe, 0, sizeof(*s->res_vpe) * cs->num_cpus);
+    }
 }
 
 static void gicv5_set_idregs(GICv5Common *cs)
@@ -2988,6 +3094,10 @@ static void gicv5_realize(DeviceState *dev, Error **errp)
             s->hppi[i] = g_new0(GICv5PendingIrq, cs->num_cpus);
         }
     }
+
+    if (cs->has_virt) {
+        s->res_vpe = g_new0(VPE *, cs->num_cpus);
+    }
 }
 
 static void gicv5_init(Object *obj)
@@ -3012,6 +3122,7 @@ static void gicv5_finalize(Object *obj)
 
         g_free(s->hppi[i]);
     }
+    g_free(s->res_vpe);
 }
 
 static void gicv5_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index b187ceefe45..6d646eacaeb 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -256,6 +256,8 @@ gicv5_irs_vmap_vper_write(const char *domain, uint32_t vmid, uint32_t vpeid) "GI
 gicv5_irs_vpe_selr_write(const char *domain, uint64_t selr, uint32_t status) "GICv5 IRS %s IRS_VPE_SELR written 0x%" PRIx64 " IRS_VPE_STATUSR now 0x%x"
 gicv5_irs_vpe_dbr_write(const char *domain, uint32_t vmid, uint32_t vpeid, uint8_t dbpm, uint32_t db_intid, bool db_req) "GICv5 IRS %s VM ID %u VPE %u IRS_VPE_DBR doorbell now valid: prio mask %u intid %u requested %d"
 gicv5_irs_vpe_dbr_write_nv(const char *domain, uint32_t vmid, uint32_t vpeid) "GICv5 IRS %s VM ID %u VPE %u IRS_VPE_DBR doorbell info no longer valid"
+gicv5_set_resident(const char *domain, uint32_t vmid, uint32_t vpeid, uint32_t cpuidx) "GICv5 IRS %s VM ID %u VPE %u set_resident phys CPU idx %u: now resident"
+gicv5_set_non_resident(const char *domain, uint32_t cpuidx, bool db, uint8_t dbpm) "GICv5 IRS %s set_resident phys CPU idx %u: now no resident VPE; db_req %d dbpm %u"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index 28417317376..ac85cad3eb5 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -40,6 +40,8 @@ typedef struct GICv5VMTConfig {
     GHashTable *vm_cache;
 } GICv5VMTConfig;
 
+typedef struct VPE VPE;
+
 /*
  * This class is for TCG-specific state for the GICv5.
  */
@@ -53,6 +55,9 @@ struct GICv5 {
 
     /* We cache the HPPI for each CPU for each domain here */
     GICv5PendingIrq *hppi[NUM_GICV5_DOMAINS];
+
+    /* Array: for each CPU, either NULL or ptr to the resident VPE */
+    VPE **res_vpe;
 };
 
 struct GICv5Class {
-- 
2.43.0


