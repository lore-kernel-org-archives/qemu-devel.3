Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB71C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxw-0002tn-Fd; Wed, 21 Feb 2024 16:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxU-0002JV-9X
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:53 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxM-0000mi-Lv
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:16:51 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ce8cbf465so3658823f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550202; x=1709155002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krMCnSm7PN59WBp42omeBRDoSFldcCIH3sGDX1JOTwc=;
 b=jKfhZQRbt1eKbTCvF9Je8+ri8dt6VB+D+IRj6Cu2tlUepxVWMweW3sE05LdIuZyqmF
 hpeHylPBYwllg71C0ze4o5r5T/Tq+dK6tDZg5yQTVLIIxmHtVvI1x4X6d3pDazLC3oYT
 g5sBdBRJf4OsYxu7QtP5Ybgf8d3k3IXLneL2Psup+KKJFibLI9ewVk5gMgAehZ91sfRw
 nS7vRy5CtUfHuoBT9g0Ca5Y4Em1mcaEPIWdeEOozTIWq/Hg41znfaP0H1bM5lUCTeD5g
 A56/36hxPf+902Vrhc22+qgV/ZOdNtmP2xgmEmSu9lRiX+tj7wqrO7uE3ECqem5vicJy
 5N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550202; x=1709155002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krMCnSm7PN59WBp42omeBRDoSFldcCIH3sGDX1JOTwc=;
 b=R9A+/bvLOSgm58RTnyp+Hin0OKsMclXgmYHulwFSprfsTtC5OxxfB8P7peQFIz87SW
 0sK7KxIVFb0u/b6ZYKcVAEoIYSBIKXYeQaEVnBsurf5PLeH7vidgtyIJ9blGqNHz0tx/
 nJwjVPWrGLx30ITrugH+o3+5TAlJgo7x+zFn7CkkEEG3mlmigP7KwNyNgVytwNsjJkqo
 TnG2v1rJo1OOqadpE+xvYgINSFV4q31QnR4kczCS+cWQkjpTMDNdzkm0+mHelWdGNyPK
 QPpozTgQnzh4zf0LOdC5suhnYOGibLzDtSTc5sMLr0h/K77+Kj14Sxmq2tUWGjUh/ixi
 SBhw==
X-Gm-Message-State: AOJu0Yz802VBcgnItScxw1FaRXixu/WwXrWCMfeeoxtSYuXLDo6VvOiv
 +hkjS6B/dgOMF/flExuhqNsqVSqrlA+x2lnXvKjqC2H8GVKvrsCZU7Kb5OsASOXPiGg0i9pxme8
 JHNw=
X-Google-Smtp-Source: AGHT+IGZf8Qtrl4tZWmdwUIeSK1cDaEYgeGvhmoolrdmoUSN1r0xO5Kbs+SYa2GK0wYLV2zGb/OPJQ==
X-Received: by 2002:a5d:648e:0:b0:33d:3bc2:7acc with SMTP id
 o14-20020a5d648e000000b0033d3bc27accmr9430955wri.11.1708550202692; 
 Wed, 21 Feb 2024 13:16:42 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 ba20-20020a0560001c1400b0033d640c8942sm7735227wrb.10.2024.02.21.13.16.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:16:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org
Subject: [PULL 02/25] hw/sysbus: Inline and remove sysbus_add_io()
Date: Wed, 21 Feb 2024 22:16:02 +0100
Message-ID: <20240221211626.48190-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

sysbus_add_io(...) is a simple wrapper to
memory_region_add_subregion(get_system_io(), ...).
It is used in 3 places; inline it directly.

Rationale: we want to move to an explicit I/O bus,
rather that an implicit one. Besides in heterogeneous
setup we can have more than one I/O bus.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240216150441.45681-1-philmd@linaro.org>
---
 include/hw/sysbus.h | 2 --
 hw/core/sysbus.c    | 6 ------
 hw/i386/kvmvapic.c  | 2 +-
 hw/mips/mipssim.c   | 2 +-
 hw/nvram/fw_cfg.c   | 5 +++--
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index 3564b7b6a2..14dbc22d0c 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -83,8 +83,6 @@ void sysbus_mmio_map(SysBusDevice *dev, int n, hwaddr addr);
 void sysbus_mmio_map_overlap(SysBusDevice *dev, int n, hwaddr addr,
                              int priority);
 void sysbus_mmio_unmap(SysBusDevice *dev, int n);
-void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
-                   MemoryRegion *mem);
 MemoryRegion *sysbus_address_space(SysBusDevice *dev);
 
 bool sysbus_realize(SysBusDevice *dev, Error **errp);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 35f902b582..9f1d5b2d6d 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -298,12 +298,6 @@ static char *sysbus_get_fw_dev_path(DeviceState *dev)
     return g_strdup(qdev_fw_name(dev));
 }
 
-void sysbus_add_io(SysBusDevice *dev, hwaddr addr,
-                       MemoryRegion *mem)
-{
-    memory_region_add_subregion(get_system_io(), addr, mem);
-}
-
 MemoryRegion *sysbus_address_space(SysBusDevice *dev)
 {
     return get_system_memory();
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index f2b0aff479..3be64fba3b 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -727,7 +727,7 @@ static void vapic_realize(DeviceState *dev, Error **errp)
     VAPICROMState *s = VAPIC(dev);
 
     memory_region_init_io(&s->io, OBJECT(s), &vapic_ops, s, "kvmvapic", 2);
-    sysbus_add_io(sbd, VAPIC_IO_PORT, &s->io);
+    memory_region_add_subregion(get_system_io(), VAPIC_IO_PORT, &s->io);
     sysbus_init_ioports(sbd, VAPIC_IO_PORT, 2);
 
     option_rom[nb_option_roms].name = "kvmvapic.bin";
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index a12427b6c8..57c8c33e2b 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -226,7 +226,7 @@ mips_mipssim_init(MachineState *machine)
         qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
-        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
+        memory_region_add_subregion(get_system_io(), 0x3f8,
                       sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
     }
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e85493d513..6d6b17462d 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1142,6 +1142,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     SysBusDevice *sbd;
     FWCfgIoState *ios;
     FWCfgState *s;
+    MemoryRegion *iomem = get_system_io();
     bool dma_requested = dma_iobase && dma_as;
 
     dev = qdev_new(TYPE_FW_CFG_IO);
@@ -1155,7 +1156,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sbd, &error_fatal);
     ios = FW_CFG_IO(dev);
-    sysbus_add_io(sbd, iobase, &ios->comb_iomem);
+    memory_region_add_subregion(iomem, iobase, &ios->comb_iomem);
 
     s = FW_CFG(dev);
 
@@ -1163,7 +1164,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
-        sysbus_add_io(sbd, dma_iobase, &s->dma_iomem);
+        memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
     }
 
     return s;
-- 
2.41.0


