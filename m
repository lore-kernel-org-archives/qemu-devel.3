Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3A4C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag6G-0005FV-5J; Thu, 15 Feb 2024 13:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5I-0001w1-6s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:47 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5E-0003BE-OP
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:43 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-563bb51c36eso921822a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020217; x=1708625017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBV5qUeSmxg7d8YWWooFsnTAz7bZYxgfHwu1fmOUlCU=;
 b=mX6wJTbPzF1p33zih82b2xr+rvHG/p8upbcp2+etksbCBn124LuDniBoYQ3U+qzaq6
 0fsgDqUvpiwWxIbCeVzq2O4wDWnZQjIYaE8cuXIxHNbP2KkDsHDEAhuH0K6MuSp8mfCl
 DlaYV/cQ4Z77TarIYiYu8Pby2msS6QjWd54gbWSjB+is8xOLuh3lvsYPW1qMM0cL/XXf
 eaX66Y94yhrzQ9hfs8rtym1cqWaAv2RkEaRzbeGuu2XPfyrTR+u5/mBgUWXxe/4AuPDe
 WBxQBJn9MTydZMKD/8iMGtF5Twwz0pkyk4CLlUnZp0XuQFeGi5QH5U+iCiZC4R7oTo8V
 ydig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020217; x=1708625017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBV5qUeSmxg7d8YWWooFsnTAz7bZYxgfHwu1fmOUlCU=;
 b=DHgQKG51Z7bYTMx80p1cjQRhQ4OMi8crZNSTk5HrnZGXduyDs7D44KuoalUdaqyVli
 M/ZSMr8nk444yBweBgxRDzxUZtu1GeHH26W2UzYg+drvHnYEXGanc/h1iObC8SDhdNEP
 +Q5oEM3rdWu21YSvxymVCBA1brjBbBPViYwV++VOi8RizE3BBHal5rU/0d+vE2TGgbqF
 Ct40TDQ1TSR7jgWOkjEqB2t4ORx+SMO5VJ7bU78jiPEhWPvMQOmbOk/MIHFqJkTTo9Fe
 oDx0QK2ZsuFcrgQ7+P4lqJnM+T9bS8pu5oZEOlKk4VYqgejr9gqkWPq1nt0Eb4K+zXVd
 wsbg==
X-Gm-Message-State: AOJu0YyDj3yEDNDR+5qVEwh0YJLopu41wtIwGWtNkprB0k02XA7aDH3b
 7AHAAAspNsP7CQaKBzzD8Dx+z5aZtgJiy860ZiJIGqjZhpi4lYp1T7s87848D5a85zxuW5FKpT5
 Pv0k=
X-Google-Smtp-Source: AGHT+IEQr/ETKSHifJM4NvzDnH6nB8W920pjx4hXnPS8saZH6joZvwJ+mEFURnJ24x7+S2CN5qIBJA==
X-Received: by 2002:a17:906:c415:b0:a3d:7d6b:2dc3 with SMTP id
 u21-20020a170906c41500b00a3d7d6b2dc3mr1755304ejz.73.1708020217134; 
 Thu, 15 Feb 2024 10:03:37 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 t22-20020a1709063e5600b00a3c091ead20sm784624eji.222.2024.02.15.10.03.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:36 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 John Snow <jsnow@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 51/56] hw/ide/ahci: Pass AHCI context to ahci_ide_create_devs()
Date: Thu, 15 Feb 2024 18:57:45 +0100
Message-ID: <20240215175752.82828-52-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Since ahci_ide_create_devs() is not PCI specific, pass
it an AHCIState argument instead of PCIDevice.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-6-philmd@linaro.org>
---
 include/hw/ide/ahci.h | 2 +-
 hw/i386/pc_q35.c      | 2 +-
 hw/ide/ahci.c         | 5 +----
 hw/mips/boston.c      | 2 +-
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index dbef377f3d..8cd55b1333 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -52,7 +52,7 @@ typedef struct AHCIState {
 } AHCIState;
 
 
-void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
+void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd);
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
 OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 09e12418f9..d346fa3b1d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -304,7 +304,7 @@ static void pc_q35_init(MachineState *machine)
         idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
         g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
         ide_drive_get(hd, ich9->ahci.ports);
-        ahci_ide_create_devs(pdev, hd);
+        ahci_ide_create_devs(&ich9->ahci, hd);
     } else {
         idebus[0] = idebus[1] = NULL;
     }
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 8b97c6b0e7..bac1871a31 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1896,10 +1896,8 @@ static void sysbus_ahci_register_types(void)
 
 type_init(sysbus_ahci_register_types)
 
-void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
+void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd)
 {
-    AHCIPCIState *d = ICH9_AHCI(dev);
-    AHCIState *ahci = &d->ahci;
     int i;
 
     for (i = 0; i < ahci->ports; i++) {
@@ -1908,5 +1906,4 @@ void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
         }
         ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
     }
-
 }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index a6c7bc18ff..1b44fb354c 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -775,7 +775,7 @@ static void boston_mach_init(MachineState *machine)
     ich9 = ICH9_AHCI(pdev);
     g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
     ide_drive_get(hd, ich9->ahci.ports);
-    ahci_ide_create_devs(pdev, hd);
+    ahci_ide_create_devs(&ich9->ahci, hd);
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
-- 
2.41.0


