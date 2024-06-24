Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0FFC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCC-0003KF-Nt; Mon, 24 Jun 2024 17:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCB-0003CJ-G3
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrC9-0006g1-Lu
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mr05o3PNbaiGr+j10jJQ3rwE+cjH0xSS581I9pWwi4U=;
 b=A9+Kj8WuoR4scMF1Ze4euesCqVsVsE+agKKC8KMch4e8NodBOLxh7qZA2x5Jq8wUXPNXnx
 wk3hXcBrbqhaNItpnp/57ZVlcbMamhemc6YDgEHsILewK1CrnWDxO1to0BPchcMAeZbZbD
 tfJ32ZLxuL456Hu97UZ3YcuJKirD0CQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-0UZ2NLWQNdmdWysIk1ypYA-1; Mon,
 24 Jun 2024 17:25:45 -0400
X-MC-Unique: 0UZ2NLWQNdmdWysIk1ypYA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1D4A195608B; Mon, 24 Jun 2024 21:25:44 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51F4A1956053; Mon, 24 Jun 2024 21:25:42 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 16/42] intel_iommu: Implement [set|unset]_iommu_device()
 callbacks
Date: Mon, 24 Jun 2024 23:24:30 +0200
Message-ID: <20240624212456.350919-17-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h |  2 +
 hw/i386/intel_iommu.c         | 81 +++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c87bb8569fd6985e299fc0a1cc4b0c0c..1eb05c29fc9c703a61f06d90616694e74fb61c15 100644
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
index c69c0d285b1fa85da22440934178243942fe42ab..019d1c9c800cde1d84f50e29eac02bea0e3329f3 100644
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
2.45.2


