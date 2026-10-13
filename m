Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B890DCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY7r-0005sc-AG; Tue, 13 Oct 2026 04:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY48-0000Je-Oi
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY45-00085k-PT
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so21343305e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880852; x=1792485652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fpHMIk8Nm/5w+iRREMxKf46LjEiZ4eICh82Sj9fIJiw=;
 b=rqS+dvBg02pTHkQwjRgqcevUQgq+SdAP/tahu+IAHQqlaWC4W0kHYTLzby1Cf9Pwew
 285cnTZa4L7hWIAsauQAtwYHsH3+t2NgkVubftSGrJ+AMbd3YnOjFHb8ld/VHDI/Uway
 IbLNlHWyiYgclAuPl6dw5IN2inw2utFudhL+D7Zn8tflh2IK7GEKapIqRI0SB6T0ZOwI
 WS5zzkjlCvSEwaXIBzrC+pP0cZ6Qx/GhM0j3/l/vFAa8ObbJ2Ey0zjNjn7V+/AWeJsvE
 nbNuymcgFsHwhvrZzGzqNws1SEtimvCGjZ9ON1h2pJgrpgYAmIyFYUusN4t7q2pgRDvh
 XJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880852; x=1792485652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fpHMIk8Nm/5w+iRREMxKf46LjEiZ4eICh82Sj9fIJiw=;
 b=lItPvafzk2FpUYXJ61fznj2Zcsi3o9dBRv3ZfN7wVqGsrSrA6F12Kyv0ycl8NazESt
 12fKPyQNeKy3Tmiz5nkJgQORSb5iTiH01QZytIWHuZ/4uiIQMk7mYb4HXsuQTOwapfbx
 01mV4KoOemWlp7d1qQ+Rgl+dlMIs5GWKzzuFw6+vCRcnIkh7o8Xs6Oj5bVlX0Qm00enA
 QpH+bANqNCB2E88FzODQCNJccAbl7mw1/P1vYKSpcHMUm798jK8dntbWRqBjcd2O0MJO
 mxE5j8RQnJwrnfP8WBgxvP8I2S5geS+my+9Lir52062kIB3e7U4wQc6kOB+P1G96oVr5
 BXoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmQCkeu3ZJoqhl/f76oI8BISR4quQiqCC9/bJzcyYaISNZ7e4j/TgiTAO+lsa+yholsiTKMFrCHIxa@nongnu.org
X-Gm-Message-State: AFq9FYJ6AGOrnuwiu9NervtwaY9VPFG1bzWlvkW27sX1KMMRroDTUBfi
 VSWeZf9Ze+w3QLsuTXkVwm1IFPu1UF91DP4A4fkM3AFCEYgNPNdEOli04Zba1p1Cc3yrk9GLrGV
 w3XVRzJE=
X-Gm-Gg: AYBFou1C3g0N/HQicyLce4YJclmjq81AMoFHMuE0RewKnKvGglbQYN1PpK7o3qKbPv7
 RviSpx4G/0g6Ouah7nO/LyStcXr5tCwA7VYUpyEDvg/4vgtONxIxG6Ker0fKq3y9yxwWIepsOUH
 4AkUvGDao210kLwNRsxhGQiK2YCzC5q7bhYtz7ppDVrCJotqH1RpqneH8pFs3acxMncJE8zXvHa
 bYsZTvoBDIwLR6hoTd/ERG9MKSDnoI4t5AVyglxr6mpnALlfAsNgIWB9lTSuFqWGGrKlxkHw+pl
 Jc8mMqbZvrUgYAESYHhQdGXhUGzn6EGSV7ItI4PY7xwWiQCzBIGNO+Bh+V2aj412zS8tuXUgM7f
 yCPWsyxYAJBWzP5nQ8oqvGuThlY6Tg/dvi2CaoTKTFWe2BRdHnfCHFLlXIsmIjkgfXPDq+ZNPoU
 7lA9PpZSekRfmj96QEV13CmqLMXxvFnXp4vy+kxbsSkcFQg1/sXztcr/FWzel1TMBwf+RQKDzTr
 N/nqPSHA++PjOIwPwlDnS9ydeGzPGL3xTD8EOKncBAvgQQhL1wKO5kCSOo2txT6iyvENk6Y2DLP
 Hf84
X-Received: by 2002:a05:600c:83c7:b0:4a1:698d:3044 with SMTP id
 5b1f17b1804b1-4a18e493020mr228631015e9.11.1791880852212; 
 Tue, 13 Oct 2026 01:40:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 58/86] hw/intc/arm_gicv5: Cache info about valid VMs in a
 hashtable
Date: Tue, 13 Oct 2026 09:39:05 +0100
Message-ID: <20261013083933.1024405-59-peter.maydell@linaro.org>
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

The VM table in guest memory contains information about each VM the
guest has set up.  In particular, it has information about other data
structures such as the VM's LPI and SPI tables and their
configuration.  We don't want to have to read this from guest memory
and extract the fields every time we use it.

Add a hash table to GICv5VMTConfig: the keys are VM IDs, and
the values are structs with the extracted and sanitized information
from the L2 VMTE.

In this commit we populate the hash table entry when the guest makes
a VM valid via a write ta IRS_VMAP_VMR.  It is also permitted for the
guest to pass us an L1 or L2 VM table where some entries are
pre-marked as valid; we will handle creating the hash table entries
for that case in the following commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c              | 216 ++++++++++++++++++++++++++++++-
 hw/intc/trace-events             |   1 +
 include/hw/intc/arm_gicv5.h      |   2 +
 include/hw/intc/arm_gicv5_regs.h |   3 +
 4 files changed, 216 insertions(+), 6 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 8cf7e363f29..b66bc5b95df 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -23,6 +23,20 @@
 
 OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
 
+/* In the GICv5VMTConfig::vm_cache this is how we store VMTE info */
+typedef struct VMTE {
+    GICv5ISTConfig lpi_ist;
+    GICv5ISTConfig spi_ist;
+    /* Address of the in-memory L2_VMTE for this VMTE */
+    hwaddr vmte_addr;
+    hwaddr vpet_addr;
+    uint32_t vmid;
+    uint8_t vpe_id_bits;
+    GICv5Domain domain;
+    /* We don't cache the VMD_ADDR as we don't use VMDs */
+    /* We don't cache VALID: the existence of this struct implies VALID=1 */
+} VMTE;
+
 static const char *domain_name[] = {
     [GICV5_ID_S] = "Secure",
     [GICV5_ID_NS] = "NonSecure",
@@ -74,6 +88,22 @@ static uint32_t gicv5_idreg(int regoffset)
     return gic_ids[regoffset];
 }
 
+/* GDestroyNotify function for VMTE struct */
+static void VMTE_free(void *data)
+{
+    VMTE *vmte = data;
+
+    /* Destroy (without writing back to guest memory) the ISTConfigs */
+    if (vmte->lpi_ist.lpi_cache) {
+        g_hash_table_destroy(vmte->lpi_ist.lpi_cache);
+    }
+    if (vmte->spi_ist.lpi_cache) {
+        g_hash_table_destroy(vmte->spi_ist.lpi_cache);
+    }
+
+    g_free(vmte);
+}
+
 static bool gicv5_domain_has_virt(GICv5Common *cs, GICv5Domain domain)
 {
     /*
@@ -1116,6 +1146,117 @@ bool gicv5_set_resident(GICv5Common *cs, GICv5Domain domain, bool valid,
     return true;
 }
 
+static bool read_first_vmte_word(GICv5Common *cs, GICv5VMTConfig *cfg,
+                                 hwaddr l2_addr,
+                                 uint64_t l2_vmte[L2_VMTE_WORDS])
+{
+    /* Read the first word of the L2 VMTE, returning false on failure */
+    MemTxResult res;
+
+    l2_vmte[0] = address_space_ldq_le(&cs->dma_as, l2_addr,
+                                      cfg->txattrs, &res);
+    return res == MEMTX_OK;
+}
+
+static bool read_other_vmte_words(GICv5Common *cs, GICv5VMTConfig *cfg,
+                                  hwaddr l2_addr,
+                                  uint64_t l2_vmte[L2_VMTE_WORDS])
+{
+    /*
+     * Read L2 VMTE words 1..3, returning false on failure.
+     * @l2_addr is the address of the start of the VMTE.
+     */
+    for (int i = 1; i < L2_VMTE_WORDS; i++) {
+        MemTxResult res;
+
+        l2_vmte[i] = address_space_ldq_le(&cs->dma_as,
+                                          l2_addr + i * sizeof(uint64_t),
+                                          cfg->txattrs, &res);
+        if (res != MEMTX_OK) {
+            return false;
+        }
+    }
+    return true;
+}
+
+static void initialize_vlpi_ist_config(GICv5Common *cs, GICv5Domain domain,
+                                       VMTE *vmte, uint64_t *l2_vmte)
+{
+    hwaddr base = l2_vmte[2] & R_L2_VMTE_2_LPI_IST_ADDR_MASK;
+    uint8_t l2sz = FIELD_EX64(l2_vmte[2], L2_VMTE_2, LPI_IST_L2SZ);
+    uint8_t istsz = FIELD_EX64(l2_vmte[2], L2_VMTE_2, LPI_ISTSZ);
+    uint8_t id_bits = FIELD_EX64(l2_vmte[2], L2_VMTE_2, LPI_ID_BITS);
+    bool structure = FIELD_EX64(l2_vmte[2], L2_VMTE_2, LPI_IST_STRUCTURE);
+
+    id_bits = MIN(MAX(id_bits, QEMU_GICV5_MIN_LPI_ID_BITS), QEMU_GICV5_ID_BITS);
+
+    initialize_ist_config(cs, domain, &vmte->lpi_ist, base,
+                          id_bits, istsz, l2sz, structure);
+}
+
+static void initialize_vspi_ist_config(GICv5Common *cs, GICv5Domain domain,
+                                       VMTE *vmte, uint64_t *l2_vmte)
+{
+    hwaddr base = l2_vmte[3] & R_L2_VMTE_3_SPI_IST_ADDR_MASK;
+    uint8_t l2sz = FIELD_EX64(l2_vmte[3], L2_VMTE_3, SPI_IST_L2SZ);
+    uint8_t istsz = FIELD_EX64(l2_vmte[3], L2_VMTE_3, SPI_ISTSZ);
+    uint8_t id_bits = FIELD_EX64(l2_vmte[3], L2_VMTE_3, SPI_ID_BITS);
+    bool structure = FIELD_EX64(l2_vmte[3], L2_VMTE_3, SPI_IST_STRUCTURE);
+
+    /*
+     * Note that QEMU_GICV5_MIN_LPI_ID_BITS applies to physical
+     * LPIs and virtual LPIs but not to vSPIs.
+     */
+    id_bits = MIN(id_bits, QEMU_GICV5_ID_BITS);
+
+    initialize_ist_config(cs, domain, &vmte->spi_ist, base,
+                          id_bits, istsz, l2sz, structure);
+}
+
+static void cache_vmte(GICv5Common *cs, GICv5Domain domain,
+                       GICv5VMTConfig *cfg,
+                       uint32_t vmid, uint64_t *l2_vmte, hwaddr l2_addr)
+{
+    /*
+     * Add a VMTE struct for an L2 VMTE to the VM cache for @cfg.
+     * @l2_addr should be the address of the L2 VMTE in guest memory.
+     * @l2_vmte is the contents of that VMTE. The caller guarantees
+     * that the VALID bit is set both in @l2_vmte and in memory.
+     */
+    VMTE *vmte = g_new0(VMTE, 1);
+
+    vmte->vmte_addr = l2_addr;
+    vmte->vmid = vmid;
+    vmte->domain = domain;
+
+    vmte->vpet_addr = l2_vmte[1] & R_L2_VMTE_1_VPET_ADDR_MASK;
+    vmte->vpe_id_bits = MIN(FIELD_EX64(l2_vmte[1], L2_VMTE_1, VPE_ID_BITS),
+                            QEMU_GICV5_VPE_ID_BITS);
+    /*
+     * Enforce alignment of the VPE table to its size:
+     * it has 2^vpe_id_bits entries of 2^3 == 8 bytes each
+     */
+    vmte->vpet_addr &= ~MAKE_64BIT_MASK(0, vmte->vpe_id_bits + 3);
+
+    /*
+     * If the VALID bits are set for the LPI and SPI ISTs, we can read
+     * the address and config fields now to set up the GICv5ISTConfig.
+     * Otherwise, the guest can make them valid later via IRS_VMAP_VISTR,
+     * and we must not read the address/config fields yet.
+     */
+    if (FIELD_EX64(l2_vmte[2], L2_VMTE_2, LPI_IST_VALID)) {
+        initialize_vlpi_ist_config(cs, domain, vmte, l2_vmte);
+    }
+
+    if (FIELD_EX64(l2_vmte[3], L2_VMTE_3, SPI_IST_VALID)) {
+        initialize_vspi_ist_config(cs, domain, vmte, l2_vmte);
+    }
+
+    g_hash_table_insert(cfg->vm_cache, GINT_TO_POINTER(vmid), vmte);
+
+    trace_gicv5_cache_vmte(domain_name[domain], vmid);
+}
+
 /* Data we need to pass through to irs_clean_lpi_cache_entry() */
 typedef struct CleanLPICacheUserData {
     GICv5Common *cs;
@@ -1197,6 +1338,40 @@ static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     }
 }
 
+typedef struct CleanVMCacheUserData {
+    GICv5Common *cs;
+    GICv5VMTConfig *cfg;
+} CleanVMCacheUserData;
+
+static gboolean irs_clean_vm_cache_entry(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    /*
+     * Drop this entry from the VM cache, including cleaning up its
+     * LPI and SPI caches.
+     */
+    CleanVMCacheUserData *ud = user_data;
+    VMTE *vmte = (VMTE *)value;
+
+    irs_clean_lpi_cache(ud->cs, &vmte->lpi_ist);
+    irs_clean_lpi_cache(ud->cs, &vmte->spi_ist);
+    return true;
+}
+
+static void irs_clean_vm_cache(GICv5Common *cs, GICv5VMTConfig *cfg)
+{
+    /*
+     * Drop the VM table cache. We don't need to write anything back
+     * to guest memory for the VM table entries themselves, but we
+     * need to clean the LPI/SPI cache, which might do writeback.
+     */
+    CleanVMCacheUserData ud;
+
+    ud.cs = cs;
+    ud.cfg = cfg;
+    g_hash_table_foreach_remove(cfg->vm_cache, irs_clean_vm_cache_entry, &ud);
+}
+
 static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 {
     GICv5Common *cs = ARM_GICV5_COMMON(s);
@@ -1213,6 +1388,7 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
             /* Ignore 1->1 transition */
             return;
         }
+        irs_clean_vm_cache(cs, &s->vmt_config[domain]);
         cs->irs_vmt_baser[domain] = FIELD_DP64(cs->irs_vmt_baser[domain],
                                                IRS_VMT_BASER, VALID, valid);
         s->vmt_config[domain].valid = false;
@@ -1273,6 +1449,16 @@ static void irs_vmt_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
             cfg->base &= ~MAKE_64BIT_MASK(0, tableszbits);
         }
 
+        if (!cfg->vm_cache) {
+            /*
+             * Keys are GINT_TO_POINTER(intid), so we want the g_direct_hash
+             * and g_direct_equal hash and equality functions. We don't
+             * want to free the keys, but we do want to free the values
+             * (which are VMTE*).
+             */
+            cfg->vm_cache = g_hash_table_new_full(NULL, NULL, NULL, VMTE_free);
+        }
+
         cfg->valid = true;
 
         trace_gicv5_vmt_valid(domain_name[domain], cfg->base,
@@ -1346,7 +1532,7 @@ static void irs_vmap_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
     bool m = FIELD_EX64(value,  IRS_VMAP_VMR, M);
     bool u = FIELD_EX64(value,  IRS_VMAP_VMR, U);
     hwaddr l1_addr, l2_addr;
-    uint64_t l1_vmte, l2_vmte_0;
+    uint64_t l1_vmte, l2_vmte[L2_VMTE_WORDS];
     MemTxResult res;
 
     if (!gicv5_domain_has_virt(cs, domain) || !cfg->valid) {
@@ -1375,16 +1561,25 @@ static void irs_vmap_vmr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
 
     l2_addr = l1_vmte & R_L1_VMTE_L2_ADDR_MASK;
 
-    l2_vmte_0 = address_space_ldq_le(&cs->dma_as, l2_addr, cfg->txattrs, &res);
+    if (!read_first_vmte_word(cs, cfg, l2_addr, l2_vmte)) {
+        goto txfail;
+    }
+
+    l2_vmte[0] = FIELD_DP64(l2_vmte[0], L2_VMTE_0, VALID, !u);
+
+    address_space_stq_le(&cs->dma_as, l2_addr, l2_vmte[0], cfg->txattrs, &res);
     if (res != MEMTX_OK) {
         goto txfail;
     }
 
-    l2_vmte_0 = FIELD_DP64(l2_vmte_0, L2_VMTE_0, VALID, !u);
+    if (u) {
+        g_hash_table_remove(cfg->vm_cache, GINT_TO_POINTER(vmid));
+    } else {
+        if (!read_other_vmte_words(cs, cfg, l2_addr, l2_vmte)) {
+            goto txfail;
+        }
 
-    address_space_stq_le(&cs->dma_as, l2_addr, l2_vmte_0, cfg->txattrs, &res);
-    if (res != MEMTX_OK) {
-        goto txfail;
+        cache_vmte(cs, domain, cfg, vmid, l2_vmte, l2_addr);
     }
 
     return;
@@ -1999,6 +2194,10 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
     /* IRS_VMT_BASER and IRS_VMT_CFGR reset to 0, clear cached info */
     for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
         s->vmt_config[i].valid = false;
+        /* Drop the VM cache entries without writeback */
+        if (s->vmt_config[i].vm_cache) {
+            g_hash_table_remove_all(s->vmt_config[i].vm_cache);
+        }
     }
 }
 
@@ -2121,6 +2320,11 @@ static void gicv5_finalize(Object *obj)
             g_hash_table_destroy(ht);
         }
 
+        ht = s->vmt_config[i].vm_cache;
+        if (ht) {
+            g_hash_table_destroy(ht);
+        }
+
         g_free(s->hppi[i]);
     }
 }
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 4b47b98e66c..cb3568fa80c 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -249,6 +249,7 @@ gicv5_irs_recalc_hppi(const char *domain, uint32_t iaffid, uint32_t id, uint8_t
 gicv5_vmt_valid(const char *domain, uint64_t base, uint8_t vm_id_bits, bool structure) "GICv5 IRS %s VM table now valid: base 0x%" PRIx64 " vm_id_bits %u 2-level %d"
 gicv5_vmt_invalid(const char *domain) "GICv5 IRS %s VM table no longer valid"
 gicv5_vmap_l2_vmtr(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u now valid"
+gicv5_cache_vmte(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u valid and cached"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5.h b/include/hw/intc/arm_gicv5.h
index 785c7112fd9..28417317376 100644
--- a/include/hw/intc/arm_gicv5.h
+++ b/include/hw/intc/arm_gicv5.h
@@ -36,6 +36,8 @@ typedef struct GICv5VMTConfig {
     uint8_t vm_id_bits; /* number of VM ID bits for the domain */
     bool structure; /* true if using 2-level table */
     bool valid; /* true if this table is valid and usable */
+    /* This caches information about valid VMs */
+    GHashTable *vm_cache;
 } GICv5VMTConfig;
 
 /*
diff --git a/include/hw/intc/arm_gicv5_regs.h b/include/hw/intc/arm_gicv5_regs.h
index edc66887ac4..51ea451b6b6 100644
--- a/include/hw/intc/arm_gicv5_regs.h
+++ b/include/hw/intc/arm_gicv5_regs.h
@@ -294,6 +294,9 @@ FIELD(L2_VMTE_3, SPI_ISTSZ, 56, 2)
 FIELD(L2_VMTE_3, SPI_IST_STRUCTURE, 58, 1)
 FIELD(L2_VMTE_3, SPI_ID_BITS, 59, 5)
 
+/* Size of L2 VMTE in 64-bit words */
+#define L2_VMTE_WORDS 4
+
 /*
  * L2 VMTEs are always 32 bytes, and the L2 table is always 4KB,
  * so the lower 7 bits in a VM ID index the L2 table.
-- 
2.43.0


