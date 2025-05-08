Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFB4C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1TS-0004YW-Dn; Thu, 08 May 2025 09:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1TG-0003zz-5X
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:39:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1TD-00042S-1D
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:39:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so998601a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711564; x=1747316364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cAbS7dd6OYaBgTRts6heMSablah9GO0KM+pjh24R5k0=;
 b=dOAdpsG9EnPQpmszWr/jscn/jA7AlzbHmqcCZ0Lq3G67QYIFG/XXCuo/xQKTew0ykD
 6iINDH6VqcFU4XghhMng1o2kzc1zZy2zndsZ0Kk857/exQVBRLrGGXITK3fHnqzoXt2g
 IwotSYQQCCWxdRduOM5jDQihFuGctUU/fjoqc2Lilv4g30yHhzy1l6Eh2w+r7ZNwkGxY
 aqU8+oUEhiwTMSFLzMp9gAFiojnDR6yMg+ZcZtG/kLJm0348ht93kIV4MyYeu94F/Sj0
 EIRvTMqpAufDqSW5ol/H+4j6l0YhR6cQEdEP3A41TaIuiRqifKA4yY4QGrT2zYFID197
 dA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711564; x=1747316364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAbS7dd6OYaBgTRts6heMSablah9GO0KM+pjh24R5k0=;
 b=qfyFfD5W9zoMs0MlgieYaVjkAFtBieNFAhhxM7+dwmA2CakQ/uOi15K8qBdXZ+ukRo
 84gUPqutwDRB02Qee6ZC5QgOzbI0NH3Bb9zFdse5fDe42c1sRfc9D6kvm8l0lw3Lp8sN
 AMRQuIWjVE6tNcV+z7FmP92Y7y3u46EcuIEPdB12+g25pAmHh859DTtvAkXgtAOS7Eav
 wnVZJo+dWWaeqqq4uhmWOZMyJJW2jZsCQ9vELTux0NHUNCq7qWURrbtyOWU4QckUEn+S
 CzD10M9CPdPqbNcJ5ky+TR5Tq/CSptE6GFUuX8OGTApoy+wiS5Oi2+UlG2UXMe9sQuSE
 v4sw==
X-Gm-Message-State: AOJu0YyP93/+LlKreiwCb8NEQhwuSvtZW1J6FhZTAFBsgcgB30tLyuUv
 BEh1fTY9J93dDNwJy3/8IymXkCZzVvBshKGSAJ20Ij2O2KkL5pRj59OUokIqPe2Tn7eQJC9aH5s
 csHqSAQ==
X-Gm-Gg: ASbGnctPu2C8ISusuesV0sL7rekbiXFUL+lVjOxDAFMoy0VJhY5rZNRw83azpnk1lel
 Rxc1iiIgpi3jpIHB/4VvLHrCCvO/5zlyyUBb9FgfkL/XCCrrGtgYQZGfhxc0pBcKVnSuDMrRMcH
 VRwfIPkaufuVwhdu2gQ4mtW4LyZKgmZQPaVFZX8dTM8ZH0XuiirOzkiQMSTh7X6sk+5q4C1aOfB
 Lnb/M/OiyQfnU+2C/V1Wt3Kf6unDlv+G+KmDuYvGh7+dCn4lg4di1AVCWzd+a0JS1xg1Tq6m7Tj
 B3/yBFr+/Xj26oixK3tMIJT3FRzusjSv8sYUq7mI4yMRaCWuRjvobGaiGW3C6P7z0PsMin+/4E4
 CR6vdcxc0RewbeWs=
X-Google-Smtp-Source: AGHT+IGD7ehNT1K93paYoGn7FaZWxJ+dSsOmuR5QXLqXBWULbE98CdNx9IjpVLps4buOu6uSfnZJuQ==
X-Received: by 2002:a17:90b:4ad2:b0:30a:a38f:f78b with SMTP id
 98e67ed59e1d1-30b3a65b933mr5249495a91.9.1746711564599; 
 Thu, 08 May 2025 06:39:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522a667sm111765955ad.171.2025.05.08.06.39.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:39:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 09/27] hw/nvram/fw_cfg: Remove
 fw_cfg_io_properties::dma_enabled
Date: Thu,  8 May 2025 15:35:32 +0200
Message-ID: <20250508133550.81391-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now than all calls to fw_cfg_init_io_dma() pass DMA arguments,
the 'dma_enabled' of the TYPE_FW_CFG_IO type is not used anymore.
Remove it, simplifying fw_cfg_init_io_dma() and fw_cfg_io_realize().

Note, we can not remove the equivalent in fw_cfg_mem_properties[]
because it is still used in HPPA and MIPS Loongson3 machines:

  $ git grep -w fw_cfg_init_mem_nodma
  hw/hppa/machine.c:204:    fw_cfg = fw_cfg_init_mem_nodma(addr, addr + 4, 1);
  hw/mips/loongson3_virt.c:289:    fw_cfg = fw_cfg_init_mem_nodma(cfg_addr, cfg_addr + 8, 8);

'linuxboot.bin' isn't used anymore, we'll remove it in the
next commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/fw_cfg.c     |  5 +----
 hw/i386/x86-common.c |  5 +----
 hw/nvram/fw_cfg.c    | 26 ++++++++------------------
 3 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 5c0bcd5f8a9..1fe084fd720 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -221,10 +221,7 @@ void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg)
      * of the i/o region used is FW_CFG_CTL_SIZE; when using DMA, the
      * DMA control register is located at FW_CFG_DMA_IO_BASE + 4
      */
-    Object *obj = OBJECT(fw_cfg);
-    uint8_t io_size = object_property_get_bool(obj, "dma_enabled", NULL) ?
-        ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t) :
-        FW_CFG_CTL_SIZE;
+    uint8_t io_size = ROUND_UP(FW_CFG_CTL_SIZE, 4) + sizeof(dma_addr_t);
     Aml *dev = aml_device("FWCF");
     Aml *crs = aml_resource_template();
 
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 27254a0e9f1..ee594364415 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -991,10 +991,7 @@ void x86_load_linux(X86MachineState *x86ms,
     }
 
     option_rom[nb_option_roms].bootindex = 0;
-    option_rom[nb_option_roms].name = "linuxboot.bin";
-    if (fw_cfg_dma_enabled(fw_cfg)) {
-        option_rom[nb_option_roms].name = "linuxboot_dma.bin";
-    }
+    option_rom[nb_option_roms].name = "linuxboot_dma.bin";
     nb_option_roms++;
 }
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 51b028b5d0a..ef976a4bce2 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1026,12 +1026,9 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     FWCfgIoState *ios;
     FWCfgState *s;
     MemoryRegion *iomem = get_system_io();
-    bool dma_requested = dma_iobase && dma_as;
 
+    assert(dma_iobase);
     dev = qdev_new(TYPE_FW_CFG_IO);
-    if (!dma_requested) {
-        qdev_prop_set_bit(dev, "dma_enabled", false);
-    }
 
     object_property_add_child(OBJECT(qdev_get_machine()), TYPE_FW_CFG,
                               OBJECT(dev));
@@ -1042,13 +1039,10 @@ FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
     memory_region_add_subregion(iomem, iobase, &ios->comb_iomem);
 
     s = FW_CFG(dev);
-
-    if (s->dma_enabled) {
-        /* 64 bits for the address field */
-        s->dma_as = dma_as;
-        s->dma_addr = 0;
-        memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
-    }
+    /* 64 bits for the address field */
+    s->dma_as = dma_as;
+    s->dma_addr = 0;
+    memory_region_add_subregion(iomem, dma_iobase, &s->dma_iomem);
 
     return s;
 }
@@ -1185,8 +1179,6 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
 }
 
 static const Property fw_cfg_io_properties[] = {
-    DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
-                     true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
                        FW_CFG_FILE_SLOTS_DFLT),
 };
@@ -1207,11 +1199,9 @@ static void fw_cfg_io_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->comb_iomem, OBJECT(s), &fw_cfg_comb_mem_ops,
                           FW_CFG(s), "fwcfg", FW_CFG_CTL_SIZE);
 
-    if (FW_CFG(s)->dma_enabled) {
-        memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
-                              &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
-                              sizeof(dma_addr_t));
-    }
+    memory_region_init_io(&FW_CFG(s)->dma_iomem, OBJECT(s),
+                          &fw_cfg_dma_mem_ops, FW_CFG(s), "fwcfg.dma",
+                          sizeof(dma_addr_t));
 
     fw_cfg_common_realize(dev, errp);
 }
-- 
2.47.1


