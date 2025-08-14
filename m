Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B67EC87FCF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 03:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umOaH-00058T-IH; Wed, 13 Aug 2025 23:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1umOaC-00057w-L3
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 23:24:52 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1umOa4-0002F9-OS
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 23:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755141884; x=1786677884;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1tdT54uzOJZBxej3PiIXT4VnoBtYHFO6CoLN5BtzElM=;
 b=UAg2xECtHC/+t1+8HdHSkepaCt5/VeSrIJfUgE28o3DBN3JoPyqwvaI+
 0JzEJ8yxeE6tqKzGNiiKgPGYuBnwgHX37DzEz3/gyVmq+QyPYeC0XQBE+
 5Vt3YXlKuEZfGWn12foO5rN7dcxIw9ByW4hnX/PNSjoGBKs27LGx/S0xi
 iDC64aSDoKlG7bqHLb2vFKzs+YBxkxN7C/DKz0tQmxCvP7tJg7nSMW9EE
 XiitU8HPUTdCJetv5FDZuuY44AFqHXJWZxTAK/RStxL2pwr1UsxHF26ho
 pi5tidxuPZh7FB+EAKrF+AzNV15iXJR4gdHGkvCUdibGhwYQu+ssavnYE A==;
X-CSE-ConnectionGUID: eSrFjgpZQLWMfuGpdcxKoQ==
X-CSE-MsgGUID: TtMZK5BJR0u/Ij6uq3Yv2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61254363"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="61254363"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 20:24:42 -0700
X-CSE-ConnectionGUID: ZB2a1hSnQ+GswXd8BWlUsQ==
X-CSE-MsgGUID: c2+EruQQTgW6Zcxhv1qS8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="167447909"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2025 20:24:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/container: Remap only populated parts in a section
Date: Wed, 13 Aug 2025 23:24:14 -0400
Message-ID: <20250814032414.301387-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

If there are multiple containers and unmap-all fails for some container, we
need to remap vaddr for the other containers for which unmap-all succeeded.
When ram discard is enabled, we should only remap populated parts in a
section instead of the whole section.

Export vfio_ram_discard_notify_populate() and use it to do population.

Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
btw: I didn't find easy to test this corner case, only code inspecting

 include/hw/vfio/vfio-container-base.h |  3 +++
 include/hw/vfio/vfio-cpr.h            |  2 +-
 hw/vfio/cpr-legacy.c                  | 19 ++++++++++++++-----
 hw/vfio/listener.c                    |  8 ++++----
 4 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index bded6e993f..3f0c085143 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -269,6 +269,9 @@ struct VFIOIOMMUClass {
     void (*release)(VFIOContainerBase *bcontainer);
 };
 
+int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
+                                     MemoryRegionSection *section);
+
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index d37daffbc5..fb32a5f873 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -67,7 +67,7 @@ bool vfio_cpr_container_match(struct VFIOContainer *container,
 void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
                            MemoryRegionSection *section);
 
-bool vfio_cpr_ram_discard_register_listener(
+bool vfio_cpr_ram_discard_replay_populated(
     struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 553b203e9b..6909c0a616 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -224,22 +224,31 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
     memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 }
 
+static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
+{
+    RamDiscardListener *rdl = opaque;
+    return vfio_ram_discard_notify_populate(rdl, section);
+}
+
 /*
  * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
  * succeeding for others, so the latter have lost their vaddr.  Call this
- * to restore vaddr for a section with a RamDiscardManager.
+ * to restore vaddr for populated parts in a section with a RamDiscardManager.
  *
- * The ram discard listener already exists.  Call its populate function
+ * The ram discard listener already exists.  Call its replay_populated function
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
-bool vfio_cpr_ram_discard_register_listener(VFIOContainerBase *bcontainer,
-                                            MemoryRegionSection *section)
+bool vfio_cpr_ram_discard_replay_populated(VFIOContainerBase *bcontainer,
+                                           MemoryRegionSection *section)
 {
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl =
         vfio_find_ram_discard_listener(bcontainer, section);
 
     g_assert(vrdl);
-    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
+    return ram_discard_manager_replay_populated(rdm, section,
+                                                vfio_cpr_rdm_remap,
+                                                &vrdl->listener) == 0;
 }
 
 int vfio_cpr_group_get_device_fd(int d, const char *name)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f498e23a93..74837c1122 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -215,8 +215,8 @@ static void vfio_ram_discard_notify_discard(RamDiscardListener *rdl,
     }
 }
 
-static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
-                                            MemoryRegionSection *section)
+int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
+                                     MemoryRegionSection *section)
 {
     VFIORamDiscardListener *vrdl = container_of(rdl, VFIORamDiscardListener,
                                                 listener);
@@ -572,8 +572,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
     if (memory_region_has_ram_discard_manager(section->mr)) {
         if (!cpr_remap) {
             vfio_ram_discard_register_listener(bcontainer, section);
-        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
-                                                           section)) {
+        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
+                                                          section)) {
             goto fail;
         }
         return;
-- 
2.47.1


