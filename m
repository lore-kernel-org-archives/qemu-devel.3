Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5042EE677FC
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0m-00036W-09; Sat, 02 Nov 2024 09:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0c-00033N-3u; Sat, 02 Nov 2024 09:17:42 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0a-0001x2-GT; Sat, 02 Nov 2024 09:17:41 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a68480164so407177166b.3; 
 Sat, 02 Nov 2024 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553458; x=1731158258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scKsKjVwCuGqApOSyGEnsOwcmcTTDBAW30tcpamKwQc=;
 b=jrgErHtCrjLcKi9cmlkjLO89/eQpgNabmwJDlGntTB0eCGiVOQjCb4XWmsl/OUb79y
 6rx7y6hkxTjqMOqn8tcPeBC/qXwJcBHcg4qOE+JOpVx1f5S5V8OKE2z65GYX0MG4gp9Y
 oBz8KZkWRih54tjF33T2h14JK1duFBQbqCHpPRKNtA4j3TrAnxSLTlRZ0+HyJ3SNr7wB
 Yb9oDtTaxK8nhTzBqp9poImchUQSBGHkTXyLJ0Z0MnSlHSXlW+tMwdgF96bV4u3IOS+1
 LUpfhQyXSBaT6heoOGFUkf4p7eBgt2C96T3aS2/s59t0nzPI6ZjjkueL+KCGEwBrRFHx
 qvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553458; x=1731158258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scKsKjVwCuGqApOSyGEnsOwcmcTTDBAW30tcpamKwQc=;
 b=ovfUIvI+VpOiBh6I9lKDadfql3HTmPvv3Ewlhw5vUZTSS3zR1DM5uNYWPxeufN2thf
 QQlkTnntRHStIX6ckTpKgNF4EqoXZa7z7xVOUh+FK4h+vVcnSeTrFuE5SGw6kixIXWbe
 tP7zV1rls9xmKzdmpYagPUrT6RUHT86dtz+67HReooiMK4Dbsxwd4enzuDAoEE29GGsq
 qsyn0XkYAl21yT3vU9v0PmHU1rz9O/XEaq3s2avPB62InpWuil1BOpKn2nZqKgui5nQ7
 znFj4MwPYNqChGW4n7sd75lJ+58I0RDlma8KUU+IlWhwd17dVHt5lwBddq0XSiaUWc3D
 c8Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1CUKsDvZxVGupEALps2Ypfy5Sr+WtuNfPLoT6mC2z4oPH4z51H+s1LLl/UkmD+yX87FRSWo54hCle@nongnu.org,
 AJvYcCX9hkJTnEnnSR51hJ/hgti9QZdrxOaEa3OKkrA6RXKzF2dqrCZIts1fe/DqY8eASjINNtw63HvG4ng=@nongnu.org
X-Gm-Message-State: AOJu0YzOh0tUrTjaPm1eJfJXntNxMBml2gfTMgLD1VkRez3s654KEhhc
 ViPJs/PrlOsNDd6VgV7Ozm2chE00/LdXajspTAS3hMYP8ZcQ04FYDZZpOg==
X-Google-Smtp-Source: AGHT+IH5iD2Tc0Jah8AtXLEsdsVSLVjz7SsPxZn1HWY1NjSiT4KU6CD5Vl6f9bdezbOv+E5npNJa7w==
X-Received: by 2002:a17:906:478f:b0:a99:f56e:ce40 with SMTP id
 a640c23a62f3a-a9de6166952mr2513568666b.47.1730553457457; 
 Sat, 02 Nov 2024 06:17:37 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 06/26] hw/ppc/e500: Reuse TYPE_GPIO_PWR
Date: Sat,  2 Nov 2024 14:16:55 +0100
Message-ID: <20241102131715.548849-7-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Taking inspiration from the ARM virt machine, port away from
qemu_allocate_irq() by reusing TYPE_GPIO_PWR.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c  | 16 ++++------------
 hw/ppc/Kconfig |  1 +
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index a0c856568b..5d75a090ee 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -30,7 +30,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "sysemu/reset.h"
-#include "sysemu/runstate.h"
 #include "kvm_ppc.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
@@ -47,7 +46,6 @@
 #include "hw/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/i2c/i2c.h"
-#include "hw/irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/misc/unimp.h"
 
@@ -887,13 +885,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
     return dev;
 }
 
-static void ppce500_power_off(void *opaque, int line, int on)
-{
-    if (on) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-    }
-}
-
 void ppce500_init(MachineState *machine)
 {
     MemoryRegion *address_space_mem = get_system_memory();
@@ -1072,7 +1063,7 @@ void ppce500_init(MachineState *machine)
     sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
 
     if (pmc->has_mpc8xxx_gpio) {
-        qemu_irq poweroff_irq;
+        DeviceState *gpio_pwr_dev;
 
         dev = qdev_new("mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
@@ -1082,8 +1073,9 @@ void ppce500_init(MachineState *machine)
                                     sysbus_mmio_get_region(s, 0));
 
         /* Power Off GPIO at Pin 0 */
-        poweroff_irq = qemu_allocate_irq(ppce500_power_off, NULL, 0);
-        qdev_connect_gpio_out(dev, 0, poweroff_irq);
+        gpio_pwr_dev = sysbus_create_simple("gpio-pwr", -1, NULL);
+        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in_named(gpio_pwr_dev,
+                                                             "shutdown", 0));
     }
 
     /* Platform Bus Device */
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index b44d91bebb..12ca3caabf 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -158,6 +158,7 @@ config E500
     imply VIRTIO_PCI
     select ETSEC
     select GPIO_MPC8XXX
+    select GPIO_PWR
     select OPENPIC
     select PFLASH_CFI01
     select PLATFORM_BUS
-- 
2.47.0


