Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1948E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQ1-0002TG-6F; Sat, 27 Dec 2025 04:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPz-0002S7-Pr
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPv-0002LX-Kw
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lf1KMiLCtOj6IyyKYDltZnw6RPiVBMyOh5Y5hndcmd4=;
 b=dXqLiGHFEI5eYp5NdhzLuKbxhbX23Ni6PN82s57PuzBxpde7vhfWL2SwXj7ekyMXsXLafb
 rFMWi6WBEea6vCMCRmD08cD+wPmFOCayfwOuaOFXv/TBvjA6uwelP9Au614PsPxzDuo0LA
 F9RPNn4PeZ+8Bmy9VjKFC50ImbRevrM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Ez5JyTx4M7u4OG7kVMf_xg-1; Sat, 27 Dec 2025 04:16:52 -0500
X-MC-Unique: Ez5JyTx4M7u4OG7kVMf_xg-1
X-Mimecast-MFC-AGG-ID: Ez5JyTx4M7u4OG7kVMf_xg_1766827011
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47904cdb9bbso70683505e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827011; x=1767431811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lf1KMiLCtOj6IyyKYDltZnw6RPiVBMyOh5Y5hndcmd4=;
 b=ew/sYYOZnv0478oMcXCCEMt3fe4efZVxWIhAHMi3Fp+CLKsnme1ZtPQCDAYHgqCPi4
 wLh9pRjzVvqOMDF67iOc5ckvKR5WFLU7AYoi4rO0vn3EC+mhdAYJ+Drl5FkioY41sDNh
 dxKt+FpFo8EYAXZ5KeRtcqDg1XDOvLxnCtyuAAnoKwXO+u7BND1cyphbGy+kKw5uSFrx
 p+4RR7eLuroqqPI13YRcyAssQZXkOOS8bahlTTIfGzw9s2QW2HxeqptqzuTSjHC9k+J3
 Kf6CZD3oIkZje9LcqnZQOTcqrqDW3rS0fX+y1qOSj6SaX7rJhzDZm+4q+lmMOTi5U7aR
 QYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827011; x=1767431811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lf1KMiLCtOj6IyyKYDltZnw6RPiVBMyOh5Y5hndcmd4=;
 b=KIJvav7rVNgHHafT768NKujiIwJXOlXX3yOqKJVHMgsHSPyJ+56BLa0N1MhnR4b5G3
 23CG6CsZVPnbn5LH1Z2leXXmZ6RBWLhlFdk1saOQiHmGimWt+gzhq6JMFCcblQa/VtRg
 JdhZSqwaCOxDqYaunB3eCND2g1lpm6oJnOxEvLkPkrwEr95KZBW2qM66E0mDn+r7nJR4
 yOlAPer7bZukuJEd2zF85ajTPXypZHdnLIslE1RgQYmEGepBJWq5rOUqJIt2xRirGIJG
 IwrV9KGUXKw6c7NIY5O62OTH5HkYR1qJk18L2q+CS+krlJjh97ueMf1zCperFDpdQ84W
 gwug==
X-Gm-Message-State: AOJu0YzwGIafwVDnnARyLEvQFqbB9ybFYY6gmUwoJvY5cfa9cJZO2bVS
 bi1JxHSrYRrdj38aaWSBspYOFsNMOPwTIKYc6pCSiGJRIu19Wi9ItOLafOMjeL5AAWzMkoXyenb
 IrLDichWUBva77eoVp8WZLfk91p+r9Afkl28f3lDfsGMZ6lVNO4Ocm20SEuvpVSvMEgGsAh2dMc
 7V6g6WpK24pU1Z/Lk+OASmJFydSuWpUk67pOP4/V6x
X-Gm-Gg: AY/fxX5C3znqgoEDVQx70E3RiZkc3qck8uV++JbdBiR9muZ0bG73AOig6aVyC6R90hA
 vZlyMHdHipuLouKR6IKzaOGk0dRBU+1U1e62XQB5ICFeOvWqKvu388ByNaPawqhoPq6Fuc7gjxN
 x9W2kmJRHfUmLP0JudF3ItiYIfIhHYQhXNxgX4IEooPy+VsEFY1gspvselISW8jn0y5j3oR25x4
 5+ErKH8eSlCEW+nnTLCK11TCE6tuCCD0hVDiy35o6xXK3out/1Had25cfDuE2x1raOm2Eqmax8i
 QZfa71y6soEVEDZixvNY8wUNAFcH+Htnzn5TG5LWLfxuaC+jjZplrcdVrDGwQOFFXUJI0ECbBAd
 gJmmVmF4lpXnoi9dRGMy/zYHmh1o9laCg6eHid8EQfrIDOGt8FRH4FONuUXavcYLK+lTt2knIWh
 cWcoANXW9wDPdHGlk=
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr273739045e9.1.1766827010785; 
 Sat, 27 Dec 2025 01:16:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzzNI2gUtWLrAJchMNGrbsBhwNZc7fW6/i2j08lJfp+Zp2IXIrYH+SLZ1mY5YbWtUgCDOfoQ==
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr273738795e9.1.1766827010088; 
 Sat, 27 Dec 2025 01:16:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm487157775e9.3.2025.12.27.01.16.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 014/153] include: move hw/or-irq.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:01 +0100
Message-ID: <20251227091622.20725-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
2.52.0


