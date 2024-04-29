Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F444C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 06:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1KuY-0003dW-RM; Mon, 29 Apr 2024 02:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuV-0003QF-UV
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:48 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1KuT-0007th-Nh
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373686; x=1745909686;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zt5SNWMw7BsypMebjduxQIFQLMZcr/PymnRgR88oP3I=;
 b=OR3mAPTGSxa6l2Euo8M4F7xclK3RW6CfRn/eMajqGRJ1130RjqLSvg4i
 55UMEOae7g1aueBm201RrAqIhk68us8woCh3AB45c2Nr7rvSBaT7URoEu
 lrYz4rVt9sq5kn6haSvhhT1Pnj79aMLVd6r/n/ysszaDko/orUXKgL6nk
 8BXi7ChWCD5hppboE2Fg1K6XP8ecP3cz3HbIcvFJnZeCD975jl1R84oiK
 UHWBVYTBumKj1G/9kV7CfTrotxlUUAwxt/0+nR1Lg2dMRIk/BM98OoyRe
 wWgzNp/m/ZhW7Zv5cBo9o0LMzRFV6KXiPxrTLXb9bqs1ifSdHYwgCUOhN w==;
X-CSE-ConnectionGUID: x5Qz4Bu5S3Ca7dpg18JOEw==
X-CSE-MsgGUID: GCdPry27Tmae7KArdwXWug==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560775"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560775"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:34 -0700
X-CSE-ConnectionGUID: dUdPrBUSTXGaXqFxPeHHFQ==
X-CSE-MsgGUID: Bx4Y17OERnuaAORdL31clA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488431"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:54:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 18/19] intel_iommu: Implement [set|unset]_iommu_device()
 callbacks
Date: Mon, 29 Apr 2024 14:50:45 +0800
Message-Id: <20240429065046.3688701-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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
index 519063c8f8..4f84e2e801 100644
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
 
+static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                    HostIOMMUDevice *hiod, Error **errp)
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
+        return -EEXIST;
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


