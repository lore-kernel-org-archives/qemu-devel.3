Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A3AD75E25
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tERhv-0007m8-7h; Fri, 22 Nov 2024 06:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERho-0007iJ-E7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:20:10 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERhl-0006Cb-M1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:20:08 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ffa97d99d6so4370311fa.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 03:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732274402; x=1732879202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w2mewmHu7F82WCCsJ8/YlP7drCNs4XevivVXJNwCNSg=;
 b=fxsoW62UNWtBGsKAI0pFbqa/XNHXDJssjeKlZxUT/d/wwpTsDc+GQRH9lROeEAGZNX
 HaFxUIcGtFLO6xXYKNmdYMKRt7mqAnkqWjb8gCD57Yt5jeU7seMLYQjyJfGJ18D9WOby
 mP/kIDl75lqbLa2yUTqLbtV9NvCvltht7L5AMKiPCXFTx9Xz750pkxeQci0Unsyq/Igg
 AOGIZqqv81DVgOkrReGnY1tbbdBFLudEXQ2m6JRHizNtM+KTDT6ziFP/7NBJJYV7XPiG
 yBlbjeUbXaZ1mC1Oq7rb8p9r8gV32gxLV3uNVehhXOvAJvc8XJ6nFXEpr0PvI80tTSC5
 h4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732274402; x=1732879202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2mewmHu7F82WCCsJ8/YlP7drCNs4XevivVXJNwCNSg=;
 b=goPIwCmCdVgRadAH2zy6y5pbN1E6CMRJRRbqgeQrW/f1nH4CIBrx1RFzTEePm43SNu
 LPYXbPGcwDwepbb7MpzoSpFANhe5T0lce5pcDbgsctF97Eh+XGT4TARiF3aUr/qZkt2j
 IfnRVuyrMuYYMam+oA5sCyp8mbz9FuYyLUaYshUB3i1IXEUN9odspoVWpU28TnmcI6h3
 29mFns/5N2BvUk4Mcseag1FSdHH5Z9x4bYt1c+TnWLdfataWQiGM3luXleRFuvsfeuAt
 UDeLNwuUQHE9TeNHxnmw1J5lik5RzYpdrFOk4C8zt4qczSa4h02RFEG1PHrvpDrCmFrX
 lLfw==
X-Gm-Message-State: AOJu0YyJc+Ugk5S8VcrEa8rBptgYKoilBlQzfTvp3q8erD41sVOuUwho
 J6hiPAOc4agJ4dWu1bKT9enR7SwVgv4c6+XP39n/ZB0yTVHyDorfOg0vOEA3CVc+hiOJwYwigy5
 4
X-Gm-Gg: ASbGncskSFNH2G4r+byux6kbRjg2a2hZ2SnEbVByY7Tb+BhSbtOfnKQS8Lq4VDQcxQQ
 tEjUKYtL6PSA/cCJpvzmghEn3A19qx089smQ9vavuVUpK+F1TASeXsgikUSP3jpnvbv2ZjfZW18
 wz1g5Z0QY+X9salHjot9dkvCm1RRy4XRMjqfUW70LcAQqShgJc30FtFLQjeOdqZ5lD5Un/H8wEB
 mdwoS3/yyXbu3l46gNmwidz7bQKpfN47tz2OjpJcsKzDb3j9mwBaLxJk65c/0z0rRRxFd0DzKLF
X-Google-Smtp-Source: AGHT+IFwZOF2ZjxGNNCypLNiOKmbPO8S1PkRtiDeGl6oxTerobzEYorV//bZfDW3KKnQn2SlDl7v7Q==
X-Received: by 2002:a05:6512:3e23:b0:539:e94d:2d3d with SMTP id
 2adb3069b0e04-53dd35a4f38mr1136485e87.7.1732274402028; 
 Fri, 22 Nov 2024 03:20:02 -0800 (PST)
Received: from localhost.localdomain ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde114d5sm24055655e9.17.2024.11.22.03.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Nov 2024 03:20:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Helge Deller <deller@gmx.de>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 3/3] hw/scsi/esp: Call scsi_bus_legacy_handle_cmdline() once
Date: Fri, 22 Nov 2024 12:19:39 +0100
Message-ID: <20241122111939.11936-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241122111939.11936-1-philmd@linaro.org>
References: <20241122111939.11936-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Call scsi_bus_legacy_handle_cmdline() once in the DeviceRealize
handler, just after scsi_bus_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/next-cube.c | 2 --
 hw/m68k/q800.c      | 2 --
 hw/mips/jazz.c      | 2 --
 hw/scsi/esp.c       | 1 +
 hw/sparc/sun4m.c    | 1 -
 5 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 08886d432c..f0fdbef7ae 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -851,8 +851,6 @@ static void next_scsi_init(DeviceState *pcdev)
 
     next_pc->scsi_reset = qdev_get_gpio_in(dev, 0);
     next_pc->scsi_dma = qdev_get_gpio_in(dev, 1);
-
-    scsi_bus_legacy_handle_cmdline(&esp->bus);
 }
 
 static void next_escc_init(DeviceState *pcdev)
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 556604e1dc..816a662fd9 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -487,8 +487,6 @@ static void q800_machine_init(MachineState *machine)
     memory_region_add_subregion(&m->macio, ESP_PDMA - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 1));
 
-    scsi_bus_legacy_handle_cmdline(&esp->bus);
-
     /* Apple Sound Chip */
 
     object_initialize_child(OBJECT(machine), "asc", &m->asc, TYPE_ASC);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 0e43c9f0ba..71badb0616 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -347,8 +347,6 @@ static void mips_jazz_init(MachineState *machine,
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(rc4030, 5));
     sysbus_mmio_map(sysbus, 0, 0x80002000);
 
-    scsi_bus_legacy_handle_cmdline(&esp->bus);
-
     /* Floppy */
     for (n = 0; n < MAX_FD; n++) {
         fds[n] = drive_get(IF_FLOPPY, 0, n);
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ac841dc32e..a1d2f6f380 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1542,6 +1542,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, sysbus_esp_gpio_demux, 2);
 
     scsi_bus_init(&s->bus, sizeof(s->bus), dev, &esp_scsi_info);
+    scsi_bus_legacy_handle_cmdline(&s->bus);
 }
 
 static void sysbus_esp_hard_reset(DeviceState *dev)
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..26e0af43bf 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -338,7 +338,6 @@ static void *sparc32_dma_init(hwaddr dma_base,
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
-    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
 
     sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
 
-- 
2.45.2


