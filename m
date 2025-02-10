Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9246CC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thade-0002tK-3C; Mon, 10 Feb 2025 15:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thada-0002cJ-SC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:14 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadY-0003oS-7z
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:14 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so2934879f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220250; x=1739825050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jh6WFwwnn1kd3QsBOUy6kQT+tKEZb8bYG1Z8Msovi/k=;
 b=V36fpQnTXNGcGXp7+lp5FqNo6sulthb21Da4xfcgIyQq06yFBAnNR28RZvW2eY0Uuy
 As6mPEVccHwPvdxgVYeTGCtMfABCv7iSwEwN00CiNP0lGJWUNlalDhj6/hutmb/SDY3n
 rTxIFuHhirWX5fYcr+tce+oTvwfkfGTWyKhqP4s9XOzt5uRFBk22ihuvFbj6SIz/IbF3
 T7ctKYkKHJfi2gwuf/IuOs/TT9XwpgYs9K1bC1h9Zr3Pze9mE0trt/jl4Psr3zYEntA5
 AAY9vdGdLUHqpyT3OTwTij+KctGtoQa5oagIDPAVK28FLN7kRaDoDoK9Xr1WVtM9jkI3
 Wq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220250; x=1739825050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jh6WFwwnn1kd3QsBOUy6kQT+tKEZb8bYG1Z8Msovi/k=;
 b=nSjDcCqOzXOQvvPX7e8rrO00+exCT15feVmgcX7FTwzEpGYNpMJeSJSGthjPFxl90z
 Ktj0jqqzulTKHAIue2Ab46ZMob3rDnMxDERJw+vn1Rk5cjLZTLtHAuhQauahkvUkTLqo
 w9hdysVM/Vog9r4iIwohXwMFqnbUuzDSUSOXqPeFbNiSIRmBJEXHbGOXT7K6L70LrCLh
 fm5KsWgWfJl71HVji9nSmP+H/Ip66UZyIvcVaDC6ZkdxUC0Hc/uIYDuJeKpyZ0q9MDM4
 t18hoYZj6sQyg9XBniYTelB2j9miQpeXaEUG7sbrPiacEIt/zeCCxrvz7N0Tq+1Ngh8J
 fD7A==
X-Gm-Message-State: AOJu0YzrfyYcUgi/KuP2i/qRHCHBx0rEs08XgaSUHt038c7f1BV4lZae
 cyburm7hw6odxpm7WIx0Tr+ZkZSNvCvHjVbPbCJaEB/x80C7haqm3bkyblBjP9CGHQ6YuiZlzgQ
 wklk=
X-Gm-Gg: ASbGncsyotJPI9wuKhd4K0sN6HU7Y1FdOAGIY7rHJv1l7g3Bt+WAQm/VDUCY3Z/0uxn
 kiLNVfMpjvKH4QbG5/S4zuvfctWL99XWqkswx/VEdt0MMGIjGchV9rIoivBcFZO3ifPwVM5xoMq
 qu8mjVCjMqNRDPrB7zeu3cX9AU3W5M473R9a4hNVh5fCofBisB7E+ZP2o8fq3C6jPLqxb/MeCLZ
 8JzdOjBsDP91vnX41Enn6020pzUjFqXu1tP9vPDbb0a/ew6hS513z22fRYYkr6jMqucJK6ia3Lz
 BNxSV1az/bmoRajnXd3zC3igKEWNDZnJg+Zq4gmKZOaOU15M0/rtKRCNwr4MR/hxag==
X-Google-Smtp-Source: AGHT+IFy0Mw13XBLuB/xmQv7kCZZN8hNqL7AAHMmmfR7YJki+vtSRJaaiik4Nlc75A3L9zgaA6/riw==
X-Received: by 2002:a5d:6d8b:0:b0:38d:e016:a66a with SMTP id
 ffacd0b85a97d-38de016a92cmr3466644f8f.50.1739220249895; 
 Mon, 10 Feb 2025 12:44:09 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8448sm157034185e9.38.2025.02.10.12.44.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 24/32] hw/arm: Remove all invalid uses of
 auto_create_sdcard=true
Date: Mon, 10 Feb 2025 21:41:56 +0100
Message-ID: <20250210204204.54407-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250204200934.65279-6-philmd@linaro.org>
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
index 91b8ae6d384..13ed868b6b9 100644
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
index 40eb5d16187..3f8db0cab60 100644
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
index f26d1cfb2c4..1bddb5e822f 100644
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
index 02c72a62a37..e720de30641 100644
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
index 25283fd6233..33611113602 100644
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
index 192c2a5ac78..3448200e3bf 100644
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


