Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8440CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1y8W-0003B3-HN; Thu, 25 Sep 2025 22:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8Q-0003AF-E8
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:37 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y88-0005Tq-Hm
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853457; x=1790389457;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wqf9XxMFx79DZt3tOTlC5BM5VOswE/tbH0hiNkN3rWk=;
 b=PR0uvVkehrg22hQV98snGHj13qUSd/6jYmJYDsTz6Sr3YJoVDaTR7M+Q
 ZiwUGfQE1nDq9m43xjKbnJPqr+6BEv4V900YLvATa8m7yUG1ZsC/CbKA+
 CZa30LoFaqlaUmFMbymlMkukDRLjbGmSz3oaHjZIcR+7gISyeMU0ZcMQd
 AN4cvzuPXE6wZPJEACp4Ovq9GlnsM5hrTK5/Vm8GTrtP8beoOp2V1n62U
 W/GwVe4qRBaMN3UfRlU8UeULay39BaOTyQcas3z1LYhaymydHztfFKIwQ
 iwbyYrIhDmz8y8cvr7O/47NkGpb7AFVdqYJOKEnp/Njqt67xMwHaVH+v7 w==;
X-CSE-ConnectionGUID: CWUU/kiOQEuVeGpFYnm4Gg==
X-CSE-MsgGUID: BUmcq3s3QhyqkN4EKecVnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61234084"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="61234084"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:04 -0700
X-CSE-ConnectionGUID: JzdreEj1QjqPfnqsfNLmMQ==
X-CSE-MsgGUID: HRh58+dNQOOpCcMtie+Dlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="176613439"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:01 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 1/5] vfio/container: Remap only populated parts in a section
Date: Thu, 25 Sep 2025 22:23:44 -0400
Message-ID: <20250926022348.1883776-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

If there are multiple containers and unmap-all fails for some of them, we
need to remap vaddr for the other containers for which unmap-all succeeded.
When ram discard is enabled, we should only remap populated parts in a
section instead of the whole section.

Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  2 +-
 hw/vfio/cpr-legacy.c       | 20 +++++++++++++++-----
 hw/vfio/listener.c         |  4 ++--
 3 files changed, 18 insertions(+), 8 deletions(-)

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
index 8f437194fa..3ea24d60de 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -224,22 +224,32 @@ void vfio_cpr_giommu_remap(VFIOContainerBase *bcontainer,
     memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 }
 
+static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
+{
+    RamDiscardListener *rdl = opaque;
+
+    return rdl->notify_populate(rdl, section);
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
index e093833165..799552781f 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -577,8 +577,8 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
             if (!vfio_ram_discard_register_listener(bcontainer, section, &err)) {
                 goto fail;
             }
-        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
-                                                           section)) {
+        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
+                                                          section)) {
             error_setg(&err,
                        "vfio_cpr_ram_discard_register_listener for %s failed",
                        memory_region_name(section->mr));
-- 
2.47.1


