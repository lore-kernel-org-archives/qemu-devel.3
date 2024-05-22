Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F45C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 09:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9ihC-0003cl-1N; Wed, 22 May 2024 05:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9ih0-0003XY-Sy
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s9igx-0001iu-IS
 for qemu-devel@nongnu.org; Wed, 22 May 2024 05:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716371727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EKvPDWgFPSPC8JKnCi/wa4wS5hggDzLtJx0kiZlHEPA=;
 b=YrfA9JoCvng01vumpOX+6p3GtED+yhiLEct9VSzC7OeKOcro5mmrLM77zkONZmg6XXOBlz
 Lz9jGG5k9w6f9pxQnuvsWlA01vuy2Q+nA+VCHmNNXtMbxOEJ9idDojhB/09KqcBBiMmtSx
 phJT3/x+YIFNuFziHd7Seery4fm22zg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-aZX8qPCUOgGlfzmxjjRkGw-1; Wed,
 22 May 2024 05:55:23 -0400
X-MC-Unique: aZX8qPCUOgGlfzmxjjRkGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED89A29AA3B4;
 Wed, 22 May 2024 09:55:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC00651BF;
 Wed, 22 May 2024 09:55:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/47] vfio: Make VFIOIOMMUClass::add_window() and its wrapper
 return bool
Date: Wed, 22 May 2024 11:54:18 +0200
Message-ID: <20240522095442.195243-24-clg@redhat.com>
In-Reply-To: <20240522095442.195243-1-clg@redhat.com>
References: <20240522095442.195243-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Make VFIOIOMMUClass::add_window() and its wrapper function
vfio_container_add_section_window() return bool.

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 12 ++++++------
 hw/vfio/common.c                      |  2 +-
 hw/vfio/container-base.c              |  8 ++++----
 hw/vfio/spapr.c                       | 16 ++++++++--------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 202e23cb6b800983b036bf3808c0ec38b1c363d0..2776481fc97ef5720b10a4e3b3e6deaa075ece75 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -76,9 +76,9 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
-int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
-                                      MemoryRegionSection *section,
-                                      Error **errp);
+bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section,
+                                       Error **errp);
 void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
                                        MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
@@ -156,9 +156,9 @@ struct VFIOIOMMUClass {
     int (*pci_hot_reset)(VFIODevice *vbasedev, bool single);
 
     /* SPAPR specific */
-    int (*add_window)(VFIOContainerBase *bcontainer,
-                      MemoryRegionSection *section,
-                      Error **errp);
+    bool (*add_window)(VFIOContainerBase *bcontainer,
+                       MemoryRegionSection *section,
+                       Error **errp);
     void (*del_window)(VFIOContainerBase *bcontainer,
                        MemoryRegionSection *section);
     void (*release)(VFIOContainerBase *bcontainer);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c04a259ffd7cfcfba480335bea1ddff787f47bdc..f9619a1dfbc689b10d70a60ce21b9b018f32391f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -588,7 +588,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (vfio_container_add_section_window(bcontainer, section, &err)) {
+    if (!vfio_container_add_section_window(bcontainer, section, &err)) {
         goto fail;
     }
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 26f4bb464a720c9895b35c7c9e01c84d6322c3c9..760d9d0622b2e847ecb3368c88df772efb06043f 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -31,12 +31,12 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
-int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
-                                      MemoryRegionSection *section,
-                                      Error **errp)
+bool vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section,
+                                       Error **errp)
 {
     if (!bcontainer->ops->add_window) {
-        return 0;
+        return true;
     }
 
     return bcontainer->ops->add_window(bcontainer, section, errp);
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 148b257c9ca6a0f957115f8060ddb50e377dfcb8..47b040f1bcca7dd0b5cf052d941b43541e98a3c5 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -323,7 +323,7 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
-static int
+static bool
 vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                         MemoryRegionSection *section,
                                         Error **errp)
@@ -351,13 +351,13 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
             error_setg(errp, "Container %p can't map guest IOVA region"
                        " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container,
                        iova, end);
-            return -EINVAL;
+            return false;
         }
-        return 0;
+        return true;
     }
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
-        return 0;
+        return true;
     }
 
     /* For now intersections are not allowed, we may relax this later */
@@ -373,14 +373,14 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                 section->offset_within_address_space +
                     int128_get64(section->size) - 1,
                 hostwin->min_iova, hostwin->max_iova);
-            return -EINVAL;
+            return false;
         }
     }
 
     ret = vfio_spapr_create_window(container, section, &pgsize);
     if (ret) {
         error_setg_errno(errp, -ret, "Failed to create SPAPR window");
-        return ret;
+        return false;
     }
 
     vfio_host_win_add(scontainer, section->offset_within_address_space,
@@ -406,14 +406,14 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
                                      "vfio: failed GROUP_SET_SPAPR_TCE for "
                                      "KVM VFIO device %d and group fd %d",
                                      param.tablefd, param.groupfd);
-                    return -errno;
+                    return false;
                 }
                 trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
             }
         }
     }
 #endif
-    return 0;
+    return true;
 }
 
 static void
-- 
2.45.1


