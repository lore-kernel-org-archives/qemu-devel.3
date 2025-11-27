Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D4BCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObtC-000695-Gp; Thu, 27 Nov 2025 08:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqj-0002ee-KT
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqg-0001GT-2m
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4s//t0LDdu7wkY5l5bRY2BtbTraYItxOYoXtY2qupM=;
 b=ND16NkAs7dRI2ydu1psfS2k+al+N9JFQfJjXoiUMbE3AlIAL49o5suqaQra5/IjV+mEE0S
 nsHEi6UQ2xphWREHc8vnLPYNnEnx4bUuaHcqOTkA5uKk/RlbON7iTrcYF4lSSBxysUWsdR
 +i64YaYiD1QG/gdEA9WuyFRXr89BH7c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-sHAM2baUOB-bs8A4btj6xg-1; Thu, 27 Nov 2025 08:15:47 -0500
X-MC-Unique: sHAM2baUOB-bs8A4btj6xg-1
X-Mimecast-MFC-AGG-ID: sHAM2baUOB-bs8A4btj6xg_1764249347
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6417677bf55so2847344a12.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249346; x=1764854146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W4s//t0LDdu7wkY5l5bRY2BtbTraYItxOYoXtY2qupM=;
 b=a9JdQWJCVq1Y1v6mNxO8Ymic6jUIdypkqdD0iVaZcKYvGvWNj7beZ8xnatJeTpwFIg
 GODarYYRl78Bkdcf80I8ZNb1LMwrLCqjrsUnIRwfLSyUR5yPpsKr62DrdaVSc0BUZnsd
 mcCSUIM/ikJ3ZZ47RMP6OQHSJc8KjrrTBJ4efOr/sfxDkccm84Vv1zfBHXVqfE5elPd/
 lSRaEQjI8XCinVTcEcytwpvH24iIbdbiVft9eenvS5uZTlF6YlvNSMigNZf1WV8oPdYQ
 iWsX/MFzdj3c/FCItufRUXunm4Hn7bYe30Pcme2md3wCtzePG6ArNh8qfm8HuHAk9j+V
 3YIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249346; x=1764854146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W4s//t0LDdu7wkY5l5bRY2BtbTraYItxOYoXtY2qupM=;
 b=BJs/ILZADDUBClneFlAfrlDOanYo5Se818L4OiC37qiFaXN0IKB36AfuimzJw8rlNl
 dpbu/oPNyrP5ohxbR21QD8DmpL3yGt49TysylldO/a2GnbPPA6ajaCErmkv4VZUYfsnf
 3m1vrrrnY7aHlIcAw2FaYQOO9ZKkr3TiA83hFOdweD2rh4TIOeigbuH5NrXefslCP3f4
 +WMwTevoohNSCR8Qw6gcrLB/p955CWTfGBN03c3ckLgMFd0tyoB03cyXWhec+cgU7wy8
 KRdAgfx5MUvGWO/sx06gpBVV43hdprVUidVuWIWafvAjqQ0ImX142ArMf1bE1cUmvGOJ
 WAFw==
X-Gm-Message-State: AOJu0YxeziQA+DNQFmexLotoGFH4AtBBd4mqYo5J3Xy0qCgMHNUq4paT
 ao7n4DiGh3xb9GoEN6h3kekv+Wt+W8h3lsCukp5eOwPOAEr7hzVyTHkagzZYMawMlzded+CPcM/
 YAf4ncxnG2M6SQBuXEPafBFIEQpFWdKfDoBLJpWMg+1zK2jAYjeGfu7vcp8zPNnvdAfUvgVWEIW
 9ekON1L1HnQv3+OpFggqjPeKYoB74YiQxJ/PfcewnF
X-Gm-Gg: ASbGncthY5gUgihJ6jF1AbrENsJ/1LfRhSEaLBgdmu64QUsHLyXGeQGgbRwvUn7xqkN
 DS8eUL9GiPenp5YQHs0Tn82b0KIidEGwG0+9Gg8FOAfCGkUETE3N+LSlv7Qo78t83Wz1+j/gkkG
 /HAWhVxurUvfGdg2jsrKOEDk8Kbp4RcmbdtgbveOwF1lLNUAmqdbS4xajzPe0KFU6PX/dgENCXH
 P/SSsEDtJRlqN2UaobrIETq6X/oOKzFt2QdEWqSLA0cM1d/y/q2u21HsdUaZLh2SflUPjRYi9mn
 3ACA/ICJ4st6hPVJXLFpRhqt4YmP6z6rXk5dgTc0JwY6P/8mwlTTR1/+v2TYKWfYSTPiu9HkV1h
 bQRU2fb0DpPfHpm+N/K/8VYREC5+HZmQUXe3lecJSnrm3GDeKsYtJHS+A6yoaakeRcapVoi5s+r
 dq0YUGuiTBdpAQH7c=
X-Received: by 2002:a05:6402:1641:b0:641:5a05:c72f with SMTP id
 4fb4d7f45d1cf-645396af1f3mr19311246a12.16.1764249345782; 
 Thu, 27 Nov 2025 05:15:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGgJk7NT2J01Gx/CPcYlmX4D1gh3MsjyuaknaKi5/uStYNxqATHBiZLUaqQ8ssbP37YEqF7g==
X-Received: by 2002:a05:6402:1641:b0:641:5a05:c72f with SMTP id
 4fb4d7f45d1cf-645396af1f3mr19311180a12.16.1764249344835; 
 Thu, 27 Nov 2025 05:15:44 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64750a90d45sm1559510a12.8.2025.11.27.05.15.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/28] include: move hw/qdev-clock.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:03 +0100
Message-ID: <20251127131516.80807-17-pbonzini@redhat.com>
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
 MAINTAINERS                        | 2 +-
 docs/devel/clocks.rst              | 4 ++--
 include/hw/{ => core}/qdev-clock.h | 0
 include/hw/misc/bcm2835_cprman.h   | 2 +-
 include/hw/net/xlnx-versal-canfd.h | 2 +-
 include/hw/net/xlnx-zynqmp-can.h   | 2 +-
 rust/hw/core/wrapper.h             | 2 +-
 hw/adc/npcm7xx_adc.c               | 2 +-
 hw/arm/armsse.c                    | 2 +-
 hw/arm/armv7m.c                    | 2 +-
 hw/arm/aspeed.c                    | 2 +-
 hw/arm/aspeed_ast10x0.c            | 2 +-
 hw/arm/aspeed_ast10x0_evb.c        | 2 +-
 hw/arm/aspeed_ast27x0-fc.c         | 2 +-
 hw/arm/aspeed_ast27x0-ssp.c        | 2 +-
 hw/arm/aspeed_ast27x0-tsp.c        | 2 +-
 hw/arm/fby35.c                     | 2 +-
 hw/arm/max78000_soc.c              | 2 +-
 hw/arm/max78000fthr.c              | 2 +-
 hw/arm/mps2-tz.c                   | 2 +-
 hw/arm/mps2.c                      | 2 +-
 hw/arm/mps3r.c                     | 2 +-
 hw/arm/msf2-soc.c                  | 2 +-
 hw/arm/msf2-som.c                  | 2 +-
 hw/arm/musca.c                     | 2 +-
 hw/arm/netduino2.c                 | 2 +-
 hw/arm/netduinoplus2.c             | 2 +-
 hw/arm/npcm7xx.c                   | 2 +-
 hw/arm/npcm8xx.c                   | 2 +-
 hw/arm/nrf51_soc.c                 | 2 +-
 hw/arm/olimex-stm32-h405.c         | 2 +-
 hw/arm/stellaris.c                 | 2 +-
 hw/arm/stm32f100_soc.c             | 2 +-
 hw/arm/stm32f205_soc.c             | 2 +-
 hw/arm/stm32f405_soc.c             | 2 +-
 hw/arm/stm32l4x5_soc.c             | 2 +-
 hw/arm/stm32vldiscovery.c          | 2 +-
 hw/arm/xilinx_zynq.c               | 2 +-
 hw/char/cadence_uart.c             | 2 +-
 hw/char/ibex_uart.c                | 2 +-
 hw/char/pl011.c                    | 2 +-
 hw/char/stm32l4x5_usart.c          | 2 +-
 hw/core/qdev-clock.c               | 2 +-
 hw/core/qdev.c                     | 2 +-
 hw/gpio/stm32l4x5_gpio.c           | 2 +-
 hw/mips/boston.c                   | 2 +-
 hw/mips/cps.c                      | 2 +-
 hw/mips/malta.c                    | 2 +-
 hw/misc/npcm7xx_mft.c              | 2 +-
 hw/misc/npcm7xx_pwm.c              | 2 +-
 hw/misc/npcm_clk.c                 | 2 +-
 hw/misc/stm32l4x5_rcc.c            | 2 +-
 hw/misc/stm32l4x5_syscfg.c         | 2 +-
 hw/misc/zynq_slcr.c                | 2 +-
 hw/net/npcm7xx_emc.c               | 2 +-
 hw/timer/armv7m_systick.c          | 2 +-
 hw/timer/cmsdk-apb-dualtimer.c     | 2 +-
 hw/timer/cmsdk-apb-timer.c         | 2 +-
 hw/timer/npcm7xx_timer.c           | 2 +-
 hw/timer/sse-counter.c             | 2 +-
 hw/timer/sse-timer.c               | 2 +-
 hw/timer/stellaris-gptm.c          | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c   | 2 +-
 target/mips/cpu.c                  | 2 +-
 target/xtensa/cpu.c                | 2 +-
 65 files changed, 65 insertions(+), 65 deletions(-)
 rename include/hw/{ => core}/qdev-clock.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index c464e7b5ea8..f6e9ad535fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3952,7 +3952,7 @@ M: Luc Michel <luc@lmichel.fr>
 R: Damien Hedde <damien.hedde@dahe.fr>
 S: Maintained
 F: include/hw/core/clock.h
-F: include/hw/qdev-clock.h
+F: include/hw/core/qdev-clock.h
 F: hw/core/clock.c
 F: hw/core/clock-vmstate.c
 F: hw/core/qdev-clock.c
diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 2dbdc668606..16de32147b9 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -47,7 +47,7 @@ Here is an example of clocks::
                                                 +--------------+
 
 Clocks are defined in the ``include/hw/core/clock.h`` header and device
-related functions are defined in the ``include/hw/qdev-clock.h``
+related functions are defined in the ``include/hw/core/qdev-clock.h``
 header.
 
 The clock state
@@ -97,7 +97,7 @@ Note that it is possible to create a static array describing clock inputs and
 outputs. The function ``qdev_init_clocks()`` must be called with the array as
 parameter to initialize the clocks: it has the same behaviour as calling the
 ``qdev_init_clock_in/out()`` for each clock in the array. To ease the array
-construction, some macros are defined in ``include/hw/qdev-clock.h``.
+construction, some macros are defined in ``include/hw/core/qdev-clock.h``.
 As an example, the following creates 2 clocks to a device: one input and one
 output.
 
diff --git a/include/hw/qdev-clock.h b/include/hw/core/qdev-clock.h
similarity index 100%
rename from include/hw/qdev-clock.h
rename to include/hw/core/qdev-clock.h
diff --git a/include/hw/misc/bcm2835_cprman.h b/include/hw/misc/bcm2835_cprman.h
index 0d380367280..7b2c0a54642 100644
--- a/include/hw/misc/bcm2835_cprman.h
+++ b/include/hw/misc/bcm2835_cprman.h
@@ -10,7 +10,7 @@
 #define HW_MISC_BCM2835_CPRMAN_H
 
 #include "hw/sysbus.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 
 #define TYPE_BCM2835_CPRMAN "bcm2835-cprman"
 
diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
index d2e582918fb..45cf0001c6b 100644
--- a/include/hw/net/xlnx-versal-canfd.h
+++ b/include/hw/net/xlnx-versal-canfd.h
@@ -31,7 +31,7 @@
 #include "hw/register.h"
 #include "hw/core/ptimer.h"
 #include "net/can_emu.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 
 #define TYPE_XILINX_CANFD "xlnx.versal-canfd"
 
diff --git a/include/hw/net/xlnx-zynqmp-can.h b/include/hw/net/xlnx-zynqmp-can.h
index 8262f11d33d..d272f40ea80 100644
--- a/include/hw/net/xlnx-zynqmp-can.h
+++ b/include/hw/net/xlnx-zynqmp-can.h
@@ -36,7 +36,7 @@
 #include "net/can_host.h"
 #include "qemu/fifo32.h"
 #include "hw/core/ptimer.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 
 #define TYPE_XLNX_ZYNQMP_CAN "xlnx.zynqmp-can"
 
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index e5c7e0518a5..44f8583bff9 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -26,7 +26,7 @@ typedef enum memory_order {
 
 #include "hw/sysbus.h"
 #include "hw/core/clock.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/core/irq.h"
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index ddb219d4562..4494d5558f0 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/adc/npcm7xx_adc.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
 #include "migration/vmstate.h"
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index c0d99182bf9..42ceb097ae8 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -23,7 +23,7 @@
 #include "hw/arm/armsse-version.h"
 #include "hw/arm/boot.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 
 /*
  * The SSE-300 puts some devices in different places to the
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 8198a83d15c..d9c7bcbcd71 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -14,7 +14,7 @@
 #include "hw/arm/boot.h"
 #include "hw/core/loader.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "elf.h"
 #include "system/reset.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3a5071a3841..6199d2d2d7c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -21,7 +21,7 @@
 #include "system/block-backend.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index ca487774aee..f923b9505b7 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -13,7 +13,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index 7af2a77865e..329578a542c 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -12,7 +12,7 @@
 #include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "system/system.h"
 #include "hw/i2c/smbus_eeprom.h"
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 1678cce416b..0502a137f3d 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -16,7 +16,7 @@
 #include "system/system.h"
 #include "hw/arm/aspeed.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/loader.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index d12a9b8459c..04d37056596 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/aspeed_coprocessor.h"
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 5b75e142063..f40c70fea54 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/aspeed_coprocessor.h"
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index 9d976c3d142..c91b41a7fc5 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -11,7 +11,7 @@
 #include "system/system.h"
 #include "system/block-backend.h"
 #include "hw/core/boards.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 7f1856f5ba1..321e63723e3 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -14,7 +14,7 @@
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "hw/arm/max78000_soc.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
 static const uint32_t max78000_icc_addr[] = {0x4002a000, 0x4002a800};
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index e4ceb7efcd5..4b6e76e46bb 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -10,7 +10,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/max78000_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index c262a9c6795..f101c1b7c3b 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -73,7 +73,7 @@
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qom/object.h"
 #include "hw/core/irq.h"
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index af3b0124891..7d2efc703bd 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -48,7 +48,7 @@
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qobject/qlist.h"
 #include "qom/object.h"
 
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index c64e103f599..77a0c0b7aff 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -33,7 +33,7 @@
 #include "system/system.h"
 #include "hw/core/boards.h"
 #include "hw/core/or-irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index c5e9c7175a4..27d77af9dcd 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -29,7 +29,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
 #define MSF2_TIMER_BASE       0x40004000
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 78d98c4a407..10382f0d3b2 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -33,7 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "system/address-spaces.h"
 #include "hw/arm/msf2-soc.h"
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 7b30d9bd446..75d82eebcac 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -34,7 +34,7 @@
 #include "hw/misc/tz-ppc.h"
 #include "hw/misc/unimp.h"
 #include "hw/rtc/pl031.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qom/object.h"
 
 #define MUSCA_NUMIRQ_MAX 96
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 1657612fe77..c9281059365 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 746a3deef8e..d64d2aefe46 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 6d6f6744869..6905e1d8a7d 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -21,7 +21,7 @@
 #include "hw/char/serial-mm.h"
 #include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "exec/tswap.h"
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 2bf5e132bb5..71e47dac2e1 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -24,7 +24,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/core/loader.h"
 #include "hw/misc/unimp.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/units.h"
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index d8cc3214ed6..a4ccfa373a6 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "qemu/log.h"
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index d15545ff07a..1a08d742155 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 34cbcbe32c2..f3e8e15de81 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -31,7 +31,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
 #include "hw/timer/stellaris-gptm.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qom/object.h"
 #include "qobject/qlist.h"
 #include "ui/input.h"
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index 0702d51cc3e..8d61be72c48 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -30,7 +30,7 @@
 #include "system/address-spaces.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "system/system.h"
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index e3c7203c6e7..406f614f1d5 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -29,7 +29,7 @@
 #include "system/address-spaces.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "system/system.h"
 
 /* At the moment only Timer 2 to 5 are modelled */
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index c8684e2b4c5..c2bc460603f 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -27,7 +27,7 @@
 #include "system/address-spaces.h"
 #include "system/system.h"
 #include "hw/arm/stm32f405_soc.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
 #define RCC_ADDR                       0x40023800
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index c28ce15e6bb..39b8cdf97dc 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -30,7 +30,7 @@
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/char/stm32l4x5_usart.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 
 #define FLASH_BASE_ADDRESS 0x08000000
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 4843c5565b6..e7e1b8200e1 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -27,7 +27,7 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index e127b232d75..0d9c01e4b78 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -34,7 +34,7 @@
 #include "hw/char/cadence_uart.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/cpu/a9mpcore.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/misc/unimp.h"
 #include "system/reset.h"
 #include "qom/object.h"
diff --git a/hw/char/cadence_uart.c b/hw/char/cadence_uart.c
index 738ba3114b9..58c4c95fded 100644
--- a/hw/char/cadence_uart.c
+++ b/hw/char/cadence_uart.c
@@ -31,7 +31,7 @@
 #include "qemu/module.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties-system.h"
 #include "trace.h"
 
diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
index db852511091..23abeacb1b5 100644
--- a/hw/char/ibex_uart.c
+++ b/hw/char/ibex_uart.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/char/ibex_uart.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 75fdb8158e4..030d6a2e8b4 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -23,7 +23,7 @@
 #include "hw/char/pl011.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index ce4a35da8f4..4533cbc93be 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -25,7 +25,7 @@
 #include "hw/char/stm32l4x5_usart.h"
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index dacafa4e036..b96525951cd 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -13,7 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9f56c66aec..fae9ffc7595 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -36,7 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/core/boards.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index a5a38da6384..5686bd53c23 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -21,7 +21,7 @@
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/core/irq.h"
 #include "hw/core/clock.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
 #include "qapi/error.h"
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index b4b4a86a5fa..b63b27d03fa 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -30,7 +30,7 @@
 #include "hw/mips/bootloader.h"
 #include "hw/mips/cps.h"
 #include "hw/pci-host/xilinx-pcie.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index e47695e2b0a..13f048ef9c9 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -22,7 +22,7 @@
 #include "qemu/module.h"
 #include "hw/mips/cps.h"
 #include "hw/mips/mips.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "system/tcg.h"
 #include "system/reset.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 2b0eb8c478e..e5ed0b56923 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -58,7 +58,7 @@
 #include "system/kvm.h"
 #include "semihosting/semihost.h"
 #include "hw/mips/cps.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "target/mips/internal.h"
 #include "trace.h"
 #include "cpu.h"
diff --git a/hw/misc/npcm7xx_mft.c b/hw/misc/npcm7xx_mft.c
index 514d29f2015..0bbae111cf9 100644
--- a/hw/misc/npcm7xx_mft.c
+++ b/hw/misc/npcm7xx_mft.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/npcm7xx_mft.h"
 #include "hw/misc/npcm7xx_pwm.h"
diff --git a/hw/misc/npcm7xx_pwm.c b/hw/misc/npcm7xx_pwm.c
index 2e72d1c7d4f..39ac0dbe2a5 100644
--- a/hw/misc/npcm7xx_pwm.c
+++ b/hw/misc/npcm7xx_pwm.c
@@ -16,7 +16,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/npcm7xx_pwm.h"
 #include "hw/registerfields.h"
diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index e202a8a2998..bc9ee975de7 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -18,7 +18,7 @@
 
 #include "hw/misc/npcm_clk.h"
 #include "hw/timer/npcm7xx_timer.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index d4af2cd6963..1b012d1cc1e 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -25,7 +25,7 @@
 #include "hw/misc/stm32l4x5_rcc_internals.h"
 #include "hw/core/clock.h"
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "hw/registerfields.h"
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index de488a46780..52495610d1b 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -27,7 +27,7 @@
 #include "hw/core/irq.h"
 #include "migration/vmstate.h"
 #include "hw/core/clock.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qapi/error.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 010387beec4..cc18b21b22b 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qom/object.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index 9eb39a6b846..704f4387684 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -32,7 +32,7 @@
 #include <zlib.h> /* for crc32 */
 
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/net/npcm7xx_emc.h"
 #include "net/eth.h"
diff --git a/hw/timer/armv7m_systick.c b/hw/timer/armv7m_systick.c
index c9e0f4c2e17..baba0817b8f 100644
--- a/hw/timer/armv7m_systick.c
+++ b/hw/timer/armv7m_systick.c
@@ -14,7 +14,7 @@
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/timer/cmsdk-apb-dualtimer.c b/hw/timer/cmsdk-apb-dualtimer.c
index 57fea11a855..5f4848ef618 100644
--- a/hw/timer/cmsdk-apb-dualtimer.c
+++ b/hw/timer/cmsdk-apb-dualtimer.c
@@ -25,7 +25,7 @@
 #include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index 8b7595731cc..d80bf1f96d0 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -35,7 +35,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/timer/cmsdk-apb-timer.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/npcm7xx_timer.c b/hw/timer/npcm7xx_timer.c
index e09e4ee03ad..0e62add74d3 100644
--- a/hw/timer/npcm7xx_timer.c
+++ b/hw/timer/npcm7xx_timer.c
@@ -17,7 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "hw/core/irq.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/npcm7xx_timer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index bb364e815be..de9d354483b 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -35,7 +35,7 @@
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
 #include "hw/core/clock.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "migration/vmstate.h"
 
 /* Registers in the control frame */
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index fc48179d25d..1de882f3eb3 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -44,7 +44,7 @@
 #include "hw/core/irq.h"
 #include "hw/registerfields.h"
 #include "hw/core/clock.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/stellaris-gptm.c b/hw/timer/stellaris-gptm.c
index d97b2f8309c..37cd760318e 100644
--- a/hw/timer/stellaris-gptm.c
+++ b/hw/timer/stellaris-gptm.c
@@ -12,7 +12,7 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/timer/stellaris-gptm.h"
 
 static void gptm_update_irq(gptm_state *s)
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index e1a2a33d73e..f1dd7d66eee 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -30,7 +30,7 @@
 #include "hw/core/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/registerfields.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 5989c3ba177..894799c02c7 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -30,7 +30,7 @@
 #include "system/kvm.h"
 #include "system/qtest.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "fpu_helper.h"
 #ifndef CONFIG_USER_ONLY
 #include "semihosting/semihost.h"
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 1eeed44e336..ecc5e093a40 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -34,7 +34,7 @@
 #include "fpu/softfloat.h"
 #include "qemu/module.h"
 #include "migration/vmstate.h"
-#include "hw/qdev-clock.h"
+#include "hw/core/qdev-clock.h"
 #include "accel/tcg/cpu-ops.h"
 #ifndef CONFIG_USER_ONLY
 #include "system/memory.h"
-- 
2.51.1


