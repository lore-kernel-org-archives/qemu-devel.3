Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AA9C25B5F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 06:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4EZw-0003Nf-8x; Tue, 07 May 2024 02:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZt-0003MS-2q; Tue, 07 May 2024 02:45:29 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4EZr-0005Ee-1S; Tue, 07 May 2024 02:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715064327; x=1746600327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Fr2V/QTY5Uvx5YftWpQRTt6S3xGiOTCE5jGwZtbQdsU=;
 b=fiidDAv9+HykJmFHcnfnh69OL21pG8JjPmYhZ8UmTiEavxCjKq4qOyPU
 JravKaMoaCFBmNZLI/lWoCbYP/drn1Hymnpoqc28tXm3v6nKchlA4R3EV
 QLxdVta7uCewkngzzEGxEFpOEQorYuyornpqOma3j6qlv7YnMeVYUuwkC
 EJTsY36e2nzKAaIQxulefDfaT4pFkLx32Py1q+uDje2WSRTiOktfvHX85
 gsewzf+SBccZTK3vgeweO5pw9WOYUFMbVdki2BMpFoIsHvuvwnCcLnxxh
 zyBZMHs9P851EWwNjYxDk7nPNCakUixFh8PxDwYFovInf0n6S7NH5ozG5 w==;
X-CSE-ConnectionGUID: 1bSqa3PaSXmWWyyHGpUb3g==
X-CSE-MsgGUID: t7AG60xSQHeusECym9lPMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="22240250"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="22240250"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:25 -0700
X-CSE-ConnectionGUID: IhIgOb1yRqumB+oXQPqczg==
X-CSE-MsgGUID: 9S4wHYRaQpauabDbvHWNXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28407526"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 23:45:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v2 05/11] vfio: Make VFIOIOMMUClass::add_window() and its
 wrapper return bool
Date: Tue,  7 May 2024 14:42:46 +0800
Message-Id: <20240507064252.457884-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507064252.457884-1-zhenzhong.duan@intel.com>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make VFIOIOMMUClass::add_window() and its wrapper function
vfio_container_add_section_window() return bool.

This is to follow the coding standand to return bool if 'Error **'
is used to pass error.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-container-base.h | 12 ++++++------
 hw/vfio/common.c                      |  2 +-
 hw/vfio/container-base.c              |  8 ++++----
 hw/vfio/spapr.c                       | 16 ++++++++--------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 68539e3bed..e96cda78c8 100644
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
@@ -131,9 +131,9 @@ struct VFIOIOMMUClass {
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
index 890d30910e..9f1f2e19f7 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -585,7 +585,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (vfio_container_add_section_window(bcontainer, section, &err)) {
+    if (!vfio_container_add_section_window(bcontainer, section, &err)) {
         goto fail;
     }
 
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 913ae49077..98d71b3144 100644
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
index 148b257c9c..47b040f1bc 100644
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
2.34.1


