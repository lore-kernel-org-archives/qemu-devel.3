Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770FEC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNaL-00054L-Rh; Fri, 09 May 2025 09:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYZ-0001pn-Vd
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYX-00079i-Qg
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Klz5oLzNjXEG77/RbmGS07w+vwqadNlGeKOMWqsRSk=;
 b=dYiuVEHou/n4NSO9lnSD8i8jcfbi5tFP78ccJB9yvI1gYz5+WmtGEhxTQMov7Myj+i+kZ9
 dcYg6M++WZpHjdWJ3ZfK2u5530Pf6WLCLXiGo4U54kzTe33oJfQh2WdddLuSyEbISlFb3S
 seWQYvDP9S7MHNPA6FZU+kd6o0/Fc0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-hYyL9vApN-ad8gPdscypjg-1; Fri,
 09 May 2025 09:14:19 -0400
X-MC-Unique: hYyL9vApN-ad8gPdscypjg-1
X-Mimecast-MFC-AGG-ID: hYyL9vApN-ad8gPdscypjg_1746796458
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8F7D1800446; Fri,  9 May 2025 13:14:18 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA31E180045B; Fri,  9 May 2025 13:14:16 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/28] vfio: add vfio_attach_device_by_iommu_type()
Date: Fri,  9 May 2025 15:13:06 +0200
Message-ID: <20250509131317.164235-18-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

Allow attachment by explicitly passing a TYPE_VFIO_IOMMU_* string;
vfio-user will use this later.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20250507152020.1254632-4-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-device.h |  3 +++
 hw/vfio/device.c              | 22 +++++++++++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index 342c4ba3bfec8d143a297203dbfa0e6f6fae3535..8b1437ba6654d08f65740f42dc3a50775d7f5cc1 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -127,6 +127,9 @@ bool vfio_device_hiod_create_and_realize(VFIODevice *vbasedev,
                                          const char *typename, Error **errp);
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp);
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp);
 void vfio_device_detach(VFIODevice *vbasedev);
 VFIODevice *vfio_get_vfio_device(Object *obj);
 
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 31c441a3dfffdf459994407904ab78b1798bf979..9673b0717ead435e117d8084720fde4ba3a13dd8 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -376,21 +376,29 @@ VFIODevice *vfio_get_vfio_device(Object *obj)
     }
 }
 
-bool vfio_device_attach(char *name, VFIODevice *vbasedev,
-                        AddressSpace *as, Error **errp)
+bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
+                                      VFIODevice *vbasedev, AddressSpace *as,
+                                      Error **errp)
 {
     const VFIOIOMMUClass *ops =
-        VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
-
-    if (vbasedev->iommufd) {
-        ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
-    }
+        VFIO_IOMMU_CLASS(object_class_by_name(iommu_type));
 
     assert(ops);
 
     return ops->attach_device(name, vbasedev, as, errp);
 }
 
+bool vfio_device_attach(char *name, VFIODevice *vbasedev,
+                        AddressSpace *as, Error **errp)
+{
+    const char *iommu_type = vbasedev->iommufd ?
+                             TYPE_VFIO_IOMMU_IOMMUFD :
+                             TYPE_VFIO_IOMMU_LEGACY;
+
+    return vfio_device_attach_by_iommu_type(iommu_type, name, vbasedev,
+                                            as, errp);
+}
+
 void vfio_device_detach(VFIODevice *vbasedev)
 {
     if (!vbasedev->bcontainer) {
-- 
2.49.0


