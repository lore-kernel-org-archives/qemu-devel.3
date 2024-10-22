Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86790D1CDB8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 08:39:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3AOs-0003BJ-5M; Tue, 22 Oct 2024 04:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOq-00035g-9V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1t3AOm-0001Yr-Vi
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 04:37:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c7edf2872so47123665ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1729586271; x=1730191071;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pk1g4gV2BzUyvws2WL8XxncsfS565/ZULISdZhPPeLs=;
 b=e65kYhIao382HvwxS36NgDZmY2E2kBQwQpVQwE+ZMMfaxoQBxcFnDhKOrrlXLvfioa
 FQSnsikjtGGPXsIuZ9TuN/onAQ9GMbJwoEmNamxCokt1zOXZaLQUp2BAq2deikMIpctp
 4RUJ69CFKdmZZIo3PQEdZ8a6b4t3duus9JHhbBTFc2+mF/Pdn2ilRl+m7kLieNSNeZ2x
 KXbp/a0bvoljh8bz4Abvf/bF9iqyWSoeDvZZ5etecyqJn88zEOegRxzWy/oeaR48jy5l
 BH3Qw6cK5R53AWaFH74dPBWDJOZFKk/KpUN49SUcsaWAnrV0fmCMOBiVI5zWz0dQcRd6
 jYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729586271; x=1730191071;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pk1g4gV2BzUyvws2WL8XxncsfS565/ZULISdZhPPeLs=;
 b=XZqoQdLpOX+4liS8ifmeqj5+wg8pAXvW7175bK5qYpDDth/IHRNzDwYDsIQc7kLJpa
 TxBAsN4YbdzqCz2Ho//GkC/Ye8fC+S5Ce3ffjl7Nb2a6aOnHTMaV32jjcJNSFM9kMyOe
 Lh0MNPs1sncZh5r37vjtd2rXo5hpI2fHb9cBvi+HpFPrqiEmHJ/jhoSt34rZJys/gWd5
 N0He3QEKnbeyztOeTjYjbb2jpJ3mA82jZQQB1hPxQF2gyoiB3YpvZqF2oCcd/L/bhgWL
 y3VrrbQMvyO81uaR159jJ+EctEk9eJSWwCKqXDkUguAT7TfyDtxIn6Zkuj0dC9busH8V
 y1bg==
X-Gm-Message-State: AOJu0YzpEgkfOc4nvGk7emPI+gRpNyrdmF/BF6v2rWVIImSv2ADH/Ecl
 DDjg+2jBz6p2So7H0FaLzTD90Kh+CCOEAE7s5ZrgSS5LgtPmGej1EfWnGMjEH00=
X-Google-Smtp-Source: AGHT+IGGG9p7JOgKjjZVi6hB9iLFvbHRLwzW/C1/BLfv1i8v69bQKWSohk9g+YPypVWGgpn0fPULpQ==
X-Received: by 2002:a17:90b:3883:b0:2e2:c225:4729 with SMTP id
 98e67ed59e1d1-2e5db95655bmr3584348a91.8.1729586271313; 
 Tue, 22 Oct 2024 01:37:51 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-2e5ad25cb15sm5455522a91.11.2024.10.22.01.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 01:37:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 22 Oct 2024 17:36:46 +0900
Subject: [PATCH v17 09/14] pcie_sriov: Reuse SR-IOV VF device instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-reuse-v17-9-bd7c133237e4@daynix.com>
References: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
In-Reply-To: <20241022-reuse-v17-0-bd7c133237e4@daynix.com>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
 include/hw/pci/pci.h        |  5 ---
 include/hw/pci/pci_device.h | 15 ++++++++
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pci.c                |  2 +-
 hw/pci/pcie_sriov.c         | 94 +++++++++++++++++++--------------------------
 5 files changed, 55 insertions(+), 62 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fe04b4fafd04..14a869eeaa71 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -680,9 +680,4 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
 void pci_set_enabled(PCIDevice *pci_dev, bool state);
 
-static inline void pci_set_power(PCIDevice *pci_dev, bool state)
-{
-    pci_set_enabled(pci_dev, state);
-}
-
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index cbc42349d561..5dcabb94d679 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -215,6 +215,21 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline void pci_set_power(PCIDevice *pci_dev, bool state)
+{
+    /*
+     * Don't change the enabled state of VFs when powering on/off the device.
+     *
+     * When powering on, VFs must not be enabled immediately but they must
+     * wait until the guest configures SR-IOV.
+     * When powering off, their corresponding PFs will be reset and disable
+     * VFs.
+     */
+    if (!pci_is_vf(pci_dev)) {
+        pci_set_enabled(pci_dev, state);
+    }
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
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
index eff408b4e9f4..7ea751fb869d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2904,7 +2904,7 @@ void pci_set_enabled(PCIDevice *d, bool state)
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
2.47.0


