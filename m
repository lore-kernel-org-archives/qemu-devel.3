Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B26C3DA6A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3z-0000hq-6R; Thu, 18 Jul 2024 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3n-00087Q-7i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3k-0004Ti-R8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266ea6a412so2811625e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308835; x=1721913635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fQR13XT9VDhcBY8spm2JM5I6IhE7k7yNucwEDGm4s9I=;
 b=gdfN3VO1paV3FAeD02sseyCYL9SF6Hht/vB02NxjnSlb6ATZh6D2qLvReCtP6E/mF9
 nuMr6D5u5xXFC4IlxwPmtrlZcb4qhoehPgXuh6JuCVosqpVzzEb08CL4J+RTo96pN3du
 HF+GkJS9fyEWT9p508ssPdojTz9p8jTUa+ot5xtavJ9tCtHl9CiN+eTHGhTU9Gi+gbU/
 /fpNM/BJT3y+Qlz+RDepk+bn5t+xP0n6qvbxG04G2L0MIYz4ns7bynP5NCVTISKeSp3R
 zY6+hVc0/dh4yWl76Y3Ip9daSheqZz40h1H4m8R9em+Cy79VyztShunGni9fe39tH82B
 itFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308835; x=1721913635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQR13XT9VDhcBY8spm2JM5I6IhE7k7yNucwEDGm4s9I=;
 b=Iq6hwMs1mLlJ7+gVX7n0k6Q78bwitt0pgAeKOsBURujNmTKi4duDy8Sh5aSuv+e52W
 hkngHfi+FQN5EXPxjNyqX37AY7HWt6Jv5y37oQ2BGUlc/9QaXvsmfu2j9hoN4luzSfxk
 Wrm3AAuPbbrPZdX968S6uM9r1JzRbNgqqo3TelJhUrjvMag6HGEnTvGCeAbh07tJgEyY
 DoRVwo2DG5dJ5B01LSOaHg89N0k5MjEqOhIcBs9NfvUslNU5J5Yn8G6BLGJcQydQUZZ1
 KG9pGtpEPnFuGAQOOwXWKhrVK/9W56uMfsvauhGtG+mwkGsHfRh//6Lplhqns2PWenwQ
 tXFQ==
X-Gm-Message-State: AOJu0YxErHeYru5KMeTkAcws8iEboPaTjOgpsWyfKkc5n0MFieuaCXhM
 Z9xiqC0GmEUXQMuST5iaZuosN56BJsUSh6iJwgzyg5xIOhKvHyej0lIArA3dvA6hl3ZbUr7Y5EK
 t
X-Google-Smtp-Source: AGHT+IH9QSFfu40W4eTsfiZ7FyzuyepIpSmyiqOHhGuM6vDc6jbMJwMzbqFBiCm0WvgwNOuldnee9A==
X-Received: by 2002:a05:600c:35d5:b0:427:9922:4526 with SMTP id
 5b1f17b1804b1-427c2cadebfmr32709665e9.7.1721308834660; 
 Thu, 18 Jul 2024 06:20:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/26] hw/arm/smmu: Consolidate ASID and VMID types
Date: Thu, 18 Jul 2024 14:20:11 +0100
Message-Id: <20240718132028.697927-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Mostafa Saleh <smostafa@google.com>

ASID and VMID used to be uint16_t in the translation config, however,
in other contexts they can be int as -1 in case of TLB invalidation,
to represent all (don’t care).
When stage-2 was added asid was set to -1 in stage-2 and vmid to -1
in stage-1 configs. However, that meant they were set as (65536),
this was not an issue as nesting was not supported and no
commands/lookup uses both.

With nesting, it’s critical to get this right as translation must be
tagged correctly with ASID/VMID, and with ASID=-1 meaning stage-2.
Represent ASID/VMID everywhere as int.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-7-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 14 +++++++-------
 hw/arm/smmu-common.c         | 10 +++++-----
 hw/arm/smmuv3.c              |  4 ++--
 hw/arm/trace-events          | 18 +++++++++---------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 366b53be778..5cb30244646 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -84,7 +84,7 @@ typedef struct SMMUS2Cfg {
     bool record_faults;     /* Record fault events (S2R) */
     uint8_t granule_sz;     /* Granule page shift (based on S2TG) */
     uint8_t eff_ps;         /* Effective PA output range (based on S2PS) */
-    uint16_t vmid;          /* Virtual Machine ID (S2VMID) */
+    int vmid;               /* Virtual Machine ID (S2VMID) */
     uint64_t vttb;          /* Address of translation table base (S2TTB) */
 } SMMUS2Cfg;
 
@@ -108,7 +108,7 @@ typedef struct SMMUTransCfg {
     uint64_t ttb;              /* TT base address */
     uint8_t oas;               /* output address width */
     uint8_t tbi;               /* Top Byte Ignore */
-    uint16_t asid;
+    int asid;
     SMMUTransTableInfo tt[2];
     /* Used by stage-2 only. */
     struct SMMUS2Cfg s2cfg;
@@ -132,8 +132,8 @@ typedef struct SMMUPciBus {
 
 typedef struct SMMUIOTLBKey {
     uint64_t iova;
-    uint16_t asid;
-    uint16_t vmid;
+    int asid;
+    int vmid;
     uint8_t tg;
     uint8_t level;
 } SMMUIOTLBKey;
@@ -205,11 +205,11 @@ SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid);
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
+SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
-void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
+void smmu_iotlb_inv_asid(SMMUState *s, int asid);
+void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 8d52472863b..7fbf8e22fe0 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -57,7 +57,7 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
            (k1->vmid == k2->vmid);
 }
 
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
+SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level)
 {
     SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
@@ -130,7 +130,7 @@ void smmu_iotlb_inv_all(SMMUState *s)
 static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
-    uint16_t asid = *(uint16_t *)user_data;
+    int asid = *(int *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
     return SMMU_IOTLB_ASID(*iotlb_key) == asid;
@@ -139,7 +139,7 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
 static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
                                          gpointer user_data)
 {
-    uint16_t vmid = *(uint16_t *)user_data;
+    int vmid = *(int *)user_data;
     SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
 
     return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
@@ -191,13 +191,13 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                                 &info);
 }
 
-void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
+void smmu_iotlb_inv_asid(SMMUState *s, int asid)
 {
     trace_smmu_iotlb_inv_asid(asid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
 }
 
-void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
 {
     trace_smmu_iotlb_inv_vmid(vmid);
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 76d9969c93e..e71b842162a 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1240,7 +1240,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         }
         case SMMU_CMD_TLBI_NH_ASID:
         {
-            uint16_t asid = CMD_ASID(&cmd);
+            int asid = CMD_ASID(&cmd);
 
             if (!STAGE1_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
@@ -1273,7 +1273,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
-            uint16_t vmid = CMD_VMID(&cmd);
+            int vmid = CMD_VMID(&cmd);
 
             if (!STAGE2_SUPPORTED(s)) {
                 cmd_error = SMMU_CERROR_ILL;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cc12924a84a..09ccd39548f 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -11,13 +11,13 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
 smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
-smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
-smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
-smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
+smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=%d"
+smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
+smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
-smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
+smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_lookup_miss(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_insert(int asid, int vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
@@ -48,12 +48,12 @@ smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t p
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
-smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
-smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
+smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
+smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.34.1


