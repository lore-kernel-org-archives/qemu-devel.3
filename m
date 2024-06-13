Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69EFBC2BA16
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHghF-0004GH-Lr; Thu, 13 Jun 2024 05:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHghE-0004Fr-R0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sHghD-0005X7-1j
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718270678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFPPspNGpR3z2DWcghCZxs58lk0acCVx1fSicKWEyZk=;
 b=e+xia53D1vlMxoKHUdNAHfisXlqww1zqccqWX6F8znSZKTKJbGTAYKqnZ2Ei2SdlILIMgF
 6jPAf3sdEzP/Ju1oztfoslnrQ3yXKLNxLkLfWagvpMBM0BolqpjQ5zwJMjq2B3AGPSVUre
 1ss2Pz/tAbCLvAS1kJfvpgCAm3whwYI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-REv8KJS2OmeU2T7J3AsDlw-1; Thu,
 13 Jun 2024 05:24:30 -0400
X-MC-Unique: REv8KJS2OmeU2T7J3AsDlw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 946E21955F1D; Thu, 13 Jun 2024 09:24:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 679501956050; Thu, 13 Jun 2024 09:24:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v3 4/7] virtio-iommu: Compute host reserved regions
Date: Thu, 13 Jun 2024 11:20:06 +0200
Message-ID: <20240613092359.847145-5-eric.auger@redhat.com>
In-Reply-To: <20240613092359.847145-1-eric.auger@redhat.com>
References: <20240613092359.847145-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
The usable IOVA regions are retrieved from the HOSTIOMMUDevice.
The virtio_iommu_set_host_iova_ranges() helper turns usable regions
into complementary reserved regions while testing the inclusion
into existing ones. virtio_iommu_set_host_iova_ranges() reuse the
implementation of virtio_iommu_set_iova_ranges() which will be
removed in subsequent patches. rebuild_resv_regions() is just moved.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

- added g_assert(!sdev->probe_done)
---
 hw/virtio/virtio-iommu.c | 146 ++++++++++++++++++++++++++++++---------
 1 file changed, 112 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index db842555c8..04474ebd74 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -498,12 +498,109 @@ get_host_iommu_device(VirtIOIOMMU *viommu, PCIBus *bus, int devfn) {
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
     VirtioHostIOMMUDevice *vhiod;
+    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     struct hiod_key *new_key;
+    GList *host_iova_ranges = NULL;
 
     assert(hiod);
 
@@ -513,6 +610,20 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return false;
     }
 
+    if (hiodc->get_iova_ranges) {
+        int ret;
+        host_iova_ranges = hiodc->get_iova_ranges(hiod, errp);
+        if (!host_iova_ranges) {
+            return true; /* some old kernels may not support that capability */
+        }
+        ret = virtio_iommu_set_host_iova_ranges(viommu, bus, devfn,
+                                                host_iova_ranges, errp);
+        if (ret) {
+            g_list_free_full(host_iova_ranges, g_free);
+            return false;
+        }
+    }
+
     vhiod = g_malloc0(sizeof(VirtioHostIOMMUDevice));
     vhiod->bus = bus;
     vhiod->devfn = (uint8_t)devfn;
@@ -525,6 +636,7 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
 
     object_ref(hiod);
     g_hash_table_insert(viommu->host_iommu_devices, new_key, vhiod);
+    g_list_free_full(host_iova_ranges, g_free);
 
     return true;
 }
@@ -1246,40 +1358,6 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
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


