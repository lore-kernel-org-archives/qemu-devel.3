Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5620CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY84-0006La-Ql; Tue, 13 Oct 2026 04:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4D-0000SH-KA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4B-00087R-3S
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:01 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so18417395e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880858; x=1792485658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y2YLtKEIJReIXSWDT6avZPvz6gFeM5i0piN3T0fzPwU=;
 b=Xf1bgs0z52iOXZqY35y1Zdd+HK8LSR1X4i0if4NoLUtPnJUgv80xLz/PmQXUhG2VSw
 Q/c6/ZzNJuECep2mM0pUie27KdIOgqJ11ZY2N2cekcckftTzrVIHN8xmAWArHk3/oEJz
 7yv7bik2K5TcephdVqo1ljgbpqWf5kCllqFEjvDYeYNw+4IYj2OhMuw0DDEkwA4JNyuy
 ihGJpSvJjNk2jQu3Lx3CVrGwjf1Qk0+tHSpJLOhDw0uZ5D4GaCRgsIES62zfXFbDZAb0
 u298rALfvqDFKNLRGWgwOiSZ5+azI058NjFq1ctnU/T80Z4MEDGA8s1bx7LamM1Ejav8
 1LqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880858; x=1792485658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y2YLtKEIJReIXSWDT6avZPvz6gFeM5i0piN3T0fzPwU=;
 b=dLYr3s/O16mcNnzltj+iuhqYZDYiXDzlFSerOd+ALl1TNeM6wq00AazilDdI84OfQu
 4XXrtPPOXwibChQLtqHOf6El3H6e6s/76yiWE1ZqnZVrvIBVbcKzDhi2kxjojv6gw4iO
 Mka5RaC1s2NwymOfBdsf2VE/RQBxsacxpmlZau7tZ5iH5eH4pc3KEaIMRzg+lnQNhHDU
 4G2FEZTii7qiqrZ+/t1uKKZvSymDF/r4KKB1zer4qsN1NxJ7R7Z5lDVlAk970k57PNlI
 BCJ0zQSCsTogSlbBKnZbfdK+fT0jHjwwbndrlS1IjNcMvat/xU+t6Ktq71tI935SelUt
 2twQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByb5FqX7ICJMpX+qa62czRQLKYOAZ68s3uAzt1aENDFeh1sJxT5x+STu8mm36Vdo+tc4s3aCw8lVAOT@nongnu.org
X-Gm-Message-State: AFq9FYKyTc0UotdyAtGsk9mCQNBKTp2luRZdTlSKvIvAs+9EEHp2AiIO
 oKVzTX1ILmZ09EMcWuQPeOgsRUkHb902SV+3d+oa+h6ZjE7qCns97a+2rym4UwmndmA=
X-Gm-Gg: AYBFou2JzhXOMpaIPIIVkb2T6nuk3x3CmfiealTgxJ8jK1ezmXauB8rlaF2A3dXDmLL
 wclOOGQKnbif7EJmd0GxtQ5tKA2P8L411DxSxN6Mkv/7Ny3h5xTYr9anvG2RS40WNDsrmheNUk9
 dxPZudqqiR3aDATh613krxNNlmbhofRiyMDQUXoRfhE90GUi7jbfJj7abW/lCflU7bld95m0qgT
 tWSzexVPn/WUiYSmv2ldkl3z1+7rN+5gctyBxFBmy0gdl9/wWAtXpSraHskPOYeJqzBx8jbQWdj
 lChQbPO+hv0wCcwtgUdKlW7PuTbTBG8cQNAnca+kdzlMEB77U/v0LZMaZ6GTkgK9pZvimPtEH3V
 pV7kq54fyS/h2sVRygElv1FLFGfVS6y6DDMG9/g+PqyEHXcsjd9uQitDCv+/1ghT1wPQsupSkjN
 sSYNROC+V9jH+6iujgAGX6ebjdILSgwa5cEgBaMjqEIFzzOtJXAGRYakEa308QCfQHW8XTn6Gzg
 eZ35LtLTTu4GQCMtQ8gPSO9r2hnu3c8gqW4XkOAUYnRsCIOz+nmGYvaRvTRpUqfygclAasqL6Xi
 NJQ=
X-Received: by 2002:a05:600c:1d20:b0:49f:fd40:80fa with SMTP id
 5b1f17b1804b1-4a18e4f50ecmr237606565e9.34.1791880857652; 
 Tue, 13 Oct 2026 01:40:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 63/86] hw/intc/arm_gicv5: Cache VPE table information
Date: Tue, 13 Oct 2026 09:39:10 +0100
Message-ID: <20261013083933.1024405-64-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Each VM has a VPE table which is a single linear table with an entry
for each possible vCPU in the VM.  Each VPE has a 'valid' bit and a
pointer to a VPE descriptor which has IMPDEF contents.  When the VM
is made valid, the table can contain a mix of already-valid and
not-yet-valid VPEs.

Cache this information.  Since the GICv5 architecture requires a
simple linear table here, we can assume that the guest is unlikely to
populate it sparsely, so we use a simple array rather than a
hashtable.

We will gradually expand the information we put into our VPE struct,
but for now we just have a boolean tracking whether the VPE is valid
or not, the guest address of the VPED, and a back-pointer to the
VMTE.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c              | 62 ++++++++++++++++++++++++++++++--
 hw/intc/trace-events             |  1 +
 include/hw/intc/arm_gicv5_regs.h |  3 ++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 4f74236c62b..c3d824f045b 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -23,10 +23,20 @@
 
 OBJECT_DEFINE_TYPE(GICv5, gicv5, ARM_GICV5, ARM_GICV5_COMMON)
 
+typedef struct VMTE VMTE;
+
+/* Cached per-VPE information, from VPE and VPE descriptor */
+typedef struct VPE {
+    VMTE *vmte;
+    hwaddr vped_addr;
+    bool valid;
+} VPE;
+
 /* In the GICv5VMTConfig::vm_cache this is how we store VMTE info */
-typedef struct VMTE {
+struct VMTE {
     GICv5ISTConfig lpi_ist;
     GICv5ISTConfig spi_ist;
+    VPE *vpet;
     /* Address of the in-memory L2_VMTE for this VMTE */
     hwaddr vmte_addr;
     hwaddr vpet_addr;
@@ -35,7 +45,7 @@ typedef struct VMTE {
     GICv5Domain domain;
     /* We don't cache the VMD_ADDR as we don't use VMDs */
     /* We don't cache VALID: the existence of this struct implies VALID=1 */
-} VMTE;
+};
 
 static const char *domain_name[] = {
     [GICV5_ID_S] = "Secure",
@@ -101,6 +111,8 @@ static void VMTE_free(void *data)
         g_hash_table_destroy(vmte->spi_ist.lpi_cache);
     }
 
+    g_free(vmte->vpet);
+
     g_free(vmte);
 }
 
@@ -1219,6 +1231,51 @@ static void initialize_vspi_ist_config(GICv5Common *cs, GICv5Domain domain,
                           id_bits, istsz, l2sz, structure);
 }
 
+static void init_vpe_from_vpete(VPE *vpe, VMTE *vmte, uint64_t vpete)
+{
+    /* Given the value of the in-memory VPETE, set up one VPE struct */
+    vpe->vmte = vmte;
+    vpe->valid = FIELD_EX64(vpete, VPETE, VALID);
+    if (vpe->valid) {
+        vpe->vped_addr = vpete & R_VPETE_VPED_ADDR_MASK;
+        vpe->vped_addr &= ~MAKE_64BIT_MASK(0, QEMU_GICV5_VPED_SZ);
+    }
+}
+
+static void initialize_vpet(GICv5Common *cs, GICv5Domain domain,
+                            GICv5VMTConfig *cfg, VMTE *vmte)
+{
+    /*
+     * Allocate our cached VPE table, and populate it from guest memory.
+     * Note that (per R_DLKTX) the VPE descriptor is supposed to be all
+     * zeroes at this point, and behaviour is UNPREDICTABLE if it is not,
+     * so we do not need to read the descriptor here. In any case QEMU
+     * doesn't use the VPE descriptors.
+     */
+    int num_vpes = 1 << vmte->vpe_id_bits;
+    hwaddr vpete_addr = vmte->vpet_addr;
+
+    vmte->vpet = g_new0(VPE, num_vpes);
+
+    for (int i = 0; i < num_vpes; i++, vpete_addr += 8) {
+        MemTxResult res;
+        uint64_t vpete;
+
+        vpete = address_space_ldq_le(&cs->dma_as, vpete_addr,
+                                     cfg->txattrs, &res);
+        if (res != MEMTX_OK) {
+            qemu_log_mask(LOG_GUEST_ERROR, "VPET lookup failed for VPE 0x%x"
+                          " at physical address 0x" HWADDR_FMT_plx "\n",
+                          i, vpete_addr);
+            return;
+        }
+
+        init_vpe_from_vpete(&vmte->vpet[i], vmte, vpete);
+        trace_gicv5_initialize_vpet(domain_name[vmte->domain], vmte->vmid,
+                                    i, vmte->vpet[i].valid);
+    }
+}
+
 static void cache_vmte(GICv5Common *cs, GICv5Domain domain,
                        GICv5VMTConfig *cfg,
                        uint32_t vmid, uint64_t *l2_vmte, hwaddr l2_addr)
@@ -1243,6 +1300,7 @@ static void cache_vmte(GICv5Common *cs, GICv5Domain domain,
      * it has 2^vpe_id_bits entries of 2^3 == 8 bytes each
      */
     vmte->vpet_addr &= ~MAKE_64BIT_MASK(0, vmte->vpe_id_bits + 3);
+    initialize_vpet(cs, domain, cfg, vmte);
 
     /*
      * If the VALID bits are set for the LPI and SPI ISTs, we can read
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index a086b14c825..9057f83af57 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -251,6 +251,7 @@ gicv5_vmt_invalid(const char *domain) "GICv5 IRS %s VM table no longer valid"
 gicv5_vmap_l2_vmtr(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u now valid"
 gicv5_cache_vmte(const char *domain, uint32_t vmid) "GICv5 IRS %s VM ID %u valid and cached"
 gicv5_irs_vmap_vistr_write(const char *domain, uint32_t vmid, const char *type, const char *what) "GICv5 IRS %s VM ID %u %s IST now %s"
+gicv5_initialize_vpet(const char *domain, uint32_t vmid, uint32_t vpeid, bool valid) "GICv5 IRS %s VM ID %u VPE %u starts as valid %d"
 
 # arm_gicv5_common.c
 gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
diff --git a/include/hw/intc/arm_gicv5_regs.h b/include/hw/intc/arm_gicv5_regs.h
index f1ebbb6aaf8..f4243abd182 100644
--- a/include/hw/intc/arm_gicv5_regs.h
+++ b/include/hw/intc/arm_gicv5_regs.h
@@ -306,6 +306,9 @@ FIELD(L2_VMTE_3, SPI_ID_BITS, 59, 5)
 #define VMT_L2_IDX_BITS 7
 #define VMT_L2_TABLE_SIZE 4096
 
+FIELD(VPETE, VALID, 0, 1)
+FIELD(VPETE, VPED_ADDR, 3, 53)
+
 /*
  * Format used for gicv5_request_config() return value, which matches
  * the ICC_ICSR_EL1 bit layout.
-- 
2.43.0


