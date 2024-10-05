Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CECBCF887C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 10:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx1cg-00035c-5h; Sat, 05 Oct 2024 06:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1cd-000330-1C; Sat, 05 Oct 2024 06:02:47 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1ca-00083e-SO; Sat, 05 Oct 2024 06:02:46 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a991fedbd04so138217866b.3; 
 Sat, 05 Oct 2024 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728122562; x=1728727362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJT4bwjrVjkUNMR4zGJJ5/3WvHmiyGwjh/aOrcBGjRY=;
 b=H0H/NyXSlWefUcISHN0wSfAh5Ckq3e6tgsSrpxQgME26gep6sXG+BSM5wbnowFCBti
 8tyq9TNEJ8D0WJ5fhxg2bd1wDO8GEJy/lQErqZXPwnIn2x3wqE36AeBmp7wLj6MXyAoe
 xydOIvdfD2q4srk4qkWyajtqonKcb2hfT8PJNkNqi2sfHAnI6nNzgRLrLoTfEq/mwhN/
 C8B9Jc4fWM3+mIym7/ke6HlvNq0/TGMtPjqObPrdsh8eNlfyP5K9FZoS55dPXTD9yl96
 f1BxO20DDJ/xEqMT6T1iy6yE218E0KdjeHKk77mOXbKkscZwi+9jtZXZeKxws2JNP3nN
 4Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728122562; x=1728727362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJT4bwjrVjkUNMR4zGJJ5/3WvHmiyGwjh/aOrcBGjRY=;
 b=tnBNYYdP6OkcgrdMGvzRyeOPGjaLKlyiO3Bk/sJDIBLqNgp5TgQq26JouZX+I9p204
 1z7B6itVknW+OWg/DXmwI9BniKcb/R1xJ5BgbfiUW+Dwkuhonugfo6LCSb/OUjC6bF+i
 3UGaWPIYgE7rHZwPIDgc4YL6riCzNBZNHtZDBP7b7yCNOo1jTnRvnokIY8Acr1Le0Rcw
 bErB6jGJ+jwLa6x/wfJUY9Fghk9RHCMHWaa1lAyJ+oVMldSh3leB/UmE/paoRbETQGkR
 cRF8k1gexIhccMJvnOIsViJxIRfc8rhVzrxuqX5Iy1voWw0m0QCkpIqKVgykb+laIJFD
 A0EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBk23FSds/dam5knwRUrzeFxVc/W6PEsmUsJSI3rGvAacleNQoLQQvtTXOMMES6rPf0u0PXH4AC40=@nongnu.org,
 AJvYcCWAmRQUDhjuWzazlMT7CR6rXOdMK90GtSXixxvUyTZlnwjOT2Fzc1lJjCbugVR4Jbm+cDRId+5z5A==@nongnu.org
X-Gm-Message-State: AOJu0YyPUYX9x9ksIwcmCmf9HDqqXSKMfWC2HUuV6V1WJV6DxwWl2qY7
 SQUB7OSLUmgqkAJRD9JPUSulcQB4YKtkpNhmXnN9WvDNm3+afL6qVj2ohA==
X-Google-Smtp-Source: AGHT+IEO6NZO2RD1rAqlnwP8PKvVYpspjzhA1Kulz9/YL9J9e/PkkdYMdtczI0kCSod+GT8jF5JRkg==
X-Received: by 2002:a05:6402:35cf:b0:5c5:cb49:2f28 with SMTP id
 4fb4d7f45d1cf-5c8d2e16faemr6064037a12.4.1728122562150; 
 Sat, 05 Oct 2024 03:02:42 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9932bf8a90sm99894166b.50.2024.10.05.03.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 03:02:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 2/2] hw/ppc/e500: Reuse TYPE_GPIO_PWR
Date: Sat,  5 Oct 2024 12:02:28 +0200
Message-ID: <20241005100228.28094-3-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005100228.28094-1-shentey@gmail.com>
References: <20241005100228.28094-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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
index 3bd12b54ab..7811c22e7b 100644
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
 
@@ -892,13 +890,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
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
@@ -1086,7 +1077,7 @@ void ppce500_init(MachineState *machine)
     sysbus_create_simple("e500-spin", pmc->spin_base, NULL);
 
     if (pmc->has_mpc8xxx_gpio) {
-        qemu_irq poweroff_irq;
+        DeviceState *gpio_pwr_dev;
 
         dev = qdev_new("mpc8xxx_gpio");
         s = SYS_BUS_DEVICE(dev);
@@ -1096,8 +1087,9 @@ void ppce500_init(MachineState *machine)
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
index 5addad1124..89cabe5d53 100644
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
2.46.2


