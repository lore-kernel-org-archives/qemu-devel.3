Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C524BC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR3x-0000Km-Mv; Thu, 18 Jul 2024 09:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3n-00085O-1O
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3j-0004TU-6T
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4266f344091so2728235e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308834; x=1721913634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jDUV0xWI972uNTpKqh58Pmu4q+0S5yiM8R6kVw2B+/k=;
 b=Ya4BdNngX9na7znvUoFDY82iLmuMRYnap7+j6OLULKPfySR6nA6NNmgSRsfp3FFjFl
 +bVbxkrVtkyk44eCCrftXCUQqPGXZqCQYJuWQW2RP74woW2KJYvlwdJAT19KOqDdQhh5
 tbeqSSPSQtjDIwKOa/r+h/W0WokKT0GdScNLFYEhJas7dSuuZe87BxkHbR1PpEkhh3IA
 ijwuXc3a69IORyqM2mjucVl6Yr+XaGtg0/jFJ3Zf/5w7E4mOLIAZmOit+zSrY/nd3hR3
 nNgjhwPrIm3couW1t22e6VynLdGWGTi2laiHStSgl6G5d4JgfYkSpDT5HOZAk7i9/n5n
 PKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308834; x=1721913634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDUV0xWI972uNTpKqh58Pmu4q+0S5yiM8R6kVw2B+/k=;
 b=HH4Z6G+pIN0JVXj7LFqJLkRWV7VJljSBTBwyGNTAHIdsZGuedb8AvnLmPkhkwryIdJ
 8CIIjaFIsvId/aIED1bbtillcAIMvPUgE60UbS8a4ZRbwzQQQvTVFRlyLg1Gl4Q2RGZz
 dIxS2G7LfPIak+EzmuB50L1YbVjzBm6VshvhdCzXIMJGQz44bxX8Le40NMNdIqMmTYTs
 tCgA/SOKuYK6pS8++XQVsh9MUAgkE0LrIqH8foD6E9ICBukNpnhQO+Emlotk9nthsFhc
 CSA5FyPT6H0g6t0ORzQ+35WsCfechQhjnlrNlg4AQHfjA2g/1xZEe3uq5715YhlLE7FY
 H++Q==
X-Gm-Message-State: AOJu0YyWCdm/sTJSVxRTGYU3a5bMvbNexHd5fxJaU40kyQRNTD0tV2ER
 1XfQF4Tg6Uvrbof84WBmPdBvNNiCJUrmHPm4LAXhyN5+Xq6tm6WfRJzqKYvQR4k9WqUSzm7ndqA
 V
X-Google-Smtp-Source: AGHT+IHtzMh3nhU8SWgJqnlfEDdTvDKMOvnuhcVkSbB0XF7iUMyUcedW+99JdTGV2suMDpNcuBJigg==
X-Received: by 2002:a05:600c:1d8b:b0:426:5e1c:1ad0 with SMTP id
 5b1f17b1804b1-427c2d00164mr31993905e9.37.1721308833658; 
 Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/26] hw/arm/smmu: Use enum for SMMU stage
Date: Thu, 18 Jul 2024 14:20:09 +0100
Message-Id: <20240718132028.697927-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently, translation stage is represented as an int, where 1 is stage-1 and
2 is stage-2, when nested is added, 3 would be confusing to represent nesting,
so we use an enum instead.

While keeping the same values, this is useful for:
 - Doing tricks with bit masks, where BIT(0) is stage-1 and BIT(1) is
   stage-2 and both is nested.
 - Tracing, as stage is printed as int.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20240715084519.1189624-5-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h | 11 +++++++++--
 hw/arm/smmu-common.c         | 14 +++++++-------
 hw/arm/smmuv3.c              | 17 +++++++++--------
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 687b7ca132d..260582089e0 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -49,8 +49,15 @@ typedef enum {
     SMMU_PTW_ERR_PERMISSION,  /* Permission fault */
 } SMMUPTWEventType;
 
+/* SMMU Stage */
+typedef enum {
+    SMMU_STAGE_1 = 1,
+    SMMU_STAGE_2,
+    SMMU_NESTED,
+} SMMUStage;
+
 typedef struct SMMUPTWEventInfo {
-    int stage;
+    SMMUStage stage;
     SMMUPTWEventType type;
     dma_addr_t addr; /* fetched address that induced an abort, if any */
 } SMMUPTWEventInfo;
@@ -88,7 +95,7 @@ typedef struct SMMUS2Cfg {
  */
 typedef struct SMMUTransCfg {
     /* Shared fields between stage-1 and stage-2. */
-    int stage;                 /* translation stage */
+    SMMUStage stage;           /* translation stage */
     bool disabled;             /* smmu is disabled */
     bool bypassed;             /* translation is bypassed */
     bool aborted;              /* translation is aborted */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index e8cdbcd8aef..408fc4efcae 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -304,7 +304,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
     dma_addr_t baseaddr, indexmask;
-    int stage = cfg->stage;
+    SMMUStage stage = cfg->stage;
     SMMUTransTableInfo *tt = select_tt(cfg, iova);
     uint8_t level, granule_sz, inputsize, stride;
 
@@ -402,7 +402,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
     info->type = SMMU_PTW_ERR_TRANSLATION;
 
 error:
-    info->stage = 1;
+    info->stage = SMMU_STAGE_1;
     tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
@@ -425,7 +425,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
                           dma_addr_t ipa, IOMMUAccessFlags perm,
                           SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
-    const int stage = 2;
+    const SMMUStage stage = SMMU_STAGE_2;
     int granule_sz = cfg->s2cfg.granule_sz;
     /* ARM DDI0487I.a: Table D8-7. */
     int inputsize = 64 - cfg->s2cfg.tsz;
@@ -525,7 +525,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
 error_ipa:
     info->addr = ipa;
 error:
-    info->stage = 2;
+    info->stage = SMMU_STAGE_2;
     tlbe->entry.perm = IOMMU_NONE;
     return -EINVAL;
 }
@@ -544,9 +544,9 @@ error:
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
              SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
 {
-    if (cfg->stage == 1) {
+    if (cfg->stage == SMMU_STAGE_1) {
         return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
-    } else if (cfg->stage == 2) {
+    } else if (cfg->stage == SMMU_STAGE_2) {
         /*
          * If bypassing stage 1(or unimplemented), the input address is passed
          * directly to stage 2 as IPA. If the input address of a transaction
@@ -555,7 +555,7 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
          */
         if (iova >= (1ULL << cfg->oas)) {
             info->type = SMMU_PTW_ERR_ADDR_SIZE;
-            info->stage = 1;
+            info->stage = SMMU_STAGE_1;
             tlbe->entry.perm = IOMMU_NONE;
             return -EINVAL;
         }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 472fdf2e5fd..aab09df23ec 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -34,7 +34,8 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
-#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == 1) ? (cfg)->record_faults : \
+#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
+                                 (cfg)->record_faults : \
                                  (cfg)->s2cfg.record_faults)
 
 /**
@@ -402,7 +403,7 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
 
 static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
 {
-    cfg->stage = 2;
+    cfg->stage = SMMU_STAGE_2;
 
     if (STE_S2AA64(ste) == 0x0) {
         qemu_log_mask(LOG_UNIMP,
@@ -678,7 +679,7 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
 
     /* we support only those at the moment */
     cfg->aa64 = true;
-    cfg->stage = 1;
+    cfg->stage = SMMU_STAGE_1;
 
     cfg->oas = oas2bits(CD_IPS(cd));
     cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
@@ -762,7 +763,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
         return ret;
     }
 
-    if (cfg->aborted || cfg->bypassed || (cfg->stage == 2)) {
+    if (cfg->aborted || cfg->bypassed || (cfg->stage == SMMU_STAGE_2)) {
         return 0;
     }
 
@@ -882,7 +883,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    if (cfg->stage == 1) {
+    if (cfg->stage == SMMU_STAGE_1) {
         /* Select stage1 translation table. */
         tt = select_tt(cfg, addr);
         if (!tt) {
@@ -919,7 +920,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
              * nesting is not supported. So it is sufficient to check the
              * translation stage to know the TLB stage for now.
              */
-            event.u.f_walk_eabt.s2 = (cfg->stage == 2);
+            event.u.f_walk_eabt.s2 = (cfg->stage == SMMU_STAGE_2);
             if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
@@ -935,7 +936,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
 
     if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
         /* All faults from PTW has S2 field. */
-        event.u.f_walk_eabt.s2 = (ptw_info.stage == 2);
+        event.u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
         g_free(cached_entry);
         switch (ptw_info.type) {
         case SMMU_PTW_ERR_WALK_EABT:
@@ -943,7 +944,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             event.u.f_walk_eabt.addr = addr;
             event.u.f_walk_eabt.rnw = flag & 0x1;
             /* Stage-2 (only) is class IN while stage-1 is class TT */
-            event.u.f_walk_eabt.class = (ptw_info.stage == 2) ?
+            event.u.f_walk_eabt.class = (ptw_info.stage == SMMU_STAGE_2) ?
                                          SMMU_CLASS_IN : SMMU_CLASS_TT;
             event.u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
-- 
2.34.1


