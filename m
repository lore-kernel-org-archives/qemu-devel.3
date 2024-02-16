Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63E7C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razll-0008J4-6B; Fri, 16 Feb 2024 10:04:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razli-0008BI-9v
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:04:50 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razlg-0000pf-49
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:04:49 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3c1a6c10bbso277535766b.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708095886; x=1708700686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IgMGnwDJJp9CianhhLKV4Wm1OtNzAWG/gtuYlfJ5Kdg=;
 b=YL6Anxr91WU+LuAWZkckGwvH2UzRTvoOeBT+jFTmkJAxHyJVq3z7Yyfh9JR8f/2i3G
 fl0d0vLjmLkqcCV6d+Z5PRSwH7TFUEmNkpVroWexIw2rrFnjckuFdLyhYNmGqMyRS7SI
 lD+4UmHpSf1tVX1PW9SsXqD9D3jfGB39gxNLPP4FWsciWFn82qFo5rdS+WUkTfOZxUAg
 REtvmbvo8Z9sAJ+4mTNA6uy9KP2sZKzPD0+zI1GM2wCXx5MIkApGC6uzVQp1nAsTjqJQ
 lLa0P+LW2SYkhtl8s9I0fRNDcDxvds+u1O+L1oAYmVBaNoQt4esz7nhMVxTQvIrmkFfK
 xDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708095886; x=1708700686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IgMGnwDJJp9CianhhLKV4Wm1OtNzAWG/gtuYlfJ5Kdg=;
 b=E/Xg8AxbWinJD2qUedQEGY/q1EdL7oFw/BD1d6n9t/QYozl9fWbXDFZBG0BrEIBXGx
 RTQND0HT0M6nt6mMeeLI9lso7YBuf8UW6Oa5mzbg/KYlK8T/2G7bZ+Ngr9FkzXVJLiWP
 1gdnMtbKlVrvETflEghtfC0Eag/17bcpZozMBrU2Q9j+95OFdAfa8dhavqIJIwN1sY6A
 0XZN9U9w+pxFPNonCQn6MaoPPjQy/AUWt50TeJ5zT5M++i5qPKMgRHhpkvQY8LOJVy++
 /tjGGFrdZur1PA8itP1TaSxa6JvTd8waR9aFaHVxH50NUelc7uBGT9N4snzokryx+fJ6
 x7+Q==
X-Gm-Message-State: AOJu0YzF7TEiNcPA3Vqr6VvSUko+B7DibMj2wGRaiLwKUrI4PUeYMk28
 ggVRaF0+ps6opni5U/bQSxS74jt87FtpjGQ5AiZdb4FgblynLYVnXiECW+ZLO9jOPsPGuBfDo0n
 k
X-Google-Smtp-Source: AGHT+IEyR9s9gmGSVwo9B83uKFpZp+AMJ+H9XSuex4SN4sutNHsSVLGhT4D3PECIl4DYIV6TzmZwdw==
X-Received: by 2002:a17:906:a881:b0:a3d:8466:d355 with SMTP id
 ha1-20020a170906a88100b00a3d8466d355mr3635489ejb.19.1708095885825; 
 Fri, 16 Feb 2024 07:04:45 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 qw13-20020a1709066a0d00b00a3df2b849a5sm14099ejc.155.2024.02.16.07.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 07:04:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH] hw/sysbus: Inline and remove sysbus_add_io()
Date: Fri, 16 Feb 2024 16:04:41 +0100
Message-ID: <20240216150441.45681-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


