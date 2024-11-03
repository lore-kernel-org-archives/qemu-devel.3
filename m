Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B1AD11040
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7al0-0006Nd-R8; Sun, 03 Nov 2024 08:35:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akn-00069s-Kl; Sun, 03 Nov 2024 08:34:54 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akm-0001Eg-4C; Sun, 03 Nov 2024 08:34:53 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso541952966b.3; 
 Sun, 03 Nov 2024 05:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640889; x=1731245689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scKsKjVwCuGqApOSyGEnsOwcmcTTDBAW30tcpamKwQc=;
 b=Qj+RsAd2eF6KCsX4IZJ1308F/XbnlP3/CQSPukHmSXmuWHxedaiu8otAgHYU+ZiNv8
 r+3OTfJ+ltZka9nPURbUzQkp5j4I+WqlmH1omZDZGOhIRvmJrLYuL2S5mrWr4SkDT7T1
 UDh/qcqzTpC0S3vT1XLM9MsgHJzJmD/6lCN7OY+//4cmla0Af7NYBnJG6C2bZqr8/adX
 pqfKt8L8q+1u58imxx4ruFPu0Ig70R0qQ8+kgxtobfUCRq3DHPbd1tW1vA+oaR6tpIJ2
 kxEjdQilZwxDLX/J4CsdoTHc4helHaYvPQOgJJZEndvE8+597v/z9O5Z7HeEnEvHMdPe
 7+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640889; x=1731245689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scKsKjVwCuGqApOSyGEnsOwcmcTTDBAW30tcpamKwQc=;
 b=T2hZYGRYz30YUIAZ0YPdwlOA7p8yN5Jr2VhxCr+7K7uTwEcpErvw1pt7d25k5V1fEV
 GmTLz0hRy1/zZgeNhW1GhoFNnHMYWSf56kQmY/nOSluCIfScNE2a2mtecNFHyT1nr5HY
 mBnQm1PKREN/b8v4JI9czeeCQyGsm/kWsvSOPU3pGwQBYbY0lDDDKXQqMUAeIW2vN9lv
 J/wjdyDYW3uGEdNfxwbC8pMoDUeu5zDO59FEG2h+IG13CK2T4kGRrAEw3osTn695Tiw0
 sZa84bmWJ8nHQzY2wNl5BkEYNMyQuP9Ju/qibz2Zbbaz5KcSsbPgniWFohfgvt/5yyXK
 QvEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVDF6gBmb/joFkdvLe8R9GnDRVAGvweJcFJHTocok231sSQYAf+dAmXkhQv2ccZG6/Gi3R/PX+HnQ=@nongnu.org,
 AJvYcCWvu8T6X5WmfnhNpEjO1El+ulAmInTx1Rz1BWIhBEGYUgHdzBkY8pbDzlRBri1U+Br4pxMSIPhrTPCI@nongnu.org
X-Gm-Message-State: AOJu0Yx+tgeGS5k01geqZRMkNGQLTU/I17C/XMSCAigaVc500Zva9zZL
 2aFuR6di0su/Q10hJj4InwvOysewJ+Ix+KCTjvXZdqRFxHRc6n8oYexFKg==
X-Google-Smtp-Source: AGHT+IF1QfdyD0Jguue1vn3h1azepvYr0LOfkoX+8GlEMqCtWBmSee7YXuBr+DBGsjlI8018RI6KmA==
X-Received: by 2002:a17:907:3f1f:b0:a99:fb10:128e with SMTP id
 a640c23a62f3a-a9de5fee8admr2751310366b.36.1730640888604; 
 Sun, 03 Nov 2024 05:34:48 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:47 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 06/26] hw/ppc/e500: Reuse TYPE_GPIO_PWR
Date: Sun,  3 Nov 2024 14:33:52 +0100
Message-ID: <20241103133412.73536-7-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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


