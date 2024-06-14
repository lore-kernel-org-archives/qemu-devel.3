Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826C5C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 09:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI3do-0006EY-4y; Fri, 14 Jun 2024 05:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dm-0006Dq-Bd
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sI3dk-0003ag-KH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 05:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718358876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSRIdmiUClQ9pX7X/Y3xsraO5rrerhKvl7FyHzAs9PE=;
 b=bnbc2AbyOS6P3PEvtGWYRsPXkx3Yfkz3w+PBAEJ8XUkKIRVJUBdQGTwf5K10uKuOBQu3VF
 Uh0DECv+iJCYagvoLBNjWA4Bsj/kw5zgeMRES4t/ZXu9ewy4MeLYEjK3nnx5HBBiKHE2jt
 Fzx6VTK7I6Z2XbR3Nd3HF04sN0MfTmM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-EWmWORHBOCu96nOiAfpaFg-1; Fri,
 14 Jun 2024 05:54:30 -0400
X-MC-Unique: EWmWORHBOCu96nOiAfpaFg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ABD719560B0; Fri, 14 Jun 2024 09:54:29 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F13E33000222; Fri, 14 Jun 2024 09:54:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 peter.maydell@linaro.org, clg@redhat.com, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [PATCH v4 3/8] HostIOMMUDevice: Introduce get_iova_ranges callback
Date: Fri, 14 Jun 2024 11:52:53 +0200
Message-ID: <20240614095402.904691-4-eric.auger@redhat.com>
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

Introduce a new HostIOMMUDevice callback that allows to
retrieve the usable IOVA ranges.

Implement this callback in the legacy VFIO and IOMMUFD VFIO
host iommu devices. This relies on the VFIODevice agent's
base container iova_ranges resource.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

---

v2 -> v3:
- add g_assert(vdev)
---
 include/sysemu/host_iommu_device.h |  8 ++++++++
 hw/vfio/container.c                | 16 ++++++++++++++++
 hw/vfio/iommufd.c                  | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 3e5f058e7b..40e0fa13ef 100644
--- a/include/sysemu/host_iommu_device.h
+++ b/include/sysemu/host_iommu_device.h
@@ -80,6 +80,14 @@ struct HostIOMMUDeviceClass {
      * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
      */
     int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
+    /**
+     * @get_iova_ranges: Return the list of usable iova_ranges along with
+     * @hiod Host IOMMU device
+     *
+     * @hiod: handle to the host IOMMU device
+     * @errp: error handle
+     */
+    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);
 };
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index b728b978a2..c48749c089 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1164,12 +1164,28 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
     }
 }
 
+static GList *
+hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+{
+    VFIODevice *vdev = hiod->agent;
+    GList *l = NULL;
+
+    g_assert(vdev);
+
+    if (vdev->bcontainer) {
+        l = g_list_copy(vdev->bcontainer->iova_ranges);
+    }
+
+    return l;
+}
+
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->realize = hiod_legacy_vfio_realize;
     hioc->get_cap = hiod_legacy_vfio_get_cap;
+    hioc->get_iova_ranges = hiod_legacy_vfio_get_iova_ranges;
 };
 
 static const TypeInfo types[] = {
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index dbdae1adbb..e502081c2a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -645,11 +645,27 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static GList *
+hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+{
+    VFIODevice *vdev = hiod->agent;
+    GList *l = NULL;
+
+    g_assert(vdev);
+
+    if (vdev->bcontainer) {
+        l = g_list_copy(vdev->bcontainer->iova_ranges);
+    }
+
+    return l;
+}
+
 static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hiodc->realize = hiod_iommufd_vfio_realize;
+    hiodc->get_iova_ranges = hiod_iommufd_vfio_get_iova_ranges;
 };
 
 static const TypeInfo types[] = {
-- 
2.41.0


