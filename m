Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DD4C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm6F-0002KM-3s; Wed, 05 Jun 2024 04:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm6D-0002Cm-G2
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:34:25 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm6B-00062T-Cv
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:34:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576464; x=1749112464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X0+qdCmK2YgF47jFM9lXNbvZxPVwxq5u44IuWT5KKUE=;
 b=AotFDgxshcelLNrChXIAQ2XKAFmMEnVP88yGAkfHhk9lNR+DWvKqQch8
 5Auhm+ypHlI/nf2QSEZ2OKoZ4M/kJaxETtxoEDRKfwWB95W7WL3+H6mpR
 SOMDXQIhbMCo4It2VH8BS/4bdqhgUmTRohUNhA5MYARYrIM0nQalRYPzC
 0CIuJ4+AodO2mGbfQ8mydw3ON39W+GhfiJOTrcCR1ogJ1bn6gJto06Pb+
 yNj2kL0h6A+am4BlZbU/GjwBmapGlnOwh1KL9WRVwxFfDPbzDjBuYSTMt
 dR4Iq72yaU7CUwkEVHz9Lh3Io2hXBJcqAi/0gnscU9T+VqqCJ43WkugaP w==;
X-CSE-ConnectionGUID: 7htG6k6iRK+KXDo48oGmTw==
X-CSE-MsgGUID: xFCr4NQtSGGvVxx2Xmzpgw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575440"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575440"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:34:23 -0700
X-CSE-ConnectionGUID: BfgH45qaQVS9EIQGZePiNA==
X-CSE-MsgGUID: 2jsWinknQcmFBmFKAif0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954901"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:34:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v7 16/17] intel_iommu: Implement [set|unset]_iommu_device()
 callbacks
Date: Wed,  5 Jun 2024 16:30:42 +0800
Message-Id: <20240605083043.317831-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Implement [set|unset]_iommu_device() callbacks in Intel vIOMMU.
In set call, we take a reference of HostIOMMUDevice and store it
in hash table indexed by PCI BDF.

Note this BDF index is device's real BDF not the aliased one which
is different from the index of VTDAddressSpace. There can be multiple
assigned devices under same virtual iommu group and share same
VTDAddressSpace, but each has its own HostIOMMUDevice.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  2 +
 hw/i386/intel_iommu.c         | 81 +++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c8..1eb05c29fc 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -292,6 +292,8 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
+    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
+
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 519063c8f8..07e897ad7a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -61,6 +61,12 @@ struct vtd_as_key {
     uint32_t pasid;
 };
 
+/* bus/devfn is PCI device's real BDF not the aliased one */
+struct vtd_hiod_key {
+    PCIBus *bus;
+    uint8_t devfn;
+};
+
 struct vtd_iotlb_key {
     uint64_t gfn;
     uint32_t pasid;
@@ -250,6 +256,25 @@ static guint vtd_as_hash(gconstpointer v)
     return (guint)(value << 8 | key->devfn);
 }
 
+/* Same implementation as vtd_as_hash() */
+static guint vtd_hiod_hash(gconstpointer v)
+{
+    return vtd_as_hash(v);
+}
+
+static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct vtd_hiod_key *key1 = v1;
+    const struct vtd_hiod_key *key2 = v2;
+
+    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
+}
+
+static void vtd_hiod_destroy(gpointer v)
+{
+    object_unref(v);
+}
+
 static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
                                           gpointer user_data)
 {
@@ -3812,6 +3837,58 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                     HostIOMMUDevice *hiod, Error **errp)
+{
+    IntelIOMMUState *s = opaque;
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
+    if (g_hash_table_lookup(s->vtd_host_iommu_dev, &key)) {
+        error_setg(errp, "Host IOMMU device already exist");
+        vtd_iommu_unlock(s);
+        return false;
+    }
+
+    new_key = g_malloc(sizeof(*new_key));
+    new_key->bus = bus;
+    new_key->devfn = devfn;
+
+    object_ref(hiod);
+    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
+
+    vtd_iommu_unlock(s);
+
+    return true;
+}
+
+static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
+{
+    IntelIOMMUState *s = opaque;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    vtd_iommu_lock(s);
+
+    if (!g_hash_table_lookup(s->vtd_host_iommu_dev, &key)) {
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
@@ -4116,6 +4193,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .set_iommu_device = vtd_dev_set_iommu_device,
+    .unset_iommu_device = vtd_dev_unset_iommu_device,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
@@ -4235,6 +4314,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
                                       g_free, g_free);
+    s->vtd_host_iommu_dev = g_hash_table_new_full(vtd_hiod_hash, vtd_hiod_equal,
+                                                  g_free, vtd_hiod_destroy);
     vtd_init(s);
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
-- 
2.34.1


