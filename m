Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F8C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3dz-0006JH-Rz; Fri, 14 Jun 2024 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dy-0006Hi-Es
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dw-0003ea-NM
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WphdMtyb4oFpdPiXVbNC9t7U9cbBdox46zm3oUQFI8k=;
 b=cSxrF1GXRyJThzVuocedqMwyqf5+xzPHpEmOu1r/96TDA4vnqYGzmxJeKJIYjjTkQ2bnVn
 qd+lguqqfjnPN4GTeZ8N4gOQDcaf23vNtHBGmJHy3EdYqH+1P19FH9NHgB8ySvaHpjBTAA
 GAPm7B2hdJ1nLCAY7xJaSin1ScpLANI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-RgIoBBebMQOr4kcEbD13Jw-1; Fri,
 14 Jun 2024 05:54:40 -0400
X-MC-Unique: RgIoBBebMQOr4kcEbD13Jw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08B6A1956096; Fri, 14 Jun 2024 09:54:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D05203000219; Fri, 14 Jun 2024 09:54:34 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v4 5/8] virtio-iommu: Compute host reserved regions
Date: Fri, 14 Jun 2024 11:52:55 +0200
Message-ID: <20240614095402.904691-6-eric.auger@redhat.com>
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
References: <20240614095402.904691-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Compute the host reserved regions in virtio_iommu_set_iommu_device().
The usable IOVA regions are retrieved from the HostIOMMUDevice.
The virtio_iommu_set_host_iova_ranges() helper turns usable regions
into complementary reserved regions while testing the inclusion
into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
implementation of virtio_iommu_set_iova_ranges() which will be
removed in subsequent patches. rebuild_resv_regions() is just moved.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
v3 -> v4:
- use aliased pci bus and devfn

v2 -> v3:
- added g_assert(!sdev->probe_done)
---
 hw/virtio/virtio-iommu.c | 147 ++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 16c8ec3ca4..a4c0cceb65 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -498,11 +498,108 @@ get_host_iommu_device(VirtIOIOMMU *viommu, PCIBus *bus, int devfn) {
     return g_hash_table_lookup(viommu->host_iommu_devices, &key);
 }
 
+/**
+ * rebuild_resv_regions: rebuild resv regions with both the
+ * info of host resv ranges and property set resv ranges
+ */
+static int rebuild_resv_regions(IOMMUDevice *sdev)
+{
+    GList *l;
+    int i = 0;
+
+    /* free the existing list and rebuild it from scratch */
+    g_list_free_full(sdev->resv_regions, g_free);
+    sdev->resv_regions = NULL;
+
+    /* First add host reserved regions if any, all tagged as RESERVED */
+    for (l = sdev->host_resv_ranges; l; l = l->next) {
+        ReservedRegion *reg = g_new0(ReservedRegion, 1);
+        Range *r = (Range *)l->data;
+
+        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
+        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
+        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
+        trace_virtio_iommu_host_resv_regions(sdev->iommu_mr.parent_obj.name, i,
+                                             range_lob(&reg->range),
+                                             range_upb(&reg->range));
+        i++;
+    }
+    /*
+     * then add higher priority reserved regions set by the machine
+     * through properties
+     */
+    add_prop_resv_regions(sdev);
+    return 0;
+}
+
+static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
+                                             int devfn, GList *iova_ranges,
+                                             Error **errp)
+{
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUDevice *sdev;
+    GList *current_ranges;
+    GList *l, *tmp, *new_ranges = NULL;
+    int ret = -EINVAL;
+
+    if (!sbus) {
+        error_report("%s no sbus", __func__);
+    }
+
+    sdev = sbus->pbdev[devfn];
+
+    current_ranges = sdev->host_resv_ranges;
+
+    g_assert(!sdev->probe_done);
+
+    /* check that each new resv region is included in an existing one */
+    if (sdev->host_resv_ranges) {
+        range_inverse_array(iova_ranges,
+                            &new_ranges,
+                            0, UINT64_MAX);
+
+        for (tmp = new_ranges; tmp; tmp = tmp->next) {
+            Range *newr = (Range *)tmp->data;
+            bool included = false;
+
+            for (l = current_ranges; l; l = l->next) {
+                Range * r = (Range *)l->data;
+
+                if (range_contains_range(r, newr)) {
+                    included = true;
+                    break;
+                }
+            }
+            if (!included) {
+                goto error;
+            }
+        }
+        /* all new reserved ranges are included in existing ones */
+        ret = 0;
+        goto out;
+    }
+
+    range_inverse_array(iova_ranges,
+                        &sdev->host_resv_ranges,
+                        0, UINT64_MAX);
+    rebuild_resv_regions(sdev);
+
+    return 0;
+error:
+    error_setg(errp, "%s Conflicting host reserved ranges set!",
+               __func__);
+out:
+    g_list_free_full(new_ranges, g_free);
+    return ret;
+}
+
 static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                           HostIOMMUDevice *hiod, Error **errp)
 {
     VirtIOIOMMU *viommu = opaque;
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     struct hiod_key *new_key;
+    GList *host_iova_ranges = NULL;
 
     assert(hiod);
 
@@ -511,12 +608,28 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    if (hiodc->get_iova_ranges) {
+        int ret;
+        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
+        if (!host_iova_ranges) {
+            return true; /* some old kernels may not support that capability */
+        }
+        ret = virtio_iommu_set_host_iova_ranges(viommu, hiod->aliased_bus,
+                                                hiod->aliased_devfn,
+                                                host_iova_ranges, errp);
+        if (ret) {
+            g_list_free_full(host_iova_ranges, g_free);
+            return false;
+        }
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
 
     object_ref(hiod);
     g_hash_table_insert(viommu->host_iommu_devices, new_key, hiod);
+    g_list_free_full(host_iova_ranges, g_free);
 
     return true;
 }
@@ -1238,40 +1351,6 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     return 0;
 }
 
-/**
- * rebuild_resv_regions: rebuild resv regions with both the
- * info of host resv ranges and property set resv ranges
- */
-static int rebuild_resv_regions(IOMMUDevice *sdev)
-{
-    GList *l;
-    int i = 0;
-
-    /* free the existing list and rebuild it from scratch */
-    g_list_free_full(sdev->resv_regions, g_free);
-    sdev->resv_regions = NULL;
-
-    /* First add host reserved regions if any, all tagged as RESERVED */
-    for (l = sdev->host_resv_ranges; l; l = l->next) {
-        ReservedRegion *reg = g_new0(ReservedRegion, 1);
-        Range *r = (Range *)l->data;
-
-        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
-        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
-        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
-        trace_virtio_iommu_host_resv_regions(sdev->iommu_mr.parent_obj.name, i,
-                                             range_lob(&reg->range),
-                                             range_upb(&reg->range));
-        i++;
-    }
-    /*
-     * then add higher priority reserved regions set by the machine
-     * through properties
-     */
-    add_prop_resv_regions(sdev);
-    return 0;
-}
-
 /**
  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
  *
-- 
2.41.0


