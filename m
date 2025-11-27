Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528B1CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObr8-0002fv-Sp; Thu, 27 Nov 2025 08:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqe-0002dO-5X
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqc-0001Fq-4d
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAHvRgvvKwLL73VIlz6jx5tFhzH+NwkRqY+7ivGH24I=;
 b=dbWed6jAHp6rI3h5JROpD6P2TUXmqlb/Q2xbqYkTXoldl7yLw9ps3xf1enpI6mDRNIZufc
 19MrrDMGEK1HqstVMbcENYl29Cv9L9GNPF5Yla6G3wZ1OdNDa+SxcHda0ulEtTUeogw/G4
 Erts/gvsQLI1o9W0upIV/6oanx6vVks=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-LMX1KkJnP6e02Sx6HLXD8Q-1; Thu, 27 Nov 2025 08:15:43 -0500
X-MC-Unique: LMX1KkJnP6e02Sx6HLXD8Q-1
X-Mimecast-MFC-AGG-ID: LMX1KkJnP6e02Sx6HLXD8Q_1764249342
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b763acb793fso81482066b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249341; x=1764854141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IAHvRgvvKwLL73VIlz6jx5tFhzH+NwkRqY+7ivGH24I=;
 b=moQCh85mdjiE1R08TGs8xaXoX4JwYxqCM9HunQ93C2JhlxiJfF5+PV7peQG6ZtEzlX
 5yuRIVTMLq5kppD9j4PeRrlYJbq5xIfQ+T+0bScexJvTjxrtCzKxHVGe5KH5A403vt4p
 ByzeMO/G2o0JOzf5R8X3E4SOSWBgK7ql3BNg9zlR8JW05PS5C9vTzpEZm+LEwbz8ffO8
 0CHlUv4sQv8CMJDDE98moCDuA+4Go1btuShKtHMr8e17cf4eO5JtzY+R3tTMF1jSobwc
 saPA8W6u5s/9ydextXH159xjHwpht05b8Lnk419w0eMn928LM2wlp82LuG6q4rC33PGt
 Bh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249341; x=1764854141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IAHvRgvvKwLL73VIlz6jx5tFhzH+NwkRqY+7ivGH24I=;
 b=GAASYGhwYl/rAF/UX2uaNjv9CiIDgwOdo1BcQRIfRBcxv7jZdA7EvJOyz3aO3JSPmc
 I3tAqsOHnMVI74F/pC1SQQSWwoYLkW5CpmJG2Ldmc1OQzUN8HIW+Hifp765BeCWDSsr/
 MHmEyqhzFi2ctP5uhiepgeIlfUwH0ZSJ4+9IFZyhzqnebTV6Gq8Z1+jI9DCHgZFyXiFr
 PefUYuu9V6Ib/Ylwbh4zSLEe1qpwrUyYUw0m6qEp28u82gRzzH1wANq1APwiQQJeWj9K
 lvnRk7p4MQ1uQSWDrgJ8FljGNZnDyptY0AYKMEeMs0G38vvgaNcEDmM/D1Celewk5l43
 i0nw==
X-Gm-Message-State: AOJu0Yx2sBha+ER3dUJjdIzjrVxhQyQJQdrwY6JMULi4vtyH03XbwRRv
 be2p3BrGBXyS4drQ2GO2mSWb120qs8oAoYR68wmMlnh05YRHRbXYZOl8hKOpqCbMMQaHeonUpu0
 nIIxm8fZ/pH7AJRrW5u7cBigji3kasMIFvfpM+Py7ixUPtirsKbbHGxwVA3mhx99k7CuM1tyR2E
 duA0hmL/9G60tYLCnkhqS1+AcUMHMndeHnpCjtTBYW
X-Gm-Gg: ASbGncv+dNDu+nkFKxgFScdV1sXuhSuojoiCUdACDG98pQQvPMHg4BVR/e92ngcGhAg
 5HrYT2lm0B5cPa8TGYlT1SdkF8cusvDd7qumQekNSaCyMjuz3QX+sYfrrWCYXkX2F+pjzCIxRLl
 bu3PnYyCBMx6YNZxJLdvbKUpHfXw7IHp3ErmIxU6ar0K7ARfGgzojyxFlkPJ8P8rqiQYspF4/DH
 6R8xE4UXLX1tlH//2qc0n5SQyB2X0PlV0t155bd5+8sFw06fnBshOaUW8ptVbsLfaGwPG1udrPR
 bpTIpOOR3iO4i5y+FN0iJ9Y8M61TnOp9YbhMGg0c3OtkWFiCoBMMeXvmSKkBYZD7GvtobGpzEPp
 J0hGZnVUxBSW9P6Sx9Bd1hSDGT3Qp1MYNsC+9gFGF6p7fwo/tefPhAp9sE4L/J8oqxtVOVOCa6g
 rj6+KOM0QB3jwBouY=
X-Received: by 2002:a17:906:5958:b0:b76:edfa:9296 with SMTP id
 a640c23a62f3a-b76edfa9470mr279456566b.44.1764249341191; 
 Thu, 27 Nov 2025 05:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPNb2hNmK8+9QY9oqD8/GZehi1Mcx0qyMwlMozP77nyMKZZdHs5yh7NjPL+wSAJFNag+F5Cw==
X-Received: by 2002:a17:906:5958:b0:b76:edfa:9296 with SMTP id
 a640c23a62f3a-b76edfa9470mr279448866b.44.1764249340054; 
 Thu, 27 Nov 2025 05:15:40 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5163903sm170861866b.7.2025.11.27.05.15.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/28] include: move hw/or-irq.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:00 +0100
Message-ID: <20251127131516.80807-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 include/hw/arm/armsse.h              | 2 +-
 include/hw/arm/bcm2835_peripherals.h | 2 +-
 include/hw/arm/exynos4210.h          | 2 +-
 include/hw/arm/fsl-imx6.h            | 2 +-
 include/hw/arm/fsl-imx7.h            | 2 +-
 include/hw/arm/fsl-imx8mp.h          | 2 +-
 include/hw/arm/max78000_soc.h        | 2 +-
 include/hw/arm/stm32f205_soc.h       | 2 +-
 include/hw/arm/stm32f405_soc.h       | 2 +-
 include/hw/arm/stm32l4x5_soc.h       | 2 +-
 include/hw/arm/xlnx-zynqmp.h         | 2 +-
 include/hw/{ => core}/or-irq.h       | 0
 include/hw/intc/aspeed_intc.h        | 2 +-
 include/hw/m68k/q800.h               | 2 +-
 hw/arm/mps2-tz.c                     | 2 +-
 hw/arm/mps2.c                        | 2 +-
 hw/arm/mps3r.c                       | 2 +-
 hw/arm/musicpal.c                    | 2 +-
 hw/arm/stm32l4x5_soc.c               | 2 +-
 hw/arm/xlnx-versal.c                 | 2 +-
 hw/core/or-irq.c                     | 2 +-
 hw/m68k/q800.c                       | 2 +-
 hw/pci-host/raven.c                  | 2 +-
 hw/ppc/pegasos.c                     | 2 +-
 hw/sparc/sun4m.c                     | 2 +-
 25 files changed, 24 insertions(+), 24 deletions(-)
 rename include/hw/{ => core}/or-irq.h (100%)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 04755ed1ec3..414e553600d 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -109,7 +109,7 @@
 #include "hw/misc/armsse-mhu.h"
 #include "hw/misc/armsse-cpu-pwrctrl.h"
 #include "hw/misc/unimp.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/core/clock.h"
 #include "hw/core/split-irq.h"
 #include "hw/cpu/cluster.h"
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 1eeaeec9e0e..d46d892956d 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -17,7 +17,7 @@
 #include "hw/char/bcm2835_aux.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/dma/bcm2835_dma.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/intc/bcm2835_ic.h"
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_rng.h"
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index d33fe385865..fbe4370219d 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -24,7 +24,7 @@
 #ifndef EXYNOS4210_H
 #define EXYNOS4210_H
 
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/sysbus.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/intc/exynos4210_gic.h"
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 124bbd478fd..5520473ba0b 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -33,7 +33,7 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "system/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index aa7818c4999..710831c8bf5 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -36,7 +36,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index d016f7d3371..1275df22f19 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -18,7 +18,7 @@
 #include "hw/misc/imx8mp_analog.h"
 #include "hw/misc/imx8mp_ccm.h"
 #include "hw/net/imx_fec.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/pci-host/designware.h"
 #include "hw/pci-host/fsl_imx8m_phy.h"
 #include "hw/sd/sdhci.h"
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index a203079ee9a..1a6cdb39495 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -9,7 +9,7 @@
 #ifndef HW_ARM_MAX78000_SOC_H
 #define HW_ARM_MAX78000_SOC_H
 
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/arm/armv7m.h"
 #include "hw/misc/max78000_aes.h"
 #include "hw/misc/max78000_gcr.h"
diff --git a/include/hw/arm/stm32f205_soc.h b/include/hw/arm/stm32f205_soc.h
index d3de6b94dab..745433b56c2 100644
--- a/include/hw/arm/stm32f205_soc.h
+++ b/include/hw/arm/stm32f205_soc.h
@@ -29,7 +29,7 @@
 #include "hw/timer/stm32f2xx_timer.h"
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/adc/stm32f2xx_adc.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/ssi/stm32f2xx_spi.h"
 #include "hw/arm/armv7m.h"
 #include "hw/core/clock.h"
diff --git a/include/hw/arm/stm32f405_soc.h b/include/hw/arm/stm32f405_soc.h
index 2eeada64ded..9fe40da9680 100644
--- a/include/hw/arm/stm32f405_soc.h
+++ b/include/hw/arm/stm32f405_soc.h
@@ -31,7 +31,7 @@
 #include "hw/char/stm32f2xx_usart.h"
 #include "hw/adc/stm32f2xx_adc.h"
 #include "hw/misc/stm32f4xx_exti.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/ssi/stm32f2xx_spi.h"
 #include "hw/arm/armv7m.h"
 #include "qom/object.h"
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
index c2fae6e23fe..9c3d662bca9 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -26,7 +26,7 @@
 
 #include "system/memory.h"
 #include "hw/arm/armv7m.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/misc/stm32l4x5_syscfg.h"
 #include "hw/misc/stm32l4x5_exti.h"
 #include "hw/misc/stm32l4x5_rcc.h"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index a3117bd6c50..620b20d0e2a 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -37,7 +37,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/nvram/xlnx-bbram.h"
 #include "hw/nvram/xlnx-zynqmp-efuse.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/misc/xlnx-zynqmp-apu-ctrl.h"
 #include "hw/misc/xlnx-zynqmp-crf.h"
 #include "hw/timer/cadence_ttc.h"
diff --git a/include/hw/or-irq.h b/include/hw/core/or-irq.h
similarity index 100%
rename from include/hw/or-irq.h
rename to include/hw/core/or-irq.h
diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 51288384a56..6dd8effcd89 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -10,7 +10,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 
 #define TYPE_ASPEED_INTC "aspeed.intc"
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index c92da2e2ac7..77551b9592e 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -31,7 +31,7 @@
 #include "hw/misc/mac_via.h"
 #include "hw/net/dp8393x.h"
 #include "hw/char/escc.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/scsi/esp.h"
 #include "hw/block/swim.h"
 #include "hw/nubus/mac-nubus-bridge.h"
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a0d917f9a9e..c262a9c6795 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -53,7 +53,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index bf5e07019ff..af3b0124891 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -32,7 +32,7 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
 #include "hw/arm/machines-qom.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index b63002f4835..c64e103f599 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -32,7 +32,7 @@
 #include "cpu.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9852e8f7648..100a9f59b3f 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -28,7 +28,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/i2c/bitbang_i2c.h"
 #include "hw/core/irq.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/audio/wm8750.h"
 #include "system/block-backend.h"
 #include "system/runstate.h"
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 64da5559c07..c28ce15e6bb 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -26,7 +26,7 @@
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "system/system.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/char/stm32l4x5_usart.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 81cb6294cfa..a0b2f18b551 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -40,7 +40,7 @@
 #include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
index 61006672ad6..bcc7ad1e444 100644
--- a/hw/core/or-irq.c
+++ b/hw/core/or-irq.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 4c03455d6bd..6fe030e8c5d 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -28,7 +28,7 @@
 #include "system/system.h"
 #include "cpu.h"
 #include "hw/core/boards.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "ui/console.h"
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 3032e0d6854..a587f16131b 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -33,7 +33,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/intc/i8259.h"
 #include "hw/core/irq.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "qom/object.h"
 
 #define TYPE_RAVEN_PCI_DEVICE "raven"
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 11bf406ef77..2de80a5fae9 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -14,7 +14,7 @@
 #include "hw/sysbus.h"
 #include "hw/pci/pci_host.h"
 #include "hw/core/irq.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/pci-host/articia.h"
 #include "hw/pci-host/mv64361.h"
 #include "hw/isa/vt82c686.h"
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index b6256864582..fa524513036 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -50,7 +50,7 @@
 #include "hw/misc/empty_slot.h"
 #include "hw/misc/unimp.h"
 #include "hw/core/irq.h"
-#include "hw/or-irq.h"
+#include "hw/core/or-irq.h"
 #include "hw/core/loader.h"
 #include "elf.h"
 #include "trace.h"
-- 
2.51.1


