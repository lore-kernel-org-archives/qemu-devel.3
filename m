Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE68C07C79
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqfO-0001jn-JM; Fri, 19 Apr 2024 12:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeo-0001J0-Oz
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqei-0001CN-V5
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:00:10 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-416a8ec0239so12923445e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542401; x=1714147201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6P7o8S6krw4zIbaWf8/FAfVFQ5WX21YqyvLNU1xBMQ=;
 b=DXBR25VRIrQ7hjnyIHmY86KioCeemLOrhLpiYHQaMxMo3iNnnNbwYo99UkniBIJgoQ
 6BNJYEV8ViDCCuknFdWGtBkDgkKASs7+QcLzIF6rhmzGZk1Gj2bYtTBTdnoycMXDJgWy
 GdDry5hb+lPgBSc7zmIOsIta5cOxwsVmU6Yi+k8LydmOZedAJUXO7tzvjB1Te6kl52jV
 LjSqxoI20Ojnn7w0sVYv2s6JK9UOsUc1PyKnb5rrzqT1r6sdeoVI2TouozGbAfbWrKa9
 T7r+FSSJ0AouQEvkEDLTF4mtftFMWZktfOJW31c3+zv++uiCAFqz1RVLfrxXGVvPmdy/
 qvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542401; x=1714147201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6P7o8S6krw4zIbaWf8/FAfVFQ5WX21YqyvLNU1xBMQ=;
 b=taECDG5Wlb8+n8nGKzApvVazWrK8rF2bD982VmgM0Z42xrHGxrBV0v7+GA/j773SzV
 e35g21swNwcUa3qTb7Cqu/IbE31e5BqQLAf8ZnBEilvdXeyd09lWd4991et8ERoN1iBc
 A5+GbAQ4tPsNk51sw73+x+R4EKb8PQs9vAArbJMmFP3Vtdky0jW1hGUZImbVEIiU2aSU
 ayhLNcvQ3aoqne2IT4ckh6zyJ57ktWMe1J6oRmSMeYGEJZxRAcsemW/thy48xlNIWyjo
 UB+cGMjujexKzc8PDUI0JOMSYtWXDzvF9vo9klKYPZSYj4nySOSP+h0iOQ6BI8U8wFR0
 nxRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4VLNVLgCsCvr/S+xx6TLrEYB6BWa6vJX/WRdtTqDl6SVUn6MDsLcV8lW1WWAs2eGp7BnalwXEUBVkdK24AtjrXmmPWFY=
X-Gm-Message-State: AOJu0YzBITX4WsENhiYhfAAn3Iw0h04U7/0SydChBNyJLT00uUYGUHCk
 qXXJG8Xi4Pm5iio7cgCrwfo9aSljcFZY1EaDndvzYEDDNZIFFQn8XHu4LvpYi9o=
X-Google-Smtp-Source: AGHT+IFEr1Eo5za6le6H3Fb4UwnWLTfpVCPtzDo/B+w0JhgSprFb67NzI/c2JAIDkViPEw6yFPK5mA==
X-Received: by 2002:a05:600c:4ec8:b0:418:bdcd:e59b with SMTP id
 g8-20020a05600c4ec800b00418bdcde59bmr4354518wmq.7.1713542401270; 
 Fri, 19 Apr 2024 09:00:01 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 09:00:01 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 22/22] hw/arm/virt: Use RAM instead of flash for
 confidential guest firmware
Date: Fri, 19 Apr 2024 16:57:10 +0100
Message-ID: <20240419155709.318866-24-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240419155709.318866-2-jean-philippe@linaro.org>
References: <20240419155709.318866-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
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
v1->v2: new
---
 include/hw/arm/boot.h |  9 +++++++++
 hw/arm/boot.c         | 34 ++++++++++++++++++++++++++++++---
 hw/arm/virt.c         | 44 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 3 deletions(-)

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
index 9f522e332b..26c6334d52 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1154,7 +1154,31 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
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
 
@@ -1205,6 +1229,10 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
         }
     }
 
+    if (info->confidential) {
+        arm_setup_confidential_firmware_boot(cpu, info, firmware_filename);
+    }
+
     /*
      * We will start from address 0 (typically a boot ROM image) in the
      * same way as hardware. Leave env->boot_info NULL, so that
@@ -1243,9 +1271,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
     info->dtb_filename = ms->dtb;
     info->dtb_limit = 0;
 
-    /* Load the kernel.  */
+    /* Load the kernel and/or firmware. */
     if (!info->kernel_filename || info->firmware_loaded) {
-        arm_setup_firmware_boot(cpu, info);
+        arm_setup_firmware_boot(cpu, info, ms->firmware);
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index bed19d0b79..4a6281fc89 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1178,6 +1178,10 @@ static PFlashCFI01 *virt_flash_create1(VirtMachineState *vms,
 
 static void virt_flash_create(VirtMachineState *vms)
 {
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     vms->flash[0] = virt_flash_create1(vms, "virt.flash0", "pflash0");
     vms->flash[1] = virt_flash_create1(vms, "virt.flash1", "pflash1");
 }
@@ -1213,6 +1217,10 @@ static void virt_flash_map(VirtMachineState *vms,
     hwaddr flashsize = vms->memmap[VIRT_FLASH].size / 2;
     hwaddr flashbase = vms->memmap[VIRT_FLASH].base;
 
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     virt_flash_map1(vms->flash[0], flashbase, flashsize,
                     secure_sysmem);
     virt_flash_map1(vms->flash[1], flashbase + flashsize, flashsize,
@@ -1228,6 +1236,10 @@ static void virt_flash_fdt(VirtMachineState *vms,
     MachineState *ms = MACHINE(vms);
     char *nodename;
 
+    if (virt_machine_is_confidential(vms)) {
+        return;
+    }
+
     if (sysmem == secure_sysmem) {
         /* Report both flash devices as a single node in the DT */
         nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
@@ -1263,6 +1275,26 @@ static void virt_flash_fdt(VirtMachineState *vms,
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
+    memory_region_init_ram_guest_memfd(fw_ram, NULL, "fw_ram", fw_size, &error_fatal);
+    memory_region_add_subregion(sysmem, fw_base, fw_ram);
+
+    return true;
+}
+
 static bool virt_firmware_init(VirtMachineState *vms,
                                MemoryRegion *sysmem,
                                MemoryRegion *secure_sysmem)
@@ -1271,6 +1303,15 @@ static bool virt_firmware_init(VirtMachineState *vms,
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
@@ -2367,7 +2408,10 @@ static void machvirt_init(MachineState *machine)
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
2.44.0


