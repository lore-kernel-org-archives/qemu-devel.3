Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99559C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag6B-0004UR-Um; Thu, 15 Feb 2024 13:04:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5A-0001qa-3h
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:41 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag57-0003AC-MV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:35 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5116ec49081so1395887e87.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020211; x=1708625011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ExMtb1HNe13B1Pbdje1mxE1780Ya0+pqDVCTBcv4Coc=;
 b=zXBxknZMKxNOPfvmAixCzHxKAFfNOZ0mAGcBRKa81qjZQOf4o+FEX8ts7ek2qTejJ8
 jxffaExn6r6ASorilO2GTv1rb1ozAVS8aWbbM5NKp0+y+H5E3AmLE7AsNajZocfcyVo1
 SdXU4fVQuzgDVtO2RW4u3VKqxsrVQDfiOUTCWN3jz9fyZuND7aFbkDZb+wwOQj7r13kE
 xVQCdXvfUtzT5robffOe/kY1m1LN3B4AFqcJwetB7COjiG3aN41PirSpcWFKwCk4FmXI
 TpSVJ6DQi0jC4WD1y8EU2XSJXhDHaV9I8Mz4tioJBv6bayE8Jy/fl4xRLyYnZv8SE7NY
 3fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020211; x=1708625011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ExMtb1HNe13B1Pbdje1mxE1780Ya0+pqDVCTBcv4Coc=;
 b=OOPP4j6LO9e8bSkHgAm572UYYy/d0QbtyWSdUyWsE4IjYRnvtfgJSfz8mxSWXL65Pw
 u54QPJf30gXRzfa5Obs5LD7KQ34j3tFALD6WppR8qjjw1DUWuQzOuPepvzfDoYQtvH3x
 0JECzgRKLpZl3Y0jbsWOjemSE+3SmHypDnR60cb0tZ4VuC4YtdmFl+315pxl+rIvGEMp
 qrbhRXAX8p9t80SL8l90/+SC4LdurbZ3eZ48OV+yfHeDkS/a4avrrMWoJ6KDSPRTKTzH
 CUNfZYEmuUZX+6h+iUYnw+rcxfP4rvpOTYpKOhV5/uCgfT98f7/9WTS+ZqOJKVHdZi6o
 SpjQ==
X-Gm-Message-State: AOJu0YxNyao95yCAJpIzsIOAen7hbLw2gj1pxqAskJqiRQTbRWOg3I45
 Rm7RMYbEEjDeavWoQDWDUQXJqFujfaWkSoqYRri/k5f+TcyVU0hVFBjT/xmciLQTKQHiq48ypRw
 O76s=
X-Google-Smtp-Source: AGHT+IENcezbxvR8ck/l+N3dv3e+M6GbRJadMUiwSMQDHaCY+3BaUlKc7Rl1VL0rO7kIvc7DJREcMw==
X-Received: by 2002:ac2:46eb:0:b0:511:78cf:968a with SMTP id
 q11-20020ac246eb000000b0051178cf968amr1860646lfo.68.1708020210864; 
 Thu, 15 Feb 2024 10:03:30 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 pk27-20020a170906d7bb00b00a3d716dde9csm786640ejb.44.2024.02.15.10.03.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 50/56] hw/ide/ahci: Inline ahci_get_num_ports()
Date: Thu, 15 Feb 2024 18:57:44 +0100
Message-ID: <20240215175752.82828-51-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Introduce the 'ich9' variable and inline ahci_get_num_ports().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-5-philmd@linaro.org>
---
 include/hw/ide/ahci.h | 1 -
 hw/i386/pc_q35.c      | 6 ++++--
 hw/ide/ahci.c         | 8 --------
 hw/mips/boston.c      | 6 ++++--
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 6818d02063..dbef377f3d 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -52,7 +52,6 @@ typedef struct AHCIState {
 } AHCIState;
 
 
-int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
 
 #define TYPE_SYSBUS_AHCI "sysbus-ahci"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a89f900c4c..09e12418f9 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -292,16 +292,18 @@ static void pc_q35_init(MachineState *machine)
 
     if (pcms->sata_enabled) {
         PCIDevice *pdev;
+        AHCIPCIState *ich9;
 
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
         pdev = pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
+        ich9 = ICH9_AHCI(pdev);
         idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
         idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
-        g_assert(MAX_SATA_PORTS == ahci_get_num_ports(pdev));
-        ide_drive_get(hd, ahci_get_num_ports(pdev));
+        g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
+        ide_drive_get(hd, ich9->ahci.ports);
         ahci_ide_create_devs(pdev, hd);
     } else {
         idebus[0] = idebus[1] = NULL;
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index aa9381a7b2..8b97c6b0e7 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1896,14 +1896,6 @@ static void sysbus_ahci_register_types(void)
 
 type_init(sysbus_ahci_register_types)
 
-int32_t ahci_get_num_ports(PCIDevice *dev)
-{
-    AHCIPCIState *d = ICH9_AHCI(dev);
-    AHCIState *ahci = &d->ahci;
-
-    return ahci->ports;
-}
-
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd)
 {
     AHCIPCIState *d = ICH9_AHCI(dev);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 0ec0b98066..a6c7bc18ff 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -678,6 +678,7 @@ static void boston_mach_init(MachineState *machine)
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
     PCIDevice *pdev;
+    AHCIPCIState *ich9;
     DriveInfo *hd[6];
     Chardev *chr;
     int fw_size, fit_err;
@@ -771,8 +772,9 @@ static void boston_mach_init(MachineState *machine)
 
     pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
-    g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(pdev));
-    ide_drive_get(hd, ahci_get_num_ports(pdev));
+    ich9 = ICH9_AHCI(pdev);
+    g_assert(ARRAY_SIZE(hd) == ich9->ahci.ports);
+    ide_drive_get(hd, ich9->ahci.ports);
     ahci_ide_create_devs(pdev, hd);
 
     if (machine->firmware) {
-- 
2.41.0


