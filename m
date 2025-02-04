Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8D2C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPFV-0001JB-0H; Tue, 04 Feb 2025 15:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPFG-00016x-QX
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:10:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPFD-0006Tk-GK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:10:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so42998815e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738699801; x=1739304601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xD9rETQLxT9pbO37xy4X0PKhByDLyIaqf+mLBbd6JiE=;
 b=I1rpNPeu4rCxgeEEGllAhtifZ+DByEf2jTCf1gI322gdJv/Pg+M4+HoGpbztWxqIOM
 bPD1zzMMP3yva7UOXHNXlD2U6AgTXH7/k3+z5AEmG99P2kiPmCkszZi8nqlWMjUYyc/s
 YRMo+s2CTlasx2oMGv+DjZ2i9Y9MYzn5sBUe37WOIWSKY6ylDI3q4tc1CgVCXdeG4JON
 kxz/zto94VJa+Uh99cKHhAIMwfcYMgxxc3fCzRG6hsFh1ZF5iYMvNnvDTqhK1yURtAgx
 S0EDbhlrNTJ3aCk3lJLIzfH3QPzAon/VboJRictyHOG1aSq6pJ6tgFxR/75Je9uHi/zZ
 6vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738699801; x=1739304601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xD9rETQLxT9pbO37xy4X0PKhByDLyIaqf+mLBbd6JiE=;
 b=SQ5CcPbVopyhs8w/LLL1ihIvbQclzpqPVsXBU6o6/9ZlvBQuRRqOmVFgfYiRMwrOVp
 gSmTYP7rzaIISI3WlerAiC7lALhPeg8t6YENbXIodQHopa6o5D/J/Jsb/3DPIctFyzur
 xvHAs27GLkEwEXNr0VnN8SUDAWR5/18JG8JN/nuV1JowHuRwMf3vj+hkfee50HrXBkCA
 odVnBuxntzNP4NDifd3ssck9Py6xEb7o95MashGUIZTcz732yH1SYrLcSLjbPX7d4piL
 4vQrRjapYn4kFw7Er7yj6io2661vY2k6mRDAEy29VAwRU/3zvL+qifEvEauCIZ/cv8c0
 w2xw==
X-Gm-Message-State: AOJu0Yx2AKV13m6yXXyyiTdePJ1mmj7DPZ3xJJbtsSHxrwkjbQXVRWY6
 JVkFQtQUNoNmBe5VN0vlRnk+syTrGVpE8z83bYHuqhRK29VnuH6CaVtMvyHtEdnaqTxc5BKBVh2
 Wqyg=
X-Gm-Gg: ASbGncupS3w4s8F6+yNtzTRzbXcEN3TDbQu7Y+dCLtg3F6oVONtjmsGTFovwnVtY0DJ
 UbR6rt/2kpV2LDB5tZlmFm0VXrmMys9GNjK5Zs8HJV9QkR5+LgOVbbVNZ+rGeJWiO+M5/ywFjvB
 vpH8Qg60tKMJKUyXGIO7oaXUlvlmlvW4ROohifrT9EDJO6u3oTUtQa0jqNelgqzJH5G0uEIjH11
 TUtQES39zvRiE9zAedJ8npNnnQC7yy2J6Oa08n6SlmZX/yyGuEvLmEcYKs2YGhvCLbdmRauxOcZ
 NbCXDE+UBqPSWFrp5G+ZZAD5Ma1rOOfXpkhHI00Jj/LcxZUmOnsch/2DlXkHlkvscg==
X-Google-Smtp-Source: AGHT+IFWC81DYmbjsMxXvwrHlTvHboixmkpb0tFV0TF6ayYMunC2O3XCI+XXY7k33QCEGKKsW9fuuA==
X-Received: by 2002:a05:6000:4020:b0:38c:5c1d:2862 with SMTP id
 ffacd0b85a97d-38db485eeb6mr126680f8f.1.1738699801413; 
 Tue, 04 Feb 2025 12:10:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38db0e2f479sm1527734f8f.57.2025.02.04.12.10.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 12:10:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 5/7] hw/arm: Remove all invalid uses of
 auto_create_sdcard=true
Date: Tue,  4 Feb 2025 21:09:32 +0100
Message-ID: <20250204200934.65279-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204200934.65279-1-philmd@linaro.org>
References: <20250204200934.65279-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
 hw/arm/aspeed.c            | 1 -
 hw/arm/b-l475e-iot01a.c    | 1 -
 hw/arm/collie.c            | 1 -
 hw/arm/digic_boards.c      | 1 -
 hw/arm/highbank.c          | 2 --
 hw/arm/kzm.c               | 1 -
 hw/arm/microbit.c          | 1 -
 hw/arm/mps2-tz.c           | 4 ----
 hw/arm/mps2.c              | 4 ----
 hw/arm/mps3r.c             | 1 -
 hw/arm/msf2-som.c          | 1 -
 hw/arm/musca.c             | 2 --
 hw/arm/musicpal.c          | 1 -
 hw/arm/netduino2.c         | 1 -
 hw/arm/netduinoplus2.c     | 1 -
 hw/arm/olimex-stm32-h405.c | 1 -
 hw/arm/sbsa-ref.c          | 1 -
 hw/arm/stellaris.c         | 1 -
 hw/arm/stm32vldiscovery.c  | 1 -
 hw/arm/virt.c              | 1 -
 hw/arm/xen-pvh.c           | 1 -
 21 files changed, 29 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f3ba90896c0..98bf071139b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1658,7 +1658,6 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
     amc->spi_model = "w25q256";
     amc->num_cs = 2;
     amc->macs_mask = 0;
-    mc->auto_create_sdcard = true;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
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
-- 
2.47.1


