Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18429C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 05:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTE8W-0001Uz-Sp; Mon, 15 Jul 2024 01:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8S-0000re-0a
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:29 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTE8H-0007hA-RS
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 01:20:27 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3dab3b85623so963455b6e.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 22:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721020808; x=1721625608;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vdR/tAAVHxSpgFFmSFp64O9usJu3eSZIZ8gMew9CW0c=;
 b=yMKRNvO/412j2m4tgLw0ysuznne3+xzXMr6qAQeW//i2Shl9S3HP8sU1YUhVDillFq
 KjG50WagSWfUlR52ag7z1vtrVbeOIqA7iHfjaMy+Om95npM4HO76Si/0bVl1no8MGTl9
 mgtxYTW3q/cMfuFMR+6xn7E0/h33495JpxuSLgtwaCspmZCaC1kKwpQgv6TPeNeXKI1/
 M9cuXNJvvLoIY4zNo86lmDpUkyWKL1XUqf3x/J3QCGtvUFUbLA93emUEPvZ/mCQ1ZM5F
 5Glv+Y4SPCf9CBH/nKBxEnR+f/kL4RiTYtOphQitS7LTyzOXCYrTt4QX2klOqxghSWkS
 YdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721020808; x=1721625608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vdR/tAAVHxSpgFFmSFp64O9usJu3eSZIZ8gMew9CW0c=;
 b=YQEKzr7no+ulfNZscL5TyuKLvNCQpBbwdkJW7V9SYu3gIi06irFixEVGNJWw9Ba5sU
 YtsRdMDbBMYOiSKcSmQ/9sosHBZiGtOAkNdb6/cwRvskEBm+ecYtGyonMuJixMBV03/E
 xXMNzW8njZ85s6UKyL0j2tkpDBwLPyUxjMS5qqLMzQSZDwMViE6QkUYPZ0bxy8OkY/+m
 4gg2EvRYRo9bC8rtjdNSLL6MAjdxLN0J6Nf/xzf/OUwPuCs5lCvIHX3l0XdFB3N6UtZb
 t2x/tSjKUBLpRvfM3+fgDTPkM+0pZADHW6+XMiBCID9X+MreReRG91hoSVVXFJeQOXFE
 SFXw==
X-Gm-Message-State: AOJu0Ywx8mx9LbUK9sb1+A9y5SWXN3qQKEQarRtCHAq7X3cTfYxX6tKm
 qfWZtTzsjoxxj6koVIyLHpNTTRBBfNWpHCxNxIMpfEux0SyVE/R8HptZXgtZ8yw=
X-Google-Smtp-Source: AGHT+IGgO0GaQBGK1+McyNpKJeJkC+M8Gp1+szDrNR0E95izawSAiQ8dyXyho98fpVeSPKk3U4Qg3g==
X-Received: by 2002:a05:6808:23d6:b0:3da:b22d:a5ab with SMTP id
 5614622812f47-3dab22da976mr8228651b6e.49.1721020808213; 
 Sun, 14 Jul 2024 22:20:08 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70b7ebb6adesm3407865b3a.73.2024.07.14.22.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 22:20:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 15 Jul 2024 14:19:12 +0900
Subject: [PATCH v5 6/8] virtio-pci: Implement SR-IOV PF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-sriov-v5-6-3f5539093ffc@daynix.com>
References: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
In-Reply-To: <20240715-sriov-v5-0-3f5539093ffc@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::236;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Allow user to attach SR-IOV VF to a virtio-pci PF.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-pci.h |  1 +
 hw/virtio/virtio-pci.c         | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 9e67ba38c748..34539f2f6722 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -152,6 +152,7 @@ struct VirtIOPCIProxy {
     uint32_t modern_io_bar_idx;
     uint32_t modern_mem_bar_idx;
     int config_cap;
+    uint16_t last_pcie_cap_offset;
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9534730bba19..0c8fcc5627d5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1955,6 +1955,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     uint8_t *config;
     uint32_t size;
     VirtIODevice *vdev = virtio_bus_get_device(bus);
+    int16_t res;
 
     /*
      * Virtio capabilities present without
@@ -2100,6 +2101,14 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
                          PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
     }
+
+    res = pcie_sriov_pf_init_from_user_created_vfs(&proxy->pci_dev,
+                                                   proxy->last_pcie_cap_offset,
+                                                   errp);
+    if (res > 0) {
+        proxy->last_pcie_cap_offset += res;
+        virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+    }
 }
 
 static void virtio_pci_device_unplugged(DeviceState *d)
@@ -2187,7 +2196,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     if (pcie_port && pci_is_express(pci_dev)) {
         int pos;
-        uint16_t last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
+        proxy->last_pcie_cap_offset = PCI_CONFIG_SPACE_SIZE;
 
         pos = pcie_endpoint_cap_init(pci_dev, 0);
         assert(pos > 0);
@@ -2207,9 +2216,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
 
         if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
-            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
+            pcie_aer_init(pci_dev, PCI_ERR_VER, proxy->last_pcie_cap_offset,
                           PCI_ERR_SIZEOF, NULL);
-            last_pcie_cap_offset += PCI_ERR_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_ERR_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
@@ -2234,9 +2243,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_ATS) {
-            pcie_ats_init(pci_dev, last_pcie_cap_offset,
+            pcie_ats_init(pci_dev, proxy->last_pcie_cap_offset,
                           proxy->flags & VIRTIO_PCI_FLAG_ATS_PAGE_ALIGNED);
-            last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
+            proxy->last_pcie_cap_offset += PCI_EXT_CAP_ATS_SIZEOF;
         }
 
         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_FLR) {
@@ -2263,6 +2272,7 @@ static void virtio_pci_exit(PCIDevice *pci_dev)
     bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
                      !pci_bus_is_root(pci_get_bus(pci_dev));
 
+    pcie_sriov_pf_exit(&proxy->pci_dev);
     msix_uninit_exclusive_bar(pci_dev);
     if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
         pci_is_express(pci_dev)) {

-- 
2.45.2


