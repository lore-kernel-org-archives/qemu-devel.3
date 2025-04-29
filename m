Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D681FC369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9leM-0002qy-F5; Tue, 29 Apr 2025 10:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leK-0002l1-FU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9leH-0006Q0-7z
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:09:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so5546191f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745935763; x=1746540563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOi5amPs94CRFUHcijuRRBsiadMoOd81cUGdXDypUyk=;
 b=K1K9VUE1bcmhTtLU1HmEnnbRXvg/32oENTtmOFcjzhpukx79kM0NwLR8kf9ZHZGO4r
 PBVXFfd4oPbuaAmSKWrWijtSUGAv+FLC5A1Eyiow8MsOs9JapA2RdDg8019H4iaJGbIo
 SNpG85wCT2gIGuNhGYx+2s8MW4VWGGOMfm/h/OWzQ1Bmmv1nrYoxEXxEMV9gc9O/AWbI
 nMY/F2MKVoIlaIyF1ZUptZTlHZy2DBkPkGaHVl4ujfqVWp0KlL8JNN/5ZFNggQofUQsr
 G4G9SHRbLe9Z+pOQ5g4saOjUpEYi78OAbcCnJB5fp06LuwA0mKbxXbrGYx7qngoiA49o
 rmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745935763; x=1746540563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOi5amPs94CRFUHcijuRRBsiadMoOd81cUGdXDypUyk=;
 b=okEdtwDf+j5hg3FRdh7aYE4NppXhG8K3ZsHz4DzowiNP1USSl4bxML0abcd+ZAEq1I
 L7e9nN4HGWxkEOihCqdmUricZbaLeb7tOIrdhxkiEsx7s19zxnFlH0z48NQt2KTlib3Y
 QevacYLvV+QlSlrt4Tb9gze/M79FeK4A6wu87HsjeqBH/S76IDxzgmjjm8Nx/JcT9Iwe
 3cUkZiqxVJPROInVoXkVWpYfo549rPSKiMxkwA9nME6dtH2HWEs1XBady4mfve5O4IvZ
 Twz1Ai43ZghSsbMvmeRsN8xqaVGvQ0aCKLgG5M7KCgVzGCvAAa/YJgkYZ6mpPrHwA9zA
 hutw==
X-Gm-Message-State: AOJu0YyBBqALLFVaR+bZbharYnBd57GeGtUdXpVX8jWQTEn9uBqBqT+L
 bJ9CURdcX5em729iHLueYzN0YxJMS4x50HzJ4ppgT4/4Mnt0pFKyvBWVtyGoHWVc8r7+ZDeAhlD
 O
X-Gm-Gg: ASbGnctWc8BLUEsdPQZzNC4Iigxwmi4euMqR8gVPSgg3Xw8rUq/Wml5kru0BPDsTVQG
 DXfdFRJnZ9rldseN5vFmhif2BJ4vXamC24G1zcSBDgNAS+Cguxcrx+bz3TjFz/zc74dh7prlfwC
 rxrl5CFGz7hxoZefTjkfktLUf/CUepMFdGndwh/QLgnFO3vOsuzzx1gjpWF5DbTWR6elR2dd3Hs
 Zre4oIcgab8jaFHDJev/zToa866E3d1cW2d6z9s9Uz6gYSRhawpnJ8ugZf5d1kz+/qzY1zLxjAp
 l9uU6/+KqUZjyUGGeCwWi8s2tIdD3/kJREaV+yQbn+h7jPYut4VWTrtFgmjif4x8OyADiz/Ycsg
 FnQQ7cQKGD7NvFknQDlLy
X-Google-Smtp-Source: AGHT+IHA4KGy0pqJ3RUSu33G9yhNDWtYTFV3m6Ur90/jECgSLmlz1z1L0guNRL2DLYoHX4dawTqh+g==
X-Received: by 2002:a05:6000:250f:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-3a07aa5feedmr12956485f8f.9.1745935763112; 
 Tue, 29 Apr 2025 07:09:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073cbede5sm13908310f8f.49.2025.04.29.07.09.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 07:09:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 11/19] hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
Date: Tue, 29 Apr 2025 16:08:17 +0200
Message-ID: <20250429140825.25964-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429140825.25964-1-philmd@linaro.org>
References: <20250429140825.25964-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

The MachineClass::legacy_fw_cfg_order boolean was only used
by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
removed. Remove it along with:

- FW_CFG_ORDER_OVERRIDE_* definitions
- fw_cfg_set_order_override()
- fw_cfg_reset_order_override()
- fw_cfg_order[]
- rom_set_order_override()
- rom_reset_order_override()

Simplify CLI and pc_vga_init() / pc_nic_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/hw/boards.h       |   3 +-
 include/hw/loader.h       |   2 -
 include/hw/nvram/fw_cfg.h |  10 ----
 hw/core/loader.c          |  14 -----
 hw/i386/pc.c              |   7 +--
 hw/nvram/fw_cfg.c         | 109 +++-----------------------------------
 system/vl.c               |   5 --
 7 files changed, 9 insertions(+), 141 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5c4e3d2a2cd..5dc5e3b547d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -286,8 +286,7 @@ struct MachineClass {
         no_parallel:1,
         no_floppy:1,
         no_cdrom:1,
-        pci_allow_0_address:1,
-        legacy_fw_cfg_order:1;
+        pci_allow_0_address:1;
     bool auto_create_sdcard;
     bool is_default;
     const char *default_machine_opts;
diff --git a/include/hw/loader.h b/include/hw/loader.h
index d280dc33e96..c96b5e141c6 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -270,8 +270,6 @@ int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
                         AddressSpace *as);
 int rom_check_and_register_reset(void);
 void rom_set_fw(FWCfgState *f);
-void rom_set_order_override(int order);
-void rom_reset_order_override(void);
 
 /**
  * rom_transaction_begin:
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 47578ccc7f2..d41b9328fd1 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -42,14 +42,6 @@ struct FWCfgDataGeneratorClass {
 
 typedef struct fw_cfg_file FWCfgFile;
 
-#define FW_CFG_ORDER_OVERRIDE_VGA    70
-#define FW_CFG_ORDER_OVERRIDE_NIC    80
-#define FW_CFG_ORDER_OVERRIDE_USER   100
-#define FW_CFG_ORDER_OVERRIDE_DEVICE 110
-
-void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
-void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
-
 typedef struct FWCfgFiles {
     uint32_t  count;
     FWCfgFile f[];
@@ -75,8 +67,6 @@ struct FWCfgState {
     uint32_t cur_offset;
     Notifier machine_ready;
 
-    int fw_cfg_order_override;
-
     bool dma_enabled;
     dma_addr_t dma_addr;
     AddressSpace *dma_as;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index b792a54bb02..e7056ba4bd3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1333,20 +1333,6 @@ void rom_set_fw(FWCfgState *f)
     fw_cfg = f;
 }
 
-void rom_set_order_override(int order)
-{
-    if (!fw_cfg)
-        return;
-    fw_cfg_set_order_override(fw_cfg, order);
-}
-
-void rom_reset_order_override(void)
-{
-    if (!fw_cfg)
-        return;
-    fw_cfg_reset_order_override(fw_cfg);
-}
-
 void rom_transaction_begin(void)
 {
     Rom *rom;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cb375aabdc5..49632b69d29 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1033,7 +1033,6 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 {
     DeviceState *dev = NULL;
 
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_VGA);
     if (pci_bus) {
         PCIDevice *pcidev = pci_vga_init(pci_bus);
         dev = pcidev ? &pcidev->qdev : NULL;
@@ -1041,7 +1040,7 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
         ISADevice *isadev = isa_vga_init(isa_bus);
         dev = isadev ? DEVICE(isadev) : NULL;
     }
-    rom_reset_order_override();
+
     return dev;
 }
 
@@ -1231,8 +1230,6 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     bool default_is_ne2k = g_str_equal(mc->default_nic, TYPE_ISA_NE2000);
     NICInfo *nd;
 
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
-
     while ((nd = qemu_find_nic_info(TYPE_ISA_NE2000, default_is_ne2k, NULL))) {
         pc_init_ne2k_isa(isa_bus, nd, &error_fatal);
     }
@@ -1241,8 +1238,6 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
     }
-
-    rom_reset_order_override();
 }
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 237b9f7d1fe..54cfa07d3f5 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -817,62 +817,6 @@ void fw_cfg_modify_i64(FWCfgState *s, uint16_t key, uint64_t value)
     g_free(old);
 }
 
-void fw_cfg_set_order_override(FWCfgState *s, int order)
-{
-    assert(s->fw_cfg_order_override == 0);
-    s->fw_cfg_order_override = order;
-}
-
-void fw_cfg_reset_order_override(FWCfgState *s)
-{
-    assert(s->fw_cfg_order_override != 0);
-    s->fw_cfg_order_override = 0;
-}
-
-/*
- * This is the legacy order list.  For legacy systems, files are in
- * the fw_cfg in the order defined below, by the "order" value.  Note
- * that some entries (VGA ROMs, NIC option ROMS, etc.) go into a
- * specific area, but there may be more than one and they occur in the
- * order that the user specifies them on the command line.  Those are
- * handled in a special manner, using the order override above.
- *
- * For non-legacy, the files are sorted by filename to avoid this kind
- * of complexity in the future.
- *
- * This is only for x86, other arches don't implement versioning so
- * they won't set legacy mode.
- */
-static struct {
-    const char *name;
-    int order;
-} fw_cfg_order[] = {
-    { "etc/boot-menu-wait", 10 },
-    { "bootsplash.jpg", 11 },
-    { "bootsplash.bmp", 12 },
-    { "etc/boot-fail-wait", 15 },
-    { "etc/smbios/smbios-tables", 20 },
-    { "etc/smbios/smbios-anchor", 30 },
-    { "etc/e820", 40 },
-    { "etc/reserved-memory-end", 50 },
-    { "genroms/kvmvapic.bin", 55 },
-    { "genroms/linuxboot.bin", 60 },
-    { }, /* VGA ROMs from pc_vga_init come here, 70. */
-    { }, /* NIC option ROMs from pc_nic_init come here, 80. */
-    { "etc/system-states", 90 },
-    { }, /* User ROMs come here, 100. */
-    { }, /* Device FW comes here, 110. */
-    { "etc/extra-pci-roots", 120 },
-    { "etc/acpi/tables", 130 },
-    { "etc/table-loader", 140 },
-    { "etc/tpm/log", 150 },
-    { "etc/acpi/rsdp", 160 },
-    { "bootorder", 170 },
-    { "etc/msr_feature_control", 180 },
-
-#define FW_CFG_ORDER_OVERRIDE_LAST 200
-};
-
 /*
  * Any sub-page size update to these table MRs will be lost during migration,
  * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
@@ -890,29 +834,6 @@ static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_t len)
     }
 }
 
-static int get_fw_cfg_order(FWCfgState *s, const char *name)
-{
-    int i;
-
-    if (s->fw_cfg_order_override > 0) {
-        return s->fw_cfg_order_override;
-    }
-
-    for (i = 0; i < ARRAY_SIZE(fw_cfg_order); i++) {
-        if (fw_cfg_order[i].name == NULL) {
-            continue;
-        }
-
-        if (strcmp(name, fw_cfg_order[i].name) == 0) {
-            return fw_cfg_order[i].order;
-        }
-    }
-
-    /* Stick unknown stuff at the end. */
-    warn_report("Unknown firmware file in legacy mode: %s", name);
-    return FW_CFG_ORDER_OVERRIDE_LAST;
-}
-
 void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
                               FWCfgCallback select_cb,
                               FWCfgWriteCallback write_cb,
@@ -921,7 +842,6 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
 {
     int i, index, count;
     size_t dsize;
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     int order = 0;
 
     if (!s->files) {
@@ -933,22 +853,10 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
     count = be32_to_cpu(s->files->count);
     assert(count < fw_cfg_file_slots(s));
 
-    /* Find the insertion point. */
-    if (mc->legacy_fw_cfg_order) {
-        /*
-         * Sort by order. For files with the same order, we keep them
-         * in the sequence in which they were added.
-         */
-        order = get_fw_cfg_order(s, filename);
-        for (index = count;
-             index > 0 && order < s->entry_order[index - 1];
-             index--);
-    } else {
-        /* Sort by file name. */
-        for (index = count;
-             index > 0 && strcmp(filename, s->files->f[index - 1].name) < 0;
-             index--);
-    }
+    /* Find the insertion point, sorting by file name. */
+    for (index = count;
+         index > 0 && strcmp(filename, s->files->f[index - 1].name) < 0;
+         index--);
 
     /*
      * Move all the entries from the index point and after down one
@@ -1058,7 +966,6 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
 
 static void fw_cfg_machine_reset(void *opaque)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     FWCfgState *s = opaque;
     void *ptr;
     size_t len;
@@ -1068,11 +975,9 @@ static void fw_cfg_machine_reset(void *opaque)
     ptr = fw_cfg_modify_file(s, "bootorder", (uint8_t *)buf, len);
     g_free(ptr);
 
-    if (!mc->legacy_fw_cfg_order) {
-        buf = get_boot_devices_lchs_list(&len);
-        ptr = fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len);
-        g_free(ptr);
-    }
+    buf = get_boot_devices_lchs_list(&len);
+    ptr = fw_cfg_modify_file(s, "bios-geometry", (uint8_t *)buf, len);
+    g_free(ptr);
 }
 
 static void fw_cfg_machine_ready(struct Notifier *n, void *data)
diff --git a/system/vl.c b/system/vl.c
index 520956f4a19..dedd555eb87 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1191,10 +1191,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
             return -1;
         }
     }
-    /* For legacy, keep user files in a specific global order. */
-    fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
     fw_cfg_add_file(fw_cfg, name, buf, size);
-    fw_cfg_reset_order_override(fw_cfg);
     return 0;
 }
 
@@ -2744,7 +2741,6 @@ static void qemu_create_cli_devices(void)
     }
 
     /* init generic devices */
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
     QTAILQ_FOREACH(opt, &device_opts, next) {
@@ -2755,7 +2751,6 @@ static void qemu_create_cli_devices(void)
         assert(ret_data == NULL); /* error_fatal aborts */
         loc_pop(&opt->loc);
     }
-    rom_reset_order_override();
 }
 
 static bool qemu_machine_creation_done(Error **errp)
-- 
2.47.1


