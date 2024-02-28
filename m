Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE58C54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 09:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfGWe-0005Ec-Il; Wed, 28 Feb 2024 04:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWa-0005AW-QC
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:46:53 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rfGWX-00029q-9d
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 04:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709113609; x=1740649609;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jLiQvP98+mmxdOUEX7dj0HvLoYoLYvqDA5bLEgUKsYs=;
 b=QaSr0nFB9Rf+2GSpAYVdismkJsK3FgexCkit7DMmolin6V503gwDZUZ4
 GR5Wbcuy0R9qyb+PpyYwWqZoitGBPK9D+LYQ1oh0j+rl5sKEc0L1M/Z/e
 SrhusfR/HCTdFHShM/OohW+Ijiw/vZMWyj7V2iF1Evi1R1tYTPiNbtmdO
 8TI76MkweJW5N72LYe0CWKo3Bl0NSGVWWpB30CDFTT0yPdaSMa6UdKrWw
 BLOYhewXvzQj0K1lo3f6+guUr48cz3wqPSWtzBZ7ZZuv0T+Rhzd3qs4VC
 qoyK/4Q8Ma4huFi4A9rv6LEAuUYE0IdqbcB+T1YVeqil/ZDxOtfXeAawx Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25969964"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; d="scan'208";a="25969964"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7809944"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 01:46:43 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 1/6] intel_iommu: Add set/unset_iommu_device callback
Date: Wed, 28 Feb 2024 17:44:27 +0800
Message-Id: <20240228094432.1092748-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yi Liu <yi.l.liu@intel.com>

This adds set/unset_iommu_device() implementation in Intel vIOMMU.
In set call, a pointer to host IOMMU device info is stored in hash
table indexed by PCI BDF.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  8 ++++
 include/hw/i386/intel_iommu.h  |  2 +
 hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index f8cf99bddf..becafd03c1 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -537,4 +537,12 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SL_IGN_COM              0xbff0000000000000ULL
 #define VTD_SL_TM                   (1ULL << 62)
 
+
+typedef struct VTDHostIOMMUDevice {
+    IntelIOMMUState *iommu_state;
+    PCIBus *bus;
+    uint8_t devfn;
+    HostIOMMUDevice *dev;
+    QLIST_ENTRY(VTDHostIOMMUDevice) next;
+} VTDHostIOMMUDevice;
 #endif
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c8..bbc7b96add 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -292,6 +292,8 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
+    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
+
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1a07faddb4..9b62441439 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1, gconstpointer v2)
            (key1->pasid == key2->pasid);
 }
 
+static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct vtd_as_key *key1 = v1;
+    const struct vtd_as_key *key2 = v2;
+
+    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
+}
 /*
  * Note that we use pointer to PCIBus as the key, so hashing/shifting
  * based on the pointer value is intended. Note that we deal with
@@ -3812,6 +3819,68 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                    HostIOMMUDevice *base_dev, Error **errp)
+{
+    IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hdev;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+    struct vtd_as_key *new_key;
+
+    assert(base_dev);
+
+    vtd_iommu_lock(s);
+
+    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+
+    if (vtd_hdev) {
+        error_setg(errp, "IOMMUFD device already exist");
+        vtd_iommu_unlock(s);
+        return -EEXIST;
+    }
+
+    vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
+    vtd_hdev->bus = bus;
+    vtd_hdev->devfn = (uint8_t)devfn;
+    vtd_hdev->iommu_state = s;
+    vtd_hdev->dev = base_dev;
+
+    new_key = g_malloc(sizeof(*new_key));
+    new_key->bus = bus;
+    new_key->devfn = devfn;
+
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hdev);
+
+    vtd_iommu_unlock(s);
+
+    return 0;
+}
+
+static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
+{
+    IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hdev;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    vtd_iommu_lock(s);
+
+    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+    if (!vtd_hdev) {
+        vtd_iommu_unlock(s);
+        return;
+    }
+
+    g_hash_table_remove(s->vtd_host_iommu_dev, &key);
+
+    vtd_iommu_unlock(s);
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4107,6 +4176,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .set_iommu_device = vtd_dev_set_iommu_device,
+    .unset_iommu_device = vtd_dev_unset_iommu_device,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
@@ -4230,6 +4301,9 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
                                       g_free, g_free);
+    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_as_hash,
+                                                  vtd_as_idev_equal,
+                                                  g_free, g_free);
     vtd_init(s);
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
-- 
2.34.1


