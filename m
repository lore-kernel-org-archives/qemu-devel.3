Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81493E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 06:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVm4l-0001Yu-HT; Thu, 09 Jan 2025 01:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4e-0001IN-AO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:22 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tVm4c-0003nC-4E
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 01:31:19 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so29751045ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736404277; x=1737009077;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tVUFPRDHvqP7JQ+45M1Y6g8qd6BS4GFtpJlj8oKyVfs=;
 b=wPh4+QlO0ZKNKLhqSyAbnqOwi0J4HEJpQ4mCdPsVYIujWe49kbhsHwpj6UzTiOvK/V
 FdKpuqa0zBfMCcnO5edT3QzZLBpEUZkeHfFlEUwrc3/s+uUpHLOLwfCfSnKKGvBdtEx2
 Ttdhdk0jH9UcOBgTXvtoNbdo3r1MvJ3yEXDPLM3mcW09oKUsf3pf69CmycB7U5wwEe+R
 nH9Oq9NUEgziulXIHH3i+cPW27NfI7NyTnVpvWXSuqfCICKJrmu7l8p/CxBSa379LYlc
 mlz2srYaEh15y1uWGATQVxDLXdD3vZD15E9xxESd39d1qz9UjbUeN3/+xCe9+ZgPw202
 bU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736404277; x=1737009077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVUFPRDHvqP7JQ+45M1Y6g8qd6BS4GFtpJlj8oKyVfs=;
 b=HkVemSMDB1he/g3zs3eLfjPxpgWzaW9TPpazBbKbngVxkNECrs2mjx7Ht5m77230Gf
 vkXNy98ntfv5ii6FxRuwI+On33oHRteBJ+ZlomqRb5SalakT7qpx1mFV0JZAtNBljZ8F
 +caHB3dsadzCbWhkZ6q2VeKsp8SKIYMHjIxQzUMkK1SHAJvfaPZ+qGIyX+axD+nY1/Fa
 2ro9Lgu4ghSRsqSyEK21cfQUzCWEk/SCbKU8YWs8KnYQ91uceU8wGnC+ztQgHMrwRkHI
 jIX4gOfIgiOdlIOc0k8qpCfoM2W5n0vbM3yi5tMsgF+YsaCalTMCYiHxS+mO/B36TszP
 IuBw==
X-Gm-Message-State: AOJu0YxjF+wDJs89lpq3vHmCBxxMaOSc9emG6KFgURgNbwoIR4rtwIkd
 ACrvoMrU+71EINBq76nTvucVUkWMntCSvwXv1G9Bl3Losh4yC14sS/ZisfCMKks=
X-Gm-Gg: ASbGnctMBGNEDMXeups8UPoz34t+DnCtHtHym60vOd4o+JgNbcooHNAxsmgtXkhaJ+e
 jerIm+wlfGTwQZ+Ip4JlRMOPhYs6QQvw0EdyEvW8qCTdPxch8USLJQfVC6cQhnfxILn7ggABRxq
 46zlBp8l8RhPLklHjAP3sF5uxUkCMpg7/tWvPuOEKp/IRu5ABcVdCKegpIAGKLRjZlqJOtbp+rY
 WQJKTfjVruFkygdlAzfyNzPS/Fp/SxqhlZ2hLJti631eRcPItRtEQBprV0=
X-Google-Smtp-Source: AGHT+IG4pyWJnZxl3qv8Z7LJORH1XkWO2wzG/6rNs16dAhySV9l8AgPMvq5FMK1BYgXoZYaAQhlksQ==
X-Received: by 2002:a05:6a00:66cb:b0:72a:83ec:b1cb with SMTP id
 d2e1a72fcca58-72d3021368emr3302564b3a.0.1736404276741; 
 Wed, 08 Jan 2025 22:31:16 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72aad8dbba0sm37579074b3a.107.2025.01.08.22.31.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 22:31:16 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 09 Jan 2025 15:29:54 +0900
Subject: [PATCH v19 09/14] pcie_sriov: Reuse SR-IOV VF device instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-reuse-v19-9-f541e82ca5f7@daynix.com>
References: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
In-Reply-To: <20250109-reuse-v19-0-f541e82ca5f7@daynix.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Disable SR-IOV VF devices by reusing code to power down PCI devices
instead of removing them when the guest requests to disable VFs. This
allows to realize devices and report VF realization errors at PF
realization time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pci.c                | 14 ++++++-
 hw/pci/pcie_sriov.c         | 94 +++++++++++++++++++--------------------------
 3 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aa704e8f9d9f..70649236c18a 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,7 +18,6 @@
 typedef struct PCIESriovPF {
     uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
-    const char *vfname; /* Reference to the device type used for the VFs */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 } PCIESriovPF;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 577ea0ea5eae..c02562e6063f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2963,7 +2963,17 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
 
 void pci_set_power(PCIDevice *d, bool state)
 {
-    pci_set_enabled(d, state);
+    /*
+     * Don't change the enabled state of VFs when powering on/off the device.
+     *
+     * When powering on, VFs must not be enabled immediately but they must
+     * wait until the guest configures SR-IOV.
+     * When powering off, their corresponding PFs will be reset and disable
+     * VFs.
+     */
+    if (!pci_is_vf(d)) {
+        pci_set_enabled(d, state);
+    }
 }
 
 void pci_set_enabled(PCIDevice *d, bool state)
@@ -2977,7 +2987,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
                                & PCI_COMMAND_MASTER) && d->enabled);
-    if (!d->enabled) {
+    if (d->qdev.realized) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 91c64c988eb4..f1993bc553c0 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,9 +20,16 @@
 #include "qapi/error.h"
 #include "trace.h"
 
-static PCIDevice *register_vf(PCIDevice *pf, int devfn,
-                              const char *name, uint16_t vf_num);
-static void unregister_vfs(PCIDevice *dev);
+static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
+{
+    for (uint16_t i = 0; i < total_vfs; i++) {
+        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
+        object_unparent(OBJECT(vf));
+        object_unref(OBJECT(vf));
+    }
+    g_free(dev->exp.sriov_pf.vf);
+    dev->exp.sriov_pf.vf = NULL;
+}
 
 bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
@@ -30,6 +37,7 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         uint16_t vf_offset, uint16_t vf_stride,
                         Error **errp)
 {
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
     int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
@@ -44,7 +52,6 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
     dev->exp.sriov_pf.num_vfs = 0;
-    dev->exp.sriov_pf.vfname = g_strdup(vfname);
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -78,14 +85,34 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
+    dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
+
+    for (uint16_t i = 0; i < total_vfs; i++) {
+        PCIDevice *vf = pci_new(devfn, vfname);
+        vf->exp.sriov_vf.pf = dev;
+        vf->exp.sriov_vf.vf_number = i;
+
+        if (!qdev_realize(&vf->qdev, bus, errp)) {
+            unparent_vfs(dev, i);
+            return false;
+        }
+
+        /* set vid/did according to sr/iov spec - they are not used */
+        pci_config_set_vendor_id(vf->config, 0xffff);
+        pci_config_set_device_id(vf->config, 0xffff);
+
+        dev->exp.sriov_pf.vf[i] = vf;
+        devfn += vf_stride;
+    }
+
     return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
-    unregister_vfs(dev);
-    g_free((char *)dev->exp.sriov_pf.vfname);
-    dev->exp.sriov_pf.vfname = NULL;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -151,38 +178,11 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
-static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
-                              uint16_t vf_num)
-{
-    PCIDevice *dev = pci_new(devfn, name);
-    dev->exp.sriov_vf.pf = pf;
-    dev->exp.sriov_vf.vf_number = vf_num;
-    PCIBus *bus = pci_get_bus(pf);
-    Error *local_err = NULL;
-
-    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return NULL;
-    }
-
-    /* set vid/did according to sr/iov spec - they are not used */
-    pci_config_set_vendor_id(dev->config, 0xffff);
-    pci_config_set_device_id(dev->config, 0xffff);
-
-    return dev;
-}
-
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
     uint16_t i;
     uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint16_t vf_offset =
-        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
-    uint16_t vf_stride =
-        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-    int32_t devfn = dev->devfn + vf_offset;
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
@@ -190,18 +190,10 @@ static void register_vfs(PCIDevice *dev)
         return;
     }
 
-    dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
-
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        dev->exp.sriov_pf.vf[i] = register_vf(dev, devfn,
-                                              dev->exp.sriov_pf.vfname, i);
-        if (!dev->exp.sriov_pf.vf[i]) {
-            num_vfs = i;
-            break;
-        }
-        devfn += vf_stride;
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
     dev->exp.sriov_pf.num_vfs = num_vfs;
 }
@@ -214,12 +206,8 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        object_unparent(OBJECT(vf));
-        object_unref(OBJECT(vf));
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    g_free(dev->exp.sriov_pf.vf);
-    dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
 }
 
@@ -241,14 +229,10 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              PCI_FUNC(dev->devfn), off, val, len);
 
     if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
-        if (dev->exp.sriov_pf.num_vfs) {
-            if (!(val & PCI_SRIOV_CTRL_VFE)) {
-                unregister_vfs(dev);
-            }
+        if (val & PCI_SRIOV_CTRL_VFE) {
+            register_vfs(dev);
         } else {
-            if (val & PCI_SRIOV_CTRL_VFE) {
-                register_vfs(dev);
-            }
+            unregister_vfs(dev);
         }
     }
 }

-- 
2.47.1


