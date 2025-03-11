Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F773C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzCa-0001hJ-Na; Tue, 11 Mar 2025 08:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCR-0001Uk-CJ; Tue, 11 Mar 2025 08:59:12 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCO-0007tn-0F; Tue, 11 Mar 2025 08:59:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fee05829edso10575715a91.3; 
 Tue, 11 Mar 2025 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697946; x=1742302746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXU+U1l4Fd7SyqGLYuKX8zb67TDEGdub9abcDAe/vP8=;
 b=QjiRjuqa/W5PvadWA3sC4hvk5+4d9XVbi/eaGhr/2VuH7Zq9eVfl5MUtCg49TVeIcq
 wE1VWcKBAGlt/lIBQzy/K3+qObJJGdCbkrV1YwnIoX9neuiSWLObeN42gikQIy2kYWam
 NRLrJcQmtRiq895kFbDiydnrpWt+bOKQ6DB9WELVHNwP5lG2au6hNvmBlqiZQiOBkznI
 xTpnnjh/p+kh7ODxERFU6vUq3K2fYFwwwrIX9xJJdJ+fTxxUeQek77NDWA4d8rcLJk86
 GQOjLq9wLTG66twik+CtwEBFOPh6Hcw1OulWNBH6YKLBRvgFPfsPTd20g8scPqstq55F
 PNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697946; x=1742302746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXU+U1l4Fd7SyqGLYuKX8zb67TDEGdub9abcDAe/vP8=;
 b=fxcxdxKm4zM5zDTkRF9eE26kp2YFC12GQ0KCLjgYlh81e4KM0vmTaIy2o5/sirTmA0
 g0jMZsvR3jqrIN1+WpASQVTZ44mybKxU6ysd1u3KPRmyfnHfyo/6RZsoOSvYBchoG9QM
 dUaAz3hKyC19XAk/AIHVhLXCLAXsELzeoNmmbH4x3xmtF2rJjmW03SNWonVWmS/WAVBy
 V/Iiq4JcfoemqB9wWudfKU5GNss6apNBdq/UlkAe+yn2B1/AECJaNqKhyzgbOHOI6B8R
 TcZ/KYAVbimoujFZ7LQuXT5DYy2YtA4fewLjnrWmz423IIy+CWamgWKpIws4afK8k+R+
 j5YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfeHw9/5VCkMdToD2OIRB/XBQp77NIP9rne8P6gIITtdHH09CYSpY1/d76ra863YGlct75f0fxQ==@nongnu.org
X-Gm-Message-State: AOJu0YxDQ0L+hn6tO1Xo7xyLVsybRm2B4I6lTP8ezzFSi1IQbC9CIUgY
 kDQg/+gTsg5O11ZFjUIB96tp986SGWu5BDtELEvxjM27YV4pietKMmX3Qw==
X-Gm-Gg: ASbGnctmliHyU6iAyhW1CIMIK4uV0GoTt8QyAgRN/rpgDisYnuh91BH6QXJYh0juZee
 IWuPHXBg+mVG1nvk0tkH4bWp+hEj00GSbkMM+d9Kle1ZB1n/j2z4aRwbn0fOjWDFiEXFT1wbCCS
 wrxNIewb4O2eRQkAYGYetN/w7MieGxN+ol/bZ89yk/0yIhuyu79MAlbCnXDlktzR1lfmspDKPhv
 Lxq3QN/WlBsGLQueoj4jqsvhZKswiC5YLp04fLhUYWpm+/ei0xwPm9Dmb3/ZMnkfIBUCiWAVBcq
 atIoROxYus+1BHtH3ucBMZFgA7xNgks5M+foaitMklb+7NQ5hms=
X-Google-Smtp-Source: AGHT+IG3+xr/2h+PWYIuYl/EieLYhOiHlZl8JyOV3SJZdQfC/ZcRMjL0XcvzQu4nL2m4ia/sIHtmug==
X-Received: by 2002:a17:90b:1648:b0:2f9:9ddd:68b9 with SMTP id
 98e67ed59e1d1-2ff7cefbc6dmr23162307a91.26.1741697945564; 
 Tue, 11 Mar 2025 05:59:05 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 10/72] ppc/pnv/homer: class-based base and size
Date: Tue, 11 Mar 2025 22:57:04 +1000
Message-ID: <20250311125815.903177-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Put HOMER memory region base and size into the class, to allow more
code-reuse between different machines in later changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_homer.c         | 46 +++++++++++++++++++++++++++-----------
 include/hw/ppc/pnv.h       |  6 ++---
 include/hw/ppc/pnv_homer.h |  7 +++++-
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 75b0ee7964..67a1fd77ba 100644
--- a/hw/ppc/pnv_homer.c
+++ b/hw/ppc/pnv_homer.c
@@ -138,16 +138,16 @@ static uint64_t pnv_homer_power8_pba_read(void *opaque, hwaddr addr,
                                           unsigned size)
 {
     PnvHomer *homer = PNV_HOMER(opaque);
-    PnvChip *chip = homer->chip;
+    PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
     uint32_t reg = addr >> 3;
     uint64_t val = 0;
 
     switch (reg) {
     case PBA_BAR0:
-        val = PNV_HOMER_BASE(chip);
+        val = homer->base;
         break;
     case PBA_BARMASK0: /* P8 homer region mask */
-        val = (PNV_HOMER_SIZE - 1) & 0x300000;
+        val = (hmrc->size - 1) & 0x300000;
         break;
     case PBA_BAR3: /* P8 occ common area */
         val = PNV_OCC_COMMON_AREA_BASE;
@@ -179,13 +179,19 @@ static const MemoryRegionOps pnv_homer_power8_pba_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static hwaddr pnv_homer_power8_get_base(PnvChip *chip)
+{
+    return PNV_HOMER_BASE(chip);
+}
+
 static void pnv_homer_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
 
+    homer->get_base = pnv_homer_power8_get_base;
+    homer->size = PNV_HOMER_SIZE;
     homer->pba_size = PNV_XSCOM_PBA_SIZE;
     homer->pba_ops = &pnv_homer_power8_pba_ops;
-    homer->homer_size = PNV_HOMER_SIZE;
     homer->homer_ops = &pnv_power8_homer_ops;
     homer->core_max_base = PNV8_CORE_MAX_BASE;
 }
@@ -291,16 +297,16 @@ static uint64_t pnv_homer_power9_pba_read(void *opaque, hwaddr addr,
                                           unsigned size)
 {
     PnvHomer *homer = PNV_HOMER(opaque);
-    PnvChip *chip = homer->chip;
+    PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
     uint32_t reg = addr >> 3;
     uint64_t val = 0;
 
     switch (reg) {
     case PBA_BAR0:
-        val = PNV9_HOMER_BASE(chip);
+        val = homer->base;
         break;
     case PBA_BARMASK0: /* P9 homer region mask */
-        val = (PNV9_HOMER_SIZE - 1) & 0x300000;
+        val = (hmrc->size - 1) & 0x300000;
         break;
     case PBA_BAR2: /* P9 occ common area */
         val = PNV9_OCC_COMMON_AREA_BASE;
@@ -332,13 +338,19 @@ static const MemoryRegionOps pnv_homer_power9_pba_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static hwaddr pnv_homer_power9_get_base(PnvChip *chip)
+{
+    return PNV9_HOMER_BASE(chip);
+}
+
 static void pnv_homer_power9_class_init(ObjectClass *klass, void *data)
 {
     PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
 
+    homer->get_base = pnv_homer_power9_get_base;
+    homer->size = PNV_HOMER_SIZE;
     homer->pba_size = PNV9_XSCOM_PBA_SIZE;
     homer->pba_ops = &pnv_homer_power9_pba_ops;
-    homer->homer_size = PNV9_HOMER_SIZE;
     homer->homer_ops = &pnv_power9_homer_ops;
     homer->core_max_base = PNV9_CORE_MAX_BASE;
 }
@@ -354,16 +366,16 @@ static uint64_t pnv_homer_power10_pba_read(void *opaque, hwaddr addr,
                                           unsigned size)
 {
     PnvHomer *homer = PNV_HOMER(opaque);
-    PnvChip *chip = homer->chip;
+    PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
     uint32_t reg = addr >> 3;
     uint64_t val = 0;
 
     switch (reg) {
     case PBA_BAR0:
-        val = PNV10_HOMER_BASE(chip);
+        val = homer->base;
         break;
     case PBA_BARMASK0: /* P10 homer region mask */
-        val = (PNV10_HOMER_SIZE - 1) & 0x300000;
+        val = (hmrc->size - 1) & 0x300000;
         break;
     case PBA_BAR2: /* P10 occ common area */
         val = PNV10_OCC_COMMON_AREA_BASE;
@@ -395,13 +407,19 @@ static const MemoryRegionOps pnv_homer_power10_pba_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static hwaddr pnv_homer_power10_get_base(PnvChip *chip)
+{
+    return PNV10_HOMER_BASE(chip);
+}
+
 static void pnv_homer_power10_class_init(ObjectClass *klass, void *data)
 {
     PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
 
+    homer->get_base = pnv_homer_power10_get_base;
+    homer->size = PNV_HOMER_SIZE;
     homer->pba_size = PNV10_XSCOM_PBA_SIZE;
     homer->pba_ops = &pnv_homer_power10_pba_ops;
-    homer->homer_size = PNV10_HOMER_SIZE;
     homer->homer_ops = &pnv_power9_homer_ops; /* TODO */
     homer->core_max_base = PNV9_CORE_MAX_BASE;
 }
@@ -424,9 +442,11 @@ static void pnv_homer_realize(DeviceState *dev, Error **errp)
                           homer, "xscom-pba", hmrc->pba_size);
 
     /* homer region */
+    homer->base = hmrc->get_base(homer->chip);
+
     memory_region_init_io(&homer->regs, OBJECT(dev),
                           hmrc->homer_ops, homer, "homer-main-memory",
-                          hmrc->homer_size);
+                          hmrc->size);
 }
 
 static const Property pnv_homer_properties[] = {
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fcb6699150..d8fca079f2 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -205,9 +205,8 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 #define PNV9_OCC_SENSOR_BASE(chip)   (PNV9_OCC_COMMON_AREA_BASE +       \
     PNV_OCC_SENSOR_DATA_BLOCK_BASE((chip)->chip_id))
 
-#define PNV9_HOMER_SIZE              0x0000000000400000ull
 #define PNV9_HOMER_BASE(chip)                                           \
-    (0x203ffd800000ull + ((uint64_t)(chip)->chip_id) * PNV9_HOMER_SIZE)
+    (0x203ffd800000ull + ((uint64_t)(chip)->chip_id) * PNV_HOMER_SIZE)
 
 /*
  * POWER10 MMIO base addresses - 16TB stride per chip
@@ -250,8 +249,7 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
 #define PNV10_OCC_SENSOR_BASE(chip) (PNV10_OCC_COMMON_AREA_BASE +       \
     PNV_OCC_SENSOR_DATA_BLOCK_BASE((chip)->chip_id))
 
-#define PNV10_HOMER_SIZE              0x0000000000400000ull
 #define PNV10_HOMER_BASE(chip)                                           \
-    (0x300ffd800000ll + ((uint64_t)(chip)->chip_id) * PNV10_HOMER_SIZE)
+    (0x300ffd800000ll + ((uint64_t)(chip)->chip_id) * PNV_HOMER_SIZE)
 
 #endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
index b1c5d498dc..5ffc0c97af 100644
--- a/include/hw/ppc/pnv_homer.h
+++ b/include/hw/ppc/pnv_homer.h
@@ -42,15 +42,20 @@ struct PnvHomer {
     PnvChip *chip;
     MemoryRegion pba_regs;
     MemoryRegion regs;
+    hwaddr base;
 };
 
 
 struct PnvHomerClass {
     DeviceClass parent_class;
 
+    /* Get base address of HOMER memory */
+    hwaddr (*get_base)(PnvChip *chip);
+    /* Size of HOMER memory */
+    int size;
+
     int pba_size;
     const MemoryRegionOps *pba_ops;
-    int homer_size;
     const MemoryRegionOps *homer_ops;
 
     hwaddr core_max_base;
-- 
2.47.1


