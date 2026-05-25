Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B2CD5BC7
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 05:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRNYM-0005uY-IJ; Mon, 25 May 2026 01:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicholasrighi@gmail.com>)
 id 1wRLxm-00018D-0e
 for qemu-devel@nongnu.org; Sun, 24 May 2026 23:26:46 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicholasrighi@gmail.com>)
 id 1wRLxk-000307-CU
 for qemu-devel@nongnu.org; Sun, 24 May 2026 23:26:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ba6485d219so69945235ad.3
 for <qemu-devel@nongnu.org>; Sun, 24 May 2026 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779679602; x=1780284402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W6pFew2PcKBu/UgDQM2bV99EKQGlTTpt1Ko3DRE89Yo=;
 b=nIXAVViLpMwiXGUI9M5ScoXVwjeCRYN24wb42eAPIdElSeTDGKLUXAcF6wHA3zBQv0
 eEOSgY44vp82Kc5FEudtcoECGHoiKIMoNfD2cEpTN29Vc+ooXd9PY2bvb49x696ssEOJ
 3VXIolQ/EsT0NQFS3XYQujblj/Bg0SHmsMoN+OmFmjfXhnoj5IFNAQBSY4tTVSpspt1n
 TviDOgLgrosCvx0YnVza6UwYmkA5LBiHUz8hEaB2E5OxTaVU3mo21j/LbLRUab8soqqA
 gbuDDV2M/zKxBmVRaVaeIaMK3jdFroAxhJgY/9PHHse1Kd1kdioN+nYZnlQOrPBFeQQK
 52uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779679602; x=1780284402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6pFew2PcKBu/UgDQM2bV99EKQGlTTpt1Ko3DRE89Yo=;
 b=dnBNcJwTq8ZQHVOn17jt9RuK+LpUfAKwUxkyuFXIR/+8bvNyP9mnLW1l/G4XYEEFlI
 BzMPHdJi1EZJi65B0eJqTL0cZbM6qgLoMP8f93heyLSOqWWw2imIosZy2xLYJOjOy4I4
 R+E8JJESHHwzgwhR6DaHSBqKL/+TlGgrThZbaHwJ+HV+qIBpc19V/G9lWpR+Cx4JLGEO
 HY+0SSyQZtvTVPmxhbwBuxmSw9tJyPqLUoIo7XVfisyNABcpc3/2JEfpuBtf59EH7kTg
 AkMCUD/xMGacDoKaM1g96cSourTPmD7GtJu/orLLwjcKbGwoJpwORko6YFMwi2gor7D7
 2EsQ==
X-Gm-Message-State: AOJu0YxcBJor4TTXCz50mA1+LdxmP/TDGh1WTU1K5uHUPgUGqs0peUbM
 ERQQn5+guGFKTc3ZrlQHxeraJWkOqqE2Tw8lPfJWx0A5h9U58R9y5/WrdDc/rNgI
X-Gm-Gg: Acq92OGuKQcR6W45FY4Yc1I7ww8TaSb2Zr6CrVjDwsDAWnFyjgl5Df9lfo7o0B/8DGV
 qv5sEK/+ssybHxL1BgjeO4SOGNmr3jjnRsO3FDEkq/4VuXjkPttYtYda+znkEvEs2o6lSlwgyus
 t/BtWFTfJ+G8IXeiHeaxeHsAVJe6tHiNsl2K8eUQVvdg9lS4/bua8rhiDMGy9qqVfk/4ffotyKT
 Q8JhxmlvxBjM0hYsINB5Xt+Kdc1NY+/aA876ck0bXBTnMaykc2UrfK6KfQinQjRbqJa2J0mqni8
 fTUz1YrOU8jkkCsAvJ+UtDoDyzxFcmv5PLV+XNMKhDUy1RmnZJrmGA0TEbqMDpdyD4FVjfyjDIi
 n2DXj7YWr1Mxgdn2akn5W6AKGnafJGU2z+GrXLuTuBueFVivKgP5vb7rWp0ziJAl1vK82Q0wSkA
 tq3dsY1LtXlnyDWdnragPjz3xQ0eCZfL9R20x/A5G24TgT6Mzt3QrrW43jyOVcGiAjslDO7Z16K
 MmaZF0MDieLpD4d
X-Received: by 2002:a17:902:f705:b0:2be:3dbc:eee5 with SMTP id
 d9443c01a7336-2beb0365bbcmr142139275ad.2.1779679602121; 
 Sun, 24 May 2026 20:26:42 -0700 (PDT)
Received: from DESKTOP-G2FUN8N.hsd1.wa.comcast.net ([73.59.59.170])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56ba00csm82058685ad.22.2026.05.24.20.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 20:26:41 -0700 (PDT)
From: Nicholas Righi <nicholasrighi@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Righi <nicholasrighi@gmail.com>
Subject: [PATCH] hw/arm/bcm2838: Route I2C interrupts to GIC
Date: Sun, 24 May 2026 20:26:34 -0700
Message-ID: <20260525032634.7754-1-nicholasrighi@gmail.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=nicholasrighi@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 25 May 2026 01:08:36 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The I2C interrupts are only routed to the legacy interrupt controller. This means
that for modern device trees that use the GIC, the interrupts don't work. This patch
re-routes the I2C OR'd interrupt from the legacy interrupt controller to the GIC so
I2C emulation works out of the box with current kernels.

Testing

Add these lines to QEMU invocation

-drive if=none,id=i2c_storage,format=raw,file=eeprom.bin \
-device at24c-eeprom,bus=i2c-bus.1,address=0x50,drive=i2c_storage,rom-size=4096 \

note: eeprom.bin is all zeros

Before this change, running i2c get to read from EEPROM would result in this

i2cget -y 1 0x50
Error: Read failed

After this change, running i2c to read from EEPROM results in this

i2cget -y 1 0x50
0x00

The eeprom can now also be enabled in the device tree. Before the
eeprom driver load would fail due to the read failing

ls -l /sys/bus/i2c/devices/i2c-1/1-0050/ | grep -i eeprom
-rw------- 1 root root 4096 May 17 16:57 eeprom

Signed-off-by: Nicholas Righi <nicholasrighi@gmail.com>
---
 hw/arm/bcm2838.c                     | 3 +++
 include/hw/arm/bcm2838_peripherals.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index c14a854046..6895f70385 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -184,6 +184,9 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
 
+    qdev_connect_gpio_out(DEVICE(&ps_base->orgated_i2c_irq), 0,
+                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_I2C));
+
     /* Connect VC mailbox to the interrupt controller */
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 7ee1bd066f..0be97e67c7 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -22,6 +22,7 @@
 #define GIC_SPI_INTERRUPT_DMA_7_8      87
 #define GIC_SPI_INTERRUPT_DMA_9_10     88
 #define GIC_SPI_INTERRUPT_AUX_UART1    93
+#define GIC_SPI_INTERRUPT_I2C          117
 #define GIC_SPI_INTERRUPT_SDHOST       120
 #define GIC_SPI_INTERRUPT_UART0        121
 #define GIC_SPI_INTERRUPT_RNG200       125
-- 
2.51.2


