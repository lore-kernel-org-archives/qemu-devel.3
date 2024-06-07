Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE8C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:30:12 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFakn-00065X-AE; Fri, 07 Jun 2024 10:39:41 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sFakl-00064L-GL
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sFakk-0003Ot-0I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717771177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eSM5FRhnse3Lv4Qk6nprGOWP6AKz6doiUgfqyn8MOXg=;
 b=VpHP7AjSb3SqyxbLlHeOFDbfzadhvZIsZhXLx7vJbB1xBVQbfqJNszNlbvvzjMunRxc8mE
 O/ZhqCa+YnI7vIq51cfOYixI8ZCc1ZerP85SvurXa6CGI0DcleG5SXzUA04CLZKKqpTtNn
 xHzo08JQ9OwNiyU14Rk+2DUz/IrkeWc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-mSd1nHcBOq6ZPOvqG4jeSw-1; Fri,
 07 Jun 2024 10:39:34 -0400
X-MC-Unique: mSd1nHcBOq6ZPOvqG4jeSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9767719560B9; Fri,  7 Jun 2024 14:39:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 069D71956048; Fri,  7 Jun 2024 14:39:26 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 imammedo@redhat.com, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
Subject: [RFC v2 3/7] HostIOMMUDevice: Introduce get_iova_ranges callback
Date: Fri,  7 Jun 2024 16:37:23 +0200
Message-ID: <20240607143905.765133-4-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-1-eric.auger@redhat.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
 include/sysemu/host_iommu_device.h |  8 ++++++++
 hw/vfio/container.c                | 14 ++++++++++++++
 hw/vfio/iommufd.c                  | 14 ++++++++++++++
 3 files changed, 36 insertions(+)

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
index b728b978a2..edd0df6262 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1164,12 +1164,26 @@ static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
     }
 }
 
+static GList *
+hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+{
+    VFIODevice *vdev = hiod->agent;
+    GList *l = NULL;
+
+    if (vdev && vdev->bcontainer) {
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
index dbdae1adbb..1706784063 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -645,11 +645,25 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static GList *
+hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
+{
+    VFIODevice *vdev = hiod->agent;
+    GList *l = NULL;
+
+    if (vdev && vdev->bcontainer) {
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


