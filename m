Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA1C3600E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 07:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLZV-0001F0-8u; Wed, 26 Mar 2025 03:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZQ-0000yQ-AT
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZO-0006Kc-Da
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OpjgmTkV3hmshry9UGwYmI8t9xIzjay1XkRPGAgDH3Q=;
 b=S1KIa8nxDGG8S9Kb/ynNDKmGkA4CGY332oIvxDg+88LEqDX3qtG9zeAm4GGKpQnVV97OnJ
 lOIkCWsR8SpXUIXW2kzPzMLz3Z958nMX1NKKOS0q3P7IJBNGJKLNbkB6BVm+OW2DatHs/l
 NdDlXpcd7/OnL86Uwcx6BZxduin5OLU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-ANQ5nVL_OA-R1hRJSmOxkA-1; Wed,
 26 Mar 2025 03:52:57 -0400
X-MC-Unique: ANQ5nVL_OA-R1hRJSmOxkA-1
X-Mimecast-MFC-AGG-ID: ANQ5nVL_OA-R1hRJSmOxkA_1742975576
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDED71903081; Wed, 26 Mar 2025 07:52:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C40319560AB; Wed, 26 Mar 2025 07:52:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 22/37] vfio: Move vfio_kvm_device_fd() into
 helpers.c
Date: Wed, 26 Mar 2025 08:51:07 +0100
Message-ID: <20250326075122.1299361-23-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The vfio_kvm_device_add/del_fd() routines opening the VFIO pseudo
device are defined in "helpers.c". Move 'vfio_kvm_device_fd'
definition there and its declaration into "vfio-helpers.h" to reduce
exposure of VFIO internals in "hw/vfio/vfio-common.h".

Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-22-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/vfio-helpers.h        |  2 ++
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/common.c              | 11 -----------
 hw/vfio/helpers.c             | 11 +++++++++++
 hw/vfio/spapr.c               |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/vfio-helpers.h b/hw/vfio/vfio-helpers.h
index dbcb68bbb0e12607f5ccf15f114530966c2cbcb2..54a327ffbc04a2df364fdd78bd97fe7e2065b38c 100644
--- a/hw/vfio/vfio-helpers.h
+++ b/hw/vfio/vfio-helpers.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_LINUX
 #include <linux/vfio.h>
 
+extern int vfio_kvm_device_fd;
+
 struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 struct vfio_info_cap_header *
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c587ed08feabd0c4845d824960dd0799e9ace69b..8b300e7768fb61af881f6a8b7eeb75dc84c98ac3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -132,7 +132,6 @@ VFIODevice *vfio_get_vfio_device(Object *obj);
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIODeviceList vfio_device_list;
 extern const MemoryListener vfio_memory_listener;
-extern int vfio_kvm_device_fd;
 
 #ifdef CONFIG_LINUX
 int vfio_get_region_info(VFIODevice *vbasedev, int index,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 2dcf70c66e81dddffb35a152da5a18d27a05c6f1..91ffc5e1a37a3ba7ab50cb5f14cbe5d56f78949d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -50,17 +50,6 @@
 VFIODeviceList vfio_device_list =
     QLIST_HEAD_INITIALIZER(vfio_device_list);
 
-#ifdef CONFIG_KVM
-/*
- * We have a single VFIO pseudo device per KVM VM.  Once created it lives
- * for the life of the VM.  Closing the file descriptor only drops our
- * reference to it and the device's reference to kvm.  Therefore once
- * initialized, this file descriptor is only released on QEMU exit and
- * we'll re-use it should another vfio device be attached before then.
- */
-int vfio_kvm_device_fd = -1;
-#endif
-
 /*
  * Device state interfaces
  */
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 7ddc9797ef7659035d927e40a3b99a8f74dca2de..48bd61d5280967dffa509dcbaeeee7a1ba01335a 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -106,6 +106,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
+#ifdef CONFIG_KVM
+/*
+ * We have a single VFIO pseudo device per KVM VM.  Once created it lives
+ * for the life of the VM.  Closing the file descriptor only drops our
+ * reference to it and the device's reference to kvm.  Therefore once
+ * initialized, this file descriptor is only released on QEMU exit and
+ * we'll re-use it should another vfio device be attached before then.
+ */
+int vfio_kvm_device_fd = -1;
+#endif
+
 int vfio_kvm_device_add_fd(int fd, Error **errp)
 {
 #ifdef CONFIG_KVM
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 4adfd50967313d1a5c3c4033a57c37eeb3a779a7..ce6eabdf0334f7c80b1b2d1ab8b7ec23812619fd 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -15,13 +15,13 @@
 #include "system/hostmem.h"
 #include "exec/address-spaces.h"
 
-#include "hw/vfio/vfio-common.h"
 #include "hw/vfio/vfio-container.h"
 #include "hw/hw.h"
 #include "exec/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
+#include "vfio-helpers.h"
 
 typedef struct VFIOHostDMAWindow {
     hwaddr min_iova;
-- 
2.49.0


