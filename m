Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34366C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raff3-0001AB-Mr; Thu, 15 Feb 2024 12:36:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeU-000865-VX
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:05 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeO-00042s-To
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:36:02 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-411d76c9ce3so9475025e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018554; x=1708623354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ea1kVIAkawEF+lGSnrFK5m7SIyAZKyj+Cf2CTRSeEN0=;
 b=WkMcUzhC+y+/mNo5E5rPuOGqJhCplejqGAf2trAGq0jfM3Ez2ww2XnpJA0cz056DDT
 JYzbP6kVXcbYJEFfw6nBic7jetwYwWQEXTeI/LNM98ZndPa2+D78Je7pI4tr3cbHEkHJ
 3+YRNi3iSSdqaBQ6w4TTYGaWP4tHKiqj8S1DzSc0w/Il36ZzpxMGsl52u7nDzqIX5JK2
 rJEZDFGWkzJ/jMVJHgYFHoFfp1tZBUvlw4vsrcWpO9eKPim84CGWIs3iNQkYrscTYSoP
 mOuiWz1M34ZghcChHrk5rBTn7iDywYP9OC/ErGF3c7fhS6hLV0krUf1YoZ2Mp0WRaVMQ
 Qq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018554; x=1708623354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ea1kVIAkawEF+lGSnrFK5m7SIyAZKyj+Cf2CTRSeEN0=;
 b=QUDHg/qvXAgx010VybR+1NJp/7HTTM02uTJWrEhtni+AOOxeoUCddQ1N7HEtVJ+vrs
 ZkD/LKsfG3mTFCFq7KnhDO9WaF5OYywQaqcUOjA2LStfwxWFvjqpsy5KvUrWwg2v76cv
 d6RmCI3KuzbK0KCbg8vp1hBgwkln8sTjkbkCAfT18yw0ECSqoIAbmV7xmsYVB3pZ33Km
 uUNxQTzXdpm9UurVQPmyAXMG3aIEX+358KLBH08mClctGUiRvBJVyCMYgyYflGgdXcYb
 oLB/h77lwjqrqp7EgAC3zyQlK8QusdA6CDSQ2aBJYfMBFefJLy2dIyaZS6CZhRaCAFOX
 JzgA==
X-Gm-Message-State: AOJu0YxU7/qJEHHEKVsodXmoQSrKxu4ZdN4hZP9XSOsWoJZA0W8lCvNp
 AN1Dm93pKQS+tmIEq0Rd69sKh6omPw20CzddFXA/w1dzZpolwThypPCWlaIgAr8Ov8YEGS5c9ws
 O
X-Google-Smtp-Source: AGHT+IGFY/qaWXAuLiH8aEN7fyKwvR3rpy+UEwb5O/KstR1gSEt4Xcl+qb7NSsZiVUE/qSpkXioejw==
X-Received: by 2002:adf:ee49:0:b0:33b:4c3b:f7da with SMTP id
 w9-20020adfee49000000b0033b4c3bf7damr1868092wro.62.1708018554305; 
 Thu, 15 Feb 2024 09:35:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/35] hw/arm/mps3r: Add remaining devices
Date: Thu, 15 Feb 2024 17:35:37 +0000
Message-Id: <20240215173538.2430599-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Add the remaining devices (or unimplemented-device stubs) for
this board: SPI controllers, SCC, FPGAIO, I2S, RTC, the
QSPI write-config block, and ethernet.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240206132931.38376-13-peter.maydell@linaro.org
---
 hw/arm/mps3r.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index 803ed0ffb5c..4d55a6564c6 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -40,7 +40,12 @@
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
+#include "hw/misc/mps2-scc.h"
+#include "hw/misc/mps2-fpgaio.h"
 #include "hw/misc/unimp.h"
+#include "hw/net/lan9118.h"
+#include "hw/rtc/pl031.h"
+#include "hw/ssi/pl022.h"
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 
@@ -105,6 +110,11 @@ struct MPS3RMachineState {
     CMSDKAPBWatchdog watchdog;
     CMSDKAPBDualTimer dualtimer;
     ArmSbconI2CState i2c[5];
+    PL022State spi[3];
+    MPS2SCC scc;
+    MPS2FPGAIO fpgaio;
+    UnimplementedDeviceState i2s_audio;
+    PL031State rtc;
     Clock *clk;
 };
 
@@ -178,6 +188,16 @@ static const RAMInfo an536_raminfo[] = {
     }
 };
 
+static const int an536_oscclk[] = {
+    24000000, /* 24MHz reference for RTC and timers */
+    50000000, /* 50MHz ACLK */
+    50000000, /* 50MHz MCLK */
+    50000000, /* 50MHz GPUCLK */
+    24576000, /* 24.576MHz AUDCLK */
+    23750000, /* 23.75MHz HDLCDCLK */
+    100000000, /* 100MHz DDR4_REF_CLK */
+};
+
 static MemoryRegion *mr_for_raminfo(MPS3RMachineState *mms,
                                     const RAMInfo *raminfo)
 {
@@ -337,6 +357,7 @@ static void mps3r_common_init(MachineState *machine)
     MPS3RMachineClass *mmc = MPS3R_MACHINE_GET_CLASS(mms);
     MemoryRegion *sysmem = get_system_memory();
     DeviceState *gicdev;
+    QList *oscclk;
 
     mms->clk = clock_new(OBJECT(machine), "CLK");
     clock_set_hz(mms->clk, CLK_FRQ);
@@ -480,6 +501,59 @@ static void mps3r_common_init(MachineState *machine)
         }
     }
 
+    for (int i = 0; i < ARRAY_SIZE(mms->spi); i++) {
+        g_autofree char *s = g_strdup_printf("spi%d", i);
+        hwaddr baseaddr = 0xe0104000 + i * 0x1000;
+
+        object_initialize_child(OBJECT(mms), s, &mms->spi[i], TYPE_PL022);
+        sysbus_realize(SYS_BUS_DEVICE(&mms->spi[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&mms->spi[i]), 0, baseaddr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&mms->spi[i]), 0,
+                           qdev_get_gpio_in(gicdev, 22 + i));
+    }
+
+    object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
+    qdev_prop_set_uint32(DEVICE(&mms->scc), "scc-cfg0", 0);
+    qdev_prop_set_uint32(DEVICE(&mms->scc), "scc-cfg4", 0x2);
+    qdev_prop_set_uint32(DEVICE(&mms->scc), "scc-aid", 0x00200008);
+    qdev_prop_set_uint32(DEVICE(&mms->scc), "scc-id", 0x41055360);
+    oscclk = qlist_new();
+    for (int i = 0; i < ARRAY_SIZE(an536_oscclk); i++) {
+        qlist_append_int(oscclk, an536_oscclk[i]);
+    }
+    qdev_prop_set_array(DEVICE(&mms->scc), "oscclk", oscclk);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->scc), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->scc), 0, 0xe0200000);
+
+    create_unimplemented_device("i2s-audio", 0xe0201000, 0x1000);
+
+    object_initialize_child(OBJECT(mms), "fpgaio", &mms->fpgaio,
+                            TYPE_MPS2_FPGAIO);
+    qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", an536_oscclk[1]);
+    qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "num-leds", 10);
+    qdev_prop_set_bit(DEVICE(&mms->fpgaio), "has-switches", true);
+    qdev_prop_set_bit(DEVICE(&mms->fpgaio), "has-dbgctrl", false);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0xe0202000);
+
+    create_unimplemented_device("clcd", 0xe0209000, 0x1000);
+
+    object_initialize_child(OBJECT(mms), "rtc", &mms->rtc, TYPE_PL031);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->rtc), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->rtc), 0, 0xe020a000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->rtc), 0,
+                       qdev_get_gpio_in(gicdev, 4));
+
+    /*
+     * In hardware this is a LAN9220; the LAN9118 is software compatible
+     * except that it doesn't support the checksum-offload feature.
+     */
+    lan9118_init(0xe0300000,
+                 qdev_get_gpio_in(gicdev, 18));
+
+    create_unimplemented_device("usb", 0xe0301000, 0x1000);
+    create_unimplemented_device("qspi-write-config", 0xe0600000, 0x1000);
+
     mms->bootinfo.ram_size = machine->ram_size;
     mms->bootinfo.board_id = -1;
     mms->bootinfo.loader_start = mmc->loader_start;
-- 
2.34.1


