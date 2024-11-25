Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F87D58D78
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 18:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFdbp-0001Ge-0i; Mon, 25 Nov 2024 13:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFdbk-0001D5-3Z
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:14:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFdbc-0005Dp-5Y
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 13:14:47 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-432d866f70fso44124905e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732558477; x=1733163277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TeUD3ACsrljufb8a/t0fN+VTQhOJNtcVR72LF73TigA=;
 b=P2lqe+jQVVJ72zuDge6ZflBwRAHd8vYgpeC16fX9iXg43AMJDVDdXwusFZ9nkRF24d
 PQDKV4LDKdnlc9gLrvCK3vHzILcAAUP2PipC8hIRor51EWIEHqaG8SNyYS6o0uXL/UWL
 yFp6gu5sPHn9m1OVmTqYW1LBakKbpZlwMkgJy/8l94XyPo/hzy6D236QbTVJ+T0FIv5s
 Vj9Ld1yFfFQuexwcvR4jkfNwqHCuUdV1ZwrLGRwqgeseOLdp0iVb9UFC+rZlPMjsRp3S
 MLvROyfYwgTf6PrmBg5V40CoYxcDCAap/tp9rCJO+EylSGWbPHhJiKxpR9npYFyUjtgH
 Iofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732558477; x=1733163277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TeUD3ACsrljufb8a/t0fN+VTQhOJNtcVR72LF73TigA=;
 b=L747+MGAdEkpW0rv+nSFigHZPlA5jZfvZNfXAn/0eSKrCZlFn0CIYN7CszGfm0Twkt
 YLxZUZigoKOuZNplrrZN1185PTv6PgYu50oQFS8CvocGdNNk6zzVGoYM0O2ZcwjfFDLZ
 +KhB9+GjEuA5vC9ZZDIfK2Iz4bMcAF2A3n0sJrjrZvVaMavd+sx/G62Hg1FEFaEmCM5Z
 WqL9I9d0zHkyOH0iUwaiA3i8t1raQ4eqlaGaql9CiGwVg2QNHIKdS1ffqVZWKTcL7bfH
 HEZOcxWVIWTjA6Rx+BuhjhKgQNmYNWYa+dUu3tkpzPBGV4cnAuLPlAp35dvQJJ2HIJh+
 +kXw==
X-Gm-Message-State: AOJu0Yzygrq6x6/F+bZ4hjoryuEbuQ61plvkTt3BmA6D99EAbPcttbgj
 PtgUrBzgeqHUw+ZBG498BUs3uv8kEpXFHE6n4umrrHOwtZQOzcrar1QRTUVO01J61KCXLX6IBOa
 K
X-Gm-Gg: ASbGncuAfCKJxekYo3U2bwDlBa55n2L0gp9rG2E6v5XJQ2x+xiZLhVH3dOOQI/K72XT
 AYcEciC8elXjA43Fatqf555Qv19KaZoM0AiW4ycBazNlTlfJ+ApDt2h1Mi31oeGyOP8CS6axIuJ
 VBBe+uvzi10tfm8EnFKb+I2jXMMhv1UvydvXQtq5vhWsHuXWFp5GiN4QYTfub3edrKv5y6LVspj
 zxblkjDBQEYduDAYeq4VNr1pvE5nA+dZYG5ijHBROK0TpTywGimWD9aKGnsad8gGss3w2vR
X-Google-Smtp-Source: AGHT+IG7tl0FBMHTaljUwUWvJNGgifLnK7bt11shPR79ekNeT+7HtTh+AU6JW/+jo7p4qodgzp0TPA==
X-Received: by 2002:a05:6000:184e:b0:382:2242:7a8 with SMTP id
 ffacd0b85a97d-38260bcb00cmr11258357f8f.40.1732558476221; 
 Mon, 25 Nov 2024 10:14:36 -0800 (PST)
Received: from localhost.localdomain ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedebfsm11099397f8f.100.2024.11.25.10.14.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Nov 2024 10:14:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 2/3] hw/boards: Explicit no_sdcard=false as
 ON_OFF_AUTO_OFF
Date: Mon, 25 Nov 2024 19:14:19 +0100
Message-ID: <20241125181420.24424-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241125181420.24424-1-philmd@linaro.org>
References: <20241125181420.24424-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Update MachineClass::no_sdcard default implicit AUTO
initialization to explicit OFF. This flag is consumed
in system/vl.c::qemu_disable_default_devices(). Use
this place to assert we don't have anymore AUTO state.

In hw/ppc/e500.c we add the ppce500_machine_class_init()
method to initialize once all the inherited classes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/alpha/dp264.c                         | 1 +
 hw/arm/aspeed.c                          | 2 ++
 hw/arm/b-l475e-iot01a.c                  | 1 +
 hw/arm/bananapi_m2u.c                    | 1 +
 hw/arm/collie.c                          | 1 +
 hw/arm/cubieboard.c                      | 1 +
 hw/arm/digic_boards.c                    | 1 +
 hw/arm/exynos4_boards.c                  | 2 ++
 hw/arm/fby35.c                           | 1 +
 hw/arm/highbank.c                        | 2 ++
 hw/arm/imx25_pdk.c                       | 1 +
 hw/arm/integratorcp.c                    | 1 +
 hw/arm/kzm.c                             | 1 +
 hw/arm/mcimx6ul-evk.c                    | 1 +
 hw/arm/mcimx7d-sabre.c                   | 1 +
 hw/arm/microbit.c                        | 1 +
 hw/arm/mps2-tz.c                         | 1 +
 hw/arm/mps2.c                            | 1 +
 hw/arm/mps3r.c                           | 1 +
 hw/arm/msf2-som.c                        | 1 +
 hw/arm/musca.c                           | 1 +
 hw/arm/musicpal.c                        | 1 +
 hw/arm/netduino2.c                       | 1 +
 hw/arm/netduinoplus2.c                   | 1 +
 hw/arm/npcm7xx_boards.c                  | 1 +
 hw/arm/olimex-stm32-h405.c               | 1 +
 hw/arm/omap_sx1.c                        | 2 ++
 hw/arm/orangepi.c                        | 1 +
 hw/arm/raspi.c                           | 1 +
 hw/arm/realview.c                        | 4 ++++
 hw/arm/sabrelite.c                       | 1 +
 hw/arm/sbsa-ref.c                        | 1 +
 hw/arm/stellaris.c                       | 2 ++
 hw/arm/stm32vldiscovery.c                | 1 +
 hw/arm/versatilepb.c                     | 2 ++
 hw/arm/vexpress.c                        | 1 +
 hw/arm/virt.c                            | 1 +
 hw/arm/xen-pvh.c                         | 1 +
 hw/arm/xilinx_zynq.c                     | 1 +
 hw/arm/xlnx-versal-virt.c                | 1 +
 hw/arm/xlnx-zcu102.c                     | 1 +
 hw/avr/arduino.c                         | 1 +
 hw/hppa/machine.c                        | 2 ++
 hw/i386/pc.c                             | 1 +
 hw/i386/x86.c                            | 1 +
 hw/i386/xen/xen-pvh.c                    | 1 +
 hw/loongarch/virt.c                      | 1 +
 hw/m68k/an5206.c                         | 1 +
 hw/m68k/mcf5208.c                        | 1 +
 hw/m68k/next-cube.c                      | 1 +
 hw/m68k/q800.c                           | 1 +
 hw/m68k/virt.c                           | 1 +
 hw/microblaze/petalogix_ml605_mmu.c      | 1 +
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
 hw/microblaze/xlnx-zynqmp-pmu.c          | 1 +
 hw/mips/boston.c                         | 1 +
 hw/mips/fuloong2e.c                      | 1 +
 hw/mips/jazz.c                           | 2 ++
 hw/mips/loongson3_virt.c                 | 1 +
 hw/mips/malta.c                          | 1 +
 hw/mips/mipssim.c                        | 1 +
 hw/openrisc/openrisc_sim.c               | 1 +
 hw/openrisc/virt.c                       | 1 +
 hw/ppc/amigaone.c                        | 1 +
 hw/ppc/e500.c                            | 8 ++++++++
 hw/ppc/e500plat.c                        | 1 +
 hw/ppc/mac_newworld.c                    | 1 +
 hw/ppc/mac_oldworld.c                    | 1 +
 hw/ppc/mpc8544ds.c                       | 1 +
 hw/ppc/pegasos2.c                        | 1 +
 hw/ppc/pnv.c                             | 1 +
 hw/ppc/ppc405_boards.c                   | 1 +
 hw/ppc/ppc440_bamboo.c                   | 1 +
 hw/ppc/prep.c                            | 1 +
 hw/ppc/sam460ex.c                        | 1 +
 hw/ppc/spapr.c                           | 1 +
 hw/ppc/virtex_ml507.c                    | 1 +
 hw/remote/machine.c                      | 1 +
 hw/riscv/microchip_pfsoc.c               | 1 +
 hw/riscv/opentitan.c                     | 1 +
 hw/riscv/shakti_c.c                      | 1 +
 hw/riscv/sifive_e.c                      | 1 +
 hw/riscv/sifive_u.c                      | 1 +
 hw/riscv/spike.c                         | 1 +
 hw/riscv/virt.c                          | 1 +
 hw/rx/rx-gdbsim.c                        | 1 +
 hw/sh4/r2d.c                             | 1 +
 hw/sparc/leon3.c                         | 1 +
 hw/sparc/sun4m.c                         | 1 +
 hw/sparc64/niagara.c                     | 1 +
 hw/sparc64/sun4u.c                       | 2 ++
 hw/tricore/triboard.c                    | 1 +
 hw/tricore/tricore_testboard.c           | 1 +
 hw/xen/xen-pvh-common.c                  | 1 +
 hw/xenpv/xen_machine_pv.c                | 1 +
 hw/xtensa/sim.c                          | 1 +
 hw/xtensa/virt.c                         | 1 +
 hw/xtensa/xtfpga.c                       | 8 ++++++++
 system/vl.c                              | 1 +
 99 files changed, 125 insertions(+)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 52a1fa310b..5fa1aa9df8 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -213,6 +213,7 @@ static void clipper_machine_init(MachineClass *mc)
     mc->default_cpu_type = ALPHA_CPU_TYPE_NAME("ev67");
     mc->default_ram_id = "ram";
     mc->default_nic = "e1000";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("clipper", clipper_machine_init)
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6ca145362c..cd4512612c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1193,6 +1193,7 @@ static void aspeed_machine_class_init_cpus_defaults(MachineClass *mc)
     mc->min_cpus = sc->num_cpus;
     mc->max_cpus = sc->num_cpus;
     mc->valid_cpu_types = sc->valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static bool aspeed_machine_ast2600_get_boot_from_emmc(Object *obj, Error **errp)
@@ -1232,6 +1233,7 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_id = "ram";
     amc->macs_mask = ASPEED_MAC0_ON;
     amc->uart_default = ASPEED_DEV_UART5;
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 5002a40f06..0338c4fd84 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -120,6 +120,7 @@ static void bl475e_machine_init(ObjectClass *oc, void *data)
     mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
     mc->init = bl475e_init;
     mc->valid_cpu_types = machine_valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 0a4b6f29b1..3da6ec4a03 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -141,6 +141,7 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "bpim2u.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index eaa5c52d45..80bf12246a 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -79,6 +79,7 @@ static void collie_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "strongarm.sdram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo collie_machine_typeinfo = {
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index b976727eef..11d896f832 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -122,6 +122,7 @@ static void cubieboard_machine_init(MachineClass *mc)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "cubieboard.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("cubieboard", cubieboard_machine_init)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 4093af09cb..59e4989d29 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -143,6 +143,7 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_size = 64 * MiB;
     mc->default_ram_id = "ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 2410e2a28e..63e86e2c60 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -165,6 +165,7 @@ static void nuri_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo nuri_type = {
@@ -184,6 +185,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo smdkc210_type = {
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index c9964bd283..0c4418c0e8 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -170,6 +170,7 @@ static void fby35_class_init(ObjectClass *oc, void *data)
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
 
     object_class_property_add_bool(oc, "execute-in-place",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f103921d49..503aa6f86f 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,6 +357,7 @@ static void highbank_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo highbank_type = {
@@ -381,6 +382,7 @@ static void midway_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo midway_type = {
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 7dfddd49e2..e5871c5d6b 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -147,6 +147,7 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "imx25.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index feb0dd63df..4110954851 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -688,6 +688,7 @@ static void integratorcp_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "integrator.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index fbd140e383..5dea5199d4 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,6 +137,7 @@ static void kzm_machine_init(MachineClass *mc)
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 500427e94b..276ff5549f 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -74,5 +74,6 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
     mc->default_ram_id = "mcimx6ul-evk.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 693a1023b6..1ba931b4bf 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -74,5 +74,6 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
     mc->default_ram_id = "mcimx7d-sabre.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 50df362088..57e5fe2026 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -67,6 +67,7 @@ static void microbit_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "BBC micro:bit (Cortex-M0)";
     mc->init = microbit_init;
     mc->max_cpus = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo microbit_info = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8edf57a66d..be6cf41940 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1273,6 +1273,7 @@ static void mps2tz_class_init(ObjectClass *oc, void *data)
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(oc);
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_CLASS(oc);
 
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->init = mps2tz_common_init;
     mc->reset = mps2_machine_reset;
     iic->check = mps2_tz_idau_check;
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..287e48715d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -472,6 +472,7 @@ static void mps2_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "mps.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 4d55a6564c..f98c081f81 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -588,6 +588,7 @@ static void mps3r_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->init = mps3r_common_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void mps3r_an536_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 5c415abe85..73ea5a0202 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -106,6 +106,7 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index e2c9d49af5..0ee05655d9 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -607,6 +607,7 @@ static void musca_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = mc->default_cpus;
     mc->valid_cpu_types = valid_cpu_types;
     mc->init = musca_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void musca_a_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 33ece06bbd..16e7873216 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1342,6 +1342,7 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
     mc->default_ram_id = "musicpal.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 8b1a9a2437..93f5dcf0b6 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -63,6 +63,7 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->init = netduino2_init;
     mc->valid_cpu_types = valid_cpu_types;
     mc->ignore_memory_transaction_failures = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index bccd100354..be5c7b6081 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -63,6 +63,7 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index e229efb447..6f80c8f937 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -464,6 +464,7 @@ static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_id = "ram";
     mc->valid_cpu_types = valid_cpu_types;
 }
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 4ad7b043be..fc6de35ef1 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -66,6 +66,7 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 62d7915fb8..e561817798 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -216,6 +216,7 @@ static void sx1_machine_v2_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo sx1_machine_v2_type = {
@@ -234,6 +235,7 @@ static void sx1_machine_v1_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = SDRAM_SIZE;
     mc->default_ram_id = "omap1.dram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo sx1_machine_v1_type = {
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 77e328191d..76ab214853 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -121,6 +121,7 @@ static void orangepi_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "orangepi.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a7a662f40d..4195ba07c6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -325,6 +325,7 @@ void raspi_machine_class_common_init(MachineClass *mc,
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_cpus = mc->min_cpus = mc->max_cpus = cores_count(board_rev);
     mc->default_ram_size = board_ram_size(board_rev);
     mc->default_ram_id = "ram";
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b186f965c6..fdbe4bd88c 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -415,6 +415,7 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -435,6 +436,7 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -453,6 +455,7 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->init = realview_pb_a8_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -472,6 +475,7 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 56f184b9ae..56f6306a1f 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -110,6 +110,7 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "sabrelite.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d5449..37abb327a6 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -900,6 +900,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 376746251e..46f343679c 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1388,6 +1388,7 @@ static void lm3s811evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s811evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo lm3s811evb_type = {
@@ -1404,6 +1405,7 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index cc41935160..93f5d3a627 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -66,6 +66,7 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
     mc->valid_cpu_types = valid_cpu_types;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index d48235453e..db95351946 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -419,6 +419,7 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
@@ -439,6 +440,7 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index de815d84cc..6f602f8486 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -783,6 +783,7 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "vexpress.highmem";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", vexpress_get_secure,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 1a381e9a2b..050384f52f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3124,6 +3124,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 33f0dd5982..632ab06b16 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -75,6 +75,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      * mc->max_cpus, QEMU will bail out with an error message.
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 76bab2499f..bcdd30db83 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -467,6 +467,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     prop = object_class_property_add_str(oc, "boot-mode", NULL,
                                          zynq_set_boot_mode);
     object_class_property_set_description(oc, "boot-mode",
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 8b12d3e7cb..2a66dafb34 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -818,6 +818,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4667cb333c..40c9e0cc23 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -280,6 +280,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_ram_id = "ddr-ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", zcu102_get_secure,
diff --git a/hw/avr/arduino.c b/hw/avr/arduino.c
index 48ef478346..1801074a42 100644
--- a/hw/avr/arduino.c
+++ b/hw/avr/arduino.c
@@ -67,6 +67,7 @@ static void arduino_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void arduino_duemilanove_class_init(ObjectClass *oc, void *data)
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index a31dc32a9f..e48c58e4c6 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -708,6 +708,7 @@ static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
@@ -744,6 +745,7 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_ram_id = "ram";
     mc->default_nic = "tulip";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     nc->nmi_monitor_handler = hppa_nmi;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 317aaca25a..f6799eb817 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1794,6 +1794,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->smp_props.dies_supported = true;
     mc->smp_props.modules_supported = true;
     mc->default_ram_id = "pc.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_AUTO;
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 01fc5e6562..adbac29ba0 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -382,6 +382,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
     mc->kvm_type = x86_kvm_type;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index f1f02d3311..e4d101c24a 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -82,6 +82,7 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Xen PVH x86 machine";
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /* mc->max_cpus holds the MAX value allowed in the -smp cmd-line opts. */
     mc->max_cpus = HVM_MAX_VCPUS;
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9a635d1d3d..92ef0cdb38 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1449,6 +1449,7 @@ static void virt_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = virt_cpu_index_to_props;
     mc->get_default_cpu_node_id = virt_get_default_cpu_node_id;
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 1e8e64f8bd..d48558c999 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -99,6 +99,7 @@ static void an5206_machine_init(MachineClass *mc)
     mc->init = an5206_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5206");
     mc->default_ram_id = "an5206.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("an5206", an5206_machine_init)
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index e37cd50d18..fd82813f5a 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -398,6 +398,7 @@ static void mcf5208evb_machine_init(MachineClass *mc)
     mc->is_default = true;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m5208");
     mc->default_ram_id = "mcf5208.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("mcf5208evb", mcf5208evb_machine_init)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 08886d432c..200cd7a5b3 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -1068,6 +1068,7 @@ static void next_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "next.ram";
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo next_typeinfo = {
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 556604e1dc..23999e50c4 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -743,6 +743,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index ea5c4a5a57..8707990446 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -318,6 +318,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_ram_id = "m68k_virt.ram";
 }
 
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index 61e47d8398..c1b83b354f 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -220,6 +220,7 @@ static void petalogix_ml605_machine_init(MachineClass *mc)
     mc->desc = "PetaLogix linux refdesign for xilinx ml605 (little endian)";
 #endif
     mc->init = petalogix_ml605_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("petalogix-ml605", petalogix_ml605_machine_init)
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 6c0f5c6c65..2c8e3b80d4 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -142,6 +142,7 @@ static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 567aad47bf..4d6dc8bbf5 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -188,6 +188,7 @@ static void xlnx_zynqmp_pmu_machine_init(MachineClass *mc)
     mc->desc = "Xilinx ZynqMP PMU machine (little endian)";
 #endif
     mc->init = xlnx_zynqmp_pmu_init;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("xlnx-zynqmp-pmu", xlnx_zynqmp_pmu_machine_init)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1ced1e337a..997d6fbda2 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -842,6 +842,7 @@ static void boston_mach_class_init(MachineClass *mc)
     mc->default_ram_id = "boston.ddr";
     mc->max_cpus = 16;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("I6400");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("boston", boston_mach_class_init)
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 7fd8296ccb..b646e14e89 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -334,6 +334,7 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
     mc->minimum_page_bits = 14;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 0e43c9f0ba..ad034959ad 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -424,6 +424,7 @@ static void mips_magnum_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo mips_magnum_type = {
@@ -441,6 +442,7 @@ static void mips_pica61_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("R4000");
     mc->default_ram_id = "mips_jazz.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo mips_pica61_type = {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f3b6326cc5..0efe4480fe 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -672,6 +672,7 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1600 * MiB;
     mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo loongson3_machine_types[] = {
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 198da5ba3d..dd565ba388 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1304,6 +1304,7 @@ static void mips_malta_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_malta.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     compat_props_add(mc->compat_props, malta_compat, malta_compat_len);
 }
 
diff --git a/hw/mips/mipssim.c b/hw/mips/mipssim.c
index 5f4835a38d..b008da5602 100644
--- a/hw/mips/mipssim.c
+++ b/hw/mips/mipssim.c
@@ -246,6 +246,7 @@ static void mips_mipssim_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("24Kf");
 #endif
     mc->default_ram_id = "mips_mipssim.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("mipssim", mips_mipssim_machine_init)
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 9fb63515ef..0d2d5d30b3 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -354,6 +354,7 @@ static void openrisc_sim_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = OR1KSIM_CPUS_MAX;
     mc->is_default = true;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 47d2c9bd3c..1edecd76c8 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -554,6 +554,7 @@ static void openrisc_virt_machine_init(ObjectClass *oc, void *data)
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->is_default = false;
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo or1ksim_machine_typeinfo = {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 900f93c15e..e54da2bdcc 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -173,6 +173,7 @@ static void amigaone_machine_init(MachineClass *mc)
     mc->default_display = "std";
     mc->default_ram_id = "ram";
     mc->default_ram_size = 512 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 46261223f3..547a89ff3b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1285,6 +1285,13 @@ static void e500_ccsr_initfn(Object *obj)
                        MPC8544_CCSRBAR_SIZE);
 }
 
+static void ppce500_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
+}
+
 static const TypeInfo e500_ccsr_info = {
     .name          = TYPE_CCSR,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -1298,6 +1305,7 @@ static const TypeInfo ppce500_info = {
     .abstract      = true,
     .instance_size = sizeof(PPCE500MachineState),
     .class_size    = sizeof(PPCE500MachineClass),
+    .class_init    = ppce500_machine_class_init,
 };
 
 static void e500_register_types(void)
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 7aa2f2107a..8798bda033 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -100,6 +100,7 @@ static void e500plat_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
  }
 
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 9d249a506c..e5d78c5a17 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -579,6 +579,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "cd";
     mc->default_display = "std";
     mc->default_nic = "sungem";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->kvm_type = core99_kvm_type;
 #ifdef TARGET_PPC64
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("970fx_v3.1");
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index eef3261002..135caf7db5 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -427,6 +427,7 @@ static void heathrow_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "ne2k_pci";
     mc->ignore_boot_device_suffixes = true;
     mc->default_ram_id = "ppc_heathrow.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     fwc->get_dev_path = heathrow_fw_dev_path;
 }
 
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index b7130903d6..0d175ed6d8 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -62,6 +62,7 @@ static void mpc8544ds_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("e500v2_v30");
     mc->default_ram_id = "mpc8544ds.ram";
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 #define TYPE_MPC8544DS_MACHINE  MACHINE_TYPE_NAME("mpc8544ds")
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 8ff4a00c34..7745f70a6f 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -576,6 +576,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     machine_add_audiodev_property(mc);
 
     vhc->cpu_in_nested = pegasos2_cpu_in_nested;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0f0d7567d..cf74251174 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2879,6 +2879,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
     /* Pnv provides a AHCI device for storage */
     mc->block_default_type = IF_IDE;
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_boot_order = NULL;
     /*
      * RAM defaults to less than 2048 for 32-bit hosts, and large
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 347428e633..8c68d419e1 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -351,6 +351,7 @@ static void ppc405_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->default_ram_id = "ppc405.ram";
     mc->deprecation_reason = "machine is old and unmaintained";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo ppc405_machine_type = {
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index a55f108434..8003bbb255 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -267,6 +267,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440epb");
     mc->default_ram_id = "ppc4xx.sdram";
     mc->default_nic = "e1000";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index fb58c312ac..bb69e5f635 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -428,6 +428,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");
     mc->default_display = "std";
     mc->default_nic = "pcnet";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 78e2a46e75..1d7cd9cf74 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -524,6 +524,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5c02037c56..2d61853e33 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4594,6 +4594,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = SPAPR_IRQ_NR_IPIS;
 
     mc->no_parallel = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->default_boot_order = "";
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc_spapr.ram";
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f378e5c4a9..a6fe83c9d4 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -288,6 +288,7 @@ static void virtex_machine_init(MachineClass *mc)
     mc->init = virtex_init;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
     mc->default_ram_id = "ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("virtex-ml507", virtex_machine_init)
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index fdc6c441bb..1f7b0b96dd 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -128,6 +128,7 @@ static void remote_machine_class_init(ObjectClass *oc, void *data)
 
     mc->init = remote_machine_init;
     mc->desc = "Experimental remote machine";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     hc->unplug = remote_machine_dev_unplug_cb;
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index f9a3b43d2e..3985fa1d52 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -647,6 +647,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT + 1;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "microchip.icicle.kit.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     /*
      * Map 513 MiB high memory, the minimum required high memory size, because
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index e2830e9dc2..4f0e890aa4 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -119,6 +119,7 @@ static void opentitan_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
     mc->default_ram_id = "riscv.lowrisc.ibex.ram";
     mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void lowrisc_ibex_soc_init(Object *obj)
diff --git a/hw/riscv/shakti_c.c b/hw/riscv/shakti_c.c
index 2dccc1eff2..e815c04dd2 100644
--- a/hw/riscv/shakti_c.c
+++ b/hw/riscv/shakti_c.c
@@ -84,6 +84,7 @@ static void shakti_c_machine_class_init(ObjectClass *klass, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_SHAKTI_C;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "riscv.shakti.c.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo shakti_c_machine_type_info = {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 5a1959f2a9..10c089818c 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -151,6 +151,7 @@ static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_E_CPU;
     mc->default_ram_id = "riscv.sifive.e.ram";
     mc->default_ram_size = sifive_e_memmap[SIFIVE_E_DEV_DTIM].size;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     object_class_property_add_bool(oc, "revb", sifive_e_machine_get_revb,
                                    sifive_e_machine_set_revb);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c5e74126b1..1ef4efcea7 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -720,6 +720,7 @@ static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = SIFIVE_U_CPU;
     mc->default_cpus = mc->min_cpus;
     mc->default_ram_id = "riscv.sifive.u.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 
     object_class_property_add_bool(oc, "start-in-flash",
                                    sifive_u_machine_get_start_in_flash,
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index fceb91d946..444b8d6390 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -356,6 +356,7 @@ static void spike_machine_class_init(ObjectClass *oc, void *data)
     /* platform instead of architectural choice */
     mc->cpu_cluster_has_numa_boundary = true;
     mc->default_ram_id = "riscv.spike.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     object_class_property_add_str(oc, "signature", NULL, spike_set_signature);
     object_class_property_set_description(oc, "signature",
                                           "File to write ACT test signature");
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 45a8c4f819..39a1cafdc3 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1805,6 +1805,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     mc->pci_allow_0_address = true;
     mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
     mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index bb4746c556..afd7a5ee55 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -166,6 +166,7 @@ static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TYPE_RX62N_CPU;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "ext-sdram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void rx62n7_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 7eecd79fcc..9f3303e0f9 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -378,6 +378,7 @@ static void r2d_machine_init(MachineClass *mc)
     mc->block_default_type = IF_IDE;
     mc->default_cpu_type = TYPE_SH7751R_CPU;
     mc->default_nic = "rtl8139";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6aaa04cb19..a6bde39f25 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -440,6 +440,7 @@ static void leon3_generic_machine_init(MachineClass *mc)
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("LEON3");
     mc->default_ram_id = "leon3.ram";
     mc->max_cpus = MAX_CPUS;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("leon3_generic", leon3_generic_machine_init)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..90ab3a62e5 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -1117,6 +1117,7 @@ static void sun4m_machine_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_display = "tcx";
     mc->default_ram_id = "sun4m.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static void ss5_class_init(ObjectClass *oc, void *data)
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 67ec403e1d..07f60efdf2 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -167,6 +167,7 @@ static void niagara_class_init(ObjectClass *oc, void *data)
     mc->default_boot_order = "c";
     mc->default_cpu_type = SPARC_CPU_TYPE_NAME("Sun-UltraSparc-T1");
     mc->default_ram_id = "sun4v-partition.ram";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo niagara_type = {
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 541c7f74fa..4e3e6e5b7b 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -816,6 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     fwc->get_dev_path = sun4u_fw_dev_path;
     compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
@@ -843,6 +844,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
     mc->default_display = "std";
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo sun4v_type = {
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
index 4dba0259cd..ffd6e3b60a 100644
--- a/hw/tricore/triboard.c
+++ b/hw/tricore/triboard.c
@@ -75,6 +75,7 @@ static void triboard_machine_tc277d_class_init(ObjectClass *oc,
     mc->init        = triboard_machine_init;
     mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
     mc->max_cpus    = 1;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
     amc->soc_name   = "tc277d-soc";
 };
 
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboard.c
index c29db8b451..05143a6ab4 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -111,6 +111,7 @@ static void ttb_machine_init(MachineClass *mc)
     mc->desc = "a minimal TriCore board";
     mc->init = tricoreboard_init;
     mc->default_cpu_type = TRICORE_CPU_TYPE_NAME("tc1796");
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("tricore_testboard", ttb_machine_init)
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 218ac851cf..5e824c233d 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -381,6 +381,7 @@ static void xen_pvh_class_init(ObjectClass *oc, void *data)
     mc->default_machine_opts = "accel=xen";
     /* Set to zero to make sure that the real ram size is passed. */
     mc->default_ram_size = 0;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xen_pvh_info = {
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index 24395f42cb..71794fe524 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -67,6 +67,7 @@ static void xenpv_machine_init(MachineClass *mc)
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("xenpv", xenpv_machine_init)
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 2160e61964..ea60854266 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -124,6 +124,7 @@ static void xtensa_sim_machine_init(MachineClass *mc)
     mc->max_cpus = 4;
     mc->no_serial = 1;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("sim", xtensa_sim_machine_init)
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 5310a88861..7aa398c416 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -122,6 +122,7 @@ static void xtensa_virt_machine_init(MachineClass *mc)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_nic = "virtio-net-pci";
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 DEFINE_MACHINE("virt", xtensa_virt_machine_init)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 398e6256e1..cc29117e97 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -592,6 +592,7 @@ static void xtfpga_lx60_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 64 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx60_type = {
@@ -609,6 +610,7 @@ static void xtfpga_lx60_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 64 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx60_nommu_type = {
@@ -626,6 +628,7 @@ static void xtfpga_lx200_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 96 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx200_type = {
@@ -643,6 +646,7 @@ static void xtfpga_lx200_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 96 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_lx200_nommu_type = {
@@ -660,6 +664,7 @@ static void xtfpga_ml605_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 512 * MiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_ml605_type = {
@@ -677,6 +682,7 @@ static void xtfpga_ml605_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_ml605_nommu_type = {
@@ -694,6 +700,7 @@ static void xtfpga_kc705_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_TYPE;
     mc->default_ram_size = 1 * GiB - XTFPGA_MMU_RESERVED_MEMORY_SIZE;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_kc705_type = {
@@ -711,6 +718,7 @@ static void xtfpga_kc705_nommu_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 32;
     mc->default_cpu_type = XTENSA_DEFAULT_CPU_NOMMU_TYPE;
     mc->default_ram_size = 256 * MiB;
+    mc->no_sdcard = ON_OFF_AUTO_OFF;
 }
 
 static const TypeInfo xtfpga_kc705_nommu_type = {
diff --git a/system/vl.c b/system/vl.c
index 4a7c29a8ab..3b9f58b967 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1350,6 +1350,7 @@ static void qemu_disable_default_devices(void)
     if (!has_defaults || machine_class->no_cdrom) {
         default_cdrom = 0;
     }
+    assert(machine_class->no_sdcard != ON_OFF_AUTO_AUTO);
     if (!has_defaults || machine_class->no_sdcard == ON_OFF_AUTO_ON) {
         default_sdcard = 0;
     }
-- 
2.45.2


