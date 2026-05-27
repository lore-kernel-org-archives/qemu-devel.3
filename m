Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C0ACD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBY4-0002mt-2i; Wed, 27 May 2026 06:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXa-0002Zh-TZ
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBXY-0000eU-RD
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:31:10 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so3458980f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877867; x=1780482667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BvRlpyLq+b9ytrSPm8QvDf+mER5mzd06EMRE5d5Rh9k=;
 b=LU4jR17g+635hYrIsw6zpu/u2oPr9acTZ2eHXbVVVaaz3zRGN1QJkk5sGA3IyQaXFc
 YuonTzFx0BCOBswVQxtYOgVzRc1BSIdlrH6BnNIYdvQr2v5gos+7oxu7T1VA8ICUnall
 nu9/hjodePOLd7Fsv4Tg4toIlcLyBbg5t2kePctnqBqiZvfbV2yD50GhHHm5pEbJLa7s
 lJUabDh8HXPSZN1I0mIb9ymOntzD8YyhbFDmmZmcxGlTS8JhuoA7vc6F+xxyezIeoveg
 ZH9RBakTno/LcuNgACTIR2GA1QAbPPjnR3slYNwH1hLG7AI1bMqyqzWhmMN/auWvbwuZ
 JYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877867; x=1780482667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BvRlpyLq+b9ytrSPm8QvDf+mER5mzd06EMRE5d5Rh9k=;
 b=f4cJBpWvxXy/RzBg6kSrlzvp8byrT89FI5Q7mhEPzCj4ZW/MKlOsoMkNPlvwXL2hMw
 BC+RzJh2ErkZHkU6NhAFspY/5Y+3VWmPMU/JRmEm0H6nmC1u707G41J2+wDsmpMIjtZt
 KBD7375m70gH4M/mpaH/aezFL/e3Zd9RZ7z2uQLgRrH5PjWWfjOYyOEozqchdIG5ybZ4
 RpbdD60XqcOn8deasa98fhzOBWE/zeNwUabURVAbb5lW/v/LzZk/SNc3MOuOMmduPB+F
 hePnUjpl7PcW4G0YH2wNFpPYF3L0s/PWG3nacE9PV/2//N3LOXuJcDMfZGsrvytwyZDJ
 Y4Tg==
X-Gm-Message-State: AOJu0YzNnQwtzgKR1qhnZvaIwHKal7GDR3UHqvqmGAPU3nsUV04ZK0HZ
 X0PdwkDG2b6IXfymxlYJ958LO0wS2oCaBxOP+pW4j5mquZlCbBWPmgPikoJ62R78ctoZPhS/s1o
 DSE3qi15lmw==
X-Gm-Gg: Acq92OFWuImNiBk7Zzb5VmXQE8606tuqLq3cL3UU9geWQblDo9YnDAk2Boy1a6VV3ii
 wwXldGOFMMG0enth0t2glCRUXocVpeGKwFOfOhKjasMyuYqcus5kCuBx555/dVZmXQ5avXkdWNd
 SKAGkmQ/e/tr3CWZg1EGdFnh/kT4phgGcaWoD6xGvhu3mHe+5m5zF89dIpb93kJNHxzUxLmOLvb
 DtlKqkLheTym6Gck8CvkFj1SbO+d1dnA4Z7C5gzkSEqfoenQXh8x+jFcpO7Znc6TOs1lN6U9lrd
 OVD8EMukio52im4W6n7pbO75eucFlNYBw/itHBR3GIvcX5egM5cGinK1d6433Cu5h4N9ZuHVxhd
 XqhqTNu0QpNRBZNyXlc5jOIM1wYKcVeH6sWzFOvK+lIez60DEATDGxDv8I7iwxpu2rtWdBAGbdE
 yQDHLhGbJl9cOTfJXg7i+X6ls8ACnFhDssr1t/vhYSzIO87Vrci3abndzTo4VP+h3JxA==
X-Received: by 2002:a05:600c:3b09:b0:490:846d:e2de with SMTP id
 5b1f17b1804b1-490846de40dmr21724905e9.28.1779877867033; 
 Wed, 27 May 2026 03:31:07 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb557679sm8647267f8f.10.2026.05.27.03.31.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:31:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/32] hw/riscv: Filter machine types for
 qemu-system-riscv32/64 binaries
Date: Wed, 27 May 2026 12:30:08 +0200
Message-ID: <20260527103037.4461-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

Register machines able to run in qemu-system-riscv32,
qemu-system-riscv64, or both.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260520-hw-riscv-cpu-int-v3-4-d1123ea63d9c@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/boston-aia.c           | 3 ++-
 hw/riscv/microblaze-v-generic.c | 3 ++-
 hw/riscv/microchip_pfsoc.c      | 2 ++
 hw/riscv/opentitan.c            | 2 ++
 hw/riscv/shakti_c.c             | 2 ++
 hw/riscv/sifive_e.c             | 2 ++
 hw/riscv/sifive_u.c             | 2 ++
 hw/riscv/spike.c                | 2 ++
 hw/riscv/virt.c                 | 3 +++
 hw/riscv/xiangshan_kmh.c        | 2 ++
 10 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boston-aia.c b/hw/riscv/boston-aia.c
index b90da096ea8..965d0f5699e 100644
--- a/hw/riscv/boston-aia.c
+++ b/hw/riscv/boston-aia.c
@@ -18,6 +18,7 @@
 #include "hw/ide/ahci-pci.h"
 #include "hw/core/loader.h"
 #include "hw/riscv/cps.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/pci-host/xilinx-pcie.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
@@ -473,4 +474,4 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_cpu_type = TYPE_RISCV_CPU_MIPS_P8700;
 }
 
-DEFINE_MACHINE("boston-aia", boston_mach_class_init)
+DEFINE_MACHINE_RISCV64("boston-aia", boston_mach_class_init)
diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
index b0494b1ac50..d33ac39a68c 100644
--- a/hw/riscv/microblaze-v-generic.c
+++ b/hw/riscv/microblaze-v-generic.c
@@ -25,6 +25,7 @@
 #include "system/address-spaces.h"
 #include "hw/char/xilinx_uartlite.h"
 #include "hw/misc/unimp.h"
+#include "hw/riscv/machines-qom.h"
 
 #define LMB_BRAM_SIZE (128 * KiB)
 #define MEMORY_BASEADDR 0x80000000
@@ -186,4 +187,4 @@ static void mb_v_generic_machine_init(MachineClass *mc)
     mc->default_cpus = 1;
 }
 
-DEFINE_MACHINE("amd-microblaze-v-generic", mb_v_generic_machine_init)
+DEFINE_MACHINE_RISCV32_64("amd-microblaze-v-generic", mb_v_generic_machine_init)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 743f31f0057..5e48a297083 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -49,6 +49,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -751,6 +752,7 @@ static const TypeInfo microchip_icicle_kit_machine_typeinfo = {
     .class_init = microchip_icicle_kit_machine_class_init,
     .instance_init = microchip_icicle_kit_machine_instance_init,
     .instance_size = sizeof(MicrochipIcicleKitState),
+    .interfaces = riscv64_machine_interfaces,
 };
 
 static void microchip_icicle_kit_machine_init_register_types(void)
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 309125e854b..c8b2f028f23 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -26,6 +26,7 @@
 #include "hw/core/boards.h"
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "qemu/units.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
@@ -335,6 +336,7 @@ static const TypeInfo open_titan_types[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(OpenTitanState),
         .class_init     = opentitan_machine_class_init,
+        .interfaces     = riscv32_machine_interfaces,
     }
 };
 
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 852d5b97973..b1823a31250 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "hw/core/boards.h"
 #include "hw/riscv/shakti_c.h"
+#include "hw/riscv/machines-qom.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/intc/sifive_plic.h"
@@ -93,6 +94,7 @@ static const TypeInfo shakti_c_machine_type_info = {
     .class_init = shakti_c_machine_class_init,
     .instance_init = shakti_c_machine_instance_init,
     .instance_size = sizeof(ShaktiCMachineState),
+    .interfaces = riscv64_machine_interfaces,
 };
 
 static void shakti_c_machine_type_info_register(void)
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1acfea49668..71925583bd9 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -40,6 +40,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -167,6 +168,7 @@ static const TypeInfo sifive_e_machine_typeinfo = {
     .class_init = sifive_e_machine_class_init,
     .instance_init = sifive_e_machine_instance_init,
     .instance_size = sizeof(SiFiveEState),
+    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void sifive_e_machine_init_register_types(void)
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7ec67b25651..6a637e3b86c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -51,6 +51,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/char/sifive_uart.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
@@ -742,6 +743,7 @@ static const TypeInfo sifive_u_machine_typeinfo = {
     .class_init = sifive_u_machine_class_init,
     .instance_init = sifive_u_machine_instance_init,
     .instance_size = sizeof(SiFiveUState),
+    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void sifive_u_machine_init_register_types(void)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 87fe0f242f5..6e16adfe559 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -33,6 +33,7 @@
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/char/riscv_htif.h"
 #include "hw/intc/riscv_aclint.h"
 #include "chardev/char.h"
@@ -365,6 +366,7 @@ static const TypeInfo spike_machine_typeinfo = {
     .class_init = spike_machine_class_init,
     .instance_init = spike_machine_instance_init,
     .instance_size = sizeof(SpikeState),
+    .interfaces = riscv32_64_machine_interfaces,
 };
 
 static void spike_machine_init_register_types(void)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3d06c9c6104..ce64eaaef7d 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/riscv-iommu-bits.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/machines-qom.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
 #include "hw/firmware/smbios.h"
@@ -2001,6 +2002,8 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_size = sizeof(RISCVVirtState),
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
+         { TYPE_TARGET_RISCV32_MACHINE },
+         { TYPE_TARGET_RISCV64_MACHINE },
          { }
     },
 };
diff --git a/hw/riscv/xiangshan_kmh.c b/hw/riscv/xiangshan_kmh.c
index 436e51c1c59..76417ba7aba 100644
--- a/hw/riscv/xiangshan_kmh.c
+++ b/hw/riscv/xiangshan_kmh.c
@@ -41,6 +41,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/xiangshan_kmh.h"
 #include "hw/riscv/riscv_hart.h"
+#include "hw/riscv/machines-qom.h"
 #include "system/system.h"
 
 static const MemMapEntry xiangshan_kmh_memmap[] = {
@@ -211,6 +212,7 @@ static const TypeInfo xiangshan_kmh_machine_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(XiangshanKmhState),
     .class_init = xiangshan_kmh_machine_class_init,
+    .interfaces = riscv64_machine_interfaces,
 };
 
 static void xiangshan_kmh_machine_register_types(void)
-- 
2.53.0


