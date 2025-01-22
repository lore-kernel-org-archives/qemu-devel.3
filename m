Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DF4C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 10:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taY2E-0002Iq-1C; Wed, 22 Jan 2025 05:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taY2C-0002IJ-Uj
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:32:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taY28-0005uR-RE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 05:32:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso4377635e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 02:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737541945; x=1738146745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Lc+q3saCS/w7IN/a5U6g/SgFDPz1VJaUexU4WrTXhAE=;
 b=iZeOb+zdYrtcbQfZJHlBUpZMTTQx/N1i/i4se2XXvd7dhTC1bqBvTMZmT6oqz1dhC9
 oO2954iCb8Cmcug9QlxGn64RR5SU5odBkeU/BEbqy/SvJlsvfm5kVwBsGoL946VtFEFp
 HI89arFKBJ85WR3BGFuAn0SWuUe4DNJuW+oopnV2NMPqJQ/uC/tnZihZODAeAP07DlyK
 nQtUr6eP1WtzqBBQ6Kyyqj4n44ttkm23IEjjPr1Tac17F4nn8HRxhuWhZpOeDnXAAebJ
 3wcpeYhuaqF8Og6Mlh6BMCdwGr61VEHojY1urNpsrm/w6Dp4g2cm1sj5aab5eymiwNI9
 Ec9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737541945; x=1738146745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lc+q3saCS/w7IN/a5U6g/SgFDPz1VJaUexU4WrTXhAE=;
 b=WEXbm3MHjat5DZgUNIBH+LVteZPKHsLxUuvq/iD2Zg2/x02G3Ah3f/fQqNbNRDAz2J
 oAUiXypcLziJnDcb6DYI6LL1lNQ4Pwr8MG9r0e90DbAWeXnPBq70DhgqM+ge/R8NMTNS
 yJr9RVxZhacnUNHecgpmSaXOm8w5eIYuGQrejtK27ye1cXojpLflNmdj7OPmISECEhBE
 tcz1a7qXHPSAYMumew9WFVKnLJgZ3mX267pSFzVOJsqLXQz3o/cRBMfq14bb/9rMr+VD
 Sw5WUqW7c5wcen9DpzDqtvBUHNKibU4wrZkKnToVjm7dDuSAeFdVxiEveo7yGKgcb1Pk
 zcFA==
X-Gm-Message-State: AOJu0YydDnhy3Qsc421eS+YKKvjIuDXIbF2GGvgMm522FGDGHAT3O6uE
 rCvORE0FR77M8uKqQ+sQTlWUDbMjYir/18JOZIYVIccLGqCTsOhasDXy8bESHyIhsTbgw1LOH/z
 KPz0=
X-Gm-Gg: ASbGnctezIecxL90htTtjGjrXmaX/FWVHwfVZxgHi3ndKUgwaTONwnaC/XGuP1PEaYk
 ZyHwn/5/GFr7iIQga6s0QEpyorJGA6LWEGJnby/weRmcc74NI0b2Wn374EJG+pfartCcjrh9Mm/
 Dg+w2fI83ShtCoEgWNBymS9s3nikFiVeQBNEtRwsduF9jKe2Y87OsgdlTVBGPZKQwOmmdUamgyS
 COPfW/ToX3BlYUk1z2s1emByBvxqaCycVcSh5MueeMIQolQBPbP5o8HsUDa0obLsTYmyDYv99Ns
 7WTuLHvw2VBpCMFZwhtxM034BlE53wCfTYslqNx8ivQN
X-Google-Smtp-Source: AGHT+IFUxJXKmskD24bm34KbZV3t8HGKDgxwVhpi7iJNT7Bl9GXBRCkkMGRpfZEra2bZC40/R5D0ZA==
X-Received: by 2002:a05:600c:218e:b0:434:e65e:457b with SMTP id
 5b1f17b1804b1-437c6ae9bdcmr261448295e9.3.1737541945115; 
 Wed, 22 Jan 2025 02:32:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31adbd7sm19630075e9.17.2025.01.22.02.32.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 02:32:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] hw/boards: Convert MachineClass bitfields to boolean
Date: Wed, 22 Jan 2025 11:32:23 +0100
Message-ID: <20250122103223.55523-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

As Daniel mentioned:

 "The number of instances of MachineClass is not large enough
  that we save a useful amount of memory through bitfields."

Also, see recent commit ecbf3567e21 ("docs/devel/style: add a
section about bitfield, and disallow them for packed structures").

Convert the MachineClass bitfields used as boolean as real ones.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h        | 14 +++++++-------
 hw/arm/aspeed.c            |  6 +++---
 hw/arm/fby35.c             |  4 ++--
 hw/arm/npcm7xx_boards.c    |  6 +++---
 hw/arm/raspi.c             |  6 +++---
 hw/arm/sbsa-ref.c          |  2 +-
 hw/arm/virt.c              |  2 +-
 hw/arm/xilinx_zynq.c       |  2 +-
 hw/avr/arduino.c           |  6 +++---
 hw/core/null-machine.c     | 10 +++++-----
 hw/i386/microvm.c          |  2 +-
 hw/i386/pc_piix.c          |  2 +-
 hw/i386/pc_q35.c           |  4 ++--
 hw/loongarch/virt.c        |  2 +-
 hw/m68k/virt.c             |  6 +++---
 hw/ppc/pnv.c               |  2 +-
 hw/ppc/spapr.c             |  2 +-
 hw/riscv/virt.c            |  2 +-
 hw/s390x/s390-virtio-ccw.c |  8 ++++----
 hw/xtensa/sim.c            |  2 +-
 20 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2ad711e56db..ff5904d6fd8 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -279,13 +279,13 @@ struct MachineClass {
     int max_cpus;
     int min_cpus;
     int default_cpus;
-    unsigned int no_serial:1,
-        no_parallel:1,
-        no_floppy:1,
-        no_cdrom:1,
-        no_sdcard:1,
-        pci_allow_0_address:1,
-        legacy_fw_cfg_order:1;
+    bool no_serial;
+    bool no_parallel;
+    bool no_floppy;
+    bool no_cdrom;
+    bool no_sdcard;
+    bool pci_allow_0_address;
+    bool legacy_fw_cfg_order;
     bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index a18d4ed1fb1..dc91052e94d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1225,9 +1225,9 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
 
     mc->init = aspeed_machine_init;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->no_parallel = 1;
+    mc->no_floppy = true;
+    mc->no_cdrom = true;
+    mc->no_parallel = true;
     mc->default_ram_id = "ram";
     amc->macs_mask = ASPEED_MAC0_ON;
     amc->uart_default = ASPEED_DEV_UART5;
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 83d08e578b7..04d0eb9b0c1 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -168,8 +168,8 @@ static void fby35_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Meta Platforms fby35";
     mc->init = fby35_init;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
+    mc->no_floppy = true;
+    mc->no_cdrom = true;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
 
     object_class_property_add_bool(oc, "execute-in-place",
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 7727e0dc4bb..c9735b357cd 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -461,9 +461,9 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
         NULL
     };
 
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->no_parallel = 1;
+    mc->no_floppy = true;
+    mc->no_cdrom = true;
+    mc->no_parallel = true;
     mc->default_ram_id = "ram";
     mc->valid_cpu_types = valid_cpu_types;
 }
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a7a662f40db..665ccd9b50b 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -322,9 +322,9 @@ void raspi_machine_class_common_init(MachineClass *mc,
                                board_type(board_rev),
                                FIELD_EX32(board_rev, REV_CODE, REVISION));
     mc->block_default_type = IF_SD;
-    mc->no_parallel = 1;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
+    mc->no_parallel = true;
+    mc->no_floppy = true;
+    mc->no_cdrom = true;
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     mc->default_ram_id = "ram";
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 6183111f2de..33c6b9ea3ec 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -899,7 +899,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->pci_allow_0_address = true;
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
-    mc->no_cdrom = 1;
+    mc->no_cdrom = true;
     mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99e0a68b6c5..8de57be1d1c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3124,7 +3124,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
     mc->block_default_type = IF_VIRTIO;
-    mc->no_cdrom = 1;
+    mc->no_cdrom = true;
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8477b828745..ac51fb512db 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -463,7 +463,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = true;
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 48ef478346e..a7229da38aa 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -64,9 +64,9 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = 1;
     mc->min_cpus = mc->default_cpus;
     mc->max_cpus = mc->default_cpus;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->no_parallel = 1;
+    mc->no_floppy = true;
+    mc->no_cdrom = true;
+    mc->no_parallel = true;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f586a4bef54..0655343ff59 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -49,11 +49,11 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->max_cpus = 1;
     mc->default_ram_size = 0;
     mc->default_ram_id = "ram";
-    mc->no_serial = 1;
-    mc->no_parallel = 1;
-    mc->no_floppy = 1;
-    mc->no_cdrom = 1;
-    mc->no_sdcard = 1;
+    mc->no_serial = true;
+    mc->no_parallel = true;
+    mc->no_floppy = true;
+    mc->no_cdrom = true;
+    mc->no_sdcard = true;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index a8d354aabe5..c804a39debe 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -649,7 +649,7 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->family = "microvm_i386";
     mc->desc = "microvm (i386)";
     mc->units_per_default_bus = 1;
-    mc->no_floppy = 1;
+    mc->no_floppy = true;
     mc->max_cpus = 288;
     mc->has_hotpluggable_cpus = false;
     mc->auto_enable_numa_with_memhp = false;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 04d2957adcd..0eda900b036 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -773,7 +773,7 @@ static void pc_i440fx_machine_2_5_options(MachineClass *m)
 
     pc_i440fx_machine_2_6_options(m);
     x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
+    m->legacy_fw_cfg_order = true;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 77536dd697f..444c8c5f0f6 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -348,7 +348,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->default_display = "std";
     m->default_nic = "e1000e";
     m->default_kernel_irqchip_split = false;
-    m->no_floppy = 1;
+    m->no_floppy = true;
     m->max_cpus = 4096;
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
@@ -668,7 +668,7 @@ static void pc_q35_machine_2_5_options(MachineClass *m)
 
     pc_q35_machine_2_6_options(m);
     x86mc->save_tsc_khz = false;
-    m->legacy_fw_cfg_order = 1;
+    m->legacy_fw_cfg_order = true;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 63fa0f4e32a..0077c22962b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1470,7 +1470,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->default_kernel_irqchip_split = false;
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
-    mc->no_cdrom = 1;
+    mc->no_cdrom = true;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 87ec39eeae1..09fde6cfebd 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -315,9 +315,9 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "QEMU M68K Virtual Machine";
     mc->init = virt_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
-    mc->max_cpus = 1;
-    mc->no_floppy = 1;
-    mc->no_parallel = 1;
+    mc->max_cpus = true;
+    mc->no_floppy = true;
+    mc->no_parallel = true;
     mc->default_ram_id = "m68k_virt.ram";
 }
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 11fd477b71b..4897a711259 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2877,7 +2877,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = MAX_CPUS;
     /* Pnv provides a AHCI device for storage */
     mc->block_default_type = IF_IDE;
-    mc->no_parallel = 1;
+    mc->no_parallel = true;
     mc->default_boot_order = NULL;
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 623842f8064..5bbab1d470f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4593,7 +4593,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
-    mc->no_parallel = 1;
+    mc->no_parallel = true;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc_spapr.ram";
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 241389d72f8..88612429cb3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1917,7 +1917,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
-    mc->no_cdrom = 1;
+    mc->no_cdrom = true;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 38aeba14eeb..af150cf6155 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -785,10 +785,10 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->init = ccw_init;
     mc->reset = s390_machine_reset;
     mc->block_default_type = IF_VIRTIO;
-    mc->no_cdrom = 1;
-    mc->no_floppy = 1;
-    mc->no_parallel = 1;
-    mc->no_sdcard = 1;
+    mc->no_cdrom = true;
+    mc->no_floppy = true;
+    mc->no_parallel = true;
+    mc->no_sdcard = true;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->smp_props.books_supported = true;
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 0a1fd900376..e06a8c1813c 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -122,7 +122,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->init = xtensa_sim_init;
     mc->max_cpus = 4;
-    mc->no_serial = 1;
+    mc->no_serial = true;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
 }
 
-- 
2.47.1


