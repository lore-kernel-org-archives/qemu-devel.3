Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D782C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhxy6-0004MM-FG; Wed, 06 Mar 2024 15:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhxxo-0004F6-Ly
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:34:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rhxxn-0001nw-2e
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709757246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCNHJBHzbGHJQEsUZ3hntYV04NWRORdIJ35ThpnGdQk=;
 b=F8FaGotl3lG4DzV2g55DhrCqfaVO7WRvZA/T/FxqIJ47rhnVgsMNrJkzD/FZT17DEsU60g
 4KfmDmcdwf/jWXSHc4vLmexT1Eif3vXVHWZ3HnoODcWKzOdpK7aHH1hSFW0ZLOlPxjGBy6
 ECPjk8ikkBhZrey/NsMU3jg5vC86t0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-A6wJnyQIPU6QrmJcGpTOaw-1; Wed, 06 Mar 2024 15:34:03 -0500
X-MC-Unique: A6wJnyQIPU6QrmJcGpTOaw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 714FE800262;
 Wed,  6 Mar 2024 20:34:02 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07CB136FF;
 Wed,  6 Mar 2024 20:33:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v7 2/9] virtio-iommu: Add a granule property
Date: Wed,  6 Mar 2024 21:32:41 +0100
Message-ID: <20240306203348.65776-3-eric.auger@redhat.com>
In-Reply-To: <20240306203348.65776-1-eric.auger@redhat.com>
References: <20240306203348.65776-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This allows to choose which granule will be used by
default by the virtio-iommu. Current page size mask
default is qemu_target_page_mask so this translates
into a 4k granule on ARM and x86_64 where virtio-iommu
is supported.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

---
v4 -> v5:
- use -(n * KiB) (Phild)

v3 -> v4:
- granule_mode introduction moved to that patch
---
 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 781ebaea8f..67ea5022af 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -24,6 +24,7 @@
 #include "hw/virtio/virtio.h"
 #include "hw/pci/pci.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-virtio.h"
 
 #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
 #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
@@ -66,6 +67,7 @@ struct VirtIOIOMMU {
     bool boot_bypass;
     Notifier machine_done;
     bool granule_frozen;
+    GranuleMode granule_mode;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 86623d55a5..84d6819d3b 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "qemu/reserved-region.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
@@ -1115,8 +1116,8 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
 }
 
 /*
- * The default mask (TARGET_PAGE_MASK) is the smallest supported guest granule,
- * for example 0xfffffffffffff000. When an assigned device has page size
+ * The default mask depends on the "granule" property. For example, with
+ * 4k granule, it is -(4 * KiB). When an assigned device has page size
  * restrictions due to the hardware IOMMU configuration, apply this restriction
  * to the mask.
  */
@@ -1313,8 +1314,27 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.page_size_mask = qemu_target_page_mask();
     s->config.input_range.end = UINT64_MAX;
+
+    switch (s->granule_mode) {
+    case GRANULE_MODE_4K:
+        s->config.page_size_mask = -(4 * KiB);
+        break;
+    case GRANULE_MODE_8K:
+        s->config.page_size_mask = -(8 * KiB);
+        break;
+    case GRANULE_MODE_16K:
+        s->config.page_size_mask = -(16 * KiB);
+        break;
+    case GRANULE_MODE_64K:
+        s->config.page_size_mask = -(64 * KiB);
+        break;
+    case GRANULE_MODE_HOST:
+        s->config.page_size_mask = qemu_real_host_page_mask();
+        break;
+    default:
+        error_setg(errp, "Unsupported granule mode");
+    }
     s->config.domain_range.end = UINT32_MAX;
     s->config.probe_size = VIOMMU_PROBE_SIZE;
 
@@ -1522,6 +1542,8 @@ static Property virtio_iommu_properties[] = {
     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
+    DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
+                             GRANULE_MODE_4K),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


