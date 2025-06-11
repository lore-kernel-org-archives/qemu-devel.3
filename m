Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3777C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN38-0005gr-Jz; Wed, 11 Jun 2025 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2t-0005YB-Cj
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2r-0007Aq-DP
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voVPz9bppXe4ojOkmZSq1ah1isRPLqgbpzeFf+0RIgM=;
 b=cVQSqNIQHFUX9Syifx3CXV8Ut6vThTBB2/OzhCaSUAnwWxRbmjLzBs8jWQz45KM5T9iZe1
 fykULtebJmjagpjRQhW3WyUb+E2Cd8irCCA/e0QEkeVY7q/GJKvOIe/DVh7eFTzu1TFCqf
 Ur3Jf6pkj1hfKdqkzKCqvyZD7fucUqU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-hbZnV96AOquNoWY6nWxsqg-1; Wed,
 11 Jun 2025 11:07:15 -0400
X-MC-Unique: hbZnV96AOquNoWY6nWxsqg-1
X-Mimecast-MFC-AGG-ID: hbZnV96AOquNoWY6nWxsqg_1749654434
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C4781956095; Wed, 11 Jun 2025 15:07:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81F0C180045C; Wed, 11 Jun 2025 15:07:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 20/27] vfio-pci: skip reset during cpr
Date: Wed, 11 Jun 2025 17:06:12 +0200
Message-ID: <20250611150620.701903-21-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Do not reset a vfio-pci device during CPR, and do not complain if the
kernel's PCI config space changes for non-emulated bits between the
vmstate save and load, which can happen due to ongoing interrupt activity.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1749569991-25171-12-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  2 ++
 hw/vfio/cpr.c              | 31 +++++++++++++++++++++++++++++++
 hw/vfio/pci.c              |  7 +++++++
 3 files changed, 40 insertions(+)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 56ede049ad68759e31d855809c5bd8493dc09176..8bf85b9f4ec2cd712ef835dc5d720fe03d767d03 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -52,4 +52,6 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
 bool vfio_cpr_ram_discard_register_listener(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
+extern const VMStateDescription vfio_cpr_pci_vmstate;
+
 #endif /* HW_VFIO_VFIO_CPR_H */
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 0e596122284507cb419cceabaf90ca37871cd9f1..fdbb58e2039e9fc6bd91c37a0f534522c0987680 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -8,6 +8,8 @@
 #include "qemu/osdep.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-cpr.h"
+#include "hw/vfio/pci.h"
+#include "migration/cpr.h"
 #include "qapi/error.h"
 #include "system/runstate.h"
 
@@ -37,3 +39,32 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
 {
     migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
 }
+
+/*
+ * The kernel may change non-emulated config bits.  Exclude them from the
+ * changed-bits check in get_pci_config_device.
+ */
+static int vfio_cpr_pci_pre_load(void *opaque)
+{
+    VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = &vdev->pdev;
+    int size = MIN(pci_config_size(pdev), vdev->config_size);
+    int i;
+
+    for (i = 0; i < size; i++) {
+        pdev->cmask[i] &= vdev->emulated_config_bits[i];
+    }
+
+    return 0;
+}
+
+const VMStateDescription vfio_cpr_pci_vmstate = {
+    .name = "vfio-cpr-pci",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .pre_load = vfio_cpr_pci_pre_load,
+    .needed = cpr_incoming_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST()
+    }
+};
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b97261c61b4f303cb799e4ed6cdce391c198353c..2da5989581e72538cf61de3f453070b5e4f53cc4 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
+#include "migration/cpr.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -3354,6 +3355,11 @@ static void vfio_pci_reset(DeviceState *dev)
 {
     VFIOPCIDevice *vdev = VFIO_PCI_BASE(dev);
 
+    /* Do not reset the device during qemu_system_reset prior to cpr load */
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     trace_vfio_pci_reset(vdev->vbasedev.name);
 
     vfio_pci_pre_reset(vdev);
@@ -3530,6 +3536,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 #ifdef CONFIG_IOMMUFD
     object_class_property_add_str(klass, "fd", NULL, vfio_pci_set_fd);
 #endif
+    dc->vmsd = &vfio_cpr_pci_vmstate;
     dc->desc = "VFIO-based PCI device assignment";
     pdc->realize = vfio_pci_realize;
 
-- 
2.49.0


