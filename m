Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134CDC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNMo-00065G-5Y; Tue, 04 Feb 2025 13:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNLY-0004WG-76
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:08:31 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNLR-0007Dq-5I
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:08:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so70145885e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738692499; x=1739297299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XQevLhcTv5uYA5KB/5zrqXWN7OuQyLnP4HfdzJLZOI=;
 b=CMnCo0YRFYnhMGYR6Ai0tCtf1bx9Csxgo2lawn0KtLR13HrnMoGeiatl0h8gp5uhGi
 Wld7uwNlTkVv0zvAJasgOjHLdjI6TLrp5uytndjji0ZZ0LWPOvPnHj/4+YAvyHp7QqP5
 hgZv7se0qER7rGm/UHriS7cNYTQlj6RGBZDOTMTFmr9mLqC2/n6IQdVShLuktP1lu1vr
 YXZIoHRoeFIDU59MnDSNvIdFbhnnbkEw6DVD8uHLGvmxydx3Db5uwmGIgd7vMfJuz2Cr
 dBGj1RHdjCNAGTddchkRXR2CMFIWZqcnvo0ebhZzkZDUoigI6nWl0WaIF8l8ZdR8lQV7
 ij3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738692499; x=1739297299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XQevLhcTv5uYA5KB/5zrqXWN7OuQyLnP4HfdzJLZOI=;
 b=PPq09F+5KtFHWmE8bFu1meYSZmtJIwlhVptQjhZRAe0V4EaDLCu5zGNEk6NIbKe69o
 y/PogDGuIq6fkV7qJxUH8aP4S52b85GO+BLSnH9ujGN/TP/oCFvro9K5IwCiYqGU8KjL
 IXAt4pAgiq4vBQv5X0bnYwsjuHeDLuMeX5xO9vKPdYmvmkc4gnbBq5Rm0GfQ1jkTOBhH
 CaJC+Ae5sovAJ3NV8mzLvINKHSSUZoqWtevOurEcpxPJhM82BXVs7CWEis0b3T4Pp2Va
 GgjmIwsxUHdpo5MM6EDBjEDHLCOfMyxiSU2FARx9HP0QCR5e9Gz0g3GniCihNd5xe4s2
 I6IA==
X-Gm-Message-State: AOJu0YyH+UEcziaQ/zkIOJo4H+fWEF1uoKoVRMC87bDMryRfv99d7Uyz
 UXSRiwyZ4yge3Fhlem7BKD91TaIWbt+AIT211iq4e83u71QP3SNsJEX7Ok0SXDwfRK12TQUu97J
 FOEk=
X-Gm-Gg: ASbGncusMD47M+gFMAnySqFrmn/9Tvy0nqqH/KWPCaKALzk0bmIU9Fy/VIMfTLAnr/g
 MGpGi2JlXJswNKis5c1bh1w3dbA/lg5gT8bLGUbbF87wYeTKRV15nJgBpH+rPTrc/DpUKzDvv8+
 XOwp0cbaL7wWh4m4H69zYEGnRgNQvx4D0FhMA2PAIGP5YNRh5ryxPmaZOL2g4EWLUe8/soF29Vq
 GbON6SR6MUeiwNi0ItqRdk/WgqgZfAC4RoVS4Xl6Yr9ovuWi5P9pN5xpeLenvknTEi36hiph3To
 hCncskErECwqdKrcCSmg6hvUm5IrQNX8jE9SeWEWr8wMQGn1+2ea2pEoEEyhd1gZOg==
X-Google-Smtp-Source: AGHT+IFbHSU7fB/c/+fXUUClavsr8MBCmtynfjHZZa4HFZYqLDNK+3b8jpmfrSzBNzVh0cl1gFCKTQ==
X-Received: by 2002:a05:600c:3b8d:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-438dc3ab58bmr281087025e9.2.1738692498177; 
 Tue, 04 Feb 2025 10:08:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2ede0sm234741865e9.21.2025.02.04.10.08.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 10:08:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] hw/arm: Remove all invalid uses of
 auto_create_sdcard=true
Date: Tue,  4 Feb 2025 19:07:44 +0100
Message-ID: <20250204180746.58357-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204180746.58357-1-philmd@linaro.org>
References: <20250204180746.58357-1-philmd@linaro.org>
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

MachineClass::auto_create_sdcard is only useful to automatically
create a SD card, attach a IF_SD block drive to it and plug the
card onto a SD bus. None of the ARM machines modified by this
commit try to use the IF_SD interface.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c            | 21 ---------------------
 hw/arm/b-l475e-iot01a.c    |  1 -
 hw/arm/bananapi_m2u.c      |  1 -
 hw/arm/collie.c            |  1 -
 hw/arm/digic_boards.c      |  1 -
 hw/arm/exynos4_boards.c    |  2 --
 hw/arm/fby35.c             |  1 -
 hw/arm/highbank.c          |  2 --
 hw/arm/imx25_pdk.c         |  1 -
 hw/arm/kzm.c               |  1 -
 hw/arm/mcimx6ul-evk.c      |  1 -
 hw/arm/mcimx7d-sabre.c     |  3 ++-
 hw/arm/microbit.c          |  1 -
 hw/arm/mps2-tz.c           |  4 ----
 hw/arm/mps2.c              |  4 ----
 hw/arm/mps3r.c             |  1 -
 hw/arm/msf2-som.c          |  1 -
 hw/arm/musca.c             |  2 --
 hw/arm/musicpal.c          |  1 -
 hw/arm/netduino2.c         |  1 -
 hw/arm/netduinoplus2.c     |  1 -
 hw/arm/olimex-stm32-h405.c |  1 -
 hw/arm/raspi.c             |  5 -----
 hw/arm/raspi4b.c           |  1 -
 hw/arm/sabrelite.c         |  1 -
 hw/arm/sbsa-ref.c          |  1 -
 hw/arm/stellaris.c         |  1 -
 hw/arm/stm32vldiscovery.c  |  1 -
 hw/arm/versatilepb.c       |  2 --
 hw/arm/virt.c              |  1 -
 hw/arm/xen-pvh.c           |  1 -
 hw/arm/xilinx_zynq.c       |  1 -
 hw/arm/xlnx-versal-virt.c  |  1 -
 hw/arm/xlnx-zcu102.c       |  1 -
 34 files changed, 2 insertions(+), 68 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f3ba90896c0..d9418e2b9f2 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1253,7 +1253,6 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1270,7 +1269,6 @@ static void aspeed_machine_quanta_q71l_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 1;
     amc->i2c_init  = quanta_q71l_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 128 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1289,7 +1287,6 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 256 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1308,7 +1305,6 @@ static void aspeed_machine_supermicro_x11spi_bmc_class_init(ObjectClass *oc,
     amc->num_cs    = 1;
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1325,7 +1321,6 @@ static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635f";
     amc->num_cs    = 1;
     amc->i2c_init  = ast2500_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1343,7 +1338,6 @@ static void aspeed_machine_yosemitev2_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = yosemitev2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1360,7 +1354,6 @@ static void aspeed_machine_romulus_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = romulus_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1378,7 +1371,6 @@ static void aspeed_machine_tiogapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx25l25635e";
     amc->num_cs    = 2;
     amc->i2c_init  = tiogapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1395,7 +1387,6 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = sonorapass_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size       = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1412,7 +1403,6 @@ static void aspeed_machine_witherspoon_class_init(ObjectClass *oc, void *data)
     amc->spi_model = "mx66l1g45g";
     amc->num_cs    = 2;
     amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1433,7 +1423,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc, void *data)
                      ASPEED_MAC3_ON;
     amc->sdhci_wp_inverted = true;
     amc->i2c_init  = ast2600_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1452,7 +1441,6 @@ static void aspeed_machine_g220a_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = g220a_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1024 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1470,7 +1458,6 @@ static void aspeed_machine_fp5280g2_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
     amc->i2c_init  = fp5280g2_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 512 * MiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1489,7 +1476,6 @@ static void aspeed_machine_rainier_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask  = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = rainier_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
     aspeed_machine_ast2600_class_emmc_init(oc);
@@ -1512,7 +1498,6 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init = fuji_bmc_i2c_init;
     amc->uart_default = ASPEED_DEV_UART1;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1533,7 +1518,6 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON;
     amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1575,7 +1559,6 @@ static void aspeed_machine_fby35_class_init(ObjectClass *oc, void *data)
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC3_ON;
     amc->i2c_init  = fby35_i2c_init;
-    mc->auto_create_sdcard = true;
     /* FIXME: Replace this macro with something more general */
     mc->default_ram_size = FUJI_BMC_RAM_SIZE;
     aspeed_machine_class_init_cpus_defaults(mc);
@@ -1658,7 +1641,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     amc->spi_model = "w25q256";
     amc->num_cs = 2;
     amc->macs_mask = 0;
-    mc->auto_create_sdcard = true;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
@@ -1687,7 +1669,6 @@ static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
     amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
     amc->uart_default = ASPEED_DEV_UART12;
     amc->i2c_init  = ast2700_evb_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
@@ -1708,7 +1689,6 @@ static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_bmc_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
@@ -1728,7 +1708,6 @@ static void aspeed_machine_qcom_firework_class_init(ObjectClass *oc,
     amc->num_cs    = 2;
     amc->macs_mask = ASPEED_MAC2_ON | ASPEED_MAC3_ON;
     amc->i2c_init  = qcom_dc_scm_firework_i2c_init;
-    mc->auto_create_sdcard = true;
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 };
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index f05ee0fee0f..c9a5209216c 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -120,7 +120,6 @@ static void bl475e_machine_init(ObjectClass *oc, void *data)
     mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
     mc->init = bl475e_init;
     mc->valid_cpu_types = machine_valid_cpu_types;
-    mc->auto_create_sdcard = true;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 4d84d10d24c..0a4b6f29b1c 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -141,7 +141,6 @@ static void bpim2u_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "bpim2u.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 864c66193b1..eaa5c52d45a 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -79,7 +79,6 @@ static void collie_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("sa1110");
     mc->default_ram_size = RAM_SIZE;
     mc->default_ram_id = "strongarm.sdram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo collie_machine_typeinfo = {
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index f334c1fb02c..2492fafeb85 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -143,7 +143,6 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_size = 64 * MiB;
     mc->default_ram_id = "ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 43dc89d902e..2410e2a28e8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -165,7 +165,6 @@ static void nuri_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo nuri_type = {
@@ -185,7 +184,6 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
     mc->min_cpus = EXYNOS4210_NCPUS;
     mc->default_cpus = EXYNOS4210_NCPUS;
     mc->ignore_memory_transaction_failures = true;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo smdkc210_type = {
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 6d3663f14a1..83d08e578b7 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -170,7 +170,6 @@ static void fby35_class_init(ObjectClass *oc, void *data)
     mc->init = fby35_init;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->auto_create_sdcard = true;
     mc->min_cpus = mc->max_cpus = mc->default_cpus = 3;
 
     object_class_property_add_bool(oc, "execute-in-place",
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 975fd7a094a..495704d9726 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -357,7 +357,6 @@ static void highbank_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo highbank_type = {
@@ -382,7 +381,6 @@ static void midway_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "highbank.dram";
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo midway_type = {
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index e95ea5e4e18..c9c2e5dd3b1 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -147,7 +147,6 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->init = imx25_pdk_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "imx25.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init)
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 736eabab664..08d2b3025cf 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,7 +137,6 @@ static void kzm_machine_init(MachineClass *mc)
     mc->init = kzm_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "kzm.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("kzm", kzm_machine_init)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 86982cb0772..690cb64ef36 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -74,6 +74,5 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->init = mcimx6ul_evk_init;
     mc->max_cpus = FSL_IMX6UL_NUM_CPUS;
     mc->default_ram_id = "mcimx6ul-evk.ram";
-    mc->auto_create_sdcard = true;
 }
 DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 33119610113..ac1f57f0671 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -74,6 +74,7 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
     mc->init = mcimx7d_sabre_init;
     mc->max_cpus = FSL_IMX7_NUM_CPUS;
     mc->default_ram_id = "mcimx7d-sabre.ram";
-    mc->auto_create_sdcard = true;
+
 }
+
 DEFINE_MACHINE("mcimx7d-sabre", mcimx7d_sabre_machine_init)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index fb099508324..3f56fb45ce1 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -67,7 +67,6 @@ static void microbit_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "BBC micro:bit (Cortex-M0)";
     mc->init = microbit_init;
     mc->max_cpus = 1;
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo microbit_info = {
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index e099506e58a..d3a9f1b03ac 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1320,7 +1320,6 @@ static void mps2tz_an505_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN505;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045050;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1355,7 +1354,6 @@ static void mps2tz_an521_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN521;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045210;
     mmc->sysclk_frq = 20 * 1000 * 1000; /* 20MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1390,7 +1388,6 @@ static void mps3tz_an524_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN524;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045240;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = mmc->sysclk_frq;
@@ -1430,7 +1427,6 @@ static void mps3tz_an547_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN547;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m55");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41055470;
     mmc->sysclk_frq = 32 * 1000 * 1000; /* 32MHz */
     mmc->apb_periph_frq = 25 * 1000 * 1000; /* 25MHz */
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index aaf34051daa..56b2af40f1d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -487,7 +487,6 @@ static void mps2_an385_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN385;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41043850;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -507,7 +506,6 @@ static void mps2_an386_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN386;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41043860;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
@@ -527,7 +525,6 @@ static void mps2_an500_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN500;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m7");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045000;
     mmc->psram_base = 0x60000000;
     mmc->ethernet_base = 0xa0000000;
@@ -547,7 +544,6 @@ static void mps2_an511_class_init(ObjectClass *oc, void *data)
     mmc->fpga_type = FPGA_AN511;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->scc_id = 0x41045110;
     mmc->psram_base = 0x21000000;
     mmc->ethernet_base = 0x40200000;
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 03c3f88cb18..2b104671db8 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -618,7 +618,6 @@ static void mps3r_an536_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 2;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-r52");
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
     mmc->raminfo = an536_raminfo;
     mps3r_set_default_ram_info(mmc);
 }
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 6d3f0a89e0b..9b20f1e2c98 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -106,7 +106,6 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->desc = "SmartFusion2 SOM kit from Emcraft (M2S010)";
     mc->init = emcraft_sf2_s2s010_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 6f19b7d58a0..e9c092abc3d 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -615,7 +615,6 @@ static void musca_a_class_init(ObjectClass *oc, void *data)
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Musca-A board (dual Cortex-M33)";
-    mc->auto_create_sdcard = true;
     mmc->type = MUSCA_A;
     mmc->init_svtor = 0x10200000;
     mmc->sram_addr_width = 15;
@@ -630,7 +629,6 @@ static void musca_b1_class_init(ObjectClass *oc, void *data)
     MuscaMachineClass *mmc = MUSCA_MACHINE_CLASS(oc);
 
     mc->desc = "ARM Musca-B1 board (dual Cortex-M33)";
-    mc->auto_create_sdcard = true;
     mmc->type = MUSCA_B1;
     /*
      * This matches the DAPlink firmware which boots from QSPI. There
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index fd2975753ee..48a32c24079 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1342,7 +1342,6 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
     mc->default_ram_id = "musicpal.ram";
-    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index fca32d45924..df793c77fe1 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -63,7 +63,6 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->init = netduino2_init;
     mc->valid_cpu_types = valid_cpu_types;
     mc->ignore_memory_transaction_failures = true;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("netduino2", netduino2_machine_init)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index e1a59fb9e23..81b6334cf72 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -63,7 +63,6 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->desc = "Netduino Plus 2 Machine (Cortex-M4)";
     mc->init = netduinoplus2_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init)
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 23f686de876..1f15620f9fd 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -66,7 +66,6 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->desc = "Olimex STM32-H405 (Cortex-M4)";
     mc->init = olimex_stm32_h405_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
 
     /* SRAM pre-allocated as part of the SoC instantiation */
     mc->default_ram_size = 0;
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index dce35ca11aa..a7a662f40db 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -342,7 +342,6 @@ static void raspi0_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->auto_create_sdcard = true;
     rmc->board_rev = 0x920092; /* Revision 1.2 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -352,7 +351,6 @@ static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->auto_create_sdcard = true;
     rmc->board_rev = 0x900021; /* Revision 1.1 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -362,7 +360,6 @@ static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa21041;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -373,7 +370,6 @@ static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->auto_create_sdcard = true;
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
     raspi_machine_class_init(mc, rmc->board_rev);
 };
@@ -383,7 +379,6 @@ static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
-    mc->auto_create_sdcard = true;
     rmc->board_rev = 0xa02082;
     raspi_machine_class_init(mc, rmc->board_rev);
 };
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index f6de103a3e1..1264e0d6eed 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -118,7 +118,6 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
     rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
 #endif
     raspi_machine_class_common_init(mc, rmc->board_rev);
-    mc->auto_create_sdcard = true;
     mc->init = raspi4b_machine_init;
 }
 
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index df60d47c6fd..1eb47042eca 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -110,7 +110,6 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "sabrelite.ram";
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("sabrelite", sabrelite_machine_init)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9ed2591f6cb..6183111f2de 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -900,7 +900,6 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
     mc->minimum_page_bits = 12;
     mc->block_default_type = IF_IDE;
     mc->no_cdrom = 1;
-    mc->auto_create_sdcard = true;
     mc->default_nic = "e1000e";
     mc->default_ram_size = 1 * GiB;
     mc->default_ram_id = "sbsa-ref.ram";
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index df520c91906..00412193a4a 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1421,7 +1421,6 @@ static void lm3s811evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s811evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
-    mc->auto_create_sdcard = true;
 }
 
 static const TypeInfo lm3s811evb_type = {
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index a71da292b84..e6c1f5b8d7d 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -66,7 +66,6 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->desc = "ST STM32VLDISCOVERY (Cortex-M3)";
     mc->init = stm32vldiscovery_init;
     mc->valid_cpu_types = valid_cpu_types;
-    mc->auto_create_sdcard = true;
 }
 
 DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 941616cd25b..bc4522989ec 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -419,7 +419,6 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
-    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
@@ -440,7 +439,6 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
-    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
 }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 88e4c995109..99e0a68b6c5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3125,7 +3125,6 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
 #endif
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
-    mc->auto_create_sdcard = true;
     mc->pci_allow_0_address = true;
     /* We know we will never create a pre-ARMv7 CPU which needs 1K pages */
     mc->minimum_page_bits = 12;
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index ce4cc4fce93..d1509bd235d 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -75,7 +75,6 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      * mc->max_cpus, QEMU will bail out with an error message.
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
-    mc->auto_create_sdcard = true;
 
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 2d626a96b9b..3c6a4604cc9 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -466,7 +466,6 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
-    mc->auto_create_sdcard = true;
     prop = object_class_property_add_str(oc, "boot-mode", NULL,
                                          zynq_set_boot_mode);
     object_class_property_set_description(oc, "boot-mode",
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 0c6f0359e3d..1401d37959e 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -818,7 +818,6 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
-    mc->auto_create_sdcard = true;
     mc->default_ram_id = "ddr";
     object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
                                    versal_set_ospi_model);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4fdb153e4d8..70fb444bbd9 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -280,7 +280,6 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_ram_id = "ddr-ram";
-    mc->auto_create_sdcard = true;
 
     machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", zcu102_get_secure,
-- 
2.47.1


