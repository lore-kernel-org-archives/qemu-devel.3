Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9088CC54E49
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 09:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdoHm-0006nJ-Oy; Sat, 24 Feb 2024 04:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHV-0006cF-8a
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:17 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rdoHT-0002fJ-Lb
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 04:25:16 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e4d869b019so900158b3a.0
 for <qemu-devel@nongnu.org>; Sat, 24 Feb 2024 01:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708766713; x=1709371513;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lyOTxnkcJD9Fch8p801dtN80LFjIP1Z0j9VlXnqzBNg=;
 b=JEMnsz86JVY5oljO/uhjXQq5Ziel+c4cJtIt+3MgvYQAFar3kOs/H5V9zWRNA3q6wT
 waXZ1anT+5ZeYw2feEQf24ul73RsFU2RohF4GQE2oYwYSfSWid48oPFohsigFnP4mm+0
 zBLXErq5n9TWZmtQhl2kAwvMFslVwcxm3Q9Uo3B8XyCO6Bamt9cODiY77VQmyEsjUCv9
 sLBjpIZJPLo5d7c3TiNdSBjeYGX46oDTTVuaZU3yiuWA36GNkJVk/dcWFak9hmdbOvPy
 RCQrBQJ2hPVW+zlJ18UJf5yAKjwggGfoLxctJ/qIvgFl0UKceg14xgxPzzkczfv7mAt5
 UTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708766713; x=1709371513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyOTxnkcJD9Fch8p801dtN80LFjIP1Z0j9VlXnqzBNg=;
 b=F2gxEn88B5bVaCRtVoCZ5/CWcN7FBoV1DXvZxuFBAWw47ADkZmGbuyPb2WpeRH13Dn
 2fC5ph2D09OKTlCe1rEoUh+DzXXfNwNKvWXjl04+JB/b0Oo1Ndr/bjFXqKS87ls/LSTH
 9Sci18IKplhQtYV5WWwDsQD7n0Hcn3RtHagnvammzOgsmqP+pL9JBTiJYtw4CHcJGPiw
 uChA4r04siRdoffDolgzDLUmkkicitDVRjmWiylnBaS5VwS6hkG2BHn7tH0kv5KD+ecz
 MgejQ9YJS4qY1/4t57VL9cXN08g1fO7rgxY8EX/xTGVmn0/jzX6AMWzzkT746B4LDIWr
 sI6w==
X-Gm-Message-State: AOJu0YxBncsWWIWEKIz24Y4IXLdDPqoRp75s70euUMSCwrfQ8pIvUAk8
 dA+cWXyq2F9IxlE4jBeCPqnEZmdLq07TFBiuXfm0Gz/YWnpt94poZX1DrjbPsdI=
X-Google-Smtp-Source: AGHT+IFttT2FH9cIR5qZgUxSuykGy9AZuOdSz5wAzYrcqQnSxLz3xnfFyJN/9JsCuQMJxA0WWjSlwg==
X-Received: by 2002:a05:6a00:320b:b0:6e4:f12c:c43e with SMTP id
 bm11-20020a056a00320b00b006e4f12cc43emr1708403pfb.24.1708766713274; 
 Sat, 24 Feb 2024 01:25:13 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 o26-20020a056a001b5a00b006e48e64ef54sm780246pfv.173.2024.02.24.01.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:25:13 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 24 Feb 2024 18:24:38 +0900
Subject: [PATCH v7 06/16] hw/pci: Rename has_power to enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-reuse-v7-6-29c14bcb952e@daynix.com>
References: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
In-Reply-To: <20240224-reuse-v7-0-29c14bcb952e@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
index d3dd0f64b273..d57f9ce83884 100644
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
index e7a39cb203ae..8bde13f7cd1e 100644
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
2.43.2


