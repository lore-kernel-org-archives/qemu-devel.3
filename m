Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFE9C02194
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 21:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdyFR-000595-Cp; Fri, 31 Jan 2025 16:08:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyF0-00043a-Ov
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:08:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdyEz-00080c-1t
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 16:07:54 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436341f575fso29196405e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738357671; x=1738962471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jevzQmfhYyewLfy6WntyUbmDu2Xn9SdL2qUs7Y2AXlw=;
 b=AG2dFcQJyvpmc/cGEmqSOh8kYj4IsCpkwowQjoSbb9MXgqBZwwAr/mIVA9w0VGOABd
 1eJIi3SsTUrF7jAgT7NuVWRRXqAsYFFyKWf8qN/qBhthbs2OK6TreFmqvNdMbHr7lUF7
 XGIsBH02AGRnJDxofoxC744GbWb/wQMUdZHECWunWE38dALLO2VWQOcBSdkn/wrqNjsV
 f0TOdj2rSPiqyiBAt8RArFkE0+M962tgg8hhVHyelf/u6nsmQGP2dNZcXq4Pm1bCu4hw
 CN1gbl48WTAtnjIztP4NdUfIV94jSOE6gKgMaQOnpGgO4STVZYxvShnJ1YGyrbZ96443
 saGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738357671; x=1738962471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jevzQmfhYyewLfy6WntyUbmDu2Xn9SdL2qUs7Y2AXlw=;
 b=wQBaXPP9igA3xflmzQ6XH5vZ2AWSDuxGp3jx6VDNtyAFhVzur/WQx6jKwfJ5M4EWmS
 EdXRuykAR9LzqRbNnlPBBBveHfV7P79EPWyE9kaMGuKwyhLYakOClDAe+N9l4/GheBXV
 nVeVt3ap7jtPk/W5IO1PMdoxQh5GvkRn9DIXSP1bgwjjjWHbqLcpxojjzxnuQ0nRJP87
 RQTb8PafpwqrfobPJMUUkcKbQLQBU2CkMg8cp49sSo3IgvQgbyUGllOcZDzsMNVqUeLV
 bN7lsAXefuqVHhOC+A+60SRpuQ//A8Tev8g+yQb7zmF/ePeaQlW8Qy6KzLyF8L0hchZh
 YhbA==
X-Gm-Message-State: AOJu0YxQPzQYTL7DGuJTLgtJAclNAqrs8w41aAI8MJOgj1WVOVaSE5vf
 AqmVv751yItfnT1hcDUS7+KnW8vJ73Egi5PARoM0Iwf05vgz0tSu3ADQaub4IThL5rYVffmxs93
 An4A=
X-Gm-Gg: ASbGnctVlJougkhnH1RK0F9+k0L2xxyPyEeV9jkHSrYljmV6AvBphcRXnG9D3Ty4Omb
 hbygbFr3PqFXHUd5XGC940SHutwlVrjV2X9QbgBiJ1p/1HbPZpeQ5Z5dkaAq4VlSOLlxgdOMGvj
 hLDZYyJJPzJkgpoTVyX3+nZP2aSFJCvV3lfH7thNCRiLrKKYm5+Sng5lT7l03GWPg6XDIeTiYnP
 RER0HgKk6DNf6krahkjf8dgx3DeHFjZ21hS2cP2hgYYcYBLlQ8+d138a/MdL1Y3GwDBChESbO8a
 vaXnhwEzopp+rdDByYY9aQoY7mCoFUDg/icS+h5REkoFJd6E7u50dMdhq1b+ZjXZqQ==
X-Google-Smtp-Source: AGHT+IEk0ehswLHlCiaQeLPChRjj68SToEqjBHwGrk4pW0tyPpNyng4HWDbtl0BAvjiuzZlUFf84Ww==
X-Received: by 2002:a05:600c:5027:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-438dc40d36emr127085665e9.24.1738357671249; 
 Fri, 31 Jan 2025 13:07:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6de7csm103590605e9.32.2025.01.31.13.07.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Jan 2025 13:07:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/36] hw/sd/omap_mmc: Use similar API for "wire up omap_clk"
 to other OMAP devices
Date: Fri, 31 Jan 2025 22:05:13 +0100
Message-ID: <20250131210520.85874-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131210520.85874-1-philmd@linaro.org>
References: <20250131210520.85874-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

The approach we've settled on for handling the omap_clk wiring for
OMAP devices converted to QDev is to have a function omap_foo_set_clk()
whose implementation just sets the field directly in the device's
state struct. (See the "TODO" comment near the top of omap.h.)
Make omap_mmc do the same.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250128104519.3981448-6-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/omap.h | 3 +++
 hw/sd/omap_mmc.c      | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index d20c55a8957..7cb87ea89cd 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -535,6 +535,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(OMAPMMCState, OMAP_MMC)
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
                            qemu_irq irq, qemu_irq dma[], omap_clk clk);
+/* TODO: clock framework (see above) */
+void omap_mmc_set_clk(DeviceState *dev, omap_clk clk);
+
 
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 1bc8290f9d6..c6b8cf65d71 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -583,6 +583,13 @@ static const MemoryRegionOps omap_mmc_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+void omap_mmc_set_clk(DeviceState *dev, omap_clk clk)
+{
+    OMAPMMCState *s = OMAP_MMC(dev);
+
+    s->clk = clk;
+}
+
 DeviceState *omap_mmc_init(hwaddr base,
                            MemoryRegion *sysmem,
                            qemu_irq irq, qemu_irq dma[], omap_clk clk)
@@ -594,7 +601,7 @@ DeviceState *omap_mmc_init(hwaddr base,
     s = OMAP_MMC(dev);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
-    s->clk = clk;
+    omap_mmc_set_clk(dev, clk);
 
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(s), 0));
-- 
2.47.1


