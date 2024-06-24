Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E798C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrBk-0002l8-RI; Mon, 24 Jun 2024 17:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBj-0002kz-61
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrBh-0006Ya-Kh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=67H4K4vQadrsCWH6HvXjBpkOvGs7cJo8u3wWL2Si11w=;
 b=eC4aLqb8/l5QokxwSQW34BsHrr15xE3OmaJ1xd2AujKktbwBf6mgjYTkZrUn/25JV9ZE5Z
 B7BlIg0KRlozQq+JMbfOLBNoI2CccyvFouAgbAu9jDf1CQsHl4RqWOOb61S2r05wCX7LKb
 zDKqA4WWdxEzvYimuwzi8GlTafQmGgE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Z8pvS8nmOjOUR7DqtgKKMQ-1; Mon,
 24 Jun 2024 17:25:18 -0400
X-MC-Unique: Z8pvS8nmOjOUR7DqtgKKMQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBBE219560AF; Mon, 24 Jun 2024 21:25:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B32401956051; Mon, 24 Jun 2024 21:25:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 06/42] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Mon, 24 Jun 2024 23:24:20 +0200
Message-ID: <20240624212456.350919-7-clg@redhat.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

The realize function populates the capabilities. For now only the
aw_bits caps is computed for legacy backend.

Introduce a helper function vfio_device_get_aw_bits() which calls
range_get_last_bit() to get host aw_bits and package it in
HostIOMMUDeviceCaps for query with .get_cap(). This helper will
also be used by iommufd backend.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/container.c           | 19 +++++++++++++++++++
 hw/vfio/helpers.c             | 17 +++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 56d171721164991b408073488330bf1d79104970..105b8b7e804d3de43868d447e21eb9bedc50808f 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -289,4 +289,5 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
 void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
 void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
                       DeviceState *dev, bool ram_discard);
+int vfio_device_get_aw_bits(VFIODevice *vdev);
 #endif /* HW_VFIO_VFIO_COMMON_H */
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c4fca2dfcab32781fb301181a1ef67238015a76f..2f62c13214412618b412240b61efcbe1b1c79ed5 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1136,6 +1136,24 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                     Error **errp)
+{
+    VFIODevice *vdev = opaque;
+
+    hiod->name = g_strdup(vdev->name);
+    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
+
+    return true;
+}
+
+static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->realize = hiod_legacy_vfio_realize;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
@@ -1144,6 +1162,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_legacy_vfio_class_init,
     }
 };
 
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 27ea26aa48f67e6518f871ac651ab8d2703cc611..b14edd46edc9069bb148359a1b419253ff4e5ef0 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -658,3 +658,20 @@ void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
 
     vbasedev->ram_block_discard_allowed = ram_discard;
 }
+
+int vfio_device_get_aw_bits(VFIODevice *vdev)
+{
+    /*
+     * iova_ranges is a sorted list. For old kernels that support
+     * VFIO but not support query of iova ranges, iova_ranges is NULL,
+     * in this case HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX(64) is returned.
+     */
+    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
+
+    if (l) {
+        Range *range = l->data;
+        return range_get_last_bit(range) + 1;
+    }
+
+    return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
+}
-- 
2.45.2


