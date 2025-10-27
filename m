Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D4CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLJm-00044h-ES; Mon, 27 Oct 2025 07:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDLJk-000440-JW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:23:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDLJf-00024W-PZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:23:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47117f92e32so40227475e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761564189; x=1762168989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=20+Pg1YzalxffzZimZzm5T6sHmYTccFzyLEmWL6cKds=;
 b=JH9fIK6LY/UzB6UMWuot1UIzBLebFXpUcfNDvcdWjr1OdAKdmxFnPJx/2ab6Tkzn8Z
 SmqN/tYb3cWadFXH3asbiCOBBXDqxvMFMdgeObYBpk93ojs+K38Yp0FXR+gyZ6SOI9VA
 8BWDEfG9ClmL66M+W0SZtPs9MzOxgLwZl+b85xPanHCteS8NN8feLbPynIpZ/ljval4A
 cgQtNEswmNQzqt9WDHF1oyqUydxXvau3K5XjBiWA7PLzf8W+aYUd7+GMK7ccllKE+rgF
 UhbMtbtxSno1NtG05q5g04ChVc7u7Yf7le6+y2h2EoNYWLQ3LeLPmTB2N5JAvUOJxHSY
 VHjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761564189; x=1762168989;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20+Pg1YzalxffzZimZzm5T6sHmYTccFzyLEmWL6cKds=;
 b=K3FOKmJ3v912hFqI9vnjGMKHd9gBkMaJxNebOkoLB4IB29Gu1RZK0RNwPqDOxiSKDS
 k3h/XoxvVtKuj7yaQ6qKtWoGUHh4mv8XXmYuOMDw3sZUWSzwlFxkcB45aYARo3BBWYwF
 y52IRBuIvd932WLAn2kyfTsbOEoKdFezkHyudOypi4r2+LL95WCzVXuF0HuqhodtM0MI
 gJlVCZGoYLIj2S3FJeugR1T0mMM884ao05LAulA9bo6to2Ev5kCyTIMv9BJXFkqrloVg
 N1trLnho3dxIKgOPCuipWgeVGNPLY7B2I9layuuYuVm9T2WmYChoAAHb3Dxhx4rUW62c
 Vl0w==
X-Gm-Message-State: AOJu0YyZ/0qoPQWCu9f4lpa39VmC36jRYIg3bK2b7HeXhzXhSxyUvvS6
 a5h6NJYcJY6k9iaaBzMPNg4x5THUFljNTWSvjwUEXmlkb4KBgJp9Djlaziv9/EaH3Kj03v46kD1
 dwBXGpvo=
X-Gm-Gg: ASbGncuyQBjq+0cNu+mTrdi/x9VPVuom6AWfx8wnxMzRlRUynefswJ/OkBm97Msk4nV
 QoHMaSxPeUsR6U5iiAR+ACn4orVhH7vPY1U+srkeRc+Bwt9eYMwabJUExVRf5O4hLWug5/Tdc+K
 oKuQNI073sV0A5iwYsUSm2GAUXFGpfbjs3KP2HzoDds9brmLSD1lRpGZoIiyEB7QeSFfpO6p7lN
 aWpYXd12VR7XIgejXbhvGuITmy8J5uRmICHNztjn4IruvYmTR6KsahbYdFfpKAp1BOAXRSjQs4O
 8wkyhsQ9Tuum0yIgOLfU7ooUkkrrbm+Beddj+KU8vIjTNwyHCd7XBjWhoVcvDztqfdw4bddTqm+
 fRTxBe+O7mXu6+RXZV4zmFrh1Q2ulf5w1EuXJ3cXGKw3ZFLhdHSLzxh1NGC5XcbWT8oGEZFd6up
 4Daf8tJD8wpCZqqZFbDmJ/eWjIkcHZTkq6hf+ckU4MgHHZQY3XHCi3HzE=
X-Google-Smtp-Source: AGHT+IHWmR02eS08AMVPvEe8tzAJju6AfX5hvsFq5n1hxn8GoCBPhvgjvfftJ1LlsoFexS08EWqrKQ==
X-Received: by 2002:a05:600c:450d:b0:475:dcbb:76b0 with SMTP id
 5b1f17b1804b1-475dcbb783dmr57834555e9.12.1761564188907; 
 Mon, 27 Oct 2025 04:23:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dcbe5587sm154973155e9.0.2025.10.27.04.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 04:23:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paul Burton <paulburton@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aditya Gupta <adityag@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH] hw/pci-host: Set DEVICE_CATEGORY_BRIDGE once in parent
 class_init()
Date: Mon, 27 Oct 2025 12:23:06 +0100
Message-ID: <20251027112306.57634-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

No need to set DEVICE_CATEGORY_BRIDGE for each device
implementing TYPE_PCI_HOST_BRIDGE: set it once in the
parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/articia.c     | 1 -
 hw/pci-host/aspeed_pcie.c | 1 -
 hw/pci-host/designware.c  | 3 ---
 hw/pci-host/gpex.c        | 2 --
 hw/pci-host/grackle.c     | 1 -
 hw/pci-host/gt64120.c     | 1 -
 hw/pci-host/mv64361.c     | 1 -
 hw/pci-host/pnv_phb.c     | 1 -
 hw/pci-host/ppce500.c     | 1 -
 hw/pci-host/q35.c         | 1 -
 hw/pci-host/raven.c       | 1 -
 hw/pci-host/remote.c      | 1 -
 hw/pci-host/sabre.c       | 1 -
 hw/pci-host/uninorth.c    | 4 ----
 hw/pci-host/xilinx-pcie.c | 2 --
 hw/pci/pci_host.c         | 1 +
 16 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/hw/pci-host/articia.c b/hw/pci-host/articia.c
index cc65aac2a87..47f223879f0 100644
--- a/hw/pci-host/articia.c
+++ b/hw/pci-host/articia.c
@@ -200,7 +200,6 @@ static void articia_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = articia_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 /* TYPE_ARTICIA_PCI_HOST */
diff --git a/hw/pci-host/aspeed_pcie.c b/hw/pci-host/aspeed_pcie.c
index f7593444fc4..2499d3fe680 100644
--- a/hw/pci-host/aspeed_pcie.c
+++ b/hw/pci-host/aspeed_pcie.c
@@ -312,7 +312,6 @@ static void aspeed_pcie_rc_class_init(ObjectClass *klass, const void *data)
     dc->desc = "ASPEED PCIe RC";
     dc->realize = aspeed_pcie_rc_realize;
     dc->fw_name = "pci";
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 
     hc->root_bus_path = aspeed_pcie_rc_root_bus_path;
     device_class_set_props(dc, aspeed_pcie_rc_props);
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f6e49ce9b8d..b0b51ad9517 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -593,8 +593,6 @@ static void designware_pcie_root_class_init(ObjectClass *klass,
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-
     k->vendor_id = PCI_VENDOR_ID_SYNOPSYS;
     k->device_id = 0xABCD;
     k->revision = 0;
@@ -736,7 +734,6 @@ static void designware_pcie_host_class_init(ObjectClass *klass,
 
     hc->root_bus_path = designware_pcie_host_root_bus_path;
     dc->realize = designware_pcie_host_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     dc->vmsd = &vmstate_designware_pcie_host;
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index b806a2286f7..5f809028be2 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -200,7 +200,6 @@ static void gpex_host_class_init(ObjectClass *klass, const void *data)
     hc->root_bus_path = gpex_host_root_bus_path;
     dc->realize = gpex_host_realize;
     dc->unrealize = gpex_host_unrealize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     device_class_set_props(dc, gpex_host_properties);
 }
@@ -242,7 +241,6 @@ static void gpex_root_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "QEMU generic PCIe host bridge";
     dc->vmsd = &vmstate_gpex_root;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index f9da5a908c1..fa872c17e3b 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -140,7 +140,6 @@ static void grackle_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = grackle_realize;
     device_class_set_props(dc, grackle_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = grackle_ofw_unit_address;
 }
diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index b1d96f62fe9..bffa1165580 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1298,7 +1298,6 @@ static void gt64120_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_props(dc, gt64120_properties);
     dc->realize = gt64120_realize;
     device_class_set_legacy_reset(dc, gt64120_reset);
diff --git a/hw/pci-host/mv64361.c b/hw/pci-host/mv64361.c
index e05b6770102..e5e6614b139 100644
--- a/hw/pci-host/mv64361.c
+++ b/hw/pci-host/mv64361.c
@@ -108,7 +108,6 @@ static void mv64361_pcihost_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = mv64361_pcihost_realize;
     device_class_set_props(dc, mv64361_pcihost_props);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo mv64361_pcihost_info = {
diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 4b0ced79b08..e07cf8a0d0f 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -202,7 +202,6 @@ static void pnv_phb_class_init(ObjectClass *klass, const void *data)
     hc->root_bus_path = pnv_phb_root_bus_path;
     dc->realize = pnv_phb_realize;
     device_class_set_props(dc, pnv_phb_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->user_creatable = true;
 }
 
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 975d191ccb8..edadc35384c 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -516,7 +516,6 @@ static void e500_pcihost_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = e500_pcihost_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     device_class_set_props(dc, pcihost_properties);
     dc->vmsd = &vmstate_ppce500_pci;
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1951ae440cc..c134679fa0c 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -194,7 +194,6 @@ static void q35_host_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, q35_host_props);
     /* Reason: needs to be wired up by pc_q35_init */
     dc->user_creatable = false;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index eacffc86d84..661a4223d69 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -365,7 +365,6 @@ static void raven_pcihost_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->realize = raven_pcihost_realizefn;
     dc->fw_name = "pci";
 }
diff --git a/hw/pci-host/remote.c b/hw/pci-host/remote.c
index e6d2af4502a..959beb5c301 100644
--- a/hw/pci-host/remote.c
+++ b/hw/pci-host/remote.c
@@ -55,7 +55,6 @@ static void remote_pcihost_class_init(ObjectClass *klass, const void *data)
     dc->realize = remote_pcihost_realize;
 
     dc->user_creatable = false;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
 }
 
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 538624c5079..f95e5db583a 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -505,7 +505,6 @@ static void sabre_class_init(ObjectClass *klass, const void *data)
     dc->realize = sabre_realize;
     device_class_set_legacy_reset(dc, sabre_reset);
     device_class_set_props(dc, sabre_properties);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = sabre_ofw_unit_address;
 }
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 194037d6e75..d337a2fd62c 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -435,7 +435,6 @@ static void pci_unin_main_class_init(ObjectClass *klass, const void *data)
 
     dc->realize = pci_unin_main_realize;
     device_class_set_props(dc, pci_unin_main_pci_host_props);
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     sbc->explicit_ofw_unit_address = pci_unin_main_ofw_unit_address;
 }
@@ -453,7 +452,6 @@ static void pci_u3_agp_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_u3_agp_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_u3_agp_info = {
@@ -469,7 +467,6 @@ static void pci_unin_agp_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_agp_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_unin_agp_info = {
@@ -485,7 +482,6 @@ static void pci_unin_internal_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = pci_unin_internal_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_unin_internal_info = {
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index c71492de9e7..1540533223c 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -172,7 +172,6 @@ static void xilinx_pcie_host_class_init(ObjectClass *klass, const void *data)
 
     hc->root_bus_path = xilinx_pcie_host_root_bus_path;
     dc->realize = xilinx_pcie_host_realize;
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     device_class_set_props(dc, xilinx_pcie_host_props);
 }
@@ -291,7 +290,6 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->desc = "Xilinx AXI-PCIe Host Bridge";
     k->vendor_id = PCI_VENDOR_ID_XILINX;
     k->device_id = 0x7021;
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 7179d99178b..b5c624e12e8 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -245,6 +245,7 @@ static void pci_host_class_init(ObjectClass *klass, const void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     device_class_set_props(dc, pci_host_properties_common);
     dc->vmsd = &vmstate_pcihost;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pci_host_type_info = {
-- 
2.51.0


