Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B612CC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 08:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8EiW-0002mZ-L1; Fri, 25 Apr 2025 04:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiI-0002iV-8l
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u8EiD-0003Cx-K9
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 04:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745570829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOjx7Ww77adIq1GqkqZD+JwC0UxWK+D5vsju9/L0IZ0=;
 b=bN+abl8QSaC2Vzw3NS1jo9A6ZRTg/gp+0AAOAd6/yTN+LTq3hjUD2ha/FsnzhXDlu/Mb78
 ZCHCGncPceSrId3p1oxQwTel0bWC+C56qe+Q6k6j28A5N40YbVBmZOXKE4D2HkD6mmWcow
 +WlJ3NVz3gLe+2RTuppm8ecNJnlwOwE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-G8_9OlkmP7K3YvJh-q62cA-1; Fri,
 25 Apr 2025 04:47:07 -0400
X-MC-Unique: G8_9OlkmP7K3YvJh-q62cA-1
X-Mimecast-MFC-AGG-ID: G8_9OlkmP7K3YvJh-q62cA_1745570826
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EB45180087B; Fri, 25 Apr 2025 08:47:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.65])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6C7D30001A2; Fri, 25 Apr 2025 08:47:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/50] vfio/spapr: Fix L2 crash with PCI device passthrough and
 memory > 128G
Date: Fri, 25 Apr 2025 10:45:57 +0200
Message-ID: <20250425084644.102196-5-clg@redhat.com>
In-Reply-To: <20250425084644.102196-1-clg@redhat.com>
References: <20250425084644.102196-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

An L2 KVM guest fails to boot inside a pSeries LPAR when booted with a
memory more than 128 GB and PCI device passthrough. The L2 guest also
crashes when it is booted with a memory greater than 128 GB and a PCI
device is hotplugged later.

The issue arises from a conditional check for `levels > 1` in
`spapr_tce_create_table()` within L1 KVM. This check is meant to prevent
multi-level TCEs, which are not supported by the PowerVM hypervisor. As
a result, when QEMU makes a `VFIO_IOMMU_SPAPR_TCE_CREATE` ioctl call
with `levels > 1`, it triggers the conditional check and returns
`EINVAL`, causing the guest to crash with the following errors:

 2025-03-04T06:36:36.133117Z qemu-system-ppc64: Failed to create a window, ret = -1 (Invalid argument)
 2025-03-04T06:36:36.133176Z qemu-system-ppc64: Failed to create SPAPR window: Invalid argument
 qemu: hardware error: vfio: DMA mapping failed, unable to continue

Fix this by checking the supported DDW "levels" returned by the
VFIO_IOMMU_SPAPR_TCE_GET_INFO ioctl before attempting the TCE create
ioctl in KVM.

The patch has been tested on KVM guests with memory configurations of up
to 390GB, and 450GB on PowerVM and bare-metal environments respectively.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250408124042.2695955-3-amachhiw@linux.ibm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 3d6354134c3d517b810d28404f3e2a7eee9b1192..7e5cb95f6a48ff87a0fddd62f9c3c297b790049d 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -26,6 +26,7 @@ typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
+    unsigned int levels;
 } VFIOSpaprContainer;
 
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
@@ -236,9 +237,11 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
 {
     int ret = 0;
     VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
     uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
-    unsigned entries, bits_total, bits_per_level, max_levels;
+    unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
     struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
     long rampagesize = qemu_minrampagesize();
 
@@ -291,16 +294,29 @@ static bool vfio_spapr_create_window(VFIOContainer *container,
      */
     bits_per_level = ctz64(qemu_real_host_page_size()) + 8;
     create.levels = bits_total / bits_per_level;
-    if (bits_total % bits_per_level) {
-        ++create.levels;
-    }
-    max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
-    for ( ; create.levels <= max_levels; ++create.levels) {
-        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
-        if (!ret) {
-            break;
+
+    ddw_levels = scontainer->levels;
+    if (ddw_levels > 1) {
+        if (bits_total % bits_per_level) {
+            ++create.levels;
         }
+        max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
+        for ( ; create.levels <= max_levels; ++create.levels) {
+            ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+            if (!ret) {
+                break;
+            }
+        }
+    } else { /* ddw_levels == 1 */
+        if (create.levels > ddw_levels) {
+            error_setg_errno(errp, EINVAL, "Host doesn't support multi-level TCE tables"
+                             ". Use larger IO page size. Supported mask is 0x%lx",
+                             bcontainer->pgsizes);
+            return false;
+        }
+        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
     }
+
     if (ret) {
         error_setg_errno(errp, errno, "Failed to create a window, ret = %d", ret);
         return false;
@@ -501,6 +517,8 @@ static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
         goto listener_unregister_exit;
     }
 
+    scontainer->levels = info.ddw.levels;
+
     if (v2) {
         bcontainer->pgsizes = info.ddw.pgsizes;
         /*
-- 
2.49.0


