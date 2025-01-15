Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED1CC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCk2-0002lU-Rx; Wed, 15 Jan 2025 18:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCk0-0002ay-Ms
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:04 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjy-0003wI-5Z
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:24:04 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385dece873cso195382f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983440; x=1737588240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uaOAnbKYApd5bKR2JBERa+OaIug2ufoE0uvtXSQimKA=;
 b=Tf1nxzmBP77flgX0tA50XkUyDjskEqVGiVzgZCmgBGZNb2VRKgnGiNfEnrs7l9olXS
 X0UZFdPWGiox1ciHsTgbrYEmS/+sAQvG5W4rNXUmXIVkaUjluo9J3/iEuJQEe7jjelHn
 rOg2LBm0w9EMCaBNiq8jFnbGAlDWmFNyUnufaQg2vCzxeD3OdtBj3NCLpoUvty5ehdxw
 IfITL+7CpqbWBO2wZ5XsowhX+12wqsIH56HKxheYfQpddDZM4F7s7yCffwyvaeQBrPOT
 atY/nBQxc5EnE5kYYArPAW5uUxwPgsA6VEVPYCDBHjlyAxKzGnuae+CQ1KCT18rVeFrb
 1WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983440; x=1737588240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaOAnbKYApd5bKR2JBERa+OaIug2ufoE0uvtXSQimKA=;
 b=w7y11XIzb26AlSyx9Ge1bs47JSaPw49dyC3H29yiLMd6jMTcoXYGwsOwf6hr+sEEZI
 t3rTmV2m0NpEbiat4/kh51aBz8hlIzgK7Rco/onLjX7/cMLawxufNctWOXAPklExb/hq
 MP7fVeOoxUwNduj5/3J8fmHlGDB6MsxDybUC4N5s2eKq9SlOwipk+bBfSwqwFSDXiWXB
 +2yodXRVIBuv6wzfBMyQNqHa9fBioXYvP57GYPkCB/Cpg6USZFRcsAfSpXbxPSFjxUAa
 V1cD4MBSFxJthsKJd5wGkDpuVHWFmjGvv3ZPqRdkIBS3eYfYZWegIsq4zD0ZqVSEgyWp
 pqtw==
X-Gm-Message-State: AOJu0Yz7hFTSPUiyvILVUzPgwrbQatC6y5PIkRTkOvPPbQYbOS8p3a6V
 rZNyA1Dx5Zc2oJ3mJQshqpESljzrMxwRzsSz75zISEL1GkutD3VGz4RTYd03KRt57sFAlamz+Cj
 ovc8=
X-Gm-Gg: ASbGnctLYx+njagLal4T6zDSSUQ3X35S/GwTG5FS2gMdF5YvqnTUQTD/QCg5rFw2iwD
 TM2EW447ssi0y75GSvKGh7kzt0rR1x2dR/gx6cbfQmgRweMHVQkd2UhbNTd4KFSOe1v4yte/TbQ
 nPnNNsuzGJxxjMHl+3wmYQPIa2DgUcNdRzCNFgisdIG2SAVjfBs+MJkBk6ynqMNVDFJaa1WDuWv
 7TUcLWHwmFyNMyX/1EzTzZQvvkmBL1IdQ4t3QnSBhViRmuFxGUbkyRLeX9eR45K2qETZ4kruV6Z
 wShgYv8eF32TzB1O2cjvN6OxRKn//N4=
X-Google-Smtp-Source: AGHT+IG1p11WYDS0XzrWxuTrxjOmreABfud1dtVr+S+2ng2SRnBPXgR9NimKWFSzsuqguEm6plCA/Q==
X-Received: by 2002:a05:6000:709:b0:386:4277:6cf1 with SMTP id
 ffacd0b85a97d-38a8733a278mr31381929f8f.39.1736983440278; 
 Wed, 15 Jan 2025 15:24:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1e0bsm18573205f8f.100.2025.01.15.15.23.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 13/21] hw/nvram/fw_cfg: Remove legacy FW_CFG_ORDER_OVERRIDE
Date: Thu, 16 Jan 2025 00:22:39 +0100
Message-ID: <20250115232247.30364-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
index e9e33c57f27..a231c8cecee 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -284,8 +284,7 @@ struct MachineClass {
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1,
-        pci_allow_0_address:1,
-        legacy_fw_cfg_order:1;
+        pci_allow_0_address:1;
     bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 8985046be40..036982db202 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -282,8 +282,6 @@ int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
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
index 4dfdb027eee..33523ee9291 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1352,20 +1352,6 @@ void rom_set_fw(FWCfgState *f)
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
index 137f827b69e..b244cc71ab4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1028,7 +1028,6 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
 {
     DeviceState *dev = NULL;
 
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_VGA);
     if (pci_bus) {
         PCIDevice *pcidev = pci_vga_init(pci_bus);
         dev = pcidev ? &pcidev->qdev : NULL;
@@ -1036,7 +1035,7 @@ DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus)
         ISADevice *isadev = isa_vga_init(isa_bus);
         dev = isadev ? DEVICE(isadev) : NULL;
     }
-    rom_reset_order_override();
+
     return dev;
 }
 
@@ -1223,8 +1222,6 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     bool default_is_ne2k = g_str_equal(mc->default_nic, TYPE_ISA_NE2000);
     NICInfo *nd;
 
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_NIC);
-
     while ((nd = qemu_find_nic_info(TYPE_ISA_NE2000, default_is_ne2k, NULL))) {
         pc_init_ne2k_isa(isa_bus, nd, &error_fatal);
     }
@@ -1233,8 +1230,6 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     if (pci_bus) {
         pci_init_nic_devices(pci_bus, mc->default_nic);
     }
-
-    rom_reset_order_override();
 }
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs)
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index a757939cfb7..48d9e915209 100644
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
index be029c52ef8..5bff12ca241 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1197,10 +1197,7 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
             return -1;
         }
     }
-    /* For legacy, keep user files in a specific global order. */
-    fw_cfg_set_order_override(fw_cfg, FW_CFG_ORDER_OVERRIDE_USER);
     fw_cfg_add_file(fw_cfg, name, buf, size);
-    fw_cfg_reset_order_override(fw_cfg);
     return 0;
 }
 
@@ -2672,7 +2669,6 @@ static void qemu_create_cli_devices(void)
     }
 
     /* init generic devices */
-    rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     qemu_opts_foreach(qemu_find_opts("device"),
                       device_init_func, NULL, &error_fatal);
     QTAILQ_FOREACH(opt, &device_opts, next) {
@@ -2683,7 +2679,6 @@ static void qemu_create_cli_devices(void)
         assert(ret_data == NULL); /* error_fatal aborts */
         loc_pop(&opt->loc);
     }
-    rom_reset_order_override();
 }
 
 static bool qemu_machine_creation_done(Error **errp)
-- 
2.47.1


