Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B878C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 07:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQFD-00019u-Ee; Fri, 23 Feb 2024 02:45:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQFC-00018C-GO
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:45:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rdQF8-0004xD-L7
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708674313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYsIudfgdQRgXsrQQmmlKg4a8jYjMo264xETq/dHpzc=;
 b=eWqw40AxAiKU2O9DSBAWW/bYhLaoYfPTyy6VFOmxi78pe7XnyEgk9bmVpedNamZYNbeW1v
 CO1Wemhp0o4rI/l84uo4v9KWMFIBAEKr36GvhCAwyryBe/sL+PJILam0e9iqAtfDJdh8J7
 iitLwK0HkJQAJq8olRtu5J72psvtujk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-DhSH0A_XONaxEvmbwFaMhQ-1; Fri,
 23 Feb 2024 02:45:08 -0500
X-MC-Unique: DhSH0A_XONaxEvmbwFaMhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61CDC38143A0;
 Fri, 23 Feb 2024 07:45:08 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.195.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27A8640D1B7F;
 Fri, 23 Feb 2024 07:45:05 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com, jasowang@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: [PATCH v4 1/3] qdev: Add a granule_mode property
Date: Fri, 23 Feb 2024 08:27:23 +0100
Message-ID: <20240223074459.63422-2-eric.auger@redhat.com>
In-Reply-To: <20240223074459.63422-1-eric.auger@redhat.com>
References: <20240223074459.63422-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
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

Introduce a new enum type property allowing to set an
IOMMU granule. Values are 4K, 8K, 16K, 64K and host.
This latter indicates the vIOMMU granule will match
the host page size.

A subsequent patch will add such a property to the
virtio-iommu device.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- Add 8K
---
 include/hw/qdev-properties-system.h |  3 +++
 include/hw/virtio/virtio-iommu.h    | 11 +++++++++++
 hw/core/qdev-properties-system.c    | 15 +++++++++++++++
 hw/virtio/virtio-iommu.c            | 11 +++++++++++
 4 files changed, 40 insertions(+)

diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 06c359c190..626be87dd3 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -8,6 +8,7 @@ extern const PropertyInfo qdev_prop_macaddr;
 extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_mig_mode;
+extern const PropertyInfo qdev_prop_granule_mode;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
 extern const PropertyInfo qdev_prop_bios_chs_trans;
@@ -47,6 +48,8 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
 #define DEFINE_PROP_MIG_MODE(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_mig_mode, \
                        MigMode)
+#define DEFINE_PROP_GRANULE_MODE(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_granule_mode, GranuleMode)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_losttickpolicy, \
                         LostTickPolicy)
diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 5fbe4677c2..e22327548f 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -31,6 +31,17 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOIOMMU, VIRTIO_IOMMU)
 
 #define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
 
+typedef enum GranuleMode {
+    GRANULE_MODE_4K,
+    GRANULE_MODE_8K,
+    GRANULE_MODE_16K,
+    GRANULE_MODE_64K,
+    GRANULE_MODE_HOST,
+    GRANULE_MODE__MAX,
+} GranuleMode;
+
+extern const QEnumLookup GranuleMode_lookup;
+
 typedef struct IOMMUDevice {
     void         *viommu;
     PCIBus       *bus;
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 1a396521d5..578eac6b14 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -34,6 +34,7 @@
 #include "net/net.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
+#include "hw/virtio/virtio-iommu.h"
 #include "hw/i386/x86.h"
 #include "util/block-helpers.h"
 
@@ -679,6 +680,20 @@ const PropertyInfo qdev_prop_mig_mode = {
     .set_default_value = qdev_propinfo_set_default_value_enum,
 };
 
+/* --- GranuleMode --- */
+
+QEMU_BUILD_BUG_ON(sizeof(GranuleMode) != sizeof(int));
+
+const PropertyInfo qdev_prop_granule_mode = {
+    .name = "GranuleMode",
+    .description = "granule_mode values, "
+                   "4K, 8K, 16K, 64K, host",
+    .enum_table = &GranuleMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
+
 /* --- Reserved Region --- */
 
 /*
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 2ec5ef3cd1..a9bdc03d12 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -44,6 +44,17 @@
 #define VIOMMU_DEFAULT_QUEUE_SIZE 256
 #define VIOMMU_PROBE_SIZE 512
 
+const QEnumLookup GranuleMode_lookup = {
+    .array = (const char *const[]) {
+        [GRANULE_MODE_4K]   = "4K",
+        [GRANULE_MODE_8K]   = "8K",
+        [GRANULE_MODE_16K]  = "16K",
+        [GRANULE_MODE_64K]  = "64K",
+        [GRANULE_MODE_HOST] = "host",
+    },
+    .size = GRANULE_MODE__MAX
+};
+
 typedef struct VirtIOIOMMUDomain {
     uint32_t id;
     bool bypass;
-- 
2.41.0


