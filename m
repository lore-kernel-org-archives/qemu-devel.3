Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982B0C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS3r-0004uO-54; Fri, 21 Feb 2025 07:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3o-0004n8-6I
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS3k-00073V-Ce
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:23:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scidcpthAR0TJWBqQT5UtCSnzM8INobCgdjwksC9/UU=;
 b=Vqta7CRQNBe8tAHr/cpDGRM8ucK+ZNm+qZHH2xefINSaRPg2aFl/aezUhwUuIV2IRDztvm
 iDGATYRKdYonJTZvFaaF/weX/1JONAWek9NEkR7odplsaxAuXidCdMLxOy8ruzezIlHLem
 6NjdibkZvYHIdE04txrkG31lWx+vpC0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-cQoBxxyAMhWn7OY3fUR3Mg-1; Fri, 21 Feb 2025 07:23:10 -0500
X-MC-Unique: cQoBxxyAMhWn7OY3fUR3Mg-1
X-Mimecast-MFC-AGG-ID: cQoBxxyAMhWn7OY3fUR3Mg_1740140589
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f44be93a8so1064670f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140588; x=1740745388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scidcpthAR0TJWBqQT5UtCSnzM8INobCgdjwksC9/UU=;
 b=s84o6Q59iGbXS+1JIOk7Sxe0SLwsrK0metzD4ahT0nn6eKfZLzzW36/S81Erjgf2HP
 LUjdfgme4j4JhQOObwEU1BUhNMsZnrgwhqWlwToNqMiwVX6XNLr1tq2EuSogaFIdUU+q
 lueA053MAldjHuSucD1O1M5l+OumIuN+bKMYw3dnxISRQ/yZMKHv6csWuKgb3OcoCr/h
 qReKURHP4i7obby4eIaQlTEjseCtSvurxAQrkLyeTkWFH06jsuDv8ZSDzphCa9z91NWC
 c5GjOp1D+XP+I/dp9/7vuFalSknp3ZhltnFOPwuIxqpoy7p07T7UE3L3FEiikv1+wK1z
 SEUw==
X-Gm-Message-State: AOJu0YyeUMwL1aFGTAyfw/fKyOylDsIqaWghx/YVPiiw7bybUelVfBpt
 udHki5w/LslqsCsbMZiY/L8UcDN45OkkX/Tr3l/wjDxhCDxM4pgVdU19HYqr4YA0XdDEfhQXX8u
 8TlsvJsan18o2kZfP3wm7qrNAyzojlTFT5PuFFUOl3Rjysnn0WeiOAdZBn+ipaY7+Nw9s1fknxh
 46Ef/8asEeo/jaa9yXr2AFaABElzq64A==
X-Gm-Gg: ASbGncvMfd7GlAdXJs7jfuBIm2M284oHDKufjRxoX7OsQjKJ6FofovT8j5L7HH7qSd7
 vb2c60f2W3tqvnlco/mxQ7P3zT1ID0xOg8MVMB9VqDeJRe0p03CduDTsiCf0qXSGWL2Elm38xz7
 mSCAoVU8W0HeODykbjz+WXwn/0F6wPYAAAdGNWnDIqV9og/w3J18+BB1M+zdBnTBTJRAsv2AmaP
 6rsMUs6khKnhHCo25yhwAQt4qYqYRdtzoM9QFivrHpMJeYfl1TxtSIP2l/OC6Dn75TYOXx/iM4S
 bLdV2Q==
X-Received: by 2002:a05:6000:188f:b0:38f:277a:4eb6 with SMTP id
 ffacd0b85a97d-38f6e4bdf02mr2448572f8f.0.1740140588328; 
 Fri, 21 Feb 2025 04:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrrUOzSJRerlT4CS6/y5fUKc+0bJYhH2HuRNdPEOvZOIy5Ts+dLe4+wHX+zt1b4JWdCP/jCg==
X-Received: by 2002:a05:6000:188f:b0:38f:277a:4eb6 with SMTP id
 ffacd0b85a97d-38f6e4bdf02mr2448551f8f.0.1740140587847; 
 Fri, 21 Feb 2025 04:23:07 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44b2sm22963137f8f.20.2025.02.21.04.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:06 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 10/41] pcie_sriov: Reuse SR-IOV VF device instances
Message-ID: <cab1398a60eb0cb2d2d1998c9b46aaa5e0bf3ee8.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Disable SR-IOV VF devices by reusing code to power down PCI devices
instead of removing them when the guest requests to disable VFs. This
allows to realize devices and report VF realization errors at PF
realization time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-8-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h |  1 -
 hw/pci/pci.c                | 14 +++++-
 hw/pci/pcie_sriov.c         | 94 +++++++++++++++----------------------
 3 files changed, 51 insertions(+), 58 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index aa704e8f9d..70649236c1 100644
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
index 2afa423925..3e29b30d55 100644
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
+    if (qdev_is_realized(&d->qdev)) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 91c64c988e..f1993bc553 100644
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
MST


