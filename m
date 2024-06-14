Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C921C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3dz-0006IU-65; Fri, 14 Jun 2024 05:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dx-0006Gy-5J
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dv-0003e0-Hq
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chQAASCdJMVJpwPeCfLJqL1+p+AwMmYdve8qkSRIxgs=;
 b=C1yaVUJ1/V0+9QaZfC/Uv0A+R1S3kGQF7H71lJ741salnnWhh8ZhyNgaCwkcExkDNcaj32
 OrkW+2XgkxNIps2M4pfmZp1BR87/eD/xZdAVfsO6Q7IrkP1s7MazOriCtlTykSze9IlYUU
 YESax89MAgjBY9nAZBGgsQ0KMaGCWbo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-JHbAOESMNcKgA_Em8MzUYQ-1; Fri,
 14 Jun 2024 05:54:45 -0400
X-MC-Unique: JHbAOESMNcKgA_Em8MzUYQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9DDC195608B; Fri, 14 Jun 2024 09:54:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B2AB3000219; Fri, 14 Jun 2024 09:54:39 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v4 6/8] virtio-iommu: Remove the implementation of
 iommu_set_iova_range
Date: Fri, 14 Jun 2024 11:52:56 +0200
Message-ID: <20240614095402.904691-7-eric.auger@redhat.com>
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
References: <20240614095402.904691-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
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

Now that we use PCIIOMMUOps to convey information about usable IOVA
ranges we do not to implement the iommu_set_iova_ranges IOMMU MR
callback.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/virtio/virtio-iommu.c | 67 ----------------------------------------
 1 file changed, 67 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a4c0cceb65..b9a7ddcd14 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1351,72 +1351,6 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     return 0;
 }
 
-/**
- * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
- *
- * The function turns those into reserved ranges. Once some
- * reserved ranges have been set, new reserved regions cannot be
- * added outside of the original ones.
- *
- * @mr: IOMMU MR
- * @iova_ranges: list of usable IOVA ranges
- * @errp: error handle
- */
-static int virtio_iommu_set_iova_ranges(IOMMUMemoryRegion *mr,
-                                        GList *iova_ranges,
-                                        Error **errp)
-{
-    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
-    GList *current_ranges = sdev->host_resv_ranges;
-    GList *l, *tmp, *new_ranges = NULL;
-    int ret = -EINVAL;
-
-    /* check that each new resv region is included in an existing one */
-    if (sdev->host_resv_ranges) {
-        range_inverse_array(iova_ranges,
-                            &new_ranges,
-                            0, UINT64_MAX);
-
-        for (tmp = new_ranges; tmp; tmp = tmp->next) {
-            Range *newr = (Range *)tmp->data;
-            bool included = false;
-
-            for (l = current_ranges; l; l = l->next) {
-                Range * r = (Range *)l->data;
-
-                if (range_contains_range(r, newr)) {
-                    included = true;
-                    break;
-                }
-            }
-            if (!included) {
-                goto error;
-            }
-        }
-        /* all new reserved ranges are included in existing ones */
-        ret = 0;
-        goto out;
-    }
-
-    if (sdev->probe_done) {
-        warn_report("%s: Notified about new host reserved regions after probe",
-                    mr->parent_obj.name);
-    }
-
-    range_inverse_array(iova_ranges,
-                        &sdev->host_resv_ranges,
-                        0, UINT64_MAX);
-    rebuild_resv_regions(sdev);
-
-    return 0;
-error:
-    error_setg(errp, "IOMMU mr=%s Conflicting host reserved ranges set!",
-               mr->parent_obj.name);
-out:
-    g_list_free_full(new_ranges, g_free);
-    return ret;
-}
-
 static void virtio_iommu_system_reset(void *opaque)
 {
     VirtIOIOMMU *s = opaque;
@@ -1742,7 +1676,6 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
     imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
-    imrc->iommu_set_iova_ranges = virtio_iommu_set_iova_ranges;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
2.41.0


