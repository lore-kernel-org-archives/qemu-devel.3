Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED394C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcj6Y-0001I3-VW; Tue, 28 Jan 2025 05:46:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj65-0001A7-Tn
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcj61-0003Y9-Tl
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:45:32 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436341f575fso59928975e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061128; x=1738665928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CvEPXzfVhE9gpoEHv/zIext3ELuNXpVwzWWv2pS9vE=;
 b=Zgtsjtsr/LvvOK/IrZPzcg/OPl7/knd3l8j7vjrc5aCMeVqqYL1YImY2a0hynIgCLn
 CDnRgqFDy7V+haGw9vvN5MRSvdrJBwzapUniorUZnG1dPdnzPqyWIsfJ5qsO8W9cILAB
 KXmuUdPlllurqUlbT1Iv5jWd2L2Y6ssUW8cuNaz6zcWegdDHQ3EbCFj3F2fZ50xim8qD
 dvJMsyZMMuoe7fyl8Id05DuYgpBoIP7e6t16udad+AzmDoIgYl8BdVp0k027BIF/eAJb
 PyRAfgta8C+UEWlVOiI06CrouCGhxKfsS+71cPCb4TyuOwkk1wsFsOimu3uZG1a1d6DZ
 VT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061128; x=1738665928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CvEPXzfVhE9gpoEHv/zIext3ELuNXpVwzWWv2pS9vE=;
 b=VwwRP3AyoBkCr9o6AN3J0y2BgXBq+j2qJ6LRwZka2e23AnC3uGQeVtsDLvtwp/SQb5
 c0hGAeH6ZsoESwj8Vok2zE0rQflEWY9hgoa00n2qNcXv8X6Ywst2sjr6jEH7aEP3yw0u
 OgcNw7/TwSKqCXz/cqX/HxtjscN4ansq6pHdhLu+HlO+LXGopwhrUPm57J90e6ibX/yC
 HYMSNxV20xUVsVWbszes8hfmpmJIHhTncJ1oGBCAxXhem0F5Ci/snkdAHhFaJtD8rvfj
 M3/0ICe/yqoPc7HsdHCoZ0TnGWShV1fWYiV+DLoOZBD2nJCftpzrKTxoSJ70yKKa1uKQ
 ELnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6vxSh2UJNx+Fy35D6f9Vi4k0Ko/+kBiRjmBKy/ZhZ+VdjLGB6kuKM5FhBUbHVCUW3TQ9hJdMUqrV/@nongnu.org
X-Gm-Message-State: AOJu0YzU/5YUI6E0gs3jnYUK+2WYqgN2HuQPpvZqjH3E+uWBuuvskGo2
 N00ZX9tWkybpm/2MtU9fktEV23oX9Oq6AxSvbjU0GUOQM494ucPVxbdZ7GpWWb4=
X-Gm-Gg: ASbGncsJVNvHW4fmFZ6Iln+pqNdnQUVYf0lEe/SIbCRmym8rbafl3/aNmLcV4vKaEei
 7peDdg4pF3NFJmWgXh3UD/xAiUvAAi5Abcd2n5Vf8wd8xAxilxoz5EyxN/ykIneyE7RT2OMXTbU
 xrK/GXuea6i0UyORPzMA6nbfuGMgQ/TE9zoSn876c1JX1/4bU7jOv54N4aDFMXu0qQyhh5+SOc0
 QsQhLVBy8mOHjvtHOMZL/LKW7qwAanTYfYgg4MHE3m8bmIBWJHibSPGTJayQCvvyo9Ty/8RF++3
 SomrJb+opHoxWaXu0s1S
X-Google-Smtp-Source: AGHT+IFHKm8LWijzuhpAkrJkJO72SMaHhVd2ZledEOuVmn8ZEefLtGzCTBQcYOD9rG8FlpSoQ019gQ==
X-Received: by 2002:a5d:64ec:0:b0:385:f66a:4271 with SMTP id
 ffacd0b85a97d-38bf5649632mr37686789f8f.4.1738061128079; 
 Tue, 28 Jan 2025 02:45:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c418esm13920133f8f.95.2025.01.28.02.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:45:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 06/11] hw/arm/omap1: Inline creation of MMC
Date: Tue, 28 Jan 2025 10:45:14 +0000
Message-Id: <20250128104519.3981448-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128104519.3981448-1-peter.maydell@linaro.org>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Our style for other conversions of OMAP devices to qdev has been to
inline the creation and wiring into omap310_mpu_init() -- see for
instance the handling of omap-intc, omap-gpio and omap_i2c. Do
the same for omap-mmc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c   | 15 +++++++++++----
 hw/sd/omap_mmc.c | 22 ----------------------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 15ba0a0d0c4..ca2eb0d1576 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -3981,10 +3981,17 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     if (!dinfo && !qtest_enabled()) {
         warn_report("missing SecureDigital device");
     }
-    s->mmc = omap_mmc_init(0xfffb7800, system_memory,
-                           qdev_get_gpio_in(s->ih[1], OMAP_INT_OQN),
-                           &s->drq[OMAP_DMA_MMC_TX],
-                    omap_findclk(s, "mmc_ck"));
+
+    s->mmc = qdev_new(TYPE_OMAP_MMC);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->mmc), &error_fatal);
+    omap_mmc_set_clk(s->mmc, omap_findclk(s, "mmc_ck"));
+
+    memory_region_add_subregion(system_memory, 0xfffb7800,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(s->mmc), 0));
+    qdev_connect_gpio_out_named(s->mmc, "dma-tx", 0, s->drq[OMAP_DMA_MMC_TX]);
+    qdev_connect_gpio_out_named(s->mmc, "dma-rx", 0, s->drq[OMAP_DMA_MMC_RX]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(s->mmc), 0,
+                       qdev_get_gpio_in(s->ih[1], OMAP_INT_OQN));
 
     if (dinfo) {
         DeviceState *card = qdev_new(TYPE_SD_CARD);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index fcec2899afb..dacbea13aad 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -590,28 +590,6 @@ void omap_mmc_set_clk(DeviceState *dev, omap_clk clk)
     s->clk = clk;
 }
 
-DeviceState *omap_mmc_init(hwaddr base,
-                           MemoryRegion *sysmem,
-                           qemu_irq irq, qemu_irq dma[], omap_clk clk)
-{
-    DeviceState *dev;
-    OMAPMMCState *s;
-
-    dev = qdev_new(TYPE_OMAP_MMC);
-    s = OMAP_MMC(dev);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
-
-    omap_mmc_set_clk(dev, clk);
-
-    memory_region_add_subregion(sysmem, base,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(s), 0));
-    qdev_connect_gpio_out_named(dev, "dma-tx", 0, dma[0]);
-    qdev_connect_gpio_out_named(dev, "dma-rx", 0, dma[1]);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
-
-    return dev;
-}
-
 static void omap_mmc_reset_hold(Object *obj, ResetType type)
 {
     OMAPMMCState *s = OMAP_MMC(obj);
-- 
2.34.1


