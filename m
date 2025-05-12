Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AACFC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOkJ-0002P4-UF; Mon, 12 May 2025 04:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjB-00087P-2w
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOj6-0001nb-7j
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:41:35 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a064a3e143so2283853f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039290; x=1747644090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1frKODZfVTNx8C6LCobmlizA4xkItfE52ERke7j6olo=;
 b=rQ6agF0xjIx0Yldnra9/uhqRHSqarG5+SHyb0nBR6NvZMOvt4takrxxnjbq5LlMZQ4
 cgDJunytFwxjLcQzgm2ZG7pxdaaZuxVzwOR1CGbYoPbwKc7So/hQHLz9tC0LU9U3vJN4
 lsPnjr6/w7v/xuGcUtQfE6vsInGlpaGTNnWLrtIbTeFTD1E9y4TqIGQxjd6NpPMwFrlf
 cYc8ToCU0sU2orEqvBCJTNXop/m/EsWvDl9uJYPWTMQMq1mjN/Gbffhlt5L8vEmVPmRt
 n+Ux3CYRoENbEiVq/pnf9XCu4B7jQ72bEMENha6TiJS+tww/LMBAHHxTfTfxT6wKvyHE
 J8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039290; x=1747644090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1frKODZfVTNx8C6LCobmlizA4xkItfE52ERke7j6olo=;
 b=kJpwCZX1Q3WFZXL7adbpOJjzShW0wJD2kVj03VMoommfxcPGXHV3DJwfwYRnls5lPJ
 93GFl3qUnNa5+UEYJ2LXPA6c305Rr7bKQxKMZTh687UlmlpmI9/y9nGQzHOoHMoV5St+
 wW31dj2I0z8nbbGb47vi3AY25xyjhysIeHly+CYtt+LOSd/fesi+JWP2+bck4jzc+nCS
 L1PP00LxXAYU/YRmNrxGhiLIW59CUmo6kqSsCeDH2oPeMy3kEDgT7BcQ5Z1XnOyPbDLj
 6l1b+EOAnUuRxw08X6iSSYnxOUqlKezXxQuaYP6nGxeg1Up1KZ+KBsdfsQ3IUS98YenK
 HcNg==
X-Gm-Message-State: AOJu0YyzKZenzvnQW49bBl66wWKV37aImwHy+6ROsZDIf67ckbiFoZ52
 b7/Tn75lGxIOlT2HiLuftub/e+XfjtrPj6l8y096Zv04jJhWYbVq+Kr+cnYPBmgdhlBt2AD+cix
 bOpbN8g==
X-Gm-Gg: ASbGncuRu41jbXIFwcDtSTJ7DFKV/NGhi0XVXl51m6k2TkBUDK05cHazDB3ogEyin8B
 QH32fZyGWgpxkntSS13N1z1vPXVeKmva0Mm/NRBfGhlduqs8v80vlHwzR4soM3cKpv0sO1l6tTn
 MCChNrZ9MW7WOV2SH6niVyOW5g/yCn6Ca1GVjPAfz+ya+yeH1fqyikEUcOsdENP5y+qk9gw/LMF
 5rnsmRdM+vMJDjST3iwd0FCwc4lKFI6z1V4CWboibv/e1N4aqqGlXEyQwKjpf/pSqeZD2Vf+WSQ
 g2Zx4CHOIUtBI5Ml+QwT1IFGPIklgksoEt/IANlYhrS4Hicim/zaA9luyBErFP1yWleSdLy6Hjk
 XJp2zvM9wJZPb0///Dy+7ydQ=
X-Google-Smtp-Source: AGHT+IGs88K7QGBoe46YIRr3SKzlSxJZoj5F4XU/OiaOegKM95TVmxeUgnln4oaaAyf2q3iRG7dDdA==
X-Received: by 2002:a05:6000:420f:b0:3a0:bdeb:c48c with SMTP id
 ffacd0b85a97d-3a1f64497a8mr9567222f8f.34.1747039290163; 
 Mon, 12 May 2025 01:41:30 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c76dsm11812447f8f.92.2025.05.12.01.41.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:41:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 11/19] hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
Date: Mon, 12 May 2025 10:39:40 +0200
Message-ID: <20250512083948.39294-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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
index 03e7cbeae82..ab900dacabc 100644
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
index fd402b8ff8f..3b7057e6c66 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1192,10 +1192,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
             return -1;
         }
     }
-    /* For legacy, keep user files in a specific global order. */
-    fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
     fw_cfg_add_file(fw_cfg, name, buf, size);
-    fw_cfg_reset_order_override(fw_cfg);
     return 0;
 }
 
@@ -2745,7 +2742,6 @@ static void qemu_create_cli_devices(void)
     }
 
     /* init generic devices */
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
     QTAILQ_FOREACH(opt, &device_opts, next) {
@@ -2756,7 +2752,6 @@ static void qemu_create_cli_devices(void)
         assert(ret_data == NULL); /* error_fatal aborts */
         loc_pop(&opt->loc);
     }
-    rom_reset_order_override();
 }
 
 static bool qemu_machine_creation_done(Error **errp)
-- 
2.47.1


