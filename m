Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5E8E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6JY-0002tX-HU; Sun, 12 Jan 2025 17:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6It-0001a3-5T
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ir-0006Xm-9c
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:30 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3862d161947so1872219f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720367; x=1737325167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OAhYKzZLI8lTOKGbMAAzPTEW29D2+vTIYkkz2t6RXA=;
 b=N9TWEKQ5OLf4BHLDsx7zWwTtQSGqAMhAGaVDlKJmJh5SVRH5Lfbypn1Fi3mhWK3Bnz
 2k7vqFwmAP14gQnNNFeNtxKGLLzSQ5lpabaAdtcH4WtzyJnKq7N83faCuxYWLCgA/dwh
 M54EHDgmZ2NIWReuqci0Rk4Me9jvrWBAmB5iyX+x89NZB2OLGQ9xqzUooEqA2vFUM6j8
 jYkGgCGvtCyIjX5MbU7rACZy6r9KxSQQY1o6kiAtCe/DbILQx3+3EtTYM1V2f0Yjaosd
 FNqtdYEAHhqrTtqCMm4tzUZkfqYdmZpHTG4LTPhwkY6cdeqWlWin8i6BIXEaJ/tAzGq+
 C0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720367; x=1737325167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OAhYKzZLI8lTOKGbMAAzPTEW29D2+vTIYkkz2t6RXA=;
 b=mCFJHcT+UuDbYxK+ITs1XLqdI9HCRM1XX5x99ju45wpDWnqTVwES+Bdk4ezQGHmxJq
 azgqjXAnFOR9iJUth2xrpqGnwPoIVnX55AIoMIa9AzyVzfS87E/aK7s70qBupfXmswb5
 FnU7UqfyEHuKkEuaQ+J0AInn0xd4/RQVUY5e69vyo3qceQ7xqZWvnJL5PtTodJZA+o7P
 sccjEIWUwRc/HoX8HuhsyXuS/XlkO7Lds/8eA2ifqZV7jnwY/bw1/IMj32MkNNAj9mr0
 EZCVJObKPV+hshXP+vp75W0ScIMf344NyjbVhQbJfSRRhndJ/dJUB+1V+ks6Vk7Zr3OJ
 AFcw==
X-Gm-Message-State: AOJu0YwpDAKTrzZIh42RSP6IzUxMBJ/Fs2vmQteo2Nqngh0gMMAiNXGr
 RZMA7w0i8et6Pvn7AcLmDJ177YoDc5tXN6ZFBq/O6WKflhXsK+fQLf3YgJVCGgebLH462G7h111
 EocM=
X-Gm-Gg: ASbGnctBJRgbZs/MPOV0sdpYxJBWKmXX3RMybPYOeoXMUyVTYtB2Q7AZW12cgSGPK07
 S57ijYVXlLVeIVZo7DymdY11lNi73AWeUbXRBrW+Nv5sD1k1KrIPypHG20Xnmc3eaE9F38Ut1FQ
 uRCUTt76b7AdC+/U5OfHsGAgh9P2K+rqP6OFori03r5mdu82Gqw5YNQJlPBMpOniPzPwDQ9MGtT
 M8+9IKY4L0C8Vc/k6wN2+vbPd23LAyupLaDCD/JqS3bVm1mG25ew0YcN10PShJrn0yDuUG+rp2S
 EXsnibG2B+AfIiH07Cb/x5MibFXRVnA=
X-Google-Smtp-Source: AGHT+IFZiGBs44f8nLvtKQVET2Rkfu2rxvtSpaiHWs0Z0gNZfRZX7Zk8pW1ec4o8N4HUW9FoZRSbBA==
X-Received: by 2002:a5d:59ab:0:b0:385:fa26:f0d8 with SMTP id
 ffacd0b85a97d-38a872f6af0mr15624682f8f.8.1736720367214; 
 Sun, 12 Jan 2025 14:19:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1dc6sm10636757f8f.96.2025.01.12.14.19.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/49] hw/pci: Rename has_power to enabled
Date: Sun, 12 Jan 2025 23:17:00 +0100
Message-ID: <20250112221726.30206-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The renamed state will not only represent powering state of PFs, but
also represent SR-IOV VF enablement in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250109-reuse-v19-1-f541e82ca5f7@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci.h        |  1 +
 include/hw/pci/pci_device.h |  2 +-
 hw/pci/pci.c                | 17 +++++++++++------
 hw/pci/pci_host.c           |  4 ++--
 4 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cefeb388bde..4002bbeebde 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -674,6 +674,7 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
+void pci_set_enabled(PCIDevice *pci_dev, bool state);
 void pci_set_power(PCIDevice *pci_dev, bool state);
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 16ea7f4c19b..add208edfab 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -57,7 +57,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool has_power;
+    bool enabled;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 78907527f2e..2afa423925c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1598,7 +1598,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->has_power) {
+        if (!d->enabled) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1686,7 +1686,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->has_power);
+                                   & PCI_COMMAND_MASTER) && d->enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2963,16 +2963,21 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
 
 void pci_set_power(PCIDevice *d, bool state)
 {
-    if (d->has_power == state) {
+    pci_set_enabled(d, state);
+}
+
+void pci_set_enabled(PCIDevice *d, bool state)
+{
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
index 4510890dfc1..80f91f409f9 100644
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
2.47.1


