Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E83DC48BC4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 04:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbZFE-00027V-KN; Sat, 17 Feb 2024 23:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZFD-00025U-44
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:39 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbZFB-0004CH-J4
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 23:57:38 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d953fa3286so17638145ad.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 20:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708232256; x=1708837056;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Dt5tQ5uZ9hzL7haEhvwz3ceAUkLCui5MeuPY2TlXFo=;
 b=Of8Ny0VcT1axeJA3YuBx4XaXXOmHXdanUeBh3ScrtaJh5O95Gdd/FNahiBAQ0jdSgG
 hTD/MC/soM7STy5B2C0ION7bKQxoNdGWYdNXKeev+oYCpLK3QLs7X1mW5JmfC+fOiM1I
 9Nbdmtr48mNr7nlGUZ/f2eVM1MUkQTwdFifVh0s41NAodKK07se8I2KmsLqcRrXgG7F7
 ujf0pDQfKj9QEa7u8n7qvPB0+GwiG0kpbGLtutCbBC998ZIUS08rVmS60mMCL5zuxJZe
 qeRUPxuT4a/2Nltu+G0Ejw34wTmrwmf8ZKpGGrIdszkQWjpIQtcNXHTouxPT0yCdnxIg
 TwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708232256; x=1708837056;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Dt5tQ5uZ9hzL7haEhvwz3ceAUkLCui5MeuPY2TlXFo=;
 b=KZxUouxAUZWKV47sfgghvU/hCcD8dGW7++zbZ102V/LGtdFPz0F+2EXGTE0EZHTCKw
 wRSg2qxVwpE9iAYva1Nx5IHkS1fc4OdaIGRkCSTVLy3zrp7nBsOmaKh98bAN9g5PKGQ2
 bfwwLsa3EeQFLop2noEk7wX0MWyqbjLhSE+s5qxMHwamt6ZB160o3WHhouG723Jx1LpR
 Z08+fIwsJBrLGom7y0dk4LOzkXivs72fBMzv+BOKxtVILd6lcx0GlvL98m6ZwHp05pv2
 K8T7bNbQ22PcfxY0AI8dW7/YiOPQHjSo5YWWC7OKMHhcymtzwKtxFyzaupuxtiRc9aeH
 y4zQ==
X-Gm-Message-State: AOJu0Yxz5vm9hkTUXb5uzbdSFT07B4RsRRkyB+I3IDqq8K/QzYz8VfEB
 y/TzfKr1cEierL9TEgYVJvN1tBBbpC2IW2jKBKRx67U00g+e+nAqhevHH/x+bNE=
X-Google-Smtp-Source: AGHT+IGisP7XXa4Q8U7eP1yNs5FCsT80BSQeaYuw28dx8UXBBCSo09V4G+TIZMVVu1B2mznoXVCNiQ==
X-Received: by 2002:a17:903:2302:b0:1d9:b3ea:25ef with SMTP id
 d2-20020a170903230200b001d9b3ea25efmr12755220plh.10.1708232256336; 
 Sat, 17 Feb 2024 20:57:36 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 mi11-20020a170902fccb00b001da34166cd2sm2152542plb.180.2024.02.17.20.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 20:57:36 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 13:56:15 +0900
Subject: [PATCH v5 10/11] hw/pci: Rename has_power to enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-reuse-v5-10-e4fc1c19b5a9@daynix.com>
References: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
In-Reply-To: <20240218-reuse-v5-0-e4fc1c19b5a9@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The renamed state will not only represent powering state of PFs, but
also represent SR-IOV VF enablement in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci.h        |  7 ++++++-
 include/hw/pci/pci_device.h |  2 +-
 hw/pci/pci.c                | 14 +++++++-------
 hw/pci/pci_host.c           |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d884..6c92b2f70008 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -642,6 +642,11 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
-void pci_set_power(PCIDevice *pci_dev, bool state);
+void pci_set_enabled(PCIDevice *pci_dev, bool state);
+
+static inline void pci_set_power(PCIDevice *pci_dev, bool state)
+{
+    pci_set_enabled(pci_dev, state);
+}
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 54fa0676abf1..cde53065e4fe 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -56,7 +56,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool has_power;
+    bool enabled;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3d37ddbb101e..1543f284b255 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1525,7 +1525,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->has_power) {
+        if (!d->enabled) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->has_power);
+                                   & PCI_COMMAND_MASTER) && d->enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2811,18 +2811,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
     return msg;
 }
 
-void pci_set_power(PCIDevice *d, bool state)
+void pci_set_enabled(PCIDevice *d, bool state)
 {
-    if (d->has_power == state) {
+    if (d->enabled == state) {
         return;
     }
 
-    d->has_power = state;
+    d->enabled = state;
     pci_update_mappings(d);
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->has_power);
-    if (!d->has_power) {
+                               & PCI_COMMAND_MASTER) && d->enabled);
+    if (!d->enabled) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index dfe6fe618401..0d82727cc9dd 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->enabled || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 

-- 
2.43.1


