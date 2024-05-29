Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBh9-0004fu-2G; Wed, 29 May 2024 01:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBh7-0004fD-ML
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCBh6-0005XE-1B
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:17:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-421124a04d6so14359515e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716959866; x=1717564666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaCMC4VTA5PCDTdrs4hE3YwemLrOkKOiTKlVZvMNghk=;
 b=wGBfBDN3rbrwV0HALvcTPXojytKqtM2y4GfYmpSNuoDJnaJKENURYvs5t2XIVK/MZQ
 iXBZCeAZKit7CNdExoixvC6ioKhCMoQwNURKVFnCt49tLJdZ59olzNw9vcl+5cr19+xL
 120IfBK+868qkkMBb9z14tWabzFpUQPQcThU9RzYw2azVWHLSoHSA0Sd1cM3rxEf76Mf
 5HtR8c6NglSm1L8YmIV3EBsJILDU68GzfF8NUzNxUqn2Ezx6z93zkwDrCmeOsMLuK1gb
 nxKiXtBor5bBdHQNzBgU9JbmsSKdK9r4d5zPW2iDRRptcu1ka9u8Ef4TIFkdbQTOjyAq
 UVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716959866; x=1717564666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaCMC4VTA5PCDTdrs4hE3YwemLrOkKOiTKlVZvMNghk=;
 b=VCH9ukdobzTAAcKoQjBNL1c+TUkKUpZLjfSQF8f9x+HRexvci+Lk7F38xbmAQkcxa4
 t0mlVVT28tsH0aRZHUG00Xh2lFbrxAtYitGyYbSTSOb9H29janN806Dr5lOcCrqjCUJ5
 XyeHIvTe+N5S29aUvbj5IBivWi7WC2WqD/H2lTawQiNNJKhUSuHlNIcRKogsOCC1ArDn
 5+nke59FPvqUsq6K8IWzcjHtxA1UXVtu2aakMqqS8k8DGUTua2uyHEq2fgGX6ZiiUm1v
 tFgU2WjmMduUNIvN7dBMWjeH2mr5qZBocm1XQ6z9tLN83J+z9T8HBZYUGwPuu5vDe479
 ckPA==
X-Gm-Message-State: AOJu0YwOOdat6ULv1aRMm/N8zPdz6q8ZtrhXGbRodqcq5zjTIKOIzNfQ
 Ama7rYfhf9PAICtnixomcMR2PoEiqm6dqmjPCqZjb3c5qqMlJTPZVmCBkjeKJy3xGpKzaQTFb4d
 s
X-Google-Smtp-Source: AGHT+IHwyLFnd1TLe8yRdF97RHd5f++rHUDlRWmZ2JGjfdY5NgvJoIy/zibixwWuIsshHwmc9c4f4Q==
X-Received: by 2002:a05:600c:1387:b0:420:e88b:6fb3 with SMTP id
 5b1f17b1804b1-42108964ad6mr99647425e9.0.1716959866263; 
 Tue, 28 May 2024 22:17:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42100fb9042sm199630475e9.39.2024.05.28.22.17.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 May 2024 22:17:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 23/23] hw/i386/pc: Replace PCMachineClass::acpi_data_size
 by PC_ACPI_DATA_SIZE
Date: Wed, 29 May 2024 07:15:39 +0200
Message-ID: <20240529051539.71210-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529051539.71210-1-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

PCMachineClass::acpi_data_size was only used by the pc-i440fx-2.0
machine, which got removed. Since it is constant, replace the class
field by a definition (local to hw/i386/pc.c, since not used
elsewhere).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h |  4 ----
 hw/i386/pc.c         | 19 ++++++++++++-------
 hw/i386/pc_piix.c    |  7 -------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 63568eb9e9..db26368ace 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -74,9 +74,6 @@ typedef struct PCMachineState {
  *
  * Compat fields:
  *
- * @acpi_data_size: Size of the chunk of memory at the top of RAM
- *                  for the BIOS ACPI tables and other BIOS
- *                  datastructures.
  * @gigabyte_align: Make sure that guest addresses aligned at
  *                  1Gbyte boundaries get mapped to host
  *                  addresses aligned at 1Gbyte boundaries. This
@@ -100,7 +97,6 @@ struct PCMachineClass {
 
     /* ACPI compat: */
     bool has_acpi_build;
-    unsigned acpi_data_size;
     int pci_root_uid;
 
     /* SMBIOS compat: */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b84c8ddba0..9dca3f0354 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -264,6 +264,16 @@ GlobalProperty pc_compat_2_4[] = {
 };
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
+/*
+ * @PC_ACPI_DATA_SIZE:
+ * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
+ * and other BIOS datastructures.
+ *
+ * BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K
+ * reported to be used at the moment, 32K should be enough for a while.
+ */
+#define PC_ACPI_DATA_SIZE (0x20000 + 0x8000)
+
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
@@ -645,8 +655,7 @@ void xen_load_linux(PCMachineState *pcms)
     fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     rom_set_fw(fw_cfg);
 
-    x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                   pcmc->pvh_enabled);
+    x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
     for (i = 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
@@ -980,8 +989,7 @@ void pc_memory_init(PCMachineState *pcms,
     }
 
     if (linux_boot) {
-        x86_load_linux(x86ms, fw_cfg, pcmc->acpi_data_size,
-                       pcmc->pvh_enabled);
+        x86_load_linux(x86ms, fw_cfg, PC_ACPI_DATA_SIZE, pcmc->pvh_enabled);
     }
 
     for (i = 0; i < nb_option_roms; i++) {
@@ -1737,9 +1745,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->has_reserved_memory = true;
     pcmc->enforce_amd_1tb_hole = true;
     pcmc->isa_bios_alias = true;
-    /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K reported
-     * to be used at the moment, 32K should be enough for a while.  */
-    pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
     x86mc->apic_xrupt_override = true;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e7f51a5f2c..e4930b7f48 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -414,13 +414,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
     pcms->south_bridge = PCSouthBridgeOption_lookup.array[value];
 }
 
-/* Looking for a pc_compat_2_4() function? It doesn't exist.
- * pc_compat_*() functions that run on machine-init time and
- * change global QEMU state are deprecated. Please don't create
- * one, and implement any pc-*-2.4 (and newer) compat code in
- * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
- */
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-- 
2.41.0


