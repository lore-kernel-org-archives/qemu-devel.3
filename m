Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C79CC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H3z-0001ot-7G; Tue, 07 May 2024 05:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3j-000179-8B
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:31 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3f-0000Fg-38
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073863; x=1746609863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s+nOrpXO8OE6Wr4hxMCU0cePNcEQQqzMxn80I0Fx34Q=;
 b=OsKUUoQ448SAJss4aXAtR1Fn2pw2UnBAqMiQumSCBXffYLtSipcfMjYI
 +DDJPEZuIM17euUibxANBv9nZ96EiGREJCCOKSPw3z40/X5Ocpel8FOY4
 qYrZE8wlT8jTfoGm9KCC9lYaOSVMGnHnSgGtMc5lph4W1HIzto8coXk1A
 QuhrFLpmCugeEGyontYKDCGsSqTU6Qg4fic7tSocDVhk7agML8UBB6oCs
 KBhymojW5U1EKtUkCIiPf2TgQ0TUEIm2w1ypz4PYWetGczBgDbTy9e811
 PuOYBg1JYhZd/s+gMB896NmOqs3SfQa3cf/j/JtXTywuyKZcKQdFrl5aT w==;
X-CSE-ConnectionGUID: r5AA5yuTQEStAqavHn0DGA==
X-CSE-MsgGUID: GasNKmcVRsCGymrkfHBIFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785357"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785357"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:24:17 -0700
X-CSE-ConnectionGUID: aCE3z1lnRl245xf1DVRbAA==
X-CSE-MsgGUID: zl3cWGWaQdKrXwCG/NNzfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553545"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:24:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 18/19] intel_iommu: Implement [set|unset]_iommu_device()
 callbacks
Date: Tue,  7 May 2024 17:20:42 +0800
Message-Id: <20240507092043.1172717-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Yi Liu <yi.l.liu@intel.com>

Implement [set|unset]_iommu_device() callbacks in Intel vIOMMU.
In set call, a new structure VTDHostIOMMUDevice which holds
a reference to HostIOMMUDevice is stored in hash table
indexed by PCI BDF.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  8 ++++
 include/hw/i386/intel_iommu.h  |  2 +
 hw/i386/intel_iommu.c          | 76 ++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

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
index 7d694b0813..2bbde41e45 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -293,6 +293,8 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
+    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
+
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 519063c8f8..747c988bc4 100644
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
@@ -3812,6 +3819,70 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                     HostIOMMUDevice *hiod, Error **errp)
+{
+    IntelIOMMUState *s = opaque;
+    VTDHostIOMMUDevice *vtd_hdev;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+    struct vtd_as_key *new_key;
+
+    assert(hiod);
+
+    vtd_iommu_lock(s);
+
+    vtd_hdev = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
+
+    if (vtd_hdev) {
+        error_setg(errp, "IOMMUFD device already exist");
+        vtd_iommu_unlock(s);
+        return false;
+    }
+
+    vtd_hdev = g_malloc0(sizeof(VTDHostIOMMUDevice));
+    vtd_hdev->bus = bus;
+    vtd_hdev->devfn = (uint8_t)devfn;
+    vtd_hdev->iommu_state = s;
+    vtd_hdev->dev = hiod;
+
+    new_key = g_malloc(sizeof(*new_key));
+    new_key->bus = bus;
+    new_key->devfn = devfn;
+
+    object_ref(hiod);
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hdev);
+
+    vtd_iommu_unlock(s);
+
+    return true;
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
+    object_unref(vtd_hdev->dev);
+
+    vtd_iommu_unlock(s);
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4116,6 +4187,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .set_iommu_device = vtd_dev_set_iommu_device,
+    .unset_iommu_device = vtd_dev_unset_iommu_device,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
@@ -4235,6 +4308,9 @@ static void vtd_realize(DeviceState *dev, Error **errp)
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


