Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F2CC02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFP-0004np-1w; Fri, 31 Jan 2025 16:08:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyF7-00048M-Hz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:06 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyF4-00080s-UT
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:00 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso24333965e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357676; x=1738962476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ImZMvGufHt1OFcfLj4pxtfCxmfTe94MlGR4mQFWK8lU=;
 b=R+rFUSiS8D60LaiJTjtzJ04NYWs+rKs449oH7up3fx9Wr7YwIRlpB9P3pQLuprHOT0
 bYpY0BZj5DEJHwnGiRLNsFk8VyVOzIEkvEjd8EbRaN6V3/c29yJNO9Ii2BdPR3EIBa+2
 wbzTuOAiR73w4nrl72lMBg1lDv/Potqf4AuAIHHY/EKzGjH0tFr+YUirjYq3HgRsAaW0
 m9WqJRUmorDjK6fxksgn9lJRA5TZ2+YonwY7115p0NlxwSKFNZt6UHWNI7yEygxF2IZX
 2Fel5QnVkblhhCIMvJPjMX9l+9smme0iCq+H08Cw44Qrclv+jwd/J5orzMwrWtwii8AX
 xeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357676; x=1738962476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ImZMvGufHt1OFcfLj4pxtfCxmfTe94MlGR4mQFWK8lU=;
 b=k/e9ejuZQcOUAkBLe45WrF+M/DmjHnlmY+BJZQMW311SlsY9o0i9KdWKkhw8QE4pzY
 Fc77L3ec0jRzDe/TUj3fo/7MEnBlFOJIQZQDCKzA+JTPXBZh9xLg+K1wrLwUEEL+BmT1
 teJ9cggwRNKA1/OehVEYkjXMjUn4aGTXCTtLmAqxu4qrw2dBxgpaZCDYCssfHSO6PBH6
 dMkDPnyJb0alHNeBNvxyAV24BJHrmtY9wiSzMPKte1m6dKx8xFru8rYiIwPr71x4VtVW
 L42CfrJPWJvkAZQyyCeAqn/WERW1zKjrM4fRQq6WaRXcg9p2EmBenUKNuvZaxh3BNkCv
 cDvA==
X-Gm-Message-State: AOJu0Yyi+2TVtgh31+kfynh0SMhL0AIyR8QSH1NSvjlbIjEwHKY+XlJ8
 03K8JsbnXiIWQQYCWPB9IQK9dE1MhSmp9zmbFHtmdo6Y4Y4GjHTaoyAo+sEXCBnm05ziq9TOOJ/
 TD0k=
X-Gm-Gg: ASbGncuqdGOvlCByU/Rtvw1LDMAGtzcN+89AXUPpqAbIlrFU4oMsiAY9fdmP3x7W1sG
 phF7g9nYaAThJJfdORHymnlh2znYiwCILlEketpYHAwlzBLF2CTMsoMXwne2I8mnhakaHPxeZkI
 4+jUWPQQwpV8aoyeLp287QqFtTXvisc3cIcI55lRvWWgPOeIN6+M9udwf2EPYYiSDmK+6pPSxMJ
 dUzZCEI05U8zRNn17j64lgErA3bec5NNZ98iFWM95Wgvmfc3puUgFHg4Pds05+8YZ1vhsdpTPy+
 ZCWq8cuoO0jK3byzWlwlzjLgjS3UuS5Osf5sJ2nK1zNJYNguEklTk5KnWCmw8oJxLg==
X-Google-Smtp-Source: AGHT+IGdUHYaDWFrfnOOd4zf4m+e9ESf7CLSwBOZnYQrKngEIyuM3dMh+9EHzFuRdNY5Hv8iCHe1yA==
X-Received: by 2002:a05:600c:4e0c:b0:434:a386:6cf with SMTP id
 5b1f17b1804b1-438dc3a8faemr119137725e9.2.1738357675828; 
 Fri, 31 Jan 2025 13:07:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc27130sm101411555e9.16.2025.01.31.13.07.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/36] hw/arm/omap1: Inline creation of MMC
Date: Fri, 31 Jan 2025 22:05:14 +0100
Message-ID: <20250131210520.85874-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

Our style for other conversions of OMAP devices to qdev has been to
inline the creation and wiring into omap310_mpu_init() -- see for
instance the handling of omap-intc, omap-gpio and omap_i2c. Do
the same for omap-mmc.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-7-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index c6b8cf65d71..a8b541ca788 100644
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
2.47.1


