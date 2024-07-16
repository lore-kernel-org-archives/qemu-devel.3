Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A19D2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTelm-00062A-JV; Tue, 16 Jul 2024 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelk-0005tg-Pn
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sTelj-0000Nb-6c
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721123205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRrR9cB41kizellih51J2f8d4SksCr5ITTCJbWBauUY=;
 b=Wz8b3SYTn//lNUDgHC3DfTaOPnfUx97WYK/no1oehQXTz4kNlhkuM0sfjj6BwKoifYLogy
 Mvjk91Lbj5xHdbKtqQ5XwVcHdLea4oluKlTAklHOPVY1tDYULsbevpOrAoTzRo11qaA3JW
 lxHhzKyjz1JO3XVx6TFYpeplnnxFrCQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-uvo_IKcLNuGhf9qru8ralg-1; Tue,
 16 Jul 2024 05:46:44 -0400
X-MC-Unique: uvo_IKcLNuGhf9qru8ralg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2529195608A; Tue, 16 Jul 2024 09:46:42 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.185])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E186B3000183; Tue, 16 Jul 2024 09:46:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jasowang@redhat.com
Cc: yanghliu@redhat.com
Subject: [PATCH 3/6] virtio-iommu: Free [host_]resv_ranges on
 unset_iommu_devices
Date: Tue, 16 Jul 2024 11:45:05 +0200
Message-ID: <20240716094619.1713905-4-eric.auger@redhat.com>
In-Reply-To: <20240716094619.1713905-1-eric.auger@redhat.com>
References: <20240716094619.1713905-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We are currently missing the deallocation of the [host_]resv_regions
in case of hot unplug. Also to make things more simple let's rule
out the case where multiple HostIOMMUDevices would be aliased and
attached to the same IOMMUDevice. This allows to remove the handling
of conflicting Host reserved regions. Anyway this is not properly
supported at guest kernel level. On hotunplug the reserved regions
are reset to the ones set by virtio-iommu property.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 62 ++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2c54c0d976..2de41ab412 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -538,8 +538,6 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
 {
     IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
     IOMMUDevice *sdev;
-    GList *current_ranges;
-    GList *l, *tmp, *new_ranges = NULL;
     int ret = -EINVAL;
 
     if (!sbus) {
@@ -553,33 +551,10 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
         return ret;
     }
 
-    current_ranges = sdev->host_resv_ranges;
-
-    /* check that each new resv region is included in an existing one */
     if (sdev->host_resv_ranges) {
-        range_inverse_array(iova_ranges,
-                            &new_ranges,
-                            0, UINT64_MAX);
-
-        for (tmp = new_ranges; tmp; tmp = tmp->next) {
-            Range *newr = (Range *)tmp->data;
-            bool included = false;
-
-            for (l = current_ranges; l; l = l->next) {
-                Range * r = (Range *)l->data;
-
-                if (range_contains_range(r, newr)) {
-                    included = true;
-                    break;
-                }
-            }
-            if (!included) {
-                goto error;
-            }
-        }
-        /* all new reserved ranges are included in existing ones */
-        ret = 0;
-        goto out;
+        error_setg(errp, "%s virtio-iommu does not support aliased BDF",
+                   __func__);
+        return ret;
     }
 
     range_inverse_array(iova_ranges,
@@ -588,14 +563,31 @@ static int virtio_iommu_set_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
     rebuild_resv_regions(sdev);
 
     return 0;
-error:
-    error_setg(errp, "%s Conflicting host reserved ranges set!",
-               __func__);
-out:
-    g_list_free_full(new_ranges, g_free);
-    return ret;
 }
 
+static void virtio_iommu_unset_host_iova_ranges(VirtIOIOMMU *s, PCIBus *bus,
+                                                int devfn)
+{
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUDevice *sdev;
+
+    if (!sbus) {
+        return;
+    }
+
+    sdev = sbus->pbdev[devfn];
+    if (!sdev) {
+        return;
+    }
+
+    g_list_free_full(g_steal_pointer(&sdev->host_resv_ranges), g_free);
+    g_list_free_full(sdev->resv_regions, g_free);
+    sdev->host_resv_ranges = NULL;
+    sdev->resv_regions = NULL;
+    add_prop_resv_regions(sdev);
+}
+
+
 static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t new_mask,
                                  Error **errp)
 {
@@ -704,6 +696,8 @@ virtio_iommu_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     if (!hiod) {
         return;
     }
+    virtio_iommu_unset_host_iova_ranges(viommu, hiod->aliased_bus,
+                                        hiod->aliased_devfn);
 
     g_hash_table_remove(viommu->host_iommu_devices, &key);
 }
-- 
2.41.0


