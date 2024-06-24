Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090BEC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCL-0003fx-MI; Mon, 24 Jun 2024 17:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCK-0003fM-8K
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCI-0006gx-Op
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZPKqL7G6cwgWQyYtyd/joq+TFlRAjLyzq5bwVaVgNU=;
 b=WCE9S+KVgEC0ncyCZu8lwfaM0WEl5jqd/jTHyoUAzTkuKF98ajniEDlVJxO9xw85KBd0ec
 +EXkvSPitiLr2wVtsaPS0dvsjBpw/TBILlAhSzJYHipmUPGK8Oxx/PQ2RvX4tz0GqQiaT/
 4VABF65Svxpcbd3sbztbxl8pEK24t6A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-iA4eym7OOlC3wzk_OJNtaA-1; Mon,
 24 Jun 2024 17:25:54 -0400
X-MC-Unique: iA4eym7OOlC3wzk_OJNtaA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EA1519560AB; Mon, 24 Jun 2024 21:25:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 67A501956051; Mon, 24 Jun 2024 21:25:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 20/42] HostIOMMUDevice: Introduce get_iova_ranges callback
Date: Mon, 24 Jun 2024 23:24:34 +0200
Message-ID: <20240624212456.350919-21-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Introduce a new HostIOMMUDevice callback that allows to
retrieve the usable IOVA ranges.

Implement this callback in the legacy VFIO and IOMMUFD VFIO
host iommu devices. This relies on the VFIODevice agent's
base container iova_ranges resource.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/sysemu/host_iommu_device.h |  8 ++++++++
 hw/vfio/container.c                | 16 ++++++++++++++++
 hw/vfio/iommufd.c                  | 16 ++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
index 3e5f058e7ba80491eae04dc73c6957f7269150cf..40e0fa13efb5c023bc9b46fc99bf553cb93adf24 100644
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
index b728b978a26d49b5a2895fd4d1add8f0a57787ad..c48749c089a67ee4d0e6b8dd975562e2938500cd 100644
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
index dbdae1adbb66f9c8547659320ce4436825efe1a1..e502081c2ad9eda31769176f875fef60a77e2b43 100644
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
2.45.2


