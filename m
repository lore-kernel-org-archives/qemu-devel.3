Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F10C54E49
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 07:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQFO-0001ZR-Ek; Fri, 23 Feb 2024 02:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQFN-0001Xl-N7
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQFC-0004xi-Iz
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708674317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTWM9Kqbr+5bRD3vjqSa0WSyOt8CpfUimMU2ld0Fpc4=;
 b=Hu37C6CjPGRPGCW7sioKrr98E5IzzjLLNTIOol7fFjXThyTkSw+X1mOgDTFB68sKumw3Nj
 EYFBure9ZjyztbipgL6SbU8jHDw7rn3SnWuxeayUf36eT8Qgv95mBhRwASkUWGzKWprY8x
 Ba9l8L295Q6OnT2k8zx4r0OV2Wa0k24=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-nwIMgYeJMmWsDJF5pfMuOg-1; Fri,
 23 Feb 2024 02:45:12 -0500
X-MC-Unique: nwIMgYeJMmWsDJF5pfMuOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC3DB3C025B4;
 Fri, 23 Feb 2024 07:45:11 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.195.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5A4B40D1B6A;
 Fri, 23 Feb 2024 07:45:08 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com, jasowang@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: [PATCH v4 2/3] virtio-iommu: Add a granule property
Date: Fri, 23 Feb 2024 08:27:24 +0100
Message-ID: <20240223074459.63422-3-eric.auger@redhat.com>
In-Reply-To: <20240223074459.63422-1-eric.auger@redhat.com>
References: <20240223074459.63422-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
into a 4K granule.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- granule_mode introduction moved to that patch
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 27 ++++++++++++++++++++++++---
 qemu-options.hx                  |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index e22327548f..a3e5b35b1e 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -78,6 +78,7 @@ struct VirtIOIOMMU {
     Notifier machine_done;
     bool granule_frozen;
     uint8_t aw_bits;
+    GranuleMode granule_mode;
 };
 
 #endif
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a9bdc03d12..0461b87ef2 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1126,8 +1126,8 @@ static int virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
 }
 
 /*
- * The default mask (TARGET_PAGE_MASK) is the smallest supported guest granule,
- * for example 0xfffffffffffff000. When an assigned device has page size
+ * The default mask depends on the "granule" property. For example, with
+ * 4K granule, it is ~0xFFF. When an assigned device has page size
  * restrictions due to the hardware IOMMU configuration, apply this restriction
  * to the mask.
  */
@@ -1324,7 +1324,26 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
      * in vfio realize
      */
     s->config.bypass = s->boot_bypass;
-    s->config.page_size_mask = qemu_target_page_mask();
+
+    switch (s->granule_mode) {
+    case GRANULE_MODE_4K:
+        s->config.page_size_mask = ~0xFFF;
+        break;
+    case GRANULE_MODE_8K:
+        s->config.page_size_mask = ~0x1FFF;
+        break;
+    case GRANULE_MODE_16K:
+        s->config.page_size_mask = ~0x3FFF;
+        break;
+    case GRANULE_MODE_64K:
+        s->config.page_size_mask = ~0xFFFF;
+        break;
+    case GRANULE_MODE_HOST:
+        s->config.page_size_mask = qemu_real_host_page_mask();
+        break;
+    default:
+        error_setg(errp, "Unsupported granule mode");
+    }
     if (s->aw_bits < 32 || s->aw_bits > 64) {
         error_setg(errp, "aw-bits must be within [32,64]");
     }
@@ -1538,6 +1557,8 @@ static Property virtio_iommu_properties[] = {
                      TYPE_PCI_BUS, PCIBus *),
     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
     DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
+    DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
+                             GRANULE_MODE_4K),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/qemu-options.hx b/qemu-options.hx
index a98bc7bd60..8bc1e9e4aa 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1179,6 +1179,9 @@ SRST
     ``aw-bits=val`` (val between 32 and 64, default depends on machine)
         This decides the address width of IOVA address space. It defaults
         to 39 bits on q35 machines and 48 bits on ARM virt machines.
+    ``granule=val`` (possible values are 4K, 8K, 16K, 64K and host)
+        This decides the default granule to be be exposed by the
+        virtio-iommu. If host, the granule matches the host page size.
 
 ERST
 
-- 
2.41.0


