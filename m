Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D062D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObrl-0003BI-8U; Thu, 27 Nov 2025 08:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqf-0002di-LL
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqb-0001Fa-02
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZPYZfIg9aIq3WhaJrg7dI2pXao3E9mhCt8SPaUEuDGk=;
 b=YF7MGWBGEpLySD6EeyGOwwde9HqmBqgsCn9Vy0n2klUdYOSsBNuyKS8db2O+MkVbVopZ/4
 mucqMAPcIhodEDBv/tXPGjSq6Tz22lVnYBg+1IUHICSHvyUR8WeVB4UyvVyjS3/veK/dYi
 dLZpUjj41Ri83slEzfLMQRV5JrVzV8Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-JM2k2DCSPVasrpsViR42lQ-1; Thu, 27 Nov 2025 08:15:42 -0500
X-MC-Unique: JM2k2DCSPVasrpsViR42lQ-1
X-Mimecast-MFC-AGG-ID: JM2k2DCSPVasrpsViR42lQ_1764249341
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b73599315adso73488066b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249341; x=1764854141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZPYZfIg9aIq3WhaJrg7dI2pXao3E9mhCt8SPaUEuDGk=;
 b=NT1+kgPGUpKAjHF5ds/jWwzVoBUP6jYpe+q9p75LWbzYJrdnZO0B7yrZpmb9KrmS/G
 +4rMziPEGwNEgU1kZp077974vxMxC4wFYhBNkpJ8fZ64vsa0asU6nc3cPAt998/0xH4z
 NZ5OrjXIhKISiLvgF+UUxUEek5EPNpeYdbl7RGokKmw7N/+C+HfDK/5QTIE88HMyaTqT
 sFOyzox+SEZ1zYWMBbRgt2ldt3xsK3EhlzmfS/tO6TMqhCY/tg5/5F61NzwdWz+mYTdy
 k6p7AVdkBfXD+bvk/hM1uUV9fVrVCZIPFYO2ITj3NY3/9pp5zrPO2y67VV/RS3HS4Nxd
 +emA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249341; x=1764854141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZPYZfIg9aIq3WhaJrg7dI2pXao3E9mhCt8SPaUEuDGk=;
 b=UixcAZrErIIqbUL3tWwTiG03jRzaLASTCQqsKgBlmF8Qa34KUd/vVPMwAGnOly1gSf
 JQ9Rtef+1oKMPrafXrR3Ts5Dh3E55m17MgsJdc5nsZjxoubSSdBbhiHMYyqQaltTTbkp
 zq/JqRYfaAOAmJQpBjLPqaCESnZcSivt0jJM3bdmHHH2MJkvcRFy+aosmt2buq3+bUMX
 /3+Q58MokwJgusReUNs1XQpu1d9iHGdX0cGCsm8QJ8DXTIBgvUSIi+02ni+8W8ukIhGC
 Sym1PkWrc2kuwWW3TxXYBiW0IY6xiIwvDxuL7XZ49BP/7c4vJyTrF1xdwt9dJgDnkDhW
 rbBg==
X-Gm-Message-State: AOJu0YwiVHjPmmutuni5Q4yG0FtZBRUcheZp+5y1UhBuqK4hPCtYiV54
 m8XwICSJ8ztmgahguRBqjr+JIztGtJlRja+cOv2YzxRLf4/x3OouRhOzbAEfarPgXT20GYPUKSz
 hHdSESC+CtVy1Oftz3knZLNaJvVYRxQC1c4ZQELH4/GHOdOy+z4ItmgFBdR6rV4Qj7wnO/3TBOL
 qlfKw5AcU5cb1jJuCZMRo0mW0brcZFjrWFdmMYJarT
X-Gm-Gg: ASbGncvdeF3MkbJ5ASZZiv3kQnFQntfGhT+LXWBB5dqmjGYcYmAKtaVm9+E4Fp0wwvJ
 MSg469f12PJQy2RvYf+HXZT1lV/amN3WOQdit09/t8mnTk1U4btriZZA2R7xa+pUZh1v5QOWora
 c34OEYkVjSm+872jqt4DxCyAHp65q2912IMiOGOG2QiDFYULheADQYPKM5kzL25FMTFFckL8nsR
 v5pOHN5XtQLEaQ+oqhjhy25ecBuG+eKDqCAtRG0l3SSr14Vhuhb5Bkv/xzsHRZh7gYIZC1Y9p14
 w9kGY+8Gmv49Psx3M+zLrhkFrat88uyYXmVut3v74aK84JFV6vlzTE1q87oETuneXa2x4NTB56O
 QYLKA7cQ5LSNgIgGKZfHvjt6vJ+EvTYAjTPSn6RsZnSKCyJ7qCM4F7A23tww3hu1vUNR8cOurUZ
 VDLX6xKLikj0ivcps=
X-Received: by 2002:a17:907:7f1b:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b76c53c3547mr1054526566b.22.1764249339364; 
 Thu, 27 Nov 2025 05:15:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8qRdozv2I7+EnwvEunzhvlvHUdDxACXhdjRhRv5ZCCivZ2DaBp/2+Am5BhwWaShrKs09pcg==
X-Received: by 2002:a17:907:7f1b:b0:b4f:e12e:aa24 with SMTP id
 a640c23a62f3a-b76c53c3547mr1054512666b.22.1764249337742; 
 Thu, 27 Nov 2025 05:15:37 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5162088sm162930366b.1.2025.11.27.05.15.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/28] include: move hw/loader.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:58 +0100
Message-ID: <20251127131516.80807-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/{ => core}/loader.h  | 0
 include/hw/riscv/boot.h         | 2 +-
 hw/acpi/utils.c                 | 2 +-
 hw/alpha/dp264.c                | 2 +-
 hw/arm/allwinner-a10.c          | 2 +-
 hw/arm/allwinner-h3.c           | 2 +-
 hw/arm/allwinner-r40.c          | 2 +-
 hw/arm/armv7m.c                 | 2 +-
 hw/arm/aspeed_ast27x0-fc.c      | 2 +-
 hw/arm/aspeed_soc_common.c      | 2 +-
 hw/arm/boot.c                   | 2 +-
 hw/arm/digic_boards.c           | 2 +-
 hw/arm/exynos4210.c             | 2 +-
 hw/arm/highbank.c               | 2 +-
 hw/arm/npcm7xx.c                | 2 +-
 hw/arm/npcm7xx_boards.c         | 2 +-
 hw/arm/npcm8xx.c                | 2 +-
 hw/arm/npcm8xx_boards.c         | 2 +-
 hw/arm/raspi.c                  | 2 +-
 hw/arm/raspi4b.c                | 2 +-
 hw/arm/sbsa-ref.c               | 2 +-
 hw/arm/vexpress.c               | 2 +-
 hw/arm/virt.c                   | 2 +-
 hw/arm/xilinx_zynq.c            | 2 +-
 hw/avr/boot.c                   | 2 +-
 hw/core/generic-loader.c        | 2 +-
 hw/core/guest-loader.c          | 2 +-
 hw/core/loader-fit.c            | 2 +-
 hw/core/loader.c                | 2 +-
 hw/core/machine.c               | 2 +-
 hw/display/artist.c             | 2 +-
 hw/display/cg3.c                | 2 +-
 hw/display/cirrus_vga_isa.c     | 2 +-
 hw/display/next-fb.c            | 2 +-
 hw/display/ramfb-standalone.c   | 2 +-
 hw/display/ramfb.c              | 2 +-
 hw/display/tcx.c                | 2 +-
 hw/display/vga-isa.c            | 2 +-
 hw/display/vga-pci.c            | 2 +-
 hw/display/vmware_vga.c         | 2 +-
 hw/hppa/machine.c               | 2 +-
 hw/hyperv/syndbg.c              | 2 +-
 hw/i386/microvm.c               | 2 +-
 hw/i386/multiboot.c             | 2 +-
 hw/i386/pc.c                    | 2 +-
 hw/i386/pc_q35.c                | 2 +-
 hw/i386/pc_sysfw.c              | 2 +-
 hw/i386/x86-common.c            | 2 +-
 hw/ipmi/ipmi_bmc_sim.c          | 2 +-
 hw/loongarch/boot.c             | 2 +-
 hw/loongarch/virt-fdt-build.c   | 2 +-
 hw/loongarch/virt.c             | 2 +-
 hw/m68k/an5206.c                | 2 +-
 hw/m68k/mcf5208.c               | 2 +-
 hw/m68k/next-cube.c             | 2 +-
 hw/m68k/q800.c                  | 2 +-
 hw/m68k/virt.c                  | 2 +-
 hw/microblaze/boot.c            | 2 +-
 hw/mips/boston.c                | 2 +-
 hw/mips/fuloong2e.c             | 2 +-
 hw/mips/jazz.c                  | 2 +-
 hw/mips/loongson3_virt.c        | 2 +-
 hw/mips/malta.c                 | 2 +-
 hw/nubus/nubus-device.c         | 2 +-
 hw/nvram/fw_cfg.c               | 2 +-
 hw/openrisc/boot.c              | 2 +-
 hw/pci/pci.c                    | 2 +-
 hw/ppc/amigaone.c               | 2 +-
 hw/ppc/e500.c                   | 2 +-
 hw/ppc/mac_newworld.c           | 2 +-
 hw/ppc/mac_oldworld.c           | 2 +-
 hw/ppc/pegasos.c                | 2 +-
 hw/ppc/pnv.c                    | 2 +-
 hw/ppc/pnv_pnor.c               | 2 +-
 hw/ppc/ppc440_bamboo.c          | 2 +-
 hw/ppc/ppc_booke.c              | 2 +-
 hw/ppc/prep.c                   | 2 +-
 hw/ppc/sam460ex.c               | 2 +-
 hw/ppc/spapr.c                  | 2 +-
 hw/ppc/spapr_vio.c              | 2 +-
 hw/ppc/virtex_ml507.c           | 2 +-
 hw/riscv/boot.c                 | 2 +-
 hw/riscv/microchip_pfsoc.c      | 2 +-
 hw/riscv/sifive_e.c             | 2 +-
 hw/riscv/sifive_u.c             | 2 +-
 hw/riscv/spike.c                | 2 +-
 hw/riscv/virt.c                 | 2 +-
 hw/rx/rx-gdbsim.c               | 2 +-
 hw/rx/rx62n.c                   | 2 +-
 hw/s390x/ipl.c                  | 2 +-
 hw/sh4/r2d.c                    | 2 +-
 hw/smbios/smbios.c              | 2 +-
 hw/sparc/leon3.c                | 2 +-
 hw/sparc/sun4m.c                | 2 +-
 hw/sparc64/niagara.c            | 2 +-
 hw/sparc64/sun4u.c              | 2 +-
 hw/tricore/tc27x_soc.c          | 2 +-
 hw/tricore/triboard.c           | 2 +-
 hw/tricore/tricore_testboard.c  | 2 +-
 hw/virtio/vhost-user-scsi-pci.c | 2 +-
 hw/virtio/virtio-pci.c          | 2 +-
 hw/vmapple/vmapple.c            | 2 +-
 hw/xen/xen_pt_load_rom.c        | 2 +-
 hw/xtensa/sim.c                 | 2 +-
 hw/xtensa/virt.c                | 2 +-
 hw/xtensa/xtfpga.c              | 2 +-
 semihosting/arm-compat-semi.c   | 2 +-
 system/device_tree.c            | 2 +-
 system/globals.c                | 2 +-
 system/vl.c                     | 2 +-
 target/arm/cpu.c                | 2 +-
 target/loongarch/kvm/kvm.c      | 2 +-
 target/openrisc/interrupt.c     | 2 +-
 target/openrisc/mmu.c           | 2 +-
 target/riscv/kvm/kvm-cpu.c      | 2 +-
 target/rx/cpu.c                 | 2 +-
 116 files changed, 115 insertions(+), 115 deletions(-)
 rename include/hw/{ => core}/loader.h (100%)

diff --git a/include/hw/loader.h b/include/hw/core/loader.h
similarity index 100%
rename from include/hw/loader.h
rename to include/hw/core/loader.h
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 51b0e13bd3e..35964bf8318 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -21,7 +21,7 @@
 #define RISCV_BOOT_H
 
 #include "exec/cpu-defs.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/riscv/riscv_hart.h"
 
 #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
diff --git a/hw/acpi/utils.c b/hw/acpi/utils.c
index 0c486ea29fa..b7cab6f5ca1 100644
--- a/hw/acpi/utils.c
+++ b/hw/acpi/utils.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 
 MemoryRegion *acpi_add_rom_blob(FWCfgCallback update, void *opaque,
                                 GArray *blob, const char *name)
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index b6155646ef7..cddd94fec82 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -10,7 +10,7 @@
 #include "cpu.h"
 #include "exec/target_page.h"
 #include "elf.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "alpha_sys.h"
 #include "qemu/error-report.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 1886df03839..d7508ee0ecd 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -26,7 +26,7 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/usb/hcd-ohci.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "target/arm/cpu-qom.h"
 
 #define AW_A10_SRAM_A_BASE      0x00000000
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index edffc21dd88..6c4c369e991 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -27,7 +27,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "system/system.h"
 #include "hw/arm/allwinner-h3.h"
 #include "target/arm/cpu-qom.h"
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 313bd21fad8..f6d4117a068 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -28,7 +28,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "system/system.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/misc/allwinner-r40-dramc.h"
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7fa1b37630e..8198a83d15c 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "elf.h"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index a0cbe50d78d..1678cce416b 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -18,7 +18,7 @@
 #include "hw/core/boards.h"
 #include "hw/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 78b6ae18f87..84e6458e80a 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -18,7 +18,7 @@
 #include "hw/char/serial-mm.h"
 #include "system/blockdev.h"
 #include "system/block-backend.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "qemu/datadir.h"
 
 
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 9b6eaf642e9..d87bcb5b88a 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -24,7 +24,7 @@
 #include "system/numa.h"
 #include "hw/core/boards.h"
 #include "system/reset.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/mem/memory-device.h"
 #include "elf.h"
 #include "system/device_tree.h"
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index d986e8f7a24..ed12f542001 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -31,7 +31,7 @@
 #include "hw/arm/digic.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "system/qtest.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 2d8e257ca2a..992edd3ba89 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -31,7 +31,7 @@
 #include "system/system.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/sd/sdhci.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 82fa9647119..b8c1256328d 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -24,7 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "net/net.h"
 #include "system/runstate.h"
 #include "system/system.h"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index ecfae328a96..6d6f6744869 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -19,7 +19,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/npcm7xx.h"
 #include "hw/char/serial-mm.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index c1e100b1e48..fda375eb4c3 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -21,7 +21,7 @@
 #include "hw/core/cpu.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 3ad7643b4bd..2bf5e132bb5 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -22,7 +22,7 @@
 #include "hw/arm/npcm8xx.h"
 #include "hw/char/serial-mm.h"
 #include "hw/intc/arm_gic.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index f775b324027..292f44d807c 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -21,7 +21,7 @@
 #include "hw/arm/npcm8xx.h"
 #include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 910c18213a5..637525a7e3f 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -23,7 +23,7 @@
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
 #include "qom/object.h"
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 058df2c4c96..ead28500c73 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -18,7 +18,7 @@
 #include "qemu/error-report.h"
 #include "system/device_tree.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "hw/arm/bcm2838.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 32d4c52bf50..5f0fb16a54c 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -42,7 +42,7 @@
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb/usb.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 2f61ad0dd62..75cb77da828 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -33,7 +33,7 @@
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/block/flash.h"
 #include "system/device_tree.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6155db2b093..c005eb914cb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -51,7 +51,7 @@
 #include "system/hvf.h"
 #include "system/qtest.h"
 #include "system/system.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index a6dc644d0bd..e127b232d75 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -25,7 +25,7 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/block/flash.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/adc/zynq-xadc.h"
 #include "hw/ssi/ssi.h"
 #include "hw/usb/chipidea.h"
diff --git a/hw/avr/boot.c b/hw/avr/boot.c
index e5a29c7218e..838378fb252 100644
--- a/hw/avr/boot.c
+++ b/hw/avr/boot.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "boot.h"
 #include "qemu/error-report.h"
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index be4fe867e4d..590c6a8131a 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -34,7 +34,7 @@
 #include "system/dma.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/core/guest-loader.c b/hw/core/guest-loader.c
index 07c36464047..e46897c4974 100644
--- a/hw/core/guest-loader.c
+++ b/hw/core/guest-loader.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/cpu.h"
 #include "system/dma.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 59a625ea57d..233a7f78c24 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/units.h"
 #include "system/memory.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/loader-fit.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 385730e8ef5..40cb187a113 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -58,7 +58,7 @@
 #include "system/reset.h"
 #include "system/system.h"
 #include "uboot_image.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "system/memory.h"
 #include "hw/core/boards.h"
diff --git a/hw/core/machine.c b/hw/core/machine.c
index dea257c3086..59359684cb8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -15,7 +15,7 @@
 #include "qemu/accel.h"
 #include "system/replay.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-machine.h"
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 3c884c92437..5efa9e45ffd 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -15,7 +15,7 @@
 #include "qemu/bswap.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-core.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 8191237124e..5ec09b63247 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -31,7 +31,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
index 4b55c48eff8..5cacf4fc127 100644
--- a/hw/display/cirrus_vga_isa.c
+++ b/hw/display/cirrus_vga_isa.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "cirrus_vga_internal.h"
diff --git a/hw/display/next-fb.c b/hw/display/next-fb.c
index ec81b766a7e..3d97702fce5 100644
--- a/hw/display/next-fb.c
+++ b/hw/display/next-fb.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "ui/console.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/m68k/next-cube.h"
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 72b2071aed0..130f4e01df0 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -2,7 +2,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/display/ramfb.h"
 #include "ui/console.h"
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 9a17d97d076..ad12fb1782e 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/display/ramfb.h"
 #include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 4853c5e1424..dfe234e3354 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
index 3618913b3b7..d2213b0f3e6 100644
--- a/hw/display/vga-isa.c
+++ b/hw/display/vga-isa.c
@@ -30,7 +30,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "ui/console.h"
 #include "qom/object.h"
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index b81f7fd2d0f..7a39bb9b213 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -33,7 +33,7 @@
 #include "ui/console.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/display/edid.h"
 #include "qom/object.h"
 #include "hw/acpi/acpi_aml_interface.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index bc1a8ed4665..7ca5a551426 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -27,7 +27,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "trace.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index acd1c3f005b..e877e6c4018 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -9,7 +9,7 @@
 #include "qemu/datadir.h"
 #include "cpu.h"
 #include "elf.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "qemu/error-report.h"
 #include "exec/target_page.h"
 #include "system/reset.h"
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index bcdfdf6af75..29908e886b4 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -14,7 +14,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "exec/target_page.h"
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e3bafb83af9..8cf99ad6623 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -30,7 +30,7 @@
 #include "acpi-microvm.h"
 #include "microvm-dt.h"
 
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/irq.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/i386/microvm.h"
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 78690781b74..8b6acfee9ba 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -27,7 +27,7 @@
 #include "cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "multiboot.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "exec/target_page.h"
 #include "system/system.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 0f2a5889022..1478a26f11b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -34,7 +34,7 @@
 #include "system/cpus.h"
 #include "hw/ide/ide-bus.h"
 #include "hw/timer/hpet.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 02de7453baa..5fd2f9d1e0c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -32,7 +32,7 @@
 #include "qemu/units.h"
 #include "hw/acpi/acpi.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "system/tcg.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 1a12b635ad9..4d64aa15550 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -32,7 +32,7 @@
 #include "hw/sysbus.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "system/kvm.h"
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 27f2f284c81..d2517b52617 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -38,7 +38,7 @@
 
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "multiboot.h"
 #include "elf.h"
 #include "standard-headers/asm-x86/bootparam.h"
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 4604d632b1e..9b3e3a4b7e7 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -28,7 +28,7 @@
 #include "hw/ipmi/ipmi.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
index 8857a049980..711d5ffbbc0 100644
--- a/hw/loongarch/boot.c
+++ b/hw/loongarch/boot.c
@@ -9,7 +9,7 @@
 #include "qemu/units.h"
 #include "target/loongarch/cpu.h"
 #include "hw/loongarch/virt.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "system/reset.h"
diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
index 1f0ba01f711..115080d80e2 100644
--- a/hw/loongarch/virt-fdt-build.c
+++ b/hw/loongarch/virt-fdt-build.c
@@ -9,7 +9,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/core/sysbus-fdt.h"
 #include "hw/intc/loongarch_extioi.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/loongarch/virt.h"
 #include "hw/pci-host/gpex.h"
 #include "system/device_tree.h"
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 0e11eb340f0..ea53941aeb9 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -22,7 +22,7 @@
 #include "system/address-spaces.h"
 #include "hw/core/irq.h"
 #include "net/net.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/intc/loongarch_extioi.h"
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index f67611ba0b2..f92a5d6a339 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -11,7 +11,7 @@
 #include "cpu.h"
 #include "hw/m68k/mcf.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b2b02f25ff1..b81305ae6e4 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -30,7 +30,7 @@
 #include "system/qtest.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "elf.h"
 
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 1411436a463..e7217cbaeac 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -18,7 +18,7 @@
 #include "hw/core/irq.h"
 #include "hw/m68k/next-cube.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/scsi/esp.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1aaaada3465..4c03455d6bd 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -30,7 +30,7 @@
 #include "hw/core/boards.h"
 #include "hw/or-irq.h"
 #include "elf.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "ui/console.h"
 #include "hw/char/escc.h"
 #include "hw/sysbus.h"
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 6f2b7bb5a08..7007d4e4e9f 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -16,7 +16,7 @@
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
 #include "elf.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "ui/console.h"
 #include "hw/sysbus.h"
 #include "standard-headers/asm-m68k/bootinfo.h"
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 39eb2386e8f..8ff99b3339d 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -34,7 +34,7 @@
 #include "system/device_tree.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 633b2a90523..b4b4a86a5fa 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -25,7 +25,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/loader-fit.h"
 #include "hw/mips/bootloader.h"
 #include "hw/mips/cps.h"
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index fa252c4b285..d4c100b69a0 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -31,7 +31,7 @@
 #include "hw/mips/mips.h"
 #include "hw/mips/bootloader.h"
 #include "hw/pci/pci.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/ide/pci.h"
 #include "hw/qdev-properties.h"
 #include "elf.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index fdcae4ce90e..fb01af8ece3 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -36,7 +36,7 @@
 #include "hw/core/boards.h"
 #include "net/net.h"
 #include "hw/scsi/esp.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/timer/i8254.h"
 #include "hw/display/vga.h"
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4df6cf13b36..fe51fb66f6f 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -37,7 +37,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/intc/i8259.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/isa/superio.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/pci.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index c63d77d4cca..2b0eb8c478e 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -44,7 +44,7 @@
 #include "qemu/log.h"
 #include "hw/ide/pci.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "qom/object.h"
 #include "hw/sysbus.h"             /* SysBusDevice */
diff --git a/hw/nubus/nubus-device.c b/hw/nubus/nubus-device.c
index 1abd9489044..5c5894c9c55 100644
--- a/hw/nubus/nubus-device.c
+++ b/hw/nubus/nubus-device.c
@@ -12,7 +12,7 @@
 #include "qemu/datadir.h"
 #include "exec/target_page.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/nubus/nubus.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index b696bf39e12..df07424e553 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -41,7 +41,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
 
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index db6fea071e8..6256babc42a 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -11,7 +11,7 @@
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 #include "elf.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/openrisc/boot.h"
 #include "system/device_tree.h"
 #include "system/qtest.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ffeb3fbf7cf..a3118ac6d0d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -39,7 +39,7 @@
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "trace.h"
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 3df4724a72b..4b858443806 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "hw/ppc/ppc.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/pci-host/articia.h"
 #include "hw/isa/vt82c686.h"
 #include "hw/ide/pci.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index eeca31dabb9..769f18023d5 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -39,7 +39,7 @@
 #include "hw/ppc/openpic_kvm.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
 #include "qemu/host-utils.h"
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3a6e47eb8b7..909a4fe257d 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -65,7 +65,7 @@
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
 #include "hw/ppc/openpic.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 8f9ce68b8b0..8400db6c352 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -42,7 +42,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
 #include "hw/misc/macio/macio.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 8b5958e7498..11bf406ef77 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -25,7 +25,7 @@
 #include "system/runstate.h"
 #include "system/qtest.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "qemu/log.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 895132da91b..eb3197da9b1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -38,7 +38,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv.h"
 #include "hw/ppc/pnv_core.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/nmi.h"
 #include "qapi/visitor.h"
 #include "hw/intc/intc.h"
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index af7cfd028ba..c7cbc525b33 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -13,7 +13,7 @@
 #include "qemu/units.h"
 #include "system/block-backend.h"
 #include "system/blockdev.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/ppc/pnv_pnor.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 824dd91ed5e..9e71037d84c 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -21,7 +21,7 @@
 #include "hw/core/boards.h"
 #include "system/kvm.h"
 #include "system/device_tree.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/char/serial-mm.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/ppc/ppc_booke.c b/hw/ppc/ppc_booke.c
index 13403a56b1a..7c6e5df9fde 100644
--- a/hw/ppc/ppc_booke.c
+++ b/hw/ppc/ppc_booke.c
@@ -29,7 +29,7 @@
 #include "qemu/timer.h"
 #include "system/reset.h"
 #include "system/runstate.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "kvm_ppc.h"
 
 void booke_set_tlb(ppcemb_tlb_t *tlb, target_ulong va, hwaddr pa,
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 0d5e1f604e6..90164face16 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -36,7 +36,7 @@
 #include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/datadir.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/isa/pc87312.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 992bfe39a36..550aaa21fa2 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -22,7 +22,7 @@
 #include "system/device_tree.h"
 #include "system/block-backend.h"
 #include "exec/page-protection.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "system/memory.h"
 #include "ppc440.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7c695ac4ecc..bad6918e6eb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -61,7 +61,7 @@
 #include "hw/core/cpu.h"
 
 #include "hw/ppc/ppc.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index c21a2a3274e..875c17f4784 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/log.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
 #include "system/kvm.h"
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 8221a01639d..8b5f4eb57a0 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -34,7 +34,7 @@
 #include "system/reset.h"
 #include "hw/core/boards.h"
 #include "system/device_tree.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 4f207dee287..df1f3abd171 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/boot_opensbi.h"
 #include "elf.h"
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 4398f7b1825..9de6456c141 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -41,7 +41,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "chardev/char.h"
 #include "hw/cpu/cluster.h"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index abe411e305e..c2032176c43 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 00438d2e596..3e081ddf37e 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -41,7 +41,7 @@
 #include "qapi/visitor.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "hw/cpu/cluster.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 6aa688acf30..c9451d7e3b3 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -26,7 +26,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 45a845318e7..0505bffa44a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -24,7 +24,7 @@
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 1a33082857c..0a0ad85a35a 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -22,7 +22,7 @@
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/rx/rx62n.h"
 #include "system/qtest.h"
 #include "system/device_tree.h"
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index a2a243afa41..3fe9a4a518c 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -25,7 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "hw/rx/rx62n.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
 #include "system/system.h"
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index f1c2af15f75..e0a04ab1a22 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -19,7 +19,7 @@
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "elf.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/s390x/virtio-ccw.h"
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 5352f23ae82..9e8c2fa8d12 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -40,7 +40,7 @@
 #include "sh7750_regs.h"
 #include "hw/ide/mmio.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/usb/usb.h"
 #include "hw/block/flash.h"
 #include "exec/tswap.h"
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 071c3b5e629..be97a5effcc 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -25,7 +25,7 @@
 #include "system/system.h"
 #include "qemu/uuid.h"
 #include "hw/firmware/smbios.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/boards.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_device.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 500b63bc9b7..cd1a03a5584 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -38,7 +38,7 @@
 #include "system/qtest.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "trace.h"
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index fa5592f26cb..b6256864582 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -51,7 +51,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/core/irq.h"
 #include "hw/or-irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 334bec14ba3..209be380473 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -29,7 +29,7 @@
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "hw/misc/unimp.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/sparc/sparc64.h"
 #include "hw/rtc/sun4v-rtc.h"
 #include "system/block-backend.h"
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5b25ba81cc8..c0fb421d2ba 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -53,7 +53,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
 #include "hw/ide/pci.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "trace.h"
diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index f3b84980e52..e1a97a43874 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "qemu/units.h"
 #include "hw/misc/unimp.h"
 
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index cb45b01d2d2..db6f2b765ac 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -23,7 +23,7 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "net/net.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/tricore/tricore.h"
 #include "qemu/error-report.h"
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 21b119712c5..60772d4f1d7 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -24,7 +24,7 @@
 #include "cpu.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "hw/tricore/tricore.h"
 #include "hw/tricore/tricore_testdevice.h"
diff --git a/hw/virtio/vhost-user-scsi-pci.c b/hw/virtio/vhost-user-scsi-pci.c
index 994e51a37bb..367b8f27da5 100644
--- a/hw/virtio/vhost-user-scsi-pci.c
+++ b/hw/virtio/vhost-user-scsi-pci.c
@@ -28,7 +28,7 @@
 #include "qemu/module.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
 #include "qom/object.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 263e112a5cb..7382e7db6fa 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -33,7 +33,7 @@
 #include "qemu/bswap.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "system/accel-irq.h"
 #include "system/kvm.h"
 #include "hw/virtio/virtio-pci.h"
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 9154a4c2576..ad513d4cbc1 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -27,7 +27,7 @@
 #include "monitor/qdev.h"
 #include "hw/core/boards.h"
 #include "hw/core/irq.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/usb/usb.h"
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 6bc64acd335..319efcad6ef 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -4,7 +4,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/pci/pci.h"
 #include "xen_pt.h"
 
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 37acc562d21..994460d0414 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -30,7 +30,7 @@
 #include "system/reset.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "elf.h"
 #include "system/memory.h"
 #include "qemu/error-report.h"
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index b9e324c2850..271f06e0953 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "system/reset.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "net/net.h"
 #include "elf.h"
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 694456aa0a1..a96abcd4bdd 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -31,7 +31,7 @@
 #include "cpu.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
 #include "elf.h"
 #include "system/memory.h"
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 2e9fa5842f6..5e5f181b908 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -47,7 +47,7 @@
 #define COMMON_SEMI_HEAP_SIZE (128 * 1024 * 1024)
 #else
 #include "qemu/cutils.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/boards.h"
 #endif
 
diff --git a/system/device_tree.c b/system/device_tree.c
index 3ccdf33374c..1ea19629841 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -24,7 +24,7 @@
 #include "qemu/cutils.h"
 #include "qemu/guest-random.h"
 #include "system/device_tree.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/boards.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/system/globals.c b/system/globals.c
index 98f9876d5d4..c33f6ed3902 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "exec/cpu-common.h"
 #include "hw/display/vga.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/xen/xen.h"
 #include "net/net.h"
 #include "system/cpus.h"
diff --git a/system/vl.c b/system/vl.c
index cdf32c119b2..659c6506fc7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -62,7 +62,7 @@
 #include "hw/firmware/smbios.h"
 #include "hw/acpi/acpi.h"
 #include "hw/xen/xen.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "monitor/qdev.h"
 #include "net/net.h"
 #include "net/slirp.h"
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7720d27a3c0..09e89272edc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -36,7 +36,7 @@
 #include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "hw/core/boards.h"
 #ifdef CONFIG_TCG
 #include "hw/intc/armv7m_nvic.h"
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8ed62acf84d..ef3359ced92 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -23,7 +23,7 @@
 #include "hw/core/irq.h"
 #include "hw/loongarch/virt.h"
 #include "qemu/log.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "system/runstate.h"
 #include "cpu-csr.h"
 #include "kvm_loongarch.h"
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index d357aaa7da1..5528b80e7b8 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -23,7 +23,7 @@
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #endif
 #include "qemu/plugin.h"
 
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index ffb732e0d1f..b2b2b3c4a98 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -26,7 +26,7 @@
 #include "exec/target_page.h"
 #include "gdbstub/helpers.h"
 #include "qemu/host-utils.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 
 static void get_phys_nommu(hwaddr *phys_addr, int *prot, vaddr address)
 {
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 1d99e5f4908..5d792563b91 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -41,7 +41,7 @@
 #include "hw/core/irq.h"
 #include "hw/intc/riscv_imsic.h"
 #include "qemu/log.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "kvm_riscv.h"
 #include "sbi_ecall_interface.h"
 #include "chardev/char-fe.h"
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index da02ae7bf88..f5f4f3ba4ab 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -25,7 +25,7 @@
 #include "exec/page-protection.h"
 #include "exec/translation-block.h"
 #include "exec/target_page.h"
-#include "hw/loader.h"
+#include "hw/core/loader.h"
 #include "fpu/softfloat.h"
 #include "tcg/debug-assert.h"
 #include "accel/tcg/cpu-ops.h"
-- 
2.51.1


