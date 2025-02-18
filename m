Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58090C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSK7-0006Gm-8c; Tue, 18 Feb 2025 13:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkSK5-0006Em-PF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkSK4-0008Mc-4i
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739903274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJn1PwuQ6ZEe/NnDcn67b5i4iWAPZ9CP/2yKneDb2Uc=;
 b=YCIHElWqE9MidSU7iOKatMV9UZAqb4sFSM++WKxAEuWUvn4ueTR3wVj1Cjb/cQZ64CvT6t
 i4SOoueTSZVK2mea3/DaRZqWKUuFqpdkhLUMXoBmymQhQxlL+CkQCQTlLaJ3ZsCB91EeoZ
 JjBbk2pAct6Cz4na8lhI3ZlmJL8CYd8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-AgP8GeFTOdGDStGkp6LupQ-1; Tue,
 18 Feb 2025 13:27:53 -0500
X-MC-Unique: AgP8GeFTOdGDStGkp6LupQ-1
X-Mimecast-MFC-AGG-ID: AgP8GeFTOdGDStGkp6LupQ_1739903272
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 701A718EB2CB; Tue, 18 Feb 2025 18:27:51 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.254])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8DF3180035F; Tue, 18 Feb 2025 18:27:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com, peterx@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: [PATCH v3 1/5] hw/virtio/virtio-iommu: Migrate to 3-phase reset
Date: Tue, 18 Feb 2025 19:25:31 +0100
Message-ID: <20250218182737.76722-2-eric.auger@redhat.com>
In-Reply-To: <20250218182737.76722-1-eric.auger@redhat.com>
References: <20250218182737.76722-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently the iommu may be reset before the devices
it protects. For example this happens with virtio-net.

Let's use 3-phase reset mechanism and reset the IOMMU on
exit phase after all DMA capable devices have been
reset during the 'enter' or 'hold' phase.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>

---
v2 -> v3:
- add a comment emphasizing the fact that the exit reset
  needs to be used
---
 hw/virtio/virtio-iommu.c | 14 ++++++++++----
 hw/virtio/trace-events   |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index f41104a952..b6e7e01ef7 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1504,11 +1504,11 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
-static void virtio_iommu_device_reset(VirtIODevice *vdev)
+static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
 {
-    VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
+    VirtIOIOMMU *s = VIRTIO_IOMMU(obj);
 
-    trace_virtio_iommu_device_reset();
+    trace_virtio_iommu_device_reset_exit();
 
     if (s->domains) {
         g_tree_destroy(s->domains);
@@ -1668,6 +1668,7 @@ static void virtio_iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_iommu_properties);
     dc->vmsd = &vmstate_virtio_iommu;
@@ -1675,7 +1676,12 @@ static void virtio_iommu_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     vdc->realize = virtio_iommu_device_realize;
     vdc->unrealize = virtio_iommu_device_unrealize;
-    vdc->reset = virtio_iommu_device_reset;
+
+    /*
+     * Use 'exit' reset phase to make sure all DMA requests
+     * have been quiesced during 'enter' or 'hold' phase
+     */
+    rc->phases.exit = virtio_iommu_device_reset_exit;
     vdc->get_config = virtio_iommu_get_config;
     vdc->set_config = virtio_iommu_set_config;
     vdc->get_features = virtio_iommu_get_features;
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 04e36ae047..76f0d458b2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -108,7 +108,7 @@ virtio_pci_notify_write(uint64_t addr, uint64_t val, unsigned int size) "0x%" PR
 virtio_pci_notify_write_pio(uint64_t addr, uint64_t val, unsigned int size) "0x%" PRIx64" = 0x%" PRIx64 " (%d)"
 
 # hw/virtio/virtio-iommu.c
-virtio_iommu_device_reset(void) "reset!"
+virtio_iommu_device_reset_exit(void) "reset!"
 virtio_iommu_system_reset(void) "system reset!"
 virtio_iommu_get_features(uint64_t features) "device supports features=0x%"PRIx64
 virtio_iommu_device_status(uint8_t status) "driver status = %d"
-- 
2.47.1


