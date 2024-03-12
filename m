Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C7C54E69
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxPj-0005gA-37; Tue, 12 Mar 2024 04:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPf-0005bO-8o
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:07 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxPb-00018b-QS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:06 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512b3b04995so4133116e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231782; x=1710836582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eC/1sv6Wv+c7ut+0cdVRZlJFS7IBk+vo2wQm3zp+8ts=;
 b=Fd1fc1iq/M+GU7EAm8sZ0C+YlMZ4hfOLoC+TBCHc0XXVliSk2MMvXiGhrvkIr7jWeJ
 U3hTRGc3aNZasSo+eWZXHL0AjxCxegy959CbkM/XeZn7RZyEvhrhffLQnSXQjNX0wQ3r
 GbAMJQa4HWQhGu+PinoRzPWtEa2RRGNHMKkk+aDDuWb+2pgHB/6ccbUQzVbkIA15Q422
 XrZpMt/MZyUrOKqTXwtT6TqHaWTpSK/0JhZrloTus8M5DU+mYAXowU7J5+m6kACLZ5M7
 9HiQGNM4CTBv50mGBm0mFaqR2NCPIkQO+rd8T8xW+BxQOE+XkCmYDMXp2FFXIRe2uqiz
 ApFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231782; x=1710836582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eC/1sv6Wv+c7ut+0cdVRZlJFS7IBk+vo2wQm3zp+8ts=;
 b=BnYpLat65GnSVwxPsRyDnA8q+jRlnXWnmRaJfY0abpV8H7lo5Kl0pK6IkaogUiJmJP
 ySm7ohYosnFle6So4cRomlwMm+zoBW7gDFyI8DHJ7ix1LjdjVD2bvu7XExm13mdUhULh
 qU0iDrEdBGk21+7UMNCabKDJG+r9pp24LeF4B9H60zAUI36owX5kZdXBm8wIG/wkeS7k
 LZbkdixfLB4P07t+wYZGKz6GQMc6VhfUHQ+YrrVkzoyIxslwLmxkAuKcckBho9zId6oH
 NAtuQMt69+WUxoaKoAa4kVjPAL/fQX4Im2MXwijk+g4cB8SlKspWXMRBjoEPrV4x46pK
 zYSA==
X-Gm-Message-State: AOJu0YyOngGmL8kr5jcgVZo/m56ygWMzOQwDTOnJ7znWCRwaDw1dZELF
 3aS8z8VcSAgjQvAVM9WrE90kQ8AZzrLmuonm3PPqpRrOrNFXgo6zRg8kZdj6dijuwkDdTw4tk3S
 h
X-Google-Smtp-Source: AGHT+IEl3EiOx9/QsAaQt4B9AVFgK6bUXopLNS2p4Ya46SpMdxFFxS3sw/JUxmpPFdLAVvGNF4KZjg==
X-Received: by 2002:a19:5f5a:0:b0:513:ee3:65bd with SMTP id
 a26-20020a195f5a000000b005130ee365bdmr4962829lfj.35.1710231781536; 
 Tue, 12 Mar 2024 01:23:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a05600c35c400b004130c1dc29csm11664395wmq.22.2024.03.12.01.23.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/13] hw/ppc/sam460ex: Support short options for adding drives
Date: Tue, 12 Mar 2024 09:22:28 +0100
Message-ID: <20240312082239.69696-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Having to use -drive if=none,... and -device ide-[cd,hd] is
inconvenient. Add support for shorter convenience options such as
-cdrom and -drive media=disk. Also adjust two nearby comments for code
style.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20240305225721.E9A404E6005@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/sam460ex.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7e34b6c5e0..d42b677898 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -33,6 +33,7 @@
 #include "hw/char/serial.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/i2c/smbus_eeprom.h"
+#include "hw/ide/pci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/ppc/fdt.h"
 #include "hw/qdev-properties.h"
@@ -449,15 +450,27 @@ static void sam460ex_init(MachineState *machine)
 
     /* PCI devices */
     pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
-    /* SoC has a single SATA port but we don't emulate that yet
+    /*
+     * SoC has a single SATA port but we don't emulate that
      * However, firmware and usual clients have driver for SiI311x
-     * so add one for convenience by default */
+     * PCI SATA card so add one for convenience by default
+     */
     if (defaults_enabled()) {
-        pci_create_simple(pci_bus, -1, "sii3112");
+        PCIIDEState *s = PCI_IDE(pci_create_simple(pci_bus, -1, "sii3112"));
+        DriveInfo *di;
+
+        di = drive_get_by_index(IF_IDE, 0);
+        if (di) {
+            ide_bus_create_drive(&s->bus[0], 0, di);
+        }
+        /* Use index 2 only if 1 does not exist, this allows -cdrom */
+        di = drive_get_by_index(IF_IDE, 1) ?: drive_get_by_index(IF_IDE, 2);
+        if (di) {
+            ide_bus_create_drive(&s->bus[1], 0, di);
+        }
     }
 
-    /* SoC has 4 UARTs
-     * but board has only one wired and two are present in fdt */
+    /* SoC has 4 UARTs but board has only one wired and two described in fdt */
     if (serial_hd(0) != NULL) {
         serial_mm_init(get_system_memory(), 0x4ef600300, 0,
                        qdev_get_gpio_in(uic[1], 1),
@@ -531,6 +544,7 @@ static void sam460ex_machine_init(MachineClass *mc)
 {
     mc->desc = "aCube Sam460ex";
     mc->init = sam460ex_init;
+    mc->block_default_type = IF_IDE;
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size = 512 * MiB;
     mc->default_ram_id = "ppc4xx.sdram";
-- 
2.41.0


