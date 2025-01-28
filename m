Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895FBC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 16:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcoF4-0005Op-BS; Tue, 28 Jan 2025 11:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoF0-0005M3-EQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:06 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tcoEw-0002dQ-QH
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 11:15:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BC6F95C6079;
 Tue, 28 Jan 2025 16:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DC9C4CEE3;
 Tue, 28 Jan 2025 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738080901;
 bh=hxMo1FNFoD+U6gmbbuqjqjojNvNGpUQwcalZq5WZRdw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Byzi0xFoteeeECHNhMe4G7zygIdV93yBXAO6YM+sX0DoM2hB6pfbh7dQ4pqDKh6mh
 TaN7wvdJYJ0FY/BcnurvkIUcf0MQaPNPEGxw/C3Gb6WWjvCDc/yTjrDL1456rZ6tke
 /kzmDez+qaKT3R8E/gNRE74/bcD0Ky5p8rfj8INzSSSgSBU9LGSBZOnSavHJTOMs7J
 B1mimF+l5xyxV+bN1UhlX2uipv2q6L713VMJeGXfCP7GnQRtdnalsqB4Lig9W1eIha
 Wc+KBtaKJMhQK4+rPtx5MXOwxqksd7jR/VhCykIEriyZBMubgvdKWR1+wCm9o7Fkcz
 T4qdtsh8maA9Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 5/5] hw/hppa: Wire up Diva GSP card
Date: Tue, 28 Jan 2025 17:14:50 +0100
Message-ID: <20250128161450.12975-6-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250128161450.12975-1-deller@kernel.org>
References: <20250128161450.12975-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

Until now we used a standard serial-pci device to emulate a HP serial
console.  This worked nicely with 32-bit Linux and 32-bit HP-UX, but
64-bit HP-UX crashes with it and expects either a Diva GSP card, or a real
64-bit capable PCI graphic card (which we don't have yet).
In order to continue with 64-bit HP-UX, switch over to the recently
added Diva GSP card emulation.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/Kconfig   |  1 +
 hw/hppa/machine.c | 24 ++++++------------------
 2 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 9312c4294a..cab21045de 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -11,6 +11,7 @@ config HPPA_B160L
     select LASI
     select SERIAL_MM
     select SERIAL_PCI
+    select DIVA_GSP
     select ISA_BUS
     select I8259
     select IDE_CMD646
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d5de793b62..1155d9aba9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -383,28 +383,16 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     pci_init_nic_devices(pci_bus, mc->default_nic);
 
-    /* BMC board: HP Powerbar SP2 Diva (with console only) */
-    pci_dev = pci_new(-1, "pci-serial");
+    /* BMC board: HP Diva GSP */
+    pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-serial");
     if (!lasi_dev) {
         /* bind default keyboard/serial to Diva card */
-        qdev_prop_set_chr(DEVICE(pci_dev), "chardev", serial_hd(0));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
+        qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
     }
-    qdev_prop_set_uint8(DEVICE(pci_dev), "prog_if", 0);
     pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
-    pci_config_set_vendor_id(pci_dev->config, PCI_VENDOR_ID_HP);
-    pci_config_set_device_id(pci_dev->config, 0x1048);
-    pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_VENDOR_ID], PCI_VENDOR_ID_HP);
-    pci_set_word(&pci_dev->config[PCI_SUBSYSTEM_ID], 0x1227); /* Powerbar */
-
-    /* create a second serial PCI card when running Astro */
-    if (serial_hd(1) && !lasi_dev) {
-        pci_dev = pci_new(-1, "pci-serial-4x");
-        qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(1));
-        qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(2));
-        qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(3));
-        qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(4));
-        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
-    }
 
     /* create USB OHCI controller for USB keyboard & mouse on Astro machines */
     if (!lasi_dev && machine->enable_graphics && defaults_enabled()) {
-- 
2.47.0


