Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EE29C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR4A-0001xM-Fr; Thu, 18 Jul 2024 09:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3q-0008NV-VC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3n-0004Uk-LB
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2ee920b0781so10537141fa.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308837; x=1721913637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wmpf63yo5K0dFoH42GioZzE5DZ52sf+lBkHwuB49yuw=;
 b=yGhAmYzPOhY6q4Lenp8Iy/nrmyaoIjP2UhQqo95w0ocHbVoyeuClxLNnjFEOI2OpRg
 nIJ06VpIIjh48yhiiEcfREkXegB6PTPHGEsVxW2MNanlagYplkoCTCuleFhZocbQu1h2
 A2usw0Ixzlnh2Mb00XX20FQicUjd3fpC9aOSyY8BRdmJsmKEc2TRFI+iic75782P2ca5
 d3qPvw3X0NGow8kZZL9QP1+QzIvZwLL4ZWlSN2uyN2v5mVy51KFhWAOpDuFwNXxWMZq9
 CdA3F5q71yJRunhp3djXM8kNXzIWh6GZqp/Mz5I26GGS7iToQIBAxgdeZw9iAgJdoRqa
 KDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308837; x=1721913637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wmpf63yo5K0dFoH42GioZzE5DZ52sf+lBkHwuB49yuw=;
 b=GNZNUpz2FLsx0eJ+ToLb358X3ajfdwBgyWmaoxq056QiYynN1fybmjG8HBtQGEbLnY
 lsweqdRRUdCpkDdKLaPsI7U6epCiYfXlsOdglctKEktVGsjfpjueG9jumw4L09qXFhWB
 PMzQ0+xkZyr2X2u14mNGbiLPEQeUJBsCE+qpPTNWSgU5hwlyvtA0d8gl0ERHRtHqF+CJ
 iWTRtmunSHgiiiBVpg3HyrOFvEOQjw+8MoMsJdGKmCG8JQYJL4hAEQ5861ZClUpIlAMt
 hJrm2LIWS04kginhVT5Du6Lbh2jXhVnZXK6FVEc3tkfhOSZTK5SVYpGJwUtF81bopCC0
 X7Qg==
X-Gm-Message-State: AOJu0Ywdm8ZOULInVbU4MLi6VEBdX3r+avXy9EV2ZiolrDf6OPCxmPlK
 pdL6nyw6JnyLAV3sZobN7I1Fj3Ve0g5PPjOfUEp71IsffgzGIlAeYvTqk9FTaj7ZpWmJeiLfVnZ
 Q
X-Google-Smtp-Source: AGHT+IHK5pG/rkgLd4fkn5paDdEgkzm5RVUZptce9d/PL4/jUoS/XF0krJyimfbifF8PsO3d68GnNQ==
X-Received: by 2002:a2e:b88d:0:b0:2ec:42db:96a2 with SMTP id
 38308e7fff4ca-2ef05c9d964mr20833451fa.29.1721308837332; 
 Thu, 18 Jul 2024 06:20:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/26] hw/arm/smmu-common: Support nested translation
Date: Thu, 18 Jul 2024 14:20:16 +0100
Message-Id: <20240718132028.697927-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

When nested translation is requested, do the following:
- Translate stage-1 table address IPA into PA through stage-2.
- Translate stage-1 table walk output (IPA) through stage-2.
- Create a single TLB entry from stage-1 and stage-2 translations
  using logic introduced before.

smmu_ptw() has a new argument SMMUState which include the TLB as
stage-1 table address can be cached in there.

Also in smmu_ptw(), a separate path used for nesting to simplify the
code, although some logic can be combined.

With nested translation class of translation fault can be different,
from the class of the translation, as faults from translating stage-1
tables are considered as CLASS_TT and not CLASS_IN, a new member
"is_ipa_descriptor" added to "SMMUPTWEventInfo" to differ faults
from walking stage 1 translation table and faults from translating
an IPA for a transaction.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-12-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  7 ++--
 hw/arm/smmu-common.c         | 74 +++++++++++++++++++++++++++++++-----
 hw/arm/smmuv3.c              | 14 +++++++
 3 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 08775364723..a51005e8b84 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -63,6 +63,7 @@ typedef struct SMMUPTWEventInfo {
     SMMUStage stage;
     SMMUPTWEventType type;
     dma_addr_t addr; /* fetched address that induced an abort, if any */
+    bool is_ipa_descriptor; /* src for fault in nested translation. */
 } SMMUPTWEventInfo;
 
 typedef struct SMMUTransTableInfo {
@@ -184,9 +185,9 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
  * smmu_ptw - Perform the page table walk for a given iova / access flags
  * pair, according to @cfg translation config
  */
-int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
-
+int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
+             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe,
+             SMMUPTWEventInfo *info);
 
 /*
  * smmu_translate - Look for a translation in TLB, if not, do a PTW.
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index bf55b9c5a42..912b89b5eeb 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -318,8 +318,41 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
     return NULL;
 }
 
+/* Translate stage-1 table address using stage-2 page table. */
+static inline int translate_table_addr_ipa(SMMUState *bs,
+                                           dma_addr_t *table_addr,
+                                           SMMUTransCfg *cfg,
+                                           SMMUPTWEventInfo *info)
+{
+    dma_addr_t addr = *table_addr;
+    SMMUTLBEntry *cached_entry;
+    int asid;
+
+    /*
+     * The translation table walks performed from TTB0 or TTB1 are always
+     * performed in IPA space if stage 2 translations are enabled.
+     */
+    asid = cfg->asid;
+    cfg->stage = SMMU_STAGE_2;
+    cfg->asid = -1;
+    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
+    cfg->asid = asid;
+    cfg->stage = SMMU_NESTED;
+
+    if (cached_entry) {
+        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
+        return 0;
+    }
+
+    info->stage = SMMU_STAGE_2;
+    info->addr = addr;
+    info->is_ipa_descriptor = true;
+    return -EINVAL;
+}
+
 /**
  * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
+ * @bs: smmu state which includes TLB instance
  * @cfg: translation config
  * @iova: iova to translate
  * @perm: access type
@@ -331,7 +364,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
  * Upon success, @tlbe is filled with translated_addr and entry
  * permission rights.
  */
-static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
+static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
                           dma_addr_t iova, IOMMUAccessFlags perm,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
@@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                 goto error;
             }
             baseaddr = get_table_pte_address(pte, granule_sz);
+            if (cfg->stage == SMMU_NESTED) {
+                if (translate_table_addr_ipa(bs, &baseaddr, cfg, info)) {
+                    goto error;
+                }
+            }
             level++;
             continue;
         } else if (is_page_pte(pte, level)) {
@@ -568,10 +606,8 @@ error:
  * combine S1 and S2 TLB entries into a single entry.
  * As a result the S1 entry is overriden with combined data.
  */
-static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
-                                                SMMUTLBEntry *tlbe_s2,
-                                                dma_addr_t iova,
-                                                SMMUTransCfg *cfg)
+static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
+                        dma_addr_t iova, SMMUTransCfg *cfg)
 {
     if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
         tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
@@ -591,6 +627,7 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
 /**
  * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
  *
+ * @bs: smmu state which includes TLB instance
  * @cfg: translation configuration
  * @iova: iova to translate
  * @perm: tentative access type
@@ -599,11 +636,15 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
  *
  * return 0 on success
  */
-int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
-             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
+int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
+             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
+    int ret;
+    SMMUTLBEntry tlbe_s2;
+    dma_addr_t ipa;
+
     if (cfg->stage == SMMU_STAGE_1) {
-        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
+        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
     } else if (cfg->stage == SMMU_STAGE_2) {
         /*
          * If bypassing stage 1(or unimplemented), the input address is passed
@@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
         return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
     }
 
-    g_assert_not_reached();
+    /* SMMU_NESTED. */
+    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
+    if (ret) {
+        return ret;
+    }
+
+    ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
+    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
+    if (ret) {
+        return ret;
+    }
+
+    combine_tlb(tlbe, &tlbe_s2, iova, cfg);
+    return 0;
 }
 
 SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
@@ -667,7 +721,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
     }
 
     cached_entry = g_new0(SMMUTLBEntry, 1);
-    status = smmu_ptw(cfg, addr, flag, cached_entry, info);
+    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info);
     if (status) {
             g_free(cached_entry);
             return NULL;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 5c5fee27997..0faa08c8d8b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -910,6 +910,20 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
     if (!cached_entry) {
         /* All faults from PTW has S2 field. */
         event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
+        /*
+         * Fault class is set as follows based on "class" input to
+         * the function and to "ptw_info" from "smmu_translate()"
+         * For stage-1:
+         *   - EABT => CLASS_TT (hardcoded)
+         *   - other events => CLASS_IN (input to function)
+         * For stage-2 => CLASS_IN (input to function)
+         * For nested, for all events:
+         *  - CD fetch => CLASS_CD (input to function)
+         *  - walking stage 1 translation table  => CLASS_TT (from
+         *    is_ipa_descriptor or input in case of TTBx)
+         *  - s2 translation => CLASS_IN (input to function)
+         */
+        class = ptw_info.is_ipa_descriptor ? SMMU_CLASS_TT : class;
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
             event->type = SMMU_EVT_F_WALK_EABT;
-- 
2.34.1


