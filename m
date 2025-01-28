Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C397C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcrxd-00024C-Ai; Tue, 28 Jan 2025 15:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxb-00023R-V4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxa-0001YD-3r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43625c4a50dso40791685e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095200; x=1738700000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kapiqooBGcDCWganGS7eNGn6yyFsqNu779iGNi7DN3A=;
 b=QrnYzf3Ut1PHEFxJvCEHTw/lTEej0bz4KsEdPckKrhpR6prXLgBeu7SlQhNvc7gzix
 MgZFCAGPf7uLaUiXKPzr+X0RsyJvANhP//sYlkkBKto6tXaazHyuqvOCMlHScr3AyTZ0
 WV98dN4TbGKjT0FoGwcBE9JyNYEOlSyPqV8yVvSCmsmlT7i9stV+IRbLs7K+I6xpO4Lf
 iqnkNswMuCmSDgUDvTFwHFUIGmxluKDm81cobgIDjpNBw53/rTctWj2KCKYMEwmQzSGr
 G0+Tq0piQyoLTnDVtmhT2LdExP6exkw1q+IaPzOwLEuBmFK8vaZaetRqnUeT02u7KOMl
 RBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095200; x=1738700000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kapiqooBGcDCWganGS7eNGn6yyFsqNu779iGNi7DN3A=;
 b=Ck5h6xzfJi36uqT6ozf1fAKvrFHiQiVYOdmSxSJVdEJZRwI+Hjm5EsoGhadpK5NcxC
 dMQeZDPDXRS42igfKo3S0YAyGjWvMnfIONzcvnQp/cuoDcYsD3U7sGOtad8V+xDptB4c
 yPUzdcQ2DQgLx9bYQwqfcHajhI6vZoBKp6wVLG8IYj96e81pFIJod6ziLM4vr0Bcbq0z
 ltEUt+oYu1JR68SOwf6wZsIoo2HbUUKxRveg/nUBtJ5wJuy++NHxqjbouQ2V2n8LjSG8
 WM02sJPGAPOYKTfDvtkww8Q7bxCyn7jd0Sk+0TvubYlVpTxbuzRU2GUE4hzD3Iyu9xwN
 dmhQ==
X-Gm-Message-State: AOJu0YxVSpl8DOul/BhOY6AgtmeXmu0MMM0Xxv11mgH1Adu7I2iK5zhD
 9CMHaRmGuTR0mCdL+qaRlz0k8ZoacW8OxtGl99sA8wwYd9P8X3KSAqDoDQ3PPiXzoj1HTLRfXp2
 h
X-Gm-Gg: ASbGncumskAdeLvQntye4UNvCHYQOzy9lklDT/fD0WjF3dbRN5P+qurafbWFBaktS/Y
 ummkUUH4Z+KUnNgGhjl/QMZ4Lq8QgONyDo/mGX8cRDRHZUX0KfHh6FXytN0VhxiZkIDnDl9QJVn
 Ft2Sv7GE0f7MOvHjJ9cUEsYhC6kO/CPqpVx0QVUSC9fcHAKc6Mr7uYP6CKP8h+XAfmYHwA66MOL
 ffkU8a44aSAKlMgIPoo+5w8GiTrWW387Z/JTj0ZjCsjV/UMngnOqqVhp5HzLVXCYo4yUadtdBkB
 5JTRI1ZAI6RBYr1WIWHa5Q==
X-Google-Smtp-Source: AGHT+IGwiX5xpJKTGE9qkDUr7NhojDIXODNYBwkx3wYf11cUyaSzzZuRiSH61gn3vYg+g+Ock6vvbg==
X-Received: by 2002:a05:600c:510e:b0:434:f1e9:afb3 with SMTP id
 5b1f17b1804b1-438dc3abb76mr2637425e9.3.1738095200236; 
 Tue, 28 Jan 2025 12:13:20 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/36] hw/arm/v7m: Remove use of &first_cpu in machine_init()
Date: Tue, 28 Jan 2025 20:12:41 +0000
Message-Id: <20250128201314.44038-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When instanciating the machine model, the machine_init()
implementations usually create the CPUs, so have access
to its first CPU. Use that rather then the &first_cpu
global.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Samuel Tardieu <sam@rfc1149.net>
Message-id: 20250112225614.33723-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/b-l475e-iot01a.c    | 2 +-
 hw/arm/microbit.c          | 2 +-
 hw/arm/mps2-tz.c           | 2 +-
 hw/arm/mps2.c              | 2 +-
 hw/arm/msf2-som.c          | 2 +-
 hw/arm/musca.c             | 2 +-
 hw/arm/netduino2.c         | 2 +-
 hw/arm/netduinoplus2.c     | 2 +-
 hw/arm/olimex-stm32-h405.c | 2 +-
 hw/arm/stellaris.c         | 2 +-
 hw/arm/stm32vldiscovery.c  | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 5002a40f06d..c9a5209216c 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -82,7 +82,7 @@ static void bl475e_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     sc = STM32L4X5_SOC_GET_CLASS(&s->soc);
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename, 0,
+    armv7m_load_kernel(s->soc.armv7m.cpu, machine->kernel_filename, 0,
                        sc->flash_size);
 
     if (object_class_by_name(TYPE_DM163)) {
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 374fbcb3618..3f56fb45ce1 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -56,7 +56,7 @@ static void microbit_init(MachineState *machine)
     memory_region_add_subregion_overlap(&s->nrf51.container, NRF51_TWI_BASE,
                                         mr, -1);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(s->nrf51.armv7m.cpu, machine->kernel_filename,
                        0, s->nrf51.flash_size);
 }
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 0136e419bfd..d3a9f1b03ac 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1211,7 +1211,7 @@ static void mps2tz_common_init(MachineState *machine)
                                     mms->remap_irq);
     }
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(mms->iotkit.armv7m[0].cpu, machine->kernel_filename,
                        0, boot_ram_size(mms));
 }
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index efb3500742f..56b2af40f1d 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -460,7 +460,7 @@ static void mps2_common_init(MachineState *machine)
                  qdev_get_gpio_in(armv7m,
                                   mmc->fpga_type == FPGA_AN511 ? 47 : 13));
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(mms->armv7m.cpu, machine->kernel_filename,
                        0, 0x400000);
 }
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 5c415abe852..9b20f1e2c98 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -92,7 +92,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
     sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(soc->armv7m.cpu, machine->kernel_filename,
                        0, soc->envm_size);
 }
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 3c3b534cb72..e9c092abc3d 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -590,7 +590,7 @@ static void musca_init(MachineState *machine)
                                                      "cfg_sec_resp", 0));
     }
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(mms->sse.armv7m[0].cpu, machine->kernel_filename,
                        0, 0x2000000);
 }
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 8b1a9a24379..df793c77fe1 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -48,7 +48,7 @@ static void netduino2_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+    armv7m_load_kernel(STM32F205_SOC(dev)->armv7m.cpu, machine->kernel_filename,
                        0, FLASH_SIZE);
 }
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index bccd1003549..81b6334cf72 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -48,7 +48,7 @@ static void netduinoplus2_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu),
+    armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
                        0, FLASH_SIZE);
 }
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 4ad7b043be0..1f15620f9fd 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -51,7 +51,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu),
+    armv7m_load_kernel(STM32F405_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
                        0, FLASH_SIZE);
 }
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 7303e096ef7..284980ad4b5 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1366,7 +1366,7 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     create_unimplemented_device("hibernation", 0x400fc000, 0x1000);
     create_unimplemented_device("flash-control", 0x400fd000, 0x1000);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, 0, flash_size);
+    armv7m_load_kernel(ARMV7M(armv7m)->cpu, ms->kernel_filename, 0, flash_size);
 }
 
 /* FIXME: Figure out how to generate these from stellaris_boards.  */
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index cc419351605..e6c1f5b8d7d 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -51,7 +51,7 @@ static void stm32vldiscovery_init(MachineState *machine)
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-    armv7m_load_kernel(ARM_CPU(first_cpu),
+    armv7m_load_kernel(STM32F100_SOC(dev)->armv7m.cpu,
                        machine->kernel_filename,
                        0, FLASH_SIZE);
 }
-- 
2.34.1


