Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4529AC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR47-0001bt-Fu; Thu, 18 Jul 2024 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3o-0008EW-TD
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3m-0004US-NP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-427b4c621b9so2497655e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308836; x=1721913636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X2AcFwMwmG8CuilTxkX1QR6WPC1ZxLwj44sonDWX5Es=;
 b=BNNkDjgFl80e1fh5MKk7eUlFv69FlCM+1ExZTTPvgtHx06Sc/I4ErYvtHvghLgfIeI
 IQT7o3QgSKhys6BYswG1gEMj+eavmrI6wmnaOOG2Zh+m+2FUm/6amPgUeV12Jnu+uLWU
 YMtP+uaNXhRPq2u3d9EbYxMSzHQrRYYVKiHz/G0NJyHPV1xMYMvnAvlDW9/kCRRqJa5L
 oNDXsJHmkn4cyAz7OTXWLWgjpd41sAGJe0/kPySzUKULyyp1H8fQJer4tTF6oOOM8/TF
 zObp9SC3K7wPJ67LnHUJShxQOIsxuDZ/8xyLO9N07LJI/W3bVByiZzOzgT6gmDfc2V1y
 1OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308836; x=1721913636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2AcFwMwmG8CuilTxkX1QR6WPC1ZxLwj44sonDWX5Es=;
 b=Tkcz2NeC3QVt4cWDVYxZ0stkoioLWu3/XeGF1mVyH21Ah9QyGzO9FDaYT1DpzkQDmq
 2BR/1mTyq88MKUU968I93hBkXMgoyxzA9d1E4/hWSPwVwqHqHjwN+HMIzUjNHpl1VEc6
 gP1iHMS6xk0GIovQiQ+u1H42b4DGDwpjxtH/NIONZpI7894L3CsNnuWJhhdE9q4OJ4Bk
 +tOiDBdYWmUesZeuXfR+BqlK/mrZz1Dq7RKDnl9qs7MSJn0vUQ4BF2yXpqCgsht9NuyU
 7iSU1haYkURlS9DCeR5AyKLCDkmzvR6/cmlClptnXVc5RQx0vRz1ZZ7OT+cVvId1alTc
 odNA==
X-Gm-Message-State: AOJu0YzFbDLtMo7o8xNhkSDHXsKtvehDNrP2RFmIUSiHd0hgHRTFTXEh
 PXemsunbN81k3dqvC/m9D5EmN+5bvryJM2ZFRrHbblolMSJTDa0UKJVu5vcvjyhoo/JqC/ogFq2
 r
X-Google-Smtp-Source: AGHT+IG8V51hCMrejrvL15SLFjRqU4d0MaVUnFCqvfL4L7QcMvjMCnxg1nqOfdIUvPSCQNX90MwPkA==
X-Received: by 2002:a05:600c:4fd5:b0:426:5f8f:51a4 with SMTP id
 5b1f17b1804b1-427c2cb08a0mr34368815e9.12.1721308836428; 
 Thu, 18 Jul 2024 06:20:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/26] hw/arm/smmu-common: Rework TLB lookup for nesting
Date: Thu, 18 Jul 2024 14:20:14 +0100
Message-Id: <20240718132028.697927-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

In the next patch, combine_tlb() will be added which combines 2 TLB
entries into one for nested translations, which chooses the granule
and level from the smallest entry.

This means that with nested translation, an entry can be cached with
the granule of stage-2 and not stage-1.

However, currently, the lookup for an IOVA is done with input stage
granule, which is stage-1 for nested configuration, which will not
work with the above logic.
This patch reworks lookup in that case, so it falls back to stage-2
granule if no entry is found using stage-1 granule.

Also, drop aligning the iova to avoid over-aligning in case the iova
is cached with a smaller granule, the TLB lookup will align the iova
anyway for each granule and level, and the page table walker doesn't
consider the page offset bits.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-10-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-common.c | 64 +++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 7fbf8e22fe0..e374cae0db6 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
     return key;
 }
 
-SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
-                                SMMUTransTableInfo *tt, hwaddr iova)
+static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
+                                                  SMMUTransCfg *cfg,
+                                                  SMMUTransTableInfo *tt,
+                                                  hwaddr iova)
 {
     uint8_t tg = (tt->granule_sz - 10) / 2;
     uint8_t inputsize = 64 - tt->tsz;
@@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
         }
         level++;
     }
+    return entry;
+}
+
+/**
+ * smmu_iotlb_lookup - Look up for a TLB entry.
+ * @bs: SMMU state which includes the TLB instance
+ * @cfg: Configuration of the translation
+ * @tt: Translation table info (granule and tsz)
+ * @iova: IOVA address to lookup
+ *
+ * returns a valid entry on success, otherwise NULL.
+ * In case of nested translation, tt can be updated to include
+ * the granule of the found entry as it might different from
+ * the IOVA granule.
+ */
+SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
+                                SMMUTransTableInfo *tt, hwaddr iova)
+{
+    SMMUTLBEntry *entry = NULL;
+
+    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    /*
+     * For nested translation also try the s2 granule, as the TLB will insert
+     * it if the size of s2 tlb entry was smaller.
+     */
+    if (!entry && (cfg->stage == SMMU_NESTED) &&
+        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
+        tt->granule_sz = cfg->s2cfg.granule_sz;
+        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
+    }
 
     if (entry) {
         cfg->iotlb_hits++;
@@ -569,18 +601,21 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
 SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
                              IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
 {
-    uint64_t page_mask, aligned_addr;
     SMMUTLBEntry *cached_entry = NULL;
     SMMUTransTableInfo *tt;
     int status;
 
     /*
-     * Combined attributes used for TLB lookup, as only one stage is supported,
-     * it will hold attributes based on the enabled stage.
+     * Combined attributes used for TLB lookup, holds the attributes for
+     * the input stage.
      */
     SMMUTransTableInfo tt_combined;
 
-    if (cfg->stage == SMMU_STAGE_1) {
+    if (cfg->stage == SMMU_STAGE_2) {
+        /* Stage2. */
+        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
+        tt_combined.tsz = cfg->s2cfg.tsz;
+    } else {
         /* Select stage1 translation table. */
         tt = select_tt(cfg, addr);
         if (!tt) {
@@ -590,22 +625,9 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
         }
         tt_combined.granule_sz = tt->granule_sz;
         tt_combined.tsz = tt->tsz;
-
-    } else {
-        /* Stage2. */
-        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
-        tt_combined.tsz = cfg->s2cfg.tsz;
     }
 
-    /*
-     * TLB lookup looks for granule and input size for a translation stage,
-     * as only one stage is supported right now, choose the right values
-     * from the configuration.
-     */
-    page_mask = (1ULL << tt_combined.granule_sz) - 1;
-    aligned_addr = addr & ~page_mask;
-
-    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr);
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             info->type = SMMU_PTW_ERR_PERMISSION;
@@ -616,7 +638,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
     }
 
     cached_entry = g_new0(SMMUTLBEntry, 1);
-    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
+    status = smmu_ptw(cfg, addr, flag, cached_entry, info);
     if (status) {
             g_free(cached_entry);
             return NULL;
-- 
2.34.1


