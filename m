Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC19E77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyxj-0000xt-JY; Sat, 04 Jan 2025 02:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxh-0000xa-JE
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:45 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxf-00032J-Tu
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:45 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so228857415ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977161; x=1736581961;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ncj//1fVtuyUfAw467C/f6+0z34Dui3jJ5cwfgaMUy4=;
 b=gI4l0QdJ+h+Cydd/RN0nPd5gtOziGp0rfqf6af3LxmjO/wAAJGeMfY8dGDqA219kID
 tHD82yw89/fsiUJ9MDpHiHcwY83u98zXGPPKWBVoDbQfj/ATjvnmlenpA9neieQaOFis
 O9Oym+fS74oXsfJJ29VaBu6yb4wToluU0cA10mwl3fvDN1ENtN7czBNAJxUJAvkc+wto
 WLbbpKiJ7ZVE6xMlG4ZvlsKMfPbDSohjjebgxn4h/F2ETWTfdXf8uX7luq12wC3Yv1Vi
 c1WrDbrkGc0i2pFA6l9mWrq26xwG0GnpaqS+YL1HMPkBdzrSkKhsP6bz2GPa8v7cBkoo
 3XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977161; x=1736581961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncj//1fVtuyUfAw467C/f6+0z34Dui3jJ5cwfgaMUy4=;
 b=kvm7PXsqacCkiC+uc8TIvEBdNxtqez4iTRfiTaKTCa1EMnvvqViPucSizJp72+HiWi
 3YG7gyJm2oJqC4WE9b2C3G+Mo2nO9e+cJfQHNHptNXri8xvD3q6JQ0nbCx62S2cIbaZh
 LzKb6LoBB+CKf8YYCDWNE2gnlgnx2nF4Fb8VmfJOgMO1WRbXMhj0rk1lu7+xYdzAGeLw
 vnOgDimVAW2poZLngFq6RcfYSXT4ULZtPDVqsDF5NYBLhKsCBArOkTS8xAfvGVts7Dq/
 A83Ye5eyusNaKKPJuGQtRDCWj1ORTGCIXM7lNXPC9l52abruO7ZkSPsuku897kn3HeJT
 uUUA==
X-Gm-Message-State: AOJu0YzNCmLi9v56FNlRbnBiidz+Ymkj+ClBNbcziBWDUJNGdPXRSdfg
 B6fsE07dfOtA8CylP51rJ1PrCYBtWnyO4QC40swIqgJjG8pQP67hFA3tsqyZbv8l1GNAfTeSyBB
 7b9o=
X-Gm-Gg: ASbGncuPl8l+2ryqCHBPS0A++pFeLTv5PYbne5JAqIGb/fUePvatD0UlsDr+fhl5Xnk
 mUbFZqCl+D0NyrwigC2k4tPQD0xaY1jEsbw+s4bzhfqrKcAkHBZUIqhe2u0th58vnVV6V5VV+cZ
 sDkAMBYVgIuV8z+x5tRMBqrbYHhmikdMYXpXnR/jaCD0dXi6vy73Vb4BgVAhEbu/R+9CAXHxNX6
 Bp5sREG/EfsGm+s8Y/M9sK+zRXzUTAj1ArY9BL/B06pMk6m4MEjgMCmhEzJ
X-Google-Smtp-Source: AGHT+IG9AaS3tZXXMgp0VNaHGy3p0ib8tNcw2vJqqu5oefyYAhLLB7wB0si3Z6SXSjaopg0kpU/PuQ==
X-Received: by 2002:a17:902:c406:b0:219:cdf1:a0b8 with SMTP id
 d9443c01a7336-219e6ebb28dmr767714575ad.30.1735977161511; 
 Fri, 03 Jan 2025 23:52:41 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc964a8bsm255139195ad.8.2025.01.03.23.52.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:52:41 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:21 +0900
Subject: [PATCH v18 01/14] hw/pci: Rename has_power to enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-1-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
index cefeb388bde5..c1e897f44143 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -674,6 +674,11 @@ static inline void pci_irq_deassert(PCIDevice *pci_dev)
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
index 8eaf0d58bb39..66b6c08b0118 100644
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
index b6c630c32368..e1563d738ce2 100644
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
@@ -2961,18 +2961,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
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
index 4510890dfc18..80f91f409f90 100644
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


