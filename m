Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6DDD59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFT-0005UD-K7; Mon, 25 Nov 2024 14:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFL-0005Fl-Gp
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:47 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFB-0004rC-GO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a2033562so6799455e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564776; x=1733169576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1bXq+74SiZeUGfQFbFaJNCrHb1OmghaBQp3KgUN++M=;
 b=dKeMCTX54+W7PJHxGuXJ+vxE8Jd/SmgrPHiwnmgUZRBV31WEa9//sWVTQppiTTEC+H
 zs6Tm2x2V2L2Xdmxza6XH1voeNdVy4Im7ntaLaEH+bJTqB7BO9tvO8dshbONPWBUJf+w
 HSnWtZlET6usH7HlnvQNGpr/44Me2qw3/Rq+wAQjK/2Md8pF+ZHhAXgtAirCNBETirA4
 VXw1MmYLYGqVjZsFhHDM0UzcjTCBhcJmC6I/15/M3qyxsH27fl25QOgm0xiL2zCPFf9C
 f4XtiV/T9l7ubL8GHT28WzYbDOHeZNJlK7LXuILRsTeyzfCejo+AayvF/DHwMWYNLp18
 GN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564776; x=1733169576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1bXq+74SiZeUGfQFbFaJNCrHb1OmghaBQp3KgUN++M=;
 b=IEztW1gdrxiI8MSyzBXHFlkCYAtiYfnn46qyiV9l43m+RvwOxg7WXWyh5SojlFAKBo
 5jioUrRwzDT2w0SyX9c1S7tj5FqBlGRjdg82uTm828fmV40SjpF6NMMh2E3c4HReT625
 oDnvWi9AcfFwbTa9SAuaCdFp7WOVK63YlN4MlusrO0QQsAcUfyIqJInVpw2YvAlyUKd0
 Xbyxxfj8bBCTv1R4u2BlFIblLm9DJlpkVLneLOim7ffiLfNO5bmCK/COctXqwRD/a+eR
 2xQoPJH5CpI6Z8sAurZDCDrsMwNLXYgCauaiUF/7ppH8AgxaiONTLZh8lHgSDNadsltb
 NzmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMOJmU8PejbS5MhpUZYg+l1tJ9kqD9IHdCf1xmnZxuthm3Ib/JRcDiAsmaVnWorrwuLXAlS9pNLWyo@nongnu.org
X-Gm-Message-State: AOJu0YyuINdhGwCfEEhCR9yMtmZt9KcVDI1eOhOh6nsP2IFFzDXZfTrv
 WVD55O0qSj7cbg6DqqnqJB+ThCey188TuALXYIcD3JvOzVT18aSlEehwUUYTpYU=
X-Gm-Gg: ASbGncu39ICNUGk/WAq5qJo2jiQbRDz2DmjwNSgZyCDxuE2WtUSUdl7nZvS5neSqlOn
 GbjEdrWrUw5mG3cFzQt6scmfVKPSLHdUNMiVbXI6WEv708cxxXWF7uHm5wf8P3vzltlqCS+Pph+
 9C9GDPJDG1tzE5s3cbjvqGKqvZiBj0cYGh20crJcszNiIzKSxtdMD/RKDpraBtKQ6CNXTSXRhtn
 JAsmW8rfyxdr5qQfCK0o28z+YpwW5IXF0Ds1sWdQ4LO+syKgAlDw8/bIh33pJBEcCGt
X-Google-Smtp-Source: AGHT+IFQgR9S9GvWuMKUvIDpUn9BlZAf2a1+Fz9wP/Nv1NRFaz6POwZPlcO/sIKSbai/bFFqVIoa7g==
X-Received: by 2002:a05:6000:4026:b0:382:3400:1ee9 with SMTP id
 ffacd0b85a97d-38260b5d6c1mr13383314f8f.14.1732564775976; 
 Mon, 25 Nov 2024 11:59:35 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:35 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v3 20/26] hw/arm/virt: Use RAM instead of flash for
 confidential guest firmware
Date: Mon, 25 Nov 2024 19:56:19 +0000
Message-ID: <20241125195626.856992-22-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
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

The flash device that holds firmware code relies on read-only stage-2
mappings. Read accesses behave as RAM and write accesses as MMIO. Since
the RMM does not support read-only mappings we cannot use the flash
device as-is.

That isn't a problem because the firmware does not want to disclose any
information to the host, hence will not store its variables in clear
persistent memory. We can therefore replace the flash device with RAM,
and load the firmware there.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/hw/arm/boot.h |  9 +++++++++
 hw/arm/boot.c         | 32 ++++++++++++++++++++++++++++--
 hw/arm/virt.c         | 45 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 80c492d742..d91cfc6942 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -112,6 +112,10 @@ struct arm_boot_info {
      */
     bool firmware_loaded;
 
+    /* Used when loading firmware into RAM */
+    hwaddr firmware_base;
+    hwaddr firmware_max_size;
+
     /* Address at which board specific loader/setup code exists. If enabled,
      * this code-blob will run before anything else. It must return to the
      * caller via the link register. There is no stack set up. Enabled by
@@ -132,6 +136,11 @@ struct arm_boot_info {
     bool secure_board_setup;
 
     arm_endianness endianness;
+
+    /*
+     * Confidential guest boot loads everything into RAM so it can be measured.
+     */
+    bool confidential;
 };
 
 /**
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a2414b1f98..4cf7dd5b4d 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1150,7 +1150,31 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
 }
 
-static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
+static void arm_setup_confidential_firmware_boot(ARMCPU *cpu,
+                                                 struct arm_boot_info *info,
+                                                 const char *firmware_filename)
+{
+    ssize_t fw_size;
+    const char *fname;
+    AddressSpace *as = arm_boot_address_space(cpu, info);
+
+    fname = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware_filename);
+    if (!fname) {
+        error_report("Could not find firmware image '%s'", firmware_filename);
+        exit(1);
+    }
+
+    fw_size = load_image_targphys_as(firmware_filename,
+                                     info->firmware_base,
+                                     info->firmware_max_size, as);
+    if (fw_size <= 0) {
+        error_report("could not load firmware '%s'", firmware_filename);
+        exit(1);
+    }
+}
+
+static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info,
+                                    const char *firmware_filename)
 {
     /* Set up for booting firmware (which might load a kernel via fw_cfg) */
 
@@ -1201,6 +1225,10 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
         }
     }
 
+    if (info->confidential) {
+        arm_setup_confidential_firmware_boot(cpu, info, firmware_filename);
+    }
+
     /*
      * We will start from address 0 (typically a boot ROM image) in the
      * same way as hardware. Leave env->boot_info NULL, so that
@@ -1244,7 +1272,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
 
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
-        arm_setup_firmware_boot(cpu, info);
+        arm_setup_firmware_boot(cpu, info, ms->firmware);
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c4cf69ea33..0750c83fae 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1228,6 +1228,10 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
 
 static void virt_flash_create(VirtMachineState *vms)
 {
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     vms->flash[0] = virt_flash_create1(vms, "virt.flash0", "pflash0");
     vms->flash[1] = virt_flash_create1(vms, "virt.flash1", "pflash1");
 }
@@ -1263,6 +1267,10 @@ static void virt_flash_map(VirtMachineState *vms,
     hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
 
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     virt_flash_map1(vms->flash[0], flashbase, flashsize,
                     secure_sysmem);
     virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
@@ -1278,6 +1286,10 @@ static void virt_flash_fdt(VirtMachineState *vms,
     MachineState *ms = MACHINE(vms);
     char *nodename;
 
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
@@ -1313,6 +1325,27 @@ static void virt_flash_fdt(VirtMachineState *vms,
     }
 }
 
+static bool virt_confidential_firmware_init(VirtMachineState *vms,
+                                            MemoryRegion *sysmem)
+{
+    MemoryRegion *fw_ram;
+    hwaddr fw_base = vms->memmap[VIRT_FLASH].base;
+    hwaddr fw_size = vms->memmap[VIRT_FLASH].size;
+
+    if (!MACHINE(vms)->firmware) {
+        return false;
+    }
+
+    assert(machine_require_guest_memfd(MACHINE(vms)));
+
+    fw_ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram_guest_memfd(fw_ram, NULL, "fw_ram", fw_size,
+                                       &error_fatal);
+    memory_region_add_subregion(sysmem, fw_base, fw_ram);
+
+    return true;
+}
+
 static bool virt_firmware_init(VirtMachineState *vms,
                                MemoryRegion *sysmem,
                                MemoryRegion *secure_sysmem)
@@ -1321,6 +1354,15 @@ static bool virt_firmware_init(VirtMachineState *vms,
     const char *bios_name;
     BlockBackend *pflash_blk0;
 
+    /*
+     * For a confidential VM, the firmware image and any boot information,
+     * including EFI variables, are stored in RAM in order to be measurable and
+     * private. Create a RAM region and load the firmware image there.
+     */
+    if (virt_machine_is_confidential(vms)) {
+        return virt_confidential_firmware_init(vms, sysmem);
+    }
+
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(vms->flash); i++) {
         pflash_cfi01_legacy_drive(vms->flash[i],
@@ -2463,7 +2505,10 @@ static void machvirt_init(MachineState *machine)
     vms->bootinfo.get_dtb = machvirt_dtb;
     vms->bootinfo.skip_dtb_autoload = true;
     vms->bootinfo.firmware_loaded = firmware_loaded;
+    vms->bootinfo.firmware_base = vms->memmap[VIRT_FLASH].base;
+    vms->bootinfo.firmware_max_size = vms->memmap[VIRT_FLASH].size;
     vms->bootinfo.psci_conduit = vms->psci_conduit;
+    vms->bootinfo.confidential = virt_machine_is_confidential(vms);
     arm_load_kernel(ARM_CPU(first_cpu), machine, &vms->bootinfo);
 
     vms->machine_done.notify = virt_machine_done;
-- 
2.47.0


