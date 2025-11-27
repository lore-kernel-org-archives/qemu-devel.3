Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1964CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObqX-0002Zy-1L; Thu, 27 Nov 2025 08:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqR-0002ZC-Os
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqP-0001CY-GA
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6q5/fA9ZBQN51KybDjDnBCFEP4bAPfWkdyioZykSiY=;
 b=D9G3x5Skzhai5p6j5XFamQEXQlbIJfpJojcOu2j76ulf1a4eCg/zZ8f3Ob/yK1QBupNHbW
 AiSzOE7f6GiCAGqhPgNSTwfesMZ0kl+CoAQCXBXY9nz/5jfmZsMgiyTydAd8qgAFecVRGg
 dpf+IxSfbQuT67iY60CYntcJidvlX48=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-6JTrkZKbMzqc_Lc0b8NDNw-1; Thu, 27 Nov 2025 08:15:31 -0500
X-MC-Unique: 6JTrkZKbMzqc_Lc0b8NDNw-1
X-Mimecast-MFC-AGG-ID: 6JTrkZKbMzqc_Lc0b8NDNw_1764249330
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b73586b1195so85329666b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249330; x=1764854130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D6q5/fA9ZBQN51KybDjDnBCFEP4bAPfWkdyioZykSiY=;
 b=dnApProBnhovVSFrkUo67iTOcZH7WsHd3Emv6nM38a7oue7Xc701EGofNhyFfZfljq
 baX59bYFWThdJyvHL79EMG8ZK5bpcL7qIokwpHtzRMeZL2Dhk2ek+tu+Pf7A/ZtyXfrB
 11UMYKLfK3jnq03tVF7QYWjuS2UAxyPs9qeR68/4FBWH+dL99nnUKG4C1SberZPbi1x7
 SaNHMaH+0qhkX8Ae7XQ8DUnPP9vh/JFC705q3oNoKEjW25ZGm1kFEAEEYsCtkJPrWWuM
 ueJLRZkBdN8OSHemEpJniiOy+FZIpmoECRH1jPtkiru6P2OSIwwYdd1ZUc7iTaxWRE5v
 kwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249330; x=1764854130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D6q5/fA9ZBQN51KybDjDnBCFEP4bAPfWkdyioZykSiY=;
 b=Q7ZjEIdLeXiazB0b0QlaH1/5Te7KbQIYczusbk2bctGQzdrIGdhAQAoyou6vT74alb
 7GUKW5pokvB3S4HPqQobm6VhVPGvpnhNTQ2P6UzddqGe4GOn2RABXK5yrRygpEyFQ3vy
 JrY7SxDUIoi1WGeixHpn50q2G27dnViK/O6OPgenVjK/dLPdh+ytU1HMjSn0SBlDsepe
 jJk2S1hka7n3Nt4QaGFX5LfeaHgzAL9wdaBBUxMG2HAcEpmI3SvJQ80OgmMa0TiNvde2
 nnW8k8/+Msff2lhJTx4hOkGIxCdFV0O2kETUCKNcL1NhovCR873USfJqUDp20HeZMXsN
 ME7Q==
X-Gm-Message-State: AOJu0Yy1oL0iWhh6t+phPMzikWhPTMvRUf1CTaRsymhffkpO03FXVR0C
 g6mk4sbzjZE/MAo1AWiMPWV6T6AZ0Mx+OpLDXWEKy5AlLw8mG4W2+yFwAyAYTyZCF1Rkkp+PlpV
 xF64I8Ib0OYeXQEJd2c/m/vO+jfxGB1240bIIrYYESfIOPZr1yHtQwNQp3f/kcuwdYWYmn1UlL8
 2M5wGNyr0cVlcV5tZ1+qjqPyfCdonTONVM+bLQ6kWO
X-Gm-Gg: ASbGnctzi/bhT0K5jL2Dl/Ni7VcSK6hWM6SwqdHYsRLhvpQ7lfYCrU+C5w/hGsw/vxs
 vlFMQv35N9X+9q44k1bQTvSWDALcJ6pfJmAVEaW/LW84zr1zhzOws8DOPRD+JqCUbKWk2xcuC0g
 SfQCzQqdxTQ1RADt9kCzZPOXrHOpDvbToNm+wlgAAkEsrCxzzPrl4lPmb6UgZ+7mN9gQX74Io2M
 I63YWwZyYOVUmRQruOHggKQ3ArGcgXC6zPX8gp2mJmTaRNsetRDBNdKBvvTiPkiuqwl62mybrGb
 vWQvKvoxOftUac/pLy2XoB7enbr0mXDxFb3J3nXffxARvdUStUWJwnRHAnjVzqr5+1BYxP6KM9R
 An6Yxb/ws9XfcgNsuVrZRlTEJIN8RGIrpkTZgw2woF8P/4Pz9oDJ55sVFJ7zp1dR1lIOsUyX4TV
 uk6LcIxx8RDXaRZgg=
X-Received: by 2002:a17:907:3c87:b0:b76:c0af:779f with SMTP id
 a640c23a62f3a-b76c0af791bmr1281824466b.43.1764249329540; 
 Thu, 27 Nov 2025 05:15:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6O/M+73/PLICojniAf2YPTo3iZnuzRQ4yktbfrw038jrNsrQlVhA40kWVOyYumcYkaJuwQA==
X-Received: by 2002:a17:907:3c87:b0:b76:c0af:779f with SMTP id
 a640c23a62f3a-b76c0af791bmr1281817166b.43.1764249328754; 
 Thu, 27 Nov 2025 05:15:28 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59aea78sm151922266b.36.2025.11.27.05.15.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/28] include: move hw/clock.h to hw/core/
Date: Thu, 27 Nov 2025 14:14:53 +0100
Message-ID: <20251127131516.80807-7-pbonzini@redhat.com>
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
 MAINTAINERS                              | 2 +-
 docs/devel/clocks.rst                    | 2 +-
 include/hw/adc/npcm7xx_adc.h             | 2 +-
 include/hw/arm/armsse.h                  | 2 +-
 include/hw/arm/armv7m.h                  | 2 +-
 include/hw/arm/msf2-soc.h                | 2 +-
 include/hw/arm/nrf51_soc.h               | 2 +-
 include/hw/arm/stm32f100_soc.h           | 2 +-
 include/hw/arm/stm32f205_soc.h           | 2 +-
 include/hw/{ => core}/clock.h            | 0
 include/hw/mips/cps.h                    | 2 +-
 include/hw/misc/npcm7xx_mft.h            | 2 +-
 include/hw/misc/npcm7xx_pwm.h            | 2 +-
 include/hw/misc/npcm_clk.h               | 2 +-
 include/hw/qdev-clock.h                  | 2 +-
 include/hw/timer/armv7m_systick.h        | 2 +-
 include/hw/timer/cmsdk-apb-dualtimer.h   | 2 +-
 include/hw/timer/cmsdk-apb-timer.h       | 2 +-
 include/hw/timer/stellaris-gptm.h        | 2 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h | 2 +-
 rust/hw/core/wrapper.h                   | 2 +-
 target/mips/cpu.h                        | 2 +-
 target/xtensa/cpu.h                      | 2 +-
 hw/char/stm32l4x5_usart.c                | 2 +-
 hw/core/clock-vmstate.c                  | 2 +-
 hw/core/clock.c                          | 2 +-
 hw/core/ptimer.c                         | 2 +-
 hw/gpio/stm32l4x5_gpio.c                 | 2 +-
 hw/mips/fuloong2e.c                      | 2 +-
 hw/mips/jazz.c                           | 2 +-
 hw/mips/malta.c                          | 2 +-
 hw/misc/stm32l4x5_rcc.c                  | 2 +-
 hw/misc/stm32l4x5_syscfg.c               | 2 +-
 hw/timer/sse-counter.c                   | 2 +-
 hw/timer/sse-timer.c                     | 2 +-
 system/qdev-monitor.c                    | 2 +-
 36 files changed, 35 insertions(+), 35 deletions(-)
 rename include/hw/{ => core}/clock.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4c3cfbc81a4..c464e7b5ea8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3951,7 +3951,7 @@ Clock framework
 M: Luc Michel <luc@lmichel.fr>
 R: Damien Hedde <damien.hedde@dahe.fr>
 S: Maintained
-F: include/hw/clock.h
+F: include/hw/core/clock.h
 F: include/hw/qdev-clock.h
 F: hw/core/clock.c
 F: hw/core/clock-vmstate.c
diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index 3f744f2be1e..2dbdc668606 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -46,7 +46,7 @@ Here is an example of clocks::
                                                 | +-------+    |
                                                 +--------------+
 
-Clocks are defined in the ``include/hw/clock.h`` header and device
+Clocks are defined in the ``include/hw/core/clock.h`` header and device
 related functions are defined in the ``include/hw/qdev-clock.h``
 header.
 
diff --git a/include/hw/adc/npcm7xx_adc.h b/include/hw/adc/npcm7xx_adc.h
index 93330a408d2..a0c56d42365 100644
--- a/include/hw/adc/npcm7xx_adc.h
+++ b/include/hw/adc/npcm7xx_adc.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_ADC_H
 #define NPCM7XX_ADC_H
 
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 88b3b759c5a..04755ed1ec3 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -110,7 +110,7 @@
 #include "hw/misc/armsse-cpu-pwrctrl.h"
 #include "hw/misc/unimp.h"
 #include "hw/or-irq.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/core/split-irq.h"
 #include "hw/cpu/cluster.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
index 5c057ab2ec9..e31888cc8cd 100644
--- a/include/hw/arm/armv7m.h
+++ b/include/hw/arm/armv7m.h
@@ -15,7 +15,7 @@
 #include "hw/misc/armv7m_ras.h"
 #include "target/arm/idau.h"
 #include "qom/object.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 #define TYPE_BITBAND "ARM-bitband-memory"
 OBJECT_DECLARE_SIMPLE_TYPE(BitBandState, BITBAND)
diff --git a/include/hw/arm/msf2-soc.h b/include/hw/arm/msf2-soc.h
index 9300664e8ea..510a91cd771 100644
--- a/include/hw/arm/msf2-soc.h
+++ b/include/hw/arm/msf2-soc.h
@@ -30,7 +30,7 @@
 #include "hw/misc/msf2-sysreg.h"
 #include "hw/ssi/mss-spi.h"
 #include "hw/net/msf2-emac.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "qom/object.h"
 
 #define TYPE_MSF2_SOC     "msf2-soc"
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index f88ab1b7d3e..94d7fc62ac4 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -17,7 +17,7 @@
 #include "hw/gpio/nrf51_gpio.h"
 #include "hw/nvram/nrf51_nvm.h"
 #include "hw/timer/nrf51_timer.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "qom/object.h"
 
 #define TYPE_NRF51_SOC "nrf51-soc"
diff --git a/include/hw/arm/stm32f100_soc.h b/include/hw/arm/stm32f100_soc.h
index a74d7b369c1..4c113d67748 100644
--- a/include/hw/arm/stm32f100_soc.h
+++ b/include/hw/arm/stm32f100_soc.h
@@ -29,7 +29,7 @@
 #include "hw/ssi/stm32f2xx_spi.h"
 #include "hw/arm/armv7m.h"
 #include "qom/object.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 #define TYPE_STM32F100_SOC "stm32f100-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(STM32F100State, STM32F100_SOC)
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index 46eda3403a9..d3de6b94dab 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -32,7 +32,7 @@
 #include "hw/or-irq.h"
 #include "hw/ssi/stm32f2xx_spi.h"
 #include "hw/arm/armv7m.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "qom/object.h"
 
 #define TYPE_STM32F205_SOC "stm32f205-soc"
diff --git a/include/hw/clock.h b/include/hw/core/clock.h
similarity index 100%
rename from include/hw/clock.h
rename to include/hw/core/clock.h
diff --git a/include/hw/mips/cps.h b/include/hw/mips/cps.h
index 05ef9f76b74..e7309841d08 100644
--- a/include/hw/mips/cps.h
+++ b/include/hw/mips/cps.h
@@ -21,7 +21,7 @@
 #define MIPS_CPS_H
 
 #include "hw/sysbus.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/misc/mips_cmgcr.h"
 #include "hw/intc/mips_gic.h"
 #include "hw/misc/mips_cpc.h"
diff --git a/include/hw/misc/npcm7xx_mft.h b/include/hw/misc/npcm7xx_mft.h
index e4b997a6ad3..54a2c2a82e6 100644
--- a/include/hw/misc/npcm7xx_mft.h
+++ b/include/hw/misc/npcm7xx_mft.h
@@ -17,7 +17,7 @@
 #define NPCM7XX_MFT_H
 
 #include "system/memory.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
diff --git a/include/hw/misc/npcm7xx_pwm.h b/include/hw/misc/npcm7xx_pwm.h
index df927266209..f697a77cdca 100644
--- a/include/hw/misc/npcm7xx_pwm.h
+++ b/include/hw/misc/npcm7xx_pwm.h
@@ -16,7 +16,7 @@
 #ifndef NPCM7XX_PWM_H
 #define NPCM7XX_PWM_H
 
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 
diff --git a/include/hw/misc/npcm_clk.h b/include/hw/misc/npcm_clk.h
index 52e972f4604..50b93a0094d 100644
--- a/include/hw/misc/npcm_clk.h
+++ b/include/hw/misc/npcm_clk.h
@@ -17,7 +17,7 @@
 #define NPCM_CLK_H
 
 #include "system/memory.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/sysbus.h"
 
 #define NPCM7XX_CLK_NR_REGS             (0x70 / sizeof(uint32_t))
diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index ffa0f7ba09e..af0d8499a67 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -14,7 +14,7 @@
 #ifndef QDEV_CLOCK_H
 #define QDEV_CLOCK_H
 
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 /**
  * qdev_init_clock_in:
diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_systick.h
index ee09b138810..ac7de0a43ef 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -15,7 +15,7 @@
 #include "hw/sysbus.h"
 #include "qom/object.h"
 #include "hw/ptimer.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 #define TYPE_SYSTICK "armv7m_systick"
 
diff --git a/include/hw/timer/cmsdk-apb-dualtimer.h b/include/hw/timer/cmsdk-apb-dualtimer.h
index f3ec86c00b5..f098128a588 100644
--- a/include/hw/timer/cmsdk-apb-dualtimer.h
+++ b/include/hw/timer/cmsdk-apb-dualtimer.h
@@ -28,7 +28,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "qom/object.h"
 
 #define TYPE_CMSDK_APB_DUALTIMER "cmsdk-apb-dualtimer"
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-apb-timer.h
index 2dd615d1be9..74eaf611aeb 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -14,7 +14,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "qom/object.h"
 
 #define TYPE_CMSDK_APB_TIMER "cmsdk-apb-timer"
diff --git a/include/hw/timer/stellaris-gptm.h b/include/hw/timer/stellaris-gptm.h
index fde1fc6f0c7..c705508b829 100644
--- a/include/hw/timer/stellaris-gptm.h
+++ b/include/hw/timer/stellaris-gptm.h
@@ -13,7 +13,7 @@
 #include "qom/object.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 #define TYPE_STELLARIS_GPTM "stellaris-gptm"
 OBJECT_DECLARE_SIMPLE_TYPE(gptm_state, STELLARIS_GPTM)
diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchdog/cmsdk-apb-watchdog.h
index c6b3e78731e..5bbf4979c9f 100644
--- a/include/hw/watchdog/cmsdk-apb-watchdog.h
+++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
@@ -33,7 +33,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/ptimer.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "qom/object.h"
 
 #define TYPE_CMSDK_APB_WATCHDOG "cmsdk-apb-watchdog"
diff --git a/rust/hw/core/wrapper.h b/rust/hw/core/wrapper.h
index 3bdbd1249e4..77b541f83f9 100644
--- a/rust/hw/core/wrapper.h
+++ b/rust/hw/core/wrapper.h
@@ -25,7 +25,7 @@ typedef enum memory_order {
 #include "qemu/osdep.h"
 
 #include "hw/sysbus.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 5cd4c6c818d..ed662135cb0 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -9,7 +9,7 @@
 #include "system/memory.h"
 #endif
 #include "fpu/softfloat-types.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "mips-defs.h"
 
 typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 74122ebe15c..22192924841 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -33,7 +33,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "xtensa-isa.h"
 
 enum {
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index afbe4bab29d..60d8ab5a0e5 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -23,7 +23,7 @@
 #include "chardev/char-serial.h"
 #include "migration/vmstate.h"
 #include "hw/char/stm32l4x5_usart.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/core/clock-vmstate.c b/hw/core/clock-vmstate.c
index e831fc596f8..9566d04cc64 100644
--- a/hw/core/clock-vmstate.c
+++ b/hw/core/clock-vmstate.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "migration/vmstate.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 static bool muldiv_needed(void *opaque)
 {
diff --git a/hw/core/clock.c b/hw/core/clock.c
index 9c906761e19..3fc98a0c65d 100644
--- a/hw/core/clock.c
+++ b/hw/core/clock.c
@@ -15,7 +15,7 @@
 #include "qemu/cutils.h"
 #include "qapi/visitor.h"
 #include "system/qtest.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "trace.h"
 
 #define CLOCK_PATH(_clk) (_clk->canonical_path)
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 0aeb10fb53e..a7337f02b8d 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -14,7 +14,7 @@
 #include "exec/icount.h"
 #include "system/qtest.h"
 #include "block/aio.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 
 #define DELTA_ADJUST     1
 #define DELTA_NO_ADJUST -1
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index 414ce830390..42fe984c493 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/irq.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index e777863703d..fa252c4b285 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -23,7 +23,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "net/net.h"
 #include "hw/core/boards.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 1708cec3f8c..fdcae4ce90e 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/mips/mips.h"
 #include "hw/intc/i8259.h"
 #include "hw/dma/i8257.h"
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index f39e56d2798..44ae8bc6c72 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -29,7 +29,7 @@
 #include "qemu/cutils.h"
 #include "qemu/guest-random.h"
 #include "exec/tswap.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/southbridge/piix.h"
 #include "hw/isa/superio.h"
 #include "hw/char/serial-mm.h"
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 0e1f27fbdda..514159777a0 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -23,7 +23,7 @@
 #include "migration/vmstate.h"
 #include "hw/misc/stm32l4x5_rcc.h"
 #include "hw/misc/stm32l4x5_rcc_internals.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index 4e21756e0b4..85be226d2f4 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -26,7 +26,7 @@
 #include "trace.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
 #include "qapi/error.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
diff --git a/hw/timer/sse-counter.c b/hw/timer/sse-counter.c
index 31f77acf61e..bb364e815be 100644
--- a/hw/timer/sse-counter.c
+++ b/hw/timer/sse-counter.c
@@ -34,7 +34,7 @@
 #include "hw/timer/sse-counter.h"
 #include "hw/sysbus.h"
 #include "hw/registerfields.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
 
diff --git a/hw/timer/sse-timer.c b/hw/timer/sse-timer.c
index 866d5eef8af..c5fd038162b 100644
--- a/hw/timer/sse-timer.c
+++ b/hw/timer/sse-timer.c
@@ -43,7 +43,7 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/registerfields.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 3babf81e330..c8773d864d9 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -41,7 +41,7 @@
 #include "migration/misc.h"
 #include "qemu/cutils.h"
 #include "hw/qdev-properties.h"
-#include "hw/clock.h"
+#include "hw/core/clock.h"
 #include "hw/core/boards.h"
 
 /*
-- 
2.51.1


