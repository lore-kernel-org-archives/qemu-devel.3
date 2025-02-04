Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3A3C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNM8-00059s-5g; Tue, 04 Feb 2025 13:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNLM-0004SQ-O6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:08:19 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNLG-0007BY-Mo
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:08:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso41399205e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738692489; x=1739297289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDsIdKnqwl6xn8PIFI2puBpK4XIK/vLL1vcgWpX1BsE=;
 b=FblNPHkYazaoEk+dHY8FmdFXgFhulkSq9LQn5aT4R+Vj3VlwEAD1c4BFRsMTJJbusF
 qKaJVrFF4h9hJ4WvUlinlmXz6mhriSAaFVyP2pyt0/Ta5+YiP1ogBp+CxEqK6fBSZudi
 I77uVTVV7YSFXzDCHctkTKr/j7NE6XiKao+WMMw4ODcenqKLvIkCvChOokXFiyYea0wU
 clZq1tIzzYodaK3z83meReYXodj2ga6+yTC9Tu+QskRL3Z5wTEOaLUVQ5yrIo5cwKbGk
 8HAO1oSaLVIXC39VBD8MwyZHc+zZ3WtzwuoRqEOpCPlfDzUkXFr3F9d5TkjtAoU3lMHR
 Fo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738692489; x=1739297289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDsIdKnqwl6xn8PIFI2puBpK4XIK/vLL1vcgWpX1BsE=;
 b=VW/CRmvlZOY9W9WfeaOH9a/lG7T7MwkgyjtI4+zgb99bYqhbDNPMeBT/a1XE/CJ8qu
 UPuvLn5mHXuqdHcNHwZeELXuhhfonXj3xsNAQE5mH0CG5we97XMzfIUoSm9Wxm1hZOK8
 5lk80CA3BXpWx+Bp0B1vd75VDoYNBdqyubXo6nHVlzyyyMWYfPCWNu+Gdvf0svKpNcG6
 bcTnUJ+J0TZxSK1bKVBKAGyddnW0IC8vQqsXglV/h/saib90gzPCc2RnOqBt7NluzUPb
 Auwi0t5BVp4FeIa82BX13bGXNxXaQ458t5w/chE43WDBMi04rMgNeXqIrBgZsRgWdyTX
 qq5A==
X-Gm-Message-State: AOJu0YxmbQ2kYDYBlXgoNk13JyXrd6QVRPRwt+sEp3BWeYIGtcsfhODV
 z6OAjJ3jk8MTRT1tbL/ojBkjq/620EAsfttc9SHbj6l1dKnmsC0uK4OsWFgnnU2ans2mROMsll/
 d7X4=
X-Gm-Gg: ASbGncsk3IG5rNfHF+CE+aNbC/dR/65W+cL0HvmA2bDWpMZQOL1+cDEXEPtrPKZPFGR
 PQ/pvte8Z6D/A11RsS8IRfmn41KrbIWANBM9y6IMB2frD6V9z9/KoOleIg+vmoWZz23f1rEY2Ci
 Fs5+A/XVJVcctOCdX9fr15+DYvLFVDQeMT5jfdhgnIz5IW9/tBwIhVW8KyhSRCdafat2Vx8mnId
 KhcDuk9HsCTcOaLdrRDhj0kCkEYE1ke+9ZE9vahL8guCiHyEtsPs41LIV2TR3y6te2hUDqinb+l
 Up7uQSL1EaySXeafqSYu8WqHXp4vBm95amQgrVDGmRSk8D8gGMKHnMMq2rOPMZFTSw==
X-Google-Smtp-Source: AGHT+IHxYwSb+HVFGuwXrEz1Y6b7n0w5+7dvVKeTMRBGtsW8JqKfE2tAq9U8EwZSyambrqOPiqzFuw==
X-Received: by 2002:a05:600c:3d19:b0:431:6083:cd38 with SMTP id
 5b1f17b1804b1-438dc3a81ccmr219800905e9.6.1738692488487; 
 Tue, 04 Feb 2025 10:08:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc819ebsm230750145e9.39.2025.02.04.10.08.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 10:08:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] hw/boards: Remove all invalid uses of
 auto_create_sdcard=true
Date: Tue,  4 Feb 2025 19:07:42 +0100
Message-ID: <20250204180746.58357-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204180746.58357-1-philmd@linaro.org>
References: <20250204180746.58357-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

MachineClass::auto_create_sdcard is only useful to automatically
create a SD card, attach a IF_SD block drive to it and plug the
card onto a SD bus. Only the ARM and RISCV targets use such
feature:

 $ git grep -wl IF_SD hw | cut -d/ -f-2 | sort -u
 hw/arm
 hw/riscv
 $

Remove all other uses.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/dp264.c                         | 1 -
 hw/avr/arduino.c                         | 1 -
 hw/hppa/machine.c                        | 2 --
 hw/i386/pc.c                             | 1 -
 hw/i386/x86.c                            | 1 -
 hw/i386/xen/xen-pvh.c                    | 1 -
 hw/loongarch/virt.c                      | 1 -
 hw/m68k/an5206.c                         | 1 -
 hw/m68k/mcf5208.c                        | 1 -
 hw/m68k/next-cube.c                      | 1 -
 hw/m68k/q800.c                           | 1 -
 hw/m68k/virt.c                           | 1 -
 hw/microblaze/petalogix_ml605_mmu.c      | 1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 -
 hw/microblaze/xlnx-zynqmp-pmu.c          | 1 -
 hw/mips/boston.c                         | 1 -
 hw/mips/fuloong2e.c                      | 1 -
 hw/mips/jazz.c                           | 2 --
 hw/mips/loongson3_virt.c                 | 1 -
 hw/mips/malta.c                          | 1 -
 hw/mips/mipssim.c                        | 1 -
 hw/openrisc/openrisc_sim.c               | 1 -
 hw/openrisc/virt.c                       | 1 -
 hw/ppc/amigaone.c                        | 1 -
 hw/ppc/e500.c                            | 3 ---
 hw/ppc/e500plat.c                        | 1 -
 hw/ppc/mac_newworld.c                    | 1 -
 hw/ppc/mac_oldworld.c                    | 1 -
 hw/ppc/mpc8544ds.c                       | 1 -
 hw/ppc/pegasos2.c                        | 1 -
 hw/ppc/pnv.c                             | 1 -
 hw/ppc/ppc405_boards.c                   | 1 -
 hw/ppc/ppc440_bamboo.c                   | 1 -
 hw/ppc/prep.c                            | 1 -
 hw/ppc/sam460ex.c                        | 1 -
 hw/ppc/spapr.c                           | 1 -
 hw/ppc/virtex_ml507.c                    | 1 -
 hw/remote/machine.c                      | 1 -
 hw/rx/rx-gdbsim.c                        | 1 -
 hw/sh4/r2d.c                             | 1 -
 hw/sparc/leon3.c                         | 1 -
 hw/sparc/sun4m.c                         | 1 -
 hw/sparc64/niagara.c                     | 1 -
 hw/sparc64/sun4u.c                       | 2 --
 hw/tricore/triboard.c                    | 1 -
 hw/tricore/tricore_testboard.c           | 1 -
 hw/xen/xen-pvh-common.c                  | 1 -
 hw/xenpv/xen_machine_pv.c                | 1 -
 hw/xtensa/sim.c                          | 1 -
 hw/xtensa/virt.c                         | 1 -
 hw/xtensa/xtfpga.c                       | 8 --------
 51 files changed, 63 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 14b942fd5a7..570ea9edf24 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,7 +213,6 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
     mc->default_ram_id = "ram";
     mc->default_nic = "e1000";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 5f30a7d5850..48ef478346e 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -67,7 +67,6 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->auto_create_sdcard = true;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a3d1cf5b2b6..b6135d95261 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -710,7 +710,6 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
-    mc->auto_create_sdcard = true;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
@@ -747,7 +746,6 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
-    mc->auto_create_sdcard = true;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cff5969f466..b46975c8a4d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1799,7 +1799,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
     mc->default_ram_id = "pc.ram";
-    mc->auto_create_sdcard = true;
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 790b1863f53..69bfc00b9a5 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,6 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    mc->auto_create_sdcard = true;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 6f5b6a2b8f5..33c10279763 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -82,7 +82,6 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Xen PVH x86 machine";
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
-    mc->auto_create_sdcard = true;
 
     /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
     mc->max_cpus = HVM_MAX_VCPUS;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 0eea84c9675..63fa0f4e32a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1471,7 +1471,6 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
-    mc->auto_create_sdcard = true;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 19478705129..d97399b882b 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -99,7 +99,6 @@ static void an5206_machine_init(MachineClass *mc)
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 9a8c551224f..75cc076f787 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,7 +398,6 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id = "mcf5208.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ee06a5e2e07..0570e4a76f1 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1359,7 +1359,6 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
     mc->no_cdrom = true;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo next_typeinfo = {
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index f3cb8541b37..aeed4c8ddb8 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -743,7 +743,6 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
-    mc->auto_create_sdcard = true;
     machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 69e8f53482d..d967bdd7438 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -318,7 +318,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->auto_create_sdcard = true;
     mc->default_ram_id = "m68k_virt.ram";
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 1e3d55dd3b4..8b44be75a22 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -220,7 +220,6 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
 #endif
     mc->init = petalogix_ml605_init;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 95b1b6483fd..2c0d8c34cd2 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -142,7 +142,6 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index b40d82b396f..bdbf7328bf4 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -188,7 +188,6 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
 #endif
     mc->init = xlnx_zynqmp_pmu_init;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 66cdad639e8..364c328032a 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -842,7 +842,6 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_ram_id = "boston.ddr";
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index e10b5a27743..646044e2749 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -335,7 +335,6 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
-    mc->auto_create_sdcard = true;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index ad4561a51e6..c89610639a9 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -424,7 +424,6 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -442,7 +441,6 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo mips_pica61_type = {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 46c2e1e9de5..831fddb1bd7 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -679,7 +679,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo loongson3_machine_types[] = {
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 31ff279b4cb..8e9cea70b13 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1306,7 +1306,6 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_malta.ram";
-    mc->auto_create_sdcard = true;
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index ff2b9050700..c530688e769 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -247,7 +247,6 @@ static void mips_mipssim_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_mipssim.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 5e4686ba7a2..e0da4067ba3 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -368,7 +368,6 @@ static void openrisc_sim_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = OR1KSIM_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 2764e398a98..7b60bf85094 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -554,7 +554,6 @@ static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 296c30da92f..b02792221cc 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -173,7 +173,6 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_display = "std";
     mc->default_ram_id = "ram";
     mc->default_ram_size = 512 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 7984dfce6f8..59208da87de 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1287,9 +1287,6 @@ static void e500_ccsr_initfn(Object *obj)
 
 static void ppce500_machine_class_init(ObjectClass *oc, void *data)
 {
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo e500_ccsr_info = {
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index afad4802cae..70a80333733 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -100,7 +100,6 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
-    mc->auto_create_sdcard = true;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 869f3f7104b..cb3dc3ab482 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -580,7 +580,6 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_display = "std";
     mc->default_nic = "sungem";
-    mc->auto_create_sdcard = true;
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 08e30a4a4e9..0dbcea035c3 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -427,7 +427,6 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "ne2k_pci";
     mc->ignore_boot_device_suffixes = true;
     mc->default_ram_id = "ppc_heathrow.ram";
-    mc->auto_create_sdcard = true;
     fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 38bdf453165..d74af766eed 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -62,7 +62,6 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
-    mc->auto_create_sdcard = true;
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index dd316fa7fa1..0364243f4fe 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -604,7 +604,6 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
-    mc->auto_create_sdcard = true;
     machine_add_audiodev_property(mc);
 
     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 15fbbf6c157..11fd477b71b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2878,7 +2878,6 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     /* Pnv provides a AHCI device for storage */
     mc->block_default_type = IF_IDE;
     mc->no_parallel = 1;
-    mc->auto_create_sdcard = true;
     mc->default_boot_order = NULL;
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 8946b5173c5..969cac345ac 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -351,7 +351,6 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
     mc->deprecation_reason = "machine is old and unmaintained";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo ppc405_machine_type = {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 081a993ef02..099fda39092 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -268,7 +268,6 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
     mc->default_ram_id = "ppc4xx.sdram";
     mc->default_nic = "e1000";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 85bfc2fd4f0..3e68d8e6e20 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -428,7 +428,6 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
-    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index d9c871ef205..3ecae6a9504 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -524,7 +524,6 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 42b07fadd9d..f3a4b4235d4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4594,7 +4594,6 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
-    mc->auto_create_sdcard = true;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc_spapr.ram";
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 22184fb6989..23238119273 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -288,7 +288,6 @@ static void virtex_machine_init(MachineClass *mc)
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
     mc->default_ram_id = "ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fa4a1bb815a..fdc6c441bbd 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -128,7 +128,6 @@ static void remote_machine_class_init(ObjectClass *oc, void *data)
 
     mc->init = remote_machine_init;
     mc->desc = "Experimental remote machine";
-    mc->auto_create_sdcard = true;
 
     hc->unplug = remote_machine_dev_unplug_cb;
 
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index de3b708bc57..88c8f12c101 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -166,7 +166,6 @@ static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RX62N_CPU;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "ext-sdram";
-    mc->auto_create_sdcard = true;
 }
 
 static void rx62n7_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e34deb33dce..d68c94e82ef 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -383,7 +383,6 @@ static void r2d_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
     mc->default_nic = "rtl8139";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 3bd24495758..0aeaad3becc 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -440,7 +440,6 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
     mc->max_cpus = MAX_CPUS;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d555548a1ca..a48d3622c5a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1113,7 +1113,6 @@ static void sun4m_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_display = "tcx";
     mc->default_ram_id = "sun4m.ram";
-    mc->auto_create_sdcard = true;
 }
 
 static void ss5_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 37004b99c4e..805ba6b1e3d 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -167,7 +167,6 @@ static void niagara_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_ram_id = "sun4v-partition.ram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo niagara_type = {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 6e9a3c5a2e5..8ab5cf0461f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -809,7 +809,6 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-    mc->auto_create_sdcard = true;
     fwc->get_dev_path = sun4u_fw_dev_path;
     compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
@@ -837,7 +836,6 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo sun4v_type = {
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index d4550507a99..f5baa8ccbb3 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -73,7 +73,6 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->init        = triboard_machine_init;
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
-    mc->auto_create_sdcard = true;
     amc->soc_name   = "tc277d-soc";
 };
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 9299cd5394a..3facfdfd611 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -111,7 +111,6 @@ static void ttb_machine_init(MachineClass *mc)
     mc->desc = "a minimal TriCore board";
     mc->init = tricoreboard_init;
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 9df50cd5382..9c21fa858d3 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -381,7 +381,6 @@ static void xen_pvh_class_init(ObjectClass *oc, void *data)
     mc->default_machine_opts = "accel=xen";
     /* Set to zero to make sure that the real ram size is passed. */
     mc->default_ram_size = 0;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xen_pvh_info = {
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index abdc5bc9a31..99c02492ef9 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -67,7 +67,6 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 989cfd49182..1cea29c66d4 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -125,7 +125,6 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->no_serial = 1;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 0a78ab3a6f9..b08404fc17c 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -122,7 +122,6 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("virt", xtensa_virt_machine_init)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index e00ae9d2e21..3f3677f1c9a 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -594,7 +594,6 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 64 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -612,7 +611,6 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 64 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -630,7 +628,6 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 96 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -648,7 +645,6 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 96 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -666,7 +662,6 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -684,7 +679,6 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -702,7 +696,6 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -720,7 +713,6 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
-- 
2.47.1


