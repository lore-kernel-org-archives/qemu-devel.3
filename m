Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D932C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXK-0002eA-1A; Tue, 06 May 2025 10:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVN-00022x-WD
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVL-00029r-Df
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-441ab63a415so58032935e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542561; x=1747147361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nuq78rkGSNZ7T1CUqO8dmM+8eIROkFYTrjfOysd4f+o=;
 b=pAG1/HsItXzUJImiKoaFlGfz1n3PsQZA9GTVg2pQ5tE3sdPIHilVcBqxfmPeJQkJeA
 Lbvf4q53g6MaB/0f2Usgw0whFYvW0DiNOhmTB3ATgFPbeoj/3MMRd2xP3swYYHbxlXYY
 NE4Nncf5QDBTxcr4t9VSnhh/KYgMaXNKeEI0318vajeEWb/4niwijfyoiKgWdIB2DIXO
 QvAejd8Hd3suB0hqTcxtBK0bhK13C1u8RF5leCGCWYa7e/My4jbnj5nWnuhzWyrVQTXI
 yiuSDO8y1xltPVq2VwmPzDNHdJPCmpO/rRc8kJYUlzxYR49aKf/Y1fLrbZz8WUTJb0lJ
 q9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542562; x=1747147362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nuq78rkGSNZ7T1CUqO8dmM+8eIROkFYTrjfOysd4f+o=;
 b=ew3OtjCUuZ7d3blK1a3OE4fb4sTWJB7pgc1UgHoQHcK6iMdIMHiKHluxWetB/LshgJ
 G0mLIZ3jAoRVjh6qGeqJuCKu2JVKaFBw2PPS7+/wNXzOdPYxHy7yofJTt9MLF/VzMFNT
 gannOX80CVK161BDHuD2YT8F99QSutaWiZoO2GpIvfKXuga1XACBDYe8wLmWD4RmbanU
 pB9Vglo84DLWru1PzyOocKjYXQi6AUkZgvkSQGMFZQ1tHrAs84gaka2cYkDn/VFWdVrE
 leR2gLh5EWEfIQUjclb6IUUUzqEI8TESvwTouSr4OaO1MXDnmOfA+u0q0ToKECjKdCcH
 JBuw==
X-Gm-Message-State: AOJu0YzXuKZAIeTzBXtU8kM+6HpuCJBJsJyaXVazXOPnfGEre8XXFzRV
 F7BDRhDK0HMlOILbEYWTCDyNpimqABAjxilC+fR3DQutNtNcbizMYOtnqafITKBQ+K0gkBjZiE+
 J
X-Gm-Gg: ASbGncvP92EvEV4Lyu3SyTohexbVdeb1P1J6jdwUDGaItlUy7Drh3y7il2OhbPNVlJs
 omFtL+NSy3gJzZ1mjWJcDnmNXjqAyQJFhYtDlijwsyvE+mxPdGFJXTPmt5AgoRDjHocigl6U75i
 9OzFWm2KPi3vS30GgDK9HPJ1K2RfJ3TgBKhaD97JNfctsb4Im7m4+BuNNb4AMqBkyqj8i6cR6tv
 qha0VsGFRVn3UFu4Puwa0GE4N5EIcDywoHW0pT4WErem7+Xzsnpk762z/YAsV/yxnyCEgMQxEtI
 FohZco/xpYsyJWexTUlj4+dTzcj7qqvn+YihBPzUa9ZF3TQ=
X-Google-Smtp-Source: AGHT+IEM3HjZCyJN7UO1HyLz+C/4lTvCot3umfbFlTJrz4lGyEGa+vExhcGhMLxKBS5VHRpJ3R6fvQ==
X-Received: by 2002:a05:600c:b88:b0:43c:eec7:eab7 with SMTP id
 5b1f17b1804b1-441d0fccce6mr26972135e9.11.1746542561630; 
 Tue, 06 May 2025 07:42:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/32] hw/arm: Attach PSPI module to NPCM8XX SoC
Date: Tue,  6 May 2025 15:42:04 +0100
Message-ID: <20250506144214.1221450-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Tim Lee <timlee660101@gmail.com>

Nuvoton's PSPI is a general purpose SPI module which enables
connections to SPI-based peripheral devices. Attach it to the NPCM8XX.

Tested:
NPCM8XX PSPI driver probed successfully from dmesg log.

Signed-off-by: Tim Lee <timlee660101@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Hao Wu <wuhaotsh@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Message-id: 20250414020629.1867106-1-timlee660101@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/npcm8xx.h |  2 ++
 hw/arm/npcm8xx.c         | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
index 9812e6fa7ec..3436abff998 100644
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
diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index 5cc67b132fc..d7ee306de7a 100644
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
-- 
2.43.0


