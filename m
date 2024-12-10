Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBF1E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYm-0008Ua-BC; Mon, 09 Dec 2024 22:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYl-0008Ta-5D; Mon, 09 Dec 2024 22:05:15 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYj-0003EG-1h; Mon, 09 Dec 2024 22:05:14 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2165cb60719so11469845ad.0; 
 Mon, 09 Dec 2024 19:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799911; x=1734404711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SXeo0T15xGhbH/tW5TyIBvX/rJyxFYWpC55x0Kt0to=;
 b=JDPENUgxK8eRI0MBzG+zywMu8n7Vrs/ALNNWS1ItIfTk6jNzJMrb1AsM9YKqhD3w3k
 fS7XMtk3/bDIcww3+zX7IFTVIwvmEBcsNmwp5i5f8Usbx7rgjiXrpe77BzhIfatPtPUq
 SwurcTztT8piCOXKiuZe4y96R5Lt4E8R3m84DyXAvZ3Ie/w4+UyuyAwXeSBy1F2T9duU
 fwS0KMsQLPmXitVzr9r2ZVGo11/FqFq1bLqiWMZMpcsnpQG9+qq7MI2wI+iApWuzRIaC
 f9GpEgTItRQDf87372F6J8YwnbtN53yT5E7PkHs5Knc3dUlOAt/88rPrRA4IqrM+eqYo
 Il7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799911; x=1734404711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0SXeo0T15xGhbH/tW5TyIBvX/rJyxFYWpC55x0Kt0to=;
 b=a/yPOm6DOmpiP6SPdOXGAXnB6cxw9THDa394abOjjG8/NGILGmGqZhkRnk8E8g8jcf
 5TVFy009Ub34wt4a+Lly0jmDfz60SHwMFUFGldcOwp/sRn/kPlpHxJt7IfzOmGjxM0ov
 bt3G3s0lqo5JEPjxHHR3rKtWsFHjLy16jau7u1UFhe9MFmvcFxbEIJgl+UGNbgT255Qt
 UkDDLgk0OiCDgGDWmetkM0OtLN9/Vjd107MUm1XXMW/Im6jioxIvQqdI9rhOWDOrzF20
 xo5q15yulNvBqy9UQvIrim/81y/Wr9Df3AX4m7TZyJpxj0uuDvvRw+KXt8lz8NA52AW7
 x4XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1P4hn4DYQdK0/BbH3EZnF66oZecixgLruNR9CcTV17lZz9seoRSoqQ4ZLwCsep4sBJCSYdmqCleUJ@nongnu.org
X-Gm-Message-State: AOJu0YxLGRyj6nSkEyq+lcn8qTlTGBkg4yzyhxIiypz8v0e0kwz3RaUs
 5tbyt/gZMl5fW+qk1ati/94shmH8kEHeebsCRfyB3FPUhkzcgaxUA69Sdw==
X-Gm-Gg: ASbGncsMN88KG8yn1DRCFFLBwd5MFFojU4zdndVDQF/O32S/78WmuttOisFxoxukI40
 lHLftuu/y82KWHmfQo+CFs69khaAsX11X4/u0zppVJ6INl+Az/YXn5k1j+e1cGUv3Msi09h3+Op
 ScenPt3/kPCnrzBK64TbG2DK9nlv/OOjnyX5beWXenyZ+OjWIVdq1kHWJAms43uq+Wm9zw+/kVD
 tVzsStLVz9i8rq58UjpG/y6/B98R8iMRv90QpIKHyqnMs17a1QnxdEb/swr
X-Google-Smtp-Source: AGHT+IHlQ7YJD/digxBf1mMYaeJIzndw8vRXxVp9RmFNyoGQ7lPnJkRDQjqWqgWBFZ1TzX0A3QvLgw==
X-Received: by 2002:a17:903:32c1:b0:216:6283:5a8c with SMTP id
 d9443c01a7336-2166a07d5femr37755795ad.39.1733799911102; 
 Mon, 09 Dec 2024 19:05:11 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 4/9] ppc/pnv/homer: class-based base and size
Date: Tue, 10 Dec 2024 13:04:44 +1000
Message-ID: <20241210030451.1306608-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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
 include/hw/ppc/pnv.h       |  6 ++---
 include/hw/ppc/pnv_homer.h |  7 +++++-
 hw/ppc/pnv_homer.c         | 46 +++++++++++++++++++++++++++-----------
 3 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fcb6699150c..d8fca079f2f 100644
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
index b1c5d498dc5..5ffc0c97afe 100644
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
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
index 658b0186a38..fda022adfc3 100644
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
 
 static Property pnv_homer_properties[] = {
-- 
2.45.2


