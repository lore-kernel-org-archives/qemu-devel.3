Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0023CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXoC-000122-Lr; Wed, 22 Oct 2025 08:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXoA-00011O-Ce
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXo8-00072v-A8
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761135551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkuOgutKsnzyz6zzREuIi83VHqQxaO3yShxiifas0sI=;
 b=hRli+5M4zc3A4h6cs12K9MG49Sqm+yY2OcdmnuQjk2E4lDc1LpUp5aWZfFlLTAYsdssLwo
 /mlp63vKOlXuWHzmF7ZKrJmL51I9iT9Tg5mYMqE1U4Atx6RMFxaS0+qG0NGZI/oGB4fUX0
 X6S/Nvr72po59Kiz36Bv70LtPik4HSU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-MChlWZTgMPWKR6rUC3qOWQ-1; Wed,
 22 Oct 2025 08:19:07 -0400
X-MC-Unique: MChlWZTgMPWKR6rUC3qOWQ-1
X-Mimecast-MFC-AGG-ID: MChlWZTgMPWKR6rUC3qOWQ_1761135546
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DDAC1956094; Wed, 22 Oct 2025 12:19:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56CD81800452; Wed, 22 Oct 2025 12:19:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <levon@movementarian.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/12] vfio/container: Support unmap all in one ioctl()
Date: Wed, 22 Oct 2025 14:18:40 +0200
Message-ID: <20251022121846.874152-7-clg@redhat.com>
In-Reply-To: <20251022121846.874152-1-clg@redhat.com>
References: <20251022121846.874152-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

VFIO type1 kernel uAPI supports unmapping whole address space in one call
since commit c19650995374 ("vfio/type1: implement unmap all"). Use the
unmap_all variant whenever it's supported in kernel.

Opportunistically pass VFIOLegacyContainer pointer in low level function
vfio_legacy_dma_unmap_one().

Co-developed-by: John Levon <levon@movementarian.org>
Signed-off-by: John Levon <levon@movementarian.org>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251009040134.334251-2-zhenzhong.duan@intel.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-legacy.h |  1 +
 hw/vfio/container-legacy.c              | 38 ++++++++++++++-----------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-container-legacy.h b/include/hw/vfio/vfio-container-legacy.h
index 74a72df018b50490b95d80044a31247ba7c9fc3b..ffd594e80d64ee11ebc48940bc481b9aafc127d4 100644
--- a/include/hw/vfio/vfio-container-legacy.h
+++ b/include/hw/vfio/vfio-container-legacy.h
@@ -30,6 +30,7 @@ struct VFIOLegacyContainer {
 
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
+    bool unmap_all_supported;
     QLIST_HEAD(, VFIOGroup) group_list;
     VFIOContainerCPR cpr;
 };
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index a3615d7b5dba8fce2f633e986036241e3cfd935d..8e9639603e08b2e1b13f1cd2ca51cc3e48913135 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -121,14 +121,14 @@ unmap_exit:
     return ret;
 }
 
-static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
+static int vfio_legacy_dma_unmap_one(const VFIOLegacyContainer *container,
                                      hwaddr iova, uint64_t size,
-                                     IOMMUTLBEntry *iotlb)
+                                     uint32_t flags, IOMMUTLBEntry *iotlb)
 {
-    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    const VFIOContainer *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
-        .flags = 0,
+        .flags = flags,
         .iova = iova,
         .size = size,
     };
@@ -170,25 +170,28 @@ static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
                                  hwaddr iova, uint64_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
+    const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
+    uint32_t flags = 0;
     int ret;
 
     if (unmap_all) {
-        /* The unmap ioctl doesn't accept a full 64-bit span. */
-        Int128 llsize = int128_rshift(int128_2_64(), 1);
-
-        ret = vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsize),
-                                        iotlb);
+        if (container->unmap_all_supported) {
+            flags = VFIO_DMA_UNMAP_FLAG_ALL;
+        } else {
+            /* The unmap ioctl doesn't accept a full 64-bit span. */
+            Int128 llsize = int128_rshift(int128_2_64(), 1);
+            size = int128_get64(llsize);
+
+            ret = vfio_legacy_dma_unmap_one(container, 0, size, flags, iotlb);
+            if (ret) {
+                return ret;
+            }
 
-        if (ret == 0) {
-            ret = vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsize),
-                                            int128_get64(llsize), iotlb);
+            iova = size;
         }
-
-    } else {
-        ret = vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
     }
 
-    return ret;
+    return vfio_legacy_dma_unmap_one(container, iova, size, flags, iotlb);
 }
 
 static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
@@ -519,6 +522,9 @@ static bool vfio_legacy_setup(VFIOContainer *bcontainer, Error **errp)
 
     vfio_get_info_iova_range(info, bcontainer);
 
+    ret = ioctl(container->fd, VFIO_CHECK_EXTENSION, VFIO_UNMAP_ALL);
+    container->unmap_all_supported = !!ret;
+
     vfio_get_iommu_info_migration(container, info);
     return true;
 }
-- 
2.51.0


