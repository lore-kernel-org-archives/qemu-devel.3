Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B32FC54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cA-000647-OV; Thu, 22 Feb 2024 07:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8bq-0005z3-D6
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:32 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8bi-0004cX-Tb
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33d18931a94so1440581f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606520; x=1709211320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZxPkAn9Il3IN8rHQ8R89Mlj+pjG0aoXx4zL2lsx2sI=;
 b=oNe5tyfykKfCzfD+slmgMUWIPWjKMm2BsriwlZScoK20E13vvlcvHfYeewo+nOv7Rm
 UG/TMbNFgOrS7Ivdg4uSDgD+r409n4KH4cd4wArB3qR2pq7gDAn4phDnglZbW+65FFrc
 pDZ09q7msddq7QnS80yp/UOTlOwkM05LUmZ2uCgyJd3UnAmFixkJVZsNLyR6DKNFJW3K
 Sbqg8IV57ZsxwgiDsjE3Bmto9IhliSlvcHKbweKmt30ze1lAspjAD0mmH9HfuxdONjea
 wX2pgMchSg3lIh6r8embP1z87BEjzBxi8nDiG3QEzjBUNzmIh9RBCZiuM7BIac0EFI5m
 5ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606520; x=1709211320;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ZxPkAn9Il3IN8rHQ8R89Mlj+pjG0aoXx4zL2lsx2sI=;
 b=iTZVihCaF29b+tRgIh/lixgwRw9rGiPaudrGDzrrTfQxMrqyMH37YK7hrWdA6YFfQT
 80XHVD8JpaGMrndeD1FdKyI49/uH+C1INrCpUi7Hu/QDvAxwEE4i3aRt9tCOEm7UPwMI
 7bEFs2bkc0+GhQXXUXEtCZbfQLKjYJRGwzFm8Wqk6K5or8sqritKufr27uIJxC34eI52
 IIWTPC+xcp9E1Hpumox6KaKKdMZwvfjwK20aOuECwIvFjkXwIYCANVyi9ZAmjrr41IMx
 q7pIanP4qfewoKwiqqUWM+FxQfAHrkibu3ajb6dJFNjjcy+UaPx1VCth8Jry0AqqY6Yw
 GJMA==
X-Gm-Message-State: AOJu0YxNaGO48aJfNB4i+Gj6W1EzApSjkJMHLq/63MsmuMWvb/NjTLDw
 ViFpHWgApbYo7tspCwoSQqlVcOVwgNf/1dAhjg2fEmiZgC8To4HSDfD3onHzxyGD45SRo+JWp3h
 fbp4=
X-Google-Smtp-Source: AGHT+IF83HJqfvwQtmmYfYWikQ67Ppg9MJTZ2Miab7H1oAkqTwSVLTXXnOWWk5uvKq5pSNnVZEwg5g==
X-Received: by 2002:a05:6000:10c6:b0:33d:7d88:bd3e with SMTP id
 b6-20020a05600010c600b0033d7d88bd3emr3316027wrx.43.1708606520647; 
 Thu, 22 Feb 2024 04:55:20 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 k1-20020adfe3c1000000b0033afc81fc00sm20170135wrm.41.2024.02.22.04.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:55:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
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
Subject: [PULL 02/32] hw/sysbus: Inline and remove sysbus_add_io()
Date: Thu, 22 Feb 2024 13:55:08 +0100
Message-ID: <20240222125517.67131-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

sysbus_add_io(...) is a simple wrapper to
memory_region_add_subregion(get_system_io(), ...).
It is used in 3 places; inline it directly.

Rationale: we want to move to an explicit I/O bus,
rather that an implicit one. Besides in heterogeneous
setup we can have more than one I/O bus.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240216150441.45681-1-philmd@linaro.org>
[PMD: Include missing "exec/address-spaces.h" header]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sysbus.h | 2 --
 hw/core/sysbus.c    | 6 ------
 hw/i386/kvmvapic.c  | 3 ++-
 hw/mips/mipssim.c   | 3 ++-
 hw/nvram/fw_cfg.c   | 6 ++++--
 5 files changed, 8 insertions(+), 12 deletions(-)

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
index f2b0aff479..20b0300357 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -16,6 +16,7 @@
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
+#include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
 #include "hw/sysbus.h"
 #include "hw/boards.h"
@@ -727,7 +728,7 @@ static void vapic_realize(DeviceState *dev, Error **errp)
     VAPICROMState *s = VAPIC(dev);
 
     memory_region_init_io(&s->io, OBJECT(s), &vapic_ops, s, "kvmvapic", 2);
-    sysbus_add_io(sbd, VAPIC_IO_PORT, &s->io);
+    memory_region_add_subregion(get_system_io(), VAPIC_IO_PORT, &s->io);
     sysbus_init_ioports(sbd, VAPIC_IO_PORT, 2);
 
     option_rom[nb_option_roms].name = "kvmvapic.bin";
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index a12427b6c8..9170d6c474 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
+#include "exec/address-spaces.h"
 #include "hw/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/char/serial.h"
@@ -226,7 +227,7 @@ mips_mipssim_init(MachineState *machine)
         qdev_prop_set_uint8(dev, "endianness", DEVICE_LITTLE_ENDIAN);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, env->irq[4]);
-        sysbus_add_io(SYS_BUS_DEVICE(dev), 0x3f8,
+        memory_region_add_subregion(get_system_io(), 0x3f8,
                       sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
     }
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e85493d513..fc0263f349 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -27,6 +27,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
+#include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
@@ -1142,6 +1143,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     SysBusDevice *sbd;
     FWCfgIoState *ios;
     FWCfgState *s;
+    MemoryRegion *iomem = get_system_io();
     bool dma_requested = dma_iobase && dma_as;
 
     dev = qdev_new(TYPE_FW_CFG_IO);
@@ -1155,7 +1157,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     sbd = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sbd, &error_fatal);
     ios = FW_CFG_IO(dev);
-    sysbus_add_io(sbd, iobase, &ios->comb_iomem);
+    memory_region_add_subregion(iomem, iobase, &ios->comb_iomem);
 
     s = FW_CFG(dev);
 
@@ -1163,7 +1165,7 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
         /* 64 bits for the address field */
         s->dma_as = dma_as;
         s->dma_addr = 0;
-        sysbus_add_io(sbd, dma_iobase, &s->dma_iomem);
+        memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
     }
 
     return s;
-- 
2.41.0


