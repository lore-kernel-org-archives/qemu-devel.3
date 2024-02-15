Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A59FC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag5P-0001wE-Vk; Thu, 15 Feb 2024 13:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag54-00017X-Bn
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:30 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag50-000385-4s
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:28 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3d6d160529so142999066b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020204; x=1708625004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw97jjpNW0qnluWLs9FH7pp1lrQFlkFyUFYsFWqMU1o=;
 b=v28xvI8EPp4Cg5DXIfPVVTDliY50wUlIWSRMVitpklKSyP3vShtfYSs4KEZL5VGjQt
 HoYjvJk2zYibKyw0qh/6MOX3TnbkVd7rBtZZC52aSASvG4MeI11sC4eqKLXmbP1TH3+W
 b+GB0sC1mtRzg0M6Lt12Zh+ELdIFY59nV2CGLoJe0/+L35qcSMEzt4KYfs/0/TiPXYpG
 6qGeMcqKTf7/XapkEcZc44vKGBAsepXd8yARdH0DYSft7+HEgzvHcSSwg5gZDDFbg+Nk
 kgX7dSM1fqJeOLsNakbC8hjZ6/yKOc7jLp0Mz9nMaEL8irUyhHNq3Zxkk0vjTvVFZbBA
 Z75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020204; x=1708625004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw97jjpNW0qnluWLs9FH7pp1lrQFlkFyUFYsFWqMU1o=;
 b=EQPCqEspk4HoUlLOJXq6kLsUbkMbtAH4MsNKKzJ3ewQGpdScX4QOsRzS67xyIq+kDU
 Vcj5EUmKXwMcH8eElMjmiGw9DJc4iSmcYEIJ0MPO52SOsOcXsqkPxg/F010UTsWtNrj1
 l2+2hNLH4m7rWT+2zYBBZGrbHoT1i8/ecfwiPr7mFSwNgTPs6P7n8E3tNyJFw8gDU7WR
 pZXXJtN19bIdTzgE3kHLPmXMNdnlLWaFM1heQihpCymQ7WlaEBhIB2/UHBkvV0rpgTlJ
 /N9Dfn+MhAzk0U21Fq/QS53NmFyCoo6hbneA3KYfd1kjf8qo3uxIET+AvSGUy77LJ2Q/
 RAQA==
X-Gm-Message-State: AOJu0YwM3LTTH7flnRdRF8RZUtwU75zF3E31sifhaC7W5NZbyu3Lv7dr
 jeA2iPYxyjL2CQykSyTYo5Z2ZF2d1qtNSg8yGjSYNvdLo6flnvjFj+rRNkhFcXJLFCNnS3TMFNV
 zUPU=
X-Google-Smtp-Source: AGHT+IHrQTGzT5Q2yLfxw0/N1DuaO5KF5vuH1Pg27dbrD110GbehTuIHU8+EMIE6K3LG4y4gfPeSfQ==
X-Received: by 2002:a17:906:494e:b0:a3d:88be:94d7 with SMTP id
 f14-20020a170906494e00b00a3d88be94d7mr1603043ejt.70.1708020204492; 
 Thu, 15 Feb 2024 10:03:24 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 wb13-20020a170907d50d00b00a3d28aa375bsm771690ejc.151.2024.02.15.10.03.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 49/56] hw/ide/ahci: Rename AHCI PCI function as 'pdev'
Date: Thu, 15 Feb 2024 18:57:43 +0100
Message-ID: <20240215175752.82828-50-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

We want to access AHCIPCIState::ahci field. In order to keep
the code simple (avoiding &ahci->ahci), rename the current
'ahci' variable as 'pdev'

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-4-philmd@linaro.org>
---
 hw/i386/pc_q35.c | 15 ++++++++-------
 hw/mips/boston.c | 10 +++++-----
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 76b3b6032b..a89f900c4c 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -134,7 +134,6 @@ static void pc_q35_init(MachineState *machine)
     GSIState *gsi_state;
     ISABus *isa_bus;
     int i;
-    PCIDevice *ahci;
     ram_addr_t lowmem;
     DriveInfo *hd[MAX_SATA_PORTS];
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -292,16 +291,18 @@ static void pc_q35_init(MachineState *machine)
                          0xff0104);
 
     if (pcms->sata_enabled) {
+        PCIDevice *pdev;
+
         /* ahci and SATA device, for q35 1 ahci controller is built-in */
-        ahci = pci_create_simple_multifunction(host_bus,
+        pdev = pci_create_simple_multifunction(host_bus,
                                                PCI_DEVFN(ICH9_SATA1_DEV,
                                                          ICH9_SATA1_FUNC),
                                                "ich9-ahci");
-        idebus[0] = qdev_get_child_bus(DEVICE(ahci), "ide.0");
-        idebus[1] = qdev_get_child_bus(DEVICE(ahci), "ide.1");
-        g_assert(MAX_SATA_PORTS == ahci_get_num_ports(ahci));
-        ide_drive_get(hd, ahci_get_num_ports(ahci));
-        ahci_ide_create_devs(ahci, hd);
+        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
+        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
+        g_assert(MAX_SATA_PORTS == ahci_get_num_ports(pdev));
+        ide_drive_get(hd, ahci_get_num_ports(pdev));
+        ahci_ide_create_devs(pdev, hd);
     } else {
         idebus[0] = idebus[1] = NULL;
     }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index cbcefdd693..0ec0b98066 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -677,7 +677,7 @@ static void boston_mach_init(MachineState *machine)
     MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem = get_system_memory();
     XilinxPCIEHost *pcie2;
-    PCIDevice *ahci;
+    PCIDevice *pdev;
     DriveInfo *hd[6];
     Chardev *chr;
     int fw_size, fit_err;
@@ -769,11 +769,11 @@ static void boston_mach_init(MachineState *machine)
     qemu_chr_fe_set_handlers(&s->lcd_display, NULL, NULL,
                              boston_lcd_event, NULL, s, NULL, true);
 
-    ahci = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
+    pdev = pci_create_simple_multifunction(&PCI_BRIDGE(&pcie2->root)->sec_bus,
                                            PCI_DEVFN(0, 0), TYPE_ICH9_AHCI);
-    g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(ahci));
-    ide_drive_get(hd, ahci_get_num_ports(ahci));
-    ahci_ide_create_devs(ahci, hd);
+    g_assert(ARRAY_SIZE(hd) == ahci_get_num_ports(pdev));
+    ide_drive_get(hd, ahci_get_num_ports(pdev));
+    ahci_ide_create_devs(pdev, hd);
 
     if (machine->firmware) {
         fw_size = load_image_targphys(machine->firmware,
-- 
2.41.0


