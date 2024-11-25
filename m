Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5950BD58D78
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 18:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdbt-0001Jl-3T; Mon, 25 Nov 2024 13:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFdbo-0001GF-6t
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:14:52 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFdbh-0005Ef-TH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:14:51 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a14d6bf4so7798475e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732558483; x=1733163283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00VZ9jvcaAGnW9G66q6p0Z9KOFencE3ScrcnIzRvY8o=;
 b=c6fbwQjxOnd/SAnUvXflL+dmXJpWR/Wg5vvfiFNZ/4lD2y+ISHC0xr50ZKMd7tcB4a
 n3P98mmKA9ecOBj5FrncWu/lot4k9PW5KRlY8iJQvpgT68Hg+uexC4FYANmlfxHuG+ct
 4RKUe5m1MSvf6gnxRrehzpKsU3bkk9A7NoJne1LwhEeXqBhFfbzmBX/98lDSoIcMy7Wa
 duro1Q4/SYnNkO2Dhx+OKG2DKk20qWNR/MbzK2IKEp72l+BnKK2ceZbehw1TKL/d+UDo
 FWrJ/F9pAXgEPnpGg+LeFwYaFrKjrOSTT1ZWGT4rYiDv6xShPsrcPOW2e6HzR1UD00DQ
 RDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732558483; x=1733163283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00VZ9jvcaAGnW9G66q6p0Z9KOFencE3ScrcnIzRvY8o=;
 b=hs5DSSS+4ujdnahUGB7/wfX2P+Ur2VqFFbYZr9pXfFLTZcd0sD0Z+/EsiQqQlgbeaz
 tCwgZ0aEvHjOYdzffPloVlgyqYobqCIJ9THd93Rr/iYo+ahvlmk3PsCqAuqJSWwOBztN
 9v5yvpvK8fZpv+jIzoIZ3dfysnRrCp/lhlzvYvRDnPERcppTR2+bPNPFDapGMPypJ27W
 GrB/91h98b0SKCjiswzJxygU67+WLIdZBjopmlmrrUytpEwYm/H07j60CbJWSZuOksNQ
 61a0MQ9A+KJ8TqWUXPaTSr2Whalv2l+zghhKcoEWKd8g/hh4cOwEuqsezue6HiHcOet+
 XttA==
X-Gm-Message-State: AOJu0YxLP6ehJuJbvC1gM/+vJE7JjO3j5iCbENYDUMQE61wiu+fq+b4E
 W0uatGTCsEo01YUJHXTBhFLk3sqqz9ppwizrZPVJdDcZFYz+IXrQRLjGbvk+9+/C/FAk8pYDg/B
 P
X-Gm-Gg: ASbGnctCfPIIFzlF1p0biuvWH7xMYnNsJs3tJ/qPKyZmFFxYGEywtqsstgvCLEWvk54
 h/cswaRrk0AmJ7FC/AlTBl3zueuTYCWoxnDYWbxkiB56mllbRJaOhDRsetrSskN+QRQgtiip2Tu
 lv44WOdiAnaz8pGK1MPL//uPdiIS7tL53aFS5cg1Q4yZkJtbYOmX/ZU4jPEYCnxu1zp6C8Y/PT+
 VpI6npqTZC2O+RzJZ5qi733XF0/BKMOMg26hwaXstuWIIILm+Jt8z7DXBuJjm23U0teqjIf
X-Google-Smtp-Source: AGHT+IEHN3VQmFHgWVCzDEpM1k+1lY20ITfpCE6xT8zoJ7GbtqHI9ZrQgFOTZer3qAvDkPzJgBwXaQ==
X-Received: by 2002:a7b:c04f:0:b0:434:8827:f713 with SMTP id
 5b1f17b1804b1-4348827f8c1mr118621105e9.12.1732558482548; 
 Mon, 25 Nov 2024 10:14:42 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45d4288sm200581805e9.23.2024.11.25.10.14.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 10:14:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 3/3] hw/boards: Rename no_sdcard ->
 create_default_sdcard_drive
Date: Mon, 25 Nov 2024 19:14:20 +0100
Message-ID: <20241125181420.24424-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125181420.24424-1-philmd@linaro.org>
References: <20241125181420.24424-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Invert the 'no_sdcard' logic, renaming it as the more
explicit "create_default_sdcard_drive". Machines are
supposed to create a SD Card drive when this flag is
set. In many cases it doesn't make much sense (as
boards don't expose SD Card host controller), but this
is patch only aims to expose that nonsense; so no
logical change intended (mechanical patch using gsed).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h                      |  2 +-
 hw/alpha/dp264.c                         |  2 +-
 hw/arm/aspeed.c                          |  4 ++--
 hw/arm/b-l475e-iot01a.c                  |  2 +-
 hw/arm/bananapi_m2u.c                    |  2 +-
 hw/arm/collie.c                          |  2 +-
 hw/arm/cubieboard.c                      |  2 +-
 hw/arm/digic_boards.c                    |  2 +-
 hw/arm/exynos4_boards.c                  |  4 ++--
 hw/arm/fby35.c                           |  2 +-
 hw/arm/highbank.c                        |  4 ++--
 hw/arm/imx25_pdk.c                       |  2 +-
 hw/arm/integratorcp.c                    |  2 +-
 hw/arm/kzm.c                             |  2 +-
 hw/arm/mcimx6ul-evk.c                    |  2 +-
 hw/arm/mcimx7d-sabre.c                   |  2 +-
 hw/arm/microbit.c                        |  2 +-
 hw/arm/mps2-tz.c                         |  2 +-
 hw/arm/mps2.c                            |  2 +-
 hw/arm/mps3r.c                           |  2 +-
 hw/arm/msf2-som.c                        |  2 +-
 hw/arm/musca.c                           |  2 +-
 hw/arm/musicpal.c                        |  2 +-
 hw/arm/netduino2.c                       |  2 +-
 hw/arm/netduinoplus2.c                   |  2 +-
 hw/arm/npcm7xx_boards.c                  |  2 +-
 hw/arm/olimex-stm32-h405.c               |  2 +-
 hw/arm/omap_sx1.c                        |  4 ++--
 hw/arm/orangepi.c                        |  2 +-
 hw/arm/raspi.c                           |  2 +-
 hw/arm/realview.c                        |  8 ++++----
 hw/arm/sabrelite.c                       |  2 +-
 hw/arm/sbsa-ref.c                        |  2 +-
 hw/arm/stellaris.c                       |  4 ++--
 hw/arm/stm32vldiscovery.c                |  2 +-
 hw/arm/versatilepb.c                     |  4 ++--
 hw/arm/vexpress.c                        |  2 +-
 hw/arm/virt.c                            |  2 +-
 hw/arm/xen-pvh.c                         |  2 +-
 hw/arm/xilinx_zynq.c                     |  4 ++--
 hw/arm/xlnx-versal-virt.c                |  2 +-
 hw/arm/xlnx-zcu102.c                     |  2 +-
 hw/avr/arduino.c                         |  2 +-
 hw/core/null-machine.c                   |  2 +-
 hw/hppa/machine.c                        |  4 ++--
 hw/i386/pc.c                             |  2 +-
 hw/i386/x86.c                            |  2 +-
 hw/i386/xen/xen-pvh.c                    |  2 +-
 hw/loongarch/virt.c                      |  2 +-
 hw/m68k/an5206.c                         |  2 +-
 hw/m68k/mcf5208.c                        |  2 +-
 hw/m68k/next-cube.c                      |  2 +-
 hw/m68k/q800.c                           |  2 +-
 hw/m68k/virt.c                           |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  2 +-
 hw/microblaze/petalogix_s3adsp1800_mmu.c |  2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  2 +-
 hw/mips/boston.c                         |  2 +-
 hw/mips/fuloong2e.c                      |  2 +-
 hw/mips/jazz.c                           |  4 ++--
 hw/mips/loongson3_virt.c                 |  2 +-
 hw/mips/malta.c                          |  2 +-
 hw/mips/mipssim.c                        |  2 +-
 hw/openrisc/openrisc_sim.c               |  2 +-
 hw/openrisc/virt.c                       |  2 +-
 hw/ppc/amigaone.c                        |  2 +-
 hw/ppc/e500.c                            |  2 +-
 hw/ppc/e500plat.c                        |  2 +-
 hw/ppc/mac_newworld.c                    |  2 +-
 hw/ppc/mac_oldworld.c                    |  2 +-
 hw/ppc/mpc8544ds.c                       |  2 +-
 hw/ppc/pegasos2.c                        |  2 +-
 hw/ppc/pnv.c                             |  2 +-
 hw/ppc/ppc405_boards.c                   |  2 +-
 hw/ppc/ppc440_bamboo.c                   |  2 +-
 hw/ppc/prep.c                            |  2 +-
 hw/ppc/sam460ex.c                        |  2 +-
 hw/ppc/spapr.c                           |  2 +-
 hw/ppc/virtex_ml507.c                    |  2 +-
 hw/remote/machine.c                      |  2 +-
 hw/riscv/microchip_pfsoc.c               |  2 +-
 hw/riscv/opentitan.c                     |  2 +-
 hw/riscv/shakti_c.c                      |  2 +-
 hw/riscv/sifive_e.c                      |  2 +-
 hw/riscv/sifive_u.c                      |  2 +-
 hw/riscv/spike.c                         |  2 +-
 hw/riscv/virt.c                          |  2 +-
 hw/rx/rx-gdbsim.c                        |  2 +-
 hw/s390x/s390-virtio-ccw.c               |  2 +-
 hw/sh4/r2d.c                             |  2 +-
 hw/sparc/leon3.c                         |  2 +-
 hw/sparc/sun4m.c                         |  2 +-
 hw/sparc64/niagara.c                     |  2 +-
 hw/sparc64/sun4u.c                       |  4 ++--
 hw/tricore/triboard.c                    |  2 +-
 hw/tricore/tricore_testboard.c           |  2 +-
 hw/xen/xen-pvh-common.c                  |  2 +-
 hw/xenpv/xen_machine_pv.c                |  2 +-
 hw/xtensa/sim.c                          |  2 +-
 hw/xtensa/virt.c                         |  2 +-
 hw/xtensa/xtfpga.c                       | 16 ++++++++--------
 system/vl.c                              |  3 +--
 102 files changed, 122 insertions(+), 123 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 86fcf9c81f..5cec73ae68 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -285,7 +285,7 @@ struct MachineClass {
         no_cdrom:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
-    OnOffAuto no_sdcard;
+    bool create_default_sdcard_drive;
     bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 5fa1aa9df8..4957d1b8e4 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,7 +213,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
     mc->default_ram_id = "ram";
     mc->default_nic = "e1000";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cd4512612c..4a3de054bf 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1193,7 +1193,7 @@ static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
     mc->min_cpus = sc->num_cpus;
     mc->max_cpus = sc->num_cpus;
     mc->valid_cpu_types = sc->valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static bool aspeed_machine_ast2600_get_boot_from_emmc(Object *obj, Error **errp)
@@ -1233,7 +1233,7 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_ram_id = "ram";
     amc->macs_mask = ASPEED_MAC0_ON;
     amc->uart_default = ASPEED_DEV_UART5;
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 0338c4fd84..113f465ad6 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -120,7 +120,7 @@ static void bl475e_machine_init(ObjectClass *oc, void *data)
     mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
     mc->init = bl475e_init;
     mc->valid_cpu_types = machine_valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 3da6ec4a03..3ad069f161 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -141,7 +141,7 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "bpim2u.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 80bf12246a..1448fb99d7 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -79,7 +79,7 @@ static void collie_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "strongarm.sdram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo collie_machine_typeinfo = {
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 11d896f832..bc3b309423 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -122,7 +122,7 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "cubieboard.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 59e4989d29..ab830e072b 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -143,7 +143,7 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_size = 64 * MiB;
     mc->default_ram_id = "ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 63e86e2c60..79c4dbaad8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -165,7 +165,7 @@ static void nuri_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo nuri_type = {
@@ -185,7 +185,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo smdkc210_type = {
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 0c4418c0e8..c75460be30 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -170,7 +170,7 @@ static void fby35_class_init(ObjectClass *oc, void *data)
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
 
     object_class_property_add_bool(oc, "execute-in-place",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 503aa6f86f..7ceb8f2acc 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,7 +357,7 @@ static void highbank_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo highbank_type = {
@@ -382,7 +382,7 @@ static void midway_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo midway_type = {
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index e5871c5d6b..04be07d617 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -147,7 +147,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "imx25.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 4110954851..64adf76355 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -688,7 +688,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "integrator.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 5dea5199d4..35a1d9ec9c 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,7 +137,7 @@ static void kzm_machine_init(MachineClass *mc)
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 276ff5549f..ac7fddc300 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -74,6 +74,6 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
     mc->default_ram_id = "mcimx6ul-evk.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 1ba931b4bf..fc0618b8d9 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -74,6 +74,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
     mc->default_ram_id = "mcimx7d-sabre.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 57e5fe2026..e1d65bbe21 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -67,7 +67,7 @@ static void microbit_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "BBC micro:bit (Cortex-M0)";
     mc->init = microbit_init;
     mc->max_cpus = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo microbit_info = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index be6cf41940..8b6b7a3324 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1273,7 +1273,7 @@ static void mps2tz_class_init(ObjectClass *oc, void *data)
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->init = mps2tz_common_init;
     mc->reset = mps2_machine_reset;
     iic->check = mps2_tz_idau_check;
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 287e48715d..9211fe7af9 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -472,7 +472,7 @@ static void mps2_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "mps.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index f98c081f81..62bb869397 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -588,7 +588,7 @@ static void mps3r_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->init = mps3r_common_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void mps3r_an536_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 73ea5a0202..c3109e6201 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -106,7 +106,7 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 0ee05655d9..aa8e3dbf5a 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -607,7 +607,7 @@ static void musca_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = mc->default_cpus;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = musca_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void musca_a_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 16e7873216..20d32a19f4 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1342,7 +1342,7 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
     mc->default_ram_id = "musicpal.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 93f5dcf0b6..101a645b3b 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -63,7 +63,7 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->init = netduino2_init;
     mc->valid_cpu_types = valid_cpu_types;
     mc->ignore_memory_transaction_failures = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index be5c7b6081..4ca1dcfe93 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -63,7 +63,7 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 6f80c8f937..9d49c4baea 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -464,7 +464,7 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_ram_id = "ram";
     mc->valid_cpu_types = valid_cpu_types;
 }
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index fc6de35ef1..e5fc2449de 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -66,7 +66,7 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index e561817798..091442237d 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -216,7 +216,7 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo sx1_machine_v2_type = {
@@ -235,7 +235,7 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo sx1_machine_v1_type = {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 76ab214853..6b6fc517d9 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -121,7 +121,7 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "orangepi.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 4195ba07c6..c85910e7ea 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -325,7 +325,7 @@ void raspi_machine_class_common_init(MachineClass *mc,
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     mc->default_ram_id = "ram";
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index fdbe4bd88c..8fb1ffe58d 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -415,7 +415,7 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -436,7 +436,7 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -455,7 +455,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->init = realview_pb_a8_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -475,7 +475,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 56f6306a1f..f8fcaaeb91 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -110,7 +110,7 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "sabrelite.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 37abb327a6..55f4b3c51e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -900,7 +900,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 46f343679c..34869a971f 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1388,7 +1388,7 @@ static void lm3s811evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s811evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo lm3s811evb_type = {
@@ -1405,7 +1405,7 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 93f5d3a627..2788fa7d41 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -66,7 +66,7 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index db95351946..cf1ffd9909 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -419,7 +419,7 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -440,7 +440,7 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 6f602f8486..bb2cdf6e95 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -783,7 +783,7 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "vexpress.highmem";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", vexpress_get_secure,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 050384f52f..e8412f56e5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3124,7 +3124,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 632ab06b16..9af1fb13de 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -75,7 +75,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      * mc->max_cpus, QEMU will bail out with an error message.
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index bcdd30db83..2072f378db 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -463,11 +463,11 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
-    mc->no_sdcard = ON_OFF_AUTO_ON;
+    mc->create_default_sdcard_drive = false;
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     prop = object_class_property_add_str(oc, "boot-mode", NULL,
                                          zynq_set_boot_mode);
     object_class_property_set_description(oc, "boot-mode",
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2a66dafb34..7b02d05d52 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -818,7 +818,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 40c9e0cc23..fc32270e29 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -280,7 +280,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_ram_id = "ddr-ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", zcu102_get_secure,
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 1801074a42..10b39afc1d 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -67,7 +67,7 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index b93056c0f7..536d8b8c66 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -53,7 +53,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_ON;
+    mc->create_default_sdcard_drive = false;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index e48c58e4c6..371b6c4ecb 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -708,7 +708,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
@@ -745,7 +745,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f6799eb817..8f3e9d50cb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1794,7 +1794,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
     mc->default_ram_id = "pc.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index adbac29ba0..9a12eb25d3 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,7 +382,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index e4d101c24a..8e6eda9fe9 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -82,7 +82,7 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Xen PVH x86 machine";
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
     mc->max_cpus = HVM_MAX_VCPUS;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 92ef0cdb38..30abc8a38c 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1449,7 +1449,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index d48558c999..1dc274b799 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -99,7 +99,7 @@ static void an5206_machine_init(MachineClass *mc)
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index fd82813f5a..ba8af56c85 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,7 +398,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id = "mcf5208.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 200cd7a5b3..1694d07563 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1068,7 +1068,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo next_typeinfo = {
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 23999e50c4..36ed6b352d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -743,7 +743,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 8707990446..d04beb26fb 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -318,7 +318,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_ram_id = "m68k_virt.ram";
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index c1b83b354f..1398478f9b 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -220,7 +220,7 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
 #endif
     mc->init = petalogix_ml605_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 2c8e3b80d4..9f07b00c42 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -142,7 +142,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 4d6dc8bbf5..94adb71df1 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -188,7 +188,7 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
 #endif
     mc->init = xlnx_zynqmp_pmu_init;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 997d6fbda2..fe8b932ee9 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -842,7 +842,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_ram_id = "boston.ddr";
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index b646e14e89..27dfca96b5 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -334,7 +334,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index ad034959ad..6a31c423c4 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -424,7 +424,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -442,7 +442,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo mips_pica61_type = {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 0efe4480fe..aaf0351cbd 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -672,7 +672,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo loongson3_machine_types[] = {
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index dd565ba388..5ee4b0b83f 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1304,7 +1304,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_malta.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index b008da5602..2e90c6022b 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -246,7 +246,7 @@ static void mips_mipssim_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_mipssim.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 0d2d5d30b3..5a6dd502c6 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -354,7 +354,7 @@ static void openrisc_sim_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = OR1KSIM_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 1edecd76c8..c91142a8c6 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -554,7 +554,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index e54da2bdcc..1bd04f0361 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -173,7 +173,7 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_display = "std";
     mc->default_ram_id = "ram";
     mc->default_ram_size = 512 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 547a89ff3b..19cb56685e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1289,7 +1289,7 @@ static void ppce500_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
 
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo e500_ccsr_info = {
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 8798bda033..46f22301f6 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -100,7 +100,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index e5d78c5a17..e1b28a33f9 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -579,7 +579,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_display = "std";
     mc->default_nic = "sungem";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 135caf7db5..76ce62f236 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -427,7 +427,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "ne2k_pci";
     mc->ignore_boot_device_suffixes = true;
     mc->default_ram_id = "ppc_heathrow.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 0d175ed6d8..e19558a275 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -62,7 +62,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 7745f70a6f..a9d096f07c 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -576,7 +576,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     machine_add_audiodev_property(mc);
 
     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index cf74251174..4af6a41081 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2879,7 +2879,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     /* Pnv provides a AHCI device for storage */
     mc->block_default_type = IF_IDE;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_boot_order = NULL;
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 8c68d419e1..343102f514 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -351,7 +351,7 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
     mc->deprecation_reason = "machine is old and unmaintained";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo ppc405_machine_type = {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 8003bbb255..088b7cee6f 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -267,7 +267,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
     mc->default_ram_id = "ppc4xx.sdram";
     mc->default_nic = "e1000";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index bb69e5f635..c66fd687de 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -428,7 +428,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1d7cd9cf74..3a88d64a0e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -524,7 +524,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2d61853e33..19e6d5158c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4594,7 +4594,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc_spapr.ram";
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index a6fe83c9d4..1ed0a332d2 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -288,7 +288,7 @@ static void virtex_machine_init(MachineClass *mc)
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
     mc->default_ram_id = "ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index 1f7b0b96dd..af283fefcf 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -128,7 +128,7 @@ static void remote_machine_class_init(ObjectClass *oc, void *data)
 
     mc->init = remote_machine_init;
     mc->desc = "Experimental remote machine";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     hc->unplug = remote_machine_dev_unplug_cb;
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 3985fa1d52..604afce542 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -647,7 +647,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     /*
      * Map 513 MiB high memory, the minimum required high memory size, because
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 4f0e890aa4..b1da96c214 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -119,7 +119,7 @@ static void opentitan_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void lowrisc_ibex_soc_init(Object *obj)
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index e815c04dd2..e0798d44b1 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -84,7 +84,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo shakti_c_machine_type_info = {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 10c089818c..aa12991dc5 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -151,7 +151,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_E_CPU;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
                                    sifive_e_machine_set_revb);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1ef4efcea7..802429e896 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -720,7 +720,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_U_CPU;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 
     object_class_property_add_bool(oc, "start-in-flash",
                                    sifive_u_machine_get_start_in_flash,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 444b8d6390..c6a073d1c2 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -356,7 +356,7 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 39a1cafdc3..d3050c73b6 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1805,7 +1805,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index afd7a5ee55..e87a90f7d3 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -166,7 +166,7 @@ static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RX62N_CPU;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "ext-sdram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void rx62n7_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8b40b87899..025dd0cabf 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -747,7 +747,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = ON_OFF_AUTO_ON;
+    mc->create_default_sdcard_drive = false;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->smp_props.books_supported = true;
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 9f3303e0f9..ab7dfe3480 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -378,7 +378,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
     mc->default_nic = "rtl8139";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index a6bde39f25..e7e63e47f4 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -440,7 +440,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
     mc->max_cpus = MAX_CPUS;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 90ab3a62e5..1cfe77c50e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1117,7 +1117,7 @@ static void sun4m_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_display = "tcx";
     mc->default_ram_id = "sun4m.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static void ss5_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 07f60efdf2..5bdf0898c2 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -167,7 +167,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_ram_id = "sun4v-partition.ram";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo niagara_type = {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4e3e6e5b7b..0d73d6234c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -816,7 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     fwc->get_dev_path = sun4u_fw_dev_path;
     compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
@@ -844,7 +844,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo sun4v_type = {
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index ffd6e3b60a..7fec6a3649 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -75,7 +75,7 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->init        = triboard_machine_init;
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
     amc->soc_name   = "tc277d-soc";
 };
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index 05143a6ab4..922225bb1b 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -111,7 +111,7 @@ static void ttb_machine_init(MachineClass *mc)
     mc->desc = "a minimal TriCore board";
     mc->init = tricoreboard_init;
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 5e824c233d..2a9e50ed79 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -381,7 +381,7 @@ static void xen_pvh_class_init(ObjectClass *oc, void *data)
     mc->default_machine_opts = "accel=xen";
     /* Set to zero to make sure that the real ram size is passed. */
     mc->default_ram_size = 0;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xen_pvh_info = {
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 71794fe524..2aa340ae49 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -67,7 +67,7 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index ea60854266..baa6e3d17f 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -124,7 +124,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->no_serial = 1;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 7aa398c416..01ad8180a2 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -122,7 +122,7 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 DEFINE_MACHINE("virt", xtensa_virt_machine_init)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index cc29117e97..43e3ef688f 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -592,7 +592,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 64 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -610,7 +610,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 64 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -628,7 +628,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 96 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -646,7 +646,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 96 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -664,7 +664,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -682,7 +682,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -700,7 +700,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -718,7 +718,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
-    mc->no_sdcard = ON_OFF_AUTO_OFF;
+    mc->create_default_sdcard_drive = true;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
diff --git a/system/vl.c b/system/vl.c
index 3b9f58b967..df1d52bcf5 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1350,8 +1350,7 @@ static void qemu_disable_default_devices(void)
     if (!has_defaults || machine_class->no_cdrom) {
         default_cdrom = 0;
     }
-    assert(machine_class->no_sdcard != ON_OFF_AUTO_AUTO);
-    if (!has_defaults || machine_class->no_sdcard == ON_OFF_AUTO_ON) {
+    if (!has_defaults || !machine_class->create_default_sdcard_drive) {
         default_sdcard = 0;
     }
     if (!has_defaults) {
-- 
2.45.2


