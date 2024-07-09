Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79110C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Mv-0005MP-DZ; Tue, 09 Jul 2024 07:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mp-0004zK-OT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Mi-0006KJ-FP
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3MthOu4YA0jbZLDxlULMG7zSMZtr9wLxweLA4487GoY=;
 b=X6SDYOQ/dgpoNXemrPk4lNb5VG1kiJZMLcyshf8DYCfALq8dXpwnDRlyu7BaInAozz4aGz
 E2FCYDhrQ9qAgRk3/X6f70VbMNcQYtajiBu7jM9GS8Q+sJwYSWp5oE6iUNrI0WUEFBy1Cc
 ob51CglIfWbILHzCKOTe8CbF/Dp/dA8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-8MozQR2eMqa8kAAjt3NAYA-1; Tue,
 09 Jul 2024 07:50:33 -0400
X-MC-Unique: 8MozQR2eMqa8kAAjt3NAYA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D44871955F43; Tue,  9 Jul 2024 11:50:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C1FD3000184; Tue,  9 Jul 2024 11:50:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 5/9] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Date: Tue,  9 Jul 2024 13:50:13 +0200
Message-ID: <20240709115017.798043-6-clg@redhat.com>
In-Reply-To: <20240709115017.798043-1-clg@redhat.com>
References: <20240709115017.798043-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Eric Auger <eric.auger@redhat.com>

Retrieve the Host IOMMU Device page size mask when this latter is set.
This allows to get the information much sooner than when relying on
IOMMU MR set_page_size_mask() call, whcih happens when the IOMMU MR
gets enabled. We introduce check_page_size_mask() helper whose code
is inherited from current virtio_iommu_set_page_size_mask()
implementation. This callback will be removed in a subsequent patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 57 ++++++++++++++++++++++++++++++++++++++--
 hw/virtio/trace-events   |  1 +
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index f278417f2bd95bc57832e9d03671e2834fca5f36..d6654985bd6ed56936289833983e6c1e20a5d9e7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -618,9 +618,39 @@ out:
     return ret;
 }
 
+static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t new_mask,
+                                 Error **errp)
+{
+    uint64_t cur_mask = viommu->config.page_size_mask;
+
+    if ((cur_mask & new_mask) == 0) {
+        error_setg(errp, "virtio-iommu reports a page size mask 0x%"PRIx64
+                   " incompatible with currently supported mask 0x%"PRIx64,
+                   new_mask, cur_mask);
+        return false;
+    }
+    /*
+     * Once the granule is frozen we can't change the mask anymore. If by
+     * chance the hotplugged device supports the same granule, we can still
+     * accept it.
+     */
+    if (viommu->granule_frozen) {
+        int cur_granule = ctz64(cur_mask);
+
+        if (!(BIT_ULL(cur_granule) & new_mask)) {
+            error_setg(errp,
+                       "virtio-iommu does not support frozen granule 0x%llx",
+                       BIT_ULL(cur_granule));
+            return false;
+        }
+    }
+    return true;
+}
+
 static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                           HostIOMMUDevice *hiod, Error **errp)
 {
+    ERRP_GUARD();
     VirtIOIOMMU *viommu = opaque;
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
     struct hiod_key *new_key;
@@ -643,8 +673,28 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                                 hiod->aliased_devfn,
                                                 host_iova_ranges, errp);
         if (ret) {
-            g_list_free_full(host_iova_ranges, g_free);
-            return false;
+            goto error;
+        }
+    }
+    if (hiodc->get_page_size_mask) {
+        uint64_t new_mask = hiodc->get_page_size_mask(hiod);
+
+        if (check_page_size_mask(viommu, new_mask, errp)) {
+            /*
+             * The default mask depends on the "granule" property. For example,
+             * with 4k granule, it is -(4 * KiB). When an assigned device has
+             * page size restrictions due to the hardware IOMMU configuration,
+             * apply this restriction to the mask.
+             */
+            trace_virtio_iommu_update_page_size_mask(hiod->name,
+                                                     viommu->config.page_size_mask,
+                                                     new_mask);
+            if (!viommu->granule_frozen) {
+                viommu->config.page_size_mask &= new_mask;
+            }
+        } else {
+            error_prepend(errp, "%s: ", hiod->name);
+            goto error;
         }
     }
 
@@ -657,6 +707,9 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     g_list_free_full(host_iova_ranges, g_free);
 
     return true;
+error:
+    g_list_free_full(host_iova_ranges, g_free);
+    return false;
 }
 
 static void
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3cf84e04a78fc6ee2f18d563dc8c8f2e31a70bc6..599d855ff6eeb1439ab51bed4d247cb4fc4998ce 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -132,6 +132,7 @@ virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
 virtio_iommu_set_page_size_mask(const char *name, uint64_t old, uint64_t new) "mr=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
+virtio_iommu_update_page_size_mask(const char *name, uint64_t old, uint64_t new) "host iommu device=%s old_mask=0x%"PRIx64" new_mask=0x%"PRIx64
 virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
-- 
2.45.2


