Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFFAC02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLmI-0001bs-V9; Thu, 16 Jan 2025 04:03:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLls-0001A6-3G
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:02:38 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLlq-0001B2-AP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:02:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166651f752so14242205ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018153; x=1737622953;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MAYWRA4k5M2a6lmqQx36KtShZ/BD3zY1mKtMdDpzcF0=;
 b=qX35vPBd87t1SM6cGZkmvm0hplgRTdR1WI7q/PB9h/EoVcY+Ksl3yv1cOtoyMKCDUB
 WnUiXCZ4YV4eSIcL4rSFBpI0D+ymt5d68W+YJ+hT06jzA+3V6JFdsAdkMai3N6NSaoPW
 eNy2pfqBW9GpS2V+6ZjfG6/c/wBvFnRl11y+Pt1riDrtvHSy1PLXkt9t/42wKdndm9Tu
 GPPILGUaRpE832gVPNTD5oEjWA5zE638vb3+AuL9uORa3Gb3Vx4PFE1AgrmSJ/39FH2w
 8mUkpJSK7dSqi3IJ5kA9ns4YwZ90z6JZr2J1enM8ljL1e8FlIS1454wpqw0Y5wGzxsuK
 rSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018153; x=1737622953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAYWRA4k5M2a6lmqQx36KtShZ/BD3zY1mKtMdDpzcF0=;
 b=kNPX01btQF+LHeTnQjDReLi5mMkHUH8zap+mIu6ZLG896Kc25x8ah9gvoarKnvF6Ya
 tkoG664ZACKlvHjPDK44XBvD4TUkY8nUevWX/89/o4qtVKzT+8fXX34NvpO7TqjBgZHj
 KRaIVX9y023IUNBA4PqfKFQY6Od23W30rKYx9LHnQI9pJxEtTvs/NZwQdT4cuObfIVgb
 GkWRu5vbHMe8yRycbyH0E2cT/z2GDB/t3rBfb/1WmluIqpUJ5fwJG50Zhjct6MtCsxYy
 JTXDjgdrp2loI2L1KnIdoECjlLay1Qyf/W3S9cZuzkLXXQDIaH38HYWhgRhSxg3rSTkE
 YD0A==
X-Gm-Message-State: AOJu0YwsjjPFIjqzgtPxqYS2ci9YVqf5Dwf2uTTaJru+OIA2Hp3SBNfx
 o9s7fQQvkFeEv5rqOiCWHaC7rAnUUVA2nurikyBTG6Cyk3nWlZWADlp6+26uLXg=
X-Gm-Gg: ASbGncv/htZQgB9rhece5dkyIEjEsHSIOEFDaOhKrPcvXokJpLeyfvxrO1D9Dow9IUj
 ZaIBEtCB+as1xhlX+duQ8nVQoxPlA2TLZihd0jwqqZ9rcWC3/p4ahJSXySDYBNp3Sy6ZMmBEpvl
 0ChilLTgU4K7LJVt1LAWk/d7jlfkjDIH2XCqwcXVftiojH8zLgXalef5NZBQoHU2VT956KAPlXk
 kCG3EQeGMWyBTwM+aMvVaJcLGPTUYF/k8JiSJPm4oiJPWTEzoFxqXP68X4=
X-Google-Smtp-Source: AGHT+IGfj7jW4zsoeU/YZFyxPUdDFPFy5oHO3Czvd7kpx+jo5mBwNYg85OqQu7Cflwcdx/CLdmC2VA==
X-Received: by 2002:a17:902:d4c4:b0:216:4016:5aea with SMTP id
 d9443c01a7336-21a83f71202mr497708635ad.29.1737018152922; 
 Thu, 16 Jan 2025 01:02:32 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-21bc9411d96sm39724965ad.119.2025.01.16.01.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:02:32 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:01:02 +0900
Subject: [PATCH v20 11/11] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-11-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77dd1..c5d2d318d330 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
+void pcie_sriov_pf_post_load(PCIDevice *dev);
+
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3e29b30d5588..69a1b8c298fc 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -803,10 +803,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
+static int pci_post_load(void *opaque, int version_id)
+{
+    pcie_sriov_pf_post_load(opaque);
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 69609c112e31..1eb4358256de 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -248,6 +248,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
+void pcie_sriov_pf_post_load(PCIDevice *dev)
+{
+    if (dev->exp.sriov_cap) {
+        register_vfs(dev);
+    }
+}
+
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)

-- 
2.47.1


