Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DD2C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR47-0001Yf-1I; Thu, 18 Jul 2024 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3q-0008NM-UQ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3o-0004VW-JN
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so2146005e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308839; x=1721913639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4YsbRAcT7lsG9lpifKyGsg4DpvurXs++XIcvW/WT4VE=;
 b=e7kniiFF0YxsDIRtdbc5fI58HmBgQe1uHLjWHj9xUg7D/HTVXQkHfikP/IVClxaGnh
 2o96e1lVujRvKBmP9RlO5N2DGo/uyBkrZb6o5V08LRH6wup93+CA/xL+v/g+moF7j73E
 bWq7mCe9I/bWwPUwDpUeSPLvR4h068125X6HA1E+Z3nsciWfk3FKjTrM/k4jJ48vLB0p
 SU9PjWmvTKYIU+FsgcJOfEjRKeb22p5a/hI0znPaaJTxV/10xBh2HZCNAXemIqOdqHJq
 WtxdL3zNLLpOeZ7gWX3RYmTMxwDLlVBYYykk7aIeteNwbLbLr5aPR3uf5vxdPthkDat2
 tMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308839; x=1721913639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YsbRAcT7lsG9lpifKyGsg4DpvurXs++XIcvW/WT4VE=;
 b=j06HytmQ3sR2a1QjnnbQBCieSYeZqFVdtdLLxMAM0snQxxTXDYpc5DbwvbT4NqIGq+
 BnNdOZYanOGjv32lf/VyVNwl9MltJR+NAmZOCl0HYhvIbKThXCUI4qMpX2kWrBP/hiVE
 pKdhErdAVzZgfw5YMErwutNjEl3XJZA5KNCUCI1dUQFL31iKiVT7p92w74VUIOZki3N4
 7p52LcDmf3nlI+axMq+14jfV2U4EQsJ9YcucUV2eFZY3BO1FOdg0k/K2qgHKon8lNQnO
 3ALvYF2Im7NZXE4g5U66XoLokzwUe0n672NxEx/I732CL1CaMz9xeiV5Qv7G1utyGhnR
 DPRg==
X-Gm-Message-State: AOJu0Yz1PSV3KRZzW+LAUCnJG35eoXvsG+xR4ujkKbYzlsJibfEhkHeg
 kYQN/8DAjs+99APnoMtC5BnTlObC2zfk6wQREZEjtUuQhxOSx5hwPF/xuG4RJuKJPfJIyO3XZxv
 P
X-Google-Smtp-Source: AGHT+IELByD129jrn92+nEn/guWZSL3W7OQj9S94rUKJUXUeSDMjQN1u4yns51cYXRWvmQ8BRbYIHw==
X-Received: by 2002:a05:600c:4e88:b0:424:8be4:f2c with SMTP id
 5b1f17b1804b1-427d2b35b6amr6643885e9.2.1721308839117; 
 Thu, 18 Jul 2024 06:20:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/26] hw/arm/smmuv3: Support nested SMMUs in
 smmuv3_notify_iova()
Date: Thu, 18 Jul 2024 14:20:20 +0100
Message-Id: <20240718132028.697927-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
SMMU instances we consider the input address as the IOVA, but when
nesting is used, we can't mix stage-1 and stage-2 addresses, so for
nesting only stage-1 is considered the IOVA and would be notified.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20240715084519.1189624-16-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c     | 39 +++++++++++++++++++++++++--------------
 hw/arm/trace-events |  2 +-
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index b05f2ab929b..a3cb30501e6 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1096,27 +1096,38 @@ epilogue:
  * @iova: iova
  * @tg: translation granule (if communicated through range invalidation)
  * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
+ * @stage: Which stage(1 or 2) is used
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages)
+                               uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
+    SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
+    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
     IOMMUTLBEvent event;
     uint8_t granule;
-    SMMUv3State *s = sdev->smmu;
+
+    if (!cfg) {
+        return;
+    }
+
+    /*
+     * stage is passed from TLB invalidation commands which can be either
+     * stage-1 or stage-2.
+     * However, IOMMUTLBEvent only understands IOVA, for stage-1 or stage-2
+     * SMMU instances we consider the input address as the IOVA, but when
+     * nesting is used, we can't mix stage-1 and stage-2 addresses, so for
+     * nesting only stage-1 is considered the IOVA and would be notified.
+     */
+    if ((stage == SMMU_STAGE_2) && (cfg->stage == SMMU_NESTED))
+        return;
 
     if (!tg) {
-        SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
-        SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
         SMMUTransTableInfo *tt;
 
-        if (!cfg) {
-            return;
-        }
-
         if (asid >= 0 && cfg->asid != asid) {
             return;
         }
@@ -1125,7 +1136,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
             return;
         }
 
-        if (STAGE1_SUPPORTED(s)) {
+        if (stage == SMMU_STAGE_1) {
             tt = select_tt(cfg, iova);
             if (!tt) {
                 return;
@@ -1151,7 +1162,7 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages)
+                                      uint64_t num_pages, int stage)
 {
     SMMUDevice *sdev;
 
@@ -1160,10 +1171,10 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
         IOMMUNotifier *n;
 
         trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
-                                        iova, tg, num_pages);
+                                        iova, tg, num_pages, stage);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
+            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
         }
     }
 }
@@ -1194,7 +1205,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         } else {
@@ -1217,7 +1228,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
                                  ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         } else {
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 593cc571da7..be6c8f720bc 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,7 +55,7 @@ smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, int asid, int vmid, uint64_t iova, uint8_t tg, uint64_t num_pages, int stage) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" stage=%d"
 
 # strongarm.c
 strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
-- 
2.34.1


