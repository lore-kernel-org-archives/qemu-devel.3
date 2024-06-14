Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D1C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3eF-0006q4-PR; Fri, 14 Jun 2024 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3eD-0006ny-Gi
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3eB-0003j5-RN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v4oXJbwUkpDdsYRWNM4Mzh6/AZK1mQcxllmiQmlMU+k=;
 b=TGgPHFEHunb8RMgW/o2AQa84XJ/jGrRSD+FazYq9WumRjFOhgsWop0FSxnp6dyqUkoAtIg
 XG/eiTBCYOSA+5XwNtcwHZvrHIwzVK9o0qZfy5FN3h8Wue7tueJpk891SW9SVZCxoa1Kuw
 /H3IXikcP7dbwVb27z0CYgzk2/D+DDI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-ZC8DzpmFN7ew3_xGZKuyFw-1; Fri,
 14 Jun 2024 05:54:58 -0400
X-MC-Unique: ZC8DzpmFN7ew3_xGZKuyFw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1196419560AE; Fri, 14 Jun 2024 09:54:57 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE7E43000219; Fri, 14 Jun 2024 09:54:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v4 8/8] memory: Remove IOMMU MR iommu_set_iova_range API
Date: Fri, 14 Jun 2024 11:52:58 +0200
Message-ID: <20240614095402.904691-9-eric.auger@redhat.com>
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
References: <20240614095402.904691-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Since the host IOVA ranges are now passed through the
PCIIOMMUOps set_host_resv_regions and we have removed
the only implementation of iommu_set_iova_range() in
the virtio-iommu and the only call site in vfio/common,
let's retire the IOMMU MR API and its memory wrapper.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/exec/memory.h | 32 --------------------------------
 system/memory.c       | 13 -------------
 2 files changed, 45 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 1be58f694c..ed40f74460 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -530,26 +530,6 @@ struct IOMMUMemoryRegionClass {
      int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
                                      uint64_t page_size_mask,
                                      Error **errp);
-    /**
-     * @iommu_set_iova_ranges:
-     *
-     * Propagate information about the usable IOVA ranges for a given IOMMU
-     * memory region. Used for example to propagate host physical device
-     * reserved memory region constraints to the virtual IOMMU.
-     *
-     * Optional method: if this method is not provided, then the default IOVA
-     * aperture is used.
-     *
-     * @iommu: the IOMMUMemoryRegion
-     *
-     * @iova_ranges: list of ordered IOVA ranges (at least one range)
-     *
-     * Returns 0 on success, or a negative error. In case of failure, the error
-     * object must be created.
-     */
-     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
-                                  GList *iova_ranges,
-                                  Error **errp);
 };
 
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1951,18 +1931,6 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
                                            uint64_t page_size_mask,
                                            Error **errp);
 
-/**
- * memory_region_iommu_set_iova_ranges - Set the usable IOVA ranges
- * for a given IOMMU MR region
- *
- * @iommu: IOMMU memory region
- * @iova_ranges: list of ordered IOVA ranges (at least one range)
- * @errp: pointer to Error*, to store an error if it happens.
- */
-int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu,
-                                        GList *iova_ranges,
-                                        Error **errp);
-
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/system/memory.c b/system/memory.c
index 74cd73ebc7..336ad5da5f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1914,19 +1914,6 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
-int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu_mr,
-                                        GList *iova_ranges,
-                                        Error **errp)
-{
-    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
-    int ret = 0;
-
-    if (imrc->iommu_set_iova_ranges) {
-        ret = imrc->iommu_set_iova_ranges(iommu_mr, iova_ranges, errp);
-    }
-    return ret;
-}
-
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
-- 
2.41.0


