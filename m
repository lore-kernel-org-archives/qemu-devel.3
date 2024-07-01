Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AB5C3065C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 08:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOCll-00060F-8C; Mon, 01 Jul 2024 04:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOCk3-0003iv-E3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sOCk1-0005Oe-LI
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 04:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719823828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IFJ+FqzJAi+xdGYd3QywewnLxLIyH2pgLmSnMH5+zk=;
 b=aoKb0XIIa8s/ZW4hD6mfImaBLl5tnQG2YH97zZ9A/gHKuGxjgJzKyuiinsNtQ4MR8QGfF/
 N3Qp5+cWaBkQgd7XgX/VxlLqO2NUez07NSkN9eY622m+8VMycIHfllZ0fWIixo/8lert/Y
 uQ10FbWOsI1viyEZhd+qrAra5AIW50Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-fjr5hWfROZKxv4oLRVvBAA-1; Mon,
 01 Jul 2024 04:50:27 -0400
X-MC-Unique: fjr5hWfROZKxv4oLRVvBAA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B155197907C; Mon,  1 Jul 2024 08:50:26 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.22.9.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECC9D1955E80; Mon,  1 Jul 2024 08:50:22 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com
Subject: [PATCH v2 5/7] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Date: Mon,  1 Jul 2024 10:48:57 +0200
Message-ID: <20240701084957.1567641-6-eric.auger@redhat.com>
In-Reply-To: <20240701084957.1567641-1-eric.auger@redhat.com>
References: <20240701084957.1567641-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Retrieve the Host IOMMU Device page size mask when this latter is set.
This allows to get the information much sooner than when relying on
IOMMU MR set_page_size_mask() call, whcih happens when the IOMMU MR
gets enabled. We introduce check_page_size_mask() helper whose code
is inherited from current virtio_iommu_set_page_size_mask()
implementation. This callback will be removed in a subsequent patch.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- do not update the mask if the granule is frozen (Zhenzhong)
---
 hw/virtio/virtio-iommu.c | 57 ++++++++++++++++++++++++++++++++++++++--
 hw/virtio/trace-events   |  1 +
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index b8f75d2b1a..7d5db554af 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -598,9 +598,39 @@ out:
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
@@ -623,8 +653,28 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
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
 
@@ -637,6 +687,9 @@ static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     g_list_free_full(host_iova_ranges, g_free);
 
     return true;
+error:
+    g_list_free_full(host_iova_ranges, g_free);
+    return false;
 }
 
 static void
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3cf84e04a7..599d855ff6 100644
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
2.41.0


