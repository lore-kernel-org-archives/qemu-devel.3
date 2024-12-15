Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2452EE77184
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwk-0001ZM-Mc; Sun, 15 Dec 2024 14:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwV-0001Kd-BF
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:15 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwS-00018a-Qt
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:15 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-29f87f1152cso1768184fac.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289571; x=1734894371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUtiDNj3KxgnjeSHYu9ugGNzQd6pYx91WleK/KTOXvs=;
 b=Qltqj9UxW+Q9ebODyxCEor7LwRf1CWm/9lHHGS30M6Hn4GSrhfXfllBhtsIOomNXrK
 dYX4QXrqKn6WGjirune3zhhU0C95RNuE6TqHq8QnXrO0lptmsjYyrinlNtnhwKMhPmAK
 +IF/TiEixqeEjzrg5bsY+dZP+5H7sPt7URyWcOzPyiSmjCP/6X1NGfo7pS12JfmemEWi
 XaC38xpz5+rXUy/b4o3Y/ygwn8Xr5/WjlOqMa78B6vI3vW6a3XIoPjESB1SMEk/xs+/e
 QMD5SxdVTnJ1H4pZJiB8xojkCDlNcFHicu52B9297gH/1i+cSdRyQpvs5eAvhsfvK03H
 XsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289571; x=1734894371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUtiDNj3KxgnjeSHYu9ugGNzQd6pYx91WleK/KTOXvs=;
 b=FMdi4rpM8G7qPCoIk0/n7Q5WtEwUpfjpFjdeDJ7BiStHtKPe7LiakuKICd7LsmDPFS
 SRjnob1BkOmbuRcD7OBe8r+V2a00Zfn32OV08HdBMW8oQ7SQLACXzxT5L6dIz0jxerNK
 t1Ywp6+iI9rPwepRIbd//eW7AIZuGYF8fNEjQQhaygr0YcSy1WfIBp2Pm5kyTIA/CB8Q
 zlxerSgCkHIKIqJduyNtc/DH3mc5fp86cHsosrni0iMxsJH7EVGCZoKPp6r/JjtLJ3ig
 6v1Ga77LoWx+aRsofPtVvC2WtJ7LxhvQWxWoztiPCTdNphAdg2G/JqVlS6gpTnB3cu8I
 ltaA==
X-Gm-Message-State: AOJu0YzLsXZKycaYaXGdXYpfo9R3naSskbrD8C4muzMR0u5T7r3Y9SAg
 /V+2y/znAtCbM8C4RK7x8hFYD8sgfJT4SkQtOFQiy9LPBl0AbtU2+SZ2uSWgp0xewBGJp8wvCzO
 2guKabqrU
X-Gm-Gg: ASbGncsvWCBWi97Fat5+FLgIT0iednF70y5y8IhbVLiyHSmLhFBJqlxPTB8ILcHNnpb
 xTXYJJtLntA5bSfHnm9wIB0sEEVDgPYJpw/wNApCV3nNntYe1vJhFiAu8L6FHr9NKvXv03tkegz
 J958gYIm7m5573euy7Nr+gVJjS6MiIn9GyXsQgjuv3QXGHp6IqsLMzX1Ulhk65uVP3HeQ7rZhBL
 4E41/wDuNldAc6SIkhb2jh5WOGmfcblo5DepoFHmI82selpmB5wi1Dun4ZlQo5lZjWVP9M4FqJd
 JifbmPCW07ONMzI9vwLu8kU9pNrHqovb/8u6elodq7M=
X-Google-Smtp-Source: AGHT+IFX5WFRye8vHQxFWDfLN8GD5XSH9t/caCHa5G5/9pv+Fbz09VjGeGMeU2ZW6DDKC1738dHXSw==
X-Received: by 2002:a05:6871:5825:b0:29e:32f2:cd4d with SMTP id
 586e51a60fabf-2a3ac497accmr5514829fac.2.1734289571522; 
 Sun, 15 Dec 2024 11:06:11 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/67] hw/display: Constify all Property
Date: Sun, 15 Dec 2024 13:04:49 -0600
Message-ID: <20241215190533.3222854-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/display/artist.c              | 2 +-
 hw/display/ati.c                 | 2 +-
 hw/display/bcm2835_fb.c          | 2 +-
 hw/display/bochs-display.c       | 2 +-
 hw/display/cg3.c                 | 2 +-
 hw/display/cirrus_vga.c          | 2 +-
 hw/display/cirrus_vga_isa.c      | 2 +-
 hw/display/exynos4210_fimd.c     | 2 +-
 hw/display/g364fb.c              | 2 +-
 hw/display/i2c-ddc.c             | 2 +-
 hw/display/macfb.c               | 4 ++--
 hw/display/pl110.c               | 2 +-
 hw/display/qxl.c                 | 2 +-
 hw/display/ramfb-standalone.c    | 2 +-
 hw/display/sm501.c               | 4 ++--
 hw/display/tcx.c                 | 2 +-
 hw/display/vga-isa.c             | 2 +-
 hw/display/vga-mmio.c            | 2 +-
 hw/display/vga-pci.c             | 4 ++--
 hw/display/vhost-user-gpu.c      | 2 +-
 hw/display/virtio-gpu-gl.c       | 2 +-
 hw/display/virtio-gpu-pci.c      | 2 +-
 hw/display/virtio-gpu-rutabaga.c | 2 +-
 hw/display/virtio-gpu.c          | 2 +-
 hw/display/virtio-vga.c          | 2 +-
 hw/display/vmware_vga.c          | 2 +-
 hw/display/xlnx_dp.c             | 2 +-
 27 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 5790b7a64e..49deed328d 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -1474,7 +1474,7 @@ static const VMStateDescription vmstate_artist = {
     }
 };
 
-static Property artist_properties[] = {
+static const Property artist_properties[] = {
     DEFINE_PROP_UINT16("width",        ARTISTState, width, 1280),
     DEFINE_PROP_UINT16("height",       ARTISTState, height, 1024),
     DEFINE_PROP_UINT16("depth",        ARTISTState, depth, 8),
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 593a25328d..e24e092bbc 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1039,7 +1039,7 @@ static void ati_vga_exit(PCIDevice *dev)
     graphic_console_close(s->vga.con);
 }
 
-static Property ati_vga_properties[] = {
+static const Property ati_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", ATIVGAState, vga.vram_size_mb, 16),
     DEFINE_PROP_STRING("model", ATIVGAState, model),
     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 7005d5bfea..2539fcc8ab 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -429,7 +429,7 @@ static void bcm2835_fb_realize(DeviceState *dev, Error **errp)
     qemu_console_resize(s->con, s->config.xres, s->config.yres);
 }
 
-static Property bcm2835_fb_props[] = {
+static const Property bcm2835_fb_props[] = {
     DEFINE_PROP_UINT32("vcram-base", BCM2835FBState, vcram_base, 0),/*required*/
     DEFINE_PROP_UINT32("vcram-size", BCM2835FBState, vcram_size,
                        DEFAULT_VCRAM_SIZE),
diff --git a/hw/display/bochs-display.c b/hw/display/bochs-display.c
index 3b1d922b6e..9a3263aa01 100644
--- a/hw/display/bochs-display.c
+++ b/hw/display/bochs-display.c
@@ -345,7 +345,7 @@ static void bochs_display_exit(PCIDevice *dev)
     graphic_console_close(s->con);
 }
 
-static Property bochs_display_properties[] = {
+static const Property bochs_display_properties[] = {
     DEFINE_PROP_SIZE("vgamem", BochsDisplayState, vgamem, 16 * MiB),
     DEFINE_PROP_BOOL("edid", BochsDisplayState, enable_edid, true),
     DEFINE_EDID_PROPERTIES(BochsDisplayState, edid_info),
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 95f8f98b99..75b3312c24 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -361,7 +361,7 @@ static void cg3_reset(DeviceState *d)
     qemu_irq_lower(s->irq);
 }
 
-static Property cg3_properties[] = {
+static const Property cg3_properties[] = {
     DEFINE_PROP_UINT32("vram-size",    CG3State, vram_size, -1),
     DEFINE_PROP_UINT16("width",        CG3State, width,     -1),
     DEFINE_PROP_UINT16("height",       CG3State, height,    -1),
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 150883a971..198ed9ed9b 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -2982,7 +2982,7 @@ static void pci_cirrus_vga_realize(PCIDevice *dev, Error **errp)
     }
 }
 
-static Property pci_vga_cirrus_properties[] = {
+static const Property pci_vga_cirrus_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct PCICirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct PCICirrusVGAState,
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 84be51670e..d0d134470f 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -69,7 +69,7 @@ static void isa_cirrus_vga_realizefn(DeviceState *dev, Error **errp)
     /* FIXME not qdev yet */
 }
 
-static Property isa_cirrus_vga_properties[] = {
+static const Property isa_cirrus_vga_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct ISACirrusVGAState,
                        cirrus_vga.vga.vram_size_mb, 4),
     DEFINE_PROP_BOOL("blitter", struct ISACirrusVGAState,
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index f3d82498bf..4f097a172c 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -1925,7 +1925,7 @@ static const GraphicHwOps exynos4210_fimd_ops = {
     .gfx_update  = exynos4210_fimd_update,
 };
 
-static Property exynos4210_fimd_properties[] = {
+static const Property exynos4210_fimd_properties[] = {
     DEFINE_PROP_LINK("framebuffer-memory", Exynos4210fimdState, fbmem,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index fa2f184908..a7533c6908 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -512,7 +512,7 @@ static void g364fb_sysbus_reset(DeviceState *d)
     g364fb_reset(&s->g364);
 }
 
-static Property g364fb_sysbus_properties[] = {
+static const Property g364fb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram_size", G364SysBusState, g364.vram_size, 8 * MiB),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/i2c-ddc.c b/hw/display/i2c-ddc.c
index 465b00355e..a2d1f2b044 100644
--- a/hw/display/i2c-ddc.c
+++ b/hw/display/i2c-ddc.c
@@ -95,7 +95,7 @@ static const VMStateDescription vmstate_i2c_ddc = {
     }
 };
 
-static Property i2c_ddc_properties[] = {
+static const Property i2c_ddc_properties[] = {
     DEFINE_EDID_PROPERTIES(I2CDDCState, edid_info),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index a5b4a499f3..977901bfdd 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -758,7 +758,7 @@ static void macfb_nubus_reset(DeviceState *d)
     macfb_reset(&s->macfb);
 }
 
-static Property macfb_sysbus_properties[] = {
+static const Property macfb_sysbus_properties[] = {
     DEFINE_PROP_UINT32("width", MacfbSysBusState, macfb.width, 640),
     DEFINE_PROP_UINT32("height", MacfbSysBusState, macfb.height, 480),
     DEFINE_PROP_UINT8("depth", MacfbSysBusState, macfb.depth, 8),
@@ -777,7 +777,7 @@ static const VMStateDescription vmstate_macfb_sysbus = {
     }
 };
 
-static Property macfb_nubus_properties[] = {
+static const Property macfb_nubus_properties[] = {
     DEFINE_PROP_UINT32("width", MacfbNubusState, macfb.width, 640),
     DEFINE_PROP_UINT32("height", MacfbNubusState, macfb.height, 480),
     DEFINE_PROP_UINT8("depth", MacfbNubusState, macfb.depth, 8),
diff --git a/hw/display/pl110.c b/hw/display/pl110.c
index 7f145bbdba..eca00b4279 100644
--- a/hw/display/pl110.c
+++ b/hw/display/pl110.c
@@ -535,7 +535,7 @@ static const GraphicHwOps pl110_gfx_ops = {
     .gfx_update  = pl110_update_display,
 };
 
-static Property pl110_properties[] = {
+static const Property pl110_properties[] = {
     DEFINE_PROP_LINK("framebuffer-memory", PL110State, fbmem,
                      TYPE_MEMORY_REGION, MemoryRegion *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 0c4b1c9bf2..949949d374 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2458,7 +2458,7 @@ static const VMStateDescription qxl_vmstate = {
     }
 };
 
-static Property qxl_properties[] = {
+static const Property qxl_properties[] = {
         DEFINE_PROP_UINT32("ram_size", PCIQXLDevice, vga.vram_size, 64 * MiB),
         DEFINE_PROP_UINT64("vram_size", PCIQXLDevice, vram32_size, 64 * MiB),
         DEFINE_PROP_UINT32("revision", PCIQXLDevice, revision,
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 20eab34ff4..e677f44be6 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -60,7 +60,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
     }
 };
 
-static Property ramfb_properties[] = {
+static const Property ramfb_properties[] = {
     DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 38d005c168..446b648f1a 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2054,7 +2054,7 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     /* TODO : chain irq to IRL */
 }
 
-static Property sm501_sysbus_properties[] = {
+static const Property sm501_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
     /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
     DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, DEFAULT_X_PIXMAN),
@@ -2143,7 +2143,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
                      &s->state.mmio_region);
 }
 
-static Property sm501_pci_properties[] = {
+static const Property sm501_pci_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
     DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEFAULT_X_PIXMAN),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index f000288fcd..3eb0a91ff9 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -879,7 +879,7 @@ static void tcx_realizefn(DeviceState *dev, Error **errp)
     qemu_console_resize(s->con, s->width, s->height);
 }
 
-static Property tcx_properties[] = {
+static const Property tcx_properties[] = {
     DEFINE_PROP_UINT32("vram_size", TCXState, vram_size, -1),
     DEFINE_PROP_UINT16("width",    TCXState, width,     -1),
     DEFINE_PROP_UINT16("height",   TCXState, height,    -1),
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index c025632635..a6cbf77103 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -88,7 +88,7 @@ static void vga_isa_realizefn(DeviceState *dev, Error **errp)
     rom_add_vga(VGABIOS_FILENAME);
 }
 
-static Property vga_isa_properties[] = {
+static const Property vga_isa_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", ISAVGAState, state.vram_size_mb, 8),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/vga-mmio.c b/hw/display/vga-mmio.c
index be33204517..b759efdde7 100644
--- a/hw/display/vga-mmio.c
+++ b/hw/display/vga-mmio.c
@@ -111,7 +111,7 @@ static void vga_mmio_realizefn(DeviceState *dev, Error **errp)
     s->vga.con = graphic_console_init(dev, 0, s->vga.hw_ops, &s->vga);
 }
 
-static Property vga_mmio_properties[] = {
+static const Property vga_mmio_properties[] = {
     DEFINE_PROP_UINT8("it_shift", VGAMmioState, it_shift, 0),
     DEFINE_PROP_UINT32("vgamem_mb", VGAMmioState, vga.vram_size_mb, 8),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index 6b51019966..3145c448f5 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -330,7 +330,7 @@ static void pci_secondary_vga_reset(DeviceState *dev)
     vga_common_reset(&d->vga);
 }
 
-static Property vga_pci_properties[] = {
+static const Property vga_pci_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", PCIVGAState, vga.vram_size_mb, 16),
     DEFINE_PROP_BIT("mmio", PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_MMIO, true),
     DEFINE_PROP_BIT("qemu-extended-regs",
@@ -342,7 +342,7 @@ static Property vga_pci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static Property secondary_pci_properties[] = {
+static const Property secondary_pci_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", PCIVGAState, vga.vram_size_mb, 16),
     DEFINE_PROP_BIT("qemu-extended-regs",
                     PCIVGAState, flags, PCI_VGA_FLAG_ENABLE_QEXT, true),
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
index 14548f1a57..a36eddcb12 100644
--- a/hw/display/vhost-user-gpu.c
+++ b/hw/display/vhost-user-gpu.c
@@ -645,7 +645,7 @@ static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
     return g->vhost ? &g->vhost->dev : NULL;
 }
 
-static Property vhost_user_gpu_properties[] = {
+static const Property vhost_user_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VhostUserGPU, parent_obj.conf),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 7c0e448b46..6f31149e1e 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -154,7 +154,7 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     virtio_gpu_device_realize(qdev, errp);
 }
 
-static Property virtio_gpu_gl_properties[] = {
+static const Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_BIT("stats", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_STATS_ENABLED, false),
     DEFINE_PROP_BIT("venus", VirtIOGPU, parent_obj.conf.flags,
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index da6a99f038..89d27c9d85 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -21,7 +21,7 @@
 #include "hw/virtio/virtio-gpu-pci.h"
 #include "qom/object.h"
 
-static Property virtio_gpu_pci_base_properties[] = {
+static const Property virtio_gpu_pci_base_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 17bf701a21..f6486acdda 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -1096,7 +1096,7 @@ static void virtio_gpu_rutabaga_realize(DeviceState *qdev, Error **errp)
     virtio_gpu_device_realize(qdev, errp);
 }
 
-static Property virtio_gpu_rutabaga_properties[] = {
+static const Property virtio_gpu_rutabaga_properties[] = {
     DEFINE_PROP_BIT64("gfxstream-vulkan", VirtIOGPURutabaga, capset_mask,
                       RUTABAGA_CAPSET_GFXSTREAM_VULKAN, false),
     DEFINE_PROP_BIT64("cross-domain", VirtIOGPURutabaga, capset_mask,
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 7d22d03bbf..82741d19e5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1674,7 +1674,7 @@ static const VMStateDescription vmstate_virtio_gpu = {
     .post_load = virtio_gpu_post_load,
 };
 
-static Property virtio_gpu_properties[] = {
+static const Property virtio_gpu_properties[] = {
     VIRTIO_GPU_BASE_PROPERTIES(VirtIOGPU, parent_obj.conf),
     DEFINE_PROP_SIZE("max_hostmem", VirtIOGPU, conf_max_hostmem,
                      256 * MiB),
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 276f315108..532e4c62d5 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -209,7 +209,7 @@ static void virtio_vga_set_big_endian_fb(Object *obj, bool value, Error **errp)
     d->vga.big_endian_fb = value;
 }
 
-static Property virtio_vga_base_properties[] = {
+static const Property virtio_vga_base_properties[] = {
     DEFINE_VIRTIO_GPU_PCI_PROPERTIES(VirtIOPCIProxy),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index f2d72c3fc7..f49bbf393a 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1332,7 +1332,7 @@ static void pci_vmsvga_realize(PCIDevice *dev, Error **errp)
                      &s->chip.fifo_ram);
 }
 
-static Property vga_vmware_properties[] = {
+static const Property vga_vmware_properties[] = {
     DEFINE_PROP_UINT32("vgamem_mb", struct pci_vmsvga_state_s,
                        chip.vga.vram_size_mb, 16),
     DEFINE_PROP_BOOL("global-vmstate", struct pci_vmsvga_state_s,
diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 6ab2335499..7838f28bca 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1387,7 +1387,7 @@ static void xlnx_dp_reset(DeviceState *dev)
     xlnx_dp_update_irq(s);
 }
 
-static Property xlnx_dp_device_properties[] = {
+static const Property xlnx_dp_device_properties[] = {
     DEFINE_AUDIO_PROPERTIES(XlnxDPState, aud_card),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


