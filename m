Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFFCC3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 02:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u49Ed-000282-Cl; Sun, 13 Apr 2025 22:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1u49EZ-000275-Dq; Sun, 13 Apr 2025 22:07:40 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timlee660101@gmail.com>)
 id 1u49EX-00080s-HT; Sun, 13 Apr 2025 22:07:39 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3035858c687so2877975a91.2; 
 Sun, 13 Apr 2025 19:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744596455; x=1745201255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rAYRjFnkuIKTv2bCsQRtCjQmDzBlPOQW/KLz9/7m55U=;
 b=euugMorNTq+dYRnfiAcShTIf8F+oBsCoR7+zWuQMF+r6tv9PUoWEgbhsOn53uX1EEc
 hdQdLiXJFtrM7BgbihXBW+00y1GmXSiIlCirU0DynAHm4T4U1bmfHrWnvmzwkyUTUd2f
 vu8+GlReONHmpVZ6zfwNAuc6vFjNXPRjBwYy/9G1gJeuvrzCBIshjdV3q8Df/5FKp8ZV
 tuun58yQ5EixdHhJ759o1MrMJ5HMjdxz4Cohb/doqnXCaIRn8uIW8Me/kWS+Cs9Ky2Kw
 RJfjEAixe7TdMhUJKT7tmqvk4+ta0hXXtEeciEa1dBs2eiEKfxpN4iBJkfc7pdvnTJxe
 yOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744596455; x=1745201255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rAYRjFnkuIKTv2bCsQRtCjQmDzBlPOQW/KLz9/7m55U=;
 b=vwoNoaIYNY91gIZ/Gc/VskdnZ6cRhKVbpcydFGI6h+wInUJEFR5+sU4mxyG5M4Ju6m
 rtxDWjjRe0O8Ih9CjCmHAd2aGxLqPoFjEYvnZGFTK4IxIKXTQoeNijHCeIiOxXwjwi39
 lLcFLb1RVhxWLIa/u6mfeksIHHIuXAaJQKUv59iF1OX3jomDJDUcjzRUAs3LUXyPAs41
 3YjkeWzco8Xp5l1S1xcboM/3YIse4Y5FCiAygImznLFBhk8lZV7AzrK3B29x2QxsuZXf
 //v2lkzclUp7wjq7DQUJkW8XdRbqbNxpiZolG2D8by2Yl/lPqvrGwH4I9I2c63TMo/wO
 hKCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo2o4FiofiY2LCpW3hMr72W0HSRnyAVAl7bn4UY6kFlCX+un2pYS1h295UgCBFhh0w6CkHXFCXEbXD@nongnu.org
X-Gm-Message-State: AOJu0YzO8BexjdFtSY3n3cZdF1hasvOLM7NYJ7lzDSzNKLKzMGbH4nFG
 nK+Gxyy+R+/HXeMFNxEa1pbmLmCAQX0xOqElkkIk8SjBnzl9M9RSbMAGbnN1
X-Gm-Gg: ASbGncu9zbPQq6kFZbwRvFsDZhJk2RNI0JyJYz4DOr0B3yL3sy2PLol9pL/8tNy3evg
 kj1lwSZHcKiQJaP7msSDWobkiBR3a178L3ZscaHdzvS2nxuRppCpQiJnL1xyR1wfdiArSKMlnoi
 DnEHiGr92RjxrSJU414IGuWNVorxuDO9MGjCxC/iW6QqOcddAwxP3E5C29D4dqUYFAonPSEK6s/
 /nxLqqxaks5q/5aKQ2d3NRS1Bj4kwfN0KLlcMVA1vrC3pLg4gKH6kbpPL0Y+OKyDQ7MBkaOk0w+
 ujO3mhoOSYdwhXJTPMAfyRPVlpRZskCo3q7l/pO+nJAQ/stCYRobaVRd2uNI69i+fhKswWd1o+N
 /GekULSyp
X-Google-Smtp-Source: AGHT+IF08toQGsozr/+A+wTcsZfkBqqrerDe26zxYao8lcZZQfA9DGxOdDXnxLIZpxV9bbv2crwVBQ==
X-Received: by 2002:a17:90b:2dca:b0:305:5f32:d9f5 with SMTP id
 98e67ed59e1d1-30823660b8amr16676466a91.7.1744596454980; 
 Sun, 13 Apr 2025 19:07:34 -0700 (PDT)
Received: from hcdev-d520mt.. (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e79fsm10185411a91.19.2025.04.13.19.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Apr 2025 19:07:34 -0700 (PDT)
From: Tim Lee <timlee660101@gmail.com>
To: peter.maydell@linaro.org, wuhaotsh@google.com, kfting@nuvoton.com,
 chli30@nuvoton.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Tim Lee <timlee660101@gmail.com>
Subject: [PATCH] hw/arm: Attach PSPI module to NPCM8XX SoC
Date: Mon, 14 Apr 2025 10:06:29 +0800
Message-Id: <20250414020629.1867106-1-timlee660101@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=timlee660101@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Nuvoton's PSPI is a general purpose SPI module which enables
connections to SPI-based peripheral devices. Attach it to the NPCM8XX.

Tested:
NPCM8XX PSPI driver probed successfully from dmesg log.

Signed-off-by: Tim Lee <timlee660101@gmail.com>
---
 hw/arm/npcm8xx.c         | 11 ++++++++++-
 include/hw/arm/npcm8xx.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index f182accc47..a7888afb6e 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -67,6 +67,9 @@
 /* SDHCI Modules */
 #define NPCM8XX_MMC_BA          0xf0842000
 
+/* PSPI Modules */
+#define NPCM8XX_PSPI_BA         0xf0201000
+
 /* Run PLL1 at 1600 MHz */
 #define NPCM8XX_PLLCON1_FIXUP_VAL   0x00402101
 /* Run the CPU from PLL1 and UART from PLL2 */
@@ -83,6 +86,7 @@ enum NPCM8xxInterrupt {
     NPCM8XX_PECI_IRQ            = 6,
     NPCM8XX_KCS_HIB_IRQ         = 9,
     NPCM8XX_MMC_IRQ             = 26,
+    NPCM8XX_PSPI_IRQ            = 28,
     NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
     NPCM8XX_TIMER1_IRQ,
     NPCM8XX_TIMER2_IRQ,
@@ -441,6 +445,7 @@ static void npcm8xx_init(Object *obj)
     }
 
     object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
+    object_initialize_child(obj, "pspi", &s->pspi, TYPE_NPCM_PSPI);
 }
 
 static void npcm8xx_realize(DeviceState *dev, Error **errp)
@@ -705,6 +710,11 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc), 0,
             npcm8xx_irq(s, NPCM8XX_MMC_IRQ));
 
+    /* PSPI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pspi), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pspi), 0, NPCM8XX_PSPI_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pspi), 0,
+            npcm8xx_irq(s, NPCM8XX_PSPI_IRQ));
 
     create_unimplemented_device("npcm8xx.shm",          0xc0001000,   4 * KiB);
     create_unimplemented_device("npcm8xx.gicextra",     0xdfffa000,  24 * KiB);
@@ -720,7 +730,6 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("npcm8xx.siox[1]",      0xf0101000,   4 * KiB);
     create_unimplemented_device("npcm8xx.siox[2]",      0xf0102000,   4 * KiB);
     create_unimplemented_device("npcm8xx.tmps",         0xf0188000,   4 * KiB);
-    create_unimplemented_device("npcm8xx.pspi",         0xf0201000,   4 * KiB);
     create_unimplemented_device("npcm8xx.viru1",        0xf0204000,   4 * KiB);
     create_unimplemented_device("npcm8xx.viru2",        0xf0205000,   4 * KiB);
     create_unimplemented_device("npcm8xx.jtm1",         0xf0208000,   4 * KiB);
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index 9812e6fa7e..3436abff99 100644
--- a/include/hw/arm/npcm8xx.h
+++ b/include/hw/arm/npcm8xx.h
@@ -36,6 +36,7 @@
 #include "hw/usb/hcd-ehci.h"
 #include "hw/usb/hcd-ohci.h"
 #include "target/arm/cpu.h"
+#include "hw/ssi/npcm_pspi.h"
 
 #define NPCM8XX_MAX_NUM_CPUS    (4)
 
@@ -99,6 +100,7 @@ struct NPCM8xxState {
     OHCISysBusState     ohci[2];
     NPCM7xxFIUState     fiu[3];
     NPCM7xxSDHCIState   mmc;
+    NPCMPSPIState       pspi;
 };
 
 struct NPCM8xxClass {
-- 
2.34.1


