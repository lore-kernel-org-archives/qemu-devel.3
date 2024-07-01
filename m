Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC07CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJZd-0001gd-EY; Mon, 01 Jul 2024 12:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ7-0000iS-Nf
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZ0-0005Pp-G1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-424ad991cbbso25269065e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850053; x=1720454853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=77qm/ulkxZX7SdkResvcWiVey4AydnKET0AsgP+gR9E=;
 b=U/MHIEN3AOx+nkDaE6JVfhhsekgDj116goIDrZ/xwbI+y+OreJig84+rdIzq6HrdnS
 g6JmEBOUiRdUodHdcGmBYr8UxYGuaW4BBoOS3C5+uYSEXJ8ciPtKVvdNI1Z2qYb0yr5S
 d1uiKdGHxGSVW0BgQjpKOaLgutVxo512jXGJNMHYc2aLp1ZI1A5QmmhfKg77CtSDioEB
 T0e+aLtwpM84bAZ+pkD2hMWCzC6DCgRd/6e3nyJpRFlH+abyikkrmeHijrEQhNx9J5Pm
 aP1TndkbJPv3b++Wb2Y7B/CjPfzpCFmERhTjNvBCOSK9bcgGEkUvLpcn9dRxXWaDnoMf
 8szA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850053; x=1720454853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=77qm/ulkxZX7SdkResvcWiVey4AydnKET0AsgP+gR9E=;
 b=DTON1hxBJXwIAVHfbHtc2bqiTsbb/85IFpJXwzYXX2KA/j7fba6ITqxIpaUIKPuMMW
 tRfsS4yMwIEMkLD08cdob6N9LgsbOcwx+PrV5M26BSUh02gPtNAiM4uQc7LpGjv06YOq
 PqQGGLGNhd5hCLQnXcZGLu42BEkjAhDFlgO1IDA8mk1fE+Ab2WRn0V080YECK8Cvsgea
 evzr3Rsh0snX4hdfcCCSD6JEunucwJqGpoquJf82RMS5JQP8/NAKMAnYfwjp31FWdPbp
 4x60aBvFZsLTiWAAdhkhFLfMQpJgw5eqdzcfIh0ABcPrRrBrGzhQVAlgBDS3k0WYjzkN
 /uRA==
X-Gm-Message-State: AOJu0Yxq+EjFwgvlNWbHj4ErOL7H45CMV/IdbUE4kRL4O7wABVxeENmZ
 5OD09jwYvYOCgT6EyThUI2OiiM+yHZXS3Wmi4hbOzv+mruWqEaa4JpmkqS8GqcyUO/DVIr8gxfp
 csoM=
X-Google-Smtp-Source: AGHT+IEOrYWG0pEry5wyrvkKZXlYk9Nn4DdLLM8VlEltvgMastqxyFRIAap4fKRv54d+kBholOjLww==
X-Received: by 2002:a05:600c:1d1a:b0:424:a578:fc1 with SMTP id
 5b1f17b1804b1-4257a05c0a3mr39768355e9.25.1719850053094; 
 Mon, 01 Jul 2024 09:07:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/29] hw/arm/smmu-common: Replace smmu_iommu_mr with
 smmu_find_sdev
Date: Mon,  1 Jul 2024 17:07:06 +0100
Message-Id: <20240701160729.1910763-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Nicolin Chen <nicolinc@nvidia.com>

The caller of smmu_iommu_mr wants to get sdev for smmuv3_flush_config().

Do it directly instead of bridging with an iommu mr pointer.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Message-id: 20240619002218.926674-1-nicolinc@nvidia.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  4 ++--
 hw/arm/smmu-common.c         |  8 ++------
 hw/arm/smmuv3.c              | 12 ++++--------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 5ec2e6c1a43..687b7ca132d 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -182,8 +182,8 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
  */
 SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova);
 
-/* Return the iommu mr associated to @sid, or NULL if none */
-IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
+/* Return the SMMUDevice associated to @sid, or NULL if none */
+SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid);
 
 #define SMMU_IOTLB_MAX_SIZE 256
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 1ce706bf94b..b6601cc102e 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -620,20 +620,16 @@ static const PCIIOMMUOps smmu_ops = {
     .get_address_space = smmu_find_add_as,
 };
 
-IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid)
+SMMUDevice *smmu_find_sdev(SMMUState *s, uint32_t sid)
 {
     uint8_t bus_n, devfn;
     SMMUPciBus *smmu_bus;
-    SMMUDevice *smmu;
 
     bus_n = PCI_BUS_NUM(sid);
     smmu_bus = smmu_find_smmu_pcibus(s, bus_n);
     if (smmu_bus) {
         devfn = SMMU_PCI_DEVFN(sid);
-        smmu = smmu_bus->pbdev[devfn];
-        if (smmu) {
-            return &smmu->iommu;
-        }
+        return smmu_bus->pbdev[devfn];
     }
     return NULL;
 }
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 2d1e0d55ec2..445e04ddf7c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1218,20 +1218,18 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_STE:
         {
             uint32_t sid = CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
+            SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
-            if (!mr) {
+            if (!sdev) {
                 break;
             }
 
             trace_smmuv3_cmdq_cfgi_ste(sid);
-            sdev = container_of(mr, SMMUDevice, iommu);
             smmuv3_flush_config(sdev);
 
             break;
@@ -1260,20 +1258,18 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_CFGI_CD_ALL:
         {
             uint32_t sid = CMD_SID(&cmd);
-            IOMMUMemoryRegion *mr = smmu_iommu_mr(bs, sid);
-            SMMUDevice *sdev;
+            SMMUDevice *sdev = smmu_find_sdev(bs, sid);
 
             if (CMD_SSEC(&cmd)) {
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
 
-            if (!mr) {
+            if (!sdev) {
                 break;
             }
 
             trace_smmuv3_cmdq_cfgi_cd(sid);
-            sdev = container_of(mr, SMMUDevice, iommu);
             smmuv3_flush_config(sdev);
             break;
         }
-- 
2.34.1


