Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CD1CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 14:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI6Vm-00028q-Nq; Sun, 09 Nov 2025 09:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vk-00028E-GL
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vI6Vi-0001mG-EU
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 09:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762698917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S4RPxn+BrMAAyfaECnJprzVKGlgFZx0NU1mbO1FNzso=;
 b=Y6HjARGB2qiYbaoVBR13YevUtT+5CkY7dNlpUbGXhKBs6PWVWhgkErrPKqDrh5Rb6kjK+z
 nFK7h9mD7dhz3tzSDe5grdbKE3zKVBPanz/lmpI+t2rYP7lrHUJG9mY0RqrjzRKKwlEazc
 AnLJcN782i1/rXHpwUgcMgSG6h8SJGM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-TEPwiV8MOhCm3dZ9hKL_Fg-1; Sun, 09 Nov 2025 09:35:16 -0500
X-MC-Unique: TEPwiV8MOhCm3dZ9hKL_Fg-1
X-Mimecast-MFC-AGG-ID: TEPwiV8MOhCm3dZ9hKL_Fg_1762698915
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4775e54a70aso22330125e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 06:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762698915; x=1763303715; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S4RPxn+BrMAAyfaECnJprzVKGlgFZx0NU1mbO1FNzso=;
 b=BxXsDuofmqstRccb3Zy0P7cywuWuMyB4rVyPvlhF7XKgp66yJMhg7b/Ia2/DUQ/UVz
 jRgb/XSbRGoz7/TdioXr62JdnyzPCrEbuUOpKR9Fi+wkf+EYsGmEb31ixvWCEirQ9ho3
 ZFSYca9lhJCuLs+IgG71x6IxATeMTZd2QQLIteHCgdgepa1KBaWZ04FB7LBRrHhEeTGj
 +80ObWuGx1UmkuxY82f8SmNxhKhf0wLFpqL/uxO6RnQI112nG8BwpIBFArd0/klKXhJD
 9eutSDK5GbYB8RZ0IkI3BphkJ4fgHudAsAGy0StYf0/wQFsJlL0gtFO9YDODwjZfIcWp
 1cvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762698915; x=1763303715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4RPxn+BrMAAyfaECnJprzVKGlgFZx0NU1mbO1FNzso=;
 b=KU1bAANQZNFkH5H5n7LJGtZm5mdKgIrVN3Q3RRKr0NdpS5JvnZY8Ugv8NlHCgAFBzT
 cX113FzzhYrPOZsAQpatzBvG3L95M9w+RAv3mKrzHfmIiz4+bmLVVJ6UNxLwHEgM7a7X
 1b/VIdNzQ7Swf3++w5JGWTdRjU6kOFSCnH9Z2FLjBKAEgquaH30qtLt309k1fv0yYfzk
 +T8ldGksUhLFrJWnYYFqGsJoZoLLvF024a4p38EWfLAMOmwPH80S6QdZZUKH7mniVt8Y
 k/uh20KuPClZUmbTrVGUK4bALbTwz3aLGpz5NGub9L95PhuvDQw8ajg3TydFe6eGQ7js
 OLnA==
X-Gm-Message-State: AOJu0YzxBhEIJkXbwS7m7qDzy1/MktNV+QXJ7RDMXAowO9BWAfs6WMPs
 DEu7N0M+ZF+CgDmzEuP7/DNPqpN2qCltoi5qn3gA1raaIG3ZHpoWXkvIhQkcXut6siC5x1alRqz
 Wr8LQBmvsMwALlQkdsPWiaJtSypo2JdVcIK2PnsXgTII/YyyrO+35UUq5H6FgJZrW34BOW8HQtU
 PqbXjr2AE9FKR2BNDKORH2n8rTHUdpOzzAPA==
X-Gm-Gg: ASbGncvNmp4Jm02njTBbw3IrN9D3E/l04LXvC8dRqIInlU5TqPKZnllYqFvYLUicTJL
 8bn7aVXNhQ+35Rdls70iTaakJeFJU27O3AwaYTTv8JafwEhDHPaTTQD9vbIK47P3AN0RoVG9JR/
 2C9lsy1sr1nepof5noVaQ/N7oz7wINU9P2v/vhLyxNsvmE93n2ZQ0WolSDQeHwJ/JCpiNZJvoDI
 vd4FdqQBQLwa+gZ/k4zL/UtGf2osUvHmyAodlIPtY/tBv2PyGf7mXGBIMKNrRgyHe0EgPgiUQFh
 C81xO/PPulsuyVvBKJu+KI2VssDF+EbmSHG7ePKXJyxw0wFTxLFpqKYmgbgw3WdTYp0=
X-Received: by 2002:a05:600c:1987:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47773290dcamr50103005e9.30.1762698914855; 
 Sun, 09 Nov 2025 06:35:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFumogiHNZKFZIdVCHqsXBUzsWfcc20UY1bCk26tCrWvtDbc1S3VjsmneaAOxOOi5njERyTLA==
X-Received: by 2002:a05:600c:1987:b0:477:1bb6:17de with SMTP id
 5b1f17b1804b1-47773290dcamr50102675e9.30.1762698914218; 
 Sun, 09 Nov 2025 06:35:14 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1536:2700:9203:49b4:a0d:b580])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47763e16db8sm87314415e9.1.2025.11.09.06.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 06:35:13 -0800 (PST)
Date: Sun, 9 Nov 2025 09:35:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Alexey Kardashevskiy <aik@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 02/14] amd_iommu: Fix handling of devices on buses != 0
Message-ID: <27d6a0ec0beec45c35a70cd5f12c4530725dda2a.1762698873.git.mst@redhat.com>
References: <cover.1762698873.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762698873.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

The AMD IOMMU is set up at boot time and uses PCI bus numbers + devfn for
indexing into the DTE. The problem is that before the guest starts, all PCI
bus numbers are 0 as no PCI discovery has happened yet (BIOS and/or kernel
will do that later), so relying on the bus number is wrong.
The immediate effect is that emulated devices cannot do DMA when placed on a
bus other than 0.

Replace the static address_space array with a hash table keyed by devfn and
PCIBus*, since these values do not change after the guest boots.

Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251103203209.645434-3-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.h |   2 +-
 hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++------------------
 2 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index daf82fc85f..38471b95d1 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -408,7 +408,7 @@ struct AMDVIState {
     bool mmio_enabled;
 
     /* for each served device */
-    AMDVIAddressSpace **address_spaces[PCI_BUS_MAX];
+    GHashTable *address_spaces;
 
     /* list of address spaces with registered notifiers */
     QLIST_HEAD(, AMDVIAddressSpace) amdvi_as_with_notifiers;
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 378e0cb55e..5c5cfd4989 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -59,7 +59,7 @@ const char *amdvi_mmio_high[] = {
 };
 
 struct AMDVIAddressSpace {
-    uint8_t bus_num;            /* bus number                           */
+    PCIBus *bus;                /* PCIBus (for bus number)              */
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
     MemoryRegion root;          /* AMDVI Root memory map region         */
@@ -101,6 +101,11 @@ typedef enum AMDVIFaultReason {
     AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
 } AMDVIFaultReason;
 
+typedef struct AMDVIAsKey {
+    PCIBus *bus;
+    uint8_t devfn;
+} AMDVIAsKey;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -382,6 +387,44 @@ static guint amdvi_uint64_hash(gconstpointer v)
     return (guint)*(const uint64_t *)v;
 }
 
+static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
+{
+    const AMDVIAsKey *key1 = v1;
+    const AMDVIAsKey *key2 = v2;
+
+    return key1->bus == key2->bus && key1->devfn == key2->devfn;
+}
+
+static guint amdvi_as_hash(gconstpointer v)
+{
+    const AMDVIAsKey *key = v;
+    guint bus = (guint)(uintptr_t)key->bus;
+
+    return (guint)(bus << 8 | (guint)key->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_as_lookup(AMDVIState *s, PCIBus *bus,
+                                          uint8_t devfn)
+{
+    const AMDVIAsKey key = { .bus = bus, .devfn = devfn };
+    return g_hash_table_lookup(s->address_spaces, &key);
+}
+
+static gboolean amdvi_find_as_by_devid(gpointer key, gpointer value,
+                                       gpointer user_data)
+{
+    const AMDVIAsKey *as = key;
+    const uint16_t *devidp = user_data;
+
+    return *devidp == PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
+}
+
+static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
+{
+    return g_hash_table_find(s->address_spaces,
+                             amdvi_find_as_by_devid, &devid);
+}
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
@@ -551,7 +594,7 @@ static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
 
 static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
 {
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIState *s = as->iommu_state;
 
     if (!amdvi_get_dte(s, devid, dte)) {
@@ -1011,25 +1054,15 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
  */
 static void amdvi_reset_address_translation_all(AMDVIState *s)
 {
-    AMDVIAddressSpace **iommu_as;
+    AMDVIAddressSpace *iommu_as;
+    GHashTableIter as_it;
 
-    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+    g_hash_table_iter_init(&as_it, s->address_spaces);
 
-        /* Nothing to do if there are no devices on the current bus */
-        if (!s->address_spaces[bus_num]) {
-            continue;
-        }
-        iommu_as = s->address_spaces[bus_num];
-
-        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
-
-            if (!iommu_as[devfn]) {
-                continue;
-            }
-            /* Use passthrough as default mode after reset */
-            iommu_as[devfn]->addr_translation = false;
-            amdvi_switch_address_space(iommu_as[devfn]);
-        }
+    while (g_hash_table_iter_next(&as_it, NULL, (void **)&iommu_as)) {
+        /* Use passthrough as default mode after reset */
+        iommu_as->addr_translation = false;
+        amdvi_switch_address_space(iommu_as);
     }
 }
 
@@ -1089,27 +1122,15 @@ static void enable_nodma_mode(AMDVIAddressSpace *as)
  */
 static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 {
-    uint8_t bus_num, devfn, dte_mode;
+    uint8_t dte_mode;
     AMDVIAddressSpace *as;
     uint64_t dte[4] = { 0 };
     int ret;
 
-    /*
-     * Convert the devid encoded in the command to a bus and devfn in
-     * order to retrieve the corresponding address space.
-     */
-    bus_num = PCI_BUS_NUM(devid);
-    devfn = devid & 0xff;
-
-    /*
-     * The main buffer of size (AMDVIAddressSpace *) * (PCI_BUS_MAX) has already
-     * been allocated within AMDVIState, but must be careful to not access
-     * unallocated devfn.
-     */
-    if (!s->address_spaces[bus_num] || !s->address_spaces[bus_num][devfn]) {
+    as = amdvi_get_as_by_devid(s, devid);
+    if (!as) {
         return;
     }
-    as = s->address_spaces[bus_num][devfn];
 
     ret = amdvi_as_to_dte(as, dte);
 
@@ -1783,7 +1804,7 @@ static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
                                bool is_write, IOMMUTLBEntry *ret)
 {
     AMDVIState *s = as->iommu_state;
-    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
+    uint16_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
     AMDVIIOTLBEntry *iotlb_entry = amdvi_iotlb_lookup(s, addr, devid);
     uint64_t entry[4];
     int dte_ret;
@@ -1858,7 +1879,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
     }
 
     amdvi_do_translate(as, addr, flag & IOMMU_WO, &ret);
-    trace_amdvi_translation_result(as->bus_num, PCI_SLOT(as->devfn),
+    trace_amdvi_translation_result(pci_bus_num(as->bus), PCI_SLOT(as->devfn),
             PCI_FUNC(as->devfn), addr, ret.translated_addr);
     return ret;
 }
@@ -2222,30 +2243,28 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 {
     char name[128];
     AMDVIState *s = opaque;
-    AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
-    int bus_num = pci_bus_num(bus);
+    AMDVIAddressSpace *amdvi_dev_as;
+    AMDVIAsKey *key;
 
-    iommu_as = s->address_spaces[bus_num];
+    amdvi_dev_as = amdvi_as_lookup(s, bus, devfn);
 
     /* allocate memory during the first run */
-    if (!iommu_as) {
-        iommu_as = g_new0(AMDVIAddressSpace *, PCI_DEVFN_MAX);
-        s->address_spaces[bus_num] = iommu_as;
-    }
-
-    /* set up AMD-Vi region */
-    if (!iommu_as[devfn]) {
+    if (!amdvi_dev_as) {
         snprintf(name, sizeof(name), "amd_iommu_devfn_%d", devfn);
 
-        iommu_as[devfn] = g_new0(AMDVIAddressSpace, 1);
-        iommu_as[devfn]->bus_num = (uint8_t)bus_num;
-        iommu_as[devfn]->devfn = (uint8_t)devfn;
-        iommu_as[devfn]->iommu_state = s;
-        iommu_as[devfn]->notifier_flags = IOMMU_NOTIFIER_NONE;
-        iommu_as[devfn]->iova_tree = iova_tree_new();
-        iommu_as[devfn]->addr_translation = false;
+        amdvi_dev_as = g_new0(AMDVIAddressSpace, 1);
+        key = g_new0(AMDVIAsKey, 1);
 
-        amdvi_dev_as = iommu_as[devfn];
+        amdvi_dev_as->bus = bus;
+        amdvi_dev_as->devfn = (uint8_t)devfn;
+        amdvi_dev_as->iommu_state = s;
+        amdvi_dev_as->notifier_flags = IOMMU_NOTIFIER_NONE;
+        amdvi_dev_as->iova_tree = iova_tree_new();
+        amdvi_dev_as->addr_translation = false;
+        key->bus = bus;
+        key->devfn = devfn;
+
+        g_hash_table_insert(s->address_spaces, key, amdvi_dev_as);
 
         /*
          * Memory region relationships looks like (Address range shows
@@ -2288,7 +2307,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
         amdvi_switch_address_space(amdvi_dev_as);
     }
-    return &iommu_as[devfn]->as;
+    return &amdvi_dev_as->as;
 }
 
 static const PCIIOMMUOps amdvi_iommu_ops = {
@@ -2329,7 +2348,7 @@ static int amdvi_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu,
     if (!s->dma_remap && (new & IOMMU_NOTIFIER_MAP)) {
         error_setg_errno(errp, ENOTSUP,
             "device %02x.%02x.%x requires dma-remap=1",
-            as->bus_num, PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
+            pci_bus_num(as->bus), PCI_SLOT(as->devfn), PCI_FUNC(as->devfn));
         return -ENOTSUP;
     }
 
@@ -2510,6 +2529,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
+    s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
+                                     amdvi_as_equal, g_free, g_free);
+
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
-- 
MST


